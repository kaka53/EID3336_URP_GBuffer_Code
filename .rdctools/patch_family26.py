# Patch family-14 clones into family 26.
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

cs = ROOT / 'Assets/ColourPass6_VS215445_PS215446_Batch/Editor/ColourPass6VS215445PS215446BatchImporter.cs'
repl(cs, [
    ('ColourPass6VS215439PS215440BatchImporter', 'ColourPass6VS215445PS215446BatchImporter'),
    ('Assets/ColourPass6_VS215439_PS215440_Batch', 'Assets/ColourPass6_VS215445_PS215446_Batch'),
    ('VS215439_PS215440_BatchManifest.json', 'VS215445_PS215446_BatchManifest.json'),
    ('EID215439215440GBuffer.shader', 'EID215445215446GBuffer.shader'),
    ('Validation/ColourPass6_VS215439', 'Validation/ColourPass6_VS215445'),
    ('ColourPass6_VS215439_PS215440', 'ColourPass6_VS215445_PS215446'),
    ('static readonly int[] ExpectedEIDs = { 1586, 1592, 1597, 1702, 1706, 1711, 1732 };',
     'static readonly int[] ExpectedEIDs = { 1632, 1637, 1687 };'),
    ('static readonly int ExpectedInstances = 7;', 'static readonly int ExpectedInstances = 3;'),
    ('[MenuItem("Tools/Colour Pass 6/Import EID 14.1-14.7 (VS215439 PS215440)")]',
     '[MenuItem("Tools/Colour Pass 6/Import EID 26.1-26.3 (VS215445 PS215446)")]'),
    ('Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 14.1-14.7."',
     'Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 26.1-26.3."'),
    ('Expected EIDs 14.1-14.7, got ', 'Expected EIDs 26.1-26.3, got '),
    ('VS215439/PS215440 shader has compile errors', 'VS215445/PS215446 shader has compile errors'),
    ('EID215439DrawProfile', 'EID215445DrawProfile'),
    ('[ColourPass6] VS215439/PS215440 import completed', '[ColourPass6] VS215445/PS215446 import completed'),
    ('if (p.vs != 215439 || p.ps != 215440)', 'if (p.vs != 215445 || p.ps != 215446)'),
    ('if (Rid(p, "res24") == 0)', 'if (Rid(p, "res27") == 0)'),
    ('EID" + p.eid + " missing material slot res24.', 'EID" + p.eid + " missing material slot res27.'),
    ('byte[] local = ReadCB(p, "PS", "uniforms23");\n        if (local.Length < 288) throw new InvalidDataException("EID" + p.eid + " PS uniforms23 expected 288 bytes, got " + local.Length);',
     'byte[] local = ReadCB(p, "PS", "uniforms26");\n        if (local.Length < 320) throw new InvalidDataException("EID" + p.eid + " PS uniforms26 expected 320 bytes, got " + local.Length);'),
    ('byte[] inst = ReadCB(p, "VS", "uniforms23");', 'byte[] inst = ReadCB(p, "VS", "uniforms23");'),  # keep, same name
    ('byte[] packed = ReadCB(p, "PS", "uniforms18");\n        if (packed.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " PS uniforms18 too small: " + packed.Length);',
     'byte[] packed = ReadCB(p, "PS", "uniforms21");\n        if (packed.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " PS uniforms21 too small: " + packed.Length);'),
    ('ssbo25 file is missing.', 'ssbo25 file is missing.'),
    ('byte[] instanceCB = ReadCB(p, "VS", "uniforms23");', 'byte[] instanceCB = ReadCB(p, "VS", "uniforms23");'),
    ('EID" + (p.sharedGeometryFromEID != 0 ? p.sharedGeometryFromEID : p.eid) + " VS215439 Complete VSInput',
     'EID" + (p.sharedGeometryFromEID != 0 ? p.sharedGeometryFromEID : p.eid) + " VS215445 Complete VSInput'),
    ('Materials/EID" + p.eid + "_VS215439_PS215440.mat', 'Materials/EID" + p.eid + "_VS215445_PS215446.mat'),
    ('m.name = "EID" + p.eid + " VS215439 PS215440";', 'm.name = "EID" + p.eid + " VS215445 PS215446";'),
    ('byte[] local = ReadCB(p, "PS", "uniforms23");\n        for (int i = 0; i < 18; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));',
     'byte[] local = ReadCB(p, "PS", "uniforms26");\n        for (int i = 0; i < 20; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));'),
    ('byte[] instanceCB = ReadCB(p, "PS", "uniforms18");', 'byte[] instanceCB = ReadCB(p, "PS", "uniforms21");'),
    ('byte[] globals = ReadCB(p, "PS", "uniforms15");\n        m.SetFloat("_EID215440MipBias", ReadFloat(globals, 416));',
     'byte[] globals = ReadCB(p, "PS", "uniforms18");\n        m.SetFloat("_EID215446MipBias", ReadFloat(globals, 416));'),
    ('m.SetFloat("_StencilRef", CapturedStencil(p));', ''),
    ('Texture albedo = LoadTexture(p, "res24");', 'Texture albedo = LoadTexture(p, "res27");'),
    ('EID" + p.eid + " res24 texture binding is incomplete.', 'EID" + p.eid + " res27 texture binding is incomplete.'),
    ('m.SetTexture("_Res24", albedo);', 'm.SetTexture("_Res27", albedo);'),
    ('report.AppendLine("EID" + p.eid + ": material res24=RID" + Rid(p, "res24") + " stencil=" + CapturedStencil(p) + " PS uniforms23=" + local.Length + "B");',
     'report.AppendLine("EID" + p.eid + ": material res27=RID" + Rid(p, "res27") + " PS uniforms26=" + local.Length + "B");'),
    ('14.1-14.7 instance total expected', '26.1-26.3 instance total expected'),
    ('g.material.shader.name != "EID/URP/VS215439_PS215440_GBuffer"', 'g.material.shader.name != "EID/URP/VS215445_PS215446_GBuffer"'),
    ('report.AppendLine("vertexAttributes=COMPLETE_6_OF_6");', 'report.AppendLine("vertexAttributes=COMPLETE_6_OF_6");'),
    ('# VS215439 / PS215440 Vertex Attribute Audit', '# VS215445 / PS215446 Vertex Attribute Audit'),
    ('- EIDs: `14.1-14.7`', '- EIDs: `26.1-26.3`'),
    ('- Shader: live Unity VP; unique res24 albedo; PS uniforms23 288B; Cull Off; ZWrite On; stencil Ref per-EID 36/52; Queue Geometry; packed `_input2` on NORMAL.x oct-only; skin bake ssbo25 via uniforms23 when bit 32 set',
     '- Shader: live Unity VP; unique res27 albedo; PS uniforms26 320B; Cull Back; ZWrite On; stencil Ref 36; Queue Geometry; packed `_input2` on NORMAL.x oct-only; wrap albedo; skin bake ssbo25 via uniforms23 when bit 32 set'),
    ('static int CapturedStencil(Profile p) => p.raster != null ? p.raster.stencilRef : 52;',
     'static int CapturedStencil(Profile p) => p.raster != null ? p.raster.stencilRef : 36;'),
    ('byte[] overlay = ReadCB(p, "PS", "uniforms18");', 'byte[] overlay = ReadCB(p, "PS", "uniforms21");'),
])

