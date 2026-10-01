#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEditor;
using UnityEditor.SceneManagement;
using EID4730;
public static class EID4725OcclusionAudit {
 const string Dir=".rdctools/eid4725_color0927";
 const string Scene="Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
 static readonly Vector2Int[] Pixels={new Vector2Int(926,369),new Vector2Int(924,370),new Vector2Int(933,371),new Vector2Int(934,372),new Vector2Int(922,374),new Vector2Int(924,374),new Vector2Int(919,375),new Vector2Int(921,375),new Vector2Int(923,376),new Vector2Int(920,379)};
 public static void Batch(){
  var log=new StringBuilder();RenderTexture final=null,stage=null;Texture2D cpu=null;Camera cam=null;RenderTexture old=null;
  try{
   EditorSceneManager.OpenScene(Scene,OpenSceneMode.Single);
   var face=GameObject.Find("EID4725_instance_000").GetComponent<Renderer>();
   cam=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();old=cam.targetTexture;
   final=new RenderTexture(1366,768,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);final.Create();
   stage=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);stage.Create();
   cpu=new Texture2D(1366,768,TextureFormat.RGBAFloat,false,true);
   cam.targetTexture=final;EID4730RenderFeature.CaptureEID4725ColorForDiagnostics=(cmd,rt)=>cmd.CopyTexture(rt.nameID,stage);
   cam.Render();cam.Render();Read(stage,cpu);log.AppendLine("baseline "+Samples(cpu));
   var candidates=new List<Renderer>();
   foreach(var r in UnityEngine.Object.FindObjectsOfType<Renderer>()){
    if(r==face||!r.enabled||!r.gameObject.activeInHierarchy)continue;
    if(Vector3.Distance(r.transform.position,face.transform.position)<3f)candidates.Add(r);
   }
   log.AppendLine("candidates="+candidates.Count);
   foreach(var r in candidates){
    string path=r.name;for(var p=r.transform.parent;p!=null;p=p.parent)path=p.name+"/"+path;
    string desc=path+" material="+(r.sharedMaterial?r.sharedMaterial.name:"NULL")+" shader="+(r.sharedMaterial&&r.sharedMaterial.shader?r.sharedMaterial.shader.name:"NULL");
    try{r.enabled=false;cam.Render();Read(stage,cpu);log.AppendLine(desc+" => "+Samples(cpu));}
    finally{r.enabled=true;}
    File.WriteAllText(Dir+"/occluder_audit.txt",log.ToString());
   }
   log.AppendLine("PASS all renderer states restored; scene NOT saved by occlusion audit.");
   File.WriteAllText(Dir+"/occluder_audit.txt",log.ToString());
  }catch(Exception e){File.WriteAllText(Dir+"/occluder_audit_failed.txt",e.ToString());Debug.LogException(e);EditorApplication.Exit(1);}
  finally{
   EID4730RenderFeature.CaptureEID4725ColorForDiagnostics=null;
   if(cam)cam.targetTexture=old;
   if(final){final.Release();UnityEngine.Object.DestroyImmediate(final);}if(stage){stage.Release();UnityEngine.Object.DestroyImmediate(stage);}if(cpu)UnityEngine.Object.DestroyImmediate(cpu);
  }
 }
 static void Read(RenderTexture rt,Texture2D cpu){var old=RenderTexture.active;try{RenderTexture.active=rt;cpu.ReadPixels(new Rect(0,0,1366,768),0,0);cpu.Apply();}finally{RenderTexture.active=old;}}
 static string Samples(Texture2D cpu){var s=new StringBuilder();int lit=0;foreach(var p in Pixels){var c=cpu.GetPixel(p.x,p.y);if(c.maxColorComponent>.1f&&Mathf.Max(c.r,Mathf.Max(c.g,c.b))>.1f)lit++;s.AppendFormat(System.Globalization.CultureInfo.InvariantCulture," ({0:F3},{1:F3},{2:F3})",c.r,c.g,c.b);}return "lit="+lit+s;}
}
#endif
