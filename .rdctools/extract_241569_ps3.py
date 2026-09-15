from pathlib import Path
ps = Path('.rdctools/shaders_12_65/474c7cb928af681c_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
print('===== last 80 =====')
for i, l in enumerate(ps[-80:], start=len(ps)-79):
    print(f'{i:5d}|{l}')
print('===== unique-set block 370-530 =====')
for i, l in enumerate(ps[369:530], start=370):
    print(f'{i:5d}|{l}')
