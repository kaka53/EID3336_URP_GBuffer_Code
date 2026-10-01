Shader "Hidden/EID4812/CharacterForward"
{
 Properties
 {
  [NoScaleOffset] _42("_42",2D)="white"{}
  [NoScaleOffset] _41("_41",2D)="white"{}
  [NoScaleOffset] _59("_59",2D)="white"{}
  [NoScaleOffset] _49("_49",3D)=""{}
  [NoScaleOffset] _47("_47",3D)=""{}
  [NoScaleOffset] _45("_45",3D)=""{}
  [NoScaleOffset] _48("_48",3D)=""{}
  [NoScaleOffset] _46("_46",3D)=""{}
  [NoScaleOffset] _44("_44",3D)=""{}
  [NoScaleOffset] _64("_64",3D)=""{}
  [NoScaleOffset] _55("_55",2D)="white"{}
  [NoScaleOffset] _30("_30",2D)="white"{}
  [NoScaleOffset] _58("_58",2D)="white"{}
  [NoScaleOffset] _54("_54",2D)="white"{}
  [NoScaleOffset] _57("_57",2D)="white"{}
  [NoScaleOffset] _52("_52",2D)="white"{}
  [NoScaleOffset] _53("_53",2D)="white"{}
  [NoScaleOffset] _56("_56",2D)="white"{}
 }
 SubShader
 {
  Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
  Pass
  {
   Name "EID4812 UniversalGBuffer"
   Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
   Cull Off ZWrite On ZTest LEqual Blend Off
   // Paired EID1727: preserve bit 0x10; Ref52 is not equivalent to full-mask Ref36.
   Stencil { Ref 52 Comp GEqual Pass Replace ReadMask 16 WriteMask 239 }
   HLSLPROGRAM
   #pragma target 5.0
   #pragma exclude_renderers gles gles3 glcore
   #pragma vertex EID4812GBufferVertex
   #pragma fragment EID4812GBufferFragment
   #include "EID4812_GBuffer.hlsl"
   ENDHLSL
  }
  Pass
  {
   Name "EID4812 CharacterForward"
   Tags { "LightMode"="CharacterForward" }
   // RenderDoc EID4812: Equal, not a reverse-Z GreaterEqual prepass.
   Cull Off ZTest Equal ZWrite On Blend Off
   ColorMask RGBA
   HLSLPROGRAM
   #pragma target 5.0
   #pragma use_dxc
   #pragma only_renderers d3d11 vulkan
   #pragma exclude_renderers gles gles3 glcore
   #pragma vertex EID4812Vertex
   #pragma fragment EID4812Fragment
   #define EID_LIVE_MVP 1
   #include "Replay.hlsl"
   #include "VS_EID4812_Live.hlsl"
#include "PS_EID4812_Live.hlsl"
struct EID4812Input
{
 float3 bakedPosition : POSITION;
 float3 bakedNormal : NORMAL;
 float4 input3 : COLOR;
 float2 input1 : TEXCOORD0;
 float input2 : TEXCOORD1;
 float2 input4 : TEXCOORD2;
 float input6 : TEXCOORD3;
 float input7 : TEXCOORD4;
 float3 input5 : TEXCOORD5;
 float4 bakedTangent : TEXCOORD6;
 float3 rawInput0 : TEXCOORD7;
 float4 input8 : BLENDWEIGHT;
 uint4 input9 : BLENDINDICES;
};
VS_SPIRV_Cross_Output EID4812Vertex(EID4812Input v)
{
 VS_SPIRV_Cross_Input x=(VS_SPIRV_Cross_Input)0;
 x.VS_3=v.bakedPosition;
 x.VS_4=v.input1;
 x.VS_5=float3(v.input2,0.0f,0.0f);
 x.VS_6=v.input3;
 x.VS_7=float4(v.input4,0.0f,1.0f);
 x.VS_8=v.input5;
 x.VS_9=float3(v.input6,0.0f,0.0f);
 x.VS_10=float4(v.input7,0.0f,0.0f,1.0f);
 x.VS_12=v.input8;
 x.VS_13=v.input9;
 x.EID_BakedNormalInput=v.bakedNormal;
 x.EID_BakedTangentInput=v.bakedTangent;
 x.gl_InstanceIndex=0;
 return EID4812VSMain(x);
}struct EID4812FragmentOutput
{
 float4 color0 : SV_Target0;
 float4 color1 : SV_Target1;
};
EID4812FragmentOutput EID4812Fragment(VS_SPIRV_Cross_Output i, bool isFrontFace:SV_IsFrontFace)
{
 SPIRV_Cross_Input x=(SPIRV_Cross_Input)0;
 x._3=i.VS_14;
 x._4=i.VS_15;
 x._5=i.VS_16;
 x._6=i.VS_17;
 x._7=i.VS_18;
 x._8=i.VS_19;
 x._9=i.VS_20;
 x._10=i.VS_21;
 x._11=i.VS_22;
 x._13=i.VS_24;
 x.gl_FragCoord=i.gl_Position;
 x.gl_FrontFacing=isFrontFace;
 SPIRV_Cross_Output captured=main(x);
 EID4812FragmentOutput o;
 o.color0=captured._15;
 o.color1=captured._16;
 return o;
}
   ENDHLSL
  }
 }
 Fallback Off
}



