#if UNITY_EDITOR
using System.IO;
using UnityEditor;
using UnityEngine;

public static class ColourPass8AutoRunner
{
    [InitializeOnLoadMethod]
    static void Initialize()
    {
        EditorApplication.delayCall += RunPending;
    }

    static void RunPending()
    {
        if (EditorApplication.isCompiling || EditorApplication.isUpdating)
        {
            EditorApplication.delayCall += RunPending;
            return;
        }
        string root = Directory.GetParent(Application.dataPath).FullName;
        string aggregate = Path.Combine(root, "Validation/ColourPass8Batch/Capture.request");
        string perEid = Path.Combine(root, "Validation/ColourPass8Batch/CapturePerEID.request");
        if (File.Exists(aggregate))
        {
            File.Delete(aggregate);
            ColourPass8VS209982PS209983Capture.Capture();
        }
        if (File.Exists(perEid))
        {
            File.Delete(perEid);
            ColourPass8PerEIDCapture.CaptureAll();
        }
    }
}
#endif
