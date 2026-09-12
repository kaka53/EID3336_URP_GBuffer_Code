#ifndef EID209984_209985_GBUFFER_INCLUDED
#define EID209984_209985_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_Res24); SAMPLER(sampler_Res24);
TEXTURE2D(_Res26); SAMPLER(sampler_Res26);
TEXTURE2D(_Res28); SAMPLER(sampler_Res28);

CBUFFER_START(UnityPerMaterial)
float4 _P00; float4 _P01; float4 _P02; float4 _P03;
float4 _P04; float4 _P05; float4 _P06; float4 _P07;
float4 _P08; float4 _P09; float4 _P10; float4 _P11;
float4 _P12; float4 _P13; float4 _P14; float4 _P15;
float4 _P16; float4 _P17; float4 _P18; float4 _P19;
float4 _P20; float4 _P21; float4 _P22; float4 _P23;
float4 _P24; float4 _P25; float4 _P26; float4 _P27;
float4 _P28; float4 _P29; float4 _P30;
float4 _InstanceMeta;
float4 _InstanceStateYZ;
float _EID209985MipBias;
float _UseBakedSkinning;
CBUFFER_END

struct Attributes209984
{
    float4 positionPacked : POSITION;
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

struct Varyings209984
{
    float4 positionCS : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    float2 uv1 : TEXCOORD1;
    float3 normalWS : TEXCOORD2;
    float4 tangentWS : TEXCOORD3;
    float3 currentClipXYW : TEXCOORD5;
    float3 previousClipXYW : TEXCOORD6;
    nointerpolation uint instanceIndex : TEXCOORD7;
};

float3 DecodeOctNormal209984(uint packed)
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

float4 DecodePackedTangent209984(uint packed, float3 n)
{
    float signed10 = float((packed << 2u) >> 22u);
    signed10 = (signed10 >= 512.0) ? signed10 - 1024.0 : signed10;
    float3 seed = n.yzx - n.zxy;
    float3 t0 = normalize(seed - dot(seed, n) * n);
    float tangentSign = signed10 < 0.0 ? -1.0 : 1.0;
    float encoded = 1.0 - abs(signed10) * 0.0039138942956924438;
    float2 r = normalize(float2(encoded, tangentSign * (1.0 - abs(encoded))));
    float3 t1 = normalize(cross(n, t0));
    float3 t = t0 * r.x + t1 * r.y;
    return float4(t, float((packed >> 31u) & 1u) * 2.0 - 1.0);
}

Varyings209984 EID209984Vertex(Attributes209984 input)
{
    Varyings209984 o;
    uint packed = asuint(input.positionPacked.w);
    bool packedBasis = (packed & 0x40000000u) != 0u;
    float3 decodedNormalOS = packedBasis ? DecodeOctNormal209984(packed) : float3(input.positionPacked.w, 0.0, 1.0);
    float4 decodedTangentOS = packedBasis ? DecodePackedTangent209984(packed, decodedNormalOS) : input.input2;
    float3 normalOS = _UseBakedSkinning > 0.5 ? input.bakedNormalOS : decodedNormalOS;
    float4 tangentOS = _UseBakedSkinning > 0.5 ? input.bakedTangentOS : decodedTangentOS;

    float3 positionWS = TransformObjectToWorld(input.positionPacked.xyz);
    float3 normalWS = normalize(TransformObjectToWorldNormal(normalOS));
    float3 tangentWS = normalize(TransformObjectToWorldDir(tangentOS.xyz));
    float tangentSignWS = tangentOS.w * GetOddNegativeScale();
    float4 clip = TransformWorldToHClip(positionWS);

    o.positionCS = clip;
    o.uv0 = input.input4;
    o.uv1 = input.input5;
    o.normalWS = normalWS;
    o.tangentWS = float4(tangentWS, tangentSignWS);
    o.currentClipXYW = clip.xyw;
    o.previousClipXYW = clip.xyw;
    o.instanceIndex = 0u;
    return o;
}

struct GBufferOutput209985
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput209985 EID209985Fragment(Varyings209984 input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput209985 o;
    float tangentInputSign = input.tangentWS.w > 0.0 ? 1.0 : -1.0;
    float2 uvBase = lerp(input.uv0, input.uv1, _P02.w) * _P11.xy + _P11.zw;
    float4 baseSample = SAMPLE_TEXTURE2D_BIAS(_Res24, sampler_Res24, uvBase, _EID209985MipBias);
    float2 uvNormal = lerp(input.uv0, input.uv1, _P03.x) * _P12.xy + _P12.zw;
    float4 normalSample = SAMPLE_TEXTURE2D_BIAS(_Res26, sampler_Res26, uvNormal, _P03.y + _EID209985MipBias);

    float2 nxy = normalSample.xy * 2.0 - 1.0;
    nxy = float2(abs(nxy.x) < 0.012 ? 0.0 : nxy.x, abs(nxy.y) < 0.012 ? 0.0 : nxy.y);
    float2 normalXY = nxy * _P00.x;
    float3 baseColor = lerp(saturate(baseSample.rgb * _P08.rgb * _P04.z), _P08.rgb, _P04.x);
    float roughness = lerp(_P00.z, _P00.w, normalSample.z);
    float materialY = lerp(baseSample.a, _P04.y, saturate(_P03.w - 1.0));

    float2 uvOverlay = lerp(input.uv0, input.uv1, _P22.x) * _P30.xy + _P30.zw;
    float3 detail = SAMPLE_TEXTURE2D_BIAS(_Res28, sampler_Res28, uvOverlay, _EID209985MipBias).xyz;
    float3 lo = float3(_P25.x, _P25.z, _P26.x);
    float3 hi = float3(_P25.y, _P25.w, _P26.y);
    float3 weights = saturate(lo * 0.5 + lerp(-lo, 1.0, detail + hi)) * float3(_P27.w, _P28.w, _P29.w);
    float4 layered = float4(baseColor, roughness);
    layered = lerp(layered, float4(_P29.xyz, _P23.w), weights.z);
    layered = lerp(layered, float4(_P28.xyz, _P23.x), weights.y);
    layered = lerp(layered, float4(_P27.xyz, _P22.y), weights.x);
    baseColor = layered.xyz;
    roughness = layered.w;
    materialY = lerp(materialY, _P24.z, weights.z);
    materialY = lerp(materialY, _P24.y, weights.y);
    materialY = lerp(materialY, _P24.x, weights.x);

    float faceSign = isFrontFace ? 1.0 : (_P01.w > 0.0 ? -1.0 : 1.0);
    float tangentZ = sqrt(saturate(1.0 - dot(nxy, nxy))) * faceSign;
    float3 n = normalize(input.normalWS);
    float3 t = normalize(input.tangentWS.xyz);
    float3 b = normalize(cross(n, t)) * tangentInputSign;
    float3 normalWS = normalize(t * normalXY.x + b * normalXY.y + n * tangentZ);

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
    o.rt2 = float4(materialY, lerp(1.0, normalSample.w, _P01.x), materialZ, float(materialId / 4u) * 0.3333333433);
    o.rt3 = float4(oct, roughness, float(materialId % 4u) * 0.3333333433);
    o.rt4 = float4(baseColor, 0.0);
    return o;
}

#endif
