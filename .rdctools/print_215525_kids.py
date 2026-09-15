import json
from pathlib import Path

d = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215525.json').read_text(encoding='utf8'))
e = d['3550']
print('=== remaining kids 50+ ===')
# kids live in slices PS_uniforms38 vars
kids = e['slices']['PS_uniforms38']['vars']
print('nvars', len(kids), 'size', e['slices']['PS_uniforms38']['size'])
for k in kids:
    print('%3d %-20s off=%4d r=%s c=%s val=%s' % (
        kids.index(k), k['name'], k['off'], k['rows'], k['cols'], k.get('val')))
print('=== meta uniforms40 ===')
print(e['slices']['PS_uniforms40'])
print('=== mip uniforms21 floats around 416 ===')
f = e['slices']['PS_uniforms21'].get('floats') or []
if f:
    print('nfloats', len(f), 'f[104]=416', f[104] if len(f)>104 else None, 'f[105]=420', f[105] if len(f)>105 else None, 'f[109]=436', f[109] if len(f)>109 else None)
print('=== pstex ===')
for t in e['pstex']:
    print(t)
