from pathlib import Path

src = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215491_215492_batch.py')
text = src.read_text(encoding='utf8')

subs = [
    ("MESH_ITEM = {\n    3231: '51.1',\n}\nEIDS = [3231]\nFAMILY = 'VS215491_PS215492'\nEXPECTED = (215491, 215492)",
     "MESH_ITEM = {\n    3545: '53.1',\n}\nEIDS = [3545]\nFAMILY = 'VS215523_PS215524'\nEXPECTED = (215523, 215524)"),
    ("ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215491_PS215492_Batch'",
     "ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215523_PS215524_Batch'"),
    ("UNIQUE_MATERIAL = {'res27', 'res29', 'res31'}",
     "UNIQUE_MATERIAL = {'res26', 'res28', 'res30', 'res32', 'res34', 'res36'}"),
    ("ps_spv = open(os.path.join(SHADER_SRC, 'e7e975a4a514b097_PS.spv'), 'rb').read()\n    ps_asm = open(os.path.join(SHADER_SRC, 'e7e975a4a514b097_PS.spvasm'), 'rb').read()",
     "ps_spv = open(os.path.join(SHADER_SRC, '2573294c13f3ad66_PS.spv'), 'rb').read()\n    ps_asm = open(os.path.join(SHADER_SRC, '2573294c13f3ad66_PS.spvasm'), 'rb').read()"),
    ("'VS215491': {", "'VS215523': {"),
    ("os.path.join(SH, 'VS215491.spv')", "os.path.join(SH, 'VS215523.spv')"),
    ("os.path.join(SH, 'VS215491.spvasm')", "os.path.join(SH, 'VS215523.spvasm')"),
    ("'PS215492': {", "'PS215524': {"),
    ("os.path.join(SH, 'PS215492.spv')", "os.path.join(SH, 'PS215524.spv')"),
    ("os.path.join(SH, 'PS215492.spvasm')", "os.path.join(SH, 'PS215524.spvasm')"),
    ("os.path.join(ASSETS, 'ColourPass6_VS215491_PS215492_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215495_PS215497_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215505_PS215507_Batch', 'TextureDatabase'),",
     "os.path.join(ASSETS, 'ColourPass6_VS215523_PS215524_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS209988_PS209989_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215491_PS215492_Batch', 'TextureDatabase'),"),
    ("'instanceBuffer': 'VS uniforms28 / PS uniforms23 stride 256 sliced by size',\n            'localMaterialCB': 'PS uniforms33 416B packed _P00.._P25',\n            'materialIdCB': 'PS uniforms35 16B',\n            'mipBias': 'PS uniforms20 child16 @416',\n            'skinning': 'flags bit32 all zero; skip hashing ssbo30 8.4MB',",
     "'instanceBuffer': 'VS uniforms28 / PS uniforms23 stride 256 sliced by size',\n            'localMaterialCB': 'PS uniforms39 576B packed _P00.._P35',\n            'materialIdCB': 'PS uniforms41 16B',\n            'mipBias': 'PS uniforms20 child16 @416',\n            'scanGlobals': 'PS uniforms20 child17@420 child20.y@436 child75@1648 child77@1680',\n            'skinning': 'flags bit32 all zero; skip hashing ssbo30 8.4MB',"),
    ("shader_files['VS215491']['sha256']", "shader_files['VS215523']['sha256']"),
    ("shader_files['PS215492']['sha256']", "shader_files['PS215524']['sha256']"),
    ("open(os.path.join(ROOT, 'VS215491_PS215492_BatchManifest.json')",
     "open(os.path.join(ROOT, 'VS215523_PS215524_BatchManifest.json')"),
    ("result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215491_215492_batch_result.json'",
     "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215523_215524_batch_result.json'"),
]

for a, b in subs:
    if a not in text:
        print('MISSING', repr(a[:140]))
    else:
        text = text.replace(a, b)
        print('OK', repr(a[:70]))

for s in ['215491', '215492', '3231', '51.1', 'res27', 'res29', 'res31', 'uniforms33', 'uniforms35', 'e7e975a4']:
    if s in text:
        for i, line in enumerate(text.splitlines(), 1):
            if s in line:
                print('LEFTOVER', s, i, line.strip()[:160])

dst = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215523_215524_batch.py')
dst.write_text(text, encoding='utf8')
print('wrote', dst, 'len', len(text))
