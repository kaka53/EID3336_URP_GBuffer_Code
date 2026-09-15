from pathlib import Path

p = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/2573294c13f3ad66_PS.spvasm')
text = p.read_text(encoding='utf8', errors='replace')
lines = text.splitlines()

print('=== first 120 lines ===')
for i, ln in enumerate(lines[:120], 1):
    print('%5d %s' % (i, ln[:220]))

print('\n=== uniforms / struct / Block ===')
for i, ln in enumerate(lines, 1):
    if any(k in ln for k in ('uniforms', 'Block', 'ArrayStride', 'Offset', 'MemberName', 'struct')):
        if i < 400 or 'uniforms' in ln or 'MemberName' in ln:
            print('%5d %s' % (i, ln[:240]))
