import os

SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS209990_PS209991_Batch'
DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215543_PS215544_Batch'
VAL = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/ColourPass6_VS215543'

FILES = [
    ('Runtime/EID209990DrawProfile.cs', 'Runtime/EID215543DrawProfile.cs'),
]


def rewrite(text):
    text = text.replace('EID209990DrawProfile', 'EID215543DrawProfile')
    text = text.replace('VS209990 PS209991', 'VS215543 PS215544')
    text = text.replace('EID209990', 'EID215543')
    text = text.replace('209990', '215543')
    text = text.replace('209991', '215544')
    return text


FOLDER_GUIDS = {
    '': '215543d4e5f647890abcde4455667700',
    'Editor': '215543d4e5f647890abcde4455667705',
    'Runtime': '215543d4e5f647890abcde4455667706',
    'Shaders': '215543d4e5f647890abcde4455667707',
    'Captured': '215543d4e5f647890abcde4455667708',
    'Geometry': '215543d4e5f647890abcde4455667709',
    'Materials': '215543d4e5f647890abcde445566770a',
    'Profiles': '215543d4e5f647890abcde445566770b',
    'TextureDatabase': '215543d4e5f647890abcde445566770c',
    'Geometry/Meshes': '215543d4e5f647890abcde445566770d',
    'Captured/Geometry': '215543d4e5f647890abcde445566770e',
    'Captured/CBuffers': '215543d4e5f647890abcde445566770f',
    'Captured/Instances': '215543d4e5f647890abcde4455667710',
}

FILE_GUIDS = {
    'Shaders/EID215543215544GBuffer.shader': ('215543d4e5f647890abcde4455667701', 'ShaderImporter'),
    'Shaders/EID215543215544GBuffer.hlsl': ('215543d4e5f647890abcde4455667702', 'ShaderIncludeImporter'),
    'Editor/ColourPass6VS215543PS215544BatchImporter.cs': ('215543d4e5f647890abcde4455667703', 'MonoImporter'),
    'Runtime/EID215543DrawProfile.cs': ('215543d4e5f647890abcde4455667704', 'MonoImporter'),
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


os.makedirs(DST, exist_ok=True)
for d in (
    'Editor', 'Runtime', 'Shaders', 'Geometry/Meshes', 'Materials', 'Profiles',
    'TextureDatabase', 'Captured/Geometry', 'Captured/CBuffers', 'Captured/Instances',
):
    os.makedirs(os.path.join(DST, d), exist_ok=True)
os.makedirs(VAL, exist_ok=True)

for rel_src, rel_dst in FILES:
    src = os.path.join(SRC, rel_src)
    dst = os.path.join(DST, rel_dst)
    text = rewrite(open(src, encoding='utf8').read())
    open(dst, 'w', encoding='utf8', newline='\n').write(text)
    print('wrote', rel_dst, os.path.getsize(dst))

open(DST + '.meta', 'w', encoding='utf8', newline='\n').write(folder_meta(FOLDER_GUIDS['']))
for rel, guid in FOLDER_GUIDS.items():
    if not rel:
        continue
    open(os.path.join(DST, rel + '.meta'), 'w', encoding='utf8', newline='\n').write(folder_meta(guid))
for rel, (guid, importer) in FILE_GUIDS.items():
    path = os.path.join(DST, rel + '.meta')
    os.makedirs(os.path.dirname(path), exist_ok=True)
    open(path, 'w', encoding='utf8', newline='\n').write(file_meta(guid, importer))

bad = []
for rel, guid in FOLDER_GUIDS.items():
    if len(guid) != 32:
        bad.append(('folder', rel, guid, len(guid)))
for rel, (guid, _) in FILE_GUIDS.items():
    if len(guid) != 32:
        bad.append(('file', rel, guid, len(guid)))
print('bad', bad)
print('ok')
