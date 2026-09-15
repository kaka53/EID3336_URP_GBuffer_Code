from pathlib import Path
vs = Path('.rdctools/shaders_12_65/c4dd8d3f9f3b1b5b_VS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
# print skin / instance / packed / outputs
keys = ('ssbo', 'struct27', '_27', 'Bitcast', '1073741824', '0.0020', 'vert_main', 'Position', 'output', 'Skin', 'child1', 'Load', 'Image')
print('VS lines', len(vs))
for i,l in enumerate(vs,1):
    if any(k.lower() in l.lower() for k in ['ssbo', 'NonWritable', 'struct27', 'Binding(7)', '1073741824', '0.0020', 'vert_main', 'skinned', 'influence', 'joint']):
        print(f'{i:4d}|{l[:220]}')
print('--- last 80 ---')
for i,l in enumerate(vs[-80:], len(vs)-79):
    print(f'{i:4d}|{l[:220]}')
