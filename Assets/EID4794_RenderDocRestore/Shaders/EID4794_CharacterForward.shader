Shader "Hidden/EID4794/CharacterForward" {
 Properties {
 [NoScaleOffset] EID4794PS_42("Captured EID4794PS_42",2D)=""{}
 [NoScaleOffset] EID4794PS_41("Captured EID4794PS_41",2D)=""{}
 [NoScaleOffset] EID4794PS_59("Captured EID4794PS_59",2D)=""{}
 [NoScaleOffset] EID4794PS_49("Captured EID4794PS_49",3D)=""{}
 [NoScaleOffset] EID4794PS_47("Captured EID4794PS_47",3D)=""{}
 [NoScaleOffset] EID4794PS_45("Captured EID4794PS_45",3D)=""{}
 [NoScaleOffset] EID4794PS_48("Captured EID4794PS_48",3D)=""{}
 [NoScaleOffset] EID4794PS_46("Captured EID4794PS_46",3D)=""{}
 [NoScaleOffset] EID4794PS_44("Captured EID4794PS_44",3D)=""{}
 [NoScaleOffset] EID4794PS_64("Captured EID4794PS_64",3D)=""{}
 [NoScaleOffset] EID4794PS_55("Captured EID4794PS_55",2D)=""{}
 [NoScaleOffset] EID4794PS_30("Captured EID4794PS_30",2D)=""{}
 [NoScaleOffset] EID4794PS_58("Captured EID4794PS_58",2D)=""{}
 [NoScaleOffset] EID4794PS_54("Captured EID4794PS_54",2D)=""{}
 [NoScaleOffset] EID4794PS_57("Captured EID4794PS_57",2D)=""{}
 [NoScaleOffset] EID4794PS_52("Captured EID4794PS_52",2D)=""{}
 [NoScaleOffset] EID4794PS_53("Captured EID4794PS_53",2D)=""{}
 [NoScaleOffset] EID4794PS_56("Captured EID4794PS_56",2D)=""{}
 }
 SubShader {
 Tags {"RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry"}
 Pass {
 Name "EID4794 CharacterForward" Tags {"LightMode"="EID4794CharacterForward"}
 Cull Back ZTest Equal ZWrite On Blend Off
 HLSLPROGRAM
 #pragma target 5.0
 #pragma use_dxc
 #pragma only_renderers d3d11 vulkan
 #pragma vertex EID4794Vertex
 #pragma fragment EID4794Fragment
 #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
 #include "VS_EID4794_Live.hlsl"
 #include "PS_EID4794_Live.hlsl"
 struct EID4794Input {
 float3 position:POSITION; float3 normal:NORMAL; float4 tangent:TANGENT; float4 color:COLOR;
 float2 uv:TEXCOORD0; float packed:TEXCOORD1; float previousPacked:TEXCOORD2; float input7:TEXCOORD3;
 float4 direction:TEXCOORD4; float3 previousPosition:TEXCOORD5; float3 rawPosition:TEXCOORD6;
 float4 weights:TEXCOORD7; uint4 joints:BLENDINDICES;
 };
 EID4794VS_SPIRV_Cross_Output EID4794Vertex(EID4794Input v){
 EID4794BakedPosition=v.position;EID4794BakedNormal=v.normal;EID4794BakedTangent=v.tangent;
 EID4794VS_SPIRV_Cross_Input x=(EID4794VS_SPIRV_Cross_Input)0;
 x.EID4794VS_3=v.rawPosition;x.EID4794VS_4=v.uv;x.EID4794VS_5=float3(v.packed,0,0);x.EID4794VS_6=v.color;
 x.EID4794VS_7=v.direction;x.EID4794VS_8=v.previousPosition;x.EID4794VS_9=float3(v.previousPacked,0,0);x.EID4794VS_10=float4(v.input7,0,0,1);
 x.EID4794VS_12=v.weights;x.EID4794VS_13=v.joints;x.EID4794VS_gl_InstanceIndex=0;return EID4794VS_main(x);
 }
 EID4794PS_SPIRV_Cross_Output EID4794Fragment(EID4794VS_SPIRV_Cross_Output i,bool front:SV_IsFrontFace){
 EID4794PS_SPIRV_Cross_Input x=(EID4794PS_SPIRV_Cross_Input)0;
 x.EID4794PS_3=i.EID4794VS_14;x.EID4794PS_4=i.EID4794VS_15;x.EID4794PS_5=i.EID4794VS_16;x.EID4794PS_6=i.EID4794VS_17;
 x.EID4794PS_7=i.EID4794VS_18;x.EID4794PS_8=i.EID4794VS_19;x.EID4794PS_9=i.EID4794VS_20;x.EID4794PS_10=i.EID4794VS_21;
 x.EID4794PS_11=i.EID4794VS_22;x.EID4794PS_13=i.EID4794VS_24;x.EID4794PS_gl_FragCoord=i.EID4794VS_gl_Position;x.EID4794PS_gl_FrontFacing=front;
 return EID4794PS_main(x);
 }
 ENDHLSL
 }
 }
 Fallback Off
}
