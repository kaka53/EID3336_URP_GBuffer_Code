#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using System.Reflection;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using EID4730;

[InitializeOnLoad]
public static class EID1687ColorRepair
{
 const string Dir=".rdctools/eid1687_verified";
 const string Root="Assets/EID4780_RenderDocRestore";
 const string Scene="Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
 [Serializable] class Manifest {public Entry[] textures;}
 [Serializable] class Entry {public string name,format;public FileEntry[] files;}
 [Serializable] class FileEntry {public string file,sha256;public int mip;}
 static double next;
 static EID1687ColorRepair(){EditorApplication.update+=Tick;}
 static void Tick(){if(Application.isBatchMode||EditorApplication.isCompiling||EditorApplication.isUpdating||EditorApplication.timeSinceStartup<next)return;next=EditorApplication.timeSinceStartup+1;string p=Dir+"/request.txt";if(!File.Exists(p))return;string action=File.ReadAllText(p).Trim();File.Delete(p);try{if(action=="repair")Run();else if(action=="audit_current")AuditCurrent();else if(action=="finalize")FinalizeRepair();else throw new Exception("Unknown action");File.WriteAllText(Dir+"/result.txt","SUCCESS "+action+" "+DateTime.Now.ToString("O"));}catch(Exception e){File.WriteAllText(Dir+"/result.txt","FAIL "+action+"\n"+e);Debug.LogException(e);}}
 static GameObject Find(string name){var g=GameObject.Find(name);if(g==null||g.scene.path!=Scene)throw new Exception("Expected current scene object "+name);return g;}
 public static void Run(){
  var source=Find("EID1687_instance_000");var forward=Find("EID4780_instance_000");var camera=Find("EID3336 RenderDoc Camera").GetComponent<Camera>();
  var sm=source.GetComponent<MeshFilter>().sharedMesh;var fm=forward.GetComponent<MeshFilter>().sharedMesh;var sr=source.GetComponent<Renderer>();var fr=forward.GetComponent<Renderer>();var material=fr.sharedMaterial;
  var sourceM=source.transform.localToWorldMatrix;var forwardM=forward.transform.localToWorldMatrix;var view=camera.worldToCameraMatrix;var projection=camera.projectionMatrix;
  if(sm.vertexCount!=508||fm.vertexCount!=508||sm.GetIndexCount(0)!=1932||fm.GetIndexCount(0)!=1932)throw new Exception("Geometry count mismatch");
  float posError=0;var a=sm.vertices;var b=fm.vertices;for(int i=0;i<a.Length;i++)posError=Mathf.Max(posError,Vector3.Distance(sourceM.MultiplyPoint3x4(a[i]),forwardM.MultiplyPoint3x4(b[i])));if(posError>0.0002f)throw new Exception("World geometry mismatch "+posError);
  var ia=sm.GetIndices(0);var ib=fm.GetIndices(0);for(int i=0;i<ia.Length;i++)if(ia[i]!=ib[i])throw new Exception("Index mismatch");
  var log=new StringBuilder(DateTime.Now.ToString("O")+" device="+SystemInfo.graphicsDeviceType+" worldPositionMaxError="+posError+"\n");
  log.AppendLine("source="+sr.sharedMaterial.name+" forward="+material.name+" sourceEnabled="+sr.enabled+" forwardEnabled="+fr.enabled+" M="+forwardM);
  try{
   Capture(camera,"before",log);CaptureGBuffer(camera,source,"before_source");CaptureGBuffer(camera,forward,"before_forward");
   var manifest=JsonUtility.FromJson<Manifest>(File.ReadAllText(Root+"/StreamingAssets/replay.json"));var decode=typeof(EID4780ReplaySession).GetMethod("ExpandB10G11",BindingFlags.Static|BindingFlags.NonPublic);
   foreach(var e in manifest.textures){if(e.format!="B10G11R11_UFloatPack32")continue;
    var path=Root+"/Textures/EID4780_"+e.name+".asset";var texture=AssetDatabase.LoadAssetAtPath<Texture3D>(path);
    if(texture==null||material.GetTexture(e.name)!=texture||texture.graphicsFormat!=UnityEngine.Experimental.Rendering.GraphicsFormat.R32G32B32A32_SFloat)throw new Exception("Unexpected volume "+path);
    File.WriteAllBytes(Dir+"/before_live"+e.name+".f32",texture.GetPixelData<byte>(0).ToArray());
    var raw=File.ReadAllBytes(Root+"/StreamingAssets/"+e.files[0].file);using(var sha=System.Security.Cryptography.SHA256.Create())if(BitConverter.ToString(sha.ComputeHash(raw)).Replace("-","").ToLowerInvariant()!=e.files[0].sha256)throw new Exception("Source hash mismatch");
    var data=(byte[])decode.Invoke(null,new object[]{raw});var expected=File.ReadAllBytes(Dir+"/"+e.name+".corrected.f32");if(data.Length!=expected.Length)throw new Exception("Data size mismatch");for(int i=0;i<data.Length;i++)if(data[i]!=expected[i])throw new Exception("Independent decode mismatch");
    texture.SetPixelData(data,0);texture.Apply(false,false);EditorUtility.SetDirty(texture);AssetDatabase.SaveAssetIfDirty(texture);File.WriteAllBytes(Dir+"/after_live"+e.name+".f32",texture.GetPixelData<byte>(0).ToArray());log.AppendLine("REPAIRED "+e.name+" exactIndependentDecode=True bytes="+data.Length);
   }
   Capture(camera,"volumes",log);
   var src=sr.sharedMaterial;const string prefix="_EID4780_GBuffer";
   material.SetTexture(prefix+"_Res27",src.GetTexture("_Res27"));for(int i=0;i<20;i++){string key="_P"+i.ToString("D2");material.SetVector(prefix+key,src.GetVector(key));}
   material.SetVector(prefix+"_InstancePacked",src.GetVector("_InstancePacked"));material.SetFloat(prefix+"_EID215446MipBias",src.GetFloat("_EID215446MipBias"));material.SetFloat(prefix+"_UseBakedSkinning",src.GetFloat("_UseBakedSkinning"));EditorUtility.SetDirty(material);AssetDatabase.SaveAssetIfDirty(material);
   log.AppendLine("GBuffer source=EID1687; texture="+AssetDatabase.GetAssetPath(material.GetTexture(prefix+"_Res27"))+" P12="+material.GetVector(prefix+"_P12")+" P13="+material.GetVector(prefix+"_P13"));
   Capture(camera,"params",log);CaptureGBuffer(camera,source,"params_source");CaptureGBuffer(camera,forward,"params_forward");
   if(sourceM!=source.transform.localToWorldMatrix||forwardM!=forward.transform.localToWorldMatrix||view!=camera.worldToCameraMatrix||projection!=camera.projectionMatrix)throw new Exception("Matrix changed");
   if(ShaderUtil.ShaderHasError(material.shader)||ShaderUtil.ShaderHasError(src.shader))throw new Exception("Shader errors");
   log.AppendLine("PASS geometry/M/liveVP preserved; source active="+source.activeInHierarchy+" forward active="+forward.activeInHierarchy+" shaderError=False");
  }finally{File.WriteAllText(Dir+"/unity_repair.txt",log.ToString());SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();}
 }
 public static void FinalizeRepair(){
  var source=Find("EID1687_instance_000");var forward=Find("EID4780_instance_000");var camera=Find("EID3336 RenderDoc Camera").GetComponent<Camera>();
  var src=source.GetComponent<Renderer>().sharedMaterial;var mat=forward.GetComponent<Renderer>().sharedMaterial;
  var sm=source.GetComponent<MeshFilter>().sharedMesh;var fm=forward.GetComponent<MeshFilter>().sharedMesh;var ms=source.transform.localToWorldMatrix;var mf=forward.transform.localToWorldMatrix;var view=camera.worldToCameraMatrix;var projection=camera.projectionMatrix;
  var log=new StringBuilder(DateTime.Now.ToString("O")+"\n");
  try{
   foreach(var shader in new[]{src.shader,mat.shader})foreach(var msg in ShaderUtil.GetShaderMessages(shader))log.AppendLine("BEFORE "+shader.name+" "+msg.severity+" "+msg.message+" "+msg.file+":"+msg.line);
   string shaderPath=Root+"/Shaders/EID1687_VerifiedGBuffer.shader";AssetDatabase.ImportAsset(shaderPath,ImportAssetOptions.ForceUpdate|ImportAssetOptions.ForceSynchronousImport);
   var corrected=AssetDatabase.LoadAssetAtPath<Shader>(shaderPath);if(corrected==null)throw new Exception("Missing isolated GBuffer shader");
   src.shader=corrected;EditorUtility.SetDirty(src);AssetDatabase.SaveAssetIfDirty(src);
   AssetDatabase.ImportAsset(Root+"/Shaders/EID4780_CharacterForward.shader",ImportAssetOptions.ForceUpdate|ImportAssetOptions.ForceSynchronousImport);
   Capture(camera,"corrected",log);CaptureGBuffer(camera,source,"corrected_source");CaptureGBuffer(camera,forward,"corrected_forward");
   foreach(var shader in new[]{src.shader,mat.shader}){
    foreach(var msg in ShaderUtil.GetShaderMessages(shader))log.AppendLine("AFTER "+shader.name+" "+msg.severity+" "+msg.message+" "+msg.file+":"+msg.line);
    log.AppendLine("shader="+shader.name+" supported="+shader.isSupported+" hasError="+ShaderUtil.ShaderHasError(shader));
   }
   if(ShaderUtil.ShaderHasError(src.shader)||ShaderUtil.ShaderHasError(mat.shader))throw new Exception("Shader error remains; see detailed messages");
   if(sm!=source.GetComponent<MeshFilter>().sharedMesh||fm!=forward.GetComponent<MeshFilter>().sharedMesh||ms!=source.transform.localToWorldMatrix||mf!=forward.transform.localToWorldMatrix||view!=camera.worldToCameraMatrix||projection!=camera.projectionMatrix)throw new Exception("Geometry or camera changed");
   var scene=source.scene;if(!EditorSceneManager.SaveScene(scene))throw new Exception("Scene save failed");
   log.AppendLine("PASS saved="+scene.path+" dirty="+scene.isDirty+" sourceActive="+source.activeInHierarchy+" forwardActive="+forward.activeInHierarchy+" mesh/M/liveVP unchanged");
  }finally{File.WriteAllText(Dir+"/finalize.txt",log.ToString());SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();}
 }
 public static void AuditCurrent(){var log=new StringBuilder(DateTime.Now.ToString("O")+"\n");var camera=Find("EID3336 RenderDoc Camera").GetComponent<Camera>();Capture(camera,"current",log);CaptureGBuffer(camera,Find("EID1687_instance_000"),"current_source");CaptureGBuffer(camera,Find("EID4780_instance_000"),"current_forward");File.WriteAllText(Dir+"/current_audit.txt",log.ToString());}
 static void Capture(Camera camera,string name,StringBuilder log){var old=camera.targetTexture;var active=RenderTexture.active;var final=new RenderTexture(1366,768,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);var stage=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);final.Create();stage.Create();int hits=0;try{camera.targetTexture=final;EID4730RenderFeature.CaptureEID4780ColorForDiagnostics=(cmd,rt)=>{cmd.CopyTexture(rt.nameID,stage);hits++;};camera.Render();camera.Render();if(hits!=2)throw new Exception("Expected two EID4780 stages; got "+hits);Dump(stage,name+"_stage");Dump(final,name+"_final");log.AppendLine(name+" hooks="+hits+" 1366x768 linear float");}finally{EID4730RenderFeature.CaptureEID4780ColorForDiagnostics=null;camera.targetTexture=old;RenderTexture.active=active;final.Release();stage.Release();UnityEngine.Object.DestroyImmediate(final);UnityEngine.Object.DestroyImmediate(stage);}}
 static void CaptureGBuffer(Camera camera,GameObject obj,string prefix){var colors=new RenderTexture[5];var ids=new RenderTargetIdentifier[5];var depth=new RenderTexture(1366,768,24,RenderTextureFormat.Depth);depth.Create();for(int i=0;i<5;i++){colors[i]=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);colors[i].Create();ids[i]=colors[i];}var cmd=new CommandBuffer{name="EID1687 isolated GBuffer audit"};try{var mat=obj.GetComponent<Renderer>().sharedMaterial;int pass=mat.FindPass("VS215445_PS215446_UniversalGBuffer");if(pass<0)throw new Exception("Missing GBuffer pass");cmd.SetViewProjectionMatrices(camera.worldToCameraMatrix,camera.projectionMatrix);cmd.SetGlobalMatrix("unity_MatrixVP",GL.GetGPUProjectionMatrix(camera.projectionMatrix,true)*camera.worldToCameraMatrix);cmd.SetGlobalVector("_WorldSpaceCameraPos",camera.transform.position);cmd.SetRenderTarget(ids,depth);cmd.ClearRenderTarget(true,true,new Color(-10,-10,-10,-10));cmd.DrawMesh(obj.GetComponent<MeshFilter>().sharedMesh,obj.transform.localToWorldMatrix,mat,0,pass);Graphics.ExecuteCommandBuffer(cmd);Dump(colors[3],prefix+"_gb3");Dump(colors[4],prefix+"_gb4");}finally{cmd.Release();foreach(var t in colors){t.Release();UnityEngine.Object.DestroyImmediate(t);}depth.Release();UnityEngine.Object.DestroyImmediate(depth);}}
 static void Dump(RenderTexture rt,string name){var old=RenderTexture.active;var cpu=new Texture2D(rt.width,rt.height,TextureFormat.RGBAFloat,false,true);try{RenderTexture.active=rt;cpu.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0);cpu.Apply();File.WriteAllBytes(Dir+"/"+name+".f32",cpu.GetRawTextureData());}finally{RenderTexture.active=old;UnityEngine.Object.DestroyImmediate(cpu);}}
}
#endif