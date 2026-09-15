import os, shutil, re
from pathlib import Path

ROOT = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace')
SRC = ROOT / 'Assets/ColourPass6_VS215521_PS215522_Batch'
DST = ROOT / 'Assets/ColourPass6_VS215519_PS215520_Batch'
SRC_IMP = SRC / 'Editor/ColourPass6VS215521PS215522BatchImporter.cs'
SRC_PROF = SRC / 'Runtime/EID215521DrawProfile.cs'
SRC_EXP = ROOT / '.rdctools/export_215521_215522_batch.py'

assert SRC_IMP.exists()
assert not (DST / 'Editor/ColourPass6VS215519PS215520BatchImporter.cs').exists() or True

dirs = [
    DST, DST/'Editor', DST/'Runtime', DST/'Shaders', DST/'Materials', DST/'Profiles',
    DST/'Geometry', DST/'Geometry'/'Meshes', DST/'TextureDatabase',
    DST/'Captured', DST/'Captured'/'Geometry', DST/'Captured'/'CBuffers', DST/'Captured'/'Instances',
    ROOT/'Validation'/'ColourPass6_VS215519',
]
for d in dirs:
    d.mkdir(parents=True, exist_ok=True)

def meta(guid, folder=False, importer=None):
    lines = ['fileFormatVersion: 2', 'guid: %s' % guid]
    if folder:
        lines += ['folderAsset: yes', 'DefaultImporter:', '  externalObjects: {}', '  userData:', '  assetBundleName:', '  assetBundleVariant:']
    elif importer == 'shader':
        lines += ['ShaderImporter:', '  externalObjects: {}', '  defaultTextures: []', '  nonModifiableTextures: []', '  userData:', '  assetBundleName:', '  assetBundleVariant:']
    elif importer == 'hlsl':
        lines += ['ShaderIncludeImporter:', '  externalObjects: {}', '  userData:', '  assetBundleName:', '  assetBundleVariant:']
    elif importer == 'cs':
        lines += ['MonoImporter:', '  externalObjects: {}', '  serializedVersion: 2', '  defaultReferences: []', '  executionOrder: 0', '  icon: {instanceID: 0}', '  userData:', '  assetBundleName:', '  assetBundleVariant:']
    return '\n'.join(lines) + '\n'

guids = {
    DST: ('215519d4e5f647890abcde4455667700', True, None),
    DST/'Editor': ('215519d4e5f647890abcde4455667705', True, None),
    DST/'Runtime': ('215519d4e5f647890abcde4455667706', True, None),
    DST/'Shaders': ('215519d4e5f647890abcde4455667707', True, None),
    DST/'Captured': ('215519d4e5f647890abcde4455667708', True, None),
    DST/'Geometry': ('215519d4e5f647890abcde4455667709', True, None),
    DST/'Materials': ('215519d4e5f647890abcde445566770a', True, None),
    DST/'Profiles': ('215519d4e5f647890abcde445566770b', True, None),
    DST/'TextureDatabase': ('215519d4e5f647890abcde445566770c', True, None),
    DST/'Geometry'/'Meshes': ('215519d4e5f647890abcde445566770d', True, None),
    DST/'Captured'/'Geometry': ('215519d4e5f647890abcde445566770e', True, None),
    DST/'Captured'/'CBuffers': ('215519d4e5f647890abcde445566770f', True, None),
    DST/'Captured'/'Instances': ('215519d4e5f647890abcde4455667710', True, None),
    DST/'Shaders'/'EID215519215520GBuffer.shader': ('215519d4e5f647890abcde4455667701', False, 'shader'),
    DST/'Shaders'/'EID215519215520GBuffer.hlsl': ('215519d4e5f647890abcde4455667702', False, 'hlsl'),
    DST/'Editor'/'ColourPass6VS215519PS215520BatchImporter.cs': ('215519d4e5f647890abcde4455667703', False, 'cs'),
    DST/'Runtime'/'EID215519DrawProfile.cs': ('215519d4e5f647890abcde4455667704', False, 'cs'),
}
for p, (g, folder, imp) in guids.items():
    mp = Path(str(p) + '.meta')
    if not mp.exists():
        mp.write_text(meta(g, folder, imp), encoding='utf8')

prof = SRC_PROF.read_text(encoding='utf8')
prof = prof.replace('VS215521 PS215522', 'VS215519 PS215520')
prof = prof.replace('EID215521DrawProfile', 'EID215519DrawProfile')
prof = prof.replace('EID215521', 'EID215519')
(DST/'Runtime'/'EID215519DrawProfile.cs').write_text(prof, encoding='utf8')

