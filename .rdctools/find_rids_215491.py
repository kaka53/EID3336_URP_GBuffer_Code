from pathlib import Path
root = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets')
rids = ['278750', '248770', '278707']
hits = {r: [] for r in rids}
for p in root.rglob('*'):
    n = p.name.lower()
    if n.endswith('.meta') or n.endswith('.raw'):
        continue
    for r in rids:
        if ('rid' + r) in n:
            hits[r].append(str(p.relative_to(root.parent)).replace('\\', '/'))
for r, xs in hits.items():
    print(r, 'count', len(xs))
    for x in xs[:12]:
        print(' ', x)
