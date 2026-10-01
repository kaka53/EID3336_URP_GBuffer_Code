#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using System.Reflection;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using EID4730;
[InitializeOnLoad]
public static class CP26LiveInspection {
 const string D="D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/cp26_regression_20260930";
 static double next;
 static bool capturing,ready,game,oldAlways;
 static RenderTexture pre,post;
 static void Begin(ScriptableRenderContext c,Camera cam){game=cam.name=="EID3336 RenderDoc Camera"&&cam.cameraType==CameraType.Game;}
 static void End(ScriptableRenderContext c,Camera cam){if(game&&cam.name=="EID3336 RenderDoc Camera"){ColourPass26HairPass.DiagnosticAlways=oldAlways;ready=true;game=false;}}
 static void Arm(){
  oldAlways=ColourPass26HairPass.DiagnosticAlways; ColourPass26HairPass.DiagnosticAlways=File.Exists(D+"/always.request"); if(File.Exists(D+"/always.request"))File.Delete(D+"/always.request");
  pre=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat);post=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat);pre.Create();post.Create();capturing=true;
  RenderPipelineManager.beginCameraRendering+=Begin;RenderPipelineManager.endCameraRendering+=End;
  ColourPass26HairPass.Capture=(cmd,target,eid,after)=>{if(!game)return;if(eid==5046&&!after)cmd.Blit(target.nameID,pre);if(eid==5062&&after)cmd.Blit(target.nameID,post);};
  foreach(var w in Resources.FindObjectsOfTypeAll<EditorWindow>())if(w.GetType().Name=="GameView")w.Repaint();EditorApplication.QueuePlayerLoopUpdate();
 }
 static void Finish(){RenderPipelineManager.beginCameraRendering-=Begin;RenderPipelineManager.endCameraRendering-=End;ColourPass26HairPass.Capture=null;Dump(pre,"live_stage_before");Dump(post,"live_stage_after");DumpFloat(pre,"live_stage_before");DumpFloat(post,"live_stage_after");pre.Release();post.Release();UnityEngine.Object.DestroyImmediate(pre);UnityEngine.Object.DestroyImmediate(post);ready=capturing=false;Inspect();}
 static void DumpFloat(RenderTexture rt,string name){var old=RenderTexture.active;var t=new Texture2D(rt.width,rt.height,TextureFormat.RGBAFloat,false,true);RenderTexture.active=rt;t.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0);t.Apply();File.WriteAllBytes(D+"/"+name+".f32",t.GetRawTextureData());RenderTexture.active=old;UnityEngine.Object.DestroyImmediate(t);}

 static CP26LiveInspection(){next=EditorApplication.timeSinceStartup+15;EditorApplication.update+=Tick;}
 static void Tick(){
 if(!capturing&&!EditorApplication.isCompiling&&!EditorApplication.isUpdating&&File.Exists(D+"/reimport.request")){
 File.Delete(D+"/reimport.request");AssetDatabase.ImportAsset("Assets/ColourPass26Hair/Shaders/CP26F.shader",ImportAssetOptions.ForceUpdate);AssetDatabase.ImportAsset("Assets/ColourPass26Hair/Shaders/CP26B.shader",ImportAssetOptions.ForceUpdate);SceneView.RepaintAll();foreach(var w in Resources.FindObjectsOfTypeAll<EditorWindow>())if(w.GetType().Name=="GameView")w.Repaint();return;}
 if(ready){Finish();return;}if(!capturing&&!EditorApplication.isCompiling&&!EditorApplication.isUpdating&&File.Exists(D+"/capture.request")){File.Move(D+"/capture.request",D+"/capture_"+DateTime.Now.ToString("yyyyMMdd_HHmmss")+".txt");Arm();return;}if(EditorApplication.isCompiling||EditorApplication.isUpdating||EditorApplication.timeSinceStartup<next||!File.Exists(D+"/inspect.request"))return;next=EditorApplication.timeSinceStartup+30;File.Move(D+"/inspect.request",D+"/inspect_"+DateTime.Now.ToString("yyyyMMdd_HHmmss")+".txt");Inspect();}
 [MenuItem("Tools/ColourPass26/Inspect Current Views")]
 public static void Inspect(){var s=new StringBuilder();try{
  s.AppendLine("Time="+DateTime.Now.ToString("O")+" scene="+UnityEngine.SceneManagement.SceneManager.GetActiveScene().path);
  s.AppendLine("Quality="+QualitySettings.GetQualityLevel()+" Pipeline="+AssetDatabase.GetAssetPath(GraphicsSettings.currentRenderPipeline));
  s.AppendLine("DiagnosticDisable="+ColourPass26HairPass.DiagnosticDisable+" LastDrawCount="+ColourPass26HairPass.LastDrawCount);
  foreach(var cam in Camera.allCameras){s.AppendLine("Camera "+cam.name+" type="+cam.cameraType+" size="+cam.pixelWidth+"x"+cam.pixelHeight+" enabled="+cam.enabled+" aspect="+cam.aspect);}
  foreach(var rd in Resources.FindObjectsOfTypeAll<ScriptableRendererData>())foreach(var feature in rd.rendererFeatures)if(feature is EID4730RenderFeature f){
   s.AppendLine("Feature "+AssetDatabase.GetAssetPath(rd)+" active="+f.isActive+" hair="+f.enableColourPass26Hair);
   var pass=typeof(EID4730RenderFeature).GetField("hairPass",BindingFlags.Instance|BindingFlags.NonPublic).GetValue(f);
   if(pass!=null)foreach(string field in new[]{"failed","color","depth","aux","materials"}){var v=pass.GetType().GetField(field,BindingFlags.Instance|BindingFlags.NonPublic).GetValue(pass);s.AppendLine(field+"="+(v==null?"null":v.ToString()));}
  }
  foreach(string name in new[]{"EID1717_instance_000","EID1721_instance_000"}){var o=GameObject.Find(name);s.AppendLine(name+"="+(o==null?"missing":("active="+o.activeInHierarchy+" renderer="+o.GetComponent<Renderer>().enabled+" shader="+o.GetComponent<Renderer>().sharedMaterial.shader.name)));}
  foreach(var w in Resources.FindObjectsOfTypeAll<EditorWindow>()){
   if(w.GetType().Name!="GameView")continue;s.AppendLine("GameView "+w.position);
   for(Type t=w.GetType();t!=null;t=t.BaseType)foreach(var f in t.GetFields(BindingFlags.Instance|BindingFlags.Public|BindingFlags.NonPublic|BindingFlags.DeclaredOnly)){
    if(typeof(RenderTexture).IsAssignableFrom(f.FieldType)){var rt=f.GetValue(w) as RenderTexture;s.AppendLine("RT "+f.Name+"="+(rt==null?"null":rt.width+"x"+rt.height));if(rt!=null&&rt.IsCreated())Dump(rt,"live_"+f.Name);}
   }
  }
 }catch(Exception e){s.AppendLine(e.ToString());}File.WriteAllText(D+"/live_inspection.txt",s.ToString());}
 static void Dump(RenderTexture rt,string name){var old=RenderTexture.active;var cpu=new Texture2D(rt.width,rt.height,TextureFormat.RGBA32,false);try{RenderTexture.active=rt;cpu.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0);cpu.Apply();File.WriteAllBytes(D+"/"+name+".png",cpu.EncodeToPNG());}finally{RenderTexture.active=old;UnityEngine.Object.DestroyImmediate(cpu);}}
}
#endif
