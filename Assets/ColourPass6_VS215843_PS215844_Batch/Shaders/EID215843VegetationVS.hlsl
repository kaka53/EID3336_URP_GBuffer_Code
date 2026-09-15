#include "EID215843CapturedConstants.hlsl"

static float4 VSglXPosition;
static int VSglXInstanceIndex;
static float3 VSX3;
static float3 VSX4;
static float4 VSX5;
static float4 VSX6;
static float2 VSX7;
static float2 VSX12;
static float3 VSX14;
static float4 VSX15;
static float4 VSXExtra;
static float3 VSX16;
static float3 VSX17;
static uint VSX19;

struct EID215843Instance
{
    float4 r0;
    float4 r1;
    float4 r2;
    float4 r3;
    float4 m1;
    float4 m2;
};
StructuredBuffer<EID215843Instance> _EID215843Instances;

float4x4 EID215843ObjectToWorldMatrix()
{
    EID215843Instance rec = _EID215843Instances[(uint)max(VSglXInstanceIndex, 0)];
    return float4x4(
        rec.r0.x, rec.r1.x, rec.r2.x, rec.r3.x,
        rec.r0.y, rec.r1.y, rec.r2.y, rec.r3.y,
        rec.r0.z, rec.r1.z, rec.r2.z, rec.r3.z,
        rec.r0.w, rec.r1.w, rec.r2.w, rec.r3.w);
}

struct EID215843VSInputInternal
{
    float3 VSX3 : TEXCOORD0;
    float3 VSX4 : TEXCOORD1;
    float4 VSX5 : TEXCOORD2;
    float4 VSX6 : TEXCOORD3;
    float2 VSX7 : TEXCOORD4;
    uint VSglXInstanceIndex : SV_InstanceID;
};

struct EID215843VertexVaryings
{
    float2 VSX12 : TEXCOORD0;
    float3 VSX14 : TEXCOORD2;
    float4 VSX15 : TEXCOORD3;
    float4 VSXExtra : TEXCOORD4;
    float3 VSX16 : TEXCOORD5;
    float3 VSX17 : TEXCOORD6;
    nointerpolation uint VSX19 : TEXCOORD8;
    UNITY_VERTEX_INPUT_INSTANCE_ID
    precise float4 VSglXPosition : SV_Position;
};

void vert_main()
{
    float4x4 objectToWorld = EID215843ObjectToWorldMatrix();
    float3 translation = float3(objectToWorld[0].w, objectToWorld[1].w, objectToWorld[2].w);
    float3x3 basis = float3x3(objectToWorld[0].xyz, objectToWorld[1].xyz, objectToWorld[2].xyz);

    uint packedBits = asuint(VSX4.x);
    bool packed = (packedBits & 1073741824u) > 0u;
    float4 tangent;
    float3 normal;
    if (packed)
    {
        float octX = float((packedBits << 22u) >> 22u);
        float octY = float((packedBits << 12u) >> 22u);
        float tanEnc = float((packedBits << 2u) >> 22u);
        float3 octa = float3((octX >= 512.0f) ? (octX - 1024.0f) : octX, (octY >= 512.0f) ? (octY - 1024.0f) : octY, 0.0f) * 0.0020f;
        float z = (1.0f - abs(octa.x)) - abs(octa.y);
        octa.z = z;
        if (z < 0.0f)
        {
            float2 folded = (1.0f.xx - abs(octa.yx)) * ((step(0.0f.xx, octa.xy) * 2.0f) - 1.0f.xx);
            octa.xy = folded;
        }
        normal = normalize(octa);
        float t = ((tanEnc >= 512.0f) ? (tanEnc - 1024.0f) : tanEnc) * 0.0020f;
        float3 ortho = normal.yzx - normal.zxy;
        float3 t0 = normalize(ortho - dot(ortho, normal));
        float signBit = (t < 0.0f) ? (-1.0f) : 1.0f;
        float oneMinus = 1.0f - ((t * signBit) * 2.0f);
        float3 t1 = mul(normalize(float2(oneMinus, signBit * (1.0f - abs(oneMinus)))), float2x3(t0, normalize(cross(normal, t0))));
        tangent = float4(t1, (float((packedBits >> 31u) & 1u) * 2.0f) - 1.0f);
    }
    else
    {
        tangent = 0.0f;
        normal = VSX4;
    }
    tangent = packed ? tangent : VSX5;

    float3 worldN = mul(basis, packed ? normal : VSX4);
    float3 worldT = mul(basis, tangent.xyz);
    float3 worldPos = mul(basis, VSX3) + translation;

    float4 clipPos = mul(UNITY_MATRIX_VP, float4(worldPos, 1.0f));
    VSglXPosition = clipPos;
    VSX12 = VSX7;
    VSX14 = worldN * rsqrt(max(1.17549435e-38f, dot(worldN, worldN)));
    VSX15 = float4(worldT * rsqrt(max(1.17549435e-38f, dot(worldT, worldT))), tangent.w);
    VSXExtra = VSX6;
    VSX16 = clipPos.xyw;
    VSX17 = clipPos.xyw;
    VSX19 = uint(VSglXInstanceIndex);
}

EID215843VertexVaryings EID215843VSGeneratedMain(EID215843VSInputInternal stage_input)
{
    VSglXInstanceIndex = int(stage_input.VSglXInstanceIndex);
    VSX3 = stage_input.VSX3;
    VSX4 = stage_input.VSX4;
    VSX5 = stage_input.VSX5;
    VSX6 = stage_input.VSX6;
    VSX7 = stage_input.VSX7;
    vert_main();
    EID215843VertexVaryings stage_output;
    stage_output.VSglXPosition = VSglXPosition;
    stage_output.VSX12 = VSX12;
    stage_output.VSX14 = VSX14;
    stage_output.VSX15 = VSX15;
    stage_output.VSXExtra = VSXExtra;
    stage_output.VSX16 = VSX16;
    stage_output.VSX17 = VSX17;
    stage_output.VSX19 = VSX19;
    return stage_output;
}

struct EID215843VertexInput
{
    float3 position : POSITION;
    float3 normal : NORMAL;
    float4 tangent : TANGENT;
    float4 extra : TEXCOORD2;
    float2 uv0 : TEXCOORD0;
    float2 uv1 : TEXCOORD1;
    float instanceIndex : TEXCOORD3;
};

EID215843VertexVaryings EID215843VertexMain(EID215843VertexInput i)
{
    EID215843VSInputInternal x;
    x.VSX3 = i.position;
    x.VSX4 = i.normal;
    x.VSX5 = i.tangent;
    x.VSX6 = i.extra;
    x.VSX7 = i.uv0;
    x.VSglXInstanceIndex = (uint)i.instanceIndex;
    return EID215843VSGeneratedMain(x);
}
