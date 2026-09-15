import os

ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215481_PS215482_Batch'
FOLDER = '''fileFormatVersion: 2
guid: {guid}
folderAsset: yes
DefaultImporter:
  externalObjects: {{}}
  userData:
  assetBundleName:
  assetBundleVariant:
'''
SHADER = '''fileFormatVersion: 2
guid: {guid}
ShaderImporter:
  externalObjects: {{}}
  defaultTextures: []
  nonModifiableTextures: []
  userData:
  assetBundleName:
  assetBundleVariant:
'''
HLSL = '''fileFormatVersion: 2
guid: {guid}
ShaderIncludeImporter:
  externalObjects: {{}}
  userData:
  assetBundleName:
  assetBundleVariant:
'''
CS = '''fileFormatVersion: 2
guid: {guid}
MonoImporter:
  externalObjects: {{}}
  serializedVersion: 2
  defaultReferences: []
  executionOrder: 0
  icon: {{instanceID: 0}}
  userData:
  assetBundleName:
  assetBundleVariant:
'''

files = {
    ROOT + '.meta': ('215481d4e5f647890abcde4455667700', FOLDER),
    os.path.join(ROOT, 'Editor.meta'): ('215481d4e5f647890abcde4455667705', FOLDER),
    os.path.join(ROOT, 'Runtime.meta'): ('215481d4e5f647890abcde4455667706', FOLDER),
    os.path.join(ROOT, 'Shaders.meta'): ('215481d4e5f647890abcde4455667707', FOLDER),
    os.path.join(ROOT, 'Captured.meta'): ('215481d4e5f647890abcde4455667708', FOLDER),
    os.path.join(ROOT, 'Geometry.meta'): ('215481d4e5f647890abcde4455667709', FOLDER),
    os.path.join(ROOT, 'Materials.meta'): ('215481d4e5f647890abcde445566770a', FOLDER),
    os.path.join(ROOT, 'Profiles.meta'): ('215481d4e5f647890abcde445566770b', FOLDER),
    os.path.join(ROOT, 'TextureDatabase.meta'): ('215481d4e5f647890abcde445566770c', FOLDER),
    os.path.join(ROOT, 'Shaders/EID215481215482GBuffer.shader.meta'): ('215481d4e5f647890abcde4455667701', SHADER),
    os.path.join(ROOT, 'Shaders/EID215481215482GBuffer.hlsl.meta'): ('215481d4e5f647890abcde4455667702', HLSL),
    os.path.join(ROOT, 'Editor/ColourPass6VS215481PS215482BatchImporter.cs.meta'): ('215481d4e5f647890abcde4455667703', CS),
    os.path.join(ROOT, 'Runtime/EID215481DrawProfile.cs.meta'): ('215481d4e5f647890abcde4455667704', CS),
}
for path, (guid, tmpl) in files.items():
    if len(guid) != 32:
        raise SystemExit('bad guid %s %d' % (guid, len(guid)))
    open(path, 'w', encoding='utf8', newline='\n').write(tmpl.format(guid=guid))
    print(os.path.basename(path), guid)
