import os, shutil

SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS241568_PS241569_Batch'
DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS243940_PS243941_Batch'
VAL = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/ColourPass6_VS243940'

FILES = [
    ('Editor/ColourPass6VS241568PS241569BatchImporter.cs', 'Editor/ColourPass6VS243940PS243941BatchImporter.cs'),
    ('Runtime/EID241568DrawProfile.cs', 'Runtime/EID243940DrawProfile.cs'),
]


def rewrite(text):
    text = text.replace('ColourPass6VS241568PS241569BatchImporter', 'ColourPass6VS243940PS243941BatchImporter')
    text = text.replace('ColourPass6_VS241568_PS241569_Batch', 'ColourPass6_VS243940_PS243941_Batch')
    text = text.replace('VS241568_PS241569', 'VS243940_PS243941')
    text = text.replace('EID241568241569GBuffer', 'EID243940243941GBuffer')
    text = text.replace('EID241568DrawProfile', 'EID243940DrawProfile')
    text = text.replace('EID241568Vertex', 'EID243940Vertex')
    text = text.replace('EID241569Fragment', 'EID243941Fragment')
    text = text.replace('_EID241569MipBias', '_EID243941MipBias')
    text = text.replace('VS241568', 'VS243940')
    text = text.replace('PS241569', 'PS243941')
    text = text.replace('241568', '243940')
    text = text.replace('241569', '243941')
    text = text.replace('static readonly int[] ExpectedEIDs = { 3567 };', 'static readonly int[] ExpectedEIDs = { 3583 };')
    text = text.replace('static readonly int ExpectedInstances = 1;', 'static readonly int ExpectedInstances = 1;')
    text = text.replace('62.1', '63.1')
    text = text.replace('d6a844f320196881', '3eae907666b7ec55')
    return text


def patch_importer(text):
    text = text.replace(
        '        if (Rid(p, "res30") == 0 || Rid(p, "res32") == 0 || Rid(p, "res34") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res30/res32/res34.");\n        byte[] local = ReadCB(p, "PS", "uniforms37");\n        if (local.Length < 432) throw new InvalidDataException("EID" + p.eid + " PS uniforms37 expected 432 bytes, got " + local.Length);',
        '        if (Rid(p, "res27") == 0 || Rid(p, "res29") == 0 || Rid(p, "res31") == 0 || Rid(p, "res33") == 0 || Rid(p, "res35") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res27/res29/res31/res33/res35.");\n        byte[] local = ReadCB(p, "PS", "uniforms41");\n        if (local.Length < 592) throw new InvalidDataException("EID" + p.eid + " PS uniforms41 expected 592 bytes, got " + local.Length);',
    )
    text = text.replace(
        '        byte[] local = ReadCB(p, "PS", "uniforms37");\n        for (int i = 0; i < 27; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms39");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));\n        ApplyInstanceState(m, p, 0);\n        byte[] globals = ReadCB(p, "PS", "uniforms20");\n        m.SetFloat("_EID243941MipBias", ReadFloat(globals, 416));',
        '        byte[] local = ReadCB(p, "PS", "uniforms41");\n        for (int i = 0; i < 37; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms43");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));\n        ApplyInstanceState(m, p, 0);\n        byte[] globals = ReadCB(p, "PS", "uniforms20");\n        m.SetFloat("_EID243941MipBias", ReadFloat(globals, 416));\n        m.SetFloat("_LightMixY", ReadFloat(globals, 436));',
    )
    text = text.replace(
        '        Texture albedo = LoadTexture(p, "res30");\n        Texture normalTex = LoadTexture(p, "res32");\n        Texture extra = LoadTexture(p, "res34");\n        if (albedo == null || normalTex == null || extra == null)\n            throw new FileNotFoundException("EID" + p.eid + " res30/res32/res34 texture binding is incomplete.");\n        m.SetTexture("_Res30", albedo);\n        m.SetTexture("_Res32", normalTex);\n        m.SetTexture("_Res34", extra);',
        '        Texture albedo = LoadTexture(p, "res27");\n        Texture normalTex = LoadTexture(p, "res29");\n        Texture extra = LoadTexture(p, "res31");\n        Texture overlay = LoadTexture(p, "res33");\n        Texture matcap = LoadTexture(p, "res35");\n        if (albedo == null || normalTex == null || extra == null || overlay == null || matcap == null)\n            throw new FileNotFoundException("EID" + p.eid + " res27/res29/res31/res33/res35 texture binding is incomplete.");\n        m.SetTexture("_Res27", albedo);\n        m.SetTexture("_Res29", normalTex);\n        m.SetTexture("_Res31", extra);\n        m.SetTexture("_Res33", overlay);\n        m.SetTexture("_Res35", matcap);',
    )
    text = text.replace(
        '        report.AppendLine("EID" + p.eid + ": material res30=RID" + Rid(p, "res30") + " res32=RID" + Rid(p, "res32") + " res34=RID" + Rid(p, "res34") + " PS uniforms37=" + local.Length + "B");',
        '        report.AppendLine("EID" + p.eid + ": material res27=RID" + Rid(p, "res27") + " res29=RID" + Rid(p, "res29") + " res31=RID" + Rid(p, "res31") + " res33=RID" + Rid(p, "res33") + " res35=RID" + Rid(p, "res35") + " PS uniforms41=" + local.Length + "B");',
    )
    text = text.replace(
        'unique res30/res32/res34; PS uniforms37 432B; Cull Back; ZWrite On; ZTest GEqual; stencil 0; skip skin (flags 0); DXT5nm .wy; extra material channels; RT0 black; packed NORMAL.x oct 0.001956; do not merge with 12/16/18/23/30/36/39/44/51/53/55/57',
        'unique res27/res29/res31/res33/res35; PS uniforms41 592B; Cull Back; ZWrite On; ZTest GEqual; stencil 0; skin bake ssbo30 flags 52; DXT5nm .wy; extra + overlay + matcap RT0; R16 weights; packed NORMAL.x oct 0.001956; do not merge with 12/16/18/23/30/36/39/44/51/53/55/57/62',
    )
    return text


