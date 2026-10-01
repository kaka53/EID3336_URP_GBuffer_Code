#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

[InitializeOnLoad]
public static class EID4812DepthStateRepair
{
 const string Dir=".rdctools/eid4812_depthfix";
 const string EID4812Material="Assets/EID4812_RenderDocRestore/M_EID4812.mat";
 const string EID1727ReferenceMaterial="Assets/ColourPass6_VS239789_PS239790_Batch/Materials/EID1727_VS239789_PS239790.mat";
 static double next;
 static EID4812DepthStateRepair(){EditorApplication.update+=Tick;}
 static void Tick(){
  if(Application.isBatchMode)return;
  if(EditorApplication.timeSinceStartup<next||EditorApplication.isCompiling||EditorApplication.isUpdating||EditorApplication.isPlayingOrWillChangePlaymode)return;
  next=EditorApplication.timeSinceStartup+1;var path=Dir+"/editor_request.txt";if(!File.Exists(path))return;
  var action=File.ReadAllText(path).Trim();File.Delete(path);
  try{if(action=="audit")Audit();else if(action=="validate")ValidateLiveScene();else if(action=="gbuffer")CaptureGBufferDiagnostics();else throw new Exception("Unknown request "+action);File.WriteAllText(Dir+"/editor_result.txt","PASS "+action);}
  catch(Exception e){File.WriteAllText(Dir+"/editor_result.txt",e.ToString());Debug.LogException(e);}
 }
 [MenuItem("Tools/EID4812/Capture GBuffer Diagnostics")]
 public static void CaptureGBufferDiagnostics(){
  Directory.CreateDirectory(Dir);
  var controller=UnityEngine.Object.FindObjectOfType<EID3332CombinedDeferredController>(true);
  var go=GameObject.Find("EID3336 RenderDoc Camera");
  if(controller==null||go==null)throw new Exception("Missing combined controller or capture camera.");
  var cam=go.GetComponent<Camera>();
  if(cam==null)throw new Exception("Capture camera component is missing.");
  var oldTarget=cam.targetTexture;var oldCapture=controller.captureURPGBufferForValidation;
  var oldLighting=controller.enableB6Lighting;var oldActive=RenderTexture.active;
  var target=new RenderTexture(1366,768,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear){name="EID4812 GBuffer diagnostic target",hideFlags=HideFlags.DontSave};
  target.Create();
  try{
   controller.captureURPGBufferForValidation=true;
   cam.targetTexture=target;
   using(EID4730.EID4730RenderFeature.BeginIsolatedAttachmentDiagnostics()){cam.Render();cam.Render();}
   var captures=controller.lastURPGBufferCapture;
   if(captures==null||captures.Length<5)throw new Exception("No five MRT capture was produced after UniversalGBuffer.");
   var report=new StringBuilder();report.AppendLine("device="+SystemInfo.graphicsDeviceType);report.AppendLine("camera="+cam.name+" size="+target.width+"x"+target.height);report.AppendLine("scene="+SceneManager.GetActiveScene().path);
   for(int i=0;i<5;i++){
    var source=captures[i];if(source==null){report.AppendLine("slot="+i+" missing=true");continue;}
    var staging=new RenderTexture(source.width,source.height,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear){name="EID4812 GBuffer staging "+i,hideFlags=HideFlags.DontSave};
    staging.Create();Texture2D cpu=null;Texture2D vis=null;
    try{
     Graphics.Blit(source,staging);RenderTexture.active=staging;
     cpu=new Texture2D(source.width,source.height,TextureFormat.RGBAFloat,false,true);cpu.ReadPixels(new Rect(0,0,source.width,source.height),0,0,false);cpu.Apply(false,false);
     var pixels=cpu.GetPixels();int finite=0,nonClear=0;float min=float.PositiveInfinity,max=float.NegativeInfinity,sum=0f;int minX=source.width,minY=source.height,maxX=-1,maxY=-1;
     for(int y=0;y<source.height;y++)for(int x=0;x<source.width;x++){var c=pixels[y*source.width+x];bool ok=!(float.IsNaN(c.r)||float.IsNaN(c.g)||float.IsNaN(c.b)||float.IsNaN(c.a)||float.IsInfinity(c.r)||float.IsInfinity(c.g)||float.IsInfinity(c.b)||float.IsInfinity(c.a));if(ok)finite++;float v=Mathf.Abs(c.r)+Mathf.Abs(c.g)+Mathf.Abs(c.b)+Mathf.Abs(c.a);if(ok){min=Mathf.Min(min,Mathf.Min(Mathf.Min(c.r,c.g),Mathf.Min(c.b,c.a)));max=Mathf.Max(max,Mathf.Max(Mathf.Max(c.r,c.g),Mathf.Max(c.b,c.a)));sum+=v;}if(ok&&v>1e-4f){nonClear++;minX=Mathf.Min(minX,x);minY=Mathf.Min(minY,y);maxX=Mathf.Max(maxX,x);maxY=Mathf.Max(maxY,y);}}
     vis=new Texture2D(source.width,source.height,TextureFormat.RGBA32,false,true);var vp=new Color[pixels.Length];for(int p=0;p<pixels.Length;p++){var c=pixels[p];float v=Mathf.Clamp01((Mathf.Abs(c.r)+Mathf.Abs(c.g)+Mathf.Abs(c.b)+Mathf.Abs(c.a))*0.25f);vp[p]=new Color(v,v,v,1f);}vis.SetPixels(vp);vis.Apply(false,false);File.WriteAllBytes(Dir+"/gbuffer_slot"+i+"_visual.png",vis.EncodeToPNG());
     report.AppendLine("slot="+i+" format="+source.graphicsFormat+" size="+source.width+"x"+source.height+" finite="+finite+" nonClear="+nonClear+" meanAbsSum="+(sum/(source.width*source.height))+" min="+min+" max="+max+" bbox="+minX+","+minY+","+maxX+","+maxY);
    }finally{RenderTexture.active=oldActive;if(cpu!=null)UnityEngine.Object.DestroyImmediate(cpu);if(vis!=null)UnityEngine.Object.DestroyImmediate(vis);staging.Release();UnityEngine.Object.DestroyImmediate(staging);}
   }
   File.WriteAllText(Dir+"/gbuffer_diag.txt",report.ToString());
  }finally{controller.captureURPGBufferForValidation=oldCapture;controller.enableB6Lighting=oldLighting;cam.targetTexture=oldTarget;RenderTexture.active=oldActive;target.Release();UnityEngine.Object.DestroyImmediate(target);}
 }
 public static void DisableDuplicateGBuffer(){
  var reference=AssetDatabase.LoadAssetAtPath<Material>(EID1727ReferenceMaterial);
  if(reference==null)throw new Exception("Missing EID1727 reference material");
  // EID1727 is the shared GBuffer/depth source. Never leave its pass disabled
  // while removing the duplicate pass from EID4812.
  if(!reference.GetShaderPassEnabled("UniversalGBuffer")){
   reference.SetShaderPassEnabled("UniversalGBuffer",true);
   EditorUtility.SetDirty(reference);
  }
  var mat=AssetDatabase.LoadAssetAtPath<Material>(EID4812Material);if(mat==null)throw new Exception("Missing dedicated EID4812 material");
  // This API selects the LightMode tag, not the Pass Name.
  // Disable only EID4812's duplicate GBuffer. EID1727 remains the shared
  // reference/depth source and must keep its UniversalGBuffer pass enabled.
  mat.SetShaderPassEnabled("UniversalGBuffer",false);
  EditorUtility.SetDirty(mat);
  if(!reference.GetShaderPassEnabled("UniversalGBuffer"))throw new Exception("EID1727 reference GBuffer was not kept enabled.");
 }
 [MenuItem("Tools/EID4812/Audit Depth Restore")]
 public static void Audit(){
  Directory.CreateDirectory(Dir);var log=new StringBuilder();log.AppendLine("device="+SystemInfo.graphicsDeviceType+" scene="+SceneManager.GetActiveScene().path+" dirty="+SceneManager.GetActiveScene().isDirty);
  var obj=GameObject.Find("EID4812_instance_000");var reference=GameObject.Find("EID1727_instance_000");if(obj==null||reference==null)throw new Exception("Open the target scene containing both EIDs first.");
  var a=obj.GetComponent<MeshFilter>().sharedMesh;var b=reference.GetComponent<MeshFilter>().sharedMesh;var av=a.vertices;var bv=b.vertices;float err=0;if(av.Length!=bv.Length)throw new Exception("Vertex count differs");for(int i=0;i<av.Length;i++)err=Mathf.Max(err,(av[i]-bv[i]).magnitude);
  float matrixError=0;for(int r=0;r<4;r++)for(int c=0;c<4;c++)matrixError=Mathf.Max(matrixError,Mathf.Abs(obj.transform.localToWorldMatrix[r,c]-reference.transform.localToWorldMatrix[r,c]));
  if(err>1e-5f||matrixError>1e-5f)throw new Exception("Reference differs: geometry="+err+" M="+matrixError);
  var mat=obj.GetComponent<Renderer>().sharedMaterial;var rm=reference.GetComponent<Renderer>().sharedMaterial;
  log.AppendLine("vertices="+a.vertexCount+" indices="+a.GetIndexCount(0)+" referencePositionError="+err+" matrixError="+matrixError);
  log.AppendLine("material="+AssetDatabase.GetAssetPath(mat)+" shader="+mat.shader.name+" queue="+mat.renderQueue);
  bool referenceEnabled=rm.GetShaderPassEnabled("UniversalGBuffer");
  bool eid4812Enabled=mat.GetShaderPassEnabled("UniversalGBuffer");
  log.AppendLine("referenceEID1727GBufferEnabled="+referenceEnabled);
  log.AppendLine("eid4812GBufferEnabled="+eid4812Enabled);
  if(!referenceEnabled)throw new Exception("EID1727 reference GBuffer must remain enabled.");
  if(eid4812Enabled)throw new Exception("EID4812 duplicate GBuffer has not been disabled.");
  foreach(var m in ShaderUtil.GetShaderMessages(mat.shader))if(m.severity==UnityEditor.Rendering.ShaderCompilerMessageSeverity.Error)throw new Exception(m.message);
  log.AppendLine("RESULT=PASS");File.WriteAllText(Dir+"/live_audit.txt",log.ToString());Debug.Log(log.ToString());
 }
 public static void ValidateSavedSceneBatch(){
  if(!Application.isBatchMode)throw new InvalidOperationException("This entry is for an isolated batch editor only.");
  Directory.CreateDirectory(Dir);
  try {
   EditorSceneManager.OpenScene("Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity",OpenSceneMode.Single);
   ValidateLiveScene();
   File.WriteAllText(Dir+"/editor_result.txt","PASS saved-scene validation "+SystemInfo.graphicsDeviceType+" "+DateTime.Now.ToString("O"));
  } catch(Exception e){File.WriteAllText(Dir+"/editor_result.txt","FAIL\n"+e);Debug.LogException(e);EditorApplication.Exit(1);}
 }
 [MenuItem("Tools/EID4812/Validate Live Scene Depth Fix")]
 public static void ValidateLiveScene(){
  Audit();var go=GameObject.Find("EID3336 RenderDoc Camera");if(go==null)throw new Exception("Missing capture camera");var cam=go.GetComponent<Camera>();var old=cam.targetTexture;var active=RenderTexture.active;var target=new RenderTexture(1366,768,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);target.Create();
  try{cam.targetTexture=target;using (EID4730.EID4730RenderFeature.BeginIsolatedAttachmentDiagnostics()) { cam.Render();cam.Render(); }SaveColor(target,"scene_camera");var aux=Shader.GetGlobalTexture("_EID4812_AuxiliaryMRT") as RenderTexture;if(aux==null)throw new Exception("EID4812 MRT1 did not run in EID4730 queue");SaveColor(aux,"scene_auxiliary");var staging=new RenderTexture(aux.width,aux.height,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);staging.Create();Texture2D cpu=null;
   try{Graphics.Blit(aux,staging);RenderTexture.active=staging;cpu=new Texture2D(aux.width,aux.height,TextureFormat.RGBAFloat,false,true);cpu.ReadPixels(new Rect(0,0,aux.width,aux.height),0,0);cpu.Apply();int count=0,bad=0;foreach(var c in cpu.GetPixels()){if(c.r+c.g+c.b>1e-4f)count++;if(float.IsNaN(c.r)||float.IsNaN(c.g)||float.IsNaN(c.b)||float.IsInfinity(c.r)||float.IsInfinity(c.g)||float.IsInfinity(c.b))bad++;}File.WriteAllText(Dir+"/live_gpu.txt","device="+SystemInfo.graphicsDeviceType+" auxiliaryNonBlack="+count+" nonfinite="+bad+"\nThis verifies scene execution, not original-frame pixel equivalence.");if(count==0||bad!=0)throw new Exception("No finite scene forward output");}
   finally{if(cpu!=null)UnityEngine.Object.DestroyImmediate(cpu);staging.Release();UnityEngine.Object.DestroyImmediate(staging);}
  }finally{cam.targetTexture=old;RenderTexture.active=active;target.Release();UnityEngine.Object.DestroyImmediate(target);}
 }
 static void SaveColor(RenderTexture source,string name){
  var staging=new RenderTexture(source.width,source.height,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);staging.Create();var previous=RenderTexture.active;Texture2D cpu=null,png=null;
  try{Graphics.Blit(source,staging);RenderTexture.active=staging;cpu=new Texture2D(source.width,source.height,TextureFormat.RGBAFloat,false,true);cpu.ReadPixels(new Rect(0,0,source.width,source.height),0,0);cpu.Apply();var pixels=cpu.GetPixels();int nonfinite=0;
   for(int i=0;i<pixels.Length;i++){var c=pixels[i];if(float.IsNaN(c.r)||float.IsNaN(c.g)||float.IsNaN(c.b)||float.IsInfinity(c.r)||float.IsInfinity(c.g)||float.IsInfinity(c.b))nonfinite++;pixels[i]=new Color(Mathf.LinearToGammaSpace(Mathf.Clamp01(c.r)),Mathf.LinearToGammaSpace(Mathf.Clamp01(c.g)),Mathf.LinearToGammaSpace(Mathf.Clamp01(c.b)),1);}
   png=new Texture2D(source.width,source.height,TextureFormat.RGBA32,false);png.SetPixels(pixels);png.Apply();File.WriteAllBytes(Dir+"/"+name+"_"+SystemInfo.graphicsDeviceType+".png",png.EncodeToPNG());if(nonfinite>0)throw new Exception(name+" contains nonfinite pixels: "+nonfinite);
  }finally{RenderTexture.active=previous;if(cpu!=null)UnityEngine.Object.DestroyImmediate(cpu);if(png!=null)UnityEngine.Object.DestroyImmediate(png);staging.Release();UnityEngine.Object.DestroyImmediate(staging);}
 }
}
#endif
