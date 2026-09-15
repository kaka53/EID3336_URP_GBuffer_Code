import os
import hashlib
import struct

root = r"D:/endcopy/EID3336_URP_GBuffer_Workspace"
batch = os.path.join(root, "Assets/ColourPass6_VS215841_PS215842_Batch")


def guid_for(rel):
    rel = rel.replace("\\", "/")
    return hashlib.md5(("eid215841-ps215842:" + rel).encode("utf-8")).hexdigest()


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
cs_tmpl = """fileFormatVersion: 2
guid: {g}
MonoImporter:
  externalObjects: {{}}
  serializedVersion: 2
  defaultReferences: []
  executionOrder: 0
  icon: {{instanceID: 0}}
  userData:
  assetBundleName:
  assetBundleVariant:
"""
shader_tmpl = """fileFormatVersion: 2
guid: {g}
ShaderImporter:
  externalObjects: {{}}
  defaultTextures: []
  nonModifiableTextures: []
  userData:
  assetBundleName:
  assetBundleVariant:
"""
hlsl_tmpl = """fileFormatVersion: 2
guid: {g}
ShaderIncludeImporter:
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
    filterMode: {filter}
    aniso: 1
    mipBias: 0
    wrapU: {wrap}
    wrapV: {wrap}
    wrapW: {wrap}
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
    "Assets/ColourPass6_VS215841_PS215842_Batch",
    "Assets/ColourPass6_VS215841_PS215842_Batch/Captured",
    "Assets/ColourPass6_VS215841_PS215842_Batch/Captured/Geometry",
    "Assets/ColourPass6_VS215841_PS215842_Batch/Captured/CBuffers",
    "Assets/ColourPass6_VS215841_PS215842_Batch/Captured/Instances",
    "Assets/ColourPass6_VS215841_PS215842_Batch/Shaders",
    "Assets/ColourPass6_VS215841_PS215842_Batch/Runtime",
    "Assets/ColourPass6_VS215841_PS215842_Batch/Editor",
    "Assets/ColourPass6_VS215841_PS215842_Batch/TextureDatabase",
    "Assets/ColourPass6_VS215841_PS215842_Batch/Geometry",
    "Assets/ColourPass6_VS215841_PS215842_Batch/Geometry/Meshes",
    "Assets/ColourPass6_VS215841_PS215842_Batch/Materials",
    "Assets/ColourPass6_VS215841_PS215842_Batch/Profiles",
]
n_folder = 0
for rel in folders:
    absdir = os.path.join(root, rel)
    os.makedirs(absdir, exist_ok=True)
    if write_if_missing(absdir + ".meta", folder_tmpl.format(g=guid_for(rel))):
        n_folder += 1

n_cs = 0
for rel, tmpl in [
    ("Assets/ColourPass6_VS215841_PS215842_Batch/Runtime/EID215841DrawProfile.cs", cs_tmpl),
    ("Assets/ColourPass6_VS215841_PS215842_Batch/Runtime/EID215841InstanceBinder.cs", cs_tmpl),
    ("Assets/ColourPass6_VS215841_PS215842_Batch/Editor/ColourPass6VS215841PS215842BatchImporter.cs", cs_tmpl),
    ("Assets/ColourPass6_VS215841_PS215842_Batch/Shaders/EID215841215842GBuffer.shader", shader_tmpl),
    ("Assets/ColourPass6_VS215841_PS215842_Batch/Shaders/EID215841215842GBuffer.hlsl", hlsl_tmpl),
]:
    if write_if_missing(os.path.join(root, rel + ".meta"), tmpl.format(g=guid_for(rel))):
        n_cs += 1

n_bytes = 0
for sub in ["Captured/Geometry", "Captured/CBuffers", "Captured/Instances", "Shaders"]:
    d = os.path.join(batch, sub)
    if not os.path.isdir(d):
        continue
    for fn in sorted(os.listdir(d)):
        if not (fn.endswith(".bytes") or fn.endswith(".spv") or fn.endswith(".spvasm") or fn.endswith(".json")):
            continue
        rel = sub + "/" + fn
        if write_if_missing(os.path.join(d, fn + ".meta"), text_tmpl.format(g=guid_for(rel))):
            n_bytes += 1

manifest = os.path.join(batch, "VS215841_PS215842_BatchManifest.json")
if os.path.exists(manifest):
    write_if_missing(manifest + ".meta", text_tmpl.format(g=guid_for("VS215841_PS215842_BatchManifest.json")))

DXGI_SRGB = {29, 91, 99}


def dds_info(path):
    with open(path, "rb") as f:
        data = f.read(148)
    if len(data) < 148 or data[:4] != b"DDS ":
        return 0, 1, 0
    fourcc = data[84:88]
    if fourcc == b"DX10":
        fmt = struct.unpack_from("<I", data, 128)[0]
        srgb = 1 if fmt in DXGI_SRGB else 0
        wrap = 2 if srgb else 0
        filt = 1 if srgb else 0
        return srgb, filt, wrap
    return 0, 1, 0


n_dds = 0
tex = os.path.join(batch, "TextureDatabase")
if os.path.isdir(tex):
    for fn in sorted(os.listdir(tex)):
        if not fn.lower().endswith(".dds"):
            continue
        path = os.path.join(tex, fn)
        rel = "TextureDatabase/" + fn
        srgb, filt, wrap = dds_info(path)
        if write_if_missing(path + ".meta", dds_tmpl.format(g=guid_for(rel), srgb=srgb, filter=filt, wrap=wrap)):
            n_dds += 1

print("newFolderMetas", n_folder)
print("newScriptMetas", n_cs)
print("newBytesMetas", n_bytes)
print("newDdsMetas", n_dds)
