from pathlib import Path

paths = [
    Path('Assets/ColourPass6_VS241568_PS241569_Batch/Editor/ColourPass6VS241568PS241569BatchImporter.cs'),
    Path('Assets/ColourPass6_VS229074_PS229075_Batch/Editor/ColourPass6VS229074PS229075BatchImporter.cs'),
    Path('Assets/ColourPass6_VS215549_PS215550_Batch/Shaders/EID215549215550GBuffer.hlsl'),
    Path('Assets/ColourPass6_VS215549_PS215550_Batch/Shaders/EID215549215550GBuffer.shader'),
    Path('Assets/ColourPass6_VS215549_PS215550_Batch/Editor/ColourPass6VS215549PS215550BatchImporter.cs'),
]
needles = (
    'HasCapturedSkinning', 'ssbo30', 'ssbo27', '_UseBakedSkinning', 'BakeSkin',
    'ReadWeights', 'res23', 'res25', 'res27', 'rt0', 'RT0', 'overlay',
    'uniforms', 'ExpectedEIDs', 'ExpectedInstances',
)
for p in paths:
    print('\n===== %s =====' % p)
    if not p.exists():
        print('MISSING')
        continue
    lines = p.read_text(encoding='utf8').splitlines()
    for i, l in enumerate(lines, 1):
        if any(n in l for n in needles):
            print(f'{i:5d}|{l}')
