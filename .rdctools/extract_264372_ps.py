from pathlib import Path

asm = Path('.rdctools/shaders_12_65/d35acbedb5e697f3_PS.spvasm').read_text(encoding='utf8', errors='replace')
lines = asm.splitlines()
print('lines', len(lines))
for i, ln in enumerate(lines, 1):
    if any(k in ln for k in (
        'ImageSample', 'UniformConstant Image', 'OpTypeImage', 'TypeImage',
        'Image2D', 'Image<', 'Binding', 'DescriptorSet',
        'Load(', 'CompositeExtract', 'DPdx', 'FMix', 'FClamp',
    )):
        if i < 250 or 'Image' in ln or 'Binding' in ln or 'DescriptorSet' in ln or 'UniformConstant' in ln:
            print('%4d|%s' % (i, ln[:200]))

print('--- IMAGE / SAMPLE ---')
for i, ln in enumerate(lines, 1):
    if any(k in ln for k in ('ImageSample', 'UniformConstant', 'TypeImage', 'Image2D', 'Image<float', 'Image<uint')):
        print('%4d|%s' % (i, ln[:240]))
