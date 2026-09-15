def work(controller):
    controller.SetFrameEvent(3320, True)
    state = controller.GetPipelineState()

    ror = []
    try:
        for r in state.GetReadOnlyResources(rd.ShaderStage.Pixel):
            d = {}
            for f in ('name', 'fixedBindSetOrSpace', 'fixedBindNumber', 'isTexture', 'variableType'):
                try:
                    v = getattr(r, f)
                    d[f] = (v.name if hasattr(v, 'name') else v)
                except Exception:
                    pass
            try:
                d['resourceId'] = str(int(r.resourceId))
            except Exception:
                pass
            ror.append(d)
    except Exception as e:
        ror = [{'error': str(e)}]

    rwr = []
    try:
        for r in state.GetReadWriteResources(rd.ShaderStage.Pixel):
            d = {}
            try:
                d['resourceId'] = str(int(r.resourceId))
            except Exception:
                pass
            for f in ('name', 'fixedBindSetOrSpace', 'fixedBindNumber', 'isTexture'):
                try:
                    v = getattr(r, f)
                    d[f] = (v.name if hasattr(v, 'name') else v)
                except Exception:
                    pass
            rwr.append(d)
    except Exception as e:
        rwr = [{'error': str(e)}]

    return {'ps_read_only': ror, 'ps_read_write': rwr}

ctx.replay(work)
