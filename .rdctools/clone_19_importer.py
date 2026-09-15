from pathlib import Path
src = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215545_PS215546_Batch/Editor/ColourPass6VS215545PS215546BatchImporter.cs')
text = src.read_text(encoding='utf-8')
repls = [
    ('ColourPass6VS215545PS215546BatchImporter', 'ColourPass6VS230642PS230643BatchImporter'),
    ('Assets/ColourPass6_VS215545_PS215546_Batch', 'Assets/ColourPass6_VS230642_PS230643_Batch'),
    ('VS215545_PS215546_BatchManifest.json', 'VS230642_PS230643_BatchManifest.json'),
    ('EID215545215546GBuffer.shader', 'EID230642230643GBuffer.shader'),
    ('Validation/ColourPass6_VS215545/', 'Validation/ColourPass6_VS230642/'),
    ('ColourPass6_VS215545_PS215546', 'ColourPass6_VS230642_PS230643'),
    ('static readonly int[] ExpectedEIDs = { 3704, 3708, 3712, 3716, 3720, 3724 };',
     'static readonly int[] ExpectedEIDs = { 2558, 2562, 2566, 2570, 2574, 2578 };'),
    ('static readonly int ExpectedInstances = 14;', 'static readonly int ExpectedInstances = 15;'),
    ('Import EID 18.1-18.6 (VS215545 PS215546)', 'Import EID 19.1-19.6 (VS230642 PS230643)'),
    ('18.1-18.6', '19.1-19.6'),
    ('EID215545DrawProfile', 'EID230642DrawProfile'),
    ('if (p.vs != 215545 || p.ps != 215546)', 'if (p.vs != 230642 || p.ps != 230643)'),
    ('if (p.layout == null || p.layout.Length != 9)', 'if (p.layout == null || p.layout.Length != 8)'),
    ('string[] required = { "_input0", "_input1", "_input2", "_input3", "_input4", "_input5", "_input6", "_input7", "_input8" };',
     'string[] required = { "_input0", "_input1", "_input2", "_input3", "_input4", "_input5", "_input7", "_input8" };'),
    ('if (Rid(p, "res31") == 0 || Rid(p, "res33") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res31/res33.");',
     'if (Rid(p, "res23") == 0 || Rid(p, "res25") == 0 || Rid(p, "res27") == 0 || Rid(p, "res29") == 0 || Rid(p, "res30") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res23/res25/res27/res29/res30.");'),
    ('byte[] local = ReadCB(p, "PS", "uniforms36");\n        if (local.Length < 416) throw new InvalidDataException("EID" + p.eid + " PS uniforms36 expected 416 bytes, got " + local.Length);',
     'byte[] local = ReadCB(p, "PS", "uniforms32");\n        if (local.Length < 304) throw new InvalidDataException("EID" + p.eid + " PS uniforms32 expected 304 bytes, got " + local.Length);'),
    ('byte[] inst = ReadCB(p, "VS", "uniforms28");', 'byte[] inst = ReadCB(p, "VS", "uniforms27");'),
    ('byte[] overlay = ReadCB(p, "PS", "uniforms23");', 'byte[] overlay = ReadCB(p, "PS", "uniforms20");'),
    ('EID" + p.eid + " VS uniforms28 too small', 'EID" + p.eid + " VS uniforms27 too small'),
    ('EID" + p.eid + " PS uniforms23 too small', 'EID" + p.eid + " PS uniforms20 too small'),
    ('string path = Root + "/Materials/EID" + p.eid + "_VS215545_PS215546.mat";',
     'string path = Root + "/Materials/EID" + p.eid + "_VS230642_PS230643.mat";'),
    ('m.name = "EID" + p.eid + " VS215545 PS215546";', 'm.name = "EID" + p.eid + " VS230642 PS230643";'),
    ('for (int i = 0; i < 26; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));',
     'for (int i = 0; i < 19; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));'),
    ('byte[] meta = ReadCB(p, "PS", "uniforms38");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));\n        ApplyInstanceOverlay(m, p, 0);\n        byte[] globals = ReadCB(p, "PS", "uniforms20");\n        m.SetFloat("_EID215546MipBias", ReadFloat(globals, 416));',
     'ApplyInstanceOverlay(m, p, 0);\n        byte[] globals = ReadCB(p, "PS", "uniforms17");\n        m.SetFloat("_EID230643MipBias", ReadFloat(globals, 416));\n        m.SetFloat("_EID230643GlobalY", ReadFloat(globals, 436));'),
    ('Texture albedo = LoadTexture(p, "res31");\n        Texture normalTex = LoadTexture(p, "res33");\n        if (albedo == null || normalTex == null)\n            throw new FileNotFoundException("EID" + p.eid + " res31/res33 texture binding is incomplete.");\n        m.SetTexture("_Res31", albedo);\n        m.SetTexture("_Res33", normalTex);',
     'Texture albedo = LoadTexture(p, "res23");\n        Texture nrm = LoadTexture(p, "res25");\n        Texture packed = LoadTexture(p, "res27");\n        Texture overlayTex = LoadTexture(p, "res29");\n        Texture vat = LoadTexture(p, "res30");\n        if (albedo == null || nrm == null || packed == null || overlayTex == null || vat == null)\n            throw new FileNotFoundException("EID" + p.eid + " res23/res25/res27/res29/res30 texture binding is incomplete.");\n        m.SetTexture("_Res23", albedo);\n        m.SetTexture("_Res25", nrm);\n        m.SetTexture("_Res27", packed);\n        m.SetTexture("_Res29", overlayTex);\n        m.SetTexture("_Res30", vat);'),
    ('report.AppendLine("EID" + p.eid + ": material res31=RID" + Rid(p, "res31") + " res33=RID" + Rid(p, "res33") + " PS uniforms36=" + local.Length + "B");',
     'report.AppendLine("EID" + p.eid + ": material res23=RID" + Rid(p, "res23") + " res25=RID" + Rid(p, "res25") + " res27=RID" + Rid(p, "res27") + " res29=RID" + Rid(p, "res29") + " res30=RID" + Rid(p, "res30") + " PS uniforms32=" + local.Length + "B");'),
    ('g.material.shader.name != "EID/URP/VS215545_PS215546_GBuffer"',
     'g.material.shader.name != "EID/URP/VS230642_PS230643_GBuffer"'),
    ('- Shader: live Unity VP; unique res31/res33; PS uniforms36 416B; Cull Off; ZWrite Off; stencil 0; skip skin (flags 0); VT omitted',
     '- Shader: live Unity VP; unique res23/25/27/29 + VAT res30; PS uniforms32 304B; Cull Back; ZWrite On; stencil 32; skip skin (flags 0); VAT sampled in VS'),
    ('byte[] cb = ReadCB(p, "VS", "uniforms28");', 'byte[] cb = ReadCB(p, "VS", "uniforms27");'),
    ('byte[] overlay = ReadCB(p, "PS", "uniforms23");\n        int o = instance * 256;\n        m.SetVector("_InstanceStateYZ", new Vector4(ReadFloat(overlay, o + 68), ReadFloat(overlay, o + 72), 0, 0));',
     'byte[] overlay = ReadCB(p, "PS", "uniforms20");\n        int o = instance * 256;\n        m.SetVector("_InstanceStateYZ", new Vector4(ReadFloat(overlay, o + 68), ReadFloat(overlay, o + 72), 0, 0));\n        m.SetVector("_InstanceChild5", ReadVector4(overlay, o + 80));\n        m.SetVector("_InstanceChild6", ReadVector4(overlay, o + 96));\n        m.SetVector("_InstanceChild8", ReadVector4(overlay, o + 128));\n        m.SetVector("_VATRowZW", new Vector4(ReadFloat(overlay, o + 248), ReadFloat(overlay, o + 252), 0, 0));'),
    ('byte[] b = ReadCB(p, "VS", "uniforms28");', 'byte[] b = ReadCB(p, "VS", "uniforms27");'),
    ('ssbo30 file is missing', 'ssbo35 file is missing'),
]
for a, b in repls:
    if a not in text:
        raise SystemExit('missing fragment:\n' + repr(a[:160]))
    text = text.replace(a, b)

