struct _19
{
    column_major float4x4 _m0;
    float4 _m1;
    float4 _m2;
};

static float3 PSX121 = float3(0.0f, 0.0f, 1.0f);
static float4 PSX123;

cbuffer _16_17 : register(b3)
{
    float4 _17_m0 : packoffset(c0);
    float4 _17_m1 : packoffset(c1);
    float4 _17_m2 : packoffset(c2);
    float4 _17_m3 : packoffset(c3);
    float4 _17_m4 : packoffset(c4);
    float4 _17_m5 : packoffset(c5);
    float4 _17_m6[6] : packoffset(c6);
    float4 _17_m7[6] : packoffset(c12);
    float4 _17_m8 : packoffset(c18);
    float4 _17_m9 : packoffset(c19);
    float4 _17_m10 : packoffset(c20);
    float4 _17_m11 : packoffset(c21);
    float4 _17_m12 : packoffset(c22);
    float4 _17_m13 : packoffset(c23);
    float4 _17_m14 : packoffset(c24);
    float4 _17_m15 : packoffset(c25);
    float _17_m16 : packoffset(c26);
    float _17_m17 : packoffset(c26.y);
    float _17_m18 : packoffset(c26.z);
    uint _17_m19 : packoffset(c26.w);
    float4 _17_m20 : packoffset(c27);
    int4 _17_m21 : packoffset(c28);
    float4 _17_m22 : packoffset(c29);
    float4 _17_m23 : packoffset(c30);
    float4 _17_m24 : packoffset(c31);
    float4 _17_m25 : packoffset(c32);
    float4 _17_m26 : packoffset(c33);
    float4 _17_m27 : packoffset(c34);
    float4 _17_m28 : packoffset(c35);
    float4 _17_m29 : packoffset(c36);
    float4 _17_m30 : packoffset(c37);
    float4 _17_m31 : packoffset(c38);
    float4 _17_m32[4] : packoffset(c39);
    float4 _17_m33[4] : packoffset(c43);
    float4 _17_m34[4] : packoffset(c47);
    float4 _17_m35[4] : packoffset(c51);
    float4 _17_m36 : packoffset(c55);
    float4 _17_m37 : packoffset(c56);
    float4 _17_m38[4] : packoffset(c57);
    float4 _17_m39[4] : packoffset(c61);
    float4 _17_m40[4] : packoffset(c65);
    float4 _17_m41 : packoffset(c69);
    float4 _17_m42 : packoffset(c70);
    float4 _17_m43 : packoffset(c71);
    float4 _17_m44 : packoffset(c72);
    float4 _17_m45 : packoffset(c73);
    float4 _17_m46 : packoffset(c74);
    float4 _17_m47 : packoffset(c75);
    float4 _17_m48 : packoffset(c76);
    float4 _17_m49 : packoffset(c77);
    float4 _17_m50 : packoffset(c78);
    float4 _17_m51 : packoffset(c79);
    float4 _17_m52 : packoffset(c80);
    float4 _17_m53 : packoffset(c81);
    float4 _17_m54 : packoffset(c82);
    float4 _17_m55 : packoffset(c83);
    float4 _17_m56 : packoffset(c84);
    float4 _17_m57 : packoffset(c85);
    float4 _17_m58 : packoffset(c86);
    float4 _17_m59 : packoffset(c87);
    float4 _17_m60 : packoffset(c88);
    float4 _17_m61 : packoffset(c89);
    float4 _17_m62 : packoffset(c90);
    float4 _17_m63 : packoffset(c91);
    float4 _17_m64 : packoffset(c92);
    float4 _17_m65 : packoffset(c93);
    float4 _17_m66 : packoffset(c94);
    float4 _17_m67 : packoffset(c95);
    float4 _17_m68 : packoffset(c96);
    float4 _17_m69 : packoffset(c97);
    float4 _17_m70 : packoffset(c98);
    float4 _17_m71 : packoffset(c99);
    float4 _17_m72 : packoffset(c100);
    float4 _17_m73 : packoffset(c101);
    float4 _17_m74 : packoffset(c102);
    float4 _17_m75 : packoffset(c103);
    float4 _17_m76 : packoffset(c104);
    float4 _17_m77 : packoffset(c105);
    float4 _17_m78 : packoffset(c106);
    float4 _17_m79 : packoffset(c107);
    float4 _17_m80 : packoffset(c108);
    float4 _17_m81 : packoffset(c109);
    float4 _17_m82 : packoffset(c110);
    float4 _17_m83 : packoffset(c111);
    float4 _17_m84 : packoffset(c112);
    float4 _17_m85 : packoffset(c113);
    float4 _17_m86 : packoffset(c114);
    float4 _17_m87 : packoffset(c115);
    float4 _17_m88 : packoffset(c116);
    float4 _17_m89 : packoffset(c117);
    float4 _17_m90 : packoffset(c118);
    float4 _17_m91 : packoffset(c119);
    float4 _17_m92 : packoffset(c120);
    float4 _17_m93 : packoffset(c121);
    float4 _17_m94 : packoffset(c122);
    float4 _17_m95 : packoffset(c123);
    float4 _17_m96 : packoffset(c124);
    float4 _17_m97 : packoffset(c125);
    float4 _17_m98 : packoffset(c126);
    float4 _17_m99[2] : packoffset(c127);
    float4 _17_m100[2] : packoffset(c129);
    float _17_m101 : packoffset(c131);
    float _17_m102 : packoffset(c131.y);
    float _17_m103 : packoffset(c131.z);
    float _17_m104 : packoffset(c131.w);
    float4 _17_m105 : packoffset(c132);
    float4 _17_m106 : packoffset(c133);
    float4 _17_m107 : packoffset(c134);
    float4 _17_m108 : packoffset(c135);
    float4 _17_m109 : packoffset(c136);
    float4 _17_m110 : packoffset(c137);
    float4 _17_m111 : packoffset(c138);
    float4 _17_m112 : packoffset(c139);
    float4 _17_m113 : packoffset(c140);
    float4 _17_m114 : packoffset(c141);
    float4 _17_m115 : packoffset(c142);
    float4 _17_m116 : packoffset(c143);
    float4 _17_m117 : packoffset(c144);
    float4 _17_m118 : packoffset(c145);
    float4 _17_m119 : packoffset(c146);
    float4 _17_m120 : packoffset(c147);
    float4 _17_m121 : packoffset(c148);
    float4 _17_m122 : packoffset(c149);
    float4 _17_m123 : packoffset(c150);
    float4 _17_m124 : packoffset(c151);
    float4 _17_m125 : packoffset(c152);
    float4 _17_m126 : packoffset(c153);
    float4 _17_m127 : packoffset(c154);
    float4 _17_m128 : packoffset(c155);
    float4 _17_m129 : packoffset(c156);
    float4 _17_m130 : packoffset(c157);
    float4 _17_m131 : packoffset(c158);
    float4 _17_m132 : packoffset(c159);
    float4 _17_m133 : packoffset(c160);
    float4 _17_m134 : packoffset(c161);
    column_major float4x4 _17_m135 : packoffset(c162);
    float4 _17_m136 : packoffset(c166);
    float4 _17_m137 : packoffset(c167);
    float4 _17_m138[32] : packoffset(c168);
};

