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
    float4 unity_SHAr; float4 unity_SHAg; float4 unity_SHAb;
    float4 unity_SHBr; float4 unity_SHBg; float4 unity_SHBb; float4 unity_SHC;
    float4 unity_RendererBounds_Min; float4 unity_RendererBounds_Max;
    float4x4 unity_MatrixPreviousM; float4x4 unity_MatrixPreviousMI; float4 unity_MotionVectorsParams;
};
float4x4 unity_MatrixVP;
float3 _WorldSpaceCameraPos;
#endif
#define EID_LIVE_MVP 1
#define EID_LIVE_PER_MATERIAL 1
