#if UNITY_EDITOR
using System;using System.IO;using UnityEditor;using UnityEngine;
[InitializeOnLoad]public static class EID3863WindAudit{
 const string D="D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/eid3863_wind_1005";
 static double until;static Vector4 first;static bool active;
 static EID3863WindAudit(){EditorApplication.update+=Tick;}
 static void Tick(){if(EditorApplication.isCompiling||EditorApplication.isUpdating)return;
 if(!active){if(!File.Exists(D+"/test.request"))return;File.Delete(D+"/test.request");first=Shader.GetGlobalVector("_EID3863WindTimes");until=EditorApplication.timeSinceStartup+1;active=true;return;}
 if(EditorApplication.timeSinceStartup<until)return;active=false;
 try{var go=GameObject.Find("EID3863_Instance_199");if(!go)throw new Exception("Instance 199 missing");var m=go.GetComponent<Renderer>().sharedMaterial;
 bool async=ShaderUtil.allowAsyncCompilation;try{ShaderUtil.allowAsyncCompilation=false;ShaderUtil.CompilePass(m,0,true);}finally{ShaderUtil.allowAsyncCompilation=async;}
 if(ShaderUtil.ShaderHasError(m.shader))throw new Exception("Wind shader compile error");
 var second=Shader.GetGlobalVector("_EID3863WindTimes");if(second.x<=first.x||second.y>second.x)throw new Exception("Shared wind clock did not advance correctly");
 if(m.GetFloat("_EID3863WindEnabled")<.5f)throw new Exception("Wind not enabled");
 File.WriteAllText(D+"/result.txt","PASS shader compiled; shared current/previous clock advanced.\n"+first.ToString("R")+" -> "+second.ToString("R")+"\nMaterial="+AssetDatabase.GetAssetPath(m)+"\nEnabled="+m.GetFloat("_EID3863WindEnabled")+" Speed="+m.GetFloat("_EID3863WindSpeed")+" Strength="+m.GetFloat("_EID3863WindStrength")+"\nVSX17 remains current clip: motion vectors intentionally zero.\n");
 }catch(Exception e){File.WriteAllText(D+"/result.txt",e.ToString());Debug.LogException(e);}}
}
#endif