P_PROPS = '\n'.join(
    '        _P%02d ("c%02d 捕获局部参数", Vector) = (0,0,0,0)' % (i, i)
    for i in range(37)
)

SHADER = r'''Shader "EID/URP/VS243940_PS243941_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res27 ("res27 基础颜色 Binding12", 2D) = "white" {}
        _Res29 ("res29 DXT5nm Binding9", 2D) = "bump" {}
        _Res31 ("res31 材质通道 Binding11", 2D) = "white" {}
        _Res33 ("res33 叠加 Binding8", 2D) = "black" {}
        _Res35 ("res35 Matcap Binding10", 2D) = "black" {}
        [Header(RenderDoc_PS_uniforms41_c00_c36)]
''' + P_PROPS + r'''
        _InstanceMeta ("uniforms43 实例材质元数据", Vector) = (0,0,0,0)
        _InstanceStateYZ ("uniforms23 实例状态 YZ", Vector) = (0,0,0,0)
        _EID243941MipBias ("uniforms20 全局纹理 Mip Bias", Float) = 0
        _LightMixY ("uniforms20 child20.y", Float) = 1
        _UseBakedSkinning ("Captured ssbo30 skin baked into VSInput", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "VS243940_PS243941_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Back
            ZWrite On
            ZTest GEqual
            Blend Off
            Stencil { Ref 0 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID243940Vertex
            #pragma fragment EID243941Fragment
            #include "EID243940243941GBuffer.hlsl"
            ENDHLSL
        }
    }
}
'''

