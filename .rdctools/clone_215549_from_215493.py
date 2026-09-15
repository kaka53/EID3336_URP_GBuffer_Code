import os

SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215493_PS215494_Batch'
DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215549_PS215550_Batch'
VAL = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/ColourPass6_VS215549'

FOLDER_GUIDS = {
    '': '215549d4e5f647890abcde4455667700',
    'Editor': '215549d4e5f647890abcde4455667705',
    'Runtime': '215549d4e5f647890abcde4455667706',
    'Shaders': '215549d4e5f647890abcde4455667707',
    'TextureDatabase': '215549d4e5f647890abcde4455667708',
    'Materials': '215549d4e5f647890abcde4455667709',
    'Profiles': '215549d4e5f647890abcde445566770a',
    'Geometry': '215549d4e5f647890abcde445566770b',
    'Captured': '215549d4e5f647890abcde445566770c',
    'Geometry/Meshes': '215549d4e5f647890abcde445566770d',
    'Captured/Geometry': '215549d4e5f647890abcde445566770e',
    'Captured/CBuffers': '215549d4e5f647890abcde445566770f',
    'Captured/Instances': '215549d4e5f647890abcde4455667710',
}

FILE_GUIDS = {
    'Shaders/EID215549215550GBuffer.shader': ('215549d4e5f647890abcde4455667701', 'ShaderImporter'),
    'Shaders/EID215549215550GBuffer.hlsl': ('215549d4e5f647890abcde4455667702', 'ShaderIncludeImporter'),
    'Editor/ColourPass6VS215549PS215550BatchImporter.cs': ('215549d4e5f647890abcde4455667703', 'MonoImporter'),
    'Runtime/EID215549DrawProfile.cs': ('215549d4e5f647890abcde4455667704', 'MonoImporter'),
}


def folder_meta(guid):
    return (
        'fileFormatVersion: 2\n'
        'guid: %s\n'
        'folderAsset: yes\n'
        'DefaultImporter:\n'
        '  externalObjects: {}\n'
        '  userData:\n'
        '  assetBundleName:\n'
        '  assetBundleVariant:\n' % guid
    )


def file_meta(guid, importer):
    if importer == 'MonoImporter':
        return (
            'fileFormatVersion: 2\n'
            'guid: %s\n'
            'MonoImporter:\n'
            '  externalObjects: {}\n'
            '  serializedVersion: 2\n'
            '  defaultReferences: []\n'
            '  executionOrder: 0\n'
            '  icon: {instanceID: 0}\n'
            '  userData:\n'
            '  assetBundleName:\n'
            '  assetBundleVariant:\n' % guid
        )
    if importer == 'ShaderIncludeImporter':
        return (
            'fileFormatVersion: 2\n'
            'guid: %s\n'
            'ShaderIncludeImporter:\n'
            '  externalObjects: {}\n'
            '  userData:\n'
            '  assetBundleName:\n'
            '  assetBundleVariant:\n' % guid
        )
    return (
        'fileFormatVersion: 2\n'
        'guid: %s\n'
        'ShaderImporter:\n'
        '  externalObjects: {}\n'
        '  defaultTextures: []\n'
        '  nonModifiableTextures: []\n'
        '  userData:\n'
        '  assetBundleName:\n'
        '  assetBundleVariant:\n' % guid
    )


def rewrite_ids(text):
    text = text.replace('EID215493DrawProfile', 'EID215549DrawProfile')
    text = text.replace('VS215493 PS215494', 'VS215549 PS215550')
    text = text.replace('EID215493', 'EID215549')
    text = text.replace('215493', '215549')
    text = text.replace('215494', '215550')
    return text


