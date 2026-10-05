using System;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public sealed class EID5537FixedFrameRendererFeature : ScriptableRendererFeature
{
    public const int Width = 1366;
    public const int Height = 768;
    public static readonly int OutputId = Shader.PropertyToID("_EID5537Res9");
    public static RenderTexture CurrentOutput { get; private set; }

    [Serializable]
    public sealed class Settings
    {
        public EID5537FixedFrameProfile profile;
        public Shader shader;
        public RenderPassEvent injectionPoint = RenderPassEvent.AfterRenderingPostProcessing;
        public bool renderInGameView = true;
        public bool renderInSceneView = false;
        public bool enabledForCamera = true;
        [HideInInspector] public int probeInput;
    }

    public Settings settings = new Settings();
    FixedFramePass pass;
    Material material;

    public override void Create()
    {
        pass?.Dispose();
        if (material != null) CoreUtils.Destroy(material);
        Shader shader = settings.shader != null ? settings.shader : Shader.Find("Hidden/EID5618/EID5537Res9");
        material = shader == null ? null : CoreUtils.CreateEngineMaterial(shader);
        pass = material == null ? null : new FixedFramePass(settings, material);
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        if (pass == null || !settings.enabledForCamera || settings.profile == null) return;
        Camera camera = renderingData.cameraData.camera;
        if (camera == null || camera.cameraType == CameraType.Preview || camera.cameraType == CameraType.Reflection) return;
        if (renderingData.cameraData.isSceneViewCamera ? !settings.renderInSceneView : !settings.renderInGameView) return;
        pass.renderPassEvent = settings.injectionPoint;
        renderer.EnqueuePass(pass);
    }

    protected override void Dispose(bool disposing)
    {
        pass?.Dispose();
        pass = null;
        if (material != null) CoreUtils.Destroy(material);
        material = null;
        CurrentOutput = null;
    }

    sealed class FixedFramePass : ScriptableRenderPass
    {
        static readonly int Res14 = Shader.PropertyToID("_790");
        static readonly int Res13 = Shader.PropertyToID("_13");
        static readonly int Res17 = Shader.PropertyToID("_800");
        static readonly int Res16 = Shader.PropertyToID("_795");
        static readonly int Res15 = Shader.PropertyToID("_15");
        static readonly int B7 = Shader.PropertyToID("_11_12");
        static readonly int B8 = Shader.PropertyToID("_5_6");
        readonly Settings settings;
        readonly Material material;
        RTHandle target;
        ComputeBuffer cb7;
        ComputeBuffer cb8;
        TextAsset previousB7;
        TextAsset previousB8;
        bool warned;

        public FixedFramePass(Settings settings, Material material)
        {
            this.settings = settings;
            this.material = material;
        }

        public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
        {
            var desc = new RenderTextureDescriptor(Width, Height)
            {
                depthBufferBits = 0, msaaSamples = 1, mipCount = 1,
                useMipMap = false, autoGenerateMips = false, sRGB = false,
                graphicsFormat = GraphicsFormat.R16G16B16A16_SFloat
            };
            RenderingUtils.ReAllocateIfNeeded(ref target, desc, FilterMode.Point, TextureWrapMode.Clamp,
                name: "EID5537_RID210447_RGBA16F");
            ConfigureTarget(target);
            ConfigureClear(ClearFlag.Color, Color.clear);
        }

        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            var p = settings.profile;
            if (target == null || p == null || !EnsureBuffers(p) || p.res14Depth == null ||
                p.res13Color == null || p.res17Color == null || p.res16Mask == null || p.res15Color == null)
            {
                if (!warned)
                {
                    Debug.LogError("[EID5537] Missing fixed-frame input or incorrect b7/b8 size (expected 192/3200 bytes).");
                    warned = true;
                }
                return;
            }

            material.SetTexture(Res14, p.res14Depth);
            material.SetTexture(Res13, p.res13Color);
            material.SetTexture(Res17, p.res17Color);
            material.SetTexture(Res16, p.res16Mask);
            material.SetTexture(Res15, p.res15Color);
            material.SetFloat("_EID5537Probe", settings.probeInput);
            var cmd = CommandBufferPool.Get("EID5537 Fixed Frame FS -> RID210447");
            try
            {
                cmd.SetGlobalConstantBuffer(cb7, B7, 0, 192);
                cmd.SetGlobalConstantBuffer(cb8, B8, 0, 3200);
                CoreUtils.SetRenderTarget(cmd, target, ClearFlag.Color, Color.clear);
                cmd.SetViewport(new Rect(0, 0, Width, Height));
                cmd.DrawProcedural(Matrix4x4.identity, material, 0, MeshTopology.Triangles, 3, 1);
                cmd.SetGlobalTexture(OutputId, target.nameID);
                context.ExecuteCommandBuffer(cmd);
                CurrentOutput = target.rt;
            }
            finally { CommandBufferPool.Release(cmd); }
        }

        bool EnsureBuffers(EID5537FixedFrameProfile p)
        {
            if (p.uniforms12B7 == null || p.uniforms6B8 == null ||
                p.uniforms12B7.bytes.Length != 192 || p.uniforms6B8.bytes.Length != 3200) return false;
            if (cb7 != null && cb8 != null && previousB7 == p.uniforms12B7 && previousB8 == p.uniforms6B8) return true;
            cb7?.Release();
            cb8?.Release();
            cb7 = new ComputeBuffer(192 / 16, 16, ComputeBufferType.Constant);
            cb8 = new ComputeBuffer(3200 / 16, 16, ComputeBufferType.Constant);
            cb7.SetData(AsUInt4(p.uniforms12B7.bytes));
            cb8.SetData(AsUInt4(p.uniforms6B8.bytes));
            previousB7 = p.uniforms12B7;
            previousB8 = p.uniforms6B8;
            return true;
        }

        struct UInt4 { public uint x, y, z, w; }

        static UInt4[] AsUInt4(byte[] bytes)
        {
            var values = new UInt4[bytes.Length / 16];
            for (int i = 0; i < values.Length; i++)
            {
                int offset = i * 16;
                values[i] = new UInt4
                {
                    x = BitConverter.ToUInt32(bytes, offset), y = BitConverter.ToUInt32(bytes, offset + 4),
                    z = BitConverter.ToUInt32(bytes, offset + 8), w = BitConverter.ToUInt32(bytes, offset + 12)
                };
            }
            return values;
        }

        public void Dispose()
        {
            if (CurrentOutput == target?.rt) CurrentOutput = null;
            target?.Release();
            target = null;
            cb7?.Release();
            cb8?.Release();
            cb7 = null;
            cb8 = null;
        }
    }
}
