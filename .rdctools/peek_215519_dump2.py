import json
from pathlib import Path
d = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215519_extra.json').read_text(encoding='utf8'))
e = d['3448']
print('keys', sorted(e.keys()))
for k in sorted(e.keys()):
    v = e[k]
    t = type(v).__name__
    extra = ''
    if isinstance(v, list):
        extra = ' len=%d' % len(v)
        if v and not isinstance(v[0], (dict, list)):
            extra += ' sample=' + str(v[:8])
    elif isinstance(v, dict):
        extra = ' sub=' + str(list(v.keys())[:20])
    else:
        extra = ' val=' + str(v)[:120]
    print(k, t, extra)
