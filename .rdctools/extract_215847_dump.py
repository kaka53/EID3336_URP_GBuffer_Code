import json
from pathlib import Path

d = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215847.json').read_text(encoding='utf8'))
e = d['3858']
print('keys', sorted(e.keys()))
for k in e:
    v = e[k]
    if isinstance(v, (str, int, float, bool)) or v is None:
        print(k, '=', v)
    elif isinstance(v, list):
        print(k, 'list', len(v), (v[0] if v else None))
    elif isinstance(v, dict):
        print(k, 'dict', list(v.keys())[:20], 'n', len(v))

print('\n===== layout =====')
for x in e.get('layout', e.get('inputs', [])):
    print(x)

print('\n===== cbs =====')
cbs = e.get('cbs') or e.get('constantBuffers') or {}
print(type(cbs), cbs if isinstance(cbs, list) else list(cbs.keys()) if isinstance(cbs, dict) else cbs)

print('\n===== textures =====')
for k in ('textures','psTextures','vsTextures','PSro','VSro'):
    if k in e:
        print('---', k)
        t = e[k]
        if isinstance(t, list):
            for x in t:
                print(x)
        else:
            print(t)

print('\n===== raster =====')
for k in e:
    if any(s in k.lower() for s in ('cull','stencil','blend','depth','raster','zw','write')):
        print(k, e[k])

print('\n===== instance =====')
for k in e:
    if any(s in k.lower() for s in ('inst','trans','mat','flag','stride')):
        v = e[k]
        if isinstance(v, list) and len(v) > 8:
            print(k, 'list', len(v), v[:3])
        else:
            print(k, v)

print('\n===== P =====')
for k in e:
    if k.startswith('_P') or k.startswith('P') or 'local' in k.lower() or 'child' in k.lower() or 'float' in k.lower():
        v = e[k]
        if isinstance(v, dict) and len(v) > 30:
            print(k, 'dict n', len(v), list(v.items())[:8])
        else:
            print(k, v if not isinstance(v, list) or len(v) < 30 else ('list', len(v), v[:8]))
