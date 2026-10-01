#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using EID4730;
public static class EID4740Assets
{
 public const string Root="Assets/EID4740_RenderDocRestore";
 public const string OriginalRoot="Assets/ColourPass6_VS215439_PS215440_Batch";
 public const string OriginalMeshPath=OriginalRoot+"/Geometry/Meshes/EID1597_VSInput.asset";
 public const string OriginalMaterialPath=OriginalRoot+"/Materials/EID1597_VS215439_PS215440.mat";
 public static void Build(){
  var source=AssetDatabase.LoadAssetAtPath<Mesh>(OriginalMeshPath);
  if(source==null||source.vertexCount!=208||source.GetIndexCount(0)!=888)throw new Exception("EID1597 source geometry missing/mismatched");
  var shader=AssetDatabase.LoadAssetAtPath<Shader>(Root+"/Shaders/EID4740_CharacterForward.shader");
  if(shader==null)throw new Exception("EID4740 shader missing");
  byte[] stream0=File.ReadAllBytes(Root+"/Captured/Verified/native_stream0.bytes");
  var oldPositions=source.vertices;float maxError=0;
  for(int i=0;i<208;i++){
   var captured=new Vector3(BitConverter.ToSingle(stream0,i*40),BitConverter.ToSingle(stream0,i*40+4),BitConverter.ToSingle(stream0,i*40+8));
   maxError=Mathf.Max(maxError,Vector3.Distance(captured,oldPositions[i]));
   Buffer.BlockCopy(BitConverter.GetBytes(oldPositions[i].x),0,stream0,i*40,4);
   Buffer.BlockCopy(BitConverter.GetBytes(oldPositions[i].y),0,stream0,i*40+4,4);
   Buffer.BlockCopy(BitConverter.GetBytes(oldPositions[i].z),0,stream0,i*40+8,4);
  }
  if(maxError>2e-5f)throw new Exception("EID1597 is not the same baked geometry: "+maxError);
  var ix=File.ReadAllBytes(Root+"/Captured/Verified/indices.bytes");var oldIndices=source.GetIndices(0);
  for(int i=0;i<888;i++)if(oldIndices[i]!=BitConverter.ToUInt16(ix,i*2))throw new Exception("Original EID1597 index mismatch "+i);
  string path=Root+"/EID4740_Mesh.asset";var mesh=AssetDatabase.LoadAssetAtPath<Mesh>(path);bool create=mesh==null;
  if(create)mesh=new Mesh();else mesh.Clear();mesh.name="EID4740 208 vertices 888 indices (EID1597 exact positions)";
  mesh.SetVertexBufferParams(208,
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
  mesh.SetIndexBufferParams(888,IndexFormat.UInt16);mesh.SetIndexBufferData(ix,0,0,ix.Length);mesh.subMeshCount=1;
  mesh.SetSubMesh(0,new SubMeshDescriptor(0,888,MeshTopology.Triangles));mesh.bounds=source.bounds;
  if(create)AssetDatabase.CreateAsset(mesh,path);else EditorUtility.SetDirty(mesh);
  path=Root+"/M_EID4740.mat";var mat=AssetDatabase.LoadAssetAtPath<Material>(path);
  if(mat==null){mat=new Material(shader);AssetDatabase.CreateAsset(mat,path);}else mat.shader=shader;
  mat.renderQueue=2000;mat.enableInstancing=false;
  using(var session=new EID4740ReplaySession("Assets/StreamingAssets/EID4740Replay/replay.json",false)){
   if(session.TextureBindingCount!=14||session.BufferBindingCount!=15)throw new Exception("EID4740 binding count mismatch");
   foreach(var pair in session.TextureBindings){
    path=Root+"/Textures/"+pair.Key+".asset";var tex=AssetDatabase.LoadAssetAtPath<Texture>(path);
    if(tex==null){tex=UnityEngine.Object.Instantiate(pair.Value);tex.hideFlags=HideFlags.None;AssetDatabase.CreateAsset(tex,path);}
    else{EditorUtility.CopySerialized(pair.Value,tex);tex.hideFlags=HideFlags.None;EditorUtility.SetDirty(tex);}
    mat.SetTexture(pair.Key,tex);AssetDatabase.SaveAssetIfDirty(tex);
   }
  }
  EditorUtility.SetDirty(mat);AssetDatabase.SaveAssetIfDirty(mesh);AssetDatabase.SaveAssetIfDirty(mat);
  File.WriteAllText(Root+"/Captured/Verified/unity_asset_validation.txt","vertices=208 indices=888\noriginalToCapturePositionMaxError="+maxError+"\nforwardPositions=exact EID1597 original\nsourceMeshUnmodified=True\ntextures=14 buffers=15\n");
 }
}
#endif
