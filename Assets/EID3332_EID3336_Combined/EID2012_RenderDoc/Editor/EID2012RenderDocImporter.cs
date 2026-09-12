#if UNITY_EDITOR
using System;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;

[InitializeOnLoad]
public static class EID2012RenderDocImporter
{
    const string Root = "Assets/EID3332_EID3336_Combined/EID2012_RenderDoc";
    const string Captured = Root + "/Captured/";
    const string MeshPath = Root + "/Geometry/EID2012_VSInput_Exact.asset";
    const string MaterialPath = Root + "/Materials/EID2012_PS209977.mat";
    const string TargetScene = "Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity";
    const string RootObjectName = "EID2012_RenderDoc";
    const string ObjectName = "eid2012_instance_000";
    const int VertexCount = 3764;
    const int IndexCount = 8892;
    static readonly string Project = Directory.GetParent(Application.dataPath).FullName;
    static readonly string RequestPath = Path.Combine(Project, "Validation/ImportEID2012.request");
    static readonly string ReportPath = Path.Combine(Project, "Validation/EID2012/import_report.txt");
    static bool busy;

    static EID2012RenderDocImporter() { EditorApplication.update += Poll; }

    static void Poll()
    {
        if (busy || EditorApplication.isCompiling || EditorApplication.isUpdating || !File.Exists(RequestPath)) return;
        File.Delete(RequestPath);
        try { ImportIntoCurrentScene(); }
        catch (Exception e)
        {
            Directory.CreateDirectory(Path.GetDirectoryName(ReportPath));
            File.WriteAllText(ReportPath, "FAIL\n" + e);
            Debug.LogException(e);
        }
    }

