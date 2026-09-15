Shader "EID/URP/VS215491_PS215492_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res27 ("res27 基础颜色 Binding4", 2D) = "white" {}
        _Res29 ("res29 RG法线 Binding2", 2D) = "bump" {}
        _Res31 ("res31 附加层 Binding3", 2D) = "white" {}
        [Header(RenderDoc_PS_uniforms33_c00_c25)]
        _P00 ("c00 法线强度及粗糙度范围", Vector) = (1,0,0,1)
        _P01 ("c01 AO与双面法线", Vector) = (1,0,0,1)
        _P02 ("c02 基础色UV混合 w", Vector) = (0,0,0,1)
        _P03 ("c03 法线UV LOD与材质Y", Vector) = (0,0,0,1)
        _P04 ("c04 常量色 材质Y 色倍率 材质Z", Vector) = (0,0,1,0.2)
        _P05 ("c05 材质通道合成", Vector) = (0.4,0,0,0)
        _P06 ("c06 捕获局部参数", Vector) = (0,0,0,0)
        _P07 ("c07 RT1与材质衰减", Vector) = (0,0,0,0)
        _P08 ("c08 基础颜色乘色", Vector) = (1,1,1,1)
        _P09 ("c09 捕获局部参数", Vector) = (0,0,0,0)
        _P10 ("c10 捕获局部参数", Vector) = (0,0,0,0)
        _P11 ("c11 基础颜色UV", Vector) = (1,1,0,0)
        _P12 ("c12 法线贴图UV", Vector) = (1,1,0,0)
        _P13 ("c13 捕获局部参数", Vector) = (0,0,0,0)
        _P14 ("c14 捕获局部参数", Vector) = (0,0,0,0)
        _P15 ("c15 捕获局部参数", Vector) = (0,0,0,0)
        _P16 ("c16 捕获局部参数", Vector) = (0,0,0,0)
        _P17 ("c17 捕获局部参数", Vector) = (0,0,0,0)
        _P18 ("c18 捕获局部参数", Vector) = (0,0,0,0)
        _P19 ("c19 捕获局部参数", Vector) = (0,0,0,0)
        _P20 ("c20 捕获局部参数", Vector) = (0,0,0,0)
        _P21 ("c21 捕获局部参数", Vector) = (0,0,0,0)
        _P22 ("c22 附加层粗糙度 蒙版 法线 混合", Vector) = (1,0,1,1)
        _P23 ("c23 距离衰减与附加UV混合", Vector) = (750,800,1,1)
        _P24 ("c24 附加层混色", Vector) = (0,0,0,0)
        _P25 ("c25 附加层UV", Vector) = (6,6,0,0)
        _InstanceMeta ("uniforms35 实例材质元数据", Vector) = (0,0,0,0)
        _InstanceStateYZ ("uniforms23 实例状态 YZ", Vector) = (0,0,0,0)
        _EID215492MipBias ("uniforms20 全局纹理 Mip Bias", Float) = 0
        _UseBakedSkinning ("Captured ssbo30 skin baked into VSInput", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "VS215491_PS215492_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Back
            ZWrite On
            ZTest GEqual
            Blend Off
            Stencil { Ref 0 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID215491Vertex
            #pragma fragment EID215492Fragment
            #include "EID215491215492GBuffer.hlsl"
            ENDHLSL
        }
    }
}
