using System;
using System.IO;
using System.Linq;
using System.Text;
using UnityEditor;
using UnityEditor.Rendering;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;

public static class EID3885Reconstruction
{
    const string Root = "Assets/ColourPass6_VS215851_PS215852_Batch";
    const string ShaderPath = Root + "/Shaders/EID215851215852GBuffer.shader";
    const string ScenePath = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    const string ReportPath = ".rdctools/eid3885_verified/unity_validation.txt";
    static readonly StringBuilder report = new StringBuilder();

    static void Require(bool condition, string message)
    {
        if (!condition) throw new InvalidDataException(message);
        report.AppendLine("PASS " + message);
    }

    [MenuItem("Tools/Colour Pass 6/Validate EID3885 UniversalGBuffer")]
    public static void Build()
    {
        report.Clear();
        try
        {
            Directory.CreateDirectory(Path.Combine(Directory.GetParent(Application.dataPath).FullName, ".rdctools/eid3885_verified"));
            Require(SystemInfo.graphicsDeviceType != GraphicsDeviceType.Null, "real graphics device: " + SystemInfo.graphicsDeviceType);
            AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);

            string shaderText = File.ReadAllText(Path.Combine(Directory.GetParent(Application.dataPath).FullName, ShaderPath.Replace('/', Path.DirectorySeparatorChar)));
            Require(shaderText.IndexOf("ZTest LEqual", StringComparison.Ordinal) >= 0, "shader ZTest LEqual (vegetation UniversalGBuffer)");
            Require(shaderText.IndexOf("ZTest Equal", StringComparison.Ordinal) < 0, "shader has no ZTest Equal");
            Require(shaderText.Contains("Tags { \"LightMode\"=\"UniversalGBuffer\" \"UniversalMaterialType\"=\"Lit\" }"), "LightMode UniversalGBuffer");
            Require(shaderText.Contains("Cull Off") && shaderText.Contains("ZWrite On") && shaderText.Contains("Blend Off"), "Cull Off / ZWrite On / Blend Off");

            Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(ShaderPath);
            Require(shader != null, "shader found");
            Require(!ShaderUtil.ShaderHasError(shader), "ShaderUtil.ShaderHasError=false\n" + FormatShaderMessages(shader));
            var sub = ShaderUtil.GetShaderData(shader).ActiveSubshader;
            Require(sub != null && sub.PassCount == 1, "one shader pass");
            for (int i = 0; i < sub.PassCount; i++)
            {
                foreach (var platform in new[] { ShaderCompilerPlatform.D3D, ShaderCompilerPlatform.Vulkan })
                foreach (var stage in new[] { ShaderType.Vertex, ShaderType.Fragment })
                {
                    var c = sub.GetPass(i).CompileVariant(stage, Array.Empty<string>(), platform, BuildTarget.StandaloneWindows64, false);
                    if (c.Messages != null)
                        foreach (var msg in c.Messages)
                            report.AppendLine(msg.severity + " " + msg.message + " " + msg.file + ":" + msg.line);
                    bool ok = c.Success && c.ShaderData != null && c.ShaderData.Length > 0;
                    if (c.ShaderData != null && c.ShaderData.Length > 0)
                        File.WriteAllBytes(".rdctools/eid3885_verified/compiled_" + i + "_" + platform + "_" + stage + ".bin", c.ShaderData);
                    if (platform == ShaderCompilerPlatform.D3D)
                        Require(ok, "compile " + i + " " + platform + " " + stage + " bytes=" + (c.ShaderData?.Length ?? 0));
                    else
                        report.AppendLine("VULKAN_DIAGNOSTIC pass=" + i + " stage=" + stage + " success=" + ok + " bytes=" + (c.ShaderData?.Length ?? 0));
                }
            }

            Material mat = AssetDatabase.LoadAssetAtPath<Material>(Root + "/Materials/EID3885_VS215851_PS215852.mat");
            Require(mat != null && mat.shader == shader, "EID3885 material uses VS215851/PS215852 GBuffer shader");
            Require(mat.HasProperty("_Res23") && mat.GetTexture("_Res23") != null, "albedo _Res23 bound");
            Require(mat.HasProperty("_Res25") && mat.GetTexture("_Res25") != null, "normal _Res25 bound");
            Require(mat.GetTexture("_EID3863VSRes34") != null && mat.GetTexture("_EID3863VSRes35") != null
                && mat.GetTexture("_EID3863VSRes36") != null && mat.GetTexture("_EID3863VSRes37") != null,
                "VS wind/terrain t0-t3 bound");
            Require(Mathf.Approximately(mat.GetFloat("_StencilRef"), 33f), "stencil Ref 33");
            Require(Mathf.Approximately(mat.GetFloat("_EID3863AlphaCutoff"), 0.5f), "cutout 0.5");

            Mesh expanded = AssetDatabase.LoadAssetAtPath<Mesh>(Root + "/Geometry/Meshes/EID3885_Expanded.asset");
            Require(expanded != null && expanded.vertexCount == 100 * 38, "expanded mesh verts=" + (expanded != null ? expanded.vertexCount : 0) + " expected 3800");
            Require(expanded.GetIndexCount(0) == 150 * 38, "expanded indices=" + expanded.GetIndexCount(0) + " expected 5700");

            var scene = EditorSceneManager.OpenScene(ScenePath, OpenSceneMode.Single);
            var go = scene.GetRootGameObjects()
                .SelectMany(r => r.GetComponentsInChildren<Transform>(true))
                .FirstOrDefault(t => t.name == "EID3885");
            Require(go != null && go.gameObject.activeInHierarchy, "scene GO EID3885 active");
            Require(go.parent != null && go.parent.name == "ColourPass6_VS215851_PS215852", "parent ColourPass6_VS215851_PS215852");
            var mf = go.GetComponent<MeshFilter>();
            var mr = go.GetComponent<MeshRenderer>();
            var binder = go.GetComponent<EID215851InstanceBinder>();
            Require(mf != null && mf.sharedMesh == expanded, "MeshFilter expanded mesh");
            Require(mr != null && mr.enabled && mr.sharedMaterial == mat, "MeshRenderer material");
            Require(binder != null && binder.profile != null && binder.profile.eventId == 3885 && binder.profile.instanceCount == 38,
                "binder profile EID3885 instances=38");
            binder.Bind();

            report.AppendLine("RESULT=PASS");
            File.WriteAllText(ReportPath, report.ToString(), Encoding.UTF8);
            Debug.Log("[EID3885] UniversalGBuffer restore validated.\n" + report);
        }
        catch (Exception e)
        {
            report.AppendLine("RESULT=FAIL");
            report.AppendLine(e.ToString());
            File.WriteAllText(ReportPath, report.ToString(), Encoding.UTF8);
            throw;
        }
    }

    static string FormatShaderMessages(Shader shader)
    {
        ShaderMessage[] msgs = ShaderUtil.GetShaderMessages(shader);
        if (msgs == null || msgs.Length == 0) return "(none)";
        var sb = new StringBuilder();
        foreach (ShaderMessage msg in msgs)
            sb.AppendLine(msg.severity + " " + msg.file + ":" + msg.line + " " + msg.message);
        return sb.ToString();
    }
}
