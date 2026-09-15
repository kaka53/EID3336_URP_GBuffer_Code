import json
from pathlib import Path
d = json.loads(Path('.rdctools/dump_215452_215453.json').read_text(encoding='utf8'))
print('top', {k:d[k] for k in d if k!='draws'})
for x in d['draws']:
    keep = {k:x[k] for k in x if k not in ('layout','cbs')}
    print(json.dumps(keep, indent=2)[:3000])
    print('LAYOUT', x.get('layout'))
    print('CBS', json.dumps(x.get('cbs') or x.get('constantBuffers'), indent=2)[:2500])
