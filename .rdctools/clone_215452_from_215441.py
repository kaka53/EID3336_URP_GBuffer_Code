import os, shutil

SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215441_PS215442_Batch'
DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215452_PS215453_Batch'

FILES = [
    ('Editor/ColourPass6VS215441PS215442BatchImporter.cs', 'Editor/ColourPass6VS215452PS215453BatchImporter.cs'),
    ('Runtime/EID215441DrawProfile.cs', 'Runtime/EID215452DrawProfile.cs'),
    ('Shaders/EID215441215442GBuffer.shader', 'Shaders/EID215452215453GBuffer.shader'),
    ('Shaders/EID215441215442GBuffer.hlsl', 'Shaders/EID215452215453GBuffer.hlsl'),
]


def rewrite(text):
    text = text.replace('ColourPass6VS215441PS215442BatchImporter', 'ColourPass6VS215452PS215453BatchImporter')
    text = text.replace('ColourPass6_VS215441_PS215442_Batch', 'ColourPass6_VS215452_PS215453_Batch')
    text = text.replace('VS215441_PS215442', 'VS215452_PS215453')
    text = text.replace('EID215441215442GBuffer', 'EID215452215453GBuffer')
    text = text.replace('EID215441DrawProfile', 'EID215452DrawProfile')
    text = text.replace('EID215441Vertex', 'EID215452Vertex')
    text = text.replace('EID215442Fragment', 'EID215453Fragment')
    text = text.replace('Attributes215441', 'Attributes215452')
    text = text.replace('Varyings215441', 'Varyings215452')
    text = text.replace('GBufferOutput215442', 'GBufferOutput215453')
    text = text.replace('DecodeOctNormal215441', 'DecodeOctNormal215452')
    text = text.replace('DecodePackedTangent215441', 'DecodePackedTangent215452')
    text = text.replace('_EID215442MipBias', '_EID215453MipBias')
    text = text.replace('EID215441_215442_GBUFFER_INCLUDED', 'EID215452_215453_GBUFFER_INCLUDED')
    text = text.replace('VS215441', 'VS215452')
    text = text.replace('PS215442', 'PS215453')
    text = text.replace('215441', '215452')
    text = text.replace('215442', '215453')
    return text


if os.path.isdir(DST):
    shutil.rmtree(DST)
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
os.makedirs(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/ColourPass6_VS215452', exist_ok=True)
print('ok')
