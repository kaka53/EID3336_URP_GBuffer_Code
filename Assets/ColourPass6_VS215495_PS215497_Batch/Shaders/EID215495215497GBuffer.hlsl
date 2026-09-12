#ifndef EID215495_215497_GBUFFER_INCLUDED
#define EID215495_215497_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_Res27); SAMPLER(sampler_Res27);
TEXTURE2D(_Res29); SAMPLER(sampler_Res29);
TEXTURE2D(_Res31); SAMPLER(sampler_Res31);
TEXTURE2D(_Res32); SAMPLER(sampler_Res32);

CBUFFER_START(UnityPerMaterial)
float4 _P00; float4 _P01; float4 _P02; float4 _P03;
float4 _P04; float4 _P05; float4 _P06; float4 _P07;
float4 _P08; float4 _P09; float4 _P10; float4 _P11;
float4 _P12; float4 _P13; float4 _P14; float4 _P15;
float4 _P16; float4 _P17; float4 _P18; float4 _P19;
float4 _P20; float4 _P21; float4 _P22; float4 _P23;
float4 _P24; float4 _P25; float4 _P26; float4 _P27;
float4 _P28; float4 _P29; float4 _P30; float4 _P31;
float4 _P32; float4 _P33; float4 _P34;
float4 _InstanceMeta;
float4 _InstanceStateYZ;
float _EID215497MipBias;
float _UseBakedSkinning;
CBUFFER_END

struct Attributes215495
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

struct Varyings215495
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
    float absViewZ : TEXCOORD8;
};

float3 DecodeOctNormal215495(uint packed)
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

float4 DecodePackedTangent215495(uint packed, float3 n)
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

float2 DeadzoneNormalXY(float2 encoded)
{
    float2 nxy = encoded * 2.0 - 1.0;
    return abs(nxy) < 0.012.xx ? 0.0.xx : nxy;
}

Varyings215495 EID215495Vertex(Attributes215495 input)
{
    Varyings215495 o;
    uint packed = asuint(input.packedNormal.x);
    bool packedBasis = (packed & 0x40000000u) != 0u;
    float3 decodedNormalOS = packedBasis ? DecodeOctNormal215495(packed) : input.packedNormal.xyz;
    float4 decodedTangentOS = packedBasis ? DecodePackedTangent215495(packed, decodedNormalOS) : input.input2;
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
    o.absViewZ = abs(TransformWorldToView(positionWS).z);
    return o;
}

