#if UNITY_EDITOR
using System;
using System.IO;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.Rendering;

public static class EID3336RouteBDeferredValidationCapture
{
    const string ScenePath = "Assets/EID3332_EID3336_Combined/Scenes/EID3332_EID3336_Combined.unity";
    const string OutputRelative = "Assets/EID3332_EID3336_Combined/Validation/URP_Deferred_Centered";

    [MenuItem("Tools/EID3332+3336/Capture Route B Deferred Lighting")]
    public static void Capture()
    {
        CaptureWithMode(EID3332CombinedDeferredController.B6ViewMode.FinalLighting, "FinalLighting");
    }

    public static void CaptureBaseColor()
    {
        CaptureWithMode(EID3332CombinedDeferredController.B6ViewMode.BaseColor, "BaseColor");
    }

    public static void CaptureNormal()
    {
        CaptureWithMode(EID3332CombinedDeferredController.B6ViewMode.NormalWS, "NormalWS");
    }

    public static void CaptureDirectLighting()
    {
        CaptureWithMode(EID3332CombinedDeferredController.B6ViewMode.DirectLighting, "DirectLighting");
    }

    public static void CaptureMaterial()
    {
        CaptureWithMode(EID3332CombinedDeferredController.B6ViewMode.Material, "Material");
    }

    public static void CaptureWorldPosition()
    {
        CaptureWithMode(EID3332CombinedDeferredController.B6ViewMode.WorldPosition, "WorldPosition");
    }

    public static void CaptureLinearDepth()
    {
        CaptureWithMode(EID3332CombinedDeferredController.B6ViewMode.LinearDepth, "LinearDepth");
    }

    public static void CaptureDiagnostics()
    {
        CaptureWithMode(EID3332CombinedDeferredController.B6ViewMode.DirectLighting, "DirectLighting");
        CaptureWithMode(EID3332CombinedDeferredController.B6ViewMode.Material, "Material");
        CaptureWithMode(EID3332CombinedDeferredController.B6ViewMode.WorldPosition, "WorldPosition");
        CaptureWithMode(EID3332CombinedDeferredController.B6ViewMode.LinearDepth, "LinearDepth");
        CaptureWithMode(EID3332CombinedDeferredController.B6ViewMode.FinalLighting, "FinalLighting");
    }

    public static void CaptureWithMode(EID3332CombinedDeferredController.B6ViewMode mode, string label)
    {
        Scene scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);
        if (!scene.IsValid()) throw new InvalidOperationException("Unable to open combined scene.");
        var controller = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>(true);
        if (controller == null || controller.targetCamera == null || controller.eid3336Root == null)
            throw new InvalidOperationException("Route B scene/controller/camera is incomplete.");
        if (controller.eid3332Root != null) controller.eid3332Root.gameObject.SetActive(false);
        if (controller.eid3315Root != null) controller.eid3315Root.gameObject.SetActive(false);
        controller.eid3336Root.gameObject.SetActive(true);
        controller.projectionSource = EID3332CombinedDeferredController.ProjectionSource.CurrentUnityCamera;
        controller.useRouteBMeshRendererForCurrentCamera = true;
        controller.enableB6Lighting = true;
        controller.normalDeferredDisplay = true;
        controller.b6ViewMode = mode;
        if (controller.b6MaterialOwnsTuningParameters && controller.b6LightingMaterial != null)
        {
            controller.b6LightingMaterial.SetFloat("_EID3336B6ViewMode", (float)mode);
            EditorUtility.SetDirty(controller.b6LightingMaterial);
        }
        controller.captureURPGBufferForValidation = true;

        var adapter = controller.GetComponent<EID3336RouteBMeshRendererAdapter>();
        if (adapter != null)
        {
            adapter.enabledForCurrentCamera = true;
            adapter.SetCamera(controller.targetCamera);
            adapter.RefreshEntries();
            adapter.ApplyAll();
        }

        Bounds bounds = CalculateBounds(controller.eid3336Root);
        if (bounds.size.sqrMagnitude < 1e-8f) bounds = new Bounds(Vector3.zero, Vector3.one);
        Camera camera = controller.targetCamera;
        int routeLayerMask = 0;
        foreach (Renderer r in controller.eid3336Root.GetComponentsInChildren<Renderer>(true))
            if (r != null) routeLayerMask |= 1 << r.gameObject.layer;
        camera.cullingMask |= routeLayerMask;
        camera.enabled = false;
        camera.orthographic = false;
        camera.fieldOfView = 40f;
        camera.aspect = 16f / 9f;
        camera.nearClipPlane = Mathf.Max(0.01f, bounds.size.magnitude * 0.001f);
        camera.farClipPlane = Mathf.Max(camera.nearClipPlane + 10f, bounds.size.magnitude * 20f);
        Vector3 dir = camera.transform.forward.sqrMagnitude > 1e-6f ? camera.transform.forward.normalized : Vector3.forward;
        float radius = Mathf.Max(bounds.extents.magnitude, 0.01f);
        float distance = radius / Mathf.Tan(camera.fieldOfView * Mathf.Deg2Rad * 0.5f) * 1.25f;
        camera.transform.position = bounds.center - dir * distance;
        camera.transform.rotation = Quaternion.LookRotation(bounds.center - camera.transform.position, Vector3.up);
        if (adapter != null) { adapter.SetCamera(camera); adapter.ApplyAll(); }

