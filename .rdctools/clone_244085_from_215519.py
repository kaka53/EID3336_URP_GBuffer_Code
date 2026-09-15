import os, shutil

SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215519_PS215520_Batch'
DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS244085_PS244086_Batch'
VAL = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/ColourPass6_VS244085'

FILES = [
    ('Editor/ColourPass6VS215519PS215520BatchImporter.cs', 'Editor/ColourPass6VS244085PS244086BatchImporter.cs'),
    ('Runtime/EID215519DrawProfile.cs', 'Runtime/EID244085DrawProfile.cs'),
]


def rewrite(text):
    text = text.replace('ColourPass6VS215519PS215520BatchImporter', 'ColourPass6VS244085PS244086BatchImporter')
    text = text.replace('ColourPass6_VS215519_PS215520_Batch', 'ColourPass6_VS244085_PS244086_Batch')
    text = text.replace('VS215519_PS215520', 'VS244085_PS244086')
    text = text.replace('EID215519215520GBuffer', 'EID244085244086GBuffer')
    text = text.replace('EID215519DrawProfile', 'EID244085DrawProfile')
    text = text.replace('EID215519Vertex', 'EID244085Vertex')
    text = text.replace('EID215520Fragment', 'EID244086Fragment')
    text = text.replace('_EID215520MipBias', '_EID244086MipBias')
    text = text.replace('VS215519', 'VS244085')
    text = text.replace('PS215520', 'PS244086')
    text = text.replace('215519', '244085')
    text = text.replace('215520', '244086')
    text = text.replace('static readonly int[] ExpectedEIDs = { 3448 };', 'static readonly int[] ExpectedEIDs = { 3555 };')
    text = text.replace('52.1', '64.1')
    return text


