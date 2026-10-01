// Current camera AO is command-buffer scoped, not mutable shared-material state.
Texture2D<float4> _EID4812DrawAO;
float _EID4812UseDrawAO;
float _EID4812AOAudit;
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

static const int2 _358[6] = { int2(2, 1), int2(2, 1), int2(0, 2), int2(0, 2), int2(0, 1), int2(0, 1) };
static const float2 _359[6] = { float2(-1.0f, 1.0f), 1.0f.xx, float2(1.0f, -1.0f), 1.0f.xx, 1.0f.xx, float2(-1.0f, 1.0f) };

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

ByteAddressBuffer _32 : register(t51);
ByteAddressBuffer _34 : register(t18);
cbuffer _35_36 : register(b48)
{
    int _36_m0 : packoffset(c0);
    int _36_m1 : packoffset(c0.y);
    int _36_m2 : packoffset(c0.z);
    int _36_m3 : packoffset(c0.w);
    float _36_m4 : packoffset(c1);
    float _36_m5 : packoffset(c1.y);
    float _36_m6 : packoffset(c1.z);
    float _36_m7 : packoffset(c1.w);
    float _36_m8 : packoffset(c2);
    float _36_m9 : packoffset(c2.y);
    float _36_m10 : packoffset(c2.z);
    float _36_m11 : packoffset(c2.w);
};

cbuffer _37_38 : register(b14)
{
    float4 _38_m0 : packoffset(c0);
    float4 _38_m1 : packoffset(c1);
    float4 _38_m2 : packoffset(c2);
    float4 _38_m3 : packoffset(c3);
    float4 _38_m4 : packoffset(c4);
    uint4 _38_m5 : packoffset(c5);
    float4 _38_m6[2048] : packoffset(c6);
};

cbuffer _39_40 : register(b15)
{
    column_major float4x4 _40_m0[5] : packoffset(c0);
    float4 _40_m1[4] : packoffset(c20);
    float4 _40_m2[4] : packoffset(c24);
    float4 _40_m3[4] : packoffset(c28);
    float4 _40_m4 : packoffset(c32);
    float4 _40_m5 : packoffset(c33);
    float4 _40_m6 : packoffset(c34);
    float4 _40_m7 : packoffset(c35);
    float4 _40_m8 : packoffset(c36);
    float4 _40_m9[27] : packoffset(c37);
    column_major float4x4 _40_m10[56] : packoffset(c64);
    float4 _40_m11[56] : packoffset(c288);
    float4 _40_m12[56] : packoffset(c344);
    float4 _40_m13 : packoffset(c400);
    float4 _40_m14[47] : packoffset(c401);
    column_major float4x4 _40_m15[15] : packoffset(c448);
    float4 _40_m16[15] : packoffset(c508);
    float4 _40_m17[15] : packoffset(c523);
    float4 _40_m18[15] : packoffset(c538);
    float4 _40_m19 : packoffset(c553);
    float4 _40_m20 : packoffset(c554);
    float4 _40_m21[21] : packoffset(c555);
    column_major float4x4 _40_m22 : packoffset(c576);
    column_major float4x4 _40_m23 : packoffset(c580);
    float4 _40_m24 : packoffset(c584);
    float4 _40_m25 : packoffset(c585);
    float4 _40_m26 : packoffset(c586);
    float4 _40_m27[128] : packoffset(c587);
};

cbuffer _50_51 : register(b42)
{
    float _51_m0 : packoffset(c0);
    float _51_m1 : packoffset(c0.y);
    float _51_m2 : packoffset(c0.z);
    float _51_m3 : packoffset(c0.w);
    float _51_m4 : packoffset(c1);
    float _51_m5 : packoffset(c1.y);
    float _51_m6 : packoffset(c1.z);
    float _51_m7 : packoffset(c1.w);
    float _51_m8 : packoffset(c2);
    float _51_m9 : packoffset(c2.y);
    float _51_m10 : packoffset(c2.z);
    float _51_m11 : packoffset(c2.w);
    float _51_m12 : packoffset(c3);
    float _51_m13 : packoffset(c3.y);
    float _51_m14 : packoffset(c3.z);
    float _51_m15 : packoffset(c3.w);
    float _51_m16 : packoffset(c4);
    float _51_m17 : packoffset(c4.y);
    float _51_m18 : packoffset(c4.z);
    float _51_m19 : packoffset(c4.w);
    float _51_m20 : packoffset(c5);
    float _51_m21 : packoffset(c5.y);
    float _51_m22 : packoffset(c5.z);
    float _51_m23 : packoffset(c5.w);
    float4 _51_m24 : packoffset(c6);
    float4 _51_m25 : packoffset(c7);
    float4 _51_m26 : packoffset(c8);
    float4 _51_m27 : packoffset(c9);
    float4 _51_m28 : packoffset(c10);
    float4 _51_m29 : packoffset(c11);
    float _51_m30 : packoffset(c12);
    float _51_m31 : packoffset(c12.y);
    float _51_m32 : packoffset(c12.z);
    float _51_m33 : packoffset(c12.w);
    float _51_m34 : packoffset(c13);
    float _51_m35 : packoffset(c13.y);
    float _51_m36 : packoffset(c13.z);
    float _51_m37 : packoffset(c13.w);
    float _51_m38 : packoffset(c14);
    float _51_m39 : packoffset(c14.y);
    float _51_m40 : packoffset(c14.z);
    float _51_m41 : packoffset(c14.w);
    float4 _51_m42 : packoffset(c15);
    float _51_m43 : packoffset(c16);
    float _51_m44 : packoffset(c16.y);
    float _51_m45 : packoffset(c16.z);
    float _51_m46 : packoffset(c16.w);
    float _51_m47 : packoffset(c17);
    float _51_m48 : packoffset(c17.y);
    float _51_m49 : packoffset(c17.z);
    float _51_m50 : packoffset(c17.w);
    float4 _51_m51 : packoffset(c18);
    float _51_m52 : packoffset(c19);
    float _51_m53 : packoffset(c19.y);
    float _51_m54 : packoffset(c19.z);
    float _51_m55 : packoffset(c19.w);
    float4 _51_m56 : packoffset(c20);
    float4 _51_m57 : packoffset(c21);
    float4 _51_m58 : packoffset(c22);
    float4 _51_m59 : packoffset(c23);
    float4 _51_m60 : packoffset(c24);
    float4 _51_m61 : packoffset(c25);
    float _51_m62 : packoffset(c26);
    float _51_m63 : packoffset(c26.y);
    float _51_m64 : packoffset(c26.z);
    float _51_m65 : packoffset(c26.w);
    float _51_m66 : packoffset(c27);
    float _51_m67 : packoffset(c27.y);
    float _51_m68 : packoffset(c27.z);
    float _51_m69 : packoffset(c27.w);
};

cbuffer _60_61 : register(b50)
{
    float4 _61_m0[32] : packoffset(c0);
    column_major float4x4 _61_m1[32] : packoffset(c32);
};

SamplerState eid4812_point_clamp_sampler25 : register(s3);
SamplerState eid4812_linear_clamp_sampler26 : register(s6);
SamplerState eid4812_linear_repeat_sampler27 : register(s4);
SamplerComparisonState eid4812_linear_clamp_compare_sampler28 : register(s7);
Texture2D<float4> _30 : register(t46);
Texture2D<float4> _41 : register(t27);
Texture2D<float4> _42 : register(t22);
Texture3D<float4> _44 : register(t35);
Texture3D<float4> _45 : register(t32);
Texture3D<float4> _46 : register(t34);
Texture3D<float4> _47 : register(t31);
Texture3D<float4> _48 : register(t33);
Texture3D<float4> _49 : register(t30);
Texture2D<float4> _52 : register(t4);
Texture2D<float4> _53 : register(t5);
Texture2D<float4> _54 : register(t2);
Texture2D<float4> _55 : register(t39);
Texture2D<float4> _56 : register(t6);
Texture2D<float4> _57 : register(t3);
Texture2D<float4> _58 : register(t1);
Texture2D<float4> _59 : register(t29);
Texture3D<float4> _64 : register(t36);

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

