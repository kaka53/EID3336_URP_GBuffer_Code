Shader "EID/URP/VS215845_PS215846_GBuffer"
{
    Properties
    {
        [NoScaleOffset] _Res26 ("基础颜色贴图（RenderDoc PS资源26）", 2D) = "white" {}
        [NoScaleOffset] _Res28 ("法线与材质遮罩（RenderDoc PS资源28）", 2D) = "white" {}
        _P00 ("c00 child0-3", Vector) = (0,0,0,0)
        _P01 ("c01 法线强度 child4", Vector) = (1,0,0,0)
        _P02 ("c02 材质Z child10 材质W child11", Vector) = (0,0,0.597,0.162)
        _P03 ("c03 双面 AO wrapNM 自发光", Vector) = (0,1,0,0.2)
        _P04 ("c04 粗糙度范围 child17-18", Vector) = (0,0.742,0.742,0)
        _P05 ("c05 wrap 强度与幂 / 基础色替换", Vector) = (0,0,1,0)
        _P06 ("c06 基础色倍率 距离衰减 粗糙度分支", Vector) = (1,0,0,0)
        _P07 ("c07 捕获局部参数", Vector) = (0,0,0,0)
        _P08 ("c08 AO smoothstep", Vector) = (0,0.01,0,0.01)
        _P09 ("c09 child36 基础色乘色", Vector) = (0.817422,0.817422,0.817422,1)
        _P10 ("c10 child37", Vector) = (0,0,0,0)
        _P11 ("c11 child38", Vector) = (0,0,0,0)
        _P12 ("c12 child39", Vector) = (0,0,0,0)
        _P13 ("c13 child40", Vector) = (0,0,0,0)
        _P14 ("c14 球遮挡混合 child41-44", Vector) = (0.525,0.25,0,0)
        _P15 ("c15 球0 child45", Vector) = (0,-1.103,0,1.15)
        _P16 ("c16 球1 child46", Vector) = (0,0,0,0)
        _P17 ("c17 球2 child47", Vector) = (0,0,0,0)
        _P18 ("c18 球3 child48", Vector) = (0,0,0,0)
        _P19 ("c19 child49", Vector) = (0,0,0,0)
        _P20 ("c20 child50", Vector) = (0,0,0,0)
        _P21 ("c21 child51", Vector) = (0,0,0,0)
        _P22 ("c22 child52", Vector) = (0,0,0,0)
        _StencilRef ("Stencil Ref", Float) = 33
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" "DisableBatching"="True" }
        Pass
        {
            Name "VS215845_PS215846_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Off
            ZWrite On
            ZTest Equal
            Blend Off
            Stencil { Ref [_StencilRef] Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID215845Vertex
            #pragma fragment EID215846Fragment
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "EID215845VegetationVS.hlsl"
            #include "EID215845VegetationPS.hlsl"
            EID215845VertexVaryings EID215845Vertex(EID215845VertexInput i)
            {
                return EID215845VertexMain(i);
            }
            EID215845GBufferOutput EID215846Fragment(EID215845FragmentVaryings i, bool frontFace : SV_IsFrontFace)
            {
                return EID215845FragmentMain(i, frontFace);
            }
            ENDHLSL
        }
    }
}
