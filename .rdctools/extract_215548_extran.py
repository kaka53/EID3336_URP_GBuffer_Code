from pathlib import Path

a56 = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/90ecda7e2c13e67b_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()

print('===== 56 extraN 560-650 =====')
for i, ln in enumerate(a56[559:650], 560):
    print('%5d %s' % (i, ln[:240]))

print('\n===== child offsets for struct of _44 =====')
for i, ln in enumerate(a56, 1):
    if 'MemberDecorate' in ln and ('Offset' in ln or 'child' in ln.lower()):
        if i < 400:
            print('%5d %s' % (i, ln[:240]))
