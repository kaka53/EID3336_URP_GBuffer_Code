#if UNITY_EDITOR
using System.IO;
using UnityEditor;
using UnityEngine;

[InitializeOnLoad]
public static class EID3863OneShotRequest
{
    static readonly string RequestPath = Path.Combine(Directory.GetParent(Application.dataPath).FullName, "Validation/ImportEID3863.request");
    static EID3863OneShotRequest() { EditorApplication.update += Run; }
    static void Run()
    {
        if (EditorApplication.isCompiling || EditorApplication.isUpdating || !File.Exists(RequestPath)) return;
        File.Delete(RequestPath);
        EID3863VegetationImporter.AddToCurrentScene();
        EditorApplication.update -= Run;
    }
}
#endif