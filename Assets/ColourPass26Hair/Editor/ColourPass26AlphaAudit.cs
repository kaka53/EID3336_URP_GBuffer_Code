#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Experimental.Rendering;
using EID4730;
public static class ColourPass26AlphaAudit {
 static string root=>Path.Combine(Application.streamingAssetsPath,"ColourPass26Hair");
 static byte[] Buffer(ColourPass26HairPass.Draw d,string name){foreach(var s in d.stages)foreach(var b in s.buffers)if(b.shaderName==name)return File.ReadAllBytes(Path.Combine(root,b.file));throw new Exception(name);}
 public static void Run(){
 string dir=Path.GetFullPath(".rdctools/colourpass26_hair");var report=new StringBuilder();
 try {
 EditorSceneManager.OpenScene("Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity");
 var camera=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();camera.aspect=1366f/768f;
 var obj=GameObject.Find("EID1721_instance_000");var mesh=obj.GetComponent<MeshFilter>().sharedMesh;
 var manifest=JsonUtility.FromJson<ColourPass26HairPass.Manifest>(File.ReadAllText(Path.Combine(root,"manifest.json")));
 var draw=Array.Find(manifest.draws,d=>d.eid==5057);var captured=Array.Find(manifest.textures,t=>t.id==223919);
 if(captured.format!="BC7_SRGB")throw new Exception("Unexpected base format");
 var texture=new Texture2D(captured.width,captured.height,GraphicsFormat.RGBA_BC7_SRGB,captured.mips,TextureCreationFlags.MipChain);
 foreach(var sub in captured.files)texture.SetPixelData(File.ReadAllBytes(Path.Combine(root,sub.file)),sub.mip);
 texture.Apply(false,true);texture.wrapMode=TextureWrapMode.Repeat;texture.filterMode=FilterMode.Bilinear;
 var shader=Shader.Find("Hidden/ColourPass26Hair/AlphaDiagnostic");if(shader==null||ShaderUtil.ShaderHasError(shader))throw new Exception("Shader error");
 var mat=new Material(shader);var rt=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);rt.Create();
 try {
 var vs=Buffer(draw,"CP26FVS_34_35");var ps=Buffer(draw,"CP26FPS_19_20");var material=Buffer(draw,"CP26FPS_53_54");
 var st=new Vector4(BitConverter.ToSingle(vs,160),BitConverter.ToSingle(vs,164),BitConverter.ToSingle(vs,168),BitConverter.ToSingle(vs,172));
 float bias=BitConverter.ToSingle(ps,416),tintAlpha=BitConverter.ToSingle(material,108);
 mat.SetTexture("_BaseMap",texture);mat.SetVector("_CapturedST",st);mat.SetFloat("_Bias",bias);mat.SetFloat("_TintAlpha",tintAlpha);
 mat.SetMatrix("_DiagnosticMVP",GL.GetGPUProjectionMatrix(camera.projectionMatrix,true)*camera.worldToCameraMatrix*obj.transform.localToWorldMatrix);
 report.AppendLine("EID5057 / RID223919 / native BC7 sRGB; ST="+st+" bias="+bias+" tintAlpha="+tintAlpha+" device="+SystemInfo.graphicsDeviceType);
 Color[] opaque=null;
 for(int mode=0;mode<4;mode++) {
 mat.SetFloat("_Mode",mode);bool blend=mode==1||mode==3;mat.SetFloat("_Src",blend?5:1);mat.SetFloat("_Dst",blend?10:0);
 var cmd=new CommandBuffer();cmd.SetRenderTarget(rt);cmd.SetViewport(new Rect(0,0,1366,768));cmd.ClearRenderTarget(false,true,new Color(0,.2f,.4f,0));cmd.DrawMesh(mesh,obj.transform.localToWorldMatrix,mat,0,0);Graphics.ExecuteCommandBuffer(cmd);cmd.Release();
 var previous=RenderTexture.active;RenderTexture.active=rt;var tex=new Texture2D(1366,768,TextureFormat.RGBAFloat,false,true);tex.ReadPixels(new Rect(0,0,1366,768),0,0);tex.Apply();RenderTexture.active=previous;
 var pixels=tex.GetPixels();File.WriteAllBytes(dir+"/alpha_mode"+mode+".f32",tex.GetRawTextureData());
 if(mode==0)opaque=pixels;
 int coverage=0,fractional=0,changed=0,nonfinite=0;
 for(int i=0;i<pixels.Length;i++){var p=pixels[i];if(float.IsNaN(p.r)||float.IsInfinity(p.r)||float.IsNaN(p.a)||float.IsInfinity(p.a))nonfinite++;if(opaque[i].r>.99f){coverage++;if(p.r>.01f&&p.r<.99f)fractional++;if(Mathf.Abs(p.r-opaque[i].r)>.001f)changed++;}}
 report.AppendLine("mode="+mode+" geometryPixels="+coverage+" fractionalRed="+fractional+" changedRed="+changed+" nonfinite="+nonfinite);
 var preview=new Texture2D(1366,768,TextureFormat.RGBA32,false,true);preview.SetPixels(pixels);preview.Apply();File.WriteAllBytes(dir+"/alpha_mode"+mode+".png",preview.EncodeToPNG());UnityEngine.Object.DestroyImmediate(preview);UnityEngine.Object.DestroyImmediate(tex);
 if(nonfinite>0 || coverage<10 || (mode==1&&fractional<10))throw new Exception("Alpha diagnostic validation failed mode="+mode);
 }
 report.AppendLine("PASS isolated front base-alpha diagnostic only; no scene depth, lighting or back-face outline. Not final restoration. Scene not saved.");
 }finally{rt.Release();UnityEngine.Object.DestroyImmediate(rt);UnityEngine.Object.DestroyImmediate(mat);UnityEngine.Object.DestroyImmediate(texture);}
 File.WriteAllText(dir+"/alpha_audit.txt",report.ToString());EditorApplication.Exit(0);
 }catch(Exception e){File.WriteAllText(dir+"/alpha_audit.txt",report+"\n"+e);Debug.LogException(e);EditorApplication.Exit(1);}
 }
}
#endif
