import os, shutil, re

SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215539_PS215540_Batch'
DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS264371_PS264372_Batch'
VAL = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/ColourPass6_VS264371'

FILES = [
    ('Editor/ColourPass6VS215539PS215540BatchImporter.cs', 'Editor/ColourPass6VS264371PS264372BatchImporter.cs'),
    ('Runtime/EID215539DrawProfile.cs', 'Runtime/EID264371DrawProfile.cs'),
]


def rewrite(text):
    text = text.replace('ColourPass6VS215539PS215540BatchImporter', 'ColourPass6VS264371PS264372BatchImporter')
    text = text.replace('ColourPass6_VS215539_PS215540_Batch', 'ColourPass6_VS264371_PS264372_Batch')
    text = text.replace('VS215539_PS215540', 'VS264371_PS264372')
    text = text.replace('EID215539215540GBuffer', 'EID264371264372GBuffer')
    text = text.replace('EID215539DrawProfile', 'EID264371DrawProfile')
    text = text.replace('EID215539Vertex', 'EID264371Vertex')
    text = text.replace('EID215540Fragment', 'EID264372Fragment')
    text = text.replace('_EID215540MipBias', '_EID264372MipBias')
    text = text.replace('VS215539', 'VS264371')
    text = text.replace('PS215540', 'PS264372')
    text = text.replace('215539', '264371')
    text = text.replace('215540', '264372')
    text = text.replace('static readonly int[] ExpectedEIDs = { 3669, 3674 };', 'static readonly int[] ExpectedEIDs = { 3612 };')
    text = text.replace('static readonly int ExpectedInstances = 2;', 'static readonly int ExpectedInstances = 3;')
    text = text.replace('static readonly int ExpectedLayoutVariants = 2;', 'static readonly int ExpectedLayoutVariants = 1;')
    text = text.replace('42.1-42.2', '65.1')
    text = text.replace('Import EID 65.1 (VS264371 PS264372)', 'Import EID 65.1 (VS264371 PS264372)')
    return text


def patch_importer(text):
    text = text.replace(
        '        if (Rid(p, "res27") == 0 || Rid(p, "res29") == 0 || Rid(p, "res31") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res27/res29/res31.");\n        byte[] local = ReadCB(p, "PS", "uniforms33");\n        if (local.Length < 448) throw new InvalidDataException("EID" + p.eid + " PS uniforms33 expected 448 bytes, got " + local.Length);',
        '        if (Rid(p, "res23") == 0 || Rid(p, "res25") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res23/res25.");\n        byte[] local = ReadCB(p, "PS", "uniforms28");\n        if (local.Length < 384) throw new InvalidDataException("EID" + p.eid + " PS uniforms28 expected 384 bytes, got " + local.Length);',
    )
    text = text.replace(
        '        byte[] overlay = ReadCB(p, "PS", "uniforms23");\n        if (overlay.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " PS uniforms23 too small: " + overlay.Length);',
        '        byte[] overlay = ReadCB(p, "PS", "uniforms20");\n        if (overlay.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " PS uniforms20 too small: " + overlay.Length);',
    )
    text = text.replace(
        '        byte[] local = ReadCB(p, "PS", "uniforms33");\n        for (int i = 0; i < 28; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms35");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));',
        '        byte[] local = ReadCB(p, "PS", "uniforms28");\n        for (int i = 0; i < 24; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms30");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));',
    )
    text = text.replace(
        '        byte[] globals = ReadCB(p, "PS", "uniforms20");\n        m.SetFloat("_EID264372MipBias", ReadFloat(globals, 416));',
        '        byte[] globals = ReadCB(p, "PS", "uniforms17");\n        m.SetFloat("_EID264372MipBias", ReadFloat(globals, 416));',
    )
    text = text.replace(
        '        Texture albedo = LoadTexture(p, "res27");\n        Texture normalTex = LoadTexture(p, "res29");\n        Texture extraTex = LoadTexture(p, "res31");\n        if (albedo == null || normalTex == null || extraTex == null)\n            throw new FileNotFoundException("EID" + p.eid + " res27/res29/res31 texture binding is incomplete.");\n        m.SetTexture("_Res27", albedo);\n        m.SetTexture("_Res29", normalTex);\n        m.SetTexture("_Res31", extraTex);',
        '        Texture albedo = LoadTexture(p, "res23");\n        Texture normalTex = LoadTexture(p, "res25");\n        if (albedo == null || normalTex == null)\n            throw new FileNotFoundException("EID" + p.eid + " res23/res25 texture binding is incomplete.");\n        m.SetTexture("_Res23", albedo);\n        m.SetTexture("_Res25", normalTex);',
    )
    text = text.replace(
        '        report.AppendLine("EID" + p.eid + ": material res27=RID" + Rid(p, "res27") + " res29=RID" + Rid(p, "res29") + " res31=RID" + Rid(p, "res31") + " PS uniforms33=" + local.Length + "B");',
        '        report.AppendLine("EID" + p.eid + ": material res23=RID" + Rid(p, "res23") + " res25=RID" + Rid(p, "res25") + " PS uniforms28=" + local.Length + "B");',
    )
    text = text.replace(
        '        byte[] overlay = ReadCB(p, "PS", "uniforms23");\n        int o = instance * 256;',
        '        byte[] overlay = ReadCB(p, "PS", "uniforms20");\n        int o = instance * 256;',
    )
    text = text.replace(
        'audit.Insert(0, "# VS264371 / PS264372 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `65.1`\\n- Layout variants: `" + layouts + "` (`254e776650e421f4`, `f99e10ea87e933cd`)\\n- Shader: live Unity VP; unique res27/res29/res31; PS uniforms33 448B; Cull Off; ZWrite Off; ZTest Equal; stencil 0; skip skin (flags 0); extra map + distance fade; isolate from family 65\\n\\n");',
        'audit.Insert(0, "# VS264371 / PS264372 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `65.1`\\n- Layout variants: `" + layouts + "` (`254e776650e421f4`)\\n- Shader: live Unity VP; unique res23/res25; PS uniforms28 384B; Cull Off; ZWrite Off; ZTest Equal; stencil 0; skip skin (flags 0); wrap only no extra map; isolate from family 42\\n\\n");',
    )
    return text


