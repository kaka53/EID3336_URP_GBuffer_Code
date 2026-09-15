from pathlib import Path

ps = Path('.rdctools/shaders_12_65/f0868f92cd5e06d0_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()

print('===== last 180 (RT packing) =====')
for i, l in enumerate(ps[-180:], len(ps)-179):
    print(f'{i:5d}|{l}')

print('\n===== child loads of interest =====')
needles = (
    '_41._child4', '_41._child7', '_41._child11', '_41._child15', '_41._child16',
    '_41._child17', '_41._child19', '_41._child20', '_41._child21', '_41._child28',
    '_41._child29', '_41._child35', '_41._child46', '_41._child50', '_41._child51',
    '_41._child52', '_41._child53', '_41._child56', '_41._child57', '_41._child58',
    '_41._child59', '_41._child61', '_41._child62', '_41._child63', '_41._child64',
    '_41._child65', '_41._child68', '_41._child70', '_41._child71', '_41._child72',
    '_41._child78', '_41._child79', 'Discard', 'Kill', 'clip',
)
for i, l in enumerate(ps, 1):
    if any(n in l for n in needles):
        print(f'{i:5d}|{l}')

print('\n===== UV / albedo mix around 380-430 =====')
for i in range(360, 422):
    print(f'{i:5d}|{ps[i-1]}')

print('\n===== extra / materialY around 480-560 =====')
for i in range(468, 550):
    print(f'{i:5d}|{ps[i-1]}')