def patch_importer(text):
    text = text.replace(
        '        if (Rid(p, "res33") == 0 || Rid(p, "res35") == 0 || Rid(p, "res37") == 0 || Rid(p, "res38") == 0 || Rid(p, "res39") == 0 || Rid(p, "res40") == 0 || Rid(p, "res41") == 0 || Rid(p, "res42") == 0 || Rid(p, "res43") == 0 || Rid(p, "res44") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res33/res35/res37/res38/res39/res40/res41/res42/res43/res44.");\n        byte[] local = ReadCB(p, "PS", "uniforms46");\n        if (local.Length < 768) throw new InvalidDataException("EID" + p.eid + " PS uniforms46 expected 768 bytes, got " + local.Length);',
        '        if (Rid(p, "res33") == 0 || Rid(p, "res35") == 0 || Rid(p, "res37") == 0 || Rid(p, "res38") == 0 || Rid(p, "res39") == 0 || Rid(p, "res40") == 0 || Rid(p, "res41") == 0 || Rid(p, "res42") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res33/res35/res37/res38/res39/res40/res41/res42.");\n        byte[] local = ReadCB(p, "PS", "uniforms44");\n        if (local.Length < 752) throw new InvalidDataException("EID" + p.eid + " PS uniforms44 expected 752 bytes, got " + local.Length);',
    )
    text = text.replace(
        '        byte[] local = ReadCB(p, "PS", "uniforms46");\n        for (int i = 0; i < 48; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms48");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));',
        '        byte[] local = ReadCB(p, "PS", "uniforms44");\n        for (int i = 0; i < 47; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms46");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));',
    )
    text = text.replace(
        '        Texture albedo = LoadTexture(p, "res33");\n        Texture normalTex = LoadTexture(p, "res35");\n        Texture overlay = LoadTexture(p, "res37");\n        Texture extraFade = LoadTexture(p, "res38");\n        Texture extraMaskTex = LoadTexture(p, "res39");\n        Texture extraBlend = LoadTexture(p, "res40");\n        Texture extraColor = LoadTexture(p, "res41");\n        Texture extraN = LoadTexture(p, "res42");\n        Texture overlayL1 = LoadTexture(p, "res43");\n        Texture overlayL2 = LoadTexture(p, "res44");\n        if (albedo == null || normalTex == null || overlay == null || extraFade == null || extraMaskTex == null || extraBlend == null || extraColor == null || extraN == null || overlayL1 == null || overlayL2 == null)\n            throw new FileNotFoundException("EID" + p.eid + " res33/res35/res37/res38/res39/res40/res41/res42/res43/res44 texture binding is incomplete.");\n        m.SetTexture("_Res33", albedo);\n        m.SetTexture("_Res35", normalTex);\n        m.SetTexture("_Res37", overlay);\n        m.SetTexture("_Res38", extraFade);\n        m.SetTexture("_Res39", extraMaskTex);\n        m.SetTexture("_Res40", extraBlend);\n        m.SetTexture("_Res41", extraColor);\n        m.SetTexture("_Res42", extraN);\n        m.SetTexture("_Res43", overlayL1);\n        m.SetTexture("_Res44", overlayL2);',
        '        Texture albedo = LoadTexture(p, "res33");\n        Texture normalTex = LoadTexture(p, "res35");\n        Texture overlay = LoadTexture(p, "res37");\n        Texture extraFade = LoadTexture(p, "res38");\n        Texture extraMaskTex = LoadTexture(p, "res39");\n        Texture extraBlend = LoadTexture(p, "res40");\n        Texture extraColor = LoadTexture(p, "res41");\n        Texture extraN = LoadTexture(p, "res42");\n        if (albedo == null || normalTex == null || overlay == null || extraFade == null || extraMaskTex == null || extraBlend == null || extraColor == null || extraN == null)\n            throw new FileNotFoundException("EID" + p.eid + " res33/res35/res37/res38/res39/res40/res41/res42 texture binding is incomplete.");\n        m.SetTexture("_Res33", albedo);\n        m.SetTexture("_Res35", normalTex);\n        m.SetTexture("_Res37", overlay);\n        m.SetTexture("_Res38", extraFade);\n        m.SetTexture("_Res39", extraMaskTex);\n        m.SetTexture("_Res40", extraBlend);\n        m.SetTexture("_Res41", extraColor);\n        m.SetTexture("_Res42", extraN);',
    )
    text = text.replace(
        '        report.AppendLine("EID" + p.eid + ": material res33=RID" + Rid(p, "res33") + " res35=RID" + Rid(p, "res35") + " res37=RID" + Rid(p, "res37") + " res38=RID" + Rid(p, "res38") + " res39=RID" + Rid(p, "res39") + " res40=RID" + Rid(p, "res40") + " res41=RID" + Rid(p, "res41") + " res42=RID" + Rid(p, "res42") + " res43=RID" + Rid(p, "res43") + " res44=RID" + Rid(p, "res44") + " PS uniforms46=" + local.Length + "B");',
        '        report.AppendLine("EID" + p.eid + ": material res33=RID" + Rid(p, "res33") + " res35=RID" + Rid(p, "res35") + " res37=RID" + Rid(p, "res37") + " res38=RID" + Rid(p, "res38") + " res39=RID" + Rid(p, "res39") + " res40=RID" + Rid(p, "res40") + " res41=RID" + Rid(p, "res41") + " res42=RID" + Rid(p, "res42") + " PS uniforms44=" + local.Length + "B");',
    )
    text = text.replace(
        'unique res33/35/37/38/39/43/44 plus reused res40/41/42; PS uniforms46 48 float4; VT off; packed oct 0.0020; extra/fade + overlay + extra maps; ZTest GEqual',
        'unique res35/res39 plus reused res33/37/38/40/41/42; PS uniforms44 47 float4; VT off; packed oct 0.0020; extra/fade + overlay constants + extra DXT5nm; no res43/res44; ZTest GEqual; do not merge with 38/40/52/54',
    )
    return text


P_PROPS = '\n'.join(
    '        _P%02d ("c%02d 捕获局部参数", Vector) = (0,0,0,0)' % (i, i)
    for i in range(47)
)

SHADER = r'''Shader "EID/URP/VS244085_PS244086_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res33 ("res33 基础颜色 Binding9", 2D) = "white" {}
        _Res35 ("res35 切线法线 Binding2", 2D) = "bump" {}
        _Res37 ("res37 细节叠加 Binding3", 2D) = "gray" {}
        _Res38 ("res38 extra/fade Binding7", 2D) = "white" {}
        _Res39 ("res39 extra maps 遮罩 Binding4", 2D) = "white" {}
        _Res40 ("res40 extra maps 混合 Binding8", 2D) = "white" {}
        _Res41 ("res41 extra maps 颜色 Binding6", 2D) = "white" {}
        _Res42 ("res42 extra maps DXT5nm Binding5", 2D) = "bump" {}
        [Header(RenderDoc_PS_uniforms44_c00_c46)]
''' + P_PROPS + r'''
        _InstanceMeta ("uniforms46 实例材质元数据", Vector) = (0,0,0,0)
        _InstanceStateYZ ("uniforms30 实例状态 YZ", Vector) = (0,0,0,0)
        _EID244086MipBias ("uniforms21 全局纹理 Mip Bias", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "VS244085_PS244086_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Back
            ZWrite On
            ZTest GEqual
            Blend Off
            Stencil { Ref 0 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID244085Vertex
            #pragma fragment EID244086Fragment
            #include "EID244085244086GBuffer.hlsl"
            ENDHLSL
        }
    }
}
'''

