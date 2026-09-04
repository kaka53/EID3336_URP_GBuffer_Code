Shader "EID3336/URP/RenderDocGBuffer"
{
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }

        Pass
        {
            Name "EID3336_RenderDoc_URP_GBuffer_Captured"
            Tags { "LightMode"="EID3336URPGBuffer" }
            Cull Back
            ZTest LEqual
            ZWrite On
            Blend Off
            Stencil
            {
                Ref 32
                Comp Always
                Pass Replace
                ReadMask 96
                WriteMask 96
            }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID3336URPGBufferVertex
            #pragma fragment EID3336URPGBufferFragment
            #pragma multi_compile _ _GBUFFER_NORMALS_OCT
            #include "EID3336URPGBufferAdapter.hlsl"
            ENDHLSL
        }

        Pass
        {
            Name "EID3336_RenderDoc_URP_GBuffer_Current"
            Tags { "LightMode"="EID3336URPGBuffer" }
            Cull Back
            ZTest LEqual
            ZWrite On
            Blend Off
            Stencil
            {
                Ref 32
                Comp Always
                Pass Replace
                ReadMask 96
                WriteMask 96
            }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID3336URPGBufferVertexCurrent
            #pragma fragment EID3336URPGBufferFragmentCurrent
            #pragma multi_compile _ _GBUFFER_NORMALS_OCT
            #include "EID3336URPGBufferAdapter.hlsl"
            ENDHLSL
        }
    }
}

