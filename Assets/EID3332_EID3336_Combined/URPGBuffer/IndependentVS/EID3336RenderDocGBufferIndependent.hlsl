#ifndef EID3336_INDEPENDENT_URP_GBUFFER_INCLUDED
#define EID3336_INDEPENDENT_URP_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"
#include "../../Geometry/EID3336VS209986_IndependentURP_Runtime.hlsl"

// The recovered PS declares its own Texture2D/Texture2DArray resources and
// RenderDoc-named constant buffers. URP already owns the standard sampler
// states, so only the sampler aliases are reused here.
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

#define EID3336_PS_USE_MATERIAL_44
#define EID3336_PS_EXTERNAL_SAMPLERS
#include "../../Geometry/EID3332CombinedPS209987_ExactUnity.hlsl"
#undef EID3336_PS_EXTERNAL_SAMPLERS

// Material-local controls. Frame/draw constants (_18_19 ... _51_52) remain
// pipeline-owned; these values are intentionally left to the material.


struct EID3336IndependentAttributes
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

struct EID3336IndependentGBufferOutput
{
    float4 GBuffer0 : SV_Target0;
    float4 GBuffer1 : SV_Target1;
    float4 GBuffer2 : SV_Target2;
    float4 GBuffer3 : SV_Target3;
    float4 GBuffer4 : SV_Target4;
};

EID3336_VS_Output EID3336IndependentVertex(EID3336IndependentAttributes input)
{
    EID3336_VS_Input v;
    v.VS_3 = input.position;
    v.VS_4 = input.packedNormal;
    v.VS_5 = input.tangent;
    v.VS_6 = input.color;
    v.VS_7 = input.uv0;
    v.VS_8 = input.uv1;
    v.VS_9 = input.uv2;
    v.VS_10 = input.uv3;
    v.VS_11 = input.uv4;
    v.VS_12 = input.uv5;

    // Optional material-local object-space adjustment. It is disabled by
    // default, leaving the Unity Transform as the source of world position.
    if (_EID3336UseLocalVSOverrides > 0.5)
        v.VS_3 = v.VS_3 * _EID3336VSLocalScale.xyz + _EID3336VSLocalOffset.xyz;

    v.EID3336_VS_InstanceIndex = 0u;
    return EID3336ExactVSCore(v);
}

SPIRV_Cross_Input EID3336IndependentBuildPSInput(EID3336_VS_Output input, bool frontFace)
{
    SPIRV_Cross_Input capturedInput;
    capturedInput._4 = input.VS_15;
    capturedInput._5 = input.VS_16;

    // Local UV controls are applied only at the adapter boundary. The PS body
    // below remains the recovered PS209987 algorithm with no color/gamma or
    // channel remapping added.
    if (_EID3336PSLocalUseUVTransform > 0.5)
    {
        capturedInput._4 = capturedInput._4 * _EID3336PSLocalUV0ScaleOffset.xy
                         + _EID3336PSLocalUV0ScaleOffset.zw;
        capturedInput._5 = capturedInput._5 * _EID3336PSLocalUV1ScaleOffset.xy
                         + _EID3336PSLocalUV1ScaleOffset.zw;
    }
    if (_EID3336PSLocalFlipUVY > 0.5)
    {
        capturedInput._4.y = 1.0 - capturedInput._4.y;
        capturedInput._5.y = 1.0 - capturedInput._5.y;
    }

    capturedInput._6 = input.VS_17;
    capturedInput._7 = input.VS_18;
    capturedInput._8 = input.VS_19;
    capturedInput._9 = input.VS_21;
    capturedInput._10 = input.VS_22;
    capturedInput._11 = input.VS_23;
    capturedInput.gl_FragCoord = input.EID3336_VS_Position;
    capturedInput.gl_FrontFacing = frontFace;
    return capturedInput;
}

EID3336IndependentGBufferOutput EID3336IndependentGBufferFragment(
    EID3336_VS_Output input,
    bool frontFace : SV_IsFrontFace)
{
    SPIRV_Cross_Output captured = EID3336ExactPS(
        EID3336IndependentBuildPSInput(input, frontFace));

    // RenderDoc PS209987 output contract, kept byte/channel order exact:
    // _13 -> RT0, _17 -> RT1, _14 -> RT2, _15 -> RT3, _16 -> RT4.
    EID3336IndependentGBufferOutput output;
    output.GBuffer0 = captured._13;
    output.GBuffer1 = captured._17;
    output.GBuffer2 = captured._14;
    output.GBuffer3 = captured._15;
    output.GBuffer4 = captured._16;
    return output;
}

// Retained diagnostic entry point for quick attachment-write checks.
EID3336IndependentGBufferOutput EID3336IndependentWhiteFragment(
    EID3336_VS_Output input,
    bool frontFace : SV_IsFrontFace)
{
    EID3336IndependentGBufferOutput output;
    output.GBuffer0 = 1.0;
    output.GBuffer1 = 1.0;
    output.GBuffer2 = 1.0;
    output.GBuffer3 = 1.0;
    output.GBuffer4 = 1.0;
    return output;
}

#endif
