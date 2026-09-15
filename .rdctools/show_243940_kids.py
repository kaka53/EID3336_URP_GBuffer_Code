import json
from pathlib import Path

d = json.loads(Path('.rdctools/dump_243940.json').read_text(encoding='utf8'))
e = d['3583']
kids = e.get('localKids') or []
want = [0,2,3,4,7,11,12,13,15,16,17,18,19,20,21,28,29,32,35,36,46,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,68,70,71,72,78,79]
print('nvars', len(kids), 'uniforms41 size', e['slices'].get('PS_uniforms41', {}).get('size'))
print('mip', e['slices'].get('PS_uniforms20_mip416'))
print('u43', e['slices'].get('PS_uniforms43'))
idx = {k['name']: k for k in kids}
for i in want:
    name = f'_child{i}'
    # dump names may be child0 or _child0 or nested
    hits = [k for k in kids if k['name'].endswith(f'child{i}') or k['name'] == name or k['name'].endswith(f'.{i}') or k['name'].split('.')[-1] in (f'child{i}', f'_child{i}', str(i))]
    if not hits:
        # try by offset from SPIR-V
        continue
    k = hits[0]
    print(f"{k['name']:30s} off={k['off']:4d} val={k.get('val')}")

print('\n===== all kids with val =====')
for k in kids:
    val = k.get('val')
    if val is None:
        continue
    # skip zeros-only later; print non-trivial or first 40
    print(f"{k['name']:40s} off={k['off']:4d} val={val}")
