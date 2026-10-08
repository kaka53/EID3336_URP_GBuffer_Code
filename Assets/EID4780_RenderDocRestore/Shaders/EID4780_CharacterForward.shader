Shader "Hidden/EID4780/CharacterForward"
{
 Properties
 {
  [Toggle] _EID4780UseCapturedScreen40("Use RenderDoc AO and shadow input",Float)=0
  [NoScaleOffset] _EID4780CapturedScreen40("RenderDoc AO and shadow input",2D)="white"{}
  [NoScaleOffset] _40("_40",2D)="white"{}
  [NoScaleOffset] _41("_41",2D)="white"{}
  [NoScaleOffset] _53("_53",2D)="white"{}
  [NoScaleOffset] _54("_54",2D)="white"{}
  [NoScaleOffset] _55("_55",2D)="white"{}
  [NoScaleOffset] _56("_56",2D)="white"{}
  [NoScaleOffset] _51("_51",2D)="white"{}
  [NoScaleOffset] _52("_52",2D)="white"{}
  [NoScaleOffset] _43("_43",3D)=""{}
  [NoScaleOffset] _44("_44",3D)=""{}
  [NoScaleOffset] _45("_45",3D)=""{}
  [NoScaleOffset] _46("_46",3D)=""{}
  [NoScaleOffset] _47("_47",3D)=""{}
  [NoScaleOffset] _48("_48",3D)=""{}
  [NoScaleOffset] _61("_61",3D)=""{}
        [Header(RenderDoc_Unique_Textures)]
        _EID4780_GBuffer_Res27 ("res27 基础颜色 Binding1", 2D) = "white" {}
        [Header(RenderDoc_PS_uniforms26_20xfloat4)]
        _EID4780_GBuffer_P00 ("c00 捕获局部参数", Vector) = (0,0,0,0)
        _EID4780_GBuffer_P01 ("c01 child4-7 双面法线在 y", Vector) = (0,1,0,0)
        _EID4780_GBuffer_P02 ("c02 捕获局部参数", Vector) = (0,0,0,0)
        _EID4780_GBuffer_P03 ("c03 捕获局部参数", Vector) = (0,0,0,0)
        _EID4780_GBuffer_P04 ("c04 捕获局部参数", Vector) = (0,0,0,0)
        _EID4780_GBuffer_P05 ("c05 捕获局部参数", Vector) = (0,0,0,0)
        _EID4780_GBuffer_P06 ("c06 child24 基础色乘色", Vector) = (1,1,1,1)
        _EID4780_GBuffer_P07 ("c07 捕获局部参数", Vector) = (0,0,0,0)
        _EID4780_GBuffer_P08 ("c08 捕获局部参数", Vector) = (0,0,0,0)
        _EID4780_GBuffer_P09 ("c09 捕获局部参数", Vector) = (0,0,0,0)
        _EID4780_GBuffer_P10 ("c10 child28 UV scale/offset", Vector) = (1,1,0,0)
        _EID4780_GBuffer_P11 ("c11 捕获局部参数", Vector) = (0,0,0,0)
        _EID4780_GBuffer_P12 ("c12 child30 wrap 在 x", Vector) = (0,0,0,0)
        _EID4780_GBuffer_P13 ("c13 child34 wrap 乘色", Vector) = (1,1,1,1)
        _EID4780_GBuffer_P14 ("c14 捕获局部参数", Vector) = (0,0,0,0)
        _EID4780_GBuffer_P15 ("c15 捕获局部参数", Vector) = (0,0,0,0)
        _EID4780_GBuffer_P16 ("c16 捕获局部参数", Vector) = (0,0,0,0)
        _EID4780_GBuffer_P17 ("c17 捕获局部参数", Vector) = (0,0,0,0)
        _EID4780_GBuffer_P18 ("c18 捕获局部参数", Vector) = (0,0,0,0)
        _EID4780_GBuffer_P19 ("c19 捕获局部参数", Vector) = (0,0,0,0)
        _EID4780_GBuffer_InstancePacked ("uniforms21 child2 10/10/10/2", Vector) = (0,0,0,0)
        _EID4780_GBuffer_EID215446MipBias ("uniforms18 全局纹理 Mip Bias", Float) = 0
  _EID4780_GBuffer_UseBakedSkinning ("Captured ssbo25 skin baked into VSInput", Float) = 0
 }
 SubShader
 {
  Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
  Pass
  {
   Name "EID4780 CharacterForward"
   Tags { "LightMode"="EID4780CharacterForward" }
   Cull Back ZTest Equal ZWrite On Blend Off
   HLSLPROGRAM
   #pragma target 5.0
   #if defined(SHADER_API_VULKAN)
   #pragma use_dxc
   #endif
   #pragma only_renderers d3d11 vulkan
   #pragma exclude_renderers gles gles3 glcore
   #pragma vertex EID4780Vertex
   #pragma fragment EID4780Fragment
   #include "Replay.hlsl"
   #include "VS_EID4780_Live.hlsl"
   #include "PS_EID4780_Live.hlsl"
struct EID4780Input
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
 float4 input8 : BLENDWEIGHTS;
 uint4 input9 : BLENDINDICES;
};
VS_SPIRV_Cross_Output EID4780Vertex(EID4780Input v)
{
 VS_SPIRV_Cross_Input x=(VS_SPIRV_Cross_Input)0;
 x.VS_3=v.bakedPosition; x.VS_4=v.input1; x.VS_5=float3(v.input2,0,0); x.VS_6=v.input3;
 x.VS_7=float4(v.input4,0,1); x.VS_8=v.input5; x.VS_9=float3(v.input6,0,0); x.VS_10=float4(v.input7,0,0,1);
 x.VS_12=v.input8; x.VS_13=v.input9; x.EID_BakedNormalInput=v.bakedNormal; x.EID_BakedTangentInput=v.bakedTangent; x.gl_InstanceIndex=0;
 return EID4780VSMain(x);
}
struct EID4780FragmentOutput { float4 color0:SV_Target0; float4 color1:SV_Target1; };
EID4780FragmentOutput EID4780Fragment(VS_SPIRV_Cross_Output i,bool isFrontFace:SV_IsFrontFace)
{
 SPIRV_Cross_Input x=(SPIRV_Cross_Input)0; x._3=i.VS_14; x._4=i.VS_15; x._5=i.VS_16; x._6=i.VS_17; x._7=i.VS_18; x._8=i.VS_19; x._9=i.VS_20; x._10=i.VS_21; x._11=i.VS_22; x._13=i.VS_24; x.gl_FragCoord=i.gl_Position; x.gl_FrontFacing=isFrontFace;
 SPIRV_Cross_Output c=main(x); EID4780FragmentOutput o; o.color0=c._15; o.color1=c._16; return o;
}
   ENDHLSL
  }
  Pass
  {
   Name "VS215445_PS215446_UniversalGBuffer"
   Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
   Cull Back
   ZWrite On
   ZTest LEqual
   Blend Off
   Stencil { Ref 36 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
   HLSLPROGRAM
   #pragma target 5.0
   #if defined(SHADER_API_VULKAN)
   #pragma use_dxc
   #endif
   #pragma only_renderers d3d11 vulkan
   #pragma exclude_renderers gles gles3 glcore
   #pragma vertex EID215445Vertex
   #pragma fragment EID215446Fragment
   #include "VS215445_PS215446_UniversalGBuffer.hlsl"
   ENDHLSL
  }
 }
 Fallback Off
}






