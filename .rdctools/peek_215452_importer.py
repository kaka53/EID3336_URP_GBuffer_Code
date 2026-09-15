from pathlib import Path
p = Path('Assets/ColourPass6_VS215452_PS215453_Batch/Editor/ColourPass6VS215452PS215453BatchImporter.cs')
t = p.read_text(encoding='utf8')
print('len', len(t), 'lines', t.count('\n')+1)
keys = ['ExpectedEIDs','ExpectedInstances','ExpectedLayoutVariants','ExpectedUniqueMeshes','CreateMaterial','uniforms24','uniforms25','uniforms19','ReadInstanceMatrix','ssbo','LoadTexture','res25','res26','res27','ReadInput','BLEND','input4','input5','input6','SNORM','BakeSkin','flags','Queue','Stencil','AlphaTest','vertexAttributes','BuildScene','stride']
for k in keys:
    idx = 0
    n = 0
    while True:
        i = t.find(k, idx)
        if i < 0:
            break
        n += 1
        line = t.rfind('\n', 0, i) + 1
        ln = t.count('\n', 0, i) + 1
        frag = t[line:t.find('\n', i)]
        if n <= 6:
            print(f'{ln:4d} {k}: {frag[:220]}')
        idx = i + len(k)
    if n == 0:
        print('NONE', k)
