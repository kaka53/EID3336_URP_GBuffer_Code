import os

src = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215539_215540_batch.py'
dst = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215543_215544_batch.py'
text = open(src, encoding='utf8').read()

unique = [
    (
        "MESH_ITEM = {\n    3669: '42.1',\n    3674: '42.2',\n}\nEIDS = [3669, 3674]\nFAMILY = 'VS215539_PS215540'\nEXPECTED = (215539, 215540)",
        "MESH_ITEM = {\n    3694: '43.1',\n    3698: '43.2',\n}\nEIDS = [3694, 3698]\nFAMILY = 'VS215543_PS215544'\nEXPECTED = (215543, 215544)",
    ),
    (
        "ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215539_PS215540_Batch'",
        "ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215543_PS215544_Batch'",
    ),
    (
        "UNIQUE_MATERIAL = {'res27', 'res29', 'res31'}",
        "UNIQUE_MATERIAL = {'res25', 'res27'}",
    ),
    (
        "EXPECTED_INPUTS = ['_input0', '_input1', '_input2', '_input3', '_input4', '_input5', '_input7', '_input8']",
        "EXPECTED_INPUTS = ['_input0', '_input1', '_input2', '_input3', '_input4', '_input5', '_input6']",
    ),
    (
        "return (key == 'VS' and name == 'uniforms27') or (key == 'PS' and name == 'uniforms23')",
        "return (key == 'VS' and name == 'uniforms27') or (key == 'PS' and name == 'uniforms22')",
    ),
    (
        "raise RuntimeError('EID%d expected 8 VS inputs _input0.._input5+_input7+_input8, got %s' % (eid, names))",
        "raise RuntimeError('EID%d expected 7 VS inputs _input0.._input6, got %s' % (eid, names))",
    ),
    (
        "vs_spv = open(os.path.join(SHADER_SRC, '3cc7fc221930fc87_VS.spv'), 'rb').read()\n    vs_asm = open(os.path.join(SHADER_SRC, '3cc7fc221930fc87_VS.spvasm'), 'rb').read()\n    ps_spv = open(os.path.join(SHADER_SRC, 'c87f481f363428b7_PS.spv'), 'rb').read()\n    ps_asm = open(os.path.join(SHADER_SRC, 'c87f481f363428b7_PS.spvasm'), 'rb').read()",
        "vs_spv = open(os.path.join(SHADER_SRC, '267bbf70820fc7f5_VS.spv'), 'rb').read()\n    vs_asm = open(os.path.join(SHADER_SRC, '267bbf70820fc7f5_VS.spvasm'), 'rb').read()\n    ps_spv = open(os.path.join(SHADER_SRC, '2e27bb50886a6788_PS.spv'), 'rb').read()\n    ps_asm = open(os.path.join(SHADER_SRC, '2e27bb50886a6788_PS.spvasm'), 'rb').read()",
    ),
    (
        "    shader_files = {\n        'VS215539': {\n            'spv': save(os.path.join(SH, 'VS215539.spv'), vs_spv),\n            'disassembly': save(os.path.join(SH, 'VS215539.spvasm'), vs_asm),\n            'sha256': hashlib.sha256(vs_spv).hexdigest(),\n        },\n        'PS215540': {\n            'spv': save(os.path.join(SH, 'PS215540.spv'), ps_spv),\n            'disassembly': save(os.path.join(SH, 'PS215540.spvasm'), ps_asm),\n            'sha256': hashlib.sha256(ps_spv).hexdigest(),\n        },\n    }",
        "    shader_files = {\n        'VS215543': {\n            'spv': save(os.path.join(SH, 'VS215543.spv'), vs_spv),\n            'disassembly': save(os.path.join(SH, 'VS215543.spvasm'), vs_asm),\n            'sha256': hashlib.sha256(vs_spv).hexdigest(),\n        },\n        'PS215544': {\n            'spv': save(os.path.join(SH, 'PS215544.spv'), ps_spv),\n            'disassembly': save(os.path.join(SH, 'PS215544.spvasm'), ps_asm),\n            'sha256': hashlib.sha256(ps_spv).hexdigest(),\n        },\n    }",
    ),
    (
        "os.path.join(ASSETS, 'ColourPass6_VS215539_PS215540_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215537_PS215538_Batch', 'TextureDatabase'),",
        "os.path.join(ASSETS, 'ColourPass6_VS215543_PS215544_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS209990_PS209991_Batch', 'TextureDatabase'),",
    ),
    (
        "'instanceBuffer': 'VS uniforms27 / PS uniforms23 stride 256 sliced by size',\n            'localMaterialCB': 'PS uniforms33 448B packed _P00.._P27',\n            'materialIdCB': 'PS uniforms35 16B',\n            'mipBias': 'PS uniforms20 child16 @416',",
        "'instanceBuffer': 'VS uniforms27 / PS uniforms22 stride 256 sliced by size',\n            'localMaterialCB': 'PS uniforms30 224B packed _P00.._P13',\n            'materialIdCB': 'none',\n            'mipBias': 'PS uniforms19 child16 @416',",
    ),
    (
        "'packedNormal': 'NORMAL.x from _input1 oct 0.0020',",
        "'packedNormal': 'NORMAL.x from _input1 oct 0.0020 stencil 33',",
    ),
    ("'vsSha256': shader_files['VS215539']['sha256'],\n            'psSha256': shader_files['PS215540']['sha256'],",
     "'vsSha256': shader_files['VS215543']['sha256'],\n            'psSha256': shader_files['PS215544']['sha256'],"),
    (
        "open(os.path.join(ROOT, 'VS215539_PS215540_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))",
        "open(os.path.join(ROOT, 'VS215543_PS215544_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))",
    ),
    (
        "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215539_215540_batch_result.json'",
        "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215543_215544_batch_result.json'",
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
for needle in ['215539', '215540', 'uniforms23', 'uniforms33', 'uniforms35', 'uniforms20', '3cc7fc22', 'c87f481f', '3669', '3674', 'res29', 'res31']:
    if needle in text:
        leftover.append((needle, text.count(needle)))
print('leftover', leftover)
print('uniforms27', text.count('uniforms27'))
print('uniforms22', text.count('uniforms22'))
print('res25', text.count('res25'))
print('res27', text.count('res27'))
print('267bbf70', text.count('267bbf70'))
print('2e27bb50', text.count('2e27bb50'))
