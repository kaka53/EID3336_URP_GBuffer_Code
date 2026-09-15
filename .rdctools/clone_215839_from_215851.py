import os, shutil

SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215851_PS215852_Batch'
DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215839_PS215840_Batch'
EXP_SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215851_215852_batch.py'
EXP_DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215839_215840_batch.py'

FILES = [
    ('Editor/ColourPass6VS215851PS215852BatchImporter.cs', 'Editor/ColourPass6VS215839PS215840BatchImporter.cs'),
    ('Runtime/EID215851DrawProfile.cs', 'Runtime/EID215839DrawProfile.cs'),
    ('Runtime/EID215851InstanceBinder.cs', 'Runtime/EID215839InstanceBinder.cs'),
    ('Shaders/EID215851215852GBuffer.shader', 'Shaders/EID215839215840GBuffer.shader'),
    ('Shaders/EID215851VegetationVS.hlsl', 'Shaders/EID215839VegetationVS.hlsl'),
    ('Shaders/EID215851VegetationPS.hlsl', 'Shaders/EID215839VegetationPS.hlsl'),
    ('Shaders/EID215851CapturedConstants.hlsl', 'Shaders/EID215839CapturedConstants.hlsl'),
    ('Editor/ColourPass6VS215851PS215852BatchImporter.cs.meta', 'Editor/ColourPass6VS215839PS215840BatchImporter.cs.meta'),
    ('Runtime/EID215851DrawProfile.cs.meta', 'Runtime/EID215839DrawProfile.cs.meta'),
    ('Runtime/EID215851InstanceBinder.cs.meta', 'Runtime/EID215839InstanceBinder.cs.meta'),
    ('Shaders/EID215851215852GBuffer.shader.meta', 'Shaders/EID215839215840GBuffer.shader.meta'),
    ('Shaders/EID215851VegetationVS.hlsl.meta', 'Shaders/EID215839VegetationVS.hlsl.meta'),
    ('Shaders/EID215851VegetationPS.hlsl.meta', 'Shaders/EID215839VegetationPS.hlsl.meta'),
    ('Shaders/EID215851CapturedConstants.hlsl.meta', 'Shaders/EID215839CapturedConstants.hlsl.meta'),
]


def rewrite(text):
    text = text.replace('ColourPass6VS215851PS215852BatchImporter', 'ColourPass6VS215839PS215840BatchImporter')
    text = text.replace('ColourPass6_VS215851_PS215852_Batch', 'ColourPass6_VS215839_PS215840_Batch')
    text = text.replace('VS215851_PS215852', 'VS215839_PS215840')
    text = text.replace('EID215851215852GBuffer', 'EID215839215840GBuffer')
    text = text.replace('EID215851DrawProfile', 'EID215839DrawProfile')
    text = text.replace('EID215851InstanceBinder', 'EID215839InstanceBinder')
    text = text.replace('EID215851Instance', 'EID215839Instance')
    text = text.replace('_EID215851Instances', '_EID215839Instances')
    text = text.replace('EID215851Vertex', 'EID215839Vertex')
    text = text.replace('EID215852Fragment', 'EID215840Fragment')
    text = text.replace('VS215851', 'VS215839')
    text = text.replace('PS215852', 'PS215840')
    text = text.replace('215851', '215839')
    text = text.replace('215852', '215840')
    text = text.replace('EID215851VegetationVS.hlsl', 'EID215839VegetationVS.hlsl')
    text = text.replace('EID215851VegetationPS.hlsl', 'EID215839VegetationPS.hlsl')
    text = text.replace('EID215851CapturedConstants.hlsl', 'EID215839CapturedConstants.hlsl')
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
    'Editor/ColourPass6VS215839PS215840BatchImporter.cs.meta': '215839d4e5f647890abcde4455667701',
    'Shaders/EID215839215840GBuffer.shader.meta': '215839d4e5f647890abcde4455667702',
    'Shaders/EID215839VegetationVS.hlsl.meta': '215839d4e5f647890abcde4455667703',
    'Shaders/EID215839VegetationPS.hlsl.meta': '215839d4e5f647890abcde4455667704',
    'Shaders/EID215839CapturedConstants.hlsl.meta': '215839d4e5f647890abcde4455667705',
    'Runtime/EID215839DrawProfile.cs.meta': '215839d4e5f647890abcde4455667706',
    'Runtime/EID215839InstanceBinder.cs.meta': '215839d4e5f647890abcde4455667707',
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
os.makedirs(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/ColourPass6_VS215839', exist_ok=True)

exp = rewrite(open(EXP_SRC, encoding='utf8').read())
exp = exp.replace(
    "MESH_ITEM = {\n    3885: '32.1',\n    3889: '32.2',\n    3895: '32.3',\n}",
    "MESH_ITEM = {\n    3771: '45.1',\n    3776: '45.2',\n}",
)
exp = exp.replace('EIDS = [3885, 3889, 3895]', 'EIDS = [3771, 3776]')
exp = exp.replace('VS_SHARED = {\'res34\',\'res35\',\'res36\',\'res37\'}', "VS_SHARED = {'res29'}")
exp = exp.replace("if key == 'VS' and name == 'uniforms28':", "if key == 'VS' and name == 'uniforms25':")
exp = exp.replace("EID%d_uniforms28_%d.bytes'", "EID%d_uniforms25_%d.bytes'")
exp = exp.replace("missing VS uniforms28 instance array", "missing VS uniforms25 instance array")
exp = exp.replace("'8fca51be7d8f9ad5_VS.spv'", "'96360155ef3e6bb7_VS.spv'")
exp = exp.replace("'8fca51be7d8f9ad5_VS.spvasm'", "'96360155ef3e6bb7_VS.spvasm'")
exp = exp.replace("'8656f77f9e6539bf_PS.spv'", "'3fb447c54784406d_PS.spv'")
exp = exp.replace("'8656f77f9e6539bf_PS.spvasm'", "'3fb447c54784406d_PS.spvasm'")
exp = exp.replace(
    "os.path.join(ASSETS, 'ColourPass6_VS215849_PS215850_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215839_PS215840_Batch', 'TextureDatabase'),",
    "os.path.join(ASSETS, 'EID3332_EID3336_Combined', 'EID3863_RenderDocVegetation', 'ImportedTextures'),\n        os.path.join(ASSETS, 'ColourPass6_VS215839_PS215840_Batch', 'TextureDatabase'),",
)
open(EXP_DST, 'w', encoding='utf8', newline='\n').write(exp)
print('wrote export', EXP_DST, 'leftover215851', '215851' in exp, 'leftover3885', '3885' in exp)
print('ok')
