import json
from pathlib import Path

inv = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/remaining_12_65_inventory.json').read_text(encoding='utf8'))
for fam in inv:
    if fam.get('n') in (53, 54, 55, 56) or str(fam.get('family','')).startswith('VS215525') or str(fam.get('family','')).startswith('VS215523'):
        print('=== family', fam.get('n'), fam.get('family'), 'draws', fam.get('drawCount'), 'inst', fam.get('instanceTotal'), 'layouts', fam.get('layouts'))
        print('eids', fam.get('eids'))
        for d in fam.get('draws', []):
            print(' ', d)

sh = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_12_65_shaders.json').read_text(encoding='utf8'))
# dump structure unknown — print keys and family 54-ish entries
if isinstance(sh, dict):
    print('shader dump keys', list(sh.keys())[:40], 'nkeys', len(sh))
    for k, v in sh.items():
        s = json.dumps(v) if not isinstance(v, str) else v
        if '215525' in str(k) or '215525' in s or '3550' in str(k) or 'f1a7bd79' in s or 'f1a7bd79' in str(k):
            print('SH', k, s[:800])
elif isinstance(sh, list):
    print('shader dump list', len(sh))
    for e in sh:
        s = json.dumps(e)
        if '215525' in s or 'f1a7bd79' in s or (isinstance(e, dict) and e.get('n') == 54):
            print('SH', s[:1200])
