#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
public static class ColourPass26GeometryAudit
{
 public static void Run() {
  string dir=Path.GetFullPath(".rdctools/colourpass26_hair");
  try {
   EditorSceneManager.OpenScene("Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity");
   var camera=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();
   camera.aspect=1366f/768f;
   var obj=GameObject.Find("EID1721_instance_000");var mesh=obj.GetComponent<MeshFilter>().sharedMesh;
   var shader=Shader.Find("Hidden/ColourPass26Hair/Diagnostic");if(shader==null || ShaderUtil.ShaderHasError(shader))throw new Exception("Diagnostic shader invalid");
   var mat=new Material(shader);var rt=new RenderTexture(1366,768,0,RenderTextureFormat.ARGB32,RenderTextureReadWrite.Linear);rt.Create();
   var report=new StringBuilder();report.AppendLine("device="+SystemInfo.graphicsDeviceType+" indices="+mesh.GetIndexCount(0)+" bounds="+mesh.bounds+" matrix="+obj.transform.localToWorldMatrix);
   try {
    report.AppendLine("view="+camera.worldToCameraMatrix+" projection="+camera.projectionMatrix+" firstVertex="+mesh.vertices[0]);
    foreach(bool worldPositions in new[]{false,true}) {
    var mvp=GL.GetGPUProjectionMatrix(camera.projectionMatrix,true)*camera.worldToCameraMatrix*(worldPositions?Matrix4x4.identity:obj.transform.localToWorldMatrix); mat.SetMatrix("_DiagnosticMVP",mvp);
    report.AppendLine("worldPositions="+worldPositions+" firstClip="+(mvp*new Vector4(mesh.vertices[0].x,mesh.vertices[0].y,mesh.vertices[0].z,1)));
    foreach(int cull in new[]{0,1,2}) {
     mat.SetFloat("_Cull",cull);
     var cmd=new CommandBuffer();cmd.SetRenderTarget(rt);cmd.SetViewport(new Rect(0,0,1366,768));cmd.ClearRenderTarget(false,true,Color.black);cmd.DrawMesh(mesh,obj.transform.localToWorldMatrix,mat,0,0);Graphics.ExecuteCommandBuffer(cmd);cmd.Release();
     var old=RenderTexture.active;RenderTexture.active=rt;var tex=new Texture2D(1366,768,TextureFormat.RGBA32,false,true);tex.ReadPixels(new Rect(0,0,1366,768),0,0);tex.Apply();RenderTexture.active=old;
     int count=0,minX=1366,minY=768,maxX=-1,maxY=-1;var pixels=tex.GetPixels32();for(int y=0;y<768;y++)for(int x=0;x<1366;x++)if(pixels[y*1366+x].r>200){count++;minX=Math.Min(minX,x);maxX=Math.Max(maxX,x);minY=Math.Min(minY,y);maxY=Math.Max(maxY,y);}
     File.WriteAllBytes(dir+"/geometry_"+worldPositions+"_cull"+cull+".png",tex.EncodeToPNG());UnityEngine.Object.DestroyImmediate(tex);
     report.AppendLine("cull="+cull+" redPixels="+count+" bottomUpBounds="+minX+","+minY+".."+maxX+","+maxY);
     File.WriteAllText(dir+"/geometry_audit.txt",report.ToString());
    }
   } }finally{rt.Release();UnityEngine.Object.DestroyImmediate(rt);UnityEngine.Object.DestroyImmediate(mat);}
   File.WriteAllText(dir+"/geometry_audit.txt",report.ToString()+"Geometry-only diagnostic; not a final visual match. Scene not saved.");EditorApplication.Exit(0);
  }catch(Exception e){File.WriteAllText(dir+"/geometry_audit.txt",e.ToString());Debug.LogException(e);EditorApplication.Exit(1);}
 }
}
#endif


