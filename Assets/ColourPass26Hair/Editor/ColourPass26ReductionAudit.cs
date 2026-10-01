#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using System.Reflection;
using System.Collections.Generic;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using EID4730;
public static class ColourPass26ReductionAudit {
 const BindingFlags Flags=BindingFlags.Instance|BindingFlags.NonPublic;
 public static void Run(){
 string dir=Path.GetFullPath(".rdctools/colourpass26_hair");var report=new StringBuilder();
 try {
 EditorSceneManager.OpenScene("Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity");
 var camera=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();camera.aspect=1366f/768f;
 var obj=GameObject.Find("EID1721_instance_000");var source=obj.GetComponent<MeshFilter>().sharedMesh;
 using(var session=new ColourPass26HairPass()) {
 var type=typeof(ColourPass26HairPass);type.GetMethod("Initialize",Flags).Invoke(session,null);
 var mesh=(Mesh)type.GetMethod("Canonical",Flags).Invoke(session,new object[]{source});
 var materials=(Material[])type.GetField("materials",Flags).GetValue(session);
 var manifest=(ColourPass26HairPass.Manifest)type.GetField("manifest",Flags).GetValue(session);
 var buffers=(Dictionary<string,ComputeBuffer>)type.GetField("buffers",Flags).GetValue(session);
 var textures=(Dictionary<int,Texture>)type.GetField("textures",Flags).GetValue(session);
 var rt=new RenderTexture(1366,768,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);rt.Create();
 var aux=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);aux.Create();
 try {
 for(int mode=0;mode<8;mode++) {
 var shader=Shader.Find(mode<6?"Hidden/ColourPass26Hair/Reduction"+mode:"Hidden/ColourPass26Hair/Front");
 if(shader==null||ShaderUtil.ShaderHasError(shader))throw new Exception("Shader invalid mode="+mode);
 var mat=new Material(shader);var dummy=new ComputeBuffer(65536,4,ComputeBufferType.Raw);dummy.SetData(new uint[65536]);
 try {
 foreach(var stage in manifest.draws[2].stages) {
 foreach(var b in stage.buffers){if(b.kind=="storage")mat.SetBuffer(b.shaderName,buffers[b.file]);else mat.SetConstantBuffer(b.shaderName,buffers[b.file],0,(int)new FileInfo(Path.Combine(Application.streamingAssetsPath,"ColourPass26Hair",b.file)).Length);}
 foreach(var t in stage.textures)mat.SetTexture(t.shaderName,textures[t.id]);
 }
 if(mode==7){mat.SetBuffer("CP26FPS_30",dummy);mat.SetBuffer("CP26FPS_32",dummy);mat.SetBuffer("CP26FVS_33",dummy);}
 mat.SetMatrix("_CP26ObjectToWorld",obj.transform.localToWorldMatrix);mat.SetMatrix("_CP26ObjectToClip",GL.GetGPUProjectionMatrix(camera.projectionMatrix,true)*camera.worldToCameraMatrix*obj.transform.localToWorldMatrix);mat.SetFloat("_CP26ZTest",8);mat.SetFloat("_DiagnosticMode",mode);
 var cmd=new CommandBuffer();cmd.SetRenderTarget(new RenderTargetIdentifier[]{rt,aux},rt);cmd.SetViewport(new Rect(0,0,1366,768));cmd.ClearRenderTarget(true,true,new Color(0,.2f,.4f,0),SystemInfo.usesReversedZBuffer?0:1);cmd.DrawMesh(mesh,obj.transform.localToWorldMatrix,mat,0,0);Graphics.ExecuteCommandBuffer(cmd);cmd.Release();
 var previous=RenderTexture.active;RenderTexture.active=rt;var tex=new Texture2D(1366,768,TextureFormat.RGBAFloat,false,true);tex.ReadPixels(new Rect(0,0,1366,768),0,0);tex.Apply();RenderTexture.active=previous;
 File.WriteAllBytes(dir+"/reduction_mode"+mode+".f32",tex.GetRawTextureData());var pixels=tex.GetPixels();int changed=0,nonfinite=0;float max=0;
 foreach(var p in pixels){if(float.IsNaN(p.r)||float.IsInfinity(p.r)||float.IsNaN(p.g)||float.IsInfinity(p.g)||float.IsNaN(p.b)||float.IsInfinity(p.b)||float.IsNaN(p.a)||float.IsInfinity(p.a)){nonfinite++;continue;}max=Mathf.Max(max,p.r,p.g,p.b);if(Mathf.Abs(p.r)>.0001f||Mathf.Abs(p.g-.2f)>.0001f||Mathf.Abs(p.b-.4f)>.0001f)changed++;}
 UnityEngine.Object.DestroyImmediate(tex);report.AppendLine("mode="+mode+" changed="+changed+" nonfinite="+nonfinite+" max="+max);File.WriteAllText(dir+"/reduction_audit.txt",report.ToString());
 }finally{dummy.Release();UnityEngine.Object.DestroyImmediate(mat);}
 }
 }finally{rt.Release();aux.Release();UnityEngine.Object.DestroyImmediate(rt);UnityEngine.Object.DestroyImmediate(aux);}
 }
 File.WriteAllText(dir+"/reduction_audit.txt",report+"Isolated draw diagnostics only; depth bypassed. Scene not saved.");EditorApplication.Exit(0);
 }catch(Exception e){File.WriteAllText(dir+"/reduction_audit.txt",report+"\n"+e);Debug.LogException(e);EditorApplication.Exit(1);}
 }
}
#endif
