import os

src = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS209990_PS209991_Batch/Editor/ColourPass6VS209990PS209991BatchImporter.cs'
dst = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215543_PS215544_Batch/Editor/ColourPass6VS215543PS215544BatchImporter.cs'
text = open(src, encoding='utf8').read()

unique_once = [
    (
        'if (Rid(p, "res28") == 0 || Rid(p, "res26") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res28/res26.");\n        byte[] local = ReadCB(p, "PS", "uniforms31");\n        if (local.Length < 368) throw new InvalidDataException("EID" + p.eid + " PS uniforms31 expected 368 bytes, got " + local.Length);',
        'if (Rid(p, "res25") == 0 || Rid(p, "res27") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res25/res27.");\n        byte[] local = ReadCB(p, "PS", "uniforms30");\n        if (local.Length < 224) throw new InvalidDataException("EID" + p.eid + " PS uniforms30 expected 224 bytes, got " + local.Length);',
    ),
    (
        'byte[] stream0 = new byte[count * 24];\n        byte[] stream1 = new byte[count * 8];\n        byte[] stream2 = new byte[count * 8];',
        'byte[] stream0 = new byte[count * 24];\n        byte[] stream1 = new byte[count * 8];\n        byte[] stream2 = new byte[count * 16];\n        byte[] stream3 = new byte[count * 4];',
    ),
    (
        'byte[] pos = ReadInput(p, "_input0", v, 12);\n            byte[] packed = ReadInput(p, "_input1", v, 4);\n            Buffer.BlockCopy(pos, 0, stream0, v * 24, 12);\n            Buffer.BlockCopy(packed, 0, stream0, v * 24 + 12, 4);\n            CopyInput(p, "_input4", v, stream1, v * 8, 8);\n            CopyInput(p, "_input2", v, stream2, v * 8, 4);\n            CopyInput(p, "_input3", v, stream2, v * 8 + 4, 4);',
        'byte[] pos = ReadInput(p, "_input0", v, 12);\n            byte[] packed = ReadInput(p, "_input1", v, 4);\n            Buffer.BlockCopy(pos, 0, stream0, v * 24, 12);\n            Buffer.BlockCopy(packed, 0, stream0, v * 24 + 12, 4);\n            CopyInput(p, "_input4", v, stream1, v * 8, 8);\n            CopyInput(p, "_input3", v, stream2, v * 16, 16);\n            CopyInput(p, "_input2", v, stream3, v * 4, 4);',
    ),
    (
        'new VertexAttributeDescriptor(VertexAttribute.Position, VertexAttributeFormat.Float32, 3, 0),\n            new VertexAttributeDescriptor(VertexAttribute.Normal, VertexAttributeFormat.Float32, 3, 0),\n            new VertexAttributeDescriptor(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4, 2),\n            new VertexAttributeDescriptor(VertexAttribute.Tangent, VertexAttributeFormat.UNorm8, 4, 2),\n            new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 2, 1),',
        'new VertexAttributeDescriptor(VertexAttribute.Position, VertexAttributeFormat.Float32, 3, 0),\n            new VertexAttributeDescriptor(VertexAttribute.Normal, VertexAttributeFormat.Float32, 3, 0),\n            new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 2, 1),\n            new VertexAttributeDescriptor(VertexAttribute.Tangent, VertexAttributeFormat.Float32, 4, 2),\n            new VertexAttributeDescriptor(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4, 3),',
    ),
    (
        'mesh.SetVertexBufferData(stream0, 0, 0, stream0.Length, 0, MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);\n        mesh.SetVertexBufferData(stream1, 0, 0, stream1.Length, 1, MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);\n        mesh.SetVertexBufferData(stream2, 0, 0, stream2.Length, 2, MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);',
        'mesh.SetVertexBufferData(stream0, 0, 0, stream0.Length, 0, MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);\n        mesh.SetVertexBufferData(stream1, 0, 0, stream1.Length, 1, MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);\n        mesh.SetVertexBufferData(stream2, 0, 0, stream2.Length, 2, MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);\n        mesh.SetVertexBufferData(stream3, 0, 0, stream3.Length, 3, MeshUpdateFlags.DontRecalculateBounds | MeshUpdateFlags.DontValidateIndices);',
    ),
    (
        'audit.AppendLine("- Unity native streams: `Position Float32x3 + Normal Float32x3 packed _input1 in .x`, `UV0 Float32x2`, `input2/input3 UNorm8x4`");',
        'audit.AppendLine("- Unity native streams: `Position Float32x3 + Normal Float32x3 packed _input1 in .x`, `UV0 Float32x2`, `input3 Float32x4 TANGENT`, `input2 UNorm8x4 COLOR`; UV1/UV2 aliases of UV0 unused");',
    ),
    (
        'byte[] local = ReadCB(p, "PS", "uniforms31");\n        for (int i = 0; i < 23; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] sun = ReadCB(p, "PS", "uniforms33");\n        m.SetVector("_SunDir", ReadVector4(sun, 0));\n        byte[] globals = ReadCB(p, "PS", "uniforms20");\n        m.SetFloat("_EID209991MipBias", ReadFloat(globals, 416));\n        Texture albedo = LoadTexture(p, "res28");\n        Texture normalTex = LoadTexture(p, "res26");\n        if (albedo == null || normalTex == null)\n            throw new FileNotFoundException("EID" + p.eid + " res28/res26 texture binding is incomplete.");\n        m.SetTexture("_Res28", albedo);\n        m.SetTexture("_Res26", normalTex);\n        EditorUtility.SetDirty(m);\n        report.AppendLine("EID" + p.eid + ": material res28=RID" + Rid(p, "res28") + " res26=RID" + Rid(p, "res26") + " PS uniforms31=" + local.Length + "B");',
        'byte[] local = ReadCB(p, "PS", "uniforms30");\n        m.SetVector("_P00", ReadVector4(local, 0));\n        m.SetVector("_P01", ReadVector4(local, 16));\n        m.SetVector("_P02", ReadVector4(local, 32));\n        m.SetVector("_P03", ReadVector4(local, 48));\n        m.SetVector("_P04", ReadVector4(local, 64));\n        m.SetVector("_P05", ReadVector4(local, 80));\n        m.SetVector("_P06", ReadVector4(local, 96));\n        m.SetVector("_P07", ReadVector4(local, 112));\n        m.SetVector("_P08", ReadVector4(local, 128));\n        m.SetVector("_P09", ReadVector4(local, 144));\n        m.SetVector("_P10", ReadVector4(local, 160));\n        m.SetVector("_P11", ReadVector4(local, 176));\n        m.SetVector("_P12", ReadVector4(local, 192));\n        m.SetVector("_P13", ReadVector4(local, 208));\n        byte[] sun = ReadCB(p, "PS", "uniforms32");\n        m.SetVector("_SunDir", ReadVector4(sun, 0));\n        byte[] globals = ReadCB(p, "PS", "uniforms19");\n        m.SetFloat("_EID215544MipBias", ReadFloat(globals, 416));\n        Texture albedo = LoadTexture(p, "res25");\n        Texture normalTex = LoadTexture(p, "res27");\n        if (albedo == null || normalTex == null)\n            throw new FileNotFoundException("EID" + p.eid + " res25/res27 texture binding is incomplete.");\n        m.SetTexture("_Res25", albedo);\n        m.SetTexture("_Res27", normalTex);\n        EditorUtility.SetDirty(m);\n        report.AppendLine("EID" + p.eid + ": material res25=RID" + Rid(p, "res25") + " res27=RID" + Rid(p, "res27") + " PS uniforms30=" + local.Length + "B");',
    ),
    (
        'audit.Insert(0, "# VS209990 / PS209991 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `24.1-24.3`\\n- Layout variants: `" + layouts + "` (`bb048e18a6ab9087`)\\n- Shader: live Unity VP; unique res28/res26; PS uniforms31 368B; Cull Off; ZWrite Off; ZTest Equal; stencil 33; skip skin; per-instance GOs\\n\\n");',
        'audit.Insert(0, "# VS215543 / PS215544 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `43.1-43.2`\\n- Layout variants: `" + layouts + "` (`bb048e18a6ab9087`)\\n- Shader: live Unity VP; unique res25/res27; PS uniforms30 224B; Cull Off; ZWrite Off; ZTest Equal; stencil 33; skip skin; oct 0.0020; per-instance GOs; isolate from family 24\\n\\n");',
    ),
]

