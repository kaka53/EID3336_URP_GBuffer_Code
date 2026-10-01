#if UNITY_EDITOR
using System;
using System.IO;
using System.Reflection;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using EID4730;
public static class ColourPass26ProjectionAudit {
 const BindingFlags Flags=BindingFlags.Instance|BindingFlags.NonPublic;
 static string Dir=>Path.GetFullPath(".rdctools/colourpass26_hair/reference_overlay");
 static void Dump(RenderTexture rt,string file){var old=RenderTexture.active;var t=new Texture2D(rt.width,rt.height,TextureFormat.RGBAFloat,false,true);try{RenderTexture.active=rt;t.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0);t.Apply();File.WriteAllBytes(Dir+"/"+file+".f32",t.GetRawTextureData());}finally{RenderTexture.active=old;UnityEngine.Object.DestroyImmediate(t);}}
 public static void Run(){try{
 EditorSceneManager.OpenScene("Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity");
 var camera=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();camera.aspect=1366f/768f;
 var proj=GL.GetGPUProjectionMatrix(camera.projectionMatrix,true);var view=camera.worldToCameraMatrix;
 var seed=new Material(Shader.Find("Hidden/ColourPass26Hair/SeedReference"));
 var rt=new RenderTexture(1366,768,32,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);rt.Create();
 var aux=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);aux.Create();
 try{using(var session=new ColourPass26HairPass()){
 var type=typeof(ColourPass26HairPass);type.GetMethod("Initialize",Flags).Invoke(session,null);var materials=(Material[])type.GetField("materials",Flags).GetValue(session);var buffers=(System.Collections.Generic.Dictionary<string,ComputeBuffer>)type.GetField("buffers",Flags).GetValue(session);var textures=(System.Collections.Generic.Dictionary<int,Texture>)type.GetField("textures",Flags).GetValue(session);var manifest=(ColourPass26HairPass.Manifest)type.GetField("manifest",Flags).GetValue(session);
 for(int i=0;i<4;i++){
 int eid=new[]{5046,5051,5057,5062}[i];var obj=GameObject.Find(i<2?"EID1717_instance_000":"EID1721_instance_000");var source=obj.GetComponent<MeshFilter>().sharedMesh;
 var mesh=(Mesh)type.GetMethod("Canonical",Flags).Invoke(session,new object[]{source});var mat=new Material(Shader.Find("Hidden/ColourPass26Hair/Captured"+(i%2==0?"F":"B")));foreach(var stage in manifest.draws[i].stages){foreach(var b in stage.buffers){if(b.kind=="storage")mat.SetBuffer(b.shaderName,buffers[b.file]);else mat.SetConstantBuffer(b.shaderName,buffers[b.file],0,(int)new FileInfo(Path.Combine(Application.streamingAssetsPath,"ColourPass26Hair",b.file)).Length);}foreach(var t in stage.textures)mat.SetTexture(t.shaderName,textures[t.id]);}
 var bg=new Texture2D(1366,768,TextureFormat.RGBAFloat,false,true);bg.LoadRawTextureData(File.ReadAllBytes(Dir+"/"+eid+"_color.f32"));bg.Apply(false,true);
 var depth=new Texture2D(1366,768,TextureFormat.RFloat,false,true);depth.LoadRawTextureData(File.ReadAllBytes(Dir+"/"+eid+"_depth.f32"));depth.Apply(false,true);
 try{seed.SetTexture("_ReferenceColor",bg);seed.SetTexture("_ReferenceDepth",depth);
 mat.SetMatrix("_CP26ObjectToWorld",obj.transform.localToWorldMatrix);mat.SetMatrix("_CP26ObjectToClip",proj*view*obj.transform.localToWorldMatrix);
 foreach(int ztest in new[]{1,-1}){
 mat.SetFloat("_CP26ZTest",2);mat.SetFloat("_CP26CaptureYSign",ztest);var cmd=new CommandBuffer();
 cmd.SetRenderTarget(new RenderTargetIdentifier[]{rt,aux},rt);cmd.SetViewport(new Rect(0,0,1366,768));cmd.ClearRenderTarget(true,true,Color.clear,SystemInfo.usesReversedZBuffer?0:1);cmd.DrawProcedural(Matrix4x4.identity,seed,0,MeshTopology.Triangles,3);
 Graphics.ExecuteCommandBuffer(cmd);cmd.Clear();Dump(rt,eid+"_projection_seed"+ztest);
 cmd.SetRenderTarget(new RenderTargetIdentifier[]{rt,aux},rt);cmd.SetViewport(new Rect(0,0,1366,768));cmd.SetGlobalMatrix("_CP26BLiveVP",proj*view);cmd.SetGlobalMatrix("_CP26BLiveP",proj);cmd.SetGlobalMatrix("_CP26BLiveView",view);cmd.SetGlobalVector("_CP26BLiveScreen",new Vector4(1366,768,1f/1366,1f/768));
 cmd.DrawMesh(mesh,obj.transform.localToWorldMatrix,mat,0,0);Graphics.ExecuteCommandBuffer(cmd);cmd.Release();Dump(rt,eid+"_projection_sign"+ztest);
 }
 }finally{UnityEngine.Object.DestroyImmediate(mat);UnityEngine.Object.DestroyImmediate(bg);UnityEngine.Object.DestroyImmediate(depth);}
 }
 }}finally{rt.Release();aux.Release();UnityEngine.Object.DestroyImmediate(rt);UnityEngine.Object.DestroyImmediate(aux);UnityEngine.Object.DestroyImmediate(seed);}
 File.WriteAllText(Dir+"/projection_audit.txt","Rendered four independent draws with captured pre-draw color/depth. ZTest Always and Less variants. Compare pixels offline; not a final match assertion. Scene not saved.");EditorApplication.Exit(0);
 }catch(Exception e){File.WriteAllText(Dir+"/projection_audit.txt",e.ToString());Debug.LogException(e);EditorApplication.Exit(1);}}
}
#endif
