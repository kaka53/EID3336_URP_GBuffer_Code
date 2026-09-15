import json
from pathlib import Path

p = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_12_65_shaders.json')
data = json.loads(p.read_text(encoding='utf8'))
print('type', type(data).__name__)
if isinstance(data, dict):
    print('keys', list(data.keys())[:30])
    for k, v in data.items():
        s = json.dumps(v)[:200] if not isinstance(v, str) else v[:200]
        if '215549' in str(k) or '215550' in str(k) or '855961aa' in str(k)+s or '3734' in str(k)+s:
            print('HIT KEY', k, type(v).__name__)
            if isinstance(v, dict):
                print('  subkeys', list(v.keys())[:40])
                print(json.dumps({kk: (vv if not isinstance(vv, (list, dict)) else str(type(vv))+str(len(vv))) for kk, vv in list(v.items())[:40]}, indent=2)[:4000])
            else:
                print(str(v)[:2000])
else:
    print('len', len(data))
    for i, item in enumerate(data):
        s = json.dumps(item)
        if '215549' in s or '215550' in s or '855961aa' in s:
            print('ITEM', i)
            if isinstance(item, dict):
                print('keys', list(item.keys())[:50])
                slim = {}
                for kk, vv in item.items():
                    if isinstance(vv, (list, dict)):
                        slim[kk] = '%s len=%s' % (type(vv).__name__, len(vv))
                    else:
                        slim[kk] = vv
                print(json.dumps(slim, indent=2)[:5000])
            else:
                print(str(item)[:3000])
            break
