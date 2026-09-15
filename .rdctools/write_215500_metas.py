import os
import hashlib
import struct

root = r"D:/endcopy/EID3336_URP_GBuffer_Workspace"
batch = os.path.join(root, "Assets/ColourPass6_VS215500_PS215502_Batch")


def guid_for(rel):
    rel = rel.replace("\\", "/")
    return hashlib.md5(("eid215500-ps215502:" + rel).encode("utf-8")).hexdigest()


def write_if_missing(path, content):
    if os.path.exists(path):
        return False
    folder = os.path.dirname(path)
    if folder:
        os.makedirs(folder, exist_ok=True)
    with open(path, "w", newline="\n", encoding="utf-8") as f:
        f.write(content)
    return True


folder_tmpl = """fileFormatVersion: 2
guid: {g}
folderAsset: yes
DefaultImporter:
  externalObjects: {{}}
  userData:
  assetBundleName:
  assetBundleVariant:
"""
text_tmpl = """fileFormatVersion: 2
guid: {g}
TextScriptImporter:
  externalObjects: {{}}
  userData:
  assetBundleName:
  assetBundleVariant:
"""
dds_tmpl = """fileFormatVersion: 2
guid: {g}
IHVImageFormatImporter:
  externalObjects: {{}}
  textureSettings:
    serializedVersion: 2
    filterMode: 1
    aniso: 1
    mipBias: 0
    wrapU: 0
    wrapV: 0
    wrapW: 0
  isReadable: 0
  sRGBTexture: {srgb}
  streamingMipmaps: 0
  streamingMipmapsPriority: 0
  ignoreMipmapLimit: 0
  mipmapLimitGroupName:
  userData:
  assetBundleName:
  assetBundleVariant:
"""

folders = [
    "Assets/ColourPass6_VS215500_PS215502_Batch",
    "Assets/ColourPass6_VS215500_PS215502_Batch/Captured",
    "Assets/ColourPass6_VS215500_PS215502_Batch/Captured/Geometry",
    "Assets/ColourPass6_VS215500_PS215502_Batch/Captured/CBuffers",
    "Assets/ColourPass6_VS215500_PS215502_Batch/Shaders",
    "Assets/ColourPass6_VS215500_PS215502_Batch/Runtime",
    "Assets/ColourPass6_VS215500_PS215502_Batch/Editor",
    "Assets/ColourPass6_VS215500_PS215502_Batch/TextureDatabase",
    "Assets/ColourPass6_VS215500_PS215502_Batch/Geometry",
    "Assets/ColourPass6_VS215500_PS215502_Batch/Geometry/Meshes",
    "Assets/ColourPass6_VS215500_PS215502_Batch/Materials",
    "Assets/ColourPass6_VS215500_PS215502_Batch/Profiles",
]
n_folder = 0
for rel in folders:
    absdir = os.path.join(root, rel)
    os.makedirs(absdir, exist_ok=True)
    if write_if_missing(absdir + ".meta", folder_tmpl.format(g=guid_for(rel))):
        n_folder += 1

n_bytes = 0
for sub in ["Captured/Geometry", "Captured/CBuffers"]:
    d = os.path.join(batch, sub)
    if not os.path.isdir(d):
        continue
    for fn in sorted(os.listdir(d)):
        if not fn.endswith(".bytes"):
            continue
        rel = sub + "/" + fn
        if write_if_missing(os.path.join(d, fn + ".meta"), text_tmpl.format(g=guid_for(rel))):
            n_bytes += 1

DXGI_BC7_UNORM_SRGB = 99
DXGI_BC7_UNORM = 98
DXGI_BC5_UNORM = 83


def dds_srgb(path):
    with open(path, "rb") as f:
        data = f.read(148)
    if len(data) < 148 or data[:4] != b"DDS ":
        return 0
    fourcc = data[84:88]
    if fourcc == b"DX10":
        fmt = struct.unpack_from("<I", data, 128)[0]
        return 1 if fmt == DXGI_BC7_UNORM_SRGB else 0
    return 0


n_dds = 0
tex = os.path.join(batch, "TextureDatabase")
for fn in sorted(os.listdir(tex)):
    if not fn.lower().endswith(".dds"):
        continue
    path = os.path.join(tex, fn)
    rel = "TextureDatabase/" + fn
    srgb = dds_srgb(path)
    if write_if_missing(path + ".meta", dds_tmpl.format(g=guid_for(rel), srgb=srgb)):
        n_dds += 1

print("newFolderMetas", n_folder)
print("newBytesMetas", n_bytes)
print("newDdsMetas", n_dds)
