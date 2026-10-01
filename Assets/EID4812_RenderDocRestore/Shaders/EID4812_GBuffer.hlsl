#ifndef EID4812_GBUFFER_INCLUDED
#define EID4812_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_56); SAMPLER(sampler_56);
TEXTURE2D(_58); SAMPLER(sampler_58);

static const float4 _P00 = float4(0, 0, 0, 1);
static const float4 _P01 = float4(0, 0, 0, 0);
static const float4 _P06 = float4(1, 1, 1, 1);
static const float4 _P10 = float4(1, 1, 0, 0);
static const float4 _InstancePacked = asfloat(uint4(19247u, 12488u, 258u, 0x3f800000u));
static const float _EID4812MipBias = -1;

struct Attributes4812GBuffer
{
    float3 position : POSITION;
    float3 bakedNormal : NORMAL;
    float2 uv : TEXCOORD0;
    float4 bakedTangent : TEXCOORD6;
};

struct Varyings4812GBuffer
{
    float4 positionCS : SV_POSITION;
    float2 uv : TEXCOORD0;
    float3 normalWS : TEXCOORD1;
    float4 tangentWS : TEXCOORD2;
    float3 currentClipXYW : TEXCOORD3;
    float3 previousClipXYW : TEXCOORD4;
};

struct GBufferOutput4812
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

Varyings4812GBuffer EID4812GBufferVertex(Attributes4812GBuffer input)
{
    Varyings4812GBuffer o;
    float3 positionWS = TransformObjectToWorld(input.position);
    float3 normalWS = normalize(TransformObjectToWorldNormal(input.bakedNormal));
    float3 tangentWS = normalize(TransformObjectToWorldDir(input.bakedTangent.xyz));
    float4 clipPos = TransformWorldToHClip(positionWS);
    o.positionCS = clipPos;
    o.uv = input.uv * _P10.xy + _P10.zw;
    o.normalWS = normalWS;
    o.tangentWS = float4(tangentWS, input.bakedTangent.w * GetOddNegativeScale());
    o.currentClipXYW = clipPos.xyw;
    o.previousClipXYW = clipPos.xyw;
    return o;
}

GBufferOutput4812 EID4812GBufferFragment(Varyings4812GBuffer input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput4812 o;
    float4 albedoSample = SAMPLE_TEXTURE2D_BIAS(_56, sampler_56, input.uv, _EID4812MipBias);
    float3 albedo = albedoSample.rgb * _P06.rgb;

    float2 nxy = SAMPLE_TEXTURE2D_BIAS(_58, sampler_58, input.uv, _EID4812MipBias).xy * 2.0 - 1.0;
    nxy *= _P00.w;
    float nz = max(0.0, sqrt(saturate(1.0 - dot(nxy, nxy))));

    float3 n = input.normalWS;
    float3 t = input.tangentWS.xyz;
    float3 b = cross(n, t) * input.tangentWS.w;
    float3 mapped = mul(float3(nxy.x, nxy.y, nz), float3x3(t, b, n));
    float faceSign = isFrontFace ? 1.0 : (2.0 * _P01.y - 1.0);
    float3 normalWS = normalize(mapped * faceSign);

    float2 motion = input.currentClipXYW.xy / max(input.currentClipXYW.z, 1e-8) - input.previousClipXYW.xy / max(input.previousClipXYW.z, 1e-8);
    motion.y = -motion.y;
    float2 encodedMotion = sqrt(sqrt(abs(motion * 0.5))) * (float2)(int2)sign(motion) * 0.5 + 0.5;

    uint packedMat = asuint(_InstancePacked.z);
    float4 unpacked = float4(
        float(packedMat & 1023u) * 0.0010,
        float((packedMat >> 10u) & 1023u) * 0.0010,
        float((packedMat >> 20u) & 1023u) * 0.0010,
        float((packedMat >> 30u) & 3u) * 0.3333);

    float3 octN = normalize(normalWS);
    float2 oct = octN.xz / dot(1.0.xxx, abs(octN));
    if (octN.y <= 0.0)
        oct = (1.0 - abs(oct.yx)) * (step(0.0, oct) * 2.0 - 1.0);
    oct = oct * 0.5 + 0.5;

    // EID1727 contributes its base color in RT4; RT0 is filled by CharacterForward later.
    o.rt0 = float4(0.0, 0.0, 0.0, 0.0);
    o.rt1 = float4(encodedMotion, 1.0, 0.4);
    o.rt2 = unpacked;
    o.rt3 = float4(oct, 0.0, 1.0);
    o.rt4 = float4(albedo, 1.0);
    return o;
}

#endif
