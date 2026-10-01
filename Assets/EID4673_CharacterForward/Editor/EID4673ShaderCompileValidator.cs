#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEditor.Rendering;
using UnityEngine;
using UnityEngine.Rendering;

internal static class EID4673ShaderCompileValidator
{
    const string ReportPath = "Validation/EID4673/shader_compile_report.txt";
    const string ForwardTag = "EID4673CharacterForward";
    const string Family215443Tag = "EID4730CharacterForward";

    static readonly string[] ShaderAssetPaths =
    {
        "Assets/ColourPass6_VS215439_PS215440_Batch/Shaders/EID215439215440GBuffer.shader",
        "Assets/ColourPass6_VS215441_PS215442_Batch/Shaders/EID215441215442GBuffer.shader",
        "Assets/ColourPass6_VS215443_PS215444_Batch/Shaders/EID215443215444GBuffer.shader",
        "Assets/ColourPass6_VS215445_PS215446_Batch/Shaders/EID215445215446GBuffer.shader",
        "Assets/ColourPass6_VS215447_PS215448_Batch/Shaders/EID215447215448GBuffer.shader",
        "Assets/ColourPass6_VS215452_PS215453_Batch/Shaders/EID215452215453GBuffer.shader",
        "Assets/ColourPass6_VS239789_PS239790_Batch/Shaders/EID239789239790GBuffer.shader"
    };

    [MenuItem("EID4673/Validate Character Forward Shader")]
    public static void Validate()
    {
        int errors = 0;
        int shadersOk = 0;
        var body = new StringBuilder();
        body.Append("utc=").Append(DateTime.UtcNow.ToString("o")).Append('\n');
        body.Append("graphics=").Append(SystemInfo.graphicsDeviceType).Append('\n');

        foreach (string shaderAssetPath in ShaderAssetPaths)
        {
            AssetDatabase.ImportAsset(shaderAssetPath, ImportAssetOptions.ForceUpdate | ImportAssetOptions.ForceSynchronousImport);
            Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(shaderAssetPath);
            var messages = shader == null ? Array.Empty<ShaderMessage>() : ShaderUtil.GetShaderMessages(shader, ShaderCompilerPlatform.Vulkan);
            int shaderErrors = 0;
            body.Append("shaderPath=").Append(shaderAssetPath).Append('\n');
            body.Append("shader=").Append(shader == null ? "NULL" : shader.name).Append('\n');
            body.Append("isSupported=").Append(shader != null && shader.isSupported).Append('\n');
            body.Append("passCount=").Append(shader != null ? shader.passCount : 0).Append('\n');
            body.Append("messageCount=").Append(messages.Length).Append('\n');
            foreach (ShaderMessage message in messages)
            {
                bool isError = message.severity == ShaderCompilerMessageSeverity.Error;
                if (isError)
                {
                    shaderErrors++;
                    errors++;
                }
                body.Append(message.severity).Append('|')
                    .Append(message.platform).Append('|')
                    .Append(message.file).Append(':').Append(message.line).Append('|')
                    .Append(message.message.Replace('\n', ' ')).Append('\n');
                string line = "[EID4673 Shader] " + shaderAssetPath + " " + message.severity + ": " + message.message + " (line " + message.line + ", " + message.platform + ")";
                if (isError)
                    Debug.LogError(line);
                else
                    Debug.LogWarning(line);
            }

            int before = body.Length;
            DumpVulkanSource(shader, shaderAssetPath, body);
            string chunk = body.ToString(before, body.Length - before);
            bool vsOk = chunk.IndexOf("success=True", StringComparison.Ordinal) >= 0 && chunk.IndexOf("compiled_", StringComparison.Ordinal) >= 0;
            bool fsOk = CountToken(chunk, "success=True") >= 2;
            bool shaderPass = shaderErrors == 0 && shader != null && shader.isSupported && shader.passCount >= 2 && vsOk && fsOk;
            if (shaderPass)
                shadersOk++;
            body.Append("vsfs=").Append(vsOk).Append('/').Append(fsOk).Append(" shaderPass=").Append(shaderPass).Append('\n');
        }

        bool pass = errors == 0 && shadersOk == ShaderAssetPaths.Length;
        body.Append("shadersOk=").Append(shadersOk).Append('/').Append(ShaderAssetPaths.Length).Append('\n');
        body.Append("RESULT=").Append(pass ? "PASS" : "FAIL").Append('\n');
        string fullPath = Path.GetFullPath(ReportPath);
        Directory.CreateDirectory(Path.GetDirectoryName(fullPath));
        File.WriteAllText(fullPath, body.ToString());
        Debug.Log("[EID4673 Shader] VALIDATION " + (pass ? "PASS" : "FAIL")
            + "; shadersOk=" + shadersOk + "/" + ShaderAssetPaths.Length
            + "; errors=" + errors
            + "; report=" + fullPath);
        if (Application.isBatchMode)
            EditorApplication.Exit(pass ? 0 : 1);
    }

