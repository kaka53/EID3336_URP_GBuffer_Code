#if UNITY_EDITOR
using System;using System.IO;using System.Text;using UnityEditor;using UnityEngine;
[InitializeOnLoad] public static class EID3863ScaleAudit1005 {
 const string D="D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/eid3863_scale_1005";
 static EID3863ScaleAudit1005(){EditorApplication.update+=Tick;}
 static void Tick(){if(EditorApplication.isCompiling||EditorApplication.isUpdating||!File.Exists(D+"/audit.request"))return;File.Delete(D+"/audit.request");try{
 var root=GameObject.Find("EID3863_Vegetation_Instances");if(!root)throw new Exception("Root missing");var s=new StringBuilder();s.AppendLine(DateTime.Now.ToString("O"));s.AppendLine("scene="+root.scene.path+" root="+root.transform.localToWorldMatrix.ToString("R"));
 foreach(var t in root.GetComponentsInChildren<Transform>(true)){s.AppendLine(t.name+" localScale="+t.localScale.ToString("R")+" world="+t.localToWorldMatrix.ToString("R"));var mf=t.GetComponent<MeshFilter>();var mr=t.GetComponent<MeshRenderer>();if(mf&&mr)s.AppendLine("mesh="+AssetDatabase.GetAssetPath(mf.sharedMesh)+" bounds="+mf.sharedMesh.bounds+" material="+AssetDatabase.GetAssetPath(mr.sharedMaterial)+" shader="+mr.sharedMaterial.shader.name+" static="+mr.isPartOfStaticBatch+" instancing="+mr.sharedMaterial.enableInstancing);}
 foreach(var binder in Resources.FindObjectsOfTypeAll<EID215849InstanceBinder>())if(binder.gameObject.scene.IsValid()&&binder.profile&&binder.profile.eventId==3863)s.AppendLine("BATCH name="+binder.name+" active="+binder.gameObject.activeInHierarchy+" matrix="+binder.transform.localToWorldMatrix.ToString("R"));
 File.WriteAllText(D+"/live_audit.txt",s.ToString());
 }catch(Exception e){File.WriteAllText(D+"/live_audit.txt",e.ToString());}}
}
#endif
