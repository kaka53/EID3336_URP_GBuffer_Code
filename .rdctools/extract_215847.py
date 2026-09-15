from pathlib import Path
import re

vs = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/1e875fd6a16f85f9_VS.spvasm').read_text(encoding='utf8', errors='replace')
ps = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65/3a45435d154b42d3_PS.spvasm').read_text(encoding='utf8', errors='replace')
out = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/extract_215847.txt')

lines = []

def grab(label, text, patterns, n=40):
    lines.append('==== %s ====' % label)
    for pat in patterns:
        hits = []
        for i, ln in enumerate(text.splitlines()):
            if re.search(pat, ln, re.I):
                hits.append('%6d| %s' % (i + 1, ln.strip()[:220]))
                if len(hits) >= n:
                    break
        lines.append('-- %s (%d shown) --' % (pat, len(hits)))
        lines.extend(hits)
        lines.append('')

grab('VS Image/Uniform/oct/packed/instance/wind', vs, [
    r'ImageSample', r'UniformConstant Image', r'0\.0020', r'0\.001956',
    r'1073741824', r'ArrayStride', r'InstanceIndex', r'DescriptorSet',
    r'Binding', r'OpTypeImage', r'SampledImage', r'Location',
], 80)

grab('PS Image/clip/DXT5/RT0', ps, [
    r'ImageSample', r'UniformConstant Image', r'OpTypeImage',
    r'DescriptorSet', r'Binding', r'Location', r'Kill', r'Discard',
    r'0\.0010', r'0\.5',
], 80)

out.write_text('\n'.join(lines), encoding='utf8')
print('vs_lines', vs.count('\n'), 'ps_lines', ps.count('\n'), 'out', out)
