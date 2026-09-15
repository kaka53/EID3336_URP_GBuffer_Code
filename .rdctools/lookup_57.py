import json
from pathlib import Path

inv = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/remaining_12_65_inventory.json').read_text(encoding='utf8'))
print('inv type', type(inv).__name__)
if isinstance(inv, dict):
    print('keys', list(inv.keys())[:40])
    for k in inv:
        if '57' in str(k) or '215549' in str(k) or '3734' in str(k):
            print('KEY', k)
            v = inv[k]
            print(json.dumps(v, indent=2)[:4000] if not isinstance(v, (list, dict)) or True else v)
else:
    print('len', len(inv))
    for i, item in enumerate(inv):
        s = json.dumps(item)
        if '215549' in s or '"57"' in s or 'family 57' in s.lower():
            print('ITEM', i)
            print(json.dumps(item, indent=2)[:5000])
