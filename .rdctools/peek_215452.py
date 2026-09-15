import json
from pathlib import Path

p = Path('.rdctools/dump_215452_215453.json')
d = json.loads(p.read_text(encoding='utf8'))
print('keys', list(d.keys())[:30])
# compact
if 'draws' in d:
    for x in d['draws']:
        print('eid', x.get('eid'), 'vs', x.get('vs'), 'ps', x.get('ps'))
        print(' raster', {k:x.get(k) for k in ['cull','depthWrites','depthFunction','stencilRef','writeMask','blend0'] if k in x or True})
        print(' layout', x.get('layout'))
        print(' cbs VS', [{k:c.get(k) for k in ['name','size','bind']} for c in x.get('cbs',{}).get('VS', x.get('constantBuffers',{}).get('VS', []))] if isinstance(x.get('cbs') or x.get('constantBuffers'), dict) else 'no')
        tex = x.get('textures') or x.get('ro')
        print(' tex', json.dumps(tex, indent=2)[:2500] if tex else None)
        print(' inst', x.get('instanceCount') or x.get('inst'))
        print('----')
else:
    print(json.dumps(d, indent=2)[:4000])
