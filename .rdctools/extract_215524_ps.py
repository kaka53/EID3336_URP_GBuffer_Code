from pathlib import Path
lines = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/2573294c13f3ad66_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
print('total', len(lines))
# dump full body from Function
start = 0
for i, ln in enumerate(lines):
    if 'Function(' in ln and 'main' in ln.lower() or ln.strip().startswith('Function('):
        start = i
        break
# print resource map around UniformConstant
print('=== resources ===')
for i, ln in enumerate(lines[:350], 1):
    if any(k in ln for k in ('Binding', 'DescriptorSet', 'Image ', 'Uniform ', 'Sampler', 'Location')):
        print('%4d %s' % (i, ln[:200]))
print('=== samples / access _39 / _20 / _23 / _36 / _32 / _34 ===')
for i, ln in enumerate(lines, 1):
    if any(k in ln for k in (
        'ImageSample', 'SampledImage', 'AccessChain(_39', 'Load(_39',
        'AccessChain(_20', 'Load(_20', 'AccessChain(_23', 'AccessChain(_36',
        'AccessChain(_32', 'AccessChain(_34', 'AccessChain(_26', 'AccessChain(_28', 'AccessChain(_30',
        'DPdx', 'DPdy', 'NMin', 'Loop', 'BranchConditional',
    )):
        print('%4d %s' % (i, ln[:220]))
