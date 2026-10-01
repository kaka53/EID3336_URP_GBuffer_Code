using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
public static class EID1642Validation {
 const string D=".rdctools/eid1642_colorfix";
 const string R="Assets/ColourPass6_VS215443_PS215444_Batch";
 public static void VerifyInstalled(){try{
  var mat=AssetDatabase.LoadAssetAtPath<Material>(R+"/Materials/EID1642_VS215443_PS215444.mat");
  if(mat.shader.name!="EID/URP/EID1642_Verified" || ShaderUtil.ShaderHasError(mat.shader))throw new Exception("Installed shader mismatch/error");
  var normal=AssetDatabase.LoadAssetAtPath<Texture2D>("Assets/EID1642_ColorFix/Normal_BC5_Capture.asset");
  if(mat.GetTexture("_Res26")!=normal || mat.GetTexture("FS_58")!=normal)throw new Exception("Normal binding mismatch");
  for(int mip=0;mip<12;mip++){var expected=File.ReadAllBytes(D+"/rid223665_m"+mip+".raw");var actual=normal.GetPixelData<byte>(mip);if(expected.Length!=actual.Length)throw new Exception("Mip size mismatch");for(int j=0;j<expected.Length;j++)if(expected[j]!=actual[j])throw new Exception("Mip data mismatch");}
  if(mat.passCount!=2 || !mat.GetShaderPassEnabled("EID4730CharacterForward"))throw new Exception("Forward pass unavailable");
  File.WriteAllText(D+"/installed_validation.txt","PASS: installed shader compiled; GBuffer/forward normal bindings correct; all 12 BC5 mip payloads byte-exact; both passes enabled. No scene loaded or saved.");EditorApplication.Exit(0);
 }catch(Exception e){File.WriteAllText(D+"/installed_validation.txt",e.ToString());EditorApplication.Exit(1);}}
 public static void Audit(){Run(false);}
 public static void Apply(){Run(true);}
 static Texture2D Raw(int rid,TextureFormat format,bool linear,string name){
  string path="Assets/EID1642_ColorFix/"+name+".asset";var old=AssetDatabase.LoadAssetAtPath<Texture2D>(path);if(old)return old;
  using(var data=new MemoryStream()){for(int mip=0;mip<12;mip++){var b=File.ReadAllBytes(D+"/rid"+rid+"_m"+mip+".raw");data.Write(b,0,b.Length);}
   var t=new Texture2D(2048,2048,format,true,linear){name=name,wrapMode=TextureWrapMode.Repeat,filterMode=FilterMode.Bilinear,anisoLevel=1};t.LoadRawTextureData(data.ToArray());t.Apply(false,false);AssetDatabase.CreateAsset(t,path);return t;
  }
 }
 static void Run(bool apply){try{
  EditorSceneManager.OpenScene("Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity");
  var obj=GameObject.Find("EID1642_instance_000");var source=obj.GetComponent<Renderer>().sharedMaterial;var camera=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();camera.aspect=1366f/768f;
  var normal=Raw(223665,TextureFormat.BC5,true,"Normal_BC5_Capture");var albedo=Raw(224056,TextureFormat.BC7,false,"Albedo_BC7_Capture");
  var m=new Material(source);var sh=AssetDatabase.LoadAssetAtPath<Shader>("Assets/EID1642_ColorFix/Shaders/EID1642.shader");
  using(var session=new EID4730.ReplaySession(Shader.Find("Hidden/EID4730/OriginalVSFS"),false)){
   Capture(camera,obj,m,"before",session);m.shader=sh;Capture(camera,obj,m,"shader",session);
   m.SetTexture("_Res26",normal);m.SetTexture("FS_58",normal);Capture(camera,obj,m,"normal",session);
   m.SetTexture("_Res25",albedo);m.SetTexture("FS_56",albedo);Capture(camera,obj,m,"both",session);
  }
  if(ShaderUtil.ShaderHasError(sh))throw new Exception("Shader compilation failed");
  if(apply){source.shader=sh;source.SetTexture("_Res26",normal);source.SetTexture("FS_58",normal);EditorUtility.SetDirty(source);AssetDatabase.SaveAssetIfDirty(source);}
  File.WriteAllText(D+"/unity_result.txt","PASS apply="+apply+"; normal="+normal.graphicsFormat+"; albedo="+albedo.graphicsFormat+"; no scene saved");UnityEngine.Object.DestroyImmediate(m);EditorApplication.Exit(0);
 }catch(Exception e){File.WriteAllText(D+"/unity_error.txt",e.ToString());Debug.LogException(e);EditorApplication.Exit(1);}}
 static void Capture(Camera cam,GameObject obj,Material mat,string prefix,EID4730.ReplaySession session){
  var colors=new RenderTexture[5];var ids=new RenderTargetIdentifier[5];var depth=new RenderTexture(1366,768,24,RenderTextureFormat.Depth);depth.Create();
  for(int i=0;i<5;i++){colors[i]=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);colors[i].Create();ids[i]=colors[i];}
  var cmd=new CommandBuffer();try{
   session.BindFrame(cmd);cmd.SetViewProjectionMatrices(cam.worldToCameraMatrix,cam.projectionMatrix);cmd.SetGlobalMatrix("unity_MatrixVP",GL.GetGPUProjectionMatrix(cam.projectionMatrix,true)*cam.worldToCameraMatrix);cmd.SetGlobalVector("_WorldSpaceCameraPos",cam.transform.position);
   cmd.SetRenderTarget(ids,depth);cmd.ClearRenderTarget(true,true,new Color(-10,-10,-10,-10));cmd.DrawMesh(obj.GetComponent<MeshFilter>().sharedMesh,obj.transform.localToWorldMatrix,mat,0,0);Graphics.ExecuteCommandBuffer(cmd);
   for(int i=0;i<5;i++)Dump(colors[i],prefix+"_gb"+i);
   cmd.Clear();session.BindFrame(cmd);cmd.SetViewProjectionMatrices(cam.worldToCameraMatrix,cam.projectionMatrix);cmd.SetGlobalMatrix("unity_MatrixVP",GL.GetGPUProjectionMatrix(cam.projectionMatrix,true)*cam.worldToCameraMatrix);cmd.SetGlobalVector("_WorldSpaceCameraPos",cam.transform.position);cmd.SetRenderTarget(new RenderTargetIdentifier[]{colors[0],colors[1]},depth);cmd.ClearRenderTarget(false,true,new Color(-10,-10,-10,-10));cmd.DrawMesh(obj.GetComponent<MeshFilter>().sharedMesh,obj.transform.localToWorldMatrix,mat,0,1);Graphics.ExecuteCommandBuffer(cmd);Dump(colors[0],prefix+"_forward");Dump(colors[1],prefix+"_forward_aux");
  }finally{cmd.Release();foreach(var t in colors){t.Release();UnityEngine.Object.DestroyImmediate(t);}depth.Release();UnityEngine.Object.DestroyImmediate(depth);}
 }
 static void Dump(RenderTexture rt,string name){var old=RenderTexture.active;var cpu=new Texture2D(rt.width,rt.height,TextureFormat.RGBAFloat,false,true);try{RenderTexture.active=rt;cpu.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0);cpu.Apply();File.WriteAllBytes(D+"/"+name+".f32",cpu.GetRawTextureData());}finally{RenderTexture.active=old;UnityEngine.Object.DestroyImmediate(cpu);}}
}


