Shader "EID/URP/VS229351_PS229352_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res25 ("res25 基础颜色 Binding4", 2D) = "white" {}
        _Res27 ("res27 extra/normal Binding3", 2D) = "bump" {}
        _Res31 ("res31 VS wind noise Binding0", 2D) = "gray" {}
        [Header(RenderDoc_PS_uniforms30_352B)]
        _P00 ("c00 child0-3", Vector) = (0,0,0,0)
        _P01 ("c01 法线强度 child4 / 双面 child6", Vector) = (1,0,0,0)
        _P02 ("c02 loc3 AO/wrap child8-9 extraMask child10 粗糙度A child11", Vector) = (0.51,0.72,0.35,0)
        _P03 ("c03 粗糙度B child12", Vector) = (1,0,0,0)
        _P04 ("c04 materialY child16 距离衰减 child18 extraPacked child19", Vector) = (0.4,0,0,0.2)
        _P05 ("c05 wrap child20-21 几何法线 child22 混色 child23", Vector) = (0,1,1,0)
        _P06 ("c06 色倍率 child24 wrap packing child25 风 child26", Vector) = (1.25,0.187,0,0)
        _P07 ("c07 AO smoothstep child28-31", Vector) = (0,0,0,0.01)
        _P08 ("c08 AO smoothstep child32-35", Vector) = (0,0.01,0,0)
        _P09 ("c09 捕获局部参数", Vector) = (0,0,0,0)
        _P10 ("c10 捕获局部参数", Vector) = (0,0,0,0)
        _P11 ("c11 捕获局部参数", Vector) = (0,0,0,0)
        _P12 ("c12 捕获局部参数", Vector) = (0,0,0,0)
        _P13 ("c13 捕获局部参数", Vector) = (0,0,0,0)
        _P14 ("c14 捕获局部参数", Vector) = (0,0,0,0)
        _P15 ("c15 基础颜色乘色 child48", Vector) = (1,1,1,1)
        _P16 ("c16 extra-tint child49-52", Vector) = (-0.055,0.3,0,0)
        _P17 ("c17 extra albedo child53", Vector) = (1,1,1,1)
        _P18 ("c18 wind child54-57", Vector) = (1.5,4,0.4,0.5)
        _P19 ("c19 wind child58-61 extraPhase", Vector) = (0,0,15,0)
        _P20 ("c20 wind child62-65", Vector) = (0,1,1.5,5)
        _P21 ("c21 wind child66-69 mixTerrain", Vector) = (0.5,0,0.15,0)
        _SunDir ("uniforms24 child53 太阳方向", Vector) = (0,-0.57,-0.82,0)
        _WindA ("uniforms24 child25 当前风", Vector) = (1.5,16.58,0,1)
        _WindB ("uniforms24 child37 上一帧风", Vector) = (1.5,16.58,0,1)
        _WindGate ("uniforms24 child36.x 风开关", Float) = 1
        _PrevBlend ("uniforms20 child4", Float) = 0
        _EID229352MipBias ("uniforms19 全局纹理 Mip Bias", Float) = -1
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry+10" }
        Pass
        {
            Name "VS229351_PS229352_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Off
            ZWrite Off
            ZTest Equal
            Blend Off
            Stencil { Ref 33 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID229351Vertex
            #pragma fragment EID229352Fragment
            #include "EID229351229352GBuffer.hlsl"
            ENDHLSL
        }
    }
}
