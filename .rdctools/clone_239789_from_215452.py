import os, shutil

SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215452_PS215453_Batch'
DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS239789_PS239790_Batch'

FILES = [
    ('Editor/ColourPass6VS215452PS215453BatchImporter.cs', 'Editor/ColourPass6VS239789PS239790BatchImporter.cs'),
    ('Runtime/EID215452DrawProfile.cs', 'Runtime/EID239789DrawProfile.cs'),
    ('Shaders/EID215452215453GBuffer.shader', 'Shaders/EID239789239790GBuffer.shader'),
    ('Shaders/EID215452215453GBuffer.hlsl', 'Shaders/EID239789239790GBuffer.hlsl'),
]


def rewrite(text):
    text = text.replace('ColourPass6VS215452PS215453BatchImporter', 'ColourPass6VS239789PS239790BatchImporter')
    text = text.replace('ColourPass6_VS215452_PS215453_Batch', 'ColourPass6_VS239789_PS239790_Batch')
    text = text.replace('VS215452_PS215453', 'VS239789_PS239790')
    text = text.replace('EID215452215453GBuffer', 'EID239789239790GBuffer')
    text = text.replace('EID215452DrawProfile', 'EID239789DrawProfile')
    text = text.replace('EID215452Vertex', 'EID239789Vertex')
    text = text.replace('EID215453Fragment', 'EID239790Fragment')
    text = text.replace('Attributes215452', 'Attributes239789')
    text = text.replace('Varyings215452', 'Varyings239789')
    text = text.replace('GBufferOutput215453', 'GBufferOutput239790')
    text = text.replace('DecodeOctNormal215452', 'DecodeOctNormal239789')
    text = text.replace('DecodePackedTangent215452', 'DecodePackedTangent239789')
    text = text.replace('_EID215453MipBias', '_EID239790MipBias')
    text = text.replace('EID215452_215453_GBUFFER_INCLUDED', 'EID239789_239790_GBUFFER_INCLUDED')
    text = text.replace('VS215452', 'VS239789')
    text = text.replace('PS215453', 'PS239790')
    text = text.replace('215452', '239789')
    text = text.replace('215453', '239790')
    text = text.replace('static readonly int[] ExpectedEIDs = { 1717, 1721 };', 'static readonly int[] ExpectedEIDs = { 1727 };')
    text = text.replace('static readonly int ExpectedInstances = 2;', 'static readonly int ExpectedInstances = 1;')
    text = text.replace('34.1-34.2', '61.1')
    text = text.replace('7c0265b241eb3b8f', '9d869769087b15e3')
    text = text.replace('0.0019569471478462219', '0.0020')
    text = text.replace('0.0019569471478462219f', '0.0020f')
    text = text.replace('(1.0 / 1023.0)', '0.0010')
    text = text.replace('(1.0 / 3.0)', '0.3333')
    return text


def patch_shader(text):
    text = text.replace(
        '        _Res26 ("res26 RG 法线 Binding1", 2D) = "bump" {}\n        _Res27 ("res27 裁剪 Binding2", 2D) = "white" {}\n',
        '        _Res26 ("res26 RG 法线 Binding1", 2D) = "bump" {}\n',
    )
    text = text.replace('_P01 ("c01 child4-7 双面法线在 y", Vector) = (0,1,0,0)', '_P01 ("c01 child4-7 双面法线在 y", Vector) = (0,0,0,0)')
    text = text.replace('_P12 ("c12 child30 裁剪阈值在 x", Vector) = (0.5,0,0,0)', '_P12 ("c12 unused clip slot", Vector) = (0,0,0,0)')
    text = text.replace(
        'Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="TransparentCutout" "Queue"="AlphaTest" }',
        'Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }',
    )
    text = text.replace('            Cull Back\n            ZWrite On\n            ZTest LEqual\n', '            Cull Off\n            ZWrite On\n            ZTest GEqual\n')
    text = text.replace(
        'Stencil { Ref 36 Comp Always Pass Replace ReadMask 255 WriteMask 255 }',
        'Stencil { Ref 52 Comp GEqual Pass Replace ReadMask 16 WriteMask 239 }',
    )
    return text


