Shader "EID/URP/EID4725_RenderDoc" {
 Properties {         [Header(RenderDoc_Unique_Textures)]
        _EID4725_GBuffer_Res27 ("res27 基础颜色 Binding1", 2D) = "white" {}
        [Header(RenderDoc_PS_uniforms26_20xfloat4)]
        _EID4725_GBuffer_P00 ("c00 捕获局部参数", Vector) = (0,0,0,0)
        _EID4725_GBuffer_P01 ("c01 child4-7 双面法线在 y", Vector) = (0,1,0,0)
        _EID4725_GBuffer_P02 ("c02 捕获局部参数", Vector) = (0,0,0,0)
        _EID4725_GBuffer_P03 ("c03 捕获局部参数", Vector) = (0,0,0,0)
        _EID4725_GBuffer_P04 ("c04 捕获局部参数", Vector) = (0,0,0,0)
        _EID4725_GBuffer_P05 ("c05 捕获局部参数", Vector) = (0,0,0,0)
        _EID4725_GBuffer_P06 ("c06 child24 基础色乘色", Vector) = (1,1,1,1)
        _EID4725_GBuffer_P07 ("c07 捕获局部参数", Vector) = (0,0,0,0)
        _EID4725_GBuffer_P08 ("c08 捕获局部参数", Vector) = (0,0,0,0)
        _EID4725_GBuffer_P09 ("c09 捕获局部参数", Vector) = (0,0,0,0)
        _EID4725_GBuffer_P10 ("c10 child28 UV scale/offset", Vector) = (1,1,0,0)
        _EID4725_GBuffer_P11 ("c11 捕获局部参数", Vector) = (0,0,0,0)
        _EID4725_GBuffer_P12 ("c12 child30 wrap 在 x", Vector) = (0,0,0,0)
        _EID4725_GBuffer_P13 ("c13 child34 wrap 乘色", Vector) = (1,1,1,1)
        _EID4725_GBuffer_P14 ("c14 捕获局部参数", Vector) = (0,0,0,0)
        _EID4725_GBuffer_P15 ("c15 捕获局部参数", Vector) = (0,0,0,0)
        _EID4725_GBuffer_P16 ("c16 捕获局部参数", Vector) = (0,0,0,0)
        _EID4725_GBuffer_P17 ("c17 捕获局部参数", Vector) = (0,0,0,0)
        _EID4725_GBuffer_P18 ("c18 捕获局部参数", Vector) = (0,0,0,0)
        _EID4725_GBuffer_P19 ("c19 捕获局部参数", Vector) = (0,0,0,0)
        _EID4725_GBuffer_InstancePacked ("uniforms21 child2 10/10/10/2", Vector) = (0,0,0,0)
        _EID4725_GBuffer_EID215446MipBias ("uniforms18 全局纹理 Mip Bias", Float) = 0
  _EID4725_GBuffer_UseBakedSkinning ("Captured ssbo25 skin baked into VSInput", Float) = 0
 [NoScaleOffset] EID4725PS_40("Captured EID4725PS_40 RID209554",2D)=""{}
 [NoScaleOffset] EID4725PS_39("Captured EID4725PS_39 RID209077",2D)=""{}
 [NoScaleOffset] EID4725PS_60("Captured EID4725PS_60 RID172",2D)=""{}
 [NoScaleOffset] EID4725PS_47("Captured EID4725PS_47 RID198567",3D)=""{}
 [NoScaleOffset] EID4725PS_45("Captured EID4725PS_45 RID198561",3D)=""{}
 [NoScaleOffset] EID4725PS_43("Captured EID4725PS_43 RID198555",3D)=""{}
 [NoScaleOffset] EID4725PS_46("Captured EID4725PS_46 RID198564",3D)=""{}
 [NoScaleOffset] EID4725PS_44("Captured EID4725PS_44 RID198558",3D)=""{}
 [NoScaleOffset] EID4725PS_42("Captured EID4725PS_42 RID198552",3D)=""{}
 [NoScaleOffset] EID4725PS_65("Captured EID4725PS_65 RID209575",3D)=""{}
 [NoScaleOffset] EID4725PS_56("Captured EID4725PS_56 RID274958",2D)=""{}
 [NoScaleOffset] EID4725PS_55("Captured EID4725PS_55 RID14997",2D)=""{}
 [NoScaleOffset] EID4725PS_54("Captured EID4725PS_54 RID269685",2D)=""{}
 [NoScaleOffset] EID4725PS_53("Captured EID4725PS_53 RID269683",2D)=""{}
 [NoScaleOffset] EID4725PS_52("Captured EID4725PS_52 RID269067",2D)=""{}
 [NoScaleOffset] EID4725PS_59("Captured EID4725PS_59 RID224372",2D)=""{}
 [NoScaleOffset] EID4725PS_58("Captured EID4725PS_58 RID267650",2D)=""{}
 [NoScaleOffset] EID4725PS_51("Captured EID4725PS_51 RID240388",2D)=""{}
 [NoScaleOffset] EID4725PS_50("Captured EID4725PS_50 RID191314",2D)=""{}
 [NoScaleOffset] EID4725PS_57("Captured EID4725PS_57 RID224349",2D)=""{}
 }
 SubShader {
 Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
 Pass {
 Name "EID4725 CharacterForward"
 Tags { "LightMode"="EID4725CharacterForward" }
 Cull Back ZTest Equal ZWrite On Blend Off
 HLSLPROGRAM
 #pragma target 5.0
 #pragma only_renderers d3d11 vulkan
 #pragma vertex EID4725Vertex
 #pragma fragment EID4725Fragment
 #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
 #include "VS_EID4725.hlsl"
 #include "PS_EID4725.hlsl"
 struct EID4725Input {
 float3 position:POSITION; float3 normal:NORMAL; float4 tangent:TANGENT;
 float2 uv:TEXCOORD0; float3 previous:TEXCOORD1; float3 referencePosition:TEXCOORD2;
 float3 referenceNormal:TEXCOORD3; float4 weights:TEXCOORD4; uint4 joints:TEXCOORD5;
};
EID4725VS_SPIRV_Cross_Output EID4725Vertex(EID4725Input v) {
 EID4725VS_SPIRV_Cross_Input x=(EID4725VS_SPIRV_Cross_Input)0;
 x.EID4725VS_3=v.position; x.EID4725VS_4=v.uv; x.EID4725VS_5=v.normal; x.EID4725VS_6=v.tangent;
 x.EID4725VS_7=float4(v.previous,1); x.EID4725VS_8=v.referencePosition; x.EID4725VS_9=v.referenceNormal;
 x.EID4725VS_11=v.weights; x.EID4725VS_12=v.joints; x.EID4725VS_gl_InstanceIndex=0;
 return EID4725VS_main(x);
}
EID4725PS_SPIRV_Cross_Output EID4725Fragment(EID4725VS_SPIRV_Cross_Output i,bool front:SV_IsFrontFace) {
 EID4725PS_SPIRV_Cross_Input x=(EID4725PS_SPIRV_Cross_Input)0;
 x.EID4725PS_3=i.EID4725VS_13; x.EID4725PS_4=i.EID4725VS_14; x.EID4725PS_5=i.EID4725VS_15; x.EID4725PS_6=i.EID4725VS_16;
 x.EID4725PS_7=i.EID4725VS_17; x.EID4725PS_8=i.EID4725VS_18; x.EID4725PS_9=i.EID4725VS_19; x.EID4725PS_10=i.EID4725VS_20;
 x.EID4725PS_12=i.EID4725VS_22; x.EID4725PS_gl_FragCoord=i.EID4725VS_gl_Position; x.EID4725PS_gl_FrontFacing=front;
 return EID4725PS_main(x);
}

 ENDHLSL
 }
 Pass {
 Name "VS215445_PS215446_UniversalGBuffer"
 Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
 Cull Back ZWrite On ZTest LEqual Blend Off
 Stencil { Ref 36 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
 HLSLPROGRAM
 #pragma target 5.0
 #pragma only_renderers d3d11 vulkan
 #pragma vertex EID215445Vertex
 #pragma fragment EID215446Fragment
 #include "VS215445_PS215446_UniversalGBuffer.hlsl"
 ENDHLSL
 }
 }
 Fallback Off
}
