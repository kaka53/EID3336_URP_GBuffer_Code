#if UNITY_EDITOR
using UnityEditor;using UnityEditor.SceneManagement;using UnityEngine;using UnityEngine.SceneManagement;using UnityEngine.Rendering;using System;using System.IO;using System.Linq;
public static class EID3899TerrainImporter
{
 const string ScenePath="Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
 const string Root="Assets/EID3332_EID3336_Combined/EID3899_RenderDocTerrain";
 const string Cap=Root+"/Captured/",Geo=Root+"/Geometry/";
 [Serializable] public class Entry {public int slice,mip,offset,length;}
 [Serializable] public class Tex {public string rid,format;public int width,height,layers,mips,size;public Entry[] entries;}
 [Serializable] public class TexList{public Tex[] textures;}
 static void CheckScene(){if(SceneManager.GetActiveScene().path!=ScenePath)throw new InvalidOperationException("Open "+ScenePath);}
 [MenuItem("EID3332-EID3336/EID3899/Reimport Terrain Textures")]
 public static void ReimportTextures()
 {
  CheckScene();
  var dir=Root+"/ImportedTextures";
  if(Directory.Exists(dir))
   foreach(var f in Directory.GetFiles(dir,"rid*.asset")) AssetDatabase.DeleteAsset(f.Replace('\\','/').Replace(Application.dataPath,"Assets"));
  AssetDatabase.Refresh(ImportAssetOptions.ForceUpdate);
  Import();
 }
 [MenuItem("EID3332-EID3336/EID3899/Import Terrain")]
 public static void Import()
 {
  CheckScene();var sc=SceneManager.GetActiveScene();Directory.CreateDirectory(Root+"/ImportedTextures");AssetDatabase.Refresh();
  var sh=AssetDatabase.LoadAssetAtPath<Shader>(Root+"/Shaders/EID3899TerrainGBuffer.shader");if(!sh||ShaderUtil.ShaderHasError(sh))throw new InvalidOperationException("Terrain shader error");
  var mat=AssetDatabase.LoadAssetAtPath<Material>(Root+"/Materials/EID3899TerrainPS210085.mat");if(!mat){mat=new Material(sh){name="EID3899TerrainPS210085"};AssetDatabase.CreateAsset(mat,Root+"/Materials/EID3899TerrainPS210085.mat");}
  var records=JsonUtility.FromJson<TexList>(File.ReadAllText(Cap+"RawTextures/textures.json")).textures;
  int[] slots={29,30,31,32,33,34,35,37,38,39,40,41};string[] ids={"198259","198278","198267","198263","198284","198300","198309","209085","209106","209109","209112","209115"};
  for(int i=0;i<slots.Length;i++)mat.SetTexture("_"+slots[i],ImportTexture(records.First(t=>t.rid==ids[i])));
  byte[] local=File.ReadAllBytes(Cap+"PS_uniforms28.bytes");
  for(int i=0;i<20;i++)mat.SetFloat("_28_m"+i,F(local,i*4));
  for(int i=20;i<26;i++)mat.SetVector("_28_m"+i,V(local,80+(i-20)*16));
  for(int i=26;i<32;i++)mat.SetFloat("_28_m"+i,F(local,176+(i-26)*4));
  for(int i=32;i<34;i++)mat.SetVector("_28_m"+i,V(local,208+(i-32)*16));
  var go=GameObject.Find("EID3899_Terrain");if(!go){go=new GameObject("EID3899_Terrain");SceneManager.MoveGameObjectToScene(go,sc);Undo.RegisterCreatedObjectUndo(go,"Import terrain");}
  var mf=go.GetComponent<MeshFilter>();if(!mf)mf=go.AddComponent<MeshFilter>();
  var mr=go.GetComponent<MeshRenderer>();if(!mr)mr=go.AddComponent<MeshRenderer>();mr.sharedMaterial=mat;mf.sharedMesh=BuildMesh();
  // World vertices are not transformed a second time at import. Live Transform remains usable.
  go.transform.SetParent(null);go.transform.SetPositionAndRotation(Vector3.zero,Quaternion.identity);go.transform.localScale=Vector3.one;
  var ctrl=go.GetComponent<EID3899TerrainController>();if(!ctrl)ctrl=go.AddComponent<EID3899TerrainController>();ctrl.enabled=false;
  ctrl.terrainMaterial=mat;ctrl.frameConstants=Load("PS_uniforms11.bytes");ctrl.frameParameters=Load("PS_uniforms13.bytes");ctrl.terrainParameters=Load("PS_uniforms22.bytes");ctrl.pageTable=Load("PS_uniforms24.bytes");ctrl.layerParameters=Load("PS_uniforms26.bytes");ctrl.enabled=true;ctrl.Bind();
  EditorUtility.SetDirty(ctrl);EditorUtility.SetDirty(mat);EditorUtility.SetDirty(mf);EditorUtility.SetDirty(mr);EditorSceneManager.MarkSceneDirty(sc);AssetDatabase.SaveAssets();EditorSceneManager.SaveScene(sc);
  Debug.Log("EID3899 terrain imported: 273 blocks, 78897 vertices. "+ctrl.ValidateBuffers());
 }
 static Texture ImportTexture(Tex t)
 {
  string path=Root+"/ImportedTextures/rid"+t.rid+".asset";var old=AssetDatabase.LoadAssetAtPath<Texture>(path);if(old)return old;
  TextureFormat fmt;
  switch(t.format){case "BC3_SRGB":case "BC3_UNORM":fmt=TextureFormat.DXT5;break;case "BC7_SRGB":case "BC7_UNORM":fmt=TextureFormat.BC7;break;case "BC5_UNORM":fmt=TextureFormat.BC5;break;case "R8G8B8A8_UNORM":fmt=TextureFormat.RGBA32;break;case "R8G8_UNORM":fmt=TextureFormat.RG16;break;default:throw new InvalidOperationException(t.format);}
  byte[] raw=File.ReadAllBytes(Cap+"RawTextures/"+t.rid+".bytes");if(raw.Length!=t.size)throw new InvalidDataException(t.rid+" size mismatch");bool linear=!t.format.EndsWith("SRGB");Texture result;
  if(t.layers==1){var tex=new Texture2D(t.width,t.height,fmt,t.mips>1,linear);foreach(var e in t.entries){var chunk=new byte[e.length];Buffer.BlockCopy(raw,e.offset,chunk,0,e.length);tex.SetPixelData(chunk,e.mip,0);}tex.Apply(false,false);result=tex;} else {var tex=new Texture2DArray(t.width,t.height,t.layers,fmt,t.mips>1,linear);foreach(var e in t.entries){var chunk=new byte[e.length];Buffer.BlockCopy(raw,e.offset,chunk,0,e.length);tex.SetPixelData(chunk,e.mip,e.slice,0);}tex.Apply(false,false);result=tex;}
  result.name="rid"+t.rid;result.wrapMode=t.layers>1?TextureWrapMode.Repeat:TextureWrapMode.Clamp;result.filterMode=t.layers>1?FilterMode.Trilinear:FilterMode.Bilinear;result.anisoLevel=0;AssetDatabase.CreateAsset(result,path);return result;
 }
 static Mesh BuildMesh()
 {
  string path=Geo+"EID3899_Terrain_World_Exact.asset";var old=AssetDatabase.LoadAssetAtPath<Mesh>(path);if(old)return old;
  byte[] vb=File.ReadAllBytes(Geo+"terrain_world_vertices.bytes"),ib=File.ReadAllBytes(Geo+"terrain_indices.bytes");var v=new Vector3[vb.Length/12];for(int i=0;i<v.Length;i++)v[i]=new Vector3(F(vb,i*12),F(vb,i*12+4),F(vb,i*12+8));var ix=new int[ib.Length/4];Buffer.BlockCopy(ib,0,ix,0,ib.Length);
  var m=new Mesh{name="EID3899_Terrain_World_Exact",indexFormat=IndexFormat.UInt32};m.SetVertices(v);m.SetIndices(ix,MeshTopology.Triangles,0);m.RecalculateBounds();AssetDatabase.CreateAsset(m,path);return m;
 }
 static TextAsset Load(string n)=>AssetDatabase.LoadAssetAtPath<TextAsset>(Cap+n);
 static float F(byte[] b,int o)=>BitConverter.ToSingle(b,o);
 static Vector4 V(byte[] b,int o)=>new Vector4(F(b,o),F(b,o+4),F(b,o+8),F(b,o+12));
}
#endif

