#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.SceneManagement;

[InitializeOnLoad]
public static class EID3336IndependentGBufferCapture
{
    const string ScenePath = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera_IndependentVS.unity";
    const string OutputRelative = "Assets/EID3332_EID3336_Combined/Validation/IndependentVS_GBuffer_20260906";
    static readonly string TriggerPath = Path.Combine(Directory.GetParent(Application.dataPath).FullName, "Validation/trigger_independent_gbuffer.txt");
    static bool running;

    static EID3336IndependentGBufferCapture()
    {
        EditorApplication.update += PollTrigger;
    }

    static void PollTrigger()
    {
        if (running || !File.Exists(TriggerPath)) return;
        try { File.Delete(TriggerPath); } catch { return; }
        EditorApplication.delayCall += Capture;
    }

    [MenuItem("Tools/EID3332+3336/Capture Independent URP RT0-RT4")]
    public static void Capture()
    {
        if (running) return;
        running = true;
        try
        {
            Scene scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);
            if (!scene.IsValid()) throw new InvalidOperationException("Unable to open scene: " + ScenePath);

            Camera camera = FindIndependentCamera();
            if (camera == null) throw new InvalidOperationException("EID3336 RenderDoc Camera was not found.");

            const string shaderName = "EID3336/URP/RenderDocGBufferIndependent";
            Shader shader = Shader.Find(shaderName);
            if (shader == null) throw new InvalidOperationException("Independent shader not found: " + shaderName);

            var renderers = UnityEngine.Object.FindObjectsOfType<Renderer>(true);
            var activeIndependent = new List<Renderer>();
            var changed = new List<RendererState>();
            for (int i = 0; i < renderers.Length; ++i)
            {
                Renderer r = renderers[i];
                if (r == null) continue;
                bool independent = HasShader(r, shaderName);
                changed.Add(new RendererState(r, r.enabled));
                r.enabled = independent;
                if (independent && r.enabled) activeIndependent.Add(r);
            }
            if (activeIndependent.Count == 0)
                throw new InvalidOperationException("No enabled Renderer uses the independent shader.");

            // Attach the validation provider to the camera GameObject itself.
            // URP's provider scan runs inside the render loop and only sees
            // scene-owned behaviours reliably; a transient hidden root can be
            // omitted even though it exists in managed code.
            GameObject bridgeRoot = camera.gameObject;
            var mrt = bridgeRoot.GetComponent<EID3332CombinedSceneMRTController>();
            if (mrt == null) mrt = bridgeRoot.AddComponent<EID3332CombinedSceneMRTController>();
            var targets = bridgeRoot.GetComponent<EID3332CombinedDeferredTargets>();
            if (targets == null) targets = bridgeRoot.AddComponent<EID3332CombinedDeferredTargets>();
            targets.width = 1024;
            targets.height = 576;
            var controller = bridgeRoot.GetComponent<EID3332CombinedDeferredController>();
            if (controller == null) controller = bridgeRoot.AddComponent<EID3332CombinedDeferredController>();
            controller.targetCamera = camera;
            controller.sharedMrtController = mrt;
            controller.targets = targets;
            controller.useURPFiveMRT = true;
            controller.captureURPGBufferForValidation = true;
            controller.enableB6Lighting = false;
            controller.renderInSceneView = false;
            controller.projectionSource = EID3332CombinedDeferredController.ProjectionSource.CurrentUnityCamera;

            CameraState cameraState = new CameraState(camera);
            RenderTexture final = new RenderTexture(1024, 576, 24, RenderTextureFormat.ARGB32)
            {
                name = "EID3336 Independent GBuffer Validation Final",
                hideFlags = HideFlags.HideAndDontSave
            };
            final.Create();
            camera.enabled = false;
            camera.targetTexture = final;
            camera.aspect = 1024f / 576f;
            camera.Render();

            string projectRoot = Directory.GetParent(Application.dataPath).FullName;
            string output = Path.Combine(projectRoot, OutputRelative.Replace('/', Path.DirectorySeparatorChar));
            Directory.CreateDirectory(output);
            SaveTexture(final, Path.Combine(output, "Final.png"));

            var report = new StringBuilder();
            report.AppendLine("EID3336 independent URP GBuffer capture");
            report.AppendLine("date=" + DateTime.Now.ToString("O", CultureInfo.InvariantCulture));
            report.AppendLine("scene=" + ScenePath);
            report.AppendLine("shader=" + shaderName);
            report.AppendLine("shaderSupported=" + shader.isSupported);
            report.AppendLine("shaderPassCount=" + shader.passCount);
            report.AppendLine("camera=" + camera.name);
            report.AppendLine("cameraPosition=" + camera.transform.position.ToString("R", CultureInfo.InvariantCulture));
            report.AppendLine("cameraProjection=" + camera.projectionMatrix);
            report.AppendLine("independentRendererCount=" + activeIndependent.Count);
            report.AppendLine("resolution=1024x576");
            report.AppendLine("note=RT0-RT4 are copied after the standard UniversalGBuffer DrawRenderers path; no legacy custom MRT redraw is used.");

            if (controller.lastURPGBufferCapture == null || controller.lastURPGBufferCapture.Length < 5)
            {
                report.AppendLine("captureStatus=FAIL");
                report.AppendLine("reason=URP GBuffer attachments were not copied by the validation provider.");
                File.WriteAllText(Path.Combine(output, "capture_info.txt"), report.ToString());
                throw new InvalidOperationException("No URP RT0-RT4 capture was produced. See " + Path.Combine(output, "capture_info.txt"));
            }

            report.AppendLine("captureStatus=PASS");
            for (int i = 0; i < 5; ++i)
            {
                RenderTexture rt = controller.lastURPGBufferCapture[i];
                if (rt == null)
                {
                    report.AppendLine($"RT{i}=null");
                    continue;
                }
                string png = Path.Combine(output, "RT" + i + ".png");
                TextureStats stats = SaveTexture(rt, png);
                report.AppendLine($"RT{i}=name:{rt.name};format:{rt.graphicsFormat};size:{rt.width}x{rt.height};nonZero:{stats.nonZero};mean:{stats.mean.ToString("R", CultureInfo.InvariantCulture)};max:{stats.max.ToString("R", CultureInfo.InvariantCulture)}");
            }
            File.WriteAllText(Path.Combine(output, "capture_info.txt"), report.ToString());
            Debug.Log("[EID3336 Independent GBuffer] PASS: " + output);

            camera.targetTexture = cameraState.targetTexture;
            cameraState.Restore(camera);
            controller.ReleaseURPGBufferValidationCapture();
            if (controller != null) UnityEngine.Object.DestroyImmediate(controller);
            if (targets != null) UnityEngine.Object.DestroyImmediate(targets);
            if (mrt != null) UnityEngine.Object.DestroyImmediate(mrt);
            if (final != null) { final.Release(); UnityEngine.Object.DestroyImmediate(final); }
            RestoreRenderers(changed);
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
        }
        catch (Exception ex)
        {
            Debug.LogException(ex);
            try { EditorSceneManager.MarkSceneDirty(SceneManager.GetActiveScene()); } catch { }
        }
        finally
        {
            running = false;
        }
    }

    static Camera FindIndependentCamera()
    {
        Camera[] cameras = UnityEngine.Object.FindObjectsOfType<Camera>(true);
        for (int i = 0; i < cameras.Length; ++i)
            if (cameras[i] != null && cameras[i].name == "EID3336 RenderDoc Camera") return cameras[i];
        return cameras.Length > 0 ? cameras[0] : null;
    }

    static bool HasShader(Renderer renderer, string shaderName)
    {
        Material[] materials = renderer.sharedMaterials;
        for (int i = 0; i < materials.Length; ++i)
            if (materials[i] != null && materials[i].shader != null && materials[i].shader.name == shaderName)
                return true;
        return false;
    }

    static void RestoreRenderers(List<RendererState> states)
    {
        for (int i = 0; i < states.Count; ++i)
            if (states[i].renderer != null) states[i].renderer.enabled = states[i].enabled;
    }

    static TextureStats SaveTexture(RenderTexture source, string path)
    {
        RenderTexture old = RenderTexture.active;
        RenderTexture converted = null;
        Texture2D tex = null;
        try
        {
            // Normalize packed URP attachments through a standard RGBA32 blit
            // before CPU readback. Direct ReadPixels from B10G11/A2B10G10R10
            // is not a valid diagnostic path on this Unity version.
            converted = RenderTexture.GetTemporary(source.width, source.height, 0, RenderTextureFormat.ARGB32, RenderTextureReadWrite.Linear);
            Graphics.Blit(source, converted);
            RenderTexture.active = converted;
            tex = new Texture2D(source.width, source.height, TextureFormat.RGBA32, false, true);
            tex.ReadPixels(new Rect(0, 0, source.width, source.height), 0, 0, false);
            tex.Apply(false, false);
            Color[] pixels = tex.GetPixels();
            double sum = 0.0;
            float max = 0f;
            int nonZero = 0;
            for (int i = 0; i < pixels.Length; ++i)
            {
                Color c = pixels[i];
                float v = Mathf.Max(Mathf.Abs(c.r), Mathf.Max(Mathf.Abs(c.g), Mathf.Max(Mathf.Abs(c.b), Mathf.Abs(c.a))));
                sum += (double)(Mathf.Abs(c.r) + Mathf.Abs(c.g) + Mathf.Abs(c.b) + Mathf.Abs(c.a)) * 0.25;
                if (v > 1e-5f) nonZero++;
                if (v > max) max = v;
            }
            TextureStats stats = new TextureStats(nonZero, pixels.Length > 0 ? (float)(sum / pixels.Length) : 0f, max);
            File.WriteAllBytes(path, tex.EncodeToPNG());
            return stats;
        }
        finally
        {
            if (tex != null) UnityEngine.Object.DestroyImmediate(tex);
            if (converted != null) RenderTexture.ReleaseTemporary(converted);
            RenderTexture.active = old;
        }
    }

    readonly struct RendererState
    {
        public readonly Renderer renderer;
        public readonly bool enabled;
        public RendererState(Renderer renderer, bool enabled) { this.renderer = renderer; this.enabled = enabled; }
    }

    readonly struct CameraState
    {
        public readonly RenderTexture targetTexture;
        public readonly Matrix4x4 worldToCamera;
        public readonly Matrix4x4 projection;
        public CameraState(Camera camera) { targetTexture = camera.targetTexture; worldToCamera = camera.worldToCameraMatrix; projection = camera.projectionMatrix; }
        public void Restore(Camera camera) { camera.worldToCameraMatrix = worldToCamera; camera.projectionMatrix = projection; }
    }

    readonly struct TextureStats
    {
        public readonly int nonZero;
        public readonly float mean;
        public readonly float max;
        public TextureStats(int nonZero, float mean, float max) { this.nonZero = nonZero; this.mean = mean; this.max = max; }
    }
}
#endif


