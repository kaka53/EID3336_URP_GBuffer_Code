from pathlib import Path
import json

def dump_cs(path, keys, outp):
    lines = Path(path).read_text(encoding='utf8', errors='replace').splitlines()
    out = ['FILE %s n=%d' % (path, len(lines))]
    for i, ln in enumerate(lines, 1):
        if any(k in ln for k in keys):
            out.append('%5d| %s' % (i, ln.rstrip()[:240]))
    Path(outp).write_text('\n'.join(out), encoding='utf8')
    print('wrote', outp, 'hits', len(out)-1)

dump_cs(
    r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215851_PS215852_Batch/Editor/ColourPass6VS215851PS215852BatchImporter.cs',
    ['uniforms28','uniforms27','uniforms39','LoadTexture','ReadCB','instanceBuffer','Combined','res23','res25','res34','res35','AlphaCutoff','ExpectedEIDs','CreateExpandedMesh','InstanceBinder','ValidateProfile','ReadInput6','instanceStride','files.','LoadInstance','CombinedTex','EID3863'],
    r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/tmp_215851_hits.txt',
)

dump_cs(
    r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215843_PS215844_Batch/Shaders/EID215843VegetationVS.hlsl',
    ['struct ','ObjectToWorld','0.0020','TEXCOORD','Instance','_input','oct','packed','NORMAL'],
    r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/tmp_215843_vs_hits.txt',
)

dump_cs(
    r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215843_PS215844_Batch/Shaders/EID215844VegetationPS.hlsl',
    ['DXT5nm','distFade','_P0','rt0','SampleBias','Instances','WorldSpace'],
    r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/tmp_215843_ps_hits.txt',
)

dump_cs(
    r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS218872_PS218873_Batch/Shaders/EID218872218873GBuffer.hlsl',
    ['EvaluateWind','Res32','Res33','Res34','ObjectToWorld','_P00','DXT5nm','0.0020','oct','distFade','rt0'],
    r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/tmp_218872_hlsl_hits.txt',
)

dump_cs(
    r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215851_PS215852_Batch/Shaders/EID215851VegetationVS.hlsl',
    ['EvaluateWind','EID3863VSRes','ObjectToWorld','0.001956','0.0020','TEXCOORD','struct EID'],
    r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/tmp_215851_vs_hits.txt',
)

# dump json summary
d = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215847.json').read_text(encoding='utf8'))
print('dump keys', list(d.keys())[:40] if isinstance(d, dict) else type(d))
if isinstance(d, dict):
    print('top', {k: (type(v).__name__, (len(v) if hasattr(v,'__len__') and not isinstance(v,str) else str(v)[:80])) for k,v in list(d.items())[:20]})
