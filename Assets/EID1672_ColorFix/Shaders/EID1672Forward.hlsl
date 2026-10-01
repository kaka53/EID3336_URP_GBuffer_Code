#ifdef EID_LIVE_MVP
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
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
    float4 _FS49_21;
    float4 _FS49_22;
    float4 _FS49_23;
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
#define FS_49_m35 _FS49_14.x
#define FS_49_m36 _FS49_14.y
#define FS_49_m37 _FS49_14.z
#define FS_49_m38 _FS49_14.w
#define FS_49_m39 _FS49_15
#define FS_49_m40 _FS49_16
#define FS_49_m41 _FS49_17
#define FS_49_m42 _FS49_18
#define FS_49_m43 _FS49_19
#define FS_49_m44 _FS49_20
#define FS_49_m45 _FS49_21
#define FS_49_m46 _FS49_22.x
#define FS_49_m47 _FS49_22.y
#define FS_49_m48 _FS49_22.z
#define FS_49_m49 _FS49_22.w
#define FS_49_m50 _FS49_23.x
#define FS_49_m51 _FS49_23.y
#define FS_49_m52 _FS49_23.z
#define FS_49_m53 _FS49_23.w
#define VS_33_m28 _FS49_10
#endif
#endif

#include "../../ColourPass6_VS215441_PS215442_Batch/Shaders/EID4765/VS.hlsl"
#include "EID1672ForwardFS.hlsl"

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
    VSSPIRV_Cross_Output o = (VSSPIRV_Cross_Output)0;
    float3 positionWS = TransformObjectToWorld(stage_input.position);
    float4 clip = TransformWorldToHClip(positionWS);
    o.VSgl_Position = clip;
    o.VS_13 = stage_input.uv * _FS49_10.xy + _FS49_10.zw;
    o.VS_14 = positionWS - _WorldSpaceCameraPos;
    o.VS_15 = normalize(TransformObjectToWorldNormal(stage_input.bakedNormalOS));
    o.VS_16 = float4(normalize(TransformObjectToWorldDir(stage_input.bakedTangentOS.xyz)),stage_input.bakedTangentOS.w * GetOddNegativeScale());
    o.VS_17 = clip.xyw;
    o.VS_18 = clip.xyw;
    o.VS_19 = stage_input.bakedNormalOS;
    o.VS_20 = stage_input.position;
    return o;
}

// Preserve both captured attachments, including the auxiliary material/motion data.
FSSPIRV_Cross_Output EIDLiveFragment(FSSPIRV_Cross_Input i)
{
    return FSmain(i);
}
#endif
