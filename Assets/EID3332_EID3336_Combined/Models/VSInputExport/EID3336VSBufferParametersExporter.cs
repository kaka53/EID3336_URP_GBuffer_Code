#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using UnityEditor;
using UnityEngine;

public static class EID3336VSBufferParametersExporter
{
    const string Root = "Assets/EID3332_EID3336_Combined";
    const string SourceRoot = Root + "/Resources/EID3336VS";
    const string RawRoot = Root + "/Resources/EID3336Raw";
    const string AssetPath = Root + "/Models/VSInputExport/EID3336_VSBufferParameters.asset";
    const int Uniform25Start = 369408;
    const int Uniform27Start = 370944;
    const int Uniform30Start = 7495168;

    struct Spec
    {
        public string name;
        public string type;
        public int offset;
        public int rows;
        public int scalarBytes;
        public Spec(string name, string type, int offset, int rows = 1, int scalarBytes = 16)
        {
            this.name = name; this.type = type; this.offset = offset; this.rows = rows; this.scalarBytes = scalarBytes;
        }
    }

    [MenuItem("Tools/EID3332+3336/Export EID3336 VS Buffer Parameters Asset")]
    public static void Export()
    {
        AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
        var records = new List<EID3336VSBufferParameters.BufferRecord>();
        Add(records, "VS_24_25", "uniforms25", "Vertex", "ConstantBuffer", 0, 13, 526, Uniform25Start, SourceRoot + "/_24_25.bytes", 22, BuildUniform25Specs());
        Add(records, "VS_26_27", "uniforms27", "Vertex", "ConstantBuffer", 0, 16, 526, Uniform27Start, SourceRoot + "/_26_27.bytes", 139, BuildUniform27Specs());
        Add(records, "VS_28_30", "uniforms30", "Vertex", "StructuredBuffer", 2, 0, 526, Uniform30Start, SourceRoot + "/_28_30.bytes", 1, BuildUniform30Specs());
        Add(records, "VS_32", "ssbo32", "Vertex", "RawBuffer", 0, 19, 261, 0, SourceRoot + "/_32.bytes", 1, BuildRawPreviewSpecs(8413184));
        Add(records, "EID3336RawStream0", "vertex_stream0", "VertexInput", "RawBuffer", -1, -1, 0, 0, RawRoot + "/vertex_stream0.bytes", 0, null);
        Add(records, "EID3336RawStream1", "vertex_stream1", "VertexInput", "RawBuffer", -1, -1, 0, 0, RawRoot + "/vertex_stream1.bytes", 0, null);
        Add(records, "EID3336RawConstants", "vertex_constant_stream", "VertexInput", "RawBuffer", -1, -1, 0, 0, RawRoot + "/vertex_constant_stream.bytes", 0, BuildRawPreviewSpecs(20));
        Add(records, "EID3336RawIndices", "indices_u16", "IndexInput", "IndexBuffer", -1, -1, 0, 0, RawRoot + "/indices_u16.bytes", 0, null);

        var inputs = new[]
        {
            Input("POSITION", "float3", 0, 0, 16, "POSITION", "stream0 + 0"),
            Input("NORMAL", "float", 0, 12, 16, "NORMAL", "raw scalar bit pattern; exact VS reads .x"),
            Input("TANGENT", "UNORM8x4", 3, 12, 0, "TANGENT", "vertex constant stream + 12"),
            Input("COLOR", "UNORM8x4", 3, 4, 0, "COLOR", "vertex constant stream + 4"),
            Input("TEXCOORD0", "float2", 1, 0, 16, "TEXCOORD0", "stream1 + 0"),
            Input("TEXCOORD1", "float2", 1, 8, 16, "TEXCOORD1", "stream1 + 8"),
            Input("TEXCOORD2", "float2", 1, 8, 16, "TEXCOORD2", "alias of TEXCOORD1 in VS209986"),
            Input("TEXCOORD3", "float4", 1, 8, 16, "TEXCOORD3", "float4(TEXCOORD1.xy, 0, 1)"),
            Input("TEXCOORD4", "UNORM8x4", 3, 16, 0, "TEXCOORD4", "vertex constant stream + 16"),
            Input("TEXCOORD5", "uint4", 3, 0, 0, "TEXCOORD5", "uint4(constant + 0, 0, 0, 0)")
        };

        var asset = AssetDatabase.LoadAssetAtPath<EID3336VSBufferParameters>(AssetPath);
        if (asset == null)
        {
            asset = ScriptableObject.CreateInstance<EID3336VSBufferParameters>();
            AssetDatabase.CreateAsset(asset, AssetPath);
        }
        asset.eventId = 3336;
        asset.vertexShaderId = 209986;
        asset.indexCount = 7980;
        asset.instanceCount = 3;
        asset.vertexCount = 1716;
        asset.indexStride = 2;
        asset.sourceDescription = "RenderDoc capture screenshot 捕获3.PNG: Set0/b13 uniforms25, Set0/b16 uniforms27, Set2/b0 uniforms30, Set0/b19 ssbo32. Numeric values are decoded from the exact captured payloads.";
        asset.buffers = records.ToArray();
        asset.inputLayout = inputs;
        if (!asset.Validate(out string error)) throw new InvalidOperationException(error);
        EditorUtility.SetDirty(asset);
        AssetDatabase.SaveAssets();
        AssetDatabase.Refresh(ImportAssetOptions.ForceSynchronousImport);
        Debug.Log("[EID3336 VS Buffer Parameters] Exported visible numeric asset " + AssetPath + " with " + asset.buffers.Length + " buffers.");
    }

