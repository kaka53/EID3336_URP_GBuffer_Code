import os

src = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215517_215518_batch.py'
dst = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215553_215554_batch.py'
text = open(src, encoding='utf8').read()

unique = [
    (
        "MESH_ITEM = {\n    3439: '39.1',\n    3443: '39.2',\n}\nEIDS = [3439, 3443]\nFAMILY = 'VS215517_PS215518'\nEXPECTED = (215517, 215518)",
        "MESH_ITEM = {\n    3761: '44.1',\n    3765: '44.2',\n}\nEIDS = [3761, 3765]\nFAMILY = 'VS215553_PS215554'\nEXPECTED = (215553, 215554)",
    ),
    (
        "ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215517_PS215518_Batch'",
        "ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215553_PS215554_Batch'",
    ),
    (
        "UNIQUE_MATERIAL = {'res32', 'res34', 'res36'}",
        "UNIQUE_MATERIAL = {'res23', 'res25'}",
    ),
    (
        "return (key == 'VS' and name == 'uniforms28') or (key == 'PS' and name == 'uniforms23')",
        "return (key == 'VS' and name == 'uniforms28') or (key == 'PS' and name == 'uniforms20')",
    ),
    (
        "ps_spv = open(os.path.join(SHADER_SRC, '1dcd63b493d58855_PS.spv'), 'rb').read()\n    ps_asm = open(os.path.join(SHADER_SRC, '1dcd63b493d58855_PS.spvasm'), 'rb').read()",
        "ps_spv = open(os.path.join(SHADER_SRC, '5e4c5a1996bc4882_PS.spv'), 'rb').read()\n    ps_asm = open(os.path.join(SHADER_SRC, '5e4c5a1996bc4882_PS.spvasm'), 'rb').read()",
    ),
    (
        "    shader_files = {\n        'VS215517': {\n            'spv': save(os.path.join(SH, 'VS215517.spv'), vs_spv),\n            'disassembly': save(os.path.join(SH, 'VS215517.spvasm'), vs_asm),\n            'sha256': hashlib.sha256(vs_spv).hexdigest(),\n        },\n        'PS215518': {\n            'spv': save(os.path.join(SH, 'PS215518.spv'), ps_spv),\n            'disassembly': save(os.path.join(SH, 'PS215518.spvasm'), ps_asm),\n            'sha256': hashlib.sha256(ps_spv).hexdigest(),\n        },\n    }",
        "    shader_files = {\n        'VS215553': {\n            'spv': save(os.path.join(SH, 'VS215553.spv'), vs_spv),\n            'disassembly': save(os.path.join(SH, 'VS215553.spvasm'), vs_asm),\n            'sha256': hashlib.sha256(vs_spv).hexdigest(),\n        },\n        'PS215554': {\n            'spv': save(os.path.join(SH, 'PS215554.spv'), ps_spv),\n            'disassembly': save(os.path.join(SH, 'PS215554.spvasm'), ps_asm),\n            'sha256': hashlib.sha256(ps_spv).hexdigest(),\n        },\n    }",
    ),
    (
        "os.path.join(ASSETS, 'ColourPass6_VS215517_PS215518_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215511_PS215514_Batch', 'TextureDatabase'),",
        "os.path.join(ASSETS, 'ColourPass6_VS215553_PS215554_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215517_PS215518_Batch', 'TextureDatabase'),",
    ),
    (
        "'instanceBuffer': 'VS uniforms28 / PS uniforms23 stride 256 sliced by size',\n            'localMaterialCB': 'PS uniforms38 544B packed _P00.._P33',\n            'materialIdCB': 'PS uniforms40 16B',\n            'mipBias': 'PS uniforms20 child16 @416',",
        "'instanceBuffer': 'VS uniforms28 / PS uniforms20 stride 256 sliced by size',\n            'localMaterialCB': 'PS uniforms28 368B packed _P00.._P22',\n            'materialIdCB': 'PS uniforms30 16B',\n            'mipBias': 'PS uniforms17 child16 @416',",
    ),
    ("'vsSha256': shader_files['VS215517']['sha256'],\n            'psSha256': shader_files['PS215518']['sha256'],",
     "'vsSha256': shader_files['VS215553']['sha256'],\n            'psSha256': shader_files['PS215554']['sha256'],"),
    (
        "open(os.path.join(ROOT, 'VS215517_PS215518_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))",
        "open(os.path.join(ROOT, 'VS215553_PS215554_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))",
    ),
    (
        "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215517_215518_batch_result.json'",
        "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215553_215554_batch_result.json'",
    ),
]

missing = []
for a, b in unique:
    n = text.count(a)
    if n != 1:
        missing.append((n, a[:180]))
    else:
        text = text.replace(a, b, 1)

open(dst, 'w', encoding='utf8', newline='\n').write(text)
print('wrote', dst, os.path.getsize(dst))
print('missing', missing)
leftover = []
for needle in ['215517', '215518', 'uniforms23', 'uniforms38', 'uniforms40', '1dcd63b4', '3439', '3443', 'res32', 'res34', 'res36']:
    if needle in text:
        leftover.append((needle, text.count(needle)))
print('leftover', leftover)
print('uniforms28', text.count('uniforms28'))
print('uniforms20', text.count('uniforms20'))
print('uniforms17', text.count('uniforms17'))
print('res23', text.count('res23'))
print('res25', text.count('res25'))
print('9bfd93b2', text.count('9bfd93b2'))
print('5e4c5a19', text.count('5e4c5a19'))
