from pathlib import Path
lines = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/f1a7bd79bd85cf88_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
print('=== loads of images / uniforms around samples ===')
# print lines 350-867
for i, ln in enumerate(lines[349:], 350):
    print('%4d %s' % (i, ln[:240]))
