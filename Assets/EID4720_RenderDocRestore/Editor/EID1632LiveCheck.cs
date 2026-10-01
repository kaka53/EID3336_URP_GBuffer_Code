#if UNITY_EDITOR
using System;using System.IO;using System.Text;using UnityEditor;using UnityEngine;using EID4730;
[InitializeOnLoad] public static class EID1632LiveCheck {
 const string D="D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/eid1632_repair_0930";static double next;
 static EID1632LiveCheck(){EditorApplication.update+=Tick;next=EditorApplication.timeSinceStartup+10;}
 static void Tick(){if(EditorApplication.isCompiling||EditorApplication.isUpdating||EditorApplication.timeSinceStartup<next||!File.Exists(D+"/live.request"))return;File.Delete(D+"/live.request");try{
  var src=GameObject.Find("EID1632_instance_000");var go=GameObject.Find("EID4720_Forward_for_EID1632");if(src==null||go==null)throw new Exception("Objects not loaded");var mat=go.GetComponent<Renderer>().sharedMaterial;
  EID4720Install.Direct(src,go,mat,"live_front",false);EID4720Install.Direct(src,go,mat,"live_capture",true);
  var s=new StringBuilder(DateTime.Now.ToString("O")+"\nscene="+src.scene.path+"\nshaderErrors="+ShaderUtil.ShaderHasError(mat.shader)+"\nbinders="+EID4720ReplayBinder.PrepareActiveForDraw()+"\n");foreach(var m in ShaderUtil.GetShaderMessages(mat.shader))s.AppendLine(m.severity+" "+m.message);File.WriteAllText(D+"/live_result.txt",s.ToString());
  Selection.activeGameObject=src;var sv=SceneView.lastActiveSceneView;if(sv!=null){var center=go.GetComponent<Renderer>().bounds.center;var dir=src.transform.TransformDirection(new Vector3(-.08882f,-.42035f,.903f));sv.LookAt(center,Quaternion.LookRotation(-dir,Vector3.up),.3f,false,true);sv.Repaint();}
 }catch(Exception e){File.WriteAllText(D+"/live_result.txt",e.ToString());} }
}
#endif
