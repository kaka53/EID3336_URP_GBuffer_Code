#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.Universal;
using EID4730;
public static class ColourPass26AlignmentAudit
{
 static string Dir=>Path.GetFullPath(".rdctools/colourpass26_hair");
 public static void Run()
 {
  var depthTargets=new System.Collections.Generic.Dictionary<int,RenderTexture>();
  Material depthRead=null;
  var enabledFeatures=new System.Collections.Generic.Dictionary<EID4730RenderFeature,bool>();
  try {
   EditorSceneManager.OpenScene("Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity");
   foreach(var guid in AssetDatabase.FindAssets("t:ScriptableRendererData")) { var data=AssetDatabase.LoadAssetAtPath<ScriptableRendererData>(AssetDatabase.GUIDToAssetPath(guid));foreach(var feature in data.rendererFeatures)if(feature is EID4730RenderFeature f){enabledFeatures[f]=f.enableColourPass26Hair;f.enableColourPass26Hair=true;} }
   var source=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();
   foreach(string n in new[]{"EID1717_instance_000","EID1721_instance_000"}) {var o=GameObject.Find(n);if(o==null)throw new Exception("Missing "+n);var mesh=o.GetComponent<MeshFilter>().sharedMesh;Debug.Log("[CP26] source "+n+" "+mesh.vertexCount+" "+mesh.GetIndexCount(0));}
   var go=new GameObject("CP26 temporary audit"){hideFlags=HideFlags.HideAndDontSave};var cam=go.AddComponent<Camera>();cam.CopyFrom(source);cam.enabled=false;cam.transform.SetPositionAndRotation(source.transform.position,source.transform.rotation);
   var ud=source.GetComponent<UniversalAdditionalCameraData>();if(ud!=null)EditorUtility.CopySerialized(ud,go.AddComponent<UniversalAdditionalCameraData>());
   var rt=new RenderTexture(1366,768,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);rt.Create();cam.targetTexture=rt;cam.aspect=1366f/768f;
   string root=Application.streamingAssetsPath+"/ColourPass26Hair/";var manifest=JsonUtility.FromJson<ColourPass26HairPass.Manifest>(File.ReadAllText(root+"manifest.json"));var stage=Array.Find(manifest.draws[0].stages,x=>x.stage=="VS");
   var bytes=File.ReadAllBytes(root+Array.Find(stage.buffers,x=>x.shaderName=="CP26FVS_25_26").file);var globals=File.ReadAllBytes(root+Array.Find(stage.buffers,x=>x.shaderName=="CP26FVS_27_28").file);
   var view=new Matrix4x4();var relative=new Matrix4x4();for(int c=0;c<4;c++)for(int r=0;r<4;r++){view[r,c]=BitConverter.ToSingle(bytes,(c*4+r)*4);relative[r,c]=BitConverter.ToSingle(bytes,512+(c*4+r)*4);}
   var rotation=view;rotation.m03=rotation.m13=rotation.m23=0;var gpu=relative*rotation.inverse;
   gpu.m02+=2*BitConverter.ToSingle(globals,312);gpu.m12-=2*BitConverter.ToSingle(globals,316);
   var projection=gpu;for(int c=0;c<4;c++)projection[1,c]=-gpu[1,c];projection.m22=-1-2*gpu.m22;projection.m23=-2*gpu.m23;
   cam.worldToCameraMatrix=view;cam.projectionMatrix=projection;

   var pre=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);pre.Create();
   var post=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);post.Create();

