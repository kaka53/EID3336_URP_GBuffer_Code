import json
from pathlib import Path

inv = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/remaining_12_65_inventory.json').read_text(encoding='utf8'))
print('n', len(inv), 'sample keys', sorted(inv[0].keys()) if inv else None)
print('first', json.dumps(inv[0], default=str)[:600])
print('--- last 12 ---')
for x in inv[-12:]:
    keys = ['family','n','id','vs','ps','eid','eids','vsHash','psHash','layout','instances','idx','verts']
    slim = {k: x.get(k) for k in x if k.lower() in {y.lower() for y in keys} or k in ('familyIndex','shaderFamily','vsId','psId','meshHash','drawCount')}
    if not slim:
        slim = {k: x[k] for k in list(x)[:12]}
    print(json.dumps(slim)[:400])

scan = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/scan_12_65.json')
if scan.exists():
    s = json.loads(scan.read_text(encoding='utf8'))
    print('\nscan type', type(s), 'len', len(s) if hasattr(s,'__len__') else None)
    if isinstance(s, dict):
        print('scan keys', list(s.keys())[:20])
        for k in s:
            if '58' in str(k) or '215843' in str(k) or '3844' in str(k):
                print('scan hit', k, str(s[k])[:400])
    elif isinstance(s, list):
        for x in s:
            blob = json.dumps(x)
            if '215843' in blob or '"58"' in blob or '3844' in blob:
                print('scan list', blob[:500])
