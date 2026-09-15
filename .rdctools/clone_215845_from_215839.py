import os

SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215839_PS215840_Batch'
DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215845_PS215846_Batch'
EXP_SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215839_215840_batch.py'
EXP_DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215845_215846_batch.py'

FILES = [
    ('Editor/ColourPass6VS215839PS215840BatchImporter.cs', 'Editor/ColourPass6VS215845PS215846BatchImporter.cs'),
    ('Runtime/EID215839DrawProfile.cs', 'Runtime/EID215845DrawProfile.cs'),
    ('Runtime/EID215839InstanceBinder.cs', 'Runtime/EID215845InstanceBinder.cs'),
    ('Shaders/EID215839215840GBuffer.shader', 'Shaders/EID215845215846GBuffer.shader'),
    ('Shaders/EID215839VegetationVS.hlsl', 'Shaders/EID215845VegetationVS.hlsl'),
    ('Shaders/EID215839VegetationPS.hlsl', 'Shaders/EID215845VegetationPS.hlsl'),
    ('Shaders/EID215839CapturedConstants.hlsl', 'Shaders/EID215845CapturedConstants.hlsl'),
    ('Editor/ColourPass6VS215839PS215840BatchImporter.cs.meta', 'Editor/ColourPass6VS215845PS215846BatchImporter.cs.meta'),
    ('Runtime/EID215839DrawProfile.cs.meta', 'Runtime/EID215845DrawProfile.cs.meta'),
    ('Runtime/EID215839InstanceBinder.cs.meta', 'Runtime/EID215845InstanceBinder.cs.meta'),
    ('Shaders/EID215839215840GBuffer.shader.meta', 'Shaders/EID215845215846GBuffer.shader.meta'),
    ('Shaders/EID215839VegetationVS.hlsl.meta', 'Shaders/EID215845VegetationVS.hlsl.meta'),
    ('Shaders/EID215839VegetationPS.hlsl.meta', 'Shaders/EID215845VegetationPS.hlsl.meta'),
    ('Shaders/EID215839CapturedConstants.hlsl.meta', 'Shaders/EID215845CapturedConstants.hlsl.meta'),
]


def rewrite(text):
    text = text.replace('ColourPass6VS215839PS215840BatchImporter', 'ColourPass6VS215845PS215846BatchImporter')
    text = text.replace('ColourPass6_VS215839_PS215840_Batch', 'ColourPass6_VS215845_PS215846_Batch')
    text = text.replace('VS215839_PS215840', 'VS215845_PS215846')
    text = text.replace('EID215839215840GBuffer', 'EID215845215846GBuffer')
    text = text.replace('EID215839DrawProfile', 'EID215845DrawProfile')
    text = text.replace('EID215839InstanceBinder', 'EID215845InstanceBinder')
    text = text.replace('EID215839Instance', 'EID215845Instance')
    text = text.replace('_EID215839Instances', '_EID215845Instances')
    text = text.replace('EID215839Vertex', 'EID215845Vertex')
    text = text.replace('EID215840Fragment', 'EID215846Fragment')
    text = text.replace('VS215839', 'VS215845')
    text = text.replace('PS215840', 'PS215846')
    text = text.replace('215839', '215845')
    text = text.replace('215840', '215846')
    text = text.replace('EID215839VegetationVS.hlsl', 'EID215845VegetationVS.hlsl')
    text = text.replace('EID215839VegetationPS.hlsl', 'EID215845VegetationPS.hlsl')
    text = text.replace('EID215839CapturedConstants.hlsl', 'EID215845CapturedConstants.hlsl')
    return text


os.makedirs(DST, exist_ok=True)
for rel_src, rel_dst in FILES:
    src = os.path.join(SRC, rel_src)
    dst = os.path.join(DST, rel_dst)
    os.makedirs(os.path.dirname(dst), exist_ok=True)
    text = open(src, encoding='utf8').read()
    open(dst, 'w', encoding='utf8', newline='\n').write(rewrite(text))
    print('wrote', rel_dst, os.path.getsize(dst))

