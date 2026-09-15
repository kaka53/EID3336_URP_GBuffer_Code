from pathlib import Path

asm = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/90ecda7e2c13e67b_PS.spvasm').read_text(encoding='utf8', errors='replace')
print('lines', len(asm.splitlines()), 'chars', len(asm))
keys = [
    'ImageSample', 'ImageQuery', 'UniformConstant Image', 'Output', 'Location',
    'Binding', 'uniforms44', 'res34', 'res36', 'res38', 'res40', 'res41', 'res42',
    'refract', 'Discard', 'Kill', 'clip', 'DPdx', 'FWidth',
]
for k in keys:
    n = asm.count(k)
    if n:
        print('%s: %d' % (k, n))

# print unique-ish resource / output / sample lines
for i, ln in enumerate(asm.splitlines(), 1):
    if any(x in ln for x in (
        'UniformConstant', 'Location', 'Binding', 'ImageSample', 'ImageQueryLod',
        'Output', '%_12', '%_13', '%_14', '%_15', '%_16',
        'res34', 'res36', 'res38', 'res40', 'res41', 'res42', 'uniforms44',
        'Discard', 'Kill', 'OpKill', 'demote',
    )):
        if 'VT' in ln or 'virtual' in ln.lower():
            continue
        print('%5d %s' % (i, ln[:220]))
