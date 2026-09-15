from pathlib import Path

ps = Path('.rdctools/shaders_12_65/f0868f92cd5e06d0_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()

print('===== struct40 uniforms41 =====')
inside = False
for i, l in enumerate(ps, 1):
    if 'struct _40' in l or 'struct40' in l and 'Block' in l:
        inside = True
    if inside:
        print(f'{i:5d}|{l}')
        if l.strip() == '}' or (inside and i > 1 and l.startswith('struct ') and 'struct _40' not in l and 'struct40' not in l):
            if 'struct _40' not in l and 'struct40' not in l:
                break
            if l.strip() == '}':
                break

print('\n===== struct42 uniforms43 =====')
inside = False
for i, l in enumerate(ps, 1):
    if 'struct _42' in l:
        inside = True
    if inside:
        print(f'{i:5d}|{l}')
        if l.strip() == '}':
            break

print('\n===== sampledimage / load image / sample windows =====')
needles = (
    'SampledImage', 'ImageSampleImplicitLod', 'ImageSampleExplicitLod',
    'Load(_27', 'Load(_29', 'Load(_31', 'Load(_33', 'Load(_35', 'Load(_36', 'Load(_38',
    '_27', '_29', '_31', '_33', '_35', '_36', '_38',
)
windows = [447, 451, 467, 573, 622, 647, 729]
for w in windows:
    print(f'\n----- around {w} -----')
    for i in range(max(1, w-25), min(len(ps)+1, w+15)):
        print(f'{i:5d}|{ps[i-1]}')

print('\n===== Output / Store / loc / rt =====')
for i, l in enumerate(ps, 1):
    if any(n in l for n in ('Output(', 'Location(', 'Store(_3', 'Store(_4', 'Store(_5', 'Store(_6', 'Store(_7', 'Store(_8', 'Store(_9', 'Store(_10', 'Store(_11', 'Store(_12', 'Store(_13', 'Store(_14', 'Store(_15', 'Store(_16', 'Discard', 'Kill', 'clip', 'AlphaTest')):
        print(f'{i:5d}|{l}')
