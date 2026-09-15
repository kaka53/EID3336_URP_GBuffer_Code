from pathlib import Path

ROOT = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace')
src_imp = ROOT / 'Assets/ColourPass6_VS215545_PS215546_Batch/Editor/ColourPass6VS215545PS215546BatchImporter.cs'
src_exp = ROOT / '.rdctools/export_215545_215546_batch.py'
dst_imp = ROOT / 'Assets/ColourPass6_VS230642_PS230643_Batch/Editor/ColourPass6VS230642PS230643BatchImporter.cs'
dst_exp = ROOT / '.rdctools/export_230642_230643_batch.py'

imp = src_imp.read_text(encoding='utf-8')

# Longest / unique fragments first so short replacements cannot steal them.
imp_repls = [
    (
        'byte[] overlay = ReadCB(p, "PS", "uniforms23");\n        int o = instance * 256;\n        m.SetVector("_InstanceStateYZ", new Vector4(ReadFloat(overlay, o + 68), ReadFloat(overlay, o + 72), 0, 0));',
        'byte[] overlay = ReadCB(p, "PS", "uniforms20");\n        int o = instance * 256;\n        m.SetVector("_InstanceStateYZ", new Vector4(ReadFloat(overlay, o + 68), ReadFloat(overlay, o + 72), 0, 0));\n        m.SetVector("_InstanceChild5", ReadVector4(overlay, o + 176));\n        m.SetVector("_InstanceChild6", ReadVector4(overlay, o + 192));\n        m.SetVector("_InstanceChild8", ReadVector4(overlay, o + 224));\n        m.SetVector("_VATRowZW", new Vector4(ReadFloat(overlay, o + 248), ReadFloat(overlay, o + 252), 0, 0));',
    ),
    (
        'byte[] meta = ReadCB(p, "PS", "uniforms38");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));\n        ApplyInstanceOverlay(m, p, 0);\n        byte[] globals = ReadCB(p, "PS", "uniforms20");\n        m.SetFloat("_EID215546MipBias", ReadFloat(globals, 416));',
        'ApplyInstanceOverlay(m, p, 0);\n        byte[] globals = ReadCB(p, "PS", "uniforms17");\n        m.SetFloat("_EID230643MipBias", ReadFloat(globals, 416));\n        m.SetFloat("_EID230643GlobalY", ReadFloat(globals, 436));',
    ),
    (
        'Texture albedo = LoadTexture(p, "res31");\n        Texture normalTex = LoadTexture(p, "res33");\n        if (albedo == null || normalTex == null)\n            throw new FileNotFoundException("EID" + p.eid + " res31/res33 texture binding is incomplete.");\n        m.SetTexture("_Res31", albedo);\n        m.SetTexture("_Res33", normalTex);',
        'Texture albedo = LoadTexture(p, "res23");\n        Texture nrm = LoadTexture(p, "res25");\n        Texture packed = LoadTexture(p, "res27");\n        Texture overlayTex = LoadTexture(p, "res29");\n        Texture vat = LoadTexture(p, "res30");\n        if (albedo == null || nrm == null || packed == null || overlayTex == null || vat == null)\n            throw new FileNotFoundException("EID" + p.eid + " res23/res25/res27/res29/res30 texture binding is incomplete.");\n        m.SetTexture("_Res23", albedo);\n        m.SetTexture("_Res25", nrm);\n        m.SetTexture("_Res27", packed);\n        m.SetTexture("_Res29", overlayTex);\n        m.SetTexture("_Res30", vat);',
    ),
    (
        'if (Rid(p, "res31") == 0 || Rid(p, "res33") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res31/res33.");',
        'if (Rid(p, "res23") == 0 || Rid(p, "res25") == 0 || Rid(p, "res27") == 0 || Rid(p, "res29") == 0 || Rid(p, "res30") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res23/res25/res27/res29/res30.");',
    ),
    (
        'byte[] local = ReadCB(p, "PS", "uniforms36");\n        if (local.Length < 416) throw new InvalidDataException("EID" + p.eid + " PS uniforms36 expected 416 bytes, got " + local.Length);',
        'byte[] local = ReadCB(p, "PS", "uniforms32");\n        if (local.Length < 304) throw new InvalidDataException("EID" + p.eid + " PS uniforms32 expected 304 bytes, got " + local.Length);',
    ),
    (
        'report.AppendLine("EID" + p.eid + ": material res31=RID" + Rid(p, "res31") + " res33=RID" + Rid(p, "res33") + " PS uniforms36=" + local.Length + "B");',
        'report.AppendLine("EID" + p.eid + ": material res23=RID" + Rid(p, "res23") + " res25=RID" + Rid(p, "res25") + " res27=RID" + Rid(p, "res27") + " res29=RID" + Rid(p, "res29") + " res30=RID" + Rid(p, "res30") + " PS uniforms32=" + local.Length + "B");',
    ),
    (
        'string[] required = { "_input0", "_input1", "_input2", "_input3", "_input4", "_input5", "_input6", "_input7", "_input8" };',
        'string[] required = { "_input0", "_input1", "_input2", "_input3", "_input4", "_input5", "_input7", "_input8" };',
    ),
    (
        '- Shader: live Unity VP; unique res31/res33; PS uniforms36 416B; Cull Off; ZWrite Off; stencil 0; skip skin (flags 0); VT omitted',
        '- Shader: live Unity VP; unique res23/25/27/29 + VAT res30; PS uniforms32 304B; Cull Back; ZWrite On; stencil 32; skip skin (flags 0); VAT sampled in VS',
    ),
    ('ColourPass6VS215545PS215546BatchImporter', 'ColourPass6VS230642PS230643BatchImporter'),
    ('Assets/ColourPass6_VS215545_PS215546_Batch', 'Assets/ColourPass6_VS230642_PS230643_Batch'),
    ('VS215545_PS215546_BatchManifest.json', 'VS230642_PS230643_BatchManifest.json'),
    ('EID215545215546GBuffer.shader', 'EID230642230643GBuffer.shader'),
    ('Validation/ColourPass6_VS215545/', 'Validation/ColourPass6_VS230642/'),
    ('Validation/ColourPass6_VS215545"', 'Validation/ColourPass6_VS230642"'),
    ('ColourPass6_VS215545_PS215546', 'ColourPass6_VS230642_PS230643'),
    ('static readonly int[] ExpectedEIDs = { 3704, 3708, 3712, 3716, 3720, 3724 };',
     'static readonly int[] ExpectedEIDs = { 2558, 2562, 2566, 2570, 2574, 2578 };'),
    ('static readonly int ExpectedInstances = 14;', 'static readonly int ExpectedInstances = 15;'),
    ('Import EID 18.1-18.6 (VS215545 PS215546)', 'Import EID 19.1-19.6 (VS230642 PS230643)'),
    ('18.1-18.6', '19.1-19.6'),
    ('EID215545DrawProfile', 'EID230642DrawProfile'),
    ('if (p.vs != 215545 || p.ps != 215546)', 'if (p.vs != 230642 || p.ps != 230643)'),
    ('if (p.layout == null || p.layout.Length != 9)', 'if (p.layout == null || p.layout.Length != 8)'),
    ('byte[] inst = ReadCB(p, "VS", "uniforms28");', 'byte[] inst = ReadCB(p, "VS", "uniforms27");'),
    ('byte[] overlay = ReadCB(p, "PS", "uniforms23");', 'byte[] overlay = ReadCB(p, "PS", "uniforms20");'),
    ('EID" + p.eid + " VS uniforms28 too small', 'EID" + p.eid + " VS uniforms27 too small'),
    ('EID" + p.eid + " PS uniforms23 too small', 'EID" + p.eid + " PS uniforms20 too small'),
    ('string path = Root + "/Materials/EID" + p.eid + "_VS215545_PS215546.mat";',
     'string path = Root + "/Materials/EID" + p.eid + "_VS230642_PS230643.mat";'),
    ('m.name = "EID" + p.eid + " VS215545 PS215546";', 'm.name = "EID" + p.eid + " VS230642 PS230643";'),
    ('for (int i = 0; i < 26; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));',
     'for (int i = 0; i < 19; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));'),
    ('g.material.shader.name != "EID/URP/VS215545_PS215546_GBuffer"',
     'g.material.shader.name != "EID/URP/VS230642_PS230643_GBuffer"'),
    ('byte[] cb = ReadCB(p, "VS", "uniforms28");', 'byte[] cb = ReadCB(p, "VS", "uniforms27");'),
    ('byte[] b = ReadCB(p, "VS", "uniforms28");', 'byte[] b = ReadCB(p, "VS", "uniforms27");'),
    ('ssbo30 file is missing', 'ssbo35 file is missing'),
    ('byte[] instanceCB = ReadCB(p, "VS", "uniforms28");', 'byte[] instanceCB = ReadCB(p, "VS", "uniforms27");'),
    ('byte[] local = ReadCB(p, "PS", "uniforms36");', 'byte[] local = ReadCB(p, "PS", "uniforms32");'),
    ('VS215545 Complete VSInput', 'VS230642 Complete VSInput'),
    ('vertexAttributes=COMPLETE_9_OF_9', 'vertexAttributes=COMPLETE_8_OF_8'),
    ('VS215545/PS215546', 'VS230642/PS230643'),
    ('VS215545 / PS215546', 'VS230642 / PS230643'),
]

