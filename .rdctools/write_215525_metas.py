from pathlib import Path

ROOT = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215525_PS215526_Batch')

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

MONO = '''fileFormatVersion: 2
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
    ROOT.parent / 'ColourPass6_VS215525_PS215526_Batch.meta': FOLDER.format(guid='215525d4e5f647890abcde4455667700'),
    ROOT / 'Shaders' / 'EID215525215526GBuffer.shader.meta': SHADER.format(guid='215525d4e5f647890abcde4455667701'),
    ROOT / 'Shaders' / 'EID215525215526GBuffer.hlsl.meta': HLSL.format(guid='215525d4e5f647890abcde4455667702'),
    ROOT / 'Editor' / 'ColourPass6VS215525PS215526BatchImporter.cs.meta': MONO.format(guid='215525d4e5f647890abcde4455667703'),
    ROOT / 'Runtime' / 'EID215525DrawProfile.cs.meta': MONO.format(guid='215525d4e5f647890abcde4455667704'),
    ROOT / 'Editor.meta': FOLDER.format(guid='215525d4e5f647890abcde4455667705'),
    ROOT / 'Runtime.meta': FOLDER.format(guid='215525d4e5f647890abcde4455667706'),
    ROOT / 'Shaders.meta': FOLDER.format(guid='215525d4e5f647890abcde4455667707'),
    ROOT / 'TextureDatabase.meta': FOLDER.format(guid='215525d4e5f647890abcde4455667708'),
    ROOT / 'Geometry.meta': FOLDER.format(guid='215525d4e5f647890abcde4455667709'),
    ROOT / 'Materials.meta': FOLDER.format(guid='215525d4e5f647890abcde445566770a'),
    ROOT / 'Profiles.meta': FOLDER.format(guid='215525d4e5f647890abcde445566770b'),
    ROOT / 'Captured.meta': FOLDER.format(guid='215525d4e5f647890abcde445566770c'),
    ROOT / 'Geometry' / 'Meshes.meta': FOLDER.format(guid='215525d4e5f647890abcde4455667710'),
    ROOT / 'Captured' / 'Geometry.meta': FOLDER.format(guid='215525d4e5f647890abcde4455667711'),
    ROOT / 'Captured' / 'CBuffers.meta': FOLDER.format(guid='215525d4e5f647890abcde4455667712'),
    ROOT / 'Captured' / 'Instances.meta': FOLDER.format(guid='215525d4e5f647890abcde4455667713'),
}

for path, text in files.items():
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding='utf8')
    guid = [ln for ln in text.splitlines() if ln.startswith('guid: ')][0].split()[1]
    assert len(guid) == 32 and all(c in '0123456789abcdef' for c in guid), (path, guid)
    print('wrote', path.relative_to(ROOT.parent), guid)

print('ok', len(files))
