Shader "EID/URP/VS209975_PS209977_GBuffer"
{
    Properties
    {
        [NoScaleOffset] _Res17 ("res17 基础色 Binding3 BC7_SRGB", 2D) = "white" {}
        [NoScaleOffset] _Res19 ("res19 切线法线与材质 Binding2 BC7_SRGB", 2D) = "bump" {}
        _EID209977MipBias ("uniforms14.m16 纹理 Mip 偏移", Float) = -1
        _EID209977BaseColorScale ("uniforms22.m1 RT0 基础色缩放", Float) = 0
        _EID209977LocalParam0 ("uniforms22.m0 捕获局部参数", Float) = 0
        _EID209977LocalParam2 ("uniforms22.m2 捕获局部参数", Vector) = (0,0,0,0)
        _EID209977LocalParam3 ("uniforms22.m3 捕获局部参数", Vector) = (0,0,0,0)
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "VS209975_PS209977_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Back
            ZWrite On
            ZTest LEqual
            Blend Off
            Stencil { Ref 0 Comp Always Pass Replace ReadMask 255 WriteMask 255 }

            HLSLPROGRAM
            #pragma target 5.0
            #pragma vertex EID209975Vertex
            #pragma fragment EID209977Fragment
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "EID209975209977GBuffer.hlsl"
            ENDHLSL
        }
    }
}