    static void Add(List<EID3336VSBufferParameters.BufferRecord> list, string name, string shaderResourceName, string stage, string kind, int descriptorSet, int binding, int resourceId, int sourceOffset, string assetPath, int variableCount, List<Spec> specs)
    {
        string abs = Path.Combine(Directory.GetParent(Application.dataPath).FullName, assetPath.Replace('/', Path.DirectorySeparatorChar));
        if (!File.Exists(abs)) throw new FileNotFoundException(abs);
        byte[] data = File.ReadAllBytes(abs);
        var record = new EID3336VSBufferParameters.BufferRecord
        {
            name = name, shaderResourceName = shaderResourceName, stage = stage, kind = kind,
            descriptorSet = descriptorSet, binding = binding, resourceId = resourceId,
            byteSize = data.Length, sourceOffset = sourceOffset,
            rangeStart = sourceOffset, rangeEnd = sourceOffset + data.Length,
            variableCount = variableCount, structuredStride = name == "VS_28_30" ? 256 : 0,
            structuredElementCount = name == "VS_28_30" ? data.Length / 256 : 0,
            sourceResource = assetPath, data = data,
            parameters = Decode(data, specs).ToArray()
        };
        list.Add(record);
    }

    static List<EID3336VSBufferParameters.ParameterRecord> Decode(byte[] data, List<Spec> specs)
    {
        if (specs == null || specs.Count == 0) return new List<EID3336VSBufferParameters.ParameterRecord>();
        var result = new List<EID3336VSBufferParameters.ParameterRecord>(specs.Count);
        foreach (Spec spec in specs)
        {
            var values = new Vector4[spec.rows];
            var formatted = new string[spec.rows];
            for (int row = 0; row < spec.rows; ++row)
            {
                int offset = spec.offset + row * 16;
                values[row] = ReadVector(data, offset, spec.scalarBytes == 4 ? 4 : 16);
                formatted[row] = FormatVector(data, offset, spec.scalarBytes == 4 ? 4 : 16);
            }
            result.Add(new EID3336VSBufferParameters.ParameterRecord
            {
                name = spec.name, type = spec.type, byteOffset = spec.offset,
                byteSize = spec.rows * (spec.scalarBytes == 4 ? 4 : 16), values = values, formattedValues = formatted
            });
        }
        return result;
    }

    static Vector4 ReadVector(byte[] data, int offset, int byteCount)
    {
        float x = ReadFloat(data, offset);
        float y = byteCount >= 8 ? ReadFloat(data, offset + 4) : 0f;
        float z = byteCount >= 12 ? ReadFloat(data, offset + 8) : 0f;
        float w = byteCount >= 16 ? ReadFloat(data, offset + 12) : 0f;
        return new Vector4(x, y, z, w);
    }

    static float ReadFloat(byte[] data, int offset)
    {
        if (offset < 0 || offset + 4 > data.Length) return 0f;
        return BitConverter.ToSingle(data, offset);
    }

    static string FormatVector(byte[] data, int offset, int byteCount)
    {
        int lanes = byteCount / 4;
        var parts = new string[lanes];
        for (int i = 0; i < lanes; ++i)
        {
            int at = offset + i * 4;
            uint bits = at + 4 <= data.Length ? BitConverter.ToUInt32(data, at) : 0u;
            float f = BitConverter.ToSingle(BitConverter.GetBytes(bits), 0);
            parts[i] = string.Format(CultureInfo.InvariantCulture, "f={0:R}; i={1}; u={2}; hex=0x{3:X8}", f, unchecked((int)bits), bits, bits);
        }
        return string.Join(" | ", parts);
    }

    static List<Spec> BuildUniform25Specs()
    {
        var list = new List<Spec>();
        for (int i = 0; i <= 10; ++i) list.Add(new Spec("VS_25_m" + i, "float4x4", i * 64, 4));
        list.Add(new Spec("VS_25_m11", "float4", 704));
        for (int i = 12; i <= 20; ++i) list.Add(new Spec("VS_25_m" + i, "float4x4", 720 + (i - 12) * 64, 4));
        list.Add(new Spec("VS_25_m21", "float4", 1296));
        return list;
    }

