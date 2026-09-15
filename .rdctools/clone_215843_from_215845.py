import os

SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215845_PS215846_Batch'
DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215843_PS215844_Batch'
EXP_SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215845_215846_batch.py'
EXP_DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215843_215844_batch.py'

FILES = [
    ('Editor/ColourPass6VS215845PS215846BatchImporter.cs', 'Editor/ColourPass6VS215843PS215844BatchImporter.cs'),
    ('Runtime/EID215845DrawProfile.cs', 'Runtime/EID215843DrawProfile.cs'),
    ('Runtime/EID215845InstanceBinder.cs', 'Runtime/EID215843InstanceBinder.cs'),
    ('Shaders/EID215845215846GBuffer.shader', 'Shaders/EID215843215844GBuffer.shader'),
    ('Shaders/EID215845VegetationVS.hlsl', 'Shaders/EID215843VegetationVS.hlsl'),
    ('Shaders/EID215845VegetationPS.hlsl', 'Shaders/EID215844VegetationPS.hlsl'),
    ('Shaders/EID215845CapturedConstants.hlsl', 'Shaders/EID215843CapturedConstants.hlsl'),
    ('Editor/ColourPass6VS215845PS215846BatchImporter.cs.meta', 'Editor/ColourPass6VS215843PS215844BatchImporter.cs.meta'),
    ('Runtime/EID215845DrawProfile.cs.meta', 'Runtime/EID215843DrawProfile.cs.meta'),
    ('Runtime/EID215845InstanceBinder.cs.meta', 'Runtime/EID215843InstanceBinder.cs.meta'),
    ('Shaders/EID215845215846GBuffer.shader.meta', 'Shaders/EID215843215844GBuffer.shader.meta'),
    ('Shaders/EID215845VegetationVS.hlsl.meta', 'Shaders/EID215843VegetationVS.hlsl.meta'),
    ('Shaders/EID215845VegetationPS.hlsl.meta', 'Shaders/EID215844VegetationPS.hlsl.meta'),
    ('Shaders/EID215845CapturedConstants.hlsl.meta', 'Shaders/EID215843CapturedConstants.hlsl.meta'),
]


def rewrite(text):
    text = text.replace('ColourPass6VS215845PS215846BatchImporter', 'ColourPass6VS215843PS215844BatchImporter')
    text = text.replace('ColourPass6_VS215845_PS215846_Batch', 'ColourPass6_VS215843_PS215844_Batch')
    text = text.replace('VS215845_PS215846', 'VS215843_PS215844')
    text = text.replace('EID215845215846GBuffer', 'EID215843215844GBuffer')
    text = text.replace('EID215845InstanceBinder', 'EID215843InstanceBinder')
    text = text.replace('EID215845DrawProfile', 'EID215843DrawProfile')
    text = text.replace('_EID215845Instances', '_EID215843Instances')
    text = text.replace('EID215845Instance', 'EID215843Instance')
    text = text.replace('EID215845Vertex', 'EID215843Vertex')
    text = text.replace('EID215846Fragment', 'EID215844Fragment')
    text = text.replace('EID215845VegetationVS.hlsl', 'EID215843VegetationVS.hlsl')
    text = text.replace('EID215845VegetationPS.hlsl', 'EID215844VegetationPS.hlsl')
    text = text.replace('EID215845CapturedConstants.hlsl', 'EID215843CapturedConstants.hlsl')
    text = text.replace('EID215846DecodeDXT5nm', 'EID215844DecodeDXT5nm')
    text = text.replace('EID215846PSMipBias', 'EID215844PSMipBias')
    text = text.replace('EID215846PSViewDirection', 'EID215844PSViewDirection')
    text = text.replace('EID215845PSFragmentBody', 'EID215843PSFragmentBody')
    text = text.replace('EID215845PSGeneratedMain', 'EID215843PSGeneratedMain')
    text = text.replace('EID215845FragmentMain', 'EID215843FragmentMain')
    text = text.replace('EID215845VSGeneratedMain', 'EID215843VSGeneratedMain')
    text = text.replace('EID215845VertexMain', 'EID215843VertexMain')
    text = text.replace('EID215845VSInputInternal', 'EID215843VSInputInternal')
    text = text.replace('EID215845VertexInput', 'EID215843VertexInput')
    text = text.replace('EID215845VertexVaryings', 'EID215843VertexVaryings')
    text = text.replace('EID215845FragmentVaryings', 'EID215843FragmentVaryings')
    text = text.replace('EID215845GBufferOutput', 'EID215843GBufferOutput')
    text = text.replace('VS215845', 'VS215843')
    text = text.replace('PS215846', 'PS215844')
    text = text.replace('215845', '215843')
    text = text.replace('215846', '215844')
    text = text.replace('uniforms31', 'uniforms30')
    text = text.replace('_Res28', '_Res27')
    text = text.replace('_Res26', '_Res25')
    text = text.replace("'res28'", "'res27'")
    text = text.replace("'res26'", "'res25'")
    text = text.replace('"res28"', '"res27"')
    text = text.replace('"res26"', '"res25"')
    text = text.replace('res26/res28', 'res25/res27')
    text = text.replace('static readonly int[] ExpectedEIDs = { 3849, 3853 };', 'static readonly int[] ExpectedEIDs = { 3844 };')
    text = text.replace('static readonly int ExpectedInstances = 156;', 'static readonly int ExpectedInstances = 3;')
    text = text.replace('static readonly int ExpectedUniqueMeshes = 2;', 'static readonly int ExpectedUniqueMeshes = 1;')
    text = text.replace('46.1-46.2', '58.1')
    text = text.replace('local.Length < 368', 'local.Length < 224')
    text = text.replace('PS uniforms31 expected 368 bytes', 'PS uniforms30 expected 224 bytes')
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
    'Editor/ColourPass6VS215843PS215844BatchImporter.cs.meta': '215843d4e5f647890abcde4455667701',
    'Shaders/EID215843215844GBuffer.shader.meta': '215843d4e5f647890abcde4455667702',
    'Shaders/EID215843VegetationVS.hlsl.meta': '215843d4e5f647890abcde4455667703',
    'Shaders/EID215844VegetationPS.hlsl.meta': '215843d4e5f647890abcde4455667704',
    'Shaders/EID215843CapturedConstants.hlsl.meta': '215843d4e5f647890abcde4455667705',
    'Runtime/EID215843DrawProfile.cs.meta': '215843d4e5f647890abcde4455667706',
    'Runtime/EID215843InstanceBinder.cs.meta': '215843d4e5f647890abcde4455667707',
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

