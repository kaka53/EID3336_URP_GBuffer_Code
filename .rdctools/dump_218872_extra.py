import os, json, struct, hashlib

EIDS = [3589, 3593]
OUT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_218872_extra.json'


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
        n = int(a.numInstances)
        rec = {
            'eid': eid,
            'vs': rid(s.GetShader(rd.ShaderStage.Vertex)),
            'ps': rid(s.GetShader(rd.ShaderStage.Pixel)),
            'inst': n,
            'idx': int(a.numIndices),
            'numVerts': int(getattr(a, 'numIndices', 0)),
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
            'slices': {},
            'pstex': [],
            'vstex': [],
            'rw': [],
            'flags256': [],
            'mats256': [],
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
                name = refl.constantBlocks[i].name if i < len(refl.constantBlocks) else 'cb%d' % i
                sz = int(d.byteSize)
                inst_cb = (key == 'VS' and name == 'uniforms27') or (key == 'PS' and name == 'uniforms22')
                local_cb = (key == 'PS' and name == 'uniforms30' and sz == 352)
                vs_local = (key == 'VS' and name == 'uniforms36' and sz == 352)
                mip = (name in ('uniforms24', 'uniforms19') and sz == 3200)
                lut = (key == 'PS' and name == 'uniforms32' and sz == 32864)
                cam = (name in ('uniforms22', 'uniforms17') and sz == 1312)
                meta32 = (key == 'VS' and name == 'uniforms20' and sz == 32)
                if inst_cb and sz >= 256:
                    take_n = min(n, 4)
                    raw256 = bytes(c.GetBufferData(d.resource, int(d.byteOffset), take_n * 256))
                    rec['slices']['%s_%s' % (key, name)] = {
                        'size': sz,
                        'rid': rid(d.resource),
                        'sha': hashlib.sha256(raw256).hexdigest()[:16],
                    }
                    if key == 'VS':
                        rec['flags256'] = [struct.unpack_from('<I', raw256, ii * 256 + 76)[0] for ii in range(take_n) if len(raw256) >= ii * 256 + 80]
                        rec['mats256'] = [floats(raw256[ii * 256 + 48:ii * 256 + 60]) for ii in range(take_n) if len(raw256) >= ii * 256 + 60]
                elif local_cb or vs_local:
                    raw = bytes(c.GetBufferData(d.resource, int(d.byteOffset), sz))
                    sl = {'size': sz, 'rid': rid(d.resource), 'sha16': hashlib.sha256(raw).hexdigest()[:16], 'floats': floats(raw)}
                    vars = []
                    cb = refl.constantBlocks[i]
                    for ch in cb.variables:
                        vars.append({'n': ch.name, 'off': int(ch.byteOffset), 'rows': int(ch.type.rows), 'cols': int(ch.type.columns), 'elems': int(ch.type.elements)})
                    sl['nvars'] = len(vars)
                    sl['vars'] = vars
                    rec['slices']['%s_%s' % (key, name)] = sl
                elif mip:
                    raw = bytes(c.GetBufferData(d.resource, int(d.byteOffset) + 416, 4))
                    rec['slices']['%s_%s_mip416' % (key, name)] = floats(raw)[0]
                    extra = bytes(c.GetBufferData(d.resource, int(d.byteOffset) + 400, 32))
                    rec['slices']['%s_%s_400' % (key, name)] = floats(extra)
                elif lut:
                    raw = bytes(c.GetBufferData(d.resource, int(d.byteOffset), 16))
                    rec['slices']['%s_%s_child0' % (key, name)] = {'size': sz, 'rid': rid(d.resource), 'dir': floats(raw)}
                elif cam:
                    raw = bytes(c.GetBufferData(d.resource, int(d.byteOffset) + 704, 16))
                    rec['slices']['%s_%s_child11' % (key, name)] = floats(raw)
                elif meta32:
                    raw = bytes(c.GetBufferData(d.resource, int(d.byteOffset), sz))
                    rec['slices']['%s_%s' % (key, name)] = floats(raw)
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
        'idx': [out[str(e)]['idx'] for e in EIDS],
        'cull': [out[str(e)]['cull'] for e in EIDS],
        'sref': [out[str(e)]['sref'] for e in EIDS],
        'zw': [out[str(e)]['zw'] for e in EIDS],
        'zfn': [out[str(e)]['zfn'] for e in EIDS],
        'writeMask': [out[str(e)]['writeMask'] for e in EIDS],
        'ib': [out[str(e)]['ib'] for e in EIDS],
        'vbs': [out[str(e)]['vbs'] for e in EIDS],
        'layout': [out[str(e)]['layout'] for e in EIDS],
        'flags256': [out[str(e)]['flags256'] for e in EIDS],
        'mats256': [out[str(e)]['mats256'] for e in EIDS],
        'u30sha': [out[str(e)]['slices'].get('PS_uniforms30', {}).get('sha16') for e in EIDS],
        'u30nvars': [out[str(e)]['slices'].get('PS_uniforms30', {}).get('nvars') for e in EIDS],
        'u30floats': [out[str(e)]['slices'].get('PS_uniforms30', {}).get('floats') for e in EIDS],
        'u36sha': [out[str(e)]['slices'].get('VS_uniforms36', {}).get('sha16') for e in EIDS],
        'u36floats': [out[str(e)]['slices'].get('VS_uniforms36', {}).get('floats') for e in EIDS],
        'mipVS': [out[str(e)]['slices'].get('VS_uniforms24_mip416') for e in EIDS],
        'mipPS': [out[str(e)]['slices'].get('PS_uniforms19_mip416') for e in EIDS],
        'wind400': [out[str(e)]['slices'].get('VS_uniforms24_400') for e in EIDS],
        'cam': [out[str(e)]['slices'].get('VS_uniforms22_child11') for e in EIDS],
        'lut': [out[str(e)]['slices'].get('PS_uniforms32_child0') for e in EIDS],
        'meta32': [out[str(e)]['slices'].get('VS_uniforms20') for e in EIDS],
        'pstex': [[(t['n'], t['rid'], t['fmt'], t['w'], t.get('bind')) for t in out[str(e)]['pstex']] for e in EIDS],
        'vstex': [[(t['n'], t['rid'], t['fmt'], t['w'], t.get('bind')) for t in out[str(e)]['vstex']] for e in EIDS],
        'instSlice': [out[str(e)]['slices'].get('VS_uniforms27') for e in EIDS],
        'rw': [out[str(e)]['rw'] for e in EIDS],
    }
    return summary


print(json.dumps(ctx.replay(work), default=str))
