import json, re
from pathlib import Path

ps = Path('.rdctools/shaders_12_65/6a9a760b1ffcb649_PS.spvasm').read_text(encoding='utf8', errors='replace')
vs = Path('.rdctools/shaders_12_65/c4dd8d3f9f3b1b5b_VS.spvasm').read_text(encoding='utf8', errors='replace')
print('PS lines', len(ps.splitlines()), 'bytes', len(ps))
print('VS lines', len(vs.splitlines()), 'bytes', len(vs))

# images / samples
for pat in ['UniformConstant Image', 'ImageSampleImplicitLod', 'ImageSampleExplicitLod', 'ImageSample', 'Kill', 'Discard', 'OpKill', 'clip', '0.001', '0.002', '0.000976']:
    hits = [i+1 for i,l in enumerate(ps.splitlines()) if pat.lower() in l.lower()]
    print(pat, 'PS', len(hits), hits[:20])

print('--- PS image decls ---')
for i,l in enumerate(ps.splitlines()):
    if 'UniformConstant' in l and ('Image' in l or 'Sampler' in l):
        print(i+1, l[:200])

print('--- PS sample ---')
for i,l in enumerate(ps.splitlines()):
    if 'ImageSample' in l or 'ImageFetch' in l or 'SampledImage' in l and ' =' in l:
        print(i+1, l[:220])

print('--- VS ArrayStride / uniforms ---')
for i,l in enumerate(vs.splitlines()):
    if any(s in l for s in ['ArrayStride', 'DescriptorSet', 'Binding', 'uniforms', 'struct26', 'struct25']):
        if any(s in l for s in ['ArrayStride', 'Binding', 'DescriptorSet', 'Block']):
            print(i+1, l[:220])

print('--- VS packed/oct ---')
for i,l in enumerate(vs.splitlines()):
    if any(s in l for s in ['0.001956', '0.0020', '1073741824', '0.0010', '0.000976']):
        print(i+1, l[:200])
