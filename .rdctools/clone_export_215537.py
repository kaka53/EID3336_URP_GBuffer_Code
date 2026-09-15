import os

src = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215521_215522_batch.py'
dst = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215537_215538_batch.py'
text = open(src, encoding='utf8').read()

unique = [
    (
        "MESH_ITEM = {\n    3536: '40.1',\n    3540: '40.2',\n}\nEIDS = [3536, 3540]\nFAMILY = 'VS215521_PS215522'\nEXPECTED = (215521, 215522)",
        "MESH_ITEM = {\n    3617: '41.1',\n    3621: '41.2',\n}\nEIDS = [3617, 3621]\nFAMILY = 'VS215537_PS215538'\nEXPECTED = (215537, 215538)",
    ),
    (
        "ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215521_PS215522_Batch'",
        "ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215537_PS215538_Batch'",
    ),
    (
        "UNIQUE_MATERIAL = {'res28', 'res30', 'res32', 'res33', 'res34', 'res35'}",
        "UNIQUE_MATERIAL = {'res33', 'res35'}",
    ),
    (
        "EXPECTED_INPUTS = ['_input%d' % i for i in range(10)]",
        "EXPECTED_INPUTS = ['_input%d' % i for i in range(9)]",
    ),
    (
        "return (key == 'VS' and name == 'uniforms30') or (key == 'PS' and name == 'uniforms24')",
        "return (key == 'VS' and name == 'uniforms29') or (key == 'PS' and name == 'uniforms25')",
    ),
    (
        "raise RuntimeError('EID%d expected 10 VS inputs _input0.._input9, got %s' % (eid, names))",
        "raise RuntimeError('EID%d expected 9 VS inputs _input0.._input8, got %s' % (eid, names))",
    ),
    (
        "vs_spv = open(os.path.join(SHADER_SRC, 'b6789548dbc85813_VS.spv'), 'rb').read()\n    vs_asm = open(os.path.join(SHADER_SRC, 'b6789548dbc85813_VS.spvasm'), 'rb').read()\n    ps_spv = open(os.path.join(SHADER_SRC, '4c2374981371b928_PS.spv'), 'rb').read()\n    ps_asm = open(os.path.join(SHADER_SRC, '4c2374981371b928_PS.spvasm'), 'rb').read()",
        "vs_spv = open(os.path.join(SHADER_SRC, '731d0624f202ecb3_VS.spv'), 'rb').read()\n    vs_asm = open(os.path.join(SHADER_SRC, '731d0624f202ecb3_VS.spvasm'), 'rb').read()\n    ps_spv = open(os.path.join(SHADER_SRC, '872a40547341e2fb_PS.spv'), 'rb').read()\n    ps_asm = open(os.path.join(SHADER_SRC, '872a40547341e2fb_PS.spvasm'), 'rb').read()",
    ),
    (
        "    shader_files = {\n        'VS215521': {\n            'spv': save(os.path.join(SH, 'VS215521.spv'), vs_spv),\n            'disassembly': save(os.path.join(SH, 'VS215521.spvasm'), vs_asm),\n            'sha256': hashlib.sha256(vs_spv).hexdigest(),\n        },\n        'PS215522': {\n            'spv': save(os.path.join(SH, 'PS215522.spv'), ps_spv),\n            'disassembly': save(os.path.join(SH, 'PS215522.spvasm'), ps_asm),\n            'sha256': hashlib.sha256(ps_spv).hexdigest(),\n        },\n    }",
        "    shader_files = {\n        'VS215537': {\n            'spv': save(os.path.join(SH, 'VS215537.spv'), vs_spv),\n            'disassembly': save(os.path.join(SH, 'VS215537.spvasm'), vs_asm),\n            'sha256': hashlib.sha256(vs_spv).hexdigest(),\n        },\n        'PS215538': {\n            'spv': save(os.path.join(SH, 'PS215538.spv'), ps_spv),\n            'disassembly': save(os.path.join(SH, 'PS215538.spvasm'), ps_asm),\n            'sha256': hashlib.sha256(ps_spv).hexdigest(),\n        },\n    }",
    ),
    (
        "os.path.join(ASSETS, 'ColourPass6_VS215521_PS215522_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215511_PS215514_Batch', 'TextureDatabase'),",
        "os.path.join(ASSETS, 'ColourPass6_VS215537_PS215538_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215512_PS215513_Batch', 'TextureDatabase'),",
    ),
    (
        "'instanceBuffer': 'VS uniforms30 / PS uniforms24 stride 256 sliced by size',\n            'localMaterialCB': 'PS uniforms37 464B packed _P00.._P28',\n            'materialIdCB': 'PS uniforms39 16B',\n            'mipBias': 'PS uniforms21 child16 @416',",
        "'instanceBuffer': 'VS uniforms29 / PS uniforms25 stride 256 sliced by size',\n            'localMaterialCB': 'PS uniforms38 512B packed _P00.._P31',\n            'materialIdCB': 'PS uniforms40 16B',\n            'mipBias': 'PS uniforms22 child16 @416',",
    ),
    (
        "'packedNormal': 'NORMAL.x from _input1 oct 0.0020',",
        "'packedNormal': 'NORMAL.x from _input1 oct 0.0019569471478462219',",
    ),
    ("'vsSha256': shader_files['VS215521']['sha256'],\n            'psSha256': shader_files['PS215522']['sha256'],",
     "'vsSha256': shader_files['VS215537']['sha256'],\n            'psSha256': shader_files['PS215538']['sha256'],"),
    (
        "open(os.path.join(ROOT, 'VS215521_PS215522_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))",
        "open(os.path.join(ROOT, 'VS215537_PS215538_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))",
    ),
    (
        "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215521_215522_batch_result.json'",
        "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215537_215538_batch_result.json'",
    ),
]

missing = []
for a, b in unique:
    n = text.count(a)
    if n != 1:
        missing.append((n, a[:160]))
    else:
        text = text.replace(a, b, 1)

open(dst, 'w', encoding='utf8', newline='\n').write(text)
print('wrote', dst, os.path.getsize(dst))
print('missing', missing)
leftover = []
for needle in ['215521', '215522', 'uniforms30', 'uniforms24', 'uniforms37', 'uniforms39', 'b6789548', '4c237498', '3536', '3540', 'range(10)', '_input9']:
    if needle in text:
        leftover.append((needle, text.count(needle)))
print('leftover', leftover)
print('uniforms29', text.count('uniforms29'))
print('uniforms25', text.count('uniforms25'))
print('res33', text.count('res33'))
print('731d0624', text.count('731d0624'))
print('872a4054', text.count('872a4054'))