    [MenuItem("Tools/EID3332+3336/Import EID2012 Into RenderDoc Camera Scene")]
    public static void ImportIntoCurrentScene()
    {
        if (busy) return;
        busy = true;
        try
        {
            Scene scene = SceneManager.GetActiveScene();
            if (scene.path != TargetScene)
                throw new InvalidOperationException("Open the target scene first: " + TargetScene + "; active=" + scene.path);

            Directory.CreateDirectory(Root + "/Geometry");
            Directory.CreateDirectory(Root + "/Materials");
            Directory.CreateDirectory(Root + "/ImportedTextures");
            Directory.CreateDirectory(Path.GetDirectoryName(ReportPath));

            string backup = Root + "/Validation/BeforeImport_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".unity";
            EditorSceneManager.SaveScene(scene, backup, true);

            byte[] stream0 = Read("vertex_stream0.bytes");
            byte[] stream1 = Read("vertex_stream1.bytes");
            byte[] constant = Read("vertex_stream3.bytes");
            byte[] indexBytes = Read("indices_u16.bytes");
            if (stream0.Length != VertexCount * 16 || stream1.Length != VertexCount * 8 || constant.Length != 20 || indexBytes.Length != IndexCount * 2)
                throw new InvalidDataException("EID2012 captured stream sizes do not match the RenderDoc draw.");

            Mesh generatedMesh = BuildExactMesh(stream0, stream1, constant, indexBytes);
            Mesh mesh = AssetDatabase.LoadAssetAtPath<Mesh>(MeshPath);
            if (mesh) { EditorUtility.CopySerialized(generatedMesh, mesh); UnityEngine.Object.DestroyImmediate(generatedMesh); }
            else { mesh = generatedMesh; AssetDatabase.CreateAsset(mesh, MeshPath); }

            AssetDatabase.ImportAsset(Root + "/Shaders/EID2012RenderDocGBuffer.shader", ImportAssetOptions.ForceUpdate | ImportAssetOptions.ForceSynchronousImport);
            Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(Root + "/Shaders/EID2012RenderDocGBuffer.shader");
            if (!shader || !shader.isSupported || ShaderUtil.ShaderHasError(shader))
                throw new InvalidOperationException("EID2012 shader is missing, unsupported, or has compile errors.");

            Texture2D baseColor = ImportBC7("PS_res17_rid266514", false);
            Texture2D normalMaterial = ImportBC7("PS_res19_rid266538", false);
            var generatedMaterial = new Material(shader) { name = "EID2012_PS209977" };
            generatedMaterial.SetTexture("_EID2012BaseColorMap", baseColor);
            generatedMaterial.SetTexture("_EID2012NormalMaterialMap", normalMaterial);
            generatedMaterial.SetFloat("_EID2012MipBias", -1.0f);
            generatedMaterial.SetFloat("_EID2012BaseColorScale", 0.0f);
            generatedMaterial.SetFloat("_EID2012LocalParam0", 0.0f);
            generatedMaterial.SetVector("_EID2012LocalParam2", Vector4.zero);
            generatedMaterial.SetVector("_EID2012LocalParam3", Vector4.zero);
            generatedMaterial.enableInstancing = false;

            Material material = AssetDatabase.LoadAssetAtPath<Material>(MaterialPath);
            if (material) { EditorUtility.CopySerialized(generatedMaterial, material); UnityEngine.Object.DestroyImmediate(generatedMaterial); }
            else { material = generatedMaterial; AssetDatabase.CreateAsset(material, MaterialPath); }

            GameObject existing = GameObject.Find(RootObjectName);
            if (existing) UnityEngine.Object.DestroyImmediate(existing);
            var root = new GameObject(RootObjectName);
            root.transform.SetPositionAndRotation(Vector3.zero, Quaternion.identity);
            root.transform.localScale = Vector3.one;

            var go = new GameObject(ObjectName);
            go.transform.SetParent(root.transform, false);
            go.transform.localPosition = new Vector3(-416.637451171875f, 113.12406921386719f, -490.5157165527344f);
            go.transform.localRotation = Quaternion.identity;
            go.transform.localScale = Vector3.one;
            var filter = go.AddComponent<MeshFilter>();
            filter.sharedMesh = mesh;
            var renderer = go.AddComponent<MeshRenderer>();
            renderer.sharedMaterial = material;
            renderer.shadowCastingMode = ShadowCastingMode.Off;
            renderer.receiveShadows = false;
            renderer.motionVectorGenerationMode = MotionVectorGenerationMode.ForceNoMotion;
            renderer.lightProbeUsage = LightProbeUsage.Off;
            renderer.reflectionProbeUsage = ReflectionProbeUsage.Off;
            renderer.allowOcclusionWhenDynamic = true;

            EditorUtility.SetDirty(mesh);
            EditorUtility.SetDirty(material);
            EditorUtility.SetDirty(root);
            EditorSceneManager.MarkSceneDirty(scene);
            EditorSceneManager.SaveScene(scene);
            AssetDatabase.SaveAssets();
            Selection.activeGameObject = go;

            var report = new StringBuilder();
            report.AppendLine("PASS");
            report.AppendLine("event=2012");
            report.AppendLine("draw=8892 indices, 1 instance, 3764 vertices, 2964 triangles");
            report.AppendLine("VS=209975; PS=209977");
            report.AppendLine("position=(-416.637451171875, 113.12406921386719, -490.5157165527344)");
            report.AppendLine("rotation=(0,0,0,1); scale=(1,1,1)");
            report.AppendLine("baseColor=res17/RID266514/BC7_SRGB; normalMaterial=res19/RID266538/BC7_SRGB");
            report.AppendLine("PS mip bias=-1; uniforms22.m1=0 (captured exact value)");
            report.AppendLine("components=Transform, MeshFilter, MeshRenderer only");
            report.AppendLine("scene=" + TargetScene);
            File.WriteAllText(ReportPath, report.ToString());
            Debug.Log("[EID2012] Import complete: " + report.ToString());
        }
        finally { busy = false; }
    }