# CreateMesh still copies _input6. Patch the mesh builder for 8-input / SNORM input5 / no _input6.
old_mesh = '''        byte[] stream0 = new byte[count * 24];
        byte[] stream1 = new byte[count * 24];
        byte[] stream2 = new byte[count * 16];
        byte[] stream3 = new byte[count * 28];
'''
new_mesh = '''        byte[] stream0 = new byte[count * 24];
        byte[] stream1 = new byte[count * 32];
        byte[] stream2 = new byte[count * 16];
        byte[] stream3 = new byte[count * 28];
'''
if old_mesh not in text:
    raise SystemExit('missing mesh stream alloc')
text = text.replace(old_mesh, new_mesh)

old_copy = '''            CopyInput(p, "_input4", v, stream1, v * 24 + 0, 8);
            CopyInput(p, "_input5", v, stream1, v * 24 + 8, 8);
            CopyInput(p, "_input6", v, stream1, v * 24 + 16, 8);
            CopyInput(p, "_input2", v, stream2, v * 16 + 0, 4);
            CopyInput(p, "_input3", v, stream2, v * 16 + 4, 4);
'''
new_copy = '''            CopyInput(p, "_input3", v, stream1, v * 32 + 0, 16);
            CopyInput(p, "_input4", v, stream1, v * 32 + 16, 16);
            WriteVector4(stream2, v * 16 + 0, DecodeSNorm4(ReadInput(p, "_input5", v, 4)));
            CopyInput(p, "_input2", v, stream2, v * 16 + 4, 4);
'''
if old_copy not in text:
    raise SystemExit('missing mesh copy')
