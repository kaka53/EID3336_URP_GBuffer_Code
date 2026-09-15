from pathlib import Path

p = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/8688786ffe26e9bc_PS.spvasm')
lines = p.read_text(encoding='utf8', errors='replace').splitlines()
print('total', len(lines), 'bytes', p.stat().st_size)

print('=== resources / entry / bindings ===')
for i, ln in enumerate(lines[:500], 1):
    if any(k in ln for k in (
        'Binding', 'DescriptorSet', 'Image', 'Uniform', 'Sampler',
        'Location', 'EntryPoint', 'Decorate', 'MemberDecorate',
    )):
        print('%4d %s' % (i, ln[:240]))

print('=== samples / stores / control ===')
for i, ln in enumerate(lines, 1):
    if any(k in ln for k in (
        'ImageSample', 'SampledImage', 'DPdx', 'DPdy',
        'NMin', 'Loop', 'BranchConditional', 'Kill', 'Discard',
        'Store', 'Output',
    )):
        if 'AccessChain' in ln:
            continue
        print('%4d %s' % (i, ln[:240]))
