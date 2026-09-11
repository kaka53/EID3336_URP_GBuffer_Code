using System;
using System.IO;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;

public static class EID3863VegetationImporter
{
    const string Root = "Assets/EID3332_EID3336_Combined/EID3863_RenderDocVegetation";
    const string Captured = Root + "/Captured/";
    const string MeshPath = Root + "/Geometry/EID3863_VSInput_Exact.asset";
    const string MaterialPath = Root + "/Materials/EID3863_Vegetation_PS215850.mat";
    const string InstancesRootName = "EID3863_Vegetation_Instances";
    const int CapturedInstanceCount = 297;
    const int CapturedInstanceStride = 96;

    // EID3863 instance 0, reconstructed from VS uniforms28.  The four captured
    // float4 records are the object-to-world matrix columns.
    static readonly Vector3 CapturedPosition = new Vector3(-546.53601f, 104.99900f, -410.93301f);
    static readonly Vector3 CapturedBasisX = new Vector3(0.88129884f, 0.12907371f, 0.61793476f);
    static readonly Vector3 CapturedBasisY = new Vector3(0.00950570f, 1.05832648f, -0.23461936f);
    static readonly Vector3 CapturedBasisZ = new Vector3(-0.63120025f, 0.19615461f, 0.85924536f);

    [MenuItem("EID3332-EID3336/EID3863/Build Single Plant Assets")]
    public static void BuildExactAssets()
    {
        Directory.CreateDirectory(Root + "/ImportedTextures");
        Directory.CreateDirectory(Root + "/Geometry");
        Directory.CreateDirectory(Root + "/Materials");

        Mesh mesh = BuildMesh();
        AssetDatabase.ImportAsset(Root + "/Shaders/EID3863Vegetation.shader", ImportAssetOptions.ForceUpdate);
        Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(Root + "/Shaders/EID3863Vegetation.shader");
        if (!shader || ShaderUtil.ShaderHasError(shader))
            throw new InvalidOperationException("EID3863 shader has compile errors. See Console/Shader Inspector.");

        var generated = new Material(shader) { name = "EID3863_Vegetation_PS215850" };
        generated.enableInstancing = true;
        generated.doubleSidedGI = true;
        generated.SetTexture("_Res23", ImportBC7("PS_res23_rid220388", false));
        generated.SetTexture("_Res25", ImportBC7("PS_res25_rid220114", true));
        generated.SetTexture("_EID3863VSRes34", ImportRaw("VS_res34_rid210510_s0_m0.bytes", 512, 512, TextureFormat.RG16, true, "rid210510"));
        generated.SetTexture("_EID3863VSRes35", ImportRaw("VS_res35_rid210507_s0_m0.bytes", 256, 256, TextureFormat.RG32, true, "rid210507"));
        generated.SetTexture("_EID3863VSRes36", ImportRaw("VS_res36_rid209141_s0_m0.bytes", 256, 256, TextureFormat.RG32, true, "rid209141"));
        generated.SetTexture("_EID3863VSRes37", ImportRaw("VS_res37_rid14988_s0_m0.bytes", 512, 512, TextureFormat.RGBA32, true, "rid14988"));

        // Active local values copied exactly from PS uniforms28 (224 bytes).
        generated.SetFloat("_EID3863NormalStrength", 3.02f);
        generated.SetFloat("_EID3863DoubleSidedNormal", 1.0f);
        generated.SetFloat("_EID3863NormalFlatten", 0.515f);
        generated.SetFloat("_EID3863MaterialClass", 0.62f);
        generated.SetFloat("_EID3863PackedNormalWeight", 0.115f);
        generated.SetFloat("_EID3863RoughnessMin", 0.0f);
        generated.SetFloat("_EID3863RoughnessMax", 1.0f);
        generated.SetFloat("_EID3863NormalMaskWeight", 0.376f);
        generated.SetFloat("_EID3863RoughnessMaskWeight", 0.547f);
        generated.SetFloat("_EID3863BaseColorReplaceWeight", 0.0f);
        generated.SetFloat("_EID3863BaseColorMultiplier", 1.0f);
        generated.SetFloat("_EID3863AlphaCutoff", 0.5f);
        generated.SetColor("_EID3863BaseColorTint", new Color(0.561464f, 0.6058412f, 0.7183276f, 1.0f));
        generated.SetVector("_EID3863OpacityDistanceParams", new Vector4(0.023f, 4.0f, 0.7f, 28.40311f));
        generated.SetVector("_EID3863MaterialDistanceParams", new Vector4(0.0f, 1.818182f, 0.923f, 98.9001f));
        generated.SetVector("_EID3863InstanceMaterial2", Vector4.zero);

        Material material = AssetDatabase.LoadAssetAtPath<Material>(MaterialPath);
        if (material)
        {
            EditorUtility.CopySerialized(generated, material);
            UnityEngine.Object.DestroyImmediate(generated);
            EditorUtility.SetDirty(material);
        }
        else
        {
            material = generated;
            AssetDatabase.CreateAsset(material, MaterialPath);
        }

        AssetDatabase.SaveAssets();
        Debug.Log($"[EID3863] Single VSInput built: vertices={mesh.vertexCount}, indices={mesh.GetIndexCount(0)}; serialized material ready.");
        Selection.activeObject = mesh;
    }