for a, b in imp_repls:
    if a not in imp:
        raise SystemExit('importer missing fragment:\n' + repr(a[:220]))
    imp = imp.replace(a, b)

old_mesh_body = '''        byte[] stream0 = new byte[count * 24];
        byte[] stream1 = new byte[count * 24];
        byte[] stream2 = new byte[count * 16];
        byte[] stream3 = new byte[count * 28];
        bool bakeSkin = HasCapturedSkinning(p);
        byte[] skin = null;
        if (bakeSkin)
        {
            if (p.readWriteResources == null || p.readWriteResources.VS == null || p.readWriteResources.VS.Length == 0 || p.readWriteResources.VS[0].file == null || string.IsNullOrEmpty(p.readWriteResources.VS[0].file.file))
                throw new FileNotFoundException("EID" + p.eid + " captured skin flag is set but ssbo35 file is missing.");
            skin = ReadFile(p.readWriteResources.VS[0].file.file);
        }
        byte[] instanceCB = ReadCB(p, "VS", "uniforms27");

        for (int v = 0; v < count; ++v)
        {
            byte[] pos = ReadInput(p, "_input0", v, 12);
            byte[] packed = ReadInput(p, "_input1", v, 4);
            Buffer.BlockCopy(pos, 0, stream0, v * 24, 12);
            Buffer.BlockCopy(packed, 0, stream0, v * 24 + 12, 4);
            CopyInput(p, "_input4", v, stream1, v * 24 + 0, 8);
            CopyInput(p, "_input5", v, stream1, v * 24 + 8, 8);
            CopyInput(p, "_input6", v, stream1, v * 24 + 16, 8);
            CopyInput(p, "_input2", v, stream2, v * 16 + 0, 4);
            CopyInput(p, "_input3", v, stream2, v * 16 + 4, 4);
            Vector4 weights = ReadWeights(p, v);
            WriteUNorm8(stream2, v * 16 + 8, weights);
            CopyInput(p, "_input8", v, stream2, v * 16 + 12, 4);
'''
new_mesh_body = '''        byte[] stream0 = new byte[count * 24];
        byte[] stream1 = new byte[count * 32];
        byte[] stream2 = new byte[count * 16];
        byte[] stream3 = new byte[count * 28];
        bool bakeSkin = HasCapturedSkinning(p);
        byte[] skin = null;
        if (bakeSkin)
        {
            if (p.readWriteResources == null || p.readWriteResources.VS == null || p.readWriteResources.VS.Length == 0 || p.readWriteResources.VS[0].file == null || string.IsNullOrEmpty(p.readWriteResources.VS[0].file.file))
                throw new FileNotFoundException("EID" + p.eid + " captured skin flag is set but ssbo35 file is missing.");
            skin = ReadFile(p.readWriteResources.VS[0].file.file);
        }
        byte[] instanceCB = ReadCB(p, "VS", "uniforms27");

        for (int v = 0; v < count; ++v)
        {
            byte[] pos = ReadInput(p, "_input0", v, 12);
            byte[] packed = ReadInput(p, "_input1", v, 4);
            Buffer.BlockCopy(pos, 0, stream0, v * 24, 12);
            Buffer.BlockCopy(packed, 0, stream0, v * 24 + 12, 4);
            CopyInput(p, "_input3", v, stream1, v * 32 + 0, 16);
            CopyInput(p, "_input4", v, stream1, v * 32 + 16, 16);
            CopyInput(p, "_input2", v, stream2, v * 16 + 0, 4);
            CopyInput(p, "_input5", v, stream2, v * 16 + 4, 4);
            Vector4 weights = ReadWeights(p, v);
            WriteUNorm8(stream2, v * 16 + 8, weights);
            CopyInput(p, "_input8", v, stream2, v * 16 + 12, 4);
'''
if old_mesh_body not in imp:
    raise SystemExit('missing CreateMesh stream body')
