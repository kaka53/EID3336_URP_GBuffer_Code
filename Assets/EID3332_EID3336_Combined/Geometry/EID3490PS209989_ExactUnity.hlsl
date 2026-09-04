#ifndef EID3490_PS209989_EXACT_UNITY_INCLUDED
#define EID3490_PS209989_EXACT_UNITY_INCLUDED

// Exact SPIRV-Cross translation of RenderDoc Event 3490 PS resource 209989.
// Arithmetic and branches are preserved. Only descriptor register annotations,
// Unity constant-buffer compatibility, stable property names, and the explicit
// current-camera VT safety switch are adapted.

SamplerState sampler_PointClamp;
SamplerState sampler_LinearClamp;
SamplerState sampler_LinearRepeat;
float _EID3332CombinedEnableVirtualTextureBranch;

#define _26 sampler_PointClamp
#define _27 sampler_LinearClamp
#define _28 sampler_LinearRepeat
#define _29 sampler_LinearRepeat
#define _30 sampler_PointClamp
#define _34 sampler_LinearRepeat
#define _36 sampler_LinearRepeat

struct _23
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

static float3 _298;

cbuffer _18_19
{
    column_major float4x4 _19_m0 : packoffset(c0);
    column_major float4x4 _19_m1 : packoffset(c4);
    column_major float4x4 _19_m2 : packoffset(c8);
    column_major float4x4 _19_m3 : packoffset(c12);
    column_major float4x4 _19_m4 : packoffset(c16);
    column_major float4x4 _19_m5 : packoffset(c20);
    column_major float4x4 _19_m6 : packoffset(c24);
    column_major float4x4 _19_m7 : packoffset(c28);
    column_major float4x4 _19_m8 : packoffset(c32);
    column_major float4x4 _19_m9 : packoffset(c36);
    column_major float4x4 _19_m10 : packoffset(c40);
    float4 _19_m11 : packoffset(c44);
    column_major float4x4 _19_m12 : packoffset(c45);
    column_major float4x4 _19_m13 : packoffset(c49);
    column_major float4x4 _19_m14 : packoffset(c53);
    column_major float4x4 _19_m15 : packoffset(c57);
    column_major float4x4 _19_m16 : packoffset(c61);
    column_major float4x4 _19_m17 : packoffset(c65);
    column_major float4x4 _19_m18 : packoffset(c69);
    column_major float4x4 _19_m19 : packoffset(c73);
    column_major float4x4 _19_m20 : packoffset(c77);
    float4 _19_m21 : packoffset(c81);
};

cbuffer _20_21
{
    float4 _21_m0 : packoffset(c0);
    float4 _21_m1 : packoffset(c1);
    float4 _21_m2 : packoffset(c2);
    float4 _21_m3 : packoffset(c3);
    float4 _21_m4 : packoffset(c4);
    float4 _21_m5 : packoffset(c5);
    float4 _21_m6[6] : packoffset(c6);
    float4 _21_m7[6] : packoffset(c12);
    float4 _21_m8 : packoffset(c18);
    float4 _21_m9 : packoffset(c19);
    float4 _21_m10 : packoffset(c20);
    float4 _21_m11 : packoffset(c21);
    float4 _21_m12 : packoffset(c22);
    float4 _21_m13 : packoffset(c23);
    float4 _21_m14 : packoffset(c24);
    float4 _21_m15 : packoffset(c25);
    float _21_m16 : packoffset(c26);
    float _21_m17 : packoffset(c26.y);
    float _21_m18 : packoffset(c26.z);
    uint _21_m19 : packoffset(c26.w);
    float4 _21_m20 : packoffset(c27);
    int4 _21_m21 : packoffset(c28);
    float4 _21_m22 : packoffset(c29);
    float4 _21_m23 : packoffset(c30);
    float4 _21_m24 : packoffset(c31);
    float4 _21_m25 : packoffset(c32);
    float4 _21_m26 : packoffset(c33);
    float4 _21_m27 : packoffset(c34);
    float4 _21_m28 : packoffset(c35);
    float4 _21_m29 : packoffset(c36);
    float4 _21_m30 : packoffset(c37);
    float4 _21_m31 : packoffset(c38);
    float4 _21_m32[4] : packoffset(c39);
    float4 _21_m33[4] : packoffset(c43);
    float4 _21_m34[4] : packoffset(c47);
    float4 _21_m35[4] : packoffset(c51);
    float4 _21_m36 : packoffset(c55);
    float4 _21_m37 : packoffset(c56);
    float4 _21_m38[4] : packoffset(c57);
    float4 _21_m39[4] : packoffset(c61);
    float4 _21_m40[4] : packoffset(c65);
    float4 _21_m41 : packoffset(c69);
    float4 _21_m42 : packoffset(c70);
    float4 _21_m43 : packoffset(c71);
    float4 _21_m44 : packoffset(c72);
    float4 _21_m45 : packoffset(c73);
    float4 _21_m46 : packoffset(c74);
    float4 _21_m47 : packoffset(c75);
    float4 _21_m48 : packoffset(c76);
    float4 _21_m49 : packoffset(c77);
    float4 _21_m50 : packoffset(c78);
    float4 _21_m51 : packoffset(c79);
    float4 _21_m52 : packoffset(c80);
    float4 _21_m53 : packoffset(c81);
    float4 _21_m54 : packoffset(c82);
    float4 _21_m55 : packoffset(c83);
    float4 _21_m56 : packoffset(c84);
    float4 _21_m57 : packoffset(c85);
    float4 _21_m58 : packoffset(c86);
    float4 _21_m59 : packoffset(c87);
    float4 _21_m60 : packoffset(c88);
    float4 _21_m61 : packoffset(c89);
    float4 _21_m62 : packoffset(c90);
    float4 _21_m63 : packoffset(c91);
    float4 _21_m64 : packoffset(c92);
    float4 _21_m65 : packoffset(c93);
    float4 _21_m66 : packoffset(c94);
    float4 _21_m67 : packoffset(c95);
    float4 _21_m68 : packoffset(c96);
    float4 _21_m69 : packoffset(c97);
    float4 _21_m70 : packoffset(c98);
    float4 _21_m71 : packoffset(c99);
    float4 _21_m72 : packoffset(c100);
    float4 _21_m73 : packoffset(c101);
    float4 _21_m74 : packoffset(c102);
    float4 _21_m75 : packoffset(c103);
    float4 _21_m76 : packoffset(c104);
    float4 _21_m77 : packoffset(c105);
    float4 _21_m78 : packoffset(c106);
    float4 _21_m79 : packoffset(c107);
    float4 _21_m80 : packoffset(c108);
    float4 _21_m81 : packoffset(c109);
    float4 _21_m82 : packoffset(c110);
    float4 _21_m83 : packoffset(c111);
    float4 _21_m84 : packoffset(c112);
    float4 _21_m85 : packoffset(c113);
    float4 _21_m86 : packoffset(c114);
    float4 _21_m87 : packoffset(c115);
    float4 _21_m88 : packoffset(c116);
    float4 _21_m89 : packoffset(c117);
    float4 _21_m90 : packoffset(c118);
    float4 _21_m91 : packoffset(c119);
    float4 _21_m92 : packoffset(c120);
    float4 _21_m93 : packoffset(c121);
    float4 _21_m94 : packoffset(c122);
    float4 _21_m95 : packoffset(c123);
    float4 _21_m96 : packoffset(c124);
    float4 _21_m97 : packoffset(c125);
    float4 _21_m98 : packoffset(c126);
    float4 _21_m99[2] : packoffset(c127);
    float4 _21_m100[2] : packoffset(c129);
    float _21_m101 : packoffset(c131);
    float _21_m102 : packoffset(c131.y);
    float _21_m103 : packoffset(c131.z);
    float _21_m104 : packoffset(c131.w);
    float4 _21_m105 : packoffset(c132);
    float4 _21_m106 : packoffset(c133);
    float4 _21_m107 : packoffset(c134);
    float4 _21_m108 : packoffset(c135);
    float4 _21_m109 : packoffset(c136);
    float4 _21_m110 : packoffset(c137);
    float4 _21_m111 : packoffset(c138);
    float4 _21_m112 : packoffset(c139);
    float4 _21_m113 : packoffset(c140);
    float4 _21_m114 : packoffset(c141);
    float4 _21_m115 : packoffset(c142);
    float4 _21_m116 : packoffset(c143);
    float4 _21_m117 : packoffset(c144);
    float4 _21_m118 : packoffset(c145);
    float4 _21_m119 : packoffset(c146);
    float4 _21_m120 : packoffset(c147);
    float4 _21_m121 : packoffset(c148);
    float4 _21_m122 : packoffset(c149);
    float4 _21_m123 : packoffset(c150);
    float4 _21_m124 : packoffset(c151);
    float4 _21_m125 : packoffset(c152);
    float4 _21_m126 : packoffset(c153);
    float4 _21_m127 : packoffset(c154);
    float4 _21_m128 : packoffset(c155);
    float4 _21_m129 : packoffset(c156);
    float4 _21_m130 : packoffset(c157);
    float4 _21_m131 : packoffset(c158);
    float4 _21_m132 : packoffset(c159);
    float4 _21_m133 : packoffset(c160);
    float4 _21_m134 : packoffset(c161);
    column_major float4x4 _21_m135 : packoffset(c162);
    float4 _21_m136 : packoffset(c166);
    float4 _21_m137 : packoffset(c167);
    float4 _21_m138[32] : packoffset(c168);
};