def patch_hlsl(text):
    text = text.replace('TEXTURE2D(_Res26); SAMPLER(sampler_Res26);\nTEXTURE2D(_Res27); SAMPLER(sampler_Res27);\n', 'TEXTURE2D(_Res26); SAMPLER(sampler_Res26);\n')
    text = text.replace(
        '''    float clipSample = SAMPLE_TEXTURE2D_BIAS(_Res27, sampler_Res27, input.uv, _EID239790MipBias).x;
    clip(clipSample - _P12.x);

    float2 nxy = SAMPLE_TEXTURE2D_BIAS(_Res26, sampler_Res26, input.uv, _EID239790MipBias).xy * 2.0 - 1.0;
''',
        '''    float2 nxy = SAMPLE_TEXTURE2D_BIAS(_Res26, sampler_Res26, input.uv, _EID239790MipBias).xy * 2.0 - 1.0;
''',
    )
    return text


def patch_importer(text):
    text = text.replace(
        '        if (Rid(p, "res25") == 0 || Rid(p, "res26") == 0 || Rid(p, "res27") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res25/res26/res27.");',
        '        if (Rid(p, "res25") == 0 || Rid(p, "res26") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res25/res26.");',
    )
    text = text.replace(
        '        Texture albedo = LoadTexture(p, "res25");\n        Texture normalTex = LoadTexture(p, "res26");\n        Texture clipTex = LoadTexture(p, "res27");\n        if (albedo == null || normalTex == null || clipTex == null)\n            throw new FileNotFoundException("EID" + p.eid + " res25/res26/res27 texture binding is incomplete.");\n        m.SetTexture("_Res25", albedo);\n        m.SetTexture("_Res26", normalTex);\n        m.SetTexture("_Res27", clipTex);\n',
        '        Texture albedo = LoadTexture(p, "res25");\n        Texture normalTex = LoadTexture(p, "res26");\n        if (albedo == null || normalTex == null)\n            throw new FileNotFoundException("EID" + p.eid + " res25/res26 texture binding is incomplete.");\n        m.SetTexture("_Res25", albedo);\n        m.SetTexture("_Res26", normalTex);\n',
    )
    text = text.replace(
        '        report.AppendLine("EID" + p.eid + ": material res25=RID" + Rid(p, "res25") + " res26=RID" + Rid(p, "res26") + " res27=RID" + Rid(p, "res27") + " PS uniforms24=" + local.Length + "B");',
        '        report.AppendLine("EID" + p.eid + ": material res25=RID" + Rid(p, "res25") + " res26=RID" + Rid(p, "res26") + " PS uniforms24=" + local.Length + "B");',
    )
    text = text.replace(
        'Cull Back; ZWrite On; stencil Ref 36; Queue AlphaTest clip; packed `_input2` on NORMAL.x; skin bake ssbo27 via uniforms25; RG normal; mip uniforms16',
        'Cull Off; ZWrite On; ZTest GEqual; stencil Ref 52 Comp GEqual ReadMask 16 WriteMask 239; Queue Geometry no clip; packed `_input2` on NORMAL.x oct 0.0020; packed decode 0.0010/0.3333; skin bake ssbo27 flags 52; RG normal; mip uniforms16',
    )
    text = text.replace('unique res25/res26/res27', 'unique res25/res26')
    text = text.replace(
        '        [MenuItem("Tools/Colour Pass 6/Import EID 61.1 (VS239789 PS239790)")]',
        '        [MenuItem("Tools/Colour Pass 6/Import EID 61.1 (VS239789 PS239790)")]',
    )
    # original menu still has 34.1-34.2 until 34.1-34.2 replace; after rewrite it becomes:
    # Tools/Colour Pass 6/Import EID 61.1 (VS239789 PS239790)  if we also replace the parenthetical
    text = text.replace(
        '[MenuItem("Tools/Colour Pass 6/Import EID 61.1 (VS239789 PS239790)")]',
        '[MenuItem("Tools/Colour Pass 6/Import EID 61.1 (VS239789 PS239790)")]',
    )
    return text


