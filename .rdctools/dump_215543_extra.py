import os, json, struct, hashlib

EIDS = [3694, 3698]
OUT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215543_extra.json'


def rid(x):
    try:
        return int(x)
    except Exception:
        return 0


def floats(raw, n=None):
    n = (len(raw) // 4) if n is None else n
    return list(struct.unpack_from('<%df' % n, raw, 0))


def work(c):
    actions = {}

    def walk(xs):
        for a in xs:
            if a.eventId in EIDS:
                actions[a.eventId] = a
            walk(a.children)

    walk(c.GetRootActions())
    texdesc = {rid(t.resourceId): t for t in c.GetTextures()}
    out = {}
    for eid in EIDS:
        a = actions[eid]
        c.SetFrameEvent(eid, False)
        s = c.GetPipelineState()
        rs = s.GetRasterState()
        ds = s.GetDepthTestState()
        st = s.GetStencilFaces()
        blends = s.GetColorBlends()
        front = st[0] if st else None
        rec = {
            'eid': eid,
            'vs': rid(s.GetShader(rd.ShaderStage.Vertex)),
            'ps': rid(s.GetShader(rd.ShaderStage.Pixel)),
            'inst': int(a.numInstances),
            'cull': str(rs.cullMode),
            'frontCCW': bool(rs.frontCCW),
            'zw': bool(ds.depthWrites),
            'zfn': str(ds.depthFunction),
            'sref': int(front.reference) if front else None,
            'sfn': str(front.function) if front else None,
            'scm': int(front.compareMask) if front else None,
            'swm': int(front.writeMask) if front else None,
            'writeMask': [int(b.writeMask) for b in blends] if blends else [],
            'layout': [],
            'slices': {},
            'pstex': [],
            'vstex': [],
            'flags': [],
            'mats': [],
            'rw': [],
        }
        for x in s.GetVertexInputs():
            rec['layout'].append((x.name, x.format.Name(), int(x.vertexBuffer), int(x.byteOffset), int(x.format.compCount)))
        for stage, key in [(rd.ShaderStage.Vertex, 'VS'), (rd.ShaderStage.Pixel, 'PS')]:
            refl = s.GetShaderReflection(stage)
            for i, u in enumerate(s.GetConstantBlocks(stage)):
                d = u.descriptor
                name = refl.constantBlocks[i].name if i < len(refl.constantBlocks) else 'cb%d' % i
                sz = int(d.byteSize)
                if ((key == 'VS' and name == 'uniforms27') or (key == 'PS' and name == 'uniforms22')) and sz >= 256:
                    n = int(a.numInstances)
                    raw = bytes(c.GetBufferData(d.resource, int(d.byteOffset), n * 256))
                    if key == 'VS':
                        rec['flags'] = [struct.unpack_from('<I', raw, ii * 256 + 76)[0] for ii in range(n)]
                        rec['mats'] = [floats(raw[ii * 256 + 48:ii * 256 + 60]) for ii in range(n)]
                    rec['slices']['%s_%s' % (key, name)] = {'size': sz, 'sliced': n * 256, 'sha16': hashlib.sha256(raw).hexdigest()[:16]}
                elif name in ('uniforms30',) or (name == 'uniforms19' and sz == 3200) or (name == 'uniforms32' and sz <= 4096):
                    raw = bytes(c.GetBufferData(d.resource, int(d.byteOffset), min(sz, 3200)))
                    sl = {'size': sz, 'rid': rid(d.resource), 'sha16': hashlib.sha256(raw).hexdigest()[:16]}
                    if name == 'uniforms30':
                        sl['floats'] = floats(raw)
                        vars = []
                        cb = refl.constantBlocks[i]
                        for ch in cb.variables:
                            vars.append({'n': ch.name, 'off': int(ch.byteOffset), 'rows': int(ch.type.rows), 'cols': int(ch.type.columns), 'elems': int(ch.type.elements)})
                        sl['vars'] = vars
                    elif sz == 3200:
                        sl['mip416'] = floats(raw[416:420])[0]
                    rec['slices']['%s_%s' % (key, name)] = sl
            for i, u in enumerate(s.GetReadOnlyResources(stage)):
                d = u.descriptor
                name = refl.readOnlyResources[i].name if i < len(refl.readOnlyResources) else 'res%d' % i
                r = rid(d.resource)
                td = texdesc.get(r)
                rec['pstex' if key == 'PS' else 'vstex'].append({
                    'n': name, 'rid': r, 'bind': int(u.access.byteOffset),
                    'fmt': td.format.Name() if td else '', 'w': int(td.width) if td else 0,
                    'h': int(td.height) if td else 0, 'mips': int(td.mips) if td else 0,
                })
            if key == 'VS':
                for i, u in enumerate(s.GetReadWriteResources(stage)):
                    d = u.descriptor
                    name = refl.readWriteResources[i].name if i < len(refl.readWriteResources) else 'rw%d' % i
                    rec['rw'].append({'n': name, 'rid': rid(d.resource), 'sz': int(d.byteSize)})
        out[str(eid)] = rec
    open(OUT, 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))
    summary = {
        'eids': EIDS,
        'vs': [out[str(e)]['vs'] for e in EIDS],
        'ps': [out[str(e)]['ps'] for e in EIDS],
        'inst': [out[str(e)]['inst'] for e in EIDS],
        'cull': [out[str(e)]['cull'] for e in EIDS],
        'sref': [out[str(e)]['sref'] for e in EIDS],
        'sfn': [out[str(e)]['sfn'] for e in EIDS],
        'swm': [out[str(e)]['swm'] for e in EIDS],
        'zw': [out[str(e)]['zw'] for e in EIDS],
        'zfn': [out[str(e)]['zfn'] for e in EIDS],
        'frontCCW': [out[str(e)]['frontCCW'] for e in EIDS],
        'writeMask': [out[str(e)]['writeMask'] for e in EIDS],
        'flags': [out[str(e)]['flags'] for e in EIDS],
        'mats': [out[str(e)]['mats'] for e in EIDS],
        'layout': [out[str(e)]['layout'] for e in EIDS],
        'rw': [out[str(e)]['rw'] for e in EIDS],
        'u30sha': [out[str(e)]['slices'].get('PS_uniforms30', {}).get('sha16') for e in EIDS],
        'u30nvars': [len(out[str(e)]['slices'].get('PS_uniforms30', {}).get('vars', [])) for e in EIDS],
        'u30size': [out[str(e)]['slices'].get('PS_uniforms30', {}).get('size') for e in EIDS],
        'mip': [out[str(e)]['slices'].get('PS_uniforms19', {}).get('mip416') for e in EIDS],
        'pstex': [[(t['n'], t['rid'], t['fmt'], t['w'], t.get('bind')) for t in out[str(e)]['pstex']] for e in EIDS],
        'vstex': [[(t['n'], t['rid'], t['fmt'], t['w'], t.get('bind')) for t in out[str(e)]['vstex']] for e in EIDS],
    }
    return summary


print(json.dumps(ctx.replay(work), default=str))