cbuffer _22_24
{
    float4 _24_raw[4096] : packoffset(c0);
};

cbuffer _43_44
{
    float _43_m0 : packoffset(c0);
    float _43_m1 : packoffset(c0.y);
    float _43_m2 : packoffset(c0.z);
    float _43_m3 : packoffset(c0.w);
    float _43_m4 : packoffset(c1);
    float _43_m5 : packoffset(c1.y);
    float _43_m6 : packoffset(c1.z);
    float _43_m7 : packoffset(c1.w);
    float _43_m8 : packoffset(c2);
    float _43_m9 : packoffset(c2.y);
    float _43_m10 : packoffset(c2.z);
    float _43_m11 : packoffset(c2.w);
    float _43_m12 : packoffset(c3);
    float _43_m13 : packoffset(c3.y);
    float _43_m14 : packoffset(c3.z);
    float _43_m15 : packoffset(c3.w);
    float _43_m16 : packoffset(c4);
    float _43_m17 : packoffset(c4.y);
    float _43_m18 : packoffset(c4.z);
    float _43_m19 : packoffset(c4.w);
    float _43_m20 : packoffset(c5);
    float _43_m21 : packoffset(c5.y);
    float _43_m22 : packoffset(c5.z);
    float _43_m23 : packoffset(c5.w);
    float _43_m24 : packoffset(c6);
    float _43_m25 : packoffset(c6.y);
    float _43_m26 : packoffset(c6.z);
    float _43_m27 : packoffset(c6.w);
    float _43_m28 : packoffset(c7);
    float _43_m29 : packoffset(c7.y);
    float _43_m30 : packoffset(c7.z);
    float _43_m31 : packoffset(c7.w);
    float4 _43_m32 : packoffset(c8);
    float4 _43_m33 : packoffset(c9);
    float4 _43_m34 : packoffset(c10);
    float4 _43_m35 : packoffset(c11);
    float4 _43_m36 : packoffset(c12);
    float4 _43_m37 : packoffset(c13);
    float4 _43_m38 : packoffset(c14);
    float4 _43_m39 : packoffset(c15);
    float4 _43_m40 : packoffset(c16);
    float4 _43_m41 : packoffset(c17);
    float4 _43_m42 : packoffset(c18);
    float4 _43_m43 : packoffset(c19);
    float4 _43_m44 : packoffset(c20);
    float4 _43_m45 : packoffset(c21);
    float _43_m46 : packoffset(c22);
    float _43_m47 : packoffset(c22.y);
    float _43_m48 : packoffset(c22.z);
    float _43_m49 : packoffset(c22.w);
    float _43_m50 : packoffset(c23);
    float _43_m51 : packoffset(c23.y);
    float _43_m52 : packoffset(c23.z);
    float _43_m53 : packoffset(c23.w);
    float4 _43_m54 : packoffset(c24);
    float4 _43_m55 : packoffset(c25);
    float _43_m56 : packoffset(c26);
    float _43_m57 : packoffset(c26.y);
    float _43_m58 : packoffset(c26.z);
    float _43_m59 : packoffset(c26.w);
    float _43_m60 : packoffset(c27);
    float _43_m61 : packoffset(c27.y);
    float _43_m62 : packoffset(c27.z);
    float _43_m63 : packoffset(c27.w);
    float _43_m64 : packoffset(c28);
    float _43_m65 : packoffset(c28.y);
    float _43_m66 : packoffset(c28.z);
    float _43_m67 : packoffset(c28.w);
    float _43_m68 : packoffset(c29);
    float _43_m69 : packoffset(c29.y);
    float _43_m70 : packoffset(c29.z);
    float _43_m71 : packoffset(c29.w);
    float4 _43_m72 : packoffset(c30);
    float4 _43_m73 : packoffset(c31);
    float _43_m74 : packoffset(c32);
    float _43_m75 : packoffset(c32.y);
    float _43_m76 : packoffset(c32.z);
    float _43_m77 : packoffset(c32.w);
    float _43_m78 : packoffset(c33);
    float _43_m79 : packoffset(c33.y);
    float _43_m80 : packoffset(c33.z);
    float _43_m81 : packoffset(c33.w);
    float _43_m82 : packoffset(c34);
    float _43_m83 : packoffset(c34.y);
    float _43_m84 : packoffset(c34.z);
    float _43_m85 : packoffset(c34.w);
    float _43_m86 : packoffset(c35);
    float _43_m87 : packoffset(c35.y);
    float _43_m88 : packoffset(c35.z);
    float _43_m89 : packoffset(c35.w);
    float _43_m90 : packoffset(c36);
    float _43_m91 : packoffset(c36.y);
    float _43_m92 : packoffset(c36.z);
    float _43_m93 : packoffset(c36.w);
    float _43_m94 : packoffset(c37);
    float _43_m95 : packoffset(c37.y);
    float _43_m96 : packoffset(c37.z);
    float _43_m97 : packoffset(c37.w);
    float4 _43_m98 : packoffset(c38);
    float4 _43_m99 : packoffset(c39);
    float4 _43_m100 : packoffset(c40);
    float4 _43_m101 : packoffset(c41);
    float _43_m102 : packoffset(c42);
    float _43_m103 : packoffset(c42.y);
    float _43_m104 : packoffset(c42.z);
    float _43_m105 : packoffset(c42.w);
    float _43_m106 : packoffset(c43);
    float _43_m107 : packoffset(c43.y);
    float _43_m108 : packoffset(c43.z);
    float _43_m109 : packoffset(c43.w);
    float _43_m110 : packoffset(c44);
    float _43_m111 : packoffset(c44.y);
    float _43_m112 : packoffset(c44.z);
    float _43_m113 : packoffset(c44.w);
};

