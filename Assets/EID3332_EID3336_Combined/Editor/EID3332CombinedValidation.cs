#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;

public static class EID3332CombinedValidation
{
    const string Root = "Assets/EID3332_EID3336_Combined";
    static readonly List<string> Report = new List<string>();
    static int failures;

    [MenuItem("Tools/EID3332+3336/Validate Independent Workspace")]
    public static void Validate()
    {
        Report.Clear(); failures = 0;
        string output = ProjectPath(Root + "/Validation");
        Directory.CreateDirectory(output);
        foreach (string png in Directory.GetFiles(output, "*.png")) File.Delete(png);

        ValidateProfiles();
        ValidateScene(EID3332CombinedSetup.IsolatedScene, "EID3332_Isolated", 1);
        ValidateScene(EID3332CombinedSetup.CombinedScene, "EID3332_EID3336_Combined", 4);
        ValidateLegacyHashes();

        Report.Insert(0, "EID3332 + EID3336 Combined Validation\nGenerated: " + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "\nFailures: " + failures);
        File.WriteAllLines(Path.Combine(output, "VALIDATION_REPORT.txt"), Report);
        AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
        if (failures != 0) throw new InvalidOperationException("EID3332 combined validation failed: " + failures + ". See Validation/VALIDATION_REPORT.txt");
        Debug.Log("[EID3332Combined Validation] PASS. " + Path.Combine(output, "VALIDATION_REPORT.txt"));
    }

    static void ValidateProfiles()
    {
        EID3332CombinedDrawProfile a = AssetDatabase.LoadAssetAtPath<EID3332CombinedDrawProfile>(EID3332CombinedSetup.Profile3332Path);
        EID3332CombinedDrawProfile b = AssetDatabase.LoadAssetAtPath<EID3332CombinedDrawProfile>(EID3332CombinedSetup.Profile3336Path);
        Check(a != null, "EID3332 profile exists");
        Check(b != null, "EID3336 profile exists");
        if (a != null)
        {
            Check(a.eventId == 3332 && a.indexCount == 4791 && a.instanceCount == 1 && a.indexOffset == 0 && a.baseVertex == 0, "EID3332 draw parameters = 4791 indices, 1 instance, offsets zero");
            Check(a.vertexCount == 829 && a.triangleCount == 1597 && !a.verticesAlreadyWorldSpace && !a.applyExportMirrorX && a.shaderInstanceOffset == 0, "EID3332 geometry/profile contract = 829 vertices, 1597 triangles, RendererLocal uses the single scene Transform correction");
        }
        if (b != null)
            Check(b.eventId == 3336 && b.indexCount == 7980 && b.instanceCount == 3 && b.indexOffset == 0 && b.baseVertex == 0 && b.shaderInstanceOffset == 0 && !b.verticesAlreadyWorldSpace, "EID3336 draw parameters = 7980 indices, 3 instances, offsets zero; RendererLocal applies Unity FBX axis conversion");
        EID3332CombinedDrawProfile c = AssetDatabase.LoadAssetAtPath<EID3332CombinedDrawProfile>(Root + "/Profiles/EID3490_DrawProfile.asset");
        Check(c != null, "EID3490 profile exists");
        if (c != null)
        {
            Check(c.eventId == 3490 && c.indexCount == 1422 && c.instanceCount == 3 && c.indexOffset == 0 && c.baseVertex == 0, "EID3490 draw parameters = 1422 indices, 3 instances, offsets zero");
            Check(c.vertexCount == 324 && c.triangleCount == 474 && c.useRawStreams && !c.verticesAlreadyWorldSpace && !c.applyExportMirrorX, "EID3490 geometry/profile contract = raw captured stream, 474 triangles, RendererLocal instance matrix");
        }
    }

