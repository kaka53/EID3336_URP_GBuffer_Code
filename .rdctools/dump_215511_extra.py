import os, json, struct, hashlib

EIDS = [3379, 3383]
OUT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215511_extra.json'


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
        rec = {'eid': eid, 'slices': {}, 'layout': [], 'pstex': [], 'vstex': [], 'flags': []}
        for x in s.GetVertexInputs():
            rec['layout'].append((x.name, x.format.Name(), int(x.vertexBuffer), int(x.byteOffset), int(x.format.compCount)))
        for stage, key in [(rd.ShaderStage.Vertex, 'VS'), (rd.ShaderStage.Pixel, 'PS')]:
            refl = s.GetShaderReflection(stage)
            for i, u in enumerate(s.GetConstantBlocks(stage)):
                d = u.descriptor
                name = refl.constantBlocks[i].name if i < len(refl.constantBlocks) else 'cb%d' % i
                sz = int(d.byteSize)
                if name == 'uniforms30' and key == 'VS' and sz >= 256:
                    n = int(a.numInstances)
                    raw = bytes(c.GetBufferData(d.resource, int(d.byteOffset), n * 256))
                    flags = [struct.unpack_from('<I', raw, ii * 256 + 76)[0] for ii in range(n)]
                    rec['flags'] = flags
                    rec['inst0t'] = floats(raw[48:64])
                    rec['slices']['VS_uniforms30'] = {'size': sz, 'sliced': n * 256, 'flags': flags, 't': rec['inst0t']}
                elif name in ('uniforms43', 'uniforms45', 'uniforms47') or (name == 'uniforms21' and sz == 3200) or (name == 'uniforms27' and sz == 3200):
                    raw = bytes(c.GetBufferData(d.resource, int(d.byteOffset), min(sz, 3200)))
                    sl = {
                        'size': sz,
                        'rid': rid(d.resource),
                        'sha16': hashlib.sha256(raw).hexdigest()[:16],
                    }
                    if name == 'uniforms43':
                        sl['floats'] = floats(raw)
                        vars = []
                        cb = refl.constantBlocks[i]
                        for ch in cb.variables:
                            vars.append({'n': ch.name, 'off': int(ch.byteOffset), 'rows': int(ch.type.rows), 'cols': int(ch.type.columns), 'elems': int(ch.type.elements)})
                        sl['vars'] = vars
                    elif name == 'uniforms45':
                        sl['floats'] = floats(raw)
                    elif name == 'uniforms47':
                        sl['floats'] = floats(raw)
                    elif sz == 3200:
                        sl['mip416'] = floats(raw[416:420])[0]
                        sl['y436'] = floats(raw[436:440])[0]
                    rec['slices']['%s_%s' % (key, name)] = sl
            for i, u in enumerate(s.GetReadOnlyResources(stage)):
                d = u.descriptor
                name = refl.readOnlyResources[i].name if i < len(refl.readOnlyResources) else 'res%d' % i
                r = rid(d.resource)
                td = texdesc.get(r)
                rec['pstex' if key == 'PS' else 'vstex'].append({
                    'n': name, 'rid': r, 'bind': int(u.access.byteOffset),
                    'fmt': td.format.Name() if td else '', 'w': int(td.width) if td else 0,
                })
        out[str(eid)] = rec
    open(OUT, 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))
    summary = {
        'eids': EIDS,
        'flags': {k: v['flags'] for k, v in out.items()},
        'layout': {k: v['layout'] for k, v in out.items()},
        'u43sha': {k: v['slices'].get('PS_uniforms43', {}).get('sha16') for k, v in out.items()},
        'u43nvars': {k: len(v['slices'].get('PS_uniforms43', {}).get('vars', [])) for k, v in out.items()},
        'u45': {k: v['slices'].get('PS_uniforms45', {}).get('floats') for k, v in out.items()},
        'mip': {k: v['slices'].get('PS_uniforms21', {}).get('mip416') for k, v in out.items()},
        'pstex': {k: [(t['n'], t['rid'], t['fmt'], t['w']) for t in v['pstex']] for k, v in out.items()},
        'inst0t': {k: v.get('inst0t') for k, v in out.items()},
    }
    return summary


print(json.dumps(ctx.replay(work), default=str))
