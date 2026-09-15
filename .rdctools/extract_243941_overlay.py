from pathlib import Path

ps = Path('.rdctools/shaders_12_65/f0868f92cd5e06d0_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
print('===== 575-720 overlay UV + lighting =====')
for i in range(575, 721):
    print(f'{i:5d}|{ps[i-1]}')
