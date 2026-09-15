import os, json, struct, hashlib

EIDS = [3439, 3443]
OUT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215517_extra.json'


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
    out = {'eids': EIDS, 'rows': []}
    for eid in EIDS:
        a = actions[eid]
        c.SetFrameEvent(eid, False)
        s = c.GetPipelineState()
        vs = rid(s.GetShader(rd.ShaderStage.Vertex))
        ps = rid(s.GetShader(rd.ShaderStage.Pixel))
        rs = s.GetRasterState()
        ds = s.GetDepthTestState()
        st = s.GetStencilFaces()
        front = st[0] if st else None
        rec = {
            'eid': eid,
            'vs': vs,
            'ps': ps,
            'inst': int(a.numInstances),
            'cull': str(rs.cullMode),
            'frontCCW': bool(rs.frontCCW),
            'zw': bool(ds.depthWrites),
            'zfn': str(ds.depthFunction),
            'sref': int(front.reference) if front else None,
            'sfn': str(front.function) if front else None,
            'swm': int(front.writeMask) if front else None,
            'layout': [],
            'flags': [],
            'mats': [],
            'slices': {},
            'pstex': [],
        }
        for x in s.GetVertexInputs():
            rec['layout'].append((x.name, x.format.Name(), int(x.vertexBuffer), int(x.byteOffset), int(x.format.compCount)))
        for stage, key in [(rd.ShaderStage.Vertex, 'VS'), (rd.ShaderStage.Pixel, 'PS')]:
            refl = s.GetShaderReflection(stage)
            for i, u in enumerate(s.GetConstantBlocks(stage)):
                d = u.descriptor
                name = refl.constantBlocks[i].name if i < len(refl.constantBlocks) else 'cb%d' % i
                sz = int(d.byteSize)
                if ((key == 'VS' and name == 'uniforms28') or (key == 'PS' and name == 'uniforms23')) and sz >= 256:
                    n = int(a.numInstances)
                    raw = bytes(c.GetBufferData(d.resource, int(d.byteOffset), n * 256))
                    if key == 'VS':
                        rec['flags'] = [struct.unpack_from('<I', raw, ii * 256 + 76)[0] for ii in range(n)]
                        rec['mats'] = [floats(raw[ii * 256 + 48:ii * 256 + 60]) for ii in range(n)]
                    rec['slices']['%s_%s' % (key, name)] = {'size': sz, 'sliced': n * 256, 'sha16': hashlib.sha256(raw).hexdigest()[:16]}
                elif name in ('uniforms38', 'uniforms40') or (name == 'uniforms20' and sz == 3200) or (name == 'uniforms25' and sz == 3200):
                    raw = bytes(c.GetBufferData(d.resource, int(d.byteOffset), min(sz, 3200)))
                    sl = {'size': sz, 'rid': rid(d.resource), 'sha16': hashlib.sha256(raw).hexdigest()[:16]}
                    if name == 'uniforms38':
                        sl['floats'] = floats(raw)
                        vars = []
                        cb = refl.constantBlocks[i]
                        for ch in cb.variables:
                            vars.append({'n': ch.name, 'off': int(ch.byteOffset), 'rows': int(ch.type.rows), 'cols': int(ch.type.columns), 'elems': int(ch.type.elements)})
                        sl['vars'] = vars
                    elif name == 'uniforms40':
                        sl['floats'] = floats(raw)
                    elif sz == 3200:
                        sl['mip416'] = floats(raw[416:420])[0]
                    rec['slices']['%s_%s' % (key, name)] = sl
            if key == 'PS':
                for i, u in enumerate(s.GetReadOnlyResources(stage)):
                    d = u.descriptor
                    name = refl.readOnlyResources[i].name if i < len(refl.readOnlyResources) else 'res%d' % i
                    r = rid(d.resource)
                    td = texdesc.get(r)
                    rec['pstex'].append({
                        'n': name, 'rid': r, 'bind': int(u.access.byteOffset),
                        'fmt': td.format.Name() if td else '', 'w': int(td.width) if td else 0,
                        'h': int(td.height) if td else 0, 'mips': int(td.mips) if td else 0,
                    })
        out['rows'].append(rec)
    open(OUT, 'w', encoding='utf8').write(json.dumps(out, indent=2))
    return {'wrote': OUT, 'eids': EIDS, 'inst': [r['inst'] for r in out['rows']], 'cull': [r['cull'] for r in out['rows']], 'sref': [r['sref'] for r in out['rows']], 'flags': [r['flags'] for r in out['rows']], 'u38sha': [r['slices'].get('PS_uniforms38', {}).get('sha16') for r in out['rows']], 'u38nvars': [len(r['slices'].get('PS_uniforms38', {}).get('vars') or []) for r in out['rows']], 'mip': [r['slices'].get('PS_uniforms20', {}).get('mip416') for r in out['rows']]}


print(json.dumps(ctx.replay(work), default=str))