HLSL = r'''#ifndef EID243940_243941_GBUFFER_INCLUDED
#define EID243940_243941_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_Res27); SAMPLER(sampler_Res27);
TEXTURE2D(_Res29); SAMPLER(sampler_Res29);
TEXTURE2D(_Res31); SAMPLER(sampler_Res31);
TEXTURE2D(_Res33); SAMPLER(sampler_Res33);
TEXTURE2D(_Res35); SAMPLER(sampler_Res35);

CBUFFER_START(UnityPerMaterial)
float4 _P00; float4 _P01; float4 _P02; float4 _P03;
float4 _P04; float4 _P05; float4 _P06; float4 _P07;
float4 _P08; float4 _P09; float4 _P10; float4 _P11;
float4 _P12; float4 _P13; float4 _P14; float4 _P15;
float4 _P16; float4 _P17; float4 _P18; float4 _P19;
float4 _P20; float4 _P21; float4 _P22; float4 _P23;
float4 _P24; float4 _P25; float4 _P26; float4 _P27;
float4 _P28; float4 _P29; float4 _P30; float4 _P31;
float4 _P32; float4 _P33; float4 _P34; float4 _P35;
float4 _P36;
float4 _InstanceMeta;
float4 _InstanceStateYZ;
float _EID243941MipBias;
float _LightMixY;
float _UseBakedSkinning;
CBUFFER_END

struct Attributes243940
{
    float3 position : POSITION;
    float4 packedNormal : NORMAL;
    float4 input2 : COLOR0;
    float4 input3 : TANGENT;
    float2 input4 : TEXCOORD0;
    float2 input5 : TEXCOORD1;
    float2 input6 : TEXCOORD2;
    float4 input7 : TEXCOORD3;
    uint4 input8 : BLENDINDICES0;
    float3 bakedNormalOS : TEXCOORD4;
    float4 bakedTangentOS : TEXCOORD5;
};

struct Varyings243940
{
    float4 positionCS : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    float2 uv1 : TEXCOORD1;
    float2 uv2 : TEXCOORD2;
    float3 normalWS : TEXCOORD3;
    float4 tangentWS : TEXCOORD4;
    float3 currentClipXYW : TEXCOORD5;
    float3 previousClipXYW : TEXCOORD6;
    nointerpolation uint instanceIndex : TEXCOORD7;
    float3 positionWS : TEXCOORD8;
};

float3 DecodeOctNormal243940(uint packed)
{
    float x = float((packed << 22u) >> 22u);
    float y = float((packed << 12u) >> 22u);
    x = (x >= 512.0) ? x - 1024.0 : x;
    y = (y >= 512.0) ? y - 1024.0 : y;
    float3 n = float3(x, y, 0.0) * 0.0019569471478462219;
    n.z = 1.0 - abs(n.x) - abs(n.y);
    if (n.z < 0.0)
        n.xy = (1.0 - abs(n.yx)) * (step(0.0, n.xy) * 2.0 - 1.0);
    return normalize(n);
}

float4 DecodePackedTangent243940(uint packed, float3 n)
{
    float signed10 = float((packed << 2u) >> 22u);
    signed10 = ((signed10 >= 512.0) ? signed10 - 1024.0 : signed10) * 0.0019569471478462219;
    float3 seed = n.yzx - n.zxy;
    float3 t0 = normalize(seed - dot(seed, n).xxx);
    float tangentSign = signed10 < 0.0 ? -1.0 : 1.0;
    float encoded = 1.0 - ((signed10 * tangentSign) * 2.0);
    float2 r = normalize(float2(encoded, tangentSign * (1.0 - abs(encoded))));
    float3 t1 = normalize(cross(n, t0));
    float3 t = mul(r, float2x3(t0, t1));
    return float4(t, float((packed >> 31u) & 1u) * 2.0 - 1.0);
}

Varyings243940 EID243940Vertex(Attributes243940 input)
{
    Varyings243940 o;
    uint packed = asuint(input.packedNormal.x);
    bool packedBasis = (packed & 0x40000000u) != 0u;
    float3 decodedNormalOS = packedBasis ? DecodeOctNormal243940(packed) : input.packedNormal.xyz;
    float4 decodedTangentOS = packedBasis ? DecodePackedTangent243940(packed, decodedNormalOS) : input.input2;
    float3 normalOS = _UseBakedSkinning > 0.5 ? input.bakedNormalOS : decodedNormalOS;
    float4 tangentOS = _UseBakedSkinning > 0.5 ? input.bakedTangentOS : decodedTangentOS;

    float3 positionWS = TransformObjectToWorld(input.position);
    float3 normalWS = normalize(TransformObjectToWorldNormal(normalOS));
    float3 tangentWS = normalize(TransformObjectToWorldDir(tangentOS.xyz));
    float4 clip = TransformWorldToHClip(positionWS);

    o.positionCS = clip;
    o.uv0 = input.input4;
    o.uv1 = input.input5;
    o.uv2 = input.input6;
    o.normalWS = normalWS;
    o.tangentWS = float4(tangentWS, tangentOS.w * GetOddNegativeScale());
    o.currentClipXYW = clip.xyw;
    o.previousClipXYW = clip.xyw;
    o.instanceIndex = 0u;
    o.positionWS = positionWS;
    return o;
}

struct GBufferOutput243941
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput243941 EID243941Fragment(Varyings243940 input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput243941 o;
    float tangentInputSign = input.tangentWS.w > 0.0 ? 1.0 : -1.0;
    float mip = _EID243941MipBias;
    float2 uvAlbedo = lerp(input.uv0, input.uv1, _P02.w) * _P11.xy + _P11.zw;
    float2 uvNormal = lerp(input.uv0, input.uv1, _P03.x) * _P12.xy + _P12.zw;
    float4 albedoSample = SAMPLE_TEXTURE2D_BIAS(_Res27, sampler_Res27, uvAlbedo, mip);
    float4 normalSample = SAMPLE_TEXTURE2D_BIAS(_Res29, sampler_Res29, uvNormal, _P03.y + mip);
    float4 extraSample = SAMPLE_TEXTURE2D_BIAS(_Res31, sampler_Res31, uvNormal, mip);

    float4 dxt5 = normalSample;
    dxt5.w = normalSample.w * normalSample.x;
    float2 nxyRaw = dxt5.wy * 2.0 - 1.0;
    float2 nxy = nxyRaw * _P00.x;
    float nz = max(0.0, sqrt(saturate(1.0 - dot(nxyRaw, nxyRaw))));

    float3 baseColor = saturate(albedoSample.rgb * _P08.rgb * _P04.z);
    baseColor = lerp(baseColor, _P08.rgb, _P04.x);
    float roughness = lerp(_P00.z, _P00.w, extraSample.y);
    float ao = lerp(1.0, extraSample.z, _P01.x);
    float materialY = lerp(extraSample.x, _P04.y, saturate(_P03.w - 1.0));

    float faceSign = isFrontFace ? 1.0 : (_P01.w > 0.0 ? -1.0 : 1.0);
    float3 n = normalize(input.normalWS);
    float3 t = normalize(input.tangentWS.xyz);
    float3 b = normalize(cross(n, t)) * tangentInputSign;
    float3 normalWS = normalize(t * nxy.x + b * nxy.y + n * (nz * faceSign));
    float3 viewDirWS = GetWorldSpaceNormalizeViewDir(input.positionWS);

    float alphaMix = lerp(albedoSample.w, extraSample.w, saturate(_P25.w - 1.0));
    float overlayMask = lerp(alphaMix, 0.0, _P26.y);
    float3 overlayLit = 0.0.xxx;
    if (overlayMask > 0.01)
    {
        float2 uvOverlay = lerp(input.uv0, input.uv1, _P26.x) * _P26.z * _P24.y;
        float4 overlaySample = SAMPLE_TEXTURE2D_BIAS(_Res33, sampler_Res33, uvOverlay, mip);
        float3 overlayTint = lerp(_P30.xyz, _P29.xyz, overlaySample.yyy);
        float ndv = max(dot(viewDirWS, normalWS), 0.001);
        float wrap = pow(ndv, floor(_P25.y));
        overlayLit = overlayTint * (overlayMask * wrap * overlayMask);
        overlayLit *= _P25.z != 0.0 ? _LightMixY : 1.0;
    }
    overlayLit *= _P28.w;

    float3 viewN = mul((float3x3)UNITY_MATRIX_V, normalWS);
    float2 uvMatcap = viewN.xy * 0.5 + 0.5;
    float3 matcap = SAMPLE_TEXTURE2D_BIAS(_Res35, sampler_Res35, uvMatcap, mip).xyz;
    matcap *= _P36.x;
    matcap *= (1.0 - _P36.y) + _LightMixY * _P36.y;
    float3 rt0rgb = overlayLit + matcap;

    uint materialId = (uint)_InstanceMeta.w;
    float materialZ = (saturate(_P04.w * roughness + _P05.y * materialY + _P05.x) * 0.95 + 0.05) * (1.0 - _P07.y);
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

    o.rt0 = float4(rt0rgb, 0.5);
    o.rt1 = float4(encodedMotion, motionWeight > 0.0 ? 1.0 : _P07.x, motionWeight);
    o.rt2 = float4(materialY, ao, materialZ, float(materialId / 4u) * 0.3333333433);
    o.rt3 = float4(oct, roughness, float(materialId % 4u) * 0.3333333433);
    o.rt4 = float4(baseColor, 0.0);
    return o;
}

#endif
'''

