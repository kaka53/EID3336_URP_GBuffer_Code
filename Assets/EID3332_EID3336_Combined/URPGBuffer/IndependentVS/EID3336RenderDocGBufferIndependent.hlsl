#ifndef EID3336_INDEPENDENT_URP_GBUFFER_INCLUDED
#define EID3336_INDEPENDENT_URP_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"
#include "../../Geometry/EID3336VS209986_IndependentURP_Runtime.hlsl"
// Material-local controls. These are written by UnityPerMaterial and are
// intentionally not overwritten by the URP command buffer.
CBUFFER_START(UnityPerMaterial)
float4 _EID3336VSLocalParameter0;
float4 _EID3336VSLocalParameter1;
float4 _EID3336VSLocalParameter2;
float4 _EID3336VSLocalScale;
float4 _EID3336VSLocalOffset;
float4 _EID3336VSLocalFlags;
float _EID3336UseLocalVSOverrides;
CBUFFER_END


struct EID3336IndependentAttributes
{
    float3 position : POSITION;
    float4 packedNormal : NORMAL;
    float4 tangent : TANGENT;
    float4 color : COLOR;
    float2 uv0 : TEXCOORD0;
    float2 uv1 : TEXCOORD1;
    float2 uv2 : TEXCOORD2;
    float4 uv3 : TEXCOORD3;
    float4 uv4 : TEXCOORD4;
    float4 uv5 : TEXCOORD5;
};

// The independent RenderDoc contract is five color attachments. RT5 is the
// URP camera-color/lighting attachment and is intentionally not written by
// this geometry pass.
struct EID3336IndependentGBufferOutput
{
    half4 GBuffer0 : SV_Target0;
    half4 GBuffer1 : SV_Target1;
    half4 GBuffer2 : SV_Target2;
    half4 GBuffer3 : SV_Target3;
    half4 GBuffer4 : SV_Target4;
};

// Unity's input ABI is the only adapter. The recovered VS209986 body then
// performs the captured math, while its matrix slots are supplied by URP.
EID3336_VS_Output EID3336IndependentVertex(EID3336IndependentAttributes input)
{
    EID3336_VS_Input v;
    v.VS_3 = input.position;
    v.VS_4 = input.packedNormal.x;
    v.VS_5 = input.tangent;
    v.VS_6 = input.color;
    v.VS_7 = input.uv0;
    v.VS_8 = input.uv1;
    v.VS_9 = input.uv2;
    v.VS_10 = input.uv3;
    v.VS_11 = input.uv4;
    v.VS_12 = (uint4)round(input.uv5);

    // Optional material-local object-space adjustment. It is disabled by
    // default, so Unity Transform remains the authoritative object-to-world
    // transform. Enabling it proves that local material parameters are not
    // overwritten by the pipeline.
    if (_EID3336UseLocalVSOverrides > 0.5)
    {
        v.VS_3 = v.VS_3 * _EID3336VSLocalScale.xyz + _EID3336VSLocalOffset.xyz;
    }

    // One shared material is used by all three MeshRenderers. The captured
    // records differ only in m0/m3, which are replaced by UNITY_MATRIX_M;
    // the remaining VS constants are identical, so record 0 is authoritative.
    v.EID3336_VS_InstanceIndex = 0u;
    return EID3336ExactVS(v);
}

EID3336IndependentGBufferOutput EID3336IndependentWhiteFragment(EID3336_VS_Output input)
{
    EID3336IndependentGBufferOutput o;
    // White diagnostic payload: each attachment must visibly receive a write
    // before the RenderDoc channel encoders are introduced.
    o.GBuffer0 = half4(1,1,1,1);
    o.GBuffer1 = half4(1,1,1,1);
    o.GBuffer2 = half4(1,1,1,1);
    o.GBuffer3 = half4(1,1,1,1);
    o.GBuffer4 = half4(1,1,1,1);
    return o;
}

#endif
