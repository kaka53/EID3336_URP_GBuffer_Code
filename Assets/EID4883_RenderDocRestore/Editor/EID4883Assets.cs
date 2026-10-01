#if UNITY_EDITOR
using System;
using System.IO;
using UnityEditor;
using UnityEngine;
using EID4730;
public static class EID4883Assets {
 const string Root="Assets/EID4883_RenderDocRestore";
 public static void Build(){
  var shader=AssetDatabase.LoadAssetAtPath<Shader>(Root+"/Shaders/EID4883_CharacterForward.shader");if(shader==null)throw new Exception("Outline shader missing");
  string path=Root+"/M_EID4883.mat";var mat=AssetDatabase.LoadAssetAtPath<Material>(path);
  if(mat==null){mat=new Material(shader);AssetDatabase.CreateAsset(mat,path);}else mat.shader=shader;
  mat.renderQueue=2451;mat.enableInstancing=false;
  using(var session=new EID4883ReplaySession("Assets/StreamingAssets/EID4883Replay/replay.json",false)){
   if(session.TextureBindingCount!=15||session.BufferBindingCount!=14)throw new Exception("Outline binding count mismatch");
   foreach(var pair in session.TextureBindings){path=Root+"/Textures/"+pair.Key+".asset";var t=AssetDatabase.LoadAssetAtPath<Texture>(path);
    if(t==null){t=UnityEngine.Object.Instantiate(pair.Value);t.hideFlags=HideFlags.None;AssetDatabase.CreateAsset(t,path);}else{EditorUtility.CopySerialized(pair.Value,t);t.hideFlags=HideFlags.None;EditorUtility.SetDirty(t);}
    mat.SetTexture(pair.Key,t);AssetDatabase.SaveAssetIfDirty(t);
   }
  }
  EditorUtility.SetDirty(mat);AssetDatabase.SaveAssetIfDirty(mat);
 }
}
#endif
