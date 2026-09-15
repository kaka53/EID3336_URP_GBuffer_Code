from pathlib import Path

ps = Path('.rdctools/shaders_12_65/474c7cb928af681c_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
print('PS lines', len(ps))
print('===== TAIL samples / RT / packed / clip =====')
for i, l in enumerate(ps, 1):
    if any(k in l for k in (
        'ImageSample', 'Discard', 'Kill', 'clip', '0.0020', '0.001956', '0.0010',
        '0.3333', '1073741824', '*_12', '*_13', '*_14', '*_15', '*_16',
        'Location(0)', 'Location(1)', 'Location(2)', 'Location(3)', 'Location(4)',
        'Bitcast', '1023', 'child2.z', '_child2', 'Store', 'rt0', 'rt1',
        'sqrt', 'Oct', '2.0000 - 1', '* 2.0000', '.wy', '.xy',
        '_30', '_32', '_34', 'Bias', 'Select(_11',
    )):
        print(f'{i:5d}|{l}')