imp = imp.replace(old_mesh_body, new_mesh_body)

old_desc = '''            new VertexAttributeDescriptor(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.Tangent, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord1, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord2, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord3, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.BlendIndices, VertexAttributeFormat.UInt8, 4, 2),
'''
new_desc = '''            new VertexAttributeDescriptor(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 4, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord1, VertexAttributeFormat.Float32, 4, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord2, VertexAttributeFormat.SNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord3, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.BlendIndices, VertexAttributeFormat.UInt8, 4, 2),
'''
if old_desc not in imp:
    raise SystemExit('missing vertex desc')
imp = imp.replace(old_desc, new_desc)

old_audit = '''        audit.AppendLine("- Unity native streams: `Position Float32x3 + Normal Float32x3 packed _input1 in .x`, `UV0/1/2 Float32x2`, `input2/input3/input7 UNorm8x4`, `input8 UInt8x4`, `TEXCOORD4/5 baked skinned n/t`");
'''
new_audit = '''        audit.AppendLine("- Unity native streams: `Position Float32x3 + Normal Float32x3 packed _input1 in .x`, `input3/input4 Float32x4`, `input5 SNorm8x4`, `input2/input7 UNorm8x4`, `input8 UInt8x4`, `TEXCOORD4/5 baked n/t`");
'''
if old_audit not in imp:
    raise SystemExit('missing audit line')
