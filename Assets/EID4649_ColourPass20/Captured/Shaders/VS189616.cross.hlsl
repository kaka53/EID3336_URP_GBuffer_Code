static float4 gl_Position;
static int gl_VertexIndex;
struct SPIRV_Cross_Input
{
    uint gl_VertexIndex : SV_VertexID;
};

struct SPIRV_Cross_Output
{
    float4 gl_Position : SV_Position;
};

void vert_main()
{
    float _24 = float((uint(gl_VertexIndex) << 1u) & 2u);
    float _26 = float(uint(gl_VertexIndex) & 2u);
    float2 _29 = (float2(_24, _26) * 2.0f) - 1.0f.xx;
    float4 _32 = float4(_29, 1.0f, 1.0f);
    _32.z = 0.0f;
    _32.y = -_29.y;
    gl_Position = _32;
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_VertexIndex = int(stage_input.gl_VertexIndex);
    vert_main();
    SPIRV_Cross_Output stage_output;
    stage_output.gl_Position = gl_Position;
    return stage_output;
}
