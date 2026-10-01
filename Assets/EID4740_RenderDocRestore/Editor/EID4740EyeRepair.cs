#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.Rendering;
using EID4730;

[InitializeOnLoad]
public static class EID4740EyeRepair
{
 const string Root="Assets/EID4740_RenderDocRestore";
 const string Dir=".rdctools/eid4740_verified";
 const string ScenePath="Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
 const string ChildName="EID4740_Forward_for_EID1597";
 static double next;
 static EID4740EyeRepair(){EditorApplication.update+=Tick;}
 static void Tick(){
  if(Application.isBatchMode||EditorApplication.isCompiling||EditorApplication.isUpdating||EditorApplication.timeSinceStartup<next)return;
  next=EditorApplication.timeSinceStartup+1;string path=Dir+"/editor_request.txt";if(!File.Exists(path))return;
  string action=File.ReadAllText(path).Trim();File.Delete(path);
  try{
   if(action=="install_verify"){InstallCurrentScene();VerifyCurrentViews();}
   else if(action=="status")Status();else if(action=="verify")VerifyCurrentViews();else throw new Exception("Unknown request "+action);
   File.WriteAllText(Dir+"/editor_result.txt","COMPLETED "+action+" "+DateTime.Now.ToString("O")+"; see live_views.txt for per-camera PASS/INCONCLUSIVE. Scene not saved.");
  }catch(Exception e){File.WriteAllText(Dir+"/editor_result.txt","FAIL\n"+e);Debug.LogException(e);}
 }
 static GameObject Source(){
  if(SceneManager.GetActiveScene().path!=ScenePath)throw new Exception("Expected target scene already open. No scene will be reopened or overwritten.");
  var all=UnityEngine.Object.FindObjectsOfType<Transform>(true);GameObject result=null;
  foreach(var t in all)if(t.gameObject.scene.path==ScenePath&&t.name=="EID1597_instance_000"){
   if(result!=null)throw new Exception("Ambiguous EID1597 target");result=t.gameObject;
  }
  if(result==null)throw new Exception("EID1597_instance_000 not found");return result;
 }
 [MenuItem("Tools/EID4740/Repair EID1597 Eyes In Current Scene")]
 public static void InstallCurrentScene(){
  Directory.CreateDirectory(Dir);var source=Source();var sourceMesh=source.GetComponent<MeshFilter>().sharedMesh;var sourceRenderer=source.GetComponent<MeshRenderer>();
  var mesh=AssetDatabase.LoadAssetAtPath<Mesh>(Root+"/EID4740_Mesh.asset");var mat=AssetDatabase.LoadAssetAtPath<Material>(Root+"/M_EID4740.mat");
  if(mesh==null||mat==null||mat.shader==null||mat.shader.name!="Hidden/EID4740/CharacterForward")throw new Exception("Verified EID4740 assets are missing or shader does not match");
  if(sourceMesh.vertexCount!=208||sourceMesh.GetIndexCount(0)!=888||mesh.vertexCount!=208||mesh.GetIndexCount(0)!=888)throw new Exception("Eye mesh counts mismatch");
  var a=sourceMesh.vertices;var b=mesh.vertices;var ia=sourceMesh.GetIndices(0);var ib=mesh.GetIndices(0);
  for(int i=0;i<a.Length;i++)if(a[i].x!=b[i].x||a[i].y!=b[i].y||a[i].z!=b[i].z)throw new Exception("Forward position differs from original vertex "+i);
  for(int i=0;i<ia.Length;i++)if(ia[i]!=ib[i])throw new Exception("Forward topology differs from original");
  if(sourceRenderer.sharedMaterial==null||!sourceRenderer.sharedMaterial.GetShaderPassEnabled("UniversalGBuffer"))throw new Exception("EID1597 GBuffer is disabled. Not changing source material without diagnosis.");
  Undo.IncrementCurrentGroup();int group=Undo.GetCurrentGroup();Undo.SetCurrentGroupName("Restore EID4740 eye forward color");
  var child=source.transform.Find(ChildName);GameObject eye;
  if(child==null){eye=new GameObject(ChildName);Undo.RegisterCreatedObjectUndo(eye,"Create eye forward renderer");Undo.SetTransformParent(eye.transform,source.transform,"Use original eye M");}
  else eye=child.gameObject;
  Undo.RecordObject(eye.transform,"Match original eye M");eye.transform.localPosition=Vector3.zero;eye.transform.localRotation=Quaternion.identity;eye.transform.localScale=Vector3.one;eye.layer=source.layer;
  var mf=eye.GetComponent<MeshFilter>();if(mf==null)mf=Undo.AddComponent<MeshFilter>(eye);Undo.RecordObject(mf,"Assign verified forward attributes");mf.sharedMesh=mesh;
  var mr=eye.GetComponent<MeshRenderer>();if(mr==null)mr=Undo.AddComponent<MeshRenderer>(eye);Undo.RecordObject(mr,"Assign captured eye material");mr.sharedMaterial=mat;mr.enabled=sourceRenderer.enabled;mr.shadowCastingMode=ShadowCastingMode.Off;mr.receiveShadows=false;mr.motionVectorGenerationMode=MotionVectorGenerationMode.ForceNoMotion;mr.lightProbeUsage=LightProbeUsage.Off;mr.reflectionProbeUsage=ReflectionProbeUsage.Off;
  var binder=eye.GetComponent<EID4740ReplayBinder>();if(binder==null)binder=Undo.AddComponent<EID4740ReplayBinder>(eye);Undo.RecordObject(binder,"Bind independent EID4740 resources");binder.material=mat;binder.Rebind();
  float error=0;var m1=source.transform.localToWorldMatrix;var m2=eye.transform.localToWorldMatrix;for(int i=0;i<16;i++)error=Mathf.Max(error,Mathf.Abs(m1[i]-m2[i]));
  if(error!=0)throw new Exception("Eye forward/source M differ: "+error);
  EditorSceneManager.MarkSceneDirty(source.scene);Undo.CollapseUndoOperations(group);
  SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();Status();
  Debug.Log("[EID4740] Attached to EID1597 as an identity child: same M, original GBuffer/mesh/material unchanged. Scene is dirty and NOT saved.");
 }
 [MenuItem("Tools/EID4740/Verify Current Eye Views")]
 public static void VerifyCurrentViews(){
  Status();var camGo=GameObject.Find("EID3336 RenderDoc Camera");if(camGo==null)throw new Exception("Fixed camera not found");
  var log=new StringBuilder();log.AppendLine("device="+SystemInfo.graphicsDeviceType+" timestamp="+DateTime.Now.ToString("O"));
  log.AppendLine("Temporary-target camera rerenders, not an on-screen editor screenshot. No scene open/save.");
  try{
   CheckView(camGo.GetComponent<Camera>(),"GameCamera",1366,768,log);
   var sv=SceneView.lastActiveSceneView;
   if(sv!=null&&sv.camera!=null)CheckView(sv.camera,"SceneView",Mathf.Max(1,sv.camera.pixelWidth),Mathf.Max(1,sv.camera.pixelHeight),log);
   else log.AppendLine("SceneView RESULT=INCONCLUSIVE: no camera");
  }catch(Exception e){log.AppendLine("RESULT=FAIL "+e);throw;}
  finally{File.WriteAllText(Dir+"/live_views.txt",log.ToString());Debug.Log(log.ToString());SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();}
 }
 static void Status(){
  Directory.CreateDirectory(Dir);var source=Source();var child=source.transform.Find(ChildName);var log=new StringBuilder();
  log.AppendLine("scene="+source.scene.path+" dirty="+source.scene.isDirty+" device="+SystemInfo.graphicsDeviceType);
  log.AppendLine("source="+source.name+" active="+source.activeInHierarchy+" enabled="+source.GetComponent<Renderer>().enabled+" M="+source.transform.localToWorldMatrix);
  if(child==null)throw new Exception("EID4740 forward child missing");
  var mat=child.GetComponent<Renderer>().sharedMaterial;log.AppendLine("forward="+child.name+" M="+child.localToWorldMatrix+" shader="+mat.shader.name+" material="+AssetDatabase.GetAssetPath(mat));
  log.AppendLine("preDrawBinders="+EID4740ReplayBinder.PrepareActiveForDraw()+" sourceMesh="+AssetDatabase.GetAssetPath(source.GetComponent<MeshFilter>().sharedMesh)+" forwardMesh="+AssetDatabase.GetAssetPath(child.GetComponent<MeshFilter>().sharedMesh));
  foreach(var name in mat.GetTexturePropertyNames()){var t=mat.GetTexture(name);log.AppendLine(name+"="+(t==null?"MISSING":AssetDatabase.GetAssetPath(t)));}
  var sv=SceneView.lastActiveSceneView;if(sv!=null)log.AppendLine("SceneView mode="+sv.cameraMode.drawMode+" sceneLighting="+sv.sceneLighting+" cameraPosition="+sv.camera.transform.position+" cameraRotation="+sv.camera.transform.rotation);
  File.WriteAllText(Dir+"/live_status.txt",log.ToString());
 }
 static void CheckView(Camera camera,string label,int width,int height,StringBuilder log){
  var old=camera.targetTexture;var active=RenderTexture.active;var rt=new RenderTexture(width,height,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);rt.Create();
  try{
   Shader.SetGlobalTexture("_EID4740_AuxiliaryMRT",null);camera.targetTexture=rt;using (EID4730.EID4730RenderFeature.BeginIsolatedAttachmentDiagnostics()) { camera.Render();camera.Render(); }
   var aux=Shader.GetGlobalTexture("_EID4740_AuxiliaryMRT") as RenderTexture;if(aux==null)throw new Exception(label+": EID4740 auxiliary missing (RenderFeature not executed)");
   var colors=Read(rt);var mask=Read(aux);if(mask.Length!=colors.Length)throw new Exception(label+": render target sizes mismatch");
   int visible=0,lit=0,bad=0,x0=width,y0=height,x1=-1,y1=-1;float max=0;
   for(int i=0;i<mask.Length;i++){
    var m=mask[i];if(m.r+m.g+m.b<=1e-4f)continue;visible++;int x=i%width,y=i/width;x0=Mathf.Min(x0,x);y0=Mathf.Min(y0,y);x1=Mathf.Max(x1,x);y1=Mathf.Max(y1,y);
    var c=colors[i];if(float.IsNaN(c.r)||float.IsInfinity(c.r)||float.IsNaN(c.g)||float.IsInfinity(c.g)||float.IsNaN(c.b)||float.IsInfinity(c.b)){bad++;continue;}
    float peak=Mathf.Max(c.r,Mathf.Max(c.g,c.b));max=Mathf.Max(max,peak);if(peak>1e-4f)lit++;
   }
   log.AppendLine(label+" cameraType="+camera.cameraType+" size="+width+"x"+height+" eyeMask="+visible+" finalNonBlackOnMask="+lit+" nonfinite="+bad+" maxRGB="+max+" bboxBottomLeft="+x0+","+y0+","+x1+","+y1);
   Save(colors,width,height,label+"_camera");Save(mask,width,height,label+"_eye_mask");
   if(bad>0||(visible>0&&lit==0))throw new Exception(label+": invalid/black final eye color");
   log.AppendLine(label+(visible==0?" RESULT=INCONCLUSIVE: no eye coverage":" RESULT=PASS: finite nonblack final color on eye forward mask; not pixel equivalence"));
  }finally{camera.targetTexture=old;RenderTexture.active=active;rt.Release();UnityEngine.Object.DestroyImmediate(rt);}
 }
 static Color[] Read(RenderTexture source){
  var active=RenderTexture.active;var staging=new RenderTexture(source.width,source.height,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);staging.Create();Texture2D cpu=null;
  try{Graphics.Blit(source,staging);RenderTexture.active=staging;cpu=new Texture2D(source.width,source.height,TextureFormat.RGBAFloat,false,true);cpu.ReadPixels(new Rect(0,0,source.width,source.height),0,0);cpu.Apply();return cpu.GetPixels();}
  finally{RenderTexture.active=active;if(cpu!=null)UnityEngine.Object.DestroyImmediate(cpu);staging.Release();UnityEngine.Object.DestroyImmediate(staging);}
 }
 static void Save(Color[] source,int width,int height,string name){
  var colors=new Color[source.Length];for(int i=0;i<source.Length;i++){var c=source[i];colors[i]=new Color(Mathf.LinearToGammaSpace(Mathf.Clamp01(c.r)),Mathf.LinearToGammaSpace(Mathf.Clamp01(c.g)),Mathf.LinearToGammaSpace(Mathf.Clamp01(c.b)),1);}
  var png=new Texture2D(width,height,TextureFormat.RGBA32,false);try{png.SetPixels(colors);png.Apply();File.WriteAllBytes(Dir+"/"+name+"_"+SystemInfo.graphicsDeviceType+".png",png.EncodeToPNG());}finally{UnityEngine.Object.DestroyImmediate(png);}
 }
}
#endif
