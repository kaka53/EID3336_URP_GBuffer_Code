import os, json

EID = 3858
TEX = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215847_PS215848_Batch/TextureDatabase'
RID = int(os.environ.get('AGENTIC_SAVE_RID', '219311'))
OUT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/save_215847_%d.json' % RID


def rid(x):
    try:
        return int(x)
    except Exception:
        return 0


def work(c):
    c.SetFrameEvent(EID, False)
    texdesc = {rid(t.resourceId): t for t in c.GetTextures()}
    os.makedirs(TEX, exist_ok=True)
    t = texdesc.get(RID)
    if t is None:
        rec = {'rid': RID, 'ok': False, 'error': 'missing'}
        open(OUT, 'w', encoding='utf8').write(json.dumps(rec, indent=2))
        return rec
    path = os.path.join(TEX, 'rid%d.dds' % RID)
    cfg = rd.TextureSave()
    cfg.resourceId = t.resourceId
    cfg.destType = rd.FileType.DDS
    cfg.mip = -1
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
    }
    open(OUT, 'w', encoding='utf8').write(json.dumps(rec, indent=2))
    return rec


print(json.dumps(ctx.replay(work), default=str))
