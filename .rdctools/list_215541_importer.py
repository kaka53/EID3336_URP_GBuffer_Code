# -*- coding: utf-8 -*-
from pathlib import Path
p = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215541_PS215542_Batch/Editor/ColourPass6VS215541PS215542BatchImporter.cs')
t = p.read_text(encoding='utf8')
lines = t.splitlines()
# print function starts
for i, ln in enumerate(lines, 1):
    if ln.strip().startswith('static ') and ('(' in ln):
        print('%4d %s' % (i, ln[:120]))
print('TOTAL', len(lines))
