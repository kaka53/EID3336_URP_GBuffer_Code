from pathlib import Path

p = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/855961aaf793ca54_PS.spvasm')
lines = p.read_text(encoding='utf8', errors='replace').splitlines()
print('nlines', len(lines))

# print sample / image / store / location / accesschain related
keys = ('ImageSample', 'TypeImage', 'TypeSampledImage', 'Location', 'Binding', 'DescriptorSet',
        'AccessChain', 'CompositeExtract', 'CompositeConstruct', 'VectorShuffle',
        'Kill', 'Discard', 'Demote', 'clip', 'FOrdLessThan', 'FOrdGreaterThan',
        'Bitcast', 'ImageFetch', 'DPdx', 'DPdy', 'ExtInst')
for i, ln in enumerate(lines, 1):
    if any(k in ln for k in keys) or 'Store' in ln or 'Load' in ln and 'uniform' in ln.lower():
        if i < 250 or any(k in ln for k in ('ImageSample', 'Location', 'Binding', 'TypeImage', 'Kill', 'Discard', 'Demote')):
            print('%4d %s' % (i, ln[:220]))

print('\n===== first 80 lines =====')
for i, ln in enumerate(lines[:80], 1):
    print('%4d %s' % (i, ln[:220]))
