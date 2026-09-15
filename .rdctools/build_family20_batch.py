from pathlib import Path

ROOT = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace')
src_imp = ROOT / 'Assets/ColourPass6_VS230642_PS230643_Batch/Editor/ColourPass6VS230642PS230643BatchImporter.cs'
src_exp = ROOT / '.rdctools/export_230642_230643_batch.py'
dst_imp = ROOT / 'Assets/ColourPass6_VS230646_PS230647_Batch/Editor/ColourPass6VS230646PS230647BatchImporter.cs'
dst_exp = ROOT / '.rdctools/export_230646_230647_batch.py'

imp = src_imp.read_text(encoding='utf-8')

imp_repls = [
    (
        'm.SetVector("_InstanceChild8", ReadVector4(overlay, o + 224));\n        m.SetVector("_VATRowZW", new Vector4(ReadFloat(overlay, o + 248), ReadFloat(overlay, o + 252), 0, 0));',
        'm.SetVector("_InstanceChild8", ReadVector4(overlay, o + 224));',
    ),
    (
        'Texture albedo = LoadTexture(p, "res23");\n        Texture nrm = LoadTexture(p, "res25");\n        Texture packed = LoadTexture(p, "res27");\n        Texture overlayTex = LoadTexture(p, "res29");\n        Texture vat = LoadTexture(p, "res30");\n        if (albedo == null || nrm == null || packed == null || overlayTex == null || vat == null)\n            throw new FileNotFoundException("EID" + p.eid + " res23/res25/res27/res29/res30 texture binding is incomplete.");\n        m.SetTexture("_Res23", albedo);\n        m.SetTexture("_Res25", nrm);\n        m.SetTexture("_Res27", packed);\n        m.SetTexture("_Res29", overlayTex);\n        m.SetTexture("_Res30", vat);',
        'Texture albedo = LoadTexture(p, "res23");\n        Texture nrm = LoadTexture(p, "res25");\n        Texture packed = LoadTexture(p, "res27");\n        Texture overlayTex = LoadTexture(p, "res29");\n        Texture layer = LoadTexture(p, "res31");\n        if (albedo == null || nrm == null || packed == null || overlayTex == null || layer == null)\n            throw new FileNotFoundException("EID" + p.eid + " res23/res25/res27/res29/res31 texture binding is incomplete.");\n        m.SetTexture("_Res23", albedo);\n        m.SetTexture("_Res25", nrm);\n        m.SetTexture("_Res27", packed);\n        m.SetTexture("_Res29", overlayTex);\n        m.SetTexture("_Res31", layer);',
    ),
    (
        'if (Rid(p, "res23") == 0 || Rid(p, "res25") == 0 || Rid(p, "res27") == 0 || Rid(p, "res29") == 0 || Rid(p, "res30") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res23/res25/res27/res29/res30.");',
        'if (Rid(p, "res23") == 0 || Rid(p, "res25") == 0 || Rid(p, "res27") == 0 || Rid(p, "res29") == 0 || Rid(p, "res31") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res23/res25/res27/res29/res31.");',
    ),
    (
        'byte[] local = ReadCB(p, "PS", "uniforms32");\n        if (local.Length < 304) throw new InvalidDataException("EID" + p.eid + " PS uniforms32 expected 304 bytes, got " + local.Length);',
        'byte[] local = ReadCB(p, "PS", "uniforms34");\n        if (local.Length < 336) throw new InvalidDataException("EID" + p.eid + " PS uniforms34 expected 336 bytes, got " + local.Length);',
    ),
    (
        'report.AppendLine("EID" + p.eid + ": material res23=RID" + Rid(p, "res23") + " res25=RID" + Rid(p, "res25") + " res27=RID" + Rid(p, "res27") + " res29=RID" + Rid(p, "res29") + " res30=RID" + Rid(p, "res30") + " PS uniforms32=" + local.Length + "B");',
        'report.AppendLine("EID" + p.eid + ": material res23=RID" + Rid(p, "res23") + " res25=RID" + Rid(p, "res25") + " res27=RID" + Rid(p, "res27") + " res29=RID" + Rid(p, "res29") + " res31=RID" + Rid(p, "res31") + " PS uniforms34=" + local.Length + "B");',
    ),
    (
        'string[] required = { "_input0", "_input1", "_input2", "_input3", "_input4", "_input5", "_input7", "_input8" };',
        'string[] required = { "_input0", "_input1", "_input2", "_input3", "_input4", "_input5", "_input6", "_input7" };',
    ),
    (
        '- Shader: live Unity VP; unique res23/25/27/29 + VAT res30; PS uniforms32 304B; Cull Back; ZWrite On; stencil 32; skip skin (flags 0); VAT sampled in VS',
        '- Shader: live Unity VP; unique res23/25/27/29/31; PS uniforms34 336B; Cull Back; ZWrite On; stencil 32; skip skin (flags 0); no VAT; res31 uv1 layer mix',
    ),
    (
        'CopyInput(p, "_input2", v, stream2, v * 16 + 0, 4);\n            CopyInput(p, "_input5", v, stream2, v * 16 + 4, 4);\n            Vector4 weights = ReadWeights(p, v);\n            WriteUNorm8(stream2, v * 16 + 8, weights);\n            CopyInput(p, "_input8", v, stream2, v * 16 + 12, 4);',
        'CopyInput(p, "_input2", v, stream2, v * 16 + 0, 4);\n            CopyInput(p, "_input5", v, stream2, v * 16 + 4, 4);\n            Vector4 weights = ReadWeights(p, v);\n            WriteUNorm8(stream2, v * 16 + 8, weights);\n            CopyInput(p, "_input7", v, stream2, v * 16 + 12, 4);',
    ),
    (
        'byte[] joints = ReadInput(p, "_input8", v, 4);',
        'byte[] joints = ReadInput(p, "_input7", v, 4);',
    ),
    (
        'audit.AppendLine("- Unity native streams: `Position Float32x3 + Normal Float32x3 packed _input1 in .x`, `input3/input4 Float32x4`, `input5 SNorm8x4`, `input2/input7 UNorm8x4`, `input8 UInt8x4`, `TEXCOORD4/5 baked n/t`");',
        'audit.AppendLine("- Unity native streams: `Position Float32x3 + Normal Float32x3 packed _input1 in .x`, `input3/input4 Float32x4`, `input5 SNorm8x4`, `input2/input6 UNorm8x4`, `input7 UInt8x4`, `TEXCOORD4/5 baked n/t`");',
    ),
    (
        'Layout l = p.layout.First(x => x.name == "_input7");',
        'Layout l = p.layout.First(x => x.name == "_input6");',
    ),
    (
        'byte[] raw = ReadInput(p, "_input7", vertex, bytes);',
        'byte[] raw = ReadInput(p, "_input6", vertex, bytes);',
    ),
    ('ColourPass6VS230642PS230643BatchImporter', 'ColourPass6VS230646PS230647BatchImporter'),
    ('Assets/ColourPass6_VS230642_PS230643_Batch', 'Assets/ColourPass6_VS230646_PS230647_Batch'),
    ('VS230642_PS230643_BatchManifest.json', 'VS230646_PS230647_BatchManifest.json'),
    ('EID230642230643GBuffer.shader', 'EID230646230647GBuffer.shader'),
    ('Validation/ColourPass6_VS230642/', 'Validation/ColourPass6_VS230646/'),
    ('Validation/ColourPass6_VS230642"', 'Validation/ColourPass6_VS230646"'),
    ('ColourPass6_VS230642_PS230643', 'ColourPass6_VS230646_PS230647'),
    ('static readonly int[] ExpectedEIDs = { 2558, 2562, 2566, 2570, 2574, 2578 };',
     'static readonly int[] ExpectedEIDs = { 2604, 2608, 2612, 2616, 2620, 2624 };'),
    ('static readonly int ExpectedInstances = 15;', 'static readonly int ExpectedInstances = 10;'),
    ('Import EID 19.1-19.6 (VS230642 PS230643)', 'Import EID 20.1-20.6 (VS230646 PS230647)'),
    ('19.1-19.6', '20.1-20.6'),
    ('EID230642DrawProfile', 'EID230646DrawProfile'),
    ('if (p.vs != 230642 || p.ps != 230643)', 'if (p.vs != 230646 || p.ps != 230647)'),
    ('string path = Root + "/Materials/EID" + p.eid + "_VS230642_PS230643.mat";',
     'string path = Root + "/Materials/EID" + p.eid + "_VS230646_PS230647.mat";'),
    ('m.name = "EID" + p.eid + " VS230642 PS230643";', 'm.name = "EID" + p.eid + " VS230646 PS230647";'),
    ('for (int i = 0; i < 19; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));',
     'for (int i = 0; i < 21; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));'),
    ('g.material.shader.name != "EID/URP/VS230642_PS230643_GBuffer"',
     'g.material.shader.name != "EID/URP/VS230646_PS230647_GBuffer"'),
    ('ssbo35 file is missing', 'ssbo29 file is missing'),
    ('byte[] local = ReadCB(p, "PS", "uniforms32");', 'byte[] local = ReadCB(p, "PS", "uniforms34");'),
    ('VS230642 Complete VSInput', 'VS230646 Complete VSInput'),
    ('VS230642/PS230643', 'VS230646/PS230647'),
    ('VS230642 / PS230643', 'VS230646 / PS230647'),
    ('_EID230643MipBias', '_EID230647MipBias'),
    ('_EID230643GlobalY', '_EID230647GlobalY'),
]