// Single reconstructed plant: per-instance material override is serialized in the material.

CBUFFER_START(UnityPerMaterial)
    float _EID3863NormalStrength;
    float _EID3863DoubleSidedNormal;
    float _EID3863NormalFlatten;
    float _EID3863MaterialClass;
    float _EID3863PackedNormalWeight;
    float _EID3863RoughnessMin;
    float _EID3863RoughnessMax;
    float _EID3863NormalMaskWeight;
    float _EID3863RoughnessMaskWeight;
    float _EID3863BaseColorReplaceWeight;
    float _EID3863BaseColorMultiplier;
    float _EID3863AlphaCutoff;
    float4 _EID3863BaseColorTint;
    float4 _EID3863OpacityDistanceParams;
    float4 _EID3863MaterialDistanceParams;
CBUFFER_END

UNITY_INSTANCING_BUFFER_START(EID3863PerInstance)
    UNITY_DEFINE_INSTANCED_PROP(float4, _EID3863InstanceMaterial2)
UNITY_INSTANCING_BUFFER_END(EID3863PerInstance)

#define EID3863_INSTANCE_MATERIAL2 UNITY_ACCESS_INSTANCED_PROP(EID3863PerInstance, _EID3863InstanceMaterial2)

#define EID3863P28_m4 _EID3863NormalStrength
#define EID3863P28_m5 _EID3863DoubleSidedNormal
#define EID3863P28_m8 _EID3863NormalFlatten
#define EID3863P28_m9 _EID3863MaterialClass
#define EID3863P28_m10 _EID3863PackedNormalWeight
#define EID3863P28_m11 _EID3863RoughnessMin
#define EID3863P28_m12 _EID3863RoughnessMax
#define EID3863P28_m14 _EID3863NormalMaskWeight
#define EID3863P28_m15 _EID3863RoughnessMaskWeight
#define EID3863P28_m20 _EID3863BaseColorReplaceWeight
#define EID3863P28_m21 _EID3863BaseColorMultiplier
#define EID3863P28_m32 _EID3863BaseColorTint
#define EID3863P28_m33 _EID3863OpacityDistanceParams
#define EID3863P28_m34 _EID3863MaterialDistanceParams

