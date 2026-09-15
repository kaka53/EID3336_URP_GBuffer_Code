import json
from pathlib import Path

sh = json.loads(Path('.rdctools/dump_12_65_shaders.json').read_text(encoding='utf8'))
inv = json.loads(Path('.rdctools/remaining_12_65_inventory.json').read_text(encoding='utf8'))
for x in sh['families']:
    n = x.get('n')
    if n not in (42, 65):
        continue
    print('n', n, x.get('family'), 'eid', x.get('eid'))
    print('  VSH', (x.get('VSH') or '')[:16], 'bytes', x.get('VSbytes'), Path(x.get('VSfile') or '').name)
    print('  PSH', (x.get('PSH') or '')[:16], 'bytes', x.get('PSbytes'), Path(x.get('PSfile') or '').name)
    print('  VSinputs', [i.get('var') for i in x.get('VSinputs') or []])
    print('  PScb', [(c.get('n'), c.get('sz')) for c in x.get('PScb') or []])
    print('  VScb', [(c.get('n'), c.get('sz')) for c in x.get('VScb') or []])
    print('  PSro', [(r.get('n'), r.get('bind'), r.get('rid')) for r in x.get('PSro') or []][:30])
    print('  VSro', [(r.get('n'), r.get('bind'), r.get('rid')) for r in x.get('VSro') or []][:20])
print('--- inventory ---')
items = inv if isinstance(inv, list) else inv.get('families') or inv.get('remaining') or []
if isinstance(inv, dict) and not items:
    print('inv keys', list(inv.keys())[:20])
for x in items:
    n = x.get('n') if isinstance(x, dict) else None
    if n in (42, 65) or (isinstance(x, dict) and ('264371' in str(x) or '215539' in str(x))):
        print(json.dumps(x, indent=2)[:2000])
