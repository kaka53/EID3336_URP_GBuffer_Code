Shader "EID/URP/VS215499_PS215501_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res23 ("res23 基础颜色 Binding5", 2D) = "white" {}
        _Res25 ("res25 切线法线 Binding3", 2D) = "bump" {}
        _Res27 ("res27 叠加颜色 Binding4", 2D) = "white" {}
        [Header(RenderDoc_PS_uniforms30_c00_c30)]
        _P00 ("c00 法线强度及粗糙度范围", Vector) = (1,0,0,1)
        _P01 ("c01 AO与双面法线", Vector) = (1,0,0,1)
        _P02 ("c02 基础色UV混合 w", Vector) = (0,0,0,0)
        _P03 ("c03 法线UV LOD与材质Y", Vector) = (0,0,0,0)
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
        _P22 ("c22 叠加灯光与白色混合", Vector) = (0,0,0,0)
        _P23 ("c23 捕获局部参数", Vector) = (0,0,0,0)
        _P24 ("c24 叠加混色", Vector) = (1,1,1,1)
        _P25 ("c25 叠加UV混合与强度", Vector) = (0,1,0,0)
        _P26 ("c26 叠加通道Y乘色", Vector) = (0,0,0,0)
        _P27 ("c27 叠加通道Z乘色", Vector) = (0,0,0,0)
        _P28 ("c28 叠加通道W乘色", Vector) = (0,0,0,0)
        _P29 ("c29 叠加UV附加", Vector) = (0,0,0,0)
        _P30 ("c30 叠加UV", Vector) = (1,1,0,0)
        _InstanceMeta ("uniforms32 实例材质元数据", Vector) = (0,0,0,0)
        _InstanceStateYZ ("uniforms20 实例状态 YZ", Vector) = (0,0,0,0)
        _OverlayChild5 ("uniforms20 child5", Vector) = (0,0,0,0)
        _OverlayChild7 ("uniforms20 child7", Vector) = (0,0,0,0)
        _OverlayChild9 ("uniforms20 child9", Vector) = (1,1,1,0)
        _EID215501MipBias ("uniforms17 全局纹理 Mip Bias", Float) = 0
        _Global75W ("uniforms17 child75.w", Float) = 0
        _LightMixY ("uniforms17 child20.y", Float) = 1
        _UseBakedSkinning ("Captured ssbo30 skin baked into VSInput", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "VS215499_PS215501_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Back
            ZWrite On
            ZTest LEqual
            Blend Off
            Stencil { Ref 0 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID215499Vertex
            #pragma fragment EID215501Fragment
            #include "EID215499215501GBuffer.hlsl"
            ENDHLSL
        }
    }
}
