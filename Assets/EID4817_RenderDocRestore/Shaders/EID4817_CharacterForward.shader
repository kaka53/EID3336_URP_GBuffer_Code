Shader "Hidden/EID4817/CharacterForward" {
 Properties {
 _EID4817_GBuffer_Res24 ("EID1711 captured albedo",2D)="white"{}
 _EID4817_GBuffer_P00 ("EID1711 c00",Vector)=(0,0,0,0)
 _EID4817_GBuffer_P01 ("EID1711 c01",Vector)=(0,0,0,0)
 _EID4817_GBuffer_P02 ("EID1711 c02",Vector)=(0,0,0,0)
 _EID4817_GBuffer_P03 ("EID1711 c03",Vector)=(0,0,0,0)
 _EID4817_GBuffer_P04 ("EID1711 c04",Vector)=(0,0,0,0)
 _EID4817_GBuffer_P05 ("EID1711 c05",Vector)=(0,0,0,0)
 _EID4817_GBuffer_P06 ("EID1711 c06",Vector)=(0,0,0,0)
 _EID4817_GBuffer_P07 ("EID1711 c07",Vector)=(0,0,0,0)
 _EID4817_GBuffer_P08 ("EID1711 c08",Vector)=(0,0,0,0)
 _EID4817_GBuffer_P09 ("EID1711 c09",Vector)=(0,0,0,0)
 _EID4817_GBuffer_P10 ("EID1711 c10",Vector)=(0,0,0,0)
 _EID4817_GBuffer_P11 ("EID1711 c11",Vector)=(0,0,0,0)
 _EID4817_GBuffer_P12 ("EID1711 c12",Vector)=(0,0,0,0)
 _EID4817_GBuffer_P13 ("EID1711 c13",Vector)=(0,0,0,0)
 _EID4817_GBuffer_P14 ("EID1711 c14",Vector)=(0,0,0,0)
 _EID4817_GBuffer_P15 ("EID1711 c15",Vector)=(0,0,0,0)
 _EID4817_GBuffer_P16 ("EID1711 c16",Vector)=(0,0,0,0)
 _EID4817_GBuffer_P17 ("EID1711 c17",Vector)=(0,0,0,0)
 _EID4817_GBuffer_InstancePacked ("EID1711 packed instance",Vector)=(0,0,0,0)
 _EID4817_GBuffer_EID215440MipBias ("Captured mip bias",Float)=0

 [NoScaleOffset] EID4817PS_39("Captured EID4817PS_39",2D)=""{}
 [NoScaleOffset] EID4817PS_38("Captured EID4817PS_38",2D)=""{}
 [NoScaleOffset] EID4817PS_53("Captured EID4817PS_53",2D)=""{}
 [NoScaleOffset] EID4817PS_46("Captured EID4817PS_46",3D)=""{}
 [NoScaleOffset] EID4817PS_44("Captured EID4817PS_44",3D)=""{}
 [NoScaleOffset] EID4817PS_42("Captured EID4817PS_42",3D)=""{}
 [NoScaleOffset] EID4817PS_45("Captured EID4817PS_45",3D)=""{}
 [NoScaleOffset] EID4817PS_43("Captured EID4817PS_43",3D)=""{}
 [NoScaleOffset] EID4817PS_41("Captured EID4817PS_41",3D)=""{}
 [NoScaleOffset] EID4817PS_58("Captured EID4817PS_58",3D)=""{}
 [NoScaleOffset] EID4817PS_50("Captured EID4817PS_50",2D)=""{}
 [NoScaleOffset] EID4817PS_52("Captured EID4817PS_52",2D)=""{}
 [NoScaleOffset] EID4817PS_49("Captured EID4817PS_49",2D)=""{}
 [NoScaleOffset] EID4817PS_51("Captured EID4817PS_51",2D)=""{}
 }
 SubShader {
 Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
 Pass {
 Name "EID4817 CharacterForward" Tags { "LightMode"="EID4817CharacterForward" }
 Cull Back ZTest Equal ZWrite On Blend Off
 HLSLPROGRAM
 #pragma target 5.0
 #pragma only_renderers d3d11 vulkan
 #pragma vertex EID4817Vertex
 #pragma fragment EID4817Fragment
 #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
 #include "VS_EID4817_Live.hlsl"
 #include "PS_EID4817_Live.hlsl"
struct EID4817Input {
 float3 position:POSITION; float3 normal:NORMAL; float4 tangent:TANGENT; float4 color:COLOR;
 float2 uv:TEXCOORD0; float packedNormal:TEXCOORD1; float2 previousUV:TEXCOORD2;
 float previousPackedNormal:TEXCOORD3; float3 referencePosition:TEXCOORD4; float3 rawPosition:TEXCOORD5;
 float4 weights:TEXCOORD6; uint4 joints:TEXCOORD7;
};
EID4817VS_SPIRV_Cross_Output EID4817Vertex(EID4817Input v) {
 EID4817BakedPosition=v.position; EID4817BakedNormal=v.normal; EID4817BakedTangent=v.tangent;
 EID4817VS_SPIRV_Cross_Input x=(EID4817VS_SPIRV_Cross_Input)0;
 x.EID4817VS_3=v.rawPosition; x.EID4817VS_4=v.uv; x.EID4817VS_5=float3(v.packedNormal,0,0); x.EID4817VS_6=v.color;
 x.EID4817VS_7=float4(v.previousUV,0,1); x.EID4817VS_8=v.referencePosition; x.EID4817VS_9=float3(v.previousPackedNormal,0,0);
 x.EID4817VS_11=v.weights; x.EID4817VS_12=v.joints; x.EID4817VS_gl_InstanceIndex=0;
 return EID4817VS_main(x);
}
EID4817PS_SPIRV_Cross_Output EID4817Fragment(EID4817VS_SPIRV_Cross_Output i,bool front:SV_IsFrontFace) {
 EID4817PS_SPIRV_Cross_Input x=(EID4817PS_SPIRV_Cross_Input)0;
 x.EID4817PS_3=i.EID4817VS_13; x.EID4817PS_4=i.EID4817VS_14; x.EID4817PS_5=i.EID4817VS_15; x.EID4817PS_6=i.EID4817VS_16;
 x.EID4817PS_7=i.EID4817VS_17; x.EID4817PS_8=i.EID4817VS_18; x.EID4817PS_9=i.EID4817VS_19; x.EID4817PS_10=i.EID4817VS_20;
 x.EID4817PS_12=i.EID4817VS_22; x.EID4817PS_gl_FragCoord=i.EID4817VS_gl_Position; x.EID4817PS_gl_FrontFacing=front;
 return EID4817PS_main(x);
}

 ENDHLSL
 }
 Pass {
 Name "VS215439_PS215440_UniversalGBuffer"
 Tags { "LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit" }
 Cull Back ZTest LEqual ZWrite On Blend Off
 Stencil { Ref 52 Comp Always Pass Replace ReadMask 255 WriteMask 255 }
 HLSLPROGRAM
 #pragma target 5.0
 #pragma only_renderers d3d11 vulkan
 #pragma vertex EID215439Vertex
 #pragma fragment EID215440Fragment
 #include "VS215439_PS215440_UniversalGBuffer.hlsl"
 ENDHLSL
 }
 }
 Fallback Off
}
