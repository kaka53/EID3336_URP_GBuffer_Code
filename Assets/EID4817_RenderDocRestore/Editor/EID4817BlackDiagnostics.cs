#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEngine.SceneManagement;
[InitializeOnLoad]
public static class EID4817BlackDiagnostics
{
 const string Dir=".rdctools/eid4817_blackfix";
 static double next;
 static EID4817BlackDiagnostics(){EditorApplication.update+=Tick;Directory.CreateDirectory(Dir);File.WriteAllText(Dir+"/runner_ready.txt",DateTime.Now.ToString("O"));}
 static void Tick(){
  if(EditorApplication.timeSinceStartup<next||EditorApplication.isCompiling||EditorApplication.isUpdating)return;
  next=EditorApplication.timeSinceStartup+1;
  var path=Dir+"/request.txt";if(!File.Exists(path))return;
  var action=File.ReadAllText(path).Trim();File.Delete(path);
  try{ if(action=="status") Status();else if(action=="rebind") RebindForwardResources();else throw new Exception("Unknown request: "+action);File.WriteAllText(Dir+"/result.txt","PASS "+action+" "+DateTime.Now.ToString("O")); }
  catch(Exception e){File.WriteAllText(Dir+"/result.txt",e.ToString());Debug.LogException(e);}
 }
 [MenuItem("Tools/EID4817/Rebind Forward Resources")]
 public static void RebindForwardResources()
 {
  foreach(var b in UnityEngine.Object.FindObjectsOfType<EID4730.EID4817ReplayBinder>(true))
   if(b.isActiveAndEnabled)b.Rebind();
  int count=EID4730.EID4817ReplayBinder.PrepareActiveForDraw();
  SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();
  Status();Debug.Log("[EID4817] Rebound active forward materials: "+count+". Mesh, M, textures, shader algorithms and render queue were not changed.");
 }
 static void Status(){
  var b=new StringBuilder();b.AppendLine("device="+SystemInfo.graphicsDeviceType+" playing="+EditorApplication.isPlaying);
  for(int i=0;i<SceneManager.sceneCount;i++){var s=SceneManager.GetSceneAt(i);b.AppendLine("scene="+s.path+" dirty="+s.isDirty);}
  foreach(var r in UnityEngine.Object.FindObjectsOfType<MeshRenderer>(true)){
   if(!r.name.Contains("4817"))continue;
   b.AppendLine("renderer="+r.name+" active="+r.gameObject.activeInHierarchy+" enabled="+r.enabled+" bounds="+r.bounds);
   foreach(var mat in r.sharedMaterials){if(mat==null){b.AppendLine("NULL MAT");continue;}
    b.AppendLine("material="+AssetDatabase.GetAssetPath(mat)+" shader="+mat.shader.name+" queue="+mat.renderQueue+" passes="+mat.passCount);
    foreach(var n in mat.GetTexturePropertyNames()){var t=mat.GetTexture(n);b.AppendLine(n+"="+(t==null?"NULL":AssetDatabase.GetAssetPath(t)+" "+t.graphicsFormat+" "+t.width+"x"+t.height));}
   }
   var binder=r.GetComponent<EID4730.EID4817ReplayBinder>();b.AppendLine("binder="+(binder!=null?binder.enabled.ToString():"NULL"));
  }
  foreach(var c in UnityEngine.Object.FindObjectsOfType<Camera>(true))b.AppendLine("camera="+c.name+" type="+c.cameraType+" enabled="+c.enabled);
  File.WriteAllText(Dir+"/live_status.txt",b.ToString());
 }
}
#endif