imp = imp.replace(old_audit, new_audit)

left = [ln for ln in imp.splitlines() if any(x in ln for x in ('215545', '215546', 'uniforms36', 'res31', 'res33', '_input6', 'uniforms28', 'uniforms23', 'ssbo30', '18.1', '3704'))]
dst_imp.parent.mkdir(parents=True, exist_ok=True)
dst_imp.write_text(imp, encoding='utf-8')
print('importer', dst_imp.stat().st_size, 'leftover', len(left))
for ln in left:
    print(' leftover:', ln)

exp = src_exp.read_text(encoding='utf-8')
exp_repls = [
    ('''MESH_ITEM = {
    3704: '18.1',
    3708: '18.2',
    3712: '18.3',
    3716: '18.4',
    3720: '18.5',
    3724: '18.6',
}
EIDS = [3704, 3708, 3712, 3716, 3720, 3724]
FAMILY = 'VS215545_PS215546'
EXPECTED = (215545, 215546)
ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215545_PS215546_Batch'
''',
     '''MESH_ITEM = {
    2558: '19.1',
    2562: '19.2',
    2566: '19.3',
    2570: '19.4',
    2574: '19.5',
    2578: '19.6',
}
EIDS = [2558, 2562, 2566, 2570, 2574, 2578]
FAMILY = 'VS230642_PS230643'
EXPECTED = (230642, 230643)
ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS230642_PS230643_Batch'
'''),
    ("UNIQUE_MATERIAL = {'res31', 'res33'}", "UNIQUE_MATERIAL = {'res23', 'res25', 'res27', 'res29', 'res30'}"),
    ("EXPECTED_INPUTS = ['_input%d' % i for i in range(9)]",
     "EXPECTED_INPUTS = ['_input0', '_input1', '_input2', '_input3', '_input4', '_input5', '_input7', '_input8']"),
    ("raise RuntimeError('EID%d expected 9 VS inputs _input0.._input8, got %s' % (eid, names))",
     "raise RuntimeError('EID%d expected 8 VS inputs without _input6, got %s' % (eid, names))"),
    ("if key == 'VS' and name == 'uniforms28':", "if key == 'VS' and name == 'uniforms27':"),
    ("for stage, key in [(rd.ShaderStage.Vertex, 'VS215545'), (rd.ShaderStage.Pixel, 'PS215546')]:",
     "for stage, key in [(rd.ShaderStage.Vertex, 'VS230642'), (rd.ShaderStage.Pixel, 'PS230643')]:"),
    ("open(os.path.join(ROOT, 'VS215545_PS215546_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))",
     "open(os.path.join(ROOT, 'VS230642_PS230643_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))"),
    ("result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215545_215546_batch_result.json'",
     "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_230642_230643_batch_result.json'"),
    ('''            'psUniqueSlots': sorted(UNIQUE_MATERIAL),
            'psSharedAlbedo': sorted(SHARED_REQUIRED),
            'instanceBuffer': 'VS uniforms28 / PS uniforms23 stride 256',
            'localMaterialCB': 'PS uniforms36 416B',
            'materialIdCB': 'PS uniforms38 16B child3',
            'mipBias': 'PS uniforms20 child16 @416',
            'skinning': 'flags bit32 all zero; ssbo30 not baked',
''',
     '''            'psUniqueSlots': sorted(UNIQUE_MATERIAL),
            'psSharedAlbedo': sorted(SHARED_REQUIRED),
            'instanceBuffer': 'VS uniforms27 / PS uniforms20 stride 256',
            'localMaterialCB': 'PS uniforms32 304B',
            'mipBias': 'PS uniforms17 child16 @416',
            'globalY': 'PS uniforms17 child20.y @436',
            'vat': 'VS res30 Binding1 R16G16B16A16_FLOAT',
            'skinning': 'flags bit32 all zero; ssbo35 not baked',
'''),
]
for a, b in exp_repls:
    if a not in exp:
        raise SystemExit('export missing fragment:\n' + repr(a[:240]))
    exp = exp.replace(a, b)

