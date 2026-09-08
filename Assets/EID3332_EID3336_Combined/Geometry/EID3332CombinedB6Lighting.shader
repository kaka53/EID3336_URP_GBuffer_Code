Shader "Hidden/EID3332Combined/Deferred/B6CapturedIndirect"
{
    Properties
    {
        [Header(Debug and GBuffer Contract)]
        [EIDB6ViewMode] _EID3336B6ViewMode ("View Mode", Float) = 0
        [Toggle] _EID3336B6UseURPGBuffer ("Use URP GBuffer Contract", Float) = 1
        [Enum(RT0,0,RT1,1,RT2,2,RT3,3,RT4,4)] _EID3336B6MaterialTarget ("Material Target", Float) = 1
        [Enum(RT0,0,RT1,1,RT2,2,RT3,3,RT4,4)] _EID3336B6NormalTarget ("Normal Target", Float) = 2
        [Enum(RT0,0,RT1,1,RT2,2,RT3,3,RT4,4)] _EID3336B6BaseColorTarget ("Base Color Target", Float) = 0
        _EID3336B6RawAttachment ("Raw Attachment", Float) = 0

        [Header(Direct Lighting)]
        _EID3336B6LightDirectionWS ("Light Direction WS", Vector) = (0.35,0.8,0.25,0)
        [HDR] _EID3336B6LightColor ("Light Color", Color) = (1,1,1,1)
        [Range(0,20)] _EID3336B6LightIntensity ("Light Intensity", Float) = 2.5
        [Range(0,4)] _EID3336B6AmbientStrength ("Ambient Strength", Float) = 0.12
        [Range(0,4)] _EID3336B6DiffuseStrength ("Diffuse Strength", Float) = 1
        [Range(0,4)] _EID3336B6SpecularStrength ("Specular Strength", Float) = 0.7

        [Header(Indirect Lighting)]
        [Range(0,4)] _EID3336B6IndirectDiffuseStrength ("Indirect Diffuse Strength", Float) = 1
        [Range(0,4)] _EID3336B6IndirectSpecularStrength ("Indirect Specular Strength", Float) = 1
        [Range(0,1)] _EID3336B6ScreenSHWeight ("屏幕SH去除权重（screen_sh_b5）", Float) = 0
        [Range(0,1)] _EID3336B6ScreenSpecularContributionWeight ("Screen Specular Weight", Float) = 1
        [Range(0,1)] _EID3336B6ProbeReflectionWeight ("Probe Reflection Weight", Float) = 1
        [Range(0,1)] _EID3336B6CapturedVisibilityWeight ("Captured Visibility Weight", Float) = 1
        _EID3336B6IndirectScale ("Captured Indirect Scale", Vector) = (1,1,1,1)
        _EID3336B6IndirectOptions ("Captured Indirect Options", Vector) = (1,1,1,1)
        _EID3336B6ReflectionMipParameters ("Reflection Mip Parameters", Vector) = (1,0,0,0)
        _EID3336B6TextureMipBias ("Texture Mip Bias", Float) = 0

        [Header(Coordinates and Display)]
        [Toggle] _EID3336B6ReconstructionFlipY ("Reconstruction Flip Y", Float) = 0
        [Toggle] _EID3336B6FlipY ("Input UV Flip Y", Float) = 0
        _EID3336B6WorldDisplayRange ("World Position Display Range", Float) = 1024
        _EID3336B6DepthDisplayFar ("Depth Display Far", Float) = 1000

        [Header(Captured SH and Probe Parameters)]
        _EID3336B6FallbackSHRed ("Fallback SH Red", Vector) = (0,0,0,0)
        _EID3336B6FallbackSHGreen ("Fallback SH Green", Vector) = (0,0,0,0)
        _EID3336B6FallbackSHBlue ("Fallback SH Blue", Vector) = (0,0,0,0)
        _EID3336B6ProbeClusterGrid ("Probe Cluster Grid", Vector) = (1,1,0,0)
        _EID3336B6ProbeAtlasLayout ("Probe Atlas Layout", Vector) = (1,0,0,1)
        _EID3336B6ProbeDepthAndAtlasOffset ("Probe Depth and Atlas Offset", Vector) = (0,0,0,0)
        _EID3336B6FallbackProbeNormalPlane ("Fallback Probe Normal Plane", Vector) = (0,1,0,1)

        [Header(Captured Lighting Textures)]
        [NoScaleOffset] _EID3336B6ScreenSH ("Captured Screen SH", 2D) = "black" {}
        [NoScaleOffset] _EID3336B6ScreenSpecularColor ("Captured Screen Specular", 2D) = "black" {}
        [NoScaleOffset] _EID3336B6ScreenSpecularWeight ("Captured Screen Specular Weight", 2D) = "black" {}
        [NoScaleOffset] _EID3336B6ReflectionValidity ("Captured Reflection Validity", 2D) = "black" {}
        [NoScaleOffset] _EID3336B6ReflectionVisibility ("Captured Reflection Visibility", 2D) = "white" {}
        [NoScaleOffset] _EID3336B6SSAO ("Captured SSAO", 2D) = "white" {}
        [NoScaleOffset] _EID3336B6ReflectionAtlas ("Captured Reflection Atlas", 2DArray) = "" {}

        [Header(Pipeline Supplied Read Only)]
        [HideInInspector] [NoScaleOffset] _EID3336B6RT0 ("URP GBuffer0", 2D) = "black" {}
        [HideInInspector] [NoScaleOffset] _EID3336B6RT1 ("URP GBuffer1", 2D) = "black" {}
        [HideInInspector] [NoScaleOffset] _EID3336B6RT2 ("URP GBuffer2", 2D) = "black" {}
        [HideInInspector] [NoScaleOffset] _EID3336B6RT3 ("URP GBuffer3", 2D) = "black" {}
        [HideInInspector] [NoScaleOffset] _EID3336B6RT4 ("Legacy GBuffer4", 2D) = "black" {}
        [HideInInspector] [NoScaleOffset] _EID3336B6Depth ("URP Depth", 2D) = "black" {}
    }

    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Overlay" }
        Pass
        {
            Name "EID3336_DirectionB_B6_CapturedIndirect"
            Cull Off
            ZTest Always
            ZWrite Off
            Blend Off
            HLSLPROGRAM
            #pragma target 4.5
            #pragma vertex EID3336B6VS
            #pragma fragment EID3336B6PS
            #include "EID3332CombinedB6.hlsl"
            ENDHLSL
        }
    }
    Fallback Off
}