imp = SRC_IMP.read_text(encoding='utf8')
repls = [
    ('ColourPass6VS215521PS215522BatchImporter', 'ColourPass6VS215519PS215520BatchImporter'),
    ('ColourPass6_VS215521_PS215522', 'ColourPass6_VS215519_PS215520'),
    ('EID215521215522GBuffer', 'EID215519215520GBuffer'),
    ('EID215521DrawProfile', 'EID215519DrawProfile'),
    ('VS215521_PS215522', 'VS215519_PS215520'),
    ('Validation/ColourPass6_VS215521', 'Validation/ColourPass6_VS215519'),
    ('EID/URP/VS215521_PS215522_GBuffer', 'EID/URP/VS215519_PS215520_GBuffer'),
    ('static readonly int[] ExpectedEIDs = { 3536, 3540 };', 'static readonly int[] ExpectedEIDs = { 3448 };'),
    ('static readonly int ExpectedInstances = 8;', 'static readonly int ExpectedInstances = 2;'),
    ('40.1-40.2', '52.1'),
    ('p.vs != 215521 || p.ps != 215522', 'p.vs != 215519 || p.ps != 215520'),
    ('byte[] local = ReadCB(p, "PS", "uniforms37");', 'byte[] local = ReadCB(p, "PS", "uniforms46");'),
    ('if (local.Length < 464) throw new InvalidDataException("EID" + p.eid + " PS uniforms37 expected 464 bytes, got " + local.Length);',
     'if (local.Length < 768) throw new InvalidDataException("EID" + p.eid + " PS uniforms46 expected 768 bytes, got " + local.Length);'),
    ('byte[] meta = ReadCB(p, "PS", "uniforms39");', 'byte[] meta = ReadCB(p, "PS", "uniforms48");'),
    ('for (int i = 0; i < 29; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));',
     'for (int i = 0; i < 48; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));'),
    ('_EID215522MipBias', '_EID215520MipBias'),
    ('m.name = "EID" + p.eid + " VS215521 PS215522";', 'm.name = "EID" + p.eid + " VS215519 PS215520";'),
    ('Root + "/Materials/EID" + p.eid + "_VS215521_PS215522.mat"', 'Root + "/Materials/EID" + p.eid + "_VS215519_PS215520.mat"'),
    ('mesh.name = "EID" + (p.sharedGeometryFromEID != 0 ? p.sharedGeometryFromEID : p.eid) + " VS215521 Complete VSInput"',
     'mesh.name = "EID" + (p.sharedGeometryFromEID != 0 ? p.sharedGeometryFromEID : p.eid) + " VS215519 Complete VSInput"'),
    ('Import EID 52.1 (VS215521 PS215522)', 'Import EID 52.1 (VS215519 PS215520)'),
    ('[ColourPass6] VS215521/PS215522 import completed', '[ColourPass6] VS215519/PS215520 import completed'),
    ('VS215521/PS215522 shader has compile errors', 'VS215519/PS215520 shader has compile errors'),
    ('# VS215521 / PS215522 Vertex Attribute Audit', '# VS215519 / PS215520 Vertex Attribute Audit'),
    ('- Shader: live Unity VP; unique res28/res30/res32 plus reused res33/res34/res35; PS uniforms37 29 float4; VT off; packed oct 0.0020; extra maps only',
     '- Shader: live Unity VP; unique res33/35/37/38/39/43/44 plus reused res40/41/42; PS uniforms46 48 float4; VT off; packed oct 0.0020; extra/fade + overlay + extra maps; ZTest GEqual'),
]
# leftover numeric ids in comments / logs
repls += [
    ('VS215521', 'VS215519'),
    ('PS215522', 'PS215520'),
]
for a,b in repls:
    if a not in imp and a not in ('Import EID 52.1 (VS215521 PS215520)',):
        # some strings already transformed by earlier replaces
        pass
    imp = imp.replace(a, b)

old_req = '''        if (Rid(p, "res28") == 0 || Rid(p, "res30") == 0 || Rid(p, "res32") == 0 || Rid(p, "res33") == 0 || Rid(p, "res34") == 0 || Rid(p, "res35") == 0)
            throw new InvalidDataException("EID" + p.eid + " missing material slots res28/res30/res32/res33/res34/res35.");'''
new_req = '''        if (Rid(p, "res33") == 0 || Rid(p, "res35") == 0 || Rid(p, "res37") == 0 || Rid(p, "res38") == 0 || Rid(p, "res39") == 0 || Rid(p, "res40") == 0 || Rid(p, "res41") == 0 || Rid(p, "res42") == 0 || Rid(p, "res43") == 0 || Rid(p, "res44") == 0)
            throw new InvalidDataException("EID" + p.eid + " missing material slots res33/res35/res37/res38/res39/res40/res41/res42/res43/res44.");'''
if old_req not in imp:
    raise SystemExit('ValidateProfile texture check not found')
imp = imp.replace(old_req, new_req)

