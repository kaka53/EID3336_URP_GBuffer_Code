from pathlib import Path
import re

asm = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/317c0cc4af786020_PS.spvasm').read_text(encoding='utf8', errors='replace')
print('lines', asm.count('\n'), 'chars', len(asm))

# Resource decls
for pat in [
    r'OpTypeImage',
    r'UniformConstant',
    r'DescriptorSet',
    r'Binding',
    r'Location',
    r'ImageSample',
    r'OpEntryPoint',
    r'Output',
]:
    pass

keys = [
    'TypeImage',
    'UniformConstant',
    'DescriptorSet',
    'Binding',
    'Location',
    'ImageSampleImplicitLod',
    'ImageSampleExplicitLod',
    'ImageSampleDref',
    'EntryPoint',
    'Output',
    'Input',
    'Decorate',
    'MemberDecorate',
    'Variable',
]
hits = {k: [] for k in keys}
for i, line in enumerate(asm.splitlines(), 1):
    for k in keys:
        if k in line:
            hits[k].append((i, line.strip()))

for k in keys:
    xs = hits[k]
    print('\n===', k, 'n=', len(xs), '===')
    show = xs if k not in ('Decorate', 'MemberDecorate', 'Variable') else xs[:80]
    if k in ('Decorate',) and len(xs) > 80:
        # filter useful decorate
        useful = [x for x in xs if any(t in x[1] for t in ('DescriptorSet', 'Binding', 'Location', 'BuiltIn', 'NonWritable'))]
        show = useful[:120]
    for ln, text in show:
        print('%5d %s' % (ln, text[:220]))
