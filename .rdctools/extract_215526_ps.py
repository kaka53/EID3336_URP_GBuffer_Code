from pathlib import Path
lines = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/f1a7bd79bd85cf88_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
print('total', len(lines))
print('=== resources ===')
for i, ln in enumerate(lines[:400], 1):
    if any(k in ln for k in ('Binding', 'DescriptorSet', 'Image ', 'Uniform ', 'Sampler', 'Location', 'EntryPoint')):
        print('%4d %s' % (i, ln[:220]))
print('=== samples / access / control ===')
for i, ln in enumerate(lines, 1):
    if any(k in ln for k in (
        'ImageSample', 'SampledImage', 'AccessChain', 'DPdx', 'DPdy',
        'NMin', 'Loop', 'BranchConditional', 'Kill', 'Discard',
        'Store(_', 'Output',
    )):
        # filter AccessChain noise a bit
        if 'AccessChain' in ln and not any(x in ln for x in ('_38', '_21', '_24', '_40', '_19', '_28', '_30', '_32', '_33', '_34', '_35', '_36')):
            continue
        print('%4d %s' % (i, ln[:240]))
