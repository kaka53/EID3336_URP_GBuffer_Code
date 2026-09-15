import json
from pathlib import Path

d = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215847.json').read_text(encoding='utf8'))
e = d['3858']
sl = e['slices']['VS_uniforms24']
vars_ = sl.get('vars')
print('nvars', sl.get('nvars'), 'type', type(vars_).__name__)
if isinstance(vars_, list):
    for i, v in enumerate(vars_):
        name = v.get('name') if isinstance(v, dict) else str(v)
        if isinstance(v, dict):
            off = v.get('off', v.get('offset'))
            val = v.get('val', v.get('value'))
            if i < 50 or (off is not None and (600 <= off <= 1100 or off in (512, 880, 896))):
                print(i, name, 'off', off, val)
            elif name and any(s in str(name) for s in ('child25','child31','child32','child41','child36','child37')):
                print(i, name, 'off', off, val)
elif isinstance(vars_, dict):
    print(list(vars_.keys())[:40])

f = sl['floats']
print('\nchild25 @512', f[128:132])
print('floats around 624-700 (child32 array?)')
for o in range(624, 720, 16):
    print(o, [round(x,5) for x in f[o//4:o//4+4]])
print('child41? search non-zero around 800-1100')
for o in range(0, min(len(f)*4, 3200), 16):
    chunk = f[o//4:o//4+4]
    if any(abs(x) > 1e-4 for x in chunk) and o not in range(512, 528):
        if o >= 600:
            print(o, [round(x,5) for x in chunk])
