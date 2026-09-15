import json
from pathlib import Path
p = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215491_extra.json')
d = json.loads(p.read_text(encoding='utf8'))
print('keys', list(d.keys())[:40])
for k in d:
    v = d[k]
    if isinstance(v, list) and v:
        print(k, 'list', len(v), 'sample', str(v[0])[:200])
    elif isinstance(v, dict):
        print(k, 'dict', list(v.keys())[:20])
    else:
        s = str(v)
        print(k, type(v).__name__, s[:240])
