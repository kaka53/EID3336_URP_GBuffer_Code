import json, os
from pathlib import Path

root = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215547_PS215548_Batch')
man = json.loads((root / 'VS215547_PS215548_BatchManifest.json').read_text(encoding='utf8'))
p = man['profiles'][0]
print('eid', p['eid'], 'vs', p['vs'], 'ps', p['ps'], 'inst', p['draw']['instanceCount'], 'v', p['vertexCount'], 'idx', p['draw']['indexCount'])
print('layout n', len(p['layout']))
print('VS cbs')
for c in p['constantBuffers']['VS']:
    print(' ', c['name'], c['size'], c['file']['file'] if isinstance(c['file'], dict) else c['file'])
print('PS cbs')
for c in p['constantBuffers']['PS']:
    print(' ', c['name'], c['size'], c['file']['file'] if isinstance(c['file'], dict) else c['file'])
print('KEEP textures')
for t in p['textures']:
    if t['name'] in ('res34','res36','res38','res40','res41','res42'):
        print(' ', t['name'], t['rid'], t['format'], t['width'])
print('\ntextureDatabase KEEP')
for e in man['textureDatabase']:
    if e['name'] in ('res34','res36','res38','res40','res41','res42') or set(e.get('bindings') or []) & {'res34','res36','res38','res40','res41','res42'}:
        print(e['rid'], e['name'], e.get('format'), 'unique', e.get('uniqueMaterial'), 'exported', e.get('exportedAsset'), 'existing', e.get('existingAssets'))

u44 = None
for c in p['constantBuffers']['PS']:
    if c['name'] == 'uniforms44':
        u44 = root / c['file']['file']
print('\nu44 path', u44, 'exists', u44.exists() if u44 else None, 'size', u44.stat().st_size if u44 and u44.exists() else None)

print('\ntex files')
tex = root / 'TextureDatabase'
for fn in sorted(os.listdir(tex)):
    if not fn.endswith('.meta'):
        print(' ', fn, os.path.getsize(tex / fn))
