import json, struct
from pathlib import Path

d = json.loads(Path('.rdctools/dump_264371.json').read_text(encoding='utf8'))
e = d['3612']
print('vs', e['vs'], 'ps', e['ps'], 'inst', e['inst'], 'idx', e['idx'])
print('cull', e['cull'], 'zw', e['zw'], 'zfn', e['zfn'])
print('sref', e['sref'], 'sfn', e['sfn'], 'scm', e['scm'], 'swm', e['swm'])
print('writeMask', e['writeMask'], 'blend0', e['blend0'], 'frontCCW', e['frontCCW'])
print('flags', e['flags'])
print('mats', e['mats'])
print('layout:')
for x in e['layout']:
    print(' ', x)
print('cbs:')
for c in e['cbs']:
    print(' ', c)
print('pstex:')
for t in e['pstex']:
    print(' ', t)
print('vstex', e['vstex'])
print('rw', e['rw'])
sl = e['slices']['PS_uniforms28']
print('u28 nvars', sl.get('nvars'), 'sha', sl.get('sha16'), 'size', sl.get('size'))
print('u30 floats', e['slices']['PS_uniforms30'].get('floats'))
u17 = e['slices'].get('PS_uniforms17', {})
fl = u17.get('floats') or []
print('u17 nfloats', len(fl))
if len(fl) > 109:
    print('u17[104] @416', fl[104])
    print('u17[109] @436', fl[109])
print('--- localKids ---')
for k in e.get('localKids') or []:
    print('  %s @%d %s val=%s' % (k['name'], k['off'], k.get('comp'), k.get('val')))
