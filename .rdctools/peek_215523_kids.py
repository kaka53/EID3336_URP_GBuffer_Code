import json
from pathlib import Path
d = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215523_extra.json').read_text(encoding='utf8'))
print('nvars', d['nvars'], 'localSize', d['localSize'])
print('--- kids ---')
for k in d['kids']:
    print('%4d %-20s %s' % (k['off'], k['name'], k.get('val')))
print('--- mats ---')
for i, m in enumerate(d['mats']):
    print('%2d %s' % (i, m))
print('flags', d['flags'])
print('mip', d['mip416'], 'meta', d['meta'])
