using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using EID4730;

// Offline capture validation only: does not switch, save, or rebuild scenes.
[InitializeOnLoad]
public static class EID1672ColorRepair
{
 const string Dir=".rdctools/eid1672_colorfix";
 const string Scene="Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
 const string SkinMaterial="Assets/ColourPass6_VS215441_PS215442_Batch/Materials/EID1672_VS215441_PS215442.mat";
 const string CutoutMaterial="Assets/ColourPass6_VS215452_PS215453_Batch/Materials/EID1721_VS215452_PS215453.mat";
 static double next;
 static EID1672ColorRepair(){EditorApplication.update+=Tick;}
 static void Tick(){
  if(EditorApplication.isCompiling||EditorApplication.isUpdating||EditorApplication.timeSinceStartup<next)return;
  next=EditorApplication.timeSinceStartup+1;string request=Dir+"/request.txt";if(!File.Exists(request))return;
  string action=File.ReadAllText(request).Trim();File.Delete(request);
  try{if(action=="install")Install();else if(action=="validate")Validate();else if(action=="refresh")AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);else throw new Exception("Unknown action: "+action);File.WriteAllText(Dir+"/result.txt","SUCCESS "+action);}
  catch(Exception e){File.WriteAllText(Dir+"/result.txt","FAIL "+e);Debug.LogException(e);}
 }
 static Shader LoadShader(string path){var shader=AssetDatabase.LoadAssetAtPath<Shader>(path);if(shader==null||ShaderUtil.ShaderHasError(shader))throw new Exception("Missing or invalid shader: "+path);return shader;}
 static void Install(){
  var skin=AssetDatabase.LoadAssetAtPath<Material>(SkinMaterial);var cutout=AssetDatabase.LoadAssetAtPath<Material>(CutoutMaterial);
  var shader=LoadShader("Assets/EID1672_ColorFix/Shaders/EID1672.shader");var cutoutShader=LoadShader("Assets/EID1672_ColorFix/Shaders/EID1721Cutout.shader");
  var lut=AssetDatabase.LoadAssetAtPath<Texture2D>("Assets/EID1672_ColorFix/ColorLUT_sRGB.asset");
  if(skin==null||cutout==null||lut==null)throw new Exception("Missing repair assets");
  Undo.RecordObjects(new UnityEngine.Object[]{skin,cutout},"Repair EID1672 capture color and EID1721 cutout coverage");
  var ramp=AssetDatabase.LoadAssetAtPath<Texture2D>("Assets/EID1672_ColorFix/LightingRamp_RGBA8.asset");
  var face=AssetDatabase.LoadAssetAtPath<Texture2D>("Assets/EID1672_ColorFix/FaceShadow_RGBA8.asset");
  if(ramp==null||face==null)throw new Exception("Missing captured ramp/face-shadow textures");
  skin.shader=shader;skin.SetTexture("FS4765_50",ramp);skin.SetTexture("FS4765_60",face);skin.SetTexture("FS4765_53",lut);cutout.shader=cutoutShader;
  EditorUtility.SetDirty(skin);EditorUtility.SetDirty(cutout);AssetDatabase.SaveAssetIfDirty(skin);AssetDatabase.SaveAssetIfDirty(cutout);
  SceneView.RepaintAll();
 }
 [MenuItem("Tools/RenderDoc/Validate EID1672 Color Repair")]
 public static void Validate(){
  Directory.CreateDirectory(Dir);var scene=UnityEngine.SceneManagement.SceneManager.GetActiveScene();if(scene.path!=Scene)throw new Exception("Open the target scene first; validation never switches scenes");
  bool dirty=scene.isDirty;var obj=GameObject.Find("EID1672_instance_000");var mat=obj.GetComponent<Renderer>().sharedMaterial;
  if(mat==null||mat.shader.name!="EID/URP/EID1672_Verified")throw new Exception("EID1672 repair material is not installed");
  var occluder=GameObject.Find("EID1721_instance_000").GetComponent<Renderer>().sharedMaterial;
  if(occluder.shader.name!="EID/URP/EID1721_CutoutDepthEqual")throw new Exception("Cutout coverage repair is not installed");
  if(ShaderUtil.ShaderHasError(mat.shader)||ShaderUtil.ShaderHasError(occluder.shader))throw new Exception("Shader compilation error");
  if(!mat.GetShaderPassEnabled("EID4730CharacterForward")||!occluder.GetShaderPassEnabled("EID4730CharacterForward"))throw new Exception("A forward pass was disabled");
  var camera=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();int projectionMode=new SerializedObject(camera).FindProperty("m_projectionMatrixMode").intValue;float aspect=camera.aspect;var projection=camera.projectionMatrix;var matrix=obj.transform.localToWorldMatrix;var view=camera.worldToCameraMatrix;var mesh=obj.GetComponent<MeshFilter>().sharedMesh;var log=new StringBuilder();
  try{camera.aspect=1366f/768f;Capture(camera,obj,mat,"installed");CaptureStage(camera,"installed",log);
   log.AppendLine("PASS device="+SystemInfo.graphicsDeviceType+"; shader errors=0; skin and cutout forward passes enabled");
   log.AppendLine("LUT format="+mat.GetTexture("FS4765_53").graphicsFormat);
   foreach(string key in new[]{"FS4765_50","FS4765_60"}){
    var tex=mat.GetTexture(key);if(tex==null||tex.graphicsFormat!=UnityEngine.Experimental.Rendering.GraphicsFormat.R8G8B8A8_UNorm)throw new Exception("Invalid captured texture: "+key);
    log.AppendLine(key+"="+AssetDatabase.GetAssetPath(tex)+" format="+tex.graphicsFormat);
   }
   if(obj.transform.localToWorldMatrix!=matrix||camera.worldToCameraMatrix!=view||obj.GetComponent<MeshFilter>().sharedMesh!=mesh)throw new Exception("Geometry/camera changed");
  }finally{camera.aspect=aspect;camera.projectionMatrix=projection;if(projectionMode==1)camera.ResetProjectionMatrix();else if(projectionMode==2)camera.usePhysicalProperties=true;log.AppendLine("Scene dirty before="+dirty+" after="+scene.isDirty+"; no scene save/switch");File.WriteAllText(Dir+"/installed_validation.txt",log.ToString());}
 }
 static void CaptureStage(Camera camera,string name,StringBuilder log){
  var old=camera.targetTexture;var active=RenderTexture.active;var previousHook=EID4730RenderFeature.CaptureEID4765ColorForDiagnostics;var final=new RenderTexture(1366,768,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);var stage=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);final.Create();stage.Create();int hits=0;
  try{camera.targetTexture=final;EID4730RenderFeature.CaptureEID4765ColorForDiagnostics=(cmd,rt)=>{cmd.CopyTexture(rt.nameID,stage);hits++;};camera.Render();camera.Render();if(hits!=2)throw new Exception("Stage hook count="+hits);Dump(stage,name+"_stage");Dump(final,name+"_final");log.AppendLine(name+" stage hooks="+hits);}
  finally{EID4730RenderFeature.CaptureEID4765ColorForDiagnostics=previousHook;camera.targetTexture=old;RenderTexture.active=active;final.Release();stage.Release();UnityEngine.Object.DestroyImmediate(final);UnityEngine.Object.DestroyImmediate(stage);}
 }
 static void Capture(Camera camera,GameObject obj,Material mat,string prefix){
  var colors=new RenderTexture[5];var ids=new RenderTargetIdentifier[5];var depth=new RenderTexture(1366,768,24,RenderTextureFormat.Depth);depth.Create();
  for(int i=0;i<5;i++){colors[i]=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);colors[i].Create();ids[i]=colors[i];}
  var cmd=new CommandBuffer{name="EID1672 isolated GBuffer validation"};
  try {
   int pass=mat.FindPass("VS215441_PS215442_UniversalGBuffer");if(pass<0)throw new Exception("Missing GBuffer pass");
   cmd.SetViewProjectionMatrices(camera.worldToCameraMatrix,camera.projectionMatrix);
   cmd.SetGlobalMatrix("unity_MatrixVP",GL.GetGPUProjectionMatrix(camera.projectionMatrix,true)*camera.worldToCameraMatrix);
   cmd.SetGlobalVector("_WorldSpaceCameraPos",camera.transform.position);
   cmd.SetRenderTarget(ids,depth);cmd.ClearRenderTarget(true,true,new Color(-10,-10,-10,-10));
   cmd.DrawMesh(obj.GetComponent<MeshFilter>().sharedMesh,obj.transform.localToWorldMatrix,mat,0,pass);Graphics.ExecuteCommandBuffer(cmd);
   for(int i=0;i<5;i++)Dump(colors[i],prefix+"_gb"+i);
  }finally{cmd.Release();foreach(var t in colors){t.Release();UnityEngine.Object.DestroyImmediate(t);}depth.Release();UnityEngine.Object.DestroyImmediate(depth);}
 }
 static void Dump(RenderTexture rt,string name){var old=RenderTexture.active;var cpu=new Texture2D(rt.width,rt.height,TextureFormat.RGBAFloat,false,true);try{RenderTexture.active=rt;cpu.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0);cpu.Apply();File.WriteAllBytes(Dir+"/"+name+".f32",cpu.GetRawTextureData());}finally{RenderTexture.active=old;UnityEngine.Object.DestroyImmediate(cpu);}}
}
