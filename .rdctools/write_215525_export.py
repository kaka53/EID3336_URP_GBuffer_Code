from pathlib import Path

src = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215511_215514_batch.py')
text = src.read_text(encoding='utf8')

subs = [
    ("MESH_ITEM = {\n    3379: '38.1',\n    3383: '38.2',\n}\nEIDS = [3379, 3383]\nFAMILY = 'VS215511_PS215514'\nEXPECTED = (215511, 215514)",
     "MESH_ITEM = {\n    3550: '54.1',\n}\nEIDS = [3550]\nFAMILY = 'VS215525_PS215526'\nEXPECTED = (215525, 215526)"),
    ("ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215511_PS215514_Batch'",
     "ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215525_PS215526_Batch'"),
    ("UNIQUE_MATERIAL = {'res33', 'res35', 'res37', 'res38', 'res40', 'res41'}",
     "UNIQUE_MATERIAL = {'res28', 'res30', 'res32', 'res33', 'res34', 'res35', 'res36'}"),
    ("ps_spv = open(os.path.join(SHADER_SRC, 'a5935352e5175225_PS.spv'), 'rb').read()\n    ps_asm = open(os.path.join(SHADER_SRC, 'a5935352e5175225_PS.spvasm'), 'rb').read()",
     "ps_spv = open(os.path.join(SHADER_SRC, 'f1a7bd79bd85cf88_PS.spv'), 'rb').read()\n    ps_asm = open(os.path.join(SHADER_SRC, 'f1a7bd79bd85cf88_PS.spvasm'), 'rb').read()"),
    ("'VS215511': {", "'VS215525': {"),
    ("os.path.join(SH, 'VS215511.spv')", "os.path.join(SH, 'VS215525.spv')"),
    ("os.path.join(SH, 'VS215511.spvasm')", "os.path.join(SH, 'VS215525.spvasm')"),
    ("'PS215514': {", "'PS215526': {"),
    ("os.path.join(SH, 'PS215514.spv')", "os.path.join(SH, 'PS215526.spv')"),
    ("os.path.join(SH, 'PS215514.spvasm')", "os.path.join(SH, 'PS215526.spvasm')"),
    ("os.path.join(ASSETS, 'ColourPass6_VS215511_PS215514_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215515_PS215516_Batch', 'TextureDatabase'),",
     "os.path.join(ASSETS, 'ColourPass6_VS215525_PS215526_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215511_PS215514_Batch', 'TextureDatabase'),"),
    ("'instanceBuffer': 'VS uniforms30 / PS uniforms24 stride 256 sliced by size',\n            'localMaterialCB': 'PS uniforms43 656B packed _P00.._P40',\n            'materialIdCB': 'PS uniforms45 16B',\n            'mipBias': 'PS uniforms21 child16 @416',\n            'skinning': 'flags bit32 all zero; no rw ssbo bake',",
     "'instanceBuffer': 'VS uniforms30 / PS uniforms24 stride 256 sliced by size',\n            'localMaterialCB': 'PS uniforms38 608B packed _P00.._P37',\n            'materialIdCB': 'PS uniforms40 16B',\n            'mipBias': 'PS uniforms21 child16 @416',\n            'skinning': 'flags bit32 all zero; skip hashing ssbo32 8.4MB',"),
    ("shader_files['VS215511']['sha256']", "shader_files['VS215525']['sha256']"),
    ("shader_files['PS215514']['sha256']", "shader_files['PS215526']['sha256']"),
    ("open(os.path.join(ROOT, 'VS215511_PS215514_BatchManifest.json')",
     "open(os.path.join(ROOT, 'VS215525_PS215526_BatchManifest.json')"),
    ("result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215511_215514_batch_result.json'",
     "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215525_215526_batch_result.json'"),
]

for a, b in subs:
    if a not in text:
        print('MISSING', repr(a[:160]))
    else:
        text = text.replace(a, b)
        print('OK', repr(a[:80]))

for s in ['215511', '215514', '3379', '3383', '38.1', '38.2', 'res37', 'res39', 'res40', 'res41', 'uniforms43', 'uniforms45', 'a5935352', '656B', '_P40']:
    if s in text:
        for i, line in enumerate(text.splitlines(), 1):
            if s in line:
                print('LEFTOVER', s, i, line.strip()[:180])

dst = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215525_215526_batch.py')
dst.write_text(text, encoding='utf8')
print('wrote', dst, 'len', len(text))
