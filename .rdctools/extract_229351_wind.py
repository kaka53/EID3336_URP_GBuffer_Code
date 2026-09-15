# -*- coding: utf-8 -*-
from pathlib import Path
VS = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/cf659d5dd67c65c6_VS.spvasm').read_text(encoding='utf8', errors='replace')
vsl = VS.splitlines()
out = []
def window(s,e):
    for i in range(s, min(e, len(vsl))+1):
        out.append('%5d| %s' % (i, vsl[i-1][:240]))
out.append('=== VS 360-560 wind locals ===')
window(360, 560)
out.append('\n=== VS 2070-2183 end ===')
window(2070, 2183)
Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/extract_229351_wind.txt').write_text('\n'.join(out), encoding='utf8')
print('wrote', len(out))
