#if UNITY_EDITOR
using System;using System.IO;using UnityEditor;using UnityEngine;using UnityEngine.Rendering;
[InitializeOnLoad]public static class EID3858ClipRegression{
const string D="D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/eid3858_clip_1005";
static EID3858ClipRegression(){EditorApplication.update+=Tick;}
static void Tick(){if(EditorApplication.isCompiling||EditorApplication.isUpdating||!File.Exists(D+"/test.request"))return;File.Delete(D+"/test.request");try{Run();}catch(Exception e){File.WriteAllText(D+"/result.txt",e.ToString());}}
[System.Runtime.InteropServices.StructLayout(System.Runtime.InteropServices.LayoutKind.Sequential)]struct Record{public Vector4 a,b,c,d,e,f;}
static void Run(){
var src=AssetDatabase.LoadAssetAtPath<Material>("Assets/ColourPass6_VS215847_PS215848_Batch/Materials/EID3858_VS215847_PS215848.mat");
var mat=new Material(src);mat.shader=Shader.Find("Hidden/EID3858/ClipRegression");
var tex=new Texture2D(2,1,TextureFormat.RGBA32,false,true){filterMode=FilterMode.Point,wrapMode=TextureWrapMode.Clamp};tex.SetPixels(new[]{new Color(1,1,1,0),Color.white});tex.Apply();mat.SetTexture("_Res25",tex);mat.SetFloat("_EID3858AlphaCutoff",.5f);
var instance=new ComputeBuffer(1,96);instance.SetData(new[]{new Record{a=new Vector4(1,0,0,0),b=new Vector4(0,1,0,0),c=new Vector4(0,0,1,0),d=new Vector4(0,0,0,1)}});mat.SetBuffer("_EID215847Instances",instance);
var mesh=new Mesh();mesh.vertices=new[]{new Vector3(-1,-1,0),new Vector3(1,-1,0),new Vector3(1,1,0),new Vector3(-1,1,0)};mesh.uv=new[]{Vector2.zero,Vector2.right,Vector2.one,Vector2.up};mesh.triangles=new[]{0,1,2,0,2,3};
var rt=new RenderTexture[5];var ids=new RenderTargetIdentifier[5];var depth=new RenderTexture(16,16,24,RenderTextureFormat.Depth);depth.Create();var cpu=new Texture2D(16,16,TextureFormat.RGBAFloat,false,true);var cmd=new CommandBuffer();var old=RenderTexture.active;bool async=ShaderUtil.allowAsyncCompilation;
try{ShaderUtil.allowAsyncCompilation=false;foreach(var m in new[]{src,mat}){ShaderUtil.CompilePass(m,0,true);if(ShaderUtil.ShaderHasError(m.shader))throw new Exception("Shader errors: "+m.shader.name);}
for(int i=0;i<5;i++){rt[i]=new RenderTexture(16,16,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);rt[i].Create();ids[i]=rt[i];}
cmd.SetRenderTarget(ids,depth);cmd.SetViewport(new Rect(0,0,16,16));cmd.ClearRenderTarget(true,true,Color.clear);cmd.DrawMesh(mesh,Matrix4x4.identity,mat);Graphics.ExecuteCommandBuffer(cmd);
RenderTexture.active=rt[0];cpu.ReadPixels(new Rect(0,0,16,16),0,0);cpu.Apply();int left=0,right=0;var pixels=cpu.GetPixels();for(int y=0;y<16;y++)for(int x=0;x<16;x++)if(pixels[y*16+x].a>.25f){if(x<8)left++;else right++;}
File.WriteAllText(D+"/result.txt",(left==0&&right==128?"PASS":"FAIL")+"\nTransparent pixels written="+left+"\nOpaque pixels written="+right+"\nProduction shader compiled; test uses production fragment with deterministic vertex/UV inputs.\nCapture threshold remains unverified; 0.5 is adjustable.\n");
}finally{ShaderUtil.allowAsyncCompilation=async;RenderTexture.active=old;cmd.Release();instance.Release();foreach(var t in rt)if(t){t.Release();UnityEngine.Object.DestroyImmediate(t);}depth.Release();foreach(var o in new UnityEngine.Object[]{depth,cpu,mesh,mat,tex})UnityEngine.Object.DestroyImmediate(o);SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();}
}}
#endif
