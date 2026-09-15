import os, json, struct, hashlib

EIDS = [3755]
OUT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_229351.json'


def rid(x):
    try:
        return int(x)
    except Exception:
        return 0


def floats(raw, n=None):
    n = (len(raw) // 4) if n is None else n
    return [round(v, 6) for v in struct.unpack_from('<%df' % n, raw, 0)]


def children_of(cb):
    out = []
    vars_ = list(getattr(cb, 'variables', []) or [])
    if not vars_:
        return out
    root = vars_
    if len(vars_) == 1 and getattr(vars_[0].type, 'members', None):
        root = list(vars_[0].type.members)

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


def is_instance_cb(key, name, sz, n):
    if n <= 0 or sz < 96:
        return None
    if key == 'VS' and name == 'uniforms27':
        return 96 if sz >= 65536 else (256 if sz >= n * 256 else 96)
    if key == 'PS' and name == 'uniforms22' and sz >= 65536:
        return 96
    for stride in (96, 256):
        if sz >= n * stride and (sz == n * stride or sz >= 65536 or (sz % stride == 0 and sz >= 10000)):
            return stride
    return None


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
        n = int(a.numInstances)
        rec = {
            'eid': eid,
            'vs': rid(s.GetShader(rd.ShaderStage.Vertex)),
            'ps': rid(s.GetShader(rd.ShaderStage.Pixel)),
            'inst': n,
            'idx': int(a.numIndices),
            'cull': str(rs.cullMode),
            'frontCCW': bool(rs.frontCCW),
            'zw': bool(ds.depthWrites),
            'zfn': str(ds.depthFunction),
            'sref': int(front.reference) if front else None,
            'sfn': str(front.function) if front else None,
            'scm': int(front.compareMask) if front else None,
            'swm': int(front.writeMask) if front else None,
            'writeMask': [int(b.writeMask) for b in blends] if blends else [],
            'blend0': bool(blends[0].enabled) if blends else None,
            'layout': [],
            'ib': None,
            'vbs': [],
            'cbs': [],
            'slices': {},
            'pstex': [],
            'vstex': [],
            'rw': [],
            'flags': [],
            'mats': [],
            'localKids': [],
        }
        ib = s.GetIBuffer()
        rec['ib'] = {'rid': rid(ib.resourceId), 'byteOffset': int(ib.byteOffset), 'byteStride': int(ib.byteStride)}
        for vb in s.GetVBuffers():
            rec['vbs'].append({'rid': rid(vb.resourceId), 'byteOffset': int(vb.byteOffset), 'byteStride': int(vb.byteStride)})
        for x in s.GetVertexInputs():
            rec['layout'].append((x.name, x.format.Name(), int(x.vertexBuffer), int(x.byteOffset), int(x.format.compCount), bool(x.perInstance)))
        for stage, key in [(rd.ShaderStage.Vertex, 'VS'), (rd.ShaderStage.Pixel, 'PS')]:
            refl = s.GetShaderReflection(stage)
            for i, u in enumerate(s.GetConstantBlocks(stage)):
                d = u.descriptor
                cb = refl.constantBlocks[i] if i < len(refl.constantBlocks) else None
                name = cb.name if cb is not None else 'cb%d' % i
                sz = int(d.byteSize)
                rec['cbs'].append({'stage': key, 'i': i, 'n': name, 'sz': sz, 'rid': rid(d.resource), 'off': int(d.byteOffset), 'bind': int(u.access.byteOffset)})
                dump_full = (sz <= 4096 and sz > 0)
                mip = (sz == 3200)
                stride = is_instance_cb(key, name, sz, n)
                looks_inst = stride is not None
                if looks_inst:
                    rec['slices']['%s_%s_guess_stride' % (key, name)] = stride
                    raw = bytes(c.GetBufferData(d.resource, int(d.byteOffset), max(n * stride, 256)))
                    rec['slices']['%s_%s' % (key, name)] = {
                        'size': sz,
                        'rid': rid(d.resource),
                        'sliced': len(raw),
                        'stride': stride,
                        'sha16': hashlib.sha256(raw).hexdigest()[:16],
                        'head16': floats(raw[:64]),
                        'head80': floats(raw[:min(len(raw), 320)]),
                    }
                    if key == 'VS':
                        rec['flags'] = [struct.unpack_from('<I', raw, ii * stride + 76)[0] for ii in range(n)]
                        rec['mats'] = [floats(raw[ii * stride + 48:ii * stride + 60]) for ii in range(n)]
                        rec['mats96'] = [floats(raw[ii * stride:ii * stride + 16]) for ii in range(min(n, 3))]
                        rec['mats256'] = [floats(raw[48:60])]
                if dump_full and not looks_inst:
                    raw = bytes(c.GetBufferData(d.resource, int(d.byteOffset), sz))
                    sl = {'size': sz, 'rid': rid(d.resource), 'sha16': hashlib.sha256(raw).hexdigest()[:16], 'floats': floats(raw)}
                    if cb is not None:
                        kids = children_of(cb)
                        for k in kids:
                            off = k['off']
                            cols = max(int(k['cols'] or 1), 1)
                            rows = max(int(k['rows'] or 1), 1)
                            ncomp = cols * rows
                            if off + ncomp * 4 <= len(raw):
                                vals = struct.unpack_from('<%df' % ncomp, raw, off)
                                k['val'] = [round(v, 6) for v in vals]
                        sl['nvars'] = len(kids)
                        sl['vars'] = kids
                        if key == 'PS' and 64 <= sz <= 2048:
                            rec['localKids'] = kids
                    rec['slices']['%s_%s' % (key, name)] = sl
                elif mip and not looks_inst:
                    raw = bytes(c.GetBufferData(d.resource, int(d.byteOffset) + 416, 4))
                    rec['slices']['%s_%s_mip416' % (key, name)] = floats(raw)[0]
                    rawy = bytes(c.GetBufferData(d.resource, int(d.byteOffset) + 436, 4))
                    rec['slices']['%s_%s_y436' % (key, name)] = floats(rawy)[0]
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
                    rec['rw'].append({'n': name, 'rid': rid(d.resource), 'sz': int(d.byteSize), 'off': int(d.byteOffset)})
        out[str(eid)] = rec
    open(OUT, 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))
    e = out['3755']
    summary = {
        'eids': EIDS,
        'vs': e['vs'],
        'ps': e['ps'],
        'inst': e['inst'],
        'idx': e['idx'],
        'cull': e['cull'],
        'sref': e['sref'],
        'zw': e['zw'],
        'zfn': e['zfn'],
        'writeMask': e['writeMask'],
        'blend0': e['blend0'],
        'ib': e['ib'],
        'vbs': e['vbs'],
        'layout': e['layout'],
        'flags': e['flags'],
        'mats': e['mats'],
        'mats96': e.get('mats96'),
        'mats256': e.get('mats256'),
        'cbs': e['cbs'],
        'slices': {k: {kk: vv for kk, vv in v.items() if kk != 'floats' and kk != 'vars'} if isinstance(v, dict) else v for k, v in e['slices'].items()},
        'localKidsHead': e['localKids'][:80],
        'localKidsN': len(e['localKids']),
        'pstex': [(t['n'], t['rid'], t['fmt'], t['w'], t.get('bind')) for t in e['pstex']],
        'vstex': [(t['n'], t['rid'], t['fmt'], t['w'], t.get('bind')) for t in e['vstex']],
        'rw': e['rw'],
        'out': OUT,
    }
    return summary


print(json.dumps(ctx.replay(work), default=str))
