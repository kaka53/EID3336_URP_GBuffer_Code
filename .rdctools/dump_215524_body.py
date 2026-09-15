from pathlib import Path
lines = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/2573294c13f3ad66_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
print('=== 330-829 body ===')
for i, ln in enumerate(lines[329:], 330):
    print('%4d %s' % (i, ln[:240]))
