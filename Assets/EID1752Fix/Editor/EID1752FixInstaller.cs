#if UNITY_EDITOR
using System;
using System.IO;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine.Rendering.Universal;
public static class EID1752FixInstaller {
 const string R="Assets/ColourPass6_VS215479_PS215480_Batch";
 const string D=".rdctools/eid1752_fix";
 static Texture2D LoadLinearMask() {
  const string path="Assets/EID1752Fix/OutlineMaskLinear.asset";
  var texture=AssetDatabase.LoadAssetAtPath<Texture2D>(path);
  if(texture==null) {
   var dds=File.ReadAllBytes("Assets/EID1752Fix/rid266927.dds");
   if(BitConverter.ToInt32(dds,128)!=98)throw new Exception("Expected DXGI BC7_UNORM DDS");
   texture=new Texture2D(512,512,TextureFormat.BC7,true,true){name="EID1752 res34 linear BC7",filterMode=FilterMode.Bilinear,wrapMode=TextureWrapMode.Repeat};
   var raw=new byte[dds.Length-148];Buffer.BlockCopy(dds,148,raw,0,raw.Length);texture.LoadRawTextureData(raw);texture.Apply(false,false);
   AssetDatabase.CreateAsset(texture,path);
  }
  if(UnityEngine.Experimental.Rendering.GraphicsFormatUtility.IsSRGBFormat(texture.graphicsFormat))throw new Exception("Outline mask must be linear");
  return texture;
 }
 public static void FinalizeLinearMask() {
  try {
   var texture=LoadLinearMask();
   var mat=AssetDatabase.LoadAssetAtPath<Material>(R+"/Materials/EID1752_VS215479_PS215480.mat");
   mat.SetTexture("_OutlineMask",texture);EditorUtility.SetDirty(mat);AssetDatabase.SaveAssets();
   if(ShaderUtil.ShaderHasError(mat.shader))throw new Exception("Shader error");
   File.WriteAllText(D+"/linear_mask_validation.txt","PASS: mask="+texture.graphicsFormat+" dimensions="+texture.width+"x"+texture.height+" mips="+texture.mipmapCount+" shader="+mat.shader.name);
   EditorApplication.Exit(0);
  }catch(Exception e){File.WriteAllText(D+"/linear_mask_error.txt",e.ToString());EditorApplication.Exit(1);}
 }
 public static void CaptureFinal() {
  try {
   EditorSceneManager.OpenScene("Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity");
   var src=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();
   var go=new GameObject("EID1752 final audit"){hideFlags=HideFlags.HideAndDontSave};var cam=go.AddComponent<Camera>();cam.CopyFrom(src);cam.enabled=false;cam.transform.SetPositionAndRotation(src.transform.position,src.transform.rotation);
   var ud=src.GetComponent<UniversalAdditionalCameraData>();if(ud!=null)EditorUtility.CopySerialized(ud,go.AddComponent<UniversalAdditionalCameraData>());
   var rt=new RenderTexture(1366,768,24,RenderTextureFormat.ARGB32);rt.Create();cam.targetTexture=rt;cam.aspect=1366f/768f;
   cam.Render();Dump(rt,"final");
   var material=GameObject.Find("EID1752_instance_000").GetComponent<Renderer>().sharedMaterial;
   if(ShaderUtil.ShaderHasError(material.shader))throw new Exception("Final shader compilation failed");
   File.WriteAllText(D+"/final_validation.txt","PASS: final linear-mask material rendered with no outline shader compile errors. Full scene unchanged. This is not a whole-frame pixel-perfect RenderDoc assertion.");
   cam.targetTexture=null;rt.Release();UnityEngine.Object.DestroyImmediate(rt);UnityEngine.Object.DestroyImmediate(go);EditorApplication.Exit(0);
  }catch(Exception e){File.WriteAllText(D+"/final_error.txt",e.ToString());EditorApplication.Exit(1);}
 }
 public static void Run() {
  try {
   AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
   var shader=AssetDatabase.LoadAssetAtPath<Shader>("Assets/EID1752Fix/Shaders/EID1752Outline.shader");
   if(shader==null || ShaderUtil.ShaderHasError(shader))throw new Exception("Outline shader compile failed");
   var texture=LoadLinearMask();
   EditorSceneManager.OpenScene("Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity");
   var obj=GameObject.Find("EID1752_instance_000");if(obj==null)throw new Exception("Missing EID1752");
   var mesh=obj.GetComponent<MeshFilter>().sharedMesh;var mat=obj.GetComponent<Renderer>().sharedMaterial;
   if(AssetDatabase.GetAssetPath(mat)!=R+"/Materials/EID1752_VS215479_PS215480.mat")throw new Exception("Wrong material");
   var src=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();
   var go=new GameObject("EID1752 audit"){hideFlags=HideFlags.HideAndDontSave};var cam=go.AddComponent<Camera>();cam.CopyFrom(src);cam.enabled=false;cam.transform.SetPositionAndRotation(src.transform.position,src.transform.rotation);
   var ud=src.GetComponent<UniversalAdditionalCameraData>();if(ud!=null)EditorUtility.CopySerialized(ud,go.AddComponent<UniversalAdditionalCameraData>());
   var rt=new RenderTexture(1366,768,24,RenderTextureFormat.ARGB32);rt.Create();cam.targetTexture=rt;cam.aspect=1366f/768f;
   cam.Render();Dump(rt,"before");
   byte[] raw=File.ReadAllBytes(D+"/outline_direction.f32");if(raw.Length!=mesh.vertexCount*12)throw new Exception("Vertex count mismatch");
   var dirs=new List<Vector3>(mesh.vertexCount);for(int i=0;i<mesh.vertexCount;i++)dirs.Add(new Vector3(BitConverter.ToSingle(raw,i*12),BitConverter.ToSingle(raw,i*12+4),BitConverter.ToSingle(raw,i*12+8)));
   mesh.SetUVs(5,dirs);EditorUtility.SetDirty(mesh);
   mat.shader=shader;mat.SetTexture("_OutlineMask",texture);EditorUtility.SetDirty(mat);
   cam.Render();Dump(rt,"after");
   foreach(var msg in ShaderUtil.GetShaderMessages(shader))Debug.Log("EID1752 shader "+msg.severity+" "+msg.message);
   if(ShaderUtil.ShaderHasError(shader))throw new Exception("Compiled shader has errors");
   AssetDatabase.SaveAssetIfDirty(mesh);AssetDatabase.SaveAssetIfDirty(mat);
   File.WriteAllText(D+"/installed.txt","PASS: EID1752-only mesh UV5 direction and outline shader/mask installed. Vertices="+mesh.vertexCount+"; mask="+texture.graphicsFormat+"; scene not saved. Before/after PNG captured. RenderDoc CPU clip comparison in cpu_validation.json.");
   cam.targetTexture=null;rt.Release();UnityEngine.Object.DestroyImmediate(rt);UnityEngine.Object.DestroyImmediate(go);
   EditorApplication.Exit(0);
  } catch(Exception e){File.WriteAllText(D+"/install_error.txt",e.ToString());Debug.LogException(e);EditorApplication.Exit(1);}
 }
 static void Dump(RenderTexture rt,string name){var previous=RenderTexture.active;RenderTexture.active=rt;var t=new Texture2D(rt.width,rt.height,TextureFormat.RGBA32,false);t.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0);t.Apply();File.WriteAllBytes(D+"/"+name+".png",t.EncodeToPNG());UnityEngine.Object.DestroyImmediate(t);RenderTexture.active=previous;}
}
#endif
