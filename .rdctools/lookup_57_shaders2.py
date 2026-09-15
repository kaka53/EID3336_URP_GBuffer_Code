import json
from pathlib import Path

data = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_12_65_shaders.json').read_text(encoding='utf8'))
print('uniqueShaders', type(data['uniqueShaders']).__name__, len(data['uniqueShaders']) if hasattr(data['uniqueShaders'], '__len__') else None)
print('families', type(data['families']).__name__, len(data['families']) if hasattr(data['families'], '__len__') else None)

fams = data['families']
if isinstance(fams, dict):
    print('fam keys sample', list(fams.keys())[:20])
    for k, v in fams.items():
        s = json.dumps(v)[:300] if not isinstance(v, str) else v[:300]
        if '215549' in str(k)+s or '215550' in str(k)+s or '855961aa' in str(k)+s:
            print('FAM HIT', k)
            if isinstance(v, dict):
                slim = {}
                for kk, vv in v.items():
                    if isinstance(vv, (list, dict)):
                        slim[kk] = '%s len=%s' % (type(vv).__name__, len(vv))
                    else:
                        slim[kk] = vv
                print(json.dumps(slim, indent=2)[:6000])
            else:
                print(str(v)[:4000])
elif isinstance(fams, list):
    for i, item in enumerate(fams):
        s = json.dumps(item)
        if '215549' in s or '215550' in s or '855961aa' in s:
            print('FAM ITEM', i)
            if isinstance(item, dict):
                slim = {}
                for kk, vv in item.items():
                    if isinstance(vv, (list, dict)):
                        slim[kk] = '%s len=%s' % (type(vv).__name__, len(vv))
                    else:
                        slim[kk] = vv
                print(json.dumps(slim, indent=2)[:8000])
                for kk in ('ps', 'PS', 'pixel', 'psHash', 'vsHash', 'vs', 'cbs', 'textures', 'constantBlocks'):
                    if kk in item:
                        print('FIELD', kk, json.dumps(item[kk], default=str)[:4000])
            break

ush = data['uniqueShaders']
target = None
if isinstance(ush, dict):
    for k, v in ush.items():
        if '855961aa' in str(k) or (isinstance(v, dict) and '855961aa' in json.dumps(v)[:500]):
            print('USH KEY', k)
            if isinstance(v, dict):
                slim = {kk: (('%s len=%s' % (type(vv).__name__, len(vv))) if isinstance(vv, (list, dict)) else vv) for kk, vv in v.items()}
                print(json.dumps(slim, indent=2)[:5000])
                target = v
elif isinstance(ush, list):
    for i, item in enumerate(ush):
        s = json.dumps(item)[:800]
        if '855961aa' in s or '215550' in s:
            print('USH ITEM', i)
            if isinstance(item, dict):
                slim = {kk: (('%s len=%s' % (type(vv).__name__, len(vv))) if isinstance(vv, (list, dict)) else vv) for kk, vv in item.items()}
                print(json.dumps(slim, indent=2)[:5000])
                target = item
            break