    static List<Spec> BuildUniform27Specs()
    {
        var list = new List<Spec>();
        for (int i = 0; i <= 5; ++i) list.Add(new Spec("VS_27_m" + i, "float4", i * 16));
        AddArray(list, "VS_27_m6", "float4[6]", 6, 6);
        AddArray(list, "VS_27_m7", "float4[6]", 12, 6);
        for (int i = 8; i <= 15; ++i) list.Add(new Spec("VS_27_m" + i, "float4", i * 16));
        list.Add(new Spec("VS_27_m16", "float", 26 * 16 + 0, 1, 4));
        list.Add(new Spec("VS_27_m17", "float", 26 * 16 + 4, 1, 4));
        list.Add(new Spec("VS_27_m18", "float", 26 * 16 + 8, 1, 4));
        list.Add(new Spec("VS_27_m19", "uint", 26 * 16 + 12, 1, 4));
        list.Add(new Spec("VS_27_m20", "float4", 27 * 16));
        list.Add(new Spec("VS_27_m21", "int4", 28 * 16));
        for (int i = 22; i <= 31; ++i) list.Add(new Spec("VS_27_m" + i, "float4", (i + 7) * 16));
        AddArray(list, "VS_27_m32", "float4[4]", 39, 4);
        AddArray(list, "VS_27_m33", "float4[4]", 43, 4);
        AddArray(list, "VS_27_m34", "float4[4]", 47, 4);
        AddArray(list, "VS_27_m35", "float4[4]", 51, 4);
        list.Add(new Spec("VS_27_m36", "float4", 55 * 16));
        list.Add(new Spec("VS_27_m37", "float4", 56 * 16));
        AddArray(list, "VS_27_m38", "float4[4]", 57, 4);
        AddArray(list, "VS_27_m39", "float4[4]", 61, 4);
        AddArray(list, "VS_27_m40", "float4[4]", 65, 4);
        for (int i = 41; i <= 98; ++i) list.Add(new Spec("VS_27_m" + i, "float4", (i + 28) * 16));
        AddArray(list, "VS_27_m99", "float4[2]", 127, 2);
        AddArray(list, "VS_27_m100", "float4[2]", 129, 2);
        list.Add(new Spec("VS_27_m101", "float", 131 * 16 + 0, 1, 4));
        list.Add(new Spec("VS_27_m102", "float", 131 * 16 + 4, 1, 4));
        list.Add(new Spec("VS_27_m103", "float", 131 * 16 + 8, 1, 4));
        list.Add(new Spec("VS_27_m104", "float", 131 * 16 + 12, 1, 4));
        for (int i = 105; i <= 134; ++i) list.Add(new Spec("VS_27_m" + i, "float4", (i + 27) * 16));
        list.Add(new Spec("VS_27_m135", "float4x4", 162 * 16, 4));
        list.Add(new Spec("VS_27_m136", "float4", 166 * 16));
        list.Add(new Spec("VS_27_m137", "float4", 167 * 16));
        AddArray(list, "VS_27_m138", "float4[32]", 168, 32);
        return list;
    }

    static List<Spec> BuildUniform30Specs()
    {
        var list = new List<Spec>();
        for (int record = 0; record < 256; ++record)
        {
            int baseOffset = record * 256;
            for (int column = 0; column < 4; ++column)
                list.Add(new Spec("VS_30_m0[" + record + "]._m0.column" + column, "float4", baseOffset + column * 16));
            list.Add(new Spec("VS_30_m0[" + record + "]._m1", "float4", baseOffset + 64));
            list.Add(new Spec("VS_30_m0[" + record + "]._m2", "float4", baseOffset + 80));
            for (int column = 0; column < 4; ++column)
                list.Add(new Spec("VS_30_m0[" + record + "]._m3.column" + column, "float4", baseOffset + 96 + column * 16));
            for (int field = 4; field <= 9; ++field)
                list.Add(new Spec("VS_30_m0[" + record + "]._m" + field, "float4", baseOffset + (field + 8) * 16));
        }
        return list;
    }

    static List<Spec> BuildRawPreviewSpecs(int byteSize)
    {
        int rows = Mathf.Min(byteSize / 16, 16);
        var list = new List<Spec>();
        for (int i = 0; i < rows; ++i) list.Add(new Spec("raw16[" + i + "]", "uint4/float4", i * 16));
        return list;
    }

    static void AddArray(List<Spec> list, string name, string type, int register, int count)
    {
        list.Add(new Spec(name, type, register * 16, count));
    }

    static EID3336VSBufferParameters.InputRecord Input(string name, string type, int stream, int offset, int stride, string semantic, string notes)
    {
        return new EID3336VSBufferParameters.InputRecord { name = name, type = type, stream = stream, offset = offset, stride = stride, semantic = semantic, notes = notes };
    }
}
#endif


// refreshed 2026-09-06
// refreshed compatibility field 2026-09-06

