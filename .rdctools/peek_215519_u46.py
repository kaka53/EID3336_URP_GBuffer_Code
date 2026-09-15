from pathlib import Path
lines = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/86e06de4d07f39b8_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()

# find struct45 (uniforms46)
for i,l in enumerate(lines):
    if 'struct45' in l or 'struct 45' in l or l.strip().startswith('struct'):
        if i < 400:
            print(f'{i}: {l[:200]}')

print('--- struct45 body ---')
# print 180-400
for i in range(170, 410):
    print(f'{i}: {lines[i][:200]}')
