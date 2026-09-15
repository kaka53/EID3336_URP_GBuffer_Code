import json
from pathlib import Path

inv = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/remaining_12_65_inventory.json').read_text(encoding='utf8'))
print(type(inv), len(inv) if hasattr(inv,'__len__') else None)
if isinstance(inv, dict):
    print('keys', list(inv.keys())[:40])
    for k in inv:
        if '58' in str(k) or (isinstance(inv[k], dict) and str(inv[k].get('family',''))=='58'):
            print('hit', k, json.dumps(inv[k])[:500])
    # print last few families
    for k in list(inv.keys())[-15:]:
        v = inv[k]
        print('k', k, str(v)[:300])
elif isinstance(inv, list):
    for x in inv:
        fam = x.get('family') or x.get('n') or x.get('id')
        if fam in (57,58,59,60,61,62,63,64,65,'57','58','59','60','61','62','63','64','65'):
            print(json.dumps(x)[:800])
