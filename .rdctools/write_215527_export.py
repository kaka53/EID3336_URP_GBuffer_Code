from pathlib import Path

src = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215491_215492_batch.py')
text = src.read_text(encoding='utf8')

subs = [
    ("MESH_ITEM = {\n    3231: '51.1',\n}\nEIDS = [3231]\nFAMILY = 'VS215491_PS215492'\nEXPECTED = (215491, 215492)",
     "MESH_ITEM = {\n    3561: '55.1',\n}\nEIDS = [3561]\nFAMILY = 'VS215527_PS215528'\nEXPECTED = (215527, 215528)"),
    ("ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215491_PS215492_Batch'",
     "ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215527_PS215528_Batch'"),
    ("UNIQUE_MATERIAL = {'res27', 'res29', 'res31'}",
     "UNIQUE_MATERIAL = {'res27', 'res29', 'res32', 'res33', 'res34'}"),
    ("ps_spv = open(os.path.join(SHADER_SRC, 'e7e975a4a514b097_PS.spv'), 'rb').read()\n    ps_asm = open(os.path.join(SHADER_SRC, 'e7e975a4a514b097_PS.spvasm'), 'rb').read()",
     "ps_spv = open(os.path.join(SHADER_SRC, '317c0cc4af786020_PS.spv'), 'rb').read()\n    ps_asm = open(os.path.join(SHADER_SRC, '317c0cc4af786020_PS.spvasm'), 'rb').read()"),
    ("'VS215491': {", "'VS215527': {"),
    ("os.path.join(SH, 'VS215491.spv')", "os.path.join(SH, 'VS215527.spv')"),
    ("os.path.join(SH, 'VS215491.spvasm')", "os.path.join(SH, 'VS215527.spvasm')"),
    ("'PS215492': {", "'PS215528': {"),
    ("os.path.join(SH, 'PS215492.spv')", "os.path.join(SH, 'PS215528.spv')"),
    ("os.path.join(SH, 'PS215492.spvasm')", "os.path.join(SH, 'PS215528.spvasm')"),
    ("os.path.join(ASSETS, 'ColourPass6_VS215491_PS215492_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215495_PS215497_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215505_PS215507_Batch', 'TextureDatabase'),",
     "os.path.join(ASSETS, 'ColourPass6_VS215527_PS215528_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS209986_PS209987_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS209988_PS209989_Batch', 'TextureDatabase'),"),
    ("'localMaterialCB': 'PS uniforms33 416B packed _P00.._P25',\n            'materialIdCB': 'PS uniforms35 16B',\n            'mipBias': 'PS uniforms20 child16 @416',\n            'skinning': 'flags bit32 all zero; skip hashing ssbo30 8.4MB',",
     "'localMaterialCB': 'PS uniforms36 448B packed _P00.._P27',\n            'materialIdCB': 'PS uniforms38 16B',\n            'mipBias': 'PS uniforms20 child16 @416',\n            'skinning': 'flags bit32 all zero; skip hashing ssbo30 8.4MB',\n            'cubemap': 'PS res32 RID257548 TextureCube BC7_SRGB',"),
    ("shader_files['VS215491']['sha256']", "shader_files['VS215527']['sha256']"),
    ("shader_files['PS215492']['sha256']", "shader_files['PS215528']['sha256']"),
    ("open(os.path.join(ROOT, 'VS215491_PS215492_BatchManifest.json')",
     "open(os.path.join(ROOT, 'VS215527_PS215528_BatchManifest.json')"),
    ("result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215491_215492_batch_result.json'",
     "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215527_215528_batch_result.json'"),
]

for a, b in subs:
    if a not in text:
        print('MISSING', repr(a[:160]))
    else:
        text = text.replace(a, b)
        print('OK', repr(a[:80]))

for s in ['215491', '215492', '3231', '51.1', 'res31', 'uniforms33', 'uniforms35', 'e7e975a4', '416B', '_P25']:
    if s in text:
        for i, line in enumerate(text.splitlines(), 1):
            if s in line:
                print('LEFTOVER', s, i, line.strip()[:180])

dst = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215527_215528_batch.py')
dst.write_text(text, encoding='utf8')
print('wrote', dst, 'len', len(text))
