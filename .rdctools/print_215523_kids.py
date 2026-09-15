import json
from pathlib import Path
d = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215523_extra.json').read_text(encoding='utf8'))
print('nvars', d.get('nvars'), 'localSize', d.get('localSize'))
for k in d.get('kids', []):
    print('%4d %-24s %s' % (k['off'], k['name'], k.get('val')))
print('--- mats first3 ---')
for i, m in enumerate(d.get('mats', [])[:3]):
    print(i, m)
print('n mats', len(d.get('mats', [])))
print('flags set', sorted(set(d.get('flags', []))))
print('mip', d.get('mip416'), 'meta', d.get('meta'))
