#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEditor.Rendering;
using UnityEngine;
using UnityEngine.Rendering;

internal static class EID4666ShaderCompileValidator
{
    const string ShaderAssetPath = "Assets/EID4666_VegetationLightPass/Shaders/EID4666VegetationLightPass.shader";
    const string ReportPath = "Validation/EID4666/shader_compile_report.txt";

    [MenuItem("EID4666/Validate Vegetation LightPass Shader")]
    public static void Validate()
    {
        AssetDatabase.ImportAsset(ShaderAssetPath, ImportAssetOptions.ForceUpdate | ImportAssetOptions.ForceSynchronousImport);
        Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(ShaderAssetPath);
        var messages = shader == null ? Array.Empty<ShaderMessage>() : ShaderUtil.GetShaderMessages(shader, ShaderCompilerPlatform.Vulkan);
        int errors = 0;
        var body = new StringBuilder();
        body.Append("utc=").Append(DateTime.UtcNow.ToString("o")).Append('\n');
        body.Append("shader=").Append(shader == null ? "NULL" : shader.name).Append('\n');
        body.Append("isSupported=").Append(shader != null && shader.isSupported).Append('\n');
        body.Append("passCount=").Append(shader != null ? shader.passCount : 0).Append('\n');
        body.Append("graphics=").Append(SystemInfo.graphicsDeviceType).Append('\n');
        body.Append("messageCount=").Append(messages.Length).Append('\n');
        foreach (ShaderMessage message in messages)
        {
            bool isError = message.severity == ShaderCompilerMessageSeverity.Error;
            if (isError)
                errors++;
            body.Append(message.severity).Append('|')
                .Append(message.platform).Append('|')
                .Append(message.file).Append(':').Append(message.line).Append('|')
                .Append(message.message.Replace('\n', ' ')).Append('\n');
            if (!string.IsNullOrEmpty(message.messageDetails))
                body.Append("DETAILS|").Append(message.messageDetails.Replace('\r', ' ').Replace('\n', ' ')).Append('\n');
            string line = "[EID4666 Shader] " + message.severity + ": " + message.message + " (line " + message.line + ", " + message.platform + ")";
            if (isError)
                Debug.LogError(line);
            else
                Debug.LogWarning(line);
        }

        DumpVulkanSource(shader, "4666", body);
        DumpNamedShader("Hidden/EID3332Combined/Deferred/EID4662Full", "4662", body);

        string reportSoFar = body.ToString();
        bool vsOk = reportSoFar.IndexOf("compiled_4666_vs success=True", StringComparison.Ordinal) >= 0;
        bool fsOk = reportSoFar.IndexOf("compiled_4666_fs success=True", StringComparison.Ordinal) >= 0;
        bool pass = errors == 0 && shader != null && shader.isSupported && vsOk && fsOk;
        body.Append("vsOk=").Append(vsOk).Append(" fsOk=").Append(fsOk).Append('\n');
        body.Append("RESULT=").Append(pass ? "PASS" : "FAIL").Append('\n');
        string fullPath = Path.GetFullPath(ReportPath);
        Directory.CreateDirectory(Path.GetDirectoryName(fullPath));
        File.WriteAllText(fullPath, body.ToString());
        Debug.Log("[EID4666 Shader] VALIDATION " + (File.ReadAllText(fullPath).Contains("RESULT=PASS") ? "PASS" : "FAIL")
            + "; messages=" + messages.Length
            + "; supported=" + (shader != null && shader.isSupported)
            + "; report=" + fullPath);
        if (Application.isBatchMode)
            EditorApplication.Exit(File.ReadAllText(fullPath).Contains("RESULT=PASS") ? 0 : 1);
    }

    static void DumpNamedShader(string shaderName, string tag, StringBuilder body)
    {
        Shader shader = Shader.Find(shaderName);
        body.Append("refshader=").Append(tag)
            .Append(" found=").Append(shader != null)
            .Append(" supported=").Append(shader != null && shader.isSupported)
            .Append(" passCount=").Append(shader != null ? shader.passCount : 0)
            .Append('\n');
        if (shader == null)
            return;
        ShaderMessage[] messages = ShaderUtil.GetShaderMessages(shader, ShaderCompilerPlatform.Vulkan);
        int errors = 0;
        foreach (ShaderMessage message in messages)
        {
            if (message.severity == ShaderCompilerMessageSeverity.Error)
            {
                errors++;
                body.Append("REFERR|").Append(tag).Append('|')
                    .Append(message.platform).Append('|')
                    .Append(message.file).Append(':').Append(message.line).Append('|')
                    .Append(message.message.Replace('\n', ' ')).Append('\n');
            }
        }
        body.Append("refshader=").Append(tag).Append(" vulkanErrors=").Append(errors).Append('\n');
        DumpVulkanSource(shader, tag, body);
    }

    static void DumpVulkanSource(Shader shader, string tag, StringBuilder body)
    {
        if (shader == null)
            return;
        ShaderData data = ShaderUtil.GetShaderData(shader);
        if (data == null || data.ActiveSubshader == null || data.ActiveSubshader.PassCount < 1)
        {
            body.Append("dump=").Append(tag).Append(" no-pass\n");
            return;
        }

        ShaderData.Pass pass = data.ActiveSubshader.GetPass(0);
        string outDir = Path.GetFullPath("Validation/EID4666");
        Directory.CreateDirectory(outDir);
        DumpStage(pass, ShaderType.Vertex, tag + "_vs", outDir, body);
        DumpStage(pass, ShaderType.Fragment, tag + "_fs", outDir, body);
    }

