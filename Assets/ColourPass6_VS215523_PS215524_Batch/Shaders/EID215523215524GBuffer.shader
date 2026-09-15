Shader "EID/URP/VS215523_PS215524_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res26 ("res26 基础颜色 Binding11", 2D) = "white" {}
        _Res28 ("res28 BC5法线 Binding9", 2D) = "bump" {}
        _Res30 ("res30 附加层 Binding10", 2D) = "white" {}
        _Res32 ("res32 扫描色 Binding8", 2D) = "black" {}
        _Res34 ("res34 扫描混合 Binding7", 2D) = "white" {}
        _Res36 ("res36 POM高度 Binding6", 2D) = "black" {}
        [Header(RenderDoc_PS_uniforms39_c00_c35)]
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
        _P22 ("c22 POM视差缩放", Vector) = (0.03,0,0,0)
        _P23 ("c23 捕获局部参数", Vector) = (0,0,0,0)
        _P24 ("c24 POM步数 扫描UV 脉冲 实例W", Vector) = (0,7,5,1)
        _P25 ("c25 脉冲k NdotV 全局Y 蒙版混合", Vector) = (0.05,3,1,0)
        _P26 ("c26 高度UV 蒙版清零 高度缩放 距离开关", Vector) = (0,0,7,0)
        _P27 ("c27 距离Far Near Amount", Vector) = (20,10,1,0)
        _P28 ("c28 res34混合 RT0缩放", Vector) = (0,0,0,1)
        _P29 ("c29 扫描色A", Vector) = (52.601,34.519,13.698,1)
        _P30 ("c30 扫描色B", Vector) = (0,0,0,1)
        _P31 ("c31 捕获局部参数", Vector) = (0,0,0,0)
        _P32 ("c32 捕获局部参数", Vector) = (0,0,0,0)
        _P33 ("c33 捕获局部参数", Vector) = (0,0,0,0)
        _P34 ("c34 捕获局部参数", Vector) = (0,0,0,0)
        _P35 ("c35 捕获局部参数", Vector) = (0,0,0,0)
        _InstanceMeta ("uniforms41 实例材质元数据", Vector) = (0,0,0,0)
        _InstanceStateYZ ("uniforms23 实例状态 YZ", Vector) = (0,0,0,0)
        _ScanPos ("uniforms20 child75 扫描原点", Vector) = (0,0,0,0)
        _ScanPoint ("uniforms20 child77 扫描点", Vector) = (0,0,0,0)
        _EID215524MipBias ("uniforms20 全局纹理 Mip Bias", Float) = 0
        _ScanPomGrad ("uniforms20 child17 POM梯度", Float) = 0.5
        _ScanGlobalY ("uniforms20 child20.y 扫描全局Y", Float) = 1
        _InstanceAffineW ("instance matrix col0-2.w 之和", Float) = 0
        _UseBakedSkinning ("Captured ssbo30 skin baked into VSInput", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "VS215523_PS215524_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Back
            ZWrite On
            ZTest GEqual
            Blend Off
            Stencil { Ref 0 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID215523Vertex
            #pragma fragment EID215524Fragment
            #include "EID215523215524GBuffer.hlsl"
            ENDHLSL
        }
    }
}
