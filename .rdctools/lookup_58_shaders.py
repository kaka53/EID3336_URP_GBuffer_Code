import json
from pathlib import Path
p = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_12_65_shaders.json')
d = json.loads(p.read_text(encoding='utf8'))
print(type(d), len(d) if hasattr(d,'__len__') else None)
if isinstance(d, dict):
    print('keys', list(d.keys())[:30])
    for k,v in d.items():
        blob = json.dumps(v) if not isinstance(v, str) else v
        if '215843' in str(k)+blob or '3844' in str(k)+blob or '951f4c63' in str(k)+blob:
            print('HIT', k, blob[:1200])
elif isinstance(d, list):
    for x in d:
        blob = json.dumps(x)
        if '215843' in blob or '3844' in blob or '951f4c63' in blob:
            print(blob[:1500])
