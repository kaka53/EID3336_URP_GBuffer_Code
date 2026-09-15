from pathlib import Path
ps = Path('.rdctools/shaders_12_65/6a9a760b1ffcb649_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
print('===== PS full =====')
for i,l in enumerate(ps,1):
    print(f'{i:4d}|{l}')
