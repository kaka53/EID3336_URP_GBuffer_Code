Shader "Hidden/ColourPass26Hair/Back" {
Properties { _CP26ZTest("Depth",Float)=2  [NoScaleOffset] CP26BVS_34("RID 224517",2D)=""{} [NoScaleOffset] CP26BPS_37("RID 198185",2D)=""{} [NoScaleOffset] CP26BPS_34("RID 209068",2D)=""{} [NoScaleOffset] CP26BPS_38("RID 209071",2D)=""{} [NoScaleOffset] CP26BPS_35("RID 209077",2D)=""{} [NoScaleOffset] CP26BPS_45("RID 198567",3D)=""{} [NoScaleOffset] CP26BPS_43("RID 198561",3D)=""{} [NoScaleOffset] CP26BPS_41("RID 198555",3D)=""{} [NoScaleOffset] CP26BPS_44("RID 198564",3D)=""{} [NoScaleOffset] CP26BPS_42("RID 198558",3D)=""{} [NoScaleOffset] CP26BPS_40("RID 198552",3D)=""{} [NoScaleOffset] CP26BPS_50("RID 209575",3D)=""{} [NoScaleOffset] CP26BPS_36("RID 209074",2D)=""{} [NoScaleOffset] CP26BPS_48("RID 191526",2D)=""{} [NoScaleOffset] CP26BPS_49("RID 224549",2D)=""{} }
SubShader { Tags {"RenderPipeline"="UniversalPipeline"} Pass {
Name "Back"
Cull Front ZWrite On ZTest [_CP26ZTest]
Blend 0 SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
Blend 1 Off
HLSLPROGRAM
#pragma target 5.0
#pragma use_dxc
#pragma only_renderers d3d11 vulkan
#pragma vertex CP26BVertex
#pragma fragment CP26BFragment
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "CP26BVS.hlsl"
#include "CP26BPS.hlsl"
struct HairInput {
 float3 position:POSITION;float3 normal:NORMAL;float4 tangent:TANGENT;float4 color:COLOR;float2 uv:TEXCOORD0;float packed:TEXCOORD1;
 float previousPacked:TEXCOORD2;float input7:TEXCOORD3;float4 direction:TEXCOORD4;float3 previousPosition:TEXCOORD5;float3 rawPosition:TEXCOORD6;float4 weights:TEXCOORD7;uint4 joints:BLENDINDICES;
};
CP26BVS_SPIRV_Cross_Output CP26BVertex(HairInput v){
 CP26BBakedPosition=v.position;CP26BBakedNormal=v.normal;CP26BBakedTangent=v.tangent;
 CP26BVS_SPIRV_Cross_Input x=(CP26BVS_SPIRV_Cross_Input)0;
 x.CP26BVS_3=v.rawPosition;x.CP26BVS_4=v.uv;x.CP26BVS_5=float3(v.packed,0,0);x.CP26BVS_6=v.color;
 x.CP26BVS_7=v.direction.xy;x.CP26BVS_8=v.direction;x.CP26BVS_10=v.weights;x.CP26BVS_11=v.joints;x.CP26BVS_gl_InstanceIndex=0;
 return CP26BVS_main(x);
}
 CP26BPS_SPIRV_Cross_Output CP26BFragment(CP26BVS_SPIRV_Cross_Output i){
 CP26BPS_SPIRV_Cross_Input x=(CP26BPS_SPIRV_Cross_Input)0;
 x.CP26BPS_3=i.CP26BVS_12;x.CP26BPS_4=i.CP26BVS_13;x.CP26BPS_5=i.CP26BVS_14;x.CP26BPS_6=i.CP26BVS_16;x.CP26BPS_7=i.CP26BVS_17;x.CP26BPS_9=i.CP26BVS_19;x.CP26BPS_gl_FragCoord=i.CP26BVS_gl_Position;return CP26BPS_main(x);
 }

ENDHLSL
} } Fallback Off
}