static float3 _381;
static float _382;
static float3 _383;
static float _387;
static uint _388;

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
    float _404 = 1.0f / gl_FragCoord.w;
    float3 _419 = lerp(-_4, float3(_18_m0[2u].x, _18_m0[2u].y, _18_m0[2u].z), _20_m4.w.xxx);
    float _420 = dot(_419, _419);
    float _422 = rsqrt(isnan(9.9999999392252902907785028219223e-09f) ? _420 : (isnan(_420) ? 9.9999999392252902907785028219223e-09f : max(_420, 9.9999999392252902907785028219223e-09f)));
    float3 _423 = _419 * _422;
    float _424 = _420 * _422;
    uint _427 = asuint(_23_m0[_13]._m2.x);
    bool _432 = (asuint(_23_m0[_13]._m1.w) & 16u) != 0u;
    float4 _449;
    float4 _450;
    float4 _451;
    if (_432)
    {
        _449 = asfloat(_34.Load4((_427 + 2u) * 16 + 0));
        _450 = asfloat(_34.Load4((_427 + 1u) * 16 + 0));
        _451 = asfloat(_34.Load4(_427 * 16 + 0));
    }
    else
    {
        _449 = _23_m0[_13]._m0[2];
        _450 = _23_m0[_13]._m0[1];
        _451 = _23_m0[_13]._m0[0];
    }
    float4 _457 = _56.SampleBias(eid4812_linear_repeat_sampler27, _3, _20_m16);
    float3 _462 = _457.xyz * _51_m24.xyz;
    float4 _466 = _57.SampleBias(eid4812_linear_repeat_sampler27, _3, _20_m16);
    float _467 = _466.x;
    float _468 = _466.y;
    float _469 = _466.z;
    float _473 = _457.w * _51_m24.w;
    float3 _491 = _462 * _51_m18;
    float3 _495 = lerp(dot(_491, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, _491, _51_m19.xxx);
    float4 _499 = _58.SampleBias(eid4812_linear_repeat_sampler27, _3, _20_m16);
    float2 _504 = (_499.xy * 2.0f) - 1.0f.xx;
    float2 _506 = _504.xy;
    float _510 = sqrt(1.0f - clamp(dot(_506, _506), 0.0f, 1.0f));
    float3 _512 = float3(_504.x, _504.y, _383.z);
    _512.z = isnan(_510) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? _510 : max(1.000000016862383526387164645044e-16f, _510));
    float2 _514 = _512.xy * _51_m3;
    float4 _525 = _52.Sample(eid4812_linear_repeat_sampler27, (_3 * _51_m51.xy) + _51_m51.zw);
    float3 _530 = _4 + _18_m11.xyz;
    float3 _535 = _530 - float3(_451.w, _387, _449.w);
    _535.y = 6.103515625e-05f;
    float3 _537 = normalize(_535);
    float3 _543 = _6.xyz * 1.0f;
    float3 _544 = (cross(_5, _6.xyz) * _6.w) * 1.0f;
    float3 _545 = _5 * 1.0f;
    float3x3 _546 = float3x3(_543, _544, _545);
    float3 _547 = mul(float3(_514.x, _514.y, _512.z), _546);
    float _548 = dot(_547, _547);
    float _556 = gl_FrontFacing ? 1.0f : ((-1.0f) + (2.0f * _51_m5));
    float3 _557 = (_547 * rsqrt(isnan(_548) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? _548 : max(1.1754943508222875079687365372222e-38f, _548)))) * _556;
    float3 _558 = normalize(_5) * _556;
    float2 _563 = (_499.zw * 2.0f) - 1.0f.xx;
    float2 _565 = _563.xy;
    float _569 = sqrt(1.0f - clamp(dot(_565, _565), 0.0f, 1.0f));
    float3 _571 = float3(_563.x, _563.y, _383.z);
    _571.z = isnan(_569) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? _569 : max(1.000000016862383526387164645044e-16f, _569));
    float2 _573 = _571.xy * _51_m31;
    float3 _576 = normalize(mul(float3(_573.x, _573.y, _571.z), _546));
    float3x3 _583 = float3x3(_451.xyz, _450.xyz, _449.xyz);
    float3 _584 = mul(_583, float3(_51_m39, 1.0f, 0.0f));
    float _585 = dot(_584, _584);
    float3 _596 = cross(_576, lerp(cross(_576, (_584 * rsqrt(isnan(_585) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? _585 : max(1.1754943508222875079687365372222e-38f, _585)))).xyz), _6.xyz, _467.xxx).xyz) * lerp(1.0f, _6.w, _467);
    float3 _598 = mul(_423, _583);
    float _607 = pow(clamp(dot(normalize(mul(_576, _583).xz), normalize(_598.xz)), 0.0f, 1.0f), _51_m37);
    float2 _612 = gl_FragCoord.xy * _20_m0.zw;
    uint2 _613 = uint2(gl_FragCoord.xy);
    float3 _623 = mul(float3x3(_18_m1[0].xyz, _18_m1[1].xyz, _18_m1[2].xyz), float3(0.0f, 0.0f, 1.0f));
    uint _632 = asuint((_20_m89.x > 0.5f) ? _20_m89.y : _23_m0[_13]._m7.x);
    float4 _645 = float4(float(_632 & 255u), float((_632 >> 8u) & 255u), float((_632 >> 16u) & 255u), float((_632 >> 24u) & 255u)) * 0.0039215688593685626983642578125f.xxxx;
    float _646 = _645.x;
    float _648 = _645.z;
    float _649 = _645.w;
    float _655 = _530.y;
    float _658 = smoothstep(-0.20000000298023223876953125f, 0.1500000059604644775390625f, lerp(_23_m0[_13]._m7.y, _20_m89.w, _20_m89.x) - _655) * _645.y;
    float _659 = isnan(_658) ? _648 : (isnan(_648) ? _658 : max(_648, _658));
    float _660 = isnan(_659) ? _646 : (isnan(_646) ? _659 : max(_646, _659));
    float _668 = lerp(_20_m22.x, 1.0f, _20_m91.w) * _20_m20.x;
    float4 _1162;
    float3 _1163;
    float3 _1164;
    float _1165;
    if (_20_m80.y < 0.5f)
    {
        float3 _686 = _530 - (_20_m105.xyz + (_623 * (-_20_m107.w)));
        float _688 = abs(_686.x);
        float _690 = abs(_686.z);
        float _696 = clamp(((isnan(_690) ? _688 : (isnan(_688) ? _690 : max(_688, _690))) - 464.0f) * 0.03125f, 0.0f, 1.0f);
        float _699 = clamp((abs(_686.y) - 208.0f) * 0.03125f, 0.0f, 1.0f);
        float _700 = isnan(_699) ? _696 : (isnan(_696) ? _699 : max(_696, _699));
        float4 _1002;
        float4 _1003;
        float4 _1004;
        float _1005;
        float _1006;
        if ((_20_m105.w != 0.0f) && (_700 < 1.0f))
        {
            float3 _713 = _530 - (_20_m105.xyz + (_623 * (-_20_m107.y)));
            float _715 = abs(_713.x);
            float _717 = abs(_713.z);
            float _723 = clamp(((isnan(_717) ? _715 : (isnan(_715) ? _717 : max(_715, _717))) - 29.0f) * 0.5f, 0.0f, 1.0f);
            float _726 = clamp((abs(_713.y) - 13.0f) * 0.5f, 0.0f, 1.0f);
            float _727 = isnan(_726) ? _723 : (isnan(_723) ? _726 : max(_723, _726));
            float _803;
            float4 _804;
            float4 _805;
            float4 _806;
            if (_727 < 1.0f)
            {
                float3 _736 = ((_530 * 2.0f) + 0.5f.xxx) * _20_m106.xyz;
                float3 _738 = _736 - floor(_736);
                float4 _742 = _44.SampleLevel(eid4812_linear_repeat_sampler27, _738, 0.0f);
                float _743 = 1.0f - _727;
                float _747 = _20_m106.y * 0.5f;
                float _752 = _738.x;
                float _753 = clamp(_738.y, _747, 1.0f - _747) * 0.3333333432674407958984375f;
                float _754 = _738.z;
                float4 _757 = _45.SampleLevel(eid4812_linear_clamp_sampler26, float3(_752, _753, _754), 0.0f);
                float _773 = _742.x;
                float _783 = _742.y;
                float _793 = _742.z;
                _803 = _700 + (_757.w * _743);
                _804 = float4(((_45.SampleLevel(eid4812_linear_clamp_sampler26, float3(_752, _753 + 0.666666686534881591796875f, _754), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _793, _793) * _743;
                _805 = float4(((_45.SampleLevel(eid4812_linear_clamp_sampler26, float3(_752, _753 + 0.3333333432674407958984375f, _754), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _783, _783) * _743;
                _806 = float4(((_757.xyz * 4.0f) - 2.0f.xxx) * _773, _773) * _743;
            }
            else
            {
                _803 = _700;
                _804 = 0.0f.xxxx;
                _805 = 0.0f.xxxx;
                _806 = 0.0f.xxxx;
            }
            float3 _812 = _530 - (_20_m105.xyz + (_623 * (-_20_m107.z)));
            float _814 = abs(_812.x);
            float _816 = abs(_812.z);
            float _822 = clamp(((isnan(_816) ? _814 : (isnan(_814) ? _816 : max(_814, _816))) - 116.0f) * 0.125f, 0.0f, 1.0f);
            float _825 = clamp((abs(_812.y) - 52.0f) * 0.125f, 0.0f, 1.0f);
            float _826 = isnan(_825) ? _822 : (isnan(_822) ? _825 : max(_822, _825));
            float _906;
            float4 _907;
            float4 _908;
            float4 _909;
            if (_826 < 1.0f)
            {
                float3 _835 = ((_530 * 0.5f) + 0.5f.xxx) * _20_m106.xyz;
                float3 _837 = _835 - floor(_835);
                float4 _841 = _46.SampleLevel(eid4812_linear_repeat_sampler27, _837, 0.0f);
                float _843 = _727 * (1.0f - _826);
                float _847 = _20_m106.y * 0.5f;
                float _852 = _837.x;
                float _853 = clamp(_837.y, _847, 1.0f - _847) * 0.3333333432674407958984375f;
                float _854 = _837.z;
                float4 _857 = _47.SampleLevel(eid4812_linear_clamp_sampler26, float3(_852, _853, _854), 0.0f);
                float _873 = _841.x;
                float _884 = _841.y;
                float _895 = _841.z;
                _906 = _803 + (_857.w * _843);
                _907 = _804 + (float4(((_47.SampleLevel(eid4812_linear_clamp_sampler26, float3(_852, _853 + 0.666666686534881591796875f, _854), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _895, _895) * _843);
                _908 = _805 + (float4(((_47.SampleLevel(eid4812_linear_clamp_sampler26, float3(_852, _853 + 0.3333333432674407958984375f, _854), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _884, _884) * _843);
                _909 = _806 + (float4(((_857.xyz * 4.0f) - 2.0f.xxx) * _873, _873) * _843);
            }
            else
            {
                _906 = _803;
                _907 = _804;
                _908 = _805;
                _909 = _806;
            }
            float4 _992;
            float4 _993;
            float4 _994;
            float _995;
            if (_826 > 0.0f)
            {
                float3 _918 = ((_530 * 0.125f) + 0.5f.xxx) * _20_m106.xyz;
                float3 _921 = _20_m106.xyz * 0.5f;
                float3 _923 = clamp(_918 - floor(_918), _921, 1.0f.xxx - _921);
                float4 _927 = _48.SampleLevel(eid4812_linear_repeat_sampler27, _923, 0.0f);
                float _929 = _826 * (1.0f - _700);
                float _933 = _20_m106.y * 0.5f;
                float _938 = _923.x;
                float _939 = clamp(_923.y, _933, 1.0f - _933) * 0.3333333432674407958984375f;
                float _940 = _923.z;
                float4 _943 = _49.SampleLevel(eid4812_linear_clamp_sampler26, float3(_938, _939, _940), 0.0f);
                float _959 = _927.x;
                float _970 = _927.y;
                float _981 = _927.z;
                _992 = _907 + (float4(((_49.SampleLevel(eid4812_linear_clamp_sampler26, float3(_938, _939 + 0.666666686534881591796875f, _940), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _981, _981) * _929);
                _993 = _908 + (float4(((_49.SampleLevel(eid4812_linear_clamp_sampler26, float3(_938, _939 + 0.3333333432674407958984375f, _940), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _970, _970) * _929);
                _994 = _909 + (float4(((_943.xyz * 4.0f) - 2.0f.xxx) * _959, _959) * _929);
                _995 = _906 + (_943.w * _929);
            }
            else
            {
                _992 = _907;
                _993 = _908;
                _994 = _909;
                _995 = _906;
            }
            float _998 = clamp((_995 * 2.0f) - 1.0f, 0.0f, 1.0f);
            _1002 = _992;
            _1003 = _993;
            _1004 = _994;
            _1005 = _998 - _700;
            _1006 = (_998 + _700) * 0.5f;
        }
        else
        {
            _1002 = 0.0f.xxxx;
            _1003 = 0.0f.xxxx;
            _1004 = 0.0f.xxxx;
            _1005 = 0.0f;
            _1006 = 1.0f;
        }
        float4 _1026 = _1004 + float4(_20_m108.x * _1006, (_20_m108.y * _1006) + ((_20_m108.w * _1005) * 0.5f), _20_m108.z * _1006, (_20_m108.w * _1006) + ((_20_m108.y * _1005) * 0.375f));
        float4 _1046 = _1003 + float4(_20_m109.x * _1006, (_20_m109.y * _1006) + ((_20_m109.w * _1005) * 0.5f), _20_m109.z * _1006, (_20_m109.w * _1006) + ((_20_m109.y * _1005) * 0.375f));
        float4 _1066 = _1002 + float4(_20_m110.x * _1006, (_20_m110.y * _1006) + ((_20_m110.w * _1005) * 0.5f), _20_m110.z * _1006, (_20_m110.w * _1006) + ((_20_m110.y * _1005) * 0.375f));
        float4 _1070 = float4(_557, 1.0f);
        float3 _1074 = float3(dot(_1026, _1070), dot(_1046, _1070), dot(_1066, _1070));
        bool3 _3983 = isnan(_1074);
        bool3 _3984 = isnan(0.0f.xxx);
        float3 _3985 = max(_1074, 0.0f.xxx);
        float3 _3986 = float3(_3983.x ? 0.0f.xxx.x : _3985.x, _3983.y ? 0.0f.xxx.y : _3985.y, _3983.z ? 0.0f.xxx.z : _3985.z);
        float3 _1076 = float3(_3984.x ? _1074.x : _3986.x, _3984.y ? _1074.y : _3986.y, _3984.z ? _1074.z : _3986.z) * _668;
        float3 _1084 = ((_1026.xyz * 0.2125999927520751953125f) + (_1046.xyz * 0.715200006961822509765625f)) + (_1066.xyz * 0.072200000286102294921875f);
        float _1085 = dot(_1084, _1084);
        float3 _1088 = _1084 * rsqrt(isnan(_1085) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? _1085 : max(1.1754943508222875079687365372222e-38f, _1085)));
        float _1090 = abs(_1088.y);
        float3 _1091 = _1088;
        _1091.y = _1090;
        float4 _1093 = float4(_1091.x, _1091.y, _1091.z, 0.0f.xxxx.w);
        _1093.w = 1.0f;
        float4 _1096 = float4(_1088.x, _1090, _1088.z, 1.0f);
        float3 _1100 = float3(dot(_1026, _1096), dot(_1046, _1096), dot(_1066, _1096));
        bool3 _3993 = isnan(_1100);
        bool3 _3994 = isnan(0.0f.xxx);
        float3 _3995 = max(_1100, 0.0f.xxx);
        float3 _3996 = float3(_3993.x ? 0.0f.xxx.x : _3995.x, _3993.y ? 0.0f.xxx.y : _3995.y, _3993.z ? 0.0f.xxx.z : _3995.z);
        float3 _1101 = float3(_3994.x ? _1100.x : _3996.x, _3994.y ? _1100.y : _3996.y, _3994.z ? _1100.z : _3996.z);
        float _1102 = _1101.x;
        float _1103 = _1101.y;
        float _1104 = _1101.z;
        float _1105 = isnan(_1103) ? _1102 : (isnan(_1102) ? _1103 : max(_1102, _1103));
        float _1106 = isnan(_1104) ? _1105 : (isnan(_1105) ? _1104 : max(_1105, _1104));
        float _1109 = _1076.z;
        float _1110 = _1076.y;
        float4 _1115 = lerp(float4(_1109, _1110, -1.0f, 0.666666686534881591796875f), float4(_1110, _1109, 0.0f, -0.3333333432674407958984375f), step(_1109, _1110).xxxx);
        float _1116 = _1076.x;
        float _1117 = _1115.x;
        float4 _1125 = lerp(float4(_1117, _1115.yw, _1116), float4(_1116, _1115.yz, _1117), step(_1117, _1116).xxxx);
        float _1126 = _1125.x;
        float _1127 = _1125.w;
        float _1128 = _1125.y;
        float _1130 = _1126 - (isnan(_1128) ? _1127 : (isnan(_1127) ? _1128 : min(_1127, _1128)));
        float _1139 = _1130 / (_1126 + 9.9999997473787516355514526367188e-05f);
        float _1140 = frac(abs(_1125.z + ((_1127 - _1128) / ((6.0f * _1130) + 9.9999997473787516355514526367188e-05f))));
        float _1146 = lerp(0.699999988079071044921875f, 0.3499999940395355224609375f, smoothstep(0.449999988079071044921875f, 0.3499999940395355224609375f, abs(_1140 - 0.5f))) * clamp(_1126, 0.0f, 1.0f);
        float _1147 = isnan(_1146) ? _1139 : (isnan(_1139) ? _1146 : min(_1139, _1146));
        float _1149 = 2.0f / (2.0f - _1147);
        _1162 = _1093;
        _1163 = _1076;
        _1164 = lerp(1.0f.xxx, clamp(abs((frac(float3(_1140, _1147, _1149).xxx + float3(1.0f, 0.666666686534881591796875f, 0.3333333432674407958984375f)) * 6.0f) - 3.0f.xxx) - 1.0f.xxx, 0.0f.xxx, 1.0f.xxx), _1147.xxx) * _1149;
        _1165 = (isnan(0.0f) ? _1106 : (isnan(_1106) ? 0.0f : max(_1106, 0.0f))) * _668;
    }
    else
    {
        _1162 = 0.0f.xxxx;
        _1163 = 1.0f.xxx;
        _1164 = _20_m81.xyz;
        _1165 = _668;
    }
    float3 _1972;
    float _1973;
    float _1974;
    float _1975;
    float _1976;
    float _1977;
    float3 _1978;
    float3 _1979;
    [branch]
    if ((clamp(_646 + _659, 0.0f, 1.0f) - _51_m20) > 0.00999999977648258209228515625f)
    {
        float _1322;
        bool _1323;
        bool _1192 = (step(_646, 0.00999999977648258209228515625f) * step(0.00999999977648258209228515625f, _659)) != 0.0f;
        bool3 _1193 = _432.xxx;
        float3 _1195 = _11.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 _1199 = float3(_1193.x ? _1195.x : _11.x, _1193.y ? _1195.y : _11.y, _1193.z ? _1195.z : _11.z) * _20_m89.z;
        float3 _1209 = float3(0.0f, -1.0f, 0.0f) + (_545 * _545.y);
        float3 _1217 = ((_10.xyz * dot(_1209, _543)) + ((cross(_9, _10.xyz) * _10.w) * dot(_1209, _544))) + (_9 * dot(_1209, _545));
        float3 _1219 = _1217.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 _1220 = float3(_1193.x ? _1219.x : _1217.x, _1193.y ? _1219.y : _1217.y, _1193.z ? _1219.z : _1217.z);
        bool _1221 = !_1192;
        bool2 _1222 = _1221.xx;
        float2 _1224 = (1.0f - _659).xx;
        float2 _1225 = float2(_1222.x ? float2(3.0f, 4.340000152587890625f).x : _1224.x, _1222.y ? float2(3.0f, 4.340000152587890625f).y : _1224.y);
        float _1228 = 1.0f - ((_1192 ? _659 : _646) * 0.64999997615814208984375f);
        float3 _1236 = frac(floor(((_3.xx * _20_m89.z) * 32.0f) * 1.5f).xyx * 0.103100001811981201171875f);
        float3 _1241 = _1236 + dot(_1236, _1236.yzx + 33.3300018310546875f.xxx).xxx;
        float _1258 = lerp(0.60000002384185791015625f, 1.0f, clamp((1.2000000476837158203125f * frac((_1199.y * (-3.0f)) + frac((_1241.x + _1241.y) * _1241.z))) + clamp(_1199.z * 10.0f, 0.0f, 1.0f), 0.0f, 1.0f));
        float _1259 = 1.0f - _660;
        float _1261 = _1259 + (0.800000011920928955078125f * _660);
        float _1264 = _1221 ? _20_m10.x : 1.0f;
        float _1266 = _1264 * _1225.x;
        float _1268 = _1264 * _1225.y;
        float3 _1269 = _1199 * 32.0f;
        float3 _1270 = _1199 * 48.345600128173828125f;
        float3 _1272 = abs(float3(_1193.x ? _9.xzy.x : _9.x, _1193.y ? _9.xzy.y : _9.y, _1193.z ? _9.xzy.z : _9.z)) - 0.20000000298023223876953125f.xxx;
        bool3 _4023 = isnan(_1272);
        bool3 _4024 = isnan(0.0f.xxx);
        float3 _4025 = max(_1272, 0.0f.xxx);
        float3 _4026 = float3(_4023.x ? 0.0f.xxx.x : _4025.x, _4023.y ? 0.0f.xxx.y : _4025.y, _4023.z ? 0.0f.xxx.z : _4025.z);
        float3 _1274 = pow(float3(_4024.x ? _1272.x : _4026.x, _4024.y ? _1272.y : _4026.y, _4024.z ? _1272.z : _4026.z), 10.0f.xxx);
        float _1275 = dot(_1274, 1.0f.xxx);
        float3 _1278 = _1274 / (isnan(6.103515625e-05f) ? _1275 : (isnan(_1275) ? 6.103515625e-05f : max(_1275, 6.103515625e-05f))).xxx;
        float2 _1280 = _1220.xz;
        float _1281 = _1278.y;
        float2 _1282 = _1269.xz * 1.0f;
        float2 _1283 = floor(_1282);
        float2 _1286 = frac(_1283 * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1290 = _1286 + dot(_1286, _1286 + 34.345001220703125f.xx).xx;
        float _1291 = _1290.x;
        float _1292 = _1290.y;
        float2 _1296 = frac(float2(_1291 * _1292, _1291 + _1292));
        float2 _1299 = frac((_1283 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1303 = _1299 + dot(_1299, _1299 + 34.345001220703125f.xx).xx;
        float _1304 = _1303.x;
        float _1305 = _1303.y;
        float2 _1309 = frac(float2(_1304 * _1305, _1304 + _1305));
        float _1315 = _1296.x;
        float _1318 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, _1315)) * _1258;
        float2 _1319 = ((_1282 - _1283) + ((((_1309 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 _1336;
        do
        {
            _1322 = dot(_1280, _1280);
            _1323 = _1322 <= 9.9999997473787516355514526367188e-06f;
            if (_1323)
            {
                _1336 = _1319;
                break;
            }
            float2 _1327 = _1280 * rsqrt(_1322);
            _1336 = float2(dot(_1319, float2(-_1327.y, _1327.x)), -dot(_1319, _1327));
            break;
        } while(false);
        float _1419;
        bool _1420;
        float2 _1343 = float2(_1336.x * 1.25f, _1336.y * ((_1336.y < 0.0f) ? 1.25f : 0.75f));
        float _1344 = length(_1343);
        float _1346 = _1266 + _1315;
        float _1350 = _1221 ? frac(_1346) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(_1346, 0.0f, 1.0f));
        float _1362 = _1296.y;
        float _1365 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, _1350) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, _1350)) * step(0.001000000047497451305389404296875f, smoothstep(_1318, 0.0f, _1344))) * step(_1228, _1362 - 0.100000001490116119384765625f);
        float _1368 = _1365 * _1281;
        float2 _1375 = float2(_1318 * _1365, _1318 - _1344) * _1281;
        float2 _1377 = _1220.xy;
        float _1378 = _1278.z;
        float2 _1379 = _1269.xy * 1.0f;
        float2 _1380 = floor(_1379);
        float2 _1383 = frac(_1380 * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1387 = _1383 + dot(_1383, _1383 + 34.345001220703125f.xx).xx;
        float _1388 = _1387.x;
        float _1389 = _1387.y;
        float2 _1393 = frac(float2(_1388 * _1389, _1388 + _1389));
        float2 _1396 = frac((_1380 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1400 = _1396 + dot(_1396, _1396 + 34.345001220703125f.xx).xx;
        float _1401 = _1400.x;
        float _1402 = _1400.y;
        float2 _1406 = frac(float2(_1401 * _1402, _1401 + _1402));
        float _1412 = _1393.x;
        float _1415 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, _1412)) * _1258;
        float2 _1416 = ((_1379 - _1380) + ((((_1406 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 _1433;
        do
        {
            _1419 = dot(_1377, _1377);
            _1420 = _1419 <= 9.9999997473787516355514526367188e-06f;
            if (_1420)
            {
                _1433 = _1416;
                break;
            }
            float2 _1424 = _1377 * rsqrt(_1419);
            _1433 = float2(dot(_1416, float2(-_1424.y, _1424.x)), -dot(_1416, _1424));
            break;
        } while(false);
        float _1516;
        bool _1517;
        float2 _1440 = float2(_1433.x * 1.25f, _1433.y * ((_1433.y < 0.0f) ? 1.25f : 0.75f));
        float _1441 = length(_1440);
        float _1443 = _1266 + _1412;
        float _1447 = _1221 ? frac(_1443) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(_1443, 0.0f, 1.0f));
        float _1459 = _1393.y;
        float _1462 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, _1447) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, _1447)) * step(0.001000000047497451305389404296875f, smoothstep(_1415, 0.0f, _1441))) * step(_1228, _1459 - 0.100000001490116119384765625f);
        float _1465 = _1462 * _1378;
        float2 _1472 = float2(_1415 * _1462, _1415 - _1441) * _1378;
        float2 _1474 = _1220.zy;
        float _1475 = _1278.x;
        float2 _1476 = _1269.zy * 1.0f;
        float2 _1477 = floor(_1476);
        float2 _1480 = frac(_1477 * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1484 = _1480 + dot(_1480, _1480 + 34.345001220703125f.xx).xx;
        float _1485 = _1484.x;
        float _1486 = _1484.y;
        float2 _1490 = frac(float2(_1485 * _1486, _1485 + _1486));
        float2 _1493 = frac((_1477 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1497 = _1493 + dot(_1493, _1493 + 34.345001220703125f.xx).xx;
        float _1498 = _1497.x;
        float _1499 = _1497.y;
        float2 _1503 = frac(float2(_1498 * _1499, _1498 + _1499));
        float _1509 = _1490.x;
        float _1512 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, _1509)) * _1258;
        float2 _1513 = ((_1476 - _1477) + ((((_1503 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 _1530;
        do
        {
            _1516 = dot(_1474, _1474);
            _1517 = _1516 <= 9.9999997473787516355514526367188e-06f;
            if (_1517)
            {
                _1530 = _1513;
                break;
            }
            float2 _1521 = _1474 * rsqrt(_1516);
            _1530 = float2(dot(_1513, float2(-_1521.y, _1521.x)), -dot(_1513, _1521));
            break;
        } while(false);
        float2 _1537 = float2(_1530.x * 1.25f, _1530.y * ((_1530.y < 0.0f) ? 1.25f : 0.75f));
        float _1538 = length(_1537);
        float _1540 = _1266 + _1509;
        float _1544 = _1221 ? frac(_1540) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(_1540, 0.0f, 1.0f));
        float _1556 = _1490.y;
        float _1559 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, _1544) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, _1544)) * step(0.001000000047497451305389404296875f, smoothstep(_1512, 0.0f, _1538))) * step(_1228, _1556 - 0.100000001490116119384765625f);
        float _1562 = _1559 * _1475;
        float2 _1569 = float2(_1512 * _1559, _1512 - _1538) * _1475;
        bool2 _4033 = isnan(_1472);
        bool2 _4034 = isnan(_1569);
        float2 _4035 = max(_1472, _1569);
        float2 _4036 = float2(_4033.x ? _1569.x : _4035.x, _4033.y ? _1569.y : _4035.y);
        float2 _1570 = float2(_4034.x ? _1472.x : _4036.x, _4034.y ? _1472.y : _4036.y);
        bool2 _4038 = isnan(_1375);
        bool2 _4039 = isnan(_1570);
        float2 _4040 = max(_1375, _1570);
        float2 _4041 = float2(_4038.x ? _1570.x : _4040.x, _4038.y ? _1570.y : _4040.y);
        float2 _1571 = float2(_4039.x ? _1375.x : _4041.x, _4039.y ? _1375.y : _4041.y);
        float _1577 = isnan(_1465) ? _1368 : (isnan(_1368) ? _1465 : max(_1368, _1465));
        float _1578 = isnan(_1577) ? _1562 : (isnan(_1562) ? _1577 : max(_1562, _1577));
        float4 _1581 = float4((float4(((clamp(_1343 / _1318.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, _1309.x)) * _1365) * _1281, _1368, _1362).xy + float4(((clamp(_1440 / _1415.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, _1406.x)) * _1462) * _1378, _1465, _1459).xy) + float4(((clamp(_1537 / _1512.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, _1503.x)) * _1559) * _1475, _1562, _1556).xy, _1578, 0.0f);
        float2 _1583 = _1270.xz * 1.0f;
        float2 _1584 = floor(_1583);
        float2 _1587 = frac(_1584 * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1591 = _1587 + dot(_1587, _1587 + 34.345001220703125f.xx).xx;
        float _1592 = _1591.x;
        float _1593 = _1591.y;
        float2 _1597 = frac(float2(_1592 * _1593, _1592 + _1593));
        float2 _1600 = frac((_1584 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1604 = _1600 + dot(_1600, _1600 + 34.345001220703125f.xx).xx;
        float _1605 = _1604.x;
        float _1606 = _1604.y;
        float2 _1610 = frac(float2(_1605 * _1606, _1605 + _1606));
        float _1616 = _1597.x;
        float _1619 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, _1616)) * _1258;
        float2 _1620 = ((_1583 - _1584) + ((((_1610 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 _1635;
        do
        {
            if (_1323)
            {
                _1635 = _1620;
                break;
            }
            float2 _1626 = _1280 * rsqrt(_1322);
            _1635 = float2(dot(_1620, float2(-_1626.y, _1626.x)), -dot(_1620, _1626));
            break;
        } while(false);
        float2 _1642 = float2(_1635.x * 1.25f, _1635.y * ((_1635.y < 0.0f) ? 1.25f : 0.75f));
        float _1643 = length(_1642);
        float _1645 = _1268 + _1616;
        float _1649 = _1221 ? frac(_1645) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(_1645, 0.0f, 1.0f));
        float _1661 = _1597.y;
        float _1664 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, _1649) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, _1649)) * step(0.001000000047497451305389404296875f, smoothstep(_1619, 0.0f, _1643))) * step(_1228, _1661 - 0.100000001490116119384765625f);
        float _1667 = _1664 * _1281;
        float2 _1674 = float2(_1619 * _1664, _1619 - _1643) * _1281;
        float2 _1676 = _1270.xy * 1.0f;
        float2 _1677 = floor(_1676);
        float2 _1680 = frac(_1677 * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1684 = _1680 + dot(_1680, _1680 + 34.345001220703125f.xx).xx;
        float _1685 = _1684.x;
        float _1686 = _1684.y;
        float2 _1690 = frac(float2(_1685 * _1686, _1685 + _1686));
        float2 _1693 = frac((_1677 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1697 = _1693 + dot(_1693, _1693 + 34.345001220703125f.xx).xx;
        float _1698 = _1697.x;
        float _1699 = _1697.y;
        float2 _1703 = frac(float2(_1698 * _1699, _1698 + _1699));
        float _1709 = _1690.x;
        float _1712 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, _1709)) * _1258;
        float2 _1713 = ((_1676 - _1677) + ((((_1703 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 _1728;
        do
        {
            if (_1420)
            {
                _1728 = _1713;
                break;
            }
            float2 _1719 = _1377 * rsqrt(_1419);
            _1728 = float2(dot(_1713, float2(-_1719.y, _1719.x)), -dot(_1713, _1719));
            break;
        } while(false);
        float2 _1735 = float2(_1728.x * 1.25f, _1728.y * ((_1728.y < 0.0f) ? 1.25f : 0.75f));
        float _1736 = length(_1735);
        float _1738 = _1268 + _1709;
        float _1742 = _1221 ? frac(_1738) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(_1738, 0.0f, 1.0f));
        float _1754 = _1690.y;
        float _1757 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, _1742) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, _1742)) * step(0.001000000047497451305389404296875f, smoothstep(_1712, 0.0f, _1736))) * step(_1228, _1754 - 0.100000001490116119384765625f);
        float _1760 = _1757 * _1378;
        float2 _1767 = float2(_1712 * _1757, _1712 - _1736) * _1378;
        float2 _1769 = _1270.zy * 1.0f;
        float2 _1770 = floor(_1769);
        float2 _1773 = frac(_1770 * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1777 = _1773 + dot(_1773, _1773 + 34.345001220703125f.xx).xx;
        float _1778 = _1777.x;
        float _1779 = _1777.y;
        float2 _1783 = frac(float2(_1778 * _1779, _1778 + _1779));
        float2 _1786 = frac((_1770 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 _1790 = _1786 + dot(_1786, _1786 + 34.345001220703125f.xx).xx;
        float _1791 = _1790.x;
        float _1792 = _1790.y;
        float2 _1796 = frac(float2(_1791 * _1792, _1791 + _1792));
        float _1802 = _1783.x;
        float _1805 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, _1802)) * _1258;
        float2 _1806 = ((_1769 - _1770) + ((((_1796 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 _1821;
        do
        {
            if (_1517)
            {
                _1821 = _1806;
                break;
            }
            float2 _1812 = _1474 * rsqrt(_1516);
            _1821 = float2(dot(_1806, float2(-_1812.y, _1812.x)), -dot(_1806, _1812));
            break;
        } while(false);
        float2 _1828 = float2(_1821.x * 1.25f, _1821.y * ((_1821.y < 0.0f) ? 1.25f : 0.75f));
        float _1829 = length(_1828);
        float _1831 = _1268 + _1802;
        float _1835 = _1221 ? frac(_1831) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(_1831, 0.0f, 1.0f));
        float _1847 = _1783.y;
        float _1850 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, _1835) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, _1835)) * step(0.001000000047497451305389404296875f, smoothstep(_1805, 0.0f, _1829))) * step(_1228, _1847 - 0.100000001490116119384765625f);
        float _1853 = _1850 * _1475;
        float2 _1860 = float2(_1805 * _1850, _1805 - _1829) * _1475;
        bool2 _4053 = isnan(_1767);
        bool2 _4054 = isnan(_1860);
        float2 _4055 = max(_1767, _1860);
        float2 _4056 = float2(_4053.x ? _1860.x : _4055.x, _4053.y ? _1860.y : _4055.y);
        float2 _1861 = float2(_4054.x ? _1767.x : _4056.x, _4054.y ? _1767.y : _4056.y);
        bool2 _4058 = isnan(_1674);
        bool2 _4059 = isnan(_1861);
        float2 _4060 = max(_1674, _1861);
        float2 _4061 = float2(_4058.x ? _1861.x : _4060.x, _4058.y ? _1861.y : _4060.y);
        float _1868 = isnan(_1760) ? _1667 : (isnan(_1667) ? _1760 : max(_1667, _1760));
        float4 _1872 = float4((float4(((clamp(_1642 / _1619.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, _1610.x)) * _1664) * _1281, _1667, _1661).xy + float4(((clamp(_1735 / _1712.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, _1703.x)) * _1757) * _1378, _1760, _1754).xy) + float4(((clamp(_1828 / _1805.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, _1796.x)) * _1850) * _1475, _1853, _1847).xy, isnan(_1868) ? _1853 : (isnan(_1853) ? _1868 : max(_1853, _1868)), 0.0f);
        float _1874 = step(_1571.x, 0.00999999977648258209228515625f);
        float2 _1881 = _1581.zw * step(0.00999999977648258209228515625f, _1578);
        float2 _1883 = _1872.zw * _1874;
        bool2 _4073 = isnan(_1881);
        bool2 _4074 = isnan(_1883);
        float2 _4075 = max(_1881, _1883);
        float2 _4076 = float2(_4073.x ? _1883.x : _4075.x, _4073.y ? _1883.y : _4075.y);
        float2 _1886 = (float2(_4059.x ? _1674.x : _4061.x, _4059.y ? _1674.y : _4061.y) * float2(0.661900997161865234375f, 1.0f)) * _1874;
        bool2 _4078 = isnan(_1571);
        bool2 _4079 = isnan(_1886);
        float2 _4080 = max(_1571, _1886);
        float2 _4081 = float2(_4078.x ? _1886.x : _4080.x, _4078.y ? _1886.y : _4080.y);
        float2 _1887 = float2(_4079.x ? _1571.x : _4081.x, _4079.y ? _1571.y : _4081.y);
        float _1892 = clamp(dot(_423, _557), 0.0f, 1.0f);
        float _1901 = float2(_4074.x ? _1881.x : _4076.x, _4074.y ? _1881.y : _4076.y).x * (_1892 * lerp(0.4000000059604644775390625f, 1.0f, smoothstep(0.0f, 4.0f, abs(_18_m2[1].y) / _424)));
        float2 _1902 = (_1581.xy + (_1872.xy * _1874)).xy;
        float _1907 = sqrt(1.0f - clamp(dot(_1902, _1902), 0.0f, 1.0f));
        float3 _1913 = normalize(float3(_1902 * (2.5f * _1892), isnan(_1907) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? _1907 : max(1.000000016862383526387164645044e-16f, _1907))));
        float2 _1915 = _1913.xy;
        float _1919 = sqrt(1.0f - clamp(dot(_1915, _1915), 0.0f, 1.0f));
        float3 _1921 = float3(_1913.x, _1913.y, 0.0f.xxx.z);
        _1921.z = isnan(_1919) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? _1919 : max(1.000000016862383526387164645044e-16f, _1919));
        float3 _1922 = normalize(_1921);
        float3 _1923 = cross(_557, float3(0.0f, 1.0f, 0.0f));
        bool3 _1926 = (dot(_1923, _1923) > 6.103515625e-05f).xxx;
        float3 _1927 = normalize(_1923);
        float3 _1928 = float3(_1926.x ? _1927.x : float3(1.0f, 0.0f, 0.0f).x, _1926.y ? _1927.y : float3(1.0f, 0.0f, 0.0f).y, _1926.z ? _1927.z : float3(1.0f, 0.0f, 0.0f).z);
        float _1932 = _1922.y;
        float _1939 = _1887.x * 4.0f;
        float _1949 = clamp(dot(_1922, normalize(float3(0.0f, -1.0f, 0.75f))), 0.0f, 1.0f);
        float _1955 = (0.60000002384185791015625f * _1901) * _1939;
        float _1958 = (1.0f - _1955) + (clamp(clamp(clamp(_1887.y * 17.54000091552734375f, 0.0f, 1.0f), 0.0f, 1.0f) + clamp(1.60000002384185791015625f * _1932, 0.0f, 1.0f), 0.0f, 1.0f) * _1955);
        float _1961 = smoothstep(0.60000002384185791015625f, 1.0f, _1958);
        float _1964 = _1901 * _1939;
        _1972 = normalize(((_1928 * _1922.x) + (cross(_1928, _557) * _1932)) + (_557 * _1922.z));
        _1973 = _1259 + (2.0f * _660);
        _1974 = _1964;
        _1975 = ((lerp(0.0500000007450580596923828125f, 1.7999999523162841796875f, (_1949 * _1949) * _1949) * _1939) * _1961) * _1901;
        _1976 = lerp(1.0f, 0.800000011920928955078125f * lerp(0.5f, 1.0f, _1961), _1901);
        _1977 = _1964;
        _1978 = (_495 * _1958) * _1261;
        _1979 = (_462 * _1958) * _1261;
    }
    else
    {
        _1972 = _557;
        _1973 = 1.0f;
        _1974 = 0.0f;
        _1975 = 0.0f;
        _1976 = 1.0f;
        _1977 = 0.0f;
        _1978 = _495;
        _1979 = _462;
    }
    float3 _2091;
    float3 _2092;
    float3 _2093;
    float _2094;
    [branch]
    if (_649 > 0.00999999977648258209228515625f)
    {
        bool3 _1983 = _432.xxx;
        float3 _1985 = _11.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 _1986 = float3(_1983.x ? _1985.x : _11.x, _1983.y ? _1985.y : _11.y, _1983.z ? _1985.z : _11.z);
        float3 _1989 = _1986 * _20_m89.z;
        float3 _1991 = float3(_1983.x ? _9.xzy.x : _9.x, _1983.y ? _9.xzy.y : _9.y, _1983.z ? _9.xzy.z : _9.z);
        float3 _1993 = abs(_1991) - 0.20000000298023223876953125f.xxx;
        float3 _1995 = (_1993 * _1993) * _1993;
        bool3 _4093 = isnan(_1995);
        bool3 _4094 = isnan(6.103515625e-05f.xxx);
        float3 _4095 = max(_1995, 6.103515625e-05f.xxx);
        float3 _4096 = float3(_4093.x ? 6.103515625e-05f.xxx.x : _4095.x, _4093.y ? 6.103515625e-05f.xxx.y : _4095.y, _4093.z ? 6.103515625e-05f.xxx.z : _4095.z);
        float3 _1996 = float3(_4094.x ? _1995.x : _4096.x, _4094.y ? _1995.y : _4096.y, _4094.z ? _1995.z : _4096.z);
        float3 _1999 = _1996 / dot(_1996, 1.0f.xxx).xxx;
        float4 _2022 = ((_55.SampleBias(eid4812_linear_repeat_sampler27, _1989.xz, _20_m16) * _1999.y) + (_55.SampleBias(eid4812_linear_repeat_sampler27, _1989.xy, _20_m16) * _1999.z)) + (_55.SampleBias(eid4812_linear_repeat_sampler27, _1989.zy, _20_m16) * _1999.x);
        float _2030 = clamp(_649 + (smoothstep(0.3499999940395355224609375f, 0.20000000298023223876953125f, _1986.y) * clamp(_649 * 3.0f, 0.0f, 1.0f)), 0.0f, 1.0f);
        float _2041 = smoothstep(2.0f - _2030, 2.349999904632568359375f - _2030, ((_1991.y * 0.64999997615814208984375f) + 0.3499999940395355224609375f) + _2022.z) * ((_469 * _469) * float(gl_FrontFacing));
        float3 _2043 = _2041.xxx;
        float2 _2049 = (_2022.xy * 2.0f) - 1.0f.xx;
        float2 _2051 = _2049.xy;
        float _2055 = sqrt(1.0f - clamp(dot(_2051, _2051), 0.0f, 1.0f));
        float3 _2057 = float3(_2049.x, _2049.y, _383.z);
        _2057.z = isnan(_2055) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? _2055 : max(1.000000016862383526387164645044e-16f, _2055));
        float2 _2059 = _2057.xy * 2.0f;
        float3 _2061 = lerp(float3(0.0f, 0.0f, 1.0f), float3(_2059.x, _2059.y, _2057.z), _2043);
        float _2062 = dot(_2061, _2061);
        float3 _2065 = _2061 * rsqrt(isnan(_2062) ? 6.103515625e-05f : (isnan(6.103515625e-05f) ? _2062 : max(6.103515625e-05f, _2062)));
        float _2066 = _557.y;
        float _2069 = step(0.00999999977648258209228515625f, 1.0f - (_2066 * _2066));
        float _2073 = lerp(_557.z, _2066, _2069);
        float _2075 = 1.0f - (_2073 * _2073);
        float3 _2080 = (float3(0.0f, _2069, 1.0f - _2069) - (_557 * _2073)) * rsqrt(isnan(_2075) ? 9.9999997473787516355514526367188e-05f : (isnan(9.9999997473787516355514526367188e-05f) ? _2075 : max(9.9999997473787516355514526367188e-05f, _2075)));
        _2091 = ((cross(_2080, _557) * _2065.x) + (_2080 * _2065.y)) + (_557 * _2065.z);
        _2092 = lerp(_1978 * 1.0f, 0.3079999983310699462890625f.xxx, _2043);
        _2093 = lerp(_1979 * 1.0f, 0.87999999523162841796875f.xxx, _2043);
        _2094 = lerp(0.0f, 0.0f, _2041);
    }
    else
    {
        _2091 = _557;
        _2092 = _1978;
        _2093 = _1979;
        _2094 = 0.0f;
    }
    float _2096 = 0.959999978542327880859375f - (_2094 * 0.959999978542327880859375f);
    float3 _2097 = _2093 * _2096;
    float3 _2100 = lerp(0.039999999105930328369140625f.xxx * _468, _2093, _2094.xxx);
    float3 _2101 = _2092 * _2096;
    float2 _2114 = (_7.xy / (isnan(9.9999999392252902907785028219223e-09f) ? _7.z : (isnan(_7.z) ? 9.9999999392252902907785028219223e-09f : max(_7.z, 9.9999999392252902907785028219223e-09f))).xx) - (_8.xy / (isnan(9.9999999392252902907785028219223e-09f) ? _8.z : (isnan(_8.z) ? 9.9999999392252902907785028219223e-09f : max(_8.z, 9.9999999392252902907785028219223e-09f))).xx);
    float2 _2117 = _2114;
    _2117.y = -_2114.y;
    float2 _2127 = ((sqrt(sqrt(abs(_2117 * 0.5f))) * float2(int2(sign(_2117)))) * 0.5f) + 0.5f.xx;
    float4 _2131 = float4(_2127.x, _2127.y, 0.0f.xxxx.z, 0.0f.xxxx.w);
    _2131.z = 1.0f;
    float4 _2132 = _2131;
    _2132.w = (_1977 > 0.100000001490116119384765625f) ? 0.699999988079071044921875f : 0.4000000059604644775390625f;
    float3 _2143 = lerp(-_38_m0.xyz, _20_m90.xyz, _20_m80.w.xxx);
    float3 _2147 = normalize(float3(_2143.x, 6.103515625e-05f, _2143.z));
    float3 _2157 = lerp(_38_m3.xyz, _20_m84.xyz, _20_m91.y.xxx);
    float3 _2161 = _2157 * lerp(_38_m3.w, 1.0f, _20_m91.w);
    int _2165 = int(_613.x);
    int _2166 = int(_613.y);
    int2 hairAOPixel = int2(_2165, _2166);
    float4 _2170 = _EID4812UseDrawAO > 0.5
        ? _EID4812DrawAO.Load(int3(hairAOPixel, 0))
        : _42.Load(int3(hairAOPixel, 0));
    if (_EID4812AOAudit > 0.5)
    {
        uint auditWidth, auditHeight;
        if (_EID4812UseDrawAO > 0.5) _EID4812DrawAO.GetDimensions(auditWidth, auditHeight);
        else _42.GetDimensions(auditWidth, auditHeight);
        _15 = float4(_2170.rg, float(auditWidth)/2048.0, float(auditHeight)/2048.0);
        _16 = 0;
        return;
    }
    float _2175 = _2170.y;
    float _2178 = lerp(lerp(1.0f, _2170.x, _40_m6.x), 1.0f, _20_m80.z);
    float _2179 = dot(_2091, _2143);
    float3 _2186 = _2101 * _20_m79.z;
    float3 _2187 = _2186 * 0.64999997615814208984375f;
    float _2191 = dot(_2097, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float _2204 = clamp(-dot(_2147.xz, normalize(_623.xz)), 0.0f, 1.0f);
    float _2208 = 1.0f - _20_m91.x;
    float4 _2222 = _53.SampleLevel(eid4812_linear_clamp_sampler26, float2((clamp(lerp(_2179, ((-_2179) * ((_2179 * 0.5f) - 1.0f)) + 0.5f, (_2204 * smoothstep(0.25f, 0.75f, 1.0f - abs(_623.y))) * _2208) + (_20_m90.w * _20_m91.x), -1.0f, 1.0f) * 0.5f) + 0.5f, 0.5f), 0.0f);
    float _2223 = _2222.w;
    float _2225 = _2222.x;
    float _2226 = _2222.y;
    float _2227 = _2222.z;
    float _2228 = isnan(_2226) ? _2225 : (isnan(_2225) ? _2226 : max(_2225, _2226));
    float _2230 = isnan(_2226) ? _2225 : (isnan(_2225) ? _2226 : min(_2225, _2226));
    float _2232 = (isnan(_2227) ? _2228 : (isnan(_2228) ? _2227 : max(_2228, _2227))) - (isnan(_2227) ? _2230 : (isnan(_2230) ? _2227 : min(_2230, _2227)));
    float4 _2240 = _53.SampleLevel(eid4812_linear_clamp_sampler26, float2((dot(_2091, _623) * 0.5f) + 0.5f, 0.5f), 0.0f);
    float _2241 = _2240.w;
    float _2242 = _469 * _2175;
    float _2248 = isnan(_469) ? _2175 : (isnan(_2175) ? _469 : min(_2175, _469));
    float _2249 = isnan(_2223) ? _2248 : (isnan(_2248) ? _2223 : min(_2248, _2223));
    float _2250 = _2241 * _2242;
    float3 _2254 = ((clamp(dot(_557, _20_m85.xyz) + _20_m86.x, 0.0f, 1.0f) * _20_m86.y) + _20_m86.z).xxx * lerp(_1164, 1.0f.xxx, (_20_m80.y * _2249).xxx);
    float3 _2256 = _2249.xxx;
    float _2269 = lerp(0.64999997615814208984375f, 1.0f, _1165);
    float3 _2279 = _2178.xxx;
    float3 _2280 = lerp((_2254 * lerp(isnan(1.5f) ? _2269 : (isnan(_2269) ? 1.5f : min(_2269, 1.5f)), clamp(_1165, 1.25f, 1.75f), _20_m80.x)) * _20_m79.w, (lerp(dot(_2161, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, _2161, _2256) + ((_2254 * clamp(_1165, 0.0f, 1.5f)) * ((1.0f - _20_m91.y).xxx + (_2157 * _20_m91.y)))) * _20_m79.y, _2279);
    float3 _2281 = lerp(lerp(lerp(dot(_2187, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, _2187, 1.2000000476837158203125f.xxx), _2186, clamp((_2242 * _2241) + _2223, 0.0f, 1.0f).xxx), _2097, _2256);
    float3 _2287 = _2281 * ((1.0f - _2232).xxx + (_2222.xyz * _2232));
    float _2288 = dot(_2287, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float3 _2296 = lerp(lerp(_2186, lerp(_2191.xxx, _2097, 1.2000000476837158203125f.xxx), _2250.xxx), _2287 * clamp(dot(_2281, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)) * (1.0f / (isnan(0.001000000047497451305389404296875f) ? _2288 : (isnan(_2288) ? 0.001000000047497451305389404296875f : max(_2288, 0.001000000047497451305389404296875f)))), 0.0f, 1.5f), _2279);
    float4 _2300 = float4(_2296, _2178);
    float _2302 = lerp(_2250, _2249, _2178);
    float3 _2308 = (_2280 * (((_2302 * 0.5f) + 0.5f) * lerp(_20_m79.z, 1.0f, _2302))) * 1.0f;
    float _2311 = lerp(0.5f, _2143.y, _2178);
    float3 _2314 = mul(_583, float3(_598.x, _2311, _598.z));
    float3 _2316 = _2143 * _2178;
    float3 _2322 = normalize(_596 + (_576 * ((_51_m34 * 2.0f) - 1.0f)));
    float3 _2323 = normalize(_2316 + (float3(_2314.x, _2314.y, _2314.z) * 2.0f)) + _423;
    float _2324 = dot(_2323, _2323);
    float3 _2327 = _2323 * rsqrt(isnan(_2324) ? 6.103515625e-05f : (isnan(6.103515625e-05f) ? _2324 : max(6.103515625e-05f, _2324)));
    float _2328 = dot(_2322, _2327);
    float _2331 = sqrt(1.0f - (_2328 * _2328));
    float3 _2336 = clamp(pow(isnan(9.9999997473787516355514526367188e-05f) ? _2331 : (isnan(_2331) ? 9.9999997473787516355514526367188e-05f : max(_2331, 9.9999997473787516355514526367188e-05f)), 200.0f).xxx * _468, 0.0f.xxx, 1.0f.xxx);
    float _2339 = _607 * _607;
    float3 _2349 = (_2336 * _54.SampleLevel(eid4812_linear_clamp_sampler26, float2(_2336.x, float(_2328 > 0.0f) * _2339), 0.0f).xyz) * _607;
    float _2350 = _2349.x;
    float _2351 = _2349.y;
    float _2352 = _2349.z;
    float _2353 = isnan(_2351) ? _2350 : (isnan(_2350) ? _2351 : max(_2350, _2351));
    float _2354 = isnan(_2352) ? _2353 : (isnan(_2353) ? _2352 : max(_2353, _2352));
    float _2366 = 1.0f - _51_m38;
    float _2370 = dot(normalize(_596 + (_576 * ((_51_m35 * 2.0f) - 1.0f))), _2327);
    float _2373 = sqrt(1.0f - (_2370 * _2370));
    float _2406 = 1.0f - _51_m45;
    float _2410 = dot(normalize(_596 + (_576 * ((2.0f * _51_m44) - 1.0f))), _2327);
    float _2413 = sqrt(1.0f - (_2410 * _2410));
    float _2424 = lerp(1.0f, lerp(1.0f, lerp(lerp(1.0f - _51_m46, 1.0f, lerp(ceil(clamp(frac(_3.x * _51_m43) - 0.5f, 0.0f, 1.0f)), 1.0f - _525.x, _51_m48)), 1.0f, _2354), clamp(pow(isnan(9.9999997473787516355514526367188e-05f) ? _2413 : (isnan(_2413) ? 9.9999997473787516355514526367188e-05f : max(_2413, 9.9999997473787516355514526367188e-05f)), float(int(200.0f * (isnan(0.0f) ? _2406 : (isnan(_2406) ? 0.0f : max(_2406, 0.0f)))))), 0.0f, 1.0f)), _468);
    float3 _2428 = ((((((_2349 * _2100) * _51_m36) * 5.0f) * _1973) + lerp(((pow(isnan(9.9999997473787516355514526367188e-05f) ? _2373 : (isnan(_2373) ? 9.9999997473787516355514526367188e-05f : max(_2373, 9.9999997473787516355514526367188e-05f)), float(int(200.0f * (isnan(0.0f) ? _2366 : (isnan(_2366) ? 0.0f : max(_2366, 0.0f)))))).xxx * _607) * (_51_m42.xyz * _466.w)) * _1973, 0.0f.xxx, _2354.xxx)) * _2308) * _20_m92.w;
    float3 _2432 = (_2280 * _2296) * _2424;
    float3 _2436 = lerp(dot(_2432, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, _2432, lerp(_51_m47, 1.0f, _2424).xxx);
    float3 _2442 = float3(_623.x, _2311, _623.z);
    float _2443 = dot(_2442, _2442);
    float3 _2452 = normalize((_2316 + ((_2442 * rsqrt(isnan(_2443) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? _2443 : max(1.1754943508222875079687365372222e-38f, _2443)))) * 2.0f)) + (_423 * (2.0f + _2178)));
    float3 _2457 = normalize(float3(-_1972.z, 0.001000000047497451305389404296875f, _1972.x));
    float _2466 = dot(_1972, _2452);
    float _2479 = (1.0f - _51_m6) + (_473 * _51_m6);
    float3 _2481 = (_2436 * _2479) + ((_2428 * _1976) + (((_2436 + _2428) * _1975) + (((((smoothstep(0.1500000059604644775390625f, 0.100000001490116119384765625f, abs(dot(_2452, _2457))) * smoothstep(0.070000000298023223876953125f, 0.0199999995529651641845703125f, abs(dot(_2452, cross(_1972, _2457))))) * (isnan(_2466) ? 0.0f : (isnan(0.0f) ? _2466 : max(0.0f, _2466)))) * 2.0f) * _1974).xxx * _2308)));
    float _2482 = dot(_2481, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float _2485 = clamp(_2482 - 0.5f, 0.0f, 0.5f);
    float3 _2521 = normalize(cross(_623, lerp(float3(_20_m88.xy, 0.0f), (float3(_18_m0[0].x, _18_m0[0].y, _18_m0[0].z) * _20_m88.x) + (float3(_18_m0[1].x, _18_m0[1].y, _18_m0[1].z) * _20_m88.y), _20_m94.w.xxx)));
    float2 _2545 = normalize(mul(float3x3(_18_m0[0].xyz, _18_m0[1].xyz, _18_m0[2].xyz), _2091).xy) * float2(_20_m5.y / _20_m5.x, 1.0f);
    float2 _2551 = _20_m5.zw - 1.0f.xx;
    float2 _2552 = 2.0f.xx - _20_m5.zw;
    float _2574 = clamp(dot(_537, _2521) + 1.0f, 0.0f, 1.0f);
    float _2575 = isnan(_469) ? _2574 : (isnan(_2574) ? _469 : min(_2574, _469));
    float _2586 = dot(_2147, _2091);
    float _2597 = dot(_423, _2091);
    float _2601 = 1.0f - _2178;
    float _2612 = isnan(_1163.y) ? _1163.x : (isnan(_1163.x) ? _1163.y : max(_1163.x, _1163.y));
    float _2614 = (isnan(_1163.z) ? _2612 : (isnan(_2612) ? _1163.z : max(_2612, _1163.z))) * 0.5f;
    bool3 _4243 = isnan(0.1500000059604644775390625f.xxx);
    bool3 _4244 = isnan(_2097);
    float3 _4245 = max(0.1500000059604644775390625f.xxx, _2097);
    float3 _4246 = float3(_4243.x ? _2097.x : _4245.x, _4243.y ? _2097.y : _4245.y, _4243.z ? _2097.z : _4245.z);
    float2 _2629 = float2(_613);
    float2 _2631 = floor(_2629 * 0.03125f);
    int _2639 = int((_2631.x + (_2631.y * _36_m5)) * 8.0f);
    float _2646 = floor(_404 - (_20_m3.y * _36_m11));
    float _2650 = clamp(_2646, 0.0f, _36_m7 - 1.0f);
    int _2652 = int(_2650 * 8.0f);
    float3 _2654;
    _2654 = lerp(_2482.xxx, _2481, ((_2485 * _2485) + 1.0f).xxx) + (((((_20_m87.xyz * smoothstep(0.100000001490116119384765625f, 0.20000000298023223876953125f, (1.0f / ((_20_m2.z * _30.SampleLevel(eid4812_point_clamp_sampler25, clamp(_612 + ((_2545 * _20_m88.w) * 0.006000000052154064178466796875f), _2551, _2552), 0.0f).x) + _20_m2.w)) - _404)) * _20_m87.w) * (isnan(_2175) ? _2575 : (isnan(_2575) ? _2175 : min(_2575, _2175)))) * (lerp(0.25f.xxx, _2097, _20_m88.z.xxx) * clamp(dot(_2521, _2091), 0.0f, 1.0f))) + ((((((lerp(_1163 * (1.0f / (isnan(1.0f) ? _2614 : (isnan(_2614) ? 1.0f : max(_2614, 1.0f)))), _2161, _2279) * clamp(lerp(dot(_1162.xyz, _2091) * _1162.w, ((-_2586) * ((_2586 * 0.5f) - 1.0f)) + 0.5f, _2178), 0.0f, 1.0f)) * ((_2601 + (_2204 * _2178)) * _2208)) * smoothstep(0.60000002384185791015625f, 0.800000011920928955078125f, 1.0f - abs(_2597))) * (isnan(_2175) ? _469 : (isnan(_469) ? _2175 : min(_469, _2175)))) * (_2601 + (smoothstep(0.100000001490116119384765625f, 0.039999999105930328369140625f, _2191) * _2178))) * float3(_4244.x ? 0.1500000059604644775390625f.xxx.x : _4246.x, _4244.y ? 0.1500000059604644775390625f.xxx.y : _4246.y, _4244.z ? 0.1500000059604644775390625f.xxx.z : _4246.z)));
    float3 _2655;
    for (int _2657 = 0; _2657 <= 7; _2654 = _2655, _2657++)
    {
        uint _2675 = (_2646 <= _2650) ? (_32.Load(uint(_2639 + _2657) * 4 + 0) & _32.Load(uint((_20_m21.y + _2652) + _2657) * 4 + 0)) : 0u;
        uint _2676 = uint(_2657);
        _2655 = _2654;
        uint _2681;
        float3 _2678;
            for (uint _2680 = _2675; _2680 != 0u; _2655 = _2678, _2680 = _2681)
        {
            uint _2685 = firstbitlow(_2680);
            _2681 = _2680 ^ (1u << (_2685 & 31u));
            int _2691 = int((32u * _2676) + _2685) * 8;
            int _2694 = _2691 + 1;
            int _2697 = _2691 + 2;
            int _2700 = _2691 + 3;
            int _2703 = _2691 + 4;
            int _2706 = _2691 + 5;
            int _2709 = _2691 + 6;
            int _2712 = _2691 + 7;
            uint _2716 = uint(_38_m6[_2706].w);
            float _2791;
            if ((_2716 & 1u) == 1u)
            {
                uint _2722 = asuint(_38_m6[_2706].x);
                uint _2729 = asuint(_38_m6[_2706].y);
                uint _2736 = asuint(_38_m6[_2706].z);
                uint _2743 = asuint(_38_m6[_2709].x);
                uint _2750 = asuint(_38_m6[_2709].y);
                uint _2757 = asuint(_38_m6[_2709].z);
                float3 _2776 = abs(mul(float4(_530 - _38_m6[_2694].xyz, 1.0f), float4x4(float4(spvUnpackHalf2x16(_2722).x, spvUnpackHalf2x16(_2736).x, spvUnpackHalf2x16(_2750).x, 0.0f), float4(spvUnpackHalf2x16(_2722 >> 16u).x, spvUnpackHalf2x16(_2736 >> 16u).x, spvUnpackHalf2x16(_2750 >> 16u).x, 0.0f), float4(spvUnpackHalf2x16(_2729).x, spvUnpackHalf2x16(_2743).x, spvUnpackHalf2x16(_2757).x, 0.0f), float4(spvUnpackHalf2x16(_2729 >> 16u).x, spvUnpackHalf2x16(_2743 >> 16u).x, spvUnpackHalf2x16(_2757 >> 16u).x, 0.0f))).xyz);
                float _2777 = _2776.x;
                float _2778 = _2776.y;
                float _2779 = isnan(_2778) ? _2777 : (isnan(_2777) ? _2778 : max(_2777, _2778));
                float _2780 = _2776.z;
                float _2783 = _38_m6[_2712].x * 0.5f;
                float _2789 = 1.0f - clamp(((isnan(_2780) ? _2779 : (isnan(_2779) ? _2780 : max(_2779, _2780))) - (_2783 + 0.5f)) / (0.5f - _2783), 0.0f, 1.0f);
                _2791 = _2789 * _2789;
            }
            else
            {
                _2791 = 1.0f;
            }
            if (false || (_2791 < 0.001000000047497451305389404296875f))
            {
                _2678 = _2655;
                continue;
            }
            float3 _3484;
            if (_38_m6[_2691].w < 1.5f)
            {
                float3 _3483;
                do
                {
                    uint _2804 = asuint(_38_m6[_2700].w);
                    if ((_2804 == 16u) || ((_38_m6[_2700].z + _20_m91.z) < 0.5f))
                    {
                        _3483 = _2655;
                        break;
                    }
                    bool _2816 = (uint(_38_m6[_2691].w) & 1u) == 0u;
                    bool _2820 = (!_2816) && (_38_m6[_2697].z > 0.0f);
                    bool _2821 = _2804 == 4u;
                    float _2822 = float(_2816);
                    float _2830 = (0.5f + (0.5f * _38_m6[_2697].y)) - abs(_38_m6[_2697].x);
                    float _2831 = _38_m6[_2697].y - _2830;
                    float _2835 = (1.0f - abs(_2830)) - abs(_2831);
                    float _2838 = abs(isnan(0.00048828125f) ? _2835 : (isnan(_2835) ? 0.00048828125f : max(_2835, 0.00048828125f)));
                    float3 _2842 = normalize(float3(_2830, _2831, (_38_m6[_2697].x >= 0.0f) ? _2838 : (-_2838)));
                    float _2845 = 2.0f * _38_m6[_2703].y;
                    float _2848 = lerp(_38_m6[_2709].w, isnan(0.100000001490116119384765625f) ? _2845 : (isnan(_2845) ? 0.100000001490116119384765625f : max(_2845, 0.100000001490116119384765625f)), float(_2821));
                    float3 _2853 = _38_m6[_2694].xyz - _530;
                    float3 _2854 = -_2842;
                    float3 _2859 = lerp(_2853, _2854 * dot(_2853, _2854), (float(_2821 && (_38_m6[_2703].z > 0.5f)) * _2822).xxx);
                    float _2860 = dot(_2859, _2859);
                    float _2861 = rsqrt(_2860);
                    float3 _2862 = _2859 * _2861;
                    float3 _2895;
                    float _2896;
                    if (_2820)
                    {
                        float3 _2866 = (_2842 * _38_m6[_2697].z) * 0.5f;
                        float3 _2867 = _2859 - _2866;
                        float3 _2868 = _2859 + _2866;
                        float _2869 = length(_2867);
                        float _2870 = length(_2868);
                        float3 _2879 = normalize(cross(cross(_2842, _2862), _2842));
                        _2895 = _2879;
                        _2896 = ((1.0f / ((((_2869 * _2870) + dot(_2867, _2868)) * 0.5f) + 1.0f)) * clamp(0.5f * ((dot(_2879, _2867) / _2869) + (dot(_2879, _2868) / _2870)), 0.0f, 1.0f)) * (1.0f / clamp(1.0f + (0.5f * clamp(_38_m6[_2697].z * _2861, 0.0f, 1.0f)), 0.0f, 1.0f));
                    }
                    else
                    {
                        _2895 = _2862;
                        _2896 = 1.0f;
                    }
                    float _2918;
                    if (_2848 < 0.0f)
                    {
                        float _2912 = _2860 * (_38_m6[_2694].w * _38_m6[_2694].w);
                        float _2915 = clamp(1.0f - (_2912 * _2912), 0.0f, 1.0f);
                        _2918 = lerp(1.0f / (_2860 + 1.0f), _2896, float(_2820)) * (_2915 * _2915);
                    }
                    else
                    {
                        float3 _2901 = _2859 * _38_m6[_2694].w;
                        _2918 = _2896 * pow(1.0f - clamp(dot(_2901, _2901), 0.0f, 1.0f), _2848);
                    }
                    float _2923 = clamp((dot(_2895, _2854) - _38_m6[_2697].z) * _38_m6[_2697].w, 0.0f, 1.0f);
                    float _2926 = _2918 * lerp(1.0f, _2923 * _2923, _2822);
                    int _2928 = int(_38_m6[_2712].w);
                    float _3032;
                    if ((!_2820) && (_2928 >= 0))
                    {
                        uint _2934 = uint(_2928);
                        float2 _3025;
                        [branch]
                        if (_2822 != 0.0f)
                        {
                            float4 _3015 = mul(_61_m1[_2934], float4(_530.x, _655, _530.z, 1.0f));
                            _3025 = _61_m0[_2934].xy + (clamp(_3015.xy / _3015.w.xx, 0.0f.xx, 1.0f.xx) * _61_m0[_2934].zw);
                        }
                        else
                        {
                            float3 _2949 = mul(float4(-_2859, 0.0f), _61_m1[_2934]).xyz;
                            float3 _392 = _2949;
                            float3 _391 = _2949;
                            float3 _390 = abs(_2949);
                            uint _2958 = uint(int(_390.y > _390.x));
                            uint _2964 = (_390.z > _390[_2958]) ? 2u : _2958;
                            uint _2970 = (_2964 * 2u) + uint(_391[_2964] < 0.0f);
                            float _2974 = abs(_392[_2970 / 2u]);
                            float _2994 = 0.5f - (0.000244140625f / _61_m0[_2934].w);
                            _3025 = _61_m0[_2934].xy + (clamp(float2((float(_2970) + ((((_392[uint(_358[_2970].x)] * _359[_2970].x) / _2974) * _2994) + 0.5f)) * 0.16666667163372039794921875f, 0.5f - (((_392[uint(_358[_2970].y)] * _359[_2970].y) / _2974) * _2994)), 0.0f.xx, 1.0f.xx) * _61_m0[_2934].zw);
                        }
                        _3032 = _2926 * _59.SampleLevel(eid4812_linear_clamp_sampler26, _3025, 0.0f).x;
                    }
                    else
                    {
                        _3032 = _2926;
                    }
                    float _3033 = _3032 * _2791;
                    float3 _3482;
                    do
                    {
                        float3 _3481;
                        [branch]
                        if (_3033 > 9.9999997473787516355514526367188e-05f)
                        {
                            [branch]
                            if (_2821)
                            {
                                _3482 = lerp(_2655, _38_m6[_2691].xyz, (_3033 * (_38_m6[_2703].x * ((1.0f - _38_m6[_2703].w) + (smoothstep(-0.5f, 0.5f, dot(_558, _2895)) * _38_m6[_2703].w)))).xxx);
                                break;
                            }
                            float _3053 = dot(_2091, _2895);
                            float _3054 = clamp(_3053, 0.0f, 1.0f);
                            float _3357;
                            if (_2804 != 0u)
                            {
                                bool _3060 = _2816 || ((_2716 & 2u) != 0u);
                                int _3109;
                                if (_3060)
                                {
                                    _3109 = int(_38_m6[_2700].x);
                                }
                                else
                                {
                                    uint _3064 = asuint(_38_m6[_2697].w);
                                    uint _3066 = asuint(_38_m6[_2700].x);
                                    float3 _3067 = _530 - _38_m6[_2694].xyz;
                                    float3 _3068 = abs(_3067);
                                    float _3069 = _3068.x;
                                    float _3070 = _3068.y;
                                    float _3072 = _3068.z;
                                    int _3104;
                                    if ((_3069 > _3070) && (_3069 > _3072))
                                    {
                                        _3104 = int((_3067.x > 0.0f) ? (_3064 >> 24u) : ((_3064 >> 16u) & 255u));
                                    }
                                    else
                                    {
                                        int _3096;
                                        if (_3070 > _3072)
                                        {
                                            _3096 = int((_3067.y > 0.0f) ? ((_3064 >> 8u) & 255u) : (_3064 & 255u));
                                        }
                                        else
                                        {
                                            _3096 = int((_3067.z > 0.0f) ? ((_3066 >> 8u) & 255u) : (_3066 & 255u));
                                        }
                                        _3104 = _3096;
                                    }
                                    _3109 = (_3104 < 80) ? _3104 : (-1);
                                }
                                bool _3110 = _3109 >= 0;
                                float _3356;
                                if (_3110)
                                {
                                    float3 _3117 = _530 - _38_m6[_2694].xyz;
                                    float _3118 = dot(_3117, _3117);
                                    float4 _3137 = mul(_40_m10[_3109], float4((_530 - ((_3117 * rsqrt(isnan(_3118) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? _3118 : max(1.1754943508222875079687365372222e-38f, _3118)))) * _40_m11[_3109].x)) + (_558 * (_40_m11[_3109].y * 5.0f)), 1.0f));
                                    float _3138 = _3137.w;
                                    float3 _3141 = _3137.xyz / _3138.xxx;
                                    float2 _3142 = _3141.xy;
                                    float3 _3150 = _3141.xyz;
                                    bool3 _3151 = bool3(_3150.x <= 0.0f.xxx.x, _3150.y <= 0.0f.xxx.y, _3150.z <= 0.0f.xxx.z);
                                    bool3 _3152 = bool3(_3150.x >= 1.0f.xxx.x, _3150.y >= 1.0f.xxx.y, _3150.z >= 1.0f.xxx.z);
                                    float _3155 = _3141.z;
                                    float2 _3166 = ((_3142 * (_40_m12[_3109].zw - _40_m12[_3109].xy)) + _40_m12[_3109].xy).xy * _40_m13.zw;
                                    float2 _3168 = floor(_3166 + 0.5f.xx);
                                    float2 _3169 = _3166 - _3168;
                                    float _3170 = _3169.x;
                                    float _3171 = _3170 + 0.5f;
                                    float _3172 = _3171 * _3171;
                                    float _3175 = 1.0f - _3170;
                                    float _3176 = isnan(0.0f) ? _3170 : (isnan(_3170) ? 0.0f : min(_3170, 0.0f));
                                    float _3179 = _3170 + 1.0f;
                                    float _3180 = isnan(0.0f) ? _3170 : (isnan(_3170) ? 0.0f : max(_3170, 0.0f));
                                    float _3191 = _3169.y;
                                    float _3192 = _3191 + 0.5f;
                                    float _3193 = _3192 * _3192;
                                    float _3196 = 1.0f - _3191;
                                    float _3197 = isnan(0.0f) ? _3191 : (isnan(_3191) ? 0.0f : min(_3191, 0.0f));
                                    float _3200 = _3191 + 1.0f;
                                    float _3201 = isnan(0.0f) ? _3191 : (isnan(_3191) ? 0.0f : max(_3191, 0.0f));
                                    float3 _3213 = float3(0.1599999964237213134765625f * _3175, 0.1599999964237213134765625f * ((_3179 - (_3180 * _3180)) + 1.0f), _3172 * 0.07999999821186065673828125f);
                                    float3 _3214 = float3(0.1599999964237213134765625f * ((_3172 * 0.5f) - _3170), 0.1599999964237213134765625f * ((_3175 - (_3176 * _3176)) + 1.0f), 0.1599999964237213134765625f * _3179) + _3213;
                                    float3 _3216 = float3(0.1599999964237213134765625f * _3196, 0.1599999964237213134765625f * ((_3200 - (_3201 * _3201)) + 1.0f), _3193 * 0.07999999821186065673828125f);
                                    float3 _3217 = float3(0.1599999964237213134765625f * ((_3193 * 0.5f) - _3191), 0.1599999964237213134765625f * ((_3196 - (_3197 * _3197)) + 1.0f), 0.1599999964237213134765625f * _3200) + _3216;
                                    float3 _3223 = ((_3213 / _3214) + float3(-2.5f, -0.5f, 1.5f)) * _40_m13.xxx;
                                    float3 _3225 = ((_3216 / _3217) + float3(-2.5f, -0.5f, 1.5f)) * _40_m13.yyy;
                                    float2 _3227 = _3168 * _40_m13.xy;
                                    float _3228 = _3223.x;
                                    float _3229 = _3225.x;
                                    float _3232 = _3223.y;
                                    float _3235 = _3223.z;
                                    float _3238 = _3225.y;
                                    float _3245 = _3225.z;
                                    float _3252 = _3214.x;
                                    float _3253 = _3217.x;
                                    float _3255 = _3214.y;
                                    float _3257 = _3214.z;
                                    float _3259 = _3217.y;
                                    float _3263 = _3217.z;
                                    float2 _3341 = 1.0f.xx - _3142;
                                    bool2 _4293 = isnan(_3142);
                                    bool2 _4294 = isnan(_3341);
                                    float2 _4295 = min(_3142, _3341);
                                    float2 _4296 = float2(_4293.x ? _3341.x : _4295.x, _4293.y ? _3341.y : _4295.y);
                                    float2 _3342 = float2(_4294.x ? _3142.x : _4296.x, _4294.y ? _3142.y : _4296.y);
                                    float _3343 = _3342.x;
                                    float _3344 = _3342.y;
                                    float _3345 = isnan(_3344) ? _3343 : (isnan(_3343) ? _3344 : min(_3343, _3344));
                                    float _3349 = (_40_m11[_3109].z - _3138) * 0.25f;
                                    float _3351 = smoothstep(0.0f, 0.0500000007450580596923828125f, isnan(_3345) ? _3349 : (isnan(_3349) ? _3345 : min(_3349, _3345)));
                                    _3356 = _3110 ? lerp(1.0f, (any(bool3(_3151.x || _3152.x, _3151.y || _3152.y, _3151.z || _3152.z)) || ((asuint(_3155) & 2147483647u) > 2139095040u)) ? 1.0f : ((((((((((_3252 * _3253) * _41.SampleCmpLevelZero(eid4812_linear_clamp_compare_sampler28, float3(_3227 + float2(_3228, _3229), _382).xy, _3155)) + ((_3255 * _3253) * _41.SampleCmpLevelZero(eid4812_linear_clamp_compare_sampler28, float3(_3227 + float2(_3232, _3229), _382).xy, _3155))) + ((_3257 * _3253) * _41.SampleCmpLevelZero(eid4812_linear_clamp_compare_sampler28, float3(_3227 + float2(_3235, _3229), _382).xy, _3155))) + ((_3252 * _3259) * _41.SampleCmpLevelZero(eid4812_linear_clamp_compare_sampler28, float3(_3227 + float2(_3228, _3238), _382).xy, _3155))) + ((_3255 * _3259) * _41.SampleCmpLevelZero(eid4812_linear_clamp_compare_sampler28, float3(_3227 + float2(_3232, _3238), _382).xy, _3155))) + ((_3257 * _3259) * _41.SampleCmpLevelZero(eid4812_linear_clamp_compare_sampler28, float3(_3227 + float2(_3235, _3238), _382).xy, _3155))) + ((_3252 * _3263) * _41.SampleCmpLevelZero(eid4812_linear_clamp_compare_sampler28, float3(_3227 + float2(_3228, _3245), _382).xy, _3155))) + ((_3255 * _3263) * _41.SampleCmpLevelZero(eid4812_linear_clamp_compare_sampler28, float3(_3227 + float2(_3232, _3245), _382).xy, _3155))) + ((_3257 * _3263) * _41.SampleCmpLevelZero(eid4812_linear_clamp_compare_sampler28, float3(_3227 + float2(_3235, _3245), _382).xy, _3155))), _3060 ? (isnan(_3351) ? _40_m11[_3109].w : (isnan(_40_m11[_3109].w) ? _3351 : min(_40_m11[_3109].w, _3351))) : _40_m11[_3109].w) : 1.0f;
                                }
                                else
                                {
                                    _3356 = clamp(dot(_537, _2895) + 1.0f, 0.0f, 1.0f);
                                }
                                _3357 = _3356;
                            }
                            else
                            {
                                _3357 = 1.0f;
                            }
                            float _3430;
                            float3 _3431;
                            float _3432;
                            float3 _3433;
                            float3 _3434;
                            [branch]
                            if (_2804 == 0u)
                            {
                                float3 _3410 = _38_m6[_2691].xyz * _3033;
                                float _3411 = _3410.x;
                                float _3412 = _3410.y;
                                float _3413 = _3410.z;
                                float _3414 = isnan(_3412) ? _3411 : (isnan(_3411) ? _3412 : max(_3411, _3412));
                                float _3416 = (isnan(_3413) ? _3414 : (isnan(_3414) ? _3413 : max(_3414, _3413))) * lerp(0.75f, 0.5f, _2601);
                                float3 _3423 = _2300.xyz;
                                _3430 = _3033;
                                _3431 = (_38_m6[_2691].xyz * ((1.0f - _38_m6[_2703].y) + ((1.0f / (isnan(_3416) ? 1.0f : (isnan(1.0f) ? _3416 : max(1.0f, _3416)))) * _38_m6[_2703].y))) * lerp(0.25f * _38_m6[_2703].x, 1.0f, clamp(_3053 + 0.5f, 0.0f, 1.0f));
                                _3432 = _3054;
                                _3433 = _3423;
                                _3434 = _3423;
                            }
                            else
                            {
                                float _3405;
                                float _3406;
                                float3 _3407;
                                float3 _3408;
                                if (_2804 == 3u)
                                {
                                    _3405 = _3033 * (smoothstep(0.100000001490116119384765625f, 0.20000000298023223876953125f, (1.0f / ((_20_m2.z * _30.SampleLevel(eid4812_point_clamp_sampler25, clamp(_612 + ((_2545 * _38_m6[_2703].x) * 0.006000000052154064178466796875f), _2551, _2552), 0.0f).x) + _20_m2.w)) - _404) * _3357);
                                    _3406 = clamp(dot(_2091, -normalize(cross(_623, cross(_623, _2895)))), 0.0f, 1.0f);
                                    _3407 = lerp(0.5f.xxx, _2097, _38_m6[_2703].y.xxx);
                                    _3408 = 0.0f.xxx;
                                }
                                else
                                {
                                    bool _3366 = _2804 == 1u;
                                    float _3376;
                                    float3 _3377;
                                    if (_3366)
                                    {
                                        _3376 = clamp(clamp(_3053 + _38_m6[_2703].x, -1.0f, 1.0f), 0.0f, 1.0f) * _3357;
                                        _3377 = _2101 * _38_m6[_2703].y;
                                    }
                                    else
                                    {
                                        _3376 = _3054;
                                        _3377 = 0.0f.xxx;
                                    }
                                    bool3 _3378 = _3366.xxx;
                                    _3405 = _3033;
                                    _3406 = _3376;
                                    _3407 = float3(_3378.x ? _2097.x : 0.0f.xxx.x, _3378.y ? _2097.y : 0.0f.xxx.y, _3378.z ? _2097.z : 0.0f.xxx.z);
                                    _3408 = _3377;
                                }
                                _3430 = _3405;
                                _3431 = _38_m6[_2691].xyz;
                                _3432 = _3406;
                                _3433 = _3407;
                                _3434 = _3408;
                            }
                            float3 _3471;
                            [branch]
                            if (_2804 != 3u)
                            {
                                float3 _3439 = _2895 + _423;
                                float _3440 = dot(_3439, _3439);
                                float _3444 = dot(_2322, _3439 * rsqrt(isnan(_3440) ? 6.103515625e-05f : (isnan(6.103515625e-05f) ? _3440 : max(6.103515625e-05f, _3440))));
                                float _3447 = sqrt(1.0f - (_3444 * _3444));
                                float3 _3452 = clamp(pow(isnan(9.9999997473787516355514526367188e-05f) ? _3447 : (isnan(_3447) ? 9.9999997473787516355514526367188e-05f : max(_3447, 9.9999997473787516355514526367188e-05f)), 200.0f).xxx * _468, 0.0f.xxx, 1.0f.xxx);
                                _3471 = (((((((_3452 * _54.SampleLevel(eid4812_linear_clamp_sampler26, float2(_3452.x, float(_3444 > 0.0f) * _2339), 0.0f).xyz) * _607) * _2100) * _51_m36) * 5.0f) * _1973) * 1.0f) * _38_m6[_2712].z;
                            }
                            else
                            {
                                _3471 = 0.0f.xxx;
                            }
                            float3 _3474 = _3431 * _3430;
                            _3481 = _2655 + (((_3474 * lerp(_3434, _3433, _3432.xxx)) * _2479) + ((_3474 * _3471) * _3432));
                        }
                        else
                        {
                            _3481 = _2655;
                        }
                        _3482 = _3481;
                        break;
                    } while(false);
                    _3483 = _3482;
                    break;
                } while(false);
                _3484 = _3483;
            }
            else
            {
                _3484 = _2655;
            }
            _2678 = _3484;
        }
    }
    float3 _3524;
    [branch]
    if (_51_m12 > 0.5f)
    {
        _3524 = lerp(lerp(0.5f.xxx, lerp(dot(_2654, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, _2654, _51_m14.xxx), _51_m15.xxx) * _51_m13, _51_m26.xyz, _51_m26.w.xxx) + ((_51_m27.xyz * smoothstep(1.0f - _51_m16, 1.0f, 1.0f - clamp(_2597, 0.0f, 1.0f))) * _51_m17);
    }
    else
    {
        _3524 = _2654;
    }
    float4 _3536 = float4(_3524 * _20_m20.y, _473);
    _3536.w = (_51_m8 == 1.0f) ? _473 : 1.0f;
    float4 _3916;
    [branch]
    if (_20_m91.w < 0.5f)
    {
        float3 _3540 = -_423;
        float _3551 = (_424 * _20_m44.w) - _20_m43.w;
        float _3556 = _655 * _20_m46.w;
        float _3560 = _3556 + _20_m47.w;
        float _3561 = isnan(_3560) ? 0.00999999977648258209228515625f : (isnan(0.00999999977648258209228515625f) ? _3560 : max(0.00999999977648258209228515625f, _3560));
        float3 _3575 = exp(_20_m45.xyz * ((-(isnan(_3551) ? 0.0f : (isnan(0.0f) ? _3551 : max(0.0f, _3551)))) * (((1.0f - exp(-_3561)) / _3561) * exp(_3556 + _20_m48.w))));
        float _3578 = dot(_3540, _20_m44.xyz);
        float _3584 = _20_m45.w * _20_m45.w;
        float _3588 = (1.0f + _3584) - ((2.0f * _20_m45.w) * _3578);
        float _3592 = (12.56637096405029296875f * _3588) * sqrt(_3588);
        float3 _3908;
        float _3909;
        if (_20_m55.z > 0.0f)
        {
            uint3 _3739 = (uint3(int3(_2165, _2166, int(_20_m19 & 7u))) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _3740 = _3739.y;
            uint _3741 = _3739.z;
            uint _3744 = _3739.x + (_3740 * _3741);
            uint _3746 = _3740 + (_3741 * _3744);
            uint _3748 = _3741 + (_3744 * _3746);
            uint _3750 = _3744 + (_3746 * _3748);
            float _3772 = dot(_3540, -_18_m0[2].xyz);
            float3 _3779 = _530 - _18_m11.xyz;
            float _3781 = (_20_m55.w * ((_3772 > 5.9604644775390625e-08f) ? (1.0f / _3772) : 0.0f)) * (1.0f / _424);
            float _3782 = _3779.y;
            float _3783 = _3781 * _3782;
            float _3785 = _18_m11.y + _3783;
            float _3786 = _3782 - _3783;
            float _3788 = (1.0f - _3781) * _424;
            float _3794 = _20_m49.z * (_3785 - _20_m49.x);
            float _3801 = _20_m49.z * _3786;
            float _3802 = isnan(_3801) ? (-127.0f) : (isnan(-127.0f) ? _3801 : max(-127.0f, _3801));
            float _3818 = _20_m52.x * (_3785 - _20_m52.z);
            float _3825 = _20_m52.x * _3786;
            float _3826 = isnan(_3825) ? (-127.0f) : (isnan(-127.0f) ? _3825 : max(-127.0f, _3825));
            float _3837 = ((_20_m49.y * exp2(-(isnan(_3794) ? (-127.0f) : (isnan(-127.0f) ? _3794 : max(-127.0f, _3794))))) * ((abs(_3802) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-_3802)) / _3802) : (0.693147182464599609375f - (0.2402265071868896484375f * _3802)))) + ((_20_m52.y * exp2(-(isnan(_3818) ? (-127.0f) : (isnan(-127.0f) ? _3818 : max(-127.0f, _3818))))) * ((abs(_3826) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-_3826)) / _3826) : (0.693147182464599609375f - (0.2402265071868896484375f * _3826))));
            float _3841 = clamp(exp2(-(_3837 * _3788)), 0.0f, 1.0f);
            float _3859 = clamp((_424 * _20_m50.w) + _20_m50.z, 0.0f, 1.0f);
            float _3862 = clamp(((isnan(_20_m51.w) ? _3841 : (isnan(_3841) ? _20_m51.w : max(_3841, _20_m51.w))) + clamp((_424 * _20_m50.y) + _20_m50.x, 0.0f, 1.0f)) + _3859, 0.0f, 1.0f);
            float _3881 = _3788 - _20_m53.w;
            float4 _3902 = lerp(float4(0.0f, 0.0f, 0.0f, 1.0f), _64.SampleLevel(eid4812_linear_clamp_sampler26, float3((_2629 + ((((float3(uint3(_3750, _3746 + (_3748 * _3750), _388) >> uint3(16u, 16u, 16u)) * 1.525902189314365386962890625e-05f.xxx) * 2.0f) - 1.0f.xxx) * _20_m59.w).xy) * _20_m57.xy, (log2((_404 * _20_m56.x) + _20_m56.y) * _20_m56.z) / _20_m55.z), 0.0f), clamp((_404 - _20_m58.z) * 1000000.0f, 0.0f, 1.0f).xxxx);
            float _3904 = _3902.w;
            _3908 = _3902.xyz + (((_20_m51.xyz * (1.0f - _3862)) + (((_20_m54.xyz * pow(clamp(dot(_423, _20_m53.xyz), 0.0f, 1.0f), _20_m54.w)) * (1.0f - clamp(exp2(-(_3837 * (isnan(0.0f) ? _3881 : (isnan(_3881) ? 0.0f : max(_3881, 0.0f))))), 0.0f, 1.0f))) * (1.0f - _3859))) * _3904);
            _3909 = _3904 * _3862;
        }
        else
        {
            float3 _3615 = _530 - _18_m11.xyz;
            float _3617 = _3615.y;
            float _3623 = _20_m49.z * (_18_m11.y - _20_m49.x);
            float _3630 = _20_m49.z * _3617;
            float _3631 = isnan(_3630) ? (-127.0f) : (isnan(-127.0f) ? _3630 : max(-127.0f, _3630));
            float _3647 = _20_m52.x * (_18_m11.y - _20_m52.z);
            float _3654 = _20_m52.x * _3617;
            float _3655 = isnan(_3654) ? (-127.0f) : (isnan(-127.0f) ? _3654 : max(-127.0f, _3654));
            float _3666 = ((_20_m49.y * exp2(-(isnan(_3623) ? (-127.0f) : (isnan(-127.0f) ? _3623 : max(-127.0f, _3623))))) * ((abs(_3631) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-_3631)) / _3631) : (0.693147182464599609375f - (0.2402265071868896484375f * _3631)))) + ((_20_m52.y * exp2(-(isnan(_3647) ? (-127.0f) : (isnan(-127.0f) ? _3647 : max(-127.0f, _3647))))) * ((abs(_3655) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-_3655)) / _3655) : (0.693147182464599609375f - (0.2402265071868896484375f * _3655))));
            float _3670 = clamp(exp2(-(_3666 * _424)), 0.0f, 1.0f);
            float _3688 = clamp((_424 * _20_m50.w) + _20_m50.z, 0.0f, 1.0f);
            float _3691 = clamp(((isnan(_20_m51.w) ? _3670 : (isnan(_3670) ? _20_m51.w : max(_3670, _20_m51.w))) + clamp((_424 * _20_m50.y) + _20_m50.x, 0.0f, 1.0f)) + _3688, 0.0f, 1.0f);
            float _3710 = _424 - _20_m53.w;
            _3908 = (_20_m51.xyz * (1.0f - _3691)) + (((_20_m54.xyz * pow(clamp(dot(_423, _20_m53.xyz), 0.0f, 1.0f), _20_m54.w)) * (1.0f - clamp(exp2(-(_3666 * (isnan(0.0f) ? _3710 : (isnan(_3710) ? 0.0f : max(_3710, 0.0f))))), 0.0f, 1.0f))) * (1.0f - _3688));
            _3909 = _3691;
        }
        float3 _3914 = (_3536.xyz * (_3575 * _3909)) + ((((clamp(((_20_m46.xyz * (0.0596831031143665313720703125f * (1.0f + (_3578 * _3578)))) + _20_m48.xyz) + (_20_m47.xyz * ((1.0f - _3584) / (isnan(0.001000000047497451305389404296875f) ? _3592 : (isnan(_3592) ? 0.001000000047497451305389404296875f : max(_3592, 0.001000000047497451305389404296875f))))), 0.0f.xxx, 1.0f.xxx) * 255.0f) * (1.0f.xxx - _3575)) * _3909) + _3908);
        _3916 = float4(_3914.x, _3914.y, _3914.z, _3536.w);
    }
    else
    {
        _3916 = _3536;
    }
    _15 = _3916;
    _16 = _2132;
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


