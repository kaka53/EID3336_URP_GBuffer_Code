from pathlib import Path

imp = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215441_PS215442_Batch/Editor/ColourPass6VS215441PS215442BatchImporter.cs')
prof = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215441_PS215442_Batch/Runtime/EID215441DrawProfile.cs')
exp = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215441_215442_batch.py')

t = imp.read_text(encoding='utf-8')
repls = [
    ('ColourPass6VS215443PS215444BatchImporter', 'ColourPass6VS215441PS215442BatchImporter'),
    ('EID215443DrawProfile', 'EID215441DrawProfile'),
    ('ColourPass6_VS215443_PS215444_Batch', 'ColourPass6_VS215441_PS215442_Batch'),
    ('VS215443_PS215444_BatchManifest.json', 'VS215441_PS215442_BatchManifest.json'),
    ('EID215443215444GBuffer', 'EID215441215442GBuffer'),
    ('EID/URP/VS215443_PS215444_GBuffer', 'EID/URP/VS215441_PS215442_GBuffer'),
    ('Validation/ColourPass6_VS215443', 'Validation/ColourPass6_VS215441'),
    ('ColourPass6_VS215443_PS215444', 'ColourPass6_VS215441_PS215442'),
    ('EID" + p.eid + " VS215443 PS215444', 'EID" + p.eid + " VS215441 PS215442'),
    ('EID" + p.eid + "_VS215443_PS215444.mat', 'EID" + p.eid + "_VS215441_PS215442.mat'),
    ('"EID" + (p.sharedGeometryFromEID != 0 ? p.sharedGeometryFromEID : p.eid) + " VS215443 Complete VSInput"',
     '"EID" + (p.sharedGeometryFromEID != 0 ? p.sharedGeometryFromEID : p.eid) + " VS215441 Complete VSInput"'),
    ('Tools/Colour Pass 6/Import EID 13.1-13.8 (VS215443 PS215444)',
     'Tools/Colour Pass 6/Import EID 25.1-25.3 (VS215441 PS215442)'),
    ('static readonly int[] ExpectedEIDs = { 1627, 1642, 1647, 1652, 1657, 1682, 1692, 1696 };',
     'static readonly int[] ExpectedEIDs = { 1618, 1622, 1672 };'),
    ('static readonly int ExpectedInstances = 8;', 'static readonly int ExpectedInstances = 3;'),
    ('static readonly int ExpectedLayoutVariants = 4;', 'static readonly int ExpectedLayoutVariants = 1;'),
    ('Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 13.1-13.8.',
     'Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 25.1-25.3.'),
    ('Expected EIDs 13.1-13.8, got ', 'Expected EIDs 25.1-25.3, got '),
    ('VS215443/PS215444 shader has compile errors', 'VS215441/PS215442 shader has compile errors'),
    ('p.vs != 215443 || p.ps != 215444', 'p.vs != 215441 || p.ps != 215442'),
    ('13.1-13.8 instance total expected', '25.1-25.3 instance total expected'),
    ('# VS215443 / PS215444 Vertex Attribute Audit', '# VS215441 / PS215442 Vertex Attribute Audit'),
    ('- EIDs: `13.1-13.8`', '- EIDs: `25.1-25.3`'),
    ('- Layout variants: `" + layouts + "` (`7c0265b241eb3b8f`, `50a33780d8f941e4`, `405a885f7842230e`, `9d869769087b15e3`)',
     '- Layout variants: `" + layouts + "` (`7c0265b241eb3b8f`)'),
    ('- Shader: live Unity VP; unique res25/res26; PS uniforms24 288B; Cull Off; ZWrite On; stencil Ref 36; Queue AlphaTest; packed `_input2` on NORMAL.x; skin bake ssbo27 via uniforms25',
     '- Shader: live Unity VP; unique res28/res29; PS uniforms27 320B; Cull Back; ZWrite On; stencil Ref 36; Queue Geometry; packed `_input2` on NORMAL.x; skin bake ssbo27 via uniforms25; no clip'),
    ('[ColourPass6] VS215443/PS215444 import completed', '[ColourPass6] VS215441/PS215442 import completed'),
    ('_EID215444MipBias', '_EID215442MipBias'),
    ('Rid(p, "res25") == 0 || Rid(p, "res26") == 0', 'Rid(p, "res28") == 0 || Rid(p, "res29") == 0'),
    ('missing material slots res25/res26.', 'missing material slots res28/res29.'),
    ('res25/res26 texture binding is incomplete.', 'res28/res29 texture binding is incomplete.'),
    ('LoadTexture(p, "res25")', 'LoadTexture(p, "res28")'),
    ('LoadTexture(p, "res26")', 'LoadTexture(p, "res29")'),
    ('m.SetTexture("_Res25", albedo)', 'm.SetTexture("_Res28", albedo)'),
    ('m.SetTexture("_Res26", normalTex)', 'm.SetTexture("_Res29", normalTex)'),
    ('material res25=RID" + Rid(p, "res25") + " res26=RID" + Rid(p, "res26") + " PS uniforms24="',
     'material res28=RID" + Rid(p, "res28") + " res29=RID" + Rid(p, "res29") + " PS uniforms27="'),
    ('PS uniforms24 expected 288 bytes', 'PS uniforms27 expected 320 bytes'),
    ('local.Length < 288', 'local.Length < 320'),
    ('for (int i = 0; i < 18; ++i)', 'for (int i = 0; i < 20; ++i)'),
    ('ReadCB(p, "PS", "uniforms24")', 'ReadCB(p, "PS", "uniforms27")'),
    ('ReadCB(p, "PS", "uniforms16")', 'ReadCB(p, "PS", "uniforms19")'),
]
for a, b in repls:
    n = t.count(a)
    print(('OK' if n else 'MISSING'), n, a[:90])
    t = t.replace(a, b)

