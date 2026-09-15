Shader "EID/URP/VS238900_PS238901_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res34 ("res34 基础颜色 Binding8", 2D) = "white" {}
        _Res36 ("res36 切线法线 Binding3", 2D) = "bump" {}
        _Res38 ("res38 打包材质 Binding4", 2D) = "gray" {}
        _Res40 ("res40 额外混合 Binding7", 2D) = "white" {}
        _Res41 ("res41 额外颜色 Binding6", 2D) = "white" {}
        _Res42 ("res42 额外法线 Binding5", 2D) = "bump" {}
        [Header(RenderDoc_PS_uniforms44_c00_c30)]
        _P00 ("c00 法线强度及粗糙度范围", Vector) = (1,0,0,1)
        _P01 ("c01 AO与双面法线", Vector) = (1,0,0,1)
        _P02 ("c02 基础色UV混合 w", Vector) = (0,0,0,0)
        _P03 ("c03 法线UV LOD与材质Y", Vector) = (0,0,0,0)
        _P04 ("c04 常量色 材质Y 色倍率 材质Z", Vector) = (0,1,1,0.2)
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
        _P22 ("c22 额外轴 混合偏置 UV缩放 法线强度", Vector) = (0,0.591,1.5,1)
        _P23 ("c23 额外混合开关", Vector) = (0,0,1,0)
        _P24 ("c24 额外材质衰减与遮罩选择", Vector) = (0,1,0,0)
        _P25 ("c25 额外色倍率", Vector) = (1,0,0,0)
        _P26 ("c26 额外颜色乘色", Vector) = (1,1,1,1)
        _P27 ("c27 额外UV偏移", Vector) = (0,0,0,0)
        _P28 ("c28 额外遮罩UV与采样源", Vector) = (2.56,0,0.36,0)
        _P29 ("c29 捕获局部参数", Vector) = (0.5,0.3,1,1)
        _P30 ("c30 捕获局部参数", Vector) = (0,0,0,0)
        _InstanceMeta ("uniforms46 实例材质元数据", Vector) = (0,0,0,0)
        _InstanceStateYZ ("uniforms30 实例状态 YZ", Vector) = (0,0,0,0)
        _EID238901MipBias ("uniforms22 全局纹理 Mip Bias", Float) = -1
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "VS238900_PS238901_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Back
            ZWrite On
            ZTest GEqual
            Blend Off
            Stencil { Ref 0 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID238900Vertex
            #pragma fragment EID238901Fragment
            #include "EID238900238901GBuffer.hlsl"
            ENDHLSL
        }
    }
}
