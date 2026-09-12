Shader "EID/URP/VS209990_PS209991_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res28 ("res28 基础颜色 Binding2", 2D) = "white" {}
        _Res26 ("res26 DXT5nm Binding3", 2D) = "bump" {}
        [Header(RenderDoc_PS_uniforms31_c00_c22)]
        _P00 ("c00 child0-3", Vector) = (0,0,0,0)
        _P01 ("c01 法线强度 child4", Vector) = (1,0,0,0)
        _P02 ("c02 child8-11 材质与高光", Vector) = (0,0,0,0.2)
        _P03 ("c03 双面混合 AO", Vector) = (0,1,0,0.2)
        _P04 ("c04 粗糙度范围", Vector) = (0,0.94,0.94,0)
        _P05 ("c05 wrap 与混色", Vector) = (0,0,1,0)
        _P06 ("c06 色倍率 距离衰减 粗糙度分支", Vector) = (1.25,1,0,0)
        _P07 ("c07 捕获局部参数", Vector) = (0,0,0,0)
        _P08 ("c08 AO smoothstep", Vector) = (0,0.01,0,0.01)
        _P09 ("c09 基础颜色乘色", Vector) = (1,1,1,1)
        _P10 ("c10 捕获局部参数", Vector) = (0,0,0,0)
        _P11 ("c11 捕获局部参数", Vector) = (0,0,0,0)
        _P12 ("c12 捕获局部参数", Vector) = (0,0,0,0)
        _P13 ("c13 捕获局部参数", Vector) = (0,0,0,0)
        _P14 ("c14 胶囊混合", Vector) = (0,0,0,0)
        _P15 ("c15 胶囊0", Vector) = (0,0,0,0)
        _P16 ("c16 胶囊1", Vector) = (0,0,0,0)
        _P17 ("c17 胶囊2", Vector) = (0,0,0,0)
        _P18 ("c18 胶囊3", Vector) = (0,0,0,0)
        _P19 ("c19 捕获局部参数", Vector) = (0,0,0,0)
        _P20 ("c20 捕获局部参数", Vector) = (0,0,0,0)
        _P21 ("c21 捕获局部参数", Vector) = (0,0,0,0)
        _P22 ("c22 捕获局部参数", Vector) = (0,0,0,0)
        _SunDir ("uniforms33 child0 太阳方向", Vector) = (0,-0.57,-0.82,0)
        _EID209991MipBias ("uniforms20 全局纹理 Mip Bias", Float) = -1
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry+10" }
        Pass
        {
            Name "VS209990_PS209991_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Off
            ZWrite Off
            ZTest Equal
            Blend Off
            Stencil { Ref 33 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID209990Vertex
            #pragma fragment EID209991Fragment
            #include "EID209990209991GBuffer.hlsl"
            ENDHLSL
        }
    }
}
