import os, json, struct, hashlib

EID = 3545
OUT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215523.json'


def rid(x):
    try:
        return int(x)
    except Exception:
        return 0


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
    vs = rid(s.GetShader(rd.ShaderStage.Vertex))
    ps = rid(s.GetShader(rd.ShaderStage.Pixel))
    rs = s.GetRasterState()
    ds = s.GetDepthTestState()
    st = s.GetStencilFaces()
    blends = s.GetColorBlends()
    front = st[0] if st else None
    inputs = []
    for x in s.GetVertexInputs():
        inputs.append({
            'name': x.name,
            'slot': int(x.vertexBuffer),
            'offset': int(x.byteOffset),
            'fmt': x.format.Name(),
            'perInstance': bool(x.perInstance),
        })
    cbs = {}
    mats = []
    flags = []
    for stage, key in [(rd.ShaderStage.Vertex, 'VS'), (rd.ShaderStage.Pixel, 'PS')]:
        refl = s.GetShaderReflection(stage)
        arr = []
        for i, u in enumerate(s.GetConstantBlocks(stage)):
            d = u.descriptor
            name = refl.constantBlocks[i].name if i < len(refl.constantBlocks) else 'cb%d' % i
            sz = int(d.byteSize)
            rec = {
                'i': i,
                'name': name,
                'bind': int(u.access.byteOffset),
                'rid': rid(d.resource),
                'off': int(d.byteOffset),
                'size': sz,
            }
            if 256 <= sz <= 65536 and (name in ('uniforms28', 'uniforms23', 'uniforms30', 'uniforms24', 'uniforms20', 'uniforms27') or sz % 256 == 0):
                n = int(a.numInstances)
                need = min(sz, n * 256)
                raw = bytes(c.GetBufferData(d.resource, d.byteOffset, need))
                rec['sha16'] = hashlib.sha256(raw).hexdigest()[:16]
                rec['sliced'] = need
                if key == 'VS' and n > 0 and len(raw) >= 64:
                    for ii in range(min(n, need // 256)):
                        f = struct.unpack_from('<16f', raw, ii * 256)
                        flags.append(struct.unpack_from('<I', raw, ii * 256 + 76)[0])
                        mats.append((round(f[12], 3), round(f[13], 3), round(f[14], 3)))
            elif sz <= 4096:
                raw = bytes(c.GetBufferData(d.resource, d.byteOffset, sz))
                rec['sha16'] = hashlib.sha256(raw).hexdigest()[:16]
                if 16 <= sz <= 1024:
                    rec['f4'] = [round(x, 5) for x in struct.unpack_from('<%df' % min(sz // 4, 32), raw, 0)]
            else:
                rec['sha16'] = 'skipped-large-%d' % sz
            arr.append(rec)
        cbs[key] = arr
    texdesc = {rid(t.resourceId): t for t in c.GetTextures()}
    textures = []
    for stage, key in [(rd.ShaderStage.Pixel, 'PS'), (rd.ShaderStage.Vertex, 'VS')]:
        refl = s.GetShaderReflection(stage)
        rr = list(refl.readOnlyResources)
        for i, u in enumerate(s.GetReadOnlyResources(stage)):
            d = u.descriptor
            r = rid(d.resource)
            if r == 0:
                continue
            name = rr[i].name if i < len(rr) else 'tex%d' % i
            td = texdesc.get(r)
            textures.append({
                'stage': key,
                'name': name,
                'bind': int(u.access.byteOffset),
                'rid': r,
                'fmt': td.format.Name() if td else '',
                'w': int(td.width) if td else 0,
                'h': int(td.height) if td else 0,
            })
    rws = []
    for stage, key in [(rd.ShaderStage.Vertex, 'VS'), (rd.ShaderStage.Pixel, 'PS')]:
        refl = s.GetShaderReflection(stage)
        rw = list(getattr(refl, 'readWriteResources', []))
        for i, u in enumerate(s.GetReadWriteResources(stage)):
            d = u.descriptor
            r = rid(d.resource)
            name = rw[i].name if i < len(rw) else 'rw%d' % i
            rws.append({'stage': key, 'name': name, 'rid': r, 'size': int(getattr(d, 'byteSize', 0) or 0)})
    local = None
    for rec in cbs.get('PS', []):
        if 200 <= rec['size'] <= 1024 and rec['name'].startswith('uniforms'):
            local = rec
            break
    out = {
        'eid': EID,
        'vs': vs,
        'ps': ps,
        'inst': int(a.numInstances) if a else None,
        'idx': int(a.numIndices) if a else None,
        'cull': str(rs.cullMode),
        'zw': bool(ds.depthWrites),
        'zfn': str(ds.depthFunction),
        'sref': int(front.reference) if front else None,
        'sfn': str(front.function) if front else None,
        'writeMask': [int(b.writeMask) for b in blends] if blends else [],
        'blend0': bool(blends[0].enabled) if blends else None,
        'inputs': inputs,
        'cbs': cbs,
        'textures': textures,
        'rws': rws,
        'flags': flags[:8],
        'flagSet': sorted(set(flags)),
        'mats': mats[:8],
        'matCount': len(mats),
        'localPS': local,
    }
    open(OUT, 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))
    return {
        'eid': EID, 'vs': vs, 'ps': ps, 'inst': out['inst'], 'idx': out['idx'],
        'cull': out['cull'], 'zw': out['zw'], 'zfn': out['zfn'], 'sref': out['sref'],
        'writeMask': out['writeMask'], 'blend0': out['blend0'],
        'nInputs': len(inputs), 'inputNames': [x['name'] for x in inputs],
        'VScbs': [(x['name'], x['size']) for x in cbs.get('VS', [])],
        'PScbs': [(x['name'], x['size']) for x in cbs.get('PS', [])],
        'PStex': [(x['name'], x['bind'], x['rid'], x['fmt'], x['w']) for x in textures if x['stage'] == 'PS'],
        'VStex': [(x['name'], x['bind'], x['rid'], x['fmt'], x['w']) for x in textures if x['stage'] == 'VS'],
        'rws': rws, 'flagSet': out['flagSet'], 'mats': mats[:4],
        'localPS': local, 'out': OUT,
    }


print(json.dumps(ctx.replay(work), default=str))
