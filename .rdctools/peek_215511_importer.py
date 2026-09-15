from pathlib import Path
p = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215511_PS215514_Batch/Editor/ColourPass6VS215511PS215514BatchImporter.cs')
text = p.read_text(encoding='utf8')
# print key sections
keys = ['ExpectedEIDs', 'ExpectedInstances', 'ExpectedLayoutVariants', 'ExpectedUniqueMeshes',
        'uniforms43', 'uniforms45', 'uniforms21', 'uniforms30', 'uniforms24',
        'res33', 'CreateMaterial', 'ValidateProfile', 'ZTest', 'LoadTexture']
for k in keys:
    print('---', k, 'count', text.count(k))
# dump CreateMaterial and ValidateProfile
lines = text.splitlines()
for i, ln in enumerate(lines, 1):
    if 'static Material CreateMaterial' in ln or 'static void ValidateProfile' in ln or 'static void ApplyInstanceState' in ln or 'ExpectedEIDs' in ln or 'ExpectedInstances' in ln or 'ExpectedLayout' in ln or 'ExpectedUnique' in ln:
        print('%4d %s' % (i, ln))
print('===== CreateMaterial =====')
start = text.find('static Material CreateMaterial')
end = text.find('static EID215511DrawProfile CreateProfileAsset')
print(text[start:end])
print('===== ValidateProfile =====')
start = text.find('static void ValidateProfile')
end = text.find('static Mesh GetOrCreateMesh')
print(text[start:end][:4000])
