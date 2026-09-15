import os

SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS238900_PS238901_Batch'
DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215547_PS215548_Batch'
VAL = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/ColourPass6_VS215547'

FOLDER_GUIDS = {
    '': '215547d4e5f647890abcde4455667700',
    'Editor': '215547d4e5f647890abcde4455667705',
    'Runtime': '215547d4e5f647890abcde4455667706',
    'Shaders': '215547d4e5f647890abcde4455667707',
    'TextureDatabase': '215547d4e5f647890abcde4455667708',
    'Materials': '215547d4e5f647890abcde4455667709',
    'Profiles': '215547d4e5f647890abcde445566770a',
    'Geometry': '215547d4e5f647890abcde445566770b',
    'Captured': '215547d4e5f647890abcde445566770c',
    'Geometry/Meshes': '215547d4e5f647890abcde445566770d',
    'Captured/Geometry': '215547d4e5f647890abcde445566770e',
    'Captured/CBuffers': '215547d4e5f647890abcde445566770f',
    'Captured/Instances': '215547d4e5f647890abcde4455667710',
}

FILE_GUIDS = {
    'Shaders/EID215547215548GBuffer.shader': ('215547d4e5f647890abcde4455667701', 'ShaderImporter'),
    'Shaders/EID215547215548GBuffer.hlsl': ('215547d4e5f647890abcde4455667702', 'ShaderIncludeImporter'),
    'Editor/ColourPass6VS215547PS215548BatchImporter.cs': ('215547d4e5f647890abcde4455667703', 'MonoImporter'),
    'Runtime/EID215547DrawProfile.cs': ('215547d4e5f647890abcde4455667704', 'MonoImporter'),
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
    text = text.replace('EID238900DrawProfile', 'EID215547DrawProfile')
    text = text.replace('VS238900 PS238901', 'VS215547 PS215548')
    text = text.replace('EID238900', 'EID215547')
    text = text.replace('238900', '215547')
    text = text.replace('238901', '215548')
    return text


def rewrite_importer(text):
    text = rewrite_ids(text)
    unique = [
        ('static readonly int[] ExpectedEIDs = { 3527, 3531 };',
         'static readonly int[] ExpectedEIDs = { 3729 };'),
        ('static readonly int ExpectedInstances = 2;',
         'static readonly int ExpectedInstances = 10;'),
        ('static readonly int ExpectedUniqueMeshes = 2;',
         'static readonly int ExpectedUniqueMeshes = 1;'),
        ('throw new InvalidDataException("Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 48.1-48.2.");',
         'throw new InvalidDataException("Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 56.1.");'),
        ('throw new InvalidDataException("Expected EIDs 48.1-48.2, got " + string.Join(",", got));',
         'throw new InvalidDataException("Expected EIDs 56.1, got " + string.Join(",", got));'),
        ('[MenuItem("Tools/Colour Pass 6/Import EID 48.1-48.2 (VS215547 PS215548)")]',
         '[MenuItem("Tools/Colour Pass 6/Import EID 56.1 (VS215547 PS215548)")]'),
        ('if (local.Length < 496) throw new InvalidDataException("EID" + p.eid + " PS uniforms44 expected 496 bytes, got " + local.Length);',
         'if (local.Length < 512) throw new InvalidDataException("EID" + p.eid + " PS uniforms44 expected 512 bytes, got " + local.Length);'),
        ('for (int i = 0; i < 31; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));',
         'for (int i = 0; i < 32; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));'),
        ('if (instances != ExpectedInstances) throw new InvalidDataException("48.1-48.2 instance total expected " + ExpectedInstances + ", got " + instances);',
         'if (instances != ExpectedInstances) throw new InvalidDataException("56.1 instance total expected " + ExpectedInstances + ", got " + instances);'),
        ('audit.Insert(0, "# VS215547 / PS215548 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `48.1-48.2`\\n- Layout variants: `" + layouts + "` (`68a569b2f8bd2ed2`)\\n- Shader: live Unity VP; unique res34/res36/res38 + reused res40/res41/res42; PS uniforms44 496B; Cull Back; ZWrite On; ZTest GEqual; stencil 0; skip skin; per-instance GOs; packed NORMAL.x oct 0.0020; keep UV1/input6/input7; do not merge with family 38 or 40\\n\\n");',
         'audit.Insert(0, "# VS215547 / PS215548 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `56.1`\\n- Layout variants: `" + layouts + "` (`68a569b2f8bd2ed2`)\\n- Shader: live Unity VP; unique res34/res36/res38 + reused res40/res41/res42; PS uniforms44 512B; Cull Off; ZWrite Off; ZTest Equal; stencil 0; Queue Geometry+10; skip skin; per-instance GOs; packed NORMAL.x oct 0.0020; keep UV1/input6/input7; extra uniforms _P23.._P28; do not merge with family 48\\n\\n");'),
    ]
    missing = []
    for a, b in unique:
        n = text.count(a)
        if n != 1:
            missing.append((n, a[:220]))
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

src_profile = open(os.path.join(SRC, 'Runtime/EID238900DrawProfile.cs'), encoding='utf8').read()
open(os.path.join(DST, 'Runtime/EID215547DrawProfile.cs'), 'w', encoding='utf8', newline='\n').write(rewrite_ids(src_profile))

src_imp = open(os.path.join(SRC, 'Editor/ColourPass6VS238900PS238901BatchImporter.cs'), encoding='utf8').read()
imp, missing = rewrite_importer(src_imp)
open(os.path.join(DST, 'Editor/ColourPass6VS215547PS215548BatchImporter.cs'), 'w', encoding='utf8', newline='\n').write(imp)

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
for needle in ['238900', '238901', '3527', '3531', '48.1', '48.2', '496', '< 31', 'i < 31', 'Cull Back', 'ZTest GEqual', 'ZWrite On', 'family 38', 'family 40']:
    if needle in imp:
        leftover.append((needle, imp.count(needle)))
print('leftover', leftover)
print('uniforms30', imp.count('uniforms30'))
print('uniforms25', imp.count('uniforms25'))
print('uniforms22', imp.count('uniforms22'))
print('uniforms44', imp.count('uniforms44'))
print('uniforms46', imp.count('uniforms46'))
print('res34', imp.count('res34'))
print('guid lens', sorted({len(g) for g in list(FOLDER_GUIDS.values()) + [g for g, _ in FILE_GUIDS.values()]}))
print('shader exists', os.path.exists(os.path.join(DST, 'Shaders/EID215547215548GBuffer.shader')))
print('hlsl exists', os.path.exists(os.path.join(DST, 'Shaders/EID215547215548GBuffer.hlsl')))
