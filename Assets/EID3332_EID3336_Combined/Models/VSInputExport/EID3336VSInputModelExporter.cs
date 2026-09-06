#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering;

public static class EID3336VSInputModelExporter
{
    const string Root = "Assets/EID3332_EID3336_Combined";
    const string RawRoot = Root + "/CapturedResources/EID3336/Raw";
    const string OutputRoot = Root + "/Models/VSInputExport";
    const string MeshPath = OutputRoot + "/EID3336_VSInput_Exact.asset";
    const string PrefabPath = OutputRoot + "/EID3336_VSInput_Exact.prefab";
    const string MetadataPath = OutputRoot + "/EID3336_VSInput_Exact.json";

    [MenuItem("Tools/EID3332+3336/Export EID3336 Exact VSInput Model")]
    public static void Export()
    {
        AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
        byte[] stream0 = LoadBytes(RawRoot + "/vertex_stream0.bytes");
        byte[] stream1 = LoadBytes(RawRoot + "/vertex_stream1.bytes");
        byte[] constants = LoadBytes(RawRoot + "/vertex_constant_stream.bytes");
        byte[] indexBytes = LoadBytes(RawRoot + "/indices_u16.bytes");
        if (stream0 == null || stream1 == null || constants == null || indexBytes == null)
            throw new InvalidOperationException("EID3336 VSInput raw stream files are incomplete.");
        if (stream0.Length % 16 != 0 || stream1.Length % 16 != 0 || indexBytes.Length % 2 != 0)
            throw new InvalidOperationException("EID3336 VSInput raw stream alignment is invalid.");

        int vertexCount = stream0.Length / 16;
        int indexCount = indexBytes.Length / 2;
        var positions = new List<Vector3>(vertexCount);
        var normals = new List<Vector3>(vertexCount);
        var tangents = new List<Vector4>(vertexCount);
        var colors = new List<Color>(vertexCount);
        var uv0 = new List<Vector2>(vertexCount);
        var uv1 = new List<Vector2>(vertexCount);
        var uv2 = new List<Vector2>(vertexCount);
        var uv3 = new List<Vector4>(vertexCount);
        var uv4 = new List<Vector4>(vertexCount);
        var uv5 = new List<Vector4>(vertexCount);
        var uv6 = new List<Vector4>(vertexCount);
        var uv7 = new List<Vector4>(vertexCount);

        Vector4 input2Tangent = DecodeUNorm8(ReadUInt32(constants, 12));
        Vector4 input3Color = DecodeUNorm8(ReadUInt32(constants, 4));
        Vector4 input10Color = DecodeUNorm8(ReadUInt32(constants, 16));
        uint input11X = ReadUInt32(constants, 0);

        for (int i = 0; i < vertexCount; ++i)
        {
            int p = i * 16;
            int q = i * 16;
            Vector3 input0Position = new Vector3(ReadFloat(stream0, p), ReadFloat(stream0, p + 4), ReadFloat(stream0, p + 8));
            float input1Scalar = UIntAsFloat(ReadUInt32(stream0, p + 12));
            Vector2 input4 = new Vector2(ReadFloat(stream1, q), ReadFloat(stream1, q + 4));
            Vector2 input5 = new Vector2(ReadFloat(stream1, q + 8), ReadFloat(stream1, q + 12));

            positions.Add(input0Position);
            // VS input1 is a scalar NORMAL input. Preserve its exact bit pattern in x;
            // the reconstructed VS reads only .x from the NORMAL semantic.
            normals.Add(new Vector3(input1Scalar, 0f, 0f));
            tangents.Add(input2Tangent);
            colors.Add(input3Color);
            uv0.Add(input4);
            uv1.Add(input5);
            uv2.Add(input5);
            uv3.Add(new Vector4(input5.x, input5.y, 0f, 1f));
            uv4.Add(input10Color);
            uv5.Add(new Vector4(UIntAsFloat(input11X), 0f, 0f, 0f));
            // Raw copies make the non-standard VSInput values inspectable without
            // changing the semantic channels consumed by Unity's mesh fetch.
            uv6.Add(new Vector4(input1Scalar, 0f, 0f, 0f));
            uv7.Add(new Vector4(input11X, 0f, 0f, 0f));
        }

        int[] indices = new int[indexCount];
        for (int i = 0; i < indexCount; ++i) indices[i] = ReadUInt16(indexBytes, i * 2);

        Directory.CreateDirectory(Path.Combine(Application.dataPath, "EID3332_EID3336_Combined/Models/VSInputExport"));
        Mesh mesh = AssetDatabase.LoadAssetAtPath<Mesh>(MeshPath);
        if (mesh == null)
        {
            mesh = new Mesh { name = "EID3336 VSInput Exact (1716 vertices, 7980 indices)" };
            AssetDatabase.CreateAsset(mesh, MeshPath);
        }
        else mesh.Clear();
        mesh.indexFormat = IndexFormat.UInt16;
        mesh.SetVertices(positions);
        mesh.SetNormals(normals);
        mesh.SetTangents(tangents);
        mesh.SetColors(colors);
        mesh.SetUVs(0, uv0);
        mesh.SetUVs(1, uv1);
        mesh.SetUVs(2, uv2);
        mesh.SetUVs(3, uv3);
        mesh.SetUVs(4, uv4);
        mesh.SetUVs(5, uv5);
        mesh.SetUVs(6, uv6);
        mesh.SetUVs(7, uv7);
        mesh.SetIndices(indices, MeshTopology.Triangles, 0, true);
        mesh.subMeshCount = 1;
        mesh.bounds = CalculateBounds(positions);
        EditorUtility.SetDirty(mesh);

        Material material = AssetDatabase.LoadAssetAtPath<Material>(Root + "/Geometry/EID3332CombinedSharedMRT_EID3336.mat");

        GameObject prefabRoot = new GameObject("EID3336_VSInput_Exact");
        prefabRoot.AddComponent<EID3336VSInputExportMetadata>();
        var metadata = prefabRoot.GetComponent<EID3336VSInputExportMetadata>();
        metadata.eventId = 3336;
        metadata.vertexCount = vertexCount;
        metadata.indexCount = indexCount;
        metadata.instanceCount = 3;
        metadata.inputLayout = "POSITION=float3 stream0+0, NORMAL=float1 bit-preserved stream0+12, TANGENT=UNORM8 constant+12, COLOR=UNORM8 constant+4, TEXCOORD0=float2 stream1+0, TEXCOORD1=float2 stream1+8, TEXCOORD2=alias TEXCOORD1, TEXCOORD3=float4(TEXCOORD1.xy,0,1), TEXCOORD4=UNORM8 constant+16, TEXCOORD5=uint4(constant+0,0,0,0)";

        for (int instance = 0; instance < 3; ++instance)
        {
            GameObject child = new GameObject("EID3336_VSInput_Instance_" + instance.ToString("D3"));
            child.transform.SetParent(prefabRoot.transform, false);
            var filter = child.AddComponent<MeshFilter>();
            filter.sharedMesh = mesh;
            var renderer = child.AddComponent<MeshRenderer>();
            renderer.sharedMaterial = material;
            Matrix4x4 matrix = ReadInstanceMatrix(instance);
            ApplyWorldMatrix(child.transform, matrix);
        }

        GameObject prefab = PrefabUtility.SaveAsPrefabAsset(prefabRoot, PrefabPath);
        UnityEngine.Object.DestroyImmediate(prefabRoot);
        if (prefab == null) throw new InvalidOperationException("Failed to save VSInput prefab.");

        File.WriteAllText(Path.Combine(Application.dataPath, "EID3332_EID3336_Combined/Models/VSInputExport/EID3336_VSInput_Exact.json"),
            "{\n  \"eventId\": 3336,\n  \"vertexCount\": 1716,\n  \"indexCount\": 7980,\n  \"instanceCount\": 3,\n  \"source\": \"CapturedResources/EID3336/Raw\",\n  \"modelAsset\": \"EID3336_VSInput_Exact.asset\",\n  \"prefab\": \"EID3336_VSInput_Exact.prefab\",\n  \"inputLayout\": {\n    \"POSITION\": \"float3 stream0 offset 0 stride 16\",\n    \"NORMAL\": \"float scalar, raw bits stream0 offset 12 stride 16\",\n    \"TANGENT\": \"UNORM8 constant stream offset 12\",\n    \"COLOR\": \"UNORM8 constant stream offset 4\",\n    \"TEXCOORD0\": \"float2 stream1 offset 0 stride 16\",\n    \"TEXCOORD1\": \"float2 stream1 offset 8 stride 16\",\n    \"TEXCOORD2\": \"alias TEXCOORD1\",\n    \"TEXCOORD3\": \"float4(TEXCOORD1.xy,0,1)\",\n    \"TEXCOORD4\": \"UNORM8 constant stream offset 16\",\n    \"TEXCOORD5\": \"uint4(constant offset 0,0,0,0)\"\n  },\n  \"coordinateSpace\": \"captured VS input object space; instance matrices remain on prefab nodes\",\n  \"rawPreservation\": {\n    \"uv6\": \"NORMAL scalar bit pattern as float\",\n    \"uv7\": \"TEXCOORD5 uint x as numeric float\"\n  }\n}\n");
        AssetDatabase.ImportAsset(MetadataPath, ImportAssetOptions.ForceSynchronousImport);
        AssetDatabase.SaveAssets();
        AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
        Debug.Log("[EID3336 VSInput Export] Created " + MeshPath + " and " + PrefabPath);
    }

