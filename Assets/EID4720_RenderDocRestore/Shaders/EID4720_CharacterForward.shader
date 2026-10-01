Shader "Hidden/EID4720/CharacterForward" {
 Properties {
 [NoScaleOffset] EID4720PS_40("Captured EID4720PS_40",2D)=""{}
 [NoScaleOffset] EID4720PS_39("Captured EID4720PS_39",2D)=""{}
 [NoScaleOffset] EID4720PS_60("Captured EID4720PS_60",2D)=""{}
 [NoScaleOffset] EID4720PS_47("Captured EID4720PS_47",3D)=""{}
 [NoScaleOffset] EID4720PS_45("Captured EID4720PS_45",3D)=""{}
 [NoScaleOffset] EID4720PS_43("Captured EID4720PS_43",3D)=""{}
 [NoScaleOffset] EID4720PS_46("Captured EID4720PS_46",3D)=""{}
 [NoScaleOffset] EID4720PS_44("Captured EID4720PS_44",3D)=""{}
 [NoScaleOffset] EID4720PS_42("Captured EID4720PS_42",3D)=""{}
 [NoScaleOffset] EID4720PS_65("Captured EID4720PS_65",3D)=""{}
 [NoScaleOffset] EID4720PS_56("Captured EID4720PS_56",2D)=""{}
 [NoScaleOffset] EID4720PS_55("Captured EID4720PS_55",2D)=""{}
 [NoScaleOffset] EID4720PS_54("Captured EID4720PS_54",2D)=""{}
 [NoScaleOffset] EID4720PS_53("Captured EID4720PS_53",2D)=""{}
 [NoScaleOffset] EID4720PS_52("Captured EID4720PS_52",2D)=""{}
 [NoScaleOffset] EID4720PS_59("Captured EID4720PS_59",2D)=""{}
 [NoScaleOffset] EID4720PS_58("Captured EID4720PS_58",2D)=""{}
 [NoScaleOffset] EID4720PS_51("Captured EID4720PS_51",2D)=""{}
 [NoScaleOffset] EID4720PS_50("Captured EID4720PS_50",2D)=""{}
 [NoScaleOffset] EID4720PS_57("Captured EID4720PS_57",2D)=""{}
 }
 SubShader {
 Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
 Pass {
 Name "EID4720 CharacterForward" Tags { "LightMode"="EID4720CharacterForward" }
 Cull Back ZTest Equal ZWrite On Blend Off
 HLSLPROGRAM
 #pragma target 5.0
 #pragma use_dxc
 #pragma only_renderers d3d11 vulkan
 #pragma vertex EID4720Vertex
 #pragma fragment EID4720Fragment
 #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
 #include "VS_EID4720_Live.hlsl"
 #include "PS_EID4720_Live.hlsl"
 struct EID4720Input {
 float3 position:POSITION; float3 normal:NORMAL; float4 tangent:TANGENT; float4 color:COLOR;
 float2 uv:TEXCOORD0; float packedNormal:TEXCOORD1; float2 previousUV:TEXCOORD2;
 float previousPackedNormal:TEXCOORD3; float3 referencePosition:TEXCOORD4; float3 rawPosition:TEXCOORD5;
 float4 weights:TEXCOORD6; uint4 joints:TEXCOORD7;
};
EID4720VS_SPIRV_Cross_Output EID4720Vertex(EID4720Input v) {
 EID4720BakedPosition=v.position; EID4720BakedNormal=v.normal; EID4720BakedTangent=v.tangent;
 EID4720VS_SPIRV_Cross_Input x=(EID4720VS_SPIRV_Cross_Input)0;
 x.EID4720VS_3=v.rawPosition; x.EID4720VS_4=v.uv; x.EID4720VS_5=float3(v.packedNormal,0,0); x.EID4720VS_6=v.color;
 x.EID4720VS_7=float4(v.previousUV,0,1); x.EID4720VS_8=v.referencePosition; x.EID4720VS_9=float3(v.previousPackedNormal,0,0);
 x.EID4720VS_11=v.weights; x.EID4720VS_12=v.joints; x.EID4720VS_gl_InstanceIndex=0;
 return EID4720VS_main(x);
}
EID4720PS_SPIRV_Cross_Output EID4720Fragment(EID4720VS_SPIRV_Cross_Output i,bool front:SV_IsFrontFace) {
 EID4720PS_SPIRV_Cross_Input x=(EID4720PS_SPIRV_Cross_Input)0;
 x.EID4720PS_3=i.EID4720VS_13; x.EID4720PS_4=i.EID4720VS_14; x.EID4720PS_5=i.EID4720VS_15; x.EID4720PS_6=i.EID4720VS_16;
 x.EID4720PS_7=i.EID4720VS_17; x.EID4720PS_8=i.EID4720VS_18; x.EID4720PS_9=i.EID4720VS_19; x.EID4720PS_10=i.EID4720VS_20;
 x.EID4720PS_12=i.EID4720VS_22; x.EID4720PS_gl_FragCoord=i.EID4720VS_gl_Position; x.EID4720PS_gl_FrontFacing=front;
 return EID4720PS_main(x);
}

 ENDHLSL
 }
 }
 Fallback Off
}
