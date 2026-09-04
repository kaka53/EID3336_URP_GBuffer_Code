#ifndef EID3336_PS209987_EXACT_UNITY_INCLUDED
#define EID3336_PS209987_EXACT_UNITY_INCLUDED

// Generated from the original EID3336 PS 209987 SPIR-V.
// Arithmetic and branches are preserved by SPIRV-Cross. Only resource
// register annotations and sampler declarations are adapted for Unity.

#ifndef EID3336_PS_EXTERNAL_SAMPLERS
SamplerState sampler_PointClamp;
SamplerState sampler_LinearClamp;
SamplerState sampler_LinearRepeat;
#else
// URP Core already owns these global sampler symbols. Keep the recovered PS
// aliases mapped to those exact symbols without redeclaring them.
#endif

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

static float3 _299;

// Temporary EID3336 parity probes. These are passed explicitly to the debug MRT pass.
struct EID3336DebugData
{
    uint dbg1474;
    uint dbgSlice;
    float2 dbg1530;
    float2 dbg1529;
    float2 dbg1722;
    float4 dbg1539;
    float4 dbg1543;
};

// Global parity-probe values. Unity's HLSLcc backend may optimize inout
// struct members across frag_main; globals keep the probe observable.
static uint g_eid3336_dbg1474;
static uint g_eid3336_dbgSlice;
static float2 g_eid3336_dbg1530;
static float2 g_eid3336_dbg1529;
static float2 g_eid3336_dbg1722;
static float4 g_eid3336_dbg1539;
static float4 g_eid3336_dbg1543;

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
    // Unity/D3D11 ignores arrays of user structs in constant buffers.
    // Preserve the original 256 x 64-float layout as 4096 float4 registers.
    float4 _24_raw[4096] : packoffset(c0);
};

cbuffer _43_44
{
    float _44_m0 : packoffset(c0);
    float _44_m1 : packoffset(c0.y);
    float _44_m2 : packoffset(c0.z);
    float _44_m3 : packoffset(c0.w);
    float _44_m4 : packoffset(c1);
    float _44_m5 : packoffset(c1.y);
    float _44_m6 : packoffset(c1.z);
    float _44_m7 : packoffset(c1.w);
    float _44_m8 : packoffset(c2);
    float _44_m9 : packoffset(c2.y);
    float _44_m10 : packoffset(c2.z);
    float _44_m11 : packoffset(c2.w);
    float _44_m12 : packoffset(c3);
    float _44_m13 : packoffset(c3.y);
    float _44_m14 : packoffset(c3.z);
    float _44_m15 : packoffset(c3.w);
    float _44_m16 : packoffset(c4);
    float _44_m17 : packoffset(c4.y);
    float _44_m18 : packoffset(c4.z);
    float _44_m19 : packoffset(c4.w);
    float _44_m20 : packoffset(c5);
    float _44_m21 : packoffset(c5.y);
    float _44_m22 : packoffset(c5.z);
    float _44_m23 : packoffset(c5.w);
    float _44_m24 : packoffset(c6);
    float _44_m25 : packoffset(c6.y);
    float _44_m26 : packoffset(c6.z);
    float _44_m27 : packoffset(c6.w);
    float _44_m28 : packoffset(c7);
    float _44_m29 : packoffset(c7.y);
    float _44_m30 : packoffset(c7.z);
    float _44_m31 : packoffset(c7.w);
    float4 _44_m32 : packoffset(c8);
    float4 _44_m33 : packoffset(c9);
    float4 _44_m34 : packoffset(c10);
    float4 _44_m35 : packoffset(c11);
    float4 _44_m36 : packoffset(c12);
    float4 _44_m37 : packoffset(c13);
    float4 _44_m38 : packoffset(c14);
    float4 _44_m39 : packoffset(c15);
    float4 _44_m40 : packoffset(c16);
    float4 _44_m41 : packoffset(c17);
    float4 _44_m42 : packoffset(c18);
    float4 _44_m43 : packoffset(c19);
    float4 _44_m44 : packoffset(c20);
    float4 _44_m45 : packoffset(c21);
    float _44_m46 : packoffset(c22);
    float _44_m47 : packoffset(c22.y);
    float _44_m48 : packoffset(c22.z);
    float _44_m49 : packoffset(c22.w);
    float _44_m50 : packoffset(c23);
    float _44_m51 : packoffset(c23.y);
    float _44_m52 : packoffset(c23.z);
    float _44_m53 : packoffset(c23.w);
    float4 _44_m54 : packoffset(c24);
    float4 _44_m55 : packoffset(c25);
    float _44_m56 : packoffset(c26);
    float _44_m57 : packoffset(c26.y);
    float _44_m58 : packoffset(c26.z);
    float _44_m59 : packoffset(c26.w);
    float _44_m60 : packoffset(c27);
    float _44_m61 : packoffset(c27.y);
    float _44_m62 : packoffset(c27.z);
    float _44_m63 : packoffset(c27.w);
    float _44_m64 : packoffset(c28);
    float _44_m65 : packoffset(c28.y);
    float _44_m66 : packoffset(c28.z);
    float _44_m67 : packoffset(c28.w);
    float _44_m68 : packoffset(c29);
    float _44_m69 : packoffset(c29.y);
    float _44_m70 : packoffset(c29.z);
    float _44_m71 : packoffset(c29.w);
    float4 _44_m72 : packoffset(c30);
    float4 _44_m73 : packoffset(c31);
    float _44_m74 : packoffset(c32);
    float _44_m75 : packoffset(c32.y);
    float _44_m76 : packoffset(c32.z);
    float _44_m77 : packoffset(c32.w);
    float _44_m78 : packoffset(c33);
    float _44_m79 : packoffset(c33.y);
    float _44_m80 : packoffset(c33.z);
    float _44_m81 : packoffset(c33.w);
    float _44_m82 : packoffset(c34);
    float _44_m83 : packoffset(c34.y);
    float _44_m84 : packoffset(c34.z);
    float _44_m85 : packoffset(c34.w);
    float _44_m86 : packoffset(c35);
    float _44_m87 : packoffset(c35.y);
    float _44_m88 : packoffset(c35.z);
    float _44_m89 : packoffset(c35.w);
    float _44_m90 : packoffset(c36);
    float _44_m91 : packoffset(c36.y);
    float _44_m92 : packoffset(c36.z);
    float _44_m93 : packoffset(c36.w);
    float _44_m94 : packoffset(c37);
    float _44_m95 : packoffset(c37.y);
    float _44_m96 : packoffset(c37.z);
    float _44_m97 : packoffset(c37.w);
    float4 _44_m98 : packoffset(c38);
    float4 _44_m99 : packoffset(c39);
    float4 _44_m100 : packoffset(c40);
    float4 _44_m101 : packoffset(c41);
    float _44_m102 : packoffset(c42);
    float _44_m103 : packoffset(c42.y);
    float _44_m104 : packoffset(c42.z);
    float _44_m105 : packoffset(c42.w);
    float _44_m106 : packoffset(c43);
    float _44_m107 : packoffset(c43.y);
    float _44_m108 : packoffset(c43.z);
    float _44_m109 : packoffset(c43.w);
    float _44_m110 : packoffset(c44);
    float _44_m111 : packoffset(c44.y);
    float _44_m112 : packoffset(c44.z);
    float _44_m113 : packoffset(c44.w);
};

