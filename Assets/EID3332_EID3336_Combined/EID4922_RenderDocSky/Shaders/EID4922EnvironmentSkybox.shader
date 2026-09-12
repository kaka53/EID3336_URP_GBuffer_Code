Shader "EID4922/EnvironmentSkybox"
{
    Properties
    {
        [HideInInspector] _EID4922ZTest ("ZTest", Float) = 8
        [HideInInspector] _EID4922Res19 ("res19 Sky Irradiance", 2D) = "white" {}
        [HideInInspector] _EID4922Res29 ("res29 Atmosphere LUT", 2D) = "white" {}
        [HideInInspector] _EID4922Res27 ("res27 4x4 Lookup", 2D) = "white" {}
        [HideInInspector] _EID4922Res25 ("res25 Reflection Atlas A", 2D) = "white" {}
        [HideInInspector] _EID4922Res23 ("res23 Reflection Atlas B", 2D) = "white" {}
        [HideInInspector] _EID4922Res21 ("res21 Reflection Atlas C", 2D) = "white" {}
        [HideInInspector] _EID4922Res20 ("res20 Sky Transmittance", 2D) = "white" {}
        [HideInInspector] _EID4922Res18 ("res18 Irradiance Volume", 3D) = "white" {}
    }
    SubShader
    {
        Tags
        {
            "Queue"="Background"
            "RenderType"="Background"
            "PreviewType"="Skybox"
            "RenderPipeline"="UniversalPipeline"
        }
        Pass
        {
            Name "EID4922 Native Environment Skybox"
            Cull Off
            ZWrite Off
            // The custom five-buffer deferred path does not guarantee that the
            // native skybox depth attachment is the same sampled depth used by
            // EID4662. The fragment shader performs the authoritative depth test.
            ZTest Always
            Blend One Zero
            ColorMask RGBA
            HLSLPROGRAM
            #pragma target 4.5
            #pragma vertex EID4922EnvironmentVertexMain
            #pragma fragment EID4922EnvironmentPixelMain
            #include "EID4922EnvironmentSkybox.hlsl"
            ENDHLSL
        }
    }
    FallBack Off
}