    static void ValidateScene(string scenePath, string prefix, int expectedBindings)
    {
        var scene = EditorSceneManager.OpenScene(scenePath, OpenSceneMode.Single);
        EID3332CombinedDeferredController controller = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>();
        EID3332CombinedSceneMRTController mrt = UnityEngine.Object.FindObjectOfType<EID3332CombinedSceneMRTController>();
        EID3332CombinedSceneMaterialResources resources = UnityEngine.Object.FindObjectOfType<EID3332CombinedSceneMaterialResources>();
        EID3332CombinedDeferredTargets targets = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredTargets>();
        Check(controller != null && mrt != null && resources != null && targets != null, prefix + " controller/MRT/resources/targets exist");
        if (controller == null || mrt == null || resources == null || targets == null) return;
        Check(mrt.bindings != null && mrt.bindings.Length == expectedBindings, prefix + " Draw Profile binding count = " + expectedBindings);
        Check(mrt.sharedMrtMaterial != null && mrt.sharedMrtMaterial.shader != null && mrt.sharedMrtMaterial.shader.isSupported, prefix + " shared VS209986/PS209987 MRT shader supported");
        Check(controller.gbufferMaterial != null && controller.gbufferMaterial.shader != null && controller.gbufferMaterial.shader.isSupported, prefix + " diagnostic GBuffer shader supported");
        Check(controller.b6LightingMaterial != null && controller.b6LightingMaterial.shader != null && controller.b6LightingMaterial.shader.isSupported, prefix + " B6 shader supported");
        Check(controller.cameraCompositeMaterial != null && controller.cameraCompositeMaterial.shader != null && controller.cameraCompositeMaterial.shader.isSupported, prefix + " composite shader supported");
        Check(controller.b6ScreenSHWeight == 0f && controller.b6ScreenSpecularContributionWeight == 0f && controller.b6ProbeReflectionWeight == 0f && controller.b6CapturedVisibilityWeight == 0f, prefix + " captured indirect weights start clean at zero");
        bool profileTransformModes = mrt.bindings == null || mrt.bindings.All(x => x == null || x.profile == null || x.resources == null ||
            (x.profile.eventId == 3490 ? x.resources.useCapturedInstanceTransforms : !x.resources.useCapturedInstanceTransforms));
        Check(profileTransformModes, prefix + " per-profile captured transform mode is preserved");
        Check(controller.useRawStreamsForCurrentCamera && controller.useCapturedInstanceTransformsForRawCurrent, prefix + " CurrentUnityCamera uses exact raw streams with parity-correct captured instance basis");
        if (mrt.bindings != null)
        {
            foreach (var liveBinding in mrt.bindings)
            {
                if (liveBinding == null || liveBinding.profile == null || liveBinding.resources == null) continue;
                mrt.Refresh();
                Renderer[] liveRenderers = liveBinding.renderers;
                Transform[] liveSources = liveBinding.GetLiveTransformSources();
                int expectedInstances = Mathf.Max(1, liveBinding.profile.instanceCount);
                Check(liveSources != null && liveSources.Length >= expectedInstances, prefix + " EID" + liveBinding.profile.eventId + " has explicit/fallback live Transform source per instance");
                if (liveSources == null || liveSources.Length < expectedInstances) continue;

                var liveResources = liveBinding.resources;
                bool originalCapturedMode = liveResources.useCapturedInstanceTransforms;
                liveResources.useCapturedInstanceTransforms = true;
                liveResources.ResetLiveTransformReferences();
                liveResources.ApplySceneTransforms(liveRenderers, liveSources, liveBinding.instanceTransformReferences);

                Matrix4x4[] initial = new Matrix4x4[expectedInstances];
                bool initialOk = true;
                for (int i = 0; i < expectedInstances; ++i)
                {
                    initialOk &= liveResources.TryGetLiveInstanceMatrix(i, out initial[i]);
                    if (liveBinding.profile.eventId == 3336 && liveResources.TryGetCapturedInstanceMatrix(i, out Matrix4x4 captured))
                        Check(Vector3.Distance(initial[i].GetColumn(3), captured.GetColumn(3)) < 0.001f, prefix + " EID3336 instance " + i + " initial position equals captured matrix " + captured.GetColumn(3));
                }

                for (int i = 0; i < expectedInstances; ++i)
                {
                    Transform source = liveSources[i];
                    if (source == null) { Check(false, prefix + " EID" + liveBinding.profile.eventId + " instance " + i + " Transform source exists"); continue; }
                    Vector3 oldPosition = source.position;
                    Vector3 testDelta = new Vector3(1.25f + i * .1f, -0.5f, 0.75f);
                    source.position = oldPosition + testDelta;
                    liveResources.ApplySceneTransforms(liveRenderers, liveSources, liveBinding.instanceTransformReferences);
                    bool afterOk = liveResources.TryGetLiveInstanceMatrix(i, out Matrix4x4 afterMove);
                    Vector3 actualDelta = afterMove.GetColumn(3) - initial[i].GetColumn(3);
                    bool isolated = true;
                    for (int j = 0; j < expectedInstances; ++j)
                    {
                        if (j == i) continue;
                        if (!liveResources.TryGetLiveInstanceMatrix(j, out Matrix4x4 other) || Vector3.Distance(other.GetColumn(3), initial[j].GetColumn(3)) > 0.001f)
                            isolated = false;
                    }
                    source.position = oldPosition;
                    liveResources.ApplySceneTransforms(liveRenderers, liveSources, liveBinding.instanceTransformReferences);
                    Check(initialOk && afterOk && Vector3.Distance(actualDelta, testDelta) < 0.001f, prefix + " EID" + liveBinding.profile.eventId + " instance " + i + " realtime translation PASS (actual " + actualDelta + ")");
                    Check(isolated, prefix + " EID" + liveBinding.profile.eventId + " instance " + i + " movement does not change other instances");
                }
                liveResources.useCapturedInstanceTransforms = originalCapturedMode;
                liveResources.ResetLiveTransformReferences();
            }
        }
        if (mrt.bindings != null)
        {
            bool stableBindings = mrt.bindings.All(x => x != null && x.material != null && x.resources != null && x.resources.material == x.material);
            bool sameShader = mrt.bindings.All(x => x.material.shader == mrt.bindings[0].material.shader);
            bool isolatedState = mrt.bindings.Select(x => x.material).Distinct().Count() == mrt.bindings.Length && mrt.bindings.Select(x => x.resources).Distinct().Count() == mrt.bindings.Length;
            Check(stableBindings && sameShader && isolatedState, prefix + " shared shader with per-profile Material/Buffer isolation");
        }

        EID3332CombinedSceneMRTController.ProfileBinding binding3332 = mrt.bindings == null ? null : mrt.bindings.FirstOrDefault(x => x != null && x.profile != null && x.profile.eventId == 3332);
        Check(binding3332 != null && binding3332.modelRoot != null, prefix + " EID3332 binding is addressable by eventId=3332");
        if (binding3332 != null && binding3332.modelRoot != null)
        {
            Renderer[] r3332 = binding3332.modelRoot.GetComponentsInChildren<Renderer>(true);
            int vertices = 0, triangles = 0;
            foreach (Renderer r in r3332)
            {
                Mesh mesh = MeshOf(r); if (mesh == null) continue;
                vertices += mesh.vertexCount;
                for (int sm = 0; sm < mesh.subMeshCount; ++sm) triangles += (int)mesh.GetIndexCount(sm) / 3;
            }
            Check(vertices == 829, prefix + " EID3332 imported vertex count = 829 (actual " + vertices + ")");
            Check(triangles == 1597, prefix + " EID3332 imported triangle count = 1597 (actual " + triangles + ")");
            Bounds corrected = BoundsOf(r3332);
            Check(Mathf.Abs(corrected.center.x - (-550.2967f)) < .25f, prefix + " EID3332 corrected world X matches RenderDoc bbox center (actual " + corrected.center.x.ToString("F4") + ")");
        }
        EID3332CombinedSceneMRTController.ProfileBinding binding3336 = mrt.bindings == null ? null : mrt.bindings.FirstOrDefault(x => x != null && x.profile != null && x.profile.eventId == 3336);
        if (binding3336 != null)
        {
            // The imported EID3336 FBX is retained for hierarchy/visibility only.
            // Its Unity bounds include the FBX axis-conversion basis and are not
            // the authoritative world-space draw data. The current and captured
            // replay paths use the event-local raw streams plus _28_30 matrices.
            Renderer[] proxy3336 = binding3336.modelRoot.GetComponentsInChildren<Renderer>(true)
                .Where(x => x != null).OrderBy(x => x.name, StringComparer.Ordinal).ToArray();
            Bounds b3336 = BoundsOf(proxy3336);
            Report.Add(prefix + " EID3336 selectable FBX proxy bounds=" + b3336);
            Vector3[] capturedCenters =
            {
                new Vector3(-539.6164f, 91.6901f, -447.8216f),
                new Vector3(-512.9574f, 95.2282f, -447.6238f),
                new Vector3(-526.5800f, 90.6038f, -465.2327f)
            };
            Check(proxy3336.Length >= 3, prefix + " EID3336 has three selectable renderer proxies");
            for (int i = 0; i < Mathf.Min(3, proxy3336.Length); ++i)
            {
                Check(Vector3.Distance(proxy3336[i].bounds.center, capturedCenters[i]) < .05f,
                    prefix + " EID3336 selectable proxy " + i + " center matches rendered/captured world position (actual " + proxy3336[i].bounds.center + ")");
                if (binding3336.resources.TryGetCapturedInstanceMatrix(i, out Matrix4x4 proxyCaptured))
                    Check(Vector3.Distance(proxy3336[i].transform.position, proxyCaptured.GetColumn(3)) < .001f,
                        prefix + " EID3336 selectable model node " + i + " Transform pivot equals captured instance position (actual " + proxy3336[i].transform.position + ")");
            }
            string rawRoot = ProjectPath(Root + "/Resources/EID3336Raw");
            Check(File.Exists(Path.Combine(rawRoot, "vertex_stream0.bytes")) && File.Exists(Path.Combine(rawRoot, "vertex_stream1.bytes")) && File.Exists(Path.Combine(rawRoot, "indices_u16.bytes")), prefix + " EID3336 raw VB/IB resources present");
        }
        const int width = 640, height = 360;
        targets.debugFloatFormats = true; targets.Ensure(width, height);
        resources.Reload(); mrt.Refresh(); controller.RefreshRenderers(); controller.projectionSource = EID3332CombinedDeferredController.ProjectionSource.CurrentUnityCamera;
        Camera camera = controller.targetCamera;
        CommandBuffer geometry = new CommandBuffer { name = "EID3332Combined Validation Geometry" };
        bool recorded = controller.RecordGeometry(geometry, camera, width, height);
        if (recorded) Graphics.ExecuteCommandBuffer(geometry);
        geometry.Release();
        Check(recorded, prefix + " geometry command recorded");
        // Drive one real URP camera render before readback. This is the same path
        // used by Scene/Game View and guarantees camera matrices are initialized.
        RenderCamera(camera, width, height);

        for (int i = 0; i < 5; ++i) Save(targets.GetColor(i), prefix + "_MRT" + i + ".png");
        PixelStats coverage = Save(targets.Coverage, prefix + "_Coverage.png");
        Save(targets.DepthDebug, prefix + "_Depth.png");
        Save(targets.ActualWorldPosition, prefix + "_ActualWorldPosition.png");
        Save(targets.ActualNormal, prefix + "_ActualNormal.png");
        // R8 coverage readback is expanded as cyan background / white geometry on this Unity DX11 editor.
        Check(coverage.whitePixels > 0, prefix + " Coverage contains geometry pixels (" + coverage.whitePixels + ")");

        if (expectedBindings >= 2 && binding3332 != null && binding3336 != null)
        {
            bool[] states = mrt.bindings.Select(x => x != null && x.modelRoot != null && x.modelRoot.gameObject.activeSelf).ToArray();
            try
            {
                foreach (var binding in mrt.bindings)
                    if (binding != null && binding.modelRoot != null) binding.modelRoot.gameObject.SetActive(false);
                binding3332.modelRoot.gameObject.SetActive(true); mrt.Refresh();
                RenderCamera(camera, width, height);
                string only3332Path = Path.Combine(ProjectPath(Root + "/Validation"), prefix + "_EID3332Only_MRT4.png");
                PixelStats only3332 = Save(targets.GetColor(4), prefix + "_EID3332Only_MRT4.png");

                foreach (var binding in mrt.bindings)
                    if (binding != null && binding.modelRoot != null) binding.modelRoot.gameObject.SetActive(false);
                binding3336.modelRoot.gameObject.SetActive(true); mrt.Refresh();
                RenderCamera(camera, width, height);
                string only3336Path = Path.Combine(ProjectPath(Root + "/Validation"), prefix + "_EID3336Only_MRT4.png");
                PixelStats only3336 = Save(targets.GetColor(4), prefix + "_EID3336Only_MRT4.png");

                Check(only3332.nonBlack > 0, prefix + " EID3332 profile independently writes shared MRT");
                Check(only3336.nonBlack > 0, prefix + " EID3336 profile independently writes shared MRT");
                Check(FileHash(only3332Path) != FileHash(only3336Path), prefix + " EID3332Only and EID3336Only MRT4 outputs are distinct");
            }
            finally
            {
                for (int i = 0; i < mrt.bindings.Length; ++i)
                    if (mrt.bindings[i] != null && mrt.bindings[i].modelRoot != null)
                        mrt.bindings[i].modelRoot.gameObject.SetActive(i < states.Length && states[i]);
                mrt.Refresh();
                RenderCamera(camera, width, height);
            }
        }
        RenderTexture final = new RenderTexture(width, height, 0, RenderTextureFormat.ARGBHalf) { name = prefix + " Final" };
        final.Create(); controller.BindDeferredLighting(camera, width, height);
        CommandBuffer lighting = new CommandBuffer { name = "EID3332Combined Validation B6" };
        lighting.SetRenderTarget(final); lighting.ClearRenderTarget(false, true, Color.clear);
        lighting.DrawProcedural(Matrix4x4.identity, controller.GetActiveDeferredLightingMaterial(), 0, MeshTopology.Triangles, 3, 1);
        Graphics.ExecuteCommandBuffer(lighting); lighting.Release();
        PixelStats finalStats = Save(final, prefix + "_Final.png");
        Check(finalStats.nonBlack > 0, prefix + " B6 final contains visible pixels (" + finalStats.nonBlack + ")");
        final.Release(); UnityEngine.Object.DestroyImmediate(final);

        RenderTexture game = new RenderTexture(width, height, 24, RenderTextureFormat.ARGB32) { name = prefix + " GameCamera" };
        game.Create(); RenderTexture oldTarget = camera.targetTexture; camera.targetTexture = game;
        camera.Render(); PixelStats gameStats = Save(game, prefix + "_GameCamera.png"); camera.targetTexture = oldTarget;
        Check(gameStats.nonBlack > 0, prefix + " actual URP Game Camera receives the deferred composite");
        game.Release(); UnityEngine.Object.DestroyImmediate(game);

        controller.LoadCapturedMatrices();
        Check(controller.capturedMatricesLoaded, prefix + " RenderDoc captured View/Projection loaded");
        controller.projectionSource = EID3332CombinedDeferredController.ProjectionSource.RenderDocCaptured;
        const int capturedWidth = 1366, capturedHeight = 768;
        controller.targets.Ensure(capturedWidth, capturedHeight);
        RenderTexture capturedOutput = new RenderTexture(capturedWidth, capturedHeight, 24, RenderTextureFormat.ARGB32) { name = prefix + " CapturedCamera" };
        capturedOutput.Create(); oldTarget = camera.targetTexture; camera.targetTexture = capturedOutput;
        camera.Render(); PixelStats capturedMrt = Save(targets.GetColor(4), prefix + "_RenderDocCaptured_MRT4.png");
        PixelStats capturedFinal = Save(capturedOutput, prefix + "_RenderDocCaptured_Final.png"); camera.targetTexture = oldTarget;
        Check(capturedMrt.nonBlack > 0 && capturedFinal.nonBlack > 0, prefix + " RenderDocCaptured mode writes MRT and final lighting");
        capturedOutput.Release(); UnityEngine.Object.DestroyImmediate(capturedOutput);
        controller.projectionSource = EID3332CombinedDeferredController.ProjectionSource.CurrentUnityCamera;
        if (mrt.bindings != null)
            foreach (var binding in mrt.bindings)
                if (binding != null && binding.resources != null)
                {
                    binding.resources.useCapturedInstanceTransforms = binding.profile != null && binding.profile.eventId == 3490;
                    binding.resources.BindForDraw();
                }
        resources.useCapturedInstanceTransforms = false;

        Report.Add(prefix + " rendererCount=" + controller.renderers.Length + " bounds=" + controller.GetModelBounds());
        for (int rendererDebugIndex = 0; rendererDebugIndex < controller.renderers.Length; ++rendererDebugIndex) if (controller.renderers[rendererDebugIndex] != null) Report.Add(prefix + " renderer[" + rendererDebugIndex + "]=" + controller.renderers[rendererDebugIndex].name + " bounds=" + controller.renderers[rendererDebugIndex].bounds + " transform=" + controller.renderers[rendererDebugIndex].transform.position);
        EditorSceneManager.SaveScene(scene, scenePath);
    }

