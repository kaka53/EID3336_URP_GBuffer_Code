import os

ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215553_PS215554_Batch/TextureDatabase'

DDS = [
    ('rid268030.dds', '215553d4e5f647890abcde4455667711', 1),  # BC7_SRGB res23
    ('rid276749.dds', '215553d4e5f647890abcde4455667712', 0),  # BC7_UNORM res25
]


def meta(guid, srgb):
    return (
        'fileFormatVersion: 2\n'
        'guid: %s\n'
        'IHVImageFormatImporter:\n'
        '  externalObjects: {}\n'
        '  textureSettings:\n'
        '    serializedVersion: 2\n'
        '    filterMode: 1\n'
        '    aniso: 1\n'
        '    mipBias: 0\n'
        '    wrapU: 0\n'
        '    wrapV: 0\n'
        '    wrapW: 0\n'
        '  isReadable: 0\n'
        '  sRGBTexture: %d\n'
        '  streamingMipmaps: 0\n'
        '  streamingMipmapsPriority: 0\n'
        '  ignoreMipmapLimit: 0\n'
        '  mipmapLimitGroupName:\n'
        '  userData:\n'
        '  assetBundleName:\n'
        '  assetBundleVariant:\n' % (guid, srgb)
    )


bad = []
for name, guid, srgb in DDS:
    if len(guid) != 32:
        bad.append((name, guid, len(guid)))
    path = os.path.join(ROOT, name)
    if not os.path.exists(path):
        raise SystemExit('missing ' + path)
    open(path + '.meta', 'w', encoding='utf8', newline='\n').write(meta(guid, srgb))
    print('wrote', name + '.meta', 'sRGB', srgb, os.path.getsize(path))
print('bad', bad)
print('ok')
