Shader "EID/URP/VS215512_PS215513_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res27 ("res27 基础颜色 Binding3", 2D) = "white" {}
        _Res29 ("res29 切线法线 Binding2", 2D) = "bump" {}
        [Header(RenderDoc_PS_uniforms32_c00_c27)]
        _P00 ("c00 法线强度及粗糙度范围", Vector) = (1,0,0,1)
        _P01 ("c01 AO与双面法线", Vector) = (1,0,0,0)
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
        _P22 ("c22 扫光混色与边缘光开关", Vector) = (0,0,0,0)
        _P23 ("c23 边缘光偏移 幂 顶点混合", Vector) = (0,1,0,0)
        _P24 ("c24 边缘光颜色", Vector) = (0,0,0,0)
        _P25 ("c25 捕获局部参数", Vector) = (0,0,0,0)
        _P26 ("c26 扫光速度 周期 宽度 强度", Vector) = (0,1,1,0)
        _P27 ("c27 扫光平移 亮度 偏移", Vector) = (0,0,0,0)
        _InstanceMeta ("uniforms34 实例材质元数据", Vector) = (0,0,0,0)
        _InstanceStateYZ ("uniforms24 child1.yz + child5.x", Vector) = (0,0,0,0)
        _InstanceChild7 ("uniforms24 child7 扫光颜色", Vector) = (0,0,0,0)
        _InstanceChild8 ("uniforms24 child8 脉冲", Vector) = (0,0,0,0)
        _ScanGlobals ("mip time globalY useViewForward", Vector) = (0,0,1,0)
        _UseBakedSkinning ("Captured ssbo31 skin baked into VSInput", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "VS215512_PS215513_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Back
            ZWrite On
            ZTest LEqual
            Blend Off
            Stencil { Ref 0 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID215512Vertex
            #pragma fragment EID215513Fragment
            #include "EID215512215513GBuffer.hlsl"
            ENDHLSL
        }
    }
}
