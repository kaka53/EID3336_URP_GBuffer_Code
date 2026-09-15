from pathlib import Path
vs = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/1e875fd6a16f85f9_VS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
ps = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/3a45435d154b42d3_PS.spvasm').read_text(encoding='utf8', errors='replace').splitlines()
out = []
out.append('VS lines %d PS lines %d' % (len(vs), len(ps)))
# samples
for i, ln in enumerate(vs, 1):
    if any(k in ln for k in ('ImageSample', '*_32', '*_33', '*_34', '0.0020', '0.001956', 'uniforms27', 'uniforms36', 'InstanceIndex', 'Kill', 'Discard')):
        if i < 400 or i > 1000:
            out.append('VS %4d| %s' % (i, ln.rstrip()[:220]))
out.append('\n===== VS 1080-1280 =====')
for i in range(1080, min(1281, len(vs)+1)):
    out.append('%4d| %s' % (i, vs[i-1].rstrip()[:220]))
out.append('\n===== VS 1840-2324 =====')
for i in range(1840, min(len(vs)+1, 2425)):
    out.append('%4d| %s' % (i, vs[i-1].rstrip()[:220]))
out.append('\n===== PS samples / encode / RT =====')
for i, ln in enumerate(ps, 1):
    if any(k in ln for k in ('ImageSample', '*_25', '*_27', '0.0010', '0.000976', '0.5000', 'SmoothStep', 'FrontFacing', '.wy', 'Discard', 'Kill')):
        out.append('PS %4d| %s' % (i, ln.rstrip()[:220]))
Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/extract_215847_vs.txt').write_text('\n'.join(out), encoding='utf8')
print('wrote', len(out), 'vs', len(vs), 'ps', len(ps))
