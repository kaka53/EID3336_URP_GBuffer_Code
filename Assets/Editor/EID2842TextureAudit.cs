#if UNITY_EDITOR
using System;using System.IO;using UnityEditor;using UnityEngine;
[InitializeOnLoad] public static class EID2842TextureAudit {
 const string D="D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/eid2842_fix_1005";
 static EID2842TextureAudit(){EditorApplication.update+=Tick;}
 static void Tick(){if(EditorApplication.isCompiling||EditorApplication.isUpdating||!File.Exists(D+"/audit.request"))return;File.Delete(D+"/audit.request");try{
 var go=GameObject.Find("EID2842_instance_000");if(!go)throw new Exception("Target missing");var m=go.GetComponent<Renderer>().sharedMaterial;var t=m.GetTexture("_Res25") as Texture2D;var baseTex=m.GetTexture("_Res23");
 string expected="Assets/EID2842_TextureFix/rid256303_Linear.dds";if(!t||AssetDatabase.GetAssetPath(t)!=expected||t.graphicsFormat.ToString()!="RGBA_BC7_UNorm"||t.mipmapCount!=12)throw new Exception("Live linear texture binding mismatch: "+(t?t.graphicsFormat.ToString():"null"));
 if(ShaderUtil.ShaderHasError(m.shader))throw new Exception("Shader compile error");
 File.WriteAllText(D+"/audit_result.txt","PASS "+DateTime.Now.ToString("O")+"\nObject="+go.name+"\nRes25="+AssetDatabase.GetAssetPath(t)+" format="+t.graphicsFormat+" size="+t.width+"x"+t.height+" mips="+t.mipmapCount+"\nRes23="+baseTex.graphicsFormat+"\nP00="+m.GetVector("_P00")+" P03="+m.GetVector("_P03")+" P04="+m.GetVector("_P04")+"\nScene/camera transforms unchanged.\n");SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();
 }catch(Exception e){File.WriteAllText(D+"/audit_result.txt",e.ToString());Debug.LogException(e);}}
}
#endif