FOLDER_GUIDS = {
    '': '239789d4e5f647890abcde4455667700',
    'Editor': '239789d4e5f647890abcde4455667710',
    'Runtime': '239789d4e5f647890abcde4455667711',
    'Shaders': '239789d4e5f647890abcde4455667712',
    'Geometry': '239789d4e5f647890abcde4455667713',
    'Geometry/Meshes': '239789d4e5f647890abcde4455667714',
    'Captured': '239789d4e5f647890abcde4455667715',
    'Captured/Geometry': '239789d4e5f647890abcde4455667716',
    'Captured/CBuffers': '239789d4e5f647890abcde4455667717',
    'Captured/Instances': '239789d4e5f647890abcde4455667718',
    'Materials': '239789d4e5f647890abcde4455667719',
    'Profiles': '239789d4e5f647890abcde445566771a',
    'TextureDatabase': '239789d4e5f647890abcde445566771b',
}

FILE_GUIDS = {
    'Editor/ColourPass6VS239789PS239790BatchImporter.cs': ('239789d4e5f647890abcde4455667701', 'MonoImporter'),
    'Shaders/EID239789239790GBuffer.shader': ('239789d4e5f647890abcde4455667702', 'ShaderImporter'),
    'Shaders/EID239789239790GBuffer.hlsl': ('239789d4e5f647890abcde4455667703', 'ShaderIncludeImporter'),
    'Runtime/EID239789DrawProfile.cs': ('239789d4e5f647890abcde4455667704', 'MonoImporter'),
}

FOLDER_META = '''fileFormatVersion: 2
guid: {guid}
folderAsset: yes
DefaultImporter:
  externalObjects: {{}}
  userData:
  assetBundleName:
  assetBundleVariant:
'''

MONO_META = '''fileFormatVersion: 2
guid: {guid}
MonoImporter:
  externalObjects: {{}}
  serializedVersion: 2
  defaultReferences: []
  executionOrder: 0
  icon: {{instanceID: 0}}
  userData:
  assetBundleName:
  assetBundleVariant:
'''

SHADER_META = '''fileFormatVersion: 2
guid: {guid}
ShaderImporter:
  externalObjects: {{}}
  defaultTextures: []
  nonModifiableTextures: []
  userData:
  assetBundleName:
  assetBundleVariant:
'''

INCLUDE_META = '''fileFormatVersion: 2
guid: {guid}
ShaderIncludeImporter:
  externalObjects: {{}}
  userData:
  assetBundleName:
  assetBundleVariant:
'''


if os.path.isdir(DST):
    shutil.rmtree(DST)
os.makedirs(DST, exist_ok=True)

for rel_src, rel_dst in FILES:
    src = os.path.join(SRC, rel_src)
    dst = os.path.join(DST, rel_dst)
    os.makedirs(os.path.dirname(dst), exist_ok=True)
    text = rewrite(open(src, encoding='utf8').read())
    if rel_dst.endswith('.shader'):
        text = patch_shader(text)
    elif rel_dst.endswith('.hlsl'):
        text = patch_hlsl(text)
    elif rel_dst.endswith('BatchImporter.cs'):
        text = patch_importer(text)
    open(dst, 'w', encoding='utf8', newline='\n').write(text)
    print('wrote', rel_dst, os.path.getsize(dst))

for d in FOLDER_GUIDS:
    path = os.path.join(DST, d) if d else DST
    os.makedirs(path, exist_ok=True)
    meta_path = (DST + '.meta') if d == '' else os.path.join(DST, d + '.meta')
    open(meta_path, 'w', encoding='utf8', newline='\n').write(FOLDER_META.format(guid=FOLDER_GUIDS[d]))
    print('meta folder', d or '.', FOLDER_GUIDS[d])

for rel, (guid, kind) in FILE_GUIDS.items():
    path = os.path.join(DST, rel + '.meta')
    if kind == 'MonoImporter':
        body = MONO_META.format(guid=guid)
    elif kind == 'ShaderImporter':
        body = SHADER_META.format(guid=guid)
    else:
        body = INCLUDE_META.format(guid=guid)
    open(path, 'w', encoding='utf8', newline='\n').write(body)
    print('meta file', rel, guid)

os.makedirs(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/ColourPass6_VS239789', exist_ok=True)
print('ok')
