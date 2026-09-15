import json
from pathlib import Path

p = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_12_65_shaders.json')
d = json.loads(p.read_text(encoding='utf8'))
fams = d.get('families') or d.get('Families') or []
print('nfam', len(fams), 'type0', type(fams[0]) if fams else None)
for x in fams:
    n = x.get('n') if isinstance(x, dict) else x
    fam = x.get('family') if isinstance(x, dict) else None
    vs = x.get('vs') if isinstance(x, dict) else None
    if n in (46, 57, 58, 59, 60) or fam in ('VS215843_PS215844', 'VS215845_PS215846', 'VS215549_PS215550') or vs in (215843, 215845, 215549):
        slim = {k: x[k] for k in x if k not in ('VSinputs', 'VSoutputs', 'PSinputs', 'PSoutputs', 'VScbs', 'PScbs', 'VSro', 'PSro')}
        print('---', json.dumps(slim)[:2000])
        print('VSinputs', json.dumps(x.get('VSinputs'))[:1500])
        print('PScbs', json.dumps([{k: c[k] for k in c if k != 'vars'} if isinstance(c, dict) else c for c in (x.get('PScbs') or [])])[:2000])
        print('PSro', json.dumps(x.get('PSro'))[:1500])
        print('VSro', json.dumps(x.get('VSro'))[:800])
        print('VScbs names', [(c.get('name'), c.get('byteSize') if isinstance(c, dict) else c) for c in (x.get('VScbs') or [])][:20])

inv = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/remaining_12_65_inventory.json').read_text(encoding='utf8'))
for x in inv:
    if x.get('n') in (46, 57, 58, 59) or x.get('family') in ('VS215843_PS215844',):
        print('INV', json.dumps(x)[:1200])
