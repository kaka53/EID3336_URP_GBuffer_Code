from pathlib import Path

ps = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/d3eb4657e302f3fe_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
print('PS lines', len(ps))
print('=== PS from 260 ===')
for i, line in enumerate(ps):
    if i >= 260:
        print(f'{i:4d}|{line[:200]}')
