import json, struct
from pathlib import Path

d = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215549.json').read_text(encoding='utf8'))
e = d['3734']
print('cull', e['cull'], 'zw', e['zw'], 'zfn', e['zfn'], 'sref', e['sref'], 'flags', e['flags'], 'mats', e['mats'])
print('writeMask', e['writeMask'])
print('layout')
for x in e['layout']:
    print(' ', x)

u32 = e['slices']['PS_uniforms32']
print('\nuniforms32 nvars', u32.get('nvars'), 'floats', u32.get('floats'))
print('vars', json.dumps(u32.get('vars'), indent=2)[:2000])

u17 = e['slices']['PS_uniforms17']
print('\nuniforms17 keys', list(u17.keys()))
# mip at 416 = float index 104, y436 = index 109
fl = u17.get('floats') or []
print('floats n', len(fl))
if fl:
    print('f[104] mip416', fl[104] if len(fl)>104 else None)
    print('f[109] y436', fl[109] if len(fl)>109 else None)
    print('child20', [v for v in (u17.get('vars') or []) if v.get('name')=='_child20' or v.get('off')==432])

u30 = e['slices']['PS_uniforms30']
print('\nuniforms30 size', u30['size'], 'sha', u30['sha16'], 'nvars', u30.get('nvars'))
print('floats packed as float4s:')
fl30 = u30.get('floats') or []
print('nfloats', len(fl30))
for i in range(0, len(fl30), 4):
    chunk = fl30[i:i+4]
    print('  _P%02d @%3d' % (i//4, i*4), [round(x,6) for x in chunk])
