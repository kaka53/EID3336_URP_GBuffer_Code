Shader "EID/URP/VS215443_PS215444_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res25 ("res25 基础颜色 Binding2", 2D) = "white" {}
        _Res26 ("res26 切线法线 Binding1", 2D) = "bump" {}
        [Header(RenderDoc_PS_uniforms24_18xfloat4)]
        _P00 ("c00 child0-3 法线强度在 w", Vector) = (0,0,0,1)
        _P01 ("c01 child4-7 双面法线在 y", Vector) = (0,1,0,0)
        _P02 ("c02 child8-11 裁剪阈值在 y", Vector) = (0,0,0,0)
        _P03 ("c03 捕获局部参数", Vector) = (0,0,0,0)
        _P04 ("c04 捕获局部参数", Vector) = (0,0,0,0)
        _P05 ("c05 捕获局部参数", Vector) = (0,0,0,0)
        _P06 ("c06 child24 基础色乘色与透明度", Vector) = (1,1,1,1)
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
        _InstancePacked ("uniforms19 child2 10/10/10/2", Vector) = (0,0,0,0)
        _EID215444MipBias ("uniforms16 全局纹理 Mip Bias", Float) = 0
        _UseBakedSkinning ("Captured ssbo27 skin baked into VSInput", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="TransparentCutout" "Queue"="AlphaTest" }
        Pass
        {
            Name "VS215443_PS215444_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Off
            ZWrite On
            ZTest LEqual
            Blend Off
            Stencil { Ref 36 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID215443Vertex
            #pragma fragment EID215444Fragment
            #include "EID215443215444GBuffer.hlsl"
            ENDHLSL
        }
    }
}
