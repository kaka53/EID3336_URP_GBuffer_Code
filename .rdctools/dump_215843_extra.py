import os, json, struct

def rid(x):
    try:
        return int(x)
    except Exception:
        return 0

def work(c):
    c.SetFrameEvent(3844, False)
    s = c.GetPipelineState()
    out = {}
    for stage, key in [(rd.ShaderStage.Vertex, 'VS'), (rd.ShaderStage.Pixel, 'PS')]:
        refl = s.GetShaderReflection(stage)
        for i, u in enumerate(s.GetConstantBlocks(stage)):
            d = u.descriptor
            name = refl.constantBlocks[i].name if i < len(refl.constantBlocks) else 'cb%d' % i
            sz = int(d.byteSize)
            if name in ('uniforms19', 'uniforms23') and sz >= 440:
                raw = bytes(c.GetBufferData(d.resource, int(d.byteOffset) + 416, 24))
                out['%s_%s_mip416' % (key, name)] = struct.unpack_from('<f', raw, 0)[0]
                out['%s_%s_y436' % (key, name)] = struct.unpack_from('<f', raw, 20)[0]
            if name == 'uniforms32' and sz >= 16:
                raw = bytes(c.GetBufferData(d.resource, int(d.byteOffset), 16))
                out['PS_uniforms32_child0'] = list(struct.unpack_from('<4f', raw, 0))
            if name == 'uniforms17' and sz >= 720:
                raw = bytes(c.GetBufferData(d.resource, int(d.byteOffset) + 704, 16))
                out['PS_uniforms17_child11'] = list(struct.unpack_from('<4f', raw, 0))
    texdesc = {rid(t.resourceId): t for t in c.GetTextures()}
    out['tex'] = []
    for i, u in enumerate(s.GetReadOnlyResources(rd.ShaderStage.Pixel)):
        d = u.descriptor
        r = rid(d.resource)
        td = texdesc.get(r)
        out['tex'].append({
            'n': s.GetShaderReflection(rd.ShaderStage.Pixel).readOnlyResources[i].name,
            'rid': r,
            'fmt': td.format.Name() if td else '',
            'w': int(td.width) if td else 0,
            'h': int(td.height) if td else 0,
            'mips': int(td.mips) if td else 0,
        })
    return out

ctx.replay(work)