        const int width = 1024;
        const int height = 576;
        var final = new RenderTexture(width, height, 24, RenderTextureFormat.ARGB32)
        {
            name = "EID3336 Route B Deferred centered final",
            hideFlags = HideFlags.DontSave
        };
        final.Create();
        RenderTexture oldTarget = camera.targetTexture;
        camera.targetTexture = final;
        camera.Render();

        string root = Directory.GetParent(Application.dataPath).FullName;
        string output = Path.Combine(root, OutputRelative.Replace('/', Path.DirectorySeparatorChar));
        Directory.CreateDirectory(output);
        SaveTexture(final, Path.Combine(output, "Final_Deferred_Centered_" + label + ".png"));
        if (controller.lastURPGBufferCapture != null)
        {
            for (int i = 0; i < controller.lastURPGBufferCapture.Length; ++i)
            {
                var rt = controller.lastURPGBufferCapture[i];
                if (rt != null)
                {
                    SaveTexture(rt, Path.Combine(output, "GBuffer" + i + "_Raw.png"));
                    SaveRawGpuTexture(rt, Path.Combine(output, "GBuffer" + i + "_Raw.bytes"),
                        Path.Combine(output, "GBuffer" + i + "_Raw.json"));
                }
            }
        }
        File.WriteAllText(Path.Combine(output, "capture_info.txt"),
            "scene=" + ScenePath + "\n" +
            "projection=CurrentUnityCamera\n" +
            "b6=source-level URP DeferredPass hook\n" +
            "viewMode=" + controller.b6ViewMode + "\n" +
            "object_center=" + bounds.center + "\n" +
            "object_size=" + bounds.size + "\n" +
            "camera_position=" + camera.transform.position + "\n" +
            "resolution=" + width + "x" + height + "\n");

        camera.targetTexture = oldTarget;
        controller.captureURPGBufferForValidation = false;
        controller.ReleaseURPGBufferValidationCapture();
        final.Release();
        UnityEngine.Object.DestroyImmediate(final);
        AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
        Debug.Log("[EID3336 Route B Deferred Capture] PASS: " + output);
    }

    static Bounds CalculateBounds(Transform root)
    {
        Renderer[] rs = root != null ? root.GetComponentsInChildren<Renderer>(true) : Array.Empty<Renderer>();
        Bounds result = new Bounds(Vector3.zero, Vector3.zero);
        bool found = false;
        foreach (Renderer r in rs)
        {
            if (r == null) continue;
            if (!found) { result = r.bounds; found = true; }
            else result.Encapsulate(r.bounds);
        }
        return found ? result : new Bounds(Vector3.zero, Vector3.one);
    }

    static void SaveRawGpuTexture(RenderTexture source, string rawPath, string metadataPath)
    {
        if (source == null) return;
        AsyncGPUReadbackRequest request = AsyncGPUReadback.Request(source);
        request.WaitForCompletion();
        if (request.hasError)
        {
            File.WriteAllText(metadataPath, "{\n  \"error\": \"AsyncGPUReadback failed\"\n}\n");
            return;
        }
        byte[] bytes = request.GetData<byte>().ToArray();
        File.WriteAllBytes(rawPath, bytes);
        File.WriteAllText(metadataPath,
            "{\n" +
            "  \"width\": " + source.width + ",\n" +
            "  \"height\": " + source.height + ",\n" +
            "  \"graphicsFormat\": \"" + source.graphicsFormat + "\",\n" +
            "  \"bytes\": " + bytes.Length + "\n" +
            "}\n");
    }

    static void SaveTexture(RenderTexture source, string path)
    {
        RenderTexture old = RenderTexture.active;
        RenderTexture.active = source;
        Texture2D texture = new Texture2D(source.width, source.height, TextureFormat.RGBA32, false, true);
        texture.ReadPixels(new Rect(0, 0, source.width, source.height), 0, 0, false);
        texture.Apply(false, false);
        File.WriteAllBytes(path, texture.EncodeToPNG());
        UnityEngine.Object.DestroyImmediate(texture);
        RenderTexture.active = old;
    }
}
#endif
