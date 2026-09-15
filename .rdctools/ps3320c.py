def work(controller):
    controller.SetFrameEvent(3320, True)
    state = controller.GetPipelineState()
    ror = state.GetReadOnlyResources(rd.ShaderStage.Pixel)
    out = []
    for r in ror:
        acc = getattr(r, 'access', None)
        desc = getattr(r, 'descriptor', None)
        d = {}
        if acc is not None:
            for f in ('index', 'byteOffset', 'arrayElement', 'staticallyUnused'):
                try:
                    v = getattr(acc, f)
                    d['acc_' + f] = (v.name if hasattr(v, 'name') else v)
                except Exception:
                    pass
            try:
                d['type'] = acc.type.name
            except Exception:
                pass
        if desc is not None:
            for f in ('resource', 'view', 'byteOffset', 'byteSize', 'numMips', 'numSlices'):
                try:
                    v = getattr(desc, f)
                    if f in ('resource', 'view'):
                        d[f] = str(int(v))
                    else:
                        d[f] = (v.name if hasattr(v, 'name') else v)
                except Exception:
                    pass
            try:
                d['textureType'] = desc.textureType.name
            except Exception:
                pass
            try:
                d['format'] = desc.format.Name()
            except Exception:
                pass
        out.append(d)
    return {'count': len(ror), 'textures': out}

ctx.replay(work)
