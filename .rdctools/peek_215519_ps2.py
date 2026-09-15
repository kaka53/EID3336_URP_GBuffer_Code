from pathlib import Path
p = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/86e06de4d07f39b8_PS.spvasm')
lines = p.read_text(encoding='utf8', errors='replace').splitlines()

print('=== UniformConstant / binding ===')
for i,line in enumerate(lines):
    if 'UniformConstant' in line or 'DescriptorSet' in line or 'Binding' in line:
        if i < 400 or 'res3' in line or 'res4' in line or 'res33' in line or 'res35' in line:
            print(f'{i}: {line[:220]}')

print('\n=== first 250 of function body-ish (void _ ) ===')
fn = None
for i,line in enumerate(lines):
    if line.startswith('void ') and '(' in line:
        print(f'{i}: {line[:200]}')
        if fn is None:
            fn = i

# print unique-set related around samples 517-900
print('\n=== unique-set sample neighborhood ===')
for i in range(300, 950):
    if i < len(lines):
        l = lines[i]
        if any(k in l for k in ['res3','res4','ImageSample','SampledImage','uniforms46','_child','Load(', 'uv', 'Bias']):
            print(f'{i}: {l[:220]}')
