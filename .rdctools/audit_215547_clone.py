from pathlib import Path

imp = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215547_PS215548_Batch/Editor/ColourPass6VS215547PS215548BatchImporter.cs').read_text(encoding='utf8')
exp = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215547_215548_batch.py').read_text(encoding='utf8')
root_meta = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215547_PS215548_Batch.meta').read_text(encoding='utf8')

print('===== importer needles =====')
for needle in ['ExpectedEIDs', 'ExpectedInstances', 'ExpectedUniqueMeshes', 'uniforms44', 'i < 32', '512', '496', '48.1', '56.1', 'MenuItem', 'audit.Insert', 'Cull', 'ZTest', '3527', '238900', 'uniforms30', 'uniforms25', 'uniforms22', 'uniforms46']:
    print(needle, imp.count(needle))

print('\n===== importer matching lines =====')
for i, ln in enumerate(imp.splitlines(), 1):
    if any(x in ln for x in ('ExpectedEIDs', 'ExpectedInstances', 'ExpectedUniqueMeshes', 'uniforms44', 'i < 32', 'i < 31', '512', '496', '48.1', '56.1', 'MenuItem', 'audit.Insert', 'Cull', 'ZTest')):
        print('%4d %s' % (i, ln[:220]))

print('\n===== export leftover =====')
for needle in ['238900', '238901', '3527', '3531', '496', '512', '_P31', '_P30', '90ecda7e', '3729', 'VS215547', '0bc71add']:
    print(needle, exp.count(needle))
print('\n===== export matching lines =====')
for i, ln in enumerate(exp.splitlines(), 1):
    if any(x in ln for x in ('238900', '238901', '3527', '3531', '496', '512', '90ecda7e', '3729', 'FAMILY', 'EXPECTED', 'EIDS', 'localMaterial', 'ps_spv', 'VS215547', 'PS215548', 'search_roots')):
        print('%4d %s' % (i, ln[:220]))

print('\n===== root meta =====')
print(root_meta)
print('guid lens')
import os, re
root = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215547_PS215548_Batch'
bad = []
for dirpath, _, files in os.walk(root):
    for fn in files:
        if fn.endswith('.meta'):
            t = open(os.path.join(dirpath, fn), encoding='utf8').read()
            m = re.search(r'guid: ([0-9a-fA-F]+)', t)
            if not m or len(m.group(1)) != 32:
                bad.append((fn, m.group(1) if m else None, len(m.group(1)) if m else 0))
t = open(root + '.meta', encoding='utf8').read()
m = re.search(r'guid: ([0-9a-fA-F]+)', t)
print('root guid', m.group(1) if m else None, len(m.group(1)) if m else 0)
print('bad', bad)
