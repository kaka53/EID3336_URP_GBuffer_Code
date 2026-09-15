from pathlib import Path
p = Path('Assets/ColourPass6_VS215491_PS215492_Batch/Editor/ColourPass6VS215491PS215492BatchImporter.cs')
text = p.read_text(encoding='utf8')
keys = ('ExpectedEIDs', 'ExpectedInstances', 'ExpectedLayout', 'ExpectedUnique', 'uniforms33', 'uniforms35', 'uniforms23', 'uniforms20', 'res27', 'res29', 'res31', '_P', 'MipBias', 'HasCapturedSkinning', 'MenuItem', 'COMPLETE_9', 'ReadInstanceMatrix', 'flags')
for i, line in enumerate(text.splitlines(), 1):
    if any(k in line for k in keys):
        print(f'{i:4d}|{line}')