    static Mesh BuildMesh()
    {
        byte[] s0 = Read("vertex_stream0.bytes");
        byte[] s1 = Read("vertex_stream1.bytes");
        byte[] s2 = Read("vertex_stream2.bytes");
        byte[] s3 = Read("vertex_stream3.bytes");
        byte[] ib = Read("indices_u16.bytes");
        if (s0.Length != 640 || s1.Length != 640 || s2.Length != 160 || s3.Length != 16 || ib.Length != 120)
            throw new InvalidDataException("EID3863 VSInput length mismatch; expected 40 vertices and 60 UInt16 indices.");

        const int vertexCount = 40;
        var positions = new Vector3[vertexCount];
        var packedInput1 = new Vector3[vertexCount];
        var input2 = new Vector4[vertexCount];
        var input3 = new Color32[vertexCount];
        var uv0 = new Vector2[vertexCount];
        var uv1 = new Vector2[vertexCount];
        var uv2 = new Vector2[vertexCount];
        Vector4 constantInput2 = UNorm(s3, 12);

        for (int v = 0; v < vertexCount; v++)
        {
            int o = v * 16;
            positions[v] = new Vector3(F(s0, o), F(s0, o + 4), F(s0, o + 8));
            uint rawInput1 = BitConverter.ToUInt32(s0, o + 12);
            packedInput1[v] = new Vector3(BitConverter.Int32BitsToSingle(unchecked((int)rawInput1)), 0f, 0f);
            input2[v] = constantInput2;
            Vector4 c = UNorm(s2, v * 4);
            input3[v] = new Color32(s2[v * 4], s2[v * 4 + 1], s2[v * 4 + 2], s2[v * 4 + 3]);
            uv0[v] = new Vector2(F(s1, o), F(s1, o + 4));
            uv1[v] = new Vector2(F(s1, o + 8), F(s1, o + 12));
            uv2[v] = uv1[v];
        }

        var indices = new int[60];
        for (int i = 0; i < indices.Length; i++)
            indices[i] = BitConverter.ToUInt16(ib, i * 2);

        var generated = new Mesh
        {
            name = "EID3863_VSInput_Instance000_Exact",
            indexFormat = IndexFormat.UInt16
        };
        generated.vertices = positions;
        generated.normals = packedInput1; // Raw input1 bits; deliberately not a conventional normal.
        generated.tangents = input2;
        generated.colors32 = input3;
        generated.SetUVs(0, uv0);
        generated.SetUVs(1, uv1);
        generated.SetUVs(2, uv2);
        generated.SetIndices(indices, MeshTopology.Triangles, 0, true);
        generated.RecalculateBounds();
        generated.UploadMeshData(false);

        Mesh existing = AssetDatabase.LoadAssetAtPath<Mesh>(MeshPath);
        if (existing)
        {
            EditorUtility.CopySerialized(generated, existing);
            UnityEngine.Object.DestroyImmediate(generated);
            EditorUtility.SetDirty(existing);
            return existing;
        }

        AssetDatabase.CreateAsset(generated, MeshPath);
        return generated;
    }

    [MenuItem("EID3332-EID3336/EID3863/Add Single Plant To Current Scene")]
    public static void AddToCurrentScene()
    {
        BuildExactAssets();

        GameObject go = GameObject.Find("EID3863_Vegetation");
        if (!go) go = new GameObject("EID3863_Vegetation");
        go.transform.SetParent(null, false);

        MeshFilter filter = go.GetComponent<MeshFilter>();
        if (!filter) filter = go.AddComponent<MeshFilter>();
        MeshRenderer renderer = go.GetComponent<MeshRenderer>();
        if (!renderer) renderer = go.AddComponent<MeshRenderer>();

        filter.sharedMesh = AssetDatabase.LoadAssetAtPath<Mesh>(MeshPath);
        renderer.sharedMaterial = AssetDatabase.LoadAssetAtPath<Material>(MaterialPath);
        ApplyCapturedInstance0Transform(go.transform);

        EditorUtility.SetDirty(go);
        EditorUtility.SetDirty(filter);
        EditorUtility.SetDirty(renderer);
        EditorSceneManager.MarkSceneDirty(go.scene);
        EditorSceneManager.SaveScene(go.scene);
        Selection.activeGameObject = go;

        Debug.Log($"[EID3863] Scene integration complete. vertices={filter.sharedMesh.vertexCount}, indices={filter.sharedMesh.GetIndexCount(0)}, position={go.transform.position}.");
    }

