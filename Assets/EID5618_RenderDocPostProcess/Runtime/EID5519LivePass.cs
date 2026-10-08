using System;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

// One selected Game camera. All four EID5519 inputs are live; never capture fallback.
public sealed class EID5519LivePass : IDisposable
{
    public RenderTexture CurrentDepth { get; private set; }
    public RenderTexture CurrentMotion { get; private set; }
    public RenderTexture Depth => depthWrite;
    public RenderTexture Motion => motionWrite;
    public int AllocationCount { get; private set; }
    public int DrawCount { get; private set; }
    public bool ResetThisRender { get; private set; }
    public string Failure { get; private set; }
    RenderTexture depthRead, motionRead, depthWrite, motionWrite;
    readonly RenderTargetIdentifier[] mrt = new RenderTargetIdentifier[2];
    Material material;
    Camera owner, pendingOwner;
    Matrix4x4 previousVP, pendingVP;
    Vector2Int previousSize, pendingSize;
    bool faulted, valid, pending, previousFlip, pendingFlip, previousPlaying;
    double lastTime;
    static readonly int DepthSource = Shader.PropertyToID("_EID5519DepthSource");
    public bool Record(CommandBuffer cmd, Shader shader, Camera camera, RTHandle depth, RTHandle motion,
        Vector2Int size, Matrix4x4 currentVP, bool flipY, bool reset)
    {
        pending=false;
        if(faulted)return false;
        if(camera==null || camera.cameraType!=CameraType.Game || shader==null || !shader.isSupported ||
            depth?.rt==null || motion?.rt==null || !depth.rt.IsCreated() || !motion.rt.IsCreated() ||
            depth.rt.antiAliasing!=1 || motion.rt.antiAliasing!=1 || !SystemInfo.usesReversedZBuffer ||
            depth.rt.depthStencilFormat==GraphicsFormat.None ||
            motion.rt.graphicsFormat!=GraphicsFormat.A2B10G10R10_UNormPack32 ||
            size.x<=0 || size.y<=0 || size.x>depth.rt.width || size.y>depth.rt.height ||
            size.x>motion.rt.width || size.y>motion.rt.height)
        { valid=false; Failure="Missing current-camera single-sample depth / RGB10A2 GBuffer motion"; return false; }
        try
        {
            if(material==null || material.shader!=shader) { CoreUtils.Destroy(material); material=CoreUtils.CreateEngineMaterial(shader);valid=false; }
            if(material.passCount<3) { Failure="Live EID5519 shader passes unavailable"; return false; }
            var d=CurrentDepth;Ensure(ref d,GraphicsFormat.R32_SFloat,"EID5519_Live13_CurrentDepth");CurrentDepth=d;
            var m=CurrentMotion;Ensure(ref m,GraphicsFormat.A2B10G10R10_UNormPack32,"EID5519_Live14_CurrentMotion");CurrentMotion=m;
            Ensure(ref depthRead,GraphicsFormat.R16_SFloat,"EID5519_Live15_PreviousDepth");
            Ensure(ref motionRead,GraphicsFormat.A2B10G10R10_UNormPack32,"EID5519_Live16_PreviousMotion");
            Ensure(ref depthWrite,GraphicsFormat.R16_SFloat,"EID5519_RID209611_LiveDepth");
            Ensure(ref motionWrite,GraphicsFormat.A2B10G10R10_UNormPack32,"EID5519_RID209540_LiveMotion");
            ResetThisRender=reset || !valid || owner!=camera || previousSize!=size || previousFlip!=flipY ||
                previousPlaying!=Application.isPlaying || Time.realtimeSinceStartupAsDouble-lastTime>1.0;
            material.SetTexture("_EID5519MotionSource",motion.rt);
            material.SetVector("_EID5519SourceSize",new Vector4(size.x,size.y,1366,768));
            material.SetFloat("_EID5519FlipY",flipY?1:0);
            cmd.SetGlobalTexture(DepthSource,depth.nameID,RenderTextureSubElement.Depth);
            mrt[0]=CurrentDepth;mrt[1]=CurrentMotion;
            cmd.BeginSample("EID5519 Live / Normalize Current Depth + Motion");
            cmd.SetRenderTarget(mrt,BuiltinRenderTextureType.None);cmd.SetViewport(new Rect(0,0,1366,768));
            cmd.DrawProcedural(Matrix4x4.identity,material,2,MeshTopology.Triangles,3);DrawCount++;
            cmd.EndSample("EID5519 Live / Normalize Current Depth + Motion");
            material.SetTexture("_13",CurrentDepth);material.SetTexture("_14",CurrentMotion);
            material.SetTexture("_15",ResetThisRender?CurrentDepth:depthRead);
            material.SetTexture("_16",ResetThisRender?CurrentMotion:motionRead);
            material.SetVector("_EID5519Size",new Vector4(1366,768,1f/1366,1f/768));
            material.SetFloat("_EID5519DepthThreshold",0.0002f);
            material.SetMatrix("_EID5519Reprojection",ResetThisRender?Matrix4x4.identity:previousVP*currentVP.inverse);
            mrt[0]=depthWrite;mrt[1]=motionWrite;
            cmd.BeginSample("EID5519 Live Depth + Motion Rejection -> TAA");
            cmd.SetRenderTarget(mrt,BuiltinRenderTextureType.None);cmd.SetViewport(new Rect(0,0,1366,768));
            cmd.DrawProcedural(Matrix4x4.identity,material,1,MeshTopology.Triangles,3);DrawCount++;
            cmd.EndSample("EID5519 Live Depth + Motion Rejection -> TAA");
            pendingOwner=camera;pendingVP=currentVP;pendingSize=size;pendingFlip=flipY;pending=true;Failure=null;return true;
        }
        catch(Exception e) { valid=false;faulted=true;Failure=e.Message;return false; }
    }
    // Only swap after the command buffer containing EID5519 AND its consumer was submitted.
    public void Commit()
    {
        if(!pending)return;
        var d=depthRead;depthRead=depthWrite;depthWrite=d;
        var m=motionRead;motionRead=motionWrite;motionWrite=m;
        owner=pendingOwner;previousVP=pendingVP;previousSize=pendingSize;previousFlip=pendingFlip;
        previousPlaying=Application.isPlaying;lastTime=Time.realtimeSinceStartupAsDouble;valid=true;pending=false;
    }
    public void Invalidate() { valid=false;pending=false;faulted=false; }
    void Ensure(ref RenderTexture rt, GraphicsFormat f, string name)
    {
        if(rt!=null && rt.IsCreated())return;
        Release(rt);rt=null;valid=false;
        if(!SystemInfo.IsFormatSupported(f,FormatUsage.Render))throw new InvalidOperationException("Unsupported RT: "+f);
        rt=new RenderTexture(new RenderTextureDescriptor(1366,768) {graphicsFormat=f,depthBufferBits=0,msaaSamples=1,mipCount=1,useMipMap=false,autoGenerateMips=false,sRGB=false})
            {name=name,filterMode=FilterMode.Point,wrapMode=TextureWrapMode.Clamp};
        if(!rt.Create())throw new InvalidOperationException("EID5519 live RT allocation failed");AllocationCount++;
    }
    static void Release(RenderTexture t) { if(t!=null){t.Release();CoreUtils.Destroy(t);} }
    public void Dispose() {Release(CurrentDepth);Release(CurrentMotion);Release(depthRead);Release(motionRead);Release(depthWrite);Release(motionWrite);
        CurrentDepth=CurrentMotion=depthRead=motionRead=depthWrite=motionWrite=null;CoreUtils.Destroy(material);material=null;owner=null;Invalidate();}
}
