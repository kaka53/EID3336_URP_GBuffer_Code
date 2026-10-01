#if UNITY_EDITOR
using System;using System.IO;using UnityEditor;using UnityEditor.SceneManagement;using UnityEngine.SceneManagement;
[InitializeOnLoad]public static class EID4798CloseAudit{
 const string D=".rdctools/eid1721_colorfix_1001";
 static EID4798CloseAudit(){EditorApplication.update+=Tick;}
 static void Tick(){if(EditorApplication.isCompiling||EditorApplication.isUpdating||!File.Exists(D+"/close.txt"))return;File.Delete(D+"/close.txt");try{var s=SceneManager.GetActiveScene();if(!EditorSceneManager.SaveScene(s,Path.GetFullPath(D+"/backup/before_pixel_audit.unity"),true))throw new Exception("Backup failed");File.WriteAllText(D+"/close_result.txt","Backed up "+s.path);EditorSceneManager.SaveScene(s);EditorApplication.Exit(0);}catch(Exception e){File.WriteAllText(D+"/close_result.txt",e.ToString());}}
}
#endif

