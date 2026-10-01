#if UNITY_EDITOR
using System;
using System.IO;
using System.Reflection;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using EID4730;
[InitializeOnLoad]
public static class EID4780LiveStability {
 const string D="D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/eid4780_stability_0930";
 static bool armed,game,ready,wantScene,focusOnly; static Material auditMaterial; static Camera capturedCamera; static int hits; static string label; static RenderTexture rt,pre; static string atDraw;
 static EID4780LiveStability(){EditorApplication.update+=Tick;AssemblyReloadEvents.beforeAssemblyReload+=Cleanup;}
 static void Repaint(){if(focusOnly){if(wantScene){SceneView.lastActiveSceneView.Focus();SceneView.lastActiveSceneView.Repaint();}else foreach(var w in Resources.FindObjectsOfTypeAll<EditorWindow>())if(w.GetType().Name=="GameView"){w.Focus();w.Repaint();}EditorApplication.QueuePlayerLoopUpdate();return;}SceneView.RepaintAll();foreach(var w in Resources.FindObjectsOfTypeAll<EditorWindow>())if(w.GetType().Name=="GameView")w.Repaint();EditorApplication.QueuePlayerLoopUpdate();}
 static void Tick(){
  if(ready){try{Save();}catch(Exception e){File.WriteAllText(D+"/error.txt",e.ToString());}finally{Cleanup();}return;}
  if(armed||EditorApplication.isCompiling||EditorApplication.isUpdating||!File.Exists(D+"/request.txt"))return;
  var request=File.ReadAllText(D+"/request.txt").Trim().Split('|');File.Delete(D+"/request.txt");label=request[0];wantScene=request.Length>1&&request[1]=="scene";focusOnly=wantScene||(request.Length>1&&request[1]=="game");
  try {
   if(request.Length>1&&request[1]=="import") {AssetDatabase.ImportAsset("Assets/EID4780_RenderDocRestore/Shaders/EID4780_CharacterForward.shader",ImportAssetOptions.ForceUpdate);}
   if(request.Length>1&&request[1]=="material") {AssetDatabase.ImportAsset("Assets/EID4780_RenderDocRestore/M_EID4780.mat",ImportAssetOptions.ForceUpdate);}
   if(request.Length>1&&request[1]=="audit"){auditMaterial=GameObject.Find("EID4780_instance_000").GetComponent<Renderer>().sharedMaterial;auditMaterial.SetFloat("_EID4780CoordinateAudit",1);}
   hits=0;rt=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);rt.Create();armed=true;
   RenderPipelineManager.beginCameraRendering+=Begin;RenderPipelineManager.endCameraRendering+=End;
   EID4730RenderFeature.CaptureEID4765ColorForDiagnostics=(cmd,target)=>{if(game){int w=target.rt!=null?target.rt.width:1366,h=target.rt!=null?target.rt.height:768;pre=new RenderTexture(w,h,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);pre.Create();cmd.Blit(target.nameID,pre);RestoreMRT(cmd,target);}};
   EID4730RenderFeature.CaptureEID4780ColorForDiagnostics=(cmd,target)=>{if(game){if(target.rt!=null&&(rt.width!=target.rt.width||rt.height!=target.rt.height)){rt.Release();UnityEngine.Object.DestroyImmediate(rt);rt=new RenderTexture(target.rt.width,target.rt.height,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);rt.Create();}cmd.Blit(target.nameID,rt);
    RestoreMRT(cmd,target);
    var renderer=GameObject.Find("EID4780_instance_000").GetComponent<Renderer>();var block=new MaterialPropertyBlock();renderer.GetPropertyBlock(block,0);var tex=block.GetTexture("_41");atDraw="draw camera="+capturedCamera.cameraType+" MPB40="+(tex==null?"null":tex.name+" "+tex.width+"x"+tex.height);

    hits++;}};
   Repaint();
  }catch(Exception e){File.WriteAllText(D+"/error.txt",e.ToString());Cleanup();}
 }
 static void RestoreMRT(CommandBuffer cmd,RTHandle target){
    var feature=AssetDatabase.LoadAssetAtPath<UnityEngine.Rendering.Universal.ScriptableRendererData>("Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-Renderer.asset");
    foreach(var f in feature.rendererFeatures)if(f is EID4730RenderFeature){var pass=f.GetType().GetField("pass",BindingFlags.NonPublic|BindingFlags.Instance).GetValue(f);var aux=(RTHandle)pass.GetType().GetProperty("SharedAuxiliary").GetValue(pass);var depth=(RTHandle)pass.GetType().GetField("depthTarget",BindingFlags.NonPublic|BindingFlags.Instance).GetValue(pass);cmd.SetRenderTarget(new RenderTargetIdentifier[]{target.nameID,aux.nameID},depth.nameID);}
 }
 static void Begin(ScriptableRenderContext c,Camera cam){game=wantScene?cam.cameraType==CameraType.SceneView:cam.cameraType==CameraType.Game&&cam.name=="EID3336 RenderDoc Camera";if(game)capturedCamera=cam;}
 static void End(ScriptableRenderContext c,Camera cam){if(game&&cam==capturedCamera){ready=true;game=false;}}
 static void Save(){
  if(pre!=null){var oldRT=RenderTexture.active;var cpu=new Texture2D(pre.width,pre.height,TextureFormat.RGBAFloat,false,true);try{RenderTexture.active=pre;cpu.ReadPixels(new Rect(0,0,pre.width,pre.height),0,0);cpu.Apply();File.WriteAllBytes(D+"/"+label+"_pre.f32",cpu.GetRawTextureData());}finally{RenderTexture.active=oldRT;UnityEngine.Object.DestroyImmediate(cpu);}}

  var old=RenderTexture.active;var t=new Texture2D(rt.width,rt.height,TextureFormat.RGBAFloat,false,true);
  try{RenderTexture.active=rt;t.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0);t.Apply();File.WriteAllBytes(D+"/"+label+".f32",t.GetRawTextureData());}finally{RenderTexture.active=old;UnityEngine.Object.DestroyImmediate(t);}
  var o=GameObject.Find("EID4780_instance_000");var mat=o.GetComponent<Renderer>().sharedMaterial;
  var s=new StringBuilder(DateTime.Now.ToString("O")+"\nscene="+o.scene.path+"\nhits="+hits+" shaderErrors="+ShaderUtil.ShaderHasError(mat.shader)+"\n");
  foreach(var msg in ShaderUtil.GetShaderMessages(mat.shader)) s.AppendLine(msg.severity+" "+msg.message+" "+msg.file+":"+msg.line);s.AppendLine(atDraw);s.AppendLine("CapturedMode="+mat.GetFloat("_EID4780UseCapturedScreen40"));
  s.AppendLine("camera="+capturedCamera.name+" type="+capturedCamera.cameraType+" rt="+rt.width+"x"+rt.height+" pixel="+capturedCamera.pixelWidth+"x"+capturedCamera.pixelHeight+" frame="+Time.frameCount);
  var block=new MaterialPropertyBlock();o.GetComponent<Renderer>().GetPropertyBlock(block,0);var mp=block.GetTexture("_41");s.AppendLine("MPB40="+(mp==null?"null":mp.name+" "+mp.width+"x"+mp.height));
  var light=mat.GetTexture("_41");s.AppendLine("MAT40="+(light==null?"null":light.name+" "+light.width+"x"+light.height));
  foreach(string n in mat.GetTexturePropertyNames()){var tex=mat.GetTexture(n);s.AppendLine(n+"="+(tex==null?"null":AssetDatabase.GetAssetPath(tex)+" "+tex.graphicsFormat));}
  File.WriteAllText(D+"/"+label+".txt",s.ToString());
  foreach(var w in Resources.FindObjectsOfTypeAll<EditorWindow>())if(w.GetType().Name=="GameView")for(Type type=w.GetType();type!=null;type=type.BaseType){var f=type.GetField("m_RenderTexture",BindingFlags.Instance|BindingFlags.NonPublic|BindingFlags.Public|BindingFlags.DeclaredOnly);if(f==null)continue;var target=f.GetValue(w) as RenderTexture;if(target==null)continue;var cpu=new Texture2D(target.width,target.height,TextureFormat.RGBA32,false);try{old=RenderTexture.active;RenderTexture.active=target;cpu.ReadPixels(new Rect(0,0,target.width,target.height),0,0);cpu.Apply();File.WriteAllBytes(D+"/"+label+"_game.png",cpu.EncodeToPNG());}finally{RenderTexture.active=old;UnityEngine.Object.DestroyImmediate(cpu);}}
 }
 static void Cleanup(){if(armed)EID4730RenderFeature.CaptureEID4765ColorForDiagnostics=null;if(pre!=null){pre.Release();UnityEngine.Object.DestroyImmediate(pre);pre=null;}if(auditMaterial!=null){auditMaterial.SetFloat("_EID4780CoordinateAudit",0);auditMaterial=null;Repaint();}RenderPipelineManager.beginCameraRendering-=Begin;RenderPipelineManager.endCameraRendering-=End;if(armed)EID4730RenderFeature.CaptureEID4780ColorForDiagnostics=null;armed=ready=game=false;if(rt!=null){rt.Release();UnityEngine.Object.DestroyImmediate(rt);rt=null;}}
}
#endif