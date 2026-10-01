#if UNITY_EDITOR
using System;
using System.IO;
using System.Reflection;
using System.Collections.Generic;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using EID4730;
public static class ColourPass26BackVertexAudit {
 const BindingFlags F=BindingFlags.Instance|BindingFlags.NonPublic;
 static bool runReference;
 public static void RunAll(){runReference=true;Run();}
 public static void Run(){string dir=Path.GetFullPath(".rdctools/colourpass26_hair/geometry_reference");try{
 EditorSceneManager.OpenScene("Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity");
 var cam=GameObject.Find("EID3336 RenderDoc Camera").GetComponent<Camera>();cam.aspect=1366f/768f;
 using(var session=new ColourPass26HairPass()){
 var t=typeof(ColourPass26HairPass);t.GetMethod("Initialize",F).Invoke(session,null);var manifest=(ColourPass26HairPass.Manifest)t.GetField("manifest",F).GetValue(session);var buffers=(Dictionary<string,ComputeBuffer>)t.GetField("buffers",F).GetValue(session);var textures=(Dictionary<int,Texture>)t.GetField("textures",F).GetValue(session);
 var cs=AssetDatabase.LoadAssetAtPath<ComputeShader>("Assets/ColourPass26Hair/Shaders/CP26BackVertexAudit.compute");int kernel=cs.FindKernel("Audit");
 foreach(int index in new[]{1,3}){int eid=manifest.draws[index].eid;var go=GameObject.Find(index==1?"EID1717_instance_000":"EID1721_instance_000");var mesh=(Mesh)t.GetMethod("Canonical",F).Invoke(session,new object[]{go.GetComponent<MeshFilter>().sharedMesh});
 var raw=new List<Vector3>();mesh.GetUVs(6,raw);var positions=raw.ToArray();var weights=new List<Vector4>();mesh.GetUVs(7,weights);var boneWeights=mesh.boneWeights;var normals=mesh.normals;var tangents=mesh.tangents;var uvs=mesh.uv;var dirs=new List<Vector4>();mesh.GetUVs(4,dirs);var packed=new List<Vector3>();mesh.GetUVs(1,packed);
 var input=new Vector4[mesh.vertexCount*7];for(int i=0;i<mesh.vertexCount;i++){input[i*7]=positions[i];input[i*7+1]=normals[i];input[i*7+2]=tangents[i];input[i*7+3]=dirs[i];input[i*7+4]=new Vector4(uvs[i].x,uvs[i].y,packed[i].x,0);input[i*7+5]=weights[i];input[i*7+6]=new Vector4(boneWeights[i].boneIndex0,boneWeights[i].boneIndex1,boneWeights[i].boneIndex2,boneWeights[i].boneIndex3);}
 var ib=new ComputeBuffer(input.Length,16);ib.SetData(input);var ob=new ComputeBuffer(mesh.vertexCount*6,16);
 try{foreach(var stage in manifest.draws[index].stages)if(stage.stage=="VS"){foreach(var b in stage.buffers){if(b.kind=="storage")cs.SetBuffer(kernel,b.shaderName,buffers[b.file]);else cs.SetConstantBuffer(Shader.PropertyToID(b.shaderName),buffers[b.file],0,(int)new FileInfo(Path.Combine(Application.streamingAssetsPath,"ColourPass26Hair",b.file)).Length);}foreach(var tex in stage.textures)cs.SetTexture(kernel,tex.shaderName,textures[tex.id]);}
 cs.SetBuffer(kernel,"_AuditInput",ib);cs.SetBuffer(kernel,"_AuditOutput",ob);cs.SetInt("_AuditCount",mesh.vertexCount);cs.SetFloat("_CP26UseCapturedProjection",1);cs.SetMatrix("_CP26ObjectToWorld",go.transform.localToWorldMatrix);cs.SetMatrix("_CP26ObjectToClip",GL.GetGPUProjectionMatrix(cam.projectionMatrix,true)*cam.worldToCameraMatrix*go.transform.localToWorldMatrix);
 cs.Dispatch(kernel,(mesh.vertexCount+63)/64,1,1);var output=new Vector4[mesh.vertexCount*6];ob.GetData(output);
 using(var w=new BinaryWriter(File.Open(dir+"/"+eid+"_unity_post.bin",FileMode.Create)))foreach(var v in output){w.Write(v.x);w.Write(v.y);w.Write(v.z);w.Write(v.w);}
 using(var w=new BinaryWriter(File.Open(dir+"/"+eid+"_unity_input.bin",FileMode.Create)))foreach(var v in input){w.Write(v.x);w.Write(v.y);w.Write(v.z);w.Write(v.w);}
 }finally{ib.Release();ob.Release();}
 }
 }
 File.WriteAllText(dir+"/unity_audit.txt","Compute vertex outputs exported. Scene not saved.");if(runReference)ColourPass26ReferenceAudit.Run();else EditorApplication.Exit(0);
 }catch(Exception e){File.WriteAllText(dir+"/unity_audit.txt",e.ToString());Debug.LogException(e);EditorApplication.Exit(1);}}
}
#endif