t = t.replace('byte[] packed = ReadCB(p, "PS", "uniforms19");', 'byte[] packed = ReadCB(p, "PS", "uniforms22");')
t = t.replace('byte[] instanceCB = ReadCB(p, "PS", "uniforms19");', 'byte[] instanceCB = ReadCB(p, "PS", "uniforms22");')
t = t.replace('byte[] overlay = ReadCB(p, "PS", "uniforms19");', 'byte[] overlay = ReadCB(p, "PS", "uniforms22");')
print('uniforms19 after packed remap', t.count('uniforms19'))
print('uniforms22', t.count('uniforms22'))
print('uniforms27', t.count('uniforms27'))
print('leftover', {k: t.count(k) for k in ['215443', '215444', 'res25', 'res26', 'uniforms24', 'uniforms16', '13.1']})
imp.write_text(t, encoding='utf-8')

p = prof.read_text(encoding='utf-8')
p = p.replace('VS215443 PS215444 Draw Profile', 'VS215441 PS215442 Draw Profile')
p = p.replace('EID215443DrawProfile', 'EID215441DrawProfile')
print('profile leftover 215443', p.count('215443'))
prof.write_text(p, encoding='utf-8')

e = exp.read_text(encoding='utf-8')
old_header = """MESH_ITEM = {
    1627: '13.1',
    1642: '13.2',
    1647: '13.3',
    1652: '13.4',
    1657: '13.5',
    1682: '13.6',
    1692: '13.7',
    1696: '13.8',
}
EIDS = [1627, 1642, 1647, 1652, 1657, 1682, 1692, 1696]
FAMILY = 'VS215443_PS215444'
EXPECTED = (215443, 215444)
ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215443_PS215444_Batch'
"""
new_header = """MESH_ITEM = {
    1618: '25.1',
    1622: '25.2',
    1672: '25.3',
}
EIDS = [1618, 1622, 1672]
FAMILY = 'VS215441_PS215442'
EXPECTED = (215441, 215442)
ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215441_PS215442_Batch'
"""
print('header', e.count(old_header))
e = e.replace(old_header, new_header)
erepls = [
    ("UNIQUE_MATERIAL = {'res25', 'res26'}", "UNIQUE_MATERIAL = {'res28', 'res29'}"),
    ("for stage, key in [(rd.ShaderStage.Vertex, 'VS215443'), (rd.ShaderStage.Pixel, 'PS215444')]:",
     "for stage, key in [(rd.ShaderStage.Vertex, 'VS215441'), (rd.ShaderStage.Pixel, 'PS215442')]:"),
    ("open(os.path.join(ROOT, 'VS215443_PS215444_BatchManifest.json')",
     "open(os.path.join(ROOT, 'VS215441_PS215442_BatchManifest.json')"),
    ("result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215443_215444_batch_result.json'",
     "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215441_215442_batch_result.json'"),
    ("'instanceBuffer': 'VS uniforms25 / PS uniforms19 stride 256'",
     "'instanceBuffer': 'VS uniforms25 / PS uniforms22 stride 256'"),
    ("'localMaterialCB': 'PS uniforms24 288B packed as 18 float4'",
     "'localMaterialCB': 'PS uniforms27 320B packed as 20 float4'"),
]
for a, b in erepls:
    print(('OK' if a in e else 'MISSING'), a[:80])
    e = e.replace(a, b)
print('walk ASSETS', e.count('os.walk(ASSETS)'))
print('export leftover', {k: e.count(k) for k in ['215443', '215444', 'res25', 'res26', '13.1']})
exp.write_text(e, encoding='utf-8')
