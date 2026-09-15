# -*- coding: utf-8 -*-
from pathlib import Path
import json, struct

ROOT = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace')
VS = (ROOT / '.rdctools/shaders_12_65/cf659d5dd67c65c6_VS.spvasm').read_text(encoding='utf8', errors='replace')
PS = (ROOT / '.rdctools/shaders_12_65/25afab1205707dfd_PS.spvasm').read_text(encoding='utf8', errors='replace')
dump = json.loads((ROOT / '.rdctools/dump_229351.json').read_text(encoding='utf8'))
e = dump['3755']
out = []
vsl = VS.splitlines()
psl = PS.splitlines()

def window(lines, start, end):
    s = max(1, start)
    e2 = min(len(lines), end)
    return ['%5d| %s' % (i, lines[i-1][:240]) for i in range(s, e2+1)]

out.append('=== VS struct around 210-270 (instance?) ===')
out += window(vsl, 200, 280)
out.append('\n=== VS uniforms around 290-360 ===')
out += window(vsl, 288, 360)
out.append('\n=== VS first ImageSample 1100-1280 ===')
out += window(vsl, 1080, 1260)
out.append('\n=== VS second ImageSample 1820-2080 packed ===')
out += window(vsl, 1820, 2080)
out.append('\n=== PS 330-430 sample + DXT ===')
out += window(psl, 320, 430)
out.append('\n=== PS 430-620 encode RT ===')
out += window(psl, 430, 620)

# uniforms24 floats
sl = e['slices']
u24 = sl.get('VS_uniforms24', {}).get('floats') or []
out.append('\n=== uniforms24 nfloats=%d ===' % len(u24))
def f4(off):
    i = off // 4
    if i+4 <= len(u24):
        return u24[i:i+4]
    return None
out.append('mip416=%s' % (u24[416//4] if len(u24)>104 else None))
out.append('y436=%s' % (u24[436//4] if len(u24)>109 else None))
out.append('@512 WindA child25=%s' % f4(512))
out.append('@608 child31=%s' % f4(608))
out.append('@880 WindGate child36=%s' % f4(880))
out.append('@896 WindB child37=%s' % f4(896))
out.append('@1104 child41=%s' % f4(1104))
out.append('@1120 child42=%s' % f4(1120))
out.append('@1296 child53 Sun?=%s' % f4(1296))

u20 = sl.get('VS_uniforms20', {}).get('floats') or []
out.append('uniforms20=%s' % u20)
u22 = sl.get('VS_uniforms22', {}).get('floats') or []
out.append('uniforms22 n=%d' % len(u22))
if u22:
    # camera child11 typically around some offset - family 59 used @704
    out.append('u22@704=%s' % (u22[704//4:704//4+4] if len(u22)>176 else None))
    out.append('u22@16=%s' % (u22[:8],))

u30 = sl.get('PS_uniforms30', {}).get('floats') or []
out.append('PS_uniforms30 nfloats=%d first88=%s' % (len(u30), u30[:88] if u30 else None))

# search VS for ArrayStride 96
out.append('\n=== VS ArrayStride 96 hits ===')
for i, ln in enumerate(vsl, 1):
    if 'ArrayStride(96)' in ln or 'ArrayStride 96' in ln:
        out.append('%5d| %s' % (i, ln[:200]))
out.append('=== VS struct25 / _27 access ===')
for i, ln in enumerate(vsl, 1):
    if '_27' in ln or 'struct25' in ln:
        if i < 400 or 'AccessChain' in ln or 'Load' in ln or 'struct' in ln:
            out.append('%5d| %s' % (i, ln[:220]))
            if i > 400 and ln.count('_27') and 'AccessChain' in ln:
                pass
# limit
hits27 = [i for i, ln in enumerate(vsl, 1) if '_27.' in ln or '&_27' in ln]
out.append('_27 refs count=%d first=%s' % (len(hits27), hits27[:20]))

Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/extract_229351_vs.txt').write_text('\n'.join(out), encoding='utf8')
print('wrote', len(out), 'lines, file chars', sum(len(x) for x in out))
