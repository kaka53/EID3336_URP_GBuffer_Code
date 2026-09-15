Shader "EID/URP/VS215847_PS215848_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        [NoScaleOffset] _Res25 ("res25 基础颜色 Binding4", 2D) = "white" {}
        [NoScaleOffset] _Res27 ("res27 extra/normal Binding3", 2D) = "bump" {}
        [NoScaleOffset] _Res32 ("res32 VS terrain Binding3", 2D) = "gray" {}
        [NoScaleOffset] _Res33 ("res33 VS terrain Binding1", 2D) = "gray" {}
        [NoScaleOffset] _Res34 ("res34 VS wind noise Binding0", 2D) = "gray" {}
        [Header(RenderDoc_PS_uniforms30_352B)]
        _P00 ("c00 child0-3", Vector) = (0,0,0,0)
        _P01 ("c01 法线强度 child4 / 双面 child6", Vector) = (0.9,0,0,0)
        _P02 ("c02 loc3 AO/wrap child8-9 extraMask child10 粗糙度A child11", Vector) = (1,0,0.162,0.198)
        _P03 ("c03 粗糙度B child12", Vector) = (1,0,0,0)
        _P04 ("c04 materialY child16 距离衰减 child18 extraPacked child19", Vector) = (0.597,0,0,0.2)
        _P05 ("c05 wrap child20-21 几何法线 child22 混色 child23", Vector) = (0,1,1,0)
        _P06 ("c06 色倍率 child24 wrap packing child25 风 child26", Vector) = (1,0,1,0)
        _P07 ("c07 AO smoothstep child28-31", Vector) = (0,0,0,0.01)
        _P08 ("c08 AO smoothstep child32-35", Vector) = (0,0.01,0,0)
        _P09 ("c09 捕获局部参数", Vector) = (0,0,0,0)
        _P10 ("c10 捕获局部参数", Vector) = (0,0,0,0)
        _P11 ("c11 捕获局部参数", Vector) = (0,0,0,0)
        _P12 ("c12 捕获局部参数", Vector) = (0,0,0,0)
        _P13 ("c13 捕获局部参数", Vector) = (0,0,0,0)
        _P14 ("c14 捕获局部参数", Vector) = (0,0,0,0)
        _P15 ("c15 基础颜色乘色 child48", Vector) = (0.817422,0.817422,0.817422,1)
        _P16 ("c16 wind child49-52", Vector) = (2,5,0.1,0)
        _P17 ("c17 wind child53-56", Vector) = (0,0.3,12,1)
        _P18 ("c18 wind child57-60", Vector) = (0.2,3,0.6,4)
        _P19 ("c19 wind child61-64", Vector) = (0.8,0,0.2,0)
        _P20 ("c20 terrain/wind child65-68", Vector) = (1,0.15,7.5,0.05)
        _P21 ("c21 terrain child69-72", Vector) = (5,0,0,0)
        _SunDir ("uniforms24 child53 太阳方向", Vector) = (0,-0.5735764,-0.819152,0)
        _WindA ("uniforms24 child25 当前风", Vector) = (1.5,16.57733,0,1)
        _WindB ("uniforms24 child37 上一帧风", Vector) = (1.5,16.575329,0,1)
        _WindGate ("uniforms24 child36.x 风开关", Float) = 1
        _TerrainOrigin32 ("uniforms24 child41", Vector) = (-556.875,105.733459,-412.25,0)
        _TerrainOrigin33 ("uniforms24 child42", Vector) = (-556.875,105.733459,-412.25,0)
        _TerrainPad ("uniforms24 child31", Vector) = (1.8,0,0,0)
        _PrevBlend ("uniforms20 child4", Float) = 0
        _EID215848MipBias ("uniforms19 全局纹理 Mip Bias", Float) = -1
        _StencilRef ("Stencil Ref", Float) = 33
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" "DisableBatching"="True" }
        Pass
        {
            Name "VS215847_PS215848_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Off
            ZWrite On
            ZTest Equal
            Blend Off
            Stencil { Ref [_StencilRef] Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID215847Vertex
            #pragma fragment EID215848Fragment
            #include "EID215847215848GBuffer.hlsl"
            ENDHLSL
        }
    }
}
