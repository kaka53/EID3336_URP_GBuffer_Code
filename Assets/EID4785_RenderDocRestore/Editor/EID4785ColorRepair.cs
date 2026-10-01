#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using EID4730;

[InitializeOnLoad]
public static class EID4785ColorRepair
{
    const string Root="Assets/EID4785_RenderDocRestore";
    const string Dir=".rdctools/eid4785_verified/color_fix0927";
    const string Scene="Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    static double next;
    [Serializable] class Manifest { public Entry[] textures; }
    [Serializable] class Entry { public string name,format; public FileEntry[] files; }
    [Serializable] class FileEntry { public string file,sha256; public int mip,slice; }
    static EID4785ColorRepair(){EditorApplication.update+=Tick;}
    static void Tick(){
        if(Application.isBatchMode||EditorApplication.isCompiling||EditorApplication.isUpdating||EditorApplication.timeSinceStartup<next)return;
        next=EditorApplication.timeSinceStartup+1;string p=Dir+"/request.txt";if(!File.Exists(p))return;
        string request=File.ReadAllText(p).Trim();File.Delete(p);
        try { if(request=="probe_binding_color")EID4785BindingValidation.ProbeColorRecovery();else if(request=="audit_live_volumes")EID4785BindingValidation.AuditLiveVolumes();else if(request=="validate_bindings")EID4785BindingValidation.Run();else if(request=="repair_verify")Run();else throw new Exception("Unknown request"); File.WriteAllText(Dir+"/result.txt","SUCCESS "+DateTime.Now.ToString("O")); }
        catch(Exception e){File.WriteAllText(Dir+"/result.txt","FAILED "+DateTime.Now.ToString("O")+"\n"+e);Debug.LogException(e);}
    }
    [MenuItem("Tools/EID4785/Repair And Verify Captured Volume Colors")]
    public static void Run(){
        var scene=UnityEngine.SceneManagement.SceneManager.GetActiveScene();if(scene.path!=Scene)throw new Exception("Expected current scene, will not reopen");
        var obj=GameObject.Find("EID4785_instance_000");if(obj==null||obj.scene!=scene)throw new Exception("Missing EID4785 instance");
        var mesh=obj.GetComponent<MeshFilter>().sharedMesh;var renderer=obj.GetComponent<Renderer>();var mat=renderer.sharedMaterial;
        if(mesh.vertexCount!=10035||mesh.GetIndexCount(0)!=34362)throw new Exception("Unexpected geometry");
        if(mat!=AssetDatabase.LoadAssetAtPath<Material>(Root+"/M_EID4785.mat"))throw new Exception("Unexpected material binding");
        if(mat.shader==null||ShaderUtil.ShaderHasError(mat.shader))throw new Exception("Shader invalid");
        var camera=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();
        var log=new StringBuilder(DateTime.Now.ToString("O")+" device="+SystemInfo.graphicsDeviceType+" colorSpace="+QualitySettings.activeColorSpace+"\n");
        var matrix=obj.transform.localToWorldMatrix;var view=camera.worldToCameraMatrix;var projection=camera.projectionMatrix;
        log.AppendLine("object="+obj.name+" material="+mat.name+" shader="+mat.shader.name+" queue="+mat.renderQueue+" mesh="+mesh.vertexCount+" indices="+mesh.GetIndexCount(0)+" M="+matrix);
        var manifest=JsonUtility.FromJson<Manifest>(File.ReadAllText("Assets/StreamingAssets/EID4785Replay/replay.json"));
        DumpTextures(mat,manifest,"before",log);
        Capture(camera,"before",log);
        var decode=typeof(EID4785ReplaySession).GetMethod("ExpandB10G11",System.Reflection.BindingFlags.Static|System.Reflection.BindingFlags.NonPublic);
        foreach(var e in manifest.textures){
            if(e.format!="B10G11R11_UFloatPack32")continue;
            var t=AssetDatabase.LoadAssetAtPath<Texture3D>(Root+"/Textures/"+e.name+".asset");
            if(t==null||mat.GetTexture(e.name)!=t||t.graphicsFormat!=UnityEngine.Experimental.Rendering.GraphicsFormat.R32G32B32A32_SFloat)throw new Exception("Unexpected volume "+e.name);
            var source=File.ReadAllBytes("Assets/StreamingAssets/EID4785Replay/"+e.files[0].file);
            using(var sha=System.Security.Cryptography.SHA256.Create())if(BitConverter.ToString(sha.ComputeHash(source)).Replace("-","").ToLowerInvariant()!=e.files[0].sha256)throw new Exception("Source hash mismatch");
            var data=(byte[])decode.Invoke(null,new object[]{source});var expected=File.ReadAllBytes(Dir+"/"+e.name+".corrected.f32");
            if(data.Length!=expected.Length)throw new Exception("Decoded length mismatch");
            for(int i=0;i<data.Length;i++)if(data[i]!=expected[i])throw new Exception("Independent decoder mismatch "+e.name+" byte "+i);
            for(int i=0;i<data.Length;i+=4){float v=BitConverter.ToSingle(data,i);if(float.IsNaN(v)||float.IsInfinity(v))throw new Exception("Nonfinite decoded volume");}
            t.SetPixelData(data,0);t.Apply(false,false);EditorUtility.SetDirty(t);AssetDatabase.SaveAssetIfDirty(t);
            log.AppendLine("REPAIRED "+e.name+" finiteTexels="+(data.Length/16)+" independentDecoderExact=True");
        }
        DumpTextures(mat,manifest,"after",log);
        var binder=obj.GetComponent<EID4785ReplayBinder>();if(binder!=null)binder.Rebind();
        Capture(camera,"after",log);
        if(obj.transform.localToWorldMatrix!=matrix||obj.GetComponent<MeshFilter>().sharedMesh!=mesh||camera.worldToCameraMatrix!=view||camera.projectionMatrix!=projection)throw new Exception("Geometry or camera changed");
        if(ShaderUtil.ShaderHasError(mat.shader))throw new Exception("Shader error after repair");
        if(!EditorSceneManager.SaveScene(scene))throw new Exception("Scene save failed");
        log.AppendLine("PASS mesh/M/camera unchanged; shaderError=False; saved="+scene.path+" dirty="+scene.isDirty);
        File.WriteAllText(Dir+"/unity_audit.txt",log.ToString());SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();
    }
    static void DumpTextures(Material mat,Manifest manifest,string prefix,StringBuilder log){
        foreach(var e in manifest.textures){var t=mat.GetTexture(e.name);if(t==null)throw new Exception("Missing texture "+e.name);
            log.AppendLine(prefix+" "+e.name+" "+t.graphicsFormat+" asset="+AssetDatabase.GetAssetPath(t));
            if(t is Texture3D volume&&volume.isReadable)File.WriteAllBytes(Dir+"/"+prefix+"_"+e.name+".raw",volume.GetPixelData<byte>(0).ToArray());
            if(t is Texture2D image&&image.isReadable)File.WriteAllBytes(Dir+"/"+prefix+"_"+e.name+".raw",image.GetRawTextureData());
        }
    }
    static void Capture(Camera camera,string prefix,StringBuilder log){
        var old=camera.targetTexture;var active=RenderTexture.active;
        var final=new RenderTexture(1366,768,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);final.Create();
        var stage=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);stage.Create();int hits=0;
        try{camera.targetTexture=final;EID4730RenderFeature.CaptureEID4785ColorForDiagnostics=(cmd,rt)=>{cmd.CopyTexture(rt.nameID,stage);hits++;};
            camera.Render();camera.Render();if(hits<2)throw new Exception("EID4785 stage not rendered");
            Dump(stage,prefix+"_stage");Dump(final,prefix+"_final");log.AppendLine(prefix+" stageCaptureHits="+hits+" camera="+camera.name+" size=1366x768");
        }finally{EID4730RenderFeature.CaptureEID4785ColorForDiagnostics=null;camera.targetTexture=old;RenderTexture.active=active;final.Release();stage.Release();UnityEngine.Object.DestroyImmediate(final);UnityEngine.Object.DestroyImmediate(stage);}
    }
    static void Dump(RenderTexture rt,string name){var previous=RenderTexture.active;var cpu=new Texture2D(rt.width,rt.height,TextureFormat.RGBAFloat,false,true);
        try{RenderTexture.active=rt;cpu.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0);cpu.Apply();File.WriteAllBytes(Dir+"/"+name+".f32",cpu.GetRawTextureData());}
        finally{RenderTexture.active=previous;UnityEngine.Object.DestroyImmediate(cpu);}}
}
#endif