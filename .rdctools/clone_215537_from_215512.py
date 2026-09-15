import os

SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215512_PS215513_Batch'
DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215537_PS215538_Batch'
VAL = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/ColourPass6_VS215537'

FILES = [
    ('Runtime/EID215512DrawProfile.cs', 'Runtime/EID215537DrawProfile.cs'),
]


def rewrite(text):
    text = text.replace('EID215512DrawProfile', 'EID215537DrawProfile')
    text = text.replace('VS215512 PS215513', 'VS215537 PS215538')
    text = text.replace('EID215512', 'EID215537')
    text = text.replace('215512', '215537')
    text = text.replace('215513', '215538')
    return text


FOLDER_GUIDS = {
    '': '215537d4e5f647890abcde4455667700',
    'Editor': '215537d4e5f647890abcde4455667705',
    'Runtime': '215537d4e5f647890abcde4455667706',
    'Shaders': '215537d4e5f647890abcde4455667707',
    'Captured': '215537d4e5f647890abcde4455667708',
    'Geometry': '215537d4e5f647890abcde4455667709',
    'Materials': '215537d4e5f647890abcde445566770a',
    'Profiles': '215537d4e5f647890abcde445566770b',
    'TextureDatabase': '215537d4e5f647890abcde445566770c',
    'Geometry/Meshes': '215537d4e5f647890abcde445566770d',
    'Captured/Geometry': '215537d4e5f647890abcde445566770e',
    'Captured/CBuffers': '215537d4e5f647890abcde445566770f',
    'Captured/Instances': '215537d4e5f647890abcde4455667710',
}

FILE_GUIDS = {
    'Shaders/EID215537215538GBuffer.shader': ('215537d4e5f647890abcde4455667701', 'ShaderImporter'),
    'Shaders/EID215537215538GBuffer.hlsl': ('215537d4e5f647890abcde4455667702', 'ShaderIncludeImporter'),
    'Editor/ColourPass6VS215537PS215538BatchImporter.cs': ('215537d4e5f647890abcde4455667703', 'MonoImporter'),
    'Runtime/EID215537DrawProfile.cs': ('215537d4e5f647890abcde4455667704', 'MonoImporter'),
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
