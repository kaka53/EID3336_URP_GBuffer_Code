from pathlib import Path

lines = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/8688786ffe26e9bc_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()

print('=== unique image loads ===')
for i, ln in enumerate(lines, 1):
    if any(x in ln for x in (
        'Load(_33', 'Load(_35', 'Load(_37', 'Load(_38', 'Load(_39',
        'Load(_40', 'Load(_41', 'Load(_42',
    )):
        print('%4d %s' % (i, ln[:220]))

print('=== overlay/extra 680-920 ===')
for i, ln in enumerate(lines[679:920], 680):
    print('%4d %s' % (i, ln[:220]))
