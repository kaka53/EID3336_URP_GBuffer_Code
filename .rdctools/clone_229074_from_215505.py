import os, shutil

SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215505_PS215507_Batch'
DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS229074_PS229075_Batch'
EXP_SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215505_215507_batch.py'
EXP_DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_229074_229075_batch.py'

FILES = [
    ('Editor/ColourPass6VS215505PS215507BatchImporter.cs', 'Editor/ColourPass6VS229074PS229075BatchImporter.cs'),
    ('Runtime/EID215505DrawProfile.cs', 'Runtime/EID229074DrawProfile.cs'),
    ('Shaders/EID215505215507GBuffer.shader', 'Shaders/EID229074229075GBuffer.shader'),
    ('Shaders/EID215505215507GBuffer.hlsl', 'Shaders/EID229074229075GBuffer.hlsl'),
]


def rewrite(text):
    text = text.replace('ColourPass6VS215505PS215507BatchImporter', 'ColourPass6VS229074PS229075BatchImporter')
    text = text.replace('ColourPass6_VS215505_PS215507_Batch', 'ColourPass6_VS229074_PS229075_Batch')
    text = text.replace('VS215505_PS215507', 'VS229074_PS229075')
    text = text.replace('EID215505215507GBuffer', 'EID229074229075GBuffer')
    text = text.replace('EID215505DrawProfile', 'EID229074DrawProfile')
    text = text.replace('EID215505Vertex', 'EID229074Vertex')
    text = text.replace('EID215507Fragment', 'EID229075Fragment')
    text = text.replace('Attributes215505', 'Attributes229074')
    text = text.replace('Varyings215505', 'Varyings229074')
    text = text.replace('GBufferOutput215507', 'GBufferOutput229075')
    text = text.replace('DecodeOctNormal215505', 'DecodeOctNormal229074')
    text = text.replace('DecodePackedTangent215505', 'DecodePackedTangent229074')
    text = text.replace('_EID215507MipBias', '_EID229075MipBias')
    text = text.replace('EID215505_215507_GBUFFER_INCLUDED', 'EID229074_229075_GBUFFER_INCLUDED')
    text = text.replace('VS215505', 'VS229074')
    text = text.replace('PS215507', 'PS229075')
    text = text.replace('215505', '229074')
    text = text.replace('215507', '229075')
    return text


for rel_src, rel_dst in FILES:
    src = os.path.join(SRC, rel_src)
    dst = os.path.join(DST, rel_dst)
    os.makedirs(os.path.dirname(dst), exist_ok=True)
    text = rewrite(open(src, encoding='utf8').read())
    open(dst, 'w', encoding='utf8', newline='\n').write(text)
    print('wrote', rel_dst, os.path.getsize(dst))

for d in (
    'Geometry/Meshes', 'Materials', 'Profiles', 'TextureDatabase',
    'Captured/Geometry', 'Captured/CBuffers', 'Captured/Instances',
):
    os.makedirs(os.path.join(DST, d), exist_ok=True)
os.makedirs(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/ColourPass6_VS229074', exist_ok=True)

exp = rewrite(open(EXP_SRC, encoding='utf8').read())
open(EXP_DST, 'w', encoding='utf8', newline='\n').write(exp)
print('wrote export', EXP_DST)
