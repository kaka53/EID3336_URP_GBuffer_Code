#if UNITY_EDITOR
using System;using System.IO;using System.Text;using UnityEditor;using UnityEngine;
[InitializeOnLoad]public static class VegetationWindAudit1005 {
 const string D="D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/vegetation_wind_extend_1005";
 static bool waiting;static double due;static Vector4 before;static string report;
 static VegetationWindAudit1005(){EditorApplication.update+=Tick;}
 static void Tick(){if(EditorApplication.isCompiling||EditorApplication.isUpdating)return;
 try{
 if(waiting){if(EditorApplication.timeSinceStartup<due)return;waiting=false;var after=Shader.GetGlobalVector("_EID3863WindTimes");if(after.x<=before.x||after.y>after.x)throw new Exception("Clock failed: "+before+" -> "+after);File.WriteAllText(D+"/result.txt","PASS\n"+report+"Shared clock: "+before.ToString("R")+" -> "+after.ToString("R"));return;}
 if(!File.Exists(D+"/test.request"))return;File.Delete(D+"/test.request");var log=new StringBuilder();bool async=ShaderUtil.allowAsyncCompilation;
 try{ShaderUtil.allowAsyncCompilation=false;foreach(string path in File.ReadAllLines(D+"/material_paths.txt")){
 var m=AssetDatabase.LoadAssetAtPath<Material>(path);if(!m)throw new Exception("Missing "+path);ShaderUtil.CompilePass(m,0,true);if(ShaderUtil.ShaderHasError(m.shader))throw new Exception("Shader error "+path);if(m.GetFloat("_EID3863WindEnabled")<.5f)throw new Exception("Disabled "+path);log.AppendLine(m.name+": compiled, enabled, speed="+m.GetFloat("_EID3863WindSpeed"));}
 var original=AssetDatabase.LoadAssetAtPath<Material>("Assets/EID3332_EID3336_Combined/EID3863_RenderDocVegetation/Materials/EID3863_Vegetation_PS215850.mat");ShaderUtil.CompilePass(original,0,true);if(ShaderUtil.ShaderHasError(original.shader))throw new Exception("Original EID3863 compile error");
 }finally{ShaderUtil.allowAsyncCompilation=async;}
 // Sample only AFTER synchronous shader compilation; compilation may stall the editor.
 report=log.ToString();before=Shader.GetGlobalVector("_EID3863WindTimes");due=EditorApplication.timeSinceStartup+1;waiting=true;
 }catch(Exception e){waiting=false;File.WriteAllText(D+"/result.txt",e.ToString());Debug.LogException(e);}}
}
#endif
