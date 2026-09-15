from pathlib import Path
p = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/855961aaf793ca54_PS.spvasm')
text = p.read_text(encoding='utf8', errors='replace')
print('lines', text.count('\n'), 'bytes', p.stat().st_size)
needles = [
    'ImageSampleImplicitLod', 'ImageSampleExplicitLod', 'ImageSample',
    'UniformConstant', 'OpTypeImage', 'TypeImage',
    'Store', 'Location', 'Decorate',
    'clip', 'Discard', 'Kill', 'demote',
    'res23', 'res25', 'res27',
    'uniforms30', 'uniforms17', 'uniforms32', 'uniforms20',
]
for n in needles:
    print('%s count=%d' % (n, text.count(n)))
