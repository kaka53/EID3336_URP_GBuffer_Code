from pathlib import Path
p = Path('Assets/ColourPass6_VS215549_PS215550_Batch/Editor/ColourPass6VS215549PS215550BatchImporter.cs')
text = p.read_text(encoding='utf8')
keys = ('ExpectedEIDs', 'ExpectedInstances', 'ExpectedLayout', 'ExpectedUnique', 'uniforms30', 'uniforms32', 'uniforms20', 'uniforms23', 'res23', 'res25', 'res27', '_P', 'MipBias', 'HasCapturedSkinning', 'MenuItem', 'COMPLETE_9', 'ReadInstanceMatrix', 'ApplyInstance')
for i, line in enumerate(text.splitlines(), 1):
    if any(k in line for k in keys):
        print(f'{i:4d}|{line}')
