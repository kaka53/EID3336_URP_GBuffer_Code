from pathlib import Path

lines = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/90ecda7e2c13e67b_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
print('===== 650-780 (child76 / extra unique) =====')
for i, ln in enumerate(lines[649:780], 650):
    print('%5d %s' % (i, ln[:240]))

print('\n===== 1540-1722 (child72/73/69 + outputs) =====')
for i, ln in enumerate(lines[1539:], 1540):
    print('%5d %s' % (i, ln[:240]))