    static void DumpStage(ShaderData.Pass pass, ShaderType stage, string tag, string outDir, StringBuilder body)
    {
        string[] keywords = Array.Empty<string>();
        var preprocess = pass.PreprocessVariant(stage, keywords, ShaderCompilerPlatform.Vulkan, BuildTarget.StandaloneWindows64, false);
        string code = preprocess.PreprocessedCode ?? "";
        string stripped = code.Replace("\0", "");
        string prePath = Path.Combine(outDir, tag + "_preprocessed.hlsl");
        File.WriteAllText(prePath, stripped);
        body.Append("preprocessed_").Append(tag)
            .Append(" success=").Append(preprocess.Success)
            .Append(" chars=").Append(code.Length)
            .Append(" stripped=").Append(stripped.Length)
            .Append(" hasFragMain=").Append(stripped.IndexOf("frag_main", StringComparison.Ordinal) >= 0)
            .Append(" hasProbeVS=").Append(stripped.IndexOf("EID4666_PROBE_SHADER_STAGE_VERTEX", StringComparison.Ordinal) >= 0)
            .Append(" hasProbeFS=").Append(stripped.IndexOf("EID4666_PROBE_SHADER_STAGE_FRAGMENT", StringComparison.Ordinal) >= 0)
            .Append(" hasDummyFrag=").Append(stripped.IndexOf("return float4(0.0, 0.0, 0.0, 0.0)", StringComparison.Ordinal) >= 0)
            .Append(" hasOriginalFS=").Append(stripped.IndexOf("EID_OriginalFS", StringComparison.Ordinal) >= 0)
            .Append(" path=").Append(prePath)
            .Append(" messages=").Append(preprocess.Messages != null ? preprocess.Messages.Length : 0)
            .Append('\n');
        if (preprocess.Messages != null)
        {
            foreach (ShaderMessage message in preprocess.Messages)
            {
                body.Append("PRE|").Append(tag).Append('|')
                    .Append(message.severity).Append('|')
                    .Append(message.file).Append(':').Append(message.line).Append('|')
                    .Append(message.message.Replace('\n', ' ')).Append('\n');
            }
        }

        var compiled = pass.CompileVariant(stage, keywords, ShaderCompilerPlatform.Vulkan, BuildTarget.StandaloneWindows64, false);
        body.Append("compiled_").Append(tag)
            .Append(" success=").Append(compiled.Success)
            .Append(" shaderDataBytes=").Append(compiled.ShaderData != null ? compiled.ShaderData.Length : 0)
            .Append(" messages=").Append(compiled.Messages != null ? compiled.Messages.Length : 0)
            .Append('\n');
        if (compiled.Messages != null)
        {
            foreach (ShaderMessage message in compiled.Messages)
            {
                body.Append("CV|").Append(tag).Append('|')
                    .Append(message.severity).Append('|')
                    .Append(message.platform).Append('|')
                    .Append(message.file).Append(':').Append(message.line).Append('|')
                    .Append(message.message.Replace('\n', ' ')).Append('\n');
                if (!string.IsNullOrEmpty(message.messageDetails))
                    body.Append("CVDETAILS|").Append(tag).Append('|').Append(message.messageDetails).Append('\n');
            }
        }

        if (stage == ShaderType.Vertex && tag.StartsWith("4666"))
            DumpGlsl(pass, keywords, outDir, body);
    }

    static void DumpGlsl(ShaderData.Pass pass, string[] keywords, string outDir, StringBuilder body)
    {
        var glsl = pass.CompileVariant(ShaderType.Vertex, keywords, ShaderCompilerPlatform.OpenGLCore, BuildTarget.StandaloneWindows64, true);
        byte[] data = glsl.ShaderData;
        body.Append("compiled_4666_glcore success=").Append(glsl.Success)
            .Append(" shaderDataBytes=").Append(data != null ? data.Length : 0)
            .Append(" messages=").Append(glsl.Messages != null ? glsl.Messages.Length : 0)
            .Append('\n');
        if (glsl.Messages != null)
        {
            foreach (ShaderMessage message in glsl.Messages)
            {
                body.Append("GL|").Append(message.severity).Append('|')
                    .Append(message.platform).Append('|')
                    .Append(message.file).Append(':').Append(message.line).Append('|')
                    .Append(message.message.Replace('\n', ' ')).Append('\n');
            }
        }
        if (data == null || data.Length == 0)
            return;
        string text = Encoding.UTF8.GetString(data).Replace("\0", "");
        string glPath = Path.Combine(outDir, "4666_glcore.glsl");
        File.WriteAllText(glPath, text);
        body.Append("glcore_path=").Append(glPath).Append(" chars=").Append(text.Length).Append('\n');
        string[] lines = text.Replace("\r\n", "\n").Split('\n');
        int around = 457;
        int from = Math.Max(0, around - 8);
        int to = Math.Min(lines.Length, around + 4);
        body.Append("glcore_around_457 from=").Append(from + 1).Append(" to=").Append(to).Append('\n');
        for (int i = from; i < to; i++)
            body.Append("G|").Append(i + 1).Append('|').Append(lines[i]).Append('\n');
    }
}
#endif
