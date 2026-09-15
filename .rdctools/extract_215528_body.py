from pathlib import Path
import json

asm = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/317c0cc4af786020_PS.spvasm').read_text(encoding='utf8', errors='replace')
lines = asm.splitlines()

# dump struct35 members (uniforms36)
print('===== struct35 / uniforms36 =====')
for i, ln in enumerate(lines, 1):
    if 'struct35' in ln or 'struct36' in ln or '_36.' in ln or 'child' in ln.lower() and '36' in ln:
        if i < 290 or 'struct35' in ln:
            print('%5d %s' % (i, ln[:220]))

print('\n===== types around 70-290 =====')
for i, ln in enumerate(lines[70:290], 71):
    if any(k in ln for k in ('struct', 'float4', 'float3', 'Member', 'Offset')):
        print('%5d %s' % (i, ln[:220]))

print('\n===== sample neighborhood =====')
for idx in (415, 431, 533, 600, 618):
    print('\n--- around', idx, '---')
    for j in range(max(0, idx-25), min(len(lines), idx+20)):
        print('%5d %s' % (j+1, lines[j][:240]))