def rewrite_importer(text):
    text = rewrite_ids(text)
    unique = [
        ('static readonly int[] ExpectedEIDs = { 2528, 2533 };',
         'static readonly int[] ExpectedEIDs = { 3734 };'),
        ('static readonly int ExpectedInstances = 3;\n    static readonly int ExpectedLayoutVariants = 2;',
         'static readonly int ExpectedInstances = 2;\n    static readonly int ExpectedLayoutVariants = 1;\n    static readonly int ExpectedUniqueMeshes = 1;'),
        ('throw new InvalidDataException("Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 36.1-36.2.");',
         'throw new InvalidDataException("Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 57.1.");'),
        ('throw new InvalidDataException("Expected EIDs 36.1-36.2, got " + string.Join(",", got));',
         'throw new InvalidDataException("Expected EIDs 57.1, got " + string.Join(",", got));'),
        ('[MenuItem("Tools/Colour Pass 6/Import EID 36.1-36.2 (VS215549 PS215550)")]',
         '[MenuItem("Tools/Colour Pass 6/Import EID 57.1 (VS215549 PS215550)")]'),
        ('if (Rid(p, "res23") == 0 || Rid(p, "res25") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res23/res25.");\n        byte[] local = ReadCB(p, "PS", "uniforms28");\n        if (local.Length < 416) throw new InvalidDataException("EID" + p.eid + " PS uniforms28 expected 416 bytes, got " + local.Length);',
         'if (Rid(p, "res23") == 0 || Rid(p, "res25") == 0 || Rid(p, "res27") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res23/res25/res27.");\n        byte[] local = ReadCB(p, "PS", "uniforms30");\n        if (local.Length < 432) throw new InvalidDataException("EID" + p.eid + " PS uniforms30 expected 432 bytes, got " + local.Length);'),
        ('byte[] local = ReadCB(p, "PS", "uniforms28");\n        for (int i = 0; i < 26; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms30");',
         'byte[] local = ReadCB(p, "PS", "uniforms30");\n        for (int i = 0; i < 27; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms32");'),
        ('Texture albedo = LoadTexture(p, "res23");\n        Texture normalTex = LoadTexture(p, "res25");\n        if (albedo == null || normalTex == null)\n            throw new FileNotFoundException("EID" + p.eid + " res23/res25 texture binding is incomplete.");\n        m.SetTexture("_Res23", albedo);\n        m.SetTexture("_Res25", normalTex);',
         'Texture albedo = LoadTexture(p, "res23");\n        Texture normalTex = LoadTexture(p, "res25");\n        Texture extra = LoadTexture(p, "res27");\n        if (albedo == null || normalTex == null || extra == null)\n            throw new FileNotFoundException("EID" + p.eid + " res23/res25/res27 texture binding is incomplete.");\n        m.SetTexture("_Res23", albedo);\n        m.SetTexture("_Res25", normalTex);\n        m.SetTexture("_Res27", extra);'),
        ('report.AppendLine("EID" + p.eid + ": material res23=RID" + Rid(p, "res23") + " res25=RID" + Rid(p, "res25") + " PS uniforms28=" + local.Length + "B");',
         'report.AppendLine("EID" + p.eid + ": material res23=RID" + Rid(p, "res23") + " res25=RID" + Rid(p, "res25") + " res27=RID" + Rid(p, "res27") + " PS uniforms30=" + local.Length + "B");'),
        ('if (instances != ExpectedInstances) throw new InvalidDataException("36.1-36.2 instance total expected " + ExpectedInstances + ", got " + instances);\n        int layouts = manifest.profiles.Select(LayoutKey).Distinct().Count();\n        if (layouts != ExpectedLayoutVariants) throw new InvalidDataException("Expected " + ExpectedLayoutVariants + " captured vertex layout variants, got " + layouts);',
         'if (instances != ExpectedInstances) throw new InvalidDataException("57.1 instance total expected " + ExpectedInstances + ", got " + instances);\n        int layouts = manifest.profiles.Select(LayoutKey).Distinct().Count();\n        if (layouts != ExpectedLayoutVariants) throw new InvalidDataException("Expected " + ExpectedLayoutVariants + " captured vertex layout variants, got " + layouts);\n        int uniqueMeshes = generated.Values.Select(x => x.mesh).Distinct().Count();\n        if (uniqueMeshes != ExpectedUniqueMeshes) throw new InvalidDataException("Expected " + ExpectedUniqueMeshes + " unique meshes, got " + uniqueMeshes);'),
        ('report.AppendLine("layoutVariants=" + layouts);\n        report.AppendLine("vertexAttributes=COMPLETE_9_OF_9");',
         'report.AppendLine("layoutVariants=" + layouts);\n        report.AppendLine("uniqueMeshes=" + uniqueMeshes);\n        report.AppendLine("vertexAttributes=COMPLETE_9_OF_9");'),
        ('audit.Insert(0, "# VS215549 / PS215550 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `36.1-36.2`\\n- Layout variants: `" + layouts + "` (`3572236fc9e4b455`, `a554ffdeec97df50`)\\n- Shader: live Unity VP; unique res23/res25; PS uniforms28 416B; Cull Off; ZWrite On; stencil 0; skip skin (flags 0); overlay from albedo/normal + uniforms20\\n\\n");',
         'audit.Insert(0, "# VS215549 / PS215550 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `57.1`\\n- Layout variants: `" + layouts + "` (`d6a844f320196881`)\\n- Shader: live Unity VP; unique res23/res25/res27; PS uniforms30 432B; Cull Back; ZWrite Off; ZTest Equal; stencil 0; Queue Geometry+10; skip skin; per-instance GOs; packed NORMAL.x oct 0.001956; DXT5nm .wy; overlay-lit RT0 from extra.w + uniforms20; do not merge with family 36\\n\\n");'),
    ]
    missing = []
    for a, b in unique:
        n = text.count(a)
        if n != 1:
            missing.append((n, a[:240]))
        else:
            text = text.replace(a, b, 1)
    return text, missing