    static void RenderCamera(Camera camera, int width, int height)
    {
        RenderTexture old = camera.targetTexture;
        RenderTexture temp = new RenderTexture(width, height, 24, RenderTextureFormat.ARGB32);
        temp.Create(); camera.targetTexture = temp; camera.Render(); camera.targetTexture = old;
        temp.Release(); UnityEngine.Object.DestroyImmediate(temp);
    }

    struct PixelStats { public int nonBlack; public int whitePixels; public float max; }

    static PixelStats StatsFromFile(string path)
    {
        byte[] bytes = File.ReadAllBytes(path); Texture2D image = new Texture2D(2, 2, TextureFormat.RGBA32, false);
        image.LoadImage(bytes, false); PixelStats result = Stats(image.GetPixels32()); UnityEngine.Object.DestroyImmediate(image); return result;
    }

    static PixelStats Stats(Color32[] pixels)
    {
        int nonBlack = 0, white = 0; byte max = 0;
        foreach (Color32 c in pixels)
        {
            byte m = Math.Max(Math.Max(c.r, c.g), c.b);
            if (m > 2 && !(c.r == 0 && c.g == 255 && c.b == 255)) nonBlack++;
            if (c.r > 250 && c.g > 250 && c.b > 250) white++;
            if (m > max) max = m;
        }
        return new PixelStats { nonBlack = nonBlack, whitePixels = white, max = max / 255f };
    }

