import json
from pathlib import Path

ps = Path('.rdctools/shaders_12_65/f0868f92cd5e06d0_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
print('===== overlay UV / POM setup 520-575 =====')
for i in range(516, 575):
    print(f'{i:5d}|{ps[i-1]}')

print('\n===== mip from dump uniforms20 =====')
d = json.loads(Path('.rdctools/dump_243940.json').read_text(encoding='utf8'))
e = d['3583']
u20 = e['slices'].get('PS_uniforms20', {})
print('u20 keys', list(u20.keys()))
floats = u20.get('floats') or []
print('nfloats', len(floats))
if len(floats) > 104:
    print('child16 @416 float index 104 =', floats[104])
    print('floats[100:110]', floats[100:110])
vars_ = u20.get('vars') or []
for k in vars_:
    if k.get('off') in (416, 420, 424) or 'child16' in k.get('name','') or 'child20' in k.get('name',''):
        print(k)

print('\n===== importer skin bake excerpt =====')
for p in [
    Path('Assets/ColourPass6_VS241568_PS241569_Batch/Editor/ColourPass6VS241568PS241569BatchImporter.cs'),
    Path('Assets/ColourPass6_VS229074_PS229075_Batch/Editor/ColourPass6VS229074PS229075BatchImporter.cs'),
    Path('Assets/ColourPass6_VS239789_PS239790_Batch/Editor/ColourPass6VS239789PS239790BatchImporter.cs'),
]:
    print('\n---', p, p.exists())
    if not p.exists():
        continue
    lines = p.read_text(encoding='utf8').splitlines()
    for i, l in enumerate(lines, 1):
        if any(n in l for n in ('HasCapturedSkinning', 'ssbo', 'BakeSkin', '_UseBakedSkinning', 'ReadWeights', 'static bool', 'Skin', 'flags')):
            print(f'{i:5d}|{l}')
