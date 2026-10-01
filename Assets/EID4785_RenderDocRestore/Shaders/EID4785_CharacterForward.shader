Shader "Hidden/EID4785/CharacterForward" {
 Properties {
  [Toggle] _EID4785UseCapturedScreen40 ("Use RenderDoc AO and shadow input", Float) = 0
  [NoScaleOffset] _EID4785CapturedScreen40 ("RenderDoc rid209554 (camera independent binding)", 2D) = "white" {}
   [Header(RenderDoc_Unique_Textures)]
  _EID4785_GBuffer_Res25 ("res25 albedo Binding", 2D) = "white" {}
  _EID4785_GBuffer_Res26 ("res26 normal Binding", 2D) = "white" {}
  [Header(RenderDoc_PS_uniforms_from_EID1692)]
  _EID4785_GBuffer_P00 ("c00", Vector) = (0,0,0,0)
  _EID4785_GBuffer_P01 ("c01", Vector) = (0,0,0,0)
  _EID4785_GBuffer_P02 ("c02", Vector) = (0,0,0,0)
  _EID4785_GBuffer_P03 ("c03", Vector) = (0,0,0,0)
  _EID4785_GBuffer_P04 ("c04", Vector) = (0,0,0,0)
  _EID4785_GBuffer_P05 ("c05", Vector) = (0,0,0,0)
  _EID4785_GBuffer_P06 ("c06", Vector) = (0,0,0,0)
  _EID4785_GBuffer_P07 ("c07", Vector) = (0,0,0,0)
  _EID4785_GBuffer_P08 ("c08", Vector) = (0,0,0,0)
  _EID4785_GBuffer_P09 ("c09", Vector) = (0,0,0,0)
  _EID4785_GBuffer_P10 ("c10", Vector) = (0,0,0,0)
  _EID4785_GBuffer_P11 ("c11", Vector) = (0,0,0,0)
  _EID4785_GBuffer_P12 ("c12", Vector) = (0,0,0,0)
  _EID4785_GBuffer_P13 ("c13", Vector) = (0,0,0,0)
  _EID4785_GBuffer_P14 ("c14", Vector) = (0,0,0,0)
  _EID4785_GBuffer_P15 ("c15", Vector) = (0,0,0,0)
  _EID4785_GBuffer_P16 ("c16", Vector) = (0,0,0,0)
  _EID4785_GBuffer_P17 ("c17", Vector) = (0,0,0,0)
  _EID4785_GBuffer_InstancePacked ("uniforms21 child2", Vector) = (0,0,0,0)
  _EID4785_GBuffer_EID215444MipBias ("uniforms18 mip bias", Float) = 0
  _EID4785_GBuffer_UseBakedSkinning ("Captured ssbo skin baked into VSInput", Float) = 0
 [NoScaleOffset] EID4785PS_40("Captured EID4785PS_40",2D)=""{}
 [NoScaleOffset] EID4785PS_39("Captured EID4785PS_39",2D)=""{}
 [NoScaleOffset] EID4785PS_63("Captured EID4785PS_63",2D)=""{}
 [NoScaleOffset] EID4785PS_47("Captured EID4785PS_47",3D)=""{}
 [NoScaleOffset] EID4785PS_45("Captured EID4785PS_45",3D)=""{}
 [NoScaleOffset] EID4785PS_43("Captured EID4785PS_43",3D)=""{}
 [NoScaleOffset] EID4785PS_46("Captured EID4785PS_46",3D)=""{}
 [NoScaleOffset] EID4785PS_44("Captured EID4785PS_44",3D)=""{}
 [NoScaleOffset] EID4785PS_42("Captured EID4785PS_42",3D)=""{}
 [NoScaleOffset] EID4785PS_68("Captured EID4785PS_68",3D)=""{}
 [NoScaleOffset] EID4785PS_56("Captured EID4785PS_56",2D)=""{}
 [NoScaleOffset] EID4785PS_55("Captured EID4785PS_55",2D)=""{}
 [NoScaleOffset] EID4785PS_54("Captured EID4785PS_54",2D)=""{}
 [NoScaleOffset] EID4785PS_53("Captured EID4785PS_53",2D)=""{}
 [NoScaleOffset] EID4785PS_62("Captured EID4785PS_62",Cube)=""{}
 [NoScaleOffset] EID4785PS_51("Captured EID4785PS_51",2D)=""{}
 [NoScaleOffset] EID4785PS_52("Captured EID4785PS_52",2D)=""{}
 [NoScaleOffset] EID4785PS_58("Captured EID4785PS_58",2D)=""{}
 [NoScaleOffset] EID4785PS_60("Captured EID4785PS_60",2D)=""{}
 [NoScaleOffset] EID4785PS_50("Captured EID4785PS_50",2D)=""{}
 [NoScaleOffset] EID4785PS_59("Captured EID4785PS_59",2D)=""{}
 [NoScaleOffset] EID4785PS_57("Captured EID4785PS_57",2D)=""{}
 }
 SubShader {
 Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
 Pass {
 Name "EID4785 CharacterForward" Tags { "LightMode"="EID4785CharacterForward" }
 Cull Off ZTest Equal ZWrite On Blend Off
 HLSLPROGRAM
 #pragma target 5.0
 #pragma only_renderers d3d11 vulkan
 #pragma vertex EID4785Vertex
 #pragma fragment EID4785Fragment
 #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
 #include "VS_EID4785_Live.hlsl"
 #include "PS_EID4785_Live.hlsl"
 struct EID4785Input {
 float3 position:POSITION; float3 normal:NORMAL; float4 tangent:TANGENT; float4 color:COLOR;
 float2 uv:TEXCOORD0; float packedNormal:TEXCOORD1; float2 previousUV:TEXCOORD2;
 float previousPackedNormal:TEXCOORD3; float3 referencePosition:TEXCOORD4; float3 rawPosition:TEXCOORD5;
 float4 weights:TEXCOORD6; uint4 joints:TEXCOORD7;
};
EID4785VS_SPIRV_Cross_Output EID4785Vertex(EID4785Input v) {
 EID4785BakedPosition=v.position; EID4785BakedNormal=v.normal; EID4785BakedTangent=v.tangent;
 EID4785VS_SPIRV_Cross_Input x=(EID4785VS_SPIRV_Cross_Input)0;
 x.EID4785VS_3=v.rawPosition; x.EID4785VS_4=v.uv; x.EID4785VS_5=float3(v.packedNormal,0,0); x.EID4785VS_6=v.color;
 x.EID4785VS_7=float4(v.previousUV,0,1); x.EID4785VS_8=v.referencePosition; x.EID4785VS_9=float3(v.previousPackedNormal,0,0);
 x.EID4785VS_11=v.weights; x.EID4785VS_12=v.joints; x.EID4785VS_gl_InstanceIndex=0;
 return EID4785VS_main(x);
}
EID4785PS_SPIRV_Cross_Output EID4785Fragment(EID4785VS_SPIRV_Cross_Output i,bool front:SV_IsFrontFace) {
 EID4785PS_SPIRV_Cross_Input x=(EID4785PS_SPIRV_Cross_Input)0;
 x.EID4785PS_3=i.EID4785VS_13; x.EID4785PS_4=i.EID4785VS_14; x.EID4785PS_5=i.EID4785VS_15; x.EID4785PS_6=i.EID4785VS_16;
 x.EID4785PS_7=i.EID4785VS_17; x.EID4785PS_8=i.EID4785VS_18; x.EID4785PS_9=i.EID4785VS_19; x.EID4785PS_10=i.EID4785VS_20;
 x.EID4785PS_12=i.EID4785VS_22; x.EID4785PS_gl_FragCoord=i.EID4785VS_gl_Position; x.EID4785PS_gl_FrontFacing=front;
 return EID4785PS_main(x);
}

 ENDHLSL
 }
 Pass {
 Name "VS215443_PS215444_UniversalGBuffer" Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
 Cull Off ZTest LEqual ZWrite On Blend Off
 Stencil { Ref 36 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
 HLSLPROGRAM
 #pragma target 5.0
 #pragma only_renderers d3d11 vulkan
 #pragma vertex EID215443Vertex
 #pragma fragment EID215444Fragment
 #include "VS215443_PS215444_UniversalGBuffer.hlsl"
 ENDHLSL
 }
 }
 Fallback Off
}
