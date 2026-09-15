#ifndef EID215511_215514_GBUFFER_INCLUDED
#define EID215511_215514_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_Res33); SAMPLER(sampler_Res33);
TEXTURE2D(_Res35); SAMPLER(sampler_Res35);
TEXTURE2D(_Res37); SAMPLER(sampler_Res37);
TEXTURE2D(_Res38); SAMPLER(sampler_Res38);
TEXTURE2D(_Res39); SAMPLER(sampler_Res39);
TEXTURE2D(_Res40); SAMPLER(sampler_Res40);
TEXTURE2D(_Res41); SAMPLER(sampler_Res41);

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
float4 _P40;
float4 _InstanceMeta;
float4 _InstanceStateYZ;
float _EID215514MipBias;
CBUFFER_END

struct Attributes215511
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

struct Varyings215511
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

float3 DecodeOctNormal215511(uint packed)
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

float4 DecodePackedTangent215511(uint packed, float3 n)
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

float2 FilterNormalXY215511(float2 raw)
{
    float2 nxy = raw * 2.0 - 1.0;
    return float2(abs(nxy.x) < 0.012 ? 0.0 : nxy.x, abs(nxy.y) < 0.012 ? 0.0 : nxy.y);
}

Varyings215511 EID215511Vertex(Attributes215511 input)
{
    Varyings215511 o;
    uint packed = asuint(input.packedNormal.x);
    bool packedBasis = (packed & 0x40000000u) != 0u;
    float3 normalOS = packedBasis ? DecodeOctNormal215511(packed) : input.packedNormal.xyz;
    float4 tangentOS = packedBasis ? DecodePackedTangent215511(packed, normalOS) : input.input2;

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

struct GBufferOutput215514
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput215514 EID215514Fragment(Varyings215511 input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput215514 o;
    float tangentInputSign = input.tangentWS.w > 0.0 ? 1.0 : -1.0;
    float2 uvBase = lerp(input.uv0, input.uv1, _P02.w) * _P11.xy + _P11.zw;
    float4 baseSample = SAMPLE_TEXTURE2D_BIAS(_Res33, sampler_Res33, uvBase, _EID215514MipBias);
    float2 uvNormal = lerp(input.uv0, input.uv1, _P03.x) * _P12.xy + _P12.zw;
    float4 normalSample = SAMPLE_TEXTURE2D_BIAS(_Res35, sampler_Res35, uvNormal, _P03.y + _EID215514MipBias);

    float2 nxy = FilterNormalXY215511(normalSample.xy);
    float3 baseTS = float3(nxy * _P00.x, sqrt(saturate(1.0 - dot(nxy, nxy))));
    float3 baseColor = lerp(saturate(baseSample.rgb * _P08.rgb * _P04.z), _P08.rgb, _P04.x);
    float roughness = lerp(_P00.z, _P00.w, normalSample.z);
    float materialY = lerp(baseSample.a, _P04.y, saturate(_P03.w - 1.0));
    float ao = lerp(1.0, normalSample.w, _P01.x);

    float2 uvOverlay = lerp(input.uv0, input.uv1, _P29.x) * _P37.xy + _P37.zw;
    float3 detail = SAMPLE_TEXTURE2D_BIAS(_Res37, sampler_Res37, uvOverlay, _EID215514MipBias).xyz;
    float3 lo = float3(_P32.x, _P32.z, _P33.x);
    float3 hi = float3(_P32.y, _P32.w, _P33.y);
    float3 weights = saturate(lo * 0.5 + lerp(-lo, 1.0, detail + hi)) * float3(_P34.w, _P35.w, _P36.w);
    float4 layered = float4(baseColor, roughness);
    layered = lerp(layered, float4(_P36.xyz, _P30.w), weights.z);
    layered = lerp(layered, float4(_P35.xyz, _P30.x), weights.y);
    layered = lerp(layered, float4(_P34.xyz, _P29.y), weights.x);
    baseColor = layered.xyz;
    roughness = layered.w;
    materialY = lerp(materialY, _P31.z, weights.z);
    materialY = lerp(materialY, _P31.y, weights.y);
    materialY = lerp(materialY, _P31.x, weights.x);

    uint axis = (uint)_P22.x;
    float2 extraUV;
    if (axis == 0u)
        extraUV = input.uv0;
    else if (axis == 1u)
        extraUV = input.positionWS.xz;
    else
        extraUV = input.uv2;
    extraUV = extraUV * _P22.z + _P27.xy;

    float4 extraColorSample = SAMPLE_TEXTURE2D_BIAS(_Res40, sampler_Res40, extraUV, _EID215514MipBias);
    float luma = dot(extraColorSample.rgb, float3(0.2127, 0.7152, 0.0722));
    float3 extraColor = lerp(luma.xxx, extraColorSample.rgb, saturate(_P24.w + 1.0)) * _P26.rgb * _P25.x;
    float4 extraNSample = SAMPLE_TEXTURE2D_BIAS(_Res41, sampler_Res41, extraUV, _EID215514MipBias);
    float2 en = extraNSample.xy * 2.0 - 1.0;
    float extraNz = max(0.0, sqrt(saturate(1.0 - saturate(dot(en, en)))));
    float3 extraTS = float3(en * _P22.w, extraNz);

    float2 maskUV = _P28.x != 0.0 ? input.uv0 : input.uv1;
    float mask;
    if (_P28.y < 0.5)
        mask = SAMPLE_TEXTURE2D_BIAS(_Res38, sampler_Res38, maskUV, _EID215514MipBias).x;
    else
    {
        float4 src = float4(extraNSample.w, baseSample.a, normalSample.w, 1.0);
        float4 sel = abs(_P28.y.xxxx - float4(1.0, 2.0, 3.0, 4.0));
        mask = dot(src, step(sel, 0.5.xxxx));
    }
    mask = saturate(mask);

    float extraA = _P23.y != 0.0 ? extraColorSample.a : _P23.x;
    float extraAO = _P24.z != 0.0 ? 1.0 : lerp(1.0, extraNSample.w, _P23.z);
    float extra39 = SAMPLE_TEXTURE2D_BIAS(_Res39, sampler_Res39, extraUV, _EID215514MipBias).x;
    float2 pair = float2(1.0 - mask, mask) * float2(extra39, extraColorSample.a);
    float pairMax = max(pair.x, pair.y);
    float2 t = max(0.0.xx, pair + _P22.y.xx - pairMax.xx);
    t *= float2(1.0 - mask, mask);
    float extraBlend = max(0.0, t.x + t.y);
    float2 nrm = extraBlend > 0.0 ? t / extraBlend : 0.0.xx;
    float extraMask = _P24.y != 0.0 ? nrm.y : mask;

    float3 basePlus = baseTS + float3(0.0, 0.0, 1.0);
    float3 extraFlip = extraTS * float3(-1.0, -1.0, 1.0);
    float3 reoriented = (basePlus * dot(basePlus, extraFlip)) / max(basePlus.z, 0.0) - extraFlip;
    float3 extraBlended = lerp(extraTS, reoriented, _P23.w.xxx);
    float3 tangentN = lerp(baseTS, extraBlended, extraMask.xxx);
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
    materialZ *= step(extraMask, 1.0 - _P24.x);
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
