import json, math

SRC = 'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/EID3332_EID3336_Combined/Resources/EID3320VS/instance_matrices.json'
OUT = 'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/EID3332_EID3336_Combined/CapturedResources/EID3320/eid_3320_unity_instances.json'

with open(SRC) as f:
    mats = json.load(f)['matrices_row_major']

def vulkan_to_unity(M):
    # Scene uses capture space directly (camera handles -Z/+Z): no flip.
    return [row[:] for row in M]

def look_rotation(forward, up):
    # replicate Unity Quaternion.LookRotation(forward, up)
    def norm(v):
        l = math.sqrt(sum(x*x for x in v))
        return [x/l for x in v]
    def cross(a, b):
        return [a[1]*b[2]-a[2]*b[1], a[2]*b[0]-a[0]*b[2], a[0]*b[1]-a[1]*b[0]]
    def dot(a, b):
        return sum(x*y for x, y in zip(a, b))
    fwd = norm(forward)
    upn = norm(up)
    right = cross(upn, fwd)
    rl = math.sqrt(sum(x*x for x in right))
    if rl < 1e-8:
        # degenerate; fall back to identity-ish
        return [0,0,0,1]
    right = [x/rl for x in right]
    up2 = cross(fwd, right)
    # rotation matrix columns: [right, up2, fwd] -> matrix R[row][col]
    R = [
        [right[0], up2[0], fwd[0]],
        [right[1], up2[1], fwd[1]],
        [right[2], up2[2], fwd[2]],
    ]
    # matrix -> quaternion (Shepperd)
    m00, m01, m02 = R[0]
    m10, m11, m12 = R[1]
    m20, m21, m22 = R[2]
    tr = m00 + m11 + m22
    if tr > 0:
        s = math.sqrt(tr + 1.0) * 2
        w = 0.25 * s
        x = (m21 - m12) / s
        y = (m02 - m20) / s
        z = (m10 - m01) / s
    elif m00 > m11 and m00 > m22:
        s = math.sqrt(1.0 + m00 - m11 - m22) * 2
        w = (m21 - m12) / s
        x = 0.25 * s
        y = (m01 + m10) / s
        z = (m02 + m20) / s
    elif m11 > m22:
        s = math.sqrt(1.0 + m11 - m00 - m22) * 2
        w = (m02 - m20) / s
        x = (m01 + m10) / s
        y = 0.25 * s
        z = (m12 + m21) / s
    else:
        s = math.sqrt(1.0 + m22 - m00 - m11) * 2
        w = (m10 - m01) / s
        x = (m02 + m20) / s
        y = (m12 + m21) / s
        z = 0.25 * s
    return [x, y, z, w]

out = []
for i, M in enumerate(mats):
    U = vulkan_to_unity(M)
    # columns of U
    col0 = [U[0][0], U[1][0], U[2][0]]
    col1 = [U[0][1], U[1][1], U[2][1]]
    col2 = [U[0][2], U[1][2], U[2][2]]
    pos = [U[0][3], U[1][3], U[2][3]]
    def mag(v): return math.sqrt(sum(x*x for x in v))
    scale = [mag(col0), mag(col1), mag(col2)]
    # LookRotation(forward=col2, up=col1)
    q = look_rotation(col2, col1)
    out.append({
        'instance': i,
        'unity_position': [round(v, 6) for v in pos],
        'unity_scale': [round(v, 6) for v in scale],
        'unity_rotation_quaternion_xyzw': [round(v, 6) for v in q],
        'unity_matrix_row_major': [[round(v, 6) for v in row] for row in U],
    })

with open(OUT, 'w') as f:
    json.dump({'coordinate_space': 'capture (Vulkan, -Z front; used directly by scene)', 'instances': out}, f, indent=2)

for o in out:
    print(o['instance'], 'pos=', o['unity_position'], 'scale=', o['unity_scale'], 'q=', o['unity_rotation_quaternion_xyzw'])
