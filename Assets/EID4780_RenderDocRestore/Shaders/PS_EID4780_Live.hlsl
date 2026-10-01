Texture2D<float4> _EID4780CapturedScreen40;
float _EID4780UseCapturedScreen40;
struct _22
{
    column_major float4x4 _m0;
    float4 _m1;
    float4 _m2;
    column_major float4x4 _m3;
    float4 _m4;
    float4 _m5;
    float4 _m6;
    float4 _m7;
    float4 _m8;
    float4 _m9;
};

static const int2 _361[6] = { int2(2, 1), int2(2, 1), int2(0, 2), int2(0, 2), int2(0, 1), int2(0, 1) };
static const float2 _362[6] = { float2(-1.0f, 1.0f), 1.0f.xx, float2(1.0f, -1.0f), 1.0f.xx, 1.0f.xx, float2(-1.0f, 1.0f) };

cbuffer _17_18 : register(b12)
{
    column_major float4x4 _18_m0 : packoffset(c0);
    column_major float4x4 _18_m1 : packoffset(c4);
    column_major float4x4 _18_m2 : packoffset(c8);
    column_major float4x4 _18_m3 : packoffset(c12);
    column_major float4x4 _18_m4 : packoffset(c16);
    column_major float4x4 _18_m5 : packoffset(c20);
    column_major float4x4 _18_m6 : packoffset(c24);
    column_major float4x4 _18_m7 : packoffset(c28);
    column_major float4x4 _18_m8 : packoffset(c32);
    column_major float4x4 _18_m9 : packoffset(c36);
    column_major float4x4 _18_m10 : packoffset(c40);
    float4 _18_m11 : packoffset(c44);
    column_major float4x4 _18_m12 : packoffset(c45);
    column_major float4x4 _18_m13 : packoffset(c49);
    column_major float4x4 _18_m14 : packoffset(c53);
    column_major float4x4 _18_m15 : packoffset(c57);
    column_major float4x4 _18_m16 : packoffset(c61);
    column_major float4x4 _18_m17 : packoffset(c65);
    column_major float4x4 _18_m18 : packoffset(c69);
    column_major float4x4 _18_m19 : packoffset(c73);
    column_major float4x4 _18_m20 : packoffset(c77);
    float4 _18_m21 : packoffset(c81);
};

cbuffer _19_20 : register(b16)
{
    float4 _20_m0 : packoffset(c0);
    float4 _20_m1 : packoffset(c1);
    float4 _20_m2 : packoffset(c2);
    float4 _20_m3 : packoffset(c3);
    float4 _20_m4 : packoffset(c4);
    float4 _20_m5 : packoffset(c5);
    float4 _20_m6[6] : packoffset(c6);
    float4 _20_m7[6] : packoffset(c12);
    float4 _20_m8 : packoffset(c18);
    float4 _20_m9 : packoffset(c19);
    float4 _20_m10 : packoffset(c20);
    float4 _20_m11 : packoffset(c21);
    float4 _20_m12 : packoffset(c22);
    float4 _20_m13 : packoffset(c23);
    float4 _20_m14 : packoffset(c24);
    float4 _20_m15 : packoffset(c25);
    float _20_m16 : packoffset(c26);
    float _20_m17 : packoffset(c26.y);
    float _20_m18 : packoffset(c26.z);
    uint _20_m19 : packoffset(c26.w);
    float4 _20_m20 : packoffset(c27);
    int4 _20_m21 : packoffset(c28);
    float4 _20_m22 : packoffset(c29);
    float4 _20_m23 : packoffset(c30);
    float4 _20_m24 : packoffset(c31);
    float4 _20_m25 : packoffset(c32);
    float4 _20_m26 : packoffset(c33);
    float4 _20_m27 : packoffset(c34);
    float4 _20_m28 : packoffset(c35);
    float4 _20_m29 : packoffset(c36);
    float4 _20_m30 : packoffset(c37);
    float4 _20_m31 : packoffset(c38);
    float4 _20_m32[4] : packoffset(c39);
    float4 _20_m33[4] : packoffset(c43);
    float4 _20_m34[4] : packoffset(c47);
    float4 _20_m35[4] : packoffset(c51);
    float4 _20_m36 : packoffset(c55);
    float4 _20_m37 : packoffset(c56);
    float4 _20_m38[4] : packoffset(c57);
    float4 _20_m39[4] : packoffset(c61);
    float4 _20_m40[4] : packoffset(c65);
    float4 _20_m41 : packoffset(c69);
    float4 _20_m42 : packoffset(c70);
    float4 _20_m43 : packoffset(c71);
    float4 _20_m44 : packoffset(c72);
    float4 _20_m45 : packoffset(c73);
    float4 _20_m46 : packoffset(c74);
    float4 _20_m47 : packoffset(c75);
    float4 _20_m48 : packoffset(c76);
    float4 _20_m49 : packoffset(c77);
    float4 _20_m50 : packoffset(c78);
    float4 _20_m51 : packoffset(c79);
    float4 _20_m52 : packoffset(c80);
    float4 _20_m53 : packoffset(c81);
    float4 _20_m54 : packoffset(c82);
    float4 _20_m55 : packoffset(c83);
    float4 _20_m56 : packoffset(c84);
    float4 _20_m57 : packoffset(c85);
    float4 _20_m58 : packoffset(c86);
    float4 _20_m59 : packoffset(c87);
    float4 _20_m60 : packoffset(c88);
    float4 _20_m61 : packoffset(c89);
    float4 _20_m62 : packoffset(c90);
    float4 _20_m63 : packoffset(c91);
    float4 _20_m64 : packoffset(c92);
    float4 _20_m65 : packoffset(c93);
    float4 _20_m66 : packoffset(c94);
    float4 _20_m67 : packoffset(c95);
    float4 _20_m68 : packoffset(c96);
    float4 _20_m69 : packoffset(c97);
    float4 _20_m70 : packoffset(c98);
    float4 _20_m71 : packoffset(c99);
    float4 _20_m72 : packoffset(c100);
    float4 _20_m73 : packoffset(c101);
    float4 _20_m74 : packoffset(c102);
    float4 _20_m75 : packoffset(c103);
    float4 _20_m76 : packoffset(c104);
    float4 _20_m77 : packoffset(c105);
    float4 _20_m78 : packoffset(c106);
    float4 _20_m79 : packoffset(c107);
    float4 _20_m80 : packoffset(c108);
    float4 _20_m81 : packoffset(c109);
    float4 _20_m82 : packoffset(c110);
    float4 _20_m83 : packoffset(c111);
    float4 _20_m84 : packoffset(c112);
    float4 _20_m85 : packoffset(c113);
    float4 _20_m86 : packoffset(c114);
    float4 _20_m87 : packoffset(c115);
    float4 _20_m88 : packoffset(c116);
    float4 _20_m89 : packoffset(c117);
    float4 _20_m90 : packoffset(c118);
    float4 _20_m91 : packoffset(c119);
    float4 _20_m92 : packoffset(c120);
    float4 _20_m93 : packoffset(c121);
    float4 _20_m94 : packoffset(c122);
    float4 _20_m95 : packoffset(c123);
    float4 _20_m96 : packoffset(c124);
    float4 _20_m97 : packoffset(c125);
    float4 _20_m98 : packoffset(c126);
    float4 _20_m99[2] : packoffset(c127);
    float4 _20_m100[2] : packoffset(c129);
    float _20_m101 : packoffset(c131);
    float _20_m102 : packoffset(c131.y);
    float _20_m103 : packoffset(c131.z);
    float _20_m104 : packoffset(c131.w);
    float4 _20_m105 : packoffset(c132);
    float4 _20_m106 : packoffset(c133);
    float4 _20_m107 : packoffset(c134);
    float4 _20_m108 : packoffset(c135);
    float4 _20_m109 : packoffset(c136);
    float4 _20_m110 : packoffset(c137);
    float4 _20_m111 : packoffset(c138);
    float4 _20_m112 : packoffset(c139);
    float4 _20_m113 : packoffset(c140);
    float4 _20_m114 : packoffset(c141);
    float4 _20_m115 : packoffset(c142);
    float4 _20_m116 : packoffset(c143);
    float4 _20_m117 : packoffset(c144);
    float4 _20_m118 : packoffset(c145);
    float4 _20_m119 : packoffset(c146);
    float4 _20_m120 : packoffset(c147);
    float4 _20_m121 : packoffset(c148);
    float4 _20_m122 : packoffset(c149);
    float4 _20_m123 : packoffset(c150);
    float4 _20_m124 : packoffset(c151);
    float4 _20_m125 : packoffset(c152);
    float4 _20_m126 : packoffset(c153);
    float4 _20_m127 : packoffset(c154);
    float4 _20_m128 : packoffset(c155);
    float4 _20_m129 : packoffset(c156);
    float4 _20_m130 : packoffset(c157);
    float4 _20_m131 : packoffset(c158);
    float4 _20_m132 : packoffset(c159);
    float4 _20_m133 : packoffset(c160);
    float4 _20_m134 : packoffset(c161);
    column_major float4x4 _20_m135 : packoffset(c162);
    float4 _20_m136 : packoffset(c166);
    float4 _20_m137 : packoffset(c167);
    float4 _20_m138[32] : packoffset(c168);
};

cbuffer _21_23 : register(b0)
{
    _22 _23_m0[256] : packoffset(c0);
};

ByteAddressBuffer _31 : register(t51);
ByteAddressBuffer _33 : register(t18);
cbuffer _34_35 : register(b48)
{
    int _35_m0 : packoffset(c0);
    int _35_m1 : packoffset(c0.y);
    int _35_m2 : packoffset(c0.z);
    int _35_m3 : packoffset(c0.w);
    float _35_m4 : packoffset(c1);
    float _35_m5 : packoffset(c1.y);
    float _35_m6 : packoffset(c1.z);
    float _35_m7 : packoffset(c1.w);
    float _35_m8 : packoffset(c2);
    float _35_m9 : packoffset(c2.y);
    float _35_m10 : packoffset(c2.z);
    float _35_m11 : packoffset(c2.w);
};

cbuffer _36_37 : register(b14)
{
    float4 _37_m0 : packoffset(c0);
    float4 _37_m1 : packoffset(c1);
    float4 _37_m2 : packoffset(c2);
    float4 _37_m3 : packoffset(c3);
    float4 _37_m4 : packoffset(c4);
    uint4 _37_m5 : packoffset(c5);
    float4 _37_m6[2048] : packoffset(c6);
};

cbuffer _38_39 : register(b15)
{
    column_major float4x4 _39_m0[5] : packoffset(c0);
    float4 _39_m1[4] : packoffset(c20);
    float4 _39_m2[4] : packoffset(c24);
    float4 _39_m3[4] : packoffset(c28);
    float4 _39_m4 : packoffset(c32);
    float4 _39_m5 : packoffset(c33);
    float4 _39_m6 : packoffset(c34);
    float4 _39_m7 : packoffset(c35);
    float4 _39_m8 : packoffset(c36);
    float4 _39_m9[27] : packoffset(c37);
    column_major float4x4 _39_m10[56] : packoffset(c64);
    float4 _39_m11[56] : packoffset(c288);
    float4 _39_m12[56] : packoffset(c344);
    float4 _39_m13 : packoffset(c400);
    float4 _39_m14[47] : packoffset(c401);
    column_major float4x4 _39_m15[15] : packoffset(c448);
    float4 _39_m16[15] : packoffset(c508);
    float4 _39_m17[15] : packoffset(c523);
    float4 _39_m18[15] : packoffset(c538);
    float4 _39_m19 : packoffset(c553);
    float4 _39_m20 : packoffset(c554);
    float4 _39_m21[21] : packoffset(c555);
    column_major float4x4 _39_m22 : packoffset(c576);
    column_major float4x4 _39_m23 : packoffset(c580);
    float4 _39_m24 : packoffset(c584);
    float4 _39_m25 : packoffset(c585);
    float4 _39_m26 : packoffset(c586);
    float4 _39_m27[128] : packoffset(c587);
};

cbuffer _49_50 : register(b42)
{
    float _50_m0 : packoffset(c0);
    float _50_m1 : packoffset(c0.y);
    float _50_m2 : packoffset(c0.z);
    float _50_m3 : packoffset(c0.w);
    float _50_m4 : packoffset(c1);
    float _50_m5 : packoffset(c1.y);
    float _50_m6 : packoffset(c1.z);
    float _50_m7 : packoffset(c1.w);
    float _50_m8 : packoffset(c2);
    float _50_m9 : packoffset(c2.y);
    float _50_m10 : packoffset(c2.z);
    float _50_m11 : packoffset(c2.w);
    float _50_m12 : packoffset(c3);
    float _50_m13 : packoffset(c3.y);
    float _50_m14 : packoffset(c3.z);
    float _50_m15 : packoffset(c3.w);
    float _50_m16 : packoffset(c4);
    float _50_m17 : packoffset(c4.y);
    float _50_m18 : packoffset(c4.z);
    float _50_m19 : packoffset(c4.w);
    float _50_m20 : packoffset(c5);
    float _50_m21 : packoffset(c5.y);
    float _50_m22 : packoffset(c5.z);
    float _50_m23 : packoffset(c5.w);
    float4 _50_m24 : packoffset(c6);
    float4 _50_m25 : packoffset(c7);
    float4 _50_m26 : packoffset(c8);
    float4 _50_m27 : packoffset(c9);
    float4 _50_m28 : packoffset(c10);
    float4 _50_m29 : packoffset(c11);
    float _50_m30 : packoffset(c12);
    float _50_m31 : packoffset(c12.y);
    float _50_m32 : packoffset(c12.z);
    float _50_m33 : packoffset(c12.w);
    float4 _50_m34 : packoffset(c13);
    float _50_m35 : packoffset(c14);
    float _50_m36 : packoffset(c14.y);
    float _50_m37 : packoffset(c14.z);
    float _50_m38 : packoffset(c14.w);
    float4 _50_m39 : packoffset(c15);
    float4 _50_m40 : packoffset(c16);
    float4 _50_m41 : packoffset(c17);
    float4 _50_m42 : packoffset(c18);
    float4 _50_m43 : packoffset(c19);
    float4 _50_m44 : packoffset(c20);
    float _50_m45 : packoffset(c21);
    float _50_m46 : packoffset(c21.y);
    float _50_m47 : packoffset(c21.z);
    float _50_m48 : packoffset(c21.w);
    float _50_m49 : packoffset(c22);
    float _50_m50 : packoffset(c22.y);
    float _50_m51 : packoffset(c22.z);
    float _50_m52 : packoffset(c22.w);
};

