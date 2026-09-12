#ifndef EID209988_209989_GBUFFER_INCLUDED
#define EID209988_209989_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_Res33); SAMPLER(sampler_Res33);
TEXTURE2D(_Res35); SAMPLER(sampler_Res35);
TEXTURE2D(_Res37); SAMPLER(sampler_Res37);
TEXTURE2D(_Res38); SAMPLER(sampler_Res38);

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
float4 _P44;
float4 _InstanceMeta;
float4 _InstanceStateYZ;
float _EID209989MipBias;
CBUFFER_END

struct Attributes209988
{
    float3 position : POSITION;
    float4 packedNormal : NORMAL;
    float4 input2 : COLOR0;
    float4 input3 : TANGENT;
    float2 input4 : TEXCOORD0;
    float2 input5 : TEXCOORD1;
    float2 input6 : TEXCOORD2;
    float2 input7 : TEXCOORD3;
    float4 input8 : TEXCOORD4;
    uint4 input9 : BLENDINDICES0;
};

struct Varyings209988
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
};

float3 DecodeOctNormal209988(uint packed)
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

float4 DecodePackedTangent209988(uint packed, float3 n)
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

float2 FilterNormalXY209988(float2 raw)
{
    float2 nxy = raw * 2.0 - 1.0;
    return float2(abs(nxy.x) < 0.012 ? 0.0 : nxy.x, abs(nxy.y) < 0.012 ? 0.0 : nxy.y);
}

Varyings209988 EID209988Vertex(Attributes209988 input)
{
    Varyings209988 o;
    uint packed = asuint(input.packedNormal.x);
    bool packedBasis = (packed & 0x40000000u) != 0u;
    float3 normalOS = packedBasis ? DecodeOctNormal209988(packed) : input.packedNormal.xxx;
    float4 tangentOS = packedBasis ? DecodePackedTangent209988(packed, normalOS) : input.input2;

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
    return o;
}

struct GBufferOutput209989
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput209989 EID209989Fragment(Varyings209988 input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput209989 o;
    float tangentInputSign = input.tangentWS.w > 0.0 ? 1.0 : -1.0;
    float2 uvBase = lerp(input.uv0, input.uv1, _P02.w) * _P11.xy + _P11.zw;
    float4 baseSample = SAMPLE_TEXTURE2D_BIAS(_Res33, sampler_Res33, uvBase, _EID209989MipBias);
    float2 uvNormal = lerp(input.uv0, input.uv1, _P03.x) * _P12.xy + _P12.zw;
    float4 normalSample = SAMPLE_TEXTURE2D_BIAS(_Res35, sampler_Res35, uvNormal, _P03.y + _EID209989MipBias);

    float2 nxy = FilterNormalXY209988(normalSample.xy);
    float3 baseColor = lerp(saturate(baseSample.rgb * _P08.rgb * _P04.z), _P08.rgb, _P04.x);
    float roughness = lerp(_P00.z, _P00.w, normalSample.z);
    float materialY = lerp(baseSample.a, _P04.y, saturate(_P03.w - 1.0));
    float ao = lerp(1.0, normalSample.w, _P01.x);

    float2 uvDetailN = lerp(input.uv0, input.uv1, _P23.z) * _P25.xy + _P25.zw;
    float4 detailN = SAMPLE_TEXTURE2D_BIAS(_Res38, sampler_Res38, uvDetailN, _EID209989MipBias);
    float blendSelect = _P22.y;
    float detailMask = lerp(
        lerp(1.0, detailN.w, saturate(blendSelect)),
        lerp(lerp(baseSample.a, normalSample.z, saturate(blendSelect - 2.0)), normalSample.w, saturate(blendSelect - 3.0)),
        saturate(blendSelect - 1.0));
    float2 dxy = FilterNormalXY209988(detailN.xy);
    float3 baseTS = float3(nxy * _P00.x, sqrt(saturate(1.0 - dot(nxy, nxy)))) + float3(0.0, 0.0, 1.0);
    float3 detailTS = float3(dxy * (detailMask * _P22.z), sqrt(saturate(1.0 - dot(dxy, dxy)))) * float3(-1.0, -1.0, 1.0);
    float3 blendedTS = (baseTS * dot(baseTS, detailTS)) / max(1e-5, baseTS.z) - detailTS;
    float albedoMix = detailMask * ((1.0 - _P22.x) * (1.0 - detailN.z));
    float3 tinted = lerp(saturate(baseColor * _P24.rgb * _P23.w), _P24.rgb, _P24.w);
    baseColor = lerp(baseColor, tinted, albedoMix.xxx);
    roughness = lerp(roughness, lerp(detailN.w, detailN.z, _P22.x), _P22.w * detailMask);
    ao *= lerp(1.0, lerp(1.0, detailN.w, _P22.x), _P22.w * detailMask);

    float2 uvOverlay = lerp(input.uv0, input.uv1, _P33.x) * _P41.xy + _P41.zw;
    float3 detail = SAMPLE_TEXTURE2D_BIAS(_Res37, sampler_Res37, uvOverlay, _EID209989MipBias).xyz;
    float3 lo = float3(_P36.x, _P36.z, _P37.x);
    float3 hi = float3(_P36.y, _P36.w, _P37.y);
    float3 weights = saturate(lo * 0.5 + lerp(-lo, 1.0, detail + hi)) * float3(_P38.w, _P39.w, _P40.w);
    float4 layered = float4(baseColor, roughness);
    layered = lerp(layered, float4(_P40.xyz, _P34.w), weights.z);
    layered = lerp(layered, float4(_P39.xyz, _P34.x), weights.y);
    layered = lerp(layered, float4(_P38.xyz, _P33.y), weights.x);
    baseColor = layered.xyz;
    roughness = layered.w;
    materialY = lerp(materialY, _P35.z, weights.z);
    materialY = lerp(materialY, _P35.y, weights.y);
    materialY = lerp(materialY, _P35.x, weights.x);

    float faceSign = isFrontFace ? 1.0 : (_P01.w > 0.0 ? -1.0 : 1.0);
    float3 n = normalize(input.normalWS);
    float3 t = normalize(input.tangentWS.xyz);
    float3 b = normalize(cross(n, t)) * tangentInputSign;
    float3 tangentN = float3(blendedTS.xy, blendedTS.z * faceSign);
    float3 normalWS = normalize(t * tangentN.x + b * tangentN.y + n * tangentN.z);

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

    o.rt0 = float4(0.0, 0.0, 0.0, 0.5);
    o.rt1 = float4(encodedMotion, motionWeight > 0.0 ? 1.0 : _P07.x, motionWeight);
    o.rt2 = float4(materialY, ao, materialZ, float(materialId / 4u) * 0.3333333433);
    o.rt3 = float4(oct, roughness, float(materialId % 4u) * 0.3333333433);
    o.rt4 = float4(baseColor, 0.0);
    return o;
}

#endif
