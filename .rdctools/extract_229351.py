# -*- coding: utf-8 -*-
from pathlib import Path
import re, json, struct

ROOT = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace')
VS = (ROOT / '.rdctools/shaders_12_65/cf659d5dd67c65c6_VS.spvasm').read_text(encoding='utf8', errors='replace')
PS = (ROOT / '.rdctools/shaders_12_65/25afab1205707dfd_PS.spvasm').read_text(encoding='utf8', errors='replace')
dump = json.loads((ROOT / '.rdctools/dump_229351.json').read_text(encoding='utf8'))
e = dump['3755']
out = []

def hits(txt, pats, n=40):
    lines = txt.splitlines()
    found = []
    for i, ln in enumerate(lines, 1):
        for p in pats:
            if p.lower() in ln.lower():
                found.append('%5d| %s' % (i, ln[:220]))
                break
        if len(found) >= n:
            break
    return found

out.append('=== VS FILE SIZE / LINES ===')
out.append('bytes=%d lines=%d' % (len(VS.encode('utf8')), VS.count('\n')+1))
out.append('=== PS FILE SIZE / LINES ===')
out.append('bytes=%d lines=%d' % (len(PS.encode('utf8')), PS.count('\n')+1))

out.append('\n=== VS KEYWORDS ===')
for p in ['0.0020', '0.001956', '0.0010', '0.000976', 'ImageSample', 'Kill', 'Discard', 'Invariant',
          'ArrayStride', 'DescriptorSet', 'Binding', 'InstanceIndex', 'Location', 'BuiltIn',
          'OpTypeImage', 'UniformConstant']:
    c = VS.lower().count(p.lower())
    if c:
        out.append('%s: %d' % (p, c))

out.append('\n=== PS KEYWORDS ===')
for p in ['0.0020', '0.001956', '0.0010', '0.000976', 'ImageSample', 'Kill', 'Discard',
          'ArrayStride', 'DescriptorSet', 'Binding', 'Location', 'FrontFacing',
          'OpTypeImage', 'UniformConstant', 'Output']:
    c = PS.lower().count(p.lower())
    if c:
        out.append('%s: %d' % (p, c))

out.append('\n=== VS ImageSample / oct / packed / wind ===')
out += hits(VS, ['ImageSample', '0.0020', '0.001956', '1073741824', '0x40000000', 'ArrayStride',
                 'InstanceIndex', 'child26', 'Wind', '0.0313'], 80)

out.append('\n=== VS entry / decorations Location Binding ===')
out += hits(VS, ['Location', 'BuiltIn InstanceIndex', 'DescriptorSet', 'Binding', 'ArrayStride 96',
                 'ArrayStride 256'], 80)

out.append('\n=== PS ImageSample / encode / Kill / DXT / RT ===')
out += hits(PS, ['ImageSample', '0.0010', '0.000976', 'Kill', 'Discard', 'FrontFacing',
                 'CompositeConstruct', '0.5', 'Output'], 80)

out.append('\n=== PS decorations ===')
out += hits(PS, ['Location', 'DescriptorSet', 'Binding', 'ArrayStride'], 60)

# dump extras
out.append('\n=== DUMP RASTER / TEX / CB ===')
out.append('cull=%s zw=%s zfn=%s sref=%s sfn=%s scm=%s swm=%s frontCCW=%s' % (
    e.get('cull'), e.get('zw'), e.get('zfn'), e.get('sref'), e.get('sfn'), e.get('scm'), e.get('swm'), e.get('frontCCW')))
out.append('writeMask=%s blend0=%s inst=%s idx=%s' % (e.get('writeMask'), e.get('blend0'), e.get('inst'), e.get('idx')))
out.append('layout:')
for x in e.get('layout', []):
    out.append('  %s' % (x,))
out.append('vstex=%s' % e.get('vstex'))
out.append('pstex=%s' % e.get('pstex'))
out.append('rw=%s' % e.get('rw'))
out.append('flags=%s mats=%s' % (e.get('flags'), e.get('mats')))
sl = e.get('slices', {})
out.append('mip VS uniforms24@416 = %s' % sl.get('VS_uniforms24_mip416'))
out.append('y VS uniforms24@436 = %s' % sl.get('VS_uniforms24_y436'))
out.append('mip PS uniforms19@416 = %s' % sl.get('PS_uniforms19_mip416'))
out.append('y PS uniforms19@436 = %s' % sl.get('PS_uniforms19_y436'))
out.append('localKidsN=%d' % len(e.get('localKids', [])))

# local 88 floats
floats = sl.get('PS_uniforms30', {}).get('floats') or sl.get('VS_uniforms33', {}).get('floats')
# dump file may have floats on disk
raw_sl = e['slices'].get('PS_uniforms30', {})
out.append('PS_uniforms30 keys=%s sha=%s nvars=%s' % (list(raw_sl.keys()), raw_sl.get('sha16'), raw_sl.get('nvars')))

# reconstruct packed _P00.. from localKids
kids = e.get('localKids', [])
buf = [0.0]*88
for k in kids:
    off = int(k.get('off') or 0)
    vals = k.get('val') or []
    for i, v in enumerate(vals):
        idx = off//4 + i
        if 0 <= idx < 88:
            buf[idx] = v
out.append('\n=== packed 22 float4 from localKids ===')
for i in range(22):
    a = buf[i*4:(i+1)*4]
    out.append('_P%02d  %s' % (i, a))

# search unique texture rids
for rid in (262741, 256294, 14988):
    hits_p = list(ROOT.glob('**/*rid%s*' % rid))[:20]
    out.append('\nRID %s existing: %s' % (rid, [str(p.relative_to(ROOT)) for p in hits_p]))

Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/extract_229351.txt').write_text('\n'.join(out), encoding='utf8')
print('wrote extract_229351.txt lines', len(out))