HLSL = r'''#ifndef EID244085_244086_GBUFFER_INCLUDED
#define EID244085_244086_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_Res33); SAMPLER(sampler_Res33);
TEXTURE2D(_Res35); SAMPLER(sampler_Res35);
TEXTURE2D(_Res37); SAMPLER(sampler_Res37);
TEXTURE2D(_Res38); SAMPLER(sampler_Res38);
TEXTURE2D(_Res39); SAMPLER(sampler_Res39);
TEXTURE2D(_Res40); SAMPLER(sampler_Res40);
TEXTURE2D(_Res41); SAMPLER(sampler_Res41);
TEXTURE2D(_Res42); SAMPLER(sampler_Res42);

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
float4 _P36; float4 _P37; float4 _P38; float4 _P39;
float4 _P40; float4 _P41; float4 _P42; float4 _P43;
float4 _P44; float4 _P45; float4 _P46;
float4 _InstanceMeta;
float4 _InstanceStateYZ;
float _EID244086MipBias;
CBUFFER_END

struct Attributes244085
{
    float3 position : POSITION;
    float4 packedNormal : NORMAL;
    float4 input2 : COLOR0;
    float4 input3 : TANGENT;
    float2 input4 : TEXCOORD0;
    float2 input5 : TEXCOORD1;
    float2 input6 : TEXCOORD2;
    float4 input8 : TEXCOORD3;
    uint4 input9 : BLENDINDICES0;
};

struct Varyings244085
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

float3 DecodeOctNormal244085(uint packed)
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

float4 DecodePackedTangent244085(uint packed, float3 n)
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

float2 FilterNormalXY244085(float2 raw)
{
    float2 nxy = raw * 2.0 - 1.0;
    return float2(abs(nxy.x) < 0.012 ? 0.0 : nxy.x, abs(nxy.y) < 0.012 ? 0.0 : nxy.y);
}

Varyings244085 EID244085Vertex(Attributes244085 input)
{
    Varyings244085 o;
    uint packed = asuint(input.packedNormal.x);
    bool packedBasis = (packed & 0x40000000u) != 0u;
    float3 normalOS = packedBasis ? DecodeOctNormal244085(packed) : input.packedNormal.xyz;
    float4 tangentOS = packedBasis ? DecodePackedTangent244085(packed, normalOS) : input.input2;

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

struct GBufferOutput244086
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput244086 EID244086Fragment(Varyings244085 input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput244086 o;
    float tangentInputSign = input.tangentWS.w > 0.0 ? 1.0 : -1.0;
    float mip = _EID244086MipBias;
    float2 uvBase = lerp(input.uv0, input.uv1, _P02.w) * _P11.xy + _P11.zw;
    float2 uvNormal = lerp(input.uv0, input.uv1, _P03.x) * _P12.xy + _P12.zw;
    float4 baseSample = SAMPLE_TEXTURE2D_BIAS(_Res33, sampler_Res33, uvBase, mip);
    float4 normalSample = SAMPLE_TEXTURE2D_BIAS(_Res35, sampler_Res35, uvNormal, _P03.y + mip);

    float2 nxy = FilterNormalXY244085(normalSample.xy);
    float3 baseTS = float3(nxy * _P00.x, sqrt(saturate(1.0 - dot(nxy, nxy))));
    float3 baseColor = lerp(saturate(baseSample.rgb * _P08.rgb * _P04.z), _P08.rgb, _P04.x);
    float roughness = lerp(_P00.z, _P00.w, normalSample.z);
    float materialY = lerp(baseSample.a, _P04.y, saturate(_P03.w - 1.0));
    float ao = lerp(1.0, normalSample.w, _P01.x);

    float2 uvExtraFade = lerp(input.uv0, input.uv1, _P23.z) * _P25.xy + _P25.zw;
    float4 extraFadeSample = SAMPLE_TEXTURE2D_BIAS(_Res38, sampler_Res38, uvExtraFade, mip);
    float extraSrc = lerp(1.0, extraFadeSample.w, saturate(_P22.y));
    float extraAlt = lerp(lerp(baseSample.a, normalSample.z, saturate(_P22.y - 2.0)), normalSample.w, saturate(_P22.y - 3.0));
    float extraMaskFade = lerp(extraSrc, extraAlt, saturate(_P22.y - 1.0));
    float viewAbsZ = abs(TransformWorldToView(input.positionWS).z);
    extraMaskFade *= saturate((_P23.y - viewAbsZ) / max(_P23.y - _P23.x, 1e-8));

    float2 fxy = FilterNormalXY244085(extraFadeSample.xy) * (extraMaskFade * _P22.z);
    float3 fadeTS = float3(fxy, sqrt(saturate(1.0 - dot(FilterNormalXY244085(extraFadeSample.xy), FilterNormalXY244085(extraFadeSample.xy)))));
    float3 fadePlus = baseTS + float3(0.0, 0.0, 1.0);
    float3 fadeFlip = fadeTS * float3(-1.0, -1.0, 1.0);
    float3 tangentN = (fadePlus * dot(fadePlus, fadeFlip)) / max(fadePlus.z, 0.0) - fadeFlip;

    float extraBlendFade = _P22.w * extraMaskFade;
    roughness = lerp(roughness, lerp(extraFadeSample.w, extraFadeSample.z, _P22.x), extraBlendFade);
    ao *= lerp(1.0, lerp(1.0, extraFadeSample.w, _P22.x), extraBlendFade);
    float extraColorAmt = extraMaskFade * (1.0 - _P22.x) * (1.0 - extraFadeSample.z);
    float3 extraFadeCol = lerp(saturate(baseColor * _P24.rgb * _P23.w), _P24.rgb, _P24.aaa);
    baseColor = lerp(baseColor, extraFadeCol, extraColorAmt);

    float2 uvOverlay = lerp(input.uv0, input.uv1, _P35.x) * _P43.xy + _P43.zw;
    float3 detail = SAMPLE_TEXTURE2D_BIAS(_Res37, sampler_Res37, uvOverlay, mip).xyz;
    float3 lo = float3(_P38.x, _P38.z, _P39.x);
    float3 hi = float3(_P38.y, _P38.w, _P39.y);
    float3 weights = saturate(lo * 0.5 + lerp(-lo, 1.0, detail + hi)) * float3(_P40.w, _P41.w, _P42.w);
    float4 layered = float4(baseColor, roughness);
    layered = lerp(layered, float4(_P42.xyz, _P36.w), weights.z);
    layered = lerp(layered, float4(_P41.xyz, _P36.x), weights.y);
    layered = lerp(layered, float4(_P40.xyz, _P35.y), weights.x);
    baseColor = layered.xyz;
    roughness = layered.w;
    materialY = lerp(materialY, _P37.z, weights.z);
    materialY = lerp(materialY, _P37.y, weights.y);
    materialY = lerp(materialY, _P37.x, weights.x);

    uint axis = (uint)_P26.x;
    float2 extraUV;
    if (axis == 0u)
        extraUV = input.uv0;
    else if (axis == 1u)
        extraUV = input.positionWS.xz;
    else
        extraUV = input.uv2;
    extraUV = extraUV * _P26.z + _P31.xy;

    float4 extraColorSample = SAMPLE_TEXTURE2D_BIAS(_Res41, sampler_Res41, extraUV, mip);
    float luma = dot(extraColorSample.rgb, float3(0.2127, 0.7152, 0.0722));
    float3 extraColor = lerp(luma.xxx, extraColorSample.rgb, saturate(_P28.w + 1.0)) * _P30.rgb * _P29.x;
    float4 extraNSample = SAMPLE_TEXTURE2D_BIAS(_Res42, sampler_Res42, extraUV, mip);
    float4 packedExtra = extraNSample;
    packedExtra.a = packedExtra.r;
    float2 en = packedExtra.wy * 2.0 - 1.0;
    float extraNz = max(0.0, sqrt(saturate(1.0 - saturate(dot(en, en)))));
    float3 extraTS = float3(en * _P26.w, extraNz);

    float2 maskUV = _P32.x != 0.0 ? input.uv0 : input.uv1;
    float mask;
    if (_P32.y < 0.5)
        mask = SAMPLE_TEXTURE2D_BIAS(_Res39, sampler_Res39, maskUV, mip).x;
    else
    {
        float4 src = float4(extraNSample.w, baseSample.a, normalSample.w, 1.0);
        float4 sel = abs(_P32.y.xxxx - float4(1.0, 2.0, 3.0, 4.0));
        mask = dot(src, step(sel, 0.5.xxxx));
    }
    mask = saturate(mask);

    float extraA = _P27.y != 0.0 ? extraColorSample.a : _P27.x;
    float extraAO = _P28.z != 0.0 ? 1.0 : lerp(1.0, extraNSample.w, _P27.z);
    float extraBlendSample = SAMPLE_TEXTURE2D_BIAS(_Res40, sampler_Res40, extraUV, mip).x;
    float2 pair = float2(1.0 - mask, mask) * float2(extraBlendSample, extraColorSample.a);
    float pairMax = max(pair.x, pair.y);
    float2 t = max(0.0.xx, pair + _P26.y.xx - pairMax.xx);
    t *= float2(1.0 - mask, mask);
    float extraBlend = max(0.0, t.x + t.y);
    float2 nrm = extraBlend > 0.0 ? t / extraBlend : 0.0.xx;
    float extraMask = _P28.y != 0.0 ? nrm.y : mask;

    float3 basePlus = tangentN + float3(0.0, 0.0, 1.0);
    float3 extraFlip = extraTS * float3(-1.0, -1.0, 1.0);
    float3 reoriented = (basePlus * dot(basePlus, extraFlip)) / max(basePlus.z, 0.0) - extraFlip;
    float3 extraBlended = lerp(extraTS, reoriented, _P27.w.xxx);
    tangentN = lerp(tangentN, extraBlended, extraMask.xxx);
    baseColor = lerp(baseColor, extraColor, extraMask.xxx);
    materialY = lerp(materialY, extraA, extraMask);
    roughness = lerp(roughness, extraNSample.z, extraMask);
    ao = lerp(ao, extraAO, extraMask);

    float faceSign = isFrontFace ? 1.0 : (_P01.w > 0.0 ? -1.0 : 1.0);
    float3 n = normalize(input.normalWS);
    float3 tdir = normalize(input.tangentWS.xyz);
    float3 b = normalize(cross(n, tdir)) * tangentInputSign;
    float3 tn = float3(tangentN.xy, tangentN.z * faceSign);
    float3 normalWS = normalize(tdir * tn.x + b * tn.y + n * tn.z);

    uint materialId = (uint)_InstanceMeta.w;
    float materialZ = saturate(_P04.w * roughness + _P05.y * materialY + _P05.x) * 0.95 + 0.05;
    materialZ *= step(extraMask, 1.0 - _P28.x);
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
    '': '244085d4e5f647890abcde4455667700',
    'Editor': '244085d4e5f647890abcde4455667710',
    'Runtime': '244085d4e5f647890abcde4455667711',
    'Shaders': '244085d4e5f647890abcde4455667712',
    'Geometry': '244085d4e5f647890abcde4455667713',
    'Geometry/Meshes': '244085d4e5f647890abcde4455667714',
    'Captured': '244085d4e5f647890abcde4455667715',
    'Captured/Geometry': '244085d4e5f647890abcde4455667716',
    'Captured/CBuffers': '244085d4e5f647890abcde4455667717',
    'Captured/Instances': '244085d4e5f647890abcde4455667718',
    'Materials': '244085d4e5f647890abcde4455667719',
    'Profiles': '244085d4e5f647890abcde445566771a',
    'TextureDatabase': '244085d4e5f647890abcde445566771b',
}

FILE_GUIDS = {
    'Editor/ColourPass6VS244085PS244086BatchImporter.cs': ('244085d4e5f647890abcde4455667701', 'MonoImporter'),
    'Shaders/EID244085244086GBuffer.shader': ('244085d4e5f647890abcde4455667702', 'ShaderImporter'),
    'Shaders/EID244085244086GBuffer.hlsl': ('244085d4e5f647890abcde4455667703', 'ShaderIncludeImporter'),
    'Runtime/EID244085DrawProfile.cs': ('244085d4e5f647890abcde4455667704', 'MonoImporter'),
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
open(os.path.join(DST, 'Shaders/EID244085244086GBuffer.shader'), 'w', encoding='utf8', newline='\n').write(SHADER)
open(os.path.join(DST, 'Shaders/EID244085244086GBuffer.hlsl'), 'w', encoding='utf8', newline='\n').write(HLSL)
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

imp = open(os.path.join(DST, 'Editor/ColourPass6VS244085PS244086BatchImporter.cs'), encoding='utf8').read()
needles = ['215519', '215520', '3448', 'res43', 'res44', 'uniforms48', '52.1', '768']
for n in needles:
    hits = [i for i, line in enumerate(imp.splitlines(), 1) if n in line]
    if hits:
        print('LEFTOVER', n, hits[:8])

hlsl = open(os.path.join(DST, 'Shaders/EID244085244086GBuffer.hlsl'), encoding='utf8').read()
for n in ['Res43', 'Res44', 'weights.zzz', '215519', '215520']:
    if n in hlsl:
        print('HLSL leftover', n)

guids = list(FOLDER_GUIDS.values()) + [g for g, _ in FILE_GUIDS.values()]
for g in guids:
    if len(g) != 32 or any(c not in '0123456789abcdef' for c in g):
        print('BAD GUID', g)
print('guid check done')
print('ok')