    static Matrix4x4 ReadInstanceMatrix(int index)
    {
        string path = Path.Combine(Application.dataPath, "EID3332_EID3336_Combined/Resources/EID3336VS/_28_30.bytes");
        if (!File.Exists(path)) return Matrix4x4.identity;
        byte[] bytes = File.ReadAllBytes(path);
        int offset = index * 256;
        if (offset + 64 > bytes.Length) return Matrix4x4.identity;
        Matrix4x4 m = Matrix4x4.identity;
        for (int c = 0; c < 4; ++c)
        {
            Vector4 col = new Vector4(
                ReadFloat(bytes, offset + c * 16 + 0),
                ReadFloat(bytes, offset + c * 16 + 4),
                ReadFloat(bytes, offset + c * 16 + 8),
                ReadFloat(bytes, offset + c * 16 + 12));
            m.SetColumn(c, col);
        }
        return m;
    }

    static void ApplyWorldMatrix(Transform target, Matrix4x4 matrix)
    {
        Vector3 x = matrix.GetColumn(0), y = matrix.GetColumn(1), z = matrix.GetColumn(2);
        Vector3 p = matrix.GetColumn(3);
        float sx = x.magnitude, sy = y.magnitude, sz = z.magnitude;
        if (sx < 1e-6f || sy < 1e-6f || sz < 1e-6f) { target.position = p; return; }
        Vector3 scale = new Vector3(sx, sy, sz);
        if (Vector3.Dot(Vector3.Cross(x / sx, y / sy), z / sz) < 0f) scale.z = -scale.z;
        target.SetPositionAndRotation(p, Quaternion.LookRotation(z / sz, y / sy));
        target.localScale = scale;
    }