    [MenuItem("EID3332-EID3336/EID3863/Add All 297 GPU Instanced Plants")]
    public static void AddAllInstancesToCurrentScene()
    {
        BuildExactAssets();

        byte[] instanceData = Read("PS_uniforms20_65536.bytes");
        if (instanceData.Length < CapturedInstanceCount * CapturedInstanceStride)
            throw new InvalidDataException("EID3863 instance buffer does not contain 297 complete records.");

        Mesh mesh = AssetDatabase.LoadAssetAtPath<Mesh>(MeshPath);
        Material material = AssetDatabase.LoadAssetAtPath<Material>(MaterialPath);
        if (!mesh || !material) throw new InvalidOperationException("EID3863 shared Mesh or Material is missing.");
        material.enableInstancing = true;
        material.doubleSidedGI = true;
        EditorUtility.SetDirty(material);

        GameObject oldSingle = GameObject.Find("EID3863_Vegetation");
        GameObject rootObject = GameObject.Find(InstancesRootName);
        if (!rootObject) rootObject = new GameObject(InstancesRootName);
        Transform rootTransform = rootObject.transform;
        rootTransform.SetParent(null, false);
        rootTransform.SetPositionAndRotation(Vector3.zero, Quaternion.identity);
        rootTransform.localScale = Vector3.one;

        for (int i = rootTransform.childCount - 1; i >= 0; --i)
            UnityEngine.Object.DestroyImmediate(rootTransform.GetChild(i).gameObject);
        if (oldSingle && oldSingle != rootObject)
            UnityEngine.Object.DestroyImmediate(oldSingle);

        int nonZeroMaterialOverrides = 0;
        float maximumMatrixError = 0f;
        var propertyBlock = new MaterialPropertyBlock();
        for (int instanceIndex = 0; instanceIndex < CapturedInstanceCount; ++instanceIndex)
        {
            Matrix4x4 capturedMatrix = ReadCapturedInstanceMatrix(instanceData, instanceIndex);
            Vector4 materialOverride = ReadCapturedInstanceMaterial2(instanceData, instanceIndex);

            var instanceObject = new GameObject($"EID3863_Instance_{instanceIndex:D3}");
            instanceObject.transform.SetParent(rootTransform, false);
            ApplyCapturedMatrix(instanceObject.transform, capturedMatrix);

            MeshFilter filter = instanceObject.AddComponent<MeshFilter>();
            filter.sharedMesh = mesh;
            MeshRenderer renderer = instanceObject.AddComponent<MeshRenderer>();
            renderer.sharedMaterial = material;
            renderer.shadowCastingMode = ShadowCastingMode.Off;
            renderer.receiveShadows = false;
            renderer.motionVectorGenerationMode = MotionVectorGenerationMode.ForceNoMotion;
            renderer.lightProbeUsage = LightProbeUsage.Off;
            renderer.reflectionProbeUsage = ReflectionProbeUsage.Off;
            renderer.allowOcclusionWhenDynamic = true;

            propertyBlock.Clear();
            propertyBlock.SetVector("_EID3863InstanceMaterial2", materialOverride);
            renderer.SetPropertyBlock(propertyBlock);
            if (materialOverride.sqrMagnitude > 1e-16f) ++nonZeroMaterialOverrides;

            maximumMatrixError = Mathf.Max(maximumMatrixError, MaximumMatrixDifference(capturedMatrix, instanceObject.transform.localToWorldMatrix));
        }

        EditorUtility.SetDirty(rootObject);
        EditorSceneManager.MarkSceneDirty(rootObject.scene);
        EditorSceneManager.SaveScene(rootObject.scene);
        AssetDatabase.SaveAssets();
        Selection.activeGameObject = rootObject;

        Debug.Log($"[EID3863] Added {CapturedInstanceCount} GPU-instanced plants. Shared mesh={mesh.name}, shared material={material.name}, material overrides={nonZeroMaterialOverrides}, max matrix error={maximumMatrixError:R}.");
    }