cbuffer _57_58 : register(b50)
{
    float4 _58_m0[32] : packoffset(c0);
    column_major float4x4 _58_m1[32] : packoffset(c32);
};

SamplerState eid4780_point_clamp_sampler25 : register(s2);
SamplerState eid4780_linear_clamp_sampler26 : register(s6);
SamplerState eid4780_linear_repeat_sampler27 : register(s4);
SamplerComparisonState eid4780_linear_clamp_compare_sampler28 : register(s7);
Texture2D<float4> _40 : register(t27);
Texture2D<float4> _41 : register(t22);
Texture3D<float4> _43 : register(t35);
Texture3D<float4> _44 : register(t32);
Texture3D<float4> _45 : register(t34);
Texture3D<float4> _46 : register(t31);
Texture3D<float4> _47 : register(t33);
Texture3D<float4> _48 : register(t30);
Texture2D<float4> _51 : register(t2);
Texture2D<float4> _52 : register(t1);
Texture2D<float4> _53 : register(t39);
Texture2D<float4> _54 : register(t37);
Texture2D<float4> _55 : register(t3);
Texture2D<float4> _56 : register(t29);
Texture3D<float4> _61 : register(t36);

static float4 gl_FragCoord;
static bool gl_FrontFacing;
static float2 _3;
static float3 _4;
static float3 _5;
static float4 _6;
static float3 _7;
static float3 _8;
static float3 _9;
static float4 _10;
static float3 _11;
static uint _13;
static float4 _15;
static float4 _16;

struct SPIRV_Cross_Input
{
    float2 _3 : TEXCOORD0;
    float3 _4 : TEXCOORD1;
    float3 _5 : TEXCOORD2;
    float4 _6 : TEXCOORD3;
    float3 _7 : TEXCOORD4;
    float3 _8 : TEXCOORD5;
    float3 _9 : TEXCOORD6;
    float4 _10 : TEXCOORD7;
    float3 _11 : TEXCOORD8;
    nointerpolation uint _13 : TEXCOORD9;
    float4 gl_FragCoord : SV_Position;
    bool gl_FrontFacing : SV_IsFrontFace;
};

struct SPIRV_Cross_Output
{
    float4 _15 : SV_Target0;
    float4 _16 : SV_Target1;
};

static float _387;
static float3 _388;
static float _393;
static uint _394;

uint spvPackHalf2x16(float2 value)
{
    uint2 Packed = f32tof16(value);
    return Packed.x | (Packed.y << 16);
}

float2 spvUnpackHalf2x16(uint value)
{
    return f16tof32(uint2(value & 0xffff, value >> 16));
}

