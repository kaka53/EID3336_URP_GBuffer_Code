Shader "Hidden/EID4740/CharacterForward" {
 Properties {
 [NoScaleOffset] EID4740PS_39("Captured EID4740PS_39",2D)=""{}
 [NoScaleOffset] EID4740PS_38("Captured EID4740PS_38",2D)=""{}
 [NoScaleOffset] EID4740PS_53("Captured EID4740PS_53",2D)=""{}
 [NoScaleOffset] EID4740PS_46("Captured EID4740PS_46",3D)=""{}
 [NoScaleOffset] EID4740PS_44("Captured EID4740PS_44",3D)=""{}
 [NoScaleOffset] EID4740PS_42("Captured EID4740PS_42",3D)=""{}
 [NoScaleOffset] EID4740PS_45("Captured EID4740PS_45",3D)=""{}
 [NoScaleOffset] EID4740PS_43("Captured EID4740PS_43",3D)=""{}
 [NoScaleOffset] EID4740PS_41("Captured EID4740PS_41",3D)=""{}
 [NoScaleOffset] EID4740PS_58("Captured EID4740PS_58",3D)=""{}
 [NoScaleOffset] EID4740PS_50("Captured EID4740PS_50",2D)=""{}
 [NoScaleOffset] EID4740PS_52("Captured EID4740PS_52",2D)=""{}
 [NoScaleOffset] EID4740PS_49("Captured EID4740PS_49",2D)=""{}
 [NoScaleOffset] EID4740PS_51("Captured EID4740PS_51",2D)=""{}
 }
 SubShader {
 Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
 Pass {
 Name "EID4740 CharacterForward" Tags { "LightMode"="EID4740CharacterForward" }
 Cull Back ZTest Equal ZWrite On Blend Off
 HLSLPROGRAM
 #pragma target 5.0
 #pragma only_renderers d3d11 vulkan
 #pragma vertex EID4740Vertex
 #pragma fragment EID4740Fragment
 #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
 #include "VS_EID4740_Live.hlsl"
 #include "PS_EID4740_Live.hlsl"
struct EID4740Input {
 float3 position:POSITION; float3 normal:NORMAL; float4 tangent:TANGENT; float4 color:COLOR;
 float2 uv:TEXCOORD0; float packedNormal:TEXCOORD1; float2 previousUV:TEXCOORD2;
 float previousPackedNormal:TEXCOORD3; float3 referencePosition:TEXCOORD4; float3 rawPosition:TEXCOORD5;
 float4 weights:TEXCOORD6; uint4 joints:TEXCOORD7;
};
EID4740VS_SPIRV_Cross_Output EID4740Vertex(EID4740Input v) {
 EID4740BakedPosition=v.position; EID4740BakedNormal=v.normal; EID4740BakedTangent=v.tangent;
 EID4740VS_SPIRV_Cross_Input x=(EID4740VS_SPIRV_Cross_Input)0;
 x.EID4740VS_3=v.rawPosition; x.EID4740VS_4=v.uv; x.EID4740VS_5=float3(v.packedNormal,0,0); x.EID4740VS_6=v.color;
 x.EID4740VS_7=float4(v.previousUV,0,1); x.EID4740VS_8=v.referencePosition; x.EID4740VS_9=float3(v.previousPackedNormal,0,0);
 x.EID4740VS_11=v.weights; x.EID4740VS_12=v.joints; x.EID4740VS_gl_InstanceIndex=0;
 return EID4740VS_main(x);
}
EID4740PS_SPIRV_Cross_Output EID4740Fragment(EID4740VS_SPIRV_Cross_Output i,bool front:SV_IsFrontFace) {
 EID4740PS_SPIRV_Cross_Input x=(EID4740PS_SPIRV_Cross_Input)0;
 x.EID4740PS_3=i.EID4740VS_13; x.EID4740PS_4=i.EID4740VS_14; x.EID4740PS_5=i.EID4740VS_15; x.EID4740PS_6=i.EID4740VS_16;
 x.EID4740PS_7=i.EID4740VS_17; x.EID4740PS_8=i.EID4740VS_18; x.EID4740PS_9=i.EID4740VS_19; x.EID4740PS_10=i.EID4740VS_20;
 x.EID4740PS_12=i.EID4740VS_22; x.EID4740PS_gl_FragCoord=i.EID4740VS_gl_Position; x.EID4740PS_gl_FrontFacing=front;
 return EID4740PS_main(x);
}

 ENDHLSL
 }
 }
 Fallback Off
}
