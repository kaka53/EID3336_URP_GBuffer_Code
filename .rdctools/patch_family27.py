# Patch family-26 clones into family 27.
from pathlib import Path

ROOT = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace')

def repl(path, pairs):
    text = path.read_text(encoding='utf-8')
    for a, b in pairs:
        if a not in text:
            raise SystemExit('missing %r in %s' % (a, path))
        text = text.replace(a, b)
    path.write_text(text, encoding='utf-8')
    print('patched', path)

cs = ROOT / 'Assets/ColourPass6_VS215477_PS215478_Batch/Editor/ColourPass6VS215477PS215478BatchImporter.cs'
repl(cs, [
    ('ColourPass6VS215445PS215446BatchImporter', 'ColourPass6VS215477PS215478BatchImporter'),
    ('Assets/ColourPass6_VS215445_PS215446_Batch', 'Assets/ColourPass6_VS215477_PS215478_Batch'),
    ('VS215445_PS215446_BatchManifest.json', 'VS215477_PS215478_BatchManifest.json'),
    ('EID215445215446GBuffer.shader', 'EID215477215478GBuffer.shader'),
    ('Validation/ColourPass6_VS215445', 'Validation/ColourPass6_VS215477'),
    ('ColourPass6_VS215445_PS215446', 'ColourPass6_VS215477_PS215478'),
    ('static readonly int[] ExpectedEIDs = { 1632, 1637, 1687 };',
     'static readonly int[] ExpectedEIDs = { 1738, 1742, 1747 };'),
    ('static readonly int ExpectedLayoutVariants = 3;', 'static readonly int ExpectedLayoutVariants = 2;'),
    ('[MenuItem("Tools/Colour Pass 6/Import EID 26.1-26.3 (VS215445 PS215446)")]',
     '[MenuItem("Tools/Colour Pass 6/Import EID 27.1-27.3 (VS215477 PS215478)")]'),
    ('Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 26.1-26.3."',
     'Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 27.1-27.3."'),
    ('Expected EIDs 26.1-26.3, got ', 'Expected EIDs 27.1-27.3, got '),
    ('VS215445/PS215446 shader has compile errors', 'VS215477/PS215478 shader has compile errors'),
    ('EID215445DrawProfile', 'EID215477DrawProfile'),
    ('[ColourPass6] VS215445/PS215446 import completed', '[ColourPass6] VS215477/PS215478 import completed'),
    ('if (p.vs != 215445 || p.ps != 215446)', 'if (p.vs != 215477 || p.ps != 215478)'),
    ('if (p.layout == null || p.layout.Length != 6) throw new InvalidDataException("EID" + p.eid + " must expose all 6 RenderDoc VS inputs.");',
     'if (p.layout == null || p.layout.Length != 8) throw new InvalidDataException("EID" + p.eid + " must expose all 8 RenderDoc VS inputs.");'),
    ('string[] required = { "_input0", "_input1", "_input2", "_input4", "_input5", "_input6" };',
     'string[] required = { "_input0", "_input1", "_input2", "_input3", "_input4", "_input5", "_input6", "_input7" };'),
    ('if (Rid(p, "res27") == 0)', 'if (Rid(p, "res12") == 0)'),
    ('EID" + p.eid + " missing material slot res27.', 'EID" + p.eid + " missing material slot res12.'),
    ('byte[] local = ReadCB(p, "PS", "uniforms26");\n        if (local.Length < 320) throw new InvalidDataException("EID" + p.eid + " PS uniforms26 expected 320 bytes, got " + local.Length);',
     'byte[] local = ReadCB(p, "PS", "uniforms11");\n        if (local.Length < 336) throw new InvalidDataException("EID" + p.eid + " PS uniforms11 expected 336 bytes, got " + local.Length);'),
    ('byte[] inst = ReadCB(p, "VS", "uniforms23");', 'byte[] inst = ReadCB(p, "VS", "uniforms26");'),
    ('EID" + p.eid + " VS uniforms23 too small: ', 'EID" + p.eid + " VS uniforms26 too small: '),
    ('byte[] packed = ReadCB(p, "PS", "uniforms21");\n        if (packed.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " PS uniforms21 too small: " + packed.Length);',
     ''),
    ('captured skin flag is set but ssbo25 file is missing.', 'captured skin flag is set but ssbo28 file is missing.'),
    ('byte[] instanceCB = ReadCB(p, "VS", "uniforms23");', 'byte[] instanceCB = ReadCB(p, "VS", "uniforms26");'),
    ('Vector4 weights = ReadWeights(p, v);\n            WriteUNorm8(stream2, v * 8 + 0, weights);\n            uint[] joints = ReadJoints(p, v);',
     'Vector4 weights = ReadWeights(p, v);\n            WriteUNorm8(stream2, v * 8 + 0, weights);\n            uint[] joints = ReadJoints(p, v);'),
    ('EID" + (p.sharedGeometryFromEID != 0 ? p.sharedGeometryFromEID : p.eid) + " VS215445 Complete VSInput',
     'EID" + (p.sharedGeometryFromEID != 0 ? p.sharedGeometryFromEID : p.eid) + " VS215477 Complete VSInput'),
    ('`input5 weights UNorm8x4`, `input6 UInt8x4`', '`input6 weights UNorm8x4`, `input7 UInt8x4`'),
    ('Materials/EID" + p.eid + "_VS215445_PS215446.mat', 'Materials/EID" + p.eid + "_VS215477_PS215478.mat'),
    ('m.name = "EID" + p.eid + " VS215445 PS215446";', 'm.name = "EID" + p.eid + " VS215477 PS215478";'),
    ('byte[] local = ReadCB(p, "PS", "uniforms26");\n        for (int i = 0; i < 20; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));',
     'byte[] local = ReadCB(p, "PS", "uniforms11");\n        for (int i = 0; i < 21; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));'),
    ('byte[] instanceCB = ReadCB(p, "PS", "uniforms21");\n        m.SetVector("_InstancePacked", ReadVector4(instanceCB, 80));\n        byte[] globals = ReadCB(p, "PS", "uniforms18");\n        m.SetFloat("_EID215446MipBias", ReadFloat(globals, 416));',
     'byte[] globals = ReadCB(p, "PS", "uniforms6");\n        m.SetFloat("_EID215478MipBias", ReadFloat(globals, 416));'),
    ('Texture albedo = LoadTexture(p, "res27");', 'Texture albedo = LoadTexture(p, "res12");'),
    ('EID" + p.eid + " res27 texture binding is incomplete.', 'EID" + p.eid + " res12 texture binding is incomplete.'),
    ('m.SetTexture("_Res27", albedo);', 'm.SetTexture("_Res12", albedo);'),
    ('report.AppendLine("EID" + p.eid + ": material res27=RID" + Rid(p, "res27") + " PS uniforms26=" + local.Length + "B");',
     'report.AppendLine("EID" + p.eid + ": material res12=RID" + Rid(p, "res12") + " PS uniforms11=" + local.Length + "B");'),
    ('26.1-26.3 instance total expected', '27.1-27.3 instance total expected'),
    ('g.material.shader.name != "EID/URP/VS215445_PS215446_GBuffer"', 'g.material.shader.name != "EID/URP/VS215477_PS215478_GBuffer"'),
    ('report.AppendLine("vertexAttributes=COMPLETE_6_OF_6");', 'report.AppendLine("vertexAttributes=COMPLETE_8_OF_8");'),
    ('# VS215445 / PS215446 Vertex Attribute Audit', '# VS215477 / PS215478 Vertex Attribute Audit'),
    ('- EIDs: `26.1-26.3`', '- EIDs: `27.1-27.3`'),
    ('- Shader: live Unity VP; unique res27 albedo; PS uniforms26 320B; Cull Back; ZWrite On; stencil Ref 36; Queue Geometry; packed `_input2` on NORMAL.x oct-only; wrap albedo; skin bake ssbo25 via uniforms23 when bit 32 set',
     '- Shader: live Unity VP; unique res12 albedo; PS uniforms11 336B; Cull Front; ZWrite On; stencil Ref 36; Queue AlphaTest clip; packed `_input2` on NORMAL.x; ColorMask RT0 only; skin bake ssbo28 via uniforms26 when bit 32 set'),
    ('byte[] cb = ReadCB(p, "VS", "uniforms23");', 'byte[] cb = ReadCB(p, "VS", "uniforms26");'),
    ('Layout l = p.layout.First(x => x.name == "_input6");', 'Layout l = p.layout.First(x => x.name == "_input7");'),
    ('byte[] raw = ReadInput(p, "_input6", vertex, bytes);', 'byte[] raw = ReadInput(p, "_input7", vertex, bytes);'),
    ('Layout l = p.layout.First(x => x.name == "_input5");', 'Layout l = p.layout.First(x => x.name == "_input6");'),
    ('byte[] raw = ReadInput(p, "_input5", vertex, bytes);', 'byte[] raw = ReadInput(p, "_input6", vertex, bytes);'),
    ('static void ApplyInstancePacked(Material m, Profile p, int instance)\n    {\n        byte[] overlay = ReadCB(p, "PS", "uniforms21");\n        m.SetVector("_InstancePacked", ReadVector4(overlay, instance * 256 + 80));\n        EditorUtility.SetDirty(m);\n    }',
     'static void ApplyInstancePacked(Material m, Profile p, int instance)\n    {\n        EditorUtility.SetDirty(m);\n    }'),
    ('byte[] b = ReadCB(p, "VS", "uniforms23"); int o = instance * 256;',
     'byte[] b = ReadCB(p, "VS", "uniforms26"); int o = instance * 256;'),
])

