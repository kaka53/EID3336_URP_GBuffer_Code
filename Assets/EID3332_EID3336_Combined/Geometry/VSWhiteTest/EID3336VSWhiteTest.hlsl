#ifndef EID3336_VS_WHITE_TEST_INCLUDED
#define EID3336_VS_WHITE_TEST_INCLUDED

#include "../EID3332CombinedVS209986_ExactUnity.hlsl"

// RenderDoc EID3336 VS209986, one-to-one recovered vertex path.
// All captured resources are supplied by EID3336VSWhiteTest and the existing
// EID3332CombinedSceneMaterialResources component.
EID3336_VS_Output EID3336VSWhiteVertex(uint vertexId : SV_VertexID)
{
    return EID3336ExactVSProcedural(vertexId);
}

float4 EID3336VSWhiteFragment(EID3336_VS_Output input, bool frontFace : SV_IsFrontFace) : SV_Target0
{
    return float4(1.0, 1.0, 1.0, 1.0);
}

#endif
