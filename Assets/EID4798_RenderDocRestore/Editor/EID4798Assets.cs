#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using EID4730;
public static class EID4798Assets
{
 public const string Root="Assets/EID4798_RenderDocRestore";
 public const string OriginalRoot="Assets/ColourPass6_VS215452_PS215453_Batch";
 public const string OriginalMeshPath=OriginalRoot+"/Geometry/Meshes/EID1721_VSInput.asset";
 public const string OriginalMaterialPath=OriginalRoot+"/Materials/EID1721_VS215452_PS215453.mat";
 public static void Build(){
  var source=AssetDatabase.LoadAssetAtPath<Mesh>(OriginalMeshPath);
  if(source==null||source.vertexCount!=11584||source.GetIndexCount(0)!=45003)throw new Exception("EID1721 source geometry missing/mismatched");
  var shader=AssetDatabase.LoadAssetAtPath<Shader>(Root+"/Shaders/EID4798_CharacterForward.shader");
  if(shader==null)throw new Exception("EID4798 shader missing");
  byte[] stream0=File.ReadAllBytes(Root+"/Captured/Verified/native_stream0.bytes");
  var oldPositions=source.vertices;float maxError=0;
  for(int i=0;i<11584;i++){
   var captured=new Vector3(BitConverter.ToSingle(stream0,i*40),BitConverter.ToSingle(stream0,i*40+4),BitConverter.ToSingle(stream0,i*40+8));
   maxError=Mathf.Max(maxError,Vector3.Distance(captured,oldPositions[i]));
   Buffer.BlockCopy(BitConverter.GetBytes(oldPositions[i].x),0,stream0,i*40,4);
   Buffer.BlockCopy(BitConverter.GetBytes(oldPositions[i].y),0,stream0,i*40+4,4);
   Buffer.BlockCopy(BitConverter.GetBytes(oldPositions[i].z),0,stream0,i*40+8,4);
  }
  if(maxError>2e-5f)throw new Exception("EID1721 is not the same baked geometry: "+maxError);
  var ix=File.ReadAllBytes(Root+"/Captured/Verified/indices.bytes");var oldIndices=source.GetIndices(0);
  for(int i=0;i<45003;i++)if(oldIndices[i]!=BitConverter.ToUInt16(ix,i*2))throw new Exception("Original EID1721 index mismatch "+i);
  string path=Root+"/EID4798_Mesh.asset";var mesh=AssetDatabase.LoadAssetAtPath<Mesh>(path);bool create=mesh==null;
  if(create)mesh=new Mesh();else mesh.Clear();mesh.name="EID4798 11584 vertices 45003 indices (EID1721 exact positions)";
  mesh.SetVertexBufferParams(11584,
   new VertexAttributeDescriptor(VertexAttribute.Position,VertexAttributeFormat.Float32,3,0),
   new VertexAttributeDescriptor(VertexAttribute.Normal,VertexAttributeFormat.Float32,3,0),
   new VertexAttributeDescriptor(VertexAttribute.Tangent,VertexAttributeFormat.Float32,4,0),
   new VertexAttributeDescriptor(VertexAttribute.Color,VertexAttributeFormat.UNorm8,4,1),
   new VertexAttributeDescriptor(VertexAttribute.TexCoord0,VertexAttributeFormat.Float32,2,1),
   new VertexAttributeDescriptor(VertexAttribute.TexCoord1,VertexAttributeFormat.Float32,1,1),
   new VertexAttributeDescriptor(VertexAttribute.TexCoord2,VertexAttributeFormat.Float32,1,1),
   new VertexAttributeDescriptor(VertexAttribute.TexCoord3,VertexAttributeFormat.Float32,1,1),
   new VertexAttributeDescriptor(VertexAttribute.TexCoord4,VertexAttributeFormat.Float32,4,1),
   new VertexAttributeDescriptor(VertexAttribute.TexCoord5,VertexAttributeFormat.Float32,3,1),
   new VertexAttributeDescriptor(VertexAttribute.TexCoord6,VertexAttributeFormat.Float32,3,1),
   new VertexAttributeDescriptor(VertexAttribute.TexCoord7,VertexAttributeFormat.UNorm16,4,2),
   new VertexAttributeDescriptor(VertexAttribute.BlendIndices,VertexAttributeFormat.UInt8,4,2));
  mesh.SetVertexBufferData(stream0,0,0,stream0.Length,0);
  for(int i=1;i<3;i++){byte[] b=File.ReadAllBytes(Root+"/Captured/Verified/native_stream"+i+".bytes");mesh.SetVertexBufferData(b,0,0,b.Length,i);}
  mesh.SetIndexBufferParams(45003,IndexFormat.UInt16);mesh.SetIndexBufferData(ix,0,0,ix.Length);mesh.subMeshCount=1;
  mesh.SetSubMesh(0,new SubMeshDescriptor(0,45003,MeshTopology.Triangles));mesh.bounds=source.bounds;
  if(create)AssetDatabase.CreateAsset(mesh,path);else EditorUtility.SetDirty(mesh);
  path=Root+"/M_EID4798.mat";var mat=AssetDatabase.LoadAssetAtPath<Material>(path);
  if(mat==null){mat=new Material(shader);AssetDatabase.CreateAsset(mat,path);}else mat.shader=shader;
  mat.renderQueue=2000;mat.enableInstancing=false;
  using(var session=new EID4798ReplaySession("Assets/StreamingAssets/EID4798Replay/replay.json",false)){
   if(session.TextureBindingCount!=18||session.BufferBindingCount!=15)throw new Exception("EID4798 binding count mismatch");
   foreach(var pair in session.TextureBindings){
    path=Root+"/Textures/"+pair.Key+".asset";var tex=AssetDatabase.LoadAssetAtPath<Texture>(path);
    if(tex==null){tex=UnityEngine.Object.Instantiate(pair.Value);tex.hideFlags=HideFlags.None;AssetDatabase.CreateAsset(tex,path);}
    else{EditorUtility.CopySerialized(pair.Value,tex);tex.hideFlags=HideFlags.None;EditorUtility.SetDirty(tex);}
    mat.SetTexture(pair.Key,tex);AssetDatabase.SaveAssetIfDirty(tex);
   }
  }
  EditorUtility.SetDirty(mat);AssetDatabase.SaveAssetIfDirty(mesh);AssetDatabase.SaveAssetIfDirty(mat);
  File.WriteAllText(Root+"/Captured/Verified/unity_asset_validation.txt","PASS original mesh positions/topology preserved; textures=18 buffers=15; max position error="+maxError);
 }
}
#endif
