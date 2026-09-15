import os

src = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215493_215494_batch.py'
dst = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215549_215550_batch.py'
text = open(src, encoding='utf8').read()

unique = [
    (
        "MESH_ITEM = {\n    2528: '36.1',\n    2533: '36.2',\n}\nEIDS = [2528, 2533]\nFAMILY = 'VS215493_PS215494'\nEXPECTED = (215493, 215494)",
        "MESH_ITEM = {\n    3734: '57.1',\n}\nEIDS = [3734]\nFAMILY = 'VS215549_PS215550'\nEXPECTED = (215549, 215550)",
    ),
    (
        "ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215493_PS215494_Batch'",
        "ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215549_PS215550_Batch'",
    ),
    (
        "UNIQUE_MATERIAL = {'res23', 'res25'}",
        "UNIQUE_MATERIAL = {'res23', 'res25', 'res27'}",
    ),
    (
        "ps_spv = open(os.path.join(SHADER_SRC, 'd5101221c5ac0491_PS.spv'), 'rb').read()\n    ps_asm = open(os.path.join(SHADER_SRC, 'd5101221c5ac0491_PS.spvasm'), 'rb').read()",
        "ps_spv = open(os.path.join(SHADER_SRC, '855961aaf793ca54_PS.spv'), 'rb').read()\n    ps_asm = open(os.path.join(SHADER_SRC, '855961aaf793ca54_PS.spvasm'), 'rb').read()",
    ),
    (
        "    shader_files = {\n        'VS215493': {\n            'spv': save(os.path.join(SH, 'VS215493.spv'), vs_spv),\n            'disassembly': save(os.path.join(SH, 'VS215493.spvasm'), vs_asm),\n            'sha256': hashlib.sha256(vs_spv).hexdigest(),\n        },\n        'PS215494': {\n            'spv': save(os.path.join(SH, 'PS215494.spv'), ps_spv),\n            'disassembly': save(os.path.join(SH, 'PS215494.spvasm'), ps_asm),\n            'sha256': hashlib.sha256(ps_spv).hexdigest(),\n        },\n    }",
        "    shader_files = {\n        'VS215549': {\n            'spv': save(os.path.join(SH, 'VS215549.spv'), vs_spv),\n            'disassembly': save(os.path.join(SH, 'VS215549.spvasm'), vs_asm),\n            'sha256': hashlib.sha256(vs_spv).hexdigest(),\n        },\n        'PS215550': {\n            'spv': save(os.path.join(SH, 'PS215550.spv'), ps_spv),\n            'disassembly': save(os.path.join(SH, 'PS215550.spvasm'), ps_asm),\n            'sha256': hashlib.sha256(ps_spv).hexdigest(),\n        },\n    }",
    ),
    (
        "os.path.join(ASSETS, 'ColourPass6_VS215505_PS215507_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215545_PS215546_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215493_PS215494_Batch', 'TextureDatabase'),",
        "os.path.join(ASSETS, 'ColourPass6_VS215549_PS215550_Batch', 'TextureDatabase'),",
    ),
    (
        "'localMaterialCB': 'PS uniforms28 416B packed _P00.._P25',\n            'materialIdCB': 'PS uniforms30 16B child3',",
        "'localMaterialCB': 'PS uniforms30 432B packed _P00.._P26',\n            'materialIdCB': 'PS uniforms32 16B child3',",
    ),
    (
        "'vsSha256': shader_files['VS215493']['sha256'],\n            'psSha256': shader_files['PS215494']['sha256'],",
        "'vsSha256': shader_files['VS215549']['sha256'],\n            'psSha256': shader_files['PS215550']['sha256'],",
    ),
    (
        "open(os.path.join(ROOT, 'VS215493_PS215494_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))",
        "open(os.path.join(ROOT, 'VS215549_PS215550_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))",
    ),
    (
        "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215493_215494_batch_result.json'",
        "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215549_215550_batch_result.json'",
    ),
]

missing = []
for a, b in unique:
    n = text.count(a)
    if n != 1:
        missing.append((n, a[:220]))
    else:
        text = text.replace(a, b, 1)

open(dst, 'w', encoding='utf8', newline='\n').write(text)
print('wrote', dst, os.path.getsize(dst))
print('missing', missing)
leftover = []
for needle in ['215493', '215494', '2528', '2533', '36.1', '36.2', 'd5101221', '_P25', '416B']:
    if needle in text:
        leftover.append((needle, text.count(needle)))
print('leftover', leftover)
print('uniforms28', text.count('uniforms28'))
print('uniforms20', text.count('uniforms20'))
print('uniforms30', text.count('uniforms30'))
print('uniforms32', text.count('uniforms32'))
print('855961aa', text.count('855961aa'))
print('9bfd93b2', text.count('9bfd93b2'))
print('3734', text.count('3734'))
print('res27', text.count('res27'))
