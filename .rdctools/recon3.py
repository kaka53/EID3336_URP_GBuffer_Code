def work(controller):
    controller.SetFrameEvent(3320, True)
    state = controller.GetPipelineState()

    vis = state.GetVertexInputs()
    sample_fields = None
    if len(vis) > 0:
        sample_fields = [n for n in dir(vis[0]) if not n.startswith('_')]

    out = []
    for i, a in enumerate(vis):
        d = {'loc': i}
        for f in ['name', 'vertexBuffer', 'byteOffset', 'perInstance', 'instanceRate', 'byteSize']:
            try:
                d[f] = getattr(a, f)
            except Exception as e:
                d[f] = 'ERR:' + str(e)
        try:
            d['format'] = serialize.format_description(a.format)
        except Exception as e:
            d['format'] = 'ERR:' + str(e)
        out.append(d)

    # what methods does PipeState expose for constant/descriptor access?
    psm = [n for n in dir(state) if not n.startswith('_')]

    return {'attr_sample_fields': sample_fields, 'vertex_inputs': out, 'pipestate_methods': psm}

ctx.replay(work)
