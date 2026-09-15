import json
from pathlib import Path

d = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215847.json').read_text(encoding='utf8'))
e = d['3858']
kids = e['localKids']
print('n', len(kids))
for i, k in enumerate(kids):
    v = k.get('val')
    print('%2d off=%3d rows=%s cols=%s array=%s val=%s' % (
        i, k.get('off'), k.get('rows'), k.get('cols'), k.get('array'), v))

print('\n===== slices with floats =====')
sl = e['slices']
for name, rec in sl.items():
    if not isinstance(rec, dict):
        print(name, rec)
        continue
    f = rec.get('floats')
    print(name, 'keys', list(rec.keys()), 'floats', (len(f) if isinstance(f, list) else type(f).__name__))
    if name == 'VS_uniforms24' and isinstance(f, list):
        print('  WindA@512', f[512//4:512//4+4])
        print('  WindGate@880', f[880//4:880//4+1])
        print('  WindB@896', f[896//4:896//4+4])
    if name == 'PS_uniforms19' and isinstance(f, list):
        print('  mip@416', f[416//4:416//4+1])
        print('  y@436', f[436//4:436//4+1] if len(f) > 109 else 'short')
    if name in ('PS_uniforms17','VS_uniforms22') and isinstance(f, list):
        print('  cam@704', f[704//4:704//4+4] if len(f) > 176 else ('len', len(f)))
    if name == 'PS_uniforms30' and isinstance(f, list):
        print('  n', len(f))
        for i in range(0, min(88, len(f)), 4):
            print('  f[%d]' % i, [round(x,6) for x in f[i:i+4]])
    if name == 'VS_uniforms27' and isinstance(f, list):
        print('  n', len(f), 'head16', f[:16], 't0', f[12:15])
