#if UNITY_EDITOR
using System;using System.IO;using System.Text;using UnityEditor;using UnityEngine;using UnityEngine.Rendering;
public static class EIDD3D11CompatibilityAudit1006 {
public static void Run(){const string D="D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/d3d11_compat_1006";var log=new StringBuilder();bool old=ShaderUtil.allowAsyncCompilation;try{
PlayerSettings.SetUseDefaultGraphicsAPIs(BuildTarget.StandaloneWindows64,false);PlayerSettings.SetGraphicsAPIs(BuildTarget.StandaloneWindows64,new[]{GraphicsDeviceType.Direct3D11,GraphicsDeviceType.Vulkan});
log.AppendLine("API="+SystemInfo.graphicsDeviceType);if(SystemInfo.graphicsDeviceType!=GraphicsDeviceType.Direct3D11)throw new Exception("Expected D3D11");ShaderUtil.allowAsyncCompilation=false;
foreach(int eid in new[]{4780,4812}){var sh=AssetDatabase.LoadAssetAtPath<Shader>("Assets/EID"+eid+"_RenderDocRestore/Shaders/EID"+eid+"_CharacterForward.shader");var m=new Material(sh);try{for(int pass=0;pass<m.passCount;pass++){ShaderUtil.CompilePass(m,pass,true);log.AppendLine(eid+" pass "+pass+" SetPass="+m.SetPass(pass));}foreach(var msg in ShaderUtil.GetShaderMessages(sh))log.AppendLine(msg.severity+": "+msg.file+":"+msg.line+" "+msg.message);log.AppendLine("hasError="+ShaderUtil.ShaderHasError(sh));}finally{UnityEngine.Object.DestroyImmediate(m);}}
}catch(Exception e){log.AppendLine(e.ToString());}finally{ShaderUtil.allowAsyncCompilation=old;File.WriteAllText(D+"/audit.txt",log.ToString());}}
}
#endif
