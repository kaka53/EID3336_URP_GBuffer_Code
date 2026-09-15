import json, hashlib, os, time, struct

INV = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/remaining_12_65_inventory.json'
OUT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/scan_12_65.json'
families = json.load(open(INV, encoding='utf8'))
EIDS = []
FAM_OF = {}
for fam in families:
    for d in fam['draws']:
        EIDS.append(d['eid'])
        FAM_OF[d['eid']] = fam['n']


def rid(x):
    try:
        return int(x)
    except Exception:
        return 0


def work(c):
    t0 = time.time()
    actions = {}

    def walk(xs):
        for a in xs:
            if a.eventId in FAM_OF:
                actions[a.eventId] = a
            walk(a.children)

    walk(c.GetRootActions())
    missing = [x for x in EIDS if x not in actions]
    shader_hash = {}
    rows = []
    for eid in EIDS:
        a = actions.get(eid)
        if a is None:
            rows.append({'eid': eid, 'family': FAM_OF[eid], 'missing': True})
            continue
        c.SetFrameEvent(eid, False)
        s = c.GetPipelineState()
        vs = rid(s.GetShader(rd.ShaderStage.Vertex))
        ps = rid(s.GetShader(rd.ShaderStage.Pixel))
        for stage, key in [(rd.ShaderStage.Vertex, 'VS'), (rd.ShaderStage.Pixel, 'PS')]:
            sid = vs if key == 'VS' else ps
            if sid not in shader_hash:
                refl = s.GetShaderReflection(stage)
                shader_hash[sid] = hashlib.sha256(bytes(refl.rawBytes)).hexdigest()
        rs = s.GetRasterState()
        ds = s.GetDepthTestState()
        st = s.GetStencilFaces()
        blends = s.GetColorBlends()
        stencil_ref = int(st[0].reference) if st else None
        inputs = []
        for x in s.GetVertexInputs():
            inputs.append({
                'n': x.name,
                'slot': int(x.vertexBuffer),
                'off': int(x.byteOffset),
                'fmt': x.format.Name(),
                'inst': bool(x.perInstance),
            })
        cbs = {'VS': [], 'PS': []}
        for stage, key in [(rd.ShaderStage.Vertex, 'VS'), (rd.ShaderStage.Pixel, 'PS')]:
            refl = s.GetShaderReflection(stage)
            for i, u in enumerate(s.GetConstantBlocks(stage)):
                d = u.descriptor
                name = refl.constantBlocks[i].name if i < len(refl.constantBlocks) else 'cb%d' % i
                cbs[key].append({'n': name, 'sz': int(d.byteSize), 'bind': int(u.access.byteOffset)})
        tex = []
        reflps = s.GetShaderReflection(rd.ShaderStage.Pixel)
        rr = list(reflps.readOnlyResources)
        for i, u in enumerate(s.GetReadOnlyResources(rd.ShaderStage.Pixel)):
            d = u.descriptor
            name = rr[i].name if i < len(rr) else 'tex%d' % i
            tex.append({'n': name, 'rid': rid(d.resource), 'bind': int(u.access.byteOffset)})
        rws = []
        reflvs = s.GetShaderReflection(rd.ShaderStage.Vertex)
        try:
            for i, u in enumerate(s.GetReadWriteResources(rd.ShaderStage.Vertex)):
                d = u.descriptor
                name = reflvs.readWriteResources[i].name if i < len(reflvs.readWriteResources) else 'rw%d' % i
                rws.append({'n': name, 'rid': rid(d.resource), 'sz': int(d.byteSize)})
        except Exception:
            pass
        ib = s.GetIBuffer()
        rows.append({
            'eid': eid,
            'family': FAM_OF[eid],
            'vs': vs,
            'ps': ps,
            'vsH': shader_hash[vs][:16],
            'psH': shader_hash[ps][:16],
            'inst': int(a.numInstances),
            'idx': int(a.numIndices),
            'cull': str(rs.cullMode),
            'fill': str(rs.fillMode),
            'ccw': bool(rs.frontCCW),
            'zfn': str(ds.depthFunction),
            'zw': bool(ds.depthWrites),
            'sref': stencil_ref,
            'blend': bool(blends[0].enabled) if blends else None,
            'istride': int(ib.byteStride) if ib else 0,
            'inputs': inputs,
            'cbs': cbs,
            'tex': tex,
            'rw': rws,
        })
    famsum = {}
    for r in rows:
        famsum.setdefault(r['family'], []).append(r)
    compact = []
    for n, xs in sorted(famsum.items()):
        vsH = sorted(set(x.get('vsH') for x in xs if 'vsH' in x))
        psH = sorted(set(x.get('psH') for x in xs if 'psH' in x))
        cull = sorted(set(x.get('cull') for x in xs))
        zw = sorted(set(x.get('zw') for x in xs))
        zfn = sorted(set(x.get('zfn') for x in xs))
        sref = sorted(set(x.get('sref') for x in xs))
        inames = sorted(set(tuple(i['n'] for i in x.get('inputs', [])) for x in xs))
        inst_tot = sum(x.get('inst', 0) for x in xs)
        texnames = sorted(set(t['n'] for x in xs for t in x.get('tex', [])))
        vscb = sorted(set((c['n'], c['sz']) for x in xs for c in x.get('cbs', {}).get('VS', [])))
        pscb = sorted(set((c['n'], c['sz']) for x in xs for c in x.get('cbs', {}).get('PS', [])))
        rw = sorted(set(t['n'] for x in xs for t in x.get('rw', [])))
        compact.append({
            'n': n,
            'eids': [x['eid'] for x in xs],
            'draws': len(xs),
            'inst': inst_tot,
            'vs': xs[0].get('vs'),
            'ps': xs[0].get('ps'),
            'vsH': vsH,
            'psH': psH,
            'cull': cull,
            'zw': zw,
            'zfn': zfn,
            'sref': sref,
            'inputSets': [list(t) for t in inames],
            'vsCB': [{'n': a, 'sz': b} for a, b in vscb],
            'psCB': [{'n': a, 'sz': b} for a, b in pscb],
            'tex': texnames,
            'rw': rw,
            'blend': sorted(set(x.get('blend') for x in xs)),
        })
    out = {
        'elapsed': time.time() - t0,
        'missing': missing,
        'families': compact,
        'shaderHashFull': shader_hash,
        'rows': rows,
    }
    open(OUT, 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))
    summary = {
        'elapsed': out['elapsed'],
        'missing': missing,
        'familyCount': len(compact),
        'vsClusters': {},
    }
    clusters = {}
    for f in compact:
        key = (tuple(f['vsH']), tuple(f['psH']))
        clusters.setdefault(str(key), []).append(f['n'])
    summary['clusters'] = clusters
    open(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/scan_12_65_summary.json', 'w', encoding='utf8').write(json.dumps(summary, indent=2))
    return {'elapsed': out['elapsed'], 'missing': missing, 'families': len(compact), 'clusters': len(clusters)}


ctx.replay(work)
