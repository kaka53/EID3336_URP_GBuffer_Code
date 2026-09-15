from pathlib import Path

a56 = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/90ecda7e2c13e67b_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
a48 = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/0bc71add2993d083_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()

# print family 48 extra N decode around sample 5
print('===== 48 extraN 567-610 =====')
for i, ln in enumerate(a48[566:610], 567):
    print('%5d %s' % (i, ln[:220]))

print('\n===== 48 extra unique around 690-760 =====')
for i, ln in enumerate(a48[689:760], 690):
    print('%5d %s' % (i, ln[:220]))

print('\n===== 48 outputs last 80 =====')
for i, ln in enumerate(a48[-80:], len(a48)-79):
    print('%5d %s' % (i, ln[:220]))
