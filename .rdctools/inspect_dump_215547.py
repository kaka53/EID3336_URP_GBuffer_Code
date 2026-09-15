import json
from pathlib import Path

d = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215547.json').read_text(encoding='utf8'))

def walk(obj, path=''):
    if isinstance(obj, dict):
        keys = list(obj.keys())
        if any(k in keys for k in ('uniforms44','u44','local','PS_uniforms44','size')):
            print('DICT', path, keys[:40])
        for k,v in obj.items():
            walk(v, path + '/' + str(k))
    elif isinstance(obj, list):
        if path.endswith('floats') or path.endswith('u44floats') or 'uniforms44' in path and len(obj)>20 and all(isinstance(x,(int,float)) for x in obj[:8]):
            print('LIST', path, 'n=', len(obj), 'head=', obj[:16])
        if obj and isinstance(obj[0], dict):
            walk(obj[0], path + '[0]')
        if len(obj)>1 and isinstance(obj[-1], dict):
            walk(obj[-1], path + '[-1]')

print('top keys', list(d.keys())[:40] if isinstance(d, dict) else type(d))
walk(d)