for a, b in imp_repls:
    if a not in imp:
        raise SystemExit('importer missing fragment:\n' + repr(a[:240]))
    imp = imp.replace(a, b)

left = [ln for ln in imp.splitlines() if any(x in ln for x in (
    '230642', '230643', 'uniforms32', 'res30', '_input8', 'ssbo35', '19.1', '2558', '_VATRowZW', 'VAT'
))]
dst_imp.parent.mkdir(parents=True, exist_ok=True)
dst_imp.write_text(imp, encoding='utf-8')
print('importer', dst_imp.stat().st_size, 'leftover', len(left))
for ln in left:
    print(' leftover:', ln)

exp = src_exp.read_text(encoding='utf-8')
exp_repls = [
    ('''MESH_ITEM = {
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
''',
     '''MESH_ITEM = {
    2604: '20.1',
    2608: '20.2',
    2612: '20.3',
    2616: '20.4',
    2620: '20.5',
    2624: '20.6',
}
EIDS = [2604, 2608, 2612, 2616, 2620, 2624]
FAMILY = 'VS230646_PS230647'
EXPECTED = (230646, 230647)
ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS230646_PS230647_Batch'
'''),
    ("UNIQUE_MATERIAL = {'res23', 'res25', 'res27', 'res29', 'res30'}",
     "UNIQUE_MATERIAL = {'res23', 'res25', 'res27', 'res29', 'res31'}"),
    ("EXPECTED_INPUTS = ['_input0', '_input1', '_input2', '_input3', '_input4', '_input5', '_input7', '_input8']",
     "EXPECTED_INPUTS = ['_input0', '_input1', '_input2', '_input3', '_input4', '_input5', '_input6', '_input7']"),
    ("raise RuntimeError('EID%d expected 8 VS inputs without _input6, got %s' % (eid, names))",
     "raise RuntimeError('EID%d expected 8 VS inputs without _input8, got %s' % (eid, names))"),
    ("for stage, key in [(rd.ShaderStage.Vertex, 'VS230642'), (rd.ShaderStage.Pixel, 'PS230643')]:",
     "for stage, key in [(rd.ShaderStage.Vertex, 'VS230646'), (rd.ShaderStage.Pixel, 'PS230647')]:"),
    ("open(os.path.join(ROOT, 'VS230642_PS230643_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))",
     "open(os.path.join(ROOT, 'VS230646_PS230647_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))"),
    ("result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_230642_230643_batch_result.json'",
     "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_230646_230647_batch_result.json'"),
    ('''            'psUniqueSlots': sorted(UNIQUE_MATERIAL),
            'psSharedAlbedo': sorted(SHARED_REQUIRED),
            'instanceBuffer': 'VS uniforms27 / PS uniforms20 stride 256',
            'localMaterialCB': 'PS uniforms32 304B',
            'mipBias': 'PS uniforms17 child16 @416',
            'globalY': 'PS uniforms17 child20.y @436',
            'vat': 'VS res30 Binding1 R16G16B16A16_FLOAT',
            'skinning': 'flags bit32 all zero; ssbo35 not baked',
''',
     '''            'psUniqueSlots': sorted(UNIQUE_MATERIAL),
            'psSharedAlbedo': sorted(SHARED_REQUIRED),
            'instanceBuffer': 'VS uniforms27 / PS uniforms20 stride 256',
            'localMaterialCB': 'PS uniforms34 336B',
            'mipBias': 'PS uniforms17 child16 @416',
            'globalY': 'PS uniforms17 child20.y @436',
            'layer': 'PS res31 Binding7 sampled at uv1',
            'skinning': 'flags bit32 all zero; ssbo29 not baked',
'''),
]

for a, b in exp_repls:
    if a not in exp:
        raise SystemExit('export missing fragment:\n' + repr(a[:240]))
    exp = exp.replace(a, b)

left_exp = [ln for ln in exp.splitlines() if any(x in ln for x in (
    '230642', '230643', 'uniforms32', 'res30', '2558', '19.1', 'ssbo35', 'VAT'
))]
dst_exp.write_text(exp, encoding='utf-8')
print('export', dst_exp.stat().st_size, 'leftover', len(left_exp))
for ln in left_exp:
    print(' leftover:', ln)
