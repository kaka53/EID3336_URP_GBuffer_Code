#include "EID215839CapturedConstants.hlsl"

#define EID3863_INSTANCE_MATERIAL2 (_EID215839Instances[PSX9].m2)
#define EID3863P28_m5 _EID3863DoubleSidedNormal
#define EID3863P28_m9 _EID3863MaterialClass
#define EID3863P28_m10 _EID3863PackedNormalWeight
#define EID3863P28_m14 _EID3863NormalMaskWeight
#define EID3863P28_m15 _EID3863RoughnessMaskWeight
#define EID3863P28_m20 _EID3863BaseColorReplaceWeight
#define EID3863P28_m21 _EID3863BaseColorMultiplier
#define EID3863P28_m32 _EID3863BaseColorTint
#define EID3863P28_m33 _EID3863OpacityDistanceParams
#define EID3863P28_m34 _EID3863MaterialDistanceParams

Texture2D<float4> _Res23 : register(t4);
SamplerState sampler_linear_mirror : register(s2);
Texture2D<float4> _Res25 : register(t3);
SamplerState sampler_point_repeat : register(s1);

static const float EID3863PSMipBias = -1.0;
static const float4 EID3863PSViewDirection = float4(-1.95365804e-08, -0.573576391, -0.819151998, 0.0);

static bool PSglXFrontFacing;
static float2 PSX3;
static float3 PSX4;
static float4 PSX5;
static float3 PSX6;
static float3 PSX7;
static float3 PSX8;
static uint PSX9;
static float4 PSX11;
static float4 PSX12;
static float4 PSX13;
static float4 PSX14;
static float4 PSX15;

struct EID3863FragmentVaryings
{
    float2 _3 : TEXCOORD0;
    float3 _4 : TEXCOORD2;
    float4 _5 : TEXCOORD3;
    float3 _6 : TEXCOORD4;
    float3 _7 : TEXCOORD5;
    float3 _8 : TEXCOORD6;
    nointerpolation uint _9 : TEXCOORD7;
    UNITY_VERTEX_INPUT_INSTANCE_ID
    bool PSglXFrontFacing : SV_IsFrontFace;
};

struct EID3863GBufferOutput
{
    float4 _11 : SV_Target0;
    float4 _15 : SV_Target1;
    float4 _12 : SV_Target2;
    float4 _13 : SV_Target3;
    float4 _14 : SV_Target4;
};

float3 EID215840DecodeDXT5nm(float2 xy, float twoSided)
{
    float4 n = float4(xy, 0.0f, 0.0f) * float4(2.0f, 2.0f, 0.0f, 0.0f) + float4(-1.0f, -1.0f, 1.0f, -1.0f);
    float d = dot(n.xyz, -n.xyw);
    n.z = d;
    float s = sqrt(max(d, 0.0f));
    float3 ts = float3(n.xy * s, n.z) * 2.0f + float3(0.0f, 0.0f, -1.0f);
    return float3(ts.xy * twoSided, ts.z);
}

