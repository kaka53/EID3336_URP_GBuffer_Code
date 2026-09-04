#if UNITY_EDITOR
using System;
using System.IO;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

public static class EID3336RouteBDiagnostics
{
    const string ScenePath = "Assets/EID3332_EID3336_Combined/Scenes/EID3332_EID3336_Combined.unity";
    const string OutputRelative = "Assets/EID3332_EID3336_Combined/Validation/URP_GBuffer_Centered";

    public static void CaptureStockLitControl()
    {
        Scene scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);
        if (!scene.IsValid()) throw new InvalidOperationException("Unable to open scene.");
        var controller = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>(true);
        if (controller == null || controller.targetCamera == null || controller.eid3336Root == null)
            throw new InvalidOperationException("Route B scene references are incomplete.");
        if (controller.eid3332Root != null) controller.eid3332Root.gameObject.SetActive(false);
        if (controller.eid3315Root != null) controller.eid3315Root.gameObject.SetActive(false);
        controller.eid3336Root.gameObject.SetActive(true);
        controller.projectionSource = EID3332CombinedDeferredController.ProjectionSource.CurrentUnityCamera;
        controller.captureURPGBufferForValidation = true;
        controller.enableB6Lighting = false;

        var routeAdapter = controller.GetComponent<EID3336RouteBMeshRendererAdapter>();
        if (routeAdapter != null) routeAdapter.enabledForCurrentCamera = false;
        Renderer[] renderers = controller.eid3336Root.GetComponentsInChildren<Renderer>(true);
        Material[] originals = new Material[renderers.Length];
        Shader lit = Shader.Find("Universal Render Pipeline/Lit");
        if (lit == null) throw new InvalidOperationException("URP Lit shader missing.");
        Material control = new Material(lit) { hideFlags = HideFlags.HideAndDontSave };
        control.SetColor("_BaseColor", new Color(0.8f, 0.2f, 0.7f, 1f));
        for (int i = 0; i < renderers.Length; ++i)
        {
            originals[i] = renderers[i].sharedMaterial;
            renderers[i].sharedMaterial = control;
            MeshFilter mf = renderers[i].GetComponent<MeshFilter>();
            Mesh mesh = mf != null ? mf.sharedMesh : null;
            Debug.Log($"[RouteB Diagnostic] renderer={renderers[i].name} enabled={renderers[i].enabled} active={renderers[i].gameObject.activeInHierarchy} layer={renderers[i].gameObject.layer} mesh={(mesh != null ? mesh.name : "null")} vertices={(mesh != null ? mesh.vertexCount : 0)} indices={(mesh != null ? (int)mesh.GetIndexCount(0) : 0)} submeshes={(mesh != null ? mesh.subMeshCount : 0)} bounds={renderers[i].bounds}");
        }

        Bounds bounds = renderers.Length > 0 ? renderers[0].bounds : new Bounds(Vector3.zero, Vector3.one);
        for (int i = 1; i < renderers.Length; ++i) bounds.Encapsulate(renderers[i].bounds);
        Camera camera = controller.targetCamera;
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
        Debug.Log($"[RouteB Diagnostic] camera={camera.name} cullingMask=0x{camera.cullingMask:X8} position={camera.transform.position} forward={camera.transform.forward} bounds={bounds} litSupported={lit.isSupported}");

        RenderTexture final = new RenderTexture(1024, 576, 24, RenderTextureFormat.ARGB32) { hideFlags = HideFlags.DontSave };
        final.Create();
        RenderTexture previous = camera.targetTexture;
        camera.targetTexture = final;
        camera.Render();
        string output = Path.Combine(Directory.GetParent(Application.dataPath).FullName, OutputRelative.Replace('/', Path.DirectorySeparatorChar));
        Directory.CreateDirectory(output);
        Save(final, Path.Combine(output, "Diagnostic_StockURPLit.png"));
        camera.targetTexture = previous;
        for (int i = 0; i < renderers.Length; ++i) renderers[i].sharedMaterial = originals[i];
        controller.captureURPGBufferForValidation = false;
        controller.ReleaseURPGBufferValidationCapture();
        final.Release();
        UnityEngine.Object.DestroyImmediate(final);
        UnityEngine.Object.DestroyImmediate(control);
        AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
        Debug.Log("[RouteB Diagnostic] PASS: stock URP Lit control captured.");
    }

    static void Save(RenderTexture source, string path)
    {
        RenderTexture old = RenderTexture.active;
        RenderTexture.active = source;
        Texture2D tex = new Texture2D(source.width, source.height, TextureFormat.RGBA32, false, true);
        tex.ReadPixels(new Rect(0, 0, source.width, source.height), 0, 0);
        tex.Apply();
        File.WriteAllBytes(path, tex.EncodeToPNG());
        UnityEngine.Object.DestroyImmediate(tex);
        RenderTexture.active = old;
    }
}
#endif