old_mat = '''        Texture albedo = LoadTexture(p, "res28");
        Texture normalTex = LoadTexture(p, "res30");
        Texture maskTex = LoadTexture(p, "res32");
        Texture extraBlend = LoadTexture(p, "res33");
        Texture extraColor = LoadTexture(p, "res34");
        Texture extraN = LoadTexture(p, "res35");
        if (albedo == null || normalTex == null || maskTex == null || extraBlend == null || extraColor == null || extraN == null)
            throw new FileNotFoundException("EID" + p.eid + " res28/res30/res32/res33/res34/res35 texture binding is incomplete.");
        m.SetTexture("_Res28", albedo);
        m.SetTexture("_Res30", normalTex);
        m.SetTexture("_Res32", maskTex);
        m.SetTexture("_Res33", extraBlend);
        m.SetTexture("_Res34", extraColor);
        m.SetTexture("_Res35", extraN);
        EditorUtility.SetDirty(m);
        report.AppendLine("EID" + p.eid + ": material res28=RID" + Rid(p, "res28") + " res30=RID" + Rid(p, "res30") + " res32=RID" + Rid(p, "res32") + " res33=RID" + Rid(p, "res33") + " res34=RID" + Rid(p, "res34") + " res35=RID" + Rid(p, "res35") + " PS uniforms37=" + local.Length + "B");'''
new_mat = '''        Texture albedo = LoadTexture(p, "res33");
        Texture normalTex = LoadTexture(p, "res35");
        Texture overlay = LoadTexture(p, "res37");
        Texture extraFade = LoadTexture(p, "res38");
        Texture extraMaskTex = LoadTexture(p, "res39");
        Texture extraBlend = LoadTexture(p, "res40");
        Texture extraColor = LoadTexture(p, "res41");
        Texture extraN = LoadTexture(p, "res42");
        Texture overlayL1 = LoadTexture(p, "res43");
        Texture overlayL2 = LoadTexture(p, "res44");
        if (albedo == null || normalTex == null || overlay == null || extraFade == null || extraMaskTex == null || extraBlend == null || extraColor == null || extraN == null || overlayL1 == null || overlayL2 == null)
            throw new FileNotFoundException("EID" + p.eid + " res33/res35/res37/res38/res39/res40/res41/res42/res43/res44 texture binding is incomplete.");
        m.SetTexture("_Res33", albedo);
        m.SetTexture("_Res35", normalTex);
        m.SetTexture("_Res37", overlay);
        m.SetTexture("_Res38", extraFade);
        m.SetTexture("_Res39", extraMaskTex);
        m.SetTexture("_Res40", extraBlend);
        m.SetTexture("_Res41", extraColor);
        m.SetTexture("_Res42", extraN);
        m.SetTexture("_Res43", overlayL1);
        m.SetTexture("_Res44", overlayL2);
        EditorUtility.SetDirty(m);
        report.AppendLine("EID" + p.eid + ": material res33=RID" + Rid(p, "res33") + " res35=RID" + Rid(p, "res35") + " res37=RID" + Rid(p, "res37") + " res38=RID" + Rid(p, "res38") + " res39=RID" + Rid(p, "res39") + " res40=RID" + Rid(p, "res40") + " res41=RID" + Rid(p, "res41") + " res42=RID" + Rid(p, "res42") + " res43=RID" + Rid(p, "res43") + " res44=RID" + Rid(p, "res44") + " PS uniforms46=" + local.Length + "B");'''
if old_mat not in imp:
    raise SystemExit('CreateMaterial block not found')
imp = imp.replace(old_mat, new_mat)

old_desc = '''            new VertexAttributeDescriptor(VertexAttribute.Position, VertexAttributeFormat.Float32, 3, 0),
            new VertexAttributeDescriptor(VertexAttribute.Normal, VertexAttributeFormat.Float32, 3, 0),
            new VertexAttributeDescriptor(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.Tangent, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord1, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord2, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord3, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.BlendIndices, VertexAttributeFormat.UInt8, 4, 2),'''
new_desc = '''            new VertexAttributeDescriptor(VertexAttribute.Position, VertexAttributeFormat.Float32, 3, 0),
            new VertexAttributeDescriptor(VertexAttribute.Normal, VertexAttributeFormat.Float32, 3, 0),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord1, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord2, VertexAttributeFormat.Float32, 2, 1),
            new VertexAttributeDescriptor(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.Tangent, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.TexCoord3, VertexAttributeFormat.UNorm8, 4, 2),
            new VertexAttributeDescriptor(VertexAttribute.BlendIndices, VertexAttributeFormat.UInt8, 4, 2),'''
if old_desc not in imp:
    raise SystemExit('vertex desc not found')
imp = imp.replace(old_desc, new_desc)

