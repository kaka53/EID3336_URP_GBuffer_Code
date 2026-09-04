#ifndef EID3490_SCENE_FIVE_MRT_INCLUDED
#define EID3490_SCENE_FIVE_MRT_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "EID3490VS209988_ExactUnity.hlsl"
#include "EID3490PS209989_ExactUnity.hlsl"

float _EID3336ScenePreviewTarget;
float _EID3336SceneModelDataInWorldSpace;
float _EID3336UseVisibilityMask;
float _EID3336VisibilityFlipY;
float _EID3332CombinedFlipMaterialUVY;
float4x4 _EID3336SceneModelBasis;
float4x4 _EID3336CurrentWorldToClip;
Texture2D _EID3336VisibilityMask;
SamplerState sampler_EID3336VisibilityMask;

struct EID3336SceneAttributes
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
    uint4 uv5 : TEXCOORD5;
};

struct EID3336SceneMRTOutput
{
    float4 target0 : SV_Target0;
    float4 target1 : SV_Target1;
    float4 target2 : SV_Target2;
    float4 target3 : SV_Target3;
    float4 target4 : SV_Target4;
};

EID3336_VS_Input EID3336BuildSceneVSInput(EID3336SceneAttributes input)
{
    EID3336_VS_Input capturedInput;
    capturedInput.VS_3 = input.position;
    capturedInput.VS_4 = input.packedNormal.x;
    capturedInput.VS_5 = input.tangent;
    capturedInput.VS_6 = input.color;
    capturedInput.VS_7 = input.uv0;
    capturedInput.VS_8 = input.uv1;
    capturedInput.VS_9 = input.uv2;
    capturedInput.VS_10 = input.uv3;
    capturedInput.VS_11 = input.uv4;
    capturedInput.VS_12 = input.uv5;
    return capturedInput;
}

EID3336_VS_Output EID3336SceneFiveMRTVertex(EID3336SceneAttributes input)
{
    return EID3336ExactVS(EID3336BuildSceneVSInput(input));
}

// PreviousReconstructed must follow EID3336ExactReplay: raw indexed streams,
// SV_VertexID and DrawProcedural, not DrawRenderer's imported vertex fetch.
EID3336_VS_Output EID3336SceneFiveMRTVertexProcedural(uint vertexId : SV_VertexID)
{
    return EID3336ExactVSProcedural(vertexId);
}

// Scene View preview keeps the recovered varyings/normal/material algorithm,
// but replaces the captured clip position with the active Unity camera matrix.
EID3336_VS_Output EID3336ScenePreviewVertexProcedural(uint vertexId : SV_VertexID)
{
    EID3336_VS_Output output = EID3336ExactVSProcedural(vertexId);
    uint index = EID3336LoadU16(EID3336RawIndices, vertexId * 2u);
    float3 positionOS = asfloat(EID3336RawStream0.Load3(index * 16u));
    float3 positionWS = mul(
        VS_30_m0[uint(_EID3336InstanceIndex)]._m0,
        float4(positionOS, 1.0f)).xyz;
    float4 positionCS = mul(_EID3336CurrentWorldToClip, float4(positionWS, 1.0f));
    output.EID3336_VS_Position = positionCS;
    output.VS_21 = positionCS.xyw;
    output.VS_22 = positionCS.xyw;
    return output;
}

EID3336_VS_Output EID3336ScenePreviewVertex(EID3336SceneAttributes input)
{
    EID3336_VS_Output output = EID3336ExactVS(EID3336BuildSceneVSInput(input));
    // Use the same instance matrix as the exact VS. This prevents Scene View
    // preview from falling back to a changed Unity Transform when the previous
    // reconstructed path is selected.
    float3 positionWS = mul(
        VS_30_m0[uint(_EID3336InstanceIndex)]._m0,
        float4(input.position, 1.0f)).xyz;
    float4 positionCS = mul(_EID3336CurrentWorldToClip, float4(positionWS, 1.0f));
    output.EID3336_VS_Position = positionCS;
    output.VS_21 = positionCS.xyw;
    output.VS_22 = positionCS.xyw;
    return output;
}

SPIRV_Cross_Output EID3336RunScenePS(EID3336_VS_Output input, bool frontFace)
{
    SPIRV_Cross_Input capturedInput;
    capturedInput._4 = input.VS_15;
    capturedInput._5 = input.VS_16;
    if (_EID3332CombinedFlipMaterialUVY > 0.5f)
    {
        capturedInput._4.y = 1.0f - capturedInput._4.y;
        capturedInput._5.y = 1.0f - capturedInput._5.y;
    }
    capturedInput._6 = input.VS_17;
    capturedInput._7 = input.VS_18;
    capturedInput._8 = input.VS_19;
    capturedInput._9 = input.VS_21;
    capturedInput._10 = input.VS_22;
    capturedInput._11 = input.VS_23;
    capturedInput.gl_FragCoord = input.EID3336_VS_Position;
    capturedInput.gl_FrontFacing = frontFace;
    return EID3490ExactPS(capturedInput);
}

EID3336SceneMRTOutput EID3336PackSceneMRT(SPIRV_Cross_Output captured)
{
    EID3336SceneMRTOutput output;
    output.target0 = captured._13;
    output.target1 = captured._17;
    output.target2 = captured._14;
    output.target3 = captured._15;
    output.target4 = captured._16;
    return output;
}

// Fixed RenderDoc replay: only pixels written by EID3336 survive.
EID3336SceneMRTOutput EID3336SceneFiveMRTFragment(EID3336_VS_Output input, bool frontFace : SV_IsFrontFace)
{
    if (_EID3336UseVisibilityMask > 0.5f)
    {
        float2 visibilityUv = float2((input.EID3336_VS_Position.x + 0.5f) / 1366.0f,
                                     (input.EID3336_VS_Position.y - 0.5f) / 768.0f);
        if (_EID3336VisibilityFlipY > 0.5f) visibilityUv.y = 1.0f - visibilityUv.y;
        clip(_EID3336VisibilityMask.SampleLevel(sampler_EID3336VisibilityMask, visibilityUv, 0).r - 0.5f);
    }
    return EID3336PackSceneMRT(EID3336RunScenePS(input, frontFace));
}

// Live Scene/Game camera: use the recovered material algorithm for every
// currently visible fragment. The fixed 1366x768 capture mask must not be used.
EID3336SceneMRTOutput EID3336SceneFiveMRTCurrentCameraFragment(EID3336_VS_Output input, bool frontFace : SV_IsFrontFace)
{
    return EID3336PackSceneMRT(EID3336RunScenePS(input, frontFace));
}

float4 EID3336ScenePreviewFragment(EID3336_VS_Output input, bool frontFace : SV_IsFrontFace) : SV_Target0
{
    SPIRV_Cross_Output captured = EID3336RunScenePS(input, frontFace);
    int target = clamp((int)round(_EID3336ScenePreviewTarget), 0, 4);
    float4 color = captured._16;
    if (target == 0) color = captured._13;
    else if (target == 1) color = captured._17;
    else if (target == 2) color = captured._14;
    else if (target == 3) color = captured._15;
    color.a = 1.0f;
    return color;
}

#endif

