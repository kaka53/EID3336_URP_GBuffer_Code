from pathlib import Path
asm = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/317c0cc4af786020_PS.spvasm').read_text(encoding='utf8', errors='replace')
lines = asm.splitlines()
print('total', len(lines))
# dump main body from first function line
start = 317
for i in range(start, len(lines)):
    print('%5d %s' % (i+1, lines[i][:240]))