void frag_main()
{
    // Captured light-grid and fog depth use the original camera clip W.
    float _410 = _7.z;
    float3 _425 = lerp(-_4, float3(_18_m0[2u].x, _18_m0[2u].y, _18_m0[2u].z), _20_m4.w.xxx);
    float _426 = dot(_425, _425);
    float _428 = rsqrt(isnan(9.9999999392252902907785028219223e-09f) ? _426 : (isnan(_426) ? 9.9999999392252902907785028219223e-09f : max(_426, 9.9999999392252902907785028219223e-09f)));
    float3 _429 = _425 * _428;
    float _430 = _426 * _428;
    uint _433 = asuint(_23_m0[_13]._m2.x);
    bool _438 = (asuint(_23_m0[_13]._m1.w) & 16u) != 0u;
    float4 _451;
    float4 _452;
    if (_438)
    {
        _451 = asfloat(_33.Load4((_433 + 2u) * 16 + 0));
        _452 = asfloat(_33.Load4(_433 * 16 + 0));
    }
    else
    {
        _451 = _23_m0[_13]._m0[2];
        _452 = _23_m0[_13]._m0[0];
    }
    float4 _458 = _55.SampleBias(eid4780_linear_repeat_sampler27, _3, _20_m16);
    float3 _463 = _458.xyz * _50_m24.xyz;
    float _470 = 1.0f - _50_m0;
    float _471 = _458.w;
    float3 _472 = _463 * 12.9200000762939453125f;
    float3 _476 = (pow(abs(_463), 0.4166666567325592041015625f.xxx) * 1.05499994754791259765625f) - 0.054999999701976776123046875f.xxx;
    bool3 _477 = bool3(_463.x <= 0.003130800090730190277099609375f.xxx.x, _463.y <= 0.003130800090730190277099609375f.xxx.y, _463.z <= 0.003130800090730190277099609375f.xxx.z);
    float3 _479 = clamp(float3(_477.x ? _472.x : _476.x, _477.y ? _472.y : _476.y, _477.z ? _472.z : _476.z), 0.0f.xxx, 1.0f.xxx);
    float _483 = _479.z * 31.0f;
    float _484 = floor(_483);
    float2 _488 = ((_479.xy * 31.0f) * float2(0.0009765625f, 0.03125f)) + float2(0.00048828125f, 0.015625f);
    float3 _493 = float3(_488.x, _488.y, _479.z);
    _493.x = _488.x + (_484 * 0.03125f);
    float3 _504 = lerp(_52.SampleLevel(eid4780_linear_clamp_sampler26, _493.xy, 0.0f).xyz, _52.SampleLevel(eid4780_linear_clamp_sampler26, _493.xy + float2(0.03125f, 0.0f), 0.0f).xyz, (_483 - _484).xxx);
    float3 _508 = _4 + _18_m11.xyz;
    float3 _513 = _508 - float3(_452.w, _393, _451.w);
    _513.y = 6.103515625e-05f;
    float3 _515 = normalize(_513);
    float3 _523 = _5 * 1.0f;
    float3 _529 = normalize(_5) * (gl_FrontFacing ? 1.0f : ((-1.0f) + (2.0f * _50_m5)));
    uint2 _531 = uint2(gl_FragCoord.xy);
    float2 capturedPixel = (_7.xy / max(_7.z, 1e-6f) * float2(0.5f, -0.5f) + 0.5f) * _20_m0.xy - _20_m9.xy;
    bool capturedScreenValid = _7.z > 0.0f && all(capturedPixel >= 0.0f) && all(capturedPixel < _20_m0.xy);
    float3 _541 = mul(float3x3(_18_m1[0].xyz, _18_m1[1].xyz, _18_m1[2].xyz), float3(0.0f, 0.0f, 1.0f));
    uint _550 = asuint((_20_m89.x > 0.5f) ? _20_m89.y : _23_m0[_13]._m7.x);
    float4 _563 = float4(float(_550 & 255u), float((_550 >> 8u) & 255u), float((_550 >> 16u) & 255u), float((_550 >> 24u) & 255u)) * 0.0039215688593685626983642578125f.xxxx;
    float _564 = _563.x;
    float _566 = _563.z;
    float _567 = _563.w;
    float _573 = _508.y;
    float _576 = smoothstep(-0.20000000298023223876953125f, 0.1500000059604644775390625f, lerp(_23_m0[_13]._m7.y, _20_m89.w, _20_m89.x) - _573) * _563.y;
    float _577 = isnan(_576) ? _566 : (isnan(_566) ? _576 : max(_566, _576));
    float _585 = lerp(_20_m22.x, 1.0f, _20_m91.w) * _20_m20.x;
    float _587 = _529.z;
    float3 _589 = normalize(float3(_529.x, 6.103515625e-05f, _587));
    float4 _1083;
    float3 _1084;
    float3 _1085;
    float _1086;
    if (_20_m80.y < 0.5f)
    {
        float3 _604 = _508 - (_20_m105.xyz + (_541 * (-_20_m107.w)));
        float _606 = abs(_604.x);
        float _608 = abs(_604.z);
        float _614 = clamp(((isnan(_608) ? _606 : (isnan(_606) ? _608 : max(_606, _608))) - 464.0f) * 0.03125f, 0.0f, 1.0f);
        float _617 = clamp((abs(_604.y) - 208.0f) * 0.03125f, 0.0f, 1.0f);
        float _618 = isnan(_617) ? _614 : (isnan(_614) ? _617 : max(_614, _617));
        float4 _920;
        float4 _921;
        float4 _922;
        float _923;
        float _924;
        if ((_20_m105.w != 0.0f) && (_618 < 1.0f))
        {
            float3 _631 = _508 - (_20_m105.xyz + (_541 * (-_20_m107.y)));
            float _633 = abs(_631.x);
            float _635 = abs(_631.z);
            float _641 = clamp(((isnan(_635) ? _633 : (isnan(_633) ? _635 : max(_633, _635))) - 29.0f) * 0.5f, 0.0f, 1.0f);
            float _644 = clamp((abs(_631.y) - 13.0f) * 0.5f, 0.0f, 1.0f);
            float _645 = isnan(_644) ? _641 : (isnan(_641) ? _644 : max(_641, _644));
            float _721;
            float4 _722;
            float4 _723;
            float4 _724;
            if (_645 < 1.0f)
            {
                float3 _654 = ((_508 * 2.0f) + 0.5f.xxx) * _20_m106.xyz;
                float3 _656 = _654 - floor(_654);
                float4 _660 = _43.SampleLevel(eid4780_linear_repeat_sampler27, _656, 0.0f);
                float _661 = 1.0f - _645;
                float _665 = _20_m106.y * 0.5f;
                float _670 = _656.x;
                float _671 = clamp(_656.y, _665, 1.0f - _665) * 0.3333333432674407958984375f;
                float _672 = _656.z;
                float4 _675 = _44.SampleLevel(eid4780_linear_clamp_sampler26, float3(_670, _671, _672), 0.0f);
                float _691 = _660.x;
                float _701 = _660.y;
                float _711 = _660.z;
                _721 = _618 + (_675.w * _661);
                _722 = float4(((_44.SampleLevel(eid4780_linear_clamp_sampler26, float3(_670, _671 + 0.666666686534881591796875f, _672), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _711, _711) * _661;
                _723 = float4(((_44.SampleLevel(eid4780_linear_clamp_sampler26, float3(_670, _671 + 0.3333333432674407958984375f, _672), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _701, _701) * _661;
                _724 = float4(((_675.xyz * 4.0f) - 2.0f.xxx) * _691, _691) * _661;
            }
            else
            {
                _721 = _618;
                _722 = 0.0f.xxxx;
                _723 = 0.0f.xxxx;
                _724 = 0.0f.xxxx;
            }
            float3 _730 = _508 - (_20_m105.xyz + (_541 * (-_20_m107.z)));
            float _732 = abs(_730.x);
            float _734 = abs(_730.z);
            float _740 = clamp(((isnan(_734) ? _732 : (isnan(_732) ? _734 : max(_732, _734))) - 116.0f) * 0.125f, 0.0f, 1.0f);
            float _743 = clamp((abs(_730.y) - 52.0f) * 0.125f, 0.0f, 1.0f);
            float _744 = isnan(_743) ? _740 : (isnan(_740) ? _743 : max(_740, _743));
            float _824;
            float4 _825;
            float4 _826;
            float4 _827;
            if (_744 < 1.0f)
            {
                float3 _753 = ((_508 * 0.5f) + 0.5f.xxx) * _20_m106.xyz;
                float3 _755 = _753 - floor(_753);
                float4 _759 = _45.SampleLevel(eid4780_linear_repeat_sampler27, _755, 0.0f);
                float _761 = _645 * (1.0f - _744);
                float _765 = _20_m106.y * 0.5f;
                float _770 = _755.x;
                float _771 = clamp(_755.y, _765, 1.0f - _765) * 0.3333333432674407958984375f;
                float _772 = _755.z;
                float4 _775 = _46.SampleLevel(eid4780_linear_clamp_sampler26, float3(_770, _771, _772), 0.0f);
                float _791 = _759.x;
                float _802 = _759.y;
                float _813 = _759.z;
                _824 = _721 + (_775.w * _761);
                _825 = _722 + (float4(((_46.SampleLevel(eid4780_linear_clamp_sampler26, float3(_770, _771 + 0.666666686534881591796875f, _772), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _813, _813) * _761);
                _826 = _723 + (float4(((_46.SampleLevel(eid4780_linear_clamp_sampler26, float3(_770, _771 + 0.3333333432674407958984375f, _772), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _802, _802) * _761);
                _827 = _724 + (float4(((_775.xyz * 4.0f) - 2.0f.xxx) * _791, _791) * _761);
            }
            else
            {
                _824 = _721;
                _825 = _722;
                _826 = _723;
                _827 = _724;
            }
            float4 _910;
            float4 _911;
            float4 _912;
            float _913;
            if (_744 > 0.0f)
            {
                float3 _836 = ((_508 * 0.125f) + 0.5f.xxx) * _20_m106.xyz;
                float3 _839 = _20_m106.xyz * 0.5f;
                float3 _841 = clamp(_836 - floor(_836), _839, 1.0f.xxx - _839);
                float4 _845 = _47.SampleLevel(eid4780_linear_repeat_sampler27, _841, 0.0f);
                float _847 = _744 * (1.0f - _618);
                float _851 = _20_m106.y * 0.5f;
                float _856 = _841.x;
                float _857 = clamp(_841.y, _851, 1.0f - _851) * 0.3333333432674407958984375f;
                float _858 = _841.z;
                float4 _861 = _48.SampleLevel(eid4780_linear_clamp_sampler26, float3(_856, _857, _858), 0.0f);
                float _877 = _845.x;
                float _888 = _845.y;
                float _899 = _845.z;
                _910 = _825 + (float4(((_48.SampleLevel(eid4780_linear_clamp_sampler26, float3(_856, _857 + 0.666666686534881591796875f, _858), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _899, _899) * _847);
                _911 = _826 + (float4(((_48.SampleLevel(eid4780_linear_clamp_sampler26, float3(_856, _857 + 0.3333333432674407958984375f, _858), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _888, _888) * _847);
                _912 = _827 + (float4(((_861.xyz * 4.0f) - 2.0f.xxx) * _877, _877) * _847);
                _913 = _824 + (_861.w * _847);
            }
            else
            {
                _910 = _825;
                _911 = _826;
                _912 = _827;
                _913 = _824;
            }
            float _916 = clamp((_913 * 2.0f) - 1.0f, 0.0f, 1.0f);
            _920 = _910;
            _921 = _911;
            _922 = _912;
            _923 = _916 - _618;
            _924 = (_916 + _618) * 0.5f;
        }
        else
        {
            _920 = 0.0f.xxxx;
            _921 = 0.0f.xxxx;
            _922 = 0.0f.xxxx;
            _923 = 0.0f;
            _924 = 1.0f;
        }
        float4 _944 = _922 + float4(_20_m108.x * _924, (_20_m108.y * _924) + ((_20_m108.w * _923) * 0.5f), _20_m108.z * _924, (_20_m108.w * _924) + ((_20_m108.y * _923) * 0.375f));
        float4 _964 = _921 + float4(_20_m109.x * _924, (_20_m109.y * _924) + ((_20_m109.w * _923) * 0.5f), _20_m109.z * _924, (_20_m109.w * _924) + ((_20_m109.y * _923) * 0.375f));
        float4 _984 = _920 + float4(_20_m110.x * _924, (_20_m110.y * _924) + ((_20_m110.w * _923) * 0.5f), _20_m110.z * _924, (_20_m110.w * _924) + ((_20_m110.y * _923) * 0.375f));
        float4 _988 = float4(_589, 1.0f);
        float3 _992 = float3(dot(_944, _988), dot(_964, _988), dot(_984, _988));
        bool3 _3756 = isnan(_992);
        bool3 _3757 = isnan(0.0f.xxx);
        float3 _3758 = max(_992, 0.0f.xxx);
        float3 _3759 = float3(_3756.x ? 0.0f.xxx.x : _3758.x, _3756.y ? 0.0f.xxx.y : _3758.y, _3756.z ? 0.0f.xxx.z : _3758.z);
        float3 _994 = float3(_3757.x ? _992.x : _3759.x, _3757.y ? _992.y : _3759.y, _3757.z ? _992.z : _3759.z) * _585;
        float3 _1002 = ((_944.xyz * 0.2125999927520751953125f) + (_964.xyz * 0.715200006961822509765625f)) + (_984.xyz * 0.072200000286102294921875f);
        float _1003 = dot(_1002, _1002);
        float3 _1006 = _1002 * rsqrt(isnan(_1003) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? _1003 : max(1.1754943508222875079687365372222e-38f, _1003)));
        float _1008 = abs(_1006.y);
        float3 _1009 = _1006;
        _1009.y = _1008;
        float4 _1011 = float4(_1009.x, _1009.y, _1009.z, 0.0f.xxxx.w);
        _1011.w = 1.0f;
        float4 _1014 = float4(_1006.x, _1008, _1006.z, 1.0f);
        float3 _1018 = float3(dot(_944, _1014), dot(_964, _1014), dot(_984, _1014));
        bool3 _3766 = isnan(_1018);
        bool3 _3767 = isnan(0.0f.xxx);
        float3 _3768 = max(_1018, 0.0f.xxx);
        float3 _3769 = float3(_3766.x ? 0.0f.xxx.x : _3768.x, _3766.y ? 0.0f.xxx.y : _3768.y, _3766.z ? 0.0f.xxx.z : _3768.z);
        float3 _1019 = float3(_3767.x ? _1018.x : _3769.x, _3767.y ? _1018.y : _3769.y, _3767.z ? _1018.z : _3769.z);
        float _1020 = _1019.x;
        float _1021 = _1019.y;
        float _1022 = _1019.z;
        float _1023 = isnan(_1021) ? _1020 : (isnan(_1020) ? _1021 : max(_1020, _1021));
        float _1024 = isnan(_1022) ? _1023 : (isnan(_1023) ? _1022 : max(_1023, _1022));
        float _1027 = _994.z;
        float _1028 = _994.y;
        float4 _1033 = lerp(float4(_1027, _1028, -1.0f, 0.666666686534881591796875f), float4(_1028, _1027, 0.0f, -0.3333333432674407958984375f), step(_1027, _1028).xxxx);
        float _1034 = _994.x;
        float _1035 = _1033.x;
        float4 _1043 = lerp(float4(_1035, _1033.yw, _1034), float4(_1034, _1033.yz, _1035), step(_1035, _1034).xxxx);
        float _1044 = _1043.x;
        float _1045 = _1043.w;
        float _1046 = _1043.y;
        float _1048 = _1044 - (isnan(_1046) ? _1045 : (isnan(_1045) ? _1046 : min(_1045, _1046)));
        float _1057 = _1048 / (_1044 + 9.9999997473787516355514526367188e-05f);
        float _1058 = frac(abs(_1043.z + ((_1045 - _1046) / ((6.0f * _1048) + 9.9999997473787516355514526367188e-05f))));
        float _1064 = lerp(0.699999988079071044921875f, 0.3499999940395355224609375f, smoothstep(0.449999988079071044921875f, 0.3499999940395355224609375f, abs(_1058 - 0.5f))) * clamp(_1044, 0.0f, 1.0f);
        float _1065 = isnan(_1064) ? _1057 : (isnan(_1057) ? _1064 : min(_1057, _1064));
        float _1067 = 2.0f / (2.0f - _1065);
        _1083 = _1011;
        _1084 = _994;
        _1085 = lerp(1.0f.xxx, clamp(abs((frac(float3(_1058, _1065, _1067).xxx + float3(1.0f, 0.666666686534881591796875f, 0.3333333432674407958984375f)) * 6.0f) - 3.0f.xxx) - 1.0f.xxx, 0.0f.xxx, 1.0f.xxx), _1065.xxx) * _1067;
        _1086 = (isnan(0.0f) ? _1024 : (isnan(_1024) ? 0.0f : max(_1024, 0.0f))) * _585;
    }
    else
    {
        _1083 = 0.0f.xxxx;
        _1084 = 1.0f.xxx;
        _1085 = _20_m82.xyz;
        _1086 = _585;
    }
    float _1105 = clamp(dot(_529, _429), 0.0f, 1.0f);
    float _1111 = clamp((1.0f - clamp((_1105 * 0.85000002384185791015625f) + 0.1500000059604644775390625f, 0.0f, 1.0f)) * _50_m30, 0.0f, 1.0f);
    float3 _1119 = _463 * ((1.0f - _1111).xxx + (_50_m34.xyz * _1111));
    float3 _1887;
    float _1888;
    float _1889;
    float _1890;
    float _1891;
    float3 _1892;
    float3 _1893;
    [branch]
    if ((clamp(_564 + _577, 0.0f, 1.0f) - _50_m20) > 0.00999999977648258209228515625f)
    {
        float _1250;
        bool _1251;
        bool _1131 = (step(_564, 0.00999999977648258209228515625f) * step(0.00999999977648258209228515625f, _577)) != 0.0f;
        bool3 _1132 = _438.xxx;
        float3 _1134 = _11.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 _1138 = float3(_1132.x ? _1134.x : _11.x, _1132.y ? _1134.y : _11.y, _1132.z ? _1134.z : _11.z) * _20_m89.z;
        float3 _1148 = float3(0.0f, -1.0f, 0.0f) + (_523 * _523.y);
        float3 _1156 = ((_10.xyz * dot(_1148, _6.xyz * 1.0f)) + ((cross(_9, _10.xyz) * _10.w) * dot(_1148, (cross(_5, _6.xyz) * _6.w) * 1.0f))) + (_9 * dot(_1148, _523));
        float3 _1158 = _1156.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 _1159 = float3(_1132.x ? _1158.x : _1156.x, _1132.y ? _1158.y : _1156.y, _1132.z ? _1158.z : _1156.z);
        float3 _1167 = frac(floor(_1138.xz * 20.0f).xyx * 0.103100001811981201171875f);
        float3 _1172 = _1167 + dot(_1167, _1167.yzx + 33.3300018310546875f.xxx).xxx;
        float _1181 = lerp(0.300000011920928955078125f, 0.64999997615814208984375f, frac((_1138.y * (-3.0f)) + frac((_1172.x + _1172.y) * _1172.z)));
        bool _1182 = !_1131;
        bool2 _1183 = _1182.xx;
        float2 _1185 = (1.0f - _577).xx;
        float2 _1186 = float2(_1183.x ? float2(3.0f, 4.345600128173828125f).x : _1185.x, _1183.y ? float2(3.0f, 4.345600128173828125f).y : _1185.y);
        float _1189 = 1.0f - (0.800000011920928955078125f * (_1131 ? _577 : _564));
        float _1192 = _1182 ? _20_m10.x : 1.0f;
        float _1194 = _1192 * _1186.x;
        float _1196 = _1192 * _1186.y;
        float3 _1197 = _1138 * 24.0f;
        float3 _1198 = _1138 * 36.270000457763671875f;
        float3 _1200 = abs(float3(_1132.x ? _9.xzy.x : _9.x, _1132.y ? _9.xzy.y : _9.y, _1132.z ? _9.xzy.z : _9.z)) - 0.20000000298023223876953125f.xxx;
        bool3 _3796 = isnan(_1200);
        bool3 _3797 = isnan(0.0f.xxx);
        float3 _3798 = max(_1200, 0.0f.xxx);
        float3 _3799 = float3(_3796.x ? 0.0f.xxx.x : _3798.x, _3796.y ? 0.0f.xxx.y : _3798.y, _3796.z ? 0.0f.xxx.z : _3798.z);
        float3 _1202 = pow(float3(_3797.x ? _1200.x : _3799.x, _3797.y ? _1200.y : _3799.y, _3797.z ? _1200.z : _3799.z), 10.0f.xxx);
        float _1203 = dot(_1202, 1.0f.xxx);
        float3 _1206 = _1202 / (isnan(6.103515625e-05f) ? _1203 : (isnan(_1203) ? 6.103515625e-05f : max(_1203, 6.103515625e-05f))).xxx;
        float2 _1208 = _1159.xz;
        float _1209 = _1206.y;
        float2 _1210 = _1197.xz * 1.0f;
        float2 _1211 = floor(_1210);
        float2 _1214 = frac(_1211 * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1218 = _1214 + dot(_1214, _1214 + 34.345001220703125f.xx).xx;
        float _1219 = _1218.x;
        float _1220 = _1218.y;
        float2 _1224 = frac(float2(_1219 * _1220, _1219 + _1220));
        float2 _1227 = frac((_1211 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1231 = _1227 + dot(_1227, _1227 + 34.345001220703125f.xx).xx;
        float _1232 = _1231.x;
        float _1233 = _1231.y;
        float2 _1237 = frac(float2(_1232 * _1233, _1232 + _1233));
        float _1243 = _1224.x;
        float _1246 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, _1243)) * _1181;
        float2 _1247 = ((_1210 - _1211) + ((((_1237 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 _1264;
        do
        {
            _1250 = dot(_1208, _1208);
            _1251 = _1250 <= 9.9999997473787516355514526367188e-06f;
            if (_1251)
            {
                _1264 = _1247;
                break;
            }
            float2 _1255 = _1208 * rsqrt(_1250);
            _1264 = float2(dot(_1247, float2(-_1255.y, _1255.x)), -dot(_1247, _1255));
            break;
        } while(false);
        float _1347;
        bool _1348;
        float2 _1271 = float2(_1264.x * 1.25f, _1264.y * ((_1264.y < 0.0f) ? 1.25f : 0.75f));
        float _1272 = length(_1271);
        float _1274 = _1194 + _1243;
        float _1278 = _1182 ? frac(_1274) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(_1274, 0.0f, 1.0f));
        float _1290 = _1224.y;
        float _1293 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, _1278) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, _1278)) * step(0.001000000047497451305389404296875f, smoothstep(_1246, 0.0f, _1272))) * step(_1189, _1290 - 0.100000001490116119384765625f);
        float _1296 = _1293 * _1209;
        float2 _1303 = float2(_1246 * _1293, _1246 - _1272) * _1209;
        float2 _1305 = _1159.xy;
        float _1306 = _1206.z;
        float2 _1307 = _1197.xy * 1.0f;
        float2 _1308 = floor(_1307);
        float2 _1311 = frac(_1308 * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1315 = _1311 + dot(_1311, _1311 + 34.345001220703125f.xx).xx;
        float _1316 = _1315.x;
        float _1317 = _1315.y;
        float2 _1321 = frac(float2(_1316 * _1317, _1316 + _1317));
        float2 _1324 = frac((_1308 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1328 = _1324 + dot(_1324, _1324 + 34.345001220703125f.xx).xx;
        float _1329 = _1328.x;
        float _1330 = _1328.y;
        float2 _1334 = frac(float2(_1329 * _1330, _1329 + _1330));
        float _1340 = _1321.x;
        float _1343 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, _1340)) * _1181;
        float2 _1344 = ((_1307 - _1308) + ((((_1334 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 _1361;
        do
        {
            _1347 = dot(_1305, _1305);
            _1348 = _1347 <= 9.9999997473787516355514526367188e-06f;
            if (_1348)
            {
                _1361 = _1344;
                break;
            }
            float2 _1352 = _1305 * rsqrt(_1347);
            _1361 = float2(dot(_1344, float2(-_1352.y, _1352.x)), -dot(_1344, _1352));
            break;
        } while(false);
        float _1444;
        bool _1445;
        float2 _1368 = float2(_1361.x * 1.25f, _1361.y * ((_1361.y < 0.0f) ? 1.25f : 0.75f));
        float _1369 = length(_1368);
        float _1371 = _1194 + _1340;
        float _1375 = _1182 ? frac(_1371) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(_1371, 0.0f, 1.0f));
        float _1387 = _1321.y;
        float _1390 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, _1375) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, _1375)) * step(0.001000000047497451305389404296875f, smoothstep(_1343, 0.0f, _1369))) * step(_1189, _1387 - 0.100000001490116119384765625f);
        float _1393 = _1390 * _1306;
        float2 _1400 = float2(_1343 * _1390, _1343 - _1369) * _1306;
        float2 _1402 = _1159.zy;
        float _1403 = _1206.x;
        float2 _1404 = _1197.zy * 1.0f;
        float2 _1405 = floor(_1404);
        float2 _1408 = frac(_1405 * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1412 = _1408 + dot(_1408, _1408 + 34.345001220703125f.xx).xx;
        float _1413 = _1412.x;
        float _1414 = _1412.y;
        float2 _1418 = frac(float2(_1413 * _1414, _1413 + _1414));
        float2 _1421 = frac((_1405 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1425 = _1421 + dot(_1421, _1421 + 34.345001220703125f.xx).xx;
        float _1426 = _1425.x;
        float _1427 = _1425.y;
        float2 _1431 = frac(float2(_1426 * _1427, _1426 + _1427));
        float _1437 = _1418.x;
        float _1440 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, _1437)) * _1181;
        float2 _1441 = ((_1404 - _1405) + ((((_1431 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 _1458;
        do
        {
            _1444 = dot(_1402, _1402);
            _1445 = _1444 <= 9.9999997473787516355514526367188e-06f;
            if (_1445)
            {
                _1458 = _1441;
                break;
            }
            float2 _1449 = _1402 * rsqrt(_1444);
            _1458 = float2(dot(_1441, float2(-_1449.y, _1449.x)), -dot(_1441, _1449));
            break;
        } while(false);
        float2 _1465 = float2(_1458.x * 1.25f, _1458.y * ((_1458.y < 0.0f) ? 1.25f : 0.75f));
        float _1466 = length(_1465);
        float _1468 = _1194 + _1437;
        float _1472 = _1182 ? frac(_1468) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(_1468, 0.0f, 1.0f));
        float _1484 = _1418.y;
        float _1487 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, _1472) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, _1472)) * step(0.001000000047497451305389404296875f, smoothstep(_1440, 0.0f, _1466))) * step(_1189, _1484 - 0.100000001490116119384765625f);
        float _1490 = _1487 * _1403;
        float2 _1497 = float2(_1440 * _1487, _1440 - _1466) * _1403;
        bool2 _3806 = isnan(_1400);
        bool2 _3807 = isnan(_1497);
        float2 _3808 = max(_1400, _1497);
        float2 _3809 = float2(_3806.x ? _1497.x : _3808.x, _3806.y ? _1497.y : _3808.y);
        float2 _1498 = float2(_3807.x ? _1400.x : _3809.x, _3807.y ? _1400.y : _3809.y);
        bool2 _3811 = isnan(_1303);
        bool2 _3812 = isnan(_1498);
        float2 _3813 = max(_1303, _1498);
        float2 _3814 = float2(_3811.x ? _1498.x : _3813.x, _3811.y ? _1498.y : _3813.y);
        float2 _1499 = float2(_3812.x ? _1303.x : _3814.x, _3812.y ? _1303.y : _3814.y);
        float _1505 = isnan(_1393) ? _1296 : (isnan(_1296) ? _1393 : max(_1296, _1393));
        float _1506 = isnan(_1505) ? _1490 : (isnan(_1490) ? _1505 : max(_1490, _1505));
        float4 _1509 = float4((float4(((clamp(_1271 / _1246.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, _1237.x)) * _1293) * _1209, _1296, _1290).xy + float4(((clamp(_1368 / _1343.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, _1334.x)) * _1390) * _1306, _1393, _1387).xy) + float4(((clamp(_1465 / _1440.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, _1431.x)) * _1487) * _1403, _1490, _1484).xy, _1506, 0.0f);
        float2 _1511 = _1198.xz * 1.0f;
        float2 _1512 = floor(_1511);
        float2 _1515 = frac(_1512 * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1519 = _1515 + dot(_1515, _1515 + 34.345001220703125f.xx).xx;
        float _1520 = _1519.x;
        float _1521 = _1519.y;
        float2 _1525 = frac(float2(_1520 * _1521, _1520 + _1521));
        float2 _1528 = frac((_1512 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1532 = _1528 + dot(_1528, _1528 + 34.345001220703125f.xx).xx;
        float _1533 = _1532.x;
        float _1534 = _1532.y;
        float2 _1538 = frac(float2(_1533 * _1534, _1533 + _1534));
        float _1544 = _1525.x;
        float _1547 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, _1544)) * _1181;
        float2 _1548 = ((_1511 - _1512) + ((((_1538 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 _1563;
        do
        {
            if (_1251)
            {
                _1563 = _1548;
                break;
            }
            float2 _1554 = _1208 * rsqrt(_1250);
            _1563 = float2(dot(_1548, float2(-_1554.y, _1554.x)), -dot(_1548, _1554));
            break;
        } while(false);
        float2 _1570 = float2(_1563.x * 1.25f, _1563.y * ((_1563.y < 0.0f) ? 1.25f : 0.75f));
        float _1571 = length(_1570);
        float _1573 = _1196 + _1544;
        float _1577 = _1182 ? frac(_1573) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(_1573, 0.0f, 1.0f));
        float _1589 = _1525.y;
        float _1592 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, _1577) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, _1577)) * step(0.001000000047497451305389404296875f, smoothstep(_1547, 0.0f, _1571))) * step(_1189, _1589 - 0.100000001490116119384765625f);
        float _1595 = _1592 * _1209;
        float2 _1602 = float2(_1547 * _1592, _1547 - _1571) * _1209;
        float2 _1604 = _1198.xy * 1.0f;
        float2 _1605 = floor(_1604);
        float2 _1608 = frac(_1605 * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1612 = _1608 + dot(_1608, _1608 + 34.345001220703125f.xx).xx;
        float _1613 = _1612.x;
        float _1614 = _1612.y;
        float2 _1618 = frac(float2(_1613 * _1614, _1613 + _1614));
        float2 _1621 = frac((_1605 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1625 = _1621 + dot(_1621, _1621 + 34.345001220703125f.xx).xx;
        float _1626 = _1625.x;
        float _1627 = _1625.y;
        float2 _1631 = frac(float2(_1626 * _1627, _1626 + _1627));
        float _1637 = _1618.x;
        float _1640 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, _1637)) * _1181;
        float2 _1641 = ((_1604 - _1605) + ((((_1631 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 _1656;
        do
        {
            if (_1348)
            {
                _1656 = _1641;
                break;
            }
            float2 _1647 = _1305 * rsqrt(_1347);
            _1656 = float2(dot(_1641, float2(-_1647.y, _1647.x)), -dot(_1641, _1647));
            break;
        } while(false);
        float2 _1663 = float2(_1656.x * 1.25f, _1656.y * ((_1656.y < 0.0f) ? 1.25f : 0.75f));
        float _1664 = length(_1663);
        float _1666 = _1196 + _1637;
        float _1670 = _1182 ? frac(_1666) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(_1666, 0.0f, 1.0f));
        float _1682 = _1618.y;
        float _1685 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, _1670) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, _1670)) * step(0.001000000047497451305389404296875f, smoothstep(_1640, 0.0f, _1664))) * step(_1189, _1682 - 0.100000001490116119384765625f);
        float _1688 = _1685 * _1306;
        float2 _1695 = float2(_1640 * _1685, _1640 - _1664) * _1306;
        float2 _1697 = _1198.zy * 1.0f;
        float2 _1698 = floor(_1697);
        float2 _1701 = frac(_1698 * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1705 = _1701 + dot(_1701, _1701 + 34.345001220703125f.xx).xx;
        float _1706 = _1705.x;
        float _1707 = _1705.y;
        float2 _1711 = frac(float2(_1706 * _1707, _1706 + _1707));
        float2 _1714 = frac((_1698 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1718 = _1714 + dot(_1714, _1714 + 34.345001220703125f.xx).xx;
        float _1719 = _1718.x;
        float _1720 = _1718.y;
        float2 _1724 = frac(float2(_1719 * _1720, _1719 + _1720));
        float _1730 = _1711.x;
        float _1733 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, _1730)) * _1181;
        float2 _1734 = ((_1697 - _1698) + ((((_1724 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 _1749;
        do
        {
            if (_1445)
            {
                _1749 = _1734;
                break;
            }
            float2 _1740 = _1402 * rsqrt(_1444);
            _1749 = float2(dot(_1734, float2(-_1740.y, _1740.x)), -dot(_1734, _1740));
            break;
        } while(false);
        float2 _1756 = float2(_1749.x * 1.25f, _1749.y * ((_1749.y < 0.0f) ? 1.25f : 0.75f));
        float _1757 = length(_1756);
        float _1759 = _1196 + _1730;
        float _1763 = _1182 ? frac(_1759) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(_1759, 0.0f, 1.0f));
        float _1775 = _1711.y;
        float _1778 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, _1763) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, _1763)) * step(0.001000000047497451305389404296875f, smoothstep(_1733, 0.0f, _1757))) * step(_1189, _1775 - 0.100000001490116119384765625f);
        float _1781 = _1778 * _1403;
        float2 _1788 = float2(_1733 * _1778, _1733 - _1757) * _1403;
        bool2 _3826 = isnan(_1695);
        bool2 _3827 = isnan(_1788);
        float2 _3828 = max(_1695, _1788);
        float2 _3829 = float2(_3826.x ? _1788.x : _3828.x, _3826.y ? _1788.y : _3828.y);
        float2 _1789 = float2(_3827.x ? _1695.x : _3829.x, _3827.y ? _1695.y : _3829.y);
        bool2 _3831 = isnan(_1602);
        bool2 _3832 = isnan(_1789);
        float2 _3833 = max(_1602, _1789);
        float2 _3834 = float2(_3831.x ? _1789.x : _3833.x, _3831.y ? _1789.y : _3833.y);
        float _1796 = isnan(_1688) ? _1595 : (isnan(_1595) ? _1688 : max(_1595, _1688));
        float4 _1800 = float4((float4(((clamp(_1570 / _1547.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, _1538.x)) * _1592) * _1209, _1595, _1589).xy + float4(((clamp(_1663 / _1640.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, _1631.x)) * _1685) * _1306, _1688, _1682).xy) + float4(((clamp(_1756 / _1733.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, _1724.x)) * _1778) * _1403, _1781, _1775).xy, isnan(_1796) ? _1781 : (isnan(_1781) ? _1796 : max(_1781, _1796)), 0.0f);
        float _1802 = step(_1499.x, 0.00999999977648258209228515625f);
        float2 _1809 = _1509.zw * step(0.00999999977648258209228515625f, _1506);
        float2 _1811 = _1800.zw * _1802;
        bool2 _3846 = isnan(_1809);
        bool2 _3847 = isnan(_1811);
        float2 _3848 = max(_1809, _1811);
        float2 _3849 = float2(_3846.x ? _1811.x : _3848.x, _3846.y ? _1811.y : _3848.y);
        float2 _1814 = (float2(_3832.x ? _1602.x : _3834.x, _3832.y ? _1602.y : _3834.y) * float2(0.661703884601593017578125f, 1.0f)) * _1802;
        bool2 _3851 = isnan(_1499);
        bool2 _3852 = isnan(_1814);
        float2 _3853 = max(_1499, _1814);
        float2 _3854 = float2(_3851.x ? _1814.x : _3853.x, _3851.y ? _1814.y : _3853.y);
        float2 _1815 = float2(_3852.x ? _1499.x : _3854.x, _3852.y ? _1499.y : _3854.y);
        float _1821 = float2(_3847.x ? _1809.x : _3849.x, _3847.y ? _1809.y : _3849.y).x * clamp(dot(_429, _529), 0.0f, 1.0f);
        float2 _1822 = (_1509.xy + (_1800.xy * _1802)).xy;
        float _1826 = sqrt(1.0f - clamp(dot(_1822, _1822), 0.0f, 1.0f));
        float3 _1832 = normalize(float3(_1822 * 2.5f, isnan(_1826) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? _1826 : max(1.000000016862383526387164645044e-16f, _1826))));
        float2 _1834 = _1832.xy;
        float _1838 = sqrt(1.0f - clamp(dot(_1834, _1834), 0.0f, 1.0f));
        float3 _1840 = float3(_1832.x, _1832.y, 0.0f.xxx.z);
        _1840.z = isnan(_1838) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? _1838 : max(1.000000016862383526387164645044e-16f, _1838));
        float3 _1841 = normalize(_1840);
        float3 _1842 = cross(_529, float3(0.0f, 1.0f, 0.0f));
        bool3 _1845 = (dot(_1842, _1842) > 6.103515625e-05f).xxx;
        float3 _1846 = normalize(_1842);
        float3 _1847 = float3(_1845.x ? _1846.x : float3(1.0f, 0.0f, 0.0f).x, _1845.y ? _1846.y : float3(1.0f, 0.0f, 0.0f).y, _1845.z ? _1846.z : float3(1.0f, 0.0f, 0.0f).z);
        float _1851 = _1841.y;
        float _1858 = _1815.x * 4.0f;
        float _1868 = clamp(dot(_1841, normalize(float3(0.0f, -1.0f, 0.75f))), 0.0f, 1.0f);
        float _1874 = (0.60000002384185791015625f * _1821) * _1858;
        float _1877 = (1.0f - _1874) + (clamp(clamp(clamp(_1815.y * 17.54000091552734375f, 0.0f, 1.0f), 0.0f, 1.0f) + clamp(1.60000002384185791015625f * _1851, 0.0f, 1.0f), 0.0f, 1.0f) * _1874);
        float _1880 = smoothstep(0.60000002384185791015625f, 1.0f, _1877);
        float _1883 = _1821 * _1858;
        _1887 = normalize(((_1847 * _1841.x) + (cross(_1847, _529) * _1851)) + (_529 * _1841.z));
        _1888 = _1883;
        _1889 = ((lerp(0.0500000007450580596923828125f, 1.7999999523162841796875f, (_1868 * _1868) * _1868) * _1858) * _1880) * _1821;
        _1890 = lerp(1.0f, 0.800000011920928955078125f * lerp(0.5f, 1.0f, _1880), _1821);
        _1891 = _1883;
        _1892 = _504 * _1877;
        _1893 = _1119 * _1877;
    }
    else
    {
        _1887 = _529;
        _1888 = 0.0f;
        _1889 = 0.0f;
        _1890 = 1.0f;
        _1891 = 0.0f;
        _1892 = _504;
        _1893 = _1119;
    }
    float3 _2052;
    float _2053;
    float _2054;
    float3 _2055;
    float3 _2056;
    float _2057;
    [branch]
    if (_567 > 0.00999999977648258209228515625f)
    {
        bool3 _1897 = _438.xxx;
        float3 _1899 = _11.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 _1900 = float3(_1897.x ? _1899.x : _11.x, _1897.y ? _1899.y : _11.y, _1897.z ? _1899.z : _11.z);
        float3 _1903 = _1900 * _20_m89.z;
        float3 _1905 = float3(_1897.x ? _9.xzy.x : _9.x, _1897.y ? _9.xzy.y : _9.y, _1897.z ? _9.xzy.z : _9.z);
        float3 _1907 = abs(_1905) - 0.20000000298023223876953125f.xxx;
        float3 _1909 = (_1907 * _1907) * _1907;
        bool3 _3866 = isnan(_1909);
        bool3 _3867 = isnan(6.103515625e-05f.xxx);
        float3 _3868 = max(_1909, 6.103515625e-05f.xxx);
        float3 _3869 = float3(_3866.x ? 6.103515625e-05f.xxx.x : _3868.x, _3866.y ? 6.103515625e-05f.xxx.y : _3868.y, _3866.z ? 6.103515625e-05f.xxx.z : _3868.z);
        float3 _1910 = float3(_3867.x ? _1909.x : _3869.x, _3867.y ? _1909.y : _3869.y, _3867.z ? _1909.z : _3869.z);
        float3 _1913 = _1910 / dot(_1910, 1.0f.xxx).xxx;
        float _1929 = _1913.y;
        float _1931 = _1913.z;
        float _1934 = _1913.x;
        float4 _1936 = ((_53.SampleBias(eid4780_linear_repeat_sampler27, _1903.xz, _20_m16) * _1929) + (_53.SampleBias(eid4780_linear_repeat_sampler27, _1903.xy, _20_m16) * _1931)) + (_53.SampleBias(eid4780_linear_repeat_sampler27, _1903.zy, _20_m16) * _1934);
        float _1944 = clamp(_567 + (smoothstep(0.3499999940395355224609375f, 0.20000000298023223876953125f, _1900.y) * clamp(_567 * 3.0f, 0.0f, 1.0f)), 0.0f, 1.0f);
        float _1955 = smoothstep(2.0f - _1944, 2.349999904632568359375f - _1944, (smoothstep(-1.0f, 0.0f, _1905.y) + _1936.z) * 0.60000002384185791015625f) * ((_471 * _471) * float(gl_FrontFacing));
        float3 _1957 = _1955.xxx;
        float2 _1963 = (_1936.xy * 2.0f) - 1.0f.xx;
        float2 _1965 = _1963.xy;
        float _1969 = sqrt(1.0f - clamp(dot(_1965, _1965), 0.0f, 1.0f));
        float3 _1971 = float3(_1963.x, _1963.y, _388.z);
        _1971.z = isnan(_1969) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? _1969 : max(1.000000016862383526387164645044e-16f, _1969));
        float2 _1973 = _1971.xy * 2.0f;
        float3 _1975 = lerp(float3(0.0f, 0.0f, 1.0f), float3(_1973.x, _1973.y, _1971.z), _1957);
        float _1976 = dot(_1975, _1975);
        float3 _1979 = _1975 * rsqrt(isnan(_1976) ? 6.103515625e-05f : (isnan(6.103515625e-05f) ? _1976 : max(6.103515625e-05f, _1976)));
        float _1980 = _529.y;
        float _1983 = step(0.00999999977648258209228515625f, 1.0f - (_1980 * _1980));
        float _1986 = lerp(_587, _1980, _1983);
        float _1988 = 1.0f - (_1986 * _1986);
        float3 _1993 = (float3(0.0f, _1983, 1.0f - _1983) - (_529 * _1986)) * rsqrt(isnan(_1988) ? 9.9999997473787516355514526367188e-05f : (isnan(9.9999997473787516355514526367188e-05f) ? _1988 : max(9.9999997473787516355514526367188e-05f, _1988)));
        float3 _2007 = _1903 * 4.0f;
        float4 _2027 = ((_54.SampleLevel(eid4780_point_clamp_sampler25, _2007.xz, 0.0f) * _1929) + (_54.SampleLevel(eid4780_point_clamp_sampler25, _2007.xy, 0.0f) * _1931)) + (_54.SampleLevel(eid4780_point_clamp_sampler25, _2007.zy, 0.0f) * _1934);
        float2 _2030 = (_2027.xz * 2.0f) - 1.0f.xx;
        float _2041 = smoothstep(0.949999988079071044921875f, 1.0f, frac(((dot(float3(_2030.x, _2027.y, _2030.y), (floor(_429 * 50.0f) * 0.0199999995529651641845703125f) * 0.100000001490116119384765625f) * 0.5f) + 0.5f) * 2.0f));
        float _2042 = _2041 * _2041;
        float _2045 = _2042 * ((_2042 * 2.0f) * _1955);
        float3 _2046 = 1.0f.xxx * _2045;
        _2052 = ((cross(_1993, _529) * _1979.x) + (_1993 * _1979.y)) + (_529 * _1979.z);
        _2053 = _1891 + _2045;
        _2054 = lerp(lerp(_470, 0.89999997615814208984375f, clamp(_1955 * 4.0f, 0.0f, 1.0f)), 0.00999999977648258209228515625f, _2045);
        _2055 = lerp(_1892 * 1.0f, 0.3079999983310699462890625f.xxx, _1957) + (_2046 * 0.5f);
        _2056 = lerp(_1893 * 1.0f, 0.87999999523162841796875f.xxx, _1957) + _2046;
        _2057 = lerp(_50_m2, 0.0f, _1955);
    }
    else
    {
        _2052 = _529;
        _2053 = _1891;
        _2054 = _470;
        _2055 = _1892;
        _2056 = _1893;
        _2057 = _50_m2;
    }
    float _2059 = 0.959999978542327880859375f - (_2057 * 0.959999978542327880859375f);
    float3 _2060 = _2056 * _2059;
    float3 _2063 = lerp(0.039999999105930328369140625f.xxx * _50_m1, _2056, _2057.xxx);
    float3 _2064 = _2055 * _2059;
    float _2065 = _2054 * _2054;
    float _2066 = isnan(0.0078125f) ? _2065 : (isnan(_2065) ? 0.0078125f : max(_2065, 0.0078125f));
    float2 _2079 = (_7.xy / (isnan(9.9999999392252902907785028219223e-09f) ? _7.z : (isnan(_7.z) ? 9.9999999392252902907785028219223e-09f : max(_7.z, 9.9999999392252902907785028219223e-09f))).xx) - (_8.xy / (isnan(9.9999999392252902907785028219223e-09f) ? _8.z : (isnan(_8.z) ? 9.9999999392252902907785028219223e-09f : max(_8.z, 9.9999999392252902907785028219223e-09f))).xx);
    float2 _2082 = _2079;
    _2082.y = -_2079.y;
    float2 _2092 = ((sqrt(sqrt(abs(_2082 * 0.5f))) * float2(int2(sign(_2082)))) * 0.5f) + 0.5f.xx;
    float4 _2096 = float4(_2092.x, _2092.y, 0.0f.xxxx.z, 0.0f.xxxx.w);
    _2096.z = 1.0f;
    float4 _2097 = _2096;
    _2097.w = (_2053 > 0.100000001490116119384765625f) ? 0.699999988079071044921875f : 0.4000000059604644775390625f;
    float3 _2108 = lerp(-_37_m0.xyz, _20_m90.xyz, _20_m80.w.xxx);
    float3 _2112 = normalize(float3(_2108.x, 6.103515625e-05f, _2108.z));
    float3 _2122 = lerp(_37_m3.xyz, _20_m83.xyz, _20_m91.y.xxx);
    float3 _2126 = _2122 * lerp(_37_m3.w, 1.0f, _20_m91.w);
    int _2130 = int(_531.x);
    int _2131 = int(_531.y);
    // Isolate captured AO/shadow from the per-camera live CP20 override.
    float4 _2135;
    if (_EID4780UseCapturedScreen40 > 0.5f)
        _2135 = capturedScreenValid ? _EID4780CapturedScreen40.Load(int3(int2(capturedPixel), 0)) : float4(1,1,0,0);
    else
        _2135 = _41.Load(int3(_2130, _2131, 0));
    float _2140 = _2135.y;
    float _2143 = lerp(lerp(1.0f, _2135.x, _39_m6.x), 1.0f, _20_m80.z);
    float3 _2151 = _2064 * _20_m79.z;
    float3 _2152 = _2151 * 0.64999997615814208984375f;
    float _2156 = dot(_2060, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float4 _2172 = _51.SampleLevel(eid4780_linear_clamp_sampler26, float2((clamp(dot(_2052, _2108) + (_20_m90.w * _20_m91.x), -1.0f, 1.0f) * 0.5f) + 0.5f, 0.5f), 0.0f);
    float _2173 = _2172.w;
    float _2175 = _2172.x;
    float _2176 = _2172.y;
    float _2177 = _2172.z;
    float _2178 = isnan(_2176) ? _2175 : (isnan(_2175) ? _2176 : max(_2175, _2176));
    float _2180 = isnan(_2176) ? _2175 : (isnan(_2175) ? _2176 : min(_2175, _2176));
    float _2182 = (isnan(_2177) ? _2178 : (isnan(_2178) ? _2177 : max(_2178, _2177))) - (isnan(_2177) ? _2180 : (isnan(_2180) ? _2177 : min(_2180, _2177)));
    float _2183 = _471 * _2140;
    float _2188 = isnan(_471) ? _2140 : (isnan(_2140) ? _471 : min(_2140, _471));
    float _2189 = isnan(_2173) ? _2188 : (isnan(_2188) ? _2173 : min(_2188, _2173));
    float3 _2193 = ((clamp(dot(_589, _20_m85.xyz) + _20_m86.x, 0.0f, 1.0f) * _20_m86.y) + _20_m86.z).xxx * lerp(_1085, 1.0f.xxx, (_20_m80.y * _2189).xxx);
    float3 _2195 = _2189.xxx;
    float _2208 = lerp(0.64999997615814208984375f, 1.0f, _1086);
    float3 _2218 = _2143.xxx;
    float3 _2219 = lerp((_2193 * lerp(isnan(1.5f) ? _2208 : (isnan(_2208) ? 1.5f : min(_2208, 1.5f)), clamp(_1086, 1.25f, 1.75f), _20_m80.x)) * _20_m79.w, (lerp(dot(_2126, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, _2126, _2195) + ((_2193 * clamp(_1086, 0.0f, 1.5f)) * ((1.0f - _20_m91.y).xxx + (_2122 * _20_m91.y)))) * _20_m79.y, _2218);
    float3 _2220 = lerp(lerp(lerp(dot(_2152, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, _2152, 1.2000000476837158203125f.xxx), _2151, clamp(_2183 + _2173, 0.0f, 1.0f).xxx), _2060, _2195);
    float3 _2226 = _2220 * ((1.0f - _2182).xxx + (_2172.xyz * _2182));
    float _2227 = dot(_2226, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float3 _2235 = lerp(lerp(_2151, lerp(_2156.xxx, _2060, 1.2000000476837158203125f.xxx), _2183.xxx), _2226 * clamp(dot(_2220, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)) * (1.0f / (isnan(0.001000000047497451305389404296875f) ? _2227 : (isnan(_2227) ? 0.001000000047497451305389404296875f : max(_2227, 0.001000000047497451305389404296875f)))), 0.0f, 1.5f), _2218);
    float4 _2239 = float4(_2235, _2143);
    float3 _2240 = _2219 * _2235;
    float _2241 = lerp(_2183, _2189, _2143);
    float3 _2247 = (_2219 * (((_2241 * 0.5f) + 0.5f) * lerp(_20_m79.z, 1.0f, _2241))) * 1.0f;
    float3 _2252 = float3(_541.x, lerp(0.5f, _2108.y, _2143), _541.z);
    float _2253 = dot(_2252, _2252);
    float3 _2263 = normalize(((_2108 * _2143) + ((_2252 * rsqrt(isnan(_2253) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? _2253 : max(1.1754943508222875079687365372222e-38f, _2253)))) * 2.0f)) + (_429 * (2.0f + _2143)));
    float _2264 = dot(_529, _2263);
    float _2265 = _2066 * _2066;
    float _2269 = (((_2264 * _2265) - _2264) * _2264) + 1.0f;
    float _2270 = _2269 * _2269;
    float _2274 = 2.0f * _1105;
    float _2276 = (1.0f + _1105) - _1105;
    float3 _2288 = ((_2063 * clamp((((_2265 != _2270) ? (_2265 / _2270) : 1.0f) * (0.5f / ((_2274 + (_2066 * _2276)) + 9.9999997473787516355514526367188e-05f))) - 6.103515625e-05f, 0.0f, 20.0f)) * _2247) * _20_m92.w;
    float3 _2296 = normalize(float3(-_1887.z, 0.001000000047497451305389404296875f, _1887.x));
    float _2305 = dot(_1887, _2263);
    float3 _2315 = (_2240 * 1.0f) + ((_2288 * _1890) + (((_2240 + _2288) * _1889) + (((((smoothstep(0.1500000059604644775390625f, 0.100000001490116119384765625f, abs(dot(_2263, _2296))) * smoothstep(0.070000000298023223876953125f, 0.0199999995529651641845703125f, abs(dot(_2263, cross(_1887, _2296))))) * (isnan(_2305) ? 0.0f : (isnan(0.0f) ? _2305 : max(0.0f, _2305)))) * 2.0f) * _1888).xxx * _2247)));
    float _2316 = dot(_2315, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float _2319 = clamp(_2316 - 0.5f, 0.0f, 0.5f);
    float3 _2355 = normalize(cross(_541, lerp(float3(_20_m88.xy, 0.0f), (float3(_18_m0[0].x, _18_m0[0].y, _18_m0[0].z) * _20_m88.x) + (float3(_18_m0[1].x, _18_m0[1].y, _18_m0[1].z) * _20_m88.y), _20_m94.w.xxx)));
    float _2361 = dot(_429, _2052);
    float _2363 = 1.0f - abs(_2361);
    float _2373 = clamp(dot(_515, _2355) + 1.0f, 0.0f, 1.0f);
    float _2374 = isnan(_471) ? _2373 : (isnan(_2373) ? _471 : min(_2373, _471));
    float _2385 = dot(_2112, _2052);
    float _2399 = 1.0f - _2143;
    float _2411 = isnan(_1084.y) ? _1084.x : (isnan(_1084.x) ? _1084.y : max(_1084.x, _1084.y));
    float _2413 = (isnan(_1084.z) ? _2411 : (isnan(_2411) ? _1084.z : max(_2411, _1084.z))) * 0.5f;
    bool3 _3981 = isnan(0.1500000059604644775390625f.xxx);
    bool3 _3982 = isnan(_2060);
    float3 _3983 = max(0.1500000059604644775390625f.xxx, _2060);
    float3 _3984 = float3(_3981.x ? _2060.x : _3983.x, _3981.y ? _2060.y : _3983.y, _3981.z ? _2060.z : _3983.z);
    float2 _2428 = clamp(capturedPixel, 0.0f, _20_m0.xy - 1.0f);
    float2 _2430 = floor(_2428 * 0.03125f);
    int _2438 = int((_2430.x + (_2430.y * _35_m5)) * 8.0f);
    float _2445 = floor(_410 - (_20_m3.y * _35_m11));
    float _2449 = clamp(_2445, 0.0f, _35_m7 - 1.0f);
    int _2451 = int(_2449 * 8.0f);
    float3 _2453;
    _2453 = lerp(_2316.xxx, _2315, ((_2319 * _2319) + 1.0f).xxx) + (((((_20_m87.xyz * smoothstep(lerp(0.800000011920928955078125f, 0.20000000298023223876953125f, _20_m88.w), lerp(0.89999997615814208984375f, 0.5f, _20_m88.w), _2363)) * _20_m87.w) * (isnan(_2140) ? _2374 : (isnan(_2374) ? _2140 : min(_2374, _2140)))) * (lerp(0.25f.xxx, _2060, _20_m88.z.xxx) * clamp(dot(_2355, _2052), 0.0f, 1.0f))) + ((((((lerp(_1084 * (1.0f / (isnan(1.0f) ? _2413 : (isnan(_2413) ? 1.0f : max(_2413, 1.0f)))), _2126, _2218) * clamp(lerp(dot(_1083.xyz, _2052) * _1083.w, ((-_2385) * ((_2385 * 0.5f) - 1.0f)) + 0.5f, _2143), 0.0f, 1.0f)) * ((_2399 + (clamp(-dot(_2112.xz, normalize(_541.xz)), 0.0f, 1.0f) * _2143)) * (1.0f - _20_m91.x))) * smoothstep(0.60000002384185791015625f, 0.800000011920928955078125f, _2363)) * (isnan(_2140) ? _471 : (isnan(_471) ? _2140 : min(_471, _2140)))) * (_2399 + (smoothstep(0.100000001490116119384765625f, 0.039999999105930328369140625f, _2156) * _2143))) * float3(_3982.x ? 0.1500000059604644775390625f.xxx.x : _3984.x, _3982.y ? 0.1500000059604644775390625f.xxx.y : _3984.y, _3982.z ? 0.1500000059604644775390625f.xxx.z : _3984.z)));
    float3 _2454;
    [loop]
    for (int _2456 = 0; _2456 <= 7; _2453 = _2454, _2456++)
    {
        uint _2474 = (capturedScreenValid && _2445 <= _2449) ? (_31.Load(uint(_2438 + _2456) * 4 + 0) & _31.Load(uint((_20_m21.y + _2451) + _2456) * 4 + 0)) : 0u;
        uint _2475 = uint(_2456);
        _2454 = _2453;
        uint _2480;
        float3 _2477;
        [loop]
        for (uint _2479 = _2474; _2479 != 0u; _2454 = _2477, _2479 = _2480)
        {
            uint _2484 = firstbitlow(_2479);
            _2480 = _2479 ^ (1u << (_2484 & 31u));
            int _2490 = int((32u * _2475) + _2484) * 8;
            int _2493 = _2490 + 1;
            int _2496 = _2490 + 2;
            int _2499 = _2490 + 3;
            int _2502 = _2490 + 4;
            int _2505 = _2490 + 5;
            int _2508 = _2490 + 6;
            int _2511 = _2490 + 7;
            uint _2515 = uint(_37_m6[_2505].w);
            float _2590;
            if ((_2515 & 1u) == 1u)
            {
                uint _2521 = asuint(_37_m6[_2505].x);
                uint _2528 = asuint(_37_m6[_2505].y);
                uint _2535 = asuint(_37_m6[_2505].z);
                uint _2542 = asuint(_37_m6[_2508].x);
                uint _2549 = asuint(_37_m6[_2508].y);
                uint _2556 = asuint(_37_m6[_2508].z);
                float3 _2575 = abs(mul(float4(_508 - _37_m6[_2493].xyz, 1.0f), float4x4(float4(spvUnpackHalf2x16(_2521).x, spvUnpackHalf2x16(_2535).x, spvUnpackHalf2x16(_2549).x, 0.0f), float4(spvUnpackHalf2x16(_2521 >> 16u).x, spvUnpackHalf2x16(_2535 >> 16u).x, spvUnpackHalf2x16(_2549 >> 16u).x, 0.0f), float4(spvUnpackHalf2x16(_2528).x, spvUnpackHalf2x16(_2542).x, spvUnpackHalf2x16(_2556).x, 0.0f), float4(spvUnpackHalf2x16(_2528 >> 16u).x, spvUnpackHalf2x16(_2542 >> 16u).x, spvUnpackHalf2x16(_2556 >> 16u).x, 0.0f))).xyz);
                float _2576 = _2575.x;
                float _2577 = _2575.y;
                float _2578 = isnan(_2577) ? _2576 : (isnan(_2576) ? _2577 : max(_2576, _2577));
                float _2579 = _2575.z;
                float _2582 = _37_m6[_2511].x * 0.5f;
                float _2588 = 1.0f - clamp(((isnan(_2579) ? _2578 : (isnan(_2578) ? _2579 : max(_2578, _2579))) - (_2582 + 0.5f)) / (0.5f - _2582), 0.0f, 1.0f);
                _2590 = _2588 * _2588;
            }
            else
            {
                _2590 = 1.0f;
            }
            if (false || (_2590 < 0.001000000047497451305389404296875f))
            {
                _2477 = _2454;
                continue;
            }
            float3 _3283;
            if (_37_m6[_2490].w < 1.5f)
            {
                float3 _3282;
                do
                {
                    uint _2603 = asuint(_37_m6[_2499].w);
                    if ((_2603 == 16u) || ((_37_m6[_2499].z + _20_m91.z) < 0.5f))
                    {
                        _3282 = _2454;
                        break;
                    }
                    bool _2615 = (uint(_37_m6[_2490].w) & 1u) == 0u;
                    bool _2619 = (!_2615) && (_37_m6[_2496].z > 0.0f);
                    bool _2620 = _2603 == 4u;
                    float _2621 = float(_2615);
                    float _2629 = (0.5f + (0.5f * _37_m6[_2496].y)) - abs(_37_m6[_2496].x);
                    float _2630 = _37_m6[_2496].y - _2629;
                    float _2634 = (1.0f - abs(_2629)) - abs(_2630);
                    float _2637 = abs(isnan(0.00048828125f) ? _2634 : (isnan(_2634) ? 0.00048828125f : max(_2634, 0.00048828125f)));
                    float3 _2641 = normalize(float3(_2629, _2630, (_37_m6[_2496].x >= 0.0f) ? _2637 : (-_2637)));
                    float _2644 = 2.0f * _37_m6[_2502].y;
                    float _2647 = lerp(_37_m6[_2508].w, isnan(0.100000001490116119384765625f) ? _2644 : (isnan(_2644) ? 0.100000001490116119384765625f : max(_2644, 0.100000001490116119384765625f)), float(_2620));
                    float3 _2652 = _37_m6[_2493].xyz - _508;
                    float3 _2653 = -_2641;
                    float3 _2658 = lerp(_2652, _2653 * dot(_2652, _2653), (float(_2620 && (_37_m6[_2502].z > 0.5f)) * _2621).xxx);
                    float _2659 = dot(_2658, _2658);
                    float _2660 = rsqrt(_2659);
                    float3 _2661 = _2658 * _2660;
                    float3 _2694;
                    float _2695;
                    if (_2619)
                    {
                        float3 _2665 = (_2641 * _37_m6[_2496].z) * 0.5f;
                        float3 _2666 = _2658 - _2665;
                        float3 _2667 = _2658 + _2665;
                        float _2668 = length(_2666);
                        float _2669 = length(_2667);
                        float3 _2678 = normalize(cross(cross(_2641, _2661), _2641));
                        _2694 = _2678;
                        _2695 = ((1.0f / ((((_2668 * _2669) + dot(_2666, _2667)) * 0.5f) + 1.0f)) * clamp(0.5f * ((dot(_2678, _2666) / _2668) + (dot(_2678, _2667) / _2669)), 0.0f, 1.0f)) * (1.0f / clamp(1.0f + (0.5f * clamp(_37_m6[_2496].z * _2660, 0.0f, 1.0f)), 0.0f, 1.0f));
                    }
                    else
                    {
                        _2694 = _2661;
                        _2695 = 1.0f;
                    }
                    float _2717;
                    if (_2647 < 0.0f)
                    {
                        float _2705 = _2659 * (_37_m6[_2493].w * _37_m6[_2493].w);
                        float _2708 = clamp(1.0f - (_2705 * _2705), 0.0f, 1.0f);
                        _2717 = lerp(1.0f / (_2659 + 1.0f), _2695, float(_2619)) * (_2708 * _2708);
                    }
                    else
                    {
                        float3 _2711 = _2658 * _37_m6[_2493].w;
                        _2717 = _2695 * pow(1.0f - clamp(dot(_2711, _2711), 0.0f, 1.0f), _2647);
                    }
                    float _2722 = clamp((dot(_2694, _2653) - _37_m6[_2496].z) * _37_m6[_2496].w, 0.0f, 1.0f);
                    float _2725 = _2717 * lerp(1.0f, _2722 * _2722, _2621);
                    int _2727 = int(_37_m6[_2511].w);
                    float _2831;
                    if ((!_2619) && (_2727 >= 0))
                    {
                        uint _2733 = uint(_2727);
                        float2 _2824;
                        [branch]
                        if (_2621 != 0.0f)
                        {
                            float4 _2745 = mul(_58_m1[_2733], float4(_508.x, _573, _508.z, 1.0f));
                            _2824 = _58_m0[_2733].xy + (clamp(_2745.xy / _2745.w.xx, 0.0f.xx, 1.0f.xx) * _58_m0[_2733].zw);
                        }
                        else
                        {
                            float3 _2765 = mul(float4(-_2658, 0.0f), _58_m1[_2733]).xyz;
                            float3 _398 = _2765;
                            float3 _397 = _2765;
                            float3 _396 = abs(_2765);
                            uint _2774 = uint(int(_396.y > _396.x));
                            uint _2780 = (_396.z > _396[_2774]) ? 2u : _2774;
                            uint _2786 = (_2780 * 2u) + uint(_397[_2780] < 0.0f);
                            float _2790 = abs(_398[_2786 / 2u]);
                            float _2810 = 0.5f - (0.000244140625f / _58_m0[_2733].w);
                            _2824 = _58_m0[_2733].xy + (clamp(float2((float(_2786) + ((((_398[uint(_361[_2786].x)] * _362[_2786].x) / _2790) * _2810) + 0.5f)) * 0.16666667163372039794921875f, 0.5f - (((_398[uint(_361[_2786].y)] * _362[_2786].y) / _2790) * _2810)), 0.0f.xx, 1.0f.xx) * _58_m0[_2733].zw);
                        }
                        _2831 = _2725 * _56.SampleLevel(eid4780_linear_clamp_sampler26, _2824, 0.0f).x;
                    }
                    else
                    {
                        _2831 = _2725;
                    }
                    float _2832 = _2831 * _2590;
                    float3 _3281;
                    do
                    {
                        float3 _3280;
                        [branch]
                        if (_2832 > 9.9999997473787516355514526367188e-05f)
                        {
                            [branch]
                            if (_2620)
                            {
                                _3281 = lerp(_2454, _37_m6[_2490].xyz, (_2832 * (_37_m6[_2502].x * ((1.0f - _37_m6[_2502].w) + (smoothstep(-0.5f, 0.5f, dot(_529, _2694)) * _37_m6[_2502].w)))).xxx);
                                break;
                            }
                            float _2852 = dot(_2052, _2694);
                            float _2853 = clamp(_2852, 0.0f, 1.0f);
                            float _3156;
                            if (_2603 != 0u)
                            {
                                bool _2859 = _2615 || ((_2515 & 2u) != 0u);
                                int _2908;
                                if (_2859)
                                {
                                    _2908 = int(_37_m6[_2499].x);
                                }
                                else
                                {
                                    uint _2865 = asuint(_37_m6[_2496].w);
                                    uint _2867 = asuint(_37_m6[_2499].x);
                                    float3 _2868 = _508 - _37_m6[_2493].xyz;
                                    float3 _2869 = abs(_2868);
                                    float _2870 = _2869.x;
                                    float _2871 = _2869.y;
                                    float _2873 = _2869.z;
                                    int _2905;
                                    if ((_2870 > _2871) && (_2870 > _2873))
                                    {
                                        _2905 = int((_2868.x > 0.0f) ? (_2865 >> 24u) : ((_2865 >> 16u) & 255u));
                                    }
                                    else
                                    {
                                        int _2904;
                                        if (_2871 > _2873)
                                        {
                                            _2904 = int((_2868.y > 0.0f) ? ((_2865 >> 8u) & 255u) : (_2865 & 255u));
                                        }
                                        else
                                        {
                                            _2904 = int((_2868.z > 0.0f) ? ((_2867 >> 8u) & 255u) : (_2867 & 255u));
                                        }
                                        _2905 = _2904;
                                    }
                                    _2908 = (_2905 < 80) ? _2905 : (-1);
                                }
                                bool _2909 = _2908 >= 0;
                                float _3155;
                                if (_2909)
                                {
                                    float3 _2913 = _508 - _37_m6[_2493].xyz;
                                    float _2914 = dot(_2913, _2913);
                                    float4 _2933 = mul(_39_m10[_2908], float4((_508 - ((_2913 * rsqrt(isnan(_2914) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? _2914 : max(1.1754943508222875079687365372222e-38f, _2914)))) * _39_m11[_2908].x)) + (_529 * (_39_m11[_2908].y * 5.0f)), 1.0f));
                                    float _2934 = _2933.w;
                                    float3 _2937 = _2933.xyz / _2934.xxx;
                                    float2 _2938 = _2937.xy;
                                    float3 _2946 = _2937.xyz;
                                    bool3 _2947 = bool3(_2946.x <= 0.0f.xxx.x, _2946.y <= 0.0f.xxx.y, _2946.z <= 0.0f.xxx.z);
                                    bool3 _2948 = bool3(_2946.x >= 1.0f.xxx.x, _2946.y >= 1.0f.xxx.y, _2946.z >= 1.0f.xxx.z);
                                    float _2951 = _2937.z;
                                    float2 _2962 = ((_2938 * (_39_m12[_2908].zw - _39_m12[_2908].xy)) + _39_m12[_2908].xy).xy * _39_m13.zw;
                                    float2 _2964 = floor(_2962 + 0.5f.xx);
                                    float2 _2965 = _2962 - _2964;
                                    float _2966 = _2965.x;
                                    float _2967 = _2966 + 0.5f;
                                    float _2968 = _2967 * _2967;
                                    float _2971 = 1.0f - _2966;
                                    float _2972 = isnan(0.0f) ? _2966 : (isnan(_2966) ? 0.0f : min(_2966, 0.0f));
                                    float _2975 = _2966 + 1.0f;
                                    float _2976 = isnan(0.0f) ? _2966 : (isnan(_2966) ? 0.0f : max(_2966, 0.0f));
                                    float _2987 = _2965.y;
                                    float _2988 = _2987 + 0.5f;
                                    float _2989 = _2988 * _2988;
                                    float _2992 = 1.0f - _2987;
                                    float _2993 = isnan(0.0f) ? _2987 : (isnan(_2987) ? 0.0f : min(_2987, 0.0f));
                                    float _2996 = _2987 + 1.0f;
                                    float _2997 = isnan(0.0f) ? _2987 : (isnan(_2987) ? 0.0f : max(_2987, 0.0f));
                                    float3 _3009 = float3(0.1599999964237213134765625f * _2971, 0.1599999964237213134765625f * ((_2975 - (_2976 * _2976)) + 1.0f), _2968 * 0.07999999821186065673828125f);
                                    float3 _3010 = float3(0.1599999964237213134765625f * ((_2968 * 0.5f) - _2966), 0.1599999964237213134765625f * ((_2971 - (_2972 * _2972)) + 1.0f), 0.1599999964237213134765625f * _2975) + _3009;
                                    float3 _3012 = float3(0.1599999964237213134765625f * _2992, 0.1599999964237213134765625f * ((_2996 - (_2997 * _2997)) + 1.0f), _2989 * 0.07999999821186065673828125f);
                                    float3 _3013 = float3(0.1599999964237213134765625f * ((_2989 * 0.5f) - _2987), 0.1599999964237213134765625f * ((_2992 - (_2993 * _2993)) + 1.0f), 0.1599999964237213134765625f * _2996) + _3012;
                                    float3 _3019 = ((_3009 / _3010) + float3(-2.5f, -0.5f, 1.5f)) * _39_m13.xxx;
                                    float3 _3021 = ((_3012 / _3013) + float3(-2.5f, -0.5f, 1.5f)) * _39_m13.yyy;
                                    float2 _3023 = _2964 * _39_m13.xy;
                                    float _3024 = _3019.x;
                                    float _3025 = _3021.x;
                                    float _3028 = _3019.y;
                                    float _3031 = _3019.z;
                                    float _3034 = _3021.y;
                                    float _3041 = _3021.z;
                                    float _3048 = _3010.x;
                                    float _3049 = _3013.x;
                                    float _3051 = _3010.y;
                                    float _3053 = _3010.z;
                                    float _3055 = _3013.y;
                                    float _3059 = _3013.z;
                                    float2 _3137 = 1.0f.xx - _2938;
                                    bool2 _4031 = isnan(_2938);
                                    bool2 _4032 = isnan(_3137);
                                    float2 _4033 = min(_2938, _3137);
                                    float2 _4034 = float2(_4031.x ? _3137.x : _4033.x, _4031.y ? _3137.y : _4033.y);
                                    float2 _3138 = float2(_4032.x ? _2938.x : _4034.x, _4032.y ? _2938.y : _4034.y);
                                    float _3139 = _3138.x;
                                    float _3140 = _3138.y;
                                    float _3141 = isnan(_3140) ? _3139 : (isnan(_3139) ? _3140 : min(_3139, _3140));
                                    float _3145 = (_39_m11[_2908].z - _2934) * 0.25f;
                                    float _3147 = smoothstep(0.0f, 0.0500000007450580596923828125f, isnan(_3141) ? _3145 : (isnan(_3145) ? _3141 : min(_3145, _3141)));
                                    _3155 = _2909 ? lerp(1.0f, (any(bool3(_2947.x || _2948.x, _2947.y || _2948.y, _2947.z || _2948.z)) || ((asuint(_2951) & 2147483647u) > 2139095040u)) ? 1.0f : ((((((((((_3048 * _3049) * _40.SampleCmpLevelZero(eid4780_linear_clamp_compare_sampler28, float3(_3023 + float2(_3024, _3025), _387).xy, _2951)) + ((_3051 * _3049) * _40.SampleCmpLevelZero(eid4780_linear_clamp_compare_sampler28, float3(_3023 + float2(_3028, _3025), _387).xy, _2951))) + ((_3053 * _3049) * _40.SampleCmpLevelZero(eid4780_linear_clamp_compare_sampler28, float3(_3023 + float2(_3031, _3025), _387).xy, _2951))) + ((_3048 * _3055) * _40.SampleCmpLevelZero(eid4780_linear_clamp_compare_sampler28, float3(_3023 + float2(_3024, _3034), _387).xy, _2951))) + ((_3051 * _3055) * _40.SampleCmpLevelZero(eid4780_linear_clamp_compare_sampler28, float3(_3023 + float2(_3028, _3034), _387).xy, _2951))) + ((_3053 * _3055) * _40.SampleCmpLevelZero(eid4780_linear_clamp_compare_sampler28, float3(_3023 + float2(_3031, _3034), _387).xy, _2951))) + ((_3048 * _3059) * _40.SampleCmpLevelZero(eid4780_linear_clamp_compare_sampler28, float3(_3023 + float2(_3024, _3041), _387).xy, _2951))) + ((_3051 * _3059) * _40.SampleCmpLevelZero(eid4780_linear_clamp_compare_sampler28, float3(_3023 + float2(_3028, _3041), _387).xy, _2951))) + ((_3053 * _3059) * _40.SampleCmpLevelZero(eid4780_linear_clamp_compare_sampler28, float3(_3023 + float2(_3031, _3041), _387).xy, _2951))), _2859 ? (isnan(_3147) ? _39_m11[_2908].w : (isnan(_39_m11[_2908].w) ? _3147 : min(_39_m11[_2908].w, _3147))) : _39_m11[_2908].w) : 1.0f;
                                }
                                else
                                {
                                    _3155 = clamp(dot(_515, _2694) + 1.0f, 0.0f, 1.0f);
                                }
                                _3156 = _3155;
                            }
                            else
                            {
                                _3156 = 1.0f;
                            }
                            float _3236;
                            float3 _3237;
                            float _3238;
                            float3 _3239;
                            float3 _3240;
                            float _3241;
                            float _3242;
                            [branch]
                            if (_2603 == 0u)
                            {
                                float3 _3162 = _37_m6[_2490].xyz * _2832;
                                float _3163 = _3162.x;
                                float _3164 = _3162.y;
                                float _3165 = _3162.z;
                                float _3166 = isnan(_3164) ? _3163 : (isnan(_3163) ? _3164 : max(_3163, _3164));
                                float _3168 = (isnan(_3165) ? _3166 : (isnan(_3166) ? _3165 : max(_3166, _3165))) * lerp(0.75f, 0.5f, _2399);
                                float3 _3175 = _2239.xyz;
                                _3236 = _2832;
                                _3237 = (_37_m6[_2490].xyz * ((1.0f - _37_m6[_2502].y) + ((1.0f / (isnan(_3168) ? 1.0f : (isnan(1.0f) ? _3168 : max(1.0f, _3168)))) * _37_m6[_2502].y))) * lerp(0.5f * _37_m6[_2502].x, 1.0f, clamp(_2852 + 0.5f, 0.0f, 1.0f));
                                _3238 = _2853;
                                _3239 = _3175;
                                _3240 = _3175;
                                _3241 = 1.0f;
                                _3242 = 0.0f;
                            }
                            else
                            {
                                float _3230;
                                float _3231;
                                float3 _3232;
                                float3 _3233;
                                float _3234;
                                float _3235;
                                if (_2603 == 3u)
                                {
                                    _3230 = _2832 * (smoothstep(lerp(0.800000011920928955078125f, 0.20000000298023223876953125f, _37_m6[_2502].x), lerp(0.89999997615814208984375f, 0.5f, _37_m6[_2502].x), _2363) * _3156);
                                    _3231 = clamp(dot(_2052, -normalize(cross(_541, cross(_541, _2694)))), 0.0f, 1.0f);
                                    _3232 = lerp(0.5f.xxx, _2060, _37_m6[_2502].y.xxx);
                                    _3233 = 0.0f.xxx;
                                    _3234 = 1.0f;
                                    _3235 = 0.0f;
                                }
                                else
                                {
                                    bool _3200 = _2603 == 1u;
                                    float _3224;
                                    float3 _3225;
                                    float _3226;
                                    float _3227;
                                    if (_3200)
                                    {
                                        _3224 = clamp(clamp(_2852 + _37_m6[_2502].x, -1.0f, 1.0f), 0.0f, 1.0f) * _3156;
                                        _3225 = _2064 * _37_m6[_2502].y;
                                        _3226 = 1.0f;
                                        _3227 = 0.0f;
                                    }
                                    else
                                    {
                                        bool _3210 = _2603 == 2u;
                                        float _3222;
                                        if (_3210)
                                        {
                                            _3222 = smoothstep(_37_m6[_2502].x + 0.0500000007450580596923828125f, _37_m6[_2502].x - 0.0500000007450580596923828125f, _2054) * ((1.0f - _37_m6[_2502].z) + (step(0.5f, _2057) * _37_m6[_2502].z));
                                        }
                                        else
                                        {
                                            _3222 = 1.0f;
                                        }
                                        _3224 = _2853;
                                        _3225 = 0.0f.xxx;
                                        _3226 = _3222;
                                        _3227 = _3210 ? _37_m6[_2502].y : 0.0f;
                                    }
                                    bool3 _3228 = _3200.xxx;
                                    _3230 = _2832;
                                    _3231 = _3224;
                                    _3232 = float3(_3228.x ? _2060.x : 0.0f.xxx.x, _3228.y ? _2060.y : 0.0f.xxx.y, _3228.z ? _2060.z : 0.0f.xxx.z);
                                    _3233 = _3225;
                                    _3234 = _3226;
                                    _3235 = _3227;
                                }
                                _3236 = _3230;
                                _3237 = _37_m6[_2490].xyz;
                                _3238 = _3231;
                                _3239 = _3232;
                                _3240 = _3233;
                                _3241 = _3234;
                                _3242 = _3235;
                            }
                            float3 _3270;
                            [branch]
                            if (_2603 != 3u)
                            {
                                float _3247 = lerp(_2066, 0.00999999977648258209228515625f, _3242);
                                float _3250 = dot(_529, normalize(_2694 + _429));
                                float _3251 = _3247 * _3247;
                                float _3255 = (((_3250 * _3251) - _3250) * _3250) + 1.0f;
                                float _3256 = _3255 * _3255;
                                _3270 = ((_2063 * clamp((((_3251 != _3256) ? (_3251 / _3256) : 1.0f) * (0.5f / ((_2274 + (_3247 * _2276)) + 9.9999997473787516355514526367188e-05f))) - 6.103515625e-05f, 0.0f, 20.0f)) * _3241) * _37_m6[_2511].z;
                            }
                            else
                            {
                                _3270 = 0.0f.xxx;
                            }
                            float3 _3273 = _3237 * _3236;
                            _3280 = _2454 + (((_3273 * lerp(_3240, _3239, _3238.xxx)) * 1.0f) + ((_3273 * _3270) * _3238));
                        }
                        else
                        {
                            _3280 = _2454;
                        }
                        _3281 = _3280;
                        break;
                    } while(false);
                    _3282 = _3281;
                    break;
                } while(false);
                _3283 = _3282;
            }
            else
            {
                _3283 = _2454;
            }
            _2477 = _3283;
        }
    }
    float3 _3323;
    [branch]
    if (_50_m12 > 0.5f)
    {
        _3323 = lerp(lerp(0.5f.xxx, lerp(dot(_2453, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, _2453, _50_m14.xxx), _50_m15.xxx) * _50_m13, _50_m26.xyz, _50_m26.w.xxx) + ((_50_m27.xyz * smoothstep(1.0f - _50_m16, 1.0f, 1.0f - clamp(_2361, 0.0f, 1.0f))) * _50_m17);
    }
    else
    {
        _3323 = _2453;
    }
    float4 _3331 = float4(_3323 * _20_m20.y, 1.0f);
    _3331.w = 1.0f;
    float4 _3714;
    [branch]
    if (_20_m91.w < 0.5f)
    {
        float3 _3335 = -_429;
        float _3346 = (_430 * _20_m44.w) - _20_m43.w;
        float _3351 = _573 * _20_m46.w;
        float _3355 = _3351 + _20_m47.w;
        float _3356 = isnan(_3355) ? 0.00999999977648258209228515625f : (isnan(0.00999999977648258209228515625f) ? _3355 : max(0.00999999977648258209228515625f, _3355));
        float3 _3370 = exp(_20_m45.xyz * ((-(isnan(_3346) ? 0.0f : (isnan(0.0f) ? _3346 : max(0.0f, _3346)))) * (((1.0f - exp(-_3356)) / _3356) * exp(_3351 + _20_m48.w))));
        float _3373 = dot(_3335, _20_m44.xyz);
        float _3379 = _20_m45.w * _20_m45.w;
        float _3383 = (1.0f + _3379) - ((2.0f * _20_m45.w) * _3373);
        float _3387 = (12.56637096405029296875f * _3383) * sqrt(_3383);
        float3 _3706;
        float _3707;
        if (_20_m55.z > 0.0f)
        {
            uint3 _3428 = (uint3(int3(_2130, _2131, int(_20_m19 & 7u))) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _3429 = _3428.y;
            uint _3430 = _3428.z;
            uint _3433 = _3428.x + (_3429 * _3430);
            uint _3435 = _3429 + (_3430 * _3433);
            uint _3437 = _3430 + (_3433 * _3435);
            uint _3439 = _3433 + (_3435 * _3437);
            float _3464 = dot(_3335, -_18_m0[2].xyz);
            float3 _3471 = _508 - _18_m11.xyz;
            float _3473 = (_20_m55.w * ((_3464 > 5.9604644775390625e-08f) ? (1.0f / _3464) : 0.0f)) * (1.0f / _430);
            float _3474 = _3471.y;
            float _3475 = _3473 * _3474;
            float _3477 = _18_m11.y + _3475;
            float _3478 = _3474 - _3475;
            float _3480 = (1.0f - _3473) * _430;
            float _3486 = _20_m49.z * (_3477 - _20_m49.x);
            float _3493 = _20_m49.z * _3478;
            float _3494 = isnan(_3493) ? (-127.0f) : (isnan(-127.0f) ? _3493 : max(-127.0f, _3493));
            float _3510 = _20_m52.x * (_3477 - _20_m52.z);
            float _3517 = _20_m52.x * _3478;
            float _3518 = isnan(_3517) ? (-127.0f) : (isnan(-127.0f) ? _3517 : max(-127.0f, _3517));
            float _3529 = ((_20_m49.y * exp2(-(isnan(_3486) ? (-127.0f) : (isnan(-127.0f) ? _3486 : max(-127.0f, _3486))))) * ((abs(_3494) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-_3494)) / _3494) : (0.693147182464599609375f - (0.2402265071868896484375f * _3494)))) + ((_20_m52.y * exp2(-(isnan(_3510) ? (-127.0f) : (isnan(-127.0f) ? _3510 : max(-127.0f, _3510))))) * ((abs(_3518) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-_3518)) / _3518) : (0.693147182464599609375f - (0.2402265071868896484375f * _3518))));
            float _3533 = clamp(exp2(-(_3529 * _3480)), 0.0f, 1.0f);
            float _3551 = clamp((_430 * _20_m50.w) + _20_m50.z, 0.0f, 1.0f);
            float _3554 = clamp(((isnan(_20_m51.w) ? _3533 : (isnan(_3533) ? _20_m51.w : max(_3533, _20_m51.w))) + clamp((_430 * _20_m50.y) + _20_m50.x, 0.0f, 1.0f)) + _3551, 0.0f, 1.0f);
            float _3573 = _3480 - _20_m53.w;
            float4 _3594 = lerp(float4(0.0f, 0.0f, 0.0f, 1.0f), _61.SampleLevel(eid4780_linear_clamp_sampler26, float3((_2428 + ((((float3(uint3(_3439, _3435 + (_3437 * _3439), _394) >> uint3(16u, 16u, 16u)) * 1.525902189314365386962890625e-05f.xxx) * 2.0f) - 1.0f.xxx) * _20_m59.w).xy) * _20_m57.xy, (log2((_410 * _20_m56.x) + _20_m56.y) * _20_m56.z) / _20_m55.z), 0.0f), (capturedScreenValid ? clamp((_410 - _20_m58.z) * 1000000.0f, 0.0f, 1.0f) : 0.0f).xxxx);
            float _3596 = _3594.w;
            _3706 = _3594.xyz + (((_20_m51.xyz * (1.0f - _3554)) + (((_20_m54.xyz * pow(clamp(dot(_429, _20_m53.xyz), 0.0f, 1.0f), _20_m54.w)) * (1.0f - clamp(exp2(-(_3529 * (isnan(0.0f) ? _3573 : (isnan(_3573) ? 0.0f : max(_3573, 0.0f))))), 0.0f, 1.0f))) * (1.0f - _3551))) * _3596);
            _3707 = _3596 * _3554;
        }
        else
        {
            float3 _3600 = _508 - _18_m11.xyz;
            float _3602 = _3600.y;
            float _3608 = _20_m49.z * (_18_m11.y - _20_m49.x);
            float _3615 = _20_m49.z * _3602;
            float _3616 = isnan(_3615) ? (-127.0f) : (isnan(-127.0f) ? _3615 : max(-127.0f, _3615));
            float _3632 = _20_m52.x * (_18_m11.y - _20_m52.z);
            float _3639 = _20_m52.x * _3602;
            float _3640 = isnan(_3639) ? (-127.0f) : (isnan(-127.0f) ? _3639 : max(-127.0f, _3639));
            float _3651 = ((_20_m49.y * exp2(-(isnan(_3608) ? (-127.0f) : (isnan(-127.0f) ? _3608 : max(-127.0f, _3608))))) * ((abs(_3616) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-_3616)) / _3616) : (0.693147182464599609375f - (0.2402265071868896484375f * _3616)))) + ((_20_m52.y * exp2(-(isnan(_3632) ? (-127.0f) : (isnan(-127.0f) ? _3632 : max(-127.0f, _3632))))) * ((abs(_3640) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-_3640)) / _3640) : (0.693147182464599609375f - (0.2402265071868896484375f * _3640))));
            float _3655 = clamp(exp2(-(_3651 * _430)), 0.0f, 1.0f);
            float _3673 = clamp((_430 * _20_m50.w) + _20_m50.z, 0.0f, 1.0f);
            float _3676 = clamp(((isnan(_20_m51.w) ? _3655 : (isnan(_3655) ? _20_m51.w : max(_3655, _20_m51.w))) + clamp((_430 * _20_m50.y) + _20_m50.x, 0.0f, 1.0f)) + _3673, 0.0f, 1.0f);
            float _3695 = _430 - _20_m53.w;
            _3706 = (_20_m51.xyz * (1.0f - _3676)) + (((_20_m54.xyz * pow(clamp(dot(_429, _20_m53.xyz), 0.0f, 1.0f), _20_m54.w)) * (1.0f - clamp(exp2(-(_3651 * (isnan(0.0f) ? _3695 : (isnan(_3695) ? 0.0f : max(_3695, 0.0f))))), 0.0f, 1.0f))) * (1.0f - _3673));
            _3707 = _3676;
        }
        float3 _3712 = (_3331.xyz * (_3370 * _3707)) + ((((clamp(((_20_m46.xyz * (0.0596831031143665313720703125f * (1.0f + (_3373 * _3373)))) + _20_m48.xyz) + (_20_m47.xyz * ((1.0f - _3379) / (isnan(0.001000000047497451305389404296875f) ? _3387 : (isnan(_3387) ? 0.001000000047497451305389404296875f : max(_3387, 0.001000000047497451305389404296875f))))), 0.0f.xxx, 1.0f.xxx) * 255.0f) * (1.0f.xxx - _3370)) * _3707) + _3706);
        _3714 = float4(_3712.x, _3712.y, _3712.z, _3331.w);
    }
    else
    {
        _3714 = _3331;
    }
    _15 = _3714;
    _16 = _2097;
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    gl_FrontFacing = stage_input.gl_FrontFacing;
    _3 = stage_input._3;
    _4 = stage_input._4;
    _5 = stage_input._5;
    _6 = stage_input._6;
    _7 = stage_input._7;
    _8 = stage_input._8;
    _9 = stage_input._9;
    _10 = stage_input._10;
    _11 = stage_input._11;
    _13 = stage_input._13;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output._15 = _15;
    stage_output._16 = _16;
    return stage_output;
}
