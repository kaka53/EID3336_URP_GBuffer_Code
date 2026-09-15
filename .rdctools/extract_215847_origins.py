from pathlib import Path
vs = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/1e875fd6a16f85f9_VS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
for i, ln in enumerate(vs, 1):
    if '_263' in ln or '_346' in ln or '_200 =' in ln or '_224 =' in ln or '_199 =' in ln or '_206 =' in ln or '_223 =' in ln:
        if i < 600 or 900 < i < 1200 or 1500 < i < 2010:
            print('%4d| %s' % (i, ln.rstrip()[:200]))