    static PixelStats Save(RenderTexture source, string fileName)
    {
        if (source == null || !source.IsCreated()) { Check(false, fileName + " source exists"); return default; }
        RenderTexture previous = RenderTexture.active; RenderTexture.active = source;
        Texture2D image = new Texture2D(source.width, source.height, TextureFormat.RGBA32, false, false);
        image.ReadPixels(new Rect(0, 0, source.width, source.height), 0, 0, false); image.Apply(false, false);
        Color32[] pixels = image.GetPixels32(); PixelStats stats = Stats(pixels);
        File.WriteAllBytes(Path.Combine(ProjectPath(Root + "/Validation"), fileName), image.EncodeToPNG());
        UnityEngine.Object.DestroyImmediate(image); RenderTexture.active = previous;
        Report.Add(fileName + " nonBlack=" + stats.nonBlack + " white=" + stats.whitePixels + " max=" + stats.max.ToString("F3"));
        return stats;
    }

    static Bounds BoundsOf(Renderer[] renderers)
    {
        bool has = false; Bounds result = new Bounds();
        foreach (Renderer r in renderers) { if (r == null) continue; if (!has) { result = r.bounds; has = true; } else result.Encapsulate(r.bounds); }
        return result;
    }

    static Mesh MeshOf(Renderer r)
    {
        if (r is SkinnedMeshRenderer sk) return sk.sharedMesh;
        MeshFilter f = r.GetComponent<MeshFilter>(); return f != null ? f.sharedMesh : null;
    }


