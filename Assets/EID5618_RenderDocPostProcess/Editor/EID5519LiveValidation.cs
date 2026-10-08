#if UNITY_EDITOR
using System;
using System.IO;
using UnityEditor;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
public static class EID5519LiveValidation
{
    const string Folder=".rdctools/eid5519_live_1007/";
    public static void Run()
    {
        EID5519LivePass live=null; RTHandle dh=null,mh=null; GameObject go=null;
        try {
            EID5519Setup.Run(); // Recheck exact captured shader after adding native RT variant.
            var shader=AssetDatabase.LoadAssetAtPath<Shader>("Assets/EID5618_RenderDocPostProcess/Shaders/EID5519.shader");
            go=new GameObject("EID5519 synthetic Game camera");var camera=go.AddComponent<Camera>();camera.enabled=false;
            dh=RTHandles.Alloc(new RenderTextureDescriptor(1366,768){graphicsFormat=GraphicsFormat.None,depthStencilFormat=GraphicsFormat.D32_SFloat,msaaSamples=1},name:"5519 test depth");
            mh=RTHandles.Alloc(new RenderTextureDescriptor(1366,768){graphicsFormat=GraphicsFormat.A2B10G10R10_UNormPack32,depthBufferBits=0,msaaSamples=1},name:"5519 test motion");
            live=new EID5519LivePass();
            for(int frame=0;frame<3;frame++) {
                var cmd=new CommandBuffer();try {
                    cmd.SetRenderTarget(mh.nameID,dh.nameID);cmd.ClearRenderTarget(true,true,new Color(.5f,.5f,0,0),frame==0?.75f:.5f);
                    if(!live.Record(cmd,shader,camera,dh,mh,new Vector2Int(1366,768),Matrix4x4.identity,false,false)) throw new Exception(live.Failure);
                    if(live.ResetThisRender!=(frame==0))throw new Exception("Unexpected history reset");
                    Graphics.ExecuteCommandBuffer(cmd);
                    var read=AsyncGPUReadback.Request(live.CurrentDepth);read.WaitForCompletion();
                    if(read.hasError || Math.Abs(read.GetData<float>()[10000]-(frame==0?.25f:.5f))>1e-6f)throw new Exception("Depth aspect / normalization mismatch frame="+frame+" readbackError="+read.hasError+" actual="+(read.hasError?-99:read.GetData<float>()[10000]));
                    var output=AsyncGPUReadback.Request(live.Depth);output.WaitForCompletion();
                    ushort expected=frame==0?(ushort)0x3400:(ushort)0x3800;
                    if(output.hasError || output.GetData<ushort>()[10000]!=expected)throw new Exception("EID5519 live depth output mismatch");
                    if(frame>0) {
                        var mat=(Material)typeof(EID5519LivePass).GetField("material",System.Reflection.BindingFlags.Instance|System.Reflection.BindingFlags.NonPublic).GetValue(live);
                        var previous=(RenderTexture)mat.GetTexture("_15");
                        if(previous==live.Depth || mat.GetTexture("_16")==live.Motion)throw new Exception("History read/write alias");
                        var previousRead=AsyncGPUReadback.Request(previous);previousRead.WaitForCompletion();
                        if(previousRead.hasError || previousRead.GetData<ushort>()[10000]!=(frame==1?0x3400:0x3800))throw new Exception("Previous frame depth mismatch");
                    }
                    live.Commit();
                } finally {cmd.Release();}
            }
            if(ShaderUtil.ShaderHasError(shader) || live.AllocationCount!=6 || live.DrawCount!=6)throw new Exception("Shader/RT reuse failed");
            var renderer=AssetDatabase.LoadAssetAtPath<UniversalRendererData>("Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-Renderer.asset");
            foreach(var f in renderer.rendererFeatures)if(f is EID5537FixedFrameRendererFeature taa) {
                taa.settings.restoreEID5519=true;taa.settings.liveEID5519=true;taa.settings.eid5519LiveShader=shader;taa.settings.eid5519Profile=null;taa.settings.useLiveColorHistory=true;taa.settings.useLiveGBufferDepth=true;
                taa.settings.requireGameCamera=true;taa.settings.renderInSceneView=false;EditorUtility.SetDirty(taa);
            }
            EditorUtility.SetDirty(renderer);AssetDatabase.SaveAssets();
            File.WriteAllText(Folder+"validation.txt","PASS API="+SystemInfo.graphicsDeviceType+"; captured output parity retained; native live 13/14 + ping-pong 15/16; 3 frames, 6 draws, 6 allocations; depth aspect and live shader output verified. Scene integration / moving-object velocity not verified.");
        } catch(Exception e) {File.WriteAllText(Folder+"validation-error.txt",e.ToString());throw;}
        finally {live?.Dispose();dh?.Release();mh?.Release();if(go!=null)UnityEngine.Object.DestroyImmediate(go);}
    }
}
#endif
