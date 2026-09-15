def work(controller):
    controller.SetFrameEvent(3320, True)
    targets = {222162, 222165, 247705, 222331, 224843, 246832}
    out = {}
    for t in controller.GetTextures():
        rid = int(t.resourceId)
        if rid in targets:
            out[str(rid)] = {
                'width': t.width, 'height': t.height, 'depth': t.depth,
                'arraySize': t.arraysize, 'mips': t.mips, 'samples': t.msSamp,
                'format': serialize.format_description(t.format),
                'byteSize': t.byteSize,
                'cube': getattr(t, 'cubemap', None),
            }
    return out

ctx.replay(work)
