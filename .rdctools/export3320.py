import struct, hashlib, json, os

OUT = 'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/EID3332_EID3336_Combined/Resources/EID3320VS'

VC = 217      # vertex count (max index 216 + 1)
IC = 1167     # index count
INST = 4      # instance count

def rid_for(controller, target):
    for b in controller.GetBuffers():
        if int(b.resourceId) == target:
            return b.resourceId
    raise RuntimeError('buffer %d not found' % target)

def write_file(path, data):
    with open(path, 'wb') as f:
        f.write(data)
    return len(data), hashlib.sha256(data).hexdigest()

def work(controller):
    controller.SetFrameEvent(3320, True)

    r526 = rid_for(controller, 526)
    r155 = rid_for(controller, 155)
    r211534 = rid_for(controller, 211534)

    v0 = bytes(controller.GetBufferData(r211534, 9711584, VC * 16))
    v1 = bytes(controller.GetBufferData(r211534, 9715104, VC * 16))
    ib = bytes(controller.GetBufferData(r211534, 9718624, IC * 2))
    c3 = bytes(controller.GetBufferData(r155, 0, 20))
    u25 = bytes(controller.GetBufferData(r526, 369408, 1312))
    u27 = bytes(controller.GetBufferData(r526, 370944, 3200))
    u30 = bytes(controller.GetBufferData(r526, 3743744, 65536))

    os.makedirs(OUT, exist_ok=True)

    files_meta = []
    def emit(name, data, rid, offset):
        size, sha = write_file(os.path.join(OUT, name), data)
        files_meta.append({
            'file': name, 'size': size, 'sha256': sha,
            'offset': offset, 'requested': len(data), 'rid': str(rid),
        })

    emit('_24_25.bytes', u25, 526, 369408)
    emit('_26_27.bytes', u27, 526, 370944)
    emit('_28_30.bytes', u30, 526, 3743744)
    emit('vertex_stream0.bin', v0, 211534, 9711584)
    emit('vertex_stream1.bin', v1, 211534, 9715104)
    emit('vertex_constant_stream.bin', c3, 155, 0)
    emit('indices_u16.bin', ib, 211534, 9718624)

    # World matrices: uniforms30[i] = 256-byte struct, first 64 bytes = column-major float4x4
    mats = []
    for i in range(INST):
        e = u30[i * 256:(i + 1) * 256]
        f = struct.unpack_from('<16f', e, 0)
        M = [
            [f[0], f[4], f[8],  f[12]],
            [f[1], f[5], f[9],  f[13]],
            [f[2], f[6], f[10], f[14]],
            [f[3], f[7], f[11], f[15]],
        ]
        mats.append(M)

    # World positions (capture space, Y-up, Vulkan -Z front)
    world = []
    minp = [1e30, 1e30, 1e30]
    maxp = [-1e30, -1e30, -1e30]
    for i in range(INST):
        M = mats[i]
        for vi in range(VC):
            px, py, pz = struct.unpack_from('<3f', v0, vi * 16)
            wx = M[0][0]*px + M[0][1]*py + M[0][2]*pz + M[0][3]
            wy = M[1][0]*px + M[1][1]*py + M[1][2]*pz + M[1][3]
            wz = M[2][0]*px + M[2][1]*py + M[2][2]*pz + M[2][3]
            world.append([i, vi, round(px, 6), round(py, 6), round(pz, 6), round(wx, 6), round(wy, 6), round(wz, 6)])
            for k, v in enumerate((wx, wy, wz)):
                if v < minp[k]: minp[k] = v
                if v > maxp[k]: maxp[k] = v

    # full struct dump of instance 0 (256 bytes = 64 floats) for documentation
    inst0 = struct.unpack_from('<64f', u30, 0)

    inst_meta = {
        'instance_count': INST,
        'struct_byte_size': 256,
        'matrices_row_major': mats,
        'translations': [[M[0][3], M[1][3], M[2][3]] for M in mats],
        'instance0_all_64_floats': list(inst0),
    }
    with open(os.path.join(OUT, 'instance_matrices.json'), 'w') as f:
        json.dump(inst_meta, f, indent=2)

    with open(os.path.join(OUT, 'world_positions.json'), 'w') as f:
        json.dump({'vertex_count': VC, 'instance_count': INST,
                   'note': 'capture space, Y-up, Vulkan -Z front',
                   'columns': ['instance', 'vertex', 'lx', 'ly', 'lz', 'wx', 'wy', 'wz'],
                   'positions': world}, f)

    manifest = {
        'event': 3320,
        'vertex_count': VC,
        'index_count': IC,
        'instance_count': INST,
        'files': files_meta,
    }
    with open(os.path.join(OUT, 'manifest.json'), 'w') as f:
        json.dump(manifest, f, indent=2)

    return {
        'written': [m['file'] for m in files_meta],
        'translations': inst_meta['translations'],
        'world_min': [round(v, 4) for v in minp],
        'world_max': [round(v, 4) for v in maxp],
    }

ctx.replay(work)
