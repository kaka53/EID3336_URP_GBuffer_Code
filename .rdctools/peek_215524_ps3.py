from pathlib import Path

p = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/2573294c13f3ad66_PS.spvasm')
lines = p.read_text(encoding='utf8', errors='replace').splitlines()

print('=== lines 290-450 (resources + start of main) ===')
for i, ln in enumerate(lines[289:450], 290):
    print('%5d %s' % (i, ln[:240]))

print('\n=== ImageSample / SampledImage / AccessChain _39 ===')
for i, ln in enumerate(lines, 1):
    if any(k in ln for k in (
        'ImageSample', 'SampledImage', 'AccessChain(_39', 'Load(_39',
        'res26', 'res28', 'res30', 'res32', 'res34', 'res36',
        '_26', '_28', '_30', '_32', '_34', '_36',
    )):
        if 'struct' in ln and 'Block' in ln:
            continue
        print('%5d %s' % (i, ln[:240]))
