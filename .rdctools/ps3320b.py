def work(controller):
    controller.SetFrameEvent(3320, True)
    state = controller.GetPipelineState()
    ror = state.GetReadOnlyResources(rd.ShaderStage.Pixel)
    sample = None
    if len(ror) > 0:
        sample = {}
        for n in dir(ror[0]):
            if n.startswith('_'):
                continue
            try:
                v = getattr(ror[0], n)
                if callable(v):
                    continue
                if hasattr(v, 'name'):
                    sample[n] = v.name
                else:
                    sample[n] = v
            except Exception as e:
                sample[n] = 'ERR:' + str(e)
    out = []
    for r in ror:
        d = {}
        for f in ('name', 'bindset', 'bind', 'bindPoint', 'resource', 'fixedBindSetOrSpace', 'fixedBindNumber'):
            try:
                v = getattr(r, f)
                if hasattr(v, 'name'):
                    d[f] = v.name
                elif f == 'resource':
                    d[f] = str(int(v))
                else:
                    d[f] = v
            except Exception:
                pass
        out.append(d)
    return {'count': len(ror), 'sample_fields': sample, 'entries': out}

ctx.replay(work)
