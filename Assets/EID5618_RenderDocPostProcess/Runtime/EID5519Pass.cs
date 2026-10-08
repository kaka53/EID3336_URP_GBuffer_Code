using System;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;

// Captured-input restoration, NOT a source of live object motion. Cache immutable
// capture output once; camera scoping is enforced by the owning Game-only TAA pass.
public sealed class EID5519Pass : IDisposable
{
    public RenderTexture Depth { get; private set; }
    public RenderTexture Motion { get; private set; }
    public int AllocationCount { get; private set; }
    public int DrawCount { get; private set; }
    Material material;
    EID5519Profile profile;
    ComputeBuffer cameraCB, frameCB;
    readonly RenderTargetIdentifier[] targets = new RenderTargetIdentifier[2];
    bool ready, failed;
    static readonly int CameraCB = Shader.PropertyToID("_6_7");
    static readonly int FrameCB = Shader.PropertyToID("_11_12");

    public bool Record(CommandBuffer cmd, EID5519Profile input)
    {
        if (input == null || input.shader == null || !input.shader.isSupported ||
            !Valid(input.currentDepth) || !Valid(input.currentMotion) ||
            !Valid(input.previousDepth) || !Valid(input.previousMotion) ||
            input.currentMotion.graphicsFormat != GraphicsFormat.R8G8B8A8_UNorm || input.previousMotion.graphicsFormat != GraphicsFormat.R8G8B8A8_UNorm ||
            input.cameraConstants == null || input.frameConstants == null) return false;
        if (profile != input) Dispose();
        if (failed) return false;
        // Frame Debugger records draws in the selected frame, not cached RT producers.
        // Re-emit the same MRT draw while debugging; retain allocations and the
        // normal one-time cache when the debugger is disabled.
        bool inspectFrame = UnityEngine.FrameDebugger.enabled;
        if (!inspectFrame && ready && Depth != null && Depth.IsCreated() && Motion != null && Motion.IsCreated()) return true;
        if (!SystemInfo.IsFormatSupported(GraphicsFormat.R16_SFloat, FormatUsage.Render) ||
            !SystemInfo.IsFormatSupported(GraphicsFormat.A2B10G10R10_UNormPack32, FormatUsage.Render) ||
            SystemInfo.supportedRenderTargetCount < 2) return false;
        try
        {
            if (material == null)
            {
                profile = input;
                material = CoreUtils.CreateEngineMaterial(input.shader);
                cameraCB = Buffer(input.cameraConstants, 1312);
                frameCB = Buffer(input.frameConstants, 192);
            }
            if (Depth == null || !Depth.IsCreated()) { Release(Depth); Depth = Allocate(GraphicsFormat.R16_SFloat, "EID5519_RID209611_Depth"); }
            if (Motion == null || !Motion.IsCreated()) { Release(Motion); Motion = Allocate(GraphicsFormat.A2B10G10R10_UNormPack32, "EID5519_RID209540_MotionRejection"); }
            material.SetTexture("_13", input.currentDepth);
            material.SetTexture("_14", input.currentMotion);
            material.SetTexture("_15", input.previousDepth);
            material.SetTexture("_16", input.previousMotion);
            // Material-local CBs: _11_12 is also used by TAA with different data.
            material.SetConstantBuffer(CameraCB, cameraCB, 0, 1312);
            material.SetConstantBuffer(FrameCB, frameCB, 0, 192);
            targets[0] = Depth; targets[1] = Motion;
            const string sample = "EID5519 Depth + Motion Rejection -> TAA";
            cmd.BeginSample(sample);
            cmd.SetRenderTarget(targets, BuiltinRenderTextureType.None);
            cmd.SetViewport(new Rect(0,0,1366,768));
            cmd.DrawProcedural(Matrix4x4.identity, material, 0, MeshTopology.Triangles, 3);
            cmd.EndSample(sample);
            ready = true; DrawCount++;
            return true;
        }
        catch (Exception e) { Dispose(); profile=input; failed=true; Debug.LogWarning("[EID5519] Disabled after allocation/render setup failure: " + e.Message); return false; }
    }
    static bool Valid(Texture t) => t != null && t.width == 1366 && t.height == 768 &&
        t.dimension == TextureDimension.Tex2D;
    RenderTexture Allocate(GraphicsFormat f, string name)
    {
        var rt = new RenderTexture(new RenderTextureDescriptor(1366,768) {
            graphicsFormat=f, depthBufferBits=0, msaaSamples=1, mipCount=1,
            useMipMap=false, autoGenerateMips=false, sRGB=false
        }) { name=name, filterMode=FilterMode.Point, wrapMode=TextureWrapMode.Clamp };
        if (!rt.Create()) { CoreUtils.Destroy(rt); throw new InvalidOperationException("EID5519 RT allocation failed"); }
        AllocationCount++;
        return rt;
    }
    static ComputeBuffer Buffer(TextAsset asset, int size)
    {
        byte[] b=asset.bytes;
        if (b.Length != size) throw new InvalidOperationException("Invalid EID5519 constants: " + asset.name);
        var words=new uint[size/4]; System.Buffer.BlockCopy(b,0,words,0,size);
        var buffer=new ComputeBuffer(size/4,4,ComputeBufferType.Constant);
        try { buffer.SetData(words); return buffer; } catch { buffer.Release(); throw; }
    }
    static void Release(RenderTexture rt) { if (rt != null) { rt.Release(); CoreUtils.Destroy(rt); } }
    public void Invalidate() { ready=false; failed=false; }
    public void Dispose()
    {
        ready=false; failed=false; Release(Depth); Release(Motion); Depth=Motion=null;
        cameraCB?.Release(); frameCB?.Release(); cameraCB=frameCB=null;
        CoreUtils.Destroy(material); material=null; profile=null;
    }
}
