#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using EID4730;
public static class EID4789Assets
{
 public const string Root="Assets/EID4789_RenderDocRestore";
 public const string OriginalRoot="Assets/ColourPass6_VS215443_PS215444_Batch";
 public const string OriginalMeshPath=OriginalRoot+"/Geometry/Meshes/EID1696_VSInput.asset";
 public const string OriginalMaterialPath=OriginalRoot+"/Materials/EID1696_VS215443_PS215444.mat";
 public static void Build(){
  var source=AssetDatabase.LoadAssetAtPath<Mesh>(OriginalMeshPath);
  if(source==null||source.vertexCount!=1521||source.GetIndexCount(0)!=5001)throw new Exception("EID1696 source geometry missing/mismatched");
  var shader=AssetDatabase.LoadAssetAtPath<Shader>(Root+"/Shaders/EID4789_CharacterForward.shader");
  if(shader==null)throw new Exception("EID4789 shader missing");
  byte[] stream0=File.ReadAllBytes(Root+"/Captured/Verified/native_stream0.bytes");
  var oldPositions=source.vertices;float maxError=0;
  for(int i=0;i<1521;i++){
   var captured=new Vector3(BitConverter.ToSingle(stream0,i*40),BitConverter.ToSingle(stream0,i*40+4),BitConverter.ToSingle(stream0,i*40+8));
   maxError=Mathf.Max(maxError,Vector3.Distance(captured,oldPositions[i]));
   Buffer.BlockCopy(BitConverter.GetBytes(oldPositions[i].x),0,stream0,i*40,4);
   Buffer.BlockCopy(BitConverter.GetBytes(oldPositions[i].y),0,stream0,i*40+4,4);
   Buffer.BlockCopy(BitConverter.GetBytes(oldPositions[i].z),0,stream0,i*40+8,4);
  }
  if(maxError>2e-5f)throw new Exception("EID1696 is not the same baked geometry: "+maxError);
  var ix=File.ReadAllBytes(Root+"/Captured/Verified/indices.bytes");var oldIndices=source.GetIndices(0);
  for(int i=0;i<5001;i++)if(oldIndices[i]!=BitConverter.ToUInt16(ix,i*2))throw new Exception("Original EID1696 index mismatch "+i);
  string path=Root+"/EID4789_Mesh.asset";var mesh=AssetDatabase.LoadAssetAtPath<Mesh>(path);bool create=mesh==null;
  if(create)mesh=new Mesh();else mesh.Clear();mesh.name="EID4789 1521 vertices 5001 indices (EID1696 exact positions)";
  mesh.SetVertexBufferParams(1521,
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
  mesh.SetIndexBufferParams(5001,IndexFormat.UInt16);mesh.SetIndexBufferData(ix,0,0,ix.Length);mesh.subMeshCount=1;
  mesh.SetSubMesh(0,new SubMeshDescriptor(0,5001,MeshTopology.Triangles));mesh.bounds=source.bounds;
  if(create)AssetDatabase.CreateAsset(mesh,path);else EditorUtility.SetDirty(mesh);
  path=Root+"/M_EID4789.mat";var mat=AssetDatabase.LoadAssetAtPath<Material>(path);
  if(mat==null){mat=new Material(shader);AssetDatabase.CreateAsset(mat,path);}else mat.shader=shader;
  mat.renderQueue=2000;mat.enableInstancing=false;
  using(var session=new EID4789ReplaySession(EID4789ReplayPaths.ManifestPath(),false)){
   if(session.TextureBindingCount!=22||session.BufferBindingCount!=15)throw new Exception("EID4789 binding count mismatch");
   foreach(var pair in session.TextureBindings){
    path=Root+"/Textures/"+pair.Key+".asset";var tex=AssetDatabase.LoadAssetAtPath<Texture>(path);
    if(tex==null){tex=UnityEngine.Object.Instantiate(pair.Value);tex.hideFlags=HideFlags.None;AssetDatabase.CreateAsset(tex,path);}
    else{EditorUtility.CopySerialized(pair.Value,tex);tex.hideFlags=HideFlags.None;EditorUtility.SetDirty(tex);}
    mat.SetTexture(pair.Key,tex);AssetDatabase.SaveAssetIfDirty(tex);
   }
  }
  EditorUtility.SetDirty(mat);AssetDatabase.SaveAssetIfDirty(mesh);AssetDatabase.SaveAssetIfDirty(mat);
  var gbshader=AssetDatabase.LoadAssetAtPath<Shader>(Root+"/Shaders/EID1696_GBuffer.shader");
  if(gbshader==null)throw new Exception("Scoped EID1696 GBuffer shader missing");
  path=Root+"/M_EID1696_GBuffer.mat";var gb=AssetDatabase.LoadAssetAtPath<Material>(path);
  var original=AssetDatabase.LoadAssetAtPath<Material>(OriginalMaterialPath);
  if(gb==null){gb=new Material(original);gb.shader=gbshader;AssetDatabase.CreateAsset(gb,path);}else {gb.CopyPropertiesFromMaterial(original);gb.shader=gbshader;}
  EditorUtility.SetDirty(gb);AssetDatabase.SaveAssetIfDirty(gb);
  File.WriteAllText(Root+"/Captured/Verified/unity_asset_validation.txt","vertices=1521 indices=5001\noriginalToCapturePositionMaxError="+maxError+"\nforwardPositions=exact EID1696 original\nsourceMeshUnmodified=True\ntextures=22 buffers=15\n");
 }
}
#endif
