struct _21
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

static const int2 _378[6] = { int2(2, 1), int2(2, 1), int2(0, 2), int2(0, 2), int2(0, 1), int2(0, 1) };
static const float2 _379[6] = { float2(-1.0f, 1.0f), 1.0f.xx, float2(1.0f, -1.0f), 1.0f.xx, 1.0f.xx, float2(-1.0f, 1.0f) };

cbuffer _16_17 : register(b12)
{
    column_major float4x4 _17_m0 : packoffset(c0);
    column_major float4x4 _17_m1 : packoffset(c4);
    column_major float4x4 _17_m2 : packoffset(c8);
    column_major float4x4 _17_m3 : packoffset(c12);
    column_major float4x4 _17_m4 : packoffset(c16);
    column_major float4x4 _17_m5 : packoffset(c20);
    column_major float4x4 _17_m6 : packoffset(c24);
    column_major float4x4 _17_m7 : packoffset(c28);
    column_major float4x4 _17_m8 : packoffset(c32);
    column_major float4x4 _17_m9 : packoffset(c36);
    column_major float4x4 _17_m10 : packoffset(c40);
    float4 _17_m11 : packoffset(c44);
    column_major float4x4 _17_m12 : packoffset(c45);
    column_major float4x4 _17_m13 : packoffset(c49);
    column_major float4x4 _17_m14 : packoffset(c53);
    column_major float4x4 _17_m15 : packoffset(c57);
    column_major float4x4 _17_m16 : packoffset(c61);
    column_major float4x4 _17_m17 : packoffset(c65);
    column_major float4x4 _17_m18 : packoffset(c69);
    column_major float4x4 _17_m19 : packoffset(c73);
    column_major float4x4 _17_m20 : packoffset(c77);
    float4 _17_m21 : packoffset(c81);
};

cbuffer _18_19 : register(b16)
{
    float4 _19_m0 : packoffset(c0);
    float4 _19_m1 : packoffset(c1);
    float4 _19_m2 : packoffset(c2);
    float4 _19_m3 : packoffset(c3);
    float4 _19_m4 : packoffset(c4);
    float4 _19_m5 : packoffset(c5);
    float4 _19_m6[6] : packoffset(c6);
    float4 _19_m7[6] : packoffset(c12);
    float4 _19_m8 : packoffset(c18);
    float4 _19_m9 : packoffset(c19);
    float4 _19_m10 : packoffset(c20);
    float4 _19_m11 : packoffset(c21);
    float4 _19_m12 : packoffset(c22);
    float4 _19_m13 : packoffset(c23);
    float4 _19_m14 : packoffset(c24);
    float4 _19_m15 : packoffset(c25);
    float _19_m16 : packoffset(c26);
    float _19_m17 : packoffset(c26.y);
    float _19_m18 : packoffset(c26.z);
    uint _19_m19 : packoffset(c26.w);
    float4 _19_m20 : packoffset(c27);
    int4 _19_m21 : packoffset(c28);
    float4 _19_m22 : packoffset(c29);
    float4 _19_m23 : packoffset(c30);
    float4 _19_m24 : packoffset(c31);
    float4 _19_m25 : packoffset(c32);
    float4 _19_m26 : packoffset(c33);
    float4 _19_m27 : packoffset(c34);
    float4 _19_m28 : packoffset(c35);
    float4 _19_m29 : packoffset(c36);
    float4 _19_m30 : packoffset(c37);
    float4 _19_m31 : packoffset(c38);
    float4 _19_m32[4] : packoffset(c39);
    float4 _19_m33[4] : packoffset(c43);
    float4 _19_m34[4] : packoffset(c47);
    float4 _19_m35[4] : packoffset(c51);
    float4 _19_m36 : packoffset(c55);
    float4 _19_m37 : packoffset(c56);
    float4 _19_m38[4] : packoffset(c57);
    float4 _19_m39[4] : packoffset(c61);
    float4 _19_m40[4] : packoffset(c65);
    float4 _19_m41 : packoffset(c69);
    float4 _19_m42 : packoffset(c70);
    float4 _19_m43 : packoffset(c71);
    float4 _19_m44 : packoffset(c72);
    float4 _19_m45 : packoffset(c73);
    float4 _19_m46 : packoffset(c74);
    float4 _19_m47 : packoffset(c75);
    float4 _19_m48 : packoffset(c76);
    float4 _19_m49 : packoffset(c77);
    float4 _19_m50 : packoffset(c78);
    float4 _19_m51 : packoffset(c79);
    float4 _19_m52 : packoffset(c80);
    float4 _19_m53 : packoffset(c81);
    float4 _19_m54 : packoffset(c82);
    float4 _19_m55 : packoffset(c83);
    float4 _19_m56 : packoffset(c84);
    float4 _19_m57 : packoffset(c85);
    float4 _19_m58 : packoffset(c86);
    float4 _19_m59 : packoffset(c87);
    float4 _19_m60 : packoffset(c88);
    float4 _19_m61 : packoffset(c89);
    float4 _19_m62 : packoffset(c90);
    float4 _19_m63 : packoffset(c91);
    float4 _19_m64 : packoffset(c92);
    float4 _19_m65 : packoffset(c93);
    float4 _19_m66 : packoffset(c94);
    float4 _19_m67 : packoffset(c95);
    float4 _19_m68 : packoffset(c96);
    float4 _19_m69 : packoffset(c97);
    float4 _19_m70 : packoffset(c98);
    float4 _19_m71 : packoffset(c99);
    float4 _19_m72 : packoffset(c100);
    float4 _19_m73 : packoffset(c101);
    float4 _19_m74 : packoffset(c102);
    float4 _19_m75 : packoffset(c103);
    float4 _19_m76 : packoffset(c104);
    float4 _19_m77 : packoffset(c105);
    float4 _19_m78 : packoffset(c106);
    float4 _19_m79 : packoffset(c107);
    float4 _19_m80 : packoffset(c108);
    float4 _19_m81 : packoffset(c109);
    float4 _19_m82 : packoffset(c110);
    float4 _19_m83 : packoffset(c111);
    float4 _19_m84 : packoffset(c112);
    float4 _19_m85 : packoffset(c113);
    float4 _19_m86 : packoffset(c114);
    float4 _19_m87 : packoffset(c115);
    float4 _19_m88 : packoffset(c116);
    float4 _19_m89 : packoffset(c117);
    float4 _19_m90 : packoffset(c118);
    float4 _19_m91 : packoffset(c119);
    float4 _19_m92 : packoffset(c120);
    float4 _19_m93 : packoffset(c121);
    float4 _19_m94 : packoffset(c122);
    float4 _19_m95 : packoffset(c123);
    float4 _19_m96 : packoffset(c124);
    float4 _19_m97 : packoffset(c125);
    float4 _19_m98 : packoffset(c126);
    float4 _19_m99[2] : packoffset(c127);
    float4 _19_m100[2] : packoffset(c129);
    float _19_m101 : packoffset(c131);
    float _19_m102 : packoffset(c131.y);
    float _19_m103 : packoffset(c131.z);
    float _19_m104 : packoffset(c131.w);
    float4 _19_m105 : packoffset(c132);
    float4 _19_m106 : packoffset(c133);
    float4 _19_m107 : packoffset(c134);
    float4 _19_m108 : packoffset(c135);
    float4 _19_m109 : packoffset(c136);
    float4 _19_m110 : packoffset(c137);
    float4 _19_m111 : packoffset(c138);
    float4 _19_m112 : packoffset(c139);
    float4 _19_m113 : packoffset(c140);
    float4 _19_m114 : packoffset(c141);
    float4 _19_m115 : packoffset(c142);
    float4 _19_m116 : packoffset(c143);
    float4 _19_m117 : packoffset(c144);
    float4 _19_m118 : packoffset(c145);
    float4 _19_m119 : packoffset(c146);
    float4 _19_m120 : packoffset(c147);
    float4 _19_m121 : packoffset(c148);
    float4 _19_m122 : packoffset(c149);
    float4 _19_m123 : packoffset(c150);
    float4 _19_m124 : packoffset(c151);
    float4 _19_m125 : packoffset(c152);
    float4 _19_m126 : packoffset(c153);
    float4 _19_m127 : packoffset(c154);
    float4 _19_m128 : packoffset(c155);
    float4 _19_m129 : packoffset(c156);
    float4 _19_m130 : packoffset(c157);
    float4 _19_m131 : packoffset(c158);
    float4 _19_m132 : packoffset(c159);
    float4 _19_m133 : packoffset(c160);
    float4 _19_m134 : packoffset(c161);
    column_major float4x4 _19_m135 : packoffset(c162);
    float4 _19_m136 : packoffset(c166);
    float4 _19_m137 : packoffset(c167);
    float4 _19_m138[32] : packoffset(c168);
};

cbuffer _20_22 : register(b0)
{
    _21 _22_m0[256] : packoffset(c0);
};

ByteAddressBuffer _30 : register(t51);
ByteAddressBuffer _32 : register(t18);
cbuffer _33_34 : register(b48)
{
    int _34_m0 : packoffset(c0);
    int _34_m1 : packoffset(c0.y);
    int _34_m2 : packoffset(c0.z);
    int _34_m3 : packoffset(c0.w);
    float _34_m4 : packoffset(c1);
    float _34_m5 : packoffset(c1.y);
    float _34_m6 : packoffset(c1.z);
    float _34_m7 : packoffset(c1.w);
    float _34_m8 : packoffset(c2);
    float _34_m9 : packoffset(c2.y);
    float _34_m10 : packoffset(c2.z);
    float _34_m11 : packoffset(c2.w);
};

cbuffer _35_36 : register(b14)
{
    float4 _36_m0 : packoffset(c0);
    float4 _36_m1 : packoffset(c1);
    float4 _36_m2 : packoffset(c2);
    float4 _36_m3 : packoffset(c3);
    float4 _36_m4 : packoffset(c4);
    uint4 _36_m5 : packoffset(c5);
    float4 _36_m6[2048] : packoffset(c6);
};

cbuffer _37_38 : register(b15)
{
    column_major float4x4 _38_m0[5] : packoffset(c0);
    float4 _38_m1[4] : packoffset(c20);
    float4 _38_m2[4] : packoffset(c24);
    float4 _38_m3[4] : packoffset(c28);
    float4 _38_m4 : packoffset(c32);
    float4 _38_m5 : packoffset(c33);
    float4 _38_m6 : packoffset(c34);
    float4 _38_m7 : packoffset(c35);
    float4 _38_m8 : packoffset(c36);
    float4 _38_m9[27] : packoffset(c37);
    column_major float4x4 _38_m10[56] : packoffset(c64);
    float4 _38_m11[56] : packoffset(c288);
    float4 _38_m12[56] : packoffset(c344);
    float4 _38_m13 : packoffset(c400);
    float4 _38_m14[47] : packoffset(c401);
    column_major float4x4 _38_m15[15] : packoffset(c448);
    float4 _38_m16[15] : packoffset(c508);
    float4 _38_m17[15] : packoffset(c523);
    float4 _38_m18[15] : packoffset(c538);
    float4 _38_m19 : packoffset(c553);
    float4 _38_m20 : packoffset(c554);
    float4 _38_m21[21] : packoffset(c555);
    column_major float4x4 _38_m22 : packoffset(c576);
    column_major float4x4 _38_m23 : packoffset(c580);
    float4 _38_m24 : packoffset(c584);
    float4 _38_m25 : packoffset(c585);
    float4 _38_m26 : packoffset(c586);
    float4 _38_m27[128] : packoffset(c587);
};

cbuffer _48_49 : register(b0)
{
    float _49_m0 : packoffset(c0);
    float _49_m1 : packoffset(c0.y);
    float _49_m2 : packoffset(c0.z);
    float _49_m3 : packoffset(c0.w);
    float _49_m4 : packoffset(c1);
    float _49_m5 : packoffset(c1.y);
    float _49_m6 : packoffset(c1.z);
    float _49_m7 : packoffset(c1.w);
    float _49_m8 : packoffset(c2);
    float _49_m9 : packoffset(c2.y);
    float _49_m10 : packoffset(c2.z);
    float _49_m11 : packoffset(c2.w);
    float _49_m12 : packoffset(c3);
    float _49_m13 : packoffset(c3.y);
    float _49_m14 : packoffset(c3.z);
    float _49_m15 : packoffset(c3.w);
    float _49_m16 : packoffset(c4);
    float _49_m17 : packoffset(c4.y);
    float _49_m18 : packoffset(c4.z);
    float _49_m19 : packoffset(c4.w);
    float _49_m20 : packoffset(c5);
    float _49_m21 : packoffset(c5.y);
    float _49_m22 : packoffset(c5.z);
    float _49_m23 : packoffset(c5.w);
    float4 _49_m24 : packoffset(c6);
    float4 _49_m25 : packoffset(c7);
    float4 _49_m26 : packoffset(c8);
    float4 _49_m27 : packoffset(c9);
    float4 _49_m28 : packoffset(c10);
    float4 _49_m29 : packoffset(c11);
    float _49_m30 : packoffset(c12);
    float _49_m31 : packoffset(c12.y);
    float _49_m32 : packoffset(c12.z);
    float _49_m33 : packoffset(c12.w);
    float4 _49_m34 : packoffset(c13);
    float4 _49_m35 : packoffset(c14);
    float4 _49_m36 : packoffset(c15);
    float4 _49_m37 : packoffset(c16);
    float4 _49_m38 : packoffset(c17);
    float4 _49_m39 : packoffset(c18);
    float _49_m40 : packoffset(c19);
    float _49_m41 : packoffset(c19.y);
    float _49_m42 : packoffset(c19.z);
    float _49_m43 : packoffset(c19.w);
    float _49_m44 : packoffset(c20);
    float _49_m45 : packoffset(c20.y);
    float _49_m46 : packoffset(c20.z);
    float _49_m47 : packoffset(c20.w);
};

