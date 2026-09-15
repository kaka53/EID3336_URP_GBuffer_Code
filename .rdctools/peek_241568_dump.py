import json, struct
from pathlib import Path
d = json.loads(Path('.rdctools/dump_241568.json').read_text(encoding='utf8'))
e = d['3567']
print('cull', e['cull'], 'zw', e['zw'], 'zfn', e['zfn'], 'sref', e['sref'], 'sfn', e['sfn'], 'scm', e['scm'], 'swm', e['swm'])
print('flags', e['flags'])
print('layout', e['layout'])
print('pstex unique-set', [(t['n'], t['rid'], t['fmt'], t['w'], t['bind']) for t in e['pstex'] if t['n'] in ('res30','res32','res34','res54')])
sl = e['slices']
u20 = sl.get('PS_uniforms20') or {}
print('uniforms20 sha', u20.get('sha16'), 'nvars', u20.get('nvars'), 'size', u20.get('size'))
floats = u20.get('floats') or []
if len(floats) > 105:
    print('mip416', floats[104], 'y436', floats[109] if len(floats)>109 else None)
u39 = sl.get('PS_uniforms39') or {}
print('uniforms39', {k:v for k,v in u39.items() if k!='vars'})
if u39.get('floats'):
    print('uniforms39 floats', u39['floats'])
print('instHead16', e.get('instHead16'))
print('rw', e.get('rw'))
