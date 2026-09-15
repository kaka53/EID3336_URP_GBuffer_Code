import os, json

RID = 257548
OUT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215527_cube.json'

def rid(x):
    try:
        return int(x)
    except Exception:
        return 0

def work(c):
    c.SetFrameEvent(3561, False)
    s = c.GetPipelineState()
    texs = []
    for t in c.GetTextures():
        r = rid(t.resourceId)
        if r in (257548, 269135, 279845, 166, 175):
            rec = {
                'rid': r,
                'name': getattr(t, 'name', ''),
                'fmt': t.format.Name(),
                'w': int(t.width), 'h': int(t.height), 'd': int(t.depth),
                'mips': int(t.mips),
                'arraysize': int(getattr(t, 'arraysize', 0) or getattr(t, 'arraySize', 0) or 0),
                'cubemap': bool(getattr(t, 'cubemap', False)),
                'msSamp': int(getattr(t, 'msSamp', 0) or 0),
                'type': str(getattr(t, 'type', '')),
                'dimension': str(getattr(t, 'dimension', '')),
            }
            for attr in ('cubemap', 'arraysize', 'arraySize', 'depth', 'type', 'dimension', 'byteSize', 'creationFlags'):
                if hasattr(t, attr):
                    rec['a_'+attr] = str(getattr(t, attr))
            texs.append(rec)
    # also list RO resources with dimension
    refl = s.GetShaderReflection(rd.ShaderStage.Pixel)
    ros = []
    for i, u in enumerate(s.GetReadOnlyResources(rd.ShaderStage.Pixel)):
        d = u.descriptor
        r = rid(d.resource)
        name = refl.readOnlyResources[i].name if i < len(refl.readOnlyResources) else 'res'
        ros.append({
            'name': name, 'rid': r, 'bind': int(u.access.byteOffset),
            'type': str(getattr(d, 'type', '')),
            'dim': str(getattr(d, 'textureType', getattr(d, 'resType', ''))),
        })
    open(OUT, 'w', encoding='utf8').write(json.dumps({'texs': texs, 'ros': ros}, indent=2, default=str))
    return {'texs': texs, 'ros': ros}

print(json.dumps(ctx.replay(work), default=str))
