#ifndef EID209982_209983_GBUFFER_INCLUDED
#define EID209982_209983_GBUFFER_INCLUDED
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_Res31); SAMPLER(sampler_Res31);
TEXTURE2D(_Res33); SAMPLER(sampler_Res33);
CBUFFER_START(UnityPerMaterial)
float4 _P00; float4 _P01; float4 _P02; float4 _P03;
float4 _P04; float4 _P05; float4 _P06; float4 _P07;
float4 _P08; float4 _P09; float4 _P10; float4 _P11;
float4 _P12; float4 _P13; float4 _P14; float4 _P15;
float4 _P16; float4 _P17; float4 _P18; float4 _P19;
float4 _P20; float4 _P21; float4 _P22; float4 _P23; float4 _P24;
float4 _InstanceMeta;
float4 _InstanceStateYZ;
float _EID209983MipBias;
CBUFFER_END

struct Attributes209982
{
    float3 positionOS : POSITION;
    float packedBasis : TEXCOORD6;
    float4 input2 : COLOR0;
    float4 input3 : TEXCOORD3;
    float2 input4 : TEXCOORD0;
    float2 input5 : TEXCOORD1;
    float2 input6 : TEXCOORD2;
    float4 input7 : TEXCOORD4;
    uint4 input8 : BLENDINDICES0;
};
struct Varyings209982
{
    float4 positionCS : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    float2 uv1 : TEXCOORD1;
    float3 normalWS : TEXCOORD2;
    float4 tangentWS : TEXCOORD3;
    float3 currentClipXYW : TEXCOORD5;
    float3 previousClipXYW : TEXCOORD6;
    nointerpolation uint instanceIndex : TEXCOORD7;
};
float3 DecodeOctNormal209982(uint packed)
{
    float x=float((packed<<22u)>>22u), y=float((packed<<12u)>>22u);
    x=(x>=512.0)?x-1024.0:x; y=(y>=512.0)?y-1024.0:y;
    float3 n=float3(x,y,0.0)*0.0019569471478462219;
    n.z=1.0-abs(n.x)-abs(n.y);
    if(n.z<0.0) n.xy=(1.0-abs(n.yx))*(step(0.0,n.xy)*2.0-1.0);
    return normalize(n);
}
float4 DecodePackedTangent209982(uint packed,float3 n)
{
    float s=float((packed<<2u)>>22u); s=(s>=512.0)?s-1024.0:s;
    float3 seed=n.yzx-n.zxy;
    float3 t0=normalize(seed-dot(seed,n)*n);
    float signV=s<0.0?-1.0:1.0;
    float enc=1.0-abs(s)*0.0039138942956924438;
    float2 r=normalize(float2(enc,signV*(1.0-abs(enc))));
    float3 t=normalize(t0*r.x+normalize(cross(n,t0))*r.y);
    return float4(t,float((packed>>31u)&1u)*2.0-1.0);
}
Varyings209982 EID209982Vertex(Attributes209982 input)
{
    Varyings209982 o;
    uint packed=asuint(input.packedBasis);
    bool packedBasis=(packed&0x40000000u)!=0u;
    float3 normalOS=packedBasis?DecodeOctNormal209982(packed):float3(input.packedBasis,0.0,1.0);
    float4 tangentOS=packedBasis?DecodePackedTangent209982(packed,normalOS):input.input2;
    float3 positionWS=TransformObjectToWorld(input.positionOS);
    float3 normalWS=normalize(TransformObjectToWorldNormal(normalOS));
    float3 tangentWS=normalize(TransformObjectToWorldDir(tangentOS.xyz));
    float4 clip=TransformWorldToHClip(positionWS);
    o.positionCS=clip; o.uv0=input.input4; o.uv1=input.input5;
    o.normalWS=normalWS; o.tangentWS=float4(tangentWS,tangentOS.w*GetOddNegativeScale());
    o.currentClipXYW=clip.xyw; o.previousClipXYW=clip.xyw; o.instanceIndex=0u;
    return o;
}
struct GBufferOutput209983 { float4 rt0:SV_Target0; float4 rt1:SV_Target1; float4 rt2:SV_Target2; float4 rt3:SV_Target3; float4 rt4:SV_Target4; };
GBufferOutput209983 EID209983Fragment(Varyings209982 input,bool isFrontFace:SV_IsFrontFace)
{
    GBufferOutput209983 o;
    float tangentSign=input.tangentWS.w>0.0?1.0:-1.0;
    float2 uvBase=lerp(input.uv0,input.uv1,_P02.w)*_P11.xy+_P11.zw;
    float2 uvNormal=lerp(input.uv0,input.uv1,_P03.x)*_P12.xy+_P12.zw;
    float4 baseSample=SAMPLE_TEXTURE2D_BIAS(_Res31,sampler_Res31,uvBase,_EID209983MipBias);
    float4 normalSample=SAMPLE_TEXTURE2D_BIAS(_Res33,sampler_Res33,uvNormal,_P03.y+_EID209983MipBias);
    float2 rawNormalXY=normalSample.xy*2.0-1.0;
    float2 filteredNormalXY=float2(abs(rawNormalXY.x)<0.012?0.0:rawNormalXY.x,abs(rawNormalXY.y)<0.012?0.0:rawNormalXY.y);
    float2 normalXY=filteredNormalXY*_P00.x;
    float3 baseColor=lerp(saturate(baseSample.rgb*_P08.rgb*_P04.z),_P08.rgb,_P04.x);
    float roughness=lerp(_P00.z,_P00.w,normalSample.z);
    float ao=lerp(1.0,normalSample.w,_P01.x);
    float materialY=lerp(baseSample.a,_P04.y,saturate(_P03.w-1.0));
    float faceSign=isFrontFace?1.0:(_P01.w>0.0?-1.0:1.0);
    float tangentZ=sqrt(saturate(1.0-dot(filteredNormalXY,filteredNormalXY)))*faceSign;
    float3 n=normalize(input.normalWS),t=normalize(input.tangentWS.xyz);
    float3 b=normalize(cross(n,t))*tangentSign;
    float3 normalWS=normalize(t*normalXY.x+b*normalXY.y+n*tangentZ);
    uint materialId=(uint)_InstanceMeta.w;
    float materialZ=(saturate(_P04.w*roughness+_P05.y*materialY+_P05.x)*0.95+0.05)*(1.0-_P07.y);
    float active=saturate(float((int)sign(max(_InstanceStateYZ.x,_InstanceStateYZ.y)-0.10000002384)));
    float2 motion=input.currentClipXYW.xy/max(input.currentClipXYW.z,1e-8)-input.previousClipXYW.xy/max(input.previousClipXYW.z,1e-8);
    motion.y=-motion.y;
    float2 encodedMotion=lerp(sqrt(sqrt(abs(motion*0.5)))*(float2)(int2)sign(motion)*0.5+0.5,0.5.xx,active.xx);
    float motionWeight=lerp(0.0,0.7,active);
    float2 oct=normalWS.xz/dot(1.0.xxx,abs(normalWS));
    if(normalWS.y<=0.0) oct=(1.0-abs(oct.yx))*(step(0.0,oct)*2.0-1.0);
    oct=oct*0.5+0.5;
    o.rt0=float4(0,0,0,0.5);
    o.rt1=float4(encodedMotion,motionWeight>0.0?1.0:_P07.x,motionWeight);
    o.rt2=float4(materialY,ao,materialZ,float(materialId/4u)*0.3333333433);
    o.rt3=float4(oct,roughness,float(materialId%4u)*0.3333333433);
    o.rt4=float4(baseColor,0.0);
    return o;
}
#endif
