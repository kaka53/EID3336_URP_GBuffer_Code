import struct

def work(controller):
    controller.SetFrameEvent(3320, True)
    pv = controller.GetPostVSData(0, 0, rd.MeshDataStage.VSOut)
    stride = pv.vertexByteStride
    data = bytes(controller.GetBufferData(pv.vertexResourceId, pv.vertexByteOffset, stride * 2))
    slots = []
    for vi in range(2):
        row = []
        for s in range(stride // 16):
            row.append(list(struct.unpack_from('<4f', data, vi * stride + s * 16)))
        slots.append(row)
    return {'stride': stride, 'vertex0_slots': slots[0], 'vertex1_slots': slots[1]}

ctx.replay(work)