P_PROPS = '\n'.join(
    '        _P%02d ("c%02d 捕获局部参数", Vector) = (0,0,0,0)' % (i, i)
    for i in range(24)
)

SHADER = r'''Shader "EID/URP/VS264371_PS264372_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res23 ("res23 基础颜色 Binding3", 2D) = "white" {}
        _Res25 ("res25 切线法线 Binding2", 2D) = "bump" {}
        [Header(RenderDoc_PS_uniforms28_c00_c23)]
''' + P_PROPS + r'''
        _InstanceMeta ("uniforms30 实例材质元数据", Vector) = (0,0,0,0)
        _InstanceStateYZ ("uniforms20 child1.yz + child5.x", Vector) = (0,0,0,0)
        _EID264372MipBias ("uniforms17 全局纹理 Mip Bias", Float) = 0
        _UseBakedSkinning ("Captured ssbo skin baked into VSInput", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry+10" }
        Pass
        {
            Name "VS264371_PS264372_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Off
            ZWrite Off
            ZTest Equal
            Blend Off
            Stencil { Ref 0 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID264371Vertex
            #pragma fragment EID264372Fragment
            #include "EID264371264372GBuffer.hlsl"
            ENDHLSL
        }
    }
}
'''

HLSL = r'''#ifndef EID264371_264372_GBUFFER_INCLUDED
#define EID264371_264372_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_Res23); SAMPLER(sampler_Res23);
TEXTURE2D(_Res25); SAMPLER(sampler_Res25);

CBUFFER_START(UnityPerMaterial)
float4 _P00; float4 _P01; float4 _P02; float4 _P03;
float4 _P04; float4 _P05; float4 _P06; float4 _P07;
float4 _P08; float4 _P09; float4 _P10; float4 _P11;
float4 _P12; float4 _P13; float4 _P14; float4 _P15;
float4 _P16; float4 _P17; float4 _P18; float4 _P19;
float4 _P20; float4 _P21; float4 _P22; float4 _P23;
float4 _InstanceMeta;
float4 _InstanceStateYZ;
float _EID264372MipBias;
float _UseBakedSkinning;
CBUFFER_END

struct Attributes264371
{
    float3 position : POSITION;
    float4 packedNormal : NORMAL;
    float4 input2 : COLOR0;
    float4 input3 : TANGENT;
    float2 input4 : TEXCOORD0;
    float2 input5 : TEXCOORD1;
    float4 input7 : TEXCOORD3;
    uint4 input8 : BLENDINDICES0;
    float3 bakedNormalOS : TEXCOORD4;
    float4 bakedTangentOS : TEXCOORD5;
};

struct Varyings264371
{
    float4 positionCS : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    float2 uv1 : TEXCOORD1;
    float3 positionWS : TEXCOORD2;
    float3 normalWS : TEXCOORD3;
    float4 tangentWS : TEXCOORD4;
    float3 currentClipXYW : TEXCOORD5;
    float3 previousClipXYW : TEXCOORD6;
};

float3 DecodeOctNormal264371(uint packed)
{
    float x = float((packed << 22u) >> 22u);
    float y = float((packed << 12u) >> 22u);
    x = (x >= 512.0) ? x - 1024.0 : x;
    y = (y >= 512.0) ? y - 1024.0 : y;
    float3 n = float3(x, y, 0.0) * 0.0020;
    n.z = 1.0 - abs(n.x) - abs(n.y);
    if (n.z < 0.0)
        n.xy = (1.0 - abs(n.yx)) * (step(0.0, n.xy) * 2.0 - 1.0);
    return normalize(n);
}

float4 DecodePackedTangent264371(uint packed, float3 n)
{
    float signed10 = float((packed << 2u) >> 22u);
    signed10 = ((signed10 >= 512.0) ? signed10 - 1024.0 : signed10) * 0.0020;
    float3 seed = n.yzx - n.zxy;
    float3 t0 = normalize(seed - dot(seed, n).xxx);
    float tangentSign = signed10 < 0.0 ? -1.0 : 1.0;
    float encoded = 1.0 - ((signed10 * tangentSign) * 2.0);
    float2 r = normalize(float2(encoded, tangentSign * (1.0 - abs(encoded))));
    float3 t1 = normalize(cross(n, t0));
    float3 t = mul(r, float2x3(t0, t1));
    return float4(t, float((packed >> 31u) & 1u) * 2.0 - 1.0);
}

float2 FilterNormalXY264371(float2 raw)
{
    float2 nxy = raw * 2.0 - 1.0;
    return abs(nxy) < 0.012.xx ? 0.0.xx : nxy;
}

Varyings264371 EID264371Vertex(Attributes264371 input)
{
    Varyings264371 o;
    uint packed = asuint(input.packedNormal.x);
    bool packedBasis = (packed & 0x40000000u) != 0u;
    float3 decodedNormalOS = packedBasis ? DecodeOctNormal264371(packed) : input.packedNormal.xyz;
    float4 decodedTangentOS = packedBasis ? DecodePackedTangent264371(packed, decodedNormalOS) : input.input2;
    float3 normalOS = _UseBakedSkinning > 0.5 ? input.bakedNormalOS : decodedNormalOS;
    float4 tangentOS = _UseBakedSkinning > 0.5 ? input.bakedTangentOS : decodedTangentOS;

    float3 positionWS = TransformObjectToWorld(input.position);
    float3 normalWS = normalize(TransformObjectToWorldNormal(normalOS));
    float3 tangentWS = normalize(TransformObjectToWorldDir(tangentOS.xyz));
    float4 clip = TransformWorldToHClip(positionWS);

    o.positionCS = clip;
    o.uv0 = input.input4;
    o.uv1 = input.input5;
    o.positionWS = positionWS;
    o.normalWS = normalWS;
    o.tangentWS = float4(tangentWS, tangentOS.w * GetOddNegativeScale());
    o.currentClipXYW = clip.xyw;
    o.previousClipXYW = clip.xyw;
    return o;
}

struct GBufferOutput264372
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput264372 EID264372Fragment(Varyings264371 input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput264372 o;
    float tangentInputSign = input.tangentWS.w > 0.0 ? 1.0 : -1.0;
    float mip = _EID264372MipBias;
    float2 uvAlbedo = lerp(input.uv0, input.uv1, _P02.w) * _P11.xy + _P11.zw;
    float2 uvNormal = lerp(input.uv0, input.uv1, _P03.x) * _P12.xy + _P12.zw;
    float4 albedoSample = SAMPLE_TEXTURE2D_BIAS(_Res23, sampler_Res23, uvAlbedo, mip);
    float4 normalSample = SAMPLE_TEXTURE2D_BIAS(_Res25, sampler_Res25, uvNormal, _P03.y + mip);

    float2 nxy = FilterNormalXY264371(normalSample.xy);
    float nz = sqrt(saturate(1.0 - dot(nxy, nxy)));
    float3 baseColor = lerp(saturate(albedoSample.rgb * _P08.rgb * _P04.z), _P08.rgb, _P04.x);
    float roughness = lerp(_P00.z, _P00.w, normalSample.z);
    float materialY = lerp(albedoSample.a, _P04.y, saturate(_P03.w - 1.0));
    float ao = lerp(1.0, normalSample.w, _P01.x);

    float faceSign = isFrontFace ? 1.0 : (_P01.w > 0.0 ? -1.0 : 1.0);
    float3 n = normalize(input.normalWS);
    float3 tdir = normalize(input.tangentWS.xyz);
    float3 b = normalize(cross(n, tdir)) * tangentInputSign;
    float3 normalWS = normalize(tdir * (nxy.x * _P00.x) + b * (nxy.y * _P00.x) + n * (nz * faceSign));

    uint materialId = (uint)_InstanceMeta.w;
    float materialZ = saturate(_P04.w * roughness + _P05.y * materialY + _P05.x) * 0.95 + 0.05;
    materialZ *= (1.0 - _P07.y);
    float active = saturate(float((int)sign(max(_InstanceStateYZ.x, _InstanceStateYZ.y) - 0.1)));

    float2 motion = input.currentClipXYW.xy / max(input.currentClipXYW.z, 1e-8) - input.previousClipXYW.xy / max(input.previousClipXYW.z, 1e-8);
    motion.y = -motion.y;
    float2 encodedMotion = lerp(sqrt(sqrt(abs(motion * 0.5))) * (float2)(int2)sign(motion) * 0.5 + 0.5, 0.5.xx, active.xx);
    float motionWeight = lerp(0.0, 0.7, active);

    float3 octN = normalize(normalWS);
    float2 oct = octN.xz / dot(1.0.xxx, abs(octN));
    if (octN.y <= 0.0)
        oct = (1.0 - abs(oct.yx)) * (step(0.0, oct) * 2.0 - 1.0);
    oct = oct * 0.5 + 0.5;

    o.rt0 = float4(0.0, 0.0, 0.0, 0.5);
    o.rt1 = float4(encodedMotion, motionWeight > 0.0 ? 1.0 : _P07.x, motionWeight);
    o.rt2 = float4(materialY, ao, materialZ, float(materialId / 4u) * 0.3333333433);
    o.rt3 = float4(oct, roughness, float(materialId % 4u) * 0.3333333433);
    o.rt4 = float4(baseColor, 0.0);
    return o;
}

#endif
'''

