import os

ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215843_PS215844_Batch'
TEMPLATE = (
    'fileFormatVersion: 2\n'
    'guid: %s\n'
    'folderAsset: yes\n'
    'DefaultImporter:\n'
    '  externalObjects: {}\n'
    '  userData: \n'
    '  assetBundleName: \n'
    '  assetBundleVariant: \n'
)
FOLDERS = {
    'Editor': '215843d4e5f647890abcde4455667710',
    'Runtime': '215843d4e5f647890abcde4455667711',
    'Shaders': '215843d4e5f647890abcde4455667712',
    'Geometry': '215843d4e5f647890abcde4455667713',
    'Geometry/Meshes': '215843d4e5f647890abcde4455667714',
    'Captured': '215843d4e5f647890abcde4455667715',
    'Captured/Geometry': '215843d4e5f647890abcde4455667716',
    'Captured/CBuffers': '215843d4e5f647890abcde4455667717',
    'Captured/Instances': '215843d4e5f647890abcde4455667718',
    'Materials': '215843d4e5f647890abcde4455667719',
    'Profiles': '215843d4e5f647890abcde445566771a',
    'TextureDatabase': '215843d4e5f647890abcde445566771b',
}
for rel, guid in FOLDERS.items():
    assert len(guid) == 32, (rel, guid, len(guid))
    path = os.path.join(ROOT, rel)
    os.makedirs(path, exist_ok=True)
    open(path + '.meta', 'w', encoding='utf8', newline='\n').write(TEMPLATE % guid)
    print(rel, guid)
print('ok')
