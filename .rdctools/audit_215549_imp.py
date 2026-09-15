from pathlib import Path
imp = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215549_PS215550_Batch/Editor/ColourPass6VS215549PS215550BatchImporter.cs').read_text(encoding='utf8')
needles = ['ExpectedEIDs','ExpectedInstances','ExpectedUniqueMeshes','ExpectedLayoutVariants','uniforms28','uniforms30','uniforms32','uniforms20','uniforms17','res23','res25','res27','i < 26','i < 27','416','432','CreateMaterial','ApplyInstance','Queue','ZTest','Cull','MenuItem','audit.Insert','3734','57.1','215549','215550','2528','215493','family 36']
print('counts')
for n in needles:
    print(n, imp.count(n))
print('\nmatching lines')
for i, ln in enumerate(imp.splitlines(), 1):
    if any(x in ln for x in ('ExpectedEIDs','ExpectedInstances','ExpectedUniqueMeshes','ExpectedLayoutVariants','uniforms28','uniforms30','uniforms32','uniforms20','i < 26','i < 27','416','432','CreateMaterial','ApplyInstance','ZTest','Cull','MenuItem','audit.Insert','3734','LoadTexture','SetTexture','ReadCB','MipBias','LightMix','Overlay','res27','uniqueMeshes')):
        print('%4d %s' % (i, ln[:240]))