FOLDER_GUIDS = {
    '': '264371d4e5f647890abcde4455667700',
    'Editor': '264371d4e5f647890abcde4455667705',
    'Runtime': '264371d4e5f647890abcde4455667706',
    'Shaders': '264371d4e5f647890abcde4455667707',
    'Captured': '264371d4e5f647890abcde4455667708',
    'Geometry': '264371d4e5f647890abcde4455667709',
    'Materials': '264371d4e5f647890abcde445566770a',
    'Profiles': '264371d4e5f647890abcde445566770b',
    'TextureDatabase': '264371d4e5f647890abcde445566770c',
    'Geometry/Meshes': '264371d4e5f647890abcde445566770d',
    'Captured/Geometry': '264371d4e5f647890abcde445566770e',
    'Captured/CBuffers': '264371d4e5f647890abcde445566770f',
    'Captured/Instances': '264371d4e5f647890abcde4455667710',
}

FILE_GUIDS = {
    'Shaders/EID264371264372GBuffer.shader': ('264371d4e5f647890abcde4455667701', 'ShaderImporter'),
    'Shaders/EID264371264372GBuffer.hlsl': ('264371d4e5f647890abcde4455667702', 'ShaderIncludeImporter'),
    'Editor/ColourPass6VS264371PS264372BatchImporter.cs': ('264371d4e5f647890abcde4455667703', 'MonoImporter'),
    'Runtime/EID264371DrawProfile.cs': ('264371d4e5f647890abcde4455667704', 'MonoImporter'),
}


