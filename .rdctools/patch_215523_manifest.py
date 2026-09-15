import json
from pathlib import Path

p = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215523_PS215524_Batch/VS215523_PS215524_BatchManifest.json')
d = json.loads(p.read_text(encoding='utf8'))
tex = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215523_PS215524_Batch/TextureDatabase')
for e in d.get('textureDatabase', []):
    local = tex / ('rid%d.dds' % e['rid'])
    print('rid', e['rid'], 'unique', e.get('uniqueMaterial'), 'exported', e.get('exportedAsset'), 'exists', local.exists(), 'fmt', e.get('format'), 'bindings', e.get('bindings'))
    if e.get('uniqueMaterial') and local.exists():
        e['exportedAsset'] = 'TextureDatabase/rid%d.dds' % e['rid']
# also list CBs
print('--- CBs ---')
for cb in d['profiles'][0]['constantBuffers']['PS']:
    print('PS', cb['name'], cb['size'], cb['file']['file'] if cb.get('file') else None)
for cb in d['profiles'][0]['constantBuffers']['VS']:
    print('VS', cb['name'], cb['size'], cb['file']['file'] if cb.get('file') else None)
p.write_text(json.dumps(d, indent=2), encoding='utf8')
print('patched', p)