    static int CountToken(string text, string token)
    {
        int count = 0;
        int index = 0;
        while ((index = text.IndexOf(token, index, StringComparison.Ordinal)) >= 0)
        {
            count++;
            index += token.Length;
        }
        return count;
    }

    static void DumpVulkanSource(Shader shader, string shaderAssetPath, StringBuilder body)
    {
        if (shader == null)
            return;
        ShaderData data = ShaderUtil.GetShaderData(shader);
        if (data == null || data.ActiveSubshader == null || data.ActiveSubshader.PassCount < 2)
        {
            body.Append("dump=4673 no-forward-pass count=")
                .Append(data != null && data.ActiveSubshader != null ? data.ActiveSubshader.PassCount : 0)
                .Append('\n');
            return;
        }

        int forwardIndex = -1;
        for (int i = 0; i < data.ActiveSubshader.PassCount; ++i)
        {
            ShaderData.Pass candidate = data.ActiveSubshader.GetPass(i);
            string name = candidate != null ? candidate.Name : "";
            body.Append("pass[").Append(i).Append("]=").Append(name).Append('\n');
            bool is215443 = shaderAssetPath.IndexOf("VS215443", StringComparison.Ordinal) >= 0;
            string want = is215443 ? Family215443Tag : ForwardTag;
            if (name != null && name.IndexOf(want, StringComparison.Ordinal) >= 0)
                forwardIndex = i;
        }
        if (forwardIndex < 0)
            forwardIndex = 1;

        ShaderData.Pass pass = data.ActiveSubshader.GetPass(forwardIndex);
        string tag = Path.GetFileNameWithoutExtension(shaderAssetPath);
        DumpStage(pass, ShaderType.Vertex, tag + "_vs", body);
        DumpStage(pass, ShaderType.Fragment, tag + "_fs", body);
    }

    static void DumpStage(ShaderData.Pass pass, ShaderType stage, string tag, StringBuilder body)
    {
        string[] keywords = Array.Empty<string>();
        var compiled = pass.CompileVariant(stage, keywords, ShaderCompilerPlatform.Vulkan, BuildTarget.StandaloneWindows64, false);
        body.Append("compiled_").Append(tag)
            .Append(" success=").Append(compiled.Success)
            .Append(" shaderDataBytes=").Append(compiled.ShaderData != null ? compiled.ShaderData.Length : 0)
            .Append(" messages=").Append(compiled.Messages != null ? compiled.Messages.Length : 0)
            .Append('\n');
        if (compiled.Messages == null)
            return;
        foreach (ShaderMessage message in compiled.Messages)
        {
            body.Append("CV|").Append(tag).Append('|')
                .Append(message.severity).Append('|')
                .Append(message.platform).Append('|')
                .Append(message.file).Append(':').Append(message.line).Append('|')
                .Append(message.message.Replace('\n', ' ')).Append('\n');
        }
    }
}
#endif
