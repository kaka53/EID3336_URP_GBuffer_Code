from pathlib import Path

lines = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/8688786ffe26e9bc_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()

print('=== remaining func 950-end samples/stores/gates ===')
for i, ln in enumerate(lines[949:], 950):
    if any(k in ln for k in (
        'ImageSample', 'SampledImage', 'Load(_', 'Store',
        'child', 'Kill', 'Discard', 'Loop', 'BranchConditional',
        'Location', '_33', '_35', '_37', '_38', '_39', '_40', '_41', '_42',
        '_53', '_54', '_55',
    )):
        print('%4d %s' % (i, ln[:240]))
