import json, struct

EID = 3545
OUT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215523_globals.json'


def rid(x):
    try:
        return int(x)
    except Exception:
        return 0


def work(c):
    c.SetFrameEvent(EID, False)
    s = c.GetPipelineState()
    ps = s.GetShaderReflection(rd.ShaderStage.Pixel)
    raw = None
    rec = None
    for i, u in enumerate(s.GetConstantBlocks(rd.ShaderStage.Pixel)):
        d = u.descriptor
        name = ps.constantBlocks[i].name if i < len(ps.constantBlocks) else 'cb%d' % i
        if name == 'uniforms20':
            raw = bytes(c.GetBufferData(d.resource, d.byteOffset, int(d.byteSize)))
            rec = {'name': name, 'size': int(d.byteSize), 'off': int(d.byteOffset), 'rid': rid(d.resource)}
            break
    def f4(off):
        return [round(x, 6) for x in struct.unpack_from('<4f', raw, off)]
    def f1(off):
        return round(struct.unpack_from('<f', raw, off)[0], 6)
    out = {
        'rec': rec,
        'child0': f4(0),
        'child4w': f1(64 + 12),
        'mip416': f1(416),
        'child17_420': f1(420),
        'child18_424': f1(424),
        'child20': f4(432),
        'child20y': f1(436),
        'child75_1648': f4(1648),
        'child77_1680': f4(1680),
        'size': len(raw),
    }
    open(OUT, 'w', encoding='utf8').write(json.dumps(out, indent=2))
    return out


print(json.dumps(ctx.replay(work), default=str))
