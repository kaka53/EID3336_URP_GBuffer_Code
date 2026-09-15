from pathlib import Path
root = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace')
need = [277115, 272330, 277083, 196313, 175]
for rid in need:
    hits = list(root.rglob('rid%d.dds' % rid)) + list(root.rglob('rid%d.*' % rid))
    # filter meta
    hits = [h for h in hits if h.suffix.lower() != '.meta' and 'Library' not in h.parts]
    print(rid, [str(h.relative_to(root)) for h in hits[:8]])
