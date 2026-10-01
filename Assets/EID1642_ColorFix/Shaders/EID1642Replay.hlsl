#ifdef EID_LIVE_MVP
#ifndef UNITY_SHADER_VARIABLES_INCLUDED
cbuffer UnityPerDraw
{
    float4x4 unity_ObjectToWorld;
    float4x4 unity_WorldToObject;
    float4 unity_LODFade;
    float4 unity_WorldTransformParams;
    float4 unity_RenderingLayer;
    float4 unity_LightData;
    float4 unity_LightIndices[2];
    float4 unity_ProbesOcclusion;
    float4 unity_SpecCube0_HDR;
    float4 unity_SpecCube1_HDR;
    float4 unity_SpecCube0_BoxMax;
    float4 unity_SpecCube0_BoxMin;
    float4 unity_SpecCube0_ProbePosition;
    float4 unity_SpecCube1_BoxMax;
    float4 unity_SpecCube1_BoxMin;
    float4 unity_SpecCube1_ProbePosition;
    float4 unity_LightmapST;
    float4 unity_DynamicLightmapST;
    float4 unity_SHAr;
    float4 unity_SHAg;
    float4 unity_SHAb;
    float4 unity_SHBr;
    float4 unity_SHBg;
    float4 unity_SHBb;
    float4 unity_SHC;
    float4 unity_RendererBounds_Min;
    float4 unity_RendererBounds_Max;
    float4x4 unity_MatrixPreviousM;
    float4x4 unity_MatrixPreviousMI;
    float4 unity_MotionVectorsParams;
};
float4x4 unity_MatrixVP;
float3 _WorldSpaceCameraPos;
#endif
#ifdef EID_LIVE_PER_MATERIAL
cbuffer UnityPerMaterial
{
    float4 _P00; float4 _P01; float4 _P02; float4 _P03;
    float4 _P04; float4 _P05; float4 _P06; float4 _P07;
    float4 _P08; float4 _P09; float4 _P10; float4 _P11;
    float4 _P12; float4 _P13; float4 _P14; float4 _P15;
    float4 _P16; float4 _P17;
    float4 _InstancePacked;
    float _EID215444MipBias;
    float _UseBakedSkinning;
    float4 _FS49_00;
    float4 _FS49_01;
    float4 _FS49_02;
    float4 _FS49_03;
    float4 _FS49_04;
    float4 _FS49_05;
    float4 _FS49_06;
    float4 _FS49_07;
    float4 _FS49_08;
    float4 _FS49_09;
    float4 _FS49_10;
    float4 _FS49_11;
    float4 _FS49_12;
    float4 _FS49_13;
    float4 _FS49_14;
    float4 _FS49_15;
    float4 _FS49_16;
    float4 _FS49_17;
    float4 _FS49_18;
    float4 _FS49_19;
    float4 _FS49_20;
};
#define FS_49_m0 _FS49_00.x
#define FS_49_m1 _FS49_00.y
#define FS_49_m2 _FS49_00.z
#define FS_49_m3 _FS49_00.w
#define FS_49_m4 _FS49_01.x
#define FS_49_m5 _FS49_01.y
#define FS_49_m6 _FS49_01.z
#define FS_49_m7 _FS49_01.w
#define FS_49_m8 _FS49_02.x
#define FS_49_m9 _FS49_02.y
#define FS_49_m10 _FS49_02.z
#define FS_49_m11 _FS49_02.w
#define FS_49_m12 _FS49_03.x
#define FS_49_m13 _FS49_03.y
#define FS_49_m14 _FS49_03.z
#define FS_49_m15 _FS49_03.w
#define FS_49_m16 _FS49_04.x
#define FS_49_m17 _FS49_04.y
#define FS_49_m18 _FS49_04.z
#define FS_49_m19 _FS49_04.w
#define FS_49_m20 _FS49_05.x
#define FS_49_m21 _FS49_05.y
#define FS_49_m22 _FS49_05.z
#define FS_49_m23 _FS49_05.w
#define FS_49_m24 _FS49_06
#define FS_49_m25 _FS49_07
#define FS_49_m26 _FS49_08
#define FS_49_m27 _FS49_09
#define FS_49_m28 _FS49_10
#define FS_49_m29 _FS49_11
#define FS_49_m30 _FS49_12.x
#define FS_49_m31 _FS49_12.y
#define FS_49_m32 _FS49_12.z
#define FS_49_m33 _FS49_12.w
#define FS_49_m34 _FS49_13
#define FS_49_m35 _FS49_14
#define FS_49_m36 _FS49_15
#define FS_49_m37 _FS49_16
#define FS_49_m38 _FS49_17
#define FS_49_m39 _FS49_18
#define FS_49_m40 _FS49_19.x
#define FS_49_m41 _FS49_19.y
#define FS_49_m42 _FS49_19.z
#define FS_49_m43 _FS49_19.w
#define FS_49_m44 _FS49_20.x
#define FS_49_m45 _FS49_20.y
#define FS_49_m46 _FS49_20.z
#define FS_49_m47 _FS49_20.w
#define VS_33_m28 _FS49_10
#endif
#endif

