from pathlib import Path
lines = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/855961aaf793ca54_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
print('===== struct _29 uniforms30 =====')
# find struct for uniforms30 (bind 6 = _30)
in_struct = False
for i, ln in enumerate(lines, 1):
    if 'struct _29' in ln or (in_struct and ln.strip().startswith('struct ')):
        if 'struct _29' in ln:
            in_struct = True
        elif in_struct:
            break
    if in_struct:
        print('%4d %s' % (i, ln[:220]))

print('\n===== function body from 280 =====')
for i, ln in enumerate(lines[280:], 281):
    print('%4d %s' % (i, ln[:240]))
