import os

src = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215537_PS215538_Batch/Editor/ColourPass6VS215537PS215538BatchImporter.cs'
dst = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215539_PS215540_Batch/Editor/ColourPass6VS215539PS215540BatchImporter.cs'
text = open(src, encoding='utf8').read()

unique_once = [
    (
        'if (p.layout == null || p.layout.Length != 9) throw new InvalidDataException("EID" + p.eid + " must expose all 9 RenderDoc VS inputs.");\n        string[] required = { "_input0", "_input1", "_input2", "_input3", "_input4", "_input5", "_input6", "_input7", "_input8" };',
        'if (p.layout == null || p.layout.Length != 8) throw new InvalidDataException("EID" + p.eid + " must expose all 8 RenderDoc VS inputs.");\n        string[] required = { "_input0", "_input1", "_input2", "_input3", "_input4", "_input5", "_input7", "_input8" };',
    ),
    (
        'if (Rid(p, "res33") == 0 || Rid(p, "res35") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res33/res35.");\n        byte[] local = ReadCB(p, "PS", "uniforms38");\n        if (local.Length < 512) throw new InvalidDataException("EID" + p.eid + " PS uniforms38 expected 512 bytes, got " + local.Length);\n        byte[] inst = ReadCB(p, "VS", "uniforms29");\n        if (inst.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " VS uniforms29 too small: " + inst.Length);\n        byte[] overlay = ReadCB(p, "PS", "uniforms25");\n        if (overlay.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " PS uniforms25 too small: " + overlay.Length);',
        'if (Rid(p, "res27") == 0 || Rid(p, "res29") == 0 || Rid(p, "res31") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res27/res29/res31.");\n        byte[] local = ReadCB(p, "PS", "uniforms33");\n        if (local.Length < 448) throw new InvalidDataException("EID" + p.eid + " PS uniforms33 expected 448 bytes, got " + local.Length);\n        byte[] inst = ReadCB(p, "VS", "uniforms27");\n        if (inst.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " VS uniforms27 too small: " + inst.Length);\n        byte[] overlay = ReadCB(p, "PS", "uniforms23");\n        if (overlay.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " PS uniforms23 too small: " + overlay.Length);',
    ),
    (
        'byte[] stream1 = new byte[count * 24];\n        byte[] stream2 = new byte[count * 16];\n        byte[] stream3 = new byte[count * 28];',
        'byte[] stream1 = new byte[count * 16];\n        byte[] stream2 = new byte[count * 16];\n        byte[] stream3 = new byte[count * 28];',
    ),
    (
        'byte[] instanceCB = ReadCB(p, "VS", "uniforms29");',
        'byte[] instanceCB = ReadCB(p, "VS", "uniforms27");',
    ),
    (
        'CopyInput(p, "_input4", v, stream1, v * 24 + 0, 8);\n            CopyInput(p, "_input5", v, stream1, v * 24 + 8, 8);\n            CopyInput(p, "_input6", v, stream1, v * 24 + 16, 8);',
        'CopyInput(p, "_input4", v, stream1, v * 16 + 0, 8);\n            CopyInput(p, "_input5", v, stream1, v * 16 + 8, 8);',
    ),
    (
        'new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 2, 1),\n            new VertexAttributeDescriptor(VertexAttribute.TexCoord1, VertexAttributeFormat.Float32, 2, 1),\n            new VertexAttributeDescriptor(VertexAttribute.TexCoord2, VertexAttributeFormat.Float32, 2, 1),\n            new VertexAttributeDescriptor(VertexAttribute.TexCoord3, VertexAttributeFormat.UNorm8, 4, 2),',
        'new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 2, 1),\n            new VertexAttributeDescriptor(VertexAttribute.TexCoord1, VertexAttributeFormat.Float32, 2, 1),\n            new VertexAttributeDescriptor(VertexAttribute.TexCoord3, VertexAttributeFormat.UNorm8, 4, 2),',
    ),
    (
        'byte[] local = ReadCB(p, "PS", "uniforms38");\n        for (int i = 0; i < 32; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms40");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));\n        ApplyInstanceOverlay(m, p, 0);\n        byte[] globals = ReadCB(p, "PS", "uniforms22");\n        m.SetVector("_ScanGlobals", new Vector4(ReadFloat(globals, 416), ReadFloat(globals, 396), ReadFloat(globals, 436), ReadFloat(globals, 76)));\n        m.SetFloat("_UseBakedSkinning", HasCapturedSkinning(p) ? 1f : 0f);\n        Texture albedo = LoadTexture(p, "res33");\n        Texture normalTex = LoadTexture(p, "res35");\n        if (albedo == null || normalTex == null)\n            throw new FileNotFoundException("EID" + p.eid + " res33/res35 texture binding is incomplete.");\n        m.SetTexture("_Res33", albedo);\n        m.SetTexture("_Res35", normalTex);\n        EditorUtility.SetDirty(m);\n        report.AppendLine("EID" + p.eid + ": material res33=RID" + Rid(p, "res33") + " res35=RID" + Rid(p, "res35") + " PS uniforms38=" + local.Length + "B");',
        'byte[] local = ReadCB(p, "PS", "uniforms33");\n        for (int i = 0; i < 28; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms35");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));\n        ApplyInstanceOverlay(m, p, 0);\n        byte[] globals = ReadCB(p, "PS", "uniforms20");\n        m.SetFloat("_EID215540MipBias", ReadFloat(globals, 416));\n        m.SetFloat("_UseBakedSkinning", HasCapturedSkinning(p) ? 1f : 0f);\n        Texture albedo = LoadTexture(p, "res27");\n        Texture normalTex = LoadTexture(p, "res29");\n        Texture extraTex = LoadTexture(p, "res31");\n        if (albedo == null || normalTex == null || extraTex == null)\n            throw new FileNotFoundException("EID" + p.eid + " res27/res29/res31 texture binding is incomplete.");\n        m.SetTexture("_Res27", albedo);\n        m.SetTexture("_Res29", normalTex);\n        m.SetTexture("_Res31", extraTex);\n        EditorUtility.SetDirty(m);\n        report.AppendLine("EID" + p.eid + ": material res27=RID" + Rid(p, "res27") + " res29=RID" + Rid(p, "res29") + " res31=RID" + Rid(p, "res31") + " PS uniforms33=" + local.Length + "B");',
    ),
    (
        'audit.AppendLine("- Unity native streams: `Position Float32x3 + Normal Float32x3 packed _input1 in .x`, `UV0/1/2 Float32x2`, `input2/input3/input7 UNorm8x4`, `input8 UInt8x4`, `TEXCOORD4/5 baked skinned n/t`");',
        'audit.AppendLine("- Unity native streams: `Position Float32x3 + Normal Float32x3 packed _input1 in .x`, `UV0/1 Float32x2`, `input2/input3/input7 UNorm8x4`, `input8 UInt8x4`, `TEXCOORD4/5 baked skinned n/t`");',
    ),
    (
        'report.AppendLine("vertexAttributes=COMPLETE_9_OF_9");',
        'report.AppendLine("vertexAttributes=COMPLETE_8_OF_8");',
    ),
    (
        'const float k = 0.0019569471478462219f;',
        'const float k = 0.0020f;',
    ),
    (
        'byte[] overlay = ReadCB(p, "PS", "uniforms25");\n        int o = instance * 256;\n        m.SetVector("_InstanceStateYZ", new Vector4(ReadFloat(overlay, o + 68), ReadFloat(overlay, o + 72), ReadFloat(overlay, o + 176), 0));\n        m.SetVector("_InstanceChild7", ReadVector4(overlay, o + 208));\n        m.SetVector("_InstanceChild8", ReadVector4(overlay, o + 224));',
        'byte[] overlay = ReadCB(p, "PS", "uniforms23");\n        int o = instance * 256;\n        m.SetVector("_InstanceStateYZ", new Vector4(ReadFloat(overlay, o + 68), ReadFloat(overlay, o + 72), ReadFloat(overlay, o + 176), 0));',
    ),
    (
        'byte[] cb = ReadCB(p, "VS", "uniforms29");\n        return cb.Length >= 80 && (BitConverter.ToUInt32(cb, 76) & 32u) != 0u;',
        'byte[] cb = ReadCB(p, "VS", "uniforms27");\n        return cb.Length >= 80 && (BitConverter.ToUInt32(cb, 76) & 32u) != 0u;',
    ),
    (
        'byte[] b = ReadCB(p, "VS", "uniforms29"); int o = instance * 256;',
        'byte[] b = ReadCB(p, "VS", "uniforms27"); int o = instance * 256;',
    ),
]

