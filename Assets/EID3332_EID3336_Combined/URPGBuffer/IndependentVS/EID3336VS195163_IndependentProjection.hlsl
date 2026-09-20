#ifndef EID3336_VS195163_INDEPENDENT_PROJECTION_INCLUDED
#define EID3336_VS195163_INDEPENDENT_PROJECTION_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

CBUFFER_START(UnityPerMaterial)
float4 _EID3336VSLocalParameter0;
float4 _EID3336VSLocalParameter1;
float4 _EID3336VSLocalParameter2;
float4 _EID3336VSLocalScale;
float4 _EID3336VSLocalOffset;
float4 _EID3336VSLocalFlags;
float _EID3336UseLocalVSOverrides;
float4 _EID3336PSLocalUV0ScaleOffset;
float4 _EID3336PSLocalUV1ScaleOffset;
float4 _EID3336PSLocalFlags;
float _EID3336PSLocalUseUVTransform;
float _EID3336PSLocalFlipUVY;
float4 _EID3336PSLocalParam00;
float4 _EID3336PSLocalParam01;
float4 _EID3336PSLocalParam02;
float4 _EID3336PSLocalParam03;
float4 _EID3336PSLocalParam04;
float4 _EID3336PSLocalParam05;
float4 _EID3336PSLocalParam06;
float4 _EID3336PSLocalParam07;
float4 _EID3336PSLocalParam08;
float4 _EID3336PSLocalParam09;
float4 _EID3336PSLocalParam10;
float4 _EID3336PSLocalParam11;
float4 _EID3336PSLocalParam12;
float4 _EID3336PSLocalParam13;
float4 _EID3336PSLocalParam14;
float4 _EID3336PSLocalParam15;
float4 _EID3336PSLocalParam16;
float4 _EID3336PSLocalParam17;
float4 _EID3336PSLocalParam18;
float4 _EID3336PSLocalParam19;
float4 _EID3336PSLocalParam20;
float4 _EID3336PSLocalParam21;
float4 _EID3336PSLocalParam22;
float4 _EID3336PSLocalParam23;
float4 _EID3336PSLocalParam24;
float4 _EID3336PSLocalParam25;
float4 _EID3336PSLocalParam26;
float4 _EID3336PSLocalParam27;
float4 _EID3336PSLocalParam28;
float4 _EID3336PSLocalParam29;
float4 _EID3336PSLocalParam30;
float4 _EID3336PSLocalParam31;
float4 _EID3336PSLocalParam32;
float4 _EID3336PSLocalParam33;
float4 _EID3336PSLocalParam34;
float4 _EID3336PSLocalParam35;
float4 _EID3336PSLocalParam36;
float4 _EID3336PSLocalParam37;
float4 _EID3336PSLocalParam38;
float4 _EID3336PSLocalParam39;
float4 _EID3336PSLocalParam40;
float4 _EID3336PSLocalParam41;
float4 _EID3336PSLocalParam42;
float4 _EID3336PSLocalParam43;
float4 _EID3336PSLocalParam44;
float _EID3336PSUseLocalParams;
CBUFFER_END

static const float _EID195163Uniforms18Child6 = 0.0f;
static const float _EID195163Uniforms22Child3Y = 0.10000000149011612f;
static const float _EID195163Uniforms22Child3Z = 10000.0f;
static const float _EID195163Uniforms27Child25 = 0.0f;
static const float _EID195163Uniforms27Child26 = 0.0f;
static const float3 _EID195163Uniforms20Child11 = float3(-560.8156127929688f, 108.86643981933594f, -410.7920227050781f);

int _EID195163CascadeIndex;

