// Generated from Capture/vs.spv by SPIRV-Cross; do not hand-edit.
static float4 EID_VSgl_Position;
static int EID_VSgl_VertexIndex;
static float2 EID_VS_4;

struct EID_VS_Input
{
    uint EID_VSgl_VertexIndex : SV_VertexID;
};

struct EID_VS_Output
{
    float2 EID_VS_4 : TEXCOORD0;
    float4 EID_VSgl_Position : SV_Position;
};

void EID_VSvert_main()
{
    float EID_VS_24 = float((uint(EID_VSgl_VertexIndex) << 1u) & 2u);
    float EID_VS_26 = float(uint(EID_VSgl_VertexIndex) & 2u);
    float2 EID_VS_29 = (float2(EID_VS_24, EID_VS_26) * 2.0f) - 1.0f.xx;
    float4 EID_VS_32 = float4(EID_VS_29, 1.0f, 1.0f);
    EID_VS_32.z = 0.0f;
    EID_VS_32.y = -EID_VS_29.y;
    EID_VSgl_Position = EID_VS_32;
    EID_VS_4 = float2(EID_VS_24, 1.0f - EID_VS_26);
}

EID_VS_Output EID_OriginalVS(EID_VS_Input stage_input)
{
    EID_VSgl_VertexIndex = int(stage_input.EID_VSgl_VertexIndex);
    EID_VSvert_main();
    EID_VS_Output stage_output;
    stage_output.EID_VSgl_Position = EID_VSgl_Position;
    stage_output.EID_VS_4 = EID_VS_4;
    return stage_output;
}
