import json
from pathlib import Path

sh = json.loads(Path('.rdctools/dump_12_65_shaders.json').read_text(encoding='utf8'))
for x in sh['families']:
    n = x.get('n')
    if n not in (62, 63, 64, 65):
        continue
    print('n', n, x.get('family'), 'eid', x.get('eid'))
    print('  VSH', (x.get('VSH') or '')[:16], 'bytes', x.get('VSbytes'), Path(x.get('VSfile') or '').name)
    print('  PSH', (x.get('PSH') or '')[:16], 'bytes', x.get('PSbytes'), Path(x.get('PSfile') or '').name)
    print('  VSinputs', [i.get('var') for i in x.get('VSinputs') or []])
    print('  PScb', [(c.get('n'), c.get('sz')) for c in x.get('PScb') or []])
    print('  VScb', [(c.get('n'), c.get('sz')) for c in x.get('VScb') or []])
    print('  PSro', [(r.get('n'), r.get('bind'), r.get('rid')) for r in x.get('PSro') or []][:20])
    print('  VSro', [(r.get('n'), r.get('bind'), r.get('rid')) for r in x.get('VSro') or []][:20])
