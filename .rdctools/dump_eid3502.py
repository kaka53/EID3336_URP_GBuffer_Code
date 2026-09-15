import json
import os
import struct

root = r"D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS209988_PS209989_Batch"
man = json.load(open(os.path.join(root, "VS209988_PS209989_BatchManifest.json"), encoding="utf-8"))
p = next(x for x in man["profiles"] if x["eid"] == 3502)
print("draw", p["draw"], "v", p["vertexCount"], "strideIdx", p["sourceIndexStride"])
print("files", p.get("files"))
print("streams", [(s["slot"], s.get("sourceStride"), s.get("file")) for s in p["streams"]])


def read(rel):
    path = os.path.join(root, rel.replace("\\", "/"))
    with open(path, "rb") as f:
        return f.read()


files = p.get("files") or {}
idxrel = files.get("indices", {})
if isinstance(idxrel, dict):
    idxrel = idxrel.get("file")
sidx = files.get("sourceIndices", {})
if isinstance(sidx, dict):
    sidx = sidx.get("file")
print("indices file", idxrel, "source", sidx)

for s in p["streams"]:
    rel = s["file"]["file"] if isinstance(s["file"], dict) else s["file"]
    b = read(rel)
    print("stream slot", s["slot"], "stride", s.get("sourceStride"), "bytes", len(b), "file", rel)

ib = read(idxrel)
print("indices bytes", len(ib), "count*4", p["draw"]["indexCount"] * 4, "count*2", p["draw"]["indexCount"] * 2)
print("first 6 u32", struct.unpack_from("<6I", ib))
print("first 12 u16", struct.unpack_from("<12H", ib))
print("max u32 first 32", max(struct.unpack_from("<32I", ib)))
print("max u16 first 32", max(struct.unpack_from("<32H", ib)))

s0 = next(s for s in p["streams"] if s["slot"] == 0)
s1 = next(s for s in p["streams"] if s["slot"] == 1)
b0 = read(s0["file"]["file"] if isinstance(s0["file"], dict) else s0["file"])
b1 = read(s1["file"]["file"] if isinstance(s1["file"], dict) else s1["file"])
print("s0 bytes", len(b0), "expect", p["vertexCount"] * 16)
print("s1 bytes", len(b1), "expect", p["vertexCount"] * 16)
uv0_minmax = [1e9, -1e9, 1e9, -1e9]
uv1_minmax = [1e9, -1e9, 1e9, -1e9]
packed_bit30 = 0
for v in range(p["vertexCount"]):
    x, y, z, packed_f = struct.unpack_from("<4f", b0, v * 16)
    pu = struct.unpack_from("<I", b0, v * 16 + 12)[0]
    uv0 = struct.unpack_from("<2f", b1, v * 16)
    uv1 = struct.unpack_from("<2f", b1, v * 16 + 8)
    if pu & 0x40000000:
        packed_bit30 += 1
    uv0_minmax[0] = min(uv0_minmax[0], uv0[0])
    uv0_minmax[1] = max(uv0_minmax[1], uv0[0])
    uv0_minmax[2] = min(uv0_minmax[2], uv0[1])
    uv0_minmax[3] = max(uv0_minmax[3], uv0[1])
    uv1_minmax[0] = min(uv1_minmax[0], uv1[0])
    uv1_minmax[1] = max(uv1_minmax[1], uv1[0])
    uv1_minmax[2] = min(uv1_minmax[2], uv1[1])
    uv1_minmax[3] = max(uv1_minmax[3], uv1[1])
    if v < 4:
        print("v", v, "pos", (round(x, 4), round(y, 4), round(z, 4)), "packed", hex(pu), "bit30", bool(pu & 0x40000000), "uv0", uv0, "uv1", uv1)
print("packed_bit30", packed_bit30, "/", p["vertexCount"])
print("uv0 minmax u,v", uv0_minmax)
print("uv1 minmax u,v", uv1_minmax)

for cb in p["constantBuffers"]["PS"]:
    if cb["name"] == "uniforms43":
        b = read(cb["file"]["file"] if isinstance(cb["file"], dict) else cb["file"])
        print("u43 bytes", len(b))
        for i in range(45):
            f = struct.unpack_from("<4f", b, i * 16)
            print("c%02d" % i, tuple(round(x, 6) for x in f))
    if cb["name"] == "uniforms45":
        b45 = read(cb["file"]["file"] if isinstance(cb["file"], dict) else cb["file"])
        print("u45", struct.unpack_from("<4f", b45), "bytes", len(b45))
    if cb["name"] == "uniforms21":
        b21 = read(cb["file"]["file"] if isinstance(cb["file"], dict) else cb["file"])
        print("mip21@416", struct.unpack_from("<f", b21, 416)[0])
