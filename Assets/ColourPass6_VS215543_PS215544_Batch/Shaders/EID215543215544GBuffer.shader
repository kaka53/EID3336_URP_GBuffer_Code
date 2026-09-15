Shader "EID/URP/VS215543_PS215544_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res25 ("res25 基础颜色 Binding3", 2D) = "white" {}
        _Res27 ("res27 切线法线 Binding2", 2D) = "bump" {}
        [Header(RenderDoc_PS_uniforms30_c00_c13)]
        _P00 ("c00 child0-3", Vector) = (0,0,0,0)
        _P01 ("c01 法线强度 child4", Vector) = (1,0,0,0)
        _P02 ("c02 材质Z child10 材质Y child11", Vector) = (0,0,0.4,0.35)
        _P03 ("c03 双面 AO wrapNM 自发光", Vector) = (0,0.51,0.72,0.2)
        _P04 ("c04 粗糙度范围 child17-18", Vector) = (0,0.655,0.655,0)
        _P05 ("c05 wrap 强度与幂", Vector) = (0,0,1,0)
        _P06 ("c06 距离衰减 粗糙度分支", Vector) = (0,0,0,0)
        _P07 ("c07 捕获局部参数", Vector) = (0,0,0,0)
        _P08 ("c08 AO smoothstep", Vector) = (0,0.01,0,0.01)
        _P09 ("c09 child36", Vector) = (0,0,0,0)
        _P10 ("c10 child37", Vector) = (0,0,0,0)
        _P11 ("c11 child38", Vector) = (0,0,0,0)
        _P12 ("c12 child39", Vector) = (0,0,0,0)
        _P13 ("c13 child40", Vector) = (0,0,0,0)
        _SunDir ("uniforms32 child0 太阳方向", Vector) = (0,-0.5735764,-0.819152,0)
        _EID215544MipBias ("uniforms19 全局纹理 Mip Bias", Float) = -1
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry+10" }
        Pass
        {
            Name "VS215543_PS215544_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Off
            ZWrite Off
            ZTest Equal
            Blend Off
            Stencil { Ref 33 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID215543Vertex
            #pragma fragment EID215544Fragment
            #include "EID215543215544GBuffer.hlsl"
            ENDHLSL
        }
    }
}
