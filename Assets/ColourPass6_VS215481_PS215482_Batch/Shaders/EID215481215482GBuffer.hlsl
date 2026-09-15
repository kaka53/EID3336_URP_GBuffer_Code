#ifndef EID215481_215482_GBUFFER_INCLUDED
#define EID215481_215482_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_Res12); SAMPLER(sampler_Res12);

CBUFFER_START(UnityPerMaterial)
float4 _P00; float4 _P01; float4 _P02; float4 _P03;
float4 _P04; float4 _P05; float4 _P06; float4 _P07;
float4 _P08; float4 _P09; float4 _P10; float4 _P11;
float4 _P12; float4 _P13; float4 _P14; float4 _P15;
float4 _P16; float4 _P17; float4 _P18; float4 _P19;
float4 _P20; float4 _P21;
float _EID215482MipBias;
float _UseBakedSkinning;
CBUFFER_END

struct Attributes215481
{
    float3 position : POSITION;
    float3 packedNormal : NORMAL;
    float2 uv : TEXCOORD0;
    float4 input6 : TEXCOORD3;
    uint4 input7 : BLENDINDICES0;
    float3 bakedNormalOS : TEXCOORD4;
};

struct Varyings215481
{
    float4 positionCS : SV_POSITION;
    float2 uv : TEXCOORD0;
};

Varyings215481 EID215481Vertex(Attributes215481 input)
{
    Varyings215481 o;
    float3 positionWS = TransformObjectToWorld(input.position);
    float4 clip = TransformWorldToHClip(positionWS);
    o.positionCS = clip;
    o.uv = input.uv * _P10.xy + _P10.zw;
    return o;
}

struct GBufferOutput215482
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput215482 EID215482Fragment(Varyings215481 input)
{
    GBufferOutput215482 o;
    float clipSample = SAMPLE_TEXTURE2D_BIAS(_Res12, sampler_Res12, input.uv, _EID215482MipBias).x;
    clip(clipSample - _P12.x);
    o.rt0 = float4(0.0, 0.0, 0.0, 0.0);
    o.rt1 = float4(0.0, 0.0, 0.0, 0.0);
    o.rt2 = float4(0.0, 0.0, 0.0, 0.0);
    o.rt3 = float4(0.0, 0.0, 0.0, 0.0);
    o.rt4 = float4(0.0, 0.0, 0.0, 0.0);
    return o;
}

#endif
