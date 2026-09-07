#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;

public static class EID3336IndependentShaderValidation
{
    [MenuItem("Tools/EID3332+3336/Validate Independent GBuffer Shader")]
    public static void Validate()
    {
        const string path = "Assets/EID3332_EID3336_Combined/URPGBuffer/IndependentVS/EID3336RenderDocGBufferIndependent.shader";
        AssetDatabase.ImportAsset(path, ImportAssetOptions.ForceUpdate | ImportAssetOptions.ForceSynchronousImport);
        Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(path);
        if (shader == null) { Debug.LogError("[EID3336 Shader] Shader asset not found"); return; }
        var messages = ShaderUtil.GetShaderMessages(shader);
        int errors = 0;
        foreach (var m in messages)
        {
            string line = $"[EID3336 Shader] {m.severity}: {m.message} (line {m.line})";
            if ((int)m.severity == 0) { errors++; Debug.LogError(line); }
            else Debug.LogWarning(line);
        }
        Debug.Log($"[EID3336 Shader] VALIDATION {(errors == 0 ? "PASS" : "FAIL")}; messages={messages.Length}; supported={shader.isSupported}");
    }
}
#endif