vs_tex_old = '''            z['bindings'].append(name)

        rws = {'VS': []}
        reflvs = s.GetShaderReflection(rd.ShaderStage.Vertex)
'''
vs_tex_new = '''            z['bindings'].append(name)

        reflvs_ro = s.GetShaderReflection(rd.ShaderStage.Vertex)
        rrvs = list(reflvs_ro.readOnlyResources)
        for i, u in enumerate(s.GetReadOnlyResources(rd.ShaderStage.Vertex)):
            d = u.descriptor
            r = rid(d.resource)
            if r == 0:
                continue
            name = rrvs[i].name if i < len(rrvs) else 'vstex%d' % i
            td = texdesc.get(r)
            tr = {
                'index': 1000 + i,
                'name': name,
                'binding': int(u.access.byteOffset),
                'rid': r,
                'format': td.format.Name() if td else '',
                'width': int(td.width) if td else 0,
                'height': int(td.height) if td else 0,
                'mips': int(td.mips) if td else 0,
                'arraySize': int(td.arraysize) if td else 0,
                'uniqueMaterial': name in UNIQUE_MATERIAL,
            }
            textures.append(tr)
            z = texture_refs.setdefault(r, dict(tr, eids=[], bindings=[]))
            z['eids'].append(eid)
            z['bindings'].append(name)

        rws = {'VS': []}
        reflvs = s.GetShaderReflection(rd.ShaderStage.Vertex)
'''
if vs_tex_old not in exp:
    raise SystemExit('export missing VS texture insertion point')
exp = exp.replace(vs_tex_old, vs_tex_new)

left_exp = [ln for ln in exp.splitlines() if any(x in ln for x in ('215545', '215546', 'uniforms36', 'res31', 'res33', '3704', '18.1', 'uniforms28'))]
dst_exp.write_text(exp, encoding='utf-8')
print('export', dst_exp.stat().st_size, 'leftover', len(left_exp))
for ln in left_exp:
    print(' leftover:', ln)
