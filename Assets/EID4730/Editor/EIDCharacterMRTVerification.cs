#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEngine.SceneManagement;
using EID4730;
[InitializeOnLoad]
public static class EIDCharacterMRTVerification
{
 const string Dir=".rdctools/character_mrt_fix";
 static double next;
 static EIDCharacterMRTVerification(){EditorApplication.update+=Tick;}
 static void Tick(){
  if(Application.isBatchMode||EditorApplication.isCompiling||EditorApplication.isUpdating||EditorApplication.timeSinceStartup<next)return;
  next=EditorApplication.timeSinceStartup+1;var request=Dir+"/editor_request.txt";if(!File.Exists(request))return;File.Delete(request);Verify();
 }
 [MenuItem("Tools/EID4730/Verify Shared Character MRT In Current Scene")]
 public static void Verify(){
  Directory.CreateDirectory(Dir);var log=new StringBuilder();var scene=SceneManager.GetActiveScene();log.AppendLine("time="+DateTime.Now.ToString("O")+" GPU="+SystemInfo.graphicsDeviceType+" scene="+scene.path+" dirty="+scene.isDirty);
  try{
   var main=GameObject.Find("EID3336 RenderDoc Camera");if(main==null)throw new Exception("Existing camera missing. Will not open a scene.");
   Check(main.GetComponent<Camera>(),"GameCamera",1366,768,log);
   var hair=GameObject.Find("EID1717_instance_000");if(hair!=null){var temp=new GameObject("Temporary MRT verification camera"){hideFlags=HideFlags.HideAndDontSave};try{
    var c=temp.AddComponent<Camera>();c.CopyFrom(main.GetComponent<Camera>());c.enabled=false;c.targetTexture=null;var center=hair.transform.TransformPoint(hair.GetComponent<MeshFilter>().sharedMesh.bounds.center);
    c.transform.position=center+hair.transform.TransformDirection(new Vector3(0,.02f,.75f));c.transform.LookAt(center,Vector3.up);c.orthographic=false;c.fieldOfView=35;c.aspect=1;c.nearClipPlane=.01f;c.farClipPlane=100;Check(c,"HairCloseup",512,512,log);
   }finally{UnityEngine.Object.DestroyImmediate(temp);}}
   log.AppendLine("RESULT=PASS: shared-MRT structure and finite character coverage; see color checks for exact/INCONCLUSIVE status. Not capture pixel equivalence. Scene not opened/saved, original objects/materials not edited.");
  }catch(Exception e){log.AppendLine("RESULT=FAIL\n"+e);Debug.LogException(e);}
  finally{File.WriteAllText(Dir+"/live_verification.txt",log.ToString());SceneView.RepaintAll();}
 }
 static void Check(Camera c,string label,int w,int h,StringBuilder log){
  var old=c.targetTexture;var active=RenderTexture.active;var rt=new RenderTexture(w,h,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);rt.Create();
  var stage=new RenderTexture(w,h,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);stage.Create();
  var previousHook=EID4730RenderFeature.CaptureCharacterColorForDiagnostics;
  EID4730RenderFeature.CaptureCharacterColorForDiagnostics=(cmd,source)=>cmd.Blit(source.nameID,stage);
  try{
   c.targetTexture=rt;Color[] control,controlStage,controlFirstStage;
   using(EID4730RenderFeature.BeginIsolatedAttachmentDiagnostics()){c.Render();controlFirstStage=Read(stage);c.Render();control=Read(rt);controlStage=Read(stage);log.AppendLine(label+" diagnostic clears="+EID4730RenderFeature.LastAuxiliaryClearCount);}
   c.Render();var sharedFirstStage=Read(stage);c.Render();var actual=Read(rt);var actualStage=Read(stage);int clears=EID4730RenderFeature.LastAuxiliaryClearCount,binds=EID4730RenderFeature.LastTargetBindingCount,groups=EID4730RenderFeature.LastDrawGroupCount;
   if(EID4730RenderFeature.LastCameraId!=c.GetInstanceID()||clears!=1||binds!=3||groups==0)throw new Exception(label+" counters incorrect: "+clears+","+binds+","+groups);
   var aux=Shader.GetGlobalTexture("_CharacterForward_AuxiliaryMRT") as RenderTexture;if(aux==null)throw new Exception("Shared MRT missing");var mask=ReadAux(aux);int bad=0,coverage=0,lit=0,diff=0;float max=0,stageMaskMax=0,controlTemporalMax=0,sharedTemporalMax=0;double sum=0;
   for(int i=0;i<actual.Length;i++){var a=actual[i];var b=control[i];if(float.IsNaN(a.r)||float.IsInfinity(a.r)||float.IsNaN(a.g)||float.IsInfinity(a.g)||float.IsNaN(a.b)||float.IsInfinity(a.b)){bad++;continue;}float e=Mathf.Max(Mathf.Abs(a.r-b.r),Mathf.Abs(a.g-b.g),Mathf.Abs(a.b-b.b));max=Mathf.Max(max,e);sum+=e;if(e>1e-4f)diff++;if(mask[i].r+mask[i].g+mask[i].b>1e-4f){coverage++;if(Mathf.Max(a.r,a.g,a.b)>1e-4f)lit++;
    stageMaskMax=Mathf.Max(stageMaskMax,Error(actualStage[i],controlStage[i]));
    controlTemporalMax=Mathf.Max(controlTemporalMax,Error(controlFirstStage[i],controlStage[i]));
    sharedTemporalMax=Mathf.Max(sharedTemporalMax,Error(sharedFirstStage[i],actualStage[i]));}}
   log.AppendLine(label+" production clears="+clears+" explicitTargetBinds="+binds+" drawGroups="+groups+" sharedCoverage="+coverage+" nonblackOnShared="+lit+" nonfinite="+bad+" RGBmaxError="+max+" RGBmeanMaxError="+(sum/actual.Length)+" changedPixels="+diff);
   log.AppendLine(label+" rawForwardStageOnSharedMask crossModeMax="+stageMaskMax+" sameControlModeMax="+controlTemporalMax+" sameSharedModeMax="+sharedTemporalMax);
   Save(control,w,h,label+"_control_camera");Save(controlStage,w,h,label+"_control_forward_stage");Save(actualStage,w,h,label+"_shared_forward_stage");Save(actual,w,h,label+"_camera");Save(mask,w,h,label+"_shared_auxiliary");
   if(bad>0)throw new Exception(label+" nonfinite camera output");
   if(stageMaskMax>1e-4f) {
    if(controlTemporalMax>1e-4f||sharedTemporalMax>1e-4f)log.AppendLine(label+" RGB=INCONCLUSIVE: same-mode repeated renders also change. Do not claim pixel equality.");
    else throw new Exception(label+" stable controls but changed forward color on shared mask");
   }else log.AppendLine(label+" rawForwardStageOnSharedMask=PASS: identical RGB within 1e-4");
   if(max>1e-4f)log.AppendLine(label+" fullFrameRGB=DIFFERENT: reported, not treated as proof of character equality; this project includes temporal rendering.");
   if(coverage==0)log.AppendLine(label+" coverage=INCONCLUSIVE");else if(lit==0)throw new Exception(label+" shared coverage all black");
   if(EID4730RenderFeature.IsolatedAttachmentDiagnostics)throw new Exception("Diagnostic scope leaked");
  }finally{EID4730RenderFeature.CaptureCharacterColorForDiagnostics=previousHook;c.targetTexture=old;RenderTexture.active=active;stage.Release();UnityEngine.Object.DestroyImmediate(stage);rt.Release();UnityEngine.Object.DestroyImmediate(rt);}
 }
 static float Error(Color a,Color b){return Mathf.Max(Mathf.Abs(a.r-b.r),Mathf.Abs(a.g-b.g),Mathf.Abs(a.b-b.b));}
 static Color[] Read(RenderTexture rt){var old=RenderTexture.active;RenderTexture.active=rt;var t=new Texture2D(rt.width,rt.height,TextureFormat.RGBAFloat,false,true);try{t.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0);t.Apply();return t.GetPixels();}finally{RenderTexture.active=old;UnityEngine.Object.DestroyImmediate(t);}}
 static Color[] ReadAux(RenderTexture rt){var tmp=new RenderTexture(rt.width,rt.height,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);tmp.Create();try{Graphics.Blit(rt,tmp);return Read(tmp);}finally{tmp.Release();UnityEngine.Object.DestroyImmediate(tmp);}}
 static void Save(Color[] input,int w,int h,string name){var p=new Color[input.Length];for(int i=0;i<p.Length;i++)p[i]=new Color(Mathf.LinearToGammaSpace(Mathf.Clamp01(input[i].r)),Mathf.LinearToGammaSpace(Mathf.Clamp01(input[i].g)),Mathf.LinearToGammaSpace(Mathf.Clamp01(input[i].b)),1);var t=new Texture2D(w,h,TextureFormat.RGBA32,false);try{t.SetPixels(p);t.Apply();File.WriteAllBytes(Dir+"/"+name+".png",t.EncodeToPNG());}finally{UnityEngine.Object.DestroyImmediate(t);}}
}
#endif
