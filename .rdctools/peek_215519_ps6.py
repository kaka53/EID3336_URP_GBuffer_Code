from pathlib import Path
lines = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/86e06de4d07f39b8_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
for i in range(650, 800):
    print(f'{i}: {lines[i][:240]}')