cbuffer _64_65 : register(b50)
{
    float4 _65_m0[32] : packoffset(c0);
    column_major float4x4 _65_m1[32] : packoffset(c32);
};

SamplerState _24 : register(s2);
SamplerState _25 : register(s6);
SamplerState _26 : register(s4);
SamplerComparisonState _27 : register(s7);
Texture2D<float4> _39 : register(t27);
Texture2D<float4> _40 : register(t22);
Texture3D<float4> _42 : register(t35);
Texture3D<float4> _43 : register(t32);
Texture3D<float4> _44 : register(t34);
Texture3D<float4> _45 : register(t31);
Texture3D<float4> _46 : register(t33);
Texture3D<float4> _47 : register(t30);
Texture2D<float4> _50 : register(t5);
Texture2D<float4> _51 : register(t1);
Texture2D<float4> _52 : register(t2);
Texture2D<float4> _53 : register(t44);
Texture2D<float4> _54 : register(t41);
Texture2D<float4> _55 : register(t39);
Texture2D<float4> _56 : register(t37);
Texture2D<float4> _57 : register(t7);
Texture2D<float4> _58 : register(t3);
Texture2D<float4> _59 : register(t6);
Texture2D<float4> _60 : register(t4);
TextureCube<float4> _62 : register(t45);
Texture2D<float4> _63 : register(t29);
Texture3D<float4> _68 : register(t36);

static float4 gl_FragCoord;
static bool gl_FrontFacing;
static float2 _3;
static float3 _4;
static float3 _5;
static float4 _6;
static float3 _7;
static float3 _8;
static float3 _9;
static float3 _10;
static uint _12;
static float4 _14;
static float4 _15;

struct SPIRV_Cross_Input
{
    float2 _3 : TEXCOORD0;
    float3 _4 : TEXCOORD1;
    float3 _5 : TEXCOORD2;
    float4 _6 : TEXCOORD3;
    float3 _7 : TEXCOORD4;
    float3 _8 : TEXCOORD5;
    float3 _9 : TEXCOORD6;
    float3 _10 : TEXCOORD7;
    nointerpolation uint _12 : TEXCOORD8;
    float4 gl_FragCoord : SV_Position;
    bool gl_FrontFacing : SV_IsFrontFace;
};

struct SPIRV_Cross_Output
{
    float4 _14 : SV_Target0;
    float4 _15 : SV_Target1;
};

