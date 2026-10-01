#if UNITY_EDITOR
using System;using System.IO;using UnityEditor;using UnityEditor.SceneManagement;using UnityEngine;using UnityEngine.SceneManagement;using EID4730;
[InitializeOnLoad]public static class EID4798Install {
 const string D=".rdctools/eid1721_colorfix_1001", R="Assets/EID4798_RenderDocRestore";
 static EID4798Install(){EditorApplication.update+=Tick;}
 static void Tick(){if(EditorApplication.isCompiling||EditorApplication.isUpdating||!File.Exists(D+"/install.txt"))return;var action=File.ReadAllText(D+"/install.txt").Trim();File.Delete(D+"/install.txt");try{if(action=="rebuild")EID4798Assets.Build();else Install();File.WriteAllText(D+"/install_result.txt","OK "+DateTime.Now);}catch(Exception e){File.WriteAllText(D+"/install_result.txt",e.ToString());Debug.LogException(e);}}
 static void Install(){
 var scene=SceneManager.GetActiveScene();if(scene.path!="Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity")throw new Exception("Wrong scene");
 var o=GameObject.Find("EID1721_instance_000");if(o==null)throw new Exception("Missing EID1721");
 if(!EditorSceneManager.SaveScene(scene,Path.GetFullPath(D+"/backup/live_before_install.unity"),true))throw new Exception("Live scene backup failed");
 EID4798Assets.Build();var renderer=o.GetComponent<Renderer>();var original=renderer.sharedMaterial;
 string gbPath=R+"/M_EID1721_GBuffer.mat";var gb=AssetDatabase.LoadAssetAtPath<Material>(gbPath);
 if(gb==null){gb=new Material(original);AssetDatabase.CreateAsset(gb,gbPath);}
 gb.SetShaderPassEnabled("EID4730CharacterForward",false);EditorUtility.SetDirty(gb);AssetDatabase.SaveAssetIfDirty(gb);Undo.RecordObject(renderer,"EID1721 captured hair shading");renderer.sharedMaterial=gb;
 var t=o.transform.Find("EID4798_Forward_for_EID1721");GameObject child;
 if(t==null){child=new GameObject("EID4798_Forward_for_EID1721");Undo.RegisterCreatedObjectUndo(child,"EID4798 forward");child.transform.SetParent(o.transform,false);}else child=t.gameObject;
 child.transform.localPosition=Vector3.zero;child.transform.localRotation=Quaternion.identity;child.transform.localScale=Vector3.one;child.layer=o.layer;
 var mf=child.GetComponent<MeshFilter>();if(mf==null)mf=child.AddComponent<MeshFilter>();mf.sharedMesh=AssetDatabase.LoadAssetAtPath<Mesh>(R+"/EID4798_Mesh.asset");
 var mr=child.GetComponent<MeshRenderer>();if(mr==null)mr=child.AddComponent<MeshRenderer>();mr.sharedMaterial=AssetDatabase.LoadAssetAtPath<Material>(R+"/M_EID4798.mat");mr.shadowCastingMode=UnityEngine.Rendering.ShadowCastingMode.Off;mr.receiveShadows=false;
 var binder=child.GetComponent<EID4798ReplayBinder>();if(binder==null)binder=child.AddComponent<EID4798ReplayBinder>();binder.material=mr.sharedMaterial;binder.Rebind();
 EditorSceneManager.MarkSceneDirty(scene);if(!EditorSceneManager.SaveScene(scene))throw new Exception("Save failed");SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();
 }
}
#endif