def folder_meta(guid):
    return (
        'fileFormatVersion: 2\n'
        'guid: %s\n'
        'folderAsset: yes\n'
        'DefaultImporter:\n'
        '  externalObjects: {}\n'
        '  userData:\n'
        '  assetBundleName:\n'
        '  assetBundleVariant:\n' % guid
    )


def file_meta(guid, importer):
    if importer == 'MonoImporter':
        return (
            'fileFormatVersion: 2\n'
            'guid: %s\n'
            'MonoImporter:\n'
            '  externalObjects: {}\n'
            '  serializedVersion: 2\n'
            '  defaultReferences: []\n'
            '  executionOrder: 0\n'
            '  icon: {instanceID: 0}\n'
            '  userData:\n'
            '  assetBundleName:\n'
            '  assetBundleVariant:\n' % guid
        )
    if importer == 'ShaderIncludeImporter':
        return (
            'fileFormatVersion: 2\n'
            'guid: %s\n'
            'ShaderIncludeImporter:\n'
            '  externalObjects: {}\n'
            '  userData:\n'
            '  assetBundleName:\n'
            '  assetBundleVariant:\n' % guid
        )
    return (
        'fileFormatVersion: 2\n'
        'guid: %s\n'
        'ShaderImporter:\n'
        '  externalObjects: {}\n'
        '  defaultTextures: []\n'
        '  nonModifiableTextures: []\n'
        '  userData:\n'
        '  assetBundleName:\n'
        '  assetBundleVariant:\n' % guid
    )


