import struct

def rid_for(controller, target):
    for b in controller.GetBuffers():
        if int(b.resourceId) == target:
            return b.resourceId
    raise RuntimeError('buffer %d not found' % target)

def work(controller):
    controller.SetFrameEvent(3320, True)
    state = controller.GetPipelineState()

    rid526 = rid_for(controller, 526)
    rid155 = rid_for(controller, 155)
    rid211534 = rid_for(controller, 211534)

    inst_data = bytes(controller.GetBufferData(rid526, 3743744, 4 * 256))
    entries = []
    for i in range(4):
        e = inst_data[i*256:(i+1)*256]
        mat = struct.unpack_from('<16f', e, 0)
        entries.append({'instance': i, 'first64_as_mat4': mat})

    pos_data = bytes(controller.GetBufferData(rid211534, 9711584, 217 * 16))
    pos = [struct.unpack_from('<4f', pos_data, i * 16) for i in range(5)]

    t0_data = bytes(controller.GetBufferData(rid211534, 9715104, 217 * 16))
    t0 = [struct.unpack_from('<4f', t0_data, i * 16) for i in range(5)]

    c3 = bytes(controller.GetBufferData(rid155, 0, 20))

    return {
        'instance_entries': entries,
        'sample_binding0_floats4': pos,
        'sample_binding1_floats4': t0,
        'binding3_20bytes_hex': c3.hex(),
    }

ctx.replay(work)
