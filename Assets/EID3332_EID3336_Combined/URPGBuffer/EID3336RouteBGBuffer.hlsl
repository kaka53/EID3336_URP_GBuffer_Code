#ifndef EID3336_ROUTE_B_GBUFFER_INCLUDED
#define EID3336_ROUTE_B_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"
// UnityGBuffer.hlsl already declares the standard sampler names. Tell the
// recovered PS not to redeclare them in this URP UniversalGBuffer variant.
#define EID3336_PS_EXTERNAL_SAMPLERS
#include "../Geometry/EID3332CombinedSharedMRT.hlsl"
#undef EID3336_PS_EXTERNAL_SAMPLERS

float _EIDRouteBMetallicScale;
float _EIDRouteBRoughnessScale;
float _EIDRouteBOcclusionScale;
float _EIDRouteBNormalStrength;

struct EID3336RouteBGBufferOutput
{
    half4 GBuffer0 : SV_Target0;
    half4 GBuffer1 : SV_Target1;
    half4 GBuffer2 : SV_Target2;
    half4 GBuffer3 : SV_Target3;
};

EID3336_VS_Output EID3336RouteBVertex(EID3336SceneAttributes input)
{
    EID3336_VS_Output output = EID3336ExactVS(EID3336BuildSceneVSInput(input));
    float3 positionWS = mul(EID3336RouteBGetInstanceRecord()._m0, float4(input.position, 1.0f)).xyz;
    float4 positionCS = mul(UNITY_MATRIX_VP, float4(positionWS, 1.0f));
    output.EID3336_VS_Position = positionCS;
    output.VS_21 = positionCS.xyw;
    output.VS_22 = positionCS.xyw;
    return output;
}

float3 EID3336RouteBDecodeNormal(float4 packed)
{
#ifdef _GBUFFER_NORMALS_OCT
    // URP 14 stores octahedral normals with PackFloat2To888, so the
    // three channels are not a plain two-channel oct encoding. Always use
    // the matching URP decoder for the UniversalGBuffer contract.
    return normalize((float3)UnpackNormal((half3)packed.xyz));
#else
    return normalize(packed.xyz);
#endif
}

float3 EID3336RouteBPackNormal(float3 normalWS)
{
#ifdef _GBUFFER_NORMALS_OCT
    return PackNormal((half3)normalize(normalWS));
#else
    return normalize(normalWS);
#endif
}

EID3336RouteBGBufferOutput EID3336RouteBFragment(EID3336_VS_Output input, bool frontFace : SV_IsFrontFace)
{
    SPIRV_Cross_Output captured = EID3336RunScenePS(input, frontFace);
    float3 baseColor = captured._16.rgb;
    float metallic = saturate(captured._14.x * _EIDRouteBMetallicScale);
    float occlusion = saturate(captured._14.y * _EIDRouteBOcclusionScale);
    float roughness = saturate(captured._15.z * _EIDRouteBRoughnessScale);
    float3 normalWS = EID3336RouteBDecodeNormal(captured._15);
    normalWS = normalize(lerp(float3(0.0, 1.0, 0.0), normalWS, saturate(_EIDRouteBNormalStrength)));
    float3 specular = lerp(float3(0.04, 0.04, 0.04), baseColor, metallic);

    EID3336RouteBGBufferOutput output;
    output.GBuffer0 = half4(baseColor, PackMaterialFlags(0u));
    // Preserve URP reflectivity in .r/.g and carry captured metallic in .b for Route B B6.
    // URP metallic setup consumes reflectivity from .r and ignores .g/.b.
    // Keep the captured metallic in .g as a Route-B extension for B6.
    float reflectivity = lerp(0.04, 1.0, metallic);
    output.GBuffer1 = half4(reflectivity, metallic, 0.0, occlusion);
    // GBuffer2 follows UnityGBuffer.hlsl: packed normal + smoothness.
    // The recovered RenderDoc channel is roughness, therefore invert it
    // only at the URP boundary and invert it back in the B6 decoder.
    output.GBuffer2 = half4(EID3336RouteBPackNormal(normalWS), 1.0 - roughness);
    output.GBuffer3 = half4(0.0, 0.0, 0.0, 1.0);
    return output;
}

#endif
