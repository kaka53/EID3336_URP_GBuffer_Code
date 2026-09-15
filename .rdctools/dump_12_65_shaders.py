import json, hashlib, os

INV = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/remaining_12_65_inventory.json'
OUTD = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/shaders_12_65'
os.makedirs(OUTD, exist_ok=True)
families = json.load(open(INV, encoding='utf8'))


def rid(x):
    try:
        return int(x)
    except Exception:
        return 0


def work(c):
    actions = {}

    def walk(xs):
        for a in xs:
            actions[a.eventId] = a
            walk(a.children)

    walk(c.GetRootActions())
    dumped = {}
    recs = []
    for fam in families:
        eid = fam['eids'][0]
        a = actions[eid]
        c.SetFrameEvent(eid, False)
        s = c.GetPipelineState()
        pso = s.GetGraphicsPipelineObject()
        rec = {'n': fam['n'], 'family': fam['family'], 'eid': eid, 'vs': fam['vs'], 'ps': fam['ps']}
        for stage, key in [(rd.ShaderStage.Vertex, 'VS'), (rd.ShaderStage.Pixel, 'PS')]:
            refl = s.GetShaderReflection(stage)
            raw = bytes(refl.rawBytes)
            h = hashlib.sha256(raw).hexdigest()
            rec[key + 'H'] = h
            rec[key + 'bytes'] = len(raw)
            if h not in dumped:
                stem = '%s_%s_%s' % (key, rec[key.lower()] if False else (fam['vs'] if key == 'VS' else fam['ps']), h[:16])
                # unique by hash
                path_spv = os.path.join(OUTD, h[:16] + '_' + key + '.spv')
                path_asm = os.path.join(OUTD, h[:16] + '_' + key + '.spvasm')
                open(path_spv, 'wb').write(raw)
                asm = c.DisassembleShader(pso, refl, 'SPIR-V (RenderDoc)')
                open(path_asm, 'w', encoding='utf8').write(asm)
                dumped[h] = {'spv': path_spv, 'asm': path_asm, 'bytes': len(raw), 'stage': key, 'firstFamily': fam['n']}
            rec[key + 'file'] = dumped[h]['asm']
        recs.append(rec)
    out = {'uniqueShaders': {h: {k: v for k, v in d.items() if k != 'spv'} for h, d in dumped.items()}, 'families': recs}
    open(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_12_65_shaders.json', 'w', encoding='utf8').write(json.dumps(out, indent=2))
    return {'unique': len(dumped), 'families': len(recs)}


ctx.replay(work)