# leftover that must change
text = cs.read_text(encoding='utf-8')
leftovers = []
for s in ['215439', '215440', 'res24', '_Res24', 'uniforms15', '14.1', '14.7', 'StencilRef']:
    if s in text:
        leftovers.append(s)
print('cs leftovers', leftovers)

dp = ROOT / 'Assets/ColourPass6_VS215445_PS215446_Batch/Runtime/EID215445DrawProfile.cs'
repl(dp, [
    ('[CreateAssetMenu(menuName = "EID/VS215439 PS215440 Draw Profile", fileName = "EID215439DrawProfile")]',
     '[CreateAssetMenu(menuName = "EID/VS215445 PS215446 Draw Profile", fileName = "EID215445DrawProfile")]'),
    ('public sealed class EID215439DrawProfile : ScriptableObject',
     'public sealed class EID215445DrawProfile : ScriptableObject'),
])

py = ROOT / '.rdctools/export_215445_215446_batch.py'
repl(py, [
    ('''MESH_ITEM = {
    1586: '14.1',
    1592: '14.2',
    1597: '14.3',
    1702: '14.4',
    1706: '14.5',
    1711: '14.6',
    1732: '14.7',
}
EIDS = [1586, 1592, 1597, 1702, 1706, 1711, 1732]
FAMILY = 'VS215439_PS215440'
EXPECTED = (215439, 215440)
ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215439_PS215440_Batch'
''',
     '''MESH_ITEM = {
    1632: '26.1',
    1637: '26.2',
    1687: '26.3',
}
EIDS = [1632, 1637, 1687]
FAMILY = 'VS215445_PS215446'
EXPECTED = (215445, 215446)
ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215445_PS215446_Batch'
'''),
    ("UNIQUE_MATERIAL = {'res24'}", "UNIQUE_MATERIAL = {'res27'}"),
    ("if key == 'VS' and name == 'uniforms23':", "if key == 'VS' and name == 'uniforms23':"),
    ("for stage, key in [(rd.ShaderStage.Vertex, 'VS215439'), (rd.ShaderStage.Pixel, 'PS215440')]:",
     "for stage, key in [(rd.ShaderStage.Vertex, 'VS215445'), (rd.ShaderStage.Pixel, 'PS215446')]:"),
    ("'instanceBuffer': 'VS uniforms23 / PS uniforms18 stride 256',",
     "'instanceBuffer': 'VS uniforms23 / PS uniforms21 stride 256',"),
    ("'localMaterialCB': 'PS uniforms23 288B packed as 18 float4',",
     "'localMaterialCB': 'PS uniforms26 320B packed as 20 float4',"),
    ("'skinning': 'ssbo25 Binding7; flags uniforms23 child1.w bit32',",
     "'skinning': 'ssbo25 Binding7; flags uniforms23 child1.w bit32',"),
    ("open(os.path.join(ROOT, 'VS215439_PS215440_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))",
     "open(os.path.join(ROOT, 'VS215445_PS215446_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))"),
    ("result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215439_215440_batch_result.json'",
     "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215445_215446_batch_result.json'"),
])
print('done')
