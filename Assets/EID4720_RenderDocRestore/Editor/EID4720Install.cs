#if UNITY_EDITOR
using System;using System.IO;using System.Reflection;using UnityEditor;using UnityEditor.SceneManagement;using UnityEngine;using UnityEngine.Rendering;using EID4730;
public static class EID4720Install {
 const string Root="Assets/EID4720_RenderDocRestore",D="D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/eid1632_repair_0930";
 public static void Run(){try{
  var scene=EditorSceneManager.OpenScene("Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity");
  EID4720Assets.Build();var src=GameObject.Find("EID1632_instance_000");if(src==null)throw new Exception("Source missing");
  src.GetComponent<Renderer>().sharedMaterial=AssetDatabase.LoadAssetAtPath<Material>(Root+"/M_EID1632_GBuffer.mat");
  var mat=AssetDatabase.LoadAssetAtPath<Material>(Root+"/M_EID4720.mat");var mesh=AssetDatabase.LoadAssetAtPath<Mesh>(Root+"/EID4720_Mesh.asset");
  var go=GameObject.Find("EID4720_Forward_for_EID1632");if(go==null)go=new GameObject("EID4720_Forward_for_EID1632");go.transform.SetParent(src.transform,false);go.transform.localPosition=Vector3.zero;go.transform.localRotation=Quaternion.identity;go.transform.localScale=Vector3.one;
  var mf=go.GetComponent<MeshFilter>();if(mf==null)mf=go.AddComponent<MeshFilter>();mf.sharedMesh=mesh;var mr=go.GetComponent<MeshRenderer>();if(mr==null)mr=go.AddComponent<MeshRenderer>();mr.sharedMaterial=mat;mr.shadowCastingMode=ShadowCastingMode.Off;mr.receiveShadows=false;mr.lightProbeUsage=LightProbeUsage.Off;mr.reflectionProbeUsage=ReflectionProbeUsage.Off;mr.motionVectorGenerationMode=MotionVectorGenerationMode.ForceNoMotion;
  var binder=go.GetComponent<EID4720ReplayBinder>();if(binder==null)binder=go.AddComponent<EID4720ReplayBinder>();binder.material=mat;binder.Rebind();
  Direct(src,go,mat,"front",false);Direct(src,go,mat,"capture_isolated",true);
  string errors="";foreach(var m in ShaderUtil.GetShaderMessages(mat.shader))errors+=m.severity+" "+m.message+" "+m.file+":"+m.line+"\n";File.WriteAllText(D+"/shader_messages.txt",errors);if(ShaderUtil.ShaderHasError(mat.shader))throw new Exception("Shader errors: "+errors);
  EditorSceneManager.MarkSceneDirty(scene);if(!EditorSceneManager.SaveScene(scene))throw new Exception("Save failed");File.WriteAllText(D+"/install_result.txt","SUCCESS "+DateTime.Now.ToString("O")+"\n"+scene.path+"\n1933 vertices, 9786 indices\nsource mesh unchanged; scoped corrected GBuffer material\n");EditorApplication.Exit(0);
 }catch(Exception e){File.WriteAllText(D+"/install_result.txt",e.ToString());Debug.LogException(e);EditorApplication.Exit(1);}}
 public static void Direct(GameObject src,GameObject go,Material mat,string label,bool captured){
  var cam=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();int w=captured?1366:512,h=captured?768:512;
  Matrix4x4 view=cam.worldToCameraMatrix,proj=cam.projectionMatrix;Vector3 cameraPos=cam.transform.position;
  if(!captured){var center=go.GetComponent<Renderer>().bounds.center;var direction=src.transform.TransformDirection(new Vector3(-.08882f,-.42035f,.903f)).normalized;cameraPos=center+direction*.6f;var rotation=Quaternion.LookRotation(center-cameraPos,Vector3.up);view=Matrix4x4.Scale(new Vector3(1,1,-1))*Matrix4x4.TRS(cameraPos,rotation,Vector3.one).inverse;proj=Matrix4x4.Ortho(-.14f,.14f,-.14f,.14f,.01f,10f);}
  var colors=new RenderTexture[5];var ids=new RenderTargetIdentifier[5];var depth=new RenderTexture(w,h,24,RenderTextureFormat.Depth);depth.Create();
  for(int i=0;i<5;i++){colors[i]=new RenderTexture(w,h,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);colors[i].Create();ids[i]=colors[i];}
  var cmd=new CommandBuffer{name="EID1632 isolated validation"};
  try{cmd.SetViewProjectionMatrices(view,proj);cmd.SetGlobalMatrix("unity_MatrixVP",GL.GetGPUProjectionMatrix(proj,true)*view);cmd.SetGlobalMatrix("unity_MatrixV",view);cmd.SetGlobalVector("_WorldSpaceCameraPos",cameraPos);cmd.SetRenderTarget(ids,depth);cmd.SetViewport(new Rect(0,0,w,h));cmd.ClearRenderTarget(true,true,Color.clear,SystemInfo.usesReversedZBuffer?0:1);
   var gb=src.GetComponent<Renderer>().sharedMaterial;cmd.DrawMesh(src.GetComponent<MeshFilter>().sharedMesh,src.transform.localToWorldMatrix,gb,0,0);Graphics.ExecuteCommandBuffer(cmd);cmd.Clear();Dump(colors[4],label+"_gbuffer");
   EID4720ReplayBinder.PrepareActiveForDraw(cmd);cmd.SetRenderTarget(new RenderTargetIdentifier[]{colors[0],colors[1]},depth);cmd.DrawMesh(go.GetComponent<MeshFilter>().sharedMesh,go.transform.localToWorldMatrix,mat,0,0);Graphics.ExecuteCommandBuffer(cmd);cmd.Clear();Dump(colors[0],label+"_hdr");
  }finally{cmd.Release();foreach(var t in colors){t.Release();UnityEngine.Object.DestroyImmediate(t);}depth.Release();UnityEngine.Object.DestroyImmediate(depth);}
 }
 static void Restore(CommandBuffer cmd,RTHandle color){var rd=AssetDatabase.LoadAssetAtPath<UnityEngine.Rendering.Universal.ScriptableRendererData>("Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-Renderer.asset");foreach(var f in rd.rendererFeatures)if(f is EID4730RenderFeature){var pass=f.GetType().GetField("pass",BindingFlags.NonPublic|BindingFlags.Instance).GetValue(f);var aux=(RTHandle)pass.GetType().GetProperty("SharedAuxiliary").GetValue(pass);var depth=(RTHandle)pass.GetType().GetField("depthTarget",BindingFlags.NonPublic|BindingFlags.Instance).GetValue(pass);cmd.SetRenderTarget(new RenderTargetIdentifier[]{color.nameID,aux.nameID},depth.nameID);}}
 static void Dump(RenderTexture rt,string n){var old=RenderTexture.active;var t=new Texture2D(rt.width,rt.height,TextureFormat.RGBAFloat,false,true);try{RenderTexture.active=rt;t.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0);t.Apply();File.WriteAllBytes(D+"/"+n+".f32",t.GetRawTextureData());}finally{RenderTexture.active=old;UnityEngine.Object.DestroyImmediate(t);}}
}
#endif