  try {
    depthRead=new Material(Shader.Find("Hidden/ColourPass26Hair/ReadDepth"));
    foreach(int eid in new[]{5046,5051,5057,5062}){var d=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);d.Create();depthTargets.Add(eid,d);}
    ColourPass26HairPass.CaptureDepth=(cmd,depth,eid)=>{cmd.SetGlobalTexture("_CP26AuditDepth",depth.nameID);cmd.SetRenderTarget(depthTargets[eid]);cmd.SetViewport(new Rect(0,0,1366,768));cmd.DrawProcedural(Matrix4x4.identity,depthRead,0,UnityEngine.MeshTopology.Triangles,3);};
    ColourPass26HairPass.Capture=(cmd,target,eid,after)=>{if(eid==5046&&!after)cmd.CopyTexture(target.nameID,pre);if(eid==5062&&after)cmd.CopyTexture(target.nameID,post);};
    ColourPass26HairPass.DiagnosticAlways=false;
    ColourPass26HairPass.DiagnosticDisable=false;cam.Render();foreach(var kv in depthTargets)Dump(kv.Value,"aligned_scene_depth_"+kv.Key);File.WriteAllText(Dir+"/aligned_scene_camera.txt","view="+cam.worldToCameraMatrix.ToString("F9")+"\nprojection="+cam.projectionMatrix.ToString("F9")+"\ngpuProjection="+GL.GetGPUProjectionMatrix(cam.projectionMatrix,true).ToString("F9"));Dump(rt,"aligned_unity_after");Dump(pre,"aligned_unity_hair_before");Dump(post,"aligned_unity_hair_after");
    foreach(string n in new[]{"Front","Back"}) {var shader=Shader.Find("Hidden/ColourPass26Hair/"+n);foreach(var msg in ShaderUtil.GetShaderMessages(shader))Debug.Log("[CP26 shader] "+msg.severity+" "+msg.message+" "+msg.file+":"+msg.line);if(ShaderUtil.ShaderHasError(shader))throw new Exception("CP26 shader compile failed "+n);}
    if(ColourPass26HairPass.LastDrawCount!=4)throw new Exception("Expected 4 hair draws, got "+ColourPass26HairPass.LastDrawCount);
    ValidatePixels();
    File.WriteAllText(Dir+"/aligned_scene_depth_audit.txt","COVERAGE PASS (not final RenderDoc color validation) device="+SystemInfo.graphicsDeviceType+" draws="+ColourPass26HairPass.LastDrawCount+"; scene not saved");
   } finally {ColourPass26HairPass.CaptureDepth=null;foreach(var d in depthTargets.Values){d.Release();UnityEngine.Object.DestroyImmediate(d);}if(depthRead!=null)UnityEngine.Object.DestroyImmediate(depthRead);ColourPass26HairPass.Capture=null;pre.Release();post.Release();UnityEngine.Object.DestroyImmediate(pre);UnityEngine.Object.DestroyImmediate(post);ColourPass26HairPass.DiagnosticDisable=false;cam.targetTexture=null;rt.Release();UnityEngine.Object.DestroyImmediate(rt);UnityEngine.Object.DestroyImmediate(go);}
   foreach(var kv in enabledFeatures)kv.Key.enableColourPass26Hair=kv.Value;
   ColourPass26ReferenceAudit.Run();
  }catch(Exception e){foreach(var kv in enabledFeatures)kv.Key.enableColourPass26Hair=kv.Value;File.WriteAllText(Dir+"/aligned_scene_depth_audit.txt",e.ToString());Debug.LogException(e);EditorApplication.Exit(1);}
 }
 static void ValidatePixels() {
  var a=File.ReadAllBytes(Dir+"/aligned_unity_hair_before.f32");var b=File.ReadAllBytes(Dir+"/aligned_unity_hair_after.f32");int changed=0;
  // Captured left fringe, in bottom-up ReadPixels coordinates. Submission alone is not a visual pass.
  for(int y=288;y<418;y++)for(int x=0;x<110;x++)for(int c=0;c<3;c++) {
   int offset=((y*1366+x)*4+c)*4;float av=BitConverter.ToSingle(a,offset),bv=BitConverter.ToSingle(b,offset);
   if(!float.IsNaN(av)&&!float.IsInfinity(av)&&!float.IsNaN(bv)&&!float.IsInfinity(bv)&&Mathf.Abs(av-bv)>0.0001f){changed++;break;}
  }
  if(changed<10)throw new Exception("VISUAL VALIDATION FAILED: submitted four draws but fringe changed pixels="+changed);
 }
 static void Dump(RenderTexture rt,string name) {var old=RenderTexture.active;var tex=new Texture2D(rt.width,rt.height,TextureFormat.RGBAFloat,false,true);try{RenderTexture.active=rt;tex.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0);tex.Apply();File.WriteAllBytes(Dir+"/"+name+".f32",tex.GetRawTextureData());}finally{RenderTexture.active=old;UnityEngine.Object.DestroyImmediate(tex);}}
}
#endif


