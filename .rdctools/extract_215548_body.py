from pathlib import Path

asm = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/90ecda7e2c13e67b_PS.spvasm').read_text(encoding='utf8', errors='replace')
lines = asm.splitlines()

# print struct44 children if present
for i, ln in enumerate(lines, 1):
    if 'struct43' in ln or 'struct44' in ln or '_44.' in ln or 'MemberDecorate' in ln and '44' in ln:
        if i < 340 or '_44' in ln or 'struct43' in ln:
            print('%5d %s' % (i, ln[:240]))

print('\n===== main unique-material samples 450-650 =====')
for i, ln in enumerate(lines[430:650], 431):
    print('%5d %s' % (i, ln[:240]))

print('\n===== extra 16B / child76-79 / _P31 / offset 496 =====')
for i, ln in enumerate(lines, 1):
    if any(x in ln for x in ('_44._child76', '_44._child77', '_44._child78', '_44._child79', '_44._child68', '_44._child69', '_44._child70', '_44._child71', '_44._child72', '_44._child73', '_44._child74', '_44._child75', 'Offset(496)', 'Offset(500)', 'Offset(504)', 'Offset(508)')):
        print('%5d %s' % (i, ln[:240]))
