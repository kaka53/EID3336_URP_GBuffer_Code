from pathlib import Path
imp = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215491_PS215492_Batch/Editor/ColourPass6VS215491PS215492BatchImporter.cs').read_text(encoding='utf8')
needles = ['ExpectedEIDs','ExpectedInstances','ExpectedUniqueMeshes','uniforms33','uniforms23','uniforms20','uniforms35','uniforms17','res27','res29','res31','i < 26','416','CreateMaterial','ApplyInstance','Queue','ZTest','Cull','MenuItem','audit.Insert','3231','51.1','215491','215492']
print('counts')
for n in needles:
    print(n, imp.count(n))
print('\nmatching lines')
for i, ln in enumerate(imp.splitlines(), 1):
    if any(x in ln for x in ('ExpectedEIDs','ExpectedInstances','ExpectedUniqueMeshes','uniforms33','uniforms23','uniforms20','uniforms35','i < 26','416','CreateMaterial','ApplyInstance','ZTest','Cull','MenuItem','audit.Insert','3231','LoadTexture','SetTexture','ReadCB','MipBias','LightMix','Overlay')):
        print('%4d %s' % (i, ln[:220]))
