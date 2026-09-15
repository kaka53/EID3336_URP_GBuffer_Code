import os

src = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_238900_238901_batch.py'
dst = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215547_215548_batch.py'
text = open(src, encoding='utf8').read()

unique = [
    (
        "MESH_ITEM = {\n    3527: '48.1',\n    3531: '48.2',\n}\nEIDS = [3527, 3531]\nFAMILY = 'VS238900_PS238901'\nEXPECTED = (238900, 238901)",
        "MESH_ITEM = {\n    3729: '56.1',\n}\nEIDS = [3729]\nFAMILY = 'VS215547_PS215548'\nEXPECTED = (215547, 215548)",
    ),
    (
        "ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS238900_PS238901_Batch'",
        "ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215547_PS215548_Batch'",
    ),
    (
        "ps_spv = open(os.path.join(SHADER_SRC, '0bc71add2993d083_PS.spv'), 'rb').read()\n    ps_asm = open(os.path.join(SHADER_SRC, '0bc71add2993d083_PS.spvasm'), 'rb').read()",
        "ps_spv = open(os.path.join(SHADER_SRC, '90ecda7e2c13e67b_PS.spv'), 'rb').read()\n    ps_asm = open(os.path.join(SHADER_SRC, '90ecda7e2c13e67b_PS.spvasm'), 'rb').read()",
    ),
    (
        "    shader_files = {\n        'VS238900': {\n            'spv': save(os.path.join(SH, 'VS238900.spv'), vs_spv),\n            'disassembly': save(os.path.join(SH, 'VS238900.spvasm'), vs_asm),\n            'sha256': hashlib.sha256(vs_spv).hexdigest(),\n        },\n        'PS238901': {\n            'spv': save(os.path.join(SH, 'PS238901.spv'), ps_spv),\n            'disassembly': save(os.path.join(SH, 'PS238901.spvasm'), ps_asm),\n            'sha256': hashlib.sha256(ps_spv).hexdigest(),\n        },\n    }",
        "    shader_files = {\n        'VS215547': {\n            'spv': save(os.path.join(SH, 'VS215547.spv'), vs_spv),\n            'disassembly': save(os.path.join(SH, 'VS215547.spvasm'), vs_asm),\n            'sha256': hashlib.sha256(vs_spv).hexdigest(),\n        },\n        'PS215548': {\n            'spv': save(os.path.join(SH, 'PS215548.spv'), ps_spv),\n            'disassembly': save(os.path.join(SH, 'PS215548.spvasm'), ps_asm),\n            'sha256': hashlib.sha256(ps_spv).hexdigest(),\n        },\n    }",
    ),
    (
        "os.path.join(ASSETS, 'ColourPass6_VS238900_PS238901_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS209984_PS209985_Batch', 'TextureDatabase'),",
        "os.path.join(ASSETS, 'ColourPass6_VS215547_PS215548_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS238900_PS238901_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS209986_PS209987_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS209984_PS209985_Batch', 'TextureDatabase'),",
    ),
    (
        "'localMaterialCB': 'PS uniforms44 496B packed _P00.._P30',",
        "'localMaterialCB': 'PS uniforms44 512B packed _P00.._P31',",
    ),
    (
        "'vsSha256': shader_files['VS238900']['sha256'],\n            'psSha256': shader_files['PS238901']['sha256'],",
        "'vsSha256': shader_files['VS215547']['sha256'],\n            'psSha256': shader_files['PS215548']['sha256'],",
    ),
    (
        "open(os.path.join(ROOT, 'VS238900_PS238901_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))",
        "open(os.path.join(ROOT, 'VS215547_PS215548_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))",
    ),
    (
        "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_238900_238901_batch_result.json'",
        "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215547_215548_batch_result.json'",
    ),
]

missing = []
for a, b in unique:
    n = text.count(a)
    if n != 1:
        missing.append((n, a[:200]))
    else:
        text = text.replace(a, b, 1)

open(dst, 'w', encoding='utf8', newline='\n').write(text)
print('wrote', dst, os.path.getsize(dst))
print('missing', missing)
leftover = []
for needle in ['238900', '238901', '3527', '3531', '48.1', '48.2', '0bc71add', '496B', '_P30']:
    if needle in text:
        leftover.append((needle, text.count(needle)))
print('leftover', leftover)
print('uniforms30', text.count('uniforms30'))
print('uniforms25', text.count('uniforms25'))
print('uniforms22', text.count('uniforms22'))
print('res34', text.count('res34'))
print('90ecda7e', text.count('90ecda7e'))
print('8d02447e', text.count('8d02447e'))
print('3729', text.count('3729'))
