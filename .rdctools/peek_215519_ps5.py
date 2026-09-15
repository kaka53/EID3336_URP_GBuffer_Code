from pathlib import Path
lines = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/86e06de4d07f39b8_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
# unique-set overlay + extra maps + encode: print child accesses 500-960
for i in range(500, 960):
    l = lines[i]
    if any(k in l for k in ['_child', '*_37', '*_38', '*_39', '*_40', '*_41', '*_42', '*_43', '*_44', 'ImageSample', 'FMix', 'Select']):
        print(f'{i}: {l[:220]}')
