Shader "Hidden/EID4705/CharacterForward" {
 Properties {
 [NoScaleOffset] EID4705PS_41("Captured EID4705PS_41",2D)=""{}
 [NoScaleOffset] EID4705PS_40("Captured EID4705PS_40",2D)=""{}
 [NoScaleOffset] EID4705PS_57("Captured EID4705PS_57",2D)=""{}
 [NoScaleOffset] EID4705PS_48("Captured EID4705PS_48",3D)=""{}
 [NoScaleOffset] EID4705PS_46("Captured EID4705PS_46",3D)=""{}
 [NoScaleOffset] EID4705PS_44("Captured EID4705PS_44",3D)=""{}
 [NoScaleOffset] EID4705PS_47("Captured EID4705PS_47",3D)=""{}
 [NoScaleOffset] EID4705PS_45("Captured EID4705PS_45",3D)=""{}
 [NoScaleOffset] EID4705PS_43("Captured EID4705PS_43",3D)=""{}
 [NoScaleOffset] EID4705PS_62("Captured EID4705PS_62",3D)=""{}
 [NoScaleOffset] EID4705PS_54("Captured EID4705PS_54",2D)=""{}
 [NoScaleOffset] EID4705PS_53("Captured EID4705PS_53",2D)=""{}
 [NoScaleOffset] EID4705PS_52("Captured EID4705PS_52",2D)=""{}
 [NoScaleOffset] EID4705PS_51("Captured EID4705PS_51",2D)=""{}
 [NoScaleOffset] EID4705PS_56("Captured EID4705PS_56",2D)=""{}
 [NoScaleOffset] EID4705PS_55("Captured EID4705PS_55",2D)=""{}
 }
 SubShader {
 Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
 Pass {
 Name "EID4705 CharacterForward" Tags { "LightMode"="EID4705CharacterForward" }
 Cull Back ZTest Equal ZWrite On Blend Off
 HLSLPROGRAM
 #pragma target 5.0
 #pragma only_renderers d3d11 vulkan
 #pragma vertex EID4705Vertex
 #pragma fragment EID4705Fragment
 #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
 #include "VS_EID4705_Live.hlsl"
 #include "PS_EID4705_Live.hlsl"
struct EID4705Input {
 float3 position:POSITION; float3 normal:NORMAL; float4 tangent:TANGENT; float4 color:COLOR;
 float2 uv:TEXCOORD0; float packedNormal:TEXCOORD1; float2 previousUV:TEXCOORD2;
 float previousPackedNormal:TEXCOORD3; float3 referencePosition:TEXCOORD4; float3 rawPosition:TEXCOORD5;
 float4 weights:TEXCOORD6; uint4 joints:TEXCOORD7;
};
EID4705VS_SPIRV_Cross_Output EID4705Vertex(EID4705Input v) {
 EID4705BakedPosition=v.position; EID4705BakedNormal=v.normal; EID4705BakedTangent=v.tangent;
 EID4705VS_SPIRV_Cross_Input x=(EID4705VS_SPIRV_Cross_Input)0;
 x.EID4705VS_3=v.rawPosition; x.EID4705VS_4=v.uv; x.EID4705VS_5=float3(v.packedNormal,0,0); x.EID4705VS_6=v.color;
 x.EID4705VS_7=float4(v.previousUV,0,1); x.EID4705VS_8=v.referencePosition; x.EID4705VS_9=float3(v.previousPackedNormal,0,0);
 x.EID4705VS_10=v.tangent; x.EID4705VS_12=v.weights; x.EID4705VS_13=v.joints; x.EID4705VS_gl_InstanceIndex=0;
 return EID4705VS_main(x);
}
EID4705PS_SPIRV_Cross_Output EID4705Fragment(EID4705VS_SPIRV_Cross_Output i,bool front:SV_IsFrontFace) {
 EID4705PS_SPIRV_Cross_Input x=(EID4705PS_SPIRV_Cross_Input)0;
 x.EID4705PS_3=i.EID4705VS_14; x.EID4705PS_4=i.EID4705VS_15; x.EID4705PS_5=i.EID4705VS_16; x.EID4705PS_6=i.EID4705VS_17;
 x.EID4705PS_7=i.EID4705VS_18; x.EID4705PS_8=i.EID4705VS_19; x.EID4705PS_9=i.EID4705VS_20; x.EID4705PS_10=i.EID4705VS_21;
 x.EID4705PS_11=i.EID4705VS_22; x.EID4705PS_13=i.EID4705VS_24; x.EID4705PS_gl_FragCoord=i.EID4705VS_gl_Position; x.EID4705PS_gl_FrontFacing=front;
 return EID4705PS_main(x);
}

 ENDHLSL
 }
 }
 Fallback Off
}
