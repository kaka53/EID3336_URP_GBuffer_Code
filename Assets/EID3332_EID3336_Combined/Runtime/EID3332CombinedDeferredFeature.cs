using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public sealed class EID3332CombinedDeferredFeature : ScriptableRendererFeature
{
    [System.Serializable]
    public sealed class Settings
    {
        public RenderPassEvent injectionPoint = RenderPassEvent.BeforeRenderingOpaques;
        public RenderPassEvent previewPoint = RenderPassEvent.AfterRenderingPostProcessing;
    }

    public Settings settings = new Settings();
    SceneGBufferPass geometryPass;
    SceneDeferredPass deferredPass;
    VSWhitePass vsWhitePass;
    static readonly HashSet<int> LoggedCameras = new HashSet<int>();

    public override void Create()
    {
        geometryPass = new SceneGBufferPass { renderPassEvent = settings.injectionPoint };
        deferredPass = new SceneDeferredPass { renderPassEvent = settings.previewPoint };
        vsWhitePass = new VSWhitePass { renderPassEvent = RenderPassEvent.AfterRenderingOpaques };
    }

    protected override void Dispose(bool disposing)
    {
        deferredPass?.Release();
        geometryPass = null;
        deferredPass = null;
        vsWhitePass = null;
    }

    public override void SetupRenderPasses(ScriptableRenderer renderer, in RenderingData renderingData)
    {
        Camera camera = renderingData.cameraData.camera;
        var white = Object.FindObjectOfType<EID3336VSWhiteTest>();
        if (white != null && white.IsForCamera(camera) && vsWhitePass != null)
        {
            vsWhitePass.test = white;
            vsWhitePass.renderPassEvent = RenderPassEvent.AfterRenderingOpaques;
        }

        var controller = Object.FindObjectOfType<EID3332CombinedDeferredController>();
        if (controller != null && controller.IsForCamera(camera))
            deferredPass.SetTarget(renderer.cameraColorTargetHandle);
        if (controller != null) deferredPass.SetCompositeMaterial(controller.cameraCompositeMaterial);
        if (vsWhitePass != null)
        {
            var whiteForTarget = Object.FindObjectOfType<EID3336VSWhiteTest>();
            if (whiteForTarget != null && whiteForTarget.IsForCamera(camera))
                vsWhitePass.SetTarget(renderer.cameraColorTargetHandle);
        }
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        Camera camera = renderingData.cameraData.camera;
        var whiteForEnqueue = Object.FindObjectOfType<EID3336VSWhiteTest>();
        if (whiteForEnqueue != null && whiteForEnqueue.IsForCamera(camera) && vsWhitePass != null)
        {
            vsWhitePass.test = whiteForEnqueue;
            vsWhitePass.renderPassEvent = RenderPassEvent.AfterRenderingOpaques;
            renderer.EnqueuePass(vsWhitePass);
        }

        var controller = Object.FindObjectOfType<EID3332CombinedDeferredController>();
        if (controller == null || !controller.IsForCamera(camera) || controller.UseEID3336FiveMRT(camera) || controller.UsesRouteBMeshForCamera(camera)) return;

        if (LoggedCameras.Add(camera.GetInstanceID()))
            Debug.Log("[EID3332Combined Runtime] Enqueue live deferred camera=" + camera.name + " type=" + camera.cameraType +
                " size=" + renderingData.cameraData.cameraTargetDescriptor.width + "x" + renderingData.cameraData.cameraTargetDescriptor.height);

        geometryPass.controller = controller;
        geometryPass.renderPassEvent = settings.injectionPoint;
        renderer.EnqueuePass(geometryPass);

        if (controller.normalDeferredDisplay && controller.GetActiveDeferredLightingMaterial() != null)
        {
            deferredPass.controller = controller;
            deferredPass.renderPassEvent = settings.previewPoint;
            renderer.EnqueuePass(deferredPass);
        }
    }

    sealed class VSWhitePass : ScriptableRenderPass
    {
        internal EID3336VSWhiteTest test;
        RTHandle colorTarget;
        internal void SetTarget(RTHandle target) { colorTarget = target; }
        public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
        {
            if (colorTarget != null) ConfigureTarget(colorTarget);
        }
        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            if (test == null || !test.IsForCamera(renderingData.cameraData.camera)) return;
            CommandBuffer cmd = CommandBufferPool.Get("EID3336 RenderDoc VS209986 White Test");
            try
            {
                test.Record(cmd);
                context.ExecuteCommandBuffer(cmd);
            }
            finally { CommandBufferPool.Release(cmd); }
        }
    }

    sealed class SceneGBufferPass : ScriptableRenderPass
    {
        internal EID3332CombinedDeferredController controller;
        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            if (controller == null) return;
            Camera camera = renderingData.cameraData.camera;
            var descriptor = renderingData.cameraData.cameraTargetDescriptor;
            CommandBuffer cmd = CommandBufferPool.Get("EID3332+EID3336 Combined Live GBuffer");
            try
            {
                if (!controller.RecordGeometry(cmd, camera, descriptor.width, descriptor.height)) return;
                context.ExecuteCommandBuffer(cmd);
            }
            finally { CommandBufferPool.Release(cmd); }
        }
    }

    sealed class SceneDeferredPass : ScriptableRenderPass
    {
        internal EID3332CombinedDeferredController controller;
        RTHandle colorTarget;
        RenderTexture currentFinal;
        Material compositeMaterial;
        readonly Dictionary<int, RenderTexture> finalByCamera = new Dictionary<int, RenderTexture>();
        readonly HashSet<int> loggedExecution = new HashSet<int>();

        internal void SetTarget(RTHandle target) => colorTarget = target;

        internal void SetCompositeMaterial(Material material) => compositeMaterial = material;

        public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
        {
            if (colorTarget != null) ConfigureTarget(colorTarget);
            currentFinal = EnsureFinalTexture(renderingData.cameraData.camera, renderingData.cameraData.cameraTargetDescriptor);
        }

        RenderTexture EnsureFinalTexture(Camera camera, RenderTextureDescriptor source)
        {
            int key = camera.GetInstanceID();
            bool captured = controller != null && controller.UseCapturedProjection(camera) && controller.targets != null;
            int width = captured ? Mathf.Max(1, controller.targets.width) : Mathf.Max(1, source.width);
            int height = captured ? Mathf.Max(1, controller.targets.height) : Mathf.Max(1, source.height);
            if (finalByCamera.TryGetValue(key, out RenderTexture texture) && texture != null && texture.width == width && texture.height == height)
                return texture;
            DestroyTexture(texture);
            var descriptor = new RenderTextureDescriptor(width, height, GraphicsFormat.R16G16B16A16_SFloat, 0)
            {
                msaaSamples = 1, useMipMap = false, autoGenerateMips = false, sRGB = false
            };
            texture = new RenderTexture(descriptor)
            {
                name = "EID3332Combined_LiveDeferredFinal_" + camera.name,
                filterMode = FilterMode.Bilinear,
                wrapMode = TextureWrapMode.Clamp
            };
            texture.Create();
            finalByCamera[key] = texture;
            return texture;
        }

        static void DestroyTexture(RenderTexture texture)
        {
            if (texture == null) return;
            texture.Release();
            if (Application.isPlaying) Object.Destroy(texture); else Object.DestroyImmediate(texture);
        }

        internal void Release()
        {
            foreach (RenderTexture texture in finalByCamera.Values) DestroyTexture(texture);
            finalByCamera.Clear();
            currentFinal = null;
        }

        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            if (controller == null || controller.GetActiveDeferredLightingMaterial() == null || colorTarget == null || currentFinal == null) return;
            Camera camera = renderingData.cameraData.camera;
            controller.BindDeferredLighting(camera, currentFinal.width, currentFinal.height);
            CommandBuffer cmd = CommandBufferPool.Get("EID3332+EID3336 Combined Deferred Lighting Final RT + Camera Blit");
            try
            {
                cmd.SetRenderTarget(currentFinal);
                cmd.ClearRenderTarget(false, true, Color.clear);
                cmd.DrawProcedural(Matrix4x4.identity, controller.GetActiveDeferredLightingMaterial(), 0, MeshTopology.Triangles, 3, 1);
                bool sceneView = camera.cameraType == CameraType.SceneView;
                bool compositeReady = compositeMaterial != null && compositeMaterial.shader != null &&
                    compositeMaterial.shader.isSupported && compositeMaterial.passCount > 0;
                // SceneView is finalized against camera.targetTexture from endCameraRendering.
                // renderer.cameraColorTargetHandle is only URP's intermediate attachment here.
                if (!sceneView)
                {
                    if (compositeReady)
                    {
                        compositeMaterial.SetFloat("_EID3336UseSceneBackground", 0f);
                        cmd.Blit(currentFinal, colorTarget, compositeMaterial, 0);
                    }
                    else
                        cmd.Blit(currentFinal, colorTarget);
                }
                context.ExecuteCommandBuffer(cmd);
                controller.SetLiveFinalTexture(camera, currentFinal);
                if (loggedExecution.Add(camera.GetInstanceID()))
                    Debug.Log("[EID3332Combined Runtime] Final RT generated camera=" + camera.name + " type=" + camera.cameraType +
                        " final=" + currentFinal.width + "x" + currentFinal.height +
                        " cameraColorWrite=" + (!sceneView) +
                        " sceneViewFinalizer=" + sceneView +
                        " composite=" + (compositeMaterial != null ? compositeMaterial.name : "null") +
                        " shader=" + (compositeMaterial != null && compositeMaterial.shader != null ? compositeMaterial.shader.name : "null") +
                        " supported=" + compositeReady +
                        " passCount=" + (compositeMaterial != null ? compositeMaterial.passCount : 0));
            }
            finally { CommandBufferPool.Release(cmd); }
        }
    }
}




