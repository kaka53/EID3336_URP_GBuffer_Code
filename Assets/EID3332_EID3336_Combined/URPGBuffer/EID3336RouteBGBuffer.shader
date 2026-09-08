Shader "EID3336/URP/RenderDocGBufferMesh"
{
    Properties
    {
        [Header(Profile Textures)]
        [NoScaleOffset] _33 ("Set1 B9 Base Color", 2D) = "white" {}
        [NoScaleOffset] _35 ("Set1 B2 Base Normal", 2D) = "bump" {}
        [NoScaleOffset] _37 ("Set1 B3 Layer Control", 2D) = "black" {}
        [NoScaleOffset] _38 ("Set1 B7 Detail Blend Normal", 2D) = "bump" {}
        [NoScaleOffset] _39 ("Set1 B4 Grass Blend Mask", 2D) = "black" {}
        [NoScaleOffset] _40 ("Set1 B8 Fallback", 2D) = "white" {}
        [NoScaleOffset] _41 ("Set1 B6 Secondary Grass Color", 2D) = "white" {}
        [NoScaleOffset] _42 ("Set1 B5 Secondary Mask Normal", 2D) = "bump" {}
        [NoScaleOffset] _53 ("Set0 B29", 2D) = "black" {}
        [NoScaleOffset] _54 ("Set0 B32", 2D) = "black" {}
        [NoScaleOffset] _55 ("Set0 B11", 2D) = "black" {}
        [NoScaleOffset] _56 ("Set0 B21", 2D) = "black" {}
        [NoScaleOffset] _57 ("Set0 B31", 2D) = "black" {}
        [NoScaleOffset] _58 ("Set0 B23 Albedo Array", 2DArray) = "" {}
        [NoScaleOffset] _59 ("Set0 B28 Normal Material Array", 2DArray) = "" {}
        [NoScaleOffset] _60 ("Set0 B22 Screen Depth", 2D) = "black" {}
        [NoScaleOffset] _61 ("Set0 B30", 2D) = "black" {}
        [NoScaleOffset] _62 ("Set0 B27", 2D) = "black" {}
        [NoScaleOffset] _63 ("Set0 B26", 2D) = "bump" {}
        [NoScaleOffset] _64 ("Set0 B25", 2D) = "bump" {}
        [NoScaleOffset] _65 ("Set0 B24", 2D) = "black" {}
        [NoScaleOffset] _EID3336VisibilityMask ("Captured Visibility Mask", 2D) = "black" {}

        [Header(Profile Switches)]
        [Toggle] _EID3336UseVisibilityMask ("Use Captured Visibility Mask", Float) = 0
        [Toggle] _EID3336VisibilityFlipY ("Visibility UV Flip Y", Float) = 0
        [Toggle] _EID3336SceneModelDataInWorldSpace ("Vertex Data Is World Space", Float) = 0
        [Toggle] _EID3332CombinedEnableVirtualTextureBranch ("Enable Virtual Texture Branch", Float) = 0
        [Toggle] _EID3332CombinedFlipMaterialUVY ("Material UV Flip Y", Float) = 0

        [Range(0,2)] _EIDRouteBMetallicScale ("Metallic Scale", Float) = 1
        [Range(0,2)] _EIDRouteBRoughnessScale ("Roughness Scale", Float) = 1
        [Range(0,2)] _EIDRouteBOcclusionScale ("Occlusion Scale", Float) = 1
        [Range(0,2)] _EIDRouteBNormalStrength ("Normal Strength", Float) = 1

        [Header(Render State)]
        [Enum(UnityEngine.Rendering.CullMode)] _EIDRouteBCull ("Cull", Float) = 0

        [Header(Pipeline Supplied Read Only)]
        [HideInInspector] _EID3336InstanceIndex ("Instance Index", Int) = 0
        [HideInInspector] _EID3336RouteBUseObjectTransform ("Use Object Transform", Float) = 1
        [HideInInspector] _EID3336RawStream1StrideBytes ("Raw Stream1 Stride", Float) = 16
    }

    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "EID3336_RenderDoc_URP_UniversalGBuffer_Mesh"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull [_EIDRouteBCull]
            ZTest LEqual
            ZWrite On
            Blend Off
            Stencil
            {
                Ref 32
                Comp Always
                Pass Replace
                ReadMask 96
                WriteMask 96
            }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID3336RouteBVertex
            #pragma fragment EID3336RouteBFragment
            #pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT
            #include "EID3336RouteBGBuffer.hlsl"
            ENDHLSL
        }
    }
}
