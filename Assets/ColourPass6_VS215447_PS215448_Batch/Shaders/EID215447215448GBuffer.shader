Shader "EID/URP/VS215447_PS215448_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res25 ("res25 基础颜色 Binding2", 2D) = "white" {}
        _Res26 ("res26 切线法线 Binding1", 2D) = "bump" {}
        [NoScaleOffset] FS_56 ("FS_56 albedo = _Res25", 2D) = "white" {}
        [NoScaleOffset] FS_57 ("FS_57 packed = Wave1 packed", 2D) = "white" {}
        [NoScaleOffset] FS_58 ("FS_58 tangent N = _Res26", 2D) = "bump" {}
        [Header(RenderDoc_PS_uniforms24_18xfloat4)]
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
        _P12 ("c12 捕获局部参数", Vector) = (0,0,0,0)
        _P13 ("c13 捕获局部参数", Vector) = (0,0,0,0)
        _P14 ("c14 捕获局部参数", Vector) = (0,0,0,0)
        _P15 ("c15 捕获局部参数", Vector) = (0,0,0,0)
        _P16 ("c16 捕获局部参数", Vector) = (0,0,0,0)
        _P17 ("c17 捕获局部参数", Vector) = (0,0,0,0)
        [Header(Wave1_FS_48_49)]
        _FS49_00 ("FS_49 c00", Vector) = (0,0,0,1)
        _FS49_01 ("FS_49 c01", Vector) = (0,0,0,0)
        _FS49_02 ("FS_49 c02", Vector) = (0,0,0,0)
        _FS49_03 ("FS_49 c03", Vector) = (0,1,1,1)
        _FS49_04 ("FS_49 c04 specScale.z specSat.w", Vector) = (0.35,4,0.5,1)
        _FS49_05 ("FS_49 c05", Vector) = (0,0,0,0)
        _FS49_06 ("FS_49 c06 albedo mul", Vector) = (1,1,1,1)
        _FS49_07 ("FS_49 c07", Vector) = (0,0,0,0)
        _FS49_08 ("FS_49 c08", Vector) = (1,1,1,0)
        _FS49_09 ("FS_49 c09", Vector) = (1,1,1,1)
        _FS49_10 ("FS_49 c10 UVST = VS_33_m28", Vector) = (1,1,0,0)
        _FS49_11 ("FS_49 c11", Vector) = (0,0,0,0)
        _FS49_12 ("FS_49 c12", Vector) = (0,0,0,0)
        _FS49_13 ("FS_49 c13", Vector) = (0,0,0,0)
        _FS49_14 ("FS_49 c14", Vector) = (0,0,0,0)
        _FS49_15 ("FS_49 c15", Vector) = (1,1,0,0)
        _FS49_16 ("FS_49 c16", Vector) = (0,0,0,0)
        _FS49_17 ("FS_49 c17", Vector) = (0,0,0,1)
        _FS49_18 ("FS_49 c18", Vector) = (0,1,0,0)
        _FS49_19 ("FS_49 c19", Vector) = (0,0,0,0)
        _FS49_20 ("FS_49 c20", Vector) = (0,0,0,0)
        _InstancePacked ("uniforms19 child2 10/10/10/2", Vector) = (0,0,0,0)
        _EID215444MipBias ("uniforms16 全局纹理 Mip Bias", Float) = 0
        _UseBakedSkinning ("Captured ssbo27 skin baked into VSInput", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "VS215447_PS215448_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Off
            ZWrite On
            ZTest LEqual
            Blend Off
            Stencil { Ref 36 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID215447Vertex
            #pragma fragment EID215448Fragment
            #include "EID215447215448GBuffer.hlsl"
            ENDHLSL
        }
        Pass
        {
            Name "VS215447_PS215448_EID4730CharacterForward"
            Tags { "LightMode"="EID4730CharacterForward" }
            Cull Back
            ZWrite On
            ZTest LEqual
            Blend Off
            ColorMask RGB
            HLSLPROGRAM
            #pragma target 5.0
            #pragma only_renderers d3d11 vulkan
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EIDLiveVertex
            #pragma fragment EIDLiveFragment
            #define EID_LIVE_MVP 1
            #define EID_LIVE_PER_MATERIAL 1
            #include "../../EID4730/Shaders/Replay.hlsl"
            ENDHLSL
        }
    }
}
