#if UNITY_EDITOR
using System;
using System.IO;
using UnityEditor;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public static class EID5519Setup
{
    const string Root="Assets/EID5618_RenderDocPostProcess/";
    const string Folder=".rdctools/eid5519_1007/";
    [MenuItem("EID5537/Install and validate EID5519 captured pass")]
    public static void Run()
    {
        EID5519Pass pass=null;
        try
        {
            AssetDatabase.Refresh();
            foreach(GraphicsFormat f in new[]{GraphicsFormat.A2B10G10R10_UNormPack32,GraphicsFormat.A2R10G10B10_UNormPack32,GraphicsFormat.R16_SFloat}) Debug.Log("[5519 format] "+f+" sample="+SystemInfo.IsFormatSupported(f,FormatUsage.Sample)+" render="+SystemInfo.IsFormatSupported(f,FormatUsage.Render));
            Debug.Log("[5519 format] ARGB2101010="+GraphicsFormatUtility.GetGraphicsFormat(RenderTextureFormat.ARGB2101010,RenderTextureReadWrite.Linear));
            var shader=AssetDatabase.LoadAssetAtPath<Shader>(Root+"Shaders/EID5519.shader");
            var profile=AssetDatabase.LoadAssetAtPath<EID5519Profile>(Root+"Materials/EID5519_Profile.asset");
            if (profile==null) { profile=ScriptableObject.CreateInstance<EID5519Profile>(); AssetDatabase.CreateAsset(profile,Root+"Materials/EID5519_Profile.asset"); }
            profile.shader=shader;
            profile.currentDepth=Import(0,GraphicsFormat.R32_SFloat);
            profile.previousMotion=Import(1,GraphicsFormat.A2R10G10B10_UNormPack32);
            profile.previousDepth=Import(2,GraphicsFormat.R16_SFloat);
            profile.currentMotion=Import(3,GraphicsFormat.A2R10G10B10_UNormPack32);
            profile.cameraConstants=AssetDatabase.LoadAssetAtPath<TextAsset>(Root+"CapturedInputs/EID5519/cb0.bytes");
            profile.frameConstants=AssetDatabase.LoadAssetAtPath<TextAsset>(Root+"CapturedInputs/EID5519/cb1.bytes");
            EditorUtility.SetDirty(profile); AssetDatabase.SaveAssets();
            pass=new EID5519Pass(); var cmd=new CommandBuffer();
            try { if (!pass.Record(cmd,profile)) throw new Exception("Record failed"); Graphics.ExecuteCommandBuffer(cmd); }
            finally { cmd.Release(); }
            if (ShaderUtil.ShaderHasError(shader)) throw new Exception("EID5519 shader compile failed");
            // Offline validation only. There is no readback in the runtime pass.
            var depth=AsyncGPUReadback.Request(pass.Depth); depth.WaitForCompletion();
            var motion=AsyncGPUReadback.Request(pass.Motion); motion.WaitForCompletion();
            if(depth.hasError || motion.hasError) throw new Exception("GPU readback failed");
            byte[] expectedD=File.ReadAllBytes(Folder+"output0.raw"), expectedM=File.ReadAllBytes(Folder+"output1.raw");
            var actualD=depth.GetData<byte>(); var actualM=motion.GetData<byte>();
            int badDepth=0,badMotion=0; long maxDiff=0;
            for(int i=0;i<expectedD.Length;i+=2) if(expectedD[i]!=actualD[i] || expectedD[i+1]!=actualD[i+1]) badDepth++;
            for(int i=0;i<expectedM.Length;i+=4) {
                uint a=(uint)(actualM[i]|actualM[i+1]<<8|actualM[i+2]<<16|actualM[i+3]<<24);
                uint b=BitConverter.ToUInt32(expectedM,i); bool bad=false;
                for(int c=0;c<4;c++) { int shift=c*10,mask=c==3?3:1023; long delta=Math.Abs((long)((a>>shift)&mask)-((b>>shift)&mask)); if(delta>maxDiff)maxDiff=delta; if(delta>1)bad=true; }
                if(bad)badMotion++;
            }
            File.WriteAllBytes(Folder+"unity_depth.raw",actualD.ToArray());
            File.WriteAllBytes(Folder+"unity_motion.raw",actualM.ToArray());
            int allocations=pass.AllocationCount,draws=pass.DrawCount;
            cmd=new CommandBuffer(); try { for(int i=0;i<60;i++) if(!pass.Record(cmd,profile))throw new Exception("Cache lost"); } finally {cmd.Release();}
            string result="API="+SystemInfo.graphicsDeviceType+" depthMismatchPixels="+badDepth+" motionMismatchGT1LSB="+badMotion+" maxMotionLSB="+maxDiff+" allocations="+pass.AllocationCount+" draws="+pass.DrawCount;
            File.WriteAllText(Folder+"validation.txt",result);
            if(badDepth>0 || badMotion>0 || allocations!=pass.AllocationCount || draws!=pass.DrawCount) throw new Exception(result);
            var renderer=AssetDatabase.LoadAssetAtPath<UniversalRendererData>("Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-Renderer.asset");
            bool found=false;
            foreach(var f in renderer.rendererFeatures) if(f is EID5537FixedFrameRendererFeature taa) {
                taa.settings.eid5519Profile=profile; taa.settings.restoreEID5519=true; taa.settings.liveEID5519=false;
                taa.settings.requireGameCamera=true; taa.settings.renderInSceneView=false;
                EditorUtility.SetDirty(taa); found=true;
            }
            if(!found)throw new Exception("TAA feature not found");
            EditorUtility.SetDirty(renderer); AssetDatabase.SaveAssets();
            File.AppendAllText(Folder+"validation.txt","\nPASS; installed Game-only, captured-motion mode.\n");
            Debug.Log("[EID5519] "+result);
        }
        catch(Exception e) { File.WriteAllText(Folder+"validation-error.txt",e.ToString()); Debug.LogException(e); throw; }
        finally { pass?.Dispose(); }
    }
    static Texture2D Import(int index, GraphicsFormat format)
    {
        string path=Root+"CapturedInputs/EID5519/input"+index+".asset";
        var existing=AssetDatabase.LoadAssetAtPath<Texture2D>(path);
        if(index==1 || index==3)format=GraphicsFormat.R8G8B8A8_UNorm;
        if(existing!=null && existing.graphicsFormat==format)return existing;
        var t=new Texture2D(1366,768,format,TextureCreationFlags.None) {name="EID5519_input"+index,filterMode=FilterMode.Point,wrapMode=TextureWrapMode.Clamp};
        t.LoadRawTextureData(File.ReadAllBytes(Root+"CapturedInputs/EID5519/input"+index+".bytes"));
        t.Apply(false,true); if(existing!=null) { EditorUtility.CopySerialized(t,existing); UnityEngine.Object.DestroyImmediate(t); EditorUtility.SetDirty(existing); return existing; } AssetDatabase.CreateAsset(t,path); return t;
    }
}
#endif
