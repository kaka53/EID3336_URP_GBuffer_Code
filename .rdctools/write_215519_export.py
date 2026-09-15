from pathlib import Path

src = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215521_215522_batch.py').read_text(encoding='utf8')
repls = [
    ("MESH_ITEM = {\n    3536: '40.1',\n    3540: '40.2',\n}", "MESH_ITEM = {\n    3448: '52.1',\n}"),
    ('EIDS = [3536, 3540]', 'EIDS = [3448]'),
    ("FAMILY = 'VS215521_PS215522'", "FAMILY = 'VS215519_PS215520'"),
    ('EXPECTED = (215521, 215522)', 'EXPECTED = (215519, 215520)'),
    ('ColourPass6_VS215521_PS215522_Batch', 'ColourPass6_VS215519_PS215520_Batch'),
    ("UNIQUE_MATERIAL = {'res28', 'res30', 'res32', 'res33', 'res34', 'res35'}",
     "UNIQUE_MATERIAL = {'res33', 'res35', 'res37', 'res38', 'res39', 'res40', 'res41', 'res42', 'res43', 'res44'}"),
    ('4c2374981371b928', '86e06de4d07f39b8'),
    ("VS215521_PS215522_BatchManifest.json", "VS215519_PS215520_BatchManifest.json"),
    ("export_215521_215522_batch_result.json", "export_215519_215520_batch_result.json"),
    ("'localMaterialCB': 'PS uniforms37 464B packed _P00.._P28'",
     "'localMaterialCB': 'PS uniforms46 768B packed _P00.._P47'"),
    ("'materialIdCB': 'PS uniforms39 16B'",
     "'materialIdCB': 'PS uniforms48 16B'"),
    ("VS215521", "VS215519"),
    ("PS215522", "PS215520"),
]
for a, b in repls:
    if a not in src:
        raise SystemExit('missing fragment: ' + repr(a[:80]))
    src = src.replace(a, b)

old_roots = """    search_roots = [
        os.path.join(ASSETS, 'ColourPass6_VS215519_PS215520_Batch', 'TextureDatabase'),
        os.path.join(ASSETS, 'ColourPass6_VS215511_PS215514_Batch', 'TextureDatabase'),
        os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'ImportedTextures'),
        os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'Resources', 'EID3336Textures'),
        os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'Resources', 'EID3332Textures'),
        os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'Resources', 'EID3490Textures'),
    ]"""
new_roots = """    search_roots = [
        os.path.join(ASSETS, 'ColourPass6_VS215519_PS215520_Batch', 'TextureDatabase'),
        os.path.join(ASSETS, 'ColourPass6_VS215521_PS215522_Batch', 'TextureDatabase'),
        os.path.join(ASSETS, 'ColourPass6_VS215511_PS215514_Batch', 'TextureDatabase'),
        os.path.join(ASSETS, 'ColourPass6_VS238900_PS238901_Batch', 'TextureDatabase'),
        os.path.join(ASSETS, 'ColourPass6_VS209986_PS209987_Batch', 'TextureDatabase'),
        os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'ImportedTextures'),
        os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'Resources', 'EID3336Textures'),
        os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'Resources', 'EID3332Textures'),
        os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'Resources', 'EID3490Textures'),
    ]"""
if old_roots not in src:
    raise SystemExit('search_roots missing after rename')
src = src.replace(old_roots, new_roots)

bad = []
for token in ('3536', '3540', 'uniforms37', '4c237498'):
    if token in src:
        bad.extend('%s :: %s' % (token, ln.strip()[:140]) for ln in src.splitlines() if token in ln)
allowed_215521 = "ColourPass6_VS215521_PS215522_Batch"
for ln in src.splitlines():
    if ('215521' in ln or '215522' in ln) and allowed_215521 not in ln:
        bad.append(ln.strip()[:140])
if bad:
    raise SystemExit('leftovers:\n' + '\n'.join(bad))
if 'uniforms30' not in src or 'uniforms24' not in src:
    raise SystemExit('lost instance CB names')
if '86e06de4d07f39b8' not in src or 'b6789548dbc85813' not in src:
    raise SystemExit('lost shader hashes')

out = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215519_215520_batch.py')
out.write_text(src, encoding='utf8')
print('wrote', out, 'lines', len(src.splitlines()))