open(os.path.join(DST + '.meta'), 'w', encoding='utf8', newline='\n').write(
    'fileFormatVersion: 2\n'
    'guid: 215843d4e5f647890abcde4455667700\n'
    'folderAsset: yes\n'
    'DefaultImporter:\n'
    '  externalObjects: {}\n'
    '  userData:\n'
    '  assetBundleName:\n'
    '  assetBundleVariant:\n'
)

for sub in (
    'Geometry/Meshes', 'Materials', 'Profiles', 'TextureDatabase',
    'Captured/Geometry', 'Captured/CBuffers', 'Captured/Instances', 'Shaders',
    'Editor', 'Runtime',
):
    os.makedirs(os.path.join(DST, sub), exist_ok=True)
os.makedirs(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/ColourPass6_VS215843', exist_ok=True)

exp = rewrite(open(EXP_SRC, encoding='utf8').read())
exp = exp.replace(
    "MESH_ITEM = {\n    3849: '46.1',\n    3853: '46.2',\n}",
    "MESH_ITEM = {\n    3844: '58.1',\n}",
)
exp = exp.replace('EIDS = [3849, 3853]', 'EIDS = [3844]')
exp = exp.replace("UNIQUE_MATERIAL = {'res26', 'res28'}", "UNIQUE_MATERIAL = {'res25', 'res27'}")
exp = exp.replace("'d89f2edd5b0e7424_VS.spv'", "'951f4c6338c81689_VS.spv'")
exp = exp.replace("'d89f2edd5b0e7424_VS.spvasm'", "'951f4c6338c81689_VS.spvasm'")
exp = exp.replace("'df3dd1dcf42e17e1_PS.spv'", "'d3eb4657e302f3fe_PS.spv'")
exp = exp.replace("'df3dd1dcf42e17e1_PS.spvasm'", "'d3eb4657e302f3fe_PS.spvasm'")
exp = exp.replace('export_215845_215846_batch_result.json', 'export_215843_215844_batch_result.json')
open(EXP_DST, 'w', encoding='utf8', newline='\n').write(exp)
print('wrote export', EXP_DST)

imp = os.path.join(DST, 'Editor/ColourPass6VS215843PS215844BatchImporter.cs')
text = open(imp, encoding='utf8').read()
checks = {
    '215845': '215845' in text,
    '215846': '215846' in text,
    '3849': '3849' in text,
    '3853': '3853' in text,
    '156': '156' in text,
    '368': '368' in text,
    'uniforms31': 'uniforms31' in text,
    'res26': 'res26' in text,
    'res28': 'res28' in text,
    '_P22': '_P22' in text,
    'family 46': 'family 46' in text.lower() or '46.1' in text,
}
print('importer leftovers', checks)
print('export leftovers', {
    '215845': '215845' in exp,
    '3849': '3849' in exp,
    'd89f2edd': 'd89f2edd' in exp,
    'df3dd1dc': 'df3dd1dc' in exp,
    'res26': 'res26' in exp,
    'uniforms31': 'uniforms31' in exp,
})
print('ok')
