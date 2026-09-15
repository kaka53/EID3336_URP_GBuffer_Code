from pathlib import Path

ps = Path('.rdctools/shaders_12_65/f0868f92cd5e06d0_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
print('lines', len(ps), 'bytes', Path('.rdctools/shaders_12_65/f0868f92cd5e06d0_PS.spvasm').stat().st_size)
print('===== bindings / images / samplers / uniforms =====')
keys = (
    'DescriptorSet', 'Binding', 'UniformConstant', 'Image', 'sampler',
    'ImageSample', 'SampledImage', 'struct', 'ArrayStride', 'Offset',
    'OpStore', 'CompositeInsert', 'Phi', 'NMax', 'DPdx', 'DPdy',
)
# no Op prefix in spiregg
needles = (
    'DescriptorSet', 'Binding(', 'UniformConstant', 'ImageSampleImplicitLod',
    'ImageSampleExplicitLod', 'ImageSample', 'SampledImage', 'ArrayStride',
    'struct17', 'struct19', 'struct21', 'struct36', 'struct38', 'struct40',
    'struct41', 'struct42', 'struct43', 'struct23',
    '_18 ', ' _20 ', ' _23 ', ' _37 ', ' _39 ', ' _41 ', ' _43 ',
    'res27', 'res29', 'res31', 'res33', 'res35', 'res36', 'res38',
)
for i, l in enumerate(ps, 1):
    if any(n in l for n in ('DescriptorSet', 'Binding(', 'UniformConstant', 'ArrayStride(256)', 'ImageSampleImplicitLod', 'ImageSampleExplicitLod', 'ImageSampleProj', 'SampledImage')):
        if i < 400 or 'ImageSample' in l or 'UniformConstant' in l or 'DescriptorSet' in l:
            print(f'{i:5d}|{l}')

print('===== first 220 =====')
for i, l in enumerate(ps[:220], 1):
    print(f'{i:5d}|{l}')