void EID3863PSFragmentBody()
{
    float signBit = (PSX5.w > 0.0f) ? 1.0f : (-1.0f);
    float3 tangent = PSX5.xyz;
    float3x3 tbn = float3x3(tangent * 1.0f, (cross(PSX4, tangent) * signBit) * 1.0f, PSX4 * 1.0f);
    float twoSided = (EID3863P28_m5 > 0.0f) ? float((PSglXFrontFacing ? 1 : (-1))) : 1.0f;

    float4 nm = _Res25.SampleBias(sampler_point_repeat, PSX3, EID3863PSMipBias);
    float3 ts = EID215840DecodeDXT5nm(nm.xy, twoSided);
    float3 worldN = mul(ts, tbn);
    worldN = (worldN * rsqrt(max(1.17549435e-38f, dot(worldN, worldN)))) * twoSided;

    float distFade = clamp(lerp(EID3863P28_m34.z, 1.0f, clamp((max(length(PSX8 + float3(0.0f, EID3863P28_m34.w, 0.0f)) - EID3863P28_m34.w, 0.0f) - EID3863P28_m34.x) * EID3863P28_m34.y, 0.0f, 1.0f)), 0.0f, 1.0f);
    float nMask = distFade * lerp(1.0f, nm.z, EID3863P28_m14);
    float rMask = distFade * lerp(1.0f, nm.z, EID3863P28_m15);
    uint matClass = uint(round(EID3863P28_m9 * 31.0f));
    uint extra = uint(round(0.0f));
    float ndotl = clamp(dot(worldN, -EID3863PSViewDirection.xyz), 0.0f, 1.0f);
    PSX12 = float4(
        float((uint(round(((0.5f * EID3863P28_m10) * (1.0f - abs(nMask - rMask))) * 127.0f)) << 3u) | ((matClass >> 2u) & 7u)) * 0.0010f,
        float((uint(round(max(nMask, rMask) * 127.0f)) << 3u) | uint(round(3.5f))) * 0.0010f,
        float((uint(round(ndotl * 127.0f)) << 3u) | ((extra >> 2u) & 7u)) * 0.0010f,
        float(matClass & 3u) * 0.3333333432674407958984375f);

    float4 nm2 = _Res25.SampleBias(sampler_point_repeat, PSX3, EID3863PSMipBias);
    float3 ts2 = EID215840DecodeDXT5nm(nm2.xy, twoSided);
    float3 worldN2 = normalize(mul(ts2, tbn) * rsqrt(max(1.17549435e-38f, dot(mul(ts2, tbn), mul(ts2, tbn)))) * twoSided);
    float2 oct = worldN2.xz / dot(1.0f.xxx, abs(worldN2)).xx;
    float3 packed;
    if (worldN2.y <= 0.0f)
    {
        float2 folded = (1.0f.xx - abs(oct.yx)) * float2(oct.x >= 0.0f ? 1.0f : -1.0f, oct.y >= 0.0f ? 1.0f : -1.0f);
        packed = float3(folded.x, worldN2.y, folded.y);
    }
    else
        packed = float3(oct.x, worldN2.y, oct.y);
    PSX13 = float4((packed.xz * 0.5f) + 0.5f, nm2.w, float(extra & 3u) * 0.3333333432674407958984375f);

    float3 albedo = clamp(_Res23.SampleBias(sampler_linear_mirror, PSX3, EID3863PSMipBias).xyz * EID3863P28_m32.xyz * EID3863P28_m21, 0.0f, 1.0f);
    albedo = lerp(albedo, EID3863P28_m32.xyz, EID3863P28_m20.xxx);
    albedo = clamp(lerp(albedo, EID3863_INSTANCE_MATERIAL2.xyz, EID3863_INSTANCE_MATERIAL2.w.xxx), 0.0f, 1.0f);
    float opacity = clamp(lerp(EID3863P28_m33.z, 1.0f, clamp((max(length(PSX8 + float3(0.0f, EID3863P28_m33.w, 0.0f)) - EID3863P28_m33.w, 0.0f) - EID3863P28_m33.x) * EID3863P28_m33.y, 0.0f, 1.0f)), 0.0f, 1.0f);
    PSX14 = float4(albedo, opacity);

    float2 motion = (PSX6.xy / max(PSX6.z, 1e-8f)) - (PSX7.xy / max(PSX7.z, 1e-8f));
    motion.y = -motion.y;
    float2 enc = (sqrt(sqrt(abs(motion * 0.5f))) * float2(int2(sign(motion)))) * 0.5f + 0.5f;
    PSX15 = float4(enc, 0.0f, 0.0f);
    PSX11 = float4(0.0f, 0.0f, 0.0f, 1.0f);
}

EID3863GBufferOutput EID3863PSGeneratedMain(EID3863FragmentVaryings stage_input)
{
    PSglXFrontFacing = stage_input.PSglXFrontFacing;
    PSX3 = stage_input._3;
    PSX4 = stage_input._4;
    PSX5 = stage_input._5;
    PSX6 = stage_input._6;
    PSX7 = stage_input._7;
    PSX8 = stage_input._8;
    PSX9 = stage_input._9;
    EID3863PSFragmentBody();
    EID3863GBufferOutput stage_output;
    stage_output._11 = PSX11;
    stage_output._12 = PSX12;
    stage_output._13 = PSX13;
    stage_output._14 = PSX14;
    stage_output._15 = PSX15;
    return stage_output;
}

EID3863GBufferOutput EID3863FragmentMain(EID3863FragmentVaryings i, bool frontFace : SV_IsFrontFace)
{
    i.PSglXFrontFacing = frontFace;
    return EID3863PSGeneratedMain(i);
}
