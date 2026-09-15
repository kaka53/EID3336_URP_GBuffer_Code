Shader "EID/URP/VS215537_PS215538_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res33 ("res33 基础颜色 Binding3", 2D) = "white" {}
        _Res35 ("res35 切线法线 Binding2", 2D) = "bump" {}
        [Header(RenderDoc_PS_uniforms38_c00_c31)]
        _P00 ("c00 法线强度及粗糙度范围", Vector) = (1,0,0,1)
        _P01 ("c01 AO与双面法线", Vector) = (1,0,0,1)
        _P02 ("c02 基础色UV混合 w", Vector) = (0,0,0,0)
        _P03 ("c03 法线UV LOD与材质Y", Vector) = (0,0,0,1)
        _P04 ("c04 常量色 材质Y 色倍率 材质Z", Vector) = (0,0,1,0.2)
        _P05 ("c05 材质通道合成", Vector) = (0.4,0,0,0)
        _P06 ("c06 捕获局部参数", Vector) = (0,0,0,0)
        _P07 ("c07 RT1与材质衰减", Vector) = (0,0,0,0)
        _P08 ("c08 基础颜色乘色", Vector) = (1,1,1,1)
        _P09 ("c09 捕获局部参数", Vector) = (0,0,0,0)
        _P10 ("c10 捕获局部参数", Vector) = (0,0,0,0)
        _P11 ("c11 基础颜色UV", Vector) = (1,1,1,1)
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
        _P22 ("c22 捕获局部参数", Vector) = (0,0,0,0)
        _P23 ("c23 全局混色 扫光混白 边缘光开关", Vector) = (1,1,0,0)
        _P24 ("c24 边缘光偏移 幂 顶点混合", Vector) = (0,1,0,0)
        _P25 ("c25 边缘光颜色", Vector) = (0.306,0.306,0.306,1)
        _P26 ("c26 捕获局部参数", Vector) = (0,0,0,0)
        _P27 ("c27 扫光速度 周期 宽度 强度", Vector) = (8,2,6,1)
        _P28 ("c28 扫光平移 亮度 偏移", Vector) = (0,0.3,0,0)
        _P29 ("c29 捕获局部参数", Vector) = (20,0.038,0.2,0)
        _P30 ("c30 捕获局部参数", Vector) = (1,0.3,1,1)
        _P31 ("c31 捕获局部参数", Vector) = (0,0,0,0)
        _InstanceMeta ("uniforms40 实例材质元数据", Vector) = (0,0,0,0)
        _InstanceStateYZ ("uniforms25 child1.yz + child5.x", Vector) = (0,0,0,0)
        _InstanceChild7 ("uniforms25 child7 扫光颜色", Vector) = (0,0,0,0)
        _InstanceChild8 ("uniforms25 child8 脉冲", Vector) = (0,0,0,0)
        _ScanGlobals ("mip time globalY useViewForward", Vector) = (0,0,1,0)
        _UseBakedSkinning ("Captured ssbo31 skin baked into VSInput", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry+10" }
        Pass
        {
            Name "VS215537_PS215538_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Off
            ZWrite Off
            ZTest Equal
            Blend Off
            Stencil { Ref 0 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID215537Vertex
            #pragma fragment EID215538Fragment
            #include "EID215537215538GBuffer.hlsl"
            ENDHLSL
        }
    }
}
