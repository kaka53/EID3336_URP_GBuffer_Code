struct HairInput {
 float3 position:POSITION;float3 normal:NORMAL;float4 tangent:TANGENT;float4 color:COLOR;float2 uv:TEXCOORD0;float packed:TEXCOORD1;
 float previousPacked:TEXCOORD2;float input7:TEXCOORD3;float4 direction:TEXCOORD4;float3 previousPosition:TEXCOORD5;float3 rawPosition:TEXCOORD6;float4 weights:TEXCOORD7;uint4 joints:BLENDINDICES;
};
EID4883VS_SPIRV_Cross_Output EID4883Vertex(HairInput v){
 EID4883BakedPosition=v.position;EID4883BakedNormal=v.normal;EID4883BakedTangent=v.tangent;
 EID4883VS_SPIRV_Cross_Input x=(EID4883VS_SPIRV_Cross_Input)0;
 x.EID4883VS_3=v.rawPosition;x.EID4883VS_4=v.uv;x.EID4883VS_5=float3(v.packed,0,0);x.EID4883VS_6=v.color;
 x.EID4883VS_7=v.direction.xy;x.EID4883VS_8=v.direction;x.EID4883VS_10=v.weights;x.EID4883VS_11=v.joints;x.EID4883VS_gl_InstanceIndex=0;
 return EID4883VS_main(x);
}
