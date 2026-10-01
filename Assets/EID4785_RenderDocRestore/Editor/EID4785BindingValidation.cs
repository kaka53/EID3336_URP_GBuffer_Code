#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using System.Reflection;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using EID4730;

public static class EID4785BindingValidation
{
    const string Dir=".rdctools/eid4785_verified/binding_fix0927";
    const string Scene="Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    public static void AuditLiveVolumes()
    {
        var log=new StringBuilder(DateTime.Now.ToString("O")+"\n");
        var mat=GameObject.Find("EID4785_instance_000").GetComponent<Renderer>().sharedMaterial;
        foreach(int slot in new[]{42,44,46})
        {
            string name="EID4785PS_"+slot;var texture=mat.GetTexture(name) as Texture3D;
            if(texture==null)throw new Exception("Missing "+name);
            byte[] data=texture.GetPixelData<byte>(0).ToArray();
            File.WriteAllBytes(Dir+"/live_"+name+".f32",data);
            int bad=0;for(int i=0;i<data.Length;i+=4){float x=BitConverter.ToSingle(data,i);if(float.IsInfinity(x)||float.IsNaN(x))bad++;}
            log.AppendLine(name+" format="+texture.graphicsFormat+" nonfinite="+bad+" path="+AssetDatabase.GetAssetPath(texture));
        }
        File.WriteAllText(Dir+"/live_volumes.txt",log.ToString());
    }
    public static void ProbeColorRecovery()
    {
        var go=GameObject.Find("EID4785_instance_000");var binder=go.GetComponent<EID4785ReplayBinder>();var mat=go.GetComponent<Renderer>().sharedMaterial;
        var camera=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();
        var log=new StringBuilder(DateTime.Now.ToString("O")+"\n");
        try
        {
            Capture(camera,binder,"probe_initial",log);
            binder.Rebind();Capture(camera,binder,"probe_explicit_rebind",log);
            foreach(int slot in new[]{42,44,46})((Texture3D)mat.GetTexture("EID4785PS_"+slot)).Apply(false,false);
            Capture(camera,binder,"probe_volume_reupload",log);
            foreach(int slot in new[]{42,44,46})mat.SetTexture("EID4785PS_"+slot,mat.GetTexture("EID4785PS_"+slot));
            Capture(camera,binder,"probe_texture_rebind",log);
        }
        finally{File.WriteAllText(Dir+"/probe.txt",log.ToString());SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();}
    }
    public static void Run()
    {
        Directory.CreateDirectory(Dir);
        var go=GameObject.Find("EID4785_instance_000");
        if(go==null||go.scene.path!=Scene||!go.activeInHierarchy)throw new Exception("Expected active object in current scene");
        var binder=go.GetComponent<EID4785ReplayBinder>();var renderer=go.GetComponent<Renderer>();var original=renderer.sharedMaterial;
        if(binder==null||!binder.isActiveAndEnabled||!renderer.enabled)throw new Exception("Expected active binder and renderer");
        var camera=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();var matrix=go.transform.localToWorldMatrix;
        var mesh=go.GetComponent<MeshFilter>().sharedMesh;var view=camera.worldToCameraMatrix;var projection=camera.projectionMatrix;
        var field=typeof(EID4785ReplayBinder).GetField("session",BindingFlags.Instance|BindingFlags.NonPublic);
        var log=new StringBuilder(DateTime.Now.ToString("O")+" device="+SystemInfo.graphicsDeviceType+"\n");
        Material temporary=null;
        try
        {
            Capture(camera,binder,"baseline",log);
            var first=(EID4785ReplaySession)field.GetValue(binder);if(first==null||!first.IsValid)throw new Exception("Missing baseline buffers");
            AssetDatabase.ImportAsset(AssetDatabase.GetAssetPath(original),ImportAssetOptions.ForceUpdate|ImportAssetOptions.ForceSynchronousImport);
            Capture(camera,binder,"material_reimport",log);
            if(!ReferenceEquals(first,field.GetValue(binder)))throw new Exception("Healthy session unnecessarily recreated");
            log.AppendLine("PASS material reimport recovered without OnEnable; session reused");
            temporary=new Material(original){name="EID4785 temporary binding regression",hideFlags=HideFlags.HideAndDontSave};renderer.sharedMaterial=temporary;
            Capture(camera,binder,"material_replacement",log);
            if(binder.material!=temporary)throw new Exception("Binder did not follow actual renderer material");
            if(!ReferenceEquals(first,field.GetValue(binder)))throw new Exception("Material change reallocated healthy buffers");
            log.AppendLine("PASS actual renderer material replacement bound automatically; session reused");
            first.Dispose();if(first.IsValid)throw new Exception("Disposed session still valid");
            Capture(camera,binder,"released_buffers",log);
            var recovered=(EID4785ReplaySession)field.GetValue(binder);
            if(recovered==null||!recovered.IsValid||ReferenceEquals(first,recovered))throw new Exception("Released buffers not recreated before draw");
            log.AppendLine("PASS released buffers automatically rebuilt without activation toggle");
            renderer.sharedMaterial=original;
            Capture(camera,binder,"restored_original",log);
            if(binder.material!=original||ShaderUtil.ShaderHasError(original.shader))throw new Exception("Original material/shader not restored");
            if(!go.activeInHierarchy||!binder.isActiveAndEnabled||!renderer.enabled||matrix!=go.transform.localToWorldMatrix||mesh!=go.GetComponent<MeshFilter>().sharedMesh||view!=camera.worldToCameraMatrix||projection!=camera.projectionMatrix)throw new Exception("Object or geometry/camera state changed");
            log.AppendLine("PASS no SetActive or Renderer.enabled changes; mesh/M/liveVP unchanged; shaderError=False; material restored");
            File.WriteAllText(Dir+"/result.txt","SUCCESS "+DateTime.Now.ToString("O"));
        }
        catch(Exception e){log.AppendLine("FAIL "+e);File.WriteAllText(Dir+"/result.txt","FAILED "+e);throw;}
        finally
        {
            renderer.sharedMaterial=original;
            if(binder.material!=original)binder.Rebind();
            if(temporary!=null)UnityEngine.Object.DestroyImmediate(temporary);
            File.WriteAllText(Dir+"/validation.txt",log.ToString());SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();
        }
    }
    static void Capture(Camera camera,EID4785ReplayBinder binder,string name,StringBuilder log)
    {
        var old=camera.targetTexture;var active=RenderTexture.active;
        var final=new RenderTexture(1366,768,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);final.Create();
        var stage=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);stage.Create();
        int hooks=0,binds=binder.SuccessfulDrawBindings;
        try
        {
            camera.targetTexture=final;
            EID4730RenderFeature.CaptureEID4785ColorForDiagnostics=(cmd,rt)=>{cmd.CopyTexture(rt.nameID,stage);hooks++;};
            camera.Render();camera.Render();
            if(hooks!=2||binder.SuccessfulDrawBindings<=binds)throw new Exception("Expected pre-draw binding on actual camera draw");
            var cpu=new Texture2D(1366,768,TextureFormat.RGBAFloat,false,true);
            try{RenderTexture.active=stage;cpu.ReadPixels(new Rect(0,0,1366,768),0,0);cpu.Apply();File.WriteAllBytes(Dir+"/"+name+".f32",cpu.GetRawTextureData());}
            finally{UnityEngine.Object.DestroyImmediate(cpu);}
            log.AppendLine("PASS "+name+" stageHooks="+hooks+" preDrawBindings="+(binder.SuccessfulDrawBindings-binds));
        }
        finally
        {
            EID4730RenderFeature.CaptureEID4785ColorForDiagnostics=null;camera.targetTexture=old;RenderTexture.active=active;
            final.Release();stage.Release();UnityEngine.Object.DestroyImmediate(final);UnityEngine.Object.DestroyImmediate(stage);
        }
    }
}
#endif