    static Mesh BuildExactMesh(byte[] s0, byte[] s1, byte[] constant, byte[] ib)
    {
        // Unity-adapted VSInput layout. The packed normal float is kept bit-for-bit in TEXCOORD1
        // because Unity's conventional NORMAL accessor may normalize/canonicalize this bit field.
        var descriptors = new[]
        {
            new VertexAttributeDescriptor(VertexAttribute.Position, VertexAttributeFormat.Float32, 3, 0),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord1, VertexAttributeFormat.Float32, 1, 0),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.Tangent, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4, 2),
        };

        byte[] constantsPerVertex = new byte[VertexCount * 8];
        for (int i = 0; i < VertexCount; i++)
        {
            Buffer.BlockCopy(constant, 12, constantsPerVertex, i * 8, 4); // _input2/tangent = FF0000FF
            Buffer.BlockCopy(constant, 4, constantsPerVertex, i * 8 + 4, 4); // _input3/color = FFFFFFFF
        }
        ushort[] indices = new ushort[IndexCount];
        Buffer.BlockCopy(ib, 0, indices, 0, ib.Length);
        for (int i = 0; i < indices.Length; i++) if (indices[i] >= VertexCount) throw new InvalidDataException("EID2012 index out of range at " + i);

        var mesh = new Mesh { name = "EID2012 VSInput Exact (3764 vertices, 8892 indices)", indexFormat = IndexFormat.UInt16 };
        var flags = MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices | MeshUpdateFlags.DontNotifyMeshUsers;
        mesh.SetVertexBufferParams(VertexCount, descriptors);
        mesh.SetVertexBufferData(s0, 0, 0, s0.Length, 0, flags);
        mesh.SetVertexBufferData(s1, 0, 0, s1.Length, 1, flags);
        mesh.SetVertexBufferData(constantsPerVertex, 0, 0, constantsPerVertex.Length, 2, flags);
        mesh.SetIndexBufferParams(IndexCount, IndexFormat.UInt16);
        mesh.SetIndexBufferData(indices, 0, 0, IndexCount, flags);

        Bounds bounds = CalculateBounds(s0);
        var sub = new SubMeshDescriptor(0, IndexCount, MeshTopology.Triangles)
        {
            baseVertex = 0,
            firstVertex = 0,
            vertexCount = VertexCount,
            bounds = bounds
        };
        mesh.SetSubMesh(0, sub, flags);
        mesh.bounds = bounds;
        mesh.UploadMeshData(false);
        return mesh;
    }

    static Bounds CalculateBounds(byte[] stream)
    {
        Vector3 min = new Vector3(float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity);
        Vector3 max = new Vector3(float.NegativeInfinity, float.NegativeInfinity, float.NegativeInfinity);
        for (int i = 0; i < VertexCount; i++)
        {
            Vector3 p = new Vector3(BitConverter.ToSingle(stream, i * 16), BitConverter.ToSingle(stream, i * 16 + 4), BitConverter.ToSingle(stream, i * 16 + 8));
            min = Vector3.Min(min, p); max = Vector3.Max(max, p);
        }
        return new Bounds((min + max) * 0.5f, max - min);
    }

    static Texture2D ImportBC7(string prefix, bool linear)
    {
        string path = Root + "/ImportedTextures/" + prefix + ".asset";
        Texture2D texture = AssetDatabase.LoadAssetAtPath<Texture2D>(path);
        if (texture) return texture;
        texture = new Texture2D(256, 256, TextureFormat.BC7, true, linear)
        {
            name = prefix,
            wrapModeU = TextureWrapMode.Repeat,
            wrapModeV = TextureWrapMode.Repeat,
            filterMode = FilterMode.Trilinear,
            anisoLevel = 1
        };
        for (int mip = 0; mip < 9; mip++) texture.SetPixelData(Read(prefix + "_s0_m" + mip + ".bytes"), mip);
        texture.Apply(false, true);
        AssetDatabase.CreateAsset(texture, path);
        return texture;
    }

    static byte[] Read(string file) => File.ReadAllBytes(Captured + file);
}
#endif
