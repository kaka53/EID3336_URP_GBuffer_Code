import os, shutil

SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215545_PS215546_Batch'
DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215493_PS215494_Batch'

FILES = [
    ('Editor/ColourPass6VS215545PS215546BatchImporter.cs', 'Editor/ColourPass6VS215493PS215494BatchImporter.cs'),
    ('Runtime/EID215545DrawProfile.cs', 'Runtime/EID215493DrawProfile.cs'),
    ('Shaders/EID215545215546GBuffer.shader', 'Shaders/EID215493215494GBuffer.shader'),
    ('Shaders/EID215545215546GBuffer.hlsl', 'Shaders/EID215493215494GBuffer.hlsl'),
]


def rewrite(text):
    text = text.replace('ColourPass6VS215545PS215546BatchImporter', 'ColourPass6VS215493PS215494BatchImporter')
    text = text.replace('ColourPass6_VS215545_PS215546_Batch', 'ColourPass6_VS215493_PS215494_Batch')
    text = text.replace('VS215545_PS215546', 'VS215493_PS215494')
    text = text.replace('EID215545215546GBuffer', 'EID215493215494GBuffer')
    text = text.replace('EID215545DrawProfile', 'EID215493DrawProfile')
    text = text.replace('EID215545Vertex', 'EID215493Vertex')
    text = text.replace('EID215546Fragment', 'EID215494Fragment')
    text = text.replace('Attributes215545', 'Attributes215493')
    text = text.replace('Varyings215545', 'Varyings215493')
    text = text.replace('GBufferOutput215546', 'GBufferOutput215494')
    text = text.replace('_EID215546MipBias', '_EID215494MipBias')
    text = text.replace('EID215545_215546_GBUFFER_INCLUDED', 'EID215493_215494_GBUFFER_INCLUDED')
    text = text.replace('DecodeOctNormal215545', 'DecodeOctNormal215493')
    text = text.replace('DecodePackedTangent215545', 'DecodePackedTangent215493')
    text = text.replace('VS215545', 'VS215493')
    text = text.replace('PS215546', 'PS215494')
    text = text.replace('215545', '215493')
    text = text.replace('215546', '215494')
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
os.makedirs(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/ColourPass6_VS215493', exist_ok=True)
print('ok')
