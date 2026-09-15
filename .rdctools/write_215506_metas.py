from pathlib import Path

root = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215506_PS215508_Batch')

folder_meta = """fileFormatVersion: 2
guid: {guid}
folderAsset: yes
DefaultImporter:
  externalObjects: {{}}
  userData:
  assetBundleName:
  assetBundleVariant:
"""
shader_meta = """fileFormatVersion: 2
guid: {guid}
ShaderImporter:
  externalObjects: {{}}
  defaultTextures: []
  nonModifiableTextures: []
  userData:
  assetBundleName:
  assetBundleVariant:
"""
hlsl_meta = """fileFormatVersion: 2
guid: {guid}
ShaderIncludeImporter:
  externalObjects: {{}}
  userData:
  assetBundleName:
  assetBundleVariant:
"""
cs_meta = """fileFormatVersion: 2
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
"""

folders = [
    (root / 'Shaders.meta', '21550600000000000000000000000002'),
    (root / 'Runtime.meta', '21550600000000000000000000000003'),
    (root / 'Editor.meta', '21550600000000000000000000000004'),
    (root / 'Profiles.meta', '21550600000000000000000000000005'),
    (root / 'Geometry.meta', '21550600000000000000000000000006'),
    (root / 'Materials.meta', '21550600000000000000000000000007'),
    (root / 'Captured.meta', '21550600000000000000000000000008'),
    (root / 'TextureDatabase.meta', '21550600000000000000000000000009'),
    (root / 'Geometry/Meshes.meta', '2155060000000000000000000000000a'),
    (root / 'Captured/CBuffers.meta', '2155060000000000000000000000000b'),
    (root / 'Captured/Geometry.meta', '2155060000000000000000000000000c'),
]
for path, guid in folders:
    path.write_text(folder_meta.format(guid=guid), encoding='utf8')

(root.parent / 'ColourPass6_VS215506_PS215508_Batch.meta').write_text(
    folder_meta.format(guid='21550600000000000000000000000001'), encoding='utf8')
(root / 'Shaders/EID215506215508GBuffer.shader.meta').write_text(
    shader_meta.format(guid='215506b2c3d4e5f647890abcde000030'), encoding='utf8')
(root / 'Shaders/EID215506215508GBuffer.hlsl.meta').write_text(
    hlsl_meta.format(guid='215506a1b2c3d4e5f647890abcde0030'), encoding='utf8')
(root / 'Runtime/EID215506DrawProfile.cs.meta').write_text(
    cs_meta.format(guid='215506c3d4e5f647890abcde33330030'), encoding='utf8')
(root / 'Editor/ColourPass6VS215506PS215508BatchImporter.cs.meta').write_text(
    cs_meta.format(guid='215506d4e5f647890abcde4455667730'), encoding='utf8')

print('metas ok')
for p in sorted(root.rglob('*.meta')):
    for line in p.read_text(encoding='utf8').splitlines():
        if line.startswith('guid:'):
            g = line.split()[1]
            assert len(g) == 32, (p, g, len(g))
print('guid lengths ok')