    static Matrix4x4 ReadCapturedInstanceMatrix(byte[] data, int instanceIndex)
    {
        int offset = instanceIndex * CapturedInstanceStride;
        Matrix4x4 matrix = Matrix4x4.zero;
        matrix.SetColumn(0, V(data, offset));
        matrix.SetColumn(1, V(data, offset + 16));
        matrix.SetColumn(2, V(data, offset + 32));
        matrix.SetColumn(3, V(data, offset + 48));
        return matrix;
    }

    static Vector4 ReadCapturedInstanceMaterial2(byte[] data, int instanceIndex)
    {
        return V(data, instanceIndex * CapturedInstanceStride + 80);
    }

    static void ApplyCapturedMatrix(Transform target, Matrix4x4 matrix)
    {
        Vector3 basisX = matrix.GetColumn(0);
        Vector3 basisY = matrix.GetColumn(1);
        Vector3 basisZ = matrix.GetColumn(2);
        Vector3 scale = new Vector3(basisX.magnitude, basisY.magnitude, basisZ.magnitude);
        if (scale.x <= 1e-8f || scale.y <= 1e-8f || scale.z <= 1e-8f)
            throw new InvalidDataException("EID3863 captured instance contains a zero scale axis.");

        Vector3 right = basisX / scale.x;
        Vector3 up = basisY / scale.y;
        Vector3 forward = basisZ / scale.z;
        if (Vector3.Dot(Vector3.Cross(right, up), forward) < 0f)
        {
            scale.x = -scale.x;
            right = -right;
        }

        target.SetPositionAndRotation(matrix.GetColumn(3), Quaternion.LookRotation(forward, up));
        target.localScale = scale;
    }

    static float MaximumMatrixDifference(Matrix4x4 expected, Matrix4x4 actual)
    {
        float result = 0f;
        for (int row = 0; row < 4; ++row)
            for (int column = 0; column < 4; ++column)
                result = Mathf.Max(result, Mathf.Abs(expected[row, column] - actual[row, column]));
        return result;
    }

    static void ApplyCapturedInstance0Transform(Transform target)
    {
        Vector3 scale = new Vector3(CapturedBasisX.magnitude, CapturedBasisY.magnitude, CapturedBasisZ.magnitude);
        Vector3 up = CapturedBasisY / scale.y;
        Vector3 forward = CapturedBasisZ / scale.z;
        target.SetPositionAndRotation(CapturedPosition, Quaternion.LookRotation(forward, up));
        target.localScale = scale;
    }

    static Texture2D ImportBC7(string prefix, bool linear)
    {
        string path = Root + "/ImportedTextures/" + prefix + ".asset";
        Texture2D old = AssetDatabase.LoadAssetAtPath<Texture2D>(path);
        if (old) return old;
        var texture = new Texture2D(512, 512, TextureFormat.BC7, true, linear)
        {
            name = prefix,
            wrapMode = TextureWrapMode.Repeat,
            filterMode = FilterMode.Trilinear
        };
        for (int mip = 0; mip < 10; mip++) texture.SetPixelData(Read(prefix + "_s0_m" + mip + ".bytes"), mip);
        texture.Apply(false, true);
        AssetDatabase.CreateAsset(texture, path);
        return texture;
    }

    static Texture2D ImportRaw(string file, int width, int height, TextureFormat format, bool linear, string name)
    {
        string path = Root + "/ImportedTextures/" + name + ".asset";
        Texture2D old = AssetDatabase.LoadAssetAtPath<Texture2D>(path);
        if (old) return old;
        var texture = new Texture2D(width, height, format, false, linear)
        {
            name = name,
            wrapMode = TextureWrapMode.Clamp,
            filterMode = FilterMode.Bilinear
        };
        texture.LoadRawTextureData(Read(file));
        texture.Apply(false, true);
        AssetDatabase.CreateAsset(texture, path);
        return texture;
    }

    static byte[] Read(string file) => File.ReadAllBytes(Captured + file);
    static float F(byte[] bytes, int offset) => BitConverter.ToSingle(bytes, offset);
    static Vector4 V(byte[] bytes, int offset) => new Vector4(F(bytes, offset), F(bytes, offset + 4), F(bytes, offset + 8), F(bytes, offset + 12));
    static Vector4 UNorm(byte[] bytes, int offset) => new Vector4(bytes[offset], bytes[offset + 1], bytes[offset + 2], bytes[offset + 3]) / 255f;
}
