#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.Universal;
using EID4730;
public static class ColourPass26HairAudit
{
 static string Dir=>Path.GetFullPath(".rdctools/colourpass26_hair");
 public static void Run() { RunCore(false); }
 public static void InstallAndValidate() { RunCore(true); }
 static void RunCore(bool install)
 {
  var enabledFeatures=new System.Collections.Generic.Dictionary<EID4730RenderFeature,bool>();
  try {
   EditorSceneManager.OpenScene("Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity");
   foreach(var guid in AssetDatabase.FindAssets("t:ScriptableRendererData")) { var data=AssetDatabase.LoadAssetAtPath<ScriptableRendererData>(AssetDatabase.GUIDToAssetPath(guid));foreach(var feature in data.rendererFeatures)if(feature is EID4730RenderFeature f){enabledFeatures[f]=f.enableColourPass26Hair;f.enableColourPass26Hair=true;} }
   var source=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();
   foreach(string n in new[]{"EID1717_instance_000","EID1721_instance_000"}) {var o=GameObject.Find(n);if(o==null)throw new Exception("Missing "+n);var mesh=o.GetComponent<MeshFilter>().sharedMesh;Debug.Log("[CP26] source "+n+" "+mesh.vertexCount+" "+mesh.GetIndexCount(0));}
   var go=new GameObject("CP26 temporary audit"){hideFlags=HideFlags.HideAndDontSave};var cam=go.AddComponent<Camera>();cam.CopyFrom(source);cam.enabled=false;cam.transform.SetPositionAndRotation(source.transform.position,source.transform.rotation);
   var ud=source.GetComponent<UniversalAdditionalCameraData>();if(ud!=null)EditorUtility.CopySerialized(ud,go.AddComponent<UniversalAdditionalCameraData>());
   var rt=new RenderTexture(1366,768,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);rt.Create();cam.targetTexture=rt;cam.aspect=1366f/768f;
   var pre=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);pre.Create();
   var post=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);post.Create();

