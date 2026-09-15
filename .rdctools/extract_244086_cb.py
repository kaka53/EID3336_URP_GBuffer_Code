from pathlib import Path

lines = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/8688786ffe26e9bc_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()

print('=== struct43 / uniforms44 member offsets ===')
for i, ln in enumerate(lines, 1):
    if 'MemberDecorate' in ln and ('_43' in ln or 'struct43' in ln or 'Offset' in ln and '43' in ln):
        if 'MemberDecorate' in ln:
            print('%4d %s' % (i, ln[:240]))

print('=== type of _44 / struct43 ===')
for i, ln in enumerate(lines[:430], 1):
    if any(x in ln for x in ('struct43', 'Struct _43', 'TypeStruct', '_44', 'child', 'Name(_43', 'Name(_44', 'MemberName')):
        print('%4d %s' % (i, ln[:240]))