#include "../../EID4730/Shaders/VS.hlsl"
#include "EID1642FS.hlsl"

#ifdef EID_LIVE_MVP
struct EIDLiveInput
{
    float3 position : POSITION;
    float4 packedNormal : NORMAL;
    float2 uv : TEXCOORD0;
    float4 input3 : COLOR0;
    float4 input5 : TEXCOORD3;
    uint4 input6 : BLENDINDICES0;
    float3 bakedNormalOS : TEXCOORD4;
    float4 bakedTangentOS : TEXCOORD5;
};

VSSPIRV_Cross_Output EIDLiveVertex(EIDLiveInput stage_input)
{
    VSSPIRV_Cross_Input v = (VSSPIRV_Cross_Input)0;
    v.VS_3 = stage_input.position;
    v.VS_4 = stage_input.uv;
    v.VS_5 = stage_input.bakedNormalOS;
    v.VS_6 = stage_input.bakedTangentOS;
    v.VS_7 = stage_input.bakedTangentOS;
    v.VS_8 = stage_input.position;
    v.VS_9 = stage_input.bakedNormalOS;
    v.VS_11 = stage_input.input5;
    v.VS_12 = stage_input.input6;
    v.VSgl_InstanceIndex = 0;
    return VSmain(v);
}

FSSPIRV_Cross_Output EIDLiveFragment(FSSPIRV_Cross_Input i)
{
    return FSmain(i);
}
#else
ByteAddressBuffer EIDIndices;
ByteAddressBuffer EIDVB0;
ByteAddressBuffer EIDVB1;
ByteAddressBuffer EIDVB2;
ByteAddressBuffer EIDVB4;
float4 DecodeUNorm8(uint v) { return float4(v&255u,(v>>8)&255u,(v>>16)&255u,v>>24)/255.0; }
float4 DecodeSNorm8(uint v)
{
 int4 s=int4(int(v<<24)>>24,int(v<<16)>>24,int(v<<8)>>24,int(v)>>24);
 return max(float4(s)/127.0,-1.0);
}
VSSPIRV_Cross_Output EIDVertex(uint id:SV_VertexID)
{
 uint index=EIDIndices.Load(id*4); uint p=index*16, t=index*12;
 VSSPIRV_Cross_Input v=(VSSPIRV_Cross_Input)0;
 v.VS_3=asfloat(EIDVB0.Load3(p));
 v.VS_4=asfloat(EIDVB1.Load2(t));
 v.VS_5=float3(asfloat(EIDVB0.Load(p+12)),0,0);
 v.VS_6=DecodeUNorm8(EIDVB4.Load(12));
 v.VS_7=DecodeSNorm8(EIDVB1.Load(t+8));
 v.VS_8=v.VS_3; v.VS_9=v.VS_5;
 uint2 weights=EIDVB2.Load2(t);
 v.VS_11=float4(weights.x&65535u,weights.x>>16,weights.y&65535u,weights.y>>16)/65535.0;
 uint joints=EIDVB2.Load(t+8);
 v.VS_12=uint4(joints&255u,(joints>>8)&255u,(joints>>16)&255u,joints>>24);
 v.VSgl_InstanceIndex=0;
 VSSPIRV_Cross_Output o=VSmain(v);
 o.VSgl_Position.y=-o.VSgl_Position.y;
 return o;
}

Texture2D<float> EIDCapturedDepth;
cbuffer EIDReplaySettings : register(b12) { uint EIDDepthUlps; uint3 EIDReplayPadding; };
FSSPIRV_Cross_Output EIDFragment(FSSPIRV_Cross_Input i)
{
 #if defined(EID_PORTABLE_DEPTH)
 float captured=EIDCapturedDepth.Load(int3(int2(i.FSgl_FragCoord.xy),0));
 uint a=asuint(captured),b=asuint(i.FSgl_FragCoord.z);
 uint distance=(a>b)?a-b:b-a;
 if(!isfinite(captured)||!isfinite(i.FSgl_FragCoord.z)||distance>EIDDepthUlps)discard;
 #endif
 return FSmain(i);
}
#endif
