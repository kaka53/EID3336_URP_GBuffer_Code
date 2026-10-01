#ifndef EID215479_215480_GBUFFER_INCLUDED
#define EID215479_215480_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_OutlineMask); SAMPLER(sampler_OutlineMask);
TEXTURE2D(_Res12); SAMPLER(sampler_Res12);

CBUFFER_START(UnityPerMaterial)
float4 _P00; float4 _P01; float4 _P02; float4 _P03;
float4 _P04; float4 _P05; float4 _P06; float4 _P07;
float4 _P08; float4 _P09; float4 _P10; float4 _P11;
float4 _P12; float4 _P13; float4 _P14; float4 _P15;
float4 _P16; float4 _P17; float4 _P18; float4 _P19;
float4 _P20;
float _EID215480MipBias;
float _UseBakedSkinning;
CBUFFER_END

struct Attributes215479
{
    float3 position : POSITION;
    float3 packedNormal : NORMAL;
    float2 uv : TEXCOORD0;
    float4 input6 : TEXCOORD3;
    uint4 input7 : BLENDINDICES0;
    float3 bakedNormalOS : TEXCOORD4;
    float3 outlineDirectionOS : TEXCOORD5;
};

struct Varyings215479
{
    float4 positionCS : SV_POSITION;
    float2 uv : TEXCOORD0;
};

Varyings215479 EID215479Vertex(Attributes215479 input)
{
    Varyings215479 o;
    float3 positionWS = TransformObjectToWorld(input.position);
    float4 clip = TransformWorldToHClip(positionWS);
    // Direction is reconstructed from the captured packed tangent frame,
    // SNORM input4 and full-precision captured skin weights by the installer.
    float3 directionWS = mul((float3x3)unity_ObjectToWorld, input.outlineDirectionOS);
    float2 projected = mul((float3x3)UNITY_MATRIX_VP, directionWS).xy;
    projected *= rsqrt(max(dot(projected, projected), 1e-30));
    float q = rcp(abs(UNITY_MATRIX_P._m11));
    float a = min(q, rcp(q));
    float halfFov = (1.0 + (-0.30189499259 + 0.08729290217*a*a)*a*a)*a;
    halfFov = q < 1.0 ? halfFov : 1.5707963705-halfFov;
    float2 mask = SAMPLE_TEXTURE2D_LOD(_OutlineMask, sampler_OutlineMask, input.uv*_P10.xy+_P10.zw, 0).rg;
    float2 width = projected * float2(_ScaledScreenParams.y/_ScaledScreenParams.x,1)
        * (_P12.x*0.392699033/halfFov)
        * saturate(clip.w*halfFov*114.591568*0.04)*0.005;
    float2 minimumWidth = rcp(_ScaledScreenParams.xy)*clamp(clip.w,0,1.570796132/halfFov);
    clip.xy += sign(width)*max(abs(width),minimumWidth)*mask.r;
    // Use the live Unity projection: no capture-only jitter is applied to scene depth.
    float push = _P12.y*mask.g*0.1;
    if (unity_OrthoParams.w < 0.5) {
        float viewZ = -clip.w-push;
        clip.z = (UNITY_MATRIX_P._m22*viewZ+UNITY_MATRIX_P._m23)*clip.w/(-viewZ);
    } else {
        clip.z -= UNITY_MATRIX_P._m22*push;
    }
    o.positionCS = clip;
    o.uv = input.uv * _P10.xy + _P10.zw;
    return o;
}

struct GBufferOutput215480
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput215480 EID215480Fragment(Varyings215479 input)
{
    GBufferOutput215480 o;
    float4 albedoSample = SAMPLE_TEXTURE2D_BIAS(_Res12, sampler_Res12, input.uv, _EID215480MipBias);
    clip(albedoSample.a * _P06.w - _P02.y);
    o.rt0 = float4(0.0, 0.0, 0.0, 0.0);
    o.rt1 = float4(0.0, 0.0, 0.0, 0.0);
    o.rt2 = float4(0.0, 0.0, 0.0, 0.0);
    o.rt3 = float4(0.0, 0.0, 0.0, 0.0);
    o.rt4 = float4(0.0, 0.0, 0.0, 0.0);
    return o;
}

#endif