missing = []
for a, b in unique_once:
    n = text.count(a)
    if n != 1:
        missing.append((n, a[:180]))
    else:
        text = text.replace(a, b, 1)

global_pairs = [
    ('ColourPass6VS215537PS215538BatchImporter', 'ColourPass6VS215539PS215540BatchImporter'),
    ('Assets/ColourPass6_VS215537_PS215538_Batch', 'Assets/ColourPass6_VS215539_PS215540_Batch'),
    ('VS215537_PS215538_BatchManifest.json', 'VS215539_PS215540_BatchManifest.json'),
    ('Shaders/EID215537215538GBuffer.shader', 'Shaders/EID215539215540GBuffer.shader'),
    ('Validation/ColourPass6_VS215537', 'Validation/ColourPass6_VS215539'),
    ('ColourPass6_VS215537_PS215538', 'ColourPass6_VS215539_PS215540'),
    ('static readonly int[] ExpectedEIDs = { 3617, 3621 };', 'static readonly int[] ExpectedEIDs = { 3669, 3674 };'),
    ('static readonly int ExpectedInstances = 4;', 'static readonly int ExpectedInstances = 2;'),
    ('static readonly int ExpectedLayoutVariants = 1;', 'static readonly int ExpectedLayoutVariants = 2;'),
    ('[MenuItem("Tools/Colour Pass 6/Import EID 41.1-41.2 (VS215537 PS215538)")]', '[MenuItem("Tools/Colour Pass 6/Import EID 42.1-42.2 (VS215539 PS215540)")]'),
    ('profiles for 41.1-41.2.', 'profiles for 42.1-42.2.'),
    ('Expected EIDs 41.1-41.2, got "', 'Expected EIDs 42.1-42.2, got "'),
    ('VS215537/PS215538 shader has compile errors', 'VS215539/PS215540 shader has compile errors'),
    ('EID215537DrawProfile', 'EID215539DrawProfile'),
    ('if (p.vs != 215537 || p.ps != 215538)', 'if (p.vs != 215539 || p.ps != 215540)'),
    ('VS215537 Complete VSInput', 'VS215539 Complete VSInput'),
    ('Materials/EID" + p.eid + "_VS215537_PS215538.mat', 'Materials/EID" + p.eid + "_VS215539_PS215540.mat'),
    ('m.name = "EID" + p.eid + " VS215537 PS215538"', 'm.name = "EID" + p.eid + " VS215539 PS215540"'),
    ('"41.1-41.2 instance total expected "', '"42.1-42.2 instance total expected "'),
    ('EID/URP/VS215537_PS215538_GBuffer', 'EID/URP/VS215539_PS215540_GBuffer'),
    ('[ColourPass6] VS215537/PS215538 import completed', '[ColourPass6] VS215539/PS215540 import completed'),
    (
        '# VS215537 / PS215538 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `41.1-41.2`\\n- Layout variants: `" + layouts + "` (`a554ffdeec97df50`)\\n- Shader: live Unity VP; unique res33/res35; PS uniforms38 512B; Cull Off; ZWrite Off; ZTest Equal; stencil 0; skip skin (flags 0); scan/rim in RT0; isolate from family 17\\n\\n"',
        '# VS215539 / PS215540 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `42.1-42.2`\\n- Layout variants: `" + layouts + "` (`254e776650e421f4`, `f99e10ea87e933cd`)\\n- Shader: live Unity VP; unique res27/res29/res31; PS uniforms33 448B; Cull Off; ZWrite Off; ZTest Equal; stencil 0; skip skin (flags 0); extra map + distance fade; isolate from family 65\\n\\n"',
    ),
]

for a, b in global_pairs:
    n = text.count(a)
    if n == 0:
        missing.append((0, a[:180]))
    else:
        text = text.replace(a, b)

os.makedirs(os.path.dirname(dst), exist_ok=True)
open(dst, 'w', encoding='utf8', newline='\n').write(text)
print('wrote', dst, os.path.getsize(dst))
print('missing', missing)
leftover = []
for needle in ['215537', '215538', 'res33', 'res35', 'uniforms38', 'uniforms29', 'uniforms25', 'uniforms22', 'uniforms40', '41.1', '41.2', '3617', '3621', '_input6', '_ScanGlobals', '_P31', 'COMPLETE_9']:
    if needle in text:
        leftover.append((needle, text.count(needle)))
print('leftover', leftover)
print('uniforms27', text.count('uniforms27'))
print('uniforms23', text.count('uniforms23'))
print('uniforms33', text.count('uniforms33'))
print('uniforms20', text.count('uniforms20'))
print('uniforms35', text.count('uniforms35'))
print('res27', text.count('res27'))
print('res29', text.count('res29'))
print('res31', text.count('res31'))
print('0.0020', text.count('0.0020'))