cbuffer _45_46
{
    float _45_m0 : packoffset(c0);
    float _45_m1 : packoffset(c0.y);
    float _45_m2 : packoffset(c0.z);
    float _45_m3 : packoffset(c0.w);
};

cbuffer _47_48
{
    float4 _47_m0 : packoffset(c0);
    float4 _47_m1 : packoffset(c1);
    float4 _47_m2 : packoffset(c2);
    float4 _47_m3 : packoffset(c3);
    float4 _47_m4 : packoffset(c4);
    int4 _47_m5 : packoffset(c5);
    float4 _47_m6 : packoffset(c6);
    float4 _47_m7 : packoffset(c7);
    float4 _47_m8 : packoffset(c8);
    float4 _47_m9 : packoffset(c9);
    float4 _47_m10 : packoffset(c10);
    uint _47_m11 : packoffset(c11);
    uint _47_m12 : packoffset(c11.y);
    float _47_m13 : packoffset(c11.z);
    float _47_m14 : packoffset(c11.w);
    float _47_m15 : packoffset(c12);
    float _47_m16 : packoffset(c12.y);
    float _47_m17 : packoffset(c12.z);
    float _47_m18 : packoffset(c12.w);
};

cbuffer _49_50
{
    uint4 _49_m0[64] : packoffset(c0);
    uint4 _49_m1[1024] : packoffset(c64);
    int4 _49_m2 : packoffset(c1088);
    int4 _49_m3 : packoffset(c1089);
    uint4 _49_m4 : packoffset(c1090);
};

cbuffer _51_52
{
    float4 _51_m0[64] : packoffset(c0);
    float4 _51_m1[64] : packoffset(c64);
    float4 _51_m2[64] : packoffset(c128);
    float4 _51_m3[64] : packoffset(c192);
    float4 _51_m4[64] : packoffset(c256);
    float4 _51_m5[64] : packoffset(c320);
    float4 _51_m6[64] : packoffset(c384);
};

Texture2D<float4> _33;
Texture2D<float4> _35;
Texture2D<float4> _37;
Texture2D<float4> _38;
Texture2D<float4> _39;
Texture2D<float4> _40;
Texture2D<float4> _41;
Texture2D<float4> _53;
Texture2D<float4> _54;
Texture2D<float4> _55;
Texture2D<float4> _56;
Texture2D<float4> _57;
Texture2DArray<float4> _58;
Texture2DArray<float4> _59;
Texture2D<float4> _60;
Texture2D<float4> _61;
Texture2D<float4> _62;
Texture2D<float4> _63;
Texture2D<float4> _64;
Texture2D<float4> _65;

static float4 gl_FragCoord;
static bool gl_FrontFacing;
static float2 _4;
static float2 _5;
static float2 _6;
static float3 _7;
static float4 _8;
static float3 _9;
static float3 _10;
static uint _11;
static float4 _13;
static float4 _14;
static float4 _15;
static float4 _16;
static float4 _17;

struct SPIRV_Cross_Input
{
    float2 _4 : TEXCOORD0;
    float2 _5 : TEXCOORD1;
    float2 _6 : TEXCOORD2;
    float3 _7 : TEXCOORD3;
    float4 _8 : TEXCOORD4;
    float3 _9 : TEXCOORD6;
    float3 _10 : TEXCOORD7;
    nointerpolation uint _11 : TEXCOORD8;
    float4 gl_FragCoord : SV_Position;
    bool gl_FrontFacing : SV_IsFrontFace;
};

struct SPIRV_Cross_Output
{
    float4 _13 : SV_Target0;
    float4 _17 : SV_Target1;
    float4 _14 : SV_Target2;
    float4 _15 : SV_Target3;
    float4 _16 : SV_Target4;
};

