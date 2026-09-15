import json
from pathlib import Path

d = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215547.json').read_text(encoding='utf8'))
u = d['3729']['slices']['PS_uniforms44']
print('size', u['size'], 'sha', u.get('sha16'), 'nvars', u['nvars'])
fl = u['floats']
print('nfloats', len(fl))
for i in range(0, len(fl), 4):
    print('  f[%3d] off=%3d _P%02d = %s' % (i, i*4, i//4, fl[i:i+4]))

print('\n===== vars =====')
for i, v in enumerate(u['vars']):
    print('%3d %s' % (i, v if not isinstance(v, dict) else {k: v[k] for k in list(v)[:8]}))
