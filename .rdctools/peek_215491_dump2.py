import json
from pathlib import Path
d = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215491_extra.json').read_text(encoding='utf8'))
e = d['3231']
print('vs', e['vs'], 'ps', e['ps'], 'inst', e['inst'], 'idx', e['idx'])
print('cull', e['cull'], 'zw', e['zw'], 'zfn', e['zfn'], 'sref', e['sref'])
print('layout names', [x.get('name') for x in e['layout']])
print('cbs:')
for cb in e['cbs']:
    print(' ', cb)
print('slices keys', list(e['slices'].keys()) if isinstance(e['slices'], dict) else type(e['slices']))
if isinstance(e['slices'], dict):
    for k,v in e['slices'].items():
        s = str(v)
        print(' slice', k, s[:300])
elif isinstance(e['slices'], list):
    for v in e['slices'][:8]:
        print(' slice', str(v)[:300])