struct GBufferOutput215497
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput215497 EID215497Fragment(Varyings215495 input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput215497 o;
    float tangentInputSign = input.tangentWS.w > 0.0 ? 1.0 : -1.0;
    float2 uvAlbedo = lerp(input.uv0, input.uv1, _P02.w) * _P11.xy + _P11.zw;
    float2 uvNormal = lerp(input.uv0, input.uv1, _P03.x) * _P12.xy + _P12.zw;
    float4 albedoSample = SAMPLE_TEXTURE2D_BIAS(_Res27, sampler_Res27, uvAlbedo, _EID215497MipBias);
    float4 normalSample = SAMPLE_TEXTURE2D_BIAS(_Res29, sampler_Res29, uvNormal, _P03.y + _EID215497MipBias);

    float2 nxyRaw = DeadzoneNormalXY(normalSample.xy);
    float2 nxy = nxyRaw * _P00.x;
    float nz = sqrt(saturate(1.0 - dot(nxyRaw, nxyRaw)));

    float3 baseColor = saturate(albedoSample.rgb * _P08.rgb * _P04.z);
    baseColor = lerp(baseColor, _P08.rgb, _P04.x);
    float roughness = lerp(_P00.z, _P00.w, normalSample.z);
    float ao = lerp(1.0, normalSample.w, _P01.x);
    float materialY = lerp(albedoSample.w, _P04.y, saturate(_P03.w - 1.0));

    float2 uvDetail = lerp(input.uv0, input.uv1, _P23.z) * _P25.xy + _P25.zw;
    float4 detailSample = SAMPLE_TEXTURE2D_BIAS(_Res32, sampler_Res32, uvDetail, _EID215497MipBias);
    float mixW = lerp(1.0, detailSample.w, saturate(_P22.y));
    float blendSrc = lerp(albedoSample.w, normalSample.z, saturate(_P22.y - 2.0));
    blendSrc = lerp(blendSrc, normalSample.w, saturate(_P22.y - 3.0));
    float detailMask = lerp(mixW, blendSrc, saturate(_P22.y - 1.0));
    float fade = saturate((_P23.y - input.absViewZ) / (_P23.y - _P23.x));
    float detailAlpha = detailMask * fade;

    float2 dxyRaw = DeadzoneNormalXY(detailSample.xy);
    float2 dxy = dxyRaw * (detailAlpha * _P22.z);
    float dnz = sqrt(saturate(1.0 - dot(dxyRaw, dxyRaw)));
    float3 n1 = float3(nxy, nz);
    float3 n2 = float3(dxy, dnz) * float3(-1.0, -1.0, 1.0);
    float3 rnmT = n1 + float3(0.0, 0.0, 1.0);
    float3 blendedN = rnmT * dot(rnmT, n2) / max(rnmT.z, 1e-8) - n2;

    float detailRough = lerp(detailSample.w, detailSample.z, _P22.x);
    roughness = lerp(roughness, detailRough, _P22.w * detailAlpha);
    ao *= lerp(1.0, lerp(1.0, detailSample.w, _P22.x), _P22.w * detailAlpha);
    float3 detailTint = saturate(baseColor * _P24.rgb * _P23.w);
    detailTint = lerp(detailTint, _P24.rgb, _P24.aaa);
    float detailAlbedoMix = detailAlpha * (1.0 - _P22.x) * (1.0 - detailSample.z);
    baseColor = lerp(baseColor, detailTint, detailAlbedoMix);

    float2 uvOverlay = lerp(input.uv0, input.uv1, _P26.x) * _P34.xy + _P34.zw;
    float4 overlaySample = SAMPLE_TEXTURE2D_BIAS(_Res31, sampler_Res31, uvOverlay, _EID215497MipBias);
    float3 overlayLo = float3(_P29.x, _P29.z, _P30.x);
    float3 overlayHi = float3(_P29.y, _P29.w, _P30.y);
    float3 overlayW = saturate(overlayLo * 0.5 + lerp(-overlayLo, 1.0.xxx, overlaySample.xyz + overlayHi)) * float3(_P31.w, _P32.w, _P33.w);
    float4 acc = float4(baseColor, roughness);
    acc = lerp(acc, float4(_P33.rgb, _P27.w), overlayW.z);
    acc = lerp(acc, float4(_P32.rgb, _P27.x), overlayW.y);
    acc = lerp(acc, float4(_P31.rgb, _P26.y), overlayW.x);
    materialY = lerp(materialY, _P28.z, overlayW.z);
    materialY = lerp(materialY, _P28.y, overlayW.y);
    materialY = lerp(materialY, _P28.x, overlayW.x);

    float faceSign = isFrontFace ? 1.0 : (_P01.w > 0.0 ? -1.0 : 1.0);
    float3 n = normalize(input.normalWS);
    float3 t = normalize(input.tangentWS.xyz);
    float3 b = normalize(cross(n, t)) * tangentInputSign;
    float3 normalWS = normalize(t * blendedN.x + b * blendedN.y + n * (blendedN.z * faceSign));

    uint materialId = (uint)_InstanceMeta.w;
    float materialZ = (saturate(_P04.w * acc.w + _P05.y * materialY + _P05.x) * 0.95 + 0.05) * (1.0 - _P07.y);
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
    o.rt3 = float4(oct, acc.w, float(materialId % 4u) * 0.3333333433);
    o.rt4 = float4(acc.rgb, 0.0);
    return o;
}

#endif
