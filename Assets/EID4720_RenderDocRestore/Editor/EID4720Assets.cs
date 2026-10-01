#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using EID4730;
public static class EID4720Assets
{
 public const string Root="Assets/EID4720_RenderDocRestore";
 public const string OriginalRoot="Assets/ColourPass6_VS215445_PS215446_Batch";
 public const string OriginalMeshPath=OriginalRoot+"/Geometry/Meshes/EID1632_VSInput.asset";
 public const string OriginalMaterialPath=OriginalRoot+"/Materials/EID1632_VS215445_PS215446.mat";
 public static void Build(){
  var source=AssetDatabase.LoadAssetAtPath<Mesh>(OriginalMeshPath);
  if(source==null||source.vertexCount!=1933||source.GetIndexCount(0)!=9786)throw new Exception("EID1632 source geometry missing/mismatched");
  var shader=AssetDatabase.LoadAssetAtPath<Shader>(Root+"/Shaders/EID4720_CharacterForward.shader");
  if(shader==null)throw new Exception("EID4720 shader missing");
  byte[] stream0=File.ReadAllBytes(Root+"/Captured/Verified/native_stream0.bytes");
  var oldPositions=source.vertices;float maxError=0;
  for(int i=0;i<1933;i++){
   var captured=new Vector3(BitConverter.ToSingle(stream0,i*40),BitConverter.ToSingle(stream0,i*40+4),BitConverter.ToSingle(stream0,i*40+8));
   maxError=Mathf.Max(maxError,Vector3.Distance(captured,oldPositions[i]));
   Buffer.BlockCopy(BitConverter.GetBytes(oldPositions[i].x),0,stream0,i*40,4);
   Buffer.BlockCopy(BitConverter.GetBytes(oldPositions[i].y),0,stream0,i*40+4,4);
   Buffer.BlockCopy(BitConverter.GetBytes(oldPositions[i].z),0,stream0,i*40+8,4);
  }
  if(maxError>2e-5f)throw new Exception("EID1632 is not the same baked geometry: "+maxError);
  var ix=File.ReadAllBytes(Root+"/Captured/Verified/indices.bytes");var oldIndices=source.GetIndices(0);
  for(int i=0;i<9786;i++)if(oldIndices[i]!=BitConverter.ToUInt16(ix,i*2))throw new Exception("Original EID1632 index mismatch "+i);
  string path=Root+"/EID4720_Mesh.asset";var mesh=AssetDatabase.LoadAssetAtPath<Mesh>(path);bool create=mesh==null;
  if(create)mesh=new Mesh();else mesh.Clear();mesh.name="EID4720 1933 vertices 9786 indices (EID1632 exact positions)";
  mesh.SetVertexBufferParams(1933,
   new VertexAttributeDescriptor(VertexAttribute.Position,VertexAttributeFormat.Float32,3,0),
   new VertexAttributeDescriptor(VertexAttribute.Normal,VertexAttributeFormat.Float32,3,0),
   new VertexAttributeDescriptor(VertexAttribute.Tangent,VertexAttributeFormat.Float32,4,0),
   new VertexAttributeDescriptor(VertexAttribute.Color,VertexAttributeFormat.UNorm8,4,1),
   new VertexAttributeDescriptor(VertexAttribute.TexCoord0,VertexAttributeFormat.Float32,2,1),
   new VertexAttributeDescriptor(VertexAttribute.TexCoord1,VertexAttributeFormat.Float32,1,1),
   new VertexAttributeDescriptor(VertexAttribute.TexCoord2,VertexAttributeFormat.Float32,2,1),
   new VertexAttributeDescriptor(VertexAttribute.TexCoord3,VertexAttributeFormat.Float32,1,1),
   new VertexAttributeDescriptor(VertexAttribute.TexCoord4,VertexAttributeFormat.Float32,3,1),
   new VertexAttributeDescriptor(VertexAttribute.TexCoord5,VertexAttributeFormat.Float32,3,1),
   new VertexAttributeDescriptor(VertexAttribute.TexCoord6,VertexAttributeFormat.UNorm16,4,2),
   new VertexAttributeDescriptor(VertexAttribute.TexCoord7,VertexAttributeFormat.UInt8,4,2));
  mesh.SetVertexBufferData(stream0,0,0,stream0.Length,0);
  for(int i=1;i<3;i++){byte[] b=File.ReadAllBytes(Root+"/Captured/Verified/native_stream"+i+".bytes");mesh.SetVertexBufferData(b,0,0,b.Length,i);}
  mesh.SetIndexBufferParams(9786,IndexFormat.UInt16);mesh.SetIndexBufferData(ix,0,0,ix.Length);mesh.subMeshCount=1;
  mesh.SetSubMesh(0,new SubMeshDescriptor(0,9786,MeshTopology.Triangles));mesh.bounds=source.bounds;
  if(create)AssetDatabase.CreateAsset(mesh,path);else EditorUtility.SetDirty(mesh);
  path=Root+"/M_EID4720.mat";var mat=AssetDatabase.LoadAssetAtPath<Material>(path);
  if(mat==null){mat=new Material(shader);AssetDatabase.CreateAsset(mat,path);}else mat.shader=shader;
  mat.renderQueue=2000;mat.enableInstancing=false;
  using(var session=new EID4720ReplaySession(EID4720ReplayPaths.ManifestPath(),false)){
   if(session.TextureBindingCount!=20||session.BufferBindingCount!=15)throw new Exception("EID4720 binding count mismatch");
   var shared=new System.Collections.Generic.Dictionary<string,string>{
    {"EID4720PS_39","Assets/EID4789_RenderDocRestore/Textures/EID4789PS_39.asset"},
    {"EID4720PS_60","Assets/EID4789_RenderDocRestore/Textures/EID4789PS_63.asset"},
    {"EID4720PS_47","Assets/EID4789_RenderDocRestore/Textures/EID4789PS_47.asset"},
    {"EID4720PS_45","Assets/EID4789_RenderDocRestore/Textures/EID4789PS_45.asset"},
    {"EID4720PS_43","Assets/EID4789_RenderDocRestore/Textures/EID4789PS_43.asset"},
    {"EID4720PS_46","Assets/EID4789_RenderDocRestore/Textures/EID4789PS_46.asset"},
    {"EID4720PS_44","Assets/EID4789_RenderDocRestore/Textures/EID4789PS_44.asset"},
    {"EID4720PS_42","Assets/EID4789_RenderDocRestore/Textures/EID4789PS_42.asset"},
    {"EID4720PS_65","Assets/EID4789_RenderDocRestore/Textures/EID4789PS_68.asset"},
    {"EID4720PS_56","Assets/EID4789_RenderDocRestore/Textures/EID4789PS_56.asset"},
    {"EID4720PS_55","Assets/EID4789_RenderDocRestore/Textures/EID4789PS_55.asset"},
   };
   foreach(var pair in session.TextureBindings){
    if(shared.TryGetValue(pair.Key,out var sharedPath)){var sharedTex=AssetDatabase.LoadAssetAtPath<Texture>(sharedPath);if(sharedTex==null)throw new Exception("Missing verified shared texture");mat.SetTexture(pair.Key,sharedTex);continue;}
    path=Root+"/Textures/"+pair.Key+".asset";var tex=AssetDatabase.LoadAssetAtPath<Texture>(path);
    if(tex==null){tex=UnityEngine.Object.Instantiate(pair.Value);tex.hideFlags=HideFlags.None;AssetDatabase.CreateAsset(tex,path);}
    else{EditorUtility.CopySerialized(pair.Value,tex);tex.hideFlags=HideFlags.None;EditorUtility.SetDirty(tex);}
    mat.SetTexture(pair.Key,tex);AssetDatabase.SaveAssetIfDirty(tex);
   }
  }
  EditorUtility.SetDirty(mat);AssetDatabase.SaveAssetIfDirty(mesh);AssetDatabase.SaveAssetIfDirty(mat);
  var gb=AssetDatabase.LoadAssetAtPath<Material>(Root+"/M_EID1632_GBuffer.mat");
  if(gb==null){gb=new Material(AssetDatabase.LoadAssetAtPath<Material>(OriginalMaterialPath));AssetDatabase.CreateAsset(gb,Root+"/M_EID1632_GBuffer.mat");}
  gb.shader=AssetDatabase.LoadAssetAtPath<Shader>(Root+"/Shaders/EID1632_VerifiedGBuffer.shader");EditorUtility.SetDirty(gb);AssetDatabase.SaveAssetIfDirty(gb);
  File.WriteAllText(Root+"/Captured/Verified/unity_asset_validation.txt","positionMaxError="+maxError+"\noriginal mesh/indices validated");
 }
}
#endif
