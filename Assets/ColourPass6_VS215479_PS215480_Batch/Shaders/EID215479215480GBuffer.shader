Shader "EID/URP/VS215479_PS215480_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res12 ("res12 基础颜色 Binding1", 2D) = "white" {}
        [Header(RenderDoc_PS_uniforms11_21xfloat4)]
        _P00 ("c00 捕获局部参数", Vector) = (0,0,0,0)
        _P01 ("c01 捕获局部参数", Vector) = (0,0,0,0)
        _P02 ("c02 child9 裁剪阈值在 y", Vector) = (0,0.5,0,0)
        _P03 ("c03 捕获局部参数", Vector) = (0,0,0,0)
        _P04 ("c04 捕获局部参数", Vector) = (0,0,0,0)
        _P05 ("c05 捕获局部参数", Vector) = (0,0,0,0)
        _P06 ("c06 child24 透明度在 w", Vector) = (1,1,1,1)
        _P07 ("c07 捕获局部参数", Vector) = (0,0,0,0)
        _P08 ("c08 捕获局部参数", Vector) = (0,0,0,0)
        _P09 ("c09 捕获局部参数", Vector) = (0,0,0,0)
        _P10 ("c10 child28 UV scale/offset", Vector) = (1,1,0,0)
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
        _EID215480MipBias ("uniforms6 全局纹理 Mip Bias", Float) = 0
        _UseBakedSkinning ("Captured ssbo31 skin baked into VSInput", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="TransparentCutout" "Queue"="AlphaTest" }
        Pass
        {
            Name "VS215479_PS215480_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Front
            ZWrite On
            ZTest LEqual
            Blend Off
            ColorMask RGBA 0
            ColorMask 0 1
            ColorMask 0 2
            ColorMask 0 3
            ColorMask 0 4
            Stencil { Ref 36 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID215479Vertex
            #pragma fragment EID215480Fragment
            #include "EID215479215480GBuffer.hlsl"
            ENDHLSL
        }
    }
}
