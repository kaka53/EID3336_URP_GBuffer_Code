#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;

[InitializeOnLoad]
static class EID3490AutoApplyOnce
{
    const string Key = "EID3490_PS209989_AutoApply_20260830_v7";

    static EID3490AutoApplyOnce()
    {
        EditorApplication.delayCall += Apply;
    }

    static void Apply()
    {
        if (SessionState.GetBool(Key, false)) return;
        SessionState.SetBool(Key, true);
        try
        {
            EID3490CombinedImporter.ImportIntoCombinedScene();
            EID3490CombinedImporter.ValidateEID3490();
            Debug.Log("[EID3490 AutoApply] PS209989 material table rebuilt; EID3490 BaseColor/Normal texture table rebuilt; RenderDoc RID271247/RID227040/RID226998/RID279400 full texture table restored; RID279400 is 1024x1024 BC7 with 11 mips; selection proxy meshes rebuilt.");
        }
        catch (System.Exception e)
        {
            Debug.LogException(e);
        }
    }
}
#endif
