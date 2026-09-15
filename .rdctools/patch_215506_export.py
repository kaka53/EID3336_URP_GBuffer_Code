from pathlib import Path

p = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215506_215508_batch.py')
t = p.read_text(encoding='utf8')

repls = [
    (
        "MESH_ITEM = {\n    2538: '23.1',\n    2542: '23.2',\n    2547: '23.3',\n    2552: '23.4',\n}",
        "MESH_ITEM = {\n    3261: '30.1',\n    3265: '30.2',\n    3269: '30.3',\n}",
    ),
    ("EIDS = [2538, 2542, 2547, 2552]", "EIDS = [3261, 3265, 3269]"),
    ("FAMILY = 'VS215499_PS215501'", "FAMILY = 'VS215506_PS215508'"),
    ("EXPECTED = (215499, 215501)", "EXPECTED = (215506, 215508)"),
    ("ColourPass6_VS215499_PS215501_Batch", "ColourPass6_VS215506_PS215508_Batch"),
    ("UNIQUE_MATERIAL = {'res23', 'res25', 'res27'}", "UNIQUE_MATERIAL = {'res31', 'res33', 'res35'}"),
    (
        "(rd.ShaderStage.Vertex, 'VS215499'), (rd.ShaderStage.Pixel, 'PS215501')",
        "(rd.ShaderStage.Vertex, 'VS215506'), (rd.ShaderStage.Pixel, 'PS215508')",
    ),
    ("VS215499_PS215501_BatchManifest.json", "VS215506_PS215508_BatchManifest.json"),
    ("export_215499_215501_batch_result.json", "export_215506_215508_batch_result.json"),
    ("'localMaterialCB': 'PS uniforms30 496B'", "'localMaterialCB': 'PS uniforms38 464B'"),
    ("'instanceBuffer': 'VS uniforms28 / PS uniforms20 stride 256'", "'instanceBuffer': 'VS uniforms28 / PS uniforms23 stride 256'"),
    ("'skinning': 'flags bit32 all zero; ssbo30 not baked'", "'skinning': 'flags bit32 all zero; ssbo30 not baked; skip dump when >1MB'"),
]
for a, b in repls:
    if a not in t:
        print('MISSING', a[:90])
    else:
        t = t.replace(a, b)

old_roots = """    search_roots = [
        os.path.join(ASSETS, 'ColourPass6_VS215505_PS215507_Batch', 'TextureDatabase'),
        os.path.join(ASSETS, 'ColourPass6_VS215495_PS215497_Batch', 'TextureDatabase'),
        os.path.join(ASSETS, 'ColourPass6_VS215506_PS215508_Batch', 'TextureDatabase'),
        os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'ImportedTextures'),
    ]"""
new_roots = """    search_roots = [
        os.path.join(ASSETS, 'ColourPass6_VS215506_PS215508_Batch', 'TextureDatabase'),
        os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'ImportedTextures'),
    ]"""
if old_roots not in t:
    print('MISSING roots')
    idx = t.find('search_roots')
    print(repr(t[idx:idx+500]))
else:
    t = t.replace(old_roots, new_roots)

old_rw = """                rws['VS'].append({
                    'index': i,
                    'name': name,
                    'binding': int(u.access.byteOffset),
                    'rid': rid(d.resource),
                    'offset': int(d.byteOffset),
                    'size': int(d.byteSize),
                })"""
new_rw = """                rec = {
                    'index': i,
                    'name': name,
                    'binding': int(u.access.byteOffset),
                    'rid': rid(d.resource),
                    'offset': int(d.byteOffset),
                    'size': int(d.byteSize),
                    'sha256': '',
                    'file': None,
                }
                sz = int(d.byteSize)
                if 0 < sz <= 1000000:
                    raw = getbuf(d.resource, d.byteOffset, d.byteSize)
                    h = hashlib.sha256(raw).hexdigest()
                    rec['sha256'] = h
                    rec['file'] = save(os.path.join(CBS, 'VS_%02d_%s_%s.bytes' % (i, name, h[:16])), raw)
                rws['VS'].append(rec)"""
if old_rw not in t:
    print('MISSING rw')
else:
    t = t.replace(old_rw, new_rw)

if "'packedNormal': 'NORMAL.x'," in t:
    t = t.replace(
        "'packedNormal': 'NORMAL.x',",
        "'packedNormal': 'NORMAL.x from _input1',\n            'rt0': 'hardcoded (0,0,0,0.5)',\n            'vt': 'omitted unless look is wrong',",
    )

leftovers = [x for x in ['215499', '215501', '2538', '2542', 'res23', 'uniforms30'] if x in t]
print('leftovers', leftovers)
p.write_text(t, encoding='utf8')
print('wrote', p)
