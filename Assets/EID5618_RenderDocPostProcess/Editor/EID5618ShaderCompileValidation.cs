#if UNITY_EDITOR
using System.IO;
using UnityEditor;
using UnityEngine;

internal static class EID5618ShaderCompileValidation
{
    [MenuItem("EID5618/Validate migrated shaders")]
    public static void Run()
    {
        string path = "Validation/eid5618_shader_validation_20260913.log";
        Directory.CreateDirectory(Path.GetDirectoryName(path));
        string[] names =
        {
            "Hidden/EID5618/EID5537Res9",
            "Hidden/EID5618/ExactRenderDocPostProcess",
            "Hidden/EID5618/Copy",
        };
        bool failed = false;
        using (StreamWriter w = new StreamWriter(path, false))
        {
            foreach (string name in names)
            {
                Shader shader = Shader.Find(name);
                w.WriteLine("Shader: " + name + " found=" + (shader != null));
                if (shader == null) { failed = true; continue; }
                ShaderMessage[] messages = ShaderUtil.GetShaderMessages(shader);
                foreach (ShaderMessage message in messages)
                {
                    if (message.severity.ToString().IndexOf("error", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                        message.message.IndexOf("error", System.StringComparison.OrdinalIgnoreCase) >= 0)
                        failed = true;
                }
            }
            w.WriteLine("RESULT=" + (failed ? "FAIL" : "PASS"));
        }
        AssetDatabase.Refresh();
        EditorApplication.Exit(failed ? 1 : 0);
    }
}
#endif

