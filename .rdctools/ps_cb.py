def work(controller):
    controller.SetFrameEvent(3320, True)
    state = controller.GetPipelineState()
    cbs = []
    for cb in state.GetConstantBlocks(rd.ShaderStage.Pixel):
        acc = getattr(cb, 'access', None)
        desc = getattr(cb, 'descriptor', None)
        d = {}
        if acc is not None:
            try:
                d['binding'] = getattr(acc, 'byteOffset', None)
            except Exception:
                pass
            try:
                d['type'] = acc.type.name
            except Exception:
                pass
        if desc is not None:
            try:
                d['resource'] = str(int(desc.resource))
            except Exception:
                pass
            try:
                d['byteOffset'] = getattr(desc, 'byteOffset', None)
            except Exception:
                pass
            try:
                d['byteSize'] = getattr(desc, 'byteSize', None)
            except Exception:
                pass
        cbs.append(d)
    return cbs

ctx.replay(work)