GUIDS = {
    'Editor/ColourPass6VS215845PS215846BatchImporter.cs.meta': '215845d4e5f647890abcde4455667701',
    'Shaders/EID215845215846GBuffer.shader.meta': '215845d4e5f647890abcde4455667702',
    'Shaders/EID215845VegetationVS.hlsl.meta': '215845d4e5f647890abcde4455667703',
    'Shaders/EID215845VegetationPS.hlsl.meta': '215845d4e5f647890abcde4455667704',
    'Shaders/EID215845CapturedConstants.hlsl.meta': '215845d4e5f647890abcde4455667705',
    'Runtime/EID215845DrawProfile.cs.meta': '215845d4e5f647890abcde4455667706',
    'Runtime/EID215845InstanceBinder.cs.meta': '215845d4e5f647890abcde4455667707',
}
for rel, guid in GUIDS.items():
    path = os.path.join(DST, rel)
    text = open(path, encoding='utf8').read()
    lines = []
    for line in text.splitlines(True):
        if line.startswith('guid:'):
            lines.append('guid: %s\n' % guid)
        else:
            lines.append(line)
    open(path, 'w', encoding='utf8', newline='\n').write(''.join(lines))
    print('guid', rel, guid, 'len', len(guid))

for sub in (
    'Geometry/Meshes', 'Materials', 'Profiles', 'TextureDatabase',
    'Captured/Geometry', 'Captured/CBuffers', 'Captured/Instances', 'Shaders',
):
    os.makedirs(os.path.join(DST, sub), exist_ok=True)
os.makedirs(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/ColourPass6_VS215845', exist_ok=True)

exp = rewrite(open(EXP_SRC, encoding='utf8').read())
exp = exp.replace(
    "MESH_ITEM = {\n    3771: '45.1',\n    3776: '45.2',\n}",
    "MESH_ITEM = {\n    3849: '46.1',\n    3853: '46.2',\n}",
)
exp = exp.replace('EIDS = [3771, 3776]', 'EIDS = [3849, 3853]')
exp = exp.replace('EXPECTED = (215845, 215846)', 'EXPECTED = (215845, 215846)')
exp = exp.replace("UNIQUE_MATERIAL = {'res23', 'res25'}", "UNIQUE_MATERIAL = {'res26', 'res28'}")
exp = exp.replace("VS_SHARED = {'res29'}", 'VS_SHARED = set()')
exp = exp.replace("if key == 'VS' and name == 'uniforms25':", "if key == 'VS' and name == 'uniforms26':")
exp = exp.replace("EID%d_uniforms25_%d.bytes'", "EID%d_uniforms26_%d.bytes'")
exp = exp.replace("missing VS uniforms25 instance array", "missing VS uniforms26 instance array")
exp = exp.replace("'96360155ef3e6bb7_VS.spv'", "'d89f2edd5b0e7424_VS.spv'")
exp = exp.replace("'96360155ef3e6bb7_VS.spvasm'", "'d89f2edd5b0e7424_VS.spvasm'")
exp = exp.replace("'3fb447c54784406d_PS.spv'", "'df3dd1dcf42e17e1_PS.spv'")
exp = exp.replace("'3fb447c54784406d_PS.spvasm'", "'df3dd1dcf42e17e1_PS.spvasm'")
exp = exp.replace(
    "os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'EID3863_RenderDocVegetation', 'ImportedTextures'),\n        os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'EID3863_RenderDocVegetation', 'ImportedTextures'),\n        os.path.join(ASSETS, 'ColourPass6_VS215845_PS215846_Batch', 'TextureDatabase'),",
    "os.path.join(ASSETS, 'ColourPass6_VS215845_PS215846_Batch', 'TextureDatabase'),",
)
open(EXP_DST, 'w', encoding='utf8', newline='\n').write(exp)
print('wrote export', EXP_DST)
print('leftover215839', '215839' in exp, 'leftover3771', '3771' in exp, 'leftover uniforms25', 'uniforms25' in exp)
print('ok')
