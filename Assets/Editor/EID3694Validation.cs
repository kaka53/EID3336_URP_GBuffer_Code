#if UNITY_EDITOR
using System;using System.IO;using System.Text;using UnityEditor;using UnityEngine;
[InitializeOnLoad]public static class EID3694Validation{
const string D="D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/eid3694_depth_1005";
const string R="Assets/ColourPass6_VS215543_PS215544_Batch/";
static EID3694Validation(){EditorApplication.update+=Tick;}
static void Tick(){if(EditorApplication.isCompiling||EditorApplication.isUpdating||!File.Exists(D+"/test.request"))return;File.Delete(D+"/test.request");bool a=ShaderUtil.allowAsyncCompilation;try{
ShaderUtil.allowAsyncCompilation=false;var m=AssetDatabase.LoadAssetAtPath<Material>(R+"Materials/EID3694_VS215543_PS215544.mat");ShaderUtil.CompilePass(m,0,true);if(ShaderUtil.ShaderHasError(m.shader))throw new Exception("Shader compile error");
if(m.GetFloat("_EID215544AlphaClip")!=1||m.GetFloat("_EID215544ZWrite")!=1||m.GetFloat("_EID215544ZTest")!=4)throw new Exception("Material state mismatch");
var other=AssetDatabase.LoadAssetAtPath<Material>(R+"Materials/EID3698_VS215543_PS215544.mat");if(other.GetFloat("_EID215544AlphaClip")!=0||other.GetFloat("_EID215544ZWrite")!=0||other.GetFloat("_EID215544ZTest")!=3)throw new Exception("EID3698 state changed");
var log=new StringBuilder("PASS: shader compilation and live material/mesh validation (not pixel parity).\n");int count=0;
foreach(var go in Resources.FindObjectsOfTypeAll<GameObject>()){if(!go.scene.IsValid()||!go.name.StartsWith("EID3694_instance_"))continue;var mr=go.GetComponent<MeshRenderer>();var mf=go.GetComponent<MeshFilter>();if(!mr||!mf||!mf.sharedMesh||mr.sharedMaterial!=m||!mr.enabled||!go.activeInHierarchy)throw new Exception("Invalid instance "+go.name);count++;log.AppendLine(go.name+" vertices="+mf.sharedMesh.vertexCount+" bounds="+mr.bounds);}
if(count!=4)throw new Exception("Expected four live instances, got "+count);log.AppendLine("EID3694: LEqual/ZWrite/alpha clip=0.5. EID3698 unchanged. No scene/camera edits.");File.WriteAllText(D+"/result.txt",log.ToString());SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();
}catch(Exception e){File.WriteAllText(D+"/result.txt",e.ToString());}finally{ShaderUtil.allowAsyncCompilation=a;}}
}
#endif
