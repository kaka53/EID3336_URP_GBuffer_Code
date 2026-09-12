Shader "EID/URP/VS230644_PS230645_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res23 ("res23 基础颜色 Binding7", 2D) = "white" {}
        _Res25 ("res25 切线法线 Binding4", 2D) = "bump" {}
        _Res27 ("res27 材质通道 Binding5", 2D) = "white" {}
        _Res29 ("res29 叠加 Binding6", 2D) = "white" {}
        [Header(RenderDoc_PS_uniforms32_c00_c15)]
        _P00 ("c00 法线强度及粗糙度范围", Vector) = (1,0,0,1)
        _P01 ("c01 AO与全局Y混", Vector) = (1,0,0,0)
        _P02 ("c02 常量白混与法线LOD", Vector) = (0,0,0,0)
        _P03 ("c03 背面常量色", Vector) = (1,1,1,1)
        _P04 ("c04 捕获局部参数", Vector) = (0,0,0,0)
        _P05 ("c05 捕获局部参数", Vector) = (0,0,0,0)
        _P06 ("c06 捕获局部参数", Vector) = (0,0,0,0)
        _P07 ("c07 捕获局部参数", Vector) = (0,0,0,0)
        _P08 ("c08 捕获局部参数", Vector) = (0,0,0,0)
        _P09 ("c09 捕获局部参数", Vector) = (0,0,0,0)
        _P10 ("c10 捕获局部参数", Vector) = (0,0,0,0)
        _P11 ("c11 叠加UV与倍率", Vector) = (0,0,0,0)
        _P12 ("c12 捕获局部参数", Vector) = (0,0,0,0)
        _P13 ("c13 叠加色A", Vector) = (0,0,0,1)
        _P14 ("c14 叠加色B", Vector) = (0,0,0,1)
        _P15 ("c15 捕获局部参数", Vector) = (0,0,0,0)
        _InstanceStateYZ ("uniforms20 实例状态 YZ", Vector) = (0,0,0,0)
        _InstanceChild5 ("uniforms20 基础色乘色", Vector) = (1,1,1,1)
        _InstanceChild6 ("uniforms20 叠加乘色", Vector) = (1,1,1,1)
        _InstanceChild8 ("uniforms20 背面常量开关", Vector) = (0,0,0,0)
        _EID230645MipBias ("uniforms17 全局纹理 Mip Bias", Float) = 0
        _EID230645GlobalY ("uniforms17 child20.y", Float) = 1
        _UseBakedSkinning ("Captured ssbo29 skin baked into VSInput", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "VS230644_PS230645_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Back
            ZWrite On
            ZTest LEqual
            Blend Off
            Stencil { Ref 32 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID230644Vertex
            #pragma fragment EID230645Fragment
            #include "EID230644230645GBuffer.hlsl"
            ENDHLSL
        }
    }
}
