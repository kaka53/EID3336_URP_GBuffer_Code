def work(controller):
    controller.SetFrameEvent(3320, True)
    state = controller.GetPipelineState()

    ib = state.GetIBuffer()
    ib_len = 1167 * 2
    ibdata = bytes(controller.GetBufferData(ib.resourceId, ib.byteOffset, ib_len))
    import struct
    idx = struct.unpack_from('<%dH' % 1167, ibdata, 0)
    maxidx = max(idx)
    vcount = maxidx + 1

    cbs = []
    for cb in state.GetConstantBlocks(rd.ShaderStage.Vertex):
        stage = getattr(cb, 'stage', None)
        cbs.append({
            'name': getattr(cb, 'name', None),
            'set': getattr(cb, 'fixedBindSetOrSpace', None),
            'binding': getattr(cb, 'fixedBindNumber', None),
            'byteSize': getattr(cb, 'byteSize', None),
            'bufferBacked': getattr(cb, 'bufferBacked', None),
            'byteOffset': getattr(cb, 'byteOffset', None),
            'buffer': str(int(getattr(cb, 'buffer', 0) or 0)),
            'stage': (stage.name if stage is not None else None),
        })

    return {
        'index_buffer': {'rid': str(int(ib.resourceId)), 'offset': ib.byteOffset, 'stride': ib.byteStride},
        'num_indices': 1167,
        'max_index': maxidx,
        'vertex_count': vcount,
        'constant_blocks': cbs,
    }

ctx.replay(work)
