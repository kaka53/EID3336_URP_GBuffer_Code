Shader "EID/URP/EID1672_Verified"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res28 ("res28 基础颜色 Binding2", 2D) = "white" {}
        _Res29 ("res29 切线法线 Binding1", 2D) = "bump" {}
        [NoScaleOffset] FS_58 ("FS_58 albedo = _Res28", 2D) = "white" {}
        [NoScaleOffset] FS_59 ("FS_59 tangent N = _Res29", 2D) = "bump" {}
        [NoScaleOffset] FS4765_50 ("FS4765_50 LUT rid191314", 2D) = "white" {}
        [NoScaleOffset] FS4765_51 ("FS4765_51 rid269338", 2D) = "white" {}
        [NoScaleOffset] FS4765_52 ("FS4765_52 rid240388", 2D) = "white" {}
        [NoScaleOffset] FS4765_53 ("FS4765_53 packed Wave1 set1 bind1", 2D) = "white" {}
        [NoScaleOffset] FS4765_54 ("FS4765_54 rid269683", 2D) = "white" {}
        [NoScaleOffset] FS4765_55 ("FS4765_55 rid269685", 2D) = "white" {}
        [NoScaleOffset] FS4765_60 ("FS4765_60 rid191357", 2D) = "white" {}
        [NoScaleOffset] FS4765_61 ("FS4765_61 rid262417", 2D) = "white" {}
        [Header(RenderDoc_PS_uniforms27_20xfloat4)]
        _P00 ("c00 child0-3 法线强度在 w", Vector) = (0,0,0,1)
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
        [Header(Wave1_FS_48_49_EID4765)]
        _FS49_00 ("FS_49 c00", Vector) = (1,0,0,1)
        _FS49_01 ("FS_49 c01", Vector) = (0,0,0,0)
        _FS49_02 ("FS_49 c02", Vector) = (0,0,0,0)
        _FS49_03 ("FS_49 c03", Vector) = (0,1,1,1)
        _FS49_04 ("FS_49 c04 specScale", Vector) = (0.35,4,0,0)
        _FS49_05 ("FS_49 c05", Vector) = (0,0,0,0)
        _FS49_06 ("FS_49 c06 albedo mul", Vector) = (1,1,1,1)
        _FS49_07 ("FS_49 c07", Vector) = (0,0,0,0)
        _FS49_08 ("FS_49 c08", Vector) = (1,1,1,0)
        _FS49_09 ("FS_49 c09", Vector) = (1,1,1,1)
        _FS49_10 ("FS_49 c10 UVST = VS_33_m28", Vector) = (1,1,0,0)
        _FS49_11 ("FS_49 c11", Vector) = (0,0,0,0)
        _FS49_12 ("FS_49 c12", Vector) = (1,1,0,0)
        _FS49_13 ("FS_49 c13 wrap mul", Vector) = (0.381326,0.130136,0.144128,1)
        _FS49_14 ("FS_49 c14 m35-m38", Vector) = (0,0,0,0)
        _FS49_15 ("FS_49 c15 m39", Vector) = (0,0,0,0)
        _FS49_16 ("FS_49 c16 m40", Vector) = (0,0,0,0)
        _FS49_17 ("FS_49 c17 m41", Vector) = (0.03,0,0,0)
        _FS49_18 ("FS_49 c18 m42", Vector) = (1,1,0,0)
        _FS49_19 ("FS_49 c19 m43", Vector) = (0,0,0,0)
        _FS49_20 ("FS_49 c20 m44", Vector) = (0,0,0,1)
        _FS49_21 ("FS_49 c21 m45", Vector) = (0,1,0,0)
        _FS49_22 ("FS_49 c22 m46-m49", Vector) = (0,0,0,0)
        _FS49_23 ("FS_49 c23 m50-m53", Vector) = (0,0,0,0)
        _InstancePacked ("uniforms22 child2 10/10/10/2", Vector) = (0,0,0,0)
        _EID215444MipBias ("uniforms19 全局纹理 Mip Bias", Float) = 0
        _UseBakedSkinning ("Captured ssbo27 skin baked into VSInput", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "VS215441_PS215442_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Back
            ZWrite On
            ZTest LEqual
            Blend Off
            Stencil { Ref 36 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID215441Vertex
            #pragma fragment EID215442Fragment
            #include "EID1672GBuffer.hlsl"
            ENDHLSL
        }
        Pass
        {
            Name "VS215999_PS216000_EID4730CharacterForward"
            Tags { "LightMode"="EID4730CharacterForward" }
            Cull Back
            ZWrite On
            ZTest Equal
            Blend Off
            ColorMask RGB 0
            ColorMask RGBA 1
            HLSLPROGRAM
            #pragma target 5.0
            #pragma only_renderers d3d11 vulkan
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EIDLiveVertex
            #pragma fragment EIDLiveFragment
            #define EID_LIVE_MVP 1
            #define EID_LIVE_PER_MATERIAL 1
            #include "EID1672Forward.hlsl"
            ENDHLSL
        }
    }
}