    static string FileHash(string path)
    {
        using (var sha = System.Security.Cryptography.SHA256.Create())
        using (FileStream stream = File.OpenRead(path))
            return BitConverter.ToString(sha.ComputeHash(stream)).Replace("-", string.Empty);
    }

    static void ValidateLegacyHashes()
    {
        string[] paths = {
            "Assets/EID3336_URP_Reconstruction/DeferredLightingScenePipeline/EID3336_SceneDeferred_B.unity",
            "Assets/EID3336_URP_Reconstruction/DeferredLightingScenePipeline/Runtime/EID3336SceneDeferredBController.cs",
            "Assets/EID3336_URP_Reconstruction/DeferredLightingScenePipeline/Geometry/EID3336SceneDeferredBB6.hlsl",
            "Assets/EID3336_URP_Reconstruction/SceneMaterialMRT/EID3336SceneMaterialMRTController.cs"
        };
        string[] hashes = {
            "C7B2D22A434FE65635A223E544422522D1007AAE82EAF78C417F3A54E14F425D",
            "366784547ED76A96E0902013C9ED8E3106870D68E0C9B923141FF85636CD1614",
            "B184A05FF0E0302607C49E3E6BBFC447B914BEE725A65B566FE341B62FFA5572",
            "7FBDB2FF6A5A642454433F4039B858A87C35FA97E92FF437340353E5A6FF1AA0"
        };
        using (var sha = System.Security.Cryptography.SHA256.Create())
            for (int i = 0; i < paths.Length; ++i)
            {
                string actual; using (FileStream stream = File.OpenRead(ProjectPath(paths[i]))) actual = BitConverter.ToString(sha.ComputeHash(stream)).Replace("-", "");
                Check(actual == hashes[i], "Legacy isolation hash unchanged: " + paths[i]);
            }
    }

    static string ProjectPath(string assetPath) => Path.Combine(Directory.GetParent(Application.dataPath).FullName, assetPath.Replace('/', Path.DirectorySeparatorChar));
    static void Check(bool condition, string text) { Report.Add((condition ? "PASS " : "FAIL ") + text); if (!condition) failures++; }
}
#endif







