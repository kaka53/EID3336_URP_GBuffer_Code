#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using EID4730;
public static class EID4789ColorAudit
{
 const string Dir=".rdctools/eid4789_verified";
 const string Scene="Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
 [Serializable] class Manifest { public Entry[] textures; }
 [Serializable] class Entry { public string name,format;public FileEntry[] files; }
 [Serializable] class FileEntry { public string file;public int mip,slice; }
 [MenuItem("Tools/EID4789/Audit Texture Bytes")]
 public static void TextureAudit(){
  var m=GameObject.Find("EID4789_Forward_for_EID1696").GetComponent<Renderer>().sharedMaterial;
  var manifest=JsonUtility.FromJson<Manifest>(File.ReadAllText(Dir+"/replay/replay.json"));var log=new StringBuilder();
  foreach(var e in manifest.textures){var t=m.GetTexture(e.name);log.AppendLine(e.name+" "+(t==null?"NULL":t.graphicsFormat.ToString())+" expected="+e.format);if(t is Texture3D t3 && t3.isReadable)File.WriteAllBytes(Dir+"/unity_"+e.name+".raw",t3.GetPixelData<byte>(0).ToArray());if(t is Texture2D t2 && t2.isReadable)File.WriteAllBytes(Dir+"/unity_"+e.name+".raw",t2.GetRawTextureData());}
  File.WriteAllText(Dir+"/texture_audit.txt",log.ToString());
 }
 public static void RepairVolumes(){
  var manifest=JsonUtility.FromJson<Manifest>(File.ReadAllText(Dir+"/replay/replay.json"));
  var decode=typeof(EID4789ReplaySession).GetMethod("ExpandB10G11",System.Reflection.BindingFlags.Static|System.Reflection.BindingFlags.NonPublic);
  var log=new StringBuilder();
  foreach(var e in manifest.textures){if(e.format!="B10G11R11_UFloatPack32")continue;
   var path="Assets/EID4789_RenderDocRestore/Textures/"+e.name+".asset";
   var texture=AssetDatabase.LoadAssetAtPath<Texture3D>(path);if(texture==null||texture.graphicsFormat!=UnityEngine.Experimental.Rendering.GraphicsFormat.R32G32B32A32_SFloat)throw new Exception("Unexpected volume format");
   byte[] bytes=(byte[])decode.Invoke(null,new object[]{File.ReadAllBytes(Dir+"/replay/"+e.files[0].file)});
   for(int i=0;i<bytes.Length;i+=4){float v=BitConverter.ToSingle(bytes,i);if(float.IsNaN(v)||float.IsInfinity(v))throw new Exception("Nonfinite decoded volume");}
   texture.SetPixelData(bytes,0);texture.Apply(false,false);EditorUtility.SetDirty(texture);AssetDatabase.SaveAssetIfDirty(texture);log.AppendLine(path+" repaired finite texels="+(bytes.Length/16));
  }
  File.WriteAllText(Dir+"/volume_repair.txt",log.ToString());TextureAudit();
 }
 public static void PipelineAudit(){
  var camera=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();var old=camera.targetTexture;var active=RenderTexture.active;
  var targets=new RenderTexture[6];for(int i=0;i<6;i++){targets[i]=new RenderTexture(1366,768,i==5?24:0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);targets[i].Create();}
  var log=new StringBuilder();log.AppendLine("auditVersion=2; stages copied without changing render targets; camera="+camera.name+" aspect="+camera.aspect+" target=1366x768");
  try {
   camera.targetTexture=targets[5];
   EID4730RenderFeature.CaptureEID4789ColorForDiagnostics=(cmd,rt)=>cmd.CopyTexture(rt.nameID,targets[1]);
   EID4730RenderFeature.CaptureCharacterColorForDiagnostics=(cmd,rt)=>cmd.CopyTexture(rt.nameID,targets[2]);
   EID5618PostProcessRendererFeature.CaptureInputsForDiagnostics=(cmd,a,b)=>{cmd.Blit(a,targets[3]);cmd.Blit(b,targets[4]);log.AppendLine("res9="+a.name+" res10="+b.name);};
   EID5618PostProcessRendererFeature.CaptureOutputForDiagnostics=(cmd,rt)=>cmd.CopyTexture(rt.nameID,targets[0]);
   camera.Render();camera.Render();for(int i=0;i<6;i++)Dump(targets[i],"pipeline_"+i);
   File.WriteAllText(Dir+"/pipeline_audit.txt",DateTime.Now.ToString("O")+"\n"+log);
  }finally{EID4730RenderFeature.CaptureEID4789ColorForDiagnostics=null;EID4730RenderFeature.CaptureCharacterColorForDiagnostics=null;EID5618PostProcessRendererFeature.CaptureInputsForDiagnostics=null;EID5618PostProcessRendererFeature.CaptureOutputForDiagnostics=null;camera.targetTexture=old;RenderTexture.active=active;foreach(var t in targets){t.Release();UnityEngine.Object.DestroyImmediate(t);}}
 }
 public static void Run()
 {
  var source=GameObject.Find("EID1696_instance_000"); if(source==null || source.scene.path!=Scene)throw new Exception("Expected loaded scene");
  var forward=GameObject.Find("EID4789_Forward_for_EID1696");if(forward==null)throw new Exception("Missing forward renderer");var child=forward.transform;
  var sr=source.GetComponent<Renderer>();var fr=child.GetComponent<Renderer>();var camera=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();
  TextureAudit();var old=camera.targetTexture;var active=RenderTexture.active;bool se=sr.enabled,fe=fr.enabled;
  var final=new RenderTexture(1366,768,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);final.Create();
  var stage=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);stage.Create();
  var log=new StringBuilder();log.AppendLine(DateTime.Now.ToString("O")+" "+SystemInfo.graphicsDeviceType+" linear="+QualitySettings.activeColorSpace);
  log.AppendLine("source="+sr.sharedMaterial.shader.name+" forward="+fr.sharedMaterial.shader.name+" sourceEnabled="+se+" childEnabled="+fe);
  try {
   camera.targetTexture=final;
   EID4730RenderFeature.CaptureEID4789ColorForDiagnostics=(cmd,rt)=>{cmd.CopyTexture(rt.nameID,stage);log.AppendLine("target="+rt.name+" format="+(rt.rt==null?"backbuffer":rt.rt.graphicsFormat.ToString()));};
   for(int mode=0;mode<3;mode++){
    sr.enabled=mode!=2;fr.enabled=mode!=1;
    camera.Render();camera.Render();
    Dump(stage,"audit_stage_"+mode);Dump(final,"audit_final_"+mode);
    log.AppendLine("mode="+mode+" source="+sr.enabled+" forward="+fr.enabled+" shaderError="+ShaderUtil.ShaderHasError(fr.sharedMaterial.shader));
   }
  } finally {
   EID4730RenderFeature.CaptureEID4789ColorForDiagnostics=null;sr.enabled=se;fr.enabled=fe;camera.targetTexture=old;RenderTexture.active=active;
   final.Release();stage.Release();UnityEngine.Object.DestroyImmediate(final);UnityEngine.Object.DestroyImmediate(stage);
   File.WriteAllText(Dir+"/color_audit.txt",log.ToString());SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();
  }
 }
 static void Dump(RenderTexture rt,string name){var prev=RenderTexture.active;var t=new Texture2D(rt.width,rt.height,TextureFormat.RGBAFloat,false,true);try{RenderTexture.active=rt;t.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0);t.Apply();File.WriteAllBytes(Dir+"/"+name+".f32",t.GetRawTextureData());}finally{RenderTexture.active=prev;UnityEngine.Object.DestroyImmediate(t);}}
 public static void SaveVerified(){var s=UnityEngine.SceneManagement.SceneManager.GetActiveScene();if(s.path!=Scene)throw new Exception("Wrong scene");var child=GameObject.Find("EID4789_Forward_for_EID1696");if(child==null||ShaderUtil.ShaderHasError(child.GetComponent<Renderer>().sharedMaterial.shader))throw new Exception("Forward missing or shader errors");if(!EditorSceneManager.SaveScene(s))throw new Exception("Save failed");File.WriteAllText(Dir+"/scene_saved.txt",DateTime.Now.ToString("O")+" "+s.path+" dirty="+s.isDirty);}
}
#endif
