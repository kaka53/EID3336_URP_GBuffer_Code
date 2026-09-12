Shader "EID/URP/VS215445_PS215446_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res27 ("res27 基础颜色 Binding1", 2D) = "white" {}
        [Header(RenderDoc_PS_uniforms26_20xfloat4)]
        _P00 ("c00 捕获局部参数", Vector) = (0,0,0,0)
        _P01 ("c01 child4-7 双面法线在 y", Vector) = (0,1,0,0)
        _P02 ("c02 捕获局部参数", Vector) = (0,0,0,0)
        _P03 ("c03 捕获局部参数", Vector) = (0,0,0,0)
        _P04 ("c04 捕获局部参数", Vector) = (0,0,0,0)
        _P05 ("c05 捕获局部参数", Vector) = (0,0,0,0)
        _P06 ("c06 child24 基础色乘色", Vector) = (1,1,1,1)
        _P07 ("c07 捕获局部参数", Vector) = (0,0,0,0)
        _P08 ("c08 捕获局部参数", Vector) = (0,0,0,0)
        _P09 ("c09 捕获局部参数", Vector) = (0,0,0,0)
        _P10 ("c10 child28 UV scale/offset", Vector) = (1,1,0,0)
        _P11 ("c11 捕获局部参数", Vector) = (0,0,0,0)
        _P12 ("c12 child30 wrap 在 x", Vector) = (0,0,0,0)
        _P13 ("c13 child34 wrap 乘色", Vector) = (1,1,1,1)
        _P14 ("c14 捕获局部参数", Vector) = (0,0,0,0)
        _P15 ("c15 捕获局部参数", Vector) = (0,0,0,0)
        _P16 ("c16 捕获局部参数", Vector) = (0,0,0,0)
        _P17 ("c17 捕获局部参数", Vector) = (0,0,0,0)
        _P18 ("c18 捕获局部参数", Vector) = (0,0,0,0)
        _P19 ("c19 捕获局部参数", Vector) = (0,0,0,0)
        _InstancePacked ("uniforms21 child2 10/10/10/2", Vector) = (0,0,0,0)
        _EID215446MipBias ("uniforms18 全局纹理 Mip Bias", Float) = 0
        _UseBakedSkinning ("Captured ssbo25 skin baked into VSInput", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "VS215445_PS215446_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Back
            ZWrite On
            ZTest LEqual
            Blend Off
            Stencil { Ref 36 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID215445Vertex
            #pragma fragment EID215446Fragment
            #include "EID215445215446GBuffer.hlsl"
            ENDHLSL
        }
    }
}
