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
public static class EID4794HairRepair
{
 const string Root="Assets/EID4794_RenderDocRestore";
 const string Dir=".rdctools/eid4794_verified";
 const string ScenePath="Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
 const string ChildName="EID4794_Forward_for_EID1717";
 static double next;
 static EID4794HairRepair(){EditorApplication.update+=Tick;}
 static void Tick(){
  if(Application.isBatchMode||EditorApplication.isCompiling||EditorApplication.isUpdating||EditorApplication.timeSinceStartup<next)return;
  next=EditorApplication.timeSinceStartup+1;string path=Dir+"/editor_request.txt";if(!File.Exists(path))return;
  string action=File.ReadAllText(path).Trim();File.Delete(path);
  try{
   if(action=="install_verify"){CaptureBefore();InstallCurrentScene();VerifyCurrentViews();}
   else if(action=="status")Status();else if(action=="verify")VerifyCurrentViews();else throw new Exception("Unknown request "+action);
   File.WriteAllText(Dir+"/editor_result.txt","COMPLETED "+action+" "+DateTime.Now.ToString("O")+"; see live_views.txt for per-camera PASS/INCONCLUSIVE. Scene not saved.");
  }catch(Exception e){File.WriteAllText(Dir+"/editor_result.txt","FAIL\n"+e);Debug.LogException(e);}
 }
 static GameObject Source(){
  if(SceneManager.GetActiveScene().path!=ScenePath)throw new Exception("Expected target scene already open. No scene will be reopened or overwritten.");
  var all=UnityEngine.Object.FindObjectsOfType<Transform>(true);GameObject result=null;
  foreach(var t in all)if(t.gameObject.scene.path==ScenePath&&t.name=="EID1717_instance_000"){
   if(result!=null)throw new Exception("Ambiguous EID1717 target");result=t.gameObject;
  }
  if(result==null)throw new Exception("EID1717_instance_000 not found");return result;
 }
 static void CaptureBefore(){
  Directory.CreateDirectory(Dir);var source=Source();if(source.transform.Find(ChildName)!=null)return;
  var cg=GameObject.Find("EID3336 RenderDoc Camera");if(cg==null)return;
  CaptureBeforeCamera(cg.GetComponent<Camera>(),"Before_GameCamera",1366,768);
  var temp=new GameObject("Hair baseline closeup camera"){hideFlags=HideFlags.HideAndDontSave};
  try{var c=temp.AddComponent<Camera>();c.CopyFrom(cg.GetComponent<Camera>());c.enabled=false;c.targetTexture=null;
   var center=source.transform.TransformPoint(source.GetComponent<MeshFilter>().sharedMesh.bounds.center);
   c.transform.position=center+source.transform.TransformDirection(new Vector3(0,.02f,.75f));c.transform.LookAt(center,Vector3.up);c.orthographic=false;c.fieldOfView=35;c.aspect=1;c.nearClipPlane=.01f;c.farClipPlane=100;
   CaptureBeforeCamera(c,"Before_HairCloseup",512,512);
  }finally{UnityEngine.Object.DestroyImmediate(temp);}
 }
 static void CaptureBeforeCamera(Camera c,string name,int width,int height){
  var old=c.targetTexture;var active=RenderTexture.active;var rt=new RenderTexture(width,height,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);rt.Create();
  try{c.targetTexture=rt;c.Render();c.Render();Save(Read(rt),width,height,name);}
  finally{c.targetTexture=old;RenderTexture.active=active;rt.Release();UnityEngine.Object.DestroyImmediate(rt);}
 }
 [MenuItem("Tools/EID4794/Repair EID1717 Hair In Current Scene")]
 public static void InstallCurrentScene(){
  Directory.CreateDirectory(Dir);var source=Source();var sourceMesh=source.GetComponent<MeshFilter>().sharedMesh;var sourceRenderer=source.GetComponent<MeshRenderer>();
  var mesh=AssetDatabase.LoadAssetAtPath<Mesh>(Root+"/EID4794_Mesh.asset");var mat=AssetDatabase.LoadAssetAtPath<Material>(Root+"/M_EID4794.mat");
  if(mesh==null||mat==null||mat.shader==null||mat.shader.name!="Hidden/EID4794/CharacterForward")throw new Exception("Verified EID4794 assets are missing or shader does not match");
  if(sourceMesh.vertexCount!=9531||sourceMesh.GetIndexCount(0)!=32772||mesh.vertexCount!=9531||mesh.GetIndexCount(0)!=32772)throw new Exception("Hair mesh counts mismatch");
  var a=sourceMesh.vertices;var b=mesh.vertices;var ia=sourceMesh.GetIndices(0);var ib=mesh.GetIndices(0);
  for(int i=0;i<a.Length;i++)if(a[i].x!=b[i].x||a[i].y!=b[i].y||a[i].z!=b[i].z)throw new Exception("Forward position differs from original vertex "+i);
  for(int i=0;i<ia.Length;i++)if(ia[i]!=ib[i])throw new Exception("Forward topology differs from original");
  if(sourceRenderer.sharedMaterial==null||!sourceRenderer.sharedMaterial.GetShaderPassEnabled("UniversalGBuffer"))throw new Exception("EID1717 GBuffer is disabled. Not changing source material without diagnosis.");
  var correctedGB=AssetDatabase.LoadAssetAtPath<Material>(Root+"/M_EID1717_GBuffer.mat");
  var outlineMat=AssetDatabase.LoadAssetAtPath<Material>("Assets/EID4883_RenderDocRestore/M_EID4883.mat");
  if(correctedGB==null||outlineMat==null||outlineMat.shader==null||outlineMat.shader.name!="Hidden/EID4883/HairOutline")throw new Exception("Verified GBuffer or outline material missing");
  GameObject oldOutline=null;foreach(var t in UnityEngine.Object.FindObjectsOfType<Transform>(true))if(t.gameObject.scene==source.scene&&t.name=="EID1766_instance_000"){if(oldOutline!=null)throw new Exception("Ambiguous EID1766");oldOutline=t.gameObject;}
  if(oldOutline==null)throw new Exception("Paired EID1766 outline prepass not found; refusing partial replacement");
  var sourceM=source.transform.localToWorldMatrix;var outlineM=oldOutline.transform.localToWorldMatrix;for(int i=0;i<16;i++)if(Mathf.Abs(sourceM[i]-outlineM[i])>1e-6f)throw new Exception("Paired outline M differs; do not overwrite transforms");
  var oldMat=sourceRenderer.sharedMaterial;
  if(oldMat!=correctedGB&&AssetDatabase.GetAssetPath(oldMat)!=EID4794Assets.OriginalMaterialPath)throw new Exception("User-assigned hair material changed; stopping instead of overwriting");
  Undo.IncrementCurrentGroup();int group=Undo.GetCurrentGroup();Undo.SetCurrentGroupName("Restore EID4794 hair forward color");
  var child=source.transform.Find(ChildName);GameObject hair;
  if(child==null){hair=new GameObject(ChildName);Undo.RegisterCreatedObjectUndo(hair,"Create hair forward renderer");Undo.SetTransformParent(hair.transform,source.transform,"Use original hair M");}
  else hair=child.gameObject;
  Undo.RecordObject(hair.transform,"Match original hair M");hair.transform.localPosition=Vector3.zero;hair.transform.localRotation=Quaternion.identity;hair.transform.localScale=Vector3.one;hair.layer=source.layer;
  var mf=hair.GetComponent<MeshFilter>();if(mf==null)mf=Undo.AddComponent<MeshFilter>(hair);Undo.RecordObject(mf,"Assign verified forward attributes");mf.sharedMesh=mesh;
  var mr=hair.GetComponent<MeshRenderer>();if(mr==null)mr=Undo.AddComponent<MeshRenderer>(hair);Undo.RecordObject(mr,"Assign captured hair material");mr.sharedMaterial=mat;mr.enabled=sourceRenderer.enabled;mr.shadowCastingMode=ShadowCastingMode.Off;mr.receiveShadows=false;mr.motionVectorGenerationMode=MotionVectorGenerationMode.ForceNoMotion;mr.lightProbeUsage=LightProbeUsage.Off;mr.reflectionProbeUsage=ReflectionProbeUsage.Off;
  var binder=hair.GetComponent<EID4794ReplayBinder>();if(binder==null)binder=Undo.AddComponent<EID4794ReplayBinder>(hair);Undo.RecordObject(binder,"Bind independent EID4794 resources");binder.material=mat;binder.Rebind();
  Undo.RecordObject(sourceRenderer,"Replace only EID1717 wrong forward with scoped captured GBuffer");sourceRenderer.sharedMaterial=correctedGB;
  var oldR=oldOutline.GetComponent<MeshRenderer>();Undo.RecordObject(oldR,"Disable incomplete EID1766 outline projection");oldR.enabled=false;
  var ot=source.transform.Find("EID4883_Outline_for_EID1717");GameObject outline;
  if(ot==null){outline=new GameObject("EID4883_Outline_for_EID1717");Undo.RegisterCreatedObjectUndo(outline,"Create verified hair outline");Undo.SetTransformParent(outline.transform,source.transform,"Inherit original hair M");}else outline=ot.gameObject;
  Undo.RecordObject(outline.transform,"Align outline M");outline.transform.localPosition=Vector3.zero;outline.transform.localRotation=Quaternion.identity;outline.transform.localScale=Vector3.one;outline.layer=source.layer;
  var omf=outline.GetComponent<MeshFilter>();if(omf==null)omf=Undo.AddComponent<MeshFilter>(outline);Undo.RecordObject(omf,"Assign same hair geometry");omf.sharedMesh=mesh;
  var omr=outline.GetComponent<MeshRenderer>();if(omr==null)omr=Undo.AddComponent<MeshRenderer>(outline);Undo.RecordObject(omr,"Assign captured outline material");omr.sharedMaterial=outlineMat;omr.enabled=sourceRenderer.enabled;omr.shadowCastingMode=ShadowCastingMode.Off;omr.receiveShadows=false;omr.lightProbeUsage=LightProbeUsage.Off;omr.reflectionProbeUsage=ReflectionProbeUsage.Off;
  var ob=outline.GetComponent<EID4883ReplayBinder>();if(ob==null)ob=Undo.AddComponent<EID4883ReplayBinder>(outline);Undo.RecordObject(ob,"Bind captured outline resources");ob.material=outlineMat;ob.Rebind();
  float error=0;var m1=source.transform.localToWorldMatrix;var m2=hair.transform.localToWorldMatrix;for(int i=0;i<16;i++)error=Mathf.Max(error,Mathf.Abs(m1[i]-m2[i]));
  if(error!=0)throw new Exception("Hair forward/source M differ: "+error);
  EditorSceneManager.MarkSceneDirty(source.scene);Undo.CollapseUndoOperations(group);
  SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();Status();
  Debug.Log("[EID4794] Attached to EID1717 as an identity child: same M, original Mesh/M and material assets unchanged; source Renderer now uses scoped GBuffer and old EID1766 Renderer is disabled. Scene is dirty and NOT saved.");
 }
 [MenuItem("Tools/EID4794/Verify Current Hair Views")]
 public static void VerifyCurrentViews(){
  Status();var camGo=GameObject.Find("EID3336 RenderDoc Camera");if(camGo==null)throw new Exception("Fixed camera not found");
  var log=new StringBuilder();log.AppendLine("device="+SystemInfo.graphicsDeviceType+" timestamp="+DateTime.Now.ToString("O"));
  log.AppendLine("Temporary-target camera rerenders, not an on-screen editor screenshot. No scene open/save.");
  try{
   CheckView(camGo.GetComponent<Camera>(),"GameCamera",1366,768,log);
   var sv=SceneView.lastActiveSceneView;
   if(sv!=null&&sv.camera!=null)CheckView(sv.camera,"SceneView",Mathf.Max(1,sv.camera.pixelWidth),Mathf.Max(1,sv.camera.pixelHeight),log);
   else log.AppendLine("SceneView RESULT=INCONCLUSIVE: no camera");
   var cg=new GameObject("EID1717 temporary closeup verification camera") {hideFlags=HideFlags.HideAndDontSave};
   try{
    var c=cg.AddComponent<Camera>();c.CopyFrom(camGo.GetComponent<Camera>());c.enabled=false;c.targetTexture=null;
    var source=Source();var center=source.transform.TransformPoint(source.GetComponent<MeshFilter>().sharedMesh.bounds.center);
    c.transform.position=center+source.transform.TransformDirection(new Vector3(0,.02f,.75f));c.transform.LookAt(center,Vector3.up);c.orthographic=false;c.fieldOfView=35;c.aspect=1;c.nearClipPlane=.01f;c.farClipPlane=100;
    CheckView(c,"HairCloseup",512,512,log);
   }finally{UnityEngine.Object.DestroyImmediate(cg);}
  }catch(Exception e){log.AppendLine("RESULT=FAIL "+e);throw;}
  finally{File.WriteAllText(Dir+"/live_views.txt",log.ToString());Debug.Log(log.ToString());SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();}
 }
 static void Status(){
  Directory.CreateDirectory(Dir);var source=Source();var child=source.transform.Find(ChildName);var log=new StringBuilder();
  log.AppendLine("scene="+source.scene.path+" dirty="+source.scene.isDirty+" device="+SystemInfo.graphicsDeviceType);
  log.AppendLine("source="+source.name+" active="+source.activeInHierarchy+" enabled="+source.GetComponent<Renderer>().enabled+" M="+source.transform.localToWorldMatrix);
  if(child==null)throw new Exception("EID4794 forward child missing");
  var mat=child.GetComponent<Renderer>().sharedMaterial;log.AppendLine("forward="+child.name+" M="+child.localToWorldMatrix+" shader="+mat.shader.name+" material="+AssetDatabase.GetAssetPath(mat));
  log.AppendLine("preDrawBinders="+EID4794ReplayBinder.PrepareActiveForDraw()+" sourceMesh="+AssetDatabase.GetAssetPath(source.GetComponent<MeshFilter>().sharedMesh)+" forwardMesh="+AssetDatabase.GetAssetPath(child.GetComponent<MeshFilter>().sharedMesh));
  var outline=source.transform.Find("EID4883_Outline_for_EID1717");
  log.AppendLine("outline="+(outline==null?"MISSING":outline.name)+" outlineBinders="+EID4883ReplayBinder.PrepareActiveForDraw());
  log.AppendLine("sourceScopedMaterial="+AssetDatabase.GetAssetPath(source.GetComponent<Renderer>().sharedMaterial));
  foreach(var name in mat.GetTexturePropertyNames()){var t=mat.GetTexture(name);log.AppendLine(name+"="+(t==null?"MISSING":AssetDatabase.GetAssetPath(t)));}
  var sv=SceneView.lastActiveSceneView;if(sv!=null)log.AppendLine("SceneView mode="+sv.cameraMode.drawMode+" sceneLighting="+sv.sceneLighting+" cameraPosition="+sv.camera.transform.position+" cameraRotation="+sv.camera.transform.rotation);
  File.WriteAllText(Dir+"/live_status.txt",log.ToString());
 }
 static void CheckView(Camera camera,string label,int width,int height,StringBuilder log){
  var old=camera.targetTexture;var active=RenderTexture.active;var rt=new RenderTexture(width,height,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);rt.Create();
  try{
   Shader.SetGlobalTexture("_EID4794_AuxiliaryMRT",null);Shader.SetGlobalTexture("_EID4883_AuxiliaryMRT",null);camera.targetTexture=rt;using (EID4730.EID4730RenderFeature.BeginIsolatedAttachmentDiagnostics()) { camera.Render();camera.Render(); }
   var colors=Read(rt);Save(colors,width,height,label+"_camera");
   foreach(string eid in new[]{"4794","4883"}){
    var aux=Shader.GetGlobalTexture("_EID"+eid+"_AuxiliaryMRT") as RenderTexture;if(aux==null)throw new Exception(label+": EID"+eid+" auxiliary missing");
    var mask=Read(aux);if(mask.Length!=colors.Length)throw new Exception(label+": mismatched attachment dimensions");
    int visible=0,lit=0,bad=0,x0=width,y0=height,x1=-1,y1=-1;float max=0;
    for(int i=0;i<mask.Length;i++){
     var m=mask[i];if(m.r+m.g+m.b<=1e-4f)continue;visible++;int x=i%width,y=i/width;x0=Mathf.Min(x0,x);y0=Mathf.Min(y0,y);x1=Mathf.Max(x1,x);y1=Mathf.Max(y1,y);
     var c=colors[i];if(float.IsNaN(c.r)||float.IsInfinity(c.r)||float.IsNaN(c.g)||float.IsInfinity(c.g)||float.IsNaN(c.b)||float.IsInfinity(c.b)){bad++;continue;}
     float peak=Mathf.Max(c.r,Mathf.Max(c.g,c.b));max=Mathf.Max(max,peak);if(peak>1e-4f)lit++;
    }
    log.AppendLine(label+" EID"+eid+" cameraType="+camera.cameraType+" size="+width+"x"+height+" mask="+visible+" finalNonBlackOnMask="+lit+" nonfinite="+bad+" maxRGB="+max+" bboxBottomLeft="+x0+","+y0+","+x1+","+y1);
    Save(mask,width,height,label+"_EID"+eid+"_mask");
    if(bad>0||(visible>0&&lit==0))throw new Exception(label+": invalid/black final hair color");
    log.AppendLine(label+" EID"+eid+(visible==0?" RESULT=INCONCLUSIVE: no coverage":" RESULT=PASS: finite nonblack final color on forward mask; not capture pixel equivalence"));
   }
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
