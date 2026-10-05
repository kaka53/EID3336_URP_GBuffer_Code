#if UNITY_EDITOR
using System;using System.IO;using System.Text;using UnityEditor;using UnityEngine;using UnityEngine.Rendering;
[InitializeOnLoad] public static class EID3448DepthRegression {
 const string D="D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/eid3448_depth_1005";
 static EID3448DepthRegression(){EditorApplication.update+=Tick;}
 static void Tick(){if(EditorApplication.isCompiling||EditorApplication.isUpdating||!File.Exists(D+"/test.request"))return;File.Delete(D+"/test.request");try{Run();}catch(Exception e){File.WriteAllText(D+"/test_result.txt",e.ToString());Debug.LogException(e);}}
 static void Run(){
 var target=GameObject.Find("EID3448_instance_001");if(!target)throw new Exception("Target missing");
 var source=target.GetComponent<Renderer>().sharedMaterial;
 var current=new Material(source);var legacy=new Material(Shader.Find("Hidden/EID3448/LegacyDepthRegression"));legacy.CopyPropertiesFromMaterial(source);
 var seed=new Material(Shader.Find("Hidden/EID3448/DepthSeed"));var mesh=new Mesh();
 mesh.vertices=new[]{new Vector3(-.8f,-.8f,0),new Vector3(.8f,-.8f,0),new Vector3(.8f,.8f,0),new Vector3(-.8f,.8f,0)};
 mesh.normals=new[]{Vector3.forward,Vector3.forward,Vector3.forward,Vector3.forward};mesh.colors=new[]{Color.red,Color.red,Color.red,Color.red};
 mesh.uv=new[]{Vector2.zero,Vector2.right,Vector2.one,Vector2.up};mesh.uv2=mesh.uv;
 mesh.triangles=new[]{0,1,2,0,2,3,2,1,0,3,2,0};
 var rt=new RenderTexture[5];var ids=new RenderTargetIdentifier[5];var depth=new RenderTexture(32,32,24,RenderTextureFormat.Depth);depth.Create();
 var cpu=new Texture2D(32,32,TextureFormat.RGBAFloat,false,true);var cmd=new CommandBuffer();var previous=RenderTexture.active;bool async=ShaderUtil.allowAsyncCompilation;ShaderUtil.allowAsyncCompilation=false;
 var log=new StringBuilder();bool pass=true;
 try{
 foreach(var m in new[]{current,legacy,seed}){ShaderUtil.CompilePass(m,0,true);if(ShaderUtil.ShaderHasError(m.shader))throw new Exception("Shader compile error: "+m.shader.name);}
 for(int i=0;i<5;i++){rt[i]=new RenderTexture(32,32,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);rt[i].Create();ids[i]=rt[i];}
 log.AppendLine("GPU="+SystemInfo.graphicsDeviceType+" reversedZ="+SystemInfo.usesReversedZBuffer+" source="+source.shader.name+" queue="+source.renderQueue);
 foreach(var m in new[]{legacy,current})foreach(float blocker in new[]{0f,1f,4f}){
 cmd.Clear();cmd.SetRenderTarget(ids,depth);cmd.SetViewport(new Rect(0,0,32,32));cmd.ClearRenderTarget(true,true,Color.clear);
 cmd.SetViewProjectionMatrices(Matrix4x4.identity,Matrix4x4.Ortho(-1,1,-1,1,.1f,10f));
 if(blocker>0)cmd.DrawMesh(mesh,Matrix4x4.Translate(new Vector3(0,0,-blocker)),seed);
 cmd.DrawMesh(mesh,Matrix4x4.Translate(new Vector3(0,0,-2)),m);Graphics.ExecuteCommandBuffer(cmd);
 RenderTexture.active=rt[0];cpu.ReadPixels(new Rect(0,0,32,32),0,0);cpu.Apply();int covered=0;foreach(var c in cpu.GetPixels())if(c.a>.25f)covered++;
 log.AppendLine((m==legacy?"legacy GEqual":"fixed LEqual")+" blocker="+blocker+" targetPixels="+covered);
 if(m==current)pass&=blocker==1?covered==0:covered>500;
 }
 log.AppendLine(pass?"PASS: clear visible; near occluder blocks; far background does not block.":"FAIL: depth regression expectations not met.");
 log.AppendLine("Scene and camera transforms unchanged. Original material was not modified by the test.");
 File.WriteAllText(D+"/test_result.txt",log.ToString());
 }finally{ShaderUtil.allowAsyncCompilation=async;RenderTexture.active=previous;cmd.Release();foreach(var r in rt)if(r){r.Release();UnityEngine.Object.DestroyImmediate(r);}depth.Release();UnityEngine.Object.DestroyImmediate(depth);foreach(var o in new UnityEngine.Object[]{cpu,mesh,current,legacy,seed})UnityEngine.Object.DestroyImmediate(o);SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();}
 }
}
#endif
