import struct, hashlib, json, os

OUT_DIR = 'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/EID3332_EID3336_Combined/Resources/EID3320CB'

def rid_for(controller, target):
    for b in controller.GetBuffers():
        if int(b.resourceId) == target:
            return b.resourceId
    raise RuntimeError('buffer %d not found' % target)

def work(controller):
    controller.SetFrameEvent(3320, True)
    r603 = rid_for(controller, 603)
    # PS_uniforms44: 45 float4 = 720 bytes @ 603, offset 685568
    data = bytes(controller.GetBufferData(r603, 685568, 720))
    os.makedirs(OUT_DIR, exist_ok=True)
    with open(os.path.join(OUT_DIR, '_43_44.bytes'), 'wb') as f:
        f.write(data)
    floats = struct.unpack_from('<%df' % 180, data, 0)
    vecs = [list(floats[i*4:i*4+4]) for i in range(5)]
    return {
        'size': len(data),
        'sha256': hashlib.sha256(data).hexdigest(),
        'first_5_vec4': vecs,
    }

ctx.replay(work)
