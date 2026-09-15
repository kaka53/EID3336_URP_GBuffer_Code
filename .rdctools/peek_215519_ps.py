from pathlib import Path
p = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/86e06de4d07f39b8_PS.spvasm')
text = p.read_text(encoding='utf8', errors='replace')
keys = ['ImageSample', 'ImageFetch', 'UniformConstant', 'OpTypeImage', 'TypeImage', 'Image ', 'SampledImage']
for k in keys:
    n = text.count(k)
    print(k, n)
print('--- sample lines ---')
for i,line in enumerate(text.splitlines()):
    if any(k in line for k in ['ImageSampleImplicitLod','ImageSampleExplicitLod','ImageSampleDref','ImageFetch','SampledImage']):
        print(f'{i}: {line[:200]}')