missing = []
for a, b in unique_once:
    n = text.count(a)
    if n != 1:
        missing.append((n, a[:220]))
    else:
        text = text.replace(a, b, 1)

global_pairs = [
    ('ColourPass6VS209990PS209991BatchImporter', 'ColourPass6VS215543PS215544BatchImporter'),
    ('Assets/ColourPass6_VS209990_PS209991_Batch', 'Assets/ColourPass6_VS215543_PS215544_Batch'),
    ('VS209990_PS209991_BatchManifest.json', 'VS215543_PS215544_BatchManifest.json'),
    ('Shaders/EID209990209991GBuffer.shader', 'Shaders/EID215543215544GBuffer.shader'),
    ('Validation/ColourPass6_VS209990', 'Validation/ColourPass6_VS215543'),
    ('ColourPass6_VS209990_PS209991', 'ColourPass6_VS215543_PS215544'),
    ('static readonly int[] ExpectedEIDs = { 3598, 3602, 3606 };', 'static readonly int[] ExpectedEIDs = { 3694, 3698 };'),
    ('static readonly int ExpectedInstances = 19;', 'static readonly int ExpectedInstances = 10;'),
    ('[MenuItem("Tools/Colour Pass 6/Import EID 24.1-24.3 (VS209990 PS209991)")]', '[MenuItem("Tools/Colour Pass 6/Import EID 43.1-43.2 (VS215543 PS215544)")]'),
    ('Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 24.1-24.3.', 'Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 43.1-43.2.'),
    ('Expected EIDs 24.1-24.3, got ', 'Expected EIDs 43.1-43.2, got '),
    ('VS209990/PS209991 shader has compile errors', 'VS215543/PS215544 shader has compile errors'),
    ('EID209990DrawProfile', 'EID215543DrawProfile'),
    ('"EID" + p.eid + " VS209990 Complete VSInput"', '"EID" + (p.sharedGeometryFromEID != 0 ? p.sharedGeometryFromEID : p.eid) + " VS215543 Complete VSInput"'),
    ('path = Root + "/Materials/EID" + p.eid + "_VS209990_PS209991.mat";', 'path = Root + "/Materials/EID" + p.eid + "_VS215543_PS215544.mat";'),
    ('m.name = "EID" + p.eid + " VS209990 PS209991";', 'm.name = "EID" + p.eid + " VS215543 PS215544";'),
    ('g.material.shader.name != "EID/URP/VS209990_PS209991_GBuffer"', 'g.material.shader.name != "EID/URP/VS215543_PS215544_GBuffer"'),
    ('"24.1-24.3 instance total expected "', '"43.1-43.2 instance total expected "'),
    ('[ColourPass6] VS209990/PS209991 import completed', '[ColourPass6] VS215543/PS215544 import completed'),
    ('EID209990', 'EID215543'),
    ('209990', '215543'),
    ('209991', '215544'),
]

global_missing = []
for a, b in global_pairs:
    n = text.count(a)
    if n == 0:
        global_missing.append(a[:160])
    else:
        text = text.replace(a, b)

open(dst, 'w', encoding='utf8', newline='\n').write(text)
print('wrote', dst, os.path.getsize(dst))
print('unique_missing', missing)
print('global_missing', global_missing)
leftover = []
for needle in ['209990', '209991', 'res28', 'res26', 'uniforms31', 'uniforms33', 'uniforms20', '3598', '3602', '3606', '24.1', 'EID209990']:
    if needle in text:
        leftover.append((needle, text.count(needle)))
print('leftover', leftover)
print('uniforms30', text.count('uniforms30'))
print('uniforms32', text.count('uniforms32'))
print('uniforms19', text.count('uniforms19'))
print('res25', text.count('res25'))
print('res27', text.count('res27'))
print('uniforms27', text.count('uniforms27'))
