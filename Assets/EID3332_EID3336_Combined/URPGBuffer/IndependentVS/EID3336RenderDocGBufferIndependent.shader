Shader "EID3336/URP/RenderDocGBufferIndependent"
{
    Properties
    {
        [Header(Material Local Parameters)]
        _EID3336VSLocalParameter0 ("VS Local Parameter 0", Vector) = (0,0,0,0)
        _EID3336VSLocalParameter1 ("VS Local Parameter 1", Vector) = (0,0,0,0)
        _EID3336VSLocalParameter2 ("VS Local Parameter 2", Vector) = (0,0,0,0)
        _EID3336VSLocalScale ("VS Local Scale", Vector) = (1,1,1,1)
        _EID3336VSLocalOffset ("VS Local Offset", Vector) = (0,0,0,0)
        _EID3336VSLocalFlags ("VS Local Flags", Vector) = (0,0,0,0)
        [Toggle] _EID3336UseLocalVSOverrides ("Enable Local VS Overrides", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "EID3336_RenderDoc_URP_UniversalGBuffer_Independent"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Off
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
            #pragma vertex EID3336IndependentVertex
            #pragma fragment EID3336IndependentWhiteFragment
            #include "EID3336RenderDocGBufferIndependent.hlsl"
            ENDHLSL
        }
    }
}