cbuffer _45_46
{
    float _46_m0 : packoffset(c0);
    float _46_m1 : packoffset(c0.y);
    float _46_m2 : packoffset(c0.z);
    float _46_m3 : packoffset(c0.w);
};

cbuffer _47_48
{
    float4 _48_m0 : packoffset(c0);
    float4 _48_m1 : packoffset(c1);
    float4 _48_m2 : packoffset(c2);
    float4 _48_m3 : packoffset(c3);
    float4 _48_m4 : packoffset(c4);
    int4 _48_m5 : packoffset(c5);
    float4 _48_m6 : packoffset(c6);
    float4 _48_m7 : packoffset(c7);
    float4 _48_m8 : packoffset(c8);
    float4 _48_m9 : packoffset(c9);
    float4 _48_m10 : packoffset(c10);
    uint _48_m11 : packoffset(c11);
    uint _48_m12 : packoffset(c11.y);
    float _48_m13 : packoffset(c11.z);
    float _48_m14 : packoffset(c11.w);
    float _48_m15 : packoffset(c12);
    float _48_m16 : packoffset(c12.y);
    float _48_m17 : packoffset(c12.z);
    float _48_m18 : packoffset(c12.w);
};

cbuffer _49_50
{
    uint4 _50_m0[64] : packoffset(c0);
    uint4 _50_m1[1024] : packoffset(c64);
    int4 _50_m2 : packoffset(c1088);
    int4 _50_m3 : packoffset(c1089);
    uint4 _50_m4 : packoffset(c1090);
};

cbuffer _51_52
{
    float4 _52_m0[64] : packoffset(c0);
    float4 _52_m1[64] : packoffset(c64);
    float4 _52_m2[64] : packoffset(c128);
    float4 _52_m3[64] : packoffset(c192);
    float4 _52_m4[64] : packoffset(c256);
    float4 _52_m5[64] : packoffset(c320);
    float4 _52_m6[64] : packoffset(c384);
};






Texture2D<float4> _33;

Texture2D<float4> _35;

Texture2D<float4> _37;
Texture2D<float4> _38;
Texture2D<float4> _39;
Texture2D<float4> _40;
Texture2D<float4> _41;
Texture2D<float4> _42;
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

