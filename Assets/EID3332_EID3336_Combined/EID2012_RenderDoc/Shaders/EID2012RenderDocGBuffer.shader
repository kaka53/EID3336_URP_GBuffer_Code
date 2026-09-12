Shader "EID2012/URP/RenderDocGBuffer"
{
    Properties
    {
        [NoScaleOffset] _EID2012BaseColorMap ("基础色贴图（RenderDoc res17 / RID 266514）", 2D) = "white" {}
        [NoScaleOffset] _EID2012NormalMaterialMap ("法线材质贴图（RenderDoc res19 / RID 266538）", 2D) = "bump" {}
        _EID2012MipBias ("纹理 Mip 偏移（捕获值 -1）", Float) = -1
        _EID2012BaseColorScale ("RT0 基础色缩放（uniforms22.m1，捕获值 0）", Float) = 0
        _EID2012LocalParam0 ("局部参数 m0（当前 PS 未使用，捕获值 0）", Float) = 0
        _EID2012LocalParam2 ("局部参数 m2（当前 PS 未使用）", Vector) = (0,0,0,0)
        _EID2012LocalParam3 ("局部参数 m3（当前 PS 未使用）", Vector) = (0,0,0,0)
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "EID2012_RenderDoc_GBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Back
            ZWrite On
            ZTest LEqual
            Blend Off
            Stencil { Ref 0 Comp Always Pass Replace ReadMask 255 WriteMask 255 }

            HLSLPROGRAM
            #pragma target 5.0
            #pragma vertex EID2012Vertex
            #pragma fragment EID2012Fragment
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "EID2012Vertex.hlsl"
            #include "EID2012Pixel.hlsl"
            ENDHLSL
        }
    }
}
