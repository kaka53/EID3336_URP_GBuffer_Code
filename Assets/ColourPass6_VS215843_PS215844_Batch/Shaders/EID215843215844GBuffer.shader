Shader "EID/URP/VS215843_PS215844_GBuffer"
{
    Properties
    {
        [NoScaleOffset] _Res25 ("基础颜色贴图（RenderDoc PS资源25）", 2D) = "white" {}
        [NoScaleOffset] _Res27 ("法线与材质遮罩（RenderDoc PS资源27）", 2D) = "white" {}
        _P00 ("c00 child0-3", Vector) = (0,0,0,0)
        _P01 ("c01 法线强度 child4", Vector) = (1,0,0,0)
        _P02 ("c02 packedClass child10 extraMask child11", Vector) = (0,0,0.386,0.205)
        _P03 ("c03 双面 AO wrapNM extraPacked", Vector) = (0,1,0,0.2)
        _P04 ("c04 粗糙度范围 child17-18", Vector) = (0,0,1,0)
        _P05 ("c05 wrap 强度与幂 / 基础色替换", Vector) = (0,0,1,0)
        _P06 ("c06 基础色倍率 距离衰减 粗糙度分支", Vector) = (1,0,0,0)
        _P07 ("c07 捕获局部参数", Vector) = (0,0,0,0)
        _P08 ("c08 AO smoothstep", Vector) = (0,0.01,0,0.01)
        _P09 ("c09 child36 基础色乘色", Vector) = (1,1,1,1)
        _P10 ("c10 child37", Vector) = (0,0,0,0)
        _P11 ("c11 child38", Vector) = (0,0,0,0)
        _P12 ("c12 child39", Vector) = (0,0,0,0)
        _P13 ("c13 child40", Vector) = (0,0,0,0)
        _StencilRef ("Stencil Ref", Float) = 33
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" "DisableBatching"="True" }
        Pass
        {
            Name "VS215843_PS215844_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Off
            ZWrite On
            ZTest Equal
            Blend Off
            Stencil { Ref [_StencilRef] Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID215843Vertex
            #pragma fragment EID215844Fragment
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "EID215843VegetationVS.hlsl"
            #include "EID215844VegetationPS.hlsl"
            EID215843VertexVaryings EID215843Vertex(EID215843VertexInput i)
            {
                return EID215843VertexMain(i);
            }
            EID215843GBufferOutput EID215844Fragment(EID215843FragmentVaryings i, bool frontFace : SV_IsFrontFace)
            {
                return EID215843FragmentMain(i, frontFace);
            }
            ENDHLSL
        }
    }
}
