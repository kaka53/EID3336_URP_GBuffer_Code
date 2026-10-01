#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using EID4730;
public static class EID4789Regression
{
 const string Root="Assets/EID4789_RenderDocRestore";
 const string Out="../../eid4789_verified";
 static StringBuilder report=new StringBuilder();
 static void Check(bool b,string m){report.AppendLine((b?"PASS ":"FAIL ")+m);if(!b)throw new Exception(m);}
 public static void Run(){
  try{EID4789Assets.Build();RunGPU();File.WriteAllText(Out+"/gpu_regression_"+SystemInfo.graphicsDeviceType+".txt",report+"RESULT=PASS\n");}
  catch(Exception e){File.WriteAllText(Out+"/gpu_regression_"+SystemInfo.graphicsDeviceType+".txt",report+"\n"+e+"\nRESULT=FAIL");Debug.LogException(e);EditorApplication.Exit(1);}
 }
 static void RunGPU(){
#pragma warning disable 618
  Shader.globalRenderPipeline="UniversalPipeline";
#pragma warning restore 618
  report.AppendLine("device="+SystemInfo.graphicsDeviceType);
  var mesh=AssetDatabase.LoadAssetAtPath<Mesh>(Root+"/EID4789_Mesh.asset");var source=AssetDatabase.LoadAssetAtPath<Mesh>(EID4789Assets.OriginalMeshPath);
  var mat=new Material(AssetDatabase.LoadAssetAtPath<Material>(Root+"/M_EID4789.mat"));var gbmat=new Material(AssetDatabase.LoadAssetAtPath<Material>(Root+"/M_EID1696_GBuffer.mat"));
  var p=source.vertices;var q=mesh.vertices;float pe=0;for(int i=0;i<p.Length;i++)pe=Mathf.Max(pe,Vector3.Distance(p[i],q[i]));Check(pe==0,"all 1521 positions exact original EID1696");
  Check(!ShaderUtil.ShaderHasError(mat.shader),"EID4789 has no compile errors before render");
  var go=new GameObject("EID4789 test only");go.AddComponent<MeshRenderer>().sharedMaterial=mat;
  var data=File.ReadAllBytes(Root+"/Captured/Verified/matrix.bytes");var M=new Matrix4x4();for(int c=0;c<4;c++)for(int r=0;r<4;r++)M[r,c]=BitConverter.ToSingle(data,(c*4+r)*4);
  go.transform.position=M.GetColumn(3);go.transform.rotation=Quaternion.LookRotation(M.GetColumn(2),M.GetColumn(1));go.transform.localScale=Vector3.one;
  var binder=go.AddComponent<EID4789ReplayBinder>();binder.material=mat;binder.Rebind();
  var cg=new GameObject("1696 test camera");var camera=cg.AddComponent<Camera>();camera.enabled=false;
  var center=go.transform.TransformPoint(source.bounds.center);camera.transform.position=center+go.transform.TransformDirection(new Vector3(0,0,.7f));camera.transform.LookAt(center,Vector3.up);
  camera.orthographic=true;camera.orthographicSize=.20f;camera.aspect=1;camera.nearClipPlane=.01f;camera.farClipPlane=10;
  var colors=new RenderTexture[5];var ids=new RenderTargetIdentifier[5];for(int i=0;i<5;i++){colors[i]=new RenderTexture(512,512,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);colors[i].Create();ids[i]=colors[i];}
  var depth=new RenderTexture(512,512,24,RenderTextureFormat.Depth);depth.Create();Color[] baseline=null;
  for(int iteration=0;iteration<4;iteration++){
   if(iteration==2)AssetDatabase.ImportAsset(Root+"/Shaders/EID4789_CharacterForward.shader",ImportAssetOptions.ForceUpdate|ImportAssetOptions.ForceSynchronousImport);
   if(iteration!=2)Check(EID4789ReplayBinder.PrepareActiveForDraw()==1,"production pre-draw binding");
   var cmd=new CommandBuffer();cmd.SetViewProjectionMatrices(camera.worldToCameraMatrix,camera.projectionMatrix);cmd.SetGlobalMatrix("unity_MatrixVP",GL.GetGPUProjectionMatrix(camera.projectionMatrix,true)*camera.worldToCameraMatrix);cmd.SetGlobalVector("_WorldSpaceCameraPos",camera.transform.position);
   cmd.SetRenderTarget(ids,depth);cmd.ClearRenderTarget(true,true,new Color(-10,-10,-10,-10));
   if(iteration!=0)cmd.DrawMesh(source,go.transform.localToWorldMatrix,gbmat,0,0);
   cmd.SetRenderTarget(new[]{ids[0],ids[1]},depth);cmd.ClearRenderTarget(false,true,new Color(-10,-10,-10,-10));cmd.DrawMesh(mesh,go.transform.localToWorldMatrix,mat,0,0);Graphics.ExecuteCommandBuffer(cmd);cmd.Release();Check(!ShaderUtil.ShaderHasError(mat.shader),"EID4789 active variant compiles");
   RenderTexture.active=colors[0];var cpu=new Texture2D(512,512,TextureFormat.RGBAFloat,false,true);cpu.ReadPixels(new Rect(0,0,512,512),0,0);cpu.Apply();var pixels=cpu.GetPixels();int covered=0,lit=0,bad=0;float error=0,max=0;
   for(int i=0;i<pixels.Length;i++){var c=pixels[i];if(float.IsNaN(c.r)||float.IsInfinity(c.r)||float.IsNaN(c.g)||float.IsInfinity(c.g)||float.IsNaN(c.b)||float.IsInfinity(c.b)){bad++;continue;}
    if(Mathf.Abs(c.r+10)>1e-3f||Mathf.Abs(c.g+10)>1e-3f||Mathf.Abs(c.b+10)>1e-3f){covered++;float peak=Mathf.Max(c.r,Mathf.Max(c.g,c.b));max=Mathf.Max(max,peak);if(peak>1e-4f)lit++;}
    if(iteration==3){var b=baseline[i];error=Mathf.Max(error,Mathf.Max(Mathf.Abs(c.r-b.r),Mathf.Max(Mathf.Abs(c.g-b.g),Mathf.Abs(c.b-b.b))));}
   }
   report.AppendLine("iteration="+iteration+" covered="+covered+" nonBlack="+lit+" nonfinite="+bad+" maxRGB="+max+" maxBaselineError="+error);
   if(iteration==0)Check(covered==0&&bad==0,"Equal depth rejects no-GBuffer draw");
   if(iteration==1||iteration==3)Check(covered>0&&lit>0&&bad==0,"original EID1696 depth admits finite nonblack EID4789 color");
   if(iteration==1)baseline=pixels;
   if(iteration==3){Check(error<1e-6f,"shader reimport rebind restores exact RGB");for(int i=0;i<pixels.Length;i++){var c=pixels[i];pixels[i]=c.r<-9?new Color(.1f,.1f,.1f,1):new Color(Mathf.LinearToGammaSpace(Mathf.Clamp01(c.r)),Mathf.LinearToGammaSpace(Mathf.Clamp01(c.g)),Mathf.LinearToGammaSpace(Mathf.Clamp01(c.b)),1);}var png=new Texture2D(512,512,TextureFormat.RGBA32,false);png.SetPixels(pixels);png.Apply();File.WriteAllBytes(Out+"/1696_isolated_"+SystemInfo.graphicsDeviceType+".png",png.EncodeToPNG());UnityEngine.Object.DestroyImmediate(png);}
   UnityEngine.Object.DestroyImmediate(cpu);
  }
  RenderTexture.active=null;foreach(var rt in colors){rt.Release();UnityEngine.Object.DestroyImmediate(rt);}depth.Release();UnityEngine.Object.DestroyImmediate(depth);UnityEngine.Object.DestroyImmediate(cg);UnityEngine.Object.DestroyImmediate(go);UnityEngine.Object.DestroyImmediate(mat);UnityEngine.Object.DestroyImmediate(gbmat);
 }
}
#endif