static float _424;
static float3 _425;
static float _428;
static uint _429;

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
    float _444 = 1.0f / gl_FragCoord.w;
    float3 _459 = lerp(-_4, float3(_17_m0[2u].x, _17_m0[2u].y, _17_m0[2u].z), _19_m4.w.xxx);
    float _460 = dot(_459, _459);
    float _462 = rsqrt(isnan(9.9999999392252902907785028219223e-09f) ? _460 : (isnan(_460) ? 9.9999999392252902907785028219223e-09f : max(_460, 9.9999999392252902907785028219223e-09f)));
    float3 _463 = _459 * _462;
    float _464 = _460 * _462;
    uint _467 = asuint(_22_m0[_12]._m2.x);
    bool _472 = (asuint(_22_m0[_12]._m1.w) & 16u) != 0u;
    float4 _485;
    float4 _486;
    if (_472)
    {
        _485 = asfloat(_32.Load4((_467 + 2u) * 16 + 0));
        _486 = asfloat(_32.Load4(_467 * 16 + 0));
    }
    else
    {
        _485 = _22_m0[_12]._m0[2];
        _486 = _22_m0[_12]._m0[0];
    }
    float4 _492 = _57.SampleBias(_26, _3, _19_m16);
    float3 _497 = _492.xyz * _49_m24.xyz;
    float4 _501 = _58.SampleBias(_26, _3, _19_m16);
    float _502 = _501.x;
    float _504 = _501.z;
    float _506 = 1.0f - _501.w;
    float _510 = _492.w * _49_m24.w;
    float3 _511 = _497 * 12.9200000762939453125f;
    float3 _515 = (pow(abs(_497), 0.4166666567325592041015625f.xxx) * 1.05499994754791259765625f) - 0.054999999701976776123046875f.xxx;
    bool3 _516 = bool3(_497.x <= 0.003130800090730190277099609375f.xxx.x, _497.y <= 0.003130800090730190277099609375f.xxx.y, _497.z <= 0.003130800090730190277099609375f.xxx.z);
    float3 _518 = clamp(float3(_516.x ? _511.x : _515.x, _516.y ? _511.y : _515.y, _516.z ? _511.z : _515.z), 0.0f.xxx, 1.0f.xxx);
    float _522 = _518.z * 31.0f;
    float _523 = floor(_522);
    float2 _527 = ((_518.xy * 31.0f) * float2(0.0009765625f, 0.03125f)) + float2(0.00048828125f, 0.015625f);
    float3 _532 = float3(_527.x, _527.y, _518.z);
    _532.x = _527.x + (_523 * 0.03125f);
    float3 _543 = lerp(_52.SampleLevel(_25, _532.xy, 0.0f).xyz, _52.SampleLevel(_25, _532.xy + float2(0.03125f, 0.0f), 0.0f).xyz, (_522 - _523).xxx);
    float4 _547 = _59.SampleBias(_26, _3, _19_m16);
    float4 _553 = _547;
    _553.w = _547.w * _547.x;
    float2 _556 = (_553.wy * 2.0f) - 1.0f.xx;
    float2 _558 = _556.xy;
    float _562 = sqrt(1.0f - clamp(dot(_558, _558), 0.0f, 1.0f));
    float3 _564 = float3(_556.x, _556.y, _425.z);
    _564.z = isnan(_562) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? _562 : max(1.000000016862383526387164645044e-16f, _562));
    float2 _566 = _564.xy * _49_m3;
    float4 _571 = _60.SampleBias(_26, _3, _19_m16);
    float3 _583 = _4 + _17_m11.xyz;
    float3 _588 = _583 - float3(_486.w, _428, _485.w);
    _588.y = 6.103515625e-05f;
    float3 _590 = normalize(_588);
    float3 _600 = mul(float3(_566.x, _566.y, _564.z), float3x3(_6.xyz * 1.0f, (cross(_5, _6.xyz) * _6.w) * 1.0f, _5 * 1.0f));
    float _601 = dot(_600, _600);
    float _609 = gl_FrontFacing ? 1.0f : ((-1.0f) + (2.0f * _49_m5));
    float3 _610 = (_600 * rsqrt(isnan(_601) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? _601 : max(1.1754943508222875079687365372222e-38f, _601)))) * _609;
    float3 _611 = normalize(_5) * _609;
    uint2 _613 = uint2(gl_FragCoord.xy);
    float3 _623 = mul(float3x3(_17_m1[0].xyz, _17_m1[1].xyz, _17_m1[2].xyz), float3(0.0f, 0.0f, 1.0f));
    uint _632 = asuint((_19_m89.x > 0.5f) ? _19_m89.y : _22_m0[_12]._m7.x);
    float4 _645 = float4(float(_632 & 255u), float((_632 >> 8u) & 255u), float((_632 >> 16u) & 255u), float((_632 >> 24u) & 255u)) * 0.0039215688593685626983642578125f.xxxx;
    float _646 = _645.x;
    float _648 = _645.z;
    float _649 = _645.w;
    float _655 = _583.y;
    float _658 = smoothstep(-0.20000000298023223876953125f, 0.1500000059604644775390625f, lerp(_22_m0[_12]._m7.y, _19_m89.w, _19_m89.x) - _655) * _645.y;
    float _659 = isnan(_658) ? _648 : (isnan(_648) ? _658 : max(_648, _658));
    float _668 = lerp(_19_m22.x, 1.0f, _19_m91.w) * _19_m20.x;
    float4 _1162;
    float3 _1163;
    float3 _1164;
    float _1165;
    if (_19_m80.y < 0.5f)
    {
        float3 _683 = _583 - (_19_m105.xyz + (_623 * (-_19_m107.w)));
        float _685 = abs(_683.x);
        float _687 = abs(_683.z);
        float _693 = clamp(((isnan(_687) ? _685 : (isnan(_685) ? _687 : max(_685, _687))) - 464.0f) * 0.03125f, 0.0f, 1.0f);
        float _696 = clamp((abs(_683.y) - 208.0f) * 0.03125f, 0.0f, 1.0f);
        float _697 = isnan(_696) ? _693 : (isnan(_693) ? _696 : max(_693, _696));
        float4 _999;
        float4 _1000;
        float4 _1001;
        float _1002;
        float _1003;
        if ((_19_m105.w != 0.0f) && (_697 < 1.0f))
        {
            float3 _710 = _583 - (_19_m105.xyz + (_623 * (-_19_m107.y)));
            float _712 = abs(_710.x);
            float _714 = abs(_710.z);
            float _720 = clamp(((isnan(_714) ? _712 : (isnan(_712) ? _714 : max(_712, _714))) - 29.0f) * 0.5f, 0.0f, 1.0f);
            float _723 = clamp((abs(_710.y) - 13.0f) * 0.5f, 0.0f, 1.0f);
            float _724 = isnan(_723) ? _720 : (isnan(_720) ? _723 : max(_720, _723));
            float _800;
            float4 _801;
            float4 _802;
            float4 _803;
            if (_724 < 1.0f)
            {
                float3 _733 = ((_583 * 2.0f) + 0.5f.xxx) * _19_m106.xyz;
                float3 _735 = _733 - floor(_733);
                float4 _739 = _42.SampleLevel(_26, _735, 0.0f);
                float _740 = 1.0f - _724;
                float _744 = _19_m106.y * 0.5f;
                float _749 = _735.x;
                float _750 = clamp(_735.y, _744, 1.0f - _744) * 0.3333333432674407958984375f;
                float _751 = _735.z;
                float4 _754 = _43.SampleLevel(_25, float3(_749, _750, _751), 0.0f);
                float _770 = _739.x;
                float _780 = _739.y;
                float _790 = _739.z;
                _800 = _697 + (_754.w * _740);
                _801 = float4(((_43.SampleLevel(_25, float3(_749, _750 + 0.666666686534881591796875f, _751), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _790, _790) * _740;
                _802 = float4(((_43.SampleLevel(_25, float3(_749, _750 + 0.3333333432674407958984375f, _751), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _780, _780) * _740;
                _803 = float4(((_754.xyz * 4.0f) - 2.0f.xxx) * _770, _770) * _740;
            }
            else
            {
                _800 = _697;
                _801 = 0.0f.xxxx;
                _802 = 0.0f.xxxx;
                _803 = 0.0f.xxxx;
            }
            float3 _809 = _583 - (_19_m105.xyz + (_623 * (-_19_m107.z)));
            float _811 = abs(_809.x);
            float _813 = abs(_809.z);
            float _819 = clamp(((isnan(_813) ? _811 : (isnan(_811) ? _813 : max(_811, _813))) - 116.0f) * 0.125f, 0.0f, 1.0f);
            float _822 = clamp((abs(_809.y) - 52.0f) * 0.125f, 0.0f, 1.0f);
            float _823 = isnan(_822) ? _819 : (isnan(_819) ? _822 : max(_819, _822));
            float _903;
            float4 _904;
            float4 _905;
            float4 _906;
            if (_823 < 1.0f)
            {
                float3 _832 = ((_583 * 0.5f) + 0.5f.xxx) * _19_m106.xyz;
                float3 _834 = _832 - floor(_832);
                float4 _838 = _44.SampleLevel(_26, _834, 0.0f);
                float _840 = _724 * (1.0f - _823);
                float _844 = _19_m106.y * 0.5f;
                float _849 = _834.x;
                float _850 = clamp(_834.y, _844, 1.0f - _844) * 0.3333333432674407958984375f;
                float _851 = _834.z;
                float4 _854 = _45.SampleLevel(_25, float3(_849, _850, _851), 0.0f);
                float _870 = _838.x;
                float _881 = _838.y;
                float _892 = _838.z;
                _903 = _800 + (_854.w * _840);
                _904 = _801 + (float4(((_45.SampleLevel(_25, float3(_849, _850 + 0.666666686534881591796875f, _851), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _892, _892) * _840);
                _905 = _802 + (float4(((_45.SampleLevel(_25, float3(_849, _850 + 0.3333333432674407958984375f, _851), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _881, _881) * _840);
                _906 = _803 + (float4(((_854.xyz * 4.0f) - 2.0f.xxx) * _870, _870) * _840);
            }
            else
            {
                _903 = _800;
                _904 = _801;
                _905 = _802;
                _906 = _803;
            }
            float4 _989;
            float4 _990;
            float4 _991;
            float _992;
            if (_823 > 0.0f)
            {
                float3 _915 = ((_583 * 0.125f) + 0.5f.xxx) * _19_m106.xyz;
                float3 _918 = _19_m106.xyz * 0.5f;
                float3 _920 = clamp(_915 - floor(_915), _918, 1.0f.xxx - _918);
                float4 _924 = _46.SampleLevel(_26, _920, 0.0f);
                float _926 = _823 * (1.0f - _697);
                float _930 = _19_m106.y * 0.5f;
                float _935 = _920.x;
                float _936 = clamp(_920.y, _930, 1.0f - _930) * 0.3333333432674407958984375f;
                float _937 = _920.z;
                float4 _940 = _47.SampleLevel(_25, float3(_935, _936, _937), 0.0f);
                float _956 = _924.x;
                float _967 = _924.y;
                float _978 = _924.z;
                _989 = _904 + (float4(((_47.SampleLevel(_25, float3(_935, _936 + 0.666666686534881591796875f, _937), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _978, _978) * _926);
                _990 = _905 + (float4(((_47.SampleLevel(_25, float3(_935, _936 + 0.3333333432674407958984375f, _937), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _967, _967) * _926);
                _991 = _906 + (float4(((_940.xyz * 4.0f) - 2.0f.xxx) * _956, _956) * _926);
                _992 = _903 + (_940.w * _926);
            }
            else
            {
                _989 = _904;
                _990 = _905;
                _991 = _906;
                _992 = _903;
            }
            float _995 = clamp((_992 * 2.0f) - 1.0f, 0.0f, 1.0f);
            _999 = _989;
            _1000 = _990;
            _1001 = _991;
            _1002 = _995 - _697;
            _1003 = (_995 + _697) * 0.5f;
        }
        else
        {
            _999 = 0.0f.xxxx;
            _1000 = 0.0f.xxxx;
            _1001 = 0.0f.xxxx;
            _1002 = 0.0f;
            _1003 = 1.0f;
        }
        float4 _1023 = _1001 + float4(_19_m108.x * _1003, (_19_m108.y * _1003) + ((_19_m108.w * _1002) * 0.5f), _19_m108.z * _1003, (_19_m108.w * _1003) + ((_19_m108.y * _1002) * 0.375f));
        float4 _1043 = _1000 + float4(_19_m109.x * _1003, (_19_m109.y * _1003) + ((_19_m109.w * _1002) * 0.5f), _19_m109.z * _1003, (_19_m109.w * _1003) + ((_19_m109.y * _1002) * 0.375f));
        float4 _1063 = _999 + float4(_19_m110.x * _1003, (_19_m110.y * _1003) + ((_19_m110.w * _1002) * 0.5f), _19_m110.z * _1003, (_19_m110.w * _1003) + ((_19_m110.y * _1002) * 0.375f));
        float4 _1067 = float4(_610, 1.0f);
        float3 _1071 = float3(dot(_1023, _1067), dot(_1043, _1067), dot(_1063, _1067));
        bool3 _3859 = isnan(_1071);
        bool3 _3860 = isnan(0.0f.xxx);
        float3 _3861 = max(_1071, 0.0f.xxx);
        float3 _3862 = float3(_3859.x ? 0.0f.xxx.x : _3861.x, _3859.y ? 0.0f.xxx.y : _3861.y, _3859.z ? 0.0f.xxx.z : _3861.z);
        float3 _1073 = float3(_3860.x ? _1071.x : _3862.x, _3860.y ? _1071.y : _3862.y, _3860.z ? _1071.z : _3862.z) * _668;
        float3 _1081 = ((_1023.xyz * 0.2125999927520751953125f) + (_1043.xyz * 0.715200006961822509765625f)) + (_1063.xyz * 0.072200000286102294921875f);
        float _1082 = dot(_1081, _1081);
        float3 _1085 = _1081 * rsqrt(isnan(_1082) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? _1082 : max(1.1754943508222875079687365372222e-38f, _1082)));
        float _1087 = abs(_1085.y);
        float3 _1088 = _1085;
        _1088.y = _1087;
        float4 _1090 = float4(_1088.x, _1088.y, _1088.z, 0.0f.xxxx.w);
        _1090.w = 1.0f;
        float4 _1093 = float4(_1085.x, _1087, _1085.z, 1.0f);
        float3 _1097 = float3(dot(_1023, _1093), dot(_1043, _1093), dot(_1063, _1093));
        bool3 _3869 = isnan(_1097);
        bool3 _3870 = isnan(0.0f.xxx);
        float3 _3871 = max(_1097, 0.0f.xxx);
        float3 _3872 = float3(_3869.x ? 0.0f.xxx.x : _3871.x, _3869.y ? 0.0f.xxx.y : _3871.y, _3869.z ? 0.0f.xxx.z : _3871.z);
        float3 _1098 = float3(_3870.x ? _1097.x : _3872.x, _3870.y ? _1097.y : _3872.y, _3870.z ? _1097.z : _3872.z);
        float _1099 = _1098.x;
        float _1100 = _1098.y;
        float _1101 = _1098.z;
        float _1102 = isnan(_1100) ? _1099 : (isnan(_1099) ? _1100 : max(_1099, _1100));
        float _1103 = isnan(_1101) ? _1102 : (isnan(_1102) ? _1101 : max(_1102, _1101));
        float _1106 = _1073.z;
        float _1107 = _1073.y;
        float4 _1112 = lerp(float4(_1106, _1107, -1.0f, 0.666666686534881591796875f), float4(_1107, _1106, 0.0f, -0.3333333432674407958984375f), step(_1106, _1107).xxxx);
        float _1113 = _1073.x;
        float _1114 = _1112.x;
        float4 _1122 = lerp(float4(_1114, _1112.yw, _1113), float4(_1113, _1112.yz, _1114), step(_1114, _1113).xxxx);
        float _1123 = _1122.x;
        float _1124 = _1122.w;
        float _1125 = _1122.y;
        float _1127 = _1123 - (isnan(_1125) ? _1124 : (isnan(_1124) ? _1125 : min(_1124, _1125)));
        float _1136 = _1127 / (_1123 + 9.9999997473787516355514526367188e-05f);
        float _1137 = frac(abs(_1122.z + ((_1124 - _1125) / ((6.0f * _1127) + 9.9999997473787516355514526367188e-05f))));
        float _1143 = lerp(0.699999988079071044921875f, 0.3499999940395355224609375f, smoothstep(0.449999988079071044921875f, 0.3499999940395355224609375f, abs(_1137 - 0.5f))) * clamp(_1123, 0.0f, 1.0f);
        float _1144 = isnan(_1143) ? _1136 : (isnan(_1136) ? _1143 : min(_1136, _1143));
        float _1146 = 2.0f / (2.0f - _1144);
        _1162 = _1090;
        _1163 = _1073;
        _1164 = lerp(1.0f.xxx, clamp(abs((frac(float3(_1137, _1144, _1146).xxx + float3(1.0f, 0.666666686534881591796875f, 0.3333333432674407958984375f)) * 6.0f) - 3.0f.xxx) - 1.0f.xxx, 0.0f.xxx, 1.0f.xxx), _1144.xxx) * _1146;
        _1165 = (isnan(0.0f) ? _1103 : (isnan(_1103) ? 0.0f : max(_1103, 0.0f))) * _668;
    }
    else
    {
        _1162 = 0.0f.xxxx;
        _1163 = 1.0f.xxx;
        _1164 = _19_m81.xyz;
        _1165 = _668;
    }
    float3 _1885;
    float _1886;
    float _1887;
    float _1888;
    float _1889;
    float3 _1890;
    float3 _1891;
    [branch]
    if ((clamp(_646 + _659, 0.0f, 1.0f) - _49_m20) > 0.00999999977648258209228515625f)
    {
        float _1193 = 1.0f - _502;
        float _1196 = smoothstep(0.3499999940395355224609375f, 0.100000001490116119384765625f, dot(_497 * _1193, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)));
        bool3 _1199 = _472.xxx;
        float3 _1201 = _10.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 _1205 = float3(_1199.x ? _1201.x : _10.x, _1199.y ? _1201.y : _10.y, _1199.z ? _1201.z : _10.z) * _19_m89.z;
        float3 _1207 = float3(_1199.x ? _9.xzy.x : _9.x, _1199.y ? _9.xzy.y : _9.y, _1199.z ? _9.xzy.z : _9.z);
        float3 _1209 = abs(_1207) - 0.20000000298023223876953125f.xxx;
        float3 _1211 = (_1209 * _1209) * _1209;
        bool3 _3899 = isnan(_1211);
        bool3 _3900 = isnan(6.103515625e-05f.xxx);
        float3 _3901 = max(_1211, 6.103515625e-05f.xxx);
        float3 _3902 = float3(_3899.x ? 6.103515625e-05f.xxx.x : _3901.x, _3899.y ? 6.103515625e-05f.xxx.y : _3901.y, _3899.z ? 6.103515625e-05f.xxx.z : _3901.z);
        float3 _1212 = float3(_3900.x ? _1211.x : _3902.x, _3900.y ? _1211.y : _3902.y, _3900.z ? _1211.z : _3902.z);
        float3 _1215 = _1212 / dot(_1212, 1.0f.xxx).xxx;
        float2 _1223 = _1205.xy;
        float2 _1228 = _1205.zy;
        float4 _1238 = ((_53.SampleBias(_26, _1205.xz, _19_m16) * _1215.y) + (_53.SampleBias(_26, _1223, _19_m16) * _1215.z)) + (_53.SampleBias(_26, _1228, _19_m16) * _1215.x);
        float _1239 = _1238.w;
        float _1241 = 1.10000002384185791015625f - _1239;
        float _1245 = smoothstep(0.800000011920928955078125f - _1239, _1241, clamp((_646 * _1193) + (_610.y * 0.20000000298023223876953125f), 0.0f, 1.0f));
        float _1249 = smoothstep(0.449999988079071044921875f - _1239, _1241, clamp(_658 * _1193, 0.0f, 1.0f));
        float _1250 = isnan(_1249) ? _1245 : (isnan(_1245) ? _1249 : max(_1245, _1249));
        float _1257 = smoothstep(0.5f, 0.75f, _502);
        float _1259 = smoothstep(0.800000011920928955078125f, 0.60000002384185791015625f, _506) * _1196;
        float _1262 = clamp(_1259 + _1257, 0.0f, 1.0f) * (isnan(_659) ? _646 : (isnan(_646) ? _659 : max(_646, _659)));
        float _1265 = step(1.0099999904632568359375f - _1262, _1238.z);
        bool _1266 = !((step(_646, 0.00999999977648258209228515625f) * step(0.00999999977648258209228515625f, _659)) != 0.0f);
        bool2 _1267 = _1266.xx;
        float2 _1269 = (1.0f - _659).xx;
        float2 _1270 = float2(_1267.x ? float2(3.0f, 4.345600128173828125f).x : _1269.x, _1267.y ? float2(3.0f, 4.345600128173828125f).y : _1269.y);
        float _1271 = 1.0f - _1262;
        float _1274 = _1266 ? _19_m10.x : 1.0f;
        float _1276 = _1274 * _1270.x;
        float _1278 = _1274 * _1270.y;
        float3 _1279 = _1205 * 20.0f;
        float3 _1280 = _1205 * 34.345600128173828125f;
        bool3 _3909 = isnan(_1209);
        bool3 _3910 = isnan(0.0f.xxx);
        float3 _3911 = max(_1209, 0.0f.xxx);
        float3 _3912 = float3(_3909.x ? 0.0f.xxx.x : _3911.x, _3909.y ? 0.0f.xxx.y : _3911.y, _3909.z ? 0.0f.xxx.z : _3911.z);
        float3 _1282 = pow(float3(_3910.x ? _1209.x : _3912.x, _3910.y ? _1209.y : _3912.y, _3910.z ? _1209.z : _3912.z), 10.0f.xxx);
        float _1283 = dot(_1282, 1.0f.xxx);
        float3 _1286 = _1282 / (isnan(6.103515625e-05f) ? _1283 : (isnan(_1283) ? 6.103515625e-05f : max(_1283, 6.103515625e-05f))).xxx;
        float _1288 = _1286.y;
        float2 _1289 = _1279.xz * 1.0f;
        float2 _1290 = floor(_1289);
        float2 _1293 = frac(_1290 * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1297 = _1293 + dot(_1293, _1293 + 34.345001220703125f.xx).xx;
        float _1298 = _1297.x;
        float _1299 = _1297.y;
        float2 _1303 = frac(float2(_1298 * _1299, _1298 + _1299));
        float2 _1306 = frac((_1290 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1310 = _1306 + dot(_1306, _1306 + 34.345001220703125f.xx).xx;
        float _1311 = _1310.x;
        float _1312 = _1310.y;
        float2 _1316 = frac(float2(_1311 * _1312, _1311 + _1312));
        float _1322 = _1303.x;
        float _1324 = 0.25f * lerp(0.60000002384185791015625f, 1.0f, _1322);
        float2 _1325 = ((_1289 - _1290) + ((((_1316 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float _1328 = _1325.y;
        float2 _1332 = float2(_1325.x * 1.25f, _1328 * ((_1328 < 0.0f) ? 1.25f : 0.75f));
        float _1335 = _1276 + _1322;
        float _1339 = _1266 ? frac(_1335) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(_1335, 0.0f, 1.0f));
        float _1351 = _1303.y;
        float _1354 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, _1339) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, _1339)) * step(0.001000000047497451305389404296875f, smoothstep(_1324, 0.0f, length(_1332)))) * step(_1271, _1351 - 0.100000001490116119384765625f);
        float _1357 = _1354 * _1288;
        float2 _1363 = float2(_1324 * _1354, _428) * _1288;
        float _1365 = _1286.z;
        float2 _1366 = _1279.xy * 1.0f;
        float2 _1367 = floor(_1366);
        float2 _1370 = frac(_1367 * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1374 = _1370 + dot(_1370, _1370 + 34.345001220703125f.xx).xx;
        float _1375 = _1374.x;
        float _1376 = _1374.y;
        float2 _1380 = frac(float2(_1375 * _1376, _1375 + _1376));
        float2 _1383 = frac((_1367 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1387 = _1383 + dot(_1383, _1383 + 34.345001220703125f.xx).xx;
        float _1388 = _1387.x;
        float _1389 = _1387.y;
        float2 _1393 = frac(float2(_1388 * _1389, _1388 + _1389));
        float _1399 = _1380.x;
        float _1401 = 0.25f * lerp(0.60000002384185791015625f, 1.0f, _1399);
        float2 _1402 = ((_1366 - _1367) + ((((_1393 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float _1405 = _1402.y;
        float2 _1409 = float2(_1402.x * 1.25f, _1405 * ((_1405 < 0.0f) ? 1.25f : 0.75f));
        float _1412 = _1276 + _1399;
        float _1416 = _1266 ? frac(_1412) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(_1412, 0.0f, 1.0f));
        float _1428 = _1380.y;
        float _1431 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, _1416) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, _1416)) * step(0.001000000047497451305389404296875f, smoothstep(_1401, 0.0f, length(_1409)))) * step(_1271, _1428 - 0.100000001490116119384765625f);
        float _1434 = _1431 * _1365;
        float2 _1440 = float2(_1401 * _1431, _428) * _1365;
        float _1442 = _1286.x;
        float2 _1443 = _1279.zy * 1.0f;
        float2 _1444 = floor(_1443);
        float2 _1447 = frac(_1444 * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1451 = _1447 + dot(_1447, _1447 + 34.345001220703125f.xx).xx;
        float _1452 = _1451.x;
        float _1453 = _1451.y;
        float2 _1457 = frac(float2(_1452 * _1453, _1452 + _1453));
        float2 _1460 = frac((_1444 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1464 = _1460 + dot(_1460, _1460 + 34.345001220703125f.xx).xx;
        float _1465 = _1464.x;
        float _1466 = _1464.y;
        float2 _1470 = frac(float2(_1465 * _1466, _1465 + _1466));
        float _1476 = _1457.x;
        float _1478 = 0.25f * lerp(0.60000002384185791015625f, 1.0f, _1476);
        float2 _1479 = ((_1443 - _1444) + ((((_1470 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float _1482 = _1479.y;
        float2 _1486 = float2(_1479.x * 1.25f, _1482 * ((_1482 < 0.0f) ? 1.25f : 0.75f));
        float _1489 = _1276 + _1476;
        float _1493 = _1266 ? frac(_1489) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(_1489, 0.0f, 1.0f));
        float _1505 = _1457.y;
        float _1508 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, _1493) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, _1493)) * step(0.001000000047497451305389404296875f, smoothstep(_1478, 0.0f, length(_1486)))) * step(_1271, _1505 - 0.100000001490116119384765625f);
        float _1511 = _1508 * _1442;
        float2 _1517 = float2(_1478 * _1508, _428) * _1442;
        bool2 _3919 = isnan(_1440);
        bool2 _3920 = isnan(_1517);
        float2 _3921 = max(_1440, _1517);
        float2 _3922 = float2(_3919.x ? _1517.x : _3921.x, _3919.y ? _1517.y : _3921.y);
        float2 _1518 = float2(_3920.x ? _1440.x : _3922.x, _3920.y ? _1440.y : _3922.y);
        bool2 _3924 = isnan(_1363);
        bool2 _3925 = isnan(_1518);
        float2 _3926 = max(_1363, _1518);
        float2 _3927 = float2(_3924.x ? _1518.x : _3926.x, _3924.y ? _1518.y : _3926.y);
        float _1525 = isnan(_1434) ? _1357 : (isnan(_1357) ? _1434 : max(_1357, _1434));
        float _1526 = isnan(_1525) ? _1511 : (isnan(_1511) ? _1525 : max(_1511, _1525));
        float4 _1529 = float4((float4(((clamp(_1332 / _1324.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, _1316.x)) * _1354) * _1288, _1357, _1351).xy + float4(((clamp(_1409 / _1401.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, _1393.x)) * _1431) * _1365, _1434, _1428).xy) + float4(((clamp(_1486 / _1478.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, _1470.x)) * _1508) * _1442, _1511, _1505).xy, _1526, 0.0f);
        float2 _1531 = _1280.xz * 1.0f;
        float2 _1532 = floor(_1531);
        float2 _1535 = frac(_1532 * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1539 = _1535 + dot(_1535, _1535 + 34.345001220703125f.xx).xx;
        float _1540 = _1539.x;
        float _1541 = _1539.y;
        float2 _1545 = frac(float2(_1540 * _1541, _1540 + _1541));
        float2 _1548 = frac((_1532 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1552 = _1548 + dot(_1548, _1548 + 34.345001220703125f.xx).xx;
        float _1553 = _1552.x;
        float _1554 = _1552.y;
        float2 _1558 = frac(float2(_1553 * _1554, _1553 + _1554));
        float _1564 = _1545.x;
        float _1566 = 0.25f * lerp(0.60000002384185791015625f, 1.0f, _1564);
        float2 _1567 = ((_1531 - _1532) + ((((_1558 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float _1570 = _1567.y;
        float2 _1574 = float2(_1567.x * 1.25f, _1570 * ((_1570 < 0.0f) ? 1.25f : 0.75f));
        float _1577 = _1278 + _1564;
        float _1581 = _1266 ? frac(_1577) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(_1577, 0.0f, 1.0f));
        float _1593 = _1545.y;
        float _1596 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, _1581) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, _1581)) * step(0.001000000047497451305389404296875f, smoothstep(_1566, 0.0f, length(_1574)))) * step(_1271, _1593 - 0.100000001490116119384765625f);
        float _1599 = _1596 * _1288;
        float2 _1604 = _1280.xy * 1.0f;
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
        float _1639 = 0.25f * lerp(0.60000002384185791015625f, 1.0f, _1637);
        float2 _1640 = ((_1604 - _1605) + ((((_1631 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float _1643 = _1640.y;
        float2 _1647 = float2(_1640.x * 1.25f, _1643 * ((_1643 < 0.0f) ? 1.25f : 0.75f));
        float _1650 = _1278 + _1637;
        float _1654 = _1266 ? frac(_1650) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(_1650, 0.0f, 1.0f));
        float _1666 = _1618.y;
        float _1669 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, _1654) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, _1654)) * step(0.001000000047497451305389404296875f, smoothstep(_1639, 0.0f, length(_1647)))) * step(_1271, _1666 - 0.100000001490116119384765625f);
        float _1672 = _1669 * _1365;
        float2 _1677 = _1280.zy * 1.0f;
        float2 _1678 = floor(_1677);
        float2 _1681 = frac(_1678 * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1685 = _1681 + dot(_1681, _1681 + 34.345001220703125f.xx).xx;
        float _1686 = _1685.x;
        float _1687 = _1685.y;
        float2 _1691 = frac(float2(_1686 * _1687, _1686 + _1687));
        float2 _1694 = frac((_1678 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1698 = _1694 + dot(_1694, _1694 + 34.345001220703125f.xx).xx;
        float _1699 = _1698.x;
        float _1700 = _1698.y;
        float2 _1704 = frac(float2(_1699 * _1700, _1699 + _1700));
        float _1710 = _1691.x;
        float _1712 = 0.25f * lerp(0.60000002384185791015625f, 1.0f, _1710);
        float2 _1713 = ((_1677 - _1678) + ((((_1704 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float _1716 = _1713.y;
        float2 _1720 = float2(_1713.x * 1.25f, _1716 * ((_1716 < 0.0f) ? 1.25f : 0.75f));
        float _1723 = _1278 + _1710;
        float _1727 = _1266 ? frac(_1723) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(_1723, 0.0f, 1.0f));
        float _1739 = _1691.y;
        float _1742 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, _1727) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, _1727)) * step(0.001000000047497451305389404296875f, smoothstep(_1712, 0.0f, length(_1720)))) * step(_1271, _1739 - 0.100000001490116119384765625f);
        float _1745 = _1742 * _1442;
        float _1754 = isnan(_1672) ? _1599 : (isnan(_1599) ? _1672 : max(_1599, _1672));
        float4 _1758 = float4((float4(((clamp(_1574 / _1566.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, _1558.x)) * _1596) * _1288, _1599, _1593).xy + float4(((clamp(_1647 / _1639.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, _1631.x)) * _1669) * _1365, _1672, _1666).xy) + float4(((clamp(_1720 / _1712.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, _1704.x)) * _1742) * _1442, _1745, _1739).xy, isnan(_1754) ? _1745 : (isnan(_1745) ? _1754 : max(_1745, _1754)), 0.0f);
        float _1760 = step(float2(_3925.x ? _1363.x : _3927.x, _3925.y ? _1363.y : _3927.y).x, 0.00999999977648258209228515625f);
        float2 _1764 = _1529.xy + (_1758.xy * _1760);
        float2 _1767 = _1529.zw * step(0.00999999977648258209228515625f, _1526);
        float2 _1769 = _1758.zw * _1760;
        bool2 _3949 = isnan(_1767);
        bool2 _3950 = isnan(_1769);
        float2 _3951 = max(_1767, _1769);
        float2 _3952 = float2(_3949.x ? _1769.x : _3951.x, _3949.y ? _1769.y : _3951.y);
        float2 _1770 = float2(_3950.x ? _1767.x : _3952.x, _3950.y ? _1767.y : _3952.y);
        float _1772 = _1770.x;
        float3 _1773 = float3((_1238.xy * 2.0f) - 1.0f.xx, 0.0f) + float3(_1764.x, _1764.y, 0.0f.xxx.z);
        float _1774 = isnan(_1265) ? _1772 : (isnan(_1772) ? _1265 : max(_1772, _1265));
        float2 _1777 = float2(0.0f, (_19_m10.x * _19_m89.z) * 0.75f);
        float3 _1780 = float3(_1207.x, 0.0f, _1207.z);
        float _1781 = dot(_1780, _1780);
        float3 _1786 = abs(_1780 * rsqrt(isnan(_1781) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? _1781 : max(1.1754943508222875079687365372222e-38f, _1781)))) - 0.20000000298023223876953125f.xxx;
        float3 _1788 = (_1786 * _1786) * _1786;
        bool3 _3964 = isnan(_1788);
        bool3 _3965 = isnan(6.103515625e-05f.xxx);
        float3 _3966 = max(_1788, 6.103515625e-05f.xxx);
        float3 _3967 = float3(_3964.x ? 6.103515625e-05f.xxx.x : _3966.x, _3964.y ? 6.103515625e-05f.xxx.y : _3966.y, _3964.z ? 6.103515625e-05f.xxx.z : _3966.z);
        float3 _1789 = float3(_3965.x ? _1788.x : _3967.x, _3965.y ? _1788.y : _3967.y, _3965.z ? _1788.z : _3967.z);
        float3 _1792 = _1789 / dot(_1789, 1.0f.xxx).xxx;
        float _1811 = _1792.z;
        float _1813 = _1792.x;
        float4 _1815 = (_54.SampleBias(_26, _1223, _19_m16) * _1811) + (_54.SampleBias(_26, _1228, _19_m16) * _1813);
        float2 _1827 = _1773.xy + ((((_1815.xy * 2.0f) - 1.0f.xx) * ((_54.SampleBias(_26, _1223 + _1777, _19_m16).w * _1811) + (_54.SampleBias(_26, _1228 + _1777, _19_m16).w * _1813))) * _1262);
        float _1829 = _1815.z;
        float _1833 = smoothstep(1.0f - _1829, 1.10000002384185791015625f - _1829, _1262) * _1262;
        float _1834 = isnan(_1833) ? _1774 : (isnan(_1774) ? _1833 : max(_1774, _1833));
        float2 _1835 = _1827.xy;
        float _1839 = sqrt(1.0f - clamp(dot(_1835, _1835), 0.0f, 1.0f));
        float3 _1841 = float3(_1827.x, _1827.y, _1773.z);
        _1841.z = isnan(_1839) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? _1839 : max(1.000000016862383526387164645044e-16f, _1839));
        float3 _1842 = normalize(_1841);
        float3 _1843 = cross(_610, float3(0.0f, 1.0f, 0.0f));
        bool3 _1846 = (dot(_1843, _1843) > 6.103515625e-05f).xxx;
        float3 _1847 = normalize(_1843);
        float3 _1848 = float3(_1846.x ? _1847.x : float3(1.0f, 0.0f, 0.0f).x, _1846.y ? _1847.y : float3(1.0f, 0.0f, 0.0f).y, _1846.z ? _1847.z : float3(1.0f, 0.0f, 0.0f).z);
        float _1859 = isnan(0.0500000007450580596923828125f) ? _506 : (isnan(_506) ? 0.0500000007450580596923828125f : min(_506, 0.0500000007450580596923828125f));
        float _1860 = lerp(_506, _1859, _1834);
        float _1877 = lerp(1.0f, 0.5f, (_1250 * (1.0f - _1196)) * (1.0f - _1259));
        float _1882 = _1860 - ((0.20000000298023223876953125f * _1196) * _1250);
        float _1883 = isnan(_1860) ? 0.20000000298023223876953125f : (isnan(0.20000000298023223876953125f) ? _1860 : min(0.20000000298023223876953125f, _1860));
        _1885 = normalize(lerp(_610, normalize(((_1848 * _1842.x) + (cross(_1848, _610) * _1842.y)) + (_610 * _1842.z)), _1834.xxx));
        _1886 = _1834;
        _1887 = _1859;
        _1888 = _1834;
        _1889 = isnan(_1883) ? _1882 : (isnan(_1882) ? _1883 : max(_1882, _1883));
        _1890 = _543 * _1877;
        _1891 = lerp(_497, _497 * ((smoothstep(0.699999988079071044921875f, 0.300000011920928955078125f, dot(_497, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f))) * 0.5f) + 1.0f).xxx, (_1834 * _1257).xxx) * _1877;
    }
    else
    {
        _1885 = _610;
        _1886 = 0.0f;
        _1887 = 0.00999999977648258209228515625f;
        _1888 = 0.0f;
        _1889 = _506;
        _1890 = _543;
        _1891 = _497;
    }
    float3 _2063;
    float _2064;
    float _2065;
    float3 _2066;
    float3 _2067;
    float _2068;
    [branch]
    if (_649 > 0.00999999977648258209228515625f)
    {
        bool3 _1895 = _472.xxx;
        float3 _1897 = _10.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 _1898 = float3(_1895.x ? _1897.x : _10.x, _1895.y ? _1897.y : _10.y, _1895.z ? _1897.z : _10.z);
        float3 _1901 = _1898 * _19_m89.z;
        float3 _1903 = float3(_1895.x ? _9.xzy.x : _9.x, _1895.y ? _9.xzy.y : _9.y, _1895.z ? _9.xzy.z : _9.z);
        float3 _1905 = abs(_1903) - 0.20000000298023223876953125f.xxx;
        float3 _1907 = (_1905 * _1905) * _1905;
        bool3 _3994 = isnan(_1907);
        bool3 _3995 = isnan(6.103515625e-05f.xxx);
        float3 _3996 = max(_1907, 6.103515625e-05f.xxx);
        float3 _3997 = float3(_3994.x ? 6.103515625e-05f.xxx.x : _3996.x, _3994.y ? 6.103515625e-05f.xxx.y : _3996.y, _3994.z ? 6.103515625e-05f.xxx.z : _3996.z);
        float3 _1908 = float3(_3995.x ? _1907.x : _3997.x, _3995.y ? _1907.y : _3997.y, _3995.z ? _1907.z : _3997.z);
        float3 _1911 = _1908 / dot(_1908, 1.0f.xxx).xxx;
        float _1927 = _1911.y;
        float _1929 = _1911.z;
        float _1932 = _1911.x;
        float4 _1934 = ((_55.SampleBias(_26, _1901.xz, _19_m16) * _1927) + (_55.SampleBias(_26, _1901.xy, _19_m16) * _1929)) + (_55.SampleBias(_26, _1901.zy, _19_m16) * _1932);
        float _1935 = _1903.y;
        float _1942 = clamp(_649 + (smoothstep(0.3499999940395355224609375f, 0.20000000298023223876953125f, _1898.y) * clamp(_649 * 3.0f, 0.0f, 1.0f)), 0.0f, 1.0f);
        float _1953 = smoothstep(2.0f - _1942, 2.349999904632568359375f - _1942, ((_1935 * 0.64999997615814208984375f) + 0.3499999940395355224609375f) + _1934.z) * ((_504 * _504) * float(gl_FrontFacing));
        float _1965 = lerp(1.0f, 0.5f, ((_1942 * (1.0f - smoothstep(0.3499999940395355224609375f, 0.100000001490116119384765625f, dot(_1891 * (1.0f - _502), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f))))) * _1934.w) * ((_1935 * 0.25f) + 0.75f));
        float3 _1967 = _1953.xxx;
        float2 _1973 = (_1934.xy * 2.0f) - 1.0f.xx;
        float2 _1975 = _1973.xy;
        float _1979 = sqrt(1.0f - clamp(dot(_1975, _1975), 0.0f, 1.0f));
        float3 _1981 = float3(_1973.x, _1973.y, _425.z);
        _1981.z = isnan(_1979) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? _1979 : max(1.000000016862383526387164645044e-16f, _1979));
        float2 _1983 = _1981.xy * 2.0f;
        float3 _1985 = lerp(float3(0.0f, 0.0f, 1.0f), float3(_1983.x, _1983.y, _1981.z), _1967);
        float _1986 = dot(_1985, _1985);
        float3 _1989 = _1985 * rsqrt(isnan(_1986) ? 6.103515625e-05f : (isnan(6.103515625e-05f) ? _1986 : max(6.103515625e-05f, _1986)));
        float _1990 = _610.y;
        float _1993 = step(0.00999999977648258209228515625f, 1.0f - (_1990 * _1990));
        float _1997 = lerp(_610.z, _1990, _1993);
        float _1999 = 1.0f - (_1997 * _1997);
        float3 _2004 = (float3(0.0f, _1993, 1.0f - _1993) - (_610 * _1997)) * rsqrt(isnan(_1999) ? 9.9999997473787516355514526367188e-05f : (isnan(9.9999997473787516355514526367188e-05f) ? _1999 : max(9.9999997473787516355514526367188e-05f, _1999)));
        float3 _2018 = _1901 * 4.0f;
        float4 _2038 = ((_56.SampleLevel(_24, _2018.xz, 0.0f) * _1927) + (_56.SampleLevel(_24, _2018.xy, 0.0f) * _1929)) + (_56.SampleLevel(_24, _2018.zy, 0.0f) * _1932);
        float2 _2041 = (_2038.xz * 2.0f) - 1.0f.xx;
        float _2052 = smoothstep(0.949999988079071044921875f, 1.0f, frac(((dot(float3(_2041.x, _2038.y, _2041.y), (floor(_463 * 50.0f) * 0.0199999995529651641845703125f) * 0.100000001490116119384765625f) * 0.5f) + 0.5f) * 2.0f));
        float _2053 = _2052 * _2052;
        float _2056 = _2053 * ((_2053 * 2.0f) * _1953);
        float3 _2057 = 1.0f.xxx * _2056;
        _2063 = ((cross(_2004, _610) * _1989.x) + (_2004 * _1989.y)) + (_610 * _1989.z);
        _2064 = _1888 + _2056;
        _2065 = lerp(lerp(_1889, 0.89999997615814208984375f, clamp(_1953 * 4.0f, 0.0f, 1.0f)), 0.00999999977648258209228515625f, _2056);
        _2066 = lerp(_1890 * _1965, 0.3079999983310699462890625f.xxx, _1967) + (_2057 * 0.5f);
        _2067 = lerp(_1891 * _1965, 0.87999999523162841796875f.xxx, _1967) + _2057;
        _2068 = lerp(_502, 0.0f, _1953);
    }
    else
    {
        _2063 = _610;
        _2064 = _1888;
        _2065 = _1889;
        _2066 = _1890;
        _2067 = _1891;
        _2068 = _502;
    }
    float _2070 = 0.959999978542327880859375f - (_2068 * 0.959999978542327880859375f);
    float3 _2071 = _2067 * _2070;
    float3 _2074 = lerp(0.039999999105930328369140625f.xxx * _501.y, _2067, _2068.xxx);
    float3 _2075 = _2066 * _2070;
    float _2076 = _2065 * _2065;
    float _2077 = isnan(0.0078125f) ? _2076 : (isnan(_2076) ? 0.0078125f : max(_2076, 0.0078125f));
    float _2078 = _2077 * _2077;
    float2 _2091 = (_7.xy / (isnan(9.9999999392252902907785028219223e-09f) ? _7.z : (isnan(_7.z) ? 9.9999999392252902907785028219223e-09f : max(_7.z, 9.9999999392252902907785028219223e-09f))).xx) - (_8.xy / (isnan(9.9999999392252902907785028219223e-09f) ? _8.z : (isnan(_8.z) ? 9.9999999392252902907785028219223e-09f : max(_8.z, 9.9999999392252902907785028219223e-09f))).xx);
    float2 _2094 = _2091;
    _2094.y = -_2091.y;
    float2 _2104 = ((sqrt(sqrt(abs(_2094 * 0.5f))) * float2(int2(sign(_2094)))) * 0.5f) + 0.5f.xx;
    float4 _2108 = float4(_2104.x, _2104.y, 0.0f.xxxx.z, 0.0f.xxxx.w);
    _2108.z = 1.0f;
    float4 _2109 = _2108;
    _2109.w = (_2064 > 0.100000001490116119384765625f) ? 0.699999988079071044921875f : 0.4000000059604644775390625f;
    float3 _2120 = lerp(-_36_m0.xyz, _19_m90.xyz, _19_m80.w.xxx);
    float3 _2124 = normalize(float3(_2120.x, 6.103515625e-05f, _2120.z));
    float3 _2134 = lerp(_36_m3.xyz, _19_m84.xyz, _19_m91.y.xxx);
    float3 _2138 = _2134 * lerp(_36_m3.w, 1.0f, _19_m91.w);
    int _2142 = int(_613.x);
    int _2143 = int(_613.y);
    float4 _2147 = _40.Load(int3(int3(_2142, _2143, 0).xy, 0));
    float _2152 = _2147.y;
    float _2155 = lerp(lerp(1.0f, _2147.x, _38_m6.x), 1.0f, _19_m80.z);
    float _2156 = dot(_2063, _2120);
    float3 _2163 = _2075 * _19_m79.z;
    float3 _2164 = _2163 * 0.64999997615814208984375f;
    float _2168 = dot(_2071, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float _2181 = clamp(-dot(_2124.xz, normalize(_623.xz)), 0.0f, 1.0f);
    float _2185 = 1.0f - _19_m91.x;
    float4 _2199 = _50.SampleLevel(_25, float2((clamp(lerp(_2156, ((-_2156) * ((_2156 * 0.5f) - 1.0f)) + 0.5f, (_2181 * smoothstep(0.25f, 0.75f, 1.0f - abs(_623.y))) * _2185) + (_19_m90.w * _19_m91.x), -1.0f, 1.0f) * 0.5f) + 0.5f, 0.5f), 0.0f);
    float _2200 = _2199.w;
    float _2202 = _2199.x;
    float _2203 = _2199.y;
    float _2204 = _2199.z;
    float _2205 = isnan(_2203) ? _2202 : (isnan(_2202) ? _2203 : max(_2202, _2203));
    float _2207 = isnan(_2203) ? _2202 : (isnan(_2202) ? _2203 : min(_2202, _2203));
    float _2209 = (isnan(_2204) ? _2205 : (isnan(_2205) ? _2204 : max(_2205, _2204))) - (isnan(_2204) ? _2207 : (isnan(_2207) ? _2204 : min(_2207, _2204)));
    float4 _2217 = _50.SampleLevel(_25, float2((dot(_2063, _623) * 0.5f) + 0.5f, 0.5f), 0.0f);
    float _2218 = _2217.w;
    float _2219 = _504 * _2152;
    float _2225 = isnan(_504) ? _2152 : (isnan(_2152) ? _504 : min(_2152, _504));
    float _2226 = isnan(_2200) ? _2225 : (isnan(_2225) ? _2200 : min(_2225, _2200));
    float _2227 = _2218 * _2219;
    float3 _2231 = ((clamp(dot(_610, _19_m85.xyz) + _19_m86.x, 0.0f, 1.0f) * _19_m86.y) + _19_m86.z).xxx * lerp(_1164, 1.0f.xxx, (_19_m80.y * _2226).xxx);
    float3 _2233 = _2226.xxx;
    float _2246 = lerp(0.64999997615814208984375f, 1.0f, _1165);
    float3 _2256 = _2155.xxx;
    float3 _2257 = lerp((_2231 * lerp(isnan(1.5f) ? _2246 : (isnan(_2246) ? 1.5f : min(_2246, 1.5f)), clamp(_1165, 1.25f, 1.75f), _19_m80.x)) * _19_m79.w, (lerp(dot(_2138, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, _2138, _2233) + ((_2231 * clamp(_1165, 0.0f, 1.5f)) * ((1.0f - _19_m91.y).xxx + (_2134 * _19_m91.y)))) * _19_m79.y, _2256);
    float3 _2258 = lerp(lerp(lerp(dot(_2164, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, _2164, 1.2000000476837158203125f.xxx), _2163, clamp((_2219 * _2218) + _2200, 0.0f, 1.0f).xxx), _2071, _2233);
    float3 _2264 = _2258 * ((1.0f - _2209).xxx + (_2199.xyz * _2209));
    float _2265 = dot(_2264, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float3 _2273 = lerp(lerp(_2163, lerp(_2168.xxx, _2071, 1.2000000476837158203125f.xxx), _2227.xxx), _2264 * clamp(dot(_2258, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)) * (1.0f / (isnan(0.001000000047497451305389404296875f) ? _2265 : (isnan(_2265) ? 0.001000000047497451305389404296875f : max(_2265, 0.001000000047497451305389404296875f)))), 0.0f, 1.5f), _2256);
    float4 _2277 = float4(_2273, _2155);
    float _2279 = lerp(_2227, _2226, _2155);
    float _2282 = lerp(_19_m79.z, 1.0f, _2279);
    float3 _2290 = float3(_623.x, lerp(0.5f, _2120.y, _2155), _623.z);
    float _2291 = dot(_2290, _2290);
    float _2303 = clamp(dot(_1885, _463), 0.0f, 1.0f);
    float _2304 = dot(_1885, normalize(((_2120 * _2155) + ((_2290 * rsqrt(isnan(_2291) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? _2291 : max(1.1754943508222875079687365372222e-38f, _2291)))) * 2.0f)) + (_463 * (2.0f + _2155))));
    float _2308 = (((_2304 * _2078) - _2304) * _2304) + 1.0f;
    float _2309 = _2308 * _2308;
    float _2312 = (_2078 != _2309) ? (_2078 / _2309) : 1.0f;
    float _2313 = 2.0f * _2303;
    float _2315 = (1.0f + _2303) - _2303;
    float _2321 = 1.0f / (_2078 + 9.9999997473787516355514526367188e-05f);
    float _2324 = _2303 * _2303;
    float3 _2336 = _2074 * _51.SampleLevel(_25, float2(lerp(_2312 / (isnan(65504.0f) ? _2321 : (isnan(_2321) ? 65504.0f : min(_2321, 65504.0f))), _2324, _49_m4), _2065 * (1.0f - _2068)), 0.0f).xyz;
    float3 _2338 = lerp(_2074, _2336, _49_m4.xxx);
    float _2351 = (1.0f - _49_m6) + (_510 * _49_m6);
    float3 _2353 = ((_2257 * _2273) * _2351) + (((_2336 * clamp((_2312 * (0.5f / ((_2313 + (_2077 * _2315)) + 9.9999997473787516355514526367188e-05f))) - 6.103515625e-05f, 0.0f, 20.0f)) * ((_2257 * (((_2279 * 0.5f) + 0.5f) * _2282)) * 1.0f)) * _19_m92.w);
    float _2354 = dot(_2353, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float _2357 = clamp(_2354 - 0.5f, 0.0f, 0.5f);
    float3 _2393 = normalize(cross(_623, lerp(float3(_19_m88.xy, 0.0f), (float3(_17_m0[0].x, _17_m0[0].y, _17_m0[0].z) * _19_m88.x) + (float3(_17_m0[1].x, _17_m0[1].y, _17_m0[1].z) * _19_m88.y), _19_m94.w.xxx)));
    float _2399 = dot(_463, _2063);
    float _2401 = 1.0f - abs(_2399);
    float _2411 = clamp(dot(_590, _2393) + 1.0f, 0.0f, 1.0f);
    float _2412 = isnan(_504) ? _2411 : (isnan(_2411) ? _504 : min(_2411, _504));
    float _2423 = dot(_2124, _2063);
    float _2435 = 1.0f - _2155;
    float _2446 = isnan(_1163.y) ? _1163.x : (isnan(_1163.x) ? _1163.y : max(_1163.x, _1163.y));
    float _2448 = (isnan(_1163.z) ? _2446 : (isnan(_2446) ? _1163.z : max(_2446, _1163.z))) * 0.5f;
    bool3 _4109 = isnan(0.1500000059604644775390625f.xxx);
    bool3 _4110 = isnan(_2071);
    float3 _4111 = max(0.1500000059604644775390625f.xxx, _2071);
    float3 _4112 = float3(_4109.x ? _2071.x : _4111.x, _4109.y ? _2071.y : _4111.y, _4109.z ? _2071.z : _4111.z);
    float _2462 = lerp(_2065, _1887, _1886);
    float _2463 = _2462 * _2462;
    float _2464 = _2324 * _2303;
    float2 _2465 = float2(1.0f, _2303);
    float2 _2468 = float2(1.0f, _2463);
    float3 _2471 = float3(1.0f, _2463, (_2463 * _2463) * _2463);
    float _2476 = dot(mul(_2465, float2x2(float2(0.0365463010966777801513671875f, 9.0631999969482421875f), float2(3.3270699977874755859375f, -9.0475597381591796875f))), _2468) / dot(mul(float3(1.0f, _2324, _2464), float3x3(float3(1.0f, 9.044010162353515625f, 5.565889835357666015625f), float3(3.596849918365478515625f, -16.3173999786376953125f, 19.788600921630859375f), float3(-1.36772000789642333984375f, 9.2294902801513671875f, -20.212299346923828125f))), _2471);
    float _2481 = dot(mul(_2465, float2x2(float2(0.99044001102447509765625f, 1.29677999019622802734375f), float2(-1.28514003753662109375f, -0.755906999111175537109375f))), _2468) / dot(mul(float3(1.0f, _2303, _2464), float3x3(float3(1.0f, 20.3225002288818359375f, 121.5630035400390625f), float3(2.9233798980712890625f, -27.0301990509033203125f, 626.1300048828125f), float3(59.41880035400390625f, 222.5919952392578125f, 316.62701416015625f))), _2471);
    float3 _2484 = (_2338 * _2476) + _2481.xxx;
    float _2485 = _2476 + _2481;
    float3 _2491 = -_463;
    float2 _2513 = float2(_613);
    float2 _2515 = floor(_2513 * 0.03125f);
    int _2523 = int((_2515.x + (_2515.y * _34_m5)) * 8.0f);
    float _2530 = floor(_444 - (_19_m3.y * _34_m11));
    float _2534 = clamp(_2530, 0.0f, _34_m7 - 1.0f);
    int _2536 = int(_2534 * 8.0f);
    float3 _2538;
    _2538 = ((lerp(_2354.xxx, _2353, ((_2357 * _2357) + 1.0f).xxx) + (((((_19_m87.xyz * smoothstep(lerp(0.800000011920928955078125f, 0.20000000298023223876953125f, _19_m88.w), lerp(0.89999997615814208984375f, 0.5f, _19_m88.w), _2401)) * _19_m87.w) * (isnan(_2152) ? _2412 : (isnan(_2412) ? _2152 : min(_2412, _2152)))) * (lerp(0.25f.xxx, _2071, _19_m88.z.xxx) * clamp(dot(_2393, _2063), 0.0f, 1.0f))) + ((((((lerp(_1163 * (1.0f / (isnan(1.0f) ? _2448 : (isnan(_2448) ? 1.0f : max(_2448, 1.0f)))), _2138, _2256) * clamp(lerp(dot(_1162.xyz, _2063) * _1162.w, ((-_2423) * ((_2423 * 0.5f) - 1.0f)) + 0.5f, _2155), 0.0f, 1.0f)) * ((_2435 + (_2181 * _2155)) * _2185)) * smoothstep(0.60000002384185791015625f, 0.800000011920928955078125f, _2401)) * (isnan(_2152) ? _504 : (isnan(_504) ? _2152 : min(_504, _2152)))) * (_2435 + (smoothstep(0.100000001490116119384765625f, 0.039999999105930328369140625f, _2168) * _2155))) * float3(_4110.x ? 0.1500000059604644775390625f.xxx.x : _4112.x, _4110.y ? 0.1500000059604644775390625f.xxx.y : _4112.y, _4110.z ? 0.1500000059604644775390625f.xxx.z : _4112.z)))) + (((_571.xyz * _49_m25.xyz) * _49_m7) * _2351)) + (((_62.SampleLevel(_25, reflect(_2491, _1885), (1.2000000476837158203125f * log2(isnan(0.001000000047497451305389404296875f) ? _2462 : (isnan(_2462) ? 0.001000000047497451305389404296875f : max(_2462, 0.001000000047497451305389404296875f)))) + 5.0f).xyz * ((_2484 + ((_2338 * ((1.0f - _2485) / _2485)) * _2484)) * 1.0f)) * ((clamp(_1165, 0.5f, 1.5f) * _19_m79.w) * _2282)) * _1164);
    float3 _2539;
    [loop]
    for (int _2541 = 0; _2541 <= 7; _2538 = _2539, _2541++)
    {
        uint _2559 = (_2530 <= _2534) ? (_30.Load(uint(_2523 + _2541) * 4 + 0) & _30.Load(uint((_19_m21.y + _2536) + _2541) * 4 + 0)) : 0u;
        uint _2560 = uint(_2541);
        _2539 = _2538;
        uint _2565;
        float3 _2562;
        [loop]
        for (uint _2564 = _2559; _2564 != 0u; _2539 = _2562, _2564 = _2565)
        {
            uint _2569 = firstbitlow(_2564);
            _2565 = _2564 ^ (1u << (_2569 & 31u));
            int _2575 = int((32u * _2560) + _2569) * 8;
            int _2578 = _2575 + 1;
            int _2581 = _2575 + 2;
            int _2584 = _2575 + 3;
            int _2587 = _2575 + 4;
            int _2590 = _2575 + 5;
            int _2593 = _2575 + 6;
            int _2596 = _2575 + 7;
            uint _2600 = uint(_36_m6[_2590].w);
            float _2675;
            if ((_2600 & 1u) == 1u)
            {
                uint _2606 = asuint(_36_m6[_2590].x);
                uint _2613 = asuint(_36_m6[_2590].y);
                uint _2620 = asuint(_36_m6[_2590].z);
                uint _2627 = asuint(_36_m6[_2593].x);
                uint _2634 = asuint(_36_m6[_2593].y);
                uint _2641 = asuint(_36_m6[_2593].z);
                float3 _2660 = abs(mul(float4(_583 - _36_m6[_2578].xyz, 1.0f), float4x4(float4(spvUnpackHalf2x16(_2606).x, spvUnpackHalf2x16(_2620).x, spvUnpackHalf2x16(_2634).x, 0.0f), float4(spvUnpackHalf2x16(_2606 >> 16u).x, spvUnpackHalf2x16(_2620 >> 16u).x, spvUnpackHalf2x16(_2634 >> 16u).x, 0.0f), float4(spvUnpackHalf2x16(_2613).x, spvUnpackHalf2x16(_2627).x, spvUnpackHalf2x16(_2641).x, 0.0f), float4(spvUnpackHalf2x16(_2613 >> 16u).x, spvUnpackHalf2x16(_2627 >> 16u).x, spvUnpackHalf2x16(_2641 >> 16u).x, 0.0f))).xyz);
                float _2661 = _2660.x;
                float _2662 = _2660.y;
                float _2663 = isnan(_2662) ? _2661 : (isnan(_2661) ? _2662 : max(_2661, _2662));
                float _2664 = _2660.z;
                float _2667 = _36_m6[_2596].x * 0.5f;
                float _2673 = 1.0f - clamp(((isnan(_2664) ? _2663 : (isnan(_2663) ? _2664 : max(_2663, _2664))) - (_2667 + 0.5f)) / (0.5f - _2667), 0.0f, 1.0f);
                _2675 = _2673 * _2673;
            }
            else
            {
                _2675 = 1.0f;
            }
            if (false || (_2675 < 0.001000000047497451305389404296875f))
            {
                _2562 = _2539;
                continue;
            }
            float3 _3368;
            if (_36_m6[_2575].w < 1.5f)
            {
                float3 _3367;
                do
                {
                    uint _2688 = asuint(_36_m6[_2584].w);
                    if ((_2688 == 16u) || ((_36_m6[_2584].z + _19_m91.z) < 0.5f))
                    {
                        _3367 = _2539;
                        break;
                    }
                    bool _2700 = (uint(_36_m6[_2575].w) & 1u) == 0u;
                    bool _2704 = (!_2700) && (_36_m6[_2581].z > 0.0f);
                    bool _2705 = _2688 == 4u;
                    float _2706 = float(_2700);
                    float _2714 = (0.5f + (0.5f * _36_m6[_2581].y)) - abs(_36_m6[_2581].x);
                    float _2715 = _36_m6[_2581].y - _2714;
                    float _2719 = (1.0f - abs(_2714)) - abs(_2715);
                    float _2722 = abs(isnan(0.00048828125f) ? _2719 : (isnan(_2719) ? 0.00048828125f : max(_2719, 0.00048828125f)));
                    float3 _2726 = normalize(float3(_2714, _2715, (_36_m6[_2581].x >= 0.0f) ? _2722 : (-_2722)));
                    float _2729 = 2.0f * _36_m6[_2587].y;
                    float _2732 = lerp(_36_m6[_2593].w, isnan(0.100000001490116119384765625f) ? _2729 : (isnan(_2729) ? 0.100000001490116119384765625f : max(_2729, 0.100000001490116119384765625f)), float(_2705));
                    float3 _2737 = _36_m6[_2578].xyz - _583;
                    float3 _2738 = -_2726;
                    float3 _2743 = lerp(_2737, _2738 * dot(_2737, _2738), (float(_2705 && (_36_m6[_2587].z > 0.5f)) * _2706).xxx);
                    float _2744 = dot(_2743, _2743);
                    float _2745 = rsqrt(_2744);
                    float3 _2746 = _2743 * _2745;
                    float3 _2779;
                    float _2780;
                    if (_2704)
                    {
                        float3 _2750 = (_2726 * _36_m6[_2581].z) * 0.5f;
                        float3 _2751 = _2743 - _2750;
                        float3 _2752 = _2743 + _2750;
                        float _2753 = length(_2751);
                        float _2754 = length(_2752);
                        float3 _2763 = normalize(cross(cross(_2726, _2746), _2726));
                        _2779 = _2763;
                        _2780 = ((1.0f / ((((_2753 * _2754) + dot(_2751, _2752)) * 0.5f) + 1.0f)) * clamp(0.5f * ((dot(_2763, _2751) / _2753) + (dot(_2763, _2752) / _2754)), 0.0f, 1.0f)) * (1.0f / clamp(1.0f + (0.5f * clamp(_36_m6[_2581].z * _2745, 0.0f, 1.0f)), 0.0f, 1.0f));
                    }
                    else
                    {
                        _2779 = _2746;
                        _2780 = 1.0f;
                    }
                    float _2802;
                    if (_2732 < 0.0f)
                    {
                        float _2790 = _2744 * (_36_m6[_2578].w * _36_m6[_2578].w);
                        float _2793 = clamp(1.0f - (_2790 * _2790), 0.0f, 1.0f);
                        _2802 = lerp(1.0f / (_2744 + 1.0f), _2780, float(_2704)) * (_2793 * _2793);
                    }
                    else
                    {
                        float3 _2796 = _2743 * _36_m6[_2578].w;
                        _2802 = _2780 * pow(1.0f - clamp(dot(_2796, _2796), 0.0f, 1.0f), _2732);
                    }
                    float _2807 = clamp((dot(_2779, _2738) - _36_m6[_2581].z) * _36_m6[_2581].w, 0.0f, 1.0f);
                    float _2810 = _2802 * lerp(1.0f, _2807 * _2807, _2706);
                    int _2812 = int(_36_m6[_2596].w);
                    float _2916;
                    if ((!_2704) && (_2812 >= 0))
                    {
                        uint _2818 = uint(_2812);
                        float2 _2909;
                        [branch]
                        if (_2706 != 0.0f)
                        {
                            float4 _2830 = mul(_65_m1[_2818], float4(_583.x, _655, _583.z, 1.0f));
                            _2909 = _65_m0[_2818].xy + (clamp(_2830.xy / _2830.w.xx, 0.0f.xx, 1.0f.xx) * _65_m0[_2818].zw);
                        }
                        else
                        {
                            float3 _2850 = mul(float4(-_2743, 0.0f), _65_m1[_2818]).xyz;
                            float3 _433 = _2850;
                            float3 _432 = _2850;
                            float3 _431 = abs(_2850);
                            uint _2859 = uint(int(_431.y > _431.x));
                            uint _2865 = (_431.z > _431[_2859]) ? 2u : _2859;
                            uint _2871 = (_2865 * 2u) + uint(_432[_2865] < 0.0f);
                            float _2875 = abs(_433[_2871 / 2u]);
                            float _2895 = 0.5f - (0.000244140625f / _65_m0[_2818].w);
                            _2909 = _65_m0[_2818].xy + (clamp(float2((float(_2871) + ((((_433[uint(_378[_2871].x)] * _379[_2871].x) / _2875) * _2895) + 0.5f)) * 0.16666667163372039794921875f, 0.5f - (((_433[uint(_378[_2871].y)] * _379[_2871].y) / _2875) * _2895)), 0.0f.xx, 1.0f.xx) * _65_m0[_2818].zw);
                        }
                        _2916 = _2810 * _63.SampleLevel(_25, _2909, 0.0f).x;
                    }
                    else
                    {
                        _2916 = _2810;
                    }
                    float _2917 = _2916 * _2675;
                    float3 _3366;
                    do
                    {
                        float3 _3365;
                        [branch]
                        if (_2917 > 9.9999997473787516355514526367188e-05f)
                        {
                            [branch]
                            if (_2705)
                            {
                                _3366 = lerp(_2539, _36_m6[_2575].xyz, (_2917 * (_36_m6[_2587].x * ((1.0f - _36_m6[_2587].w) + (smoothstep(-0.5f, 0.5f, dot(_611, _2779)) * _36_m6[_2587].w)))).xxx);
                                break;
                            }
                            float _2937 = dot(_2063, _2779);
                            float _2938 = clamp(_2937, 0.0f, 1.0f);
                            float _3241;
                            if (_2688 != 0u)
                            {
                                bool _2944 = _2700 || ((_2600 & 2u) != 0u);
                                int _2993;
                                if (_2944)
                                {
                                    _2993 = int(_36_m6[_2584].x);
                                }
                                else
                                {
                                    uint _2950 = asuint(_36_m6[_2581].w);
                                    uint _2952 = asuint(_36_m6[_2584].x);
                                    float3 _2953 = _583 - _36_m6[_2578].xyz;
                                    float3 _2954 = abs(_2953);
                                    float _2955 = _2954.x;
                                    float _2956 = _2954.y;
                                    float _2958 = _2954.z;
                                    int _2990;
                                    if ((_2955 > _2956) && (_2955 > _2958))
                                    {
                                        _2990 = int((_2953.x > 0.0f) ? (_2950 >> 24u) : ((_2950 >> 16u) & 255u));
                                    }
                                    else
                                    {
                                        int _2989;
                                        if (_2956 > _2958)
                                        {
                                            _2989 = int((_2953.y > 0.0f) ? ((_2950 >> 8u) & 255u) : (_2950 & 255u));
                                        }
                                        else
                                        {
                                            _2989 = int((_2953.z > 0.0f) ? ((_2952 >> 8u) & 255u) : (_2952 & 255u));
                                        }
                                        _2990 = _2989;
                                    }
                                    _2993 = (_2990 < 80) ? _2990 : (-1);
                                }
                                bool _2994 = _2993 >= 0;
                                float _3240;
                                if (_2994)
                                {
                                    float3 _2998 = _583 - _36_m6[_2578].xyz;
                                    float _2999 = dot(_2998, _2998);
                                    float4 _3018 = mul(_38_m10[_2993], float4((_583 - ((_2998 * rsqrt(isnan(_2999) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? _2999 : max(1.1754943508222875079687365372222e-38f, _2999)))) * _38_m11[_2993].x)) + (_611 * (_38_m11[_2993].y * 5.0f)), 1.0f));
                                    float _3019 = _3018.w;
                                    float3 _3022 = _3018.xyz / _3019.xxx;
                                    float2 _3023 = _3022.xy;
                                    float3 _3031 = _3022.xyz;
                                    bool3 _3032 = bool3(_3031.x <= 0.0f.xxx.x, _3031.y <= 0.0f.xxx.y, _3031.z <= 0.0f.xxx.z);
                                    bool3 _3033 = bool3(_3031.x >= 1.0f.xxx.x, _3031.y >= 1.0f.xxx.y, _3031.z >= 1.0f.xxx.z);
                                    float _3036 = _3022.z;
                                    float2 _3047 = ((_3023 * (_38_m12[_2993].zw - _38_m12[_2993].xy)) + _38_m12[_2993].xy).xy * _38_m13.zw;
                                    float2 _3049 = floor(_3047 + 0.5f.xx);
                                    float2 _3050 = _3047 - _3049;
                                    float _3051 = _3050.x;
                                    float _3052 = _3051 + 0.5f;
                                    float _3053 = _3052 * _3052;
                                    float _3056 = 1.0f - _3051;
                                    float _3057 = isnan(0.0f) ? _3051 : (isnan(_3051) ? 0.0f : min(_3051, 0.0f));
                                    float _3060 = _3051 + 1.0f;
                                    float _3061 = isnan(0.0f) ? _3051 : (isnan(_3051) ? 0.0f : max(_3051, 0.0f));
                                    float _3072 = _3050.y;
                                    float _3073 = _3072 + 0.5f;
                                    float _3074 = _3073 * _3073;
                                    float _3077 = 1.0f - _3072;
                                    float _3078 = isnan(0.0f) ? _3072 : (isnan(_3072) ? 0.0f : min(_3072, 0.0f));
                                    float _3081 = _3072 + 1.0f;
                                    float _3082 = isnan(0.0f) ? _3072 : (isnan(_3072) ? 0.0f : max(_3072, 0.0f));
                                    float3 _3094 = float3(0.1599999964237213134765625f * _3056, 0.1599999964237213134765625f * ((_3060 - (_3061 * _3061)) + 1.0f), _3053 * 0.07999999821186065673828125f);
                                    float3 _3095 = float3(0.1599999964237213134765625f * ((_3053 * 0.5f) - _3051), 0.1599999964237213134765625f * ((_3056 - (_3057 * _3057)) + 1.0f), 0.1599999964237213134765625f * _3060) + _3094;
                                    float3 _3097 = float3(0.1599999964237213134765625f * _3077, 0.1599999964237213134765625f * ((_3081 - (_3082 * _3082)) + 1.0f), _3074 * 0.07999999821186065673828125f);
                                    float3 _3098 = float3(0.1599999964237213134765625f * ((_3074 * 0.5f) - _3072), 0.1599999964237213134765625f * ((_3077 - (_3078 * _3078)) + 1.0f), 0.1599999964237213134765625f * _3081) + _3097;
                                    float3 _3104 = ((_3094 / _3095) + float3(-2.5f, -0.5f, 1.5f)) * _38_m13.xxx;
                                    float3 _3106 = ((_3097 / _3098) + float3(-2.5f, -0.5f, 1.5f)) * _38_m13.yyy;
                                    float2 _3108 = _3049 * _38_m13.xy;
                                    float _3109 = _3104.x;
                                    float _3110 = _3106.x;
                                    float _3113 = _3104.y;
                                    float _3116 = _3104.z;
                                    float _3119 = _3106.y;
                                    float _3126 = _3106.z;
                                    float _3133 = _3095.x;
                                    float _3134 = _3098.x;
                                    float _3136 = _3095.y;
                                    float _3138 = _3095.z;
                                    float _3140 = _3098.y;
                                    float _3144 = _3098.z;
                                    float2 _3222 = 1.0f.xx - _3023;
                                    bool2 _4164 = isnan(_3023);
                                    bool2 _4165 = isnan(_3222);
                                    float2 _4166 = min(_3023, _3222);
                                    float2 _4167 = float2(_4164.x ? _3222.x : _4166.x, _4164.y ? _3222.y : _4166.y);
                                    float2 _3223 = float2(_4165.x ? _3023.x : _4167.x, _4165.y ? _3023.y : _4167.y);
                                    float _3224 = _3223.x;
                                    float _3225 = _3223.y;
                                    float _3226 = isnan(_3225) ? _3224 : (isnan(_3224) ? _3225 : min(_3224, _3225));
                                    float _3230 = (_38_m11[_2993].z - _3019) * 0.25f;
                                    float _3232 = smoothstep(0.0f, 0.0500000007450580596923828125f, isnan(_3226) ? _3230 : (isnan(_3230) ? _3226 : min(_3230, _3226)));
                                    _3240 = _2994 ? lerp(1.0f, (any(bool3(_3032.x || _3033.x, _3032.y || _3033.y, _3032.z || _3033.z)) || ((asuint(_3036) & 2147483647u) > 2139095040u)) ? 1.0f : ((((((((((_3133 * _3134) * _39.SampleCmpLevelZero(_27, float3(_3108 + float2(_3109, _3110), _424).xy, _3036)) + ((_3136 * _3134) * _39.SampleCmpLevelZero(_27, float3(_3108 + float2(_3113, _3110), _424).xy, _3036))) + ((_3138 * _3134) * _39.SampleCmpLevelZero(_27, float3(_3108 + float2(_3116, _3110), _424).xy, _3036))) + ((_3133 * _3140) * _39.SampleCmpLevelZero(_27, float3(_3108 + float2(_3109, _3119), _424).xy, _3036))) + ((_3136 * _3140) * _39.SampleCmpLevelZero(_27, float3(_3108 + float2(_3113, _3119), _424).xy, _3036))) + ((_3138 * _3140) * _39.SampleCmpLevelZero(_27, float3(_3108 + float2(_3116, _3119), _424).xy, _3036))) + ((_3133 * _3144) * _39.SampleCmpLevelZero(_27, float3(_3108 + float2(_3109, _3126), _424).xy, _3036))) + ((_3136 * _3144) * _39.SampleCmpLevelZero(_27, float3(_3108 + float2(_3113, _3126), _424).xy, _3036))) + ((_3138 * _3144) * _39.SampleCmpLevelZero(_27, float3(_3108 + float2(_3116, _3126), _424).xy, _3036))), _2944 ? (isnan(_3232) ? _38_m11[_2993].w : (isnan(_38_m11[_2993].w) ? _3232 : min(_38_m11[_2993].w, _3232))) : _38_m11[_2993].w) : 1.0f;
                                }
                                else
                                {
                                    _3240 = clamp(dot(_590, _2779) + 1.0f, 0.0f, 1.0f);
                                }
                                _3241 = _3240;
                            }
                            else
                            {
                                _3241 = 1.0f;
                            }
                            float _3321;
                            float3 _3322;
                            float _3323;
                            float3 _3324;
                            float3 _3325;
                            float _3326;
                            float _3327;
                            [branch]
                            if (_2688 == 0u)
                            {
                                float3 _3247 = _36_m6[_2575].xyz * _2917;
                                float _3248 = _3247.x;
                                float _3249 = _3247.y;
                                float _3250 = _3247.z;
                                float _3251 = isnan(_3249) ? _3248 : (isnan(_3248) ? _3249 : max(_3248, _3249));
                                float _3253 = (isnan(_3250) ? _3251 : (isnan(_3251) ? _3250 : max(_3251, _3250))) * lerp(0.75f, 0.5f, _2435);
                                float3 _3260 = _2277.xyz;
                                _3321 = _2917;
                                _3322 = (_36_m6[_2575].xyz * ((1.0f - _36_m6[_2587].y) + ((1.0f / (isnan(_3253) ? 1.0f : (isnan(1.0f) ? _3253 : max(1.0f, _3253)))) * _36_m6[_2587].y))) * lerp(0.25f * _36_m6[_2587].x, 1.0f, clamp(_2937 + 0.5f, 0.0f, 1.0f));
                                _3323 = _2938;
                                _3324 = _3260;
                                _3325 = _3260;
                                _3326 = 1.0f;
                                _3327 = 0.0f;
                            }
                            else
                            {
                                float _3315;
                                float _3316;
                                float3 _3317;
                                float3 _3318;
                                float _3319;
                                float _3320;
                                if (_2688 == 3u)
                                {
                                    _3315 = _2917 * (smoothstep(lerp(0.800000011920928955078125f, 0.20000000298023223876953125f, _36_m6[_2587].x), lerp(0.89999997615814208984375f, 0.5f, _36_m6[_2587].x), _2401) * _3241);
                                    _3316 = clamp(dot(_2063, -normalize(cross(_623, cross(_623, _2779)))), 0.0f, 1.0f);
                                    _3317 = lerp(0.5f.xxx, _2071, _36_m6[_2587].y.xxx);
                                    _3318 = 0.0f.xxx;
                                    _3319 = 1.0f;
                                    _3320 = 0.0f;
                                }
                                else
                                {
                                    bool _3285 = _2688 == 1u;
                                    float _3309;
                                    float3 _3310;
                                    float _3311;
                                    float _3312;
                                    if (_3285)
                                    {
                                        _3309 = clamp(clamp(_2937 + _36_m6[_2587].x, -1.0f, 1.0f), 0.0f, 1.0f) * _3241;
                                        _3310 = _2075 * _36_m6[_2587].y;
                                        _3311 = 1.0f;
                                        _3312 = 0.0f;
                                    }
                                    else
                                    {
                                        bool _3295 = _2688 == 2u;
                                        float _3307;
                                        if (_3295)
                                        {
                                            _3307 = smoothstep(_36_m6[_2587].x + 0.0500000007450580596923828125f, _36_m6[_2587].x - 0.0500000007450580596923828125f, _2065) * ((1.0f - _36_m6[_2587].z) + (step(0.5f, _2068) * _36_m6[_2587].z));
                                        }
                                        else
                                        {
                                            _3307 = 1.0f;
                                        }
                                        _3309 = _2938;
                                        _3310 = 0.0f.xxx;
                                        _3311 = _3307;
                                        _3312 = _3295 ? _36_m6[_2587].y : 0.0f;
                                    }
                                    bool3 _3313 = _3285.xxx;
                                    _3315 = _2917;
                                    _3316 = _3309;
                                    _3317 = float3(_3313.x ? _2071.x : 0.0f.xxx.x, _3313.y ? _2071.y : 0.0f.xxx.y, _3313.z ? _2071.z : 0.0f.xxx.z);
                                    _3318 = _3310;
                                    _3319 = _3311;
                                    _3320 = _3312;
                                }
                                _3321 = _3315;
                                _3322 = _36_m6[_2575].xyz;
                                _3323 = _3316;
                                _3324 = _3317;
                                _3325 = _3318;
                                _3326 = _3319;
                                _3327 = _3320;
                            }
                            float3 _3355;
                            [branch]
                            if (_2688 != 3u)
                            {
                                float _3332 = lerp(_2077, 0.00999999977648258209228515625f, _3327);
                                float _3335 = dot(_1885, normalize(_2779 + _463));
                                float _3336 = _3332 * _3332;
                                float _3340 = (((_3335 * _3336) - _3335) * _3335) + 1.0f;
                                float _3341 = _3340 * _3340;
                                _3355 = ((_2336 * clamp((((_3336 != _3341) ? (_3336 / _3341) : 1.0f) * (0.5f / ((_2313 + (_3332 * _2315)) + 9.9999997473787516355514526367188e-05f))) - 6.103515625e-05f, 0.0f, 20.0f)) * _3326) * _36_m6[_2596].z;
                            }
                            else
                            {
                                _3355 = 0.0f.xxx;
                            }
                            float3 _3358 = _3322 * _3321;
                            _3365 = _2539 + (((_3358 * lerp(_3325, _3324, _3323.xxx)) * _2351) + ((_3358 * _3355) * _3323));
                        }
                        else
                        {
                            _3365 = _2539;
                        }
                        _3366 = _3365;
                        break;
                    } while(false);
                    _3367 = _3366;
                    break;
                } while(false);
                _3368 = _3367;
            }
            else
            {
                _3368 = _2539;
            }
            _2562 = _3368;
        }
    }
    float3 _3408;
    [branch]
    if (_49_m12 > 0.5f)
    {
        _3408 = lerp(lerp(0.5f.xxx, lerp(dot(_2538, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, _2538, _49_m14.xxx), _49_m15.xxx) * _49_m13, _49_m26.xyz, _49_m26.w.xxx) + ((_49_m27.xyz * smoothstep(1.0f - _49_m16, 1.0f, 1.0f - clamp(_2399, 0.0f, 1.0f))) * _49_m17);
    }
    else
    {
        _3408 = _2538;
    }
    float4 _3420 = float4(_3408 * _19_m20.y, _510);
    _3420.w = (_49_m8 == 1.0f) ? _510 : 1.0f;
    float4 _3802;
    [branch]
    if (_19_m91.w < 0.5f)
    {
        float _3434 = (_464 * _19_m44.w) - _19_m43.w;
        float _3439 = _655 * _19_m46.w;
        float _3443 = _3439 + _19_m47.w;
        float _3444 = isnan(_3443) ? 0.00999999977648258209228515625f : (isnan(0.00999999977648258209228515625f) ? _3443 : max(0.00999999977648258209228515625f, _3443));
        float3 _3458 = exp(_19_m45.xyz * ((-(isnan(_3434) ? 0.0f : (isnan(0.0f) ? _3434 : max(0.0f, _3434)))) * (((1.0f - exp(-_3444)) / _3444) * exp(_3439 + _19_m48.w))));
        float _3461 = dot(_2491, _19_m44.xyz);
        float _3467 = _19_m45.w * _19_m45.w;
        float _3471 = (1.0f + _3467) - ((2.0f * _19_m45.w) * _3461);
        float _3475 = (12.56637096405029296875f * _3471) * sqrt(_3471);
        float3 _3794;
        float _3795;
        if (_19_m55.z > 0.0f)
        {
            uint3 _3516 = (uint3(int3(_2142, _2143, int(_19_m19 & 7u))) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _3517 = _3516.y;
            uint _3518 = _3516.z;
            uint _3521 = _3516.x + (_3517 * _3518);
            uint _3523 = _3517 + (_3518 * _3521);
            uint _3525 = _3518 + (_3521 * _3523);
            uint _3527 = _3521 + (_3523 * _3525);
            float _3552 = dot(_2491, -_17_m0[2].xyz);
            float3 _3559 = _583 - _17_m11.xyz;
            float _3561 = (_19_m55.w * ((_3552 > 5.9604644775390625e-08f) ? (1.0f / _3552) : 0.0f)) * (1.0f / _464);
            float _3562 = _3559.y;
            float _3563 = _3561 * _3562;
            float _3565 = _17_m11.y + _3563;
            float _3566 = _3562 - _3563;
            float _3568 = (1.0f - _3561) * _464;
            float _3574 = _19_m49.z * (_3565 - _19_m49.x);
            float _3581 = _19_m49.z * _3566;
            float _3582 = isnan(_3581) ? (-127.0f) : (isnan(-127.0f) ? _3581 : max(-127.0f, _3581));
            float _3598 = _19_m52.x * (_3565 - _19_m52.z);
            float _3605 = _19_m52.x * _3566;
            float _3606 = isnan(_3605) ? (-127.0f) : (isnan(-127.0f) ? _3605 : max(-127.0f, _3605));
            float _3617 = ((_19_m49.y * exp2(-(isnan(_3574) ? (-127.0f) : (isnan(-127.0f) ? _3574 : max(-127.0f, _3574))))) * ((abs(_3582) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-_3582)) / _3582) : (0.693147182464599609375f - (0.2402265071868896484375f * _3582)))) + ((_19_m52.y * exp2(-(isnan(_3598) ? (-127.0f) : (isnan(-127.0f) ? _3598 : max(-127.0f, _3598))))) * ((abs(_3606) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-_3606)) / _3606) : (0.693147182464599609375f - (0.2402265071868896484375f * _3606))));
            float _3621 = clamp(exp2(-(_3617 * _3568)), 0.0f, 1.0f);
            float _3639 = clamp((_464 * _19_m50.w) + _19_m50.z, 0.0f, 1.0f);
            float _3642 = clamp(((isnan(_19_m51.w) ? _3621 : (isnan(_3621) ? _19_m51.w : max(_3621, _19_m51.w))) + clamp((_464 * _19_m50.y) + _19_m50.x, 0.0f, 1.0f)) + _3639, 0.0f, 1.0f);
            float _3661 = _3568 - _19_m53.w;
            float4 _3682 = lerp(float4(0.0f, 0.0f, 0.0f, 1.0f), _68.SampleLevel(_25, float3((_2513 + ((((float3(uint3(_3527, _3523 + (_3525 * _3527), _429) >> uint3(16u, 16u, 16u)) * 1.525902189314365386962890625e-05f.xxx) * 2.0f) - 1.0f.xxx) * _19_m59.w).xy) * _19_m57.xy, (log2((_444 * _19_m56.x) + _19_m56.y) * _19_m56.z) / _19_m55.z), 0.0f), clamp((_444 - _19_m58.z) * 1000000.0f, 0.0f, 1.0f).xxxx);
            float _3684 = _3682.w;
            _3794 = _3682.xyz + (((_19_m51.xyz * (1.0f - _3642)) + (((_19_m54.xyz * pow(clamp(dot(_463, _19_m53.xyz), 0.0f, 1.0f), _19_m54.w)) * (1.0f - clamp(exp2(-(_3617 * (isnan(0.0f) ? _3661 : (isnan(_3661) ? 0.0f : max(_3661, 0.0f))))), 0.0f, 1.0f))) * (1.0f - _3639))) * _3684);
            _3795 = _3684 * _3642;
        }
        else
        {
            float3 _3688 = _583 - _17_m11.xyz;
            float _3690 = _3688.y;
            float _3696 = _19_m49.z * (_17_m11.y - _19_m49.x);
            float _3703 = _19_m49.z * _3690;
            float _3704 = isnan(_3703) ? (-127.0f) : (isnan(-127.0f) ? _3703 : max(-127.0f, _3703));
            float _3720 = _19_m52.x * (_17_m11.y - _19_m52.z);
            float _3727 = _19_m52.x * _3690;
            float _3728 = isnan(_3727) ? (-127.0f) : (isnan(-127.0f) ? _3727 : max(-127.0f, _3727));
            float _3739 = ((_19_m49.y * exp2(-(isnan(_3696) ? (-127.0f) : (isnan(-127.0f) ? _3696 : max(-127.0f, _3696))))) * ((abs(_3704) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-_3704)) / _3704) : (0.693147182464599609375f - (0.2402265071868896484375f * _3704)))) + ((_19_m52.y * exp2(-(isnan(_3720) ? (-127.0f) : (isnan(-127.0f) ? _3720 : max(-127.0f, _3720))))) * ((abs(_3728) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-_3728)) / _3728) : (0.693147182464599609375f - (0.2402265071868896484375f * _3728))));
            float _3743 = clamp(exp2(-(_3739 * _464)), 0.0f, 1.0f);
            float _3761 = clamp((_464 * _19_m50.w) + _19_m50.z, 0.0f, 1.0f);
            float _3764 = clamp(((isnan(_19_m51.w) ? _3743 : (isnan(_3743) ? _19_m51.w : max(_3743, _19_m51.w))) + clamp((_464 * _19_m50.y) + _19_m50.x, 0.0f, 1.0f)) + _3761, 0.0f, 1.0f);
            float _3783 = _464 - _19_m53.w;
            _3794 = (_19_m51.xyz * (1.0f - _3764)) + (((_19_m54.xyz * pow(clamp(dot(_463, _19_m53.xyz), 0.0f, 1.0f), _19_m54.w)) * (1.0f - clamp(exp2(-(_3739 * (isnan(0.0f) ? _3783 : (isnan(_3783) ? 0.0f : max(_3783, 0.0f))))), 0.0f, 1.0f))) * (1.0f - _3761));
            _3795 = _3764;
        }
        float3 _3800 = (_3420.xyz * (_3458 * _3795)) + ((((clamp(((_19_m46.xyz * (0.0596831031143665313720703125f * (1.0f + (_3461 * _3461)))) + _19_m48.xyz) + (_19_m47.xyz * ((1.0f - _3467) / (isnan(0.001000000047497451305389404296875f) ? _3475 : (isnan(_3475) ? 0.001000000047497451305389404296875f : max(_3475, 0.001000000047497451305389404296875f))))), 0.0f.xxx, 1.0f.xxx) * 255.0f) * (1.0f.xxx - _3458)) * _3795) + _3794);
        _3802 = float4(_3800.x, _3800.y, _3800.z, _3420.w);
    }
    else
    {
        _3802 = _3420;
    }
    _14 = _3802;
    _15 = _2109;
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
    _12 = stage_input._12;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output._14 = _14;
    stage_output._15 = _15;
    return stage_output;
}
