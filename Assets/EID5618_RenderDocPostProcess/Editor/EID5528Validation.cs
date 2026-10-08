#if UNITY_EDITOR
using System;
using System.IO;
using UnityEditor;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
public static class EID5528Validation
{
    const string Folder=".rdctools/eid5528_1007/";
    [MenuItem("EID5537/Validate and enable live EID5528 mask")]
    public static void Run()
    {
        EID5528Pass pass=null;Texture2D fixture=null;RenderTexture native=null;
        try {
            AssetDatabase.Refresh();
            Shader shader=AssetDatabase.LoadAssetAtPath<Shader>("Assets/EID5618_RenderDocPostProcess/Shaders/EID5528LiveMask.shader");
            byte[] packed=File.ReadAllBytes(Folder+"input0.raw");float[] pixels=new float[1366*768*4];
            for(int i=0;i<1366*768;i++) {
                uint v=BitConverter.ToUInt32(packed,i*4);pixels[i*4]=(v&1023)/1023f;pixels[i*4+1]=((v>>10)&1023)/1023f;
                pixels[i*4+2]=((v>>20)&1023)/1023f;pixels[i*4+3]=(v>>30)/3f;
            }
            fixture=new Texture2D(1366,768,TextureFormat.RGBAFloat,false,true);
            fixture.SetPixelData(pixels,0);fixture.Apply(false,true);
            pass=new EID5528Pass();
            var cmd=new CommandBuffer();try {
                if(!pass.Record(cmd,shader,fixture))throw new Exception(pass.Failure);
                Graphics.ExecuteCommandBuffer(cmd);
            }finally{cmd.Release();}
            if(ShaderUtil.ShaderHasError(shader))throw new Exception("Mask shader compile error");
            var read=AsyncGPUReadback.Request(pass.Output);read.WaitForCompletion();
            if(read.hasError)throw new Exception("Mask readback failed");
            var actual=read.GetData<byte>();byte[] expected=File.ReadAllBytes(Folder+"output0.raw");
            int bad=0,ones=0;for(int i=0;i<expected.Length;i++){if(actual[i]!=expected[i])bad++;if(actual[i]!=0)ones++;}
            File.WriteAllBytes(Folder+"unity-mask.raw",actual.ToArray());
            File.WriteAllText(Folder+"validation.txt","API="+SystemInfo.graphicsDeviceType+" pixels="+actual.Length+" mismatch="+bad+" nonzero="+ones+"\n");
            if(bad!=0)throw new Exception("EID5528 captured-reference mismatch: "+bad);
            native=new RenderTexture(new RenderTextureDescriptor(1366,768){graphicsFormat=GraphicsFormat.A2B10G10R10_UNormPack32,depthBufferBits=0,msaaSamples=1});
            if(!native.Create())throw new Exception("Native motion fixture allocation failed");
            for(int frame=0;frame<3;frame++) {
                // Exercise the real RGB10A2 input format with changing contents, not a cached mask.
                cmd=new CommandBuffer();try {
                    cmd.SetRenderTarget(native);cmd.ClearRenderTarget(false,true,frame==1?new Color(0,0,1f/1023,0):Color.clear);
                    if(!pass.Record(cmd,shader,native))throw new Exception(pass.Failure);Graphics.ExecuteCommandBuffer(cmd);
                }finally{cmd.Release();}
                read=AsyncGPUReadback.Request(pass.Output);read.WaitForCompletion();if(read.hasError)throw new Exception("Dynamic readback failed");
                actual=read.GetData<byte>();for(int i=0;i<actual.Length;i++)if(actual[i]!=(frame==1?255:0))throw new Exception("Live native mask did not track input at frame "+frame);
            }
            cmd=new CommandBuffer();try {for(int i=0;i<60;i++)if(!pass.Record(cmd,shader,native))throw new Exception(pass.Failure);Graphics.ExecuteCommandBuffer(cmd);}finally{cmd.Release();}
            if(pass.AllocationCount!=1 || pass.DrawCount!=64)throw new Exception("Unexpected RT churn/draw count");
            var renderer=AssetDatabase.LoadAssetAtPath<UniversalRendererData>("Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-Renderer.asset");
            bool found=false;
            foreach(var f in renderer.rendererFeatures)if(f is EID5537FixedFrameRendererFeature taa) {
                if(!taa.settings.liveEID5519 || !taa.settings.restoreEID5519 || !taa.settings.useLiveColorHistory || !taa.settings.useLiveGBufferDepth || taa.settings.useLiveInputs)
                    throw new Exception("Expected existing live EID5519/color/depth mode; renderer settings not changed");
                taa.settings.liveEID5528=true;taa.settings.eid5528Shader=shader;taa.settings.requireGameCamera=true;taa.settings.renderInSceneView=false;
                taa.ResetColorHistory();EditorUtility.SetDirty(taa);found=true;
            }
            if(!found)throw new Exception("TAA renderer feature missing");
            EditorUtility.SetDirty(renderer);AssetDatabase.SaveAssets();
            File.AppendAllText(Folder+"validation.txt","PASS: byte-exact captured mask; native RGB10A2 black/positive/black updates; 64 draws, 1 allocation. Live _795 enabled for Game only. Full scene visual validation not performed.\n");
        }catch(Exception e){File.WriteAllText(Folder+"validation-error.txt",e.ToString());throw;}
        finally {pass?.Dispose();if(fixture)UnityEngine.Object.DestroyImmediate(fixture);if(native){native.Release();UnityEngine.Object.DestroyImmediate(native);}}
    }
}
#endif
