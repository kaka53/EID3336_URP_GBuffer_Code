using System;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;

// Owned and invoked by the Game-only EID5537 renderer feature. No global last-camera output.
public sealed class EID5528Pass : IDisposable
{
    public const int Width=344, Height=192;
    public RenderTexture Output {get; private set;}
    public int AllocationCount {get; private set;}
    public int DrawCount {get; private set;}
    public string Failure {get; private set;}
    Material material;
    bool faulted;
    static readonly int MotionId=Shader.PropertyToID("_EID5528Motion");
    static readonly int SourceSizeId=Shader.PropertyToID("_EID5528SourceSize");
    static readonly int TargetSizeId=Shader.PropertyToID("_EID5528TargetSize");
    public bool Record(CommandBuffer cmd, Shader shader, Texture currentMotion)
    {
        if(faulted)return false;
        if(shader==null || !shader.isSupported || currentMotion==null ||
            currentMotion.width!=1366 || currentMotion.height!=768 ||
            currentMotion.dimension!=TextureDimension.Tex2D ||
            (currentMotion is RenderTexture rt && (!rt.IsCreated() || rt.antiAliasing!=1)))
        { Failure="Missing supported shader or matching current-frame EID5519 motion RT";return false; }
        try {
            if(material==null || material.shader!=shader) {CoreUtils.Destroy(material);material=CoreUtils.CreateEngineMaterial(shader);}
            if(Output==null || !Output.IsCreated()) {
                if(!SystemInfo.IsFormatSupported(GraphicsFormat.R8_UNorm,FormatUsage.Render))throw new InvalidOperationException("R8 render target unsupported");
                ReleaseOutput();
                Output=new RenderTexture(new RenderTextureDescriptor(Width,Height){graphicsFormat=GraphicsFormat.R8_UNorm,depthBufferBits=0,
                    msaaSamples=1,mipCount=1,useMipMap=false,autoGenerateMips=false,sRGB=false})
                    {name="EID5528_RID209614_Live795_Mask",filterMode=FilterMode.Bilinear,wrapMode=TextureWrapMode.Clamp};
                if(!Output.Create())throw new InvalidOperationException("EID5528 RT allocation failed");
                AllocationCount++;
            }
            if(currentMotion==Output)throw new InvalidOperationException("EID5528 input/output feedback alias");
            material.SetTexture(MotionId,currentMotion);
            material.SetVector(SourceSizeId,new Vector4(1366,768,1f/1366,1f/768));
            material.SetVector(TargetSizeId,new Vector4(Width,Height,1f/Width,1f/Height));
            cmd.BeginSample("EID5528 Live Mask -> EID5537 _795");
            cmd.SetRenderTarget(Output);cmd.SetViewport(new Rect(0,0,Width,Height));
            cmd.DrawProcedural(Matrix4x4.identity,material,0,MeshTopology.Triangles,3);
            cmd.EndSample("EID5528 Live Mask -> EID5537 _795");
            DrawCount++;Failure=null;return true;
        } catch(Exception e) {faulted=true;Failure=e.Message;return false;}
    }
    public void Invalidate() {faulted=false;}
    void ReleaseOutput() {if(Output!=null){Output.Release();CoreUtils.Destroy(Output);Output=null;}}
    public void Dispose() {ReleaseOutput();CoreUtils.Destroy(material);material=null;faulted=false;}
}
