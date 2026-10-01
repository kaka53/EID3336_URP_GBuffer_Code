#if UNITY_EDITOR
using System;using System.IO;using UnityEditor;using UnityEngine;using UnityEngine.Rendering;using EID4730;
[InitializeOnLoad]public static class EID4798PixelProbe{
const string D=".rdctools/eid1721_colorfix_1001";static bool active;static int mode,count;static double next;static Camera cam;
static EID4798PixelProbe(){EditorApplication.update+=Tick;AssemblyReloadEvents.beforeAssemblyReload+=Stop;}
static void Tick(){if(!active){if(EditorApplication.isCompiling||EditorApplication.isUpdating||!File.Exists(D+"/pixel_request.txt"))return;File.Delete(D+"/pixel_request.txt");active=true;mode=2;next=0;RenderPipelineManager.beginCameraRendering+=Begin;EID4730RenderFeature.CaptureHairForDiagnostics+=Stage;}
if(EditorApplication.timeSinceStartup<next)return;mode++;count=0;if(mode>12){Stop();return;}Shader.SetGlobalFloat("_EID4798DebugMode",mode);next=EditorApplication.timeSinceStartup+4;foreach(var w in Resources.FindObjectsOfTypeAll<EditorWindow>())if(w.GetType().Name=="GameView")w.Repaint();}
static void Begin(ScriptableRenderContext c,Camera camera){cam=camera;}
static void Stage(CommandBuffer cmd,RTHandle t,int eid){if(eid!=4798||cam==null||cam.cameraType!=CameraType.Game||count++>=2)return;int m=mode,w=t.rt.width,h=t.rt.height;cmd.RequestAsyncReadback(t.rt,0,TextureFormat.RGBAFloat,r=>{if(r.hasError)return;var a=r.GetData<float>();foreach(int y in new[]{350,370}){int i=(y*w+10)*4;File.AppendAllText(D+"/gpu_values.csv",m+","+y+","+a[i]+","+a[i+1]+","+a[i+2]+"\n");}});}
static void Stop(){if(!active)return;active=false;RenderPipelineManager.beginCameraRendering-=Begin;EID4730RenderFeature.CaptureHairForDiagnostics-=Stage;Shader.SetGlobalFloat("_EID4798DebugMode",0);File.WriteAllText(D+"/pixel_done.txt","Done");}
}
#endif
