using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using EID4730;
[InitializeOnLoad]
public static class EID4817ColorAudit {
 static string Dir=>Path.GetFullPath(Path.Combine(Application.dataPath,"../.rdctools/eid4817_colorfix"));
 static double next;
 static EID4817ColorAudit(){EditorApplication.update+=Tick;}
 static void Tick(){if(EditorApplication.isCompiling||EditorApplication.isUpdating||EditorApplication.timeSinceStartup<next)return;next=EditorApplication.timeSinceStartup+1;string req=Dir+"/request.txt";if(!File.Exists(req))return;string a=File.ReadAllText(req).Trim();File.Delete(req);try{if(a=="refresh")AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);else Run(a);File.WriteAllText(Dir+"/result.txt","SUCCESS "+a);}catch(Exception e){File.WriteAllText(Dir+"/result.txt",e.ToString());Debug.LogException(e);}}
 static void ValidateDecoder(){
  var method=typeof(EID4817ReplaySession).GetMethod("DecodeUnsignedFloat",System.Reflection.BindingFlags.NonPublic|System.Reflection.BindingFlags.Static);if(method==null)throw new Exception("Missing packed-float decoder");int tested=0;
  foreach(int n in new[]{5,6})for(uint bits=0;bits<(1u<<(n+5));bits++){
   uint exponent=bits>>n,mantissa=bits&((1u<<n)-1u);float expected;
   if(exponent==0)expected=mantissa*(n==6?0.00000095367431640625f:0.0000019073486328125f);
   else if(exponent==31)expected=mantissa==0?float.PositiveInfinity:float.NaN;
   else{uint ieee=((exponent+112u)<<23)|(mantissa<<(23-n));expected=BitConverter.ToSingle(BitConverter.GetBytes(ieee),0);}
   float actual=(float)method.Invoke(null,new object[]{bits,n});if(!(float.IsNaN(expected)?float.IsNaN(actual):actual==expected))throw new Exception("Packed float decode mismatch: "+n+" bits="+bits);tested++;
  }
  File.WriteAllText(Dir+"/decoder_regression.txt","PASS "+tested+" bit patterns (zero, subnormal, exponent below/above bias, Inf and NaN)");
 }
 public static void Run(string prefix){
  ValidateDecoder();
  var scene=UnityEngine.SceneManagement.SceneManager.GetActiveScene();if(!scene.path.EndsWith("EID3336_RenderDocCamera.unity"))throw new Exception("Wrong scene; no automatic scene switch");
  var obj=GameObject.Find("EID4817_instance_000");var source=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();var mat=obj.GetComponent<Renderer>().sharedMaterial;
  if(ShaderUtil.ShaderHasError(mat.shader))throw new Exception("Shader errors");bool dirty=scene.isDirty;var originalVP=source.projectionMatrix;var matrix=obj.transform.localToWorldMatrix;var oldActive=RenderTexture.active;
  var go=new GameObject("EID4817 temporary color audit"){hideFlags=HideFlags.HideAndDontSave};var cam=go.AddComponent<Camera>();cam.CopyFrom(source);cam.enabled=false;cam.transform.SetPositionAndRotation(source.transform.position,source.transform.rotation);var srcData=source.GetComponent<UniversalAdditionalCameraData>();if(srcData!=null)EditorUtility.CopySerialized(srcData,go.AddComponent<UniversalAdditionalCameraData>());cam.aspect=1366f/768f;
  var final=new RenderTexture(1366,768,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);var before=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);var after=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);final.Create();before.Create();after.Create();var hook=EID4730RenderFeature.CaptureEID4817ColorForDiagnostics;var log=new StringBuilder();int hits=0;
  try{cam.targetTexture=final;EID4730RenderFeature.CaptureEID4817ColorForDiagnostics=(cmd,rt,post)=>{cmd.CopyTexture(rt.nameID,post?after:before);hits++;};cam.Render();cam.Render();if(hits!=4)throw new Exception("Hook count="+hits);Dump(before,prefix+"_before");Dump(after,prefix+"_after");Dump(final,prefix+"_final");
   log.AppendLine("device="+SystemInfo.graphicsDeviceType+" hooks="+hits+" shaderErrors=0 material="+AssetDatabase.GetAssetPath(mat));foreach(string n in mat.GetTexturePropertyNames()){var t=mat.GetTexture(n);log.AppendLine(n+"="+(t?AssetDatabase.GetAssetPath(t)+" "+t.graphicsFormat:"NULL"));}
   if(matrix!=obj.transform.localToWorldMatrix||source.projectionMatrix!=originalVP)throw new Exception("Source transform/projection changed");
  }finally{EID4730RenderFeature.CaptureEID4817ColorForDiagnostics=hook;RenderTexture.active=oldActive;final.Release();before.Release();after.Release();UnityEngine.Object.DestroyImmediate(final);UnityEngine.Object.DestroyImmediate(before);UnityEngine.Object.DestroyImmediate(after);UnityEngine.Object.DestroyImmediate(go);log.AppendLine("sceneDirty="+dirty+" -> "+scene.isDirty+"; source camera/scene not saved");File.WriteAllText(Dir+"/"+prefix+".txt",log.ToString());}
 }
 static void Dump(RenderTexture rt,string name){var old=RenderTexture.active;var cpu=new Texture2D(rt.width,rt.height,TextureFormat.RGBAFloat,false,true);try{RenderTexture.active=rt;cpu.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0);cpu.Apply();File.WriteAllBytes(Dir+"/"+name+".f32",cpu.GetRawTextureData());}finally{RenderTexture.active=old;UnityEngine.Object.DestroyImmediate(cpu);}}
}