os.makedirs(DST, exist_ok=True)
for d in (
    'Editor', 'Runtime', 'Shaders', 'Geometry/Meshes', 'Materials', 'Profiles',
    'TextureDatabase', 'Captured/Geometry', 'Captured/CBuffers', 'Captured/Instances',
):
    os.makedirs(os.path.join(DST, d), exist_ok=True)
os.makedirs(VAL, exist_ok=True)

src_profile = open(os.path.join(SRC, 'Runtime/EID215493DrawProfile.cs'), encoding='utf8').read()
open(os.path.join(DST, 'Runtime/EID215549DrawProfile.cs'), 'w', encoding='utf8', newline='\n').write(rewrite_ids(src_profile))

src_imp = open(os.path.join(SRC, 'Editor/ColourPass6VS215493PS215494BatchImporter.cs'), encoding='utf8').read()
imp, missing = rewrite_importer(src_imp)
open(os.path.join(DST, 'Editor/ColourPass6VS215549PS215550BatchImporter.cs'), 'w', encoding='utf8', newline='\n').write(imp)

open(DST + '.meta', 'w', encoding='utf8', newline='\n').write(folder_meta(FOLDER_GUIDS['']))
for rel, guid in FOLDER_GUIDS.items():
    if not rel:
        continue
    open(os.path.join(DST, rel + '.meta'), 'w', encoding='utf8', newline='\n').write(folder_meta(guid))
for rel, (guid, importer) in FILE_GUIDS.items():
    path = os.path.join(DST, rel + '.meta')
    os.makedirs(os.path.dirname(path), exist_ok=True)
    open(path, 'w', encoding='utf8', newline='\n').write(file_meta(guid, importer))

print('missing', missing)
leftover = []
for needle in ['2528', '2533', '36.1', '36.2', '215493', '215494', 'i < 26', 'uniforms28 expected 416', 'PS uniforms28=', 'res23/res25 texture', 'Cull Off', 'ZWrite On', 'family 36']:
    if needle in imp:
        leftover.append((needle, imp.count(needle)))
print('leftover', leftover)
print('uniforms28', imp.count('uniforms28'))
print('uniforms30', imp.count('uniforms30'))
print('uniforms32', imp.count('uniforms32'))
print('uniforms20', imp.count('uniforms20'))
print('uniforms17', imp.count('uniforms17'))
print('res27', imp.count('res27'))
print('ReadFloat(globals, 416)', imp.count('ReadFloat(globals, 416)'))
print('guid lens', sorted({len(g) for g in list(FOLDER_GUIDS.values()) + [g for g, _ in FILE_GUIDS.values()]}))
print('shader exists', os.path.exists(os.path.join(DST, 'Shaders/EID215549215550GBuffer.shader')))
print('hlsl exists', os.path.exists(os.path.join(DST, 'Shaders/EID215549215550GBuffer.hlsl')))
