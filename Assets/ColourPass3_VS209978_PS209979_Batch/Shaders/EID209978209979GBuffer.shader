Shader "EID/URP/VS209978_PS209979_GBuffer"
{
    Properties
    {
        [Header(RenderDoc Textures)]
        _Res23 ("res23 基础颜色贴图 Binding5", 2D) = "white" {}
        _Res25 ("res25 法线贴图 Binding3", 2D) = "bump" {}
        _Res27 ("res27 材质参数贴图 Binding4", 2D) = "white" {}
        [Header(RenderDoc_PS_uniforms30_c00_c21)]
        _P00 ("c00 法线强度与粗糙度范围", Vector) = (1,0,0,1)
        _P01 ("c01 材质通道与双面法线", Vector) = (1,0,0,0)
        _P02 ("c02 基础色 UV 选择", Vector) = (0,0,0,0)
        _P03 ("c03 法线材质 UV 与 LOD", Vector) = (0,0,0,1)
        _P04 ("c04 常量色 粗糙度与材质控制", Vector) = (0,1,1,0)
        _P05 ("c05 材质通道合成", Vector) = (0,0,0,0)
        _P06 ("c06 捕获局部参数", Vector) = (0,0,0,0)
        _P07 ("c07 RT1 与材质衰减", Vector) = (0,0,0,0)
        _P08 ("c08 基础颜色乘色 RGBA", Color) = (1,1,1,1)
        _P09 ("c09 捕获局部参数", Vector) = (0,0,0,0)
        _P10 ("c10 捕获局部参数", Vector) = (0,0,0,0)
        _P11 ("c11 基础颜色 UV 缩放偏移", Vector) = (1,1,0,0)
        _P12 ("c12 法线材质 UV 缩放偏移", Vector) = (1,1,0,0)
        _P13 ("c13 捕获局部参数", Vector) = (0,0,0,0)
        _P14 ("c14 捕获局部参数", Vector) = (0,0,0,0)
        _P15 ("c15 捕获局部参数", Vector) = (0,0,0,0)
        _P16 ("c16 捕获局部参数", Vector) = (0,0,0,0)
        _P17 ("c17 捕获局部参数", Vector) = (0,0,0,0)
        _P18 ("c18 捕获局部参数", Vector) = (0,0,0,0)
        _P19 ("c19 捕获局部参数", Vector) = (0,0,0,0)
        _P20 ("c20 捕获局部参数", Vector) = (0,0,0,0)
        _P21 ("c21 捕获局部参数", Vector) = (0,0,0,0)
        [HideInInspector] _InstanceMeta ("uniforms32 实例材质元数据", Vector) = (0,0,0,0)
        [HideInInspector] _InstanceStateYZ ("uniforms20 实例状态 YZ", Vector) = (0,0,0,0)
        [HideInInspector] _EID209979MipBias ("uniforms17 全局纹理 Mip Bias", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "VS209978_PS209979_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Off
            ZWrite On
            ZTest LEqual
            Blend Off
            Stencil { Ref 32 Comp Always Pass Replace ReadMask 96 WriteMask 96 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID209978Vertex
            #pragma fragment EID209979Fragment
            #include "EID209978209979GBuffer.hlsl"
            ENDHLSL
        }
    }
}

