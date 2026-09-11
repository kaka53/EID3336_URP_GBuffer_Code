struct _19
{
    column_major float4x4 _m0;
    float4 _m1;
    float4 _m2;
};

static float3 _121;
static float4 _123;

cbuffer _16_17 : register(b16)
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

cbuffer EID3863PSInstanceRecords : register(b17)
{
    _19 _20_m0[682] : packoffset(c0);
};

cbuffer EID3863PSMaterialParameters : register(b18)
{
    float _28_m0 : packoffset(c0);
    float _28_m1 : packoffset(c0.y);
    float _28_m2 : packoffset(c0.z);
    float _28_m3 : packoffset(c0.w);
    float _28_m4 : packoffset(c1);
    float _28_m5 : packoffset(c1.y);
    float _28_m6 : packoffset(c1.z);
    float _28_m7 : packoffset(c1.w);
    float _28_m8 : packoffset(c2);
    float _28_m9 : packoffset(c2.y);
    float _28_m10 : packoffset(c2.z);
    float _28_m11 : packoffset(c2.w);
    float _28_m12 : packoffset(c3);
    float _28_m13 : packoffset(c3.y);
    float _28_m14 : packoffset(c3.z);
    float _28_m15 : packoffset(c3.w);
    float _28_m16 : packoffset(c4);
    float _28_m17 : packoffset(c4.y);
    float _28_m18 : packoffset(c4.z);
    float _28_m19 : packoffset(c4.w);
    float _28_m20 : packoffset(c5);
    float _28_m21 : packoffset(c5.y);
    float _28_m22 : packoffset(c5.z);
    float _28_m23 : packoffset(c5.w);
    float _28_m24 : packoffset(c6);
    float _28_m25 : packoffset(c6.y);
    float _28_m26 : packoffset(c6.z);
    float _28_m27 : packoffset(c6.w);
    float _28_m28 : packoffset(c7);
    float _28_m29 : packoffset(c7.y);
    float _28_m30 : packoffset(c7.z);
    float _28_m31 : packoffset(c7.w);
    float4 _28_m32 : packoffset(c8);
    float4 _28_m33 : packoffset(c9);
    float4 _28_m34 : packoffset(c10);
    float4 _28_m35 : packoffset(c11);
    float4 _28_m36 : packoffset(c12);
    float4 _28_m37 : packoffset(c13);
};

cbuffer _29_30 : register(b34)
{
    float4 _30_m0 : packoffset(c0);
    float4 _30_m1 : packoffset(c1);
    float4 _30_m2 : packoffset(c2);
    float4 _30_m3 : packoffset(c3);
    float4 _30_m4 : packoffset(c4);
    uint4 _30_m5 : packoffset(c5);
    float4 _30_m6[2048] : packoffset(c6);
};

Texture2D<float4> _23 : register(t4);
SamplerState _24 : register(s2);
Texture2D<float4> _25 : register(t3);
SamplerState _26 : register(s1);

static bool gl_FrontFacing;
static float2 _3;
static float3 _4;
static float4 _5;
static float3 _6;
static float3 _7;
static float3 _8;
static uint _9;
static float4 _11;
static float4 _12;
static float4 _13;
static float4 _14;
static float4 _15;

struct SPIRV_Cross_Input
{
    float2 _3 : TEXCOORD0;
    float3 _4 : TEXCOORD2;
    float4 _5 : TEXCOORD3;
    float3 _6 : TEXCOORD4;
    float3 _7 : TEXCOORD5;
    float3 _8 : TEXCOORD6;
    nointerpolation uint _9 : TEXCOORD7;
    bool gl_FrontFacing : SV_IsFrontFace;
};

struct SPIRV_Cross_Output
{
    float4 _11 : SV_Target0;
    float4 _15 : SV_Target1;
    float4 _12 : SV_Target2;
    float4 _13 : SV_Target3;
    float4 _14 : SV_Target4;
};

