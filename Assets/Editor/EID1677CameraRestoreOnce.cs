#if UNITY_EDITOR
using System;using System.IO;using System.Linq;using UnityEditor;using UnityEditor.SceneManagement;using UnityEngine;
[InitializeOnLoad]
public static class EID1677CameraRestoreOnce {
 const string D="D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/camera_restore_1005";
 static EID1677CameraRestoreOnce(){EditorApplication.update+=Tick;}
 static void Tick(){if(EditorApplication.isCompiling||EditorApplication.isUpdating||!File.Exists(D+"/restore.request"))return;
  File.Delete(D+"/restore.request");EditorApplication.update-=Tick;
  try{
   if(EditorApplication.isPlayingOrWillChangePlaymode)throw new Exception("Refusing camera restore during Play Mode");
   var cameras=Resources.FindObjectsOfTypeAll<Camera>().Where(c=>c.name=="EID3336 RenderDoc Camera"&&c.gameObject.scene.path=="Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity").ToArray();
   if(cameras.Length!=1)throw new Exception("Expected exactly one target scene camera");var camera=cameras[0];var t=camera.transform;var scene=camera.gameObject.scene;
   if(t.parent!=null)throw new Exception("Camera parent changed; refuse local transform ambiguity");
   if(!EditorSceneManager.SaveScene(scene,D+"/scene_live_before.unity",true))throw new Exception("Live backup failed");
   var old=t.localPosition.ToString("R")+" / "+t.localRotation.ToString("R");
   Undo.RecordObject(t,"Restore RenderDoc camera transform from pre-close backup");
   t.localPosition=new Vector3(-560.8157f,108.86642f,-410.79205f);
   t.localRotation=new Quaternion(0.05396448f,0.8124064f,-0.07616986f,0.5755708f);
   t.localScale=Vector3.one;EditorUtility.SetDirty(t);EditorSceneManager.MarkSceneDirty(scene);
   if(!EditorSceneManager.SaveScene(scene))throw new Exception("Scene save failed");
   File.WriteAllText(D+"/result.txt","PASS\nSource: .rdctools/eid1677_fix_1004/backup/scene_disk.unity\nBefore="+old+"\nAfter="+t.localPosition.ToString("R")+" / "+t.localRotation.ToString("R")+"\nEuler="+t.localEulerAngles.ToString("R")+"\nChanged only Transform; camera projection and materials untouched.\n");
   SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();
  }catch(Exception e){File.WriteAllText(D+"/result.txt",e.ToString());Debug.LogException(e);}
 }
}
#endif
