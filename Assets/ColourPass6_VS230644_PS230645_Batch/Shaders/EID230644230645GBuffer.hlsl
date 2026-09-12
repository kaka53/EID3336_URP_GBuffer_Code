#ifndef EID230644_230645_GBUFFER_INCLUDED
#define EID230644_230645_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_Res23); SAMPLER(sampler_Res23);
TEXTURE2D(_Res25); SAMPLER(sampler_Res25);
TEXTURE2D(_Res27); SAMPLER(sampler_Res27);
TEXTURE2D(_Res29); SAMPLER(sampler_Res29);

CBUFFER_START(UnityPerMaterial)
float4 _P00; float4 _P01; float4 _P02; float4 _P03;
float4 _P04; float4 _P05; float4 _P06; float4 _P07;
float4 _P08; float4 _P09; float4 _P10; float4 _P11;
float4 _P12; float4 _P13; float4 _P14; float4 _P15;
float4 _InstanceStateYZ;
float4 _InstanceChild5;
float4 _InstanceChild6;
float4 _InstanceChild8;
float _EID230645MipBias;
float _EID230645GlobalY;
float _UseBakedSkinning;
CBUFFER_END

struct Attributes230644
{
    float3 position : POSITION;
    float4 packedNormal : NORMAL;
    float4 input2 : COLOR0;
    float4 input3 : TEXCOORD0;
    float4 input4 : TEXCOORD1;
    float4 input5 : TEXCOORD2;
    float4 input6 : TEXCOORD3;
    uint4 input7 : BLENDINDICES0;
    float3 bakedNormalOS : TEXCOORD4;
    float4 bakedTangentOS : TEXCOORD5;
};

struct Varyings230644
{
    float4 positionCS : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    float2 uv1 : TEXCOORD1;
    float3 normalWS : TEXCOORD2;
    float4 tangentWS : TEXCOORD3;
    float3 currentClipXYW : TEXCOORD4;
    float3 previousClipXYW : TEXCOORD5;
    nointerpolation uint instanceIndex : TEXCOORD6;
};

float3 DecodeOctNormal230644(uint packed)
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

float4 DecodePackedTangent230644(uint packed, float3 n)
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

Varyings230644 EID230644Vertex(Attributes230644 input)
{
    Varyings230644 o;
    uint packed = asuint(input.packedNormal.x);
    bool packedBasis = (packed & 0x40000000u) != 0u;
    float3 decodedNormalOS = packedBasis ? DecodeOctNormal230644(packed) : input.packedNormal.xyz;
    float4 decodedTangentOS = packedBasis ? DecodePackedTangent230644(packed, decodedNormalOS) : input.input2;
    float3 normalOS = _UseBakedSkinning > 0.5 ? input.bakedNormalOS : decodedNormalOS;
    float4 tangentOS = _UseBakedSkinning > 0.5 ? input.bakedTangentOS : decodedTangentOS;

    float3 positionWS = TransformObjectToWorld(input.position);
    float3 previousWS = TransformObjectToWorld(input.position);
    float3 normalWS = normalize(TransformObjectToWorldNormal(normalOS));
    float3 tangentWS = normalize(TransformObjectToWorldDir(tangentOS.xyz));
    float4 clip = TransformWorldToHClip(positionWS);
    float4 prevClip = TransformWorldToHClip(previousWS);

    o.positionCS = clip;
    o.uv0 = input.input3.xy;
    o.uv1 = input.input4.xy;
    o.normalWS = normalWS;
    o.tangentWS = float4(tangentWS, tangentOS.w * GetOddNegativeScale());
    o.currentClipXYW = clip.xyw;
    o.previousClipXYW = prevClip.xyw;
    o.instanceIndex = 0u;
    return o;
}

struct GBufferOutput230645
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput230645 EID230645Fragment(Varyings230644 input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput230645 o;
    float tangentInputSign = input.tangentWS.w > 0.0 ? 1.0 : -1.0;
    float mip = _EID230645MipBias;
    float4 albedoSample = SAMPLE_TEXTURE2D_BIAS(_Res23, sampler_Res23, input.uv0, mip);
    float4 normalSample = SAMPLE_TEXTURE2D_BIAS(_Res25, sampler_Res25, input.uv0, _P02.y + mip);
    float4 packedSample = SAMPLE_TEXTURE2D_BIAS(_Res27, sampler_Res27, input.uv0, mip);
    float2 overlayUV = lerp(input.uv0, input.uv1, _P11.x);
    float4 overlaySample = SAMPLE_TEXTURE2D_BIAS(_Res29, sampler_Res29, overlayUV, mip);

    float2 nxy = float2(normalSample.w * normalSample.x, normalSample.y) * 2.0 - 1.0;
    float nz = max(0.0, sqrt(saturate(1.0 - dot(nxy, nxy))));
    nxy *= _P00.x;
    float3 nts = float3(nxy, nz);

    float3 baseAlbedo = albedoSample.rgb * _InstanceChild5.rgb;
    float roughnessLo = lerp(_P00.z, _P00.w, packedSample.y);
    float ao = lerp(1.0, packedSample.z, _P01.x);
    float materialY = packedSample.x;

    float3 n = normalize(input.normalWS);
    float3 t = normalize(input.tangentWS.xyz);
    float3 b = normalize(cross(n, t)) * tangentInputSign;
    float3x3 tbn = float3x3(t, b, n);
    float3 normalWS = normalize(mul(nts, tbn));
    normalWS = isFrontFace ? normalWS : -normalWS;

    float3 overlayRgb = overlaySample.x * _InstanceChild6.rgb + (overlaySample.y * _P13.rgb + overlaySample.z * _P14.rgb) * _P11.y;
    float3 color = lerp(baseAlbedo, 1.0.xxx, _P02.x.xxx) * overlayRgb;
    color *= lerp(1.0, _EID230645GlobalY, _P01.w);

    uint backfaceConst = asuint(_InstanceChild8.y) & 1u;
    if (backfaceConst != 0u && !isFrontFace)
        color = _P03.rgb;

    float active = saturate(float((int)sign(max(_InstanceStateYZ.x, _InstanceStateYZ.y) - 0.1)));
    float2 motion = input.currentClipXYW.xy / max(input.currentClipXYW.z, 1e-8) - input.previousClipXYW.xy / max(input.previousClipXYW.z, 1e-8);
    motion.y = -motion.y;
    float2 encodedMotion = lerp(sqrt(sqrt(abs(motion * 0.5))) * (float2)(int2)sign(motion) * 0.5 + 0.5, 0.5.xx, active.xx);
    float motionWeight = lerp(0.0, 0.7, active);
    float motionZ = lerp(0.0, 1.0, active);

    float3 octN = normalize(normalWS);
    float2 oct = octN.xz / dot(1.0.xxx, abs(octN));
    if (octN.y <= 0.0)
        oct = (1.0 - abs(oct.yx)) * (step(0.0, oct) * 2.0 - 1.0);
    oct = oct * 0.5 + 0.5;

    o.rt0 = float4(color, 0.5);
    o.rt1 = float4(encodedMotion, motionZ, motionWeight);
    o.rt2 = float4(materialY, ao, 0.0, 0.0);
    o.rt3 = float4(oct, roughnessLo, 0.0);
    o.rt4 = float4(baseAlbedo, 0.0);
    return o;
}

#endif
