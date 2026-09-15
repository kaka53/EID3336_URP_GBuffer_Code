import struct

def rid_for(controller, target):
    for b in controller.GetBuffers():
        if int(b.resourceId) == target:
            return b.resourceId
    raise RuntimeError('buffer %d not found' % target)

def colmaj_to_rowmaj(f):
    return [
        [f[0], f[4], f[8],  f[12]],
        [f[1], f[5], f[9],  f[13]],
        [f[2], f[6], f[10], f[14]],
        [f[3], f[7], f[11], f[15]],
    ]

def mul(M, v):
    return [
        M[0][0]*v[0] + M[0][1]*v[1] + M[0][2]*v[2] + M[0][3],
        M[1][0]*v[0] + M[1][1]*v[1] + M[1][2]*v[2] + M[1][3],
        M[2][0]*v[0] + M[2][1]*v[1] + M[2][2]*v[2] + M[2][3],
        M[3][0]*v[0] + M[3][1]*v[1] + M[3][2]*v[2] + M[3][3],
    ]

def work(controller):
    controller.SetFrameEvent(3320, True)
    r526 = rid_for(controller, 526)
    r211534 = rid_for(controller, 211534)

    u30 = bytes(controller.GetBufferData(r526, 3743744, 256))
    v0 = bytes(controller.GetBufferData(r211534, 9711584, 217 * 16))

    mf = struct.unpack_from('<16f', u30, 0)
    M = colmaj_to_rowmaj(mf)

    computed_world = []
    for vi in range(3):
        px, py, pz = struct.unpack_from('<3f', v0, vi * 16)
        w = mul(M, [px, py, pz, 1.0])
        computed_world.append([round(x, 5) for x in w])

    pv = controller.GetPostVSData(0, 0, rd.MeshDataStage.VSOut)
    pvdata = bytes(controller.GetBufferData(pv.vertexResourceId, pv.vertexByteOffset, pv.vertexByteStride * 3))
    postvs_pos = [struct.unpack_from('<4f', pvdata, i * pv.vertexByteStride) for i in range(3)]
    postvs_pos = [[round(x, 5) for x in p] for p in postvs_pos]

    # differences
    diffs = []
    for i in range(3):
        diffs.append([round(computed_world[i][k] - postvs_pos[i][k], 6) for k in range(3)])

    return {
        'computed_world_xyz': computed_world,
        'postvs_position_xyzw': postvs_pos,
        'diff_xyz': diffs,
        'meshformat_unproject': pv.unproject,
        'meshformat_stride': pv.vertexByteStride,
    }

ctx.replay(work)
