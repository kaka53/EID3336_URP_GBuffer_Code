from pathlib import Path
import re

p = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/2573294c13f3ad66_PS.spvasm')
text = p.read_text(encoding='utf8', errors='replace')
print('bytes', p.stat().st_size, 'lines', text.count('\n'))

# bindings / images / sampled
keys = [
    'UniformConstant Image',
    'ImageSampleImplicitLod',
    'ImageSampleExplicitLod',
    'ImageSampleDref',
    'OpTypeImage',
    'Binding',
    'DescriptorSet',
    'Location',
    'Output',
    'Discard',
    'Kill',
    'clip',
    'Alpha',
]
for k in keys:
    n = text.count(k)
    if n:
        print('%s: %d' % (k, n))

# extract UniformConstant Image lines and nearby names
lines = text.splitlines()
print('\n=== UniformConstant / Binding snippets ===')
for i, ln in enumerate(lines):
    if 'UniformConstant' in ln or ('Binding' in ln and 'Decorate' in ln):
        print('%5d %s' % (i+1, ln[:220]))

print('\n=== Name of images / sampled images ===')
for i, ln in enumerate(lines):
    if any(x in ln for x in ('res', 'Image', 'Sampler', 'uniforms')) and ('Name ' in ln or 'MemberName' in ln):
        if any(x in ln.lower() for x in ('res', 'uniform', 'image', 'sampler', 'struct', 'type')):
            print('%5d %s' % (i+1, ln[:220]))
