Shader "EID/URP/VS264371_PS264372_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res23 ("res23 基础颜色 Binding3", 2D) = "white" {}
        _Res25 ("res25 切线法线 Binding2", 2D) = "bump" {}
        [Header(RenderDoc_PS_uniforms28_c00_c23)]
        _P00 ("c00 捕获局部参数", Vector) = (0,0,0,0)
        _P01 ("c01 捕获局部参数", Vector) = (0,0,0,0)
        _P02 ("c02 捕获局部参数", Vector) = (0,0,0,0)
        _P03 ("c03 捕获局部参数", Vector) = (0,0,0,0)
        _P04 ("c04 捕获局部参数", Vector) = (0,0,0,0)
        _P05 ("c05 捕获局部参数", Vector) = (0,0,0,0)
        _P06 ("c06 捕获局部参数", Vector) = (0,0,0,0)
        _P07 ("c07 捕获局部参数", Vector) = (0,0,0,0)
        _P08 ("c08 捕获局部参数", Vector) = (0,0,0,0)
        _P09 ("c09 捕获局部参数", Vector) = (0,0,0,0)
        _P10 ("c10 捕获局部参数", Vector) = (0,0,0,0)
        _P11 ("c11 捕获局部参数", Vector) = (0,0,0,0)
        _P12 ("c12 捕获局部参数", Vector) = (0,0,0,0)
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
        _P23 ("c23 捕获局部参数", Vector) = (0,0,0,0)
        _InstanceMeta ("uniforms30 实例材质元数据", Vector) = (0,0,0,0)
        _InstanceStateYZ ("uniforms20 child1.yz + child5.x", Vector) = (0,0,0,0)
        _EID264372MipBias ("uniforms17 全局纹理 Mip Bias", Float) = 0
        _UseBakedSkinning ("Captured ssbo skin baked into VSInput", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry+10" }
        Pass
        {
            Name "VS264371_PS264372_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Off
            ZWrite Off
            ZTest Equal
            Blend Off
            Stencil { Ref 0 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID264371Vertex
            #pragma fragment EID264372Fragment
            #include "EID264371264372GBuffer.hlsl"
            ENDHLSL
        }
    }
}
