Shader "EID/URP/VS215439_PS215440_GBuffer"
{
    Properties
    {
        [Header(RenderDoc_Unique_Textures)]
        _Res24 ("res24 基础颜色 Binding1", 2D) = "white" {}
        [NoScaleOffset] FS4817_49 ("FS4817_49 LUT rid195216", 2D) = "white" {}
        [NoScaleOffset] FS4817_51 ("FS4817_51 albedo = _Res24", 2D) = "white" {}
        [NoScaleOffset] FS4817_52 ("FS4817_52 rid269336", 2D) = "white" {}
        [Header(RenderDoc_PS_uniforms23_18xfloat4)]
        _P00 ("c00 捕获局部参数", Vector) = (0,0,0,0)
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
        _InstancePacked ("uniforms18 child2 10/10/10/2", Vector) = (0,0,0,0)
        _EID215440MipBias ("uniforms15 全局纹理 Mip Bias", Float) = 0
        _UseBakedSkinning ("Captured ssbo25 skin baked into VSInput", Float) = 0
        _StencilRef ("Captured stencil reference", Float) = 52
        [Header(Wave1_FS_47_48_EID4817)]
        _FS49_00 ("FS_48 c00", Vector) = (0,0,0,0)
        _FS49_01 ("FS_48 c01", Vector) = (0,0,0,0)
        _FS49_02 ("FS_48 c02", Vector) = (0,0,0,0)
        _FS49_03 ("FS_48 c03", Vector) = (0,1,1,1)
        _FS49_04 ("FS_48 c04", Vector) = (0.35,4,0.55,1.4)
        _FS49_05 ("FS_48 c05", Vector) = (0,0,0,0)
        _FS49_06 ("FS_48 c06 albedo mul", Vector) = (1,1,1,1)
        _FS49_07 ("FS_48 c07", Vector) = (0,0,0,0)
        _FS49_08 ("FS_48 c08", Vector) = (1,1,1,0)
        _FS49_09 ("FS_48 c09", Vector) = (1,1,1,1)
        _FS49_10 ("FS_48 c10 UVST = VS_33_m28", Vector) = (1,1,0,0)
        _FS49_11 ("FS_48 c11", Vector) = (0,0,0,0)
        _FS49_12 ("FS_48 c12", Vector) = (0,0.03,0,0)
        _FS49_13 ("FS_48 c13", Vector) = (0,0,0,0)
        _FS49_14 ("FS_48 c14 m35", Vector) = (0,0,0,0)
        _FS49_15 ("FS_48 c15 m36", Vector) = (1.641526,1.767054,1.844303,1)
        _FS49_16 ("FS_48 c16 m37", Vector) = (2.240114,1.534478,1.738328,1)
        _FS49_17 ("FS_48 c17 m38-m41", Vector) = (0,0.9,0,0)
        _FS49_18 ("FS_48 c18 m42", Vector) = (0.239480,0.359814,0.818868,0.698039)
        _FS49_19 ("FS_48 c19 m43", Vector) = (1,1,0,0)
        _FS49_20 ("FS_48 c20 m44", Vector) = (0,0,0,0)
        _FS49_21 ("FS_48 c21 m45", Vector) = (0,0,0,1)
        _FS49_22 ("FS_48 c22 m46", Vector) = (0,1,0,0)
        _FS49_23 ("FS_48 c23 m47-m50", Vector) = (0,0,0,0)
        _FS49_24 ("FS_48 c24 m51-m54", Vector) = (0,0,0,0)
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Pass
        {
            Name "VS215439_PS215440_UniversalGBuffer"
            Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
            Cull Off
            ZWrite On
            ZTest LEqual
            Blend Off
            Stencil { Ref [_StencilRef] Comp Always Pass Replace ReadMask 255 WriteMask 255 }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID215439Vertex
            #pragma fragment EID215440Fragment
            #include "EID215439215440GBuffer.hlsl"
            ENDHLSL
        }
        Pass
        {
            Name "VS215979_PS215980_EID4673CharacterForward"
            Tags { "LightMode"="EID4673CharacterForwardOff" }
            Cull Back
            ZWrite On
            ZTest Equal
            Blend Off
            ColorMask RGB
            HLSLPROGRAM
            #pragma target 5.0
            #pragma exclude_renderers gles gles3 glcore
            #pragma vertex EID215439Vertex
            #pragma fragment EID215980Fragment
            #include "EID215439215440GBuffer.hlsl"
            // isolate EID4730: this family LightMode off
            ENDHLSL
        }
        Pass
        {
            Name "VS215993_PS215994_EID4730CharacterForward"
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
            #include "EID4817/Replay4817.hlsl"
            ENDHLSL
        }
    }
}
