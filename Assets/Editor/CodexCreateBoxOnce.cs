#if UNITY_EDITOR
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

[InitializeOnLoad]
internal static class CodexCreateBoxOnce
{
    const string DoneKey = "CodexCreateBoxOnce_20260907";
    static CodexCreateBoxOnce()
    {
        EditorApplication.delayCall += Create;
    }

    static void Create()
    {
        EditorApplication.delayCall -= Create;
        if (SessionState.GetBool(DoneKey, false)) return;
        Scene scene = SceneManager.GetActiveScene();
        if (!scene.IsValid() || !scene.isLoaded) return;

        GameObject existing = GameObject.Find("Codex_Box");
        if (existing == null)
        {
            existing = GameObject.CreatePrimitive(PrimitiveType.Cube);
            existing.name = "Codex_Box";
            existing.transform.position = Vector3.zero;
            existing.transform.localScale = Vector3.one;
        }
        Undo.RegisterCreatedObjectUndo(existing, "Create Codex Box");
        Selection.activeGameObject = existing;
        EditorSceneManager.MarkSceneDirty(scene);
        EditorSceneManager.SaveScene(scene);
        SessionState.SetBool(DoneKey, true);
        Debug.Log("[Codex] Created Codex_Box in active scene: " + scene.path);
    }
}
#endif

