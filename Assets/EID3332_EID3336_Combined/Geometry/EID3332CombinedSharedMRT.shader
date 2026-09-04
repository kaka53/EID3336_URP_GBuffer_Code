Shader "Reconstructed/EID3332+EID3336 Shared Scene Material Five MRT"
{
    Properties
    {
        [NoScaleOffset] _33 ("Set1 B9 Base Color - RID271247", 2D) = "white" {}
        [NoScaleOffset] _35 ("Set1 B2 Base Normal - RID222331", 2D) = "bump" {}
        [NoScaleOffset] _37 ("Set1 B3 Layer Control - RID224843", 2D) = "black" {}
        [NoScaleOffset] _38 ("Set1 B7 Detail/Blend Normal - RID197602", 2D) = "bump" {}
        [NoScaleOffset] _39 ("Set1 B4 Grass Blend Mask - RID246832", 2D) = "black" {}
        [NoScaleOffset] _40 ("Set1 B8 Fallback - RID204", 2D) = "white" {}
        [NoScaleOffset] _41 ("Set1 B6 Secondary/Grass Color - RID197598", 2D) = "white" {}
        [NoScaleOffset] _42 ("Set1 B5 Secondary Mask/Normal - RID198094", 2D) = "bump" {}
        [NoScaleOffset] _53 ("Set0 B29 - RID198259", 2D) = "black" {}
        [NoScaleOffset] _54 ("Set0 B32 - RID198278", 2D) = "black" {}
        [NoScaleOffset] _55 ("Set0 B11 - RID198267", 2D) = "black" {}
        [NoScaleOffset] _56 ("Set0 B21 - RID198263", 2D) = "black" {}
        [NoScaleOffset] _57 ("Set0 B31 - RID198284", 2D) = "black" {}
        [NoScaleOffset] _58 ("Set0 B23 Albedo Array - RID198300", 2DArray) = "" {}
        [NoScaleOffset] _59 ("Set0 B28 Normal/Material Array - RID198309", 2DArray) = "" {}
        [NoScaleOffset] _60 ("Set0 B22 Screen Depth - RID209602", 2D) = "black" {}
        [NoScaleOffset] _61 ("Set0 B30 - RID209085", 2D) = "black" {}
        [NoScaleOffset] _62 ("Set0 B27 - RID209115", 2D) = "black" {}
        [NoScaleOffset] _63 ("Set0 B26 - RID209112", 2D) = "bump" {}
        [NoScaleOffset] _64 ("Set0 B25 - RID209109", 2D) = "bump" {}
        [NoScaleOffset] _65 ("Set0 B24 - RID209106", 2D) = "black" {}
        [NoScaleOffset] _EID3336VisibilityMask ("RenderDoc EID3336 visibility mask", 2D) = "black" {}
        [Toggle] _EID3336UseVisibilityMask ("Use Captured Visibility Mask", Float) = 0
        [Toggle] _EID3336SceneModelDataInWorldSpace ("Scene Model Data Is World Space", Float) = 0
        [Toggle] _EID3332CombinedEnableVirtualTextureBranch ("Enable Profile Virtual Texture Branch", Float) = 1
        [Toggle] _EID3332CombinedFlipMaterialUVY ("Flip Profile Material UV Y", Float) = 0
        [Enum(RT0,0,RT1,1,RT2,2,RT3,3,RT4,4)] _EID3336ScenePreviewTarget ("Scene Preview MRT", Float) = 4
    }

    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }

        Pass
        {
            Name "EID3332Combined_FiveMRT"
            Tags { "LightMode"="EID3336SceneFiveMRT" }
            Cull Back
            ZTest LEqual
            ZWrite On
            Blend Off
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID3336SceneFiveMRTVertex
            #pragma fragment EID3336SceneFiveMRTFragment
            #pragma multi_compile_instancing
            #include "EID3332CombinedSharedMRT.hlsl"
            ENDHLSL
        }

        Pass
        {
            Name "EID3332Combined_FiveMRTProcedural"
            Tags { "LightMode"="EID3336SceneFiveMRTProcedural" }
            Cull Back
            ZTest LEqual
            ZWrite On
            Blend Off
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID3336SceneFiveMRTVertexProcedural
            #pragma fragment EID3336SceneFiveMRTFragment
            #pragma multi_compile_instancing
            #include "EID3332CombinedSharedMRT.hlsl"
            ENDHLSL
        }

        Pass
        {
            Name "EID3332Combined_FiveMRTCurrentCameraProcedural"
            Tags { "LightMode"="EID3336SceneFiveMRTCurrentCameraProcedural" }
            Cull Back
            ZTest LEqual
            ZWrite On
            Blend Off
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID3336ScenePreviewVertexProcedural
            #pragma fragment EID3336SceneFiveMRTCurrentCameraFragment
            #pragma multi_compile_instancing
            #include "EID3332CombinedSharedMRT.hlsl"
            ENDHLSL
        }

        Pass
        {
            Name "EID3332Combined_FiveMRTCurrentCamera"
            Tags { "LightMode"="EID3336SceneFiveMRTCurrentCamera" }
            Cull Back
            ZTest LEqual
            ZWrite On
            Blend Off
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID3336ScenePreviewVertex
            #pragma fragment EID3336SceneFiveMRTCurrentCameraFragment
            #pragma multi_compile_instancing
            #include "EID3332CombinedSharedMRT.hlsl"
            ENDHLSL
        }

        Pass
        {
            Name "EID3332Combined_PreviewProcedural"
            Tags { "LightMode"="EID3336ScenePreviewProcedural" }
            Cull Back
            ZTest LEqual
            ZWrite On
            Blend Off
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID3336ScenePreviewVertexProcedural
            #pragma fragment EID3336ScenePreviewFragment
            #pragma multi_compile_instancing
            #include "EID3332CombinedSharedMRT.hlsl"
            ENDHLSL
        }

        Pass
        {
            Name "EID3332Combined_Preview"
            Tags { "LightMode"="UniversalForward" }
            Cull Back
            ZTest LEqual
            ZWrite On
            Blend Off
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID3336ScenePreviewVertex
            #pragma fragment EID3336ScenePreviewFragment
            #pragma multi_compile_instancing
            #include "EID3332CombinedSharedMRT.hlsl"
            ENDHLSL
        }
    }
}