text = cs.read_text(encoding='utf-8')
leftovers = []
for s in ['215445', '215446', 'res27', '_Res27', 'uniforms23', 'uniforms21', 'uniforms18', 'uniforms26', 'ssbo25', '26.1', '26.3', '_input5', '_InstancePacked']:
    if s in text:
        leftovers.append(s)
print('cs leftovers', leftovers)

dp = ROOT / 'Assets/ColourPass6_VS215477_PS215478_Batch/Runtime/EID215477DrawProfile.cs'
repl(dp, [
    ('[CreateAssetMenu(menuName = "EID/VS215445 PS215446 Draw Profile", fileName = "EID215445DrawProfile")]',
     '[CreateAssetMenu(menuName = "EID/VS215477 PS215478 Draw Profile", fileName = "EID215477DrawProfile")]'),
    ('public sealed class EID215445DrawProfile : ScriptableObject',
     'public sealed class EID215477DrawProfile : ScriptableObject'),
])

py = ROOT / '.rdctools/export_215477_215478_batch.py'
repl(py, [
    ("1632: '26.1',\n    1637: '26.2',\n    1687: '26.3',",
     "1738: '27.1',\n    1742: '27.2',\n    1747: '27.3',"),
    ('EIDS = [1632, 1637, 1687]', 'EIDS = [1738, 1742, 1747]'),
    ("FAMILY = 'VS215445_PS215446'", "FAMILY = 'VS215477_PS215478'"),
    ('EXPECTED = (215445, 215446)', 'EXPECTED = (215477, 215478)'),
    ("ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215445_PS215446_Batch'",
     "ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215477_PS215478_Batch'"),
    ("UNIQUE_MATERIAL = {'res27'}", "UNIQUE_MATERIAL = {'res12'}"),
    ("EXPECTED_INPUTS = {'_input0', '_input1', '_input2', '_input4', '_input5', '_input6'}",
     "EXPECTED_INPUTS = {'_input0', '_input1', '_input2', '_input3', '_input4', '_input5', '_input6', '_input7'}"),
    ("raise RuntimeError('EID%d expected 6 VS inputs, got %s' % (eid, sorted(names)))",
     "raise RuntimeError('EID%d expected 8 VS inputs, got %s' % (eid, sorted(names)))"),
    ("if key == 'VS' and name == 'uniforms23':", "if key == 'VS' and name == 'uniforms26':"),
    ("for stage, key in [(rd.ShaderStage.Vertex, 'VS215445'), (rd.ShaderStage.Pixel, 'PS215446')]:",
     "for stage, key in [(rd.ShaderStage.Vertex, 'VS215477'), (rd.ShaderStage.Pixel, 'PS215478')]:"),
    ("os.path.join(ASSETS, 'ColourPass6_VS215445_PS215446_Batch', 'TextureDatabase'),",
     "os.path.join(ASSETS, 'ColourPass6_VS215477_PS215478_Batch', 'TextureDatabase'),"),
    ("'instanceBuffer': 'VS uniforms23 / PS uniforms21 stride 256',",
     "'instanceBuffer': 'VS uniforms26 stride 256',"),
    ("'localMaterialCB': 'PS uniforms26 320B packed as 20 float4',",
     "'localMaterialCB': 'PS uniforms11 336B packed as 21 float4',"),
    ("'skinning': 'ssbo25 Binding7; flags uniforms23 child1.w bit32',",
     "'skinning': 'ssbo28 Binding7; flags uniforms26 child1.w bit32',"),
    ("'packedNormal': 'NORMAL.xyz from _input2; packed bits in .x',",
     "'packedNormal': 'NORMAL.xyz from _input2; packed bits in .x; weights _input6 joints _input7',"),
    ("open(os.path.join(ROOT, 'VS215445_PS215446_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))",
     "open(os.path.join(ROOT, 'VS215477_PS215478_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))"),
    ("result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215445_215446_batch_result.json'",
     "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215477_215478_batch_result.json'"),
])

pytext = py.read_text(encoding='utf-8')
pyleftovers = []
for s in ['215445', '215446', 'res27', 'uniforms23', 'uniforms21', 'uniforms18', 'ssbo25', '1632', '26.1']:
    if s in pytext:
        pyleftovers.append(s)
print('py leftovers', pyleftovers)
print('done')
