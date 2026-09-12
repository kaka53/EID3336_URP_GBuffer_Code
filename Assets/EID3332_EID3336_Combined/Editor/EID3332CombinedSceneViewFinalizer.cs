#if UNITY_EDITOR
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

[InitializeOnLoad]
public static class EID3332CombinedSceneViewFinalizer
{
    static readonly Dictionary<int, RenderTexture> BackgroundByCamera = new Dictionary<int, RenderTexture>();

    static EID3332CombinedSceneViewFinalizer()
    {
        RenderPipelineManager.endCameraRendering -= OnEndCameraRendering;
        RenderPipelineManager.endCameraRendering += OnEndCameraRendering;
        AssemblyReloadEvents.beforeAssemblyReload -= Release;
        AssemblyReloadEvents.beforeAssemblyReload += Release;
        EditorApplication.quitting -= Release;
        EditorApplication.quitting += Release;
    }

    static void OnEndCameraRendering(ScriptableRenderContext context, Camera camera)
    {
        if (camera == null || camera.cameraType != CameraType.SceneView) return;
        EID3332CombinedDeferredController controller = Object.FindObjectOfType<EID3332CombinedDeferredController>();
        if (controller == null || !controller.normalDeferredDisplay || !controller.renderInSceneView) return;
        // EID4662Full is rendered directly by the modified URP DeferredPass.
        // Do not run the legacy endCameraRendering Blit on SceneView, otherwise
        // the native output is composited a second time from a stale final RT.
        if (controller.lightPassMode == EID3332CombinedDeferredController.LightPassMode.EID4662Full) return;
        RenderTexture source = controller.liveSceneViewFinalTexture;
        RenderTexture destination = camera.targetTexture;
        Material composite = controller.cameraCompositeMaterial;
        if (source == null || !source.IsCreated() || destination == null || !destination.IsCreated() ||
            composite == null || composite.shader == null || !composite.shader.isSupported || composite.passCount < 1)
            return;

        RenderTexture background = EnsureBackground(camera, destination);
        try
        {
            Graphics.Blit(destination, background);
            composite.SetTexture("_EID3336SceneBackground", background);
            composite.SetFloat("_EID3336UseSceneBackground", 1f);
            Graphics.Blit(source, destination, composite, 0);
        }
        finally { composite.SetFloat("_EID3336UseSceneBackground", 0f); }
    }

    static RenderTexture EnsureBackground(Camera camera, RenderTexture destination)
    {
        int key = camera.GetInstanceID();
        if (BackgroundByCamera.TryGetValue(key, out RenderTexture texture) && texture != null &&
            texture.width == destination.width && texture.height == destination.height &&
            texture.graphicsFormat == destination.graphicsFormat) return texture;
        DestroyTexture(texture);
        RenderTextureDescriptor descriptor = destination.descriptor;
        descriptor.depthBufferBits = 0; descriptor.msaaSamples = 1; descriptor.bindMS = false;
        descriptor.enableRandomWrite = false; descriptor.useMipMap = false; descriptor.autoGenerateMips = false;
        texture = new RenderTexture(descriptor) { name = "EID3332Combined_SceneView_Background", hideFlags = HideFlags.HideAndDontSave, filterMode = FilterMode.Bilinear, wrapMode = TextureWrapMode.Clamp };
        texture.Create(); BackgroundByCamera[key] = texture; return texture;
    }

    static void Release()
    {
        RenderPipelineManager.endCameraRendering -= OnEndCameraRendering;
        foreach (RenderTexture texture in BackgroundByCamera.Values) DestroyTexture(texture);
        BackgroundByCamera.Clear();
    }

    static void DestroyTexture(RenderTexture texture)
    {
        if (texture == null) return;
        texture.Release(); Object.DestroyImmediate(texture);
    }
}
#endif
