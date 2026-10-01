#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using System.Reflection;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using EID4730;
[InitializeOnLoad] public static class EIDMultiViewTrace {
 const string D="D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/multiview_diagnosis_1001";
 static Camera cam; static double deadline,next; static bool armed; static int frames,step; static string run; static int gpuPairs; static StringBuilder log=new StringBuilder();
 static EIDMultiViewTrace(){EditorApplication.update+=Tick;AssemblyReloadEvents.beforeAssemblyReload+=Stop;}
 static string T(Texture t){return t==null?"null":t.name+"#"+t.GetInstanceID()+" "+t.width+"x"+t.height;}
 static string W(EditorWindow w){return w==null?"null":w.GetType().Name;}
 static void Tick(){try {
 if(!armed){if(EditorApplication.isCompiling||EditorApplication.isUpdating||!File.Exists(D+"/request.txt"))return;run=File.ReadAllText(D+"/request.txt").Trim();File.Delete(D+"/request.txt");log.Clear();frames=step=gpuPairs=0;armed=true;deadline=EditorApplication.timeSinceStartup+35;next=0;
 RenderPipelineManager.beginCameraRendering+=Begin;RenderPipelineManager.endCameraRendering+=End;
 EID4649ColourPass20Feature.CaptureInputsForDiagnostics+=Inputs;
 EID4730RenderFeature.CaptureBeforeEID4720ColorForDiagnostics+=Stage;
 EID4730RenderFeature.CaptureCharacterColorForDiagnostics+=Stage;
 log.AppendLine("START "+DateTime.Now.ToString("O"));
 foreach(var c in UnityEngine.Object.FindObjectsOfType<EID3332CombinedDeferredController>())log.AppendLine("Controller "+c.name+" mode="+c.lightPassMode);
 }
 if(EditorApplication.timeSinceStartup>deadline){Stop();return;}
 if(EditorApplication.timeSinceStartup<next)return;next=EditorApplication.timeSinceStartup+4;
 bool scene=(step++%2)==1; log.AppendLine("REPAINT request="+(scene?"Scene":"Game"));
 if(scene)SceneView.RepaintAll();else foreach(var w in Resources.FindObjectsOfTypeAll<EditorWindow>())if(w.GetType().Name=="GameView")w.Repaint();
 }catch(Exception e){log.AppendLine(e.ToString());Stop();}}
 static void Begin(ScriptableRenderContext c,Camera camera){cam=camera;log.AppendLine("BEGIN "+(++frames)+" "+cam.name+"#"+cam.GetInstanceID()+" "+cam.cameraType+" size="+cam.pixelWidth+"x"+cam.pixelHeight+" pos="+cam.transform.position.ToString("F4")+" hover="+W(EditorWindow.mouseOverWindow)+" focus="+W(EditorWindow.focusedWindow));}
 static void Stage(CommandBuffer cmd,RTHandle target){
 log.AppendLine("STAGE cam="+(cam==null?"null":cam.cameraType.ToString())+" color="+T(target.rt)+" worldCamera="+Shader.GetGlobalVector("_WorldSpaceCameraPos").ToString("F4")+" screen="+Shader.GetGlobalVector("_ScreenParams"));
 foreach(string n in new[]{"EID1727_instance_000","EID4725_instance_000","EID1717_instance_000","EID1622_instance_000"}){
 var go=GameObject.Find(n);if(go==null){log.AppendLine(n+" absent");continue;}
 foreach(var r in go.GetComponentsInChildren<Renderer>()){int i=0;foreach(var m in r.sharedMaterials){if(m==null){i++;continue;}var b=new MaterialPropertyBlock();r.GetPropertyBlock(b,i++);log.AppendLine(r.name+" mat="+m.name+"#"+m.GetInstanceID()+" shader="+m.shader.name);
 foreach(var p in m.GetTexturePropertyNames())if(p.EndsWith("_40")||p=="_40"||p=="_41")log.AppendLine(" "+p+" material="+T(m.GetTexture(p))+" mpb="+T(b.GetTexture(p))+" global="+T(Shader.GetGlobalTexture(p)));
 }} }
 foreach(var p in new[]{"_EndfieldGTAOBlur","_EndfieldContact","_EID4649ColourPass20RT"})log.AppendLine(p+"="+T(Shader.GetGlobalTexture(p)));
 }
 static void Inputs(CommandBuffer cmd,Camera camera,Texture blur,Texture contact,Texture blurCopy,Texture contactCopy){
 log.AppendLine("INPUTS "+camera.cameraType+"#"+camera.GetInstanceID()+" blur="+T(blur)+" contact="+T(contact)+" blurCopy="+T(blurCopy)+" contactCopy="+T(contactCopy)+" selfCopy="+(blur!=null&&blur==blurCopy||contact!=null&&contact==contactCopy));
 if(gpuPairs++>=4||contact==null||contactCopy==null)return;
 string label=run+"_"+frames+"_"+camera.cameraType;
 Probe(cmd,contact,label+"_source");Probe(cmd,contactCopy,label+"_copy");
 }
 static void Probe(CommandBuffer cmd,Texture texture,string label){
 cmd.RequestAsyncReadback(texture,0,TextureFormat.RGBA32,r=>{try{if(r.hasError){File.AppendAllText(D+"/gpu.txt",label+" ERROR\n");return;}
 var data=r.GetData<byte>();ulong hash=14695981039346656037UL;unchecked{for(int i=0;i<data.Length;i+=4){hash=(hash^data[i])*1099511628211UL;hash=(hash^data[i+1])*1099511628211UL;}}
 File.AppendAllText(D+"/gpu.txt",label+" RG="+hash.ToString("X16")+" bytes="+data.Length+"\n");}catch(Exception e){File.AppendAllText(D+"/gpu.txt",e+"\n");}});
 }
 static void Output(RenderTexture texture,string label){if(texture==null||!texture.IsCreated())return;int w=texture.width,h=texture.height;
 AsyncGPUReadback.Request(texture,0,TextureFormat.RGBA32,r=>{try{if(r.hasError){File.AppendAllText(D+"/gpu.txt",label+" OUTPUT_ERROR\n");return;}File.WriteAllBytes(D+"/"+label+"_"+w+"x"+h+".rgba",r.GetData<byte>().ToArray());}catch(Exception e){File.AppendAllText(D+"/gpu.txt",e+"\n");}});}
 static void End(ScriptableRenderContext c,Camera camera){
 log.AppendLine("END "+camera.cameraType+" target="+T(camera.targetTexture)+" CP26Draws="+ColourPass26HairPass.LastDrawCount);
 if(camera.cameraType==CameraType.SceneView)Output(camera.targetTexture,run+"_"+frames+"_Scene");
 if(camera.cameraType!=CameraType.Game)return;
 foreach(var w in Resources.FindObjectsOfTypeAll<EditorWindow>())if(w.GetType().Name=="GameView"){
 var f=w.GetType().GetField("m_RenderTexture",BindingFlags.Instance|BindingFlags.NonPublic|BindingFlags.Public);if(f!=null){var t=f.GetValue(w) as RenderTexture;log.AppendLine("GameView output="+T(t));Output(t,run+"_"+frames+"_Game");}}
 }
 static void Stop(){if(!armed)return;armed=false;RenderPipelineManager.beginCameraRendering-=Begin;RenderPipelineManager.endCameraRendering-=End;EID4649ColourPass20Feature.CaptureInputsForDiagnostics-=Inputs;EID4730RenderFeature.CaptureBeforeEID4720ColorForDiagnostics-=Stage;EID4730RenderFeature.CaptureCharacterColorForDiagnostics-=Stage;File.WriteAllText(D+"/trace.txt",log.ToString());File.WriteAllText(D+"/"+run+"_trace.txt",log.ToString());}
}
#endif
