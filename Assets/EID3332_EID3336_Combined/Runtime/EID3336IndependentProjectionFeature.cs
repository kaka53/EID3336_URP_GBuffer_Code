using System;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public sealed class EID3336IndependentProjectionFeature : ScriptableRendererFeature
{
    public const string ShaderPassName = "EID3336IndependentProjection";
    public const string GlobalTextureName = "_EID3336IndependentProjectionRT";
    public const int AtlasSize = 2048;
    public const int CascadeSize = 1024;

    [Serializable]
    public sealed class Settings
    {
        public RenderPassEvent injectionPoint = RenderPassEvent.AfterRenderingGbuffer;
        public bool renderInGameView = true;
        public bool renderInSceneView = true;
        public LayerMask layerMask = -1;
    }

    public Settings settings = new Settings();
    ProjectionPass pass;

    public override void Create()
    {
        pass = new ProjectionPass(settings);
        pass.renderPassEvent = settings.injectionPoint;
    }

    protected override void Dispose(bool disposing)
    {
        pass?.Dispose();
        pass = null;
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        if (pass == null) return;
        Camera camera = renderingData.cameraData.camera;
        if (camera == null) return;
        if (camera.cameraType == CameraType.Preview || camera.cameraType == CameraType.Reflection) return;
        bool sceneView = renderingData.cameraData.isSceneViewCamera;
        if (sceneView)
        {
            if (!settings.renderInSceneView) return;
        }
        else if (!settings.renderInGameView)
        {
            return;
        }

        pass.renderPassEvent = settings.injectionPoint;
        renderer.EnqueuePass(pass);
    }

    sealed class ProjectionPass : ScriptableRenderPass
    {
        static readonly ShaderTagId PassTag = new ShaderTagId(ShaderPassName);
        static readonly int GlobalTextureId = Shader.PropertyToID(GlobalTextureName);
        static readonly int CascadeIndexId = Shader.PropertyToID("_EID195163CascadeIndex");

        static readonly Rect[] CascadeViewports =
        {
            new Rect(0f, 0f, CascadeSize, CascadeSize),
            new Rect(0f, CascadeSize, CascadeSize, CascadeSize),
            new Rect(CascadeSize, 0f, CascadeSize, CascadeSize)
        };

        readonly Settings settings;
        RTHandle colorTarget;
        RTHandle depthTarget;

        public ProjectionPass(Settings settings)
        {
            this.settings = settings;
        }

        public void Dispose()
        {
            colorTarget?.Release();
            depthTarget?.Release();
            colorTarget = null;
            depthTarget = null;
        }

        public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
        {
            var colorDesc = new RenderTextureDescriptor(AtlasSize, AtlasSize)
            {
                msaaSamples = 1,
                graphicsFormat = GraphicsFormat.R16_SFloat,
                depthBufferBits = 0,
                depthStencilFormat = GraphicsFormat.None,
                sRGB = false,
                mipCount = 1,
                useMipMap = false,
                autoGenerateMips = false,
                enableRandomWrite = false
            };

            var depthDesc = colorDesc;
            depthDesc.graphicsFormat = GraphicsFormat.None;
            depthDesc.depthBufferBits = 32;
            depthDesc.depthStencilFormat = GraphicsFormat.D32_SFloat;

            RenderingUtils.ReAllocateIfNeeded(ref colorTarget, colorDesc, FilterMode.Point, TextureWrapMode.Clamp, name: GlobalTextureName);
            RenderingUtils.ReAllocateIfNeeded(ref depthTarget, depthDesc, FilterMode.Point, TextureWrapMode.Clamp, name: "_EID3336IndependentProjectionDepth");
            ConfigureTarget(colorTarget, depthTarget);
            ConfigureClear(ClearFlag.Color | ClearFlag.Depth, Color.black);
        }

        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            if (colorTarget == null || depthTarget == null) return;

            CommandBuffer cmd = CommandBufferPool.Get("EID3336 Independent Projection 195163");
            try
            {
                cmd.SetRenderTarget(colorTarget, depthTarget);
                cmd.SetViewport(new Rect(0f, 0f, AtlasSize, AtlasSize));
                cmd.ClearRenderTarget(true, true, Color.black);
                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();

                DrawingSettings drawingSettings = CreateDrawingSettings(PassTag, ref renderingData, renderingData.cameraData.defaultOpaqueSortFlags);
                FilteringSettings filteringSettings = new FilteringSettings(RenderQueueRange.opaque, settings.layerMask);

                for (int cascade = 0; cascade < CascadeViewports.Length; ++cascade)
                {
                    cmd.SetViewport(CascadeViewports[cascade]);
                    cmd.SetGlobalInt(CascadeIndexId, cascade);
                    context.ExecuteCommandBuffer(cmd);
                    cmd.Clear();
                    context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref filteringSettings);
                }

                cmd.SetGlobalTexture(GlobalTextureId, colorTarget);
                context.ExecuteCommandBuffer(cmd);
            }
            finally
            {
                CommandBufferPool.Release(cmd);
            }
        }
    }
}
