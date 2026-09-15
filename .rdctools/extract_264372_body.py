from pathlib import Path
lines = Path('.rdctools/shaders_12_65/d35acbedb5e697f3_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
for i, ln in enumerate(lines, 1):
    if 240 <= i <= 507:
        print('%4d|%s' % (i, ln[:220]))
