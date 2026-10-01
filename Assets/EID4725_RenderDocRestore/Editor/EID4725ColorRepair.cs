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
public static class EID4725ColorRepair
{
    const string Root="Assets/EID4725_RenderDocRestore";
    const string Dir=".rdctools/eid4725_color0927";
    const string Scene="Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    static double next;
    [Serializable] class Manifest { public Entry[] textures; }
    [Serializable] class Entry { public string name,format; public FileEntry[] files; }
    [Serializable] class FileEntry { public string file,sha256; public int mip,slice; }
    static EID4725ColorRepair(){EditorApplication.update+=Tick;}
    static void Tick(){
        if(Application.isBatchMode||EditorApplication.isCompiling||EditorApplication.isUpdating||EditorApplication.timeSinceStartup<next)return;
        next=EditorApplication.timeSinceStartup+1;string p=Dir+"/request.txt";if(!File.Exists(p))return;
        string request=File.ReadAllText(p).Trim();File.Delete(p);
        try { if(request=="repair_verify")Run();else if(request=="audit_current")AuditCurrent();else throw new Exception("Unknown request"); File.WriteAllText(Dir+"/result.txt","SUCCESS "+request+" "+DateTime.Now.ToString("O")); }
        catch(Exception e){File.WriteAllText(Dir+"/result.txt","FAILED "+DateTime.Now.ToString("O")+"\n"+e);Debug.LogException(e);}
    }
    [MenuItem("Tools/EID4725/Repair And Verify Captured Volume Colors")]
    public static void Run(){
        var scene=UnityEngine.SceneManagement.SceneManager.GetActiveScene();if(scene.path!=Scene)throw new Exception("Expected current scene, will not reopen");
        var obj=GameObject.Find("EID4725_instance_000");if(obj==null||obj.scene!=scene)throw new Exception("Missing EID4725 instance");
        var mesh=obj.GetComponent<MeshFilter>().sharedMesh;var renderer=obj.GetComponent<Renderer>();var mat=renderer.sharedMaterial;
        if(mesh.vertexCount!=1701||mesh.GetIndexCount(0)!=8460)throw new Exception("Unexpected geometry");
        if(mat!=AssetDatabase.LoadAssetAtPath<Material>(Root+"/M_EID4725.mat"))throw new Exception("Unexpected material binding");
        if(mat.shader==null||ShaderUtil.ShaderHasError(mat.shader))throw new Exception("Shader invalid");
        var camera=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();
        var log=new StringBuilder(DateTime.Now.ToString("O")+" device="+SystemInfo.graphicsDeviceType+" colorSpace="+QualitySettings.activeColorSpace+"\n");
        var matrix=obj.transform.localToWorldMatrix;var view=camera.worldToCameraMatrix;var projection=camera.projectionMatrix;
        log.AppendLine("object="+obj.name+" material="+mat.name+" shader="+mat.shader.name+" queue="+mat.renderQueue+" mesh="+mesh.vertexCount+" indices="+mesh.GetIndexCount(0)+" M="+matrix);
        var manifest=JsonUtility.FromJson<Manifest>(File.ReadAllText("Assets/StreamingAssets/EID4725Replay/replay.json"));
        DumpTextures(mat,manifest,"before",log);
        Capture(camera,"before",log);CaptureGBuffer(camera,obj,"before_gbuffer");
        var decode=typeof(EID4725ReplaySession).GetMethod("ExpandB10G11",System.Reflection.BindingFlags.Static|System.Reflection.BindingFlags.NonPublic);
        foreach(var e in manifest.textures){
            if(e.format!="B10G11R11_UFloatPack32")continue;
            var t=AssetDatabase.LoadAssetAtPath<Texture3D>(Root+"/Textures/"+e.name+".asset");
            if(t==null||mat.GetTexture(e.name)!=t||t.graphicsFormat!=UnityEngine.Experimental.Rendering.GraphicsFormat.R32G32B32A32_SFloat)throw new Exception("Unexpected volume "+e.name);
            var source=File.ReadAllBytes("Assets/StreamingAssets/EID4725Replay/"+e.files[0].file);
            using(var sha=System.Security.Cryptography.SHA256.Create())if(BitConverter.ToString(sha.ComputeHash(source)).Replace("-","").ToLowerInvariant()!=e.files[0].sha256)throw new Exception("Source hash mismatch");
            var data=(byte[])decode.Invoke(null,new object[]{source});var expected=File.ReadAllBytes(Dir+"/"+e.name+".corrected.f32");
            if(data.Length!=expected.Length)throw new Exception("Decoded length mismatch");
            for(int i=0;i<data.Length;i++)if(data[i]!=expected[i])throw new Exception("Independent decoder mismatch "+e.name+" byte "+i);
            for(int i=0;i<data.Length;i+=4){float v=BitConverter.ToSingle(data,i);if(float.IsNaN(v)||float.IsInfinity(v))throw new Exception("Nonfinite decoded volume");}
            t.SetPixelData(data,0);t.Apply(false,false);EditorUtility.SetDirty(t);AssetDatabase.SaveAssetIfDirty(t);
            log.AppendLine("REPAIRED "+e.name+" finiteTexels="+(data.Length/16)+" independentDecoderExact=True");
        }
        DumpTextures(mat,manifest,"after",log);
        var binder=obj.GetComponent<EID4725ReplayBinder>();if(binder!=null)binder.Rebind();
        Capture(camera,"after",log);CaptureGBuffer(camera,obj,"after_gbuffer");
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
        var stage=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);stage.Create();int hits=0;RenderTexture depthCopy=null;
        try{camera.targetTexture=final;
            EID4730RenderFeature.CaptureEID4725DepthForDiagnostics=(cmd,rt)=>{if(depthCopy==null){depthCopy=new RenderTexture(rt.rt.descriptor);depthCopy.Create();log.AppendLine("depth="+rt.rt.descriptor.depthStencilFormat+" samples="+rt.rt.antiAliasing);}cmd.CopyTexture(rt.nameID,depthCopy);};
            EID4730RenderFeature.CaptureEID4725ColorForDiagnostics=(cmd,rt)=>{cmd.CopyTexture(rt.nameID,stage);hits++;};
            camera.Render();camera.Render();if(hits<2)throw new Exception("EID4725 stage not rendered");
            Dump(stage,prefix+"_stage");Dump(final,prefix+"_final");if(depthCopy!=null)DumpDepth(depthCopy,prefix+"_depth");log.AppendLine(prefix+" stageCaptureHits="+hits+" camera="+camera.name+" size=1366x768");
        }finally{EID4730RenderFeature.CaptureEID4725DepthForDiagnostics=null;if(depthCopy!=null){depthCopy.Release();UnityEngine.Object.DestroyImmediate(depthCopy);}EID4730RenderFeature.CaptureEID4725ColorForDiagnostics=null;camera.targetTexture=old;RenderTexture.active=active;final.Release();stage.Release();UnityEngine.Object.DestroyImmediate(final);UnityEngine.Object.DestroyImmediate(stage);}
    }
 static void CaptureGBuffer(Camera camera,GameObject obj,string prefix){var colors=new RenderTexture[5];var ids=new RenderTargetIdentifier[5];var depth=new RenderTexture(1366,768,24,RenderTextureFormat.Depth);depth.Create();for(int i=0;i<5;i++){colors[i]=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);colors[i].Create();ids[i]=colors[i];}var cmd=new CommandBuffer{name="EID4725 isolated GBuffer audit"};var oldTarget=camera.targetTexture;try{camera.targetTexture=colors[0];EID4725ReplayBinder.PrepareActiveForDraw();var mat=obj.GetComponent<Renderer>().sharedMaterial;int pass=mat.FindPass("VS215445_PS215446_UniversalGBuffer");if(pass<0)throw new Exception("Missing GBuffer pass");cmd.SetViewProjectionMatrices(camera.worldToCameraMatrix,camera.projectionMatrix);cmd.SetGlobalMatrix("unity_MatrixVP",GL.GetGPUProjectionMatrix(camera.projectionMatrix,true)*camera.worldToCameraMatrix);cmd.SetGlobalVector("_WorldSpaceCameraPos",camera.transform.position);cmd.SetRenderTarget(ids,depth);cmd.ClearRenderTarget(true,true,new Color(-10,-10,-10,-10));cmd.DrawMesh(obj.GetComponent<MeshFilter>().sharedMesh,obj.transform.localToWorldMatrix,mat,0,pass);Graphics.ExecuteCommandBuffer(cmd);Dump(colors[3],prefix+"_gb3");Dump(colors[4],prefix+"_gb4");DumpDepth(depth,prefix+"_depth");}finally{camera.targetTexture=oldTarget;cmd.Release();foreach(var t in colors){t.Release();UnityEngine.Object.DestroyImmediate(t);}depth.Release();UnityEngine.Object.DestroyImmediate(depth);}}

    public static void BatchRepair(){Batch(false);}
    public static void BatchAudit(){Batch(true);}
    static void Batch(bool audit){
        try {
            if(SystemInfo.graphicsDeviceType==GraphicsDeviceType.Null)throw new Exception("Real GPU required");
            EditorSceneManager.OpenScene(Scene,OpenSceneMode.Single);
            if(audit)AuditCurrent();else Run();
            File.WriteAllText(Dir+(audit?"/batch_audit.txt":"/batch_repair.txt"),"SUCCESS "+DateTime.Now.ToString("O"));
        }catch(Exception e){File.WriteAllText(Dir+(audit?"/batch_audit.txt":"/batch_repair.txt"),"FAIL "+e);Debug.LogException(e);EditorApplication.Exit(1);}
    }
    public static void AuditCurrent(){
        var obj=GameObject.Find("EID4725_instance_000");if(obj==null||obj.scene.path!=Scene)throw new Exception("Expected current scene");
        var camera=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();var log=new StringBuilder(DateTime.Now.ToString("O")+"\n");
        var mesh=obj.GetComponent<MeshFilter>().sharedMesh;
        var matrix=obj.transform.localToWorldMatrix;var view=camera.worldToCameraMatrix;var projection=camera.projectionMatrix;
        if(mesh.vertexCount!=1701||mesh.GetIndexCount(0)!=8460)throw new Exception("Unexpected geometry");
        Capture(camera,"current",log);CaptureGBuffer(camera,obj,"current_gbuffer");
        if(obj.transform.localToWorldMatrix!=matrix||obj.GetComponent<MeshFilter>().sharedMesh!=mesh||camera.worldToCameraMatrix!=view||camera.projectionMatrix!=projection)throw new Exception("Geometry or camera changed");
        log.AppendLine("mesh="+mesh.vertexCount+" indices="+mesh.GetIndexCount(0)+" M="+matrix+" live camera unchanged");
        log.AppendLine("source EID1637 active="+(GameObject.Find("EID1637_instance_000")!=null));
        var mat=obj.GetComponent<Renderer>().sharedMaterial;foreach(var msg in ShaderUtil.GetShaderMessages(mat.shader))log.AppendLine(msg.severity+" "+msg.message);
        if(ShaderUtil.ShaderHasError(mat.shader))throw new Exception("Shader errors");
        if(!EditorSceneManager.SaveScene(obj.scene))throw new Exception("Save failed");
        log.AppendLine("PASS shaderError=False saved="+obj.scene.path+" dirty="+obj.scene.isDirty);
        File.WriteAllText(Dir+"/current_audit.txt",log.ToString());SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();
    }
    static void DumpDepth(RenderTexture depth,string name){
        var shader=AssetDatabase.LoadAssetAtPath<Shader>(Root+"/Editor/EID4725DiagnosticDepth.shader");
        if(shader==null||ShaderUtil.ShaderHasError(shader))throw new Exception("Depth diagnostic shader invalid");
        var mat=new Material(shader);var rt=new RenderTexture(depth.width,depth.height,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);rt.Create();
        var cmd=new CommandBuffer{name="EID4725 read-only depth diagnostic"};
        try{cmd.SetGlobalTexture("_EID4725DiagnosticDepth",depth);cmd.SetRenderTarget(rt);cmd.DrawProcedural(Matrix4x4.identity,mat,0,MeshTopology.Triangles,3,1);Graphics.ExecuteCommandBuffer(cmd);Dump(rt,name);}
        finally{cmd.Release();rt.Release();UnityEngine.Object.DestroyImmediate(rt);UnityEngine.Object.DestroyImmediate(mat);}
    }
    static void Dump(RenderTexture rt,string name){var previous=RenderTexture.active;var cpu=new Texture2D(rt.width,rt.height,TextureFormat.RGBAFloat,false,true);
        try{RenderTexture.active=rt;cpu.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0);cpu.Apply();File.WriteAllBytes(Dir+"/"+name+".f32",cpu.GetRawTextureData());}
        finally{RenderTexture.active=previous;UnityEngine.Object.DestroyImmediate(cpu);}}
}
#endif