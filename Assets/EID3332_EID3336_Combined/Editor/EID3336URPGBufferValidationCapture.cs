#if UNITY_EDITOR
using System;
using System.IO;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

[InitializeOnLoad]
public static class EID3336URPGBufferValidationCapture
{
    static readonly string TriggerPath = Path.Combine(Directory.GetParent(Application.dataPath).FullName, "Validation/trigger_centered_gbuffer.txt");

    static EID3336URPGBufferValidationCapture()
    {
        if (File.Exists(TriggerPath))
        {
            File.Delete(TriggerPath);
            EditorApplication.delayCall += CaptureCenteredURPGBuffer;
        }
    }
    const string ScenePath = "Assets/EID3332_EID3336_Combined/Scenes/EID3332_EID3336_Combined.unity";
    const string OutputRelative = "Assets/EID3332_EID3336_Combined/Validation/URP_GBuffer_Centered";

    [MenuItem("Tools/EID3332+3336/Capture Centered URP GBuffer")]
    public static void CaptureCenteredURPGBuffer()
    {
        Scene scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);
        if (!scene.IsValid()) throw new InvalidOperationException("Unable to open combined scene: " + ScenePath);

        EID3332CombinedDeferredController controller = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>(true);
        if (controller == null || controller.targetCamera == null)
            throw new InvalidOperationException("Combined controller or target camera is missing.");

        if (controller.eid3332Root != null) controller.eid3332Root.gameObject.SetActive(false);
        if (controller.eid3315Root != null) controller.eid3315Root.gameObject.SetActive(false);
        if (controller.eid3336Root != null) controller.eid3336Root.gameObject.SetActive(true);
        int routeBLayerMask = 0;
        if (controller.eid3336Root != null)
            foreach (Renderer r in controller.eid3336Root.GetComponentsInChildren<Renderer>(true))
                if (r != null) routeBLayerMask |= 1 << r.gameObject.layer;

        controller.projectionSource = EID3332CombinedDeferredController.ProjectionSource.CurrentUnityCamera;
        controller.captureURPGBufferForValidation = true;
        controller.enableB6Lighting = false;

        Bounds bounds = CalculateBounds(controller.eid3336Root);
        if (bounds.size.sqrMagnitude < 1e-8f)
            bounds = new Bounds(Vector3.zero, Vector3.one);

        Camera camera = controller.targetCamera;
        camera.cullingMask |= routeBLayerMask;
        camera.enabled = false;
        camera.orthographic = false;
        camera.fieldOfView = 40f;
        camera.aspect = 16f / 9f;
        camera.nearClipPlane = Mathf.Max(0.01f, bounds.size.magnitude * 0.001f);
        camera.farClipPlane = Mathf.Max(camera.nearClipPlane + 10f, bounds.size.magnitude * 20f);

        Vector3 viewDirection = camera.transform.forward;
        if (viewDirection.sqrMagnitude < 1e-6f) viewDirection = new Vector3(0f, 0f, 1f);
        viewDirection.Normalize();
        float radius = Mathf.Max(bounds.extents.magnitude, 0.01f);
        float distance = radius / Mathf.Tan(camera.fieldOfView * Mathf.Deg2Rad * 0.5f) * 1.25f;
        camera.transform.position = bounds.center - viewDirection * distance;
        camera.transform.rotation = Quaternion.LookRotation(bounds.center - camera.transform.position, Vector3.up);

        int width = 1024;
        int height = 576;
        RenderTexture final = new RenderTexture(width, height, 24, RenderTextureFormat.ARGB32)
        {
            name = "EID3336 URP GBuffer centered final",
            hideFlags = HideFlags.DontSave
        };
        final.Create();
        RenderTexture oldTarget = camera.targetTexture;
        camera.targetTexture = final;

        // Edit-mode Camera.Render does not guarantee LateUpdate. Push the
        // current camera and per-renderer Transform matrices explicitly so
        // the stock URP DrawRenderers path sees the same values as Game/Scene.
        EID3336RouteBMeshRendererAdapter adapter =
            UnityEngine.Object.FindObjectOfType<EID3336RouteBMeshRendererAdapter>(true);
        if (adapter != null)
        {
            adapter.SetCamera(camera);
            adapter.RefreshEntries();
            adapter.ApplyAll();
        }

        camera.Render();

        string projectRoot = Directory.GetParent(Application.dataPath).FullName;
        string output = Path.Combine(projectRoot, OutputRelative.Replace('/', Path.DirectorySeparatorChar));
        Directory.CreateDirectory(output);
        SaveTexture(final, Path.Combine(output, "Final_Centered.png"), false);

        if (controller.lastURPGBufferCapture == null || controller.lastURPGBufferCapture.Length < 5)
            throw new InvalidOperationException("URP GBuffer capture was not produced. The provider was not called or attachments were unavailable.");

        for (int i = 0; i < 5; ++i)
        {
            RenderTexture rt = controller.lastURPGBufferCapture[i];
            if (rt == null) continue;
            SaveTexture(rt, Path.Combine(output, "GBuffer" + i + "_Raw.png"), false);
            SaveTexture(rt, Path.Combine(output, "RenderDocRT" + i + "_Raw.png"), false);
            if (i == 2)
                SaveTexture(rt, Path.Combine(output, "GBuffer2_Normal_Visualized.png"), true);
        }

        File.WriteAllText(Path.Combine(output, "capture_info.txt"),
            "scene=" + ScenePath + "\n" +
            "projection=CurrentUnityCamera\n" +
            "object_center=" + bounds.center + "\n" +
            "object_size=" + bounds.size + "\n" +
            "camera_position=" + camera.transform.position + "\n" +
            "resolution=" + width + "x" + height + "\n");

        camera.targetTexture = oldTarget;
        controller.captureURPGBufferForValidation = false;
        controller.ReleaseURPGBufferValidationCapture();
        if (final != null) { final.Release(); UnityEngine.Object.DestroyImmediate(final); }
        AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
        Debug.Log("[EID3336 URP GBuffer Capture] PASS: " + output);
    }

    static Bounds CalculateBounds(Transform root)
    {
        if (root == null) return new Bounds(Vector3.zero, Vector3.zero);
        Renderer[] renderers = root.GetComponentsInChildren<Renderer>(true);
        Bounds result = new Bounds(root.position, Vector3.zero);
        bool found = false;
        for (int i = 0; i < renderers.Length; ++i)
        {
            if (renderers[i] == null) continue;
            if (!found) { result = renderers[i].bounds; found = true; }
            else result.Encapsulate(renderers[i].bounds);
        }
        return result;
    }

    static void SaveTexture(RenderTexture source, string path, bool visualizeNormal)
    {
        RenderTexture previous = RenderTexture.active;
        RenderTexture.active = source;
        Texture2D texture = new Texture2D(source.width, source.height, TextureFormat.RGBA32, false, true);
        texture.ReadPixels(new Rect(0, 0, source.width, source.height), 0, 0, false);
        texture.Apply(false, false);
        if (visualizeNormal)
        {
            Color[] pixels = texture.GetPixels();
            for (int i = 0; i < pixels.Length; ++i)
                pixels[i] = new Color(pixels[i].r, pixels[i].g, pixels[i].b, 1f);
            texture.SetPixels(pixels);
            texture.Apply(false, false);
        }
        File.WriteAllBytes(path, texture.EncodeToPNG());
        UnityEngine.Object.DestroyImmediate(texture);
        RenderTexture.active = previous;
    }
}
#endif




