from pathlib import Path

src = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215553_215554_batch.py')
text = src.read_text(encoding='utf8')

subs = [
    ("MESH_ITEM = {\n    3761: '44.1',\n    3765: '44.2',\n}\nEIDS = [3761, 3765]\nFAMILY = 'VS215553_PS215554'\nEXPECTED = (215553, 215554)",
     "MESH_ITEM = {\n    3231: '51.1',\n}\nEIDS = [3231]\nFAMILY = 'VS215491_PS215492'\nEXPECTED = (215491, 215492)"),
    ("ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215553_PS215554_Batch'",
     "ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215491_PS215492_Batch'"),
    ("UNIQUE_MATERIAL = {'res23', 'res25'}",
     "UNIQUE_MATERIAL = {'res27', 'res29', 'res31'}"),
    ("return (key == 'VS' and name == 'uniforms28') or (key == 'PS' and name == 'uniforms20')",
     "return (key == 'VS' and name == 'uniforms28') or (key == 'PS' and name == 'uniforms23')"),
    ("ps_spv = open(os.path.join(SHADER_SRC, '5e4c5a1996bc4882_PS.spv'), 'rb').read()\n    ps_asm = open(os.path.join(SHADER_SRC, '5e4c5a1996bc4882_PS.spvasm'), 'rb').read()",
     "ps_spv = open(os.path.join(SHADER_SRC, 'e7e975a4a514b097_PS.spv'), 'rb').read()\n    ps_asm = open(os.path.join(SHADER_SRC, 'e7e975a4a514b097_PS.spvasm'), 'rb').read()"),
    ("'VS215553': {", "'VS215491': {"),
    ("os.path.join(SH, 'VS215553.spv')", "os.path.join(SH, 'VS215491.spv')"),
    ("os.path.join(SH, 'VS215553.spvasm')", "os.path.join(SH, 'VS215491.spvasm')"),
    ("'PS215554': {", "'PS215492': {"),
    ("os.path.join(SH, 'PS215554.spv')", "os.path.join(SH, 'PS215492.spv')"),
    ("os.path.join(SH, 'PS215554.spvasm')", "os.path.join(SH, 'PS215492.spvasm')"),
    ("os.path.join(ASSETS, 'ColourPass6_VS215553_PS215554_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215517_PS215518_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215506_PS215508_Batch', 'TextureDatabase'),",
     "os.path.join(ASSETS, 'ColourPass6_VS215491_PS215492_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215495_PS215497_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215505_PS215507_Batch', 'TextureDatabase'),"),
    ("'instanceBuffer': 'VS uniforms28 / PS uniforms20 stride 256 sliced by size',\n            'localMaterialCB': 'PS uniforms28 368B packed _P00.._P22',\n            'materialIdCB': 'PS uniforms30 16B',\n            'mipBias': 'PS uniforms17 child16 @416',\n            'skinning': 'flags bit32 all zero; no rw ssbo bake',",
     "'instanceBuffer': 'VS uniforms28 / PS uniforms23 stride 256 sliced by size',\n            'localMaterialCB': 'PS uniforms33 416B packed _P00.._P25',\n            'materialIdCB': 'PS uniforms35 16B',\n            'mipBias': 'PS uniforms20 child16 @416',\n            'skinning': 'flags bit32 all zero; skip hashing ssbo30 8.4MB',"),
    ("shader_files['VS215553']['sha256']", "shader_files['VS215491']['sha256']"),
    ("shader_files['PS215554']['sha256']", "shader_files['PS215492']['sha256']"),
    ("open(os.path.join(ROOT, 'VS215553_PS215554_BatchManifest.json')",
     "open(os.path.join(ROOT, 'VS215491_PS215492_BatchManifest.json')"),
    ("result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215553_215554_batch_result.json'",
     "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215491_215492_batch_result.json'"),
]

for a,b in subs:
    if a not in text:
        print('MISSING', repr(a[:120]))
    else:
        text = text.replace(a,b)
        print('OK', repr(a[:70]))

for s in ['215553','215554','3761','3765','44.1','res23','res25','uniforms17','5e4c5a19']:
    if s in text:
        for i,line in enumerate(text.splitlines(),1):
            if s in line:
                print('LEFTOVER', s, i, line.strip()[:160])

dst = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215491_215492_batch.py')
dst.write_text(text, encoding='utf8')
print('wrote', dst, 'len', len(text))
