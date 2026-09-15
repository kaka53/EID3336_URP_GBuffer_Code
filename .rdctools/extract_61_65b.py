import json
from pathlib import Path

inv = json.loads(Path('.rdctools/remaining_12_65_inventory.json').read_text(encoding='utf8'))
print('families n=', [x.get('n') for x in inv])
for x in inv:
    if x.get('n') in (61,62,63,64,65):
        print(json.dumps({k:v for k,v in x.items() if k!='draws'}, indent=2))
        print('draws', json.dumps(x.get('draws'), indent=2)[:1500])
        print('====')

sh = json.loads(Path('.rdctools/dump_12_65_shaders.json').read_text(encoding='utf8'))
for x in sh['families']:
    if x.get('n') in (61,62,63,64,65):
        keys = ['n','family','eid','vs','ps','VSH','PSH','VSbytes','PSbytes','VSfile','PSfile']
        print({k: x.get(k) for k in keys})
        print('PSinputs', x.get('PSinputs'))
        print('PSoutputs', x.get('PSoutputs'))
        print('====')
