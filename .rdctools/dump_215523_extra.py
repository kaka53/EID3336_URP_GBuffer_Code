import json, struct

EID = 3545
OUT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215523_extra.json'


def rid(x):
    try:
        return int(x)
    except Exception:
        return 0


def children_of(cb):
    out = []
    vars_ = list(getattr(cb, 'variables', []) or [])
    if not vars_:
        return out
    # some CBs wrap a struct as the only child
    root = vars_
    if len(vars_) == 1 and getattr(vars_[0].type, 'members', None):
        root = list(vars_[0].type.members)
        base_name = vars_[0].name
    else:
        base_name = cb.name

    def walk(members, prefix, base_off):
        for m in members:
            t = m.type
            off = base_off + int(m.byteOffset)
            name = prefix + m.name
            rows = int(getattr(t, 'rows', 0) or 0)
            cols = int(getattr(t, 'columns', 0) or 0)
            members2 = list(getattr(t, 'members', []) or [])
            array = list(getattr(t, 'array', []) or [])
            if members2:
                walk(members2, name + '.', off)
            else:
                out.append({
                    'name': name,
                    'off': off,
                    'rows': rows,
                    'cols': cols,
                    'array': [int(x) for x in array],
                    'comp': str(getattr(t, 'name', '') or getattr(t, 'type', '')),
                })
    walk(root, '', 0)
    return out


def work(c):
    c.SetFrameEvent(EID, False)
    s = c.GetPipelineState()
    a = None

    def walk(xs):
        nonlocal a
        for x in xs:
            if x.eventId == EID:
                a = x
            walk(x.children)
    walk(c.GetRootActions())

    n = int(a.numInstances)
    vs_refl = s.GetShaderReflection(rd.ShaderStage.Vertex)
    ps_refl = s.GetShaderReflection(rd.ShaderStage.Pixel)

    inst_raw = None
    local_raw = None
    meta_raw = None
    mip_raw = None
    inst_name = None
    local_cb = None
    ps_cbs = []
    vs_cbs = []

    for i, u in enumerate(s.GetConstantBlocks(rd.ShaderStage.Vertex)):
        d = u.descriptor
        name = vs_refl.constantBlocks[i].name if i < len(vs_refl.constantBlocks) else 'cb%d' % i
        sz = int(d.byteSize)
        vs_cbs.append({'name': name, 'size': sz, 'off': int(d.byteOffset), 'rid': rid(d.resource)})
        if name == 'uniforms28':
            inst_raw = bytes(c.GetBufferData(d.resource, d.byteOffset, n * 256))
            inst_name = name

    for i, u in enumerate(s.GetConstantBlocks(rd.ShaderStage.Pixel)):
        d = u.descriptor
        cb = ps_refl.constantBlocks[i]
        name = cb.name
        sz = int(d.byteSize)
        rec = {'name': name, 'size': sz, 'off': int(d.byteOffset), 'rid': rid(d.resource), 'bind': int(u.access.byteOffset)}
        ps_cbs.append(rec)
        if name == 'uniforms39':
            local_raw = bytes(c.GetBufferData(d.resource, d.byteOffset, sz))
            local_cb = cb
        if name == 'uniforms41':
            meta_raw = bytes(c.GetBufferData(d.resource, d.byteOffset, sz))
        if name == 'uniforms20':
            mip_raw = bytes(c.GetBufferData(d.resource, d.byteOffset, min(sz, 512)))

    flags = []
    mats = []
    for ii in range(n):
        f = struct.unpack_from('<16f', inst_raw, ii * 256)
        flags.append(struct.unpack_from('<I', inst_raw, ii * 256 + 76)[0])
        mats.append([round(f[12], 4), round(f[13], 4), round(f[14], 4)])

    local_f4 = [round(x, 6) for x in struct.unpack('<%df' % (len(local_raw)//4), local_raw)]
    kids = children_of(local_cb) if local_cb is not None else []
    # attach values
    for k in kids:
        off = k['off']
        cols = max(int(k['cols'] or 1), 1)
        rows = max(int(k['rows'] or 1), 1)
        ncomp = cols * rows
        if off + ncomp * 4 <= len(local_raw):
            vals = struct.unpack_from('<%df' % ncomp, local_raw, off)
            k['val'] = [round(v, 6) for v in vals]

    mip = None
    if mip_raw and len(mip_raw) >= 420:
        mip = struct.unpack_from('<f', mip_raw, 416)[0]

    meta = None
    if meta_raw:
        meta = [round(x, 6) for x in struct.unpack_from('<%df' % (len(meta_raw)//4), meta_raw, 0)]

    ib = s.GetIBuffer()
    vbs = s.GetVBuffers()
    inputs = []
    for x in s.GetVertexInputs():
        inputs.append({
            'name': x.name, 'slot': int(x.vertexBuffer), 'offset': int(x.byteOffset),
            'fmt': x.format.Name(), 'stride': int(vbs[x.vertexBuffer].byteStride) if x.vertexBuffer < len(vbs) else None,
            'vbrid': rid(vbs[x.vertexBuffer].resourceId) if x.vertexBuffer < len(vbs) else None,
        })

    out = {
        'n': n,
        'idx': int(a.numIndices),
        'ibStride': int(ib.byteStride),
        'ibRid': rid(ib.resourceId),
        'ibOff': int(ib.byteOffset),
        'vs_cbs': vs_cbs,
        'ps_cbs': ps_cbs,
        'flags': flags,
        'flagSet': sorted(set(flags)),
        'mats': mats,
        'localSize': len(local_raw) if local_raw else 0,
        'localSha': __import__('hashlib').sha256(local_raw).hexdigest()[:16] if local_raw else None,
        'nvars': len(kids),
        'kids': kids,
        'local_f4_head': local_f4[:48],
        'mip416': mip,
        'meta': meta,
        'inputs': inputs,
    }
    open(OUT, 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))
    return {
        'n': n, 'idx': out['idx'], 'ibStride': out['ibStride'],
        'flagSet': out['flagSet'], 'nFlags32': sum(1 for f in flags if f & 32),
        'matsHead': mats[:6], 'matsTail': mats[-3:],
        'localSize': out['localSize'], 'nvars': out['nvars'],
        'mip416': mip, 'meta': meta,
        'kidNames': [(k['name'], k['off'], k.get('val')) for k in kids[:40]],
        'inputs': inputs,
        'out': OUT,
    }


print(json.dumps(ctx.replay(work), default=str))
