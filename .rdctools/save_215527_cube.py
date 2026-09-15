import os, json

EID = 3561
RID = 257548
TEX = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215527_PS215528_Batch/TextureDatabase'
OUT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/save_215527_cube.json'


def rid(x):
    try:
        return int(x)
    except Exception:
        return 0


def work(c):
    c.SetFrameEvent(EID, False)
    texdesc = {rid(t.resourceId): t for t in c.GetTextures()}
    t = texdesc.get(RID)
    os.makedirs(TEX, exist_ok=True)
    if t is None:
        rec = {'rid': RID, 'ok': False, 'error': 'missing'}
        open(OUT, 'w', encoding='utf8').write(json.dumps(rec, indent=2))
        return rec
    path = os.path.join(TEX, 'rid%d.dds' % RID)
    cfg = rd.TextureSave()
    cfg.resourceId = t.resourceId
    cfg.destType = rd.FileType.DDS
    cfg.mip = -1
    cfg.slice.sliceIndex = -1
    ok = bool(c.SaveTexture(cfg, path))
    rec = {
        'rid': RID,
        'ok': ok,
        'path': path,
        'exists': os.path.exists(path),
        'bytes': os.path.getsize(path) if os.path.exists(path) else 0,
        'format': t.format.Name(),
        'w': int(t.width),
        'h': int(t.height),
        'mips': int(t.mips),
        'arraysize': int(getattr(t, 'arraysize', 0) or 0),
        'type': str(getattr(t, 'type', '')),
        'cubemap': bool(getattr(t, 'cubemap', False)),
    }
    open(OUT, 'w', encoding='utf8').write(json.dumps(rec, indent=2))
    return rec


print(json.dumps(ctx.replay(work), default=str))
