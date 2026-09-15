from pathlib import Path
ps = Path('.rdctools/shaders_12_65/474c7cb928af681c_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
print('===== 530-760 gate =====')
for i, l in enumerate(ps[529:760], start=530):
    print(f'{i:5d}|{l}')
print('===== 1648-1768 RT assemble =====')
for i, l in enumerate(ps[1647:], start=1648):
    print(f'{i:5d}|{l}')