text = text.replace(old_copy, new_copy)

old_desc = '''            new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord1, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord2, VertexAttributeFormat.Float32, 2, 1),
'''
new_desc = '''            new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 4, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord1, VertexAttributeFormat.Float32, 4, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord2, VertexAttributeFormat.Float32, 4, 2),
'''
if old_desc not in text:
    raise SystemExit('missing vertex desc')
text = text.replace(old_desc, new_desc)

old_audit = '''        audit.AppendLine("- Unity native streams: `Position Float32x3 + Normal Float32x3 packed _input1 in .x`, `UV0/1/2 Float32x2`, `input2/input3/input7 UNorm8x4`, `input8 UInt8x4`, `TEXCOORD4/5 baked skinned n/t`");
'''
new_audit = '''        audit.AppendLine("- Unity native streams: `Position Float32x3 + Normal Float32x3 packed _input1 in .x`, `input3/input4 Float32x4`, `input5 SNorm8 expanded to Float32x4`, `input2/input7 UNorm8x4`, `input8 UInt8x4`, `TEXCOORD4/5 baked skinned n/t`");
'''
if old_audit not in text:
    raise SystemExit('missing audit line')
text = text.replace(old_audit, new_audit)

old_complete = 'vertexAttributes=COMPLETE_9_OF_9'
new_complete = 'vertexAttributes=COMPLETE_8_OF_8'
if old_complete not in text:
    raise SystemExit('missing complete line')
text = text.replace(old_complete, new_complete)

helper = '''    static Vector4 DecodeUNorm4(byte[] b) => new Vector4(b[0] / 255f, b[1] / 255f, b[2] / 255f, b[3] / 255f);
'''
helper_new = '''    static Vector4 DecodeUNorm4(byte[] b) => new Vector4(b[0] / 255f, b[1] / 255f, b[2] / 255f, b[3] / 255f);
    static float DecodeSNorm8(byte b) { int x = b >= 128 ? b - 256 : b; return x == -128 ? -1f : x / 127f; }
    static Vector4 DecodeSNorm4(byte[] b) => new Vector4(DecodeSNorm8(b[0]), DecodeSNorm8(b[1]), DecodeSNorm8(b[2]), DecodeSNorm8(b[3]));
'''
if helper not in text:
    raise SystemExit('missing DecodeUNorm4')
text = text.replace(helper, helper_new)

# stream1 size in SetVertexBufferData is derived from array length already.
dst = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS230642_PS230643_Batch/Editor/ColourPass6VS230642PS230643BatchImporter.cs')
dst.write_text(text, encoding='utf-8')
print('wrote importer', dst.stat().st_size)
left = [ln for ln in text.splitlines() if '215545' in ln or '215546' in ln or 'uniforms36' in ln or 'res31' in ln or 'res33' in ln or '_input6' in ln]
print('leftover', len(left))
for ln in left:
    print(ln)
