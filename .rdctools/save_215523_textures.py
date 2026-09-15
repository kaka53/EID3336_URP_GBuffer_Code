import os, json

EID = 3545
TEX = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215523_PS215524_Batch/TextureDatabase'
RIDS = [277115, 272330, 277083, 196313]
OUT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/save_215523_textures.json'


def rid(x):
    try:
        return int(x)
    except Exception:
        return 0


def work(c):
    c.SetFrameEvent(EID, False)
    texdesc = {rid(t.resourceId): t for t in c.GetTextures()}
    os.makedirs(TEX, exist_ok=True)
    results = []
    for r in RIDS:
        t = texdesc.get(r)
        if t is None:
            results.append({'rid': r, 'ok': False, 'error': 'missing'})
            continue
        path = os.path.join(TEX, 'rid%d.dds' % r)
        cfg = rd.TextureSave()
        cfg.resourceId = t.resourceId
        cfg.destType = rd.FileType.DDS
        cfg.mip = -1
        ok = bool(c.SaveTexture(cfg, path))
        results.append({
            'rid': r,
            'ok': ok,
            'path': path,
            'exists': os.path.exists(path),
            'bytes': os.path.getsize(path) if os.path.exists(path) else 0,
            'format': t.format.Name(),
            'w': int(t.width),
            'h': int(t.height),
        })
    open(OUT, 'w', encoding='utf8').write(json.dumps(results, indent=2))
    return results


print(json.dumps(ctx.replay(work), default=str))
