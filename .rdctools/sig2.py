def work(controller):
    controller.SetFrameEvent(3320, True)
    pv = controller.GetPostVSData(0, 0, rd.MeshDataStage.VSOut)
    fields = []
    for n in dir(pv):
        if n.startswith('_'):
            continue
        try:
            v = getattr(pv, n)
            if callable(v):
                continue
            if hasattr(v, 'name'):
                fields.append([n, v.name])
            elif isinstance(v, list):
                fields.append([n, 'list[%d]' % len(v)])
            else:
                fields.append([n, v])
        except Exception as e:
            fields.append([n, 'ERR:' + str(e)])
    return {'meshformat_fields': fields}

ctx.replay(work)
