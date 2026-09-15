#include "EID215843CapturedConstants.hlsl"

Texture2D<float4> _Res25 : register(t3);
SamplerState sampler_linear_repeat : register(s1);
Texture2D<float4> _Res27 : register(t2);
SamplerState sampler_point_repeat : register(s0);

static const float EID215844PSMipBias = -1.0;
static const float4 EID215844PSViewDirection = float4(-1.95365804e-08, -0.573576391, -0.819151998, 0.0);

static bool PSglXFrontFacing;
static float2 PSX3;
static float3 PSX4;
static float4 PSX5;
static float4 PSXExtra;
static float3 PSX6;
static float3 PSX7;
static uint PSX9;
static float4 PSX11;
static float4 PSX12;
static float4 PSX13;
static float4 PSX14;
static float4 PSX15;

struct EID215843FragmentVaryings
{
    float2 _3 : TEXCOORD0;
    float3 _4 : TEXCOORD2;
    float4 _5 : TEXCOORD3;
    float4 _extra : TEXCOORD4;
    float3 _6 : TEXCOORD5;
    float3 _7 : TEXCOORD6;
    nointerpolation uint _9 : TEXCOORD8;
    UNITY_VERTEX_INPUT_INSTANCE_ID
    bool PSglXFrontFacing : SV_IsFrontFace;
};

struct EID215843GBufferOutput
{
    float4 _11 : SV_Target0;
    float4 _15 : SV_Target1;
    float4 _12 : SV_Target2;
    float4 _13 : SV_Target3;
    float4 _14 : SV_Target4;
};

float3 EID215844DecodeDXT5nm(float2 xy, float scale, float twoSided)
{
    float4 n = float4(xy, 0.0f, 0.0f) * float4(2.0f, 2.0f, 0.0f, 0.0f) + float4(-1.0f, -1.0f, 1.0f, -1.0f);
    float d = dot(n.xyz, -n.xyw);
    n.z = d;
    float s = sqrt(max(d, 0.0f));
    float3 ts = float3(n.xy * s, n.z) * 2.0f + float3(0.0f, 0.0f, -1.0f);
    float3 scaled = float3(ts.xy * scale, ts.z);
    float3 nrm = normalize(scaled);
    return float3(nrm.xy * twoSided, nrm.z);
}

