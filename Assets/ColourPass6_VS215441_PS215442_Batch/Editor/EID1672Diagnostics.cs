#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEngine;
using UnityEditor;
using UnityEngine.Rendering;
using UnityEditor.SceneManagement;
using EID4730;
[InitializeOnLoad]
public static class EID1672Diagnostics
{
 const string Dir=".rdctools/eid1672_compare";
 const string Scene="Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
 static double next;
 static EID1672Diagnostics(){EditorApplication.update+=Tick;}
 static void Tick(){if(EditorApplication.isCompiling||EditorApplication.isUpdating||EditorApplication.timeSinceStartup<next)return;next=EditorApplication.timeSinceStartup+1;string p=Dir+"/request.txt";if(!File.Exists(p))return;string tag=File.ReadAllText(p).Trim();File.Delete(p);try{Run(tag);File.WriteAllText(Dir+"/result.txt","SUCCESS "+tag);}catch(Exception e){File.WriteAllText(Dir+"/result.txt","FAIL "+e);Debug.LogException(e);}}
 public static void Run(string tag){
 var go=GameObject.Find("EID1672_instance_000");if(go==null||go.scene.path!=Scene)throw new Exception("Wrong scene");
 var cam=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();var mesh=go.GetComponent<MeshFilter>().sharedMesh;var mat=go.GetComponent<Renderer>().sharedMaterial;
 var m=go.transform.localToWorldMatrix;var v=cam.worldToCameraMatrix;var p=cam.projectionMatrix;
 var log=new StringBuilder(DateTime.Now.ToString("O")+" device="+SystemInfo.graphicsDeviceType+"\n");log.AppendLine("mesh="+AssetDatabase.GetAssetPath(mesh)+" vertices="+mesh.vertexCount+" indices="+mesh.GetIndexCount(0)+" M="+m+" material="+AssetDatabase.GetAssetPath(mat)+" shader="+mat.shader.name+" gbufferEnabled="+mat.GetShaderPassEnabled("UniversalGBuffer"));
 foreach(var msg in ShaderUtil.GetShaderMessages(mat.shader))log.AppendLine(msg.severity+" "+msg.message);if(ShaderUtil.ShaderHasError(mat.shader))throw new Exception(log.ToString());
 var old=cam.targetTexture;var active=RenderTexture.active;var final=new RenderTexture(1366,768,24,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);var stage=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);final.Create();stage.Create();int hits=0;
 try{cam.targetTexture=final;EID4730RenderFeature.CaptureEID4765ColorForDiagnostics=(cmd,rt)=>{cmd.CopyTexture(rt.nameID,stage);hits++;};cam.Render();cam.Render();if(hits!=2)throw new Exception("Stage not reached "+hits);Dump(stage,tag+"_stage");Dump(final,tag+"_final");log.AppendLine("hooks="+hits);}
 finally{EID4730RenderFeature.CaptureEID4765ColorForDiagnostics=null;cam.targetTexture=old;RenderTexture.active=active;final.Release();stage.Release();UnityEngine.Object.DestroyImmediate(final);UnityEngine.Object.DestroyImmediate(stage);}
 var colors=new RenderTexture[5];var ids=new RenderTargetIdentifier[5];var depth=new RenderTexture(1366,768,24,RenderTextureFormat.Depth);depth.Create();for(int i=0;i<5;i++){colors[i]=new RenderTexture(1366,768,0,RenderTextureFormat.ARGBFloat,RenderTextureReadWrite.Linear);colors[i].Create();ids[i]=colors[i];}var cb=new CommandBuffer{name="EID1672 isolated GBuffer verification"};
 try{int pass=mat.FindPass("VS215441_PS215442_UniversalGBuffer");if(pass<0)throw new Exception("GBuffer missing");cb.SetViewProjectionMatrices(v,p);cb.SetGlobalMatrix("unity_MatrixVP",GL.GetGPUProjectionMatrix(p,true)*v);cb.SetGlobalVector("_WorldSpaceCameraPos",cam.transform.position);cb.SetRenderTarget(ids,depth);cb.ClearRenderTarget(true,true,new Color(-10,-10,-10,-10));cb.DrawMesh(mesh,m,mat,0,pass);Graphics.ExecuteCommandBuffer(cb);Dump(colors[3],tag+"_gb3");Dump(colors[4],tag+"_gb4");}
 finally{cb.Release();foreach(var t in colors){t.Release();UnityEngine.Object.DestroyImmediate(t);}depth.Release();UnityEngine.Object.DestroyImmediate(depth);}
 if(m!=go.transform.localToWorldMatrix||mesh!=go.GetComponent<MeshFilter>().sharedMesh||v!=cam.worldToCameraMatrix||p!=cam.projectionMatrix)throw new Exception("Geometry/camera changed");
 if(tag=="after"){AssetDatabase.SaveAssets();if(!EditorSceneManager.SaveScene(go.scene))throw new Exception("Save failed");log.AppendLine("Scene saved; mesh/M/VP unchanged");}
 File.WriteAllText(Dir+"/"+tag+"_audit.txt",log.ToString());SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();
 }
 static void Dump(RenderTexture rt,string name){var old=RenderTexture.active;var cpu=new Texture2D(rt.width,rt.height,TextureFormat.RGBAFloat,false,true);try{RenderTexture.active=rt;cpu.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0);cpu.Apply();File.WriteAllBytes(Dir+"/"+name+".f32",cpu.GetRawTextureData());}finally{RenderTexture.active=old;UnityEngine.Object.DestroyImmediate(cpu);}}
}
#endif
