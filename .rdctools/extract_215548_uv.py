from pathlib import Path

lines = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/90ecda7e2c13e67b_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()

print('===== extra UV 480-560 =====')
for i, ln in enumerate(lines[479:560], 480):
    print('%5d %s' % (i, ln[:240]))

print('\n===== child50/52/67 around extraUV =====')
for i, ln in enumerate(lines, 1):
    if any(x in ln for x in ('_44._child50', '_44._child52', '_44._child67', '_44._child66', '_44._child62')):
        print('%5d %s' % (i, ln[:240]))
