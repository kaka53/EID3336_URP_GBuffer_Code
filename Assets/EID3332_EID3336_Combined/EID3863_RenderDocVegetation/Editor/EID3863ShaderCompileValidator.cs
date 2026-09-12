#if UNITY_EDITOR
using System;
using System.IO;
using System.Linq;
using UnityEditor;
using UnityEngine;

internal static class EID3863ShaderCompileValidator
{
    private const string ShaderAssetPath = "Assets/EID3332_EID3336_Combined/EID3863_RenderDocVegetation/Shaders/EID3863Vegetation.shader";

    [MenuItem("EID3863/Validate RenderDoc Vegetation Shader")]
    private static void Validate()
    {
        AssetDatabase.ImportAsset(ShaderAssetPath, ImportAssetOptions.ForceUpdate | ImportAssetOptions.ForceSynchronousImport);
        var shader = AssetDatabase.LoadAssetAtPath<Shader>(ShaderAssetPath);
        var messages = shader == null ? Array.Empty<ShaderMessage>() : ShaderUtil.GetShaderMessages(shader);
        string reportPath = Path.GetFullPath("Validation/EID3863/shader_compile_report.txt");
        Directory.CreateDirectory(Path.GetDirectoryName(reportPath));
        var lines = messages.Select(m => $"{m.severity}|{m.platform}|{m.file}:{m.line}|{m.message}").ToArray();
        File.WriteAllText(reportPath,
            $"utc={DateTime.UtcNow:O}\nshader={(shader == null ? "NULL" : shader.name)}\nisSupported={(shader != null && shader.isSupported)}\nmessageCount={messages.Length}\n" +
            string.Join("\n", lines));
        Debug.Log("[EID3863] Manual shader validation complete. Report: " + reportPath);
    }
}
#endif