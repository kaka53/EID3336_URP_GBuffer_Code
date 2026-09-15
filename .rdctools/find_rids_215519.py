from pathlib import Path
root = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace')
rids = [243284, 251280, 261996, 202675, 230832, 197602, 197598, 198094, 204, 271247]
hits = {r: [] for r in rids}
for p in root.rglob('*'):
    if not p.is_file():
        continue
    if p.suffix.lower() in ('.meta', '.raw'):
        continue
    low = p.name.lower()
    for r in rids:
        if ('rid%d' % r) in low:
            hits[r].append(str(p.relative_to(root)).replace('\\', '/'))
for r, xs in hits.items():
    print(r, xs[:8] if xs else 'MISSING')