void EID215843PSFragmentBody()
{
    float signBit = (PSX5.w > 0.0f) ? 1.0f : (-1.0f);
    float3 tangent = PSX5.xyz;
    float3x3 tbn = float3x3(tangent * 1.0f, (cross(PSX4, tangent) * signBit) * 1.0f, PSX4 * 1.0f);
    float extraX = PSXExtra.x;
    float extraY = PSXExtra.y;
    float twoSided = lerp(1.0f, float(PSglXFrontFacing ? 1 : (-1)), step(0.5f, _P03.x + extraX + extraY));

    float4 albedoSample = _Res25.SampleBias(sampler_linear_repeat, PSX3, EID215844PSMipBias);
    float3 tinted = saturate(albedoSample.xyz * _P09.xyz * _P06.x);
    tinted = lerp(tinted, _P09.xyz, _P05.www);
    float3 albedo = extraX != 0.0f ? albedoSample.xyz : tinted;

    float4 nm = _Res27.SampleBias(sampler_point_repeat, PSX3, EID215844PSMipBias);
    float3 ts = EID215844DecodeDXT5nm(nm.xy, _P01.x, twoSided);
    float3 worldN = mul(ts, tbn);
    worldN = (worldN * rsqrt(max(1.17549435e-38f, dot(worldN, worldN)))) * twoSided;

    float ndotl = saturate(dot(worldN, -EID215844PSViewDirection.xyz));
    float distFade = 1.0f;
    if (_P06.y != 0.0f)
    {
        EID215843Instance rec = _EID215843Instances[PSX9];
        distFade = smoothstep(60.0f, 50.0f, length(_WorldSpaceCameraPos - rec.r3.xyz));
    }
    float roughA;
    float extraMask;
    if (_P06.z < 0.5f)
    {
        roughA = lerp(_P04.y, _P04.z, 0.8f);
        extraMask = (_P02.w * nm.z) * distFade;
    }
    else
    {
        roughA = lerp(_P04.y, _P04.z, nm.z);
        extraMask = _P02.w * distFade;
    }
    float roughness = lerp(roughA, nm.z, extraX);
    extraMask = lerp(extraMask, 0.0f, extraX);
    float ao = lerp(saturate(lerp(1.0f, nm.w, _P03.y)), nm.w, extraX);
    float packedClass = lerp(_P02.z, 0.0f, extraX);
    float wrapNdotL = dot(worldN, EID215844PSViewDirection.xyz) * 0.5f + 0.5f;
    float wrapLit = saturate(1.0f - (pow(wrapNdotL, _P05.z) * _P05.y));
    wrapLit *= lerp(lerp(1.0f, nm.w, _P03.z), 1.0f, extraX);
    float extraPacked = lerp(_P03.w, 0.0f, extraX);

    float2 maskSmooth = smoothstep(_P08.xz, _P08.xz + _P08.yw, ao.xx);
    float maskA = extraMask * maskSmooth.x;
    float classPacked = packedClass * maskSmooth.y;

    uint classU = (uint)round(classPacked * 31.0f);
    uint extraU = (uint)round(extraPacked * 31.0f);
    PSX12 = float4(
        float(((uint)round(maskA * 127.0f) << 3u) | ((classU >> 2u) & 7u)) * 0.0010f,
        float(((uint)round(wrapLit * 127.0f) << 3u) | (uint)round(3.5f)) * 0.0010f,
        float(((uint)round(ndotl * 127.0f) << 3u) | ((extraU >> 2u) & 7u)) * 0.0010f,
        float(classU & 3u) * 0.3333f);

    float3 nEnc = normalize(worldN);
    float2 oct = nEnc.xz / dot(1.0f.xxx, abs(nEnc)).xx;
    float3 packedN;
    if (nEnc.y <= 0.0f)
    {
        float2 folded = (1.0f.xx - abs(oct.yx)) * float2(oct.x >= 0.0f ? 1.0f : -1.0f, oct.y >= 0.0f ? 1.0f : -1.0f);
        packedN = float3(folded.x, nEnc.y, folded.y);
    }
    else
        packedN = float3(oct.x, nEnc.y, oct.y);
    PSX13 = float4((packedN.xz * 0.5f) + 0.5f, roughness, float(extraU & 3u) * 0.3333f);
    PSX14 = float4(albedo, ao);

    float2 motion = (PSX6.xy / max(PSX6.z, 0.0f)) - (PSX7.xy / max(PSX7.z, 0.0f));
    motion.y = -motion.y;
    float2 enc = (sqrt(sqrt(abs(motion * 0.5f))) * float2(int2(sign(motion)))) * 0.5f + 0.5f;
    PSX15 = float4(enc, 0.0f, 0.0f);
    PSX11 = float4(0.0f, 0.0f, 0.0f, 0.5f);
}

EID215843GBufferOutput EID215843PSGeneratedMain(EID215843FragmentVaryings stage_input)
{
    PSglXFrontFacing = stage_input.PSglXFrontFacing;
    PSX3 = stage_input._3;
    PSX4 = stage_input._4;
    PSX5 = stage_input._5;
    PSXExtra = stage_input._extra;
    PSX6 = stage_input._6;
    PSX7 = stage_input._7;
    PSX9 = stage_input._9;
    EID215843PSFragmentBody();
    EID215843GBufferOutput stage_output;
    stage_output._11 = PSX11;
    stage_output._12 = PSX12;
    stage_output._13 = PSX13;
    stage_output._14 = PSX14;
    stage_output._15 = PSX15;
    return stage_output;
}

EID215843GBufferOutput EID215843FragmentMain(EID215843FragmentVaryings i, bool frontFace : SV_IsFrontFace)
{
    i.PSglXFrontFacing = frontFace;
    return EID215843PSGeneratedMain(i);
}
