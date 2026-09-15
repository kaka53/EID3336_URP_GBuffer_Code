import json
from pathlib import Path

p = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_244085.json')
d = json.loads(p.read_text(encoding='utf8'))
e = d['3555']
print('vs', e['vs'], 'ps', e['ps'], 'inst', e['inst'], 'idx', e['idx'])
print('cull', e['cull'], 'zw', e['zw'], 'zfn', e['zfn'])
print('sref', e['sref'], 'sfn', e['sfn'], 'scm', e['scm'], 'swm', e['swm'])
print('writeMask', e['writeMask'], 'blend0', e['blend0'], 'frontCCW', e['frontCCW'])
print('flags', e['flags'])
print('mats', e['mats'])
print('ib', e['ib'])
print('vbs', e['vbs'])
print('layout:')
for x in e['layout']:
    print(' ', x)
print('cbs:')
for x in e['cbs']:
    print(' ', x)
print('slices keys:')
for k, v in e['slices'].items():
    if isinstance(v, dict):
        print(' ', k, {kk: vv for kk, vv in v.items() if kk not in ('floats', 'vars')})
    else:
        print(' ', k, v)
print('localKidsN', len(e.get('localKids') or []))
print('pstex:')
for t in e['pstex']:
    print(' ', t)
print('vstex:', e['vstex'])
print('rw:', e['rw'])
print('localKids head:')
for k in (e.get('localKids') or [])[:120]:
    print(' ', k)