if os.path.isdir(DST):
    shutil.rmtree(DST)

os.makedirs(DST, exist_ok=True)
for d in (
    'Editor', 'Runtime', 'Shaders', 'Geometry/Meshes', 'Materials', 'Profiles',
    'TextureDatabase', 'Captured/Geometry', 'Captured/CBuffers', 'Captured/Instances',
):
    os.makedirs(os.path.join(DST, d), exist_ok=True)
os.makedirs(VAL, exist_ok=True)

for rel_src, rel_dst in FILES:
    src = os.path.join(SRC, rel_src)
    dst = os.path.join(DST, rel_dst)
    text = rewrite(open(src, encoding='utf8').read())
    if rel_dst.endswith('BatchImporter.cs'):
        text = patch_importer(text)
    open(dst, 'w', encoding='utf8', newline='\n').write(text)
    print('wrote', rel_dst, os.path.getsize(dst))

open(os.path.join(DST, 'Shaders/EID264371264372GBuffer.shader'), 'w', encoding='utf8', newline='\n').write(SHADER)
open(os.path.join(DST, 'Shaders/EID264371264372GBuffer.hlsl'), 'w', encoding='utf8', newline='\n').write(HLSL)
print('wrote shader/hlsl')

open(DST + '.meta', 'w', encoding='utf8', newline='\n').write(folder_meta(FOLDER_GUIDS['']))
for rel, guid in FOLDER_GUIDS.items():
    if not rel:
        continue
    open(os.path.join(DST, rel + '.meta'), 'w', encoding='utf8', newline='\n').write(folder_meta(guid))
for rel, (guid, importer) in FILE_GUIDS.items():
    path = os.path.join(DST, rel + '.meta')
    os.makedirs(os.path.dirname(path), exist_ok=True)
    open(path, 'w', encoding='utf8', newline='\n').write(file_meta(guid, importer))

bad = []
for rel, guid in FOLDER_GUIDS.items():
    if len(guid) != 32:
        bad.append(('folder', rel, guid, len(guid)))
for rel, (guid, _) in FILE_GUIDS.items():
    if len(guid) != 32:
        bad.append(('file', rel, guid, len(guid)))
print('bad guids', bad)

imp = open(os.path.join(DST, 'Editor/ColourPass6VS264371PS264372BatchImporter.cs'), encoding='utf8').read()
needles = [
    'res27', 'res29', 'res31', 'uniforms33', 'uniforms35', 'uniforms23',
    '3669', '3674', '448', 'for (int i = 0; i < 28;',
]
hits = []
for n in needles:
    if n in imp:
        hits.append(n)
print('importer leftover', hits)
print('ExpectedEIDs', '3612' in imp, 'ExpectedInstances = 3' in imp, 'ExpectedLayoutVariants = 1' in imp)
print('res23' in imp, 'res25' in imp, 'uniforms28' in imp, 'uniforms17' in imp, 'uniforms20' in imp)
print('ok')