void frag_main()
{
    float _136 = (_5.w > 0.0f) ? 1.0f : (-1.0f);
    float3 _141 = float4(_5.xyz, _136).xyz;
    float3x3 _147 = float3x3(_141 * 1.0f, (cross(_4, _141) * _136) * 1.0f, _4 * 1.0f);
    float _153 = lerp(1.0f, float((gl_FrontFacing ? true : false) ? 1 : (-1)), _28_m5);
    float4 _159 = _25.SampleBias(_26, _3, _17_m16);
    float2 _163 = _28_m8.xx;
    float2 _164 = lerp(_159.xy, float2(0.5f, 1.0f), _163);
    float _165 = _164.x;
    float4 _167 = float4(_165, _164.y, 0.0f, 1.0f);
    _167.w = _165;
    float2 _173 = (_167.wy * 2.0f) - 1.0f.xx;
    float3 _174 = float3(_173.x, _173.y, 0.0f);
    float2 _175 = _173.xy;
    _174.z = max(1.000000016862383526387164645044e-16f, sqrt(1.0f - clamp(dot(_175, _175), 0.0f, 1.0f)));
    float2 _185 = (_174.xy * _28_m4).xy * _153;
    float _187 = _159.w;
    float3 _188 = mul(float3(_185.x, _185.y, _174.z), _147);
    float _209 = clamp(lerp(_28_m34.z, 1.0f, clamp((max(length(_8 + float3(0.0f, _28_m34.w, 0.0f)) - _28_m34.w, 0.0f) - _28_m34.x) * _28_m34.y, 0.0f, 1.0f)), 0.0f, 1.0f);
    float _213 = _209 * lerp(1.0f, _187, _28_m14);
    float _217 = _209 * lerp(1.0f, _187, _28_m15);
    uint _239 = uint(round(_28_m9 * 31.0f));
    uint _253 = uint(round(0.0f));
    float4 _273 = _25.SampleBias(_26, _3, _17_m16);
    float2 _275 = lerp(_273.xy, float2(0.5f, 1.0f), _163);
    float _276 = _275.x;
    float4 _278 = float4(_276, _275.y, 0.0f, 1.0f);
    _278.w = _276;
    float2 _282 = (_278.wy * 2.0f) - 1.0f.xx;
    float3 _283 = float3(_282.x, _282.y, 0.0f);
    float2 _284 = _282.xy;
    _283.z = max(1.000000016862383526387164645044e-16f, sqrt(1.0f - clamp(dot(_284, _284), 0.0f, 1.0f)));
    float2 _294 = (_283.xy * _28_m4).xy * _153;
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
    _335.z = lerp(_28_m11, _28_m12, _273.z);
    float3 _361 = clamp(lerp(lerp(clamp((_23.SampleBias(_24, _3, _17_m16).xyz * _28_m32.xyz) * _28_m21, 0.0f.xxx, 1.0f.xxx), _28_m32.xyz, _28_m20.xxx), _20_m0[_9]._m2.xyz, _20_m0[_9]._m2.w.xxx), 0.0f.xxx, 1.0f.xxx);
    float4 _378 = float4(_361.x, _361.y, _361.z, 0.0f.xxxx.w);
    _378.w = clamp(lerp(_28_m33.z, 1.0f, clamp((max(length(_8 + float3(0.0f, _28_m33.w, 0.0f)) - _28_m33.w, 0.0f) - _28_m33.x) * _28_m33.y, 0.0f, 1.0f)), 0.0f, 1.0f);
    float2 _392 = (_6.xy / max(_6.z, 9.9999999392252902907785028219223e-09f).xx) - (_7.xy / max(_7.z, 9.9999999392252902907785028219223e-09f).xx);
    _392.y = -_392.y;
    float2 _405 = ((sqrt(sqrt(abs(_392 * 0.5f))) * float2(int2(sign(_392)))) * 0.5f) + 0.5f.xx;
    float4 _406 = float4(_405.x, _405.y, 0.0f.xxxx.z, 0.0f.xxxx.w);
    _406.z = 0.0f;
    _406.w = 0.0f;
    _11 = float4(0.0f, 0.0f, 0.0f, 1.0f);
    _12 = float4(float((uint(round(((0.5f * _28_m10) * (1.0f - abs(_213 - _217))) * 127.0f)) << 3u) | ((_239 >> 2u) & 7u)) * 0.000977517105638980865478515625f, float((uint(round(max(_213, _217) * 127.0f)) << 3u) | uint(round(3.5f))) * 0.000977517105638980865478515625f, float((uint(round(clamp(dot((_188 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(_188, _188)))) * _153, -_30_m0.xyz), 0.0f, 1.0f) * 127.0f)) << 3u) | ((_253 >> 2u) & 7u)) * 0.000977517105638980865478515625f, float(_239 & 3u) * 0.3333333432674407958984375f);
    _13 = _335;
    _14 = _378;
    _15 = _406;
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_FrontFacing = stage_input.gl_FrontFacing;
    _3 = stage_input._3;
    _4 = stage_input._4;
    _5 = stage_input._5;
    _6 = stage_input._6;
    _7 = stage_input._7;
    _8 = stage_input._8;
    _9 = stage_input._9;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output._11 = _11;
    stage_output._12 = _12;
    stage_output._13 = _13;
    stage_output._14 = _14;
    stage_output._15 = _15;
    return stage_output;
}
