def work(controller):
    controller.SetFrameEvent(3320, True)
    state = controller.GetPipelineState()

    ror = state.GetReadOnlyResources(rd.ShaderStage.Vertex)
    ror_dump = []
    for r in ror:
        d = {'_type': type(r).__name__}
        d['_fields'] = [n for n in dir(r) if not n.startswith('_')]
        for f in ['name', 'resourceId', 'fixedBindSetOrSpace', 'fixedBindNumber', 'byteOffset', 'byteSize', 'isTexture', 'variableType']:
            try:
                v = getattr(r, f)
                if hasattr(v, 'name'):
                    d[f] = v.name
                elif f in ('resourceId',):
                    d[f] = str(int(v))
                else:
                    d[f] = v
            except Exception:
                pass
        ror_dump.append(d)

    vk = controller.GetVulkanPipelineState()
    vk_fields = [n for n in dir(vk) if not n.startswith('_')]

    ds_info = 'n/a'
    try:
        dsets = vk.descriptorSets
        out = []
        for ds in dsets:
            setidx = getattr(ds, 'index', None)
            for b in ds.descriptorBindings:
                bt = getattr(b, 'type', None)
                out.append({
                    'set': setidx,
                    'binding': getattr(b, 'binding', None),
                    'type': (bt.name if hasattr(bt, 'name') else str(bt)),
                    'resource': str(int(getattr(b, 'resourceId', 0) or 0)),
                    'offset': getattr(b, 'byteOffset', None),
                    'size': getattr(b, 'byteSize', None),
                })
        ds_info = out
    except Exception as e:
        ds_info = 'ERR:' + str(e)

    return {
        'read_only_resources': ror_dump,
        'vk_fields': vk_fields,
        'vk_descriptor_sets': ds_info,
    }

ctx.replay(work)
