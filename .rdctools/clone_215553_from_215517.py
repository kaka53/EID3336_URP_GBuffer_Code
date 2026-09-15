import os

SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215517_PS215518_Batch'
DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215553_PS215554_Batch'
VAL = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/ColourPass6_VS215553'

FILES = [
    ('Runtime/EID215517DrawProfile.cs', 'Runtime/EID215553DrawProfile.cs'),
]


def rewrite(text):
    text = text.replace('EID215517DrawProfile', 'EID215553DrawProfile')
    text = text.replace('VS215517 PS215518', 'VS215553 PS215554')
    text = text.replace('EID215517', 'EID215553')
    text = text.replace('215517', '215553')
    text = text.replace('215518', '215554')
    return text


FOLDER_GUIDS = {
    '': '215553d4e5f647890abcde4455667700',
    'Editor': '215553d4e5f647890abcde4455667705',
    'Runtime': '215553d4e5f647890abcde4455667706',
    'Shaders': '215553d4e5f647890abcde4455667707',
    'Captured': '215553d4e5f647890abcde4455667708',
    'Geometry': '215553d4e5f647890abcde4455667709',
    'Materials': '215553d4e5f647890abcde445566770a',
    'Profiles': '215553d4e5f647890abcde445566770b',
    'TextureDatabase': '215553d4e5f647890abcde445566770c',
    'Geometry/Meshes': '215553d4e5f647890abcde445566770d',
    'Captured/Geometry': '215553d4e5f647890abcde445566770e',
    'Captured/CBuffers': '215553d4e5f647890abcde445566770f',
    'Captured/Instances': '215553d4e5f647890abcde4455667710',
}

FILE_GUIDS = {
    'Shaders/EID215553215554GBuffer.shader': ('215553d4e5f647890abcde4455667701', 'ShaderImporter'),
    'Shaders/EID215553215554GBuffer.hlsl': ('215553d4e5f647890abcde4455667702', 'ShaderIncludeImporter'),
    'Editor/ColourPass6VS215553PS215554BatchImporter.cs': ('215553d4e5f647890abcde4455667703', 'MonoImporter'),
    'Runtime/EID215553DrawProfile.cs': ('215553d4e5f647890abcde4455667704', 'MonoImporter'),
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
