Shader "Reconstructed/EID3336/RenderDoc VS209986 White Test"
{
    Properties
    {
        [Header(RenderDoc VS local controls)]
        _EID3336VSLocalParameter0 ("VS Local Parameter 0", Vector) = (0,0,0,0)
        _EID3336VSLocalParameter1 ("VS Local Parameter 1", Vector) = (0,0,0,0)
        _EID3336VSLocalParameter2 ("VS Local Parameter 2", Vector) = (0,0,0,0)
        _EID3336VSLocalScale ("VS Local Scale", Vector) = (1,1,1,1)
        _EID3336VSLocalOffset ("VS Local Offset", Vector) = (0,0,0,0)
        _EID3336VSLocalFlags ("VS Local Flags", Vector) = (0,0,0,0)
        [HideInInspector] _EID3336RawStream1StrideBytes ("Raw Stream1 Stride", Float) = 16
        [HideInInspector] _EID3336InstanceIndex ("Instance Index", Float) = 0
        [HideInInspector] _EID3336RouteBUseObjectTransform ("Use Object Transform", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry+10" }
        Pass
        {
            Name "EID3336_RenderDocVS_White"
            Tags { "LightMode"="EID3336RenderDocVSWhite" }
            Cull Back
            ZTest LEqual
            ZWrite On
            Blend Off
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID3336VSWhiteVertex
            #pragma fragment EID3336VSWhiteFragment
            #include "EID3336VSWhiteTest.hlsl"
            ENDHLSL
        }
    }
}


