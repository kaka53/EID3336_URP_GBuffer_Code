#if UNITY_EDITOR
using System;using System.IO;using UnityEditor;using UnityEngine;using UnityEngine.Rendering;
[InitializeOnLoad] public static class EIDVulkanSettingsRecovery1006 {
const string D="D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/crash_recovery_1006";
static EIDVulkanSettingsRecovery1006(){EditorApplication.delayCall+=Run;}
static void Run(){if(!File.Exists(D+"/restore_vulkan.request"))return;
try{PlayerSettings.SetUseDefaultGraphicsAPIs(BuildTarget.StandaloneWindows64,false);
PlayerSettings.SetGraphicsAPIs(BuildTarget.StandaloneWindows64,new[]{GraphicsDeviceType.Vulkan,GraphicsDeviceType.Direct3D11});
AssetDatabase.SaveAssets();File.WriteAllText(D+"/restore_vulkan_result.txt","PASS: Windows graphics API restored to Vulkan first. Current session="+SystemInfo.graphicsDeviceType+". Restart required; no scene saved.");File.Delete(D+"/restore_vulkan.request");
Debug.Log("[Vulkan Recovery] Vulkan restored as first Windows API. Restart Editor to apply; scene not saved.");
}catch(Exception e){File.WriteAllText(D+"/restore_vulkan_result.txt",e.ToString());}}
}
#endif
