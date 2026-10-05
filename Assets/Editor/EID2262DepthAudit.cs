#if UNITY_EDITOR
using System;using System.IO;using UnityEditor;using UnityEngine;using UnityEngine.Rendering;using UnityEngine.Rendering.Universal;
[InitializeOnLoad]public static class EID2262DepthAudit {
 const string D="D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/eid2262_depth_1005";static bool active;
 static EID2262DepthAudit(){EditorApplication.update+=Tick;AssemblyReloadEvents.beforeAssemblyReload+=Stop;}
 static void Stop(){active=false;RenderPipelineManager.endCameraRendering-=End;}
 static void Tick(){if(EditorApplication.isCompiling||EditorApplication.isUpdating||active||!File.Exists(D+"/depth.request"))return;File.Delete(D+"/depth.request");active=true;RenderPipelineManager.endCameraRendering+=End;SceneView.RepaintAll();}
 static void Dump(RenderTexture rt,string n){var old=RenderTexture.active;var t=new Texture2D(rt.width,rt.height,TextureFormat.RGBAFloat,false,true);try{RenderTexture.active=rt;t.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0);t.Apply();File.WriteAllBytes(D+"/"+n+".f32",t.GetRawTextureData());}finally{RenderTexture.active=old;UnityEngine.Object.DestroyImmediate(t);}}
 static void End(ScriptableRenderContext context,Camera cam){if(!active||cam.cameraType!=CameraType.SceneView)return;Stop();var go=GameObject.Find("EID2262");if(!go)return;
  try{if(!EID3336FiveMRTLightingInputs.TryGetVegetationLightPassInputs(cam,out var depth,out var packed,out var normal,out var albedo))throw new Exception("No same-camera GBuffer");
   int w=depth.width,h=depth.height;var rt=new RenderTexture(w,h,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);rt.Create();var mat=new Material(Shader.Find("Hidden/EID2262/DepthAudit"));var cmd=new CommandBuffer();bool async=ShaderUtil.allowAsyncCompilation;ShaderUtil.allowAsyncCompilation=false;
   try{ShaderUtil.CompilePass(mat,0,true);ShaderUtil.CompilePass(mat,1,true);
    cmd.SetRenderTarget(rt);cmd.SetViewport(new Rect(0,0,w,h));cmd.SetGlobalTexture("_AuditDepth",depth);cmd.DrawProcedural(Matrix4x4.identity,mat,0,MeshTopology.Triangles,3);Graphics.ExecuteCommandBuffer(cmd);Dump(rt,"scene_depth");cmd.Clear();
    cmd.SetRenderTarget(rt);cmd.ClearRenderTarget(true,true,new Color(-1,-1,-1,0));cmd.SetViewProjectionMatrices(cam.worldToCameraMatrix,cam.projectionMatrix);cmd.DrawMesh(go.GetComponent<MeshFilter>().sharedMesh,go.transform.localToWorldMatrix,mat,0,1);Graphics.ExecuteCommandBuffer(cmd);Dump(rt,"target_depth");
    cmd.Clear();cmd.SetRenderTarget(rt);cmd.ClearRenderTarget(true,true,new Color(-1,-1,-1,0));cmd.SetViewProjectionMatrices(cam.worldToCameraMatrix,cam.projectionMatrix);cmd.DrawMesh(go.GetComponent<MeshFilter>().sharedMesh,go.transform.localToWorldMatrix,mat,0,2);Graphics.ExecuteCommandBuffer(cmd);Dump(rt,"target_back_depth");
    Graphics.Blit(albedo,rt);Dump(rt,"scene_albedo");Graphics.Blit(normal,rt);Dump(rt,"scene_normal");
    if(cam.targetTexture){Graphics.Blit(cam.targetTexture,rt);Dump(rt,"scene_final");}
    File.WriteAllText(D+"/depth_audit.txt","PASS "+DateTime.Now+"\nSize="+w+"x"+h+"\nDepth="+depth.name+"\nCamera="+cam.transform.position.ToString("R")+"\nMatrix="+go.transform.localToWorldMatrix.ToString("R")+"\nReversedZ="+SystemInfo.usesReversedZBuffer+"\nShader="+go.GetComponent<Renderer>().sharedMaterial.shader.name+"\n");
   }finally{ShaderUtil.allowAsyncCompilation=async;cmd.Release();rt.Release();UnityEngine.Object.DestroyImmediate(rt);UnityEngine.Object.DestroyImmediate(mat);}
  }catch(Exception e){File.WriteAllText(D+"/depth_audit.txt",e.ToString());Debug.LogException(e);}}
}
#endif
