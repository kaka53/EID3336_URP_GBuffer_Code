from pathlib import Path
vs = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/1e875fd6a16f85f9_VS.spvasm').read_text(encoding='utf8', errors='replace')
lines = vs.splitlines()
out = []
# dump struct35 / uniforms36 children
for i, ln in enumerate(lines[:280], 1):
    if '_36' in ln or 'struct35' in ln or 'struct25' in ln or 'child' in ln and i < 250:
        if i < 250:
            out.append('%4d| %s' % (i, ln.rstrip()[:200]))
# around samples 1100-1260 and 1840-2200 and packed 2250-end
for a,b in [(250, 330), (1080, 1260), (1500, 1760), (1840, 2324)]:
    out.append('\n===== VS %d-%d =====' % (a,b))
    for i in range(a, min(b, len(lines))+1):
        out.append('%4d| %s' % (i, lines[i-1].rstrip()[:220]))
Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/extract_215847_vs.txt').write_text('\n'.join(out), encoding='utf8')
print('wrote', len(out))
