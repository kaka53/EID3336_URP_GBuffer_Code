import os, re, shutil

SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215849_PS215850_Batch'
DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215851_PS215852_Batch'
EXP_SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215849_215850_batch.py'
EXP_DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215851_215852_batch.py'

FILES = [
    ('Editor/ColourPass6VS215849PS215850BatchImporter.cs', 'Editor/ColourPass6VS215851PS215852BatchImporter.cs'),
    ('Runtime/EID215849DrawProfile.cs', 'Runtime/EID215851DrawProfile.cs'),
    ('Runtime/EID215849InstanceBinder.cs', 'Runtime/EID215851InstanceBinder.cs'),
    ('Shaders/EID215849215850GBuffer.shader', 'Shaders/EID215851215852GBuffer.shader'),
    ('Shaders/EID3863VegetationVS.hlsl', 'Shaders/EID215851VegetationVS.hlsl'),
    ('Shaders/EID3863VegetationPS.hlsl', 'Shaders/EID215851VegetationPS.hlsl'),
    ('Shaders/EID3863CapturedConstants.hlsl', 'Shaders/EID215851CapturedConstants.hlsl'),
]


def rewrite(text):
    text = text.replace('ColourPass6VS215849PS215850BatchImporter', 'ColourPass6VS215851PS215852BatchImporter')
    text = text.replace('ColourPass6_VS215849_PS215850_Batch', 'ColourPass6_VS215851_PS215852_Batch')
    text = text.replace('VS215849_PS215850', 'VS215851_PS215852')
    text = text.replace('EID215849215850GBuffer', 'EID215851215852GBuffer')
    text = text.replace('EID215849DrawProfile', 'EID215851DrawProfile')
    text = text.replace('EID215849InstanceBinder', 'EID215851InstanceBinder')
    text = text.replace('EID215849Instance', 'EID215851Instance')
    text = text.replace('_EID215849Instances', '_EID215851Instances')
    text = text.replace('EID215849Vertex', 'EID215851Vertex')
    text = text.replace('EID215850Fragment', 'EID215852Fragment')
    text = text.replace('VS215849', 'VS215851')
    text = text.replace('PS215850', 'PS215852')
    text = text.replace('215849', '215851')
    text = text.replace('215850', '215852')
    text = text.replace('EID3863VegetationVS.hlsl', 'EID215851VegetationVS.hlsl')
    text = text.replace('EID3863VegetationPS.hlsl', 'EID215851VegetationPS.hlsl')
    text = text.replace('EID3863CapturedConstants.hlsl', 'EID215851CapturedConstants.hlsl')
    return text


for rel_src, rel_dst in FILES:
    src = os.path.join(SRC, rel_src)
    dst = os.path.join(DST, rel_dst)
    os.makedirs(os.path.dirname(dst), exist_ok=True)
    text = open(src, encoding='utf8').read()
    open(dst, 'w', encoding='utf8', newline='\n').write(rewrite(text))
    print('wrote', rel_dst, os.path.getsize(dst))

os.makedirs(os.path.join(DST, 'Geometry/Meshes'), exist_ok=True)
os.makedirs(os.path.join(DST, 'Materials'), exist_ok=True)
os.makedirs(os.path.join(DST, 'Profiles'), exist_ok=True)
os.makedirs(os.path.join(DST, 'TextureDatabase'), exist_ok=True)
os.makedirs(os.path.join(DST, 'Captured/Geometry'), exist_ok=True)
os.makedirs(os.path.join(DST, 'Captured/CBuffers'), exist_ok=True)
os.makedirs(os.path.join(DST, 'Captured/Instances'), exist_ok=True)
os.makedirs(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/ColourPass6_VS215851', exist_ok=True)

exp = rewrite(open(EXP_SRC, encoding='utf8').read())
exp = exp.replace(
    "MESH_ITEM = {\n    3863: '21.1',\n    3867: '21.2',\n    3871: '21.3',\n    3875: '21.4',\n    3880: '21.5',\n}",
    "MESH_ITEM = {\n    3885: '32.1',\n    3889: '32.2',\n    3895: '32.3',\n}",
)
exp = exp.replace('EIDS = [3863, 3867, 3871, 3875, 3880]', 'EIDS = [3885, 3889, 3895]')
exp = exp.replace("EXPECTED = (215851, 215852)", "EXPECTED = (215851, 215852)")
exp = exp.replace(
    "os.path.join(ASSETS, 'ColourPass6_VS215851_PS215852_Batch', 'TextureDatabase'),",
    "os.path.join(ASSETS, 'ColourPass6_VS215849_PS215850_Batch', 'TextureDatabase'),\n        os.path.join(ASSETS, 'ColourPass6_VS215851_PS215852_Batch', 'TextureDatabase'),",
)
open(EXP_DST, 'w', encoding='utf8', newline='\n').write(exp)
print('wrote export', EXP_DST)
