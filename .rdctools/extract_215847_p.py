import json
from pathlib import Path

d = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215847.json').read_text(encoding='utf8'))
e = d['3858']
kids = e['localKids']
vals = []
for k in kids:
    v = k.get('val') or [0]
    vals.append(float(v[0]) if isinstance(v, list) else float(v))
print('n kids', len(vals))
for i in range(0, 73, 4):
    chunk = vals[i:i+4]
    while len(chunk) < 4:
        chunk.append(0.0)
    print('_P%02d' % (i//4), tuple(round(x, 6) for x in chunk))

print('\npstex', e['pstex'])
print('vstex', e['vstex'])
print('ib', e['ib'])
print('vbs', e['vbs'])

sl = e['slices']
print('\nslice keys', list(sl.keys()))
for name, rec in sl.items():
    floats = rec.get('f') or rec.get('floats') or rec.get('head') or rec
    if isinstance(rec, dict):
        print(name, {k: (len(v) if isinstance(v, list) else v) for k,v in rec.items()})
    else:
        print(name, type(rec), rec if not isinstance(rec, list) else len(rec))

def getf(rec):
    if isinstance(rec, dict):
        for k in ('f','floats','head','head16','vals'):
            if k in rec:
                return rec[k]
        # maybe raw list under data
        if 'data' in rec and isinstance(rec['data'], list):
            return rec['data']
    if isinstance(rec, list):
        return rec
    return None

for key, off, n, label in [
    ('PS_uniforms19', 416, 1, 'mip'),
    ('PS_uniforms19', 436, 1, 'y148'),
    ('VS_uniforms24', 512, 4, 'WindA'),
    ('VS_uniforms24', 880, 1, 'WindGate'),
    ('VS_uniforms24', 896, 4, 'WindB'),
    ('PS_uniforms17', 704, 4, 'cam'),
    ('VS_uniforms22', 704, 4, 'camVS'),
    ('PS_uniforms30', 0, 88, 'local30'),
]:
    rec = sl.get(key)
    f = getf(rec)
    if f is None:
        print(label, 'NO FLOATS', type(rec), list(rec)[:12] if isinstance(rec, dict) else rec)
        continue
    print(label, f[off//4:off//4+n] if isinstance(f, list) and len(f) > off//4 else ('len', len(f) if hasattr(f,'__len__') else f, 'off', off))
