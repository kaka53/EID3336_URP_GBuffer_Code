import json, os
from pathlib import Path

d = json.loads(Path('.rdctools/dump_239789.json').read_text(encoding='utf8'))
e = d['1727']
print('sfn', e.get('sfn'), 'scm', e.get('scm'), 'swm', e.get('swm'), 'frontCCW', e.get('frontCCW'))
print('flags', e.get('flags'))
print('layout')
for x in e['layout']:
    print(' ', x)
print('cbs')
for c in e['cbs']:
    print(' ', c)
print('rw', e.get('rw'))
print('pstex', e.get('pstex'))
print('vstex', e.get('vstex'))

# local floats
sl = e['slices']['PS_uniforms24']
print('local nvars', sl.get('nvars'), 'sha', sl.get('sha16'))
print('floats', sl.get('floats'))
print('mip', e['slices'].get('PS_uniforms16_mip416'), e['slices'].get('VS_uniforms22_mip416'))
print('y436', e['slices'].get('PS_uniforms16_y436'))

# instance packed uniforms19 child2 at +32?
inst = e['slices']['VS_uniforms25']
print('inst stride', inst.get('stride'), 'head80', inst.get('head80'))

# search existing rids
rids = [257158, 223048]
roots = [
    Path('Assets'),
]
hits = {r: [] for r in rids}
for root, dirs, files in os.walk('Assets'):
    dirs[:] = [x for x in dirs if x not in ('Library', 'Temp')]
    for fn in files:
        low = fn.lower()
        if low.endswith('.meta') or low.endswith('.raw'):
            continue
        for r in rids:
            if ('rid%d' % r) in low:
                hits[r].append(str(Path(root) / fn))
print('EXISTING', json.dumps(hits, indent=2))