void frag_main()
{
    float2 _320 = gl_FragCoord.xy * _21_m0.zw;
    float2 _322 = (_320 * 2.0f) - 1.0f.xx;
    float4 _325 = float4(_322, gl_FragCoord.z, 1.0f);
    _325.y = -_322.y;
    float4 _328 = mul(_19_m6, _325);
    float3 _332 = _328.xyz / _328.w.xxx;
    float _333 = _332.x;
    float _339 = abs(mul(_19_m0, float4(_333, _332.yz, 1.0f)).z);
    float _343 = (_8.w > 0.0f) ? 1.0f : (-1.0f);
    float3 _348 = float4(_8.xyz, _343).xyz;
    float3 _350 = cross(_7, _348) * _343;
    float4 _387 = _33.SampleBias(_34, (lerp(_4, _5, _43_m11.xx) * _43_m35.xy) + _43_m35.zw, _21_m16);
    float _389 = _387.w;
    float4 _392 = _35.SampleBias(_36, (lerp(_4, _5, _43_m12.xx) * _43_m36.xy) + _43_m36.zw, _43_m13 + _21_m16);
    float2 _395 = (_392.xy * 2.0f.xx) - 1.0f.xx;
    float2 _396 = abs(_395);
    bool2 _397 = bool2(_396.x < 0.01200000010430812835693359375f.xx.x, _396.y < 0.01200000010430812835693359375f.xx.y);
    float2 _398 = float2(_397.x ? 0.0f.xx.x : _395.x, _397.y ? 0.0f.xx.y : _395.y);
    float _407 = _392.z;
    float _408 = _392.w;
    float3 _420 = lerp(clamp((_387.xyz * _43_m32.xyz) * _43_m18, 0.0f.xxx, 1.0f.xxx), _43_m32.xyz, _43_m16.xxx);
    float4 _449 = _38.SampleBias(_28, (lerp(_4, _5, _43_m52.xx) * _43_m55.xy) + _43_m55.zw, _21_m16);
    float _450 = _449.w;
    float _472 = lerp(lerp(1.0f, _450, clamp(_43_m47, 0.0f, 1.0f)), lerp(lerp(_389, _407, clamp(_43_m47 - 2.0f, 0.0f, 1.0f)), _408, clamp(_43_m47 - 3.0f, 0.0f, 1.0f)), clamp(_43_m47 - 1.0f, 0.0f, 1.0f)) * clamp((_43_m51 - _339) / (_43_m51 - _43_m50), 0.0f, 1.0f);
    float2 _486 = (_449.xy * 2.0f.xx) - 1.0f.xx;
    float2 _487 = abs(_486);
    bool2 _488 = bool2(_487.x < 0.01200000010430812835693359375f.xx.x, _487.y < 0.01200000010430812835693359375f.xx.y);
    float2 _489 = float2(_488.x ? 0.0f.xx.x : _486.x, _488.y ? 0.0f.xx.y : _486.y);
    float3 _498 = float3(_398 * _43_m0, sqrt(clamp(1.0f - dot(_398, _398), 0.0f, 1.0f))) + float3(0.0f, 0.0f, 1.0f);
    float3 _499 = float3(_489 * (_472 * _43_m48), sqrt(clamp(1.0f - dot(_489, _489), 0.0f, 1.0f))) * float3(-1.0f, -1.0f, 1.0f);
    float3 _506 = ((_498 * dot(_498, _499)) / max(9.9999997473787516355514526367188e-06f, _498.z).xxx) - _499;
    float _507 = _43_m49 * _472;
    float _508 = _449.z;
    float4 _540 = _37.SampleBias(_28, (lerp(_4, _5, _43_m78.xx) * _43_m101.xy) + _43_m101.zw, _21_m16);
    float3 _566 = float3(_43_m90, _43_m92, _43_m94);
    float3 _584 = clamp((_566 * 0.5f.xxx) + lerp(-_566, 1.0f.xxx, _540.xyz + float3(_43_m91, _43_m93, _43_m95)), 0.0f.xxx, 1.0f.xxx) * float3(_43_m98.w, _43_m99.w, _43_m100.w);
    float _593 = _584.z;
    float _600 = _584.y;
    float _607 = _584.x;
    float4 _609 = lerp(lerp(lerp(float4(lerp(_420, lerp(clamp((_420 * _43_m54.xyz) * _43_m53, 0.0f.xxx, 1.0f.xxx), _43_m54.xyz, _43_m54.w.xxx), (_472 * ((1.0f - _43_m46) * (1.0f - _508))).xxx), lerp(lerp(_43_m2, _43_m3, _407), lerp(_450, _508, _43_m46), _507)), float4(_43_m100.xyz, _43_m85), _593.xxxx), float4(_43_m99.xyz, _43_m82), _600.xxxx), float4(_43_m98.xyz, _43_m79), _607.xxxx);
    float3 _300 = float3(_4.x, _333, _6.x);
    float3 _301 = float3(_4.y, _332.z, _6.y);
    uint _627 = uint(_43_m56);
    float2 _639 = (float2(_300[_627], _301[_627]) * _43_m58) + _43_m73.xy;
    float4 _643 = _40.SampleBias(_28, _639, _21_m16);
    float3 _644 = _643.xyz;
    float4 _656 = _41.SampleBias(_28, _639, _21_m16);
    float _672 = clamp(clamp((lerp(_7.y, normalize(mul(_506, float3x3(_348 * 1.0f, _350 * 1.0f, _7 * 1.0f))).y, _43_m76) - _43_m75) / max(1.1754943508222875079687365372222e-38f, _43_m74), 0.0f, 1.0f), 0.0f, 1.0f);
    float _673 = _656.x;
    float4 _675 = float4(_673, _656.y, 0.0f, 1.0f);
    _675.w = _673;
    float2 _681 = (_675.wy * 2.0f) - 1.0f.xx;
    float3 _682 = float3(_681.x, _681.y, _298.z);
    float2 _683 = _681.xy;
    _682.z = max(1.000000016862383526387164645044e-16f, sqrt(1.0f - clamp(dot(_683, _683), 0.0f, 1.0f)));
    float2 _691 = _682.xy * _43_m59;
    float3 _692 = float3(_691.x, _691.y, _682.z);
    float _704 = _643.w;
    float2 _723 = float2(1.0f - _672, _672);
    float2 _727 = _723 * float2(_39.SampleBias(_28, _639, _21_m16).x, _704);
    float2 _737 = (max(0.0f.xx, (_727 + _43_m57.xx) - max(_727.x, _727.y).xx) + 9.9999999747524270787835121154785e-07f.xx) * _723;
    float _748 = (_43_m65 != 0.0f) ? (_737 / max(1.1754943508222875079687365372222e-38f, _737.x + _737.y).xx).y : _672;
    float3 _749 = _506 + float3(0.0f, 0.0f, 1.0f);
    float3 _750 = _692 * float3(-1.0f, -1.0f, 1.0f);
    float3 _762 = _748.xxx;
    float3 _763 = lerp(_506, lerp(_692, ((_749 * dot(_749, _750)) / max(9.9999997473787516355514526367188e-06f, _749.z).xxx) - _750, _43_m63.xxx), _762);
    float3 _764 = lerp(_609.xyz, (lerp(dot(_644, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, _644, clamp(_43_m67 + 1.0f, 0.0f, 1.0f).xxx).xyz * _43_m72.xyz) * _43_m68, _762);
    float _765 = lerp(lerp(lerp(lerp(lerp(_389, _43_m17, clamp(_43_m15 - 1.0f, 0.0f, 1.0f)), _43_m88, _593), _43_m87, _600), _43_m86, _607), (_43_m61 != 0.0f) ? _704 : _43_m60, _748);
    float _766 = lerp(_609.w, _656.z, _748);
    float _767 = lerp(lerp(1.0f, _408, _43_m4) * lerp(1.0f, lerp(1.0f, _450, _43_m46), _507), (_43_m66 != 0.0f) ? 1.0f : lerp(1.0f, _656.w, _43_m62), _748);
    float3 _783 = normalize(((_8.xyz * _763.x) + (_350 * _763.y)) + (_7 * (_763.z * ((gl_FrontFacing ? true : false) ? 1.0f : ((_43_m7 > 0.0f) ? (-1.0f) : 1.0f)))));
    uint _786 = uint(_45_m3);
    float _808 = (((clamp(((_43_m19 * _766) + (_43_m21 * _765)) + _43_m20, 0.0f, 1.0f) * 0.949999988079071044921875f) + 0.0500000007450580596923828125f) * step(_748, 1.0f - _43_m64)) * (1.0f - _43_m29);
    float3 _1687;
    float _1688;
    float _1689;
    float3 _1690;
    float _1691;
    float _1692;
    float _1693;
    float3 _1694;
    [branch]
    if ((_EID3332CombinedEnableVirtualTextureBranch > 0.5f) && (_21_m4.w == 0.0f) && (_339 < 128.0f))
    {
        float4 _821 = _60.SampleLevel(_30, _320, 0.0f);
        float _822 = _821.x;
        float _830 = (1.0f / ((_21_m2.z * _822) + _21_m2.w)) - _339;
        float _838 = clamp(pow(abs(_830 * _43_m102), _43_m104), 0.0f, 1.0f);
        float _847 = lerp(clamp(pow(abs(_830 * _43_m108), _43_m109), 0.0f, 1.0f), 0.0f, _43_m110);
        float3 _1679;
        float _1680;
        float _1681;
        float3 _1682;
        float _1683;
        float _1684;
        float _1685;
        float3 _1686;
        [branch]
        if (min(_838, _847) < 0.999000012874603271484375f)
        {
            float _852 = _320.x;
            float4 _854 = float4(_852, _320.y, _822, 1.0f);
            float2 _859 = float2((_852 * 2.0f) - 1.0f, 1.0f - (2.0f * _320.y));
            float4 _861 = mul(_19_m6, float4(_859.x, _859.y, _854.z, _854.w));
            float3 _865 = _861.xyz / _861.w.xxx;
            bool _869 = _47_m5.x != 0;
            float _1632;
            float _1633;
            float _1634;
            float _1635;
            float3 _1636;
            float3 _1637;
            float _1638;
            if (_869)
            {
                float3 _872 = _865.xyz;
                float3 _873 = ddx(_872);
                float3 _874 = ddy(_872);
                float _878 = 1.0f / _47_m4.z;
                float2 _879 = _865.xz;
                float2 _889 = max(0.0f.xx, min((_879 * _878) - _47_m4.xy, float2(_47_m5.xx) - 9.9999999747524270787835121154785e-07f.xx));
                int2 _890 = int2(_889);
                float2 _891 = frac(_889);
                int2 _895 = _890 - _49_m3.xy;
                bool2 _896 = bool2(_890.x >= int2(0, 0).x, _890.y >= int2(0, 0).y);
                int2 _897 = _47_m5.x.xx;
                bool2 _898 = bool2(_890.x < _897.x, _890.y < _897.y);
                bool2 _899 = bool2(_896.x && _898.x, _896.y && _898.y);
                bool2 _900 = bool2(_895.x >= int2(0, 0).x, _895.y >= int2(0, 0).y);
                bool2 _901 = bool2(_899.x && _900.x, _899.y && _900.y);
                int2 _904 = _49_m3.z.xx;
                bool2 _905 = bool2(_895.x < _904.x, _895.y < _904.y);
                bool _907 = all(bool2(_901.x && _905.x, _901.y && _905.y));
                float4 _996;
                bool _997;
                if (_907)
                {
                    int _913 = (_895.y * _49_m3.z) + _895.x;
                    uint4 _924 = (_49_m0[clamp(_913 >> 2, 0, 63)] >> (uint((_913 & 3) << 3).xxxx & uint4(31u, 31u, 31u, 31u))) & uint4(255u, 255u, 255u, 255u);
                    uint _934 = (((_924.w << 24u) | (_924.z << 16u)) | (_924.y << 8u)) | _924.x;
                    uint _936 = (_934 >> 20u) & 1023u;
                    float _937 = float(_936);
                    float _940 = float(1u << (_936 & 31u));
                    float _960 = float(1u << (uint(_47_m6.x) & 31u)) * _47_m6.y;
                    float2 _961 = (_873.xz * _878) * _960;
                    float2 _962 = (_874.xz * _878) * _960;
                    float _963 = dot(_961, _961);
                    float _964 = dot(_962, _962);
                    float _965 = _47_m6.x - _937;
                    float4 _991 = round(_61.SampleLevel(_26, (floor(clamp(_891 * _940, 0.5f.xx, (_940 - 0.5f).xx) + float2(float(_934 & 1023u), float((_934 >> 10u) & 1023u))) + 0.5f.xx) * _47_m6.w, floor(clamp(lerp((0.5f * log2(max(_963, _964))) - _965, (0.5f * log2(min(_963, _964))) - _965, 0.449999988079071044921875f), 0.0f, _937))) * 255.0f);
                    float3 _992 = _991.xyz;
                    _996 = _991;
                    _997 = !all(bool3(_992.x > 254.0f.xxx.x, _992.y > 254.0f.xxx.y, _992.z > 254.0f.xxx.z));
                }
                else
                {
                    _996 = 0.0f.xxxx;
                    _997 = false;
                }
                float2 _1002 = clamp(_889, 0.0f.xx, (float(_47_m5.x) - 9.9999997473787516355514526367188e-05f).xx);
                int2 _1003 = int2(_1002);
                int _1004 = _1003.x;
                int _1005 = _1003.y;
                int _1008 = (_1004 | (_1004 << 4)) & 3855;
                int _1011 = (_1008 | (_1008 << 2)) & 13107;
                int _1017 = (_1005 | (_1005 << 4)) & 3855;
                int _1020 = (_1017 | (_1017 << 2)) & 13107;
                int _1025 = ((_1011 | (_1011 << 1)) & 21845) | (((_1020 | (_1020 << 1)) & 21845) << 1);
                uint4 _1036 = (_49_m1[clamp(_1025 >> 2, 0, 1023)] >> (uint((_1025 & 3) << 3).xxxx & uint4(31u, 31u, 31u, 31u))) & uint4(255u, 255u, 255u, 255u);
                uint _1046 = (((_1036.w << 24u) | (_1036.z << 16u)) | (_1036.y << 8u)) | _1036.x;
                int _1049 = int((_1046 >> 16u) & 255u);
                int2 _1051 = _1049.xx & int2(31, 31);
                float2 _1060 = (_1002 - float2((_1003 >> _1051) << _1051)) / float(1 << (_1049 & 31)).xx;
                float2 _1063 = float2(1.0f, _47_m14);
                int _1066 = int(_1046 & 65535u) - 1;
                float2 _1080 = float2(float(_1066 & (_47_m5.y - 1)), float(_1066 >> (_47_m5.z & 31))) * _47_m4.w;
                uint _1084 = uint(_1049) & 31u;
                float _1086 = float(_47_m11 >> _1084);
                float _1091 = float(_47_m12 << _1084);
                float2 _1092 = _1060 * _1091;
                float4 _1134 = (((_1060.xyxy * _47_m0.xxyy) + _1080.xyxy) + _47_m1.xxyy) * _1063.xyxy;
                float4 _1139 = _53.SampleLevel(_27, _1134.xy, 0.0f);
                float2 _1142 = (_1139.xy * 2.0f) - 1.0f.xx;
                float _1147 = sqrt(max(1.0f - dot(_1142, _1142), 0.0f));
                float3 _1149 = float3(_1142.x, _1147, _1142.y);
                float _1249;
                float _1250;
                float _1251;
                float _1252;
                float _1253;
                float3 _1254;
                float3 _1255;
                float _1256;
                if (_907 && _997)
                {
                    float2 _1194 = ((clamp(frac(_891 * float(uint(exp2(_47_m6.x - _996.z)))) * _47_m6.y, 0.5f.xx, (_47_m6.y - 0.5f).xx) + _47_m16.xx) + (_996.xy * _47_m15)) * _47_m6.z;
                    _1194.y = _1194.y * _47_m13;
                    float4 _1203 = _62.SampleLevel(_27, _1194, 0.0f);
                    float4 _1223;
                    if (_47_m17 > 0.0f)
                    {
                        float4 _1217 = _63.SampleLevel(_27, _1194, 0.0f);
                        float4 _1221 = _64.SampleLevel(_27, _1194, 0.0f);
                        _1223 = float4(_1217.x, _1217.y, _1221.x, _1221.y);
                    }
                    else
                    {
                        _1223 = _63.SampleLevel(_27, _1194, 0.0f);
                    }
                    float4 _1227 = _65.SampleLevel(_27, _1194, 0.0f);
                    float2 _1230 = (_1223.xy * 2.0f) - 1.0f.xx;
                    float _1243 = _1227.x;
                    _1249 = _1243;
                    _1250 = (_1223.w * 2.0f) - 1.0f;
                    _1251 = _1227.w;
                    _1252 = _1227.y;
                    _1253 = _1223.z;
                    _1254 = _1203.xyz;
                    _1255 = float3(_1230.x, sqrt(max(1.0f - dot(_1230, _1230), 0.0f)), _1230.y);
                    _1256 = clamp(_1203.w - _1243, 0.0f, 1.0f);
                }
                else
                {
                    _1249 = 0.5f;
                    _1250 = 0.0f;
                    _1251 = 0.0f;
                    _1252 = _1139.z;
                    _1253 = _1139.w;
                    _1254 = _54.SampleLevel(_27, _1134.zw, 0.0f).xyz;
                    _1255 = _1149;
                    _1256 = clamp(_55.SampleLevel(_27, ((_1080 + (((floor(_1092) + clamp(frac(_1092), (0.5f / _1086).xx, ((_1086 - 0.5f) * (1.0f / _1086)).xx)) / _1091.xx) * _47_m0.w)) + _47_m1.w.xx) * _1063, 0.0f).w - 0.5f, 0.0f, 1.0f);
                }
                float _1258 = clamp(_1256 * 2.17391300201416015625f, 0.0f, 1.0f);
                float3 _1261 = lerp(_1254, _1254 * 0.64999997615814208984375f, _1258.xxx);
                float _1262 = lerp(_1253, 0.0f, _1258);
                float _1264 = lerp(_1252, _1252 * 0.89999997615814208984375f, _1258);
                float3 _1268 = lerp(_1255, float3(0.0f, 1.0f, 0.0f), (min(_1258, 1.0f) * 0.980000019073486328125f).xxx);
                float _1278 = log2(1.0f / ((0.300000011920928955078125f * max(length(_873), length(_874))) + 6.103515625e-05f));
                float2 _1282 = exp2(float2(floor(_1278), ceil(_1278)));
                float3 _1285 = floor(_872 * _1282.x);
                uint2 _1287 = asuint(_1285.xy);
                uint _1292 = (_1287.x * 374761393u) + (_1287.y * 668265263u);
                uint _1295 = (_1292 ^ (_1292 >> 13u)) * 1274126177u;
                uint2 _1302 = asuint(float2(float(_1295 ^ (_1295 >> 16u)) * 2.3283064365386962890625e-10f, _1285.z));
                uint _1307 = (_1302.x * 374761393u) + (_1302.y * 668265263u);
                uint _1310 = (_1307 ^ (_1307 >> 13u)) * 1274126177u;
                float3 _1317 = floor(_872 * _1282.y);
                uint2 _1319 = asuint(_1317.xy);
                uint _1324 = (_1319.x * 374761393u) + (_1319.y * 668265263u);
                uint _1327 = (_1324 ^ (_1324 >> 13u)) * 1274126177u;
                uint2 _1334 = asuint(float2(float(_1327 ^ (_1327 >> 16u)) * 2.3283064365386962890625e-10f, _1317.z));
                uint _1339 = (_1334.x * 374761393u) + (_1334.y * 668265263u);
                uint _1342 = (_1339 ^ (_1339 >> 13u)) * 1274126177u;
                float _1347 = frac(_1278);
                float _1348 = lerp(float(_1310 ^ (_1310 >> 16u)) * 2.3283064365386962890625e-10f, float(_1342 ^ (_1342 >> 16u)) * 2.3283064365386962890625e-10f, _1347);
                float _1350 = min(_1347, 1.0f - _1347);
                float _1351 = 1.0f - _1350;
                float _1355 = (2.0f * _1350) * _1351;
                float _1360 = 1.0f - _1348;
                float3 _1366 = step(_1348.xxx, float3(_1350, _1351, 1.0f));
                float _1373 = clamp(dot(_1366 * (1.0f.xxx - float3(0.0f, _1366.xy)), float3((_1348 * _1348) / _1355, (_1348 - (0.5f * _1350)) / _1351, 1.0f - ((_1360 * _1360) / _1355))), 0.0f, 1.0f);
                float3 _1374 = abs(_1149);
                float3 _1375 = _1374 * _1374;
                float3 _1376 = _1375 * _1375;
                float3 _1377 = _1376 * _1376;
                float3 _1385 = _1377 / (((_1377.x + _1377.y) + _1377.z) + 6.103515625e-05f).xxx;
                float _1386 = _1385.x;
                float3 _1391 = step(_1373.xxx, float3(_1386, _1386 + _1385.y, 1.0f));
                float3 _1396 = _1391 * (1.0f.xxx - float3(0.0f, _1391.xy));
                float _1398 = _1396.x;
                float _1400 = _1396.y;
                float _1404 = _1396.z;
                float3 _1423 = cross(_1149, float3(0.0f, 0.0f, 1.0f));
                float2 _1426 = ((((_1060 * _47_m9.x) + _1080) + _47_m9.y.xx) * _1063) * _47_m8.xy;
                float2 _1429 = floor(_1426 - 0.5f.xx) + 0.5f.xx;
                float2 _1431 = _1426 - _1429;
                float2 _1432 = 1.0f.xx - _1431;
                float _1433 = _1432.x;
                float _1434 = _1432.y;
                float _1435 = _1433 * _1434;
                float _1440 = _1435 + (_1431.x * _1434);
                float4 _1444 = step(_1373.xxxx, float4(_1435, _1440, _1440 + (_1433 * _1431.y), 1.0f));
                uint _1452 = uint(dot(_1444 * (1.0f.xxxx - float4(0.0f, _1444.xyz)), float4(0.0f, 1.0f, 2.0f, 3.0f)));
                uint2 _1468 = uint2(floor((_57.SampleLevel(_26, _47_m8.zw * (_1429 + float2(float(_1452 & 1u), float(_1452 >> 1u))), 0.0f).xy * 255.5f) * 0.25f.xx));
                uint _1469 = _1468.y;
                float4 _1478 = _56.SampleLevel(_27, _1134.zw, 0.0f);
                float _1479 = _1478.w;
                float _1480 = _1479 * _1479;
                float _1486 = _51_m1[_1469].x * _47_m3.y;
                float2 _1491 = ((((_865.zy * _1398) + (_879 * _1400)) + (_865.xy * _1404)) * _1486) + _51_m1[_1469].z.xx;
                float4 _1492 = float4(((_873.zy * _1398) + (_873.xz * _1400)) + (_873.xy * _1404), ((_874.zy * _1398) + (_874.xz * _1400)) + (_874.xy * _1404)) * _1486;
                uint _1494 = uint(asint(_51_m1[_1469].y));
                float4 _1524;
                float2 _1525;
                [branch]
                if (((_1494 >> 13u) & 1u) == 0u)
                {
                    uint _1510 = (_1494 >> 11u) & 3u;
                    _1524 = min(_1492 * 0.5f, _47_m10.z.xxxx);
                    _1525 = clamp(frac(_1491) * 0.5f, _47_m10.xx, _47_m10.yy) + (float2(float(_1510 & 1u), float(_1510 >> 1u)) * 0.5f);
                }
                else
                {
                    _1524 = _1492;
                    _1525 = _1491;
                }
                float3 _1530 = float3(_1525, float((_1494 >> 6u) & 31u));
                float4 _1534 = _58.SampleGrad(_29, _1530, _1524.xy, _1524.zw);
                float4 _1538 = _59.SampleGrad(_29, _1530, _1524.xy, _1524.zw);
                float4 _1564 = (float4(0.0f, _1538.w, _1534.w, _1538.z) * _51_m4[_1469]) + _51_m3[_1469];
                float2 _1570 = ((_1538.xy * 2.0f) - 1.0f.xx).xy;
                float2 _1576 = _1570 * _51_m0[_1469].w;
                float _1587 = round(_51_m3[_1469].x * 255.0f);
                float _1596 = 1.0f - clamp(_1147, 0.0f, 1.0f);
                float _1599 = clamp(lerp(-3.0f, 4.0f, 5.0f * _1596), 0.0f, 1.0f);
                float _1602 = clamp(lerp(-0.20000000298023223876953125f, 1.2000000476837158203125f, 0.89999997615814208984375f * _1596), 0.0f, 1.0f);
                float3 _1603 = _1602.xxx;
                float2 _1611 = float2(_1249, lerp(_1249, _1564.z, _1602));
                float2 _1613 = (_1611 * _1611) * _1611;
                float2 _1619 = float2(_1613.x * (1.0f - _1599), _1613.y * _1599);
                float2 _1623 = _1619 / max(dot(_1619, 1.0f.xx), 6.103515625e-05f).xx;
                float _1624 = _1623.y;
                float3 _1625 = _1624.xxx;
                _1632 = _1250;
                _1633 = lerp(_1251, lerp(_1251, (_1587 == 19.0f) ? 1.0f : ((_1587 == 15.0f) ? 0.5f : 0.0f), _1602), _1624);
                _1634 = lerp(_1264, lerp(_1264, _1564.y, _1602), _1624);
                _1635 = lerp(_1262, lerp(_1262, _1564.w, _1602), _1624);
                _1636 = lerp(_1261, lerp(_1261, (_1534.xyz * _51_m2[_1469].xyz) + ((lerp(_1478.xyz, _51_m0[_1469].xyz, (1.0f - _1480).xxx) * _1480) - (_51_m0[_1469].xyz * _1480)), _1603), _1625);
                _1637 = normalize(lerp(_1268, normalize(lerp(_1268, normalize(((_1423 * _1576.x) + (cross(_1423, _1149) * _1576.y)) + (_1149 * max(6.103515625e-05f, sqrt(1.0f - clamp(dot(_1570, _1570), 0.0f, 1.0f))))), _1603)), _1625));
                _1638 = _1256;
            }
            else
            {
                _1632 = 0.0f;
                _1633 = 0.0f;
                _1634 = 0.0f;
                _1635 = 0.0f;
                _1636 = 0.0f.xxx;
                _1637 = 0.0f.xxx;
                _1638 = 0.0f;
            }
            float _1642 = lerp(_1638 * (1.0f - _847), _1638, _43_m110);
            float3 _1658 = _838.xxx;
            _1679 = lerp(_1637, _783, clamp(_838 + _43_m103, 0.0f, 1.0f).xxx);
            _1680 = lerp(_1635, lerp(_766, _766 * _43_m107, _1642), _838);
            _1681 = lerp(_1634, _767, _838);
            _1682 = lerp(0.0f.xxx, 0.0f.xxx, _1658);
            _1683 = lerp(clamp(((_1632 * _45_m1) + _45_m2) * (1.0f - clamp(abs((_1633 * 2.0f) - 1.0f), 0.0f, 1.0f)), 0.0f, 1.0f), 0.0f, _838);
            _1684 = lerp(0.0f, _808, _838);
            _1685 = lerp(_869 ? 0.0f : 0.0f, _765, _838);
            _1686 = lerp(_1636, lerp(_764, _764 * _43_m106, _1642.xxx), _1658);
        }
        else
        {
            _1679 = _783;
            _1680 = _766;
            _1681 = _767;
            _1682 = 0.0f.xxx;
            _1683 = 0.0f;
            _1684 = _808;
            _1685 = _765;
            _1686 = _764;
        }
        _1687 = _1679;
        _1688 = _1680;
        _1689 = _1681;
        _1690 = _1682;
        _1691 = _1683;
        _1692 = _1684;
        _1693 = _1685;
        _1694 = _1686;
    }
    else
    {
        _1687 = _783;
        _1688 = _766;
        _1689 = _767;
        _1690 = 0.0f.xxx;
        _1691 = 0.0f;
        _1692 = _808;
        _1693 = _765;
        _1694 = _764;
    }
    float _1704 = clamp(float(int(sign(max(_24_raw[uint(_11) * 16u + 4u].y, _24_raw[uint(_11) * 16u + 4u].z) + (-0.10000002384185791015625f)))), 0.0f, 1.0f);
    float2 _1717 = (_9.xy / max(_9.z, 9.9999999392252902907785028219223e-09f).xx) - (_10.xy / max(_10.z, 9.9999999392252902907785028219223e-09f).xx);
    _1717.y = -_1717.y;
    float2 _1741 = lerp(((sqrt(sqrt(abs(_1717 * 0.5f))) * float2(int2(sign(_1717)))) * 0.5f) + 0.5f.xx, ((sqrt(sqrt(abs(0.0f.xx))) * float2(int2(sign(0.0f.xx)))) * 0.5f) + 0.5f.xx, _1704.xx);
    float _1742 = lerp(0.0f, 0.699999988079071044921875f, _1704);
    float4 _1747 = float4(_1690.x, _1690.y, _1690.z, 0.0f.xxxx.w);
    _1747.w = 0.5f;
    float3 _1749 = normalize(_1687);
    float2 _1754 = _1749.xz / dot(1.0f.xxx, abs(_1749)).xx;
    float3 _1768;
    if (_1749.y <= 0.0f)
    {
        float2 _1763 = _1754.xy;
        bool2 _1764 = bool2(_1763.x >= 0.0f.xx.x, _1763.y >= 0.0f.xx.y);
        float2 _1766 = (1.0f.xx - abs(_1754.yx)) * float2(_1764.x ? 1.0f.xx.x : (-1.0f).xx.x, _1764.y ? 1.0f.xx.y : (-1.0f).xx.y);
        _1768 = float3(_1766.x, _1749.y, _1766.y);
    }
    else
    {
        _1768 = float3(_1754.x, _1749.y, _1754.y);
    }
    float2 _1771 = (_1768.xz * 0.5f) + 0.5f.xx;
    float4 _1772 = float4(_1771.x, _1771.y, 0.0f.xxxx.z, 0.0f.xxxx.w);
    _1772.z = _1688;
    _1772.w = float(_786 % 4u) * 0.3333333432674407958984375f;
    float4 _1782 = float4(_1694.x, _1694.y, _1694.z, 0.0f.xxxx.w);
    _1782.w = _1691;
    float4 _1784 = float4(_1741.x, _1741.y, 0.0f.xxxx.z, 0.0f.xxxx.w);
    _1784.z = (_1742 > 0.0f) ? 1.0f : _43_m28;
    _1784.w = _1742;
    _13 = _1747;
    _14 = float4(_1693, _1689, _1692, float(_786 / 4u) * 0.3333333432674407958984375f);
    _15 = _1772;
    _16 = _1782;
    _17 = _1784;
}

SPIRV_Cross_Output EID3490ExactPS(SPIRV_Cross_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    gl_FrontFacing = stage_input.gl_FrontFacing;
    _4 = stage_input._4;
    _5 = stage_input._5;
    _6 = stage_input._6;
    _7 = stage_input._7;
    _8 = stage_input._8;
    _9 = stage_input._9;
    _10 = stage_input._10;
    _11 = stage_input._11;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output._13 = _13;
    stage_output._14 = _14;
    stage_output._15 = _15;
    stage_output._16 = _16;
    stage_output._17 = _17;
    return stage_output;
}
#undef _26
#undef _27
#undef _28
#undef _29
#undef _30
#undef _34
#undef _36

#endif
