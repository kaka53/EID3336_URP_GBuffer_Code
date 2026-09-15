Shader "EID/URP/VS215519_PS215520_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res33 ("res33 基础颜色 Binding11", 2D) = "white" {}
        _Res35 ("res35 切线法线 Binding2", 2D) = "bump" {}
        _Res37 ("res37 细节叠加 Binding3", 2D) = "gray" {}
        _Res38 ("res38 extra/fade Binding9", 2D) = "white" {}
        _Res39 ("res39 extra maps 遮罩 Binding6", 2D) = "white" {}
        _Res40 ("res40 extra maps 混合 Binding10", 2D) = "white" {}
        _Res41 ("res41 extra maps 颜色 Binding8", 2D) = "white" {}
        _Res42 ("res42 extra maps 法线 Binding7", 2D) = "bump" {}
        _Res43 ("res43 overlay 层1 Binding4", 2D) = "white" {}
        _Res44 ("res44 overlay 层2 Binding5", 2D) = "white" {}
        [Header(RenderDoc_PS_uniforms46_c00_c47)]
        _P00 ("c00 法线强度及粗糙度范围", Vector) = (0,0,0,0)
        _P01 ("c01 AO与双面法线", Vector) = (0,0,0,0)
        _P02 ("c02 基础色UV混合 w", Vector) = (0,0,0,0)
        _P03 ("c03 法线UV LOD与材质Y", Vector) = (0,0,0,0)
        _P04 ("c04 常量色 材质Y 色倍率 材质Z", Vector) = (0,0,0,0)
        _P05 ("c05 材质通道合成", Vector) = (0,0,0,0)
        _P06 ("c06 捕获局部参数", Vector) = (0,0,0,0)
        _P07 ("c07 RT1与材质衰减", Vector) = (0,0,0,0)
        _P08 ("c08 基础颜色乘色", Vector) = (0,0,0,0)
        _P09 ("c09 捕获局部参数", Vector) = (0,0,0,0)
        _P10 ("c10 捕获局部参数", Vector) = (0,0,0,0)
        _P11 ("c11 基础颜色UV", Vector) = (0,0,0,0)
        _P12 ("c12 法线贴图UV", Vector) = (0,0,0,0)
        _P13 ("c13 捕获局部参数", Vector) = (0,0,0,0)
        _P14 ("c14 捕获局部参数", Vector) = (0,0,0,0)
        _P15 ("c15 捕获局部参数", Vector) = (0,0,0,0)
        _P16 ("c16 捕获局部参数", Vector) = (0,0,0,0)
        _P17 ("c17 捕获局部参数", Vector) = (0,0,0,0)
        _P18 ("c18 捕获局部参数", Vector) = (0,0,0,0)
        _P19 ("c19 捕获局部参数", Vector) = (0,0,0,0)
        _P20 ("c20 捕获局部参数", Vector) = (0,0,0,0)
        _P21 ("c21 捕获局部参数", Vector) = (0,0,0,0)
        _P22 ("c22 extra/fade 粗糙度源 遮罩选择 法线 混合", Vector) = (0,0,0,0)
        _P23 ("c23 extra/fade 近远 与UV混合", Vector) = (0,0,0,0)
        _P24 ("c24 extra/fade 颜色", Vector) = (0,0,0,0)
        _P25 ("c25 extra/fade UV", Vector) = (0,0,0,0)
        _P26 ("c26 extra maps 轴 混合偏置 UV缩放 法线", Vector) = (0,0,0,0)
        _P27 ("c27 extra maps A/AO/RNM", Vector) = (0,0,0,0)
        _P28 ("c28 extra maps 材质衰减与遮罩", Vector) = (0,0,0,0)
        _P29 ("c29 extra maps 色倍率", Vector) = (0,0,0,0)
        _P30 ("c30 extra maps 颜色乘色", Vector) = (0,0,0,0)
        _P31 ("c31 extra maps UV偏移", Vector) = (0,0,0,0)
        _P32 ("c32 extra maps 遮罩UV与采样源", Vector) = (0,0,0,0)
        _P33 ("c33 overlay UV混合 层0粗糙度 层粗糙度lo", Vector) = (0,0,0,0)
        _P34 ("c34 overlay 层粗糙度hi", Vector) = (0,0,0,0)
        _P35 ("c35 overlay 材质Y", Vector) = (0,0,0,0)
        _P36 ("c36 overlay lo/hi xy", Vector) = (0,0,0,0)
        _P37 ("c37 overlay lo/hi z", Vector) = (0,0,0,0)
        _P38 ("c38 overlay 层0 RGB与权重", Vector) = (0,0,0,0)
        _P39 ("c39 捕获局部参数", Vector) = (0,0,0,0)
        _P40 ("c40 捕获局部参数", Vector) = (0,0,0,0)
        _P41 ("c41 overlay 细节UV", Vector) = (0,0,0,0)
        _P42 ("c42 overlay 层1/层2 UV缩放", Vector) = (0,0,0,0)
        _P43 ("c43 overlay 层1 RGB与权重", Vector) = (0,0,0,0)
        _P44 ("c44 overlay 层2 RGB与权重", Vector) = (0,0,0,0)
        _P45 ("c45 捕获局部参数", Vector) = (0,0,0,0)
        _P46 ("c46 捕获局部参数", Vector) = (0,0,0,0)
        _P47 ("c47 捕获局部参数", Vector) = (0,0,0,0)
        _InstanceMeta ("uniforms48 实例材质元数据", Vector) = (0,0,0,0)
        _InstanceStateYZ ("uniforms30 实例状态 YZ", Vector) = (0,0,0,0)
        _EID215520MipBias ("uniforms21 全局纹理 Mip Bias", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "VS215519_PS215520_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Back
            ZWrite On
            ZTest GEqual
            Blend Off
            Stencil { Ref 0 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID215519Vertex
            #pragma fragment EID215520Fragment
            #include "EID215519215520GBuffer.hlsl"
            ENDHLSL
        }
    }
}
