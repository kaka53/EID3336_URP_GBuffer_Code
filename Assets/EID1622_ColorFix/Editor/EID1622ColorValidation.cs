using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;

public static class EID1622ColorValidation
{
 const string Dir=".rdctools/eid1622_colorfix";
 const string Scene="Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
 public static void Audit(){Run(false);}
 public static void Apply(){Run(true);}
 public static void VerifyInstalled(){
  var log=new StringBuilder();
  try {
   var mat=AssetDatabase.LoadAssetAtPath<Material>("Assets/ColourPass6_VS215441_PS215442_Batch/Materials/EID1622_VS215441_PS215442.mat");
   if(mat.shader.name!="EID/URP/EID1622_VerifiedGBuffer")throw new Exception("Wrong installed shader");
   var normal=AssetDatabase.LoadAssetAtPath<Texture2D>("Assets/EID1622_ColorFix/Normal_BC5_Capture.asset");
   if(mat.GetTexture("_Res29")!=normal)throw new Exception("Wrong normal binding");
   for(int mip=0;mip<normal.mipmapCount;mip++){
    var expected=File.ReadAllBytes(".rdctools/eid4705_verified/rid223506_m"+mip+"_s0.raw");var actual=normal.GetPixelData<byte>(mip).ToArray();
    if(actual.Length!=expected.Length)throw new Exception("Mip size mismatch");for(int j=0;j<actual.Length;j++)if(actual[j]!=expected[j])throw new Exception("Mip data mismatch");
   }
   log.AppendLine("PASS native BC5 all 11 mips byte-exact RenderDoc data; format="+normal.graphicsFormat);
   var imported=AssetDatabase.LoadAssetAtPath<Texture2D>("Assets/ColourPass6_VS215441_PS215442_Batch/TextureDatabase/rid223506.dds");
   log.AppendLine("DDS format="+imported.graphicsFormat+" size="+imported.width+"x"+imported.height);
   foreach(var tex in new[]{imported,normal}){
    var r=AsyncGPUReadback.Request(tex,0);r.WaitForCompletion();if(!r.hasError){var data=r.GetData<byte>().ToArray();File.WriteAllBytes(Dir+"/"+(tex==normal?"capture":"dds")+"_gpu_mip0.bin",data);log.AppendLine("GPU readback="+tex.name+" bytes="+data.Length);}else log.AppendLine("GPU readback unsupported: "+tex.name);
   }
   var scene=EditorSceneManager.OpenScene(Scene,OpenSceneMode.Single);var obj=GameObject.Find("EID1622_instance_000");var camera=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();camera.aspect=1366f/768f;
   if(obj.GetComponent<Renderer>().sharedMaterial!=mat)throw new Exception("Scene binding mismatch");
   Capture(camera,obj,mat,"installed");
   if(ShaderUtil.ShaderHasError(mat.shader))throw new Exception("Installed shader compile error");
   log.AppendLine("PASS installed shader rendered on "+SystemInfo.graphicsDeviceType+"; ShaderHasError=False; passCount="+mat.passCount);
   log.AppendLine("PASS target active="+obj.activeInHierarchy+" rendererEnabled="+obj.GetComponent<Renderer>().enabled);
   log.AppendLine("PASS no scene, mesh, transform, camera, activation or shared family shader saved/modified by this repair");
   log.AppendLine("RESULT=PASS");
  }catch(Exception e){log.AppendLine(e.ToString());File.WriteAllText(Dir+"/installed_validation.txt",log.ToString());if(Application.isBatchMode)EditorApplication.Exit(1);throw;}
  File.WriteAllText(Dir+"/installed_validation.txt",log.ToString());
 }
 public static void AuditTextures(){
  var scene=EditorSceneManager.OpenScene(Scene,OpenSceneMode.Single);
  var obj=GameObject.Find("EID1622_instance_000");var camera=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();camera.aspect=1366f/768f;
  var mat=new Material(obj.GetComponent<Renderer>().sharedMaterial);mat.shader=AssetDatabase.LoadAssetAtPath<Shader>("Assets/EID1622_ColorFix/Shaders/EID1622GBuffer.shader");
  try{
   Capture(camera,obj,mat,"view_only");
   mat.SetTexture("_Res29",RawTexture(223506,TextureFormat.BC5,true,"Normal_BC5_Capture"));Capture(camera,obj,mat,"raw_normal");
   mat.SetTexture("_Res28",RawTexture(223385,TextureFormat.BC7,false,"Albedo_BC7_Capture"));Capture(camera,obj,mat,"raw_both");
   File.WriteAllText(Dir+"/texture_result.txt","PASS "+System.DateTime.Now.ToString("O"));
  }finally{UnityEngine.Object.DestroyImmediate(mat);}
 }
 static Texture2D RawTexture(int rid,TextureFormat format,bool linear,string name){
  using(var all=new MemoryStream()){
   for(int mip=0;mip<11;mip++){var b=File.ReadAllBytes(".rdctools/eid4705_verified/rid"+rid+"_m"+mip+"_s0.raw");all.Write(b,0,b.Length);}
   var t=new Texture2D(1024,1024,format,true,linear);t.name=name;t.wrapMode=TextureWrapMode.Repeat;t.filterMode=FilterMode.Bilinear;t.anisoLevel=1;t.LoadRawTextureData(all.ToArray());t.Apply(false,false);
   string path="Assets/EID1622_ColorFix/"+name+".asset";var old=AssetDatabase.LoadAssetAtPath<Texture2D>(path);if(old==null)AssetDatabase.CreateAsset(t,path);else{EditorUtility.CopySerialized(t,old);UnityEngine.Object.DestroyImmediate(t);t=old;EditorUtility.SetDirty(t);}AssetDatabase.SaveAssetIfDirty(t);return t;
  }
 }
 static void Run(bool apply){
  var log=new StringBuilder();
  try {
   Directory.CreateDirectory(Dir);
   if(SystemInfo.graphicsDeviceType==GraphicsDeviceType.Null)throw new Exception("Graphics device required");
   log.AppendLine("Device="+SystemInfo.graphicsDeviceType);
   var scene=EditorSceneManager.OpenScene(Scene,OpenSceneMode.Single);
   var obj=GameObject.Find("EID1622_instance_000");if(obj==null||obj.scene!=scene)throw new Exception("Target not found");
   var camera=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();
   // Batch editor has a 4:3 default viewport. Use capture aspect for diagnostics only; never save camera.
   camera.aspect=1366f/768f;
   var mesh=obj.GetComponent<MeshFilter>().sharedMesh;var renderer=obj.GetComponent<Renderer>();var source=renderer.sharedMaterial;
   var m=obj.transform.localToWorldMatrix;var v=camera.worldToCameraMatrix;var p=camera.projectionMatrix;
   log.AppendLine("Scene="+Scene+" material="+AssetDatabase.GetAssetPath(source)+" mesh="+AssetDatabase.GetAssetPath(mesh));
   log.AppendLine("Vertices="+mesh.vertexCount+" indices="+mesh.GetIndexCount(0)+" enabled="+renderer.enabled+" active="+obj.activeInHierarchy);
   log.AppendLine("Camera="+camera.transform.position+"\nV="+v+"\nP="+p);
   Capture(camera,obj,source,"before");
   CaptureForward(camera,obj,source,log);
   var shader=AssetDatabase.LoadAssetAtPath<Shader>("Assets/EID1622_ColorFix/Shaders/EID1622GBuffer.shader");
   if(shader==null)throw new Exception("Missing candidate shader");
   var candidate=new Material(source);candidate.shader=shader;
   try{Capture(camera,obj,candidate,"after");}finally{UnityEngine.Object.DestroyImmediate(candidate);}
   foreach(var s in new[]{source.shader,shader}){foreach(var e in ShaderUtil.GetShaderMessages(s))log.AppendLine(s.name+" "+e.severity+" "+e.message);if(ShaderUtil.ShaderHasError(s))throw new Exception("Shader errors "+s.name);}
   if(m!=obj.transform.localToWorldMatrix||v!=camera.worldToCameraMatrix||p!=camera.projectionMatrix)throw new Exception("Matrices changed");
   if(apply){source.shader=shader;EditorUtility.SetDirty(source);AssetDatabase.SaveAssetIfDirty(source);log.AppendLine("SAVED material only; no scene, mesh, camera or renderer activation changes");}
   log.AppendLine("RESULT=PASS apply="+apply);
  }catch(Exception e){log.AppendLine(e.ToString());File.WriteAllText(Dir+"/unity_result.txt",log.ToString());Debug.LogError(log.ToString());if(Application.isBatchMode)EditorApplication.Exit(1);throw;}
  File.WriteAllText(Dir+"/unity_result.txt",log.ToString());Debug.Log(log.ToString());
 }
 static void Capture(Camera camera,GameObject obj,Material mat,string prefix){
  var colors=new RenderTexture[5];var ids=new RenderTargetIdentifier[5];var depth=new RenderTexture(1366,768,24,RenderTextureFormat.Depth);depth.Create();
  for(int i=0;i<5;i++){colors[i]=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);colors[i].Create();ids[i]=colors[i];}
  var cmd=new CommandBuffer{name="EID1622 isolated GBuffer validation"};
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
 static void CaptureForward(Camera camera,GameObject obj,Material gbuffer,StringBuilder log){
  var forward=GameObject.Find("EID4705_instance_000");if(forward==null){log.AppendLine("No matching forward object");return;}
  var mesh=forward.GetComponent<MeshFilter>().sharedMesh;var mat=forward.GetComponent<Renderer>().sharedMaterial;
  var colors=new RenderTexture[5];var ids=new RenderTargetIdentifier[5];var depth=new RenderTexture(1366,768,24,RenderTextureFormat.Depth);depth.Create();
  for(int i=0;i<5;i++){colors[i]=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);colors[i].Create();ids[i]=colors[i];}
  var cmd=new CommandBuffer{name="EID1622 EID4705 forward audit"};
  try{
   EID4730.EID4705ReplayBinder.PrepareActiveForDraw();
   cmd.SetViewProjectionMatrices(camera.worldToCameraMatrix,camera.projectionMatrix);
   cmd.SetGlobalMatrix("unity_MatrixVP",GL.GetGPUProjectionMatrix(camera.projectionMatrix,true)*camera.worldToCameraMatrix);
   cmd.SetGlobalVector("_WorldSpaceCameraPos",camera.transform.position);
   cmd.SetRenderTarget(ids,depth);cmd.ClearRenderTarget(true,true,new Color(-10,-10,-10,-10));
   cmd.DrawMesh(obj.GetComponent<MeshFilter>().sharedMesh,obj.transform.localToWorldMatrix,gbuffer,0,gbuffer.FindPass("VS215441_PS215442_UniversalGBuffer"));
   cmd.SetRenderTarget(new RenderTargetIdentifier[]{colors[0],colors[1]},depth);
   cmd.DrawMesh(mesh,forward.transform.localToWorldMatrix,mat,0,0);Graphics.ExecuteCommandBuffer(cmd);Dump(colors[0],"forward_gbuffer_depth");
   // A forward depth prepass distinguishes depth-equality dropout from pixel shader color errors.
   cmd.Clear();cmd.SetRenderTarget(new RenderTargetIdentifier[]{colors[0],colors[1]},depth);
   cmd.ClearRenderTarget(true,true,new Color(-10,-10,-10,-10));
   var zmat=new Material(gbuffer);zmat.SetFloat("_UseBakedSkinning",0); // native mesh normals are unused by the depth comparison
   cmd.SetRenderTarget(ids,depth);cmd.DrawMesh(mesh,forward.transform.localToWorldMatrix,zmat,0,zmat.FindPass("VS215441_PS215442_UniversalGBuffer"));
   cmd.SetRenderTarget(new RenderTargetIdentifier[]{colors[0],colors[1]},depth);cmd.DrawMesh(mesh,forward.transform.localToWorldMatrix,mat,0,0);
   Graphics.ExecuteCommandBuffer(cmd);Dump(colors[0],"forward_own_depth");UnityEngine.Object.DestroyImmediate(zmat);
   log.AppendLine("Forward diagnostics="+mat.shader.name+" active="+forward.activeInHierarchy+" enabled="+forward.GetComponent<Renderer>().enabled);
  }finally{cmd.Release();foreach(var t in colors){t.Release();UnityEngine.Object.DestroyImmediate(t);}depth.Release();UnityEngine.Object.DestroyImmediate(depth);}
 }
 static void Dump(RenderTexture rt,string name){var old=RenderTexture.active;var cpu=new Texture2D(rt.width,rt.height,TextureFormat.RGBAFloat,false,true);try{RenderTexture.active=rt;cpu.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0);cpu.Apply();File.WriteAllBytes(Dir+"/"+name+".f32",cpu.GetRawTextureData());}finally{RenderTexture.active=old;UnityEngine.Object.DestroyImmediate(cpu);}}
}
