from pathlib import Path
lines = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/2573294c13f3ad66_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
print('=== 450-829 full remaining body ===')
for i, ln in enumerate(lines[449:], 450):
    print('%5d %s' % (i, ln[:240]))
