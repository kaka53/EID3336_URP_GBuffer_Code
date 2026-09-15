# -*- coding: utf-8 -*-
from pathlib import Path
VS = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/cf659d5dd67c65c6_VS.spvasm').read_text(encoding='utf8', errors='replace')
PS = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/25afab1205707dfd_PS.spvasm').read_text(encoding='utf8', errors='replace')
out = []
vsl = VS.splitlines()
psl = PS.splitlines()

out.append('=== VS _33._child refs ===')
for i, ln in enumerate(vsl, 1):
    if '_33._child' in ln or '&_33.' in ln:
        out.append('%5d| %s' % (i, ln[:220]))

out.append('\n=== VS _24._child (uniforms24 wind) ===')
for i, ln in enumerate(vsl, 1):
    if '_24._child' in ln or '&_24.' in ln:
        out.append('%5d| %s' % (i, ln[:220]))

out.append('\n=== VS _20._child (uniforms20) ===')
for i, ln in enumerate(vsl, 1):
    if '_20._child' in ln or '&_20.' in ln:
        out.append('%5d| %s' % (i, ln[:220]))

out.append('\n=== VS _22._child (camera/VP) ===')
n = 0
for i, ln in enumerate(vsl, 1):
    if '_22._child' in ln or '&_22.' in ln:
        out.append('%5d| %s' % (i, ln[:220]))
        n += 1
        if n > 40:
            out.append('... truncated')
            break

out.append('\n=== PS _30._child ===')
for i, ln in enumerate(psl, 1):
    if '_30._child' in ln or '&_30.' in ln:
        out.append('%5d| %s' % (i, ln[:220]))

out.append('\n=== PS remaining 413-620 ===')
for i in range(413, min(621, len(psl)+1)):
    out.append('%5d| %s' % (i, psl[i-1][:240]))

Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/extract_229351_cb.txt').write_text('\n'.join(out), encoding='utf8')
print('wrote', len(out))
