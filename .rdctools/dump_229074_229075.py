import os, json, struct, hashlib

EIDS = [3739, 3743, 3749]
OUT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_229074_229075.json'
CBS = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_229074_cbs.json'


def rid(x):
    try:
        return int(x)
    except Exception:
        return 0


def hexhash(b):
    return hashlib.sha256(bytes(b)).hexdigest()


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
    missing = [x for x in EIDS if x not in actions]
    texdesc = {rid(t.resourceId): t for t in c.GetTextures()}
    draws = []
    cbs = {}

    for eid in EIDS:
        a = actions[eid]
        c.SetFrameEvent(eid, False)
        s = c.GetPipelineState()
        vs = rid(s.GetShader(rd.ShaderStage.Vertex))
        ps = rid(s.GetShader(rd.ShaderStage.Pixel))
        rs = s.GetRasterState()
        ds = s.GetDepthTestState()
        st = s.GetStencilFaces()
        blends = s.GetColorBlends()
        front = st[0] if st else None
        write_mask = [int(b.writeMask) for b in blends] if blends else []
        vrefl = s.GetShaderReflection(rd.ShaderStage.Vertex)
        prefl = s.GetShaderReflection(rd.ShaderStage.Pixel)

        layout = []
        for x in s.GetVertexInputs():
            layout.append({
                'name': x.name,
                'slot': int(x.vertexBuffer),
                'off': int(x.byteOffset),
                'fmt': x.format.Name(),
                'perInst': bool(x.perInstance),
                'comp': int(x.format.compCount),
                'bw': int(x.format.compByteWidth),
            })

        def stage_cbs(stage, key):
            out = []
            refl = s.GetShaderReflection(stage)
            flags = []
            inst0 = None
            for i, u in enumerate(s.GetConstantBlocks(stage)):
                d = u.descriptor
                name = refl.constantBlocks[i].name if i < len(refl.constantBlocks) else 'cb%d' % i
                sz = int(d.byteSize)
                rec = {
                    'name': name,
                    'bind': int(u.access.byteOffset),
                    'rid': rid(d.resource),
                    'offset': int(d.byteOffset),
                    'size': sz,
                    'sha': '',
                }
                if name in ('uniforms28', 'uniforms20') and sz >= 256:
                    n = int(a.numInstances)
                    need = n * 256
                    raw = bytes(c.GetBufferData(d.resource, int(d.byteOffset), need))
                    rec['sha'] = hexhash(raw)[:16]
                    rec['sliced'] = need
                    for ii in range(n):
                        if ii * 256 + 80 <= len(raw):
                            flags.append(struct.unpack_from('<I', raw, ii * 256 + 76)[0])
                    inst0 = {
                        'm16': floats(raw[:64]),
                        't': floats(raw[48:64]),
                        'flags0': flags[:1],
                    }
                    cbs['%s_%s_%d_inst' % (key, name, eid)] = {
                        'size': sz,
                        'sliced': need,
                        't': inst0['t'],
                        'flags': flags,
                    }
                elif 0 < sz <= 4096:
                    raw = bytes(c.GetBufferData(d.resource, int(d.byteOffset), sz))
                    rec['sha'] = hexhash(raw)[:16]
                    if name in ('uniforms32', 'uniforms34', 'uniforms17') or sz in (512, 16, 32):
                        cbs['%s_%s_%d' % (key, name, eid)] = {
                            'size': sz,
                            'sha': rec['sha'],
                            'floats': floats(raw[:min(sz, 512)]),
                        }
                out.append(rec)
            return out, flags, inst0

        def stage_tex(stage):
            out = []
            refl = s.GetShaderReflection(stage)
            for i, u in enumerate(s.GetReadOnlyResources(stage)):
                d = u.descriptor
                name = refl.readOnlyResources[i].name if i < len(refl.readOnlyResources) else 'res%d' % i
                r = rid(d.resource)
                td = texdesc.get(r)
                out.append({
                    'name': name,
                    'bind': int(u.access.byteOffset),
                    'rid': r,
                    'fmt': td.format.Name() if td else '',
                    'w': int(td.width) if td else 0,
                    'h': int(td.height) if td else 0,
                    'type': str(td.type) if td else '',
                })
            return out

        def stage_rw(stage):
            out = []
            refl = s.GetShaderReflection(stage)
            try:
                rws = s.GetReadWriteResources(stage)
            except Exception:
                rws = []
            for i, u in enumerate(rws):
                d = u.descriptor
                name = refl.readWriteResources[i].name if i < len(refl.readWriteResources) else 'rw%d' % i
                out.append({
                    'name': name,
                    'rid': rid(d.resource),
                    'size': int(d.byteSize),
                    'offset': int(d.byteOffset),
                    'bind': int(u.access.byteOffset),
                })
            return out

        vs_cbs, flags, inst0 = stage_cbs(rd.ShaderStage.Vertex, 'VS')
        ps_cbs, _, _ = stage_cbs(rd.ShaderStage.Pixel, 'PS')
        draws.append({
            'eid': eid,
            'vs': vs,
            'ps': ps,
            'inst': int(a.numInstances),
            'idx': int(a.numIndices),
            'cull': str(rs.cullMode),
            'zw': bool(ds.depthWrites),
            'zfn': str(ds.depthFunction),
            'frontCCW': bool(rs.frontCCW),
            'sref': int(front.reference) if front else None,
            'sfn': str(front.function) if front else None,
            'scm': int(front.compareMask) if front else None,
            'swm': int(front.writeMask) if front else None,
            'spass': str(front.passOperation) if front else None,
            'writeMask': write_mask,
            'blend0': bool(blends[0].enabled) if blends else None,
            'inputs': layout,
            'vsH': hexhash(bytes(vrefl.rawBytes))[:16],
            'psH': hexhash(bytes(prefl.rawBytes))[:16],
            'VScb': vs_cbs,
            'PScb': ps_cbs,
            'VStex': stage_tex(rd.ShaderStage.Vertex),
            'PStex': stage_tex(rd.ShaderStage.Pixel),
            'VSrw': stage_rw(rd.ShaderStage.Vertex),
            'PSrw': stage_rw(rd.ShaderStage.Pixel),
            'flags': flags,
            'inst0': inst0,
        })

    out = {
        'missing': missing,
        'draws': draws,
        'vsH': sorted(set(x['vsH'] for x in draws)),
        'psH': sorted(set(x['psH'] for x in draws)),
        'cull': sorted(set(x['cull'] for x in draws)),
        'sref': sorted(set(x['sref'] for x in draws)),
        'zw': sorted(set(x['zw'] for x in draws)),
        'zfn': sorted(set(x['zfn'] for x in draws)),
        'writeMask': draws[0]['writeMask'] if draws else [],
        'inst': sum(x['inst'] for x in draws),
        'inputNames': sorted(set(i['name'] for x in draws for i in x['inputs'])),
    }
    open(OUT, 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))
    open(CBS, 'w', encoding='utf8').write(json.dumps(cbs, indent=2, default=str))
    return {
        'missing': missing,
        'vsH': out['vsH'],
        'psH': out['psH'],
        'cull': out['cull'],
        'sref': out['sref'],
        'zw': out['zw'],
        'zfn': out['zfn'],
        'writeMask': out['writeMask'],
        'inst': out['inst'],
        'inputNames': out['inputNames'],
        'eids': [x['eid'] for x in draws],
        'vs': [x['vs'] for x in draws],
        'ps': [x['ps'] for x in draws],
        'flagsUnique': sorted(set(f for x in draws for f in x['flags'])),
        'VStex': [{t['name']: (t['rid'], t['fmt'], t['w']) for t in x['VStex']} for x in draws],
        'PStex': [{t['name']: (t['rid'], t['fmt'], t['w']) for t in x['PStex']} for x in draws],
        'VScb': [{b['name']: (b['size'], b['rid']) for b in x['VScb']} for x in draws],
        'PScb': [{b['name']: (b['size'], b['rid']) for b in x['PScb']} for x in draws],
        'VSrw': [x['VSrw'] for x in draws],
        'layouts': [[(i['name'], i['fmt'], i['slot'], i['off']) for i in x['inputs']] for x in draws],
        'inst0t': [x['inst0']['t'] if x['inst0'] else None for x in draws],
        'sfn': sorted(set(x['sfn'] for x in draws)),
        'spass': sorted(set(x['spass'] for x in draws)),
        'blend0': sorted(set(x['blend0'] for x in draws)),
    }


print(json.dumps(ctx.replay(work), default=str))
