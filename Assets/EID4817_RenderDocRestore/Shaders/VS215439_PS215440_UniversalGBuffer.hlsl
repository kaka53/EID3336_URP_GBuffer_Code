#ifndef EID215439_215440_GBUFFER_INCLUDED
#define EID215439_215440_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_EID4817_GBuffer_Res24); SAMPLER(sampler_EID4817_GBuffer_Res24);

CBUFFER_START(UnityPerMaterial)
float4 _EID4817_GBuffer_P00; float4 _EID4817_GBuffer_P01; float4 _EID4817_GBuffer_P02; float4 _EID4817_GBuffer_P03;
float4 _EID4817_GBuffer_P04; float4 _EID4817_GBuffer_P05; float4 _EID4817_GBuffer_P06; float4 _EID4817_GBuffer_P07;
float4 _EID4817_GBuffer_P08; float4 _EID4817_GBuffer_P09; float4 _EID4817_GBuffer_P10; float4 _EID4817_GBuffer_P11;
float4 _EID4817_GBuffer_P12; float4 _EID4817_GBuffer_P13; float4 _EID4817_GBuffer_P14; float4 _EID4817_GBuffer_P15;
float4 _EID4817_GBuffer_P16; float4 _EID4817_GBuffer_P17;
float4 _EID4817_GBuffer_InstancePacked;
float _EID4817_GBuffer_EID215440MipBias;
float _EID4817_GBuffer_UseBakedSkinning;
float _EID4817_GBuffer_StencilRef;
   
   
   
   
   
   

CBUFFER_END


struct Attributes215439 { float3 position:POSITION; float3 bakedNormalOS:NORMAL; float2 uv:TEXCOORD0; };

struct Varyings215439
{
    float4 positionCS : SV_POSITION;
    float2 uv : TEXCOORD0;
    float3 normalWS : TEXCOORD1;
    float3 currentClipXYW : TEXCOORD2;
    float3 previousClipXYW : TEXCOORD3;
    float3 positionWS : TEXCOORD4;
};

float3 DecodeOctNormal215439(uint packed)
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

Varyings215439 EID215439Vertex(Attributes215439 input)
{
    Varyings215439 o;
    float3 normalOS = input.bakedNormalOS;
    float3 positionWS = TransformObjectToWorld(input.position);
    float3 normalWS = normalize(TransformObjectToWorldNormal(normalOS));
    float4 clip = TransformWorldToHClip(positionWS);

    o.positionCS = clip;
    o.uv = input.uv * _EID4817_GBuffer_P10.xy + _EID4817_GBuffer_P10.zw;
    o.normalWS = normalWS;
    o.currentClipXYW = clip.xyw;
    o.previousClipXYW = clip.xyw;
    o.positionWS = positionWS;
    return o;
}

struct GBufferOutput215440
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput215440 EID215440Fragment(Varyings215439 input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput215440 o;
    float4 albedoSample = SAMPLE_TEXTURE2D_BIAS(_EID4817_GBuffer_Res24, sampler_EID4817_GBuffer_Res24, input.uv, _EID4817_GBuffer_EID215440MipBias);
    float3 tinted = albedoSample.rgb * _EID4817_GBuffer_P06.rgb;

    float faceSign = isFrontFace ? 1.0 : (2.0 * _EID4817_GBuffer_P01.y - 1.0);
    float3 normalWS = normalize(input.normalWS * faceSign);

    float2 motion = input.currentClipXYW.xy / max(input.currentClipXYW.z, 1e-8) - input.previousClipXYW.xy / max(input.previousClipXYW.z, 1e-8);
    motion.y = -motion.y;
    float2 encodedMotion = sqrt(sqrt(abs(motion * 0.5))) * (float2)(int2)sign(motion) * 0.5 + 0.5;

    uint packedMat = asuint(_EID4817_GBuffer_InstancePacked.z);
    float4 unpacked = float4(
        float(packedMat & 1023u) * (1.0 / 1023.0),
        float((packedMat >> 10u) & 1023u) * (1.0 / 1023.0),
        float((packedMat >> 20u) & 1023u) * (1.0 / 1023.0),
        float((packedMat >> 30u) & 3u) * (1.0 / 3.0));

    float3 octN = normalize(normalWS);
    float2 oct = octN.xz / dot(1.0.xxx, abs(octN));
    if (octN.y <= 0.0)
        oct = (1.0 - abs(oct.yx)) * (step(0.0, oct) * 2.0 - 1.0);
    oct = oct * 0.5 + 0.5;

    o.rt0 = float4(0.0, 0.0, 0.0, 0.0);
    o.rt1 = float4(encodedMotion, 1.0, 0.4);
    o.rt2 = unpacked;
    o.rt3 = float4(oct, 0.0, 0.7);
    o.rt4 = float4(tinted, 1.0);
    return o;
}


#endif
