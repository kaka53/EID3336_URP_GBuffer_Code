Shader "EID4922/RenderDocSky"
{
    Properties
    {
        [HideInInspector] _EID4922Cull ("Cull", Float) = 0
        [HideInInspector] _EID4922ZTest ("ZTest", Float) = 4
        [HideInInspector] _EID4922DebugMode ("Debug Mode", Float) = 0
        [HideInInspector] _EID4922DepthMode ("Depth Mode", Float) = 0
        [NoScaleOffset] _EID4922Res19 ("res19 Sky Irradiance", 2D) = "white" {}
        [NoScaleOffset] _EID4922Res29 ("res29 Atmosphere LUT", 2D) = "white" {}
        [NoScaleOffset] _EID4922Res27 ("res27 4x4 Lookup", 2D) = "white" {}
        [NoScaleOffset] _EID4922Res25 ("res25 Reflection Atlas A", 2D) = "white" {}
        [NoScaleOffset] _EID4922Res23 ("res23 Reflection Atlas B", 2D) = "white" {}
        [NoScaleOffset] _EID4922Res21 ("res21 Reflection Atlas C", 2D) = "white" {}
        [NoScaleOffset] _EID4922Res20 ("res20 Sky Transmittance", 2D) = "white" {}
        [NoScaleOffset] _EID4922Res18 ("res18 Irradiance Volume", 3D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "Queue"="Background" "RenderType"="Background" }
        Pass
        {
            Name "EID4922 RenderDoc Sky"
            Tags { "LightMode"="EID4922Sky" }
            Cull Off
            ZWrite Off
            ZTest [_EID4922ZTest]
            Blend One Zero
            HLSLPROGRAM
            #pragma target 4.5
            #pragma vertex EID4922VertexMain
            #pragma fragment EID4922PixelMain
            #include "EID4922Sky.hlsl"
            ENDHLSL
        }
    }
    FallBack Off
}
