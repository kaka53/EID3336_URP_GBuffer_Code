Shader "EID/URP/VS244085_PS244086_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res33 ("res33 基础颜色 Binding9", 2D) = "white" {}
        _Res35 ("res35 切线法线 Binding2", 2D) = "bump" {}
        _Res37 ("res37 细节叠加 Binding3", 2D) = "gray" {}
        _Res38 ("res38 extra/fade Binding7", 2D) = "white" {}
        _Res39 ("res39 extra maps 遮罩 Binding4", 2D) = "white" {}
        _Res40 ("res40 extra maps 混合 Binding8", 2D) = "white" {}
        _Res41 ("res41 extra maps 颜色 Binding6", 2D) = "white" {}
        _Res42 ("res42 extra maps DXT5nm Binding5", 2D) = "bump" {}
        [Header(RenderDoc_PS_uniforms44_c00_c46)]
        _P00 ("c00 捕获局部参数", Vector) = (0,0,0,0)
        _P01 ("c01 捕获局部参数", Vector) = (0,0,0,0)
        _P02 ("c02 捕获局部参数", Vector) = (0,0,0,0)
        _P03 ("c03 捕获局部参数", Vector) = (0,0,0,0)
        _P04 ("c04 捕获局部参数", Vector) = (0,0,0,0)
        _P05 ("c05 捕获局部参数", Vector) = (0,0,0,0)
        _P06 ("c06 捕获局部参数", Vector) = (0,0,0,0)
        _P07 ("c07 捕获局部参数", Vector) = (0,0,0,0)
        _P08 ("c08 捕获局部参数", Vector) = (0,0,0,0)
        _P09 ("c09 捕获局部参数", Vector) = (0,0,0,0)
        _P10 ("c10 捕获局部参数", Vector) = (0,0,0,0)
        _P11 ("c11 捕获局部参数", Vector) = (0,0,0,0)
        _P12 ("c12 捕获局部参数", Vector) = (0,0,0,0)
        _P13 ("c13 捕获局部参数", Vector) = (0,0,0,0)
        _P14 ("c14 捕获局部参数", Vector) = (0,0,0,0)
        _P15 ("c15 捕获局部参数", Vector) = (0,0,0,0)
        _P16 ("c16 捕获局部参数", Vector) = (0,0,0,0)
        _P17 ("c17 捕获局部参数", Vector) = (0,0,0,0)
        _P18 ("c18 捕获局部参数", Vector) = (0,0,0,0)
        _P19 ("c19 捕获局部参数", Vector) = (0,0,0,0)
        _P20 ("c20 捕获局部参数", Vector) = (0,0,0,0)
        _P21 ("c21 捕获局部参数", Vector) = (0,0,0,0)
        _P22 ("c22 捕获局部参数", Vector) = (0,0,0,0)
        _P23 ("c23 捕获局部参数", Vector) = (0,0,0,0)
        _P24 ("c24 捕获局部参数", Vector) = (0,0,0,0)
        _P25 ("c25 捕获局部参数", Vector) = (0,0,0,0)
        _P26 ("c26 捕获局部参数", Vector) = (0,0,0,0)
        _P27 ("c27 捕获局部参数", Vector) = (0,0,0,0)
        _P28 ("c28 捕获局部参数", Vector) = (0,0,0,0)
        _P29 ("c29 捕获局部参数", Vector) = (0,0,0,0)
        _P30 ("c30 捕获局部参数", Vector) = (0,0,0,0)
        _P31 ("c31 捕获局部参数", Vector) = (0,0,0,0)
        _P32 ("c32 捕获局部参数", Vector) = (0,0,0,0)
        _P33 ("c33 捕获局部参数", Vector) = (0,0,0,0)
        _P34 ("c34 捕获局部参数", Vector) = (0,0,0,0)
        _P35 ("c35 捕获局部参数", Vector) = (0,0,0,0)
        _P36 ("c36 捕获局部参数", Vector) = (0,0,0,0)
        _P37 ("c37 捕获局部参数", Vector) = (0,0,0,0)
        _P38 ("c38 捕获局部参数", Vector) = (0,0,0,0)
        _P39 ("c39 捕获局部参数", Vector) = (0,0,0,0)
        _P40 ("c40 捕获局部参数", Vector) = (0,0,0,0)
        _P41 ("c41 捕获局部参数", Vector) = (0,0,0,0)
        _P42 ("c42 捕获局部参数", Vector) = (0,0,0,0)
        _P43 ("c43 捕获局部参数", Vector) = (0,0,0,0)
        _P44 ("c44 捕获局部参数", Vector) = (0,0,0,0)
        _P45 ("c45 捕获局部参数", Vector) = (0,0,0,0)
        _P46 ("c46 捕获局部参数", Vector) = (0,0,0,0)
        _InstanceMeta ("uniforms46 实例材质元数据", Vector) = (0,0,0,0)
        _InstanceStateYZ ("uniforms30 实例状态 YZ", Vector) = (0,0,0,0)
        _EID244086MipBias ("uniforms21 全局纹理 Mip Bias", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "VS244085_PS244086_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Back
            ZWrite On
            ZTest GEqual
            Blend Off
            Stencil { Ref 0 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID244085Vertex
            #pragma fragment EID244086Fragment
            #include "EID244085244086GBuffer.hlsl"
            ENDHLSL
        }
    }
}