  try {
    ColourPass26HairPass.Capture=(cmd,target,eid,after)=>{if(eid==5046&&!after)cmd.CopyTexture(target.nameID,pre);if(eid==5062&&after)cmd.CopyTexture(target.nameID,post);};
    ColourPass26HairPass.DiagnosticAlways=false;
    ColourPass26HairPass.DiagnosticDisable=false;cam.Render();Dump(rt,"unity_after");Dump(pre,"unity_hair_before");Dump(post,"unity_hair_after");
    foreach(string n in new[]{"Front","Back"}) {var shader=Shader.Find("Hidden/ColourPass26Hair/"+n);foreach(var msg in ShaderUtil.GetShaderMessages(shader))Debug.Log("[CP26 shader] "+msg.severity+" "+msg.message+" "+msg.file+":"+msg.line);if(ShaderUtil.ShaderHasError(shader))throw new Exception("CP26 shader compile failed "+n);}
    if(ColourPass26HairPass.LastDrawCount!=4)throw new Exception("Expected 4 hair draws, got "+ColourPass26HairPass.LastDrawCount);
    ValidatePixels();
    File.WriteAllText(Dir+"/unity_audit.txt","COVERAGE PASS (not final RenderDoc color validation) device="+SystemInfo.graphicsDeviceType+" draws="+ColourPass26HairPass.LastDrawCount+"; scene not saved");
   } finally {ColourPass26HairPass.Capture=null;pre.Release();post.Release();UnityEngine.Object.DestroyImmediate(pre);UnityEngine.Object.DestroyImmediate(post);ColourPass26HairPass.DiagnosticDisable=false;cam.targetTexture=null;rt.Release();UnityEngine.Object.DestroyImmediate(rt);UnityEngine.Object.DestroyImmediate(go);}
   foreach(var kv in enabledFeatures)kv.Key.enableColourPass26Hair=kv.Value;
   if(install) {
    int installed=0;
    foreach(var kv in enabledFeatures)if(AssetDatabase.GetAssetPath(kv.Key)=="Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-Renderer.asset") {
      var f=kv.Key;f.enableColourPass26Hair=true;f.colourPass26FrontShader=Shader.Find("Hidden/ColourPass26Hair/Front");f.colourPass26BackShader=Shader.Find("Hidden/ColourPass26Hair/Back");
      if(f.colourPass26FrontShader==null||f.colourPass26BackShader==null)throw new Exception("Cannot save missing shader references");
      EditorUtility.SetDirty(f);AssetDatabase.SaveAssetIfDirty(f);installed++;
    }
    if(installed!=1)throw new Exception("Expected exactly one target renderer feature, got "+installed);
    File.WriteAllText(Dir+"/installed.txt","Enabled ColourPass26 hair in EID3332Combined-Renderer.asset with explicit shader references. Four-draw coverage, fringe, dark-hair no-overpaint and nonfinite regression checks passed. Scene not saved. Upstream scene appearance is outside this hair-only validation.");
   }
   EditorApplication.Exit(0);
  }catch(Exception e){foreach(var kv in enabledFeatures)kv.Key.enableColourPass26Hair=kv.Value;File.WriteAllText(Dir+"/unity_audit.txt",e.ToString());Debug.LogException(e);EditorApplication.Exit(1);}
 }
 static void ValidatePixels() {
  var a=File.ReadAllBytes(Dir+"/unity_hair_before.f32");var b=File.ReadAllBytes(Dir+"/unity_hair_after.f32");int changed=0;
  // Captured left fringe, in bottom-up ReadPixels coordinates. Submission alone is not a visual pass.
  for(int y=288;y<418;y++)for(int x=0;x<110;x++)for(int c=0;c<3;c++) {
   int offset=((y*1366+x)*4+c)*4;float av=BitConverter.ToSingle(a,offset),bv=BitConverter.ToSingle(b,offset);
   if(!float.IsNaN(av)&&!float.IsInfinity(av)&&!float.IsNaN(bv)&&!float.IsInfinity(bv)&&Mathf.Abs(av-bv)>0.0001f){changed++;break;}
  }
  int darkChanged=0,invalidBefore=0,invalidAfter=0;
  for(int y=333;y<443;y++)for(int x=630;x<735;x++)for(int c=0;c<3;c++){int o=((y*1366+x)*4+c)*4;float av=BitConverter.ToSingle(a,o),bv=BitConverter.ToSingle(b,o);if(!float.IsNaN(av)&&!float.IsInfinity(av)&&!float.IsNaN(bv)&&!float.IsInfinity(bv)&&Mathf.Abs(av-bv)>0.0001f){darkChanged++;break;}}
  for(int o=0;o<a.Length;o+=4){float av=BitConverter.ToSingle(a,o),bv=BitConverter.ToSingle(b,o);if(float.IsNaN(av)||float.IsInfinity(av))invalidBefore++;if(float.IsNaN(bv)||float.IsInfinity(bv))invalidAfter++;}
  File.WriteAllText(Dir+"/scene_validation.txt","fringeChanged="+changed+" darkHairChanged="+darkChanged+" nonfiniteComponentsBefore="+invalidBefore+" after="+invalidAfter);
  if(darkChanged>3)throw new Exception("Dark opaque hair was unexpectedly repainted: "+darkChanged);
  if(invalidAfter>invalidBefore)throw new Exception("Hair introduced additional nonfinite HDR components");
  if(changed<500)throw new Exception("VISUAL VALIDATION FAILED: submitted four draws but fringe changed pixels="+changed);
 }
 static void Dump(RenderTexture rt,string name) {var old=RenderTexture.active;var tex=new Texture2D(rt.width,rt.height,TextureFormat.RGBAFloat,false,true);try{RenderTexture.active=rt;tex.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0);tex.Apply();File.WriteAllBytes(Dir+"/"+name+".f32",tex.GetRawTextureData());}finally{RenderTexture.active=old;UnityEngine.Object.DestroyImmediate(tex);}}
}
#endif


