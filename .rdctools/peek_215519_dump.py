import json, struct
from pathlib import Path
p = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215519_extra.json')
d = json.loads(p.read_text(encoding='utf8'))
# find u46 floats
def walk(x, path=''):
    if isinstance(x, dict):
        for k,v in x.items():
            if k in ('u46','uniforms46','local','floats','u46floats') or 'u46' in k.lower():
                print('KEY', path+'.'+k, type(v).__name__, (len(v) if hasattr(v,'__len__') and not isinstance(v,str) else ''))
            walk(v, path+'.'+k)
    elif isinstance(x, list) and x and not isinstance(x[0], (dict,list)):
        pass

print('top keys', list(d.keys()) if isinstance(d, dict) else type(d))
if isinstance(d, dict):
    for k in d:
        print(k, type(d[k]).__name__, (len(d[k]) if hasattr(d[k],'__len__') and not isinstance(d[k], str) else ''))
