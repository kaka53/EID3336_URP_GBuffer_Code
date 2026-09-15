from pathlib import Path

root = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace')
vs = (root / '.rdctools/shaders_12_65/951f4c6338c81689_VS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
ps = (root / '.rdctools/shaders_12_65/d3eb4657e302f3fe_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()

print('=== VS rest from 200 ===')
for i, line in enumerate(vs):
    if i >= 200:
        print(f'{i:4d}|{line[:180]}')

print('\n=== PS head structs / decorations / samples ===')
for i, line in enumerate(ps):
    l = line.lower()
    if i < 280 or any(x in l for x in [
        'entrypoint', 'imagesample', 'uniformconstant', 'location',
        '0.002', 'dxt', 'normal', 'albedo', 'rough', 'ao',
        'rt0', 'output', 'clip', 'discard', 'kill',
        'child', 'offset(', 'sampler', 'image',
    ]):
        if i < 320 or any(x in l for x in [
            'entrypoint', 'imagesample', 'uniformconstant image',
            'output float', 'location', 'discard', 'kill', 'clip',
        ]):
            print(f'{i:4d}|{line[:180]}')
