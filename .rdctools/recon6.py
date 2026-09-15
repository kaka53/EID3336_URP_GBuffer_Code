def dump_fields(obj):
    out = []
    for n in dir(obj):
        if n.startswith('_'):
            continue
        try:
            v = getattr(obj, n)
            if callable(v):
                continue
            if hasattr(v, 'name'):
                out.append([n, v.name])
            else:
                out.append([n, v])
        except Exception as e:
            out.append([n, 'ERR:' + str(e)])
    return out

def work(controller):
    controller.SetFrameEvent(3320, True)
    state = controller.GetPipelineState()

    cbs = state.GetConstantBlocks(rd.ShaderStage.Vertex)
    cb_dump = []
    for cb in cbs:
        cb_dump.append(dump_fields(cb))

    rl = None
    try:
        rl = state.GetResourceLayout()
        rl_dump = dump_fields(rl)
        # descriptor set layouts
        dsl = None
        try:
            dsl = dump_fields(getattr(rl, 'descriptorSets', None))
        except Exception as e:
            dsl = 'ERR:' + str(e)
    except Exception as e:
        rl_dump = 'ERR:' + str(e)
        dsl = None

    return {'constant_block_fields': cb_dump, 'resource_layout_fields': rl_dump, 'rl_descriptor_sets': dsl}

ctx.replay(work)
