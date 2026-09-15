from pathlib import Path

lines = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/8688786ffe26e9bc_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()

print('=== Load/Access of unique images 33/35/37/38/39/40/41/42 and local 44 ===')
for i, ln in enumerate(lines, 1):
    if any(x in ln for x in (
        'Load(_33', 'Load(_35', 'Load(_37', 'Load(_38', 'Load(_39', 'Load(_40', 'Load(_41', 'Load(_42',
        'Load(_44', 'AccessChain(_44', 'AccessChain(_21', 'AccessChain(_46',
    )):
        print('%4d %s' % (i, ln[:240]))

print('=== first 220 func lines around samples ===')
for i, ln in enumerate(lines[430:950], 431):
    print('%4d %s' % (i, ln[:220]))
