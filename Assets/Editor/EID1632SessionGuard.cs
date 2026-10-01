#if UNITY_EDITOR
using System;using System.IO;using System.Text;using UnityEditor;using UnityEditor.SceneManagement;using UnityEngine.SceneManagement;
[InitializeOnLoad] public static class EID1632SessionGuard {
 const string D="D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/eid1632_repair_0930";
 static EID1632SessionGuard(){EditorApplication.update+=Tick;}
 static void Tick(){if(EditorApplication.isCompiling||EditorApplication.isUpdating||!File.Exists(D+"/close.request"))return;File.Delete(D+"/close.request");try{
 if(EditorApplication.isPlayingOrWillChangePlaymode)throw new Exception("Play mode active");var folder=D+"/session_"+DateTime.Now.ToString("yyyyMMdd_HHmmss");Directory.CreateDirectory(folder);var log=new StringBuilder();
 for(int i=0;i<SceneManager.sceneCount;i++){var sc=SceneManager.GetSceneAt(i);if(!sc.isLoaded)continue;if(string.IsNullOrEmpty(sc.path))throw new Exception("Untitled scene; not closing");var path=folder+"/scene_"+i+".unity";if(!EditorSceneManager.SaveScene(sc,path,true))throw new Exception("Backup failed");if(!EditorSceneManager.SaveScene(sc))throw new Exception("Save failed");log.AppendLine(sc.path+" -> "+path);}
 File.WriteAllText(D+"/saved_scenes.txt",log.ToString());EditorApplication.delayCall+=()=>EditorApplication.Exit(0);
 }catch(Exception e){File.WriteAllText(D+"/close_error.txt",e.ToString());}}
}
#endif
