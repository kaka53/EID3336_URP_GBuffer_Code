#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEngine.SceneManagement;
using EID4730;

[InitializeOnLoad]
public static class EID4725BlackDiagnostics
{
 const string Dir=".rdctools/eid4725_blackfix";
 static double next;
 static EID4725BlackDiagnostics(){EditorApplication.update+=Tick;}
 static void Tick(){
  if(Application.isBatchMode||EditorApplication.isCompiling||EditorApplication.isUpdating||EditorApplication.timeSinceStartup<next)return;
  next=EditorApplication.timeSinceStartup+1;var path=Dir+"/editor_request.txt";if(!File.Exists(path))return;
  string action=File.ReadAllText(path).Trim();File.Delete(path);
  try{if(action=="verify_views")VerifyCurrentViews();else if(action=="rebind")Rebind();else if(action=="status")Status();else throw new Exception("Unknown request "+action);File.WriteAllText(Dir+"/editor_result.txt","COMPLETED "+action+" "+DateTime.Now.ToString("O")+"; inspect live_views.txt for per-view PASS/INCONCLUSIVE status");}
  catch(Exception e){File.WriteAllText(Dir+"/editor_result.txt","FAIL\n"+e);Debug.LogException(e);}
 }
 [MenuItem("Tools/EID4725/Rebind Forward Resources")]
 public static void Rebind(){
  foreach(var b in UnityEngine.Object.FindObjectsOfType<EID4725ReplayBinder>(true))if(b.isActiveAndEnabled)b.Rebind();
  int count=EID4725ReplayBinder.PrepareActiveForDraw();SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();Status();Debug.Log("[EID4725] Rebound forward materials="+count+"; geometry, shader algorithm, material colors and transform unchanged.");
 }
 static void Status(){
  Directory.CreateDirectory(Dir);var log=new StringBuilder();log.AppendLine("device="+SystemInfo.graphicsDeviceType+" scene="+SceneManager.GetActiveScene().path+" dirty="+SceneManager.GetActiveScene().isDirty);
  var go=GameObject.Find("EID4725_instance_000");if(go==null)throw new Exception("The current loaded scene has no active EID4725_instance_000; not reopening or overwriting your scene.");
  var r=go.GetComponent<Renderer>();var m=r.sharedMaterial;var mesh=go.GetComponent<MeshFilter>().sharedMesh;
  log.AppendLine("enabled="+r.enabled+" active="+go.activeInHierarchy+" vertices="+mesh.vertexCount+" indices="+mesh.GetIndexCount(0)+" M="+go.transform.localToWorldMatrix);
  log.AppendLine("material="+AssetDatabase.GetAssetPath(m)+" shader="+m.shader.name+" queue="+m.renderQueue+" facePass="+m.GetShaderPassEnabled("EID4725CharacterForward"));
  var binder=go.GetComponent<EID4725ReplayBinder>();log.AppendLine("binderEnabled="+(binder!=null&&binder.isActiveAndEnabled)+" binderMaterialMatches="+(binder!=null&&binder.material==m));
  foreach(string name in m.GetTexturePropertyNames()){var t=m.GetTexture(name);log.AppendLine(name+"="+(t!=null?AssetDatabase.GetAssetPath(t):"MISSING"));}
  var sv=SceneView.lastActiveSceneView;if(sv!=null){log.AppendLine("SceneView drawMode="+sv.cameraMode.drawMode+" sceneLighting="+sv.sceneLighting);if(sv.camera!=null)log.AppendLine("SceneView camera position="+sv.camera.transform.position+" rotation="+sv.camera.transform.rotation+" dimensions="+sv.camera.pixelWidth+"x"+sv.camera.pixelHeight);}
  File.WriteAllText(Dir+"/live_status.txt",log.ToString());
 }
 [MenuItem("Tools/EID4725/Verify Game And SceneView Face")]
 public static void VerifyCurrentViews(){
  Status();var go=GameObject.Find("EID3336 RenderDoc Camera");if(go==null)throw new Exception("Missing capture camera");var log=new StringBuilder();log.AppendLine("device="+SystemInfo.graphicsDeviceType);
  log.AppendLine("Camera rerenders with temporary targets, not an on-screen editor screenshot. No scene is reopened or saved.");
  try {
   CheckView(go.GetComponent<Camera>(),"GameCamera",1366,768,log);
   var sv=SceneView.lastActiveSceneView;
   if(sv!=null&&sv.camera!=null)CheckView(sv.camera,"SceneView",Mathf.Max(1,sv.camera.pixelWidth),Mathf.Max(1,sv.camera.pixelHeight),log);
   else log.AppendLine("SceneView RESULT=INCONCLUSIVE: no active SceneView camera.");
  } catch(Exception e){log.AppendLine("RESULT=FAIL "+e.Message);throw;}
  finally {File.WriteAllText(Dir+"/live_views.txt",log.ToString());Debug.Log(log.ToString());SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();}
 }
 static void CheckView(Camera camera,string label,int width,int height,StringBuilder log){
  var old=camera.targetTexture;var active=RenderTexture.active;var rt=new RenderTexture(width,height,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);rt.Create();
  try{
   camera.targetTexture=rt;using (EID4730.EID4730RenderFeature.BeginIsolatedAttachmentDiagnostics()) { camera.Render();camera.Render(); }var aux=Shader.GetGlobalTexture("_EID4725_AuxiliaryMRT") as RenderTexture;
   if(aux==null)throw new Exception(label+": face auxiliary target is missing");
   var colors=Read(rt);var mask=Read(aux);int visible=0,lit=0,bad=0;float max=0;
   if(mask.Length!=colors.Length)throw new Exception(label+": mismatched face target dimensions");
   for(int i=0;i<mask.Length;i++){if(mask[i].r+mask[i].g+mask[i].b<=1e-4f)continue;visible++;var c=colors[i];if(float.IsNaN(c.r)||float.IsNaN(c.g)||float.IsNaN(c.b)||float.IsInfinity(c.r)||float.IsInfinity(c.g)||float.IsInfinity(c.b)){bad++;continue;}float peak=Mathf.Max(c.r,Mathf.Max(c.g,c.b));max=Mathf.Max(max,peak);if(peak>1e-4f)lit++;}
   log.AppendLine(label+" cameraType="+camera.cameraType+" dimensions="+width+"x"+height+" faceMaskPixels="+visible+" finalColorNonBlackOnMask="+lit+" nonfinite="+bad+" maxRGB="+max);
   Save(colors,width,height,label+"_camera");Save(mask,width,height,label+"_face_mask");
   if(bad>0)throw new Exception(label+": nonfinite face color");
   if(visible>0&&lit==0)throw new Exception(label+": face wrote its mask but the final color is black");
   if(visible==0)log.AppendLine(label+" RESULT=INCONCLUSIVE: no face coverage; this camera is NOT accepted as a face-color pass.");
   else log.AppendLine(label+" RESULT=PASS finite nonblack final color overlaps the forward mask (not a RenderDoc pixel-equivalence claim).");
  }finally{camera.targetTexture=old;RenderTexture.active=active;rt.Release();UnityEngine.Object.DestroyImmediate(rt);}
 }
 static Color[] Read(RenderTexture source){
  var staging=new RenderTexture(source.width,source.height,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);staging.Create();Texture2D cpu=null;var active=RenderTexture.active;
  try{Graphics.Blit(source,staging);RenderTexture.active=staging;cpu=new Texture2D(source.width,source.height,TextureFormat.RGBAFloat,false,true);cpu.ReadPixels(new Rect(0,0,source.width,source.height),0,0);cpu.Apply();return cpu.GetPixels();}
  finally{RenderTexture.active=active;if(cpu!=null)UnityEngine.Object.DestroyImmediate(cpu);staging.Release();UnityEngine.Object.DestroyImmediate(staging);}
 }
 static void Save(Color[] source,int width,int height,string name){
  var colors=new Color[source.Length];for(int i=0;i<source.Length;i++){var c=source[i];colors[i]=new Color(Mathf.LinearToGammaSpace(Mathf.Clamp01(c.r)),Mathf.LinearToGammaSpace(Mathf.Clamp01(c.g)),Mathf.LinearToGammaSpace(Mathf.Clamp01(c.b)),1);}
  var png=new Texture2D(width,height,TextureFormat.RGBA32,false);try{png.SetPixels(colors);png.Apply();File.WriteAllBytes(Dir+"/"+name+"_"+SystemInfo.graphicsDeviceType+".png",png.EncodeToPNG());}finally{UnityEngine.Object.DestroyImmediate(png);}
 }
}
#endif
