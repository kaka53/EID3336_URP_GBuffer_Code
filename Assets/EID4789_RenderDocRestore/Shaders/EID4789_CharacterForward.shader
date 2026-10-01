Shader "Hidden/EID4789/CharacterForward" {
 Properties {
 [Toggle] _EID4789UseCapturedScreen40("Use RenderDoc AO and shadow input",Float)=0
 [NoScaleOffset] _EID4789CapturedScreen40("RenderDoc AO and shadow input",2D)="white"{}
 [NoScaleOffset] EID4789PS_40("Captured EID4789PS_40",2D)=""{}
 [NoScaleOffset] EID4789PS_39("Captured EID4789PS_39",2D)=""{}
 [NoScaleOffset] EID4789PS_63("Captured EID4789PS_63",2D)=""{}
 [NoScaleOffset] EID4789PS_47("Captured EID4789PS_47",3D)=""{}
 [NoScaleOffset] EID4789PS_45("Captured EID4789PS_45",3D)=""{}
 [NoScaleOffset] EID4789PS_43("Captured EID4789PS_43",3D)=""{}
 [NoScaleOffset] EID4789PS_46("Captured EID4789PS_46",3D)=""{}
 [NoScaleOffset] EID4789PS_44("Captured EID4789PS_44",3D)=""{}
 [NoScaleOffset] EID4789PS_42("Captured EID4789PS_42",3D)=""{}
 [NoScaleOffset] EID4789PS_68("Captured EID4789PS_68",3D)=""{}
 [NoScaleOffset] EID4789PS_56("Captured EID4789PS_56",2D)=""{}
 [NoScaleOffset] EID4789PS_55("Captured EID4789PS_55",2D)=""{}
 [NoScaleOffset] EID4789PS_54("Captured EID4789PS_54",2D)=""{}
 [NoScaleOffset] EID4789PS_53("Captured EID4789PS_53",2D)=""{}
 [NoScaleOffset] EID4789PS_62("Captured EID4789PS_62",Cube)=""{}
 [NoScaleOffset] EID4789PS_51("Captured EID4789PS_51",2D)=""{}
 [NoScaleOffset] EID4789PS_52("Captured EID4789PS_52",2D)=""{}
 [NoScaleOffset] EID4789PS_58("Captured EID4789PS_58",2D)=""{}
 [NoScaleOffset] EID4789PS_60("Captured EID4789PS_60",2D)=""{}
 [NoScaleOffset] EID4789PS_50("Captured EID4789PS_50",2D)=""{}
 [NoScaleOffset] EID4789PS_59("Captured EID4789PS_59",2D)=""{}
 [NoScaleOffset] EID4789PS_57("Captured EID4789PS_57",2D)=""{}
 }
 SubShader {
 Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
 Pass {
 Name "EID4789 CharacterForward" Tags { "LightMode"="EID4789CharacterForward" }
 Cull Off ZTest Equal ZWrite On Blend Off
 HLSLPROGRAM
 #pragma target 5.0
 #pragma only_renderers d3d11 vulkan
 #pragma vertex EID4789Vertex
 #pragma fragment EID4789Fragment
 #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
 #include "VS_EID4789_Live.hlsl"
 #include "PS_EID4789_Live.hlsl"
 struct EID4789Input {
 float3 position:POSITION; float3 normal:NORMAL; float4 tangent:TANGENT; float4 color:COLOR;
 float2 uv:TEXCOORD0; float packedNormal:TEXCOORD1; float2 previousUV:TEXCOORD2;
 float previousPackedNormal:TEXCOORD3; float3 referencePosition:TEXCOORD4; float3 rawPosition:TEXCOORD5;
 float4 weights:TEXCOORD6; uint4 joints:TEXCOORD7;
};
EID4789VS_SPIRV_Cross_Output EID4789Vertex(EID4789Input v) {
 EID4789BakedPosition=v.position; EID4789BakedNormal=v.normal; EID4789BakedTangent=v.tangent;
 EID4789VS_SPIRV_Cross_Input x=(EID4789VS_SPIRV_Cross_Input)0;
 x.EID4789VS_3=v.rawPosition; x.EID4789VS_4=v.uv; x.EID4789VS_5=float3(v.packedNormal,0,0); x.EID4789VS_6=v.color;
 x.EID4789VS_7=float4(v.previousUV,0,1); x.EID4789VS_8=v.referencePosition; x.EID4789VS_9=float3(v.previousPackedNormal,0,0);
 x.EID4789VS_11=v.weights; x.EID4789VS_12=v.joints; x.EID4789VS_gl_InstanceIndex=0;
 return EID4789VS_main(x);
}
EID4789PS_SPIRV_Cross_Output EID4789Fragment(EID4789VS_SPIRV_Cross_Output i,bool front:SV_IsFrontFace) {
 EID4789PS_SPIRV_Cross_Input x=(EID4789PS_SPIRV_Cross_Input)0;
 x.EID4789PS_3=i.EID4789VS_13; x.EID4789PS_4=i.EID4789VS_14; x.EID4789PS_5=i.EID4789VS_15; x.EID4789PS_6=i.EID4789VS_16;
 x.EID4789PS_7=i.EID4789VS_17; x.EID4789PS_8=i.EID4789VS_18; x.EID4789PS_9=i.EID4789VS_19; x.EID4789PS_10=i.EID4789VS_20;
 x.EID4789PS_12=i.EID4789VS_22; x.EID4789PS_gl_FragCoord=i.EID4789VS_gl_Position; x.EID4789PS_gl_FrontFacing=front;
 return EID4789PS_main(x);
}

 ENDHLSL
 }
 }
 Fallback Off
}
