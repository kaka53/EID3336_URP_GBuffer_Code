#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;

static class EID3490AutoApplyOnce
{
    [MenuItem("Tools/EID3332+3336/Apply EID3490 To Combined Scene")]
    static void Apply()
    {
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
