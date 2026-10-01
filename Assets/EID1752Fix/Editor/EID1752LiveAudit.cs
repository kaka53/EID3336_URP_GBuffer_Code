#if UNITY_EDITOR
using System;
using System.IO;
using System.Linq;
using System.Text;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.Experimental.Rendering;
[InitializeOnLoad]
public static class EID1752LiveAudit {
 const string D="D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/eid1752_fix";
 static EID1752LiveAudit(){EditorApplication.delayCall+=CheckRequest;}
 static void CheckRequest(){if(!File.Exists(D+"/live_audit.request"))return;File.Move(D+"/live_audit.request",D+"/live_audit_consumed_"+DateTime.Now.ToString("yyyyMMdd_HHmmss")+".txt");Run();}
 [MenuItem("Tools/EID1752/Validate Loaded Scene (Read Only)")]
 public static void Run(){
  var report=new StringBuilder();
  try{
   var scene=SceneManager.GetActiveScene();var dirty=scene.isDirty;
   report.AppendLine("Time="+DateTime.Now.ToString("O"));report.AppendLine("Scene="+scene.path);report.AppendLine("DirtyBefore="+dirty);
   if(!scene.path.EndsWith("/EID3336_RenderDocCamera.unity"))throw new Exception("Unexpected active scene");
   var go=GameObject.Find("EID1752_instance_000");if(go==null)throw new Exception("Missing target");
   var renderer=go.GetComponent<Renderer>();var mat=renderer.sharedMaterial;var mesh=go.GetComponent<MeshFilter>().sharedMesh;
   if(!renderer.enabled || !go.activeInHierarchy)throw new Exception("Target not enabled");
   if(mat.shader.name!="EID/URP/EID1752_Outline")throw new Exception("Old shader still bound");
   if(ShaderUtil.ShaderHasError(mat.shader))throw new Exception("Shader compilation error");
   var tex=mat.GetTexture("_OutlineMask") as Texture2D;
   if(tex==null || tex.graphicsFormat!=GraphicsFormat.RGBA_BC7_UNorm || tex.mipmapCount!=10)throw new Exception("Wrong mask format/mips");
   var dirs=new List<Vector3>();mesh.GetUVs(5,dirs);
   if(dirs.Count!=19393 || dirs.Any(v=>float.IsNaN(v.x)||float.IsInfinity(v.x)||float.IsNaN(v.y)||float.IsInfinity(v.y)||float.IsNaN(v.z)||float.IsInfinity(v.z)))throw new Exception("Invalid outline directions");
   var raw=File.ReadAllBytes(D+"/outline_direction.f32");float max=0;
   for(int i=0;i<dirs.Count;i++)for(int j=0;j<3;j++)max=Mathf.Max(max,Mathf.Abs(dirs[i][j]-BitConverter.ToSingle(raw,i*12+j*4)));
   if(max!=0)throw new Exception("Loaded outline directions differ from validated data");
   report.AppendLine("Renderer enabled=true; Shader="+mat.shader.name);report.AppendLine("Mask="+tex.graphicsFormat+" Mips="+tex.mipmapCount);report.AppendLine("Vertices="+mesh.vertexCount+" Indices="+mesh.GetIndexCount(0)+" DirectionMaxError="+max);
   report.AppendLine("Material="+AssetDatabase.GetAssetPath(mat));report.AppendLine("Mesh="+AssetDatabase.GetAssetPath(mesh));
   report.AppendLine("DirtyAfter="+scene.isDirty);report.AppendLine("PASS: loaded editor bindings match validated assets; no scene/asset edits or extra camera rendering.");
   File.WriteAllText(D+"/live_audit.txt",report.ToString());Debug.Log("[EID1752] Live binding audit PASS; report on D drive.");
  }catch(Exception e){report.AppendLine("FAIL: "+e);File.WriteAllText(D+"/live_audit.txt",report.ToString());Debug.LogError("[EID1752] Live binding audit failed; see D-drive report.");}
 }
}
#endif