static const float4x4 _EID195163Uniforms31Cascade0 = float4x4(
    float4(-0.18547934293746948f, 2.537294596649531e-9f, 1.7482955361192154e-10f, 0.0f),
    float4(3.2947749939443846e-16f, -0.15193577110767365f, 0.005132838152348995f, 0.0f),
    float4(4.423637900430322e-9f, 0.10638657957315445f, 0.007330453488975763f, 0.0f),
    float4(-103.20703887939453f, 60.2734375f, 2.5208356380462646f, 1.0f));

static const float4x4 _EID195163Uniforms31Cascade1 = float4x4(
    float4(-0.0751468688249588f, 1.027983698165258e-9f, 1.51454737640222e-10f, 0.0f),
    float4(1.3348765439672903e-16f, -0.06155670806765556f, 0.004446574952453375f, 0.0f),
    float4(1.792234916031532e-9f, 0.04310247302055359f, 0.006350367795675993f, 0.0f),
    float4(-41.330081939697266f, 24.437501907348633f, 2.270718812942505f, 1.0f));

static const float4x4 _EID195163Uniforms31Cascade2 = float4x4(
    float4(-0.028332054615020752f, 3.875728904478848e-10f, 1.1043881781303e-10f, 0.0f),
    float4(5.032783898965354e-17f, -0.0232082586735487f, 0.0032423841767013073f, 0.0f),
    float4(6.757127635204085e-10f, 0.016250599175691605f, 0.004630605224519968f, 0.0f),
    float4(-15.076171875f, 9.232421875f, 1.8318367004394531f, 1.0f));

float4x4 EID195163SelectUniforms31()
{
    if (_EID195163CascadeIndex < 1)
        return _EID195163Uniforms31Cascade0;
    if (_EID195163CascadeIndex < 2)
        return _EID195163Uniforms31Cascade1;
    return _EID195163Uniforms31Cascade2;
}

struct EID3336IndependentProjectionAttributes
{
    float3 position : POSITION;
    float packedNormal : NORMAL;
    float4 tangent : TANGENT;
    float4 color : COLOR;
    float2 uv0 : TEXCOORD0;
    float2 uv1 : TEXCOORD1;
    float2 uv2 : TEXCOORD2;
    float4 uv3 : TEXCOORD3;
    float4 uv4 : TEXCOORD4;
    uint4 uv5 : TEXCOORD5;
};

struct EID3336IndependentProjectionVaryings
{
    float4 positionCS : SV_POSITION;
};

EID3336IndependentProjectionVaryings EID3336IndependentProjectionVertex(
    EID3336IndependentProjectionAttributes input)
{
    float3 positionOS = input.position;
    if (_EID3336UseLocalVSOverrides > 0.5f)
        positionOS = positionOS * _EID3336VSLocalScale.xyz + _EID3336VSLocalOffset.xyz;

    float3x3 world3x3 = float3x3(UNITY_MATRIX_M[0].xyz, UNITY_MATRIX_M[1].xyz, UNITY_MATRIX_M[2].xyz);
    float3 worldT = float3(UNITY_MATRIX_M[0].w, UNITY_MATRIX_M[1].w, UNITY_MATRIX_M[2].w);
    float3 originWS = _EID195163Uniforms20Child11;
    float3 relativeWS = mul(world3x3, positionOS) + (worldT - originWS);

    float nearFarAbs = abs(_EID195163Uniforms22Child3Z - _EID195163Uniforms22Child3Y);
    float yBias = _EID195163Uniforms18Child6 * (_EID195163Uniforms27Child26 + _EID195163Uniforms27Child25 * (-5.0f - nearFarAbs));
    relativeWS.y += yBias;

    float3 positionWS = relativeWS + originWS;
    float4 positionCS = mul(float4(positionWS, 1.0f), EID195163SelectUniforms31());
    positionCS.y = -positionCS.y;

    EID3336IndependentProjectionVaryings output;
    output.positionCS = positionCS;
    return output;
}

float EID3336IndependentProjectionFragment(EID3336IndependentProjectionVaryings input) : SV_Target0
{
    return input.positionCS.z;
}

#endif
