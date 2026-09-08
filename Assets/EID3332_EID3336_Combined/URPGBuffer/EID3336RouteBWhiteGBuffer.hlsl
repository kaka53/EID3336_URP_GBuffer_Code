#ifndef EID3336_ROUTE_B_WHITE_GBUFFER_INCLUDED
#define EID3336_ROUTE_B_WHITE_GBUFFER_INCLUDED

// Reuse the recovered RenderDoc VS and the standard URP GBuffer ABI.
// EID3336RouteBVertex evaluates UNITY_MATRIX_VP, which is populated by URP
// for the current camera. No MVP matrix is exposed as a material property.
#include "EID3336RouteBGBuffer.hlsl"

// These uniforms intentionally remain material-local. The current white RT
// stage exposes them for inspection/tuning; later RT stages may consume them.
float4 _EID3336VSLocalParameter0;
float4 _EID3336VSLocalParameter1;
float4 _EID3336VSLocalParameter2;
float4 _EID3336VSLocalScale;
float4 _EID3336VSLocalOffset;
float4 _EID3336VSLocalFlags;

EID3336RouteBGBufferOutput EID3336RouteBWhiteFragment(
    EID3336_VS_Output input,
    bool frontFace : SV_IsFrontFace)
{
    EID3336RouteBGBufferOutput output;
    output.GBuffer0 = half4(1.0h, 1.0h, 1.0h, 1.0h);
    output.GBuffer1 = half4(1.0h, 1.0h, 1.0h, 1.0h);
    output.GBuffer2 = half4(1.0h, 1.0h, 1.0h, 1.0h);
    output.GBuffer3 = half4(1.0h, 1.0h, 1.0h, 1.0h);
    return output;
}

#endif
