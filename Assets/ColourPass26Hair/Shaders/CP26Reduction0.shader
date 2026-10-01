Shader "Hidden/ColourPass26Hair/Reduction0" {
Properties { _CP26ZTest("Depth",Float)=2  [NoScaleOffset] CP26FPS_44("RID 198185",2D)=""{} [NoScaleOffset] CP26FPS_41("RID 209068",2D)=""{} [NoScaleOffset] CP26FPS_45("RID 209071",2D)=""{} [NoScaleOffset] CP26FPS_42("RID 209077",2D)=""{} [NoScaleOffset] CP26FPS_62("RID 172",2D)=""{} [NoScaleOffset] CP26FPS_52("RID 198567",3D)=""{} [NoScaleOffset] CP26FPS_50("RID 198561",3D)=""{} [NoScaleOffset] CP26FPS_48("RID 198555",3D)=""{} [NoScaleOffset] CP26FPS_51("RID 198564",3D)=""{} [NoScaleOffset] CP26FPS_49("RID 198558",3D)=""{} [NoScaleOffset] CP26FPS_47("RID 198552",3D)=""{} [NoScaleOffset] CP26FPS_67("RID 209575",3D)=""{} [NoScaleOffset] CP26FPS_58("RID 14997",2D)=""{} [NoScaleOffset] CP26FPS_43("RID 209074",2D)=""{} [NoScaleOffset] CP26FPS_61("RID 224499",2D)=""{} [NoScaleOffset] CP26FPS_57("RID 195420",2D)=""{} [NoScaleOffset] CP26FPS_60("RID 224573",2D)=""{} [NoScaleOffset] CP26FPS_55("RID 272756",2D)=""{} [NoScaleOffset] CP26FPS_56("RID 191526",2D)=""{} [NoScaleOffset] CP26FPS_59("RID 224549",2D)=""{} }
SubShader { Tags {"RenderPipeline"="UniversalPipeline"} Pass {
Name "Front"
Cull Off ZWrite Off ZTest [_CP26ZTest]
Blend 0 Off
Blend 1 Off
HLSLPROGRAM
#pragma target 5.0
#pragma use_dxc
#pragma only_renderers d3d11 vulkan
#pragma vertex CP26FVertex
#pragma fragment CP26FFragment
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "CP26FVS.hlsl"
#include "CP26FPS.hlsl"
 struct CP26FInput {
 float3 position:POSITION; float3 normal:NORMAL; float4 tangent:TANGENT; float4 color:COLOR;
 float2 uv:TEXCOORD0; float packed:TEXCOORD1; float previousPacked:TEXCOORD2; float input7:TEXCOORD3;
 float4 direction:TEXCOORD4; float3 previousPosition:TEXCOORD5; float3 rawPosition:TEXCOORD6;
 float4 weights:TEXCOORD7; uint4 joints:BLENDINDICES;
 };
 CP26FVS_SPIRV_Cross_Output CP26FVertex(CP26FInput v){
 CP26FBakedPosition=v.position;CP26FBakedNormal=v.normal;CP26FBakedTangent=v.tangent;
 CP26FVS_SPIRV_Cross_Input x=(CP26FVS_SPIRV_Cross_Input)0;
 x.CP26FVS_3=v.rawPosition;x.CP26FVS_4=v.uv;x.CP26FVS_5=float3(v.packed,0,0);x.CP26FVS_6=v.color;
 x.CP26FVS_7=v.direction;x.CP26FVS_8=v.previousPosition;x.CP26FVS_9=float3(v.previousPacked,0,0);x.CP26FVS_10=float4(v.input7,0,0,1);
 x.CP26FVS_12=v.weights;x.CP26FVS_13=v.joints;x.CP26FVS_gl_InstanceIndex=0;return CP26FVS_main(x);
 }
 CP26FPS_SPIRV_Cross_Output CP26FFragment(CP26FVS_SPIRV_Cross_Output i){CP26FPS_SPIRV_Cross_Output o=(CP26FPS_SPIRV_Cross_Output)0;o.CP26FPS_15=float4(1,0,0,1);return o;}
ENDHLSL
} } Fallback Off
}