EID3336DebugData frag_main(bool emitDebugPayload)
{
    EID3336DebugData debug;
    uint eid_dbg1474 = 0u;
    uint eid_dbgSlice = 0u;
    float2 eid_dbg1530 = 0.0f.xx;
    float4 eid_dbg1539 = 0.0f.xxxx;
    float4 eid_dbg1543 = 0.0f.xxxx;
    debug.dbg1474 = 0u;
    debug.dbgSlice = 0u;
    debug.dbg1530 = 0.0f.xx;
    debug.dbg1529 = 0.0f.xx;
    debug.dbg1722 = 0.0f.xx;
    debug.dbg1539 = 0.0f.xxxx;
    debug.dbg1543 = 0.0f.xxxx;
    float2 _321 = gl_FragCoord.xy * _21_m0.zw;
    float2 _323 = (_321 * 2.0f) - 1.0f.xx;
    float4 _326 = float4(_323, gl_FragCoord.z, 1.0f);
    _326.y = -_323.y;
    float4 _329 = mul(_19_m6, _326);
    float3 _333 = _329.xyz / _329.w.xxx;
    float _334 = _333.x;
    float _340 = abs(mul(_19_m0, float4(_334, _333.yz, 1.0f)).z);
    float _344 = (_8.w > 0.0f) ? 1.0f : (-1.0f);
    float4 _384 = _33.SampleBias(_34, (lerp(_4, _5, _44_m11.xx) * _44_m35.xy) + _44_m35.zw, _21_m16);
    float _386 = _384.w;
    float4 _389 = _35.SampleBias(_36, (lerp(_4, _5, _44_m12.xx) * _44_m36.xy) + _44_m36.zw, _44_m13 + _21_m16);
    float2 _392 = (_389.xy * 2.0f.xx) - 1.0f.xx;
    float2 _393 = abs(_392);
    bool2 _394 = bool2(_393.x < 0.01200000010430812835693359375f.xx.x, _393.y < 0.01200000010430812835693359375f.xx.y);
    float2 _395 = float2(_394.x ? 0.0f.xx.x : _392.x, _394.y ? 0.0f.xx.y : _392.y);
    float _404 = _389.z;
    float _405 = _389.w;
    float3 _417 = lerp(clamp((_384.xyz * _44_m32.xyz) * _44_m18, 0.0f.xxx, 1.0f.xxx), _44_m32.xyz, _44_m16.xxx);
    float4 _446 = _38.SampleBias(_28, (lerp(_4, _5, _44_m52.xx) * _44_m55.xy) + _44_m55.zw, _21_m16);
    float _447 = _446.w;
    float _469 = lerp(lerp(1.0f, _447, clamp(_44_m47, 0.0f, 1.0f)), lerp(lerp(_386, _404, clamp(_44_m47 - 2.0f, 0.0f, 1.0f)), _405, clamp(_44_m47 - 3.0f, 0.0f, 1.0f)), clamp(_44_m47 - 1.0f, 0.0f, 1.0f)) * clamp((_44_m51 - _340) / (_44_m51 - _44_m50), 0.0f, 1.0f);
    float2 _483 = (_446.xy * 2.0f.xx) - 1.0f.xx;
    float2 _484 = abs(_483);
    bool2 _485 = bool2(_484.x < 0.01200000010430812835693359375f.xx.x, _484.y < 0.01200000010430812835693359375f.xx.y);
    float2 _486 = float2(_485.x ? 0.0f.xx.x : _483.x, _485.y ? 0.0f.xx.y : _483.y);
    float3 _495 = float3(_395 * _44_m0, sqrt(clamp(1.0f - dot(_395, _395), 0.0f, 1.0f))) + float3(0.0f, 0.0f, 1.0f);
    float3 _496 = float3(_486 * (_469 * _44_m48), sqrt(clamp(1.0f - dot(_486, _486), 0.0f, 1.0f))) * float3(-1.0f, -1.0f, 1.0f);
    float3 _503 = ((_495 * dot(_495, _496)) / max(9.9999997473787516355514526367188e-06f, _495.z).xxx) - _496;
    float _504 = _44_m49 * _469;
    float _505 = _446.z;
    float4 _537 = _37.SampleBias(_28, (lerp(_4, _5, _44_m78.xx) * _44_m101.xy) + _44_m101.zw, _21_m16);
    float3 _563 = float3(_44_m90, _44_m92, _44_m94);
    float3 _581 = clamp((_563 * 0.5f.xxx) + lerp(-_563, 1.0f.xxx, _537.xyz + float3(_44_m91, _44_m93, _44_m95)), 0.0f.xxx, 1.0f.xxx) * float3(_44_m98.w, _44_m99.w, _44_m100.w);
    float _590 = _581.z;
    float _597 = _581.y;
    float _604 = _581.x;
    float4 _606 = lerp(lerp(lerp(float4(lerp(_417, lerp(clamp((_417 * _44_m54.xyz) * _44_m53, 0.0f.xxx, 1.0f.xxx), _44_m54.xyz, _44_m54.w.xxx), (_469 * ((1.0f - _44_m46) * (1.0f - _505))).xxx), lerp(lerp(_44_m2, _44_m3, _404), lerp(_447, _505, _44_m46), _504)), float4(_44_m100.xyz, _44_m85), _590.xxxx), float4(_44_m99.xyz, _44_m82), _597.xxxx), float4(_44_m98.xyz, _44_m79), _604.xxxx);
    float3 _301 = float3(_4.x, _334, _6.x);
    float3 _302 = float3(_4.y, _333.z, _6.y);
    uint _624 = uint(_44_m56);
    float2 _636 = (float2(_301[_624], _302[_624]) * _44_m58) + _44_m73.xy;
    float4 _640 = _41.SampleBias(_28, _636, _21_m16);
    float3 _641 = _640.xyz;
    float4 _653 = _42.SampleBias(_28, _636, _21_m16);
    float _654 = _653.w;
    bool2 _658 = (_44_m74 != 0.0f).xx;
    float _677;
    [branch]
    if (_44_m75 < 0.5f)
    {
        _677 = _39.SampleBias(_28, float2(_658.x ? _4.x : _5.x, _658.y ? _4.y : _5.y), _21_m16).x;
    }
    else
    {
        _677 = dot(float4(_654, _386, _405, 1.0f), step(abs((1.0f.xxxx * _44_m75) - float4(1.0f, 2.0f, 3.0f, 4.0f)), 0.5f.xxxx));
    }
    float _678 = clamp(_677, 0.0f, 1.0f);
    float _679 = _653.x;
    float4 _681 = float4(_679, _653.y, 0.0f, 1.0f);
    _681.w = _679;
    float2 _687 = (_681.wy * 2.0f) - 1.0f.xx;
    float3 _688 = float3(_687.x, _687.y, _299.z);
    float2 _689 = _687.xy;
    _688.z = max(1.000000016862383526387164645044e-16f, sqrt(1.0f - clamp(dot(_689, _689), 0.0f, 1.0f)));
    float2 _697 = _688.xy * _44_m59;
    float3 _698 = float3(_697.x, _697.y, _688.z);
    float _710 = _640.w;
    float4 _725 = _40.SampleBias(_28, _636, _21_m16);
    float2 _728 = float2(1.0f - _678, _678);
    float2 _732 = _728 * float2(_725.x, _710);
    float2 _742 = (max(0.0f.xx, (_732 + _44_m57.xx) - max(_732.x, _732.y).xx) + 9.9999999747524270787835121154785e-07f.xx) * _728;
    float _753 = (_44_m65 != 0.0f) ? (_742 / max(1.1754943508222875079687365372222e-38f, _742.x + _742.y).xx).y : _678;
    float3 _754 = _503 + float3(0.0f, 0.0f, 1.0f);
    float3 _755 = _698 * float3(-1.0f, -1.0f, 1.0f);
    float3 _767 = _753.xxx;
    float3 _768 = lerp(_503, lerp(_698, ((_754 * dot(_754, _755)) / max(9.9999997473787516355514526367188e-06f, _754.z).xxx) - _755, _44_m63.xxx), _767);
    float3 _769 = lerp(_606.xyz, (lerp(dot(_641, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, _641, clamp(_44_m67 + 1.0f, 0.0f, 1.0f).xxx).xyz * _44_m72.xyz) * _44_m68, _767);
    float _770 = lerp(lerp(lerp(lerp(lerp(_386, _44_m17, clamp(_44_m15 - 1.0f, 0.0f, 1.0f)), _44_m88, _590), _44_m87, _597), _44_m86, _604), (_44_m61 != 0.0f) ? _710 : _44_m60, _753);
    float _771 = lerp(_606.w, _653.z, _753);
    float _772 = lerp(lerp(1.0f, _405, _44_m4) * lerp(1.0f, lerp(1.0f, _447, _44_m46), _504), (_44_m66 != 0.0f) ? 1.0f : lerp(1.0f, _654, _44_m62), _753);
    float3 _788 = normalize(((_8.xyz * _768.x) + ((cross(_7, float4(_8.xyz, _344).xyz) * _344) * _768.y)) + (_7 * (_768.z * ((gl_FrontFacing ? true : false) ? 1.0f : ((_44_m7 > 0.0f) ? (-1.0f) : 1.0f)))));
    uint _791 = uint(_46_m3);
    float _813 = (((clamp(((_44_m19 * _771) + (_44_m21 * _770)) + _44_m20, 0.0f, 1.0f) * 0.949999988079071044921875f) + 0.0500000007450580596923828125f) * step(_753, 1.0f - _44_m64)) * (1.0f - _44_m29);
    float3 _1692;
    float _1693;
    float _1694;
    float3 _1695;
    float _1696;
    float _1697;
    float _1698;
    float3 _1699;
    [branch]
    if ((_21_m4.w == 0.0f) && (_340 < 128.0f))
    {
        float4 _826 = _60.SampleLevel(_30, _321, 0.0f);
        float _827 = _826.x;
        float _835 = (1.0f / ((_21_m2.z * _827) + _21_m2.w)) - _340;
        float _843 = clamp(pow(abs(_835 * _44_m102), _44_m104), 0.0f, 1.0f);
        float _852 = lerp(clamp(pow(abs(_835 * _44_m108), _44_m109), 0.0f, 1.0f), 0.0f, _44_m110);
        float3 _1684;
        float _1685;
        float _1686;
        float3 _1687;
        float _1688;
        float _1689;
        float _1690;
        float3 _1691;
        [branch]
        if (min(_843, _852) < 0.999000012874603271484375f)
        {
            float _857 = _321.x;
            float4 _859 = float4(_857, _321.y, _827, 1.0f);
            float2 _864 = float2((_857 * 2.0f) - 1.0f, 1.0f - (2.0f * _321.y));
            float4 _866 = mul(_19_m6, float4(_864.x, _864.y, _859.z, _859.w));
            float3 _870 = _866.xyz / _866.w.xxx;
            bool _874 = _48_m5.x != 0;
            float _1637;
            float _1638;
            float _1639;
            float _1640;
            float3 _1641;
            float3 _1642;
            float _1643;
            if (_874)
            {
                float3 _877 = _870.xyz;
                float3 _878 = ddx(_877);
                float3 _879 = ddy(_877);
                float _883 = 1.0f / _48_m4.z;
                float2 _884 = _870.xz;
                float2 _894 = max(0.0f.xx, min((_884 * _883) - _48_m4.xy, float2(_48_m5.xx) - 9.9999999747524270787835121154785e-07f.xx));
                int2 _895 = int2(_894);
                float2 _896 = frac(_894);
                int2 _900 = _895 - _50_m3.xy;
                bool2 _901 = bool2(_895.x >= int2(0, 0).x, _895.y >= int2(0, 0).y);
                int2 _902 = _48_m5.x.xx;
                bool2 _903 = bool2(_895.x < _902.x, _895.y < _902.y);
                bool2 _904 = bool2(_901.x && _903.x, _901.y && _903.y);
                bool2 _905 = bool2(_900.x >= int2(0, 0).x, _900.y >= int2(0, 0).y);
                bool2 _906 = bool2(_904.x && _905.x, _904.y && _905.y);
                int2 _909 = _50_m3.z.xx;
                bool2 _910 = bool2(_900.x < _909.x, _900.y < _909.y);
                bool _912 = all(bool2(_906.x && _910.x, _906.y && _910.y));
                float4 _1001;
                bool _1002;
                if (_912)
                {
                    int _918 = (_900.y * _50_m3.z) + _900.x;
                    uint4 _929 = (_50_m0[clamp(_918 >> 2, 0, 63)] >> (uint((_918 & 3) << 3).xxxx & uint4(31u, 31u, 31u, 31u))) & uint4(255u, 255u, 255u, 255u);
                    uint _939 = (((_929.w << 24u) | (_929.z << 16u)) | (_929.y << 8u)) | _929.x;
                    uint _941 = (_939 >> 20u) & 1023u;
                    float _942 = float(_941);
                    float _945 = float(1u << (_941 & 31u));
                    float _965 = float(1u << (uint(_48_m6.x) & 31u)) * _48_m6.y;
                    float2 _966 = (_878.xz * _883) * _965;
                    float2 _967 = (_879.xz * _883) * _965;
                    float _968 = dot(_966, _966);
                    float _969 = dot(_967, _967);
                    float _970 = _48_m6.x - _942;
                    float4 _996 = round(_61.SampleLevel(_26, (floor(clamp(_896 * _945, 0.5f.xx, (_945 - 0.5f).xx) + float2(float(_939 & 1023u), float((_939 >> 10u) & 1023u))) + 0.5f.xx) * _48_m6.w, floor(clamp(lerp((0.5f * log2(max(_968, _969))) - _970, (0.5f * log2(min(_968, _969))) - _970, 0.449999988079071044921875f), 0.0f, _942))) * 255.0f);
                    float3 _997 = _996.xyz;
                    _1001 = _996;
                    _1002 = !all(bool3(_997.x > 254.0f.xxx.x, _997.y > 254.0f.xxx.y, _997.z > 254.0f.xxx.z));
                }
                else
                {
                    _1001 = 0.0f.xxxx;
                    _1002 = false;
                }
                float2 _1007 = clamp(_894, 0.0f.xx, (float(_48_m5.x) - 9.9999997473787516355514526367188e-05f).xx);
                int2 _1008 = int2(_1007);
                int _1009 = _1008.x;
                int _1010 = _1008.y;
                int _1013 = (_1009 | (_1009 << 4)) & 3855;
                int _1016 = (_1013 | (_1013 << 2)) & 13107;
                int _1022 = (_1010 | (_1010 << 4)) & 3855;
                int _1025 = (_1022 | (_1022 << 2)) & 13107;
                int _1030 = ((_1016 | (_1016 << 1)) & 21845) | (((_1025 | (_1025 << 1)) & 21845) << 1);
                uint4 _1041 = (_50_m1[clamp(_1030 >> 2, 0, 1023)] >> (uint((_1030 & 3) << 3).xxxx & uint4(31u, 31u, 31u, 31u))) & uint4(255u, 255u, 255u, 255u);
                uint _1051 = (((_1041.w << 24u) | (_1041.z << 16u)) | (_1041.y << 8u)) | _1041.x;
                int _1054 = int((_1051 >> 16u) & 255u);
                int2 _1056 = _1054.xx & int2(31, 31);
                float2 _1065 = (_1007 - float2((_1008 >> _1056) << _1056)) / float(1 << (_1054 & 31)).xx;
                float2 _1068 = float2(1.0f, _48_m14);
                int _1071 = int(_1051 & 65535u) - 1;
                float2 _1085 = float2(float(_1071 & (_48_m5.y - 1)), float(_1071 >> (_48_m5.z & 31))) * _48_m4.w;
                uint _1089 = uint(_1054) & 31u;
                float _1091 = float(_48_m11 >> _1089);
                float _1096 = float(_48_m12 << _1089);
                float2 _1097 = _1065 * _1096;
                float4 _1139 = (((_1065.xyxy * _48_m0.xxyy) + _1085.xyxy) + _48_m1.xxyy) * _1068.xyxy;
                float4 _1144 = _53.SampleLevel(_27, _1139.xy, 0.0f);
                float2 _1147 = (_1144.xy * 2.0f) - 1.0f.xx;
                float _1152 = sqrt(max(1.0f - dot(_1147, _1147), 0.0f));
                float3 _1154 = float3(_1147.x, _1152, _1147.y);
                float _1254;
                float _1255;
                float _1256;
                float _1257;
                float _1258;
                float3 _1259;
                float3 _1260;
                float _1261;
                if (_912 && _1002)
                {
                    float2 _1199 = ((clamp(frac(_896 * float(uint(exp2(_48_m6.x - _1001.z)))) * _48_m6.y, 0.5f.xx, (_48_m6.y - 0.5f).xx) + _48_m16.xx) + (_1001.xy * _48_m15)) * _48_m6.z;
                    _1199.y = _1199.y * _48_m13;
                    float4 _1208 = _62.SampleLevel(_27, _1199, 0.0f);
                    float4 _1228;
                    if (_48_m17 > 0.0f)
                    {
                        float4 _1222 = _63.SampleLevel(_27, _1199, 0.0f);
                        float4 _1226 = _64.SampleLevel(_27, _1199, 0.0f);
                        _1228 = float4(_1222.x, _1222.y, _1226.x, _1226.y);
                    }
                    else
                    {
                        _1228 = _63.SampleLevel(_27, _1199, 0.0f);
                    }
                    float4 _1232 = _65.SampleLevel(_27, _1199, 0.0f);
                    float2 _1235 = (_1228.xy * 2.0f) - 1.0f.xx;
                    float _1248 = _1232.x;
                    _1254 = _1248;
                    _1255 = (_1228.w * 2.0f) - 1.0f;
                    _1256 = _1232.w;
                    _1257 = _1232.y;
                    _1258 = _1228.z;
                    _1259 = _1208.xyz;
                    _1260 = float3(_1235.x, sqrt(max(1.0f - dot(_1235, _1235), 0.0f)), _1235.y);
                    _1261 = clamp(_1208.w - _1248, 0.0f, 1.0f);
                }
                else
                {
                    _1254 = 0.5f;
                    _1255 = 0.0f;
                    _1256 = 0.0f;
                    _1257 = _1144.z;
                    _1258 = _1144.w;
                    _1259 = _54.SampleLevel(_27, _1139.zw, 0.0f).xyz;
                    _1260 = _1154;
                    _1261 = clamp(_55.SampleLevel(_27, ((_1085 + (((floor(_1097) + clamp(frac(_1097), (0.5f / _1091).xx, ((_1091 - 0.5f) * (1.0f / _1091)).xx)) / _1096.xx) * _48_m0.w)) + _48_m1.w.xx) * _1068, 0.0f).w - 0.5f, 0.0f, 1.0f);
                }
                float _1263 = clamp(_1261 * 2.17391300201416015625f, 0.0f, 1.0f);
                float3 _1266 = lerp(_1259, _1259 * 0.64999997615814208984375f, _1263.xxx);
                float _1267 = lerp(_1258, 0.0f, _1263);
                float _1269 = lerp(_1257, _1257 * 0.89999997615814208984375f, _1263);
                float3 _1273 = lerp(_1260, float3(0.0f, 1.0f, 0.0f), (min(_1263, 1.0f) * 0.980000019073486328125f).xxx);
                float _1283 = log2(1.0f / ((0.300000011920928955078125f * max(length(_878), length(_879))) + 6.103515625e-05f));
                float2 _1287 = exp2(float2(floor(_1283), ceil(_1283)));
                float3 _1290 = floor(_877 * _1287.x);
                uint2 _1292 = asuint(_1290.xy);
                uint _1297 = (_1292.x * 374761393u) + (_1292.y * 668265263u);
                uint _1300 = (_1297 ^ (_1297 >> 13u)) * 1274126177u;
                uint2 _1307 = asuint(float2(float(_1300 ^ (_1300 >> 16u)) * 2.3283064365386962890625e-10f, _1290.z));
                uint _1312 = (_1307.x * 374761393u) + (_1307.y * 668265263u);
                uint _1315 = (_1312 ^ (_1312 >> 13u)) * 1274126177u;
                float3 _1322 = floor(_877 * _1287.y);
                uint2 _1324 = asuint(_1322.xy);
                uint _1329 = (_1324.x * 374761393u) + (_1324.y * 668265263u);
                uint _1332 = (_1329 ^ (_1329 >> 13u)) * 1274126177u;
                uint2 _1339 = asuint(float2(float(_1332 ^ (_1332 >> 16u)) * 2.3283064365386962890625e-10f, _1322.z));
                uint _1344 = (_1339.x * 374761393u) + (_1339.y * 668265263u);
                uint _1347 = (_1344 ^ (_1344 >> 13u)) * 1274126177u;
                float _1352 = frac(_1283);
                float _1353 = lerp(float(_1315 ^ (_1315 >> 16u)) * 2.3283064365386962890625e-10f, float(_1347 ^ (_1347 >> 16u)) * 2.3283064365386962890625e-10f, _1352);
                float _1355 = min(_1352, 1.0f - _1352);
                float _1356 = 1.0f - _1355;
                float _1360 = (2.0f * _1355) * _1356;
                float _1365 = 1.0f - _1353;
                float3 _1371 = step(_1353.xxx, float3(_1355, _1356, 1.0f));
                float _1378 = clamp(dot(_1371 * (1.0f.xxx - float3(0.0f, _1371.xy)), float3((_1353 * _1353) / _1360, (_1353 - (0.5f * _1355)) / _1356, 1.0f - ((_1365 * _1365) / _1360))), 0.0f, 1.0f);
                float3 _1379 = abs(_1154);
                float3 _1380 = _1379 * _1379;
                float3 _1381 = _1380 * _1380;
                float3 _1382 = _1381 * _1381;
                float3 _1390 = _1382 / (((_1382.x + _1382.y) + _1382.z) + 6.103515625e-05f).xxx;
                float _1391 = _1390.x;
                float3 _1396 = step(_1378.xxx, float3(_1391, _1391 + _1390.y, 1.0f));
                float3 _1401 = _1396 * (1.0f.xxx - float3(0.0f, _1396.xy));
                float _1403 = _1401.x;
                float _1405 = _1401.y;
                float _1409 = _1401.z;
                float3 _1428 = cross(_1154, float3(0.0f, 0.0f, 1.0f));
                float2 _1431 = ((((_1065 * _48_m9.x) + _1085) + _48_m9.y.xx) * _1068) * _48_m8.xy;
                float2 _1434 = floor(_1431 - 0.5f.xx) + 0.5f.xx;
                float2 _1436 = _1431 - _1434;
                float2 _1437 = 1.0f.xx - _1436;
                float _1438 = _1437.x;
                float _1439 = _1437.y;
                float _1440 = _1438 * _1439;
                float _1445 = _1440 + (_1436.x * _1439);
                float4 _1449 = step(_1378.xxxx, float4(_1440, _1445, _1445 + (_1438 * _1436.y), 1.0f));
                uint _1457 = uint(dot(_1449 * (1.0f.xxxx - float4(0.0f, _1449.xyz)), float4(0.0f, 1.0f, 2.0f, 3.0f)));
                uint2 _1473 = uint2(floor((_57.SampleLevel(_26, _48_m8.zw * (_1434 + float2(float(_1457 & 1u), float(_1457 >> 1u))), 0.0f).xy * 255.5f) * 0.25f.xx));
                uint _1474 = _1473.y;
                eid_dbg1474 = _1474;
                debug.dbg1474 = _1474;
    g_eid3336_dbg1474 = _1474;
                float4 _1483 = _56.SampleLevel(_27, _1139.zw, 0.0f);
                float _1484 = _1483.w;
                float _1485 = _1484 * _1484;
                float _1491 = _52_m1[_1474].x * _48_m3.y;
                float2 _1496 = ((((_870.zy * _1403) + (_884 * _1405)) + (_870.xy * _1409)) * _1491) + _52_m1[_1474].z.xx;
                float4 _1497 = float4(((_878.zy * _1403) + (_878.xz * _1405)) + (_878.xy * _1409), ((_879.zy * _1403) + (_879.xz * _1405)) + (_879.xy * _1409)) * _1491;
                uint _1499 = uint(asint(_52_m1[_1474].y));
                float4 _1529;
                float2 _1530;
                [branch]
                if (((_1499 >> 13u) & 1u) == 0u)
                {
                    uint _1515 = (_1499 >> 11u) & 3u;
                    _1529 = min(_1497 * 0.5f, _48_m10.z.xxxx);
                    _1530 = clamp(frac(_1496) * 0.5f, _48_m10.xx, _48_m10.yy) + (float2(float(_1515 & 1u), float(_1515 >> 1u)) * 0.5f);
                }
                else
                {
                    _1529 = _1497;
                    _1530 = _1496;
                }
                eid_dbg1530 = _1530;
                debug.dbg1530 = _1530;
    g_eid3336_dbg1530 = _1530;
                debug.dbg1529 = _1529.xy;
    g_eid3336_dbg1529 = _1529.xy;
                float3 _1535 = float3(_1530, float((_1499 >> 6u) & 31u));
                eid_dbgSlice = (_1499 >> 6u) & 31u;
                debug.dbgSlice = eid_dbgSlice;
    g_eid3336_dbgSlice = (_1499 >> 6u) & 31u;
                float4 _1539 = _58.SampleGrad(_29, _1535, _1529.xy, _1529.zw);
                float4 _1543 = _59.SampleGrad(_29, _1535, _1529.xy, _1529.zw);
                eid_dbg1539 = _1539;
                debug.dbg1539 = _1539;
    g_eid3336_dbg1539 = _1539;
                eid_dbg1543 = _1543;
                debug.dbg1543 = _1543;
    g_eid3336_dbg1543 = _1543;
                float4 _1569 = (float4(0.0f, _1543.w, _1539.w, _1543.z) * _52_m4[_1474]) + _52_m3[_1474];
                float2 _1575 = ((_1543.xy * 2.0f) - 1.0f.xx).xy;
                float2 _1581 = _1575 * _52_m0[_1474].w;
                float _1592 = round(_52_m3[_1474].x * 255.0f);
                float _1601 = 1.0f - clamp(_1152, 0.0f, 1.0f);
                float _1604 = clamp(lerp(-3.0f, 4.0f, 5.0f * _1601), 0.0f, 1.0f);
                float _1607 = clamp(lerp(-0.20000000298023223876953125f, 1.2000000476837158203125f, 0.89999997615814208984375f * _1601), 0.0f, 1.0f);
                float3 _1608 = _1607.xxx;
                float2 _1616 = float2(_1254, lerp(_1254, _1569.z, _1607));
                float2 _1618 = (_1616 * _1616) * _1616;
                float2 _1624 = float2(_1618.x * (1.0f - _1604), _1618.y * _1604);
                float2 _1628 = _1624 / max(dot(_1624, 1.0f.xx), 6.103515625e-05f).xx;
                float _1629 = _1628.y;
                float3 _1630 = _1629.xxx;
                _1637 = _1255;
                _1638 = lerp(_1256, lerp(_1256, (_1592 == 19.0f) ? 1.0f : ((_1592 == 15.0f) ? 0.5f : 0.0f), _1607), _1629);
                _1639 = lerp(_1269, lerp(_1269, _1569.y, _1607), _1629);
                _1640 = lerp(_1267, lerp(_1267, _1569.w, _1607), _1629);
                _1641 = lerp(_1266, lerp(_1266, (_1539.xyz * _52_m2[_1474].xyz) + ((lerp(_1483.xyz, _52_m0[_1474].xyz, (1.0f - _1485).xxx) * _1485) - (_52_m0[_1474].xyz * _1485)), _1608), _1630);
                _1642 = normalize(lerp(_1273, normalize(lerp(_1273, normalize(((_1428 * _1581.x) + (cross(_1428, _1154) * _1581.y)) + (_1154 * max(6.103515625e-05f, sqrt(1.0f - clamp(dot(_1575, _1575), 0.0f, 1.0f))))), _1608)), _1630));
                _1643 = _1261;
            }
            else
            {
                _1637 = 0.0f;
                _1638 = 0.0f;
                _1639 = 0.0f;
                _1640 = 0.0f;
                _1641 = 0.0f.xxx;
                _1642 = 0.0f.xxx;
                _1643 = 0.0f;
            }
            float _1647 = lerp(_1643 * (1.0f - _852), _1643, _44_m110);
            float3 _1663 = _843.xxx;
            _1684 = lerp(_1642, _788, clamp(_843 + _44_m103, 0.0f, 1.0f).xxx);
            _1685 = lerp(_1640, lerp(_771, _771 * _44_m107, _1647), _843);
            _1686 = lerp(_1639, _772, _843);
            _1687 = lerp(0.0f.xxx, 0.0f.xxx, _1663);
            _1688 = lerp(clamp(((_1637 * _46_m1) + _46_m2) * (1.0f - clamp(abs((_1638 * 2.0f) - 1.0f), 0.0f, 1.0f)), 0.0f, 1.0f), 0.0f, _843);
            _1689 = lerp(0.0f, _813, _843);
            _1690 = lerp(_874 ? 0.0f : 0.0f, _770, _843);
            _1691 = lerp(_1641, lerp(_769, _769 * _44_m106, _1647.xxx), _1663);
        }
        else
        {
            _1684 = _788;
            _1685 = _771;
            _1686 = _772;
            _1687 = 0.0f.xxx;
            _1688 = 0.0f;
            _1689 = _813;
            _1690 = _770;
            _1691 = _769;
        }
        _1692 = _1684;
        _1693 = _1685;
        _1694 = _1686;
        _1695 = _1687;
        _1696 = _1688;
        _1697 = _1689;
        _1698 = _1690;
        _1699 = _1691;
    }
    else
    {
        _1692 = _788;
        _1693 = _771;
        _1694 = _772;
        _1695 = 0.0f.xxx;
        _1696 = 0.0f;
        _1697 = _813;
        _1698 = _770;
        _1699 = _769;
    }
    float _1709 = clamp(float(int(sign(max(_24_raw[uint(_11) * 16u + 4u].y, _24_raw[uint(_11) * 16u + 4u].z) + (-0.10000002384185791015625f)))), 0.0f, 1.0f);
    float2 _1722 = (_9.xy / max(_9.z, 9.9999999392252902907785028219223e-09f).xx) - (_10.xy / max(_10.z, 9.9999999392252902907785028219223e-09f).xx);
    _1722.y = -_1722.y;
    debug.dbg1722 = _1722;
    g_eid3336_dbg1722 = _1722;
    float2 _1746 = lerp(((sqrt(sqrt(abs(_1722 * 0.5f))) * float2(int2(sign(_1722)))) * 0.5f) + 0.5f.xx, ((sqrt(sqrt(abs(0.0f.xx))) * float2(int2(sign(0.0f.xx)))) * 0.5f) + 0.5f.xx, _1709.xx);
    float _1747 = lerp(0.0f, 0.699999988079071044921875f, _1709);
    float4 _1752 = float4(_1695.x, _1695.y, _1695.z, 0.0f.xxxx.w);
    _1752.w = 0.5f;
    float3 _1754 = normalize(_1692);
    float2 _1759 = _1754.xz / dot(1.0f.xxx, abs(_1754)).xx;
    float3 _1773;
    if (_1754.y <= 0.0f)
    {
        float2 _1768 = _1759.xy;
        bool2 _1769 = bool2(_1768.x >= 0.0f.xx.x, _1768.y >= 0.0f.xx.y);
        float2 _1771 = (1.0f.xx - abs(_1759.yx)) * float2(_1769.x ? 1.0f.xx.x : (-1.0f).xx.x, _1769.y ? 1.0f.xx.y : (-1.0f).xx.y);
        _1773 = float3(_1771.x, _1754.y, _1771.y);
    }
    else
    {
        _1773 = float3(_1759.x, _1754.y, _1759.y);
    }
    float2 _1776 = (_1773.xz * 0.5f) + 0.5f.xx;
    float4 _1777 = float4(_1776.x, _1776.y, 0.0f.xxxx.z, 0.0f.xxxx.w);
    _1777.z = _1693;
    _1777.w = float(_791 % 4u) * 0.3333333432674407958984375f;
    float4 _1787 = float4(_1699.x, _1699.y, _1699.z, 0.0f.xxxx.w);
    _1787.w = _1696;
    float4 _1789 = float4(_1746.x, _1746.y, 0.0f.xxxx.z, 0.0f.xxxx.w);
    _1789.z = (_1747 > 0.0f) ? 1.0f : _44_m28;
    _1789.w = _1747;
    _13 = _1752;
    _14 = float4(_1698, _1694, _1697, float(_791 / 4u) * 0.3333333432674407958984375f);
    _15 = _1777;
    _16 = _1787;
    _17 = _1789;
    if (emitDebugPayload)
    {
        _14 = eid_dbg1539;
        _15 = eid_dbg1543;
        _16 = float4(float(eid_dbg1474), float(eid_dbgSlice), eid_dbg1530.x, eid_dbg1530.y);
    }
    return debug;
}

SPIRV_Cross_Output EID3336ExactPS(SPIRV_Cross_Input stage_input)
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
    EID3336DebugData debug = frag_main(false);
    SPIRV_Cross_Output stage_output;
    stage_output._13 = _13;
    stage_output._14 = _14;
    stage_output._15 = _15;
    stage_output._16 = _16;
    stage_output._17 = _17;
    return stage_output;
}

SPIRV_Cross_Output EID3336ExactPSDebug(SPIRV_Cross_Input stage_input)
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
    EID3336DebugData debug = frag_main(false);
    SPIRV_Cross_Output stage_output;
    stage_output._13 = _13;
    stage_output._14 = float4(11.0f, 12.0f, 13.0f, 14.0f);
    stage_output._15 = float4(21.0f, 22.0f, 23.0f, 24.0f);
    stage_output._16 = float4(31.0f, 32.0f, 33.0f, 34.0f);
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

