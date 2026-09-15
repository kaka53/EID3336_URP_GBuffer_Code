import os

src = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215537_215538_batch.py'
dst = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215539_215540_batch.py'
text = open(src, encoding='utf8').read()

unique = [
    (
        "MESH_ITEM = {\n    3617: '41.1',\n    3621: '41.2',\n}\nEIDS = [3617, 3621]\nFAMILY = 'VS215537_PS215538'\nEXPECTED = (215537, 215538)",
        "MESH_ITEM = {\n    3669: '42.1',\n    3674: '42.2',\n}\nEIDS = [3669, 3674]\nFAMILY = 'VS215539_PS215540'\nEXPECTED = (215539, 215540)",
    ),
    (
        "ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215537_PS215538_Batch'",
        "ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215539_PS215540_Batch'",
    ),
    (
        "UNIQUE_MATERIAL = {'res33', 'res35'}",
        "UNIQUE_MATERIAL = {'res27', 'res29', 'res31'}",
    ),
    (
        "EXPECTED_INPUTS = ['_input%d' % i for i in range(9)]",
        "EXPECTED_INPUTS = ['_input0', '_input1', '_input2', '_input3', '_input4', '_input5', '_input7', '_input8']",
    ),
    (
        "return (key == 'VS' and name == 'uniforms29') or (key == 'PS' and name == 'uniforms25')",
        "return (key == 'VS' and name == 'uniforms27') or (key == 'PS' and name == 'uniforms23')",
    ),
    (
        "raise RuntimeError('EID%d expected 9 VS inputs _input0.._input8, got %s' % (eid, names))",
        "raise RuntimeError('EID%d expected 8 VS inputs _input0.._input5+_input7+_input8, got %s' % (eid, names))",
    ),
    (
        "vs_spv = open(os.path.join(SHADER_SRC, '731d0624f202ecb3_VS.spv'), 'rb').read()\n    vs_asm = open(os.path.join(SHADER_SRC, '731d0624f202ecb3_VS.spvasm'), 'rb').read()\n    ps_spv = open(os.path.join(SHADER_SRC, '872a40547341e2fb_PS.spv'), 'rb').read()\n    ps_asm = open(os.path.join(SHADER_SRC, '872a40547341e2fb_PS.spvasm'), 'rb').read()",
        "vs_spv = open(os.path.join(SHADER_SRC, '3cc7fc221930fc87_VS.spv'), 'rb').read()\n    vs_asm = open(os.path.join(SHADER_SRC, '3cc7fc221930fc87_VS.spvasm'), 'rb').read()\n    ps_spv = open(os.path.join(SHADER_SRC, 'c87f481f363428b7_PS.spv'), 'rb').read()\n    ps_asm = open(os.path.join(SHADER_SRC, 'c87f481f363428b7_PS.spvasm'), 'rb').read()",
    ),
    (
        "    shader_files = {\n        'VS215537': {\n            'spv': save(os.path.join(SH, 'VS215537.spv'), vs_spv),\n            'disassembly': save(os.path.join(SH, 'VS215537.spvasm'), vs_asm),\n            'sha256': hashlib.sha256(vs_spv).hexdigest(),\n        },\n        'PS215538': {\n            'spv': save(os.path.join(SH, 'PS215538.spv'), ps_spv),\n            'disassembly': save(os.path.join(SH, 'PS215538.spvasm'), ps_asm),\n            'sha256': hashlib.sha256(ps_spv).hexdigest(),\n        },\n    }",
        "    shader_files = {\n        'VS215539': {\n            'spv': save(os.path.join(SH, 'VS215539.spv'), vs_spv),\n            'disassembly': save(os.path.join(SH, 'VS215539.spvasm'), vs_asm),\n            'sha256': hashlib.sha256(vs_spv).hexdigest(),\n        },\n        'PS215540': {\n            'spv': save(os.path.join(SH, 'PS215540.spv'), ps_spv),\n            'disassembly': save(os.path.join(SH, 'PS215540.spvasm'), ps_asm),\n            'sha256': hashlib.sha256(ps_spv).hexdigest(),\n        },\n    }",
    ),
    (
        "os.path.join(ASSETS, 'ColourPass6_VS215537_PS215538_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215512_PS215513_Batch', 'TextureDatabase'),",
        "os.path.join(ASSETS, 'ColourPass6_VS215539_PS215540_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215537_PS215538_Batch', 'TextureDatabase'),",
    ),
    (
        "'instanceBuffer': 'VS uniforms29 / PS uniforms25 stride 256 sliced by size',\n            'localMaterialCB': 'PS uniforms38 512B packed _P00.._P31',\n            'materialIdCB': 'PS uniforms40 16B',\n            'mipBias': 'PS uniforms22 child16 @416',",
        "'instanceBuffer': 'VS uniforms27 / PS uniforms23 stride 256 sliced by size',\n            'localMaterialCB': 'PS uniforms33 448B packed _P00.._P27',\n            'materialIdCB': 'PS uniforms35 16B',\n            'mipBias': 'PS uniforms20 child16 @416',",
    ),
    (
        "'packedNormal': 'NORMAL.x from _input1 oct 0.0019569471478462219',",
        "'packedNormal': 'NORMAL.x from _input1 oct 0.0020',",
    ),
    ("'vsSha256': shader_files['VS215537']['sha256'],\n            'psSha256': shader_files['PS215538']['sha256'],",
     "'vsSha256': shader_files['VS215539']['sha256'],\n            'psSha256': shader_files['PS215540']['sha256'],"),
    (
        "open(os.path.join(ROOT, 'VS215537_PS215538_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))",
        "open(os.path.join(ROOT, 'VS215539_PS215540_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))",
    ),
    (
        "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215537_215538_batch_result.json'",
        "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215539_215540_batch_result.json'",
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
for needle in ['215537', '215538', 'uniforms29', 'uniforms25', 'uniforms38', 'uniforms40', 'uniforms22', '731d0624', '872a4054', '3617', '3621', 'range(9)', 'res33', 'res35']:
    if needle in text:
        leftover.append((needle, text.count(needle)))
print('leftover', leftover)
print('uniforms27', text.count('uniforms27'))
print('uniforms23', text.count('uniforms23'))
print('res27', text.count('res27'))
print('3cc7fc22', text.count('3cc7fc22'))
print('c87f481f', text.count('c87f481f'))