# leftover 215521/215522 should be gone
if '215521' in imp or '215522' in imp or 'uniforms37' in imp or 'uniforms39' in imp:
    hits = []
    for i,line in enumerate(imp.splitlines(), 1):
        if any(x in line for x in ('215521','215522','uniforms37','uniforms39')):
            hits.append('%d:%s' % (i, line.strip()[:160]))
    raise SystemExit('leftover family-40 identifiers:\n' + '\n'.join(hits))
if 'uniforms30' not in imp:
    raise SystemExit('lost uniforms30 instance CB')

(DST/'Editor'/'ColourPass6VS215519PS215520BatchImporter.cs').write_text(imp, encoding='utf8')
print('importer lines', len(imp.splitlines()))

# export
exp = SRC_EXP.read_text(encoding='utf8')
exp_repls = [
    ("MESH_ITEM = {\n    3536: '40.1',\n    3540: '40.2',\n}", "MESH_ITEM = {\n    3448: '52.1',\n}"),
    ('EIDS = [3536, 3540]', 'EIDS = [3448]'),
    ("FAMILY = 'VS215521_PS215522'", "FAMILY = 'VS215519_PS215520'"),
    ('EXPECTED = (215521, 215522)', 'EXPECTED = (215519, 215520)'),
    ('ColourPass6_VS215521_PS215522_Batch', 'ColourPass6_VS215519_PS215520_Batch'),
    ("UNIQUE_MATERIAL = {'res28', 'res30', 'res32', 'res33', 'res34', 'res35'}",
     "UNIQUE_MATERIAL = {'res33', 'res35', 'res37', 'res38', 'res39', 'res40', 'res41', 'res42', 'res43', 'res44'}"),
    ("'4c2374981371b928_PS.spv'", "'86e06de4d07f39b8_PS.spv'"),
    ("'4c2374981371b928_PS.spvasm'", "'86e06de4d07f39b8_PS.spvasm'"),
    ("'VS215521'", "'VS215519'"),
    ("'PS215522'", "'PS215520'"),
    ('VS215521.spv', 'VS215519.spv'),
    ('VS215521.spvasm', 'VS215519.spvasm'),
    ('PS215522.spv', 'PS215520.spv'),
    ('PS215522.spvasm', 'PS215520.spvasm'),
    ("VS215521_PS215522_BatchManifest.json", "VS215519_PS215520_BatchManifest.json"),
    ("export_215521_215522_batch_result.json", "export_215519_215520_batch_result.json"),
    ("'localMaterialCB': 'PS uniforms37 464B packed _P00.._P28'",
     "'localMaterialCB': 'PS uniforms46 768B packed _P00.._P47'"),
    ("'materialIdCB': 'PS uniforms39 16B'",
     "'materialIdCB': 'PS uniforms48 16B'"),
]
for a,b in exp_repls:
    if a not in exp:
        raise SystemExit('export fragment missing: ' + a[:80])
    exp = exp.replace(a, b)

old_roots = '''    search_roots = [
        os.path.join(ASSETS, 'ColourPass6_VS215519_PS215520_Batch', 'TextureDatabase'),
        os.path.join(ASSETS, 'ColourPass6_VS215511_PS215514_Batch', 'TextureDatabase'),
        os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'ImportedTextures'),
        os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'Resources', 'EID3336Textures'),
        os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'Resources', 'EID3332Textures'),
        os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'Resources', 'EID3490Textures'),
    ]'''
new_roots = '''    search_roots = [
        os.path.join(ASSETS, 'ColourPass6_VS215519_PS215520_Batch', 'TextureDatabase'),
        os.path.join(ASSETS, 'ColourPass6_VS215521_PS215522_Batch', 'TextureDatabase'),
        os.path.join(ASSETS, 'ColourPass6_VS215511_PS215514_Batch', 'TextureDatabase'),
        os.path.join(ASSETS, 'ColourPass6_VS238900_PS238901_Batch', 'TextureDatabase'),
        os.path.join(ASSETS, 'ColourPass6_VS209986_PS209987_Batch', 'TextureDatabase'),
        os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'ImportedTextures'),
        os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'Resources', 'EID3336Textures'),
        os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'Resources', 'EID3332Textures'),
        os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'Resources', 'EID3490Textures'),
    ]'''
if old_roots not in exp:
    raise SystemExit('search_roots not found after family rename')
exp = exp.replace(old_roots, new_roots)
if '3536' in exp or '3540' in exp or 'uniforms37' in exp:
    hits = [ln.strip()[:160] for ln in exp.splitlines() if any(x in ln for x in ('3536','3540','uniforms37','215521','215522','4c237498'))]
    raise SystemExit('export leftovers: ' + str(hits))
(ROOT/'.rdctools'/'export_215519_215520_batch.py').write_text(exp, encoding='utf8')
print('export ok')
print('dst', DST)
