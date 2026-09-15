from pathlib import Path

ps_path = Path('.rdctools/shaders_12_65/474c7cb928af681c_PS.spvasm')
vs_path = Path('.rdctools/shaders_12_65/9bfd93b2c33c7fc3_VS.spvasm')
print('PS exists', ps_path.exists(), 'size', ps_path.stat().st_size if ps_path.exists() else 0)
print('VS exists', vs_path.exists(), 'size', vs_path.stat().st_size if vs_path.exists() else 0)
ps = ps_path.read_text(encoding='utf8', errors='replace').splitlines()
keys = (
    'UniformConstant', 'DescriptorSet', 'Binding', 'ArrayStride', 'ImageSample',
    'Image *', 'sampler', 'clip', 'Discard', 'Kill', '0.0020', '0.001956',
    '0.0010', '0.3333', '1023', 'DXT', 'child', 'Location', 'EntryPoint',
    'OpTypeImage', 'TypeImage', 'TypeSampler', 'TypeSampledImage',
    'Bitcast', '1073741824', 'frontFace', 'FrontFacing',
)
print('===== PS KEY =====')
for i, l in enumerate(ps, 1):
    if any(k in l for k in keys) or 'Image' in l or 'Sample' in l:
        print(f'{i:5d}|{l}')