    static Bounds CalculateBounds(List<Vector3> vertices)
    {
        if (vertices == null || vertices.Count == 0) return new Bounds(Vector3.zero, Vector3.zero);
        Bounds b = new Bounds(vertices[0], Vector3.zero);
        for (int i = 1; i < vertices.Count; ++i) b.Encapsulate(vertices[i]);
        return b;
    }

    static byte[] LoadBytes(string assetPath, bool allowMissing = false)
    {
        string path = Path.Combine(Application.dataPath, assetPath.Substring("Assets/".Length).Replace('/', Path.DirectorySeparatorChar));
        if (!File.Exists(path)) { if (allowMissing) return Array.Empty<byte>(); throw new FileNotFoundException(path); }
        return File.ReadAllBytes(path);
    }
    static uint ReadUInt32(byte[] b, int o) => BitConverter.ToUInt32(b, o);
    static ushort ReadUInt16(byte[] b, int o) => BitConverter.ToUInt16(b, o);
    static float ReadFloat(byte[] b, int o) => BitConverter.ToSingle(b, o);
    static float UIntAsFloat(uint v) => BitConverter.ToSingle(BitConverter.GetBytes(v), 0);
    static Vector4 DecodeUNorm8(uint v) => new Vector4(v & 255u, (v >> 8) & 255u, (v >> 16) & 255u, (v >> 24) & 255u) / 255f;
}

public sealed class EID3336VSInputExportMetadata : MonoBehaviour
{
    public int eventId;
    public int vertexCount;
    public int indexCount;
    public int instanceCount;
    [TextArea(3, 12)] public string inputLayout;
}
#endif


