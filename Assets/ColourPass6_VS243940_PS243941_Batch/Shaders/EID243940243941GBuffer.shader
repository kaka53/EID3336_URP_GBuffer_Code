Shader "EID/URP/VS243940_PS243941_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res27 ("res27 基础颜色 Binding12", 2D) = "white" {}
        _Res29 ("res29 DXT5nm Binding9", 2D) = "bump" {}
        _Res31 ("res31 材质通道 Binding11", 2D) = "white" {}
        _Res33 ("res33 叠加 Binding8", 2D) = "black" {}
        _Res35 ("res35 Matcap Binding10", 2D) = "black" {}
        [Header(RenderDoc_PS_uniforms41_c00_c36)]
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
        _InstanceMeta ("uniforms43 实例材质元数据", Vector) = (0,0,0,0)
        _InstanceStateYZ ("uniforms23 实例状态 YZ", Vector) = (0,0,0,0)
        _EID243941MipBias ("uniforms20 全局纹理 Mip Bias", Float) = 0
        _LightMixY ("uniforms20 child20.y", Float) = 1
        _UseBakedSkinning ("Captured ssbo30 skin baked into VSInput", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "VS243940_PS243941_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Back
            ZWrite On
            ZTest GEqual
            Blend Off
            Stencil { Ref 0 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID243940Vertex
            #pragma fragment EID243941Fragment
            #include "EID243940243941GBuffer.hlsl"
            ENDHLSL
        }
    }
}
