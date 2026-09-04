#ifndef EID3336_URP_GBUFFER_ADAPTER_INCLUDED
#define EID3336_URP_GBUFFER_ADAPTER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"
#define EID3336_PS_EXTERNAL_SAMPLERS
#include "../Geometry/EID3332CombinedSharedMRT.hlsl"
#undef EID3336_PS_EXTERNAL_SAMPLERS

struct EID3336URPGBufferOutput
{
    float4 GBuffer0 : SV_Target0; // URP albedo + material flags
    float4 GBuffer1 : SV_Target1; // URP reflectivity/specular + occlusion
    float4 GBuffer2 : SV_Target2; // URP normal + smoothness
    float4 GBuffer3 : SV_Target3; // URP lighting buffer (zero in stage 1)
};

float3 EID3336DecodeCapturedNormal(float4 packed)
{
    float2 e = packed.xy * 2.0 - 1.0;
    float f = 1.0 - abs(e.x) - abs(e.y);
    float3 n = float3(e.x, f, e.y);
    if (f < 0.0)
    {
        float2 signs = float2(n.x >= 0.0 ? 1.0 : -1.0, n.z >= 0.0 ? 1.0 : -1.0);
        float2 folded = (1.0 - abs(n.zx)) * signs;
        n = float3(folded.x, n.y, folded.y);
    }
    return normalize(n);
}

float3 EID3336PackURPNormal(float3 normalWS)
{
#ifdef _GBUFFER_NORMALS_OCT
    return PackNormal((half3)normalize(normalWS));
#else
    return normalize(normalWS);
#endif
}

EID3336_VS_Output EID3336URPGBufferVertex(uint vertexId : SV_VertexID)
{
    return EID3336SceneFiveMRTVertexProcedural(vertexId);
}

EID3336_VS_Output EID3336URPGBufferVertexCurrent(uint vertexId : SV_VertexID)
{
    return EID3336ScenePreviewVertexProcedural(vertexId);
}

EID3336URPGBufferOutput EID3336URPGBufferFragment(EID3336_VS_Output input, bool frontFace : SV_IsFrontFace)
{
    SPIRV_Cross_Output captured = EID3336RunScenePS(input, frontFace);

    // These are the authoritative EID3336 scene MRT semantics. Decode them
    // before writing the URP contract; copying channels by index would be
    // incorrect because EID's MRT3 is octa normal + roughness and MRT4 is
    // base color, while URP uses a different four-target layout.
    float3 baseColor = saturate(captured._16.rgb);
    float metallic = saturate(captured._14.x);
    float occlusion = saturate(captured._14.y);
    float roughness = saturate(captured._15.z);
    float3 normalWS = EID3336DecodeCapturedNormal(captured._15);
    float3 specular = lerp(float3(0.04, 0.04, 0.04), baseColor, metallic);

    EID3336URPGBufferOutput output;
    output.GBuffer0 = float4(baseColor, PackMaterialFlags(0u));
    output.GBuffer1 = float4(specular, occlusion);
    output.GBuffer2 = float4(EID3336PackURPNormal(normalWS), 1.0 - roughness);
    output.GBuffer3 = float4(0.0, 0.0, 0.0, 1.0);
    return output;
}

EID3336URPGBufferOutput EID3336URPGBufferFragmentCurrent(EID3336_VS_Output input, bool frontFace : SV_IsFrontFace)
{
    return EID3336URPGBufferFragment(input, frontFace);
}

#endif