FOLDER_GUIDS = {
    '': '243940d4e5f647890abcde4455667700',
    'Editor': '243940d4e5f647890abcde4455667710',
    'Runtime': '243940d4e5f647890abcde4455667711',
    'Shaders': '243940d4e5f647890abcde4455667712',
    'Geometry': '243940d4e5f647890abcde4455667713',
    'Geometry/Meshes': '243940d4e5f647890abcde4455667714',
    'Captured': '243940d4e5f647890abcde4455667715',
    'Captured/Geometry': '243940d4e5f647890abcde4455667716',
    'Captured/CBuffers': '243940d4e5f647890abcde4455667717',
    'Captured/Instances': '243940d4e5f647890abcde4455667718',
    'Materials': '243940d4e5f647890abcde4455667719',
    'Profiles': '243940d4e5f647890abcde445566771a',
    'TextureDatabase': '243940d4e5f647890abcde445566771b',
}

FILE_GUIDS = {
    'Editor/ColourPass6VS243940PS243941BatchImporter.cs': ('243940d4e5f647890abcde4455667701', 'MonoImporter'),
    'Shaders/EID243940243941GBuffer.shader': ('243940d4e5f647890abcde4455667702', 'ShaderImporter'),
    'Shaders/EID243940243941GBuffer.hlsl': ('243940d4e5f647890abcde4455667703', 'ShaderIncludeImporter'),
    'Runtime/EID243940DrawProfile.cs': ('243940d4e5f647890abcde4455667704', 'MonoImporter'),
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
    if rel_dst.endswith('BatchImporter.cs'):
        text = patch_importer(text)
    open(dst, 'w', encoding='utf8', newline='\n').write(text)
    print('wrote', rel_dst, os.path.getsize(dst))

os.makedirs(os.path.join(DST, 'Shaders'), exist_ok=True)
open(os.path.join(DST, 'Shaders/EID243940243941GBuffer.shader'), 'w', encoding='utf8', newline='\n').write(SHADER)
open(os.path.join(DST, 'Shaders/EID243940243941GBuffer.hlsl'), 'w', encoding='utf8', newline='\n').write(HLSL)
print('wrote shader/hlsl')

for d in FOLDER_GUIDS:
    path = os.path.join(DST, d) if d else DST
    os.makedirs(path, exist_ok=True)
    meta_path = (DST + '.meta') if d == '' else os.path.join(DST, d + '.meta')
    open(meta_path, 'w', encoding='utf8', newline='\n').write(FOLDER_META.format(guid=FOLDER_GUIDS[d]))

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

os.makedirs(VAL, exist_ok=True)

imp = open(os.path.join(DST, 'Editor/ColourPass6VS243940PS243941BatchImporter.cs'), encoding='utf8').read()
needles = ['241568', '241569', '3567', 'res30', 'res32', 'res34', 'uniforms37', 'uniforms39', '62.1', '432']
for n in needles:
    hits = [i for i, line in enumerate(imp.splitlines(), 1) if n in line]
    if hits:
        print('LEFTOVER', n, hits[:8])

guids = list(FOLDER_GUIDS.values()) + [g for g, _ in FILE_GUIDS.values()]
for g in guids:
    if len(g) != 32 or any(c not in '0123456789abcdef' for c in g):
        print('BAD GUID', g)
print('guid check done')
print('ok')
