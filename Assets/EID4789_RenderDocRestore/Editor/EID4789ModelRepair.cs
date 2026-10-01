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
public static class EID4789ModelRepair
{
 const string Root="Assets/EID4789_RenderDocRestore";
 const string Dir=".rdctools/eid4789_verified";
 const string ScenePath="Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
 const string ChildName="EID4789_Forward_for_EID1696";
 static double next;
 static EID4789ModelRepair(){EditorApplication.update+=Tick;}
 static void Tick(){
  if(Application.isBatchMode||EditorApplication.isCompiling||EditorApplication.isUpdating||EditorApplication.timeSinceStartup<next)return;
  next=EditorApplication.timeSinceStartup+1;string path=Dir+"/editor_request.txt";if(!File.Exists(path))return;
  string action=File.ReadAllText(path).Trim();File.Delete(path);
  try{
   if(action=="install_verify"){CaptureBefore();InstallCurrentScene();VerifyCurrentViews();}
   else if(action=="audit_pipeline")EID4789ColorAudit.PipelineAudit();else if(action=="repair_volumes")EID4789ColorAudit.RepairVolumes();else if(action=="audit_textures")EID4789ColorAudit.TextureAudit();else if(action=="audit_color")EID4789ColorAudit.Run();else if(action=="save_verified")EID4789ColorAudit.SaveVerified();else if(action=="status")Status();else if(action=="verify")VerifyCurrentViews();else throw new Exception("Unknown request "+action);
   File.WriteAllText(Dir+"/editor_result.txt","COMPLETED "+action+" "+DateTime.Now.ToString("O")+"; see live_views.txt for per-camera PASS/INCONCLUSIVE. Scene saved only for save_verified.");
  }catch(Exception e){File.WriteAllText(Dir+"/editor_result.txt","FAIL\n"+e);Debug.LogException(e);}
 }
 static GameObject Source(){
  if(SceneManager.GetActiveScene().path!=ScenePath)throw new Exception("Expected target scene already open. No scene will be reopened or overwritten.");
  var all=UnityEngine.Object.FindObjectsOfType<Transform>(true);GameObject result=null;
  foreach(var t in all)if(t.gameObject.scene.path==ScenePath&&t.name=="EID1696_instance_000"){
   if(result!=null)throw new Exception("Ambiguous EID1696 target");result=t.gameObject;
  }
  if(result==null)throw new Exception("EID1696_instance_000 not found");return result;
 }
 [MenuItem("Tools/EID4789/Repair EID1696 Model In Current Scene")]
 public static void InstallCurrentScene(){
  Directory.CreateDirectory(Dir);var source=Source();var sourceMesh=source.GetComponent<MeshFilter>().sharedMesh;var sourceRenderer=source.GetComponent<MeshRenderer>();
  var mesh=AssetDatabase.LoadAssetAtPath<Mesh>(Root+"/EID4789_Mesh.asset");var mat=AssetDatabase.LoadAssetAtPath<Material>(Root+"/M_EID4789.mat");
  if(mesh==null||mat==null||mat.shader==null||mat.shader.name!="Hidden/EID4789/CharacterForward")throw new Exception("Verified EID4789 assets are missing or shader does not match");
  if(sourceMesh.vertexCount!=1521||sourceMesh.GetIndexCount(0)!=5001||mesh.vertexCount!=1521||mesh.GetIndexCount(0)!=5001)throw new Exception("Model mesh counts mismatch");
  var a=sourceMesh.vertices;var b=mesh.vertices;var ia=sourceMesh.GetIndices(0);var ib=mesh.GetIndices(0);
  for(int i=0;i<a.Length;i++)if(a[i].x!=b[i].x||a[i].y!=b[i].y||a[i].z!=b[i].z)throw new Exception("Forward position differs from original vertex "+i);
  for(int i=0;i<ia.Length;i++)if(ia[i]!=ib[i])throw new Exception("Forward topology differs from original");
  if(sourceRenderer.sharedMaterial==null||!sourceRenderer.sharedMaterial.GetShaderPassEnabled("UniversalGBuffer"))throw new Exception("EID1696 GBuffer is disabled. Not changing source material without diagnosis.");
  var gbmat=AssetDatabase.LoadAssetAtPath<Material>(Root+"/M_EID1696_GBuffer.mat");
  if(gbmat==null||ShaderUtil.ShaderHasError(gbmat.shader)||ShaderUtil.ShaderHasError(mat.shader))throw new Exception("Verified shaders missing or have errors");
  string sourceMatPath=AssetDatabase.GetAssetPath(sourceRenderer.sharedMaterial);
  if(sourceMatPath!=EID4789Assets.OriginalMaterialPath&&sourceMatPath!=Root+"/M_EID1696_GBuffer.mat")throw new Exception("Unexpected current source material; will not overwrite user changes: "+sourceMatPath);
  var bytes=File.ReadAllBytes(Root+"/Captured/Verified/matrix.bytes");float matrixError=0;
  for(int cc=0;cc<4;cc++)for(int rr=0;rr<4;rr++)matrixError=Mathf.Max(matrixError,Mathf.Abs(source.transform.localToWorldMatrix[rr,cc]-BitConverter.ToSingle(bytes,(cc*4+rr)*4)));
  if(matrixError>2e-4f)throw new Exception("Original M differs from capture; refusing to silently overwrite it: "+matrixError);
  Undo.IncrementCurrentGroup();int group=Undo.GetCurrentGroup();Undo.SetCurrentGroupName("Restore EID4789 model forward color");
  Undo.RecordObject(sourceRenderer,"Use verified GBuffer-only material, remove wrong general forward");sourceRenderer.sharedMaterial=gbmat;
  var child=source.transform.Find(ChildName);GameObject model;
  if(child==null){model=new GameObject(ChildName);Undo.RegisterCreatedObjectUndo(model,"Create model forward renderer");Undo.SetTransformParent(model.transform,source.transform,"Use original model M");}
  else model=child.gameObject;
  Undo.RecordObject(model.transform,"Match original model M");model.transform.localPosition=Vector3.zero;model.transform.localRotation=Quaternion.identity;model.transform.localScale=Vector3.one;model.layer=source.layer;
  var mf=model.GetComponent<MeshFilter>();if(mf==null)mf=Undo.AddComponent<MeshFilter>(model);Undo.RecordObject(mf,"Assign verified forward attributes");mf.sharedMesh=mesh;
  var mr=model.GetComponent<MeshRenderer>();if(mr==null)mr=Undo.AddComponent<MeshRenderer>(model);Undo.RecordObject(mr,"Assign captured model material");mr.sharedMaterial=mat;mr.enabled=sourceRenderer.enabled;mr.shadowCastingMode=ShadowCastingMode.Off;mr.receiveShadows=false;mr.motionVectorGenerationMode=MotionVectorGenerationMode.ForceNoMotion;mr.lightProbeUsage=LightProbeUsage.Off;mr.reflectionProbeUsage=ReflectionProbeUsage.Off;
  var binder=model.GetComponent<EID4789ReplayBinder>();if(binder==null)binder=Undo.AddComponent<EID4789ReplayBinder>(model);Undo.RecordObject(binder,"Bind independent EID4789 resources");binder.material=mat;binder.Rebind();
  float error=0;var m1=source.transform.localToWorldMatrix;var m2=model.transform.localToWorldMatrix;for(int i=0;i<16;i++)error=Mathf.Max(error,Mathf.Abs(m1[i]-m2[i]));
  if(error!=0)throw new Exception("Model forward/source M differ: "+error);
  EditorSceneManager.MarkSceneDirty(source.scene);Undo.CollapseUndoOperations(group);
  SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();Status();
  Debug.Log("[EID4789] Attached to EID1696 as an identity child: same M, original mesh/M unchanged; source Renderer uses scoped GBuffer-only material; original material asset unchanged. Scene is dirty and NOT saved.");
 }
 [MenuItem("Tools/EID4789/Verify Current Model Views")]
 public static void VerifyCurrentViews(){
  Status();var camGo=GameObject.Find("EID3336 RenderDoc Camera");if(camGo==null)throw new Exception("Fixed camera not found");
  var log=new StringBuilder();log.AppendLine("device="+SystemInfo.graphicsDeviceType+" timestamp="+DateTime.Now.ToString("O"));
  log.AppendLine("Temporary-target camera rerenders, not an on-screen editor screenshot. No scene open/save.");
  try{
   CheckView(camGo.GetComponent<Camera>(),"GameCamera",1366,768,log);
   WithCloseup(camGo.GetComponent<Camera>(),Source(),1,(c)=>CheckView(c,"CloseupFront",512,512,log));
   WithCloseup(camGo.GetComponent<Camera>(),Source(),-1,(c)=>CheckView(c,"CloseupBack",512,512,log));
   var sv=SceneView.lastActiveSceneView;
   if(sv!=null&&sv.camera!=null)CheckView(sv.camera,"SceneView",Mathf.Max(1,sv.camera.pixelWidth),Mathf.Max(1,sv.camera.pixelHeight),log);
   else log.AppendLine("SceneView RESULT=INCONCLUSIVE: no camera");
  }catch(Exception e){log.AppendLine("RESULT=FAIL "+e);throw;}
  finally{File.WriteAllText(Dir+"/live_views.txt",log.ToString());Debug.Log(log.ToString());SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();}
 }
 static void CaptureBefore(){
  Directory.CreateDirectory(Dir);var source=Source();if(source.transform.Find(ChildName)!=null)return;
  var main=GameObject.Find("EID3336 RenderDoc Camera");if(main==null)return;
  CaptureCamera(main.GetComponent<Camera>(),"Before_GameCamera",1366,768);
  WithCloseup(main.GetComponent<Camera>(),source,1,(camera)=>CaptureCamera(camera,"Before_Closeup",512,512));
 }
 static void CaptureCamera(Camera c,string label,int w,int h){var old=c.targetTexture;var active=RenderTexture.active;var rt=new RenderTexture(w,h,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);rt.Create();try{c.targetTexture=rt;c.Render();c.Render();Save(Read(rt),w,h,label);}finally{c.targetTexture=old;RenderTexture.active=active;rt.Release();UnityEngine.Object.DestroyImmediate(rt);}}
 static void WithCloseup(Camera template,GameObject source,int side,Action<Camera> action){
  var temp=new GameObject("Temporary EID1696 verification camera"){hideFlags=HideFlags.HideAndDontSave};try{var c=temp.AddComponent<Camera>();c.CopyFrom(template);c.enabled=false;c.targetTexture=null;var center=source.transform.TransformPoint(source.GetComponent<MeshFilter>().sharedMesh.bounds.center);
   c.transform.position=center+source.transform.TransformDirection(new Vector3(0,.02f,.75f*side));c.transform.LookAt(center,Vector3.up);c.orthographic=false;c.fieldOfView=45;c.aspect=1;c.nearClipPlane=.01f;c.farClipPlane=100;action(c);
  }finally{UnityEngine.Object.DestroyImmediate(temp);}
 }
 static void Status(){
  Directory.CreateDirectory(Dir);var source=Source();var forward=GameObject.Find(ChildName);var child=forward==null?null:forward.transform;var log=new StringBuilder();
  log.AppendLine("scene="+source.scene.path+" dirty="+source.scene.isDirty+" device="+SystemInfo.graphicsDeviceType);
  log.AppendLine("source="+source.name+" active="+source.activeInHierarchy+" enabled="+source.GetComponent<Renderer>().enabled+" M="+source.transform.localToWorldMatrix);
  if(child==null)throw new Exception("EID4789 forward child missing");
  var mat=child.GetComponent<Renderer>().sharedMaterial;log.AppendLine("forward="+child.name+" M="+child.localToWorldMatrix+" shader="+mat.shader.name+" material="+AssetDatabase.GetAssetPath(mat));
  log.AppendLine("preDrawBinders="+EID4789ReplayBinder.PrepareActiveForDraw()+" sourceMesh="+AssetDatabase.GetAssetPath(source.GetComponent<MeshFilter>().sharedMesh)+" forwardMesh="+AssetDatabase.GetAssetPath(child.GetComponent<MeshFilter>().sharedMesh));
  foreach(var name in mat.GetTexturePropertyNames()){var t=mat.GetTexture(name);log.AppendLine(name+"="+(t==null?"MISSING":AssetDatabase.GetAssetPath(t)));}
  var sv=SceneView.lastActiveSceneView;if(sv!=null)log.AppendLine("SceneView mode="+sv.cameraMode.drawMode+" sceneLighting="+sv.sceneLighting+" cameraPosition="+sv.camera.transform.position+" cameraRotation="+sv.camera.transform.rotation);
  File.WriteAllText(Dir+"/live_status.txt",log.ToString());
 }
 static void CheckView(Camera camera,string label,int width,int height,StringBuilder log){
  var old=camera.targetTexture;var active=RenderTexture.active;var rt=new RenderTexture(width,height,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);rt.Create();
  try{
   Shader.SetGlobalTexture("_EID4789_AuxiliaryMRT",null);camera.targetTexture=rt;using (EID4730.EID4730RenderFeature.BeginIsolatedAttachmentDiagnostics()) { camera.Render();camera.Render(); }
   var aux=Shader.GetGlobalTexture("_EID4789_AuxiliaryMRT") as RenderTexture;if(aux==null)throw new Exception(label+": EID4789 auxiliary missing (RenderFeature not executed)");
   var mask=Read(aux);camera.Render();camera.Render();var colors=Read(rt);
   if(EID4730RenderFeature.LastAuxiliaryClearCount!=1||EID4730RenderFeature.LastDrawGroupCount!=10)throw new Exception("Normal shared-MRT path not active (expected 1 clear/10 groups)");
   log.AppendLine(label+" production shared MRT clears="+EID4730RenderFeature.LastAuxiliaryClearCount+" groups="+EID4730RenderFeature.LastDrawGroupCount);
   if(mask.Length!=colors.Length)throw new Exception(label+": render target sizes mismatch");
   int visible=0,lit=0,bad=0,x0=width,y0=height,x1=-1,y1=-1;float max=0;
   for(int i=0;i<mask.Length;i++){
    var m=mask[i];if(m.r+m.g+m.b<=1e-4f)continue;visible++;int x=i%width,y=i/width;x0=Mathf.Min(x0,x);y0=Mathf.Min(y0,y);x1=Mathf.Max(x1,x);y1=Mathf.Max(y1,y);
    var c=colors[i];if(float.IsNaN(c.r)||float.IsInfinity(c.r)||float.IsNaN(c.g)||float.IsInfinity(c.g)||float.IsNaN(c.b)||float.IsInfinity(c.b)){bad++;continue;}
    float peak=Mathf.Max(c.r,Mathf.Max(c.g,c.b));max=Mathf.Max(max,peak);if(peak>1e-4f)lit++;
   }
   log.AppendLine(label+" cameraType="+camera.cameraType+" size="+width+"x"+height+" modelMask="+visible+" finalNonBlackOnMask="+lit+" nonfinite="+bad+" maxRGB="+max+" bboxBottomLeft="+x0+","+y0+","+x1+","+y1);
   Save(colors,width,height,label+"_camera");Save(mask,width,height,label+"_model_mask");
   if(bad>0||(visible>0&&lit==0))throw new Exception(label+": invalid/black final model color");
   log.AppendLine(label+(visible==0?" RESULT=INCONCLUSIVE: no model coverage":" RESULT=PASS: finite nonblack final color on model forward mask; not pixel equivalence"));
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
