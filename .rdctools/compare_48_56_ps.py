from pathlib import Path

a56 = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/90ecda7e2c13e67b_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
a48 = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/0bc71add2993d083_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
print('56 lines', len(a56), '48 lines', len(a48))

# strip ids-ish by keeping opcode + trailing operands without SSA
def norm(ln):
    s = ln.strip()
    # drop leading SSA assign
    if ' = ' in s:
        s = s.split(' = ', 1)[1]
    return s

n56 = [norm(x) for x in a56]
n48 = [norm(x) for x in a48]
# find first unique-material sample region differences around ImageSampleImplicitLod
print('56 implicit', sum(1 for x in a56 if 'ImageSampleImplicitLod' in x))
print('48 implicit', sum(1 for x in a48 if 'ImageSampleImplicitLod' in x))
print('56 explicit', sum(1 for x in a56 if 'ImageSampleExplicitLod' in x))
print('48 explicit', sum(1 for x in a48 if 'ImageSampleExplicitLod' in x))

# print first 6 implicit sample contexts for each
print('\n===== 48 implicit samples =====')
for i, ln in enumerate(a48, 1):
    if 'ImageSampleImplicitLod' in ln:
        for j in range(max(1, i-6), min(len(a48), i+2)+1):
            print('%5d %s' % (j, a48[j-1][:200]))
        print('---')

print('\n===== 56 implicit samples =====')
for i, ln in enumerate(a56, 1):
    if 'ImageSampleImplicitLod' in ln:
        for j in range(max(1, i-6), min(len(a56), i+2)+1):
            print('%5d %s' % (j, a56[j-1][:200]))
        print('---')