cbuffer _29_30 : register(b7)
{
    float4 _30_m0 : packoffset(c0);
    float4 _30_m1 : packoffset(c1);
    float4 _30_m2 : packoffset(c2);
    float4 _30_m3 : packoffset(c3);
    float4 _30_m4 : packoffset(c4);
    uint4 _30_m5 : packoffset(c5);
    float4 _30_m6[2048] : packoffset(c6);
};

Texture2D<float4> _Res23 : register(t4);
#include "EID3863CapturedConstants.hlsl"
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

void EID3863PSFragmentBody()
{
    // EID3863 uses the alpha channel of RenderDoc PS resource 23 as the cutout mask.
    // Clip before any MRT output so transparent texels write neither GBuffer nor depth/stencil.
    float EID3863CutoutAlpha = _Res23.SampleBias(sampler_linear_mirror, PSX3, EID3863PSMipBias).a;
    clip(EID3863CutoutAlpha - _EID3863AlphaCutoff);
    float _136 = (PSX5.w > 0.0f) ? 1.0f : (-1.0f);
    float3 _141 = float4(PSX5.xyz, _136).xyz;
    float3x3 _147 = float3x3(_141 * 1.0f, (cross(PSX4, _141) * _136) * 1.0f, PSX4 * 1.0f);
    float _153 = lerp(1.0f, float((PSglXFrontFacing ? true : false) ? 1 : (-1)), EID3863P28_m5);
    float4 _159 = _Res25.SampleBias(sampler_point_repeat, PSX3, EID3863PSMipBias);
    float2 _163 = EID3863P28_m8.xx;
    float2 _164 = lerp(_159.xy, float2(0.5f, 1.0f), _163);
    float _165 = _164.x;
    float4 _167 = float4(_165, _164.y, 0.0f, 1.0f);
    _167.w = _165;
    float2 _173 = (_167.wy * 2.0f) - 1.0f.xx;
    float3 _174 = float3(_173.x, _173.y, 0.0f);
    float2 _175 = _173.xy;
    _174.z = max(1.000000016862383526387164645044e-16f, sqrt(1.0f - clamp(dot(_175, _175), 0.0f, 1.0f)));
    float2 _185 = (_174.xy * EID3863P28_m4).xy * _153;
    float _187 = _159.w;
    float3 _188 = mul(float3(_185.x, _185.y, _174.z), _147);
    float _209 = clamp(lerp(EID3863P28_m34.z, 1.0f, clamp((max(length(PSX8 + float3(0.0f, EID3863P28_m34.w, 0.0f)) - EID3863P28_m34.w, 0.0f) - EID3863P28_m34.x) * EID3863P28_m34.y, 0.0f, 1.0f)), 0.0f, 1.0f);
    float _213 = _209 * lerp(1.0f, _187, EID3863P28_m14);
    float _217 = _209 * lerp(1.0f, _187, EID3863P28_m15);
    uint _239 = uint(round(EID3863P28_m9 * 31.0f));
    uint _253 = uint(round(0.0f));
    float4 _273 = _Res25.SampleBias(sampler_point_repeat, PSX3, EID3863PSMipBias);
    float2 _275 = lerp(_273.xy, float2(0.5f, 1.0f), _163);
    float _276 = _275.x;
    float4 _278 = float4(_276, _275.y, 0.0f, 1.0f);
    _278.w = _276;
    float2 _282 = (_278.wy * 2.0f) - 1.0f.xx;
    float3 _283 = float3(_282.x, _282.y, 0.0f);
    float2 _284 = _282.xy;
    _283.z = max(1.000000016862383526387164645044e-16f, sqrt(1.0f - clamp(dot(_284, _284), 0.0f, 1.0f)));
    float2 _294 = (_283.xy * EID3863P28_m4).xy * _153;
    float3 _302 = mul(float3(_294.x, _294.y, _283.z), _147);
    float4 _311;
    _311.w = float(_253 & 3u) * 0.3333333432674407958984375f;
    float3 _312 = normalize((_302 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(_302, _302)))) * _153);
    float2 _317 = _312.xz / dot(1.0f.xxx, abs(_312)).xx;
    float3 _331;
    if (_312.y <= 0.0f)
    {
        float2 _326 = _317.xy;
        bool2 _327 = bool2(_326.x >= 0.0f.xx.x, _326.y >= 0.0f.xx.y);
        float2 _329 = (1.0f.xx - abs(_317.yx)) * float2(_327.x ? 1.0f.xx.x : (-1.0f).xx.x, _327.y ? 1.0f.xx.y : (-1.0f).xx.y);
        _331 = float3(_329.x, _312.y, _329.y);
    }
    else
    {
        _331 = float3(_317.x, _312.y, _317.y);
    }
    float2 _334 = (_331.xz * 0.5f) + 0.5f.xx;
    float4 _335 = float4(_334.x, _334.y, _311.z, _311.w);
    _335.z = lerp(EID3863P28_m11, EID3863P28_m12, _273.z);
    float3 _361 = clamp(lerp(lerp(clamp((_Res23.SampleBias(sampler_linear_mirror, PSX3, EID3863PSMipBias).xyz * EID3863P28_m32.xyz) * EID3863P28_m21, 0.0f.xxx, 1.0f.xxx), EID3863P28_m32.xyz, EID3863P28_m20.xxx), EID3863_INSTANCE_MATERIAL2.xyz, EID3863_INSTANCE_MATERIAL2.w.xxx), 0.0f.xxx, 1.0f.xxx);
    float4 _378 = float4(_361.x, _361.y, _361.z, 0.0f.xxxx.w);
    _378.w = clamp(lerp(EID3863P28_m33.z, 1.0f, clamp((max(length(PSX8 + float3(0.0f, EID3863P28_m33.w, 0.0f)) - EID3863P28_m33.w, 0.0f) - EID3863P28_m33.x) * EID3863P28_m33.y, 0.0f, 1.0f)), 0.0f, 1.0f);
    float2 _392 = (PSX6.xy / max(PSX6.z, 9.9999999392252902907785028219223e-09f).xx) - (PSX7.xy / max(PSX7.z, 9.9999999392252902907785028219223e-09f).xx);
    _392.y = -_392.y;
    float2 _405 = ((sqrt(sqrt(abs(_392 * 0.5f))) * float2(int2(sign(_392)))) * 0.5f) + 0.5f.xx;
    float4 _406 = float4(_405.x, _405.y, 0.0f.xxxx.z, 0.0f.xxxx.w);
    _406.z = 0.0f;
    _406.w = 0.0f;
    PSX11 = float4(0.0f, 0.0f, 0.0f, 1.0f);
    PSX12 = float4(float((uint(round(((0.5f * EID3863P28_m10) * (1.0f - abs(_213 - _217))) * 127.0f)) << 3u) | ((_239 >> 2u) & 7u)) * 0.000977517105638980865478515625f, float((uint(round(max(_213, _217) * 127.0f)) << 3u) | uint(round(3.5f))) * 0.000977517105638980865478515625f, float((uint(round(clamp(dot((_188 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(_188, _188)))) * _153, -EID3863PSViewDirection.xyz), 0.0f, 1.0f) * 127.0f)) << 3u) | ((_253 >> 2u) & 7u)) * 0.000977517105638980865478515625f, float(_239 & 3u) * 0.3333333432674407958984375f);
    PSX13 = _335;
    PSX14 = _378;
    PSX15 = _406;
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

EID3863GBufferOutput EID3863FragmentMain(EID3863FragmentVaryings i, bool frontFace : SV_IsFrontFace) { i.PSglXFrontFacing=frontFace; return EID3863PSGeneratedMain(i); }
