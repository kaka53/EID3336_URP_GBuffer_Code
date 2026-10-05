using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

/// <summary>RenderDoc Colour Pass #16: EID4602 half depth + EID4613 capsule SH.</summary>
public sealed class EID4613ColourPass16Feature : ScriptableRendererFeature
{
    public const string ShaderName = "Hidden/EID4613/ColourPass16";
    public const int InjectionPoint = 221; // GBuffer 210 / depth copy 211 / CP2 220 / CP16 221 / CP20 222 / lighting 230.
    [Serializable]
    public sealed class Settings
    {
        public bool enabledForCamera = true;
        public bool renderInGameView = true;
        public bool renderInSceneView = true;
        [Tooltip("将本相机的新鲜输出绑定到 4662/4666 的 _38。关闭只生成 RT，不改变光照输入。")]
        public bool feedDeferredScreenSH = true;
    }
    public Settings settings = new Settings();
    Pass pass;
    sealed class Output
    {
        public Camera camera;
        public EID4613ColourPass16Feature owner;
        public RenderTexture texture;
        public Texture inputDepth, inputRT3;
        public bool ready;
    }
    static readonly Dictionary<int, Output> outputs = new Dictionary<int, Output>();

    public static bool TryGetOutput(Camera camera, out RenderTexture texture)
    {
        texture = null;
        if (camera == null || !outputs.TryGetValue(camera.GetInstanceID(), out var o)
            || o.camera != camera || !o.ready || o.owner == null || !o.owner.isActive
            || !o.owner.settings.enabledForCamera || !o.texture || !o.texture.IsCreated()) return false;
        if (camera.cameraType == CameraType.SceneView ? !o.owner.settings.renderInSceneView : !o.owner.settings.renderInGameView) return false;
        texture = o.texture;
        return true;
    }
    public static bool TryGetInputs(Camera camera, out Texture depth, out Texture rt3)
    {
        depth = rt3 = null;
        if (!TryGetOutput(camera, out _)) return false;
        var o = outputs[camera.GetInstanceID()]; depth = o.inputDepth; rt3 = o.inputRT3; return true;
    }
    public static void ApplyDeferredScreenSH(Material material, Camera camera)
    {
        if (material == null || !material.HasProperty("_38") || !TryGetOutput(camera, out var rt)) return;
        if (outputs[camera.GetInstanceID()].owner.settings.feedDeferredScreenSH) material.SetTexture("_38", rt);
    }
    public override void Create()
    {
        pass?.Dispose(); pass = new Pass(this) { renderPassEvent = (RenderPassEvent)InjectionPoint };
    }
    protected override void Dispose(bool disposing) { pass?.Dispose(); pass = null; }
    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        var camera = renderingData.cameraData.camera;
        if (camera == null) return;
        if (outputs.TryGetValue(camera.GetInstanceID(), out var previous) && previous.owner == this) previous.ready = false;
        if (!settings.enabledForCamera || (camera.cameraType != CameraType.Game && camera.cameraType != CameraType.SceneView)) return;
        if (camera.cameraType == CameraType.SceneView ? !settings.renderInSceneView : !settings.renderInGameView) return;
        var controller = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>();
        if (controller == null || !controller.IsForCamera(camera) || !controller.UseEID3336FiveMRT(camera)) return;
        if (pass == null) Create();
        pass.ConfigureInput(ScriptableRenderPassInput.None);
        renderer.EnqueuePass(pass);
    }

    // Shared original constants are immutable. Every draw snapshots textures/matrices in a property block.
    public sealed class CapsuleRenderer : IDisposable
    {
        readonly Material material;
        readonly List<ComputeBuffer> buffers = new List<ComputeBuffer>();
        readonly MaterialPropertyBlock block = new MaterialPropertyBlock();
        Texture2D lut;
        readonly int instanceCount;
        readonly int indexCount;
        static byte[] Data(string name)
        {
            var asset = Resources.Load<TextAsset>("EID4613ColourPass16/" + name);
            if (!asset) throw new InvalidOperationException("Missing CP16 data: " + name);
            return asset.bytes;
        }
        struct UInt4 { public uint x, y, z, w; }
        ComputeBuffer Buffer(byte[] bytes, int stride, ComputeBufferType type)
        {
            var b = new ComputeBuffer(bytes.Length / stride, stride, type); buffers.Add(b);
            // uint arrays preserve the captured bit pattern; one uint per 4-byte word.
            var words = new uint[bytes.Length / 4]; System.Buffer.BlockCopy(bytes, 0, words, 0, bytes.Length);
            if (stride == 16)
            {
                var data = new UInt4[bytes.Length / 16];
                for (int i = 0; i < data.Length; i++) data[i] = new UInt4 { x=words[i*4], y=words[i*4+1], z=words[i*4+2], w=words[i*4+3] };
                b.SetData(data);
            }
            else if (stride == 12)
            {
                var data = new Vector3[bytes.Length / 12];
                for (int i = 0; i < data.Length; i++) data[i] = new Vector3(BitConverter.ToSingle(bytes,i*12),BitConverter.ToSingle(bytes,i*12+4),BitConverter.ToSingle(bytes,i*12+8));
                b.SetData(data);
            }
            else b.SetData(words);
            return b;
        }
        public CapsuleRenderer()
        {
            try
            {
                var shader = Shader.Find(ShaderName);
                if (!shader || !shader.isSupported) throw new InvalidOperationException("CP16 shader unavailable");
                material = CoreUtils.CreateEngineMaterial(shader);
                material.SetFloat("_CP16DepthTest", (float)(SystemInfo.usesReversedZBuffer ? CompareFunction.Greater : CompareFunction.Less));
                byte[] camera = Data("Camera"), parameters = Data("Parameters"), capsules = Data("Capsules");
                BindConstant("_6_7", camera); BindConstant("_13_14", parameters); BindConstant("_15_17", capsules);
                instanceCount = Mathf.Clamp(Mathf.RoundToInt(BitConverter.ToSingle(capsules, 0)), 0, 128);
                var vertices = Data("Vertices"); var indices = Data("Indices"); indexCount = indices.Length / 4;
                material.SetBuffer("_CP16Vertices", Buffer(vertices, 12, ComputeBufferType.Structured));
                material.SetBuffer("_CP16Indices", Buffer(indices, 4, ComputeBufferType.Structured));
                lut = new Texture2D(256, 1, TextureFormat.RGBA32, false, true) { name = "CP16 rid264196 LUT", filterMode = FilterMode.Bilinear, wrapMode = TextureWrapMode.Clamp };
                lut.LoadRawTextureData(Data("LUT")); lut.Apply(false, true); material.SetTexture("_18", lut);
            }
            catch { Dispose(); throw; }
        }
        void BindConstant(string name, byte[] data)
        {
            var b = Buffer(data, 16, ComputeBufferType.Constant);
            material.SetConstantBuffer(Shader.PropertyToID(name), b, 0, data.Length);
        }
        public static RenderTexture CreateTarget(int width, int height, string name)
        {
            var desc = new RenderTextureDescriptor(width, height)
            {
                graphicsFormat = GraphicsFormat.R16G16B16A16_SFloat,
                depthStencilFormat = GraphicsFormat.D32_SFloat_S8_UInt,
                msaaSamples = 1, sRGB = false, useMipMap = false, autoGenerateMips = false
            };
            var rt = new RenderTexture(desc) { name = name, filterMode = FilterMode.Bilinear, wrapMode = TextureWrapMode.Clamp };
            rt.Create(); return rt;
        }
        public void Record(CommandBuffer cmd, RenderTexture output, Texture depth, Texture rt3, bool capturedProjection, Matrix4x4 worldToClip)
        {
            block.Clear(); block.SetTexture("_12", depth); block.SetTexture("_19", rt3);
            block.SetFloat("_CP16CapturedProjection", capturedProjection ? 1 : 0);
            block.SetVector("_CP16OutputSize", new Vector4(output.width, output.height, 1f / output.width, 1f / output.height));
            block.SetMatrix("_CP16WorldToClip", worldToClip); block.SetMatrix("_CP16ClipToWorld", worldToClip.inverse);
            cmd.SetRenderTarget(output);
            cmd.SetViewport(new Rect(0, 0, output.width, output.height));
            cmd.ClearRenderTarget(RTClearFlags.All, Color.clear, 1f, 0u);
            cmd.BeginSample("RenderDoc EID4602 Half Depth (2x2 Min)");
            cmd.DrawProcedural(Matrix4x4.identity, material, 0, MeshTopology.Triangles, 3, 1, block);
            cmd.EndSample("RenderDoc EID4602 Half Depth (2x2 Min)");
            cmd.BeginSample("RenderDoc Colour Pass #16 EID4613 Capsule SH");
            cmd.DrawProcedural(Matrix4x4.identity, material, 1, MeshTopology.Triangles, indexCount, instanceCount, block);
            cmd.EndSample("RenderDoc Colour Pass #16 EID4613 Capsule SH");
        }
        public void Dispose()
        {
            foreach (var b in buffers) b.Release(); buffers.Clear();
            CoreUtils.Destroy(material); CoreUtils.Destroy(lut);
        }
    }
    sealed class Pass : ScriptableRenderPass
    {
        readonly EID4613ColourPass16Feature owner;
        readonly Dictionary<int, Output> states = new Dictionary<int, Output>();
        CapsuleRenderer renderer;
        bool warned;
        public Pass(EID4613ColourPass16Feature owner) { this.owner = owner; }
        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            var camera = renderingData.cameraData.camera;
            var controller = UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>();
            if (camera == null || controller == null || !controller.IsForCamera(camera)) return;
            if (!EID3336FiveMRTLightingInputs.TryGetVegetationLightPassInputs(camera, out var depth, out _, out var normal, out _)
                || depth.width != normal.width || depth.height != normal.height)
            {
                if (!warned) Debug.LogWarning("[CP16] Same-camera Depth / RT3 unavailable. Skipping, never substituting another viewport/captured texture.");
                warned = true; return;
            }
            warned = false;
            if (renderer == null) renderer = new CapsuleRenderer();
            int key = camera.GetInstanceID();
            if (!states.TryGetValue(key, out var state)) { state = new Output { camera = camera, owner = owner }; states.Add(key, state); }
            // Half-resolution render target: ceil handles odd Scene/Game dimensions.
            int w = (depth.width + 1) / 2, h = (depth.height + 1) / 2;
            if (!state.texture || !state.texture.IsCreated() || state.texture.width != w || state.texture.height != h)
            {
                if (state.texture) { state.texture.Release(); CoreUtils.Destroy(state.texture); }
                state.texture = CapsuleRenderer.CreateTarget(w, h, "CP16_CapsuleSH_" + camera.name + "_" + key);
            }
            state.ready = false; outputs[key] = state;
            var cmd = CommandBufferPool.Get("EID4613 Colour Pass #16");
            try
            {
                renderer.Record(cmd, state.texture, depth, normal, controller.UseCapturedProjection(camera), controller.GetViewProjection(camera));
                context.ExecuteCommandBuffer(cmd);
                state.inputDepth = depth; state.inputRT3 = normal; state.ready = true;
            }
            finally { CommandBufferPool.Release(cmd); }
        }
        public void Dispose()
        {
            renderer?.Dispose(); renderer = null;
            foreach (var kv in states)
            {
                if (outputs.TryGetValue(kv.Key, out var o) && o == kv.Value) outputs.Remove(kv.Key);
                if (kv.Value.texture) { kv.Value.texture.Release(); CoreUtils.Destroy(kv.Value.texture); }
            }
            states.Clear();
        }
    }
}
