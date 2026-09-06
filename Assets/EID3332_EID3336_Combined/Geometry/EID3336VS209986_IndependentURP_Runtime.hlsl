#ifndef EID3336_VS209986_INDEPENDENT_URP_INCLUDED
#define EID3336_VS209986_INDEPENDENT_URP_INCLUDED

// Exact SPIRV-Cross translation of captured VS resource 209986.
// Registers were removed so Unity binds the renamed cbuffer/SSBO symbols.
struct VS_29
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

static float4 VS_111;

float4x4 _EID3336PipelineMVP;

cbuffer VS_24_25
{
    column_major float4x4 VS_25_m0 : packoffset(c0);
    column_major float4x4 VS_25_m1 : packoffset(c4);
    column_major float4x4 VS_25_m2 : packoffset(c8);
    column_major float4x4 VS_25_m3 : packoffset(c12);
    column_major float4x4 VS_25_m4 : packoffset(c16);
    column_major float4x4 VS_25_m5 : packoffset(c20);
    column_major float4x4 VS_25_m6 : packoffset(c24);
    column_major float4x4 VS_25_m7 : packoffset(c28);
    column_major float4x4 VS_25_m8 : packoffset(c32);
    column_major float4x4 VS_25_m9 : packoffset(c36);
    column_major float4x4 VS_25_m10 : packoffset(c40);
    float4 VS_25_m11 : packoffset(c44);
    column_major float4x4 VS_25_m12 : packoffset(c45);
    column_major float4x4 VS_25_m13 : packoffset(c49);
    column_major float4x4 VS_25_m14 : packoffset(c53);
    column_major float4x4 VS_25_m15 : packoffset(c57);
    column_major float4x4 VS_25_m16 : packoffset(c61);
    column_major float4x4 VS_25_m17 : packoffset(c65);
    column_major float4x4 VS_25_m18 : packoffset(c69);
    column_major float4x4 VS_25_m19 : packoffset(c73);
    column_major float4x4 VS_25_m20 : packoffset(c77);
    float4 VS_25_m21 : packoffset(c81);
};

cbuffer VS_26_27
{
    float4 VS_27_m0 : packoffset(c0);
    float4 VS_27_m1 : packoffset(c1);
    float4 VS_27_m2 : packoffset(c2);
    float4 VS_27_m3 : packoffset(c3);
    float4 VS_27_m4 : packoffset(c4);
    float4 VS_27_m5 : packoffset(c5);
    float4 VS_27_m6[6] : packoffset(c6);
    float4 VS_27_m7[6] : packoffset(c12);
    float4 VS_27_m8 : packoffset(c18);
    float4 VS_27_m9 : packoffset(c19);
    float4 VS_27_m10 : packoffset(c20);
    float4 VS_27_m11 : packoffset(c21);
    float4 VS_27_m12 : packoffset(c22);
    float4 VS_27_m13 : packoffset(c23);
    float4 VS_27_m14 : packoffset(c24);
    float4 VS_27_m15 : packoffset(c25);
    float VS_27_m16 : packoffset(c26);
    float VS_27_m17 : packoffset(c26.y);
    float VS_27_m18 : packoffset(c26.z);
    uint VS_27_m19 : packoffset(c26.w);
    float4 VS_27_m20 : packoffset(c27);
    int4 VS_27_m21 : packoffset(c28);
    float4 VS_27_m22 : packoffset(c29);
    float4 VS_27_m23 : packoffset(c30);
    float4 VS_27_m24 : packoffset(c31);
    float4 VS_27_m25 : packoffset(c32);
    float4 VS_27_m26 : packoffset(c33);
    float4 VS_27_m27 : packoffset(c34);
    float4 VS_27_m28 : packoffset(c35);
    float4 VS_27_m29 : packoffset(c36);
    float4 VS_27_m30 : packoffset(c37);
    float4 VS_27_m31 : packoffset(c38);
    float4 VS_27_m32[4] : packoffset(c39);
    float4 VS_27_m33[4] : packoffset(c43);
    float4 VS_27_m34[4] : packoffset(c47);
    float4 VS_27_m35[4] : packoffset(c51);
    float4 VS_27_m36 : packoffset(c55);
    float4 VS_27_m37 : packoffset(c56);
    float4 VS_27_m38[4] : packoffset(c57);
    float4 VS_27_m39[4] : packoffset(c61);
    float4 VS_27_m40[4] : packoffset(c65);
    float4 VS_27_m41 : packoffset(c69);
    float4 VS_27_m42 : packoffset(c70);
    float4 VS_27_m43 : packoffset(c71);
    float4 VS_27_m44 : packoffset(c72);
    float4 VS_27_m45 : packoffset(c73);
    float4 VS_27_m46 : packoffset(c74);
    float4 VS_27_m47 : packoffset(c75);
    float4 VS_27_m48 : packoffset(c76);
    float4 VS_27_m49 : packoffset(c77);
    float4 VS_27_m50 : packoffset(c78);
    float4 VS_27_m51 : packoffset(c79);
    float4 VS_27_m52 : packoffset(c80);
    float4 VS_27_m53 : packoffset(c81);
    float4 VS_27_m54 : packoffset(c82);
    float4 VS_27_m55 : packoffset(c83);
    float4 VS_27_m56 : packoffset(c84);
    float4 VS_27_m57 : packoffset(c85);
    float4 VS_27_m58 : packoffset(c86);
    float4 VS_27_m59 : packoffset(c87);
    float4 VS_27_m60 : packoffset(c88);
    float4 VS_27_m61 : packoffset(c89);
    float4 VS_27_m62 : packoffset(c90);
    float4 VS_27_m63 : packoffset(c91);
    float4 VS_27_m64 : packoffset(c92);
    float4 VS_27_m65 : packoffset(c93);
    float4 VS_27_m66 : packoffset(c94);
    float4 VS_27_m67 : packoffset(c95);
    float4 VS_27_m68 : packoffset(c96);
    float4 VS_27_m69 : packoffset(c97);
    float4 VS_27_m70 : packoffset(c98);
    float4 VS_27_m71 : packoffset(c99);
    float4 VS_27_m72 : packoffset(c100);
    float4 VS_27_m73 : packoffset(c101);
    float4 VS_27_m74 : packoffset(c102);
    float4 VS_27_m75 : packoffset(c103);
    float4 VS_27_m76 : packoffset(c104);
    float4 VS_27_m77 : packoffset(c105);
    float4 VS_27_m78 : packoffset(c106);
    float4 VS_27_m79 : packoffset(c107);
    float4 VS_27_m80 : packoffset(c108);
    float4 VS_27_m81 : packoffset(c109);
    float4 VS_27_m82 : packoffset(c110);
    float4 VS_27_m83 : packoffset(c111);
    float4 VS_27_m84 : packoffset(c112);
    float4 VS_27_m85 : packoffset(c113);
    float4 VS_27_m86 : packoffset(c114);
    float4 VS_27_m87 : packoffset(c115);
    float4 VS_27_m88 : packoffset(c116);
    float4 VS_27_m89 : packoffset(c117);
    float4 VS_27_m90 : packoffset(c118);
    float4 VS_27_m91 : packoffset(c119);
    float4 VS_27_m92 : packoffset(c120);
    float4 VS_27_m93 : packoffset(c121);
    float4 VS_27_m94 : packoffset(c122);
    float4 VS_27_m95 : packoffset(c123);
    float4 VS_27_m96 : packoffset(c124);
    float4 VS_27_m97 : packoffset(c125);
    float4 VS_27_m98 : packoffset(c126);
    float4 VS_27_m99[2] : packoffset(c127);
    float4 VS_27_m100[2] : packoffset(c129);
    float VS_27_m101 : packoffset(c131);
    float VS_27_m102 : packoffset(c131.y);
    float VS_27_m103 : packoffset(c131.z);
    float VS_27_m104 : packoffset(c131.w);
    float4 VS_27_m105 : packoffset(c132);
    float4 VS_27_m106 : packoffset(c133);
    float4 VS_27_m107 : packoffset(c134);
    float4 VS_27_m108 : packoffset(c135);
    float4 VS_27_m109 : packoffset(c136);
    float4 VS_27_m110 : packoffset(c137);
    float4 VS_27_m111 : packoffset(c138);
    float4 VS_27_m112 : packoffset(c139);
    float4 VS_27_m113 : packoffset(c140);
    float4 VS_27_m114 : packoffset(c141);
    float4 VS_27_m115 : packoffset(c142);
    float4 VS_27_m116 : packoffset(c143);
    float4 VS_27_m117 : packoffset(c144);
    float4 VS_27_m118 : packoffset(c145);
    float4 VS_27_m119 : packoffset(c146);
    float4 VS_27_m120 : packoffset(c147);
    float4 VS_27_m121 : packoffset(c148);
    float4 VS_27_m122 : packoffset(c149);
    float4 VS_27_m123 : packoffset(c150);
    float4 VS_27_m124 : packoffset(c151);
    float4 VS_27_m125 : packoffset(c152);
    float4 VS_27_m126 : packoffset(c153);
    float4 VS_27_m127 : packoffset(c154);
    float4 VS_27_m128 : packoffset(c155);
    float4 VS_27_m129 : packoffset(c156);
    float4 VS_27_m130 : packoffset(c157);
    float4 VS_27_m131 : packoffset(c158);
    float4 VS_27_m132 : packoffset(c159);
    float4 VS_27_m133 : packoffset(c160);
    float4 VS_27_m134 : packoffset(c161);
    column_major float4x4 VS_27_m135 : packoffset(c162);
    float4 VS_27_m136 : packoffset(c166);
    float4 VS_27_m137 : packoffset(c167);
    float4 VS_27_m138[32] : packoffset(c168);
};

// Captured set/binding instance table: 256 records * 256 bytes.
// This is a storage buffer in the Vulkan capture, not a D3D constant buffer.
StructuredBuffer<VS_29> VS_30_m0;

// Unity replays the original instance-major draw as three ordered indexed draws.
// The explicit index preserves gl_InstanceIndex 0/1/2 without relying on a
// backend-specific instancing variant.
// Route B uses ordinary MeshRenderer transforms for live scene rendering. The
// remaining instance fields stay captured, while only the transform basis is
// overridden per renderer through a MaterialPropertyBlock.
VS_29 EID3336IndependentGetInstanceRecord()
{
    VS_29 record = VS_30_m0[0u];
    record._m0 = UNITY_MATRIX_M;
    record._m3 = UNITY_MATRIX_M;
    return record;
}


ByteAddressBuffer VS_32;

// Raw capture streams used by the procedural path. This preserves the Vulkan
// bindings exactly, including overlapping attributes and the stride-zero binding.
ByteAddressBuffer EID3336RawStream0;
ByteAddressBuffer EID3336RawStream1;
ByteAddressBuffer EID3336RawConstants;
ByteAddressBuffer EID3336RawIndices;

static float4 EID3336_VS_Position;
static int EID3336_VS_InstanceIndex;
static float3 VS_3;
static float VS_4;
static float4 VS_5;
static float4 VS_6;
static float2 VS_7;
static float2 VS_8;
static float2 VS_9;
static float4 VS_10;
static float4 VS_11;
static uint4 VS_12;
static float2 VS_15;
static float2 VS_16;
static float2 VS_17;
static float3 VS_18;
static float4 VS_19;
static float3 VS_21;
static float3 VS_22;
static uint VS_23;

struct EID3336_VS_Input
{
    float3 VS_3 : POSITION;
    float VS_4 : NORMAL;
    float4 VS_5 : TANGENT;
    float4 VS_6 : COLOR;
    float2 VS_7 : TEXCOORD0;
    float2 VS_8 : TEXCOORD1;
    float2 VS_9 : TEXCOORD2;
    float4 VS_10 : TEXCOORD3;
    float4 VS_11 : TEXCOORD4;
    uint4  VS_12 : TEXCOORD5;
    uint EID3336_VS_InstanceIndex : SV_InstanceID;
};

struct EID3336_VS_Output
{
    float2 VS_15 : TEXCOORD0;
    float2 VS_16 : TEXCOORD1;
    float2 VS_17 : TEXCOORD2;
    float3 VS_18 : TEXCOORD3;
    float4 VS_19 : TEXCOORD4;
    float3 VS_21 : TEXCOORD6;
    float3 VS_22 : TEXCOORD7;
    nointerpolation uint VS_23 : TEXCOORD8;
    precise float4 EID3336_VS_Position : SV_Position;
};

void EID3336_VS_MainBody()
{
    uint VS_125 = asuint(VS_4);
    bool VS_127 = (VS_125 & 1073741824u) > 0u;
    float4 VS_200;
    float3 VS_201;
    if (VS_127)
    {
        float VS_133 = float((VS_125 << 22u) >> 22u);
        float VS_136 = float((VS_125 << 12u) >> 22u);
        float VS_139 = float((VS_125 << 2u) >> 22u);
        float3 VS_153 = float3((VS_133 >= 512.0f) ? (VS_133 - 1024.0f) : VS_133, (VS_136 >= 512.0f) ? (VS_136 - 1024.0f) : VS_136, 0.0f) * 0.001956947147846221923828125f;
        float VS_159 = (1.0f - abs(VS_153.x)) - abs(VS_153.y);
        float3 VS_160 = VS_153;
        VS_160.z = VS_159;
        bool2 VS_162 = (VS_159 < 0.0f).xx;
        float2 VS_170 = (1.0f.xx - abs(VS_160.yx)) * ((step(0.0f.xx, VS_160.xy) * 2.0f) - 1.0f.xx);
        float2 VS_171 = float2(VS_162.x ? VS_170.x : VS_160.xy.x, VS_162.y ? VS_170.y : VS_160.xy.y);
        float3 VS_173 = normalize(float3(VS_171.x, VS_171.y, VS_160.z));
        float VS_174 = ((VS_139 >= 512.0f) ? (VS_139 - 1024.0f) : VS_139) * 0.001956947147846221923828125f;
        float3 VS_177 = VS_173.yzx - VS_173.zxy;
        float3 VS_181 = normalize(VS_177 - dot(VS_177, VS_173).xxx);
        float VS_186 = (VS_174 < 0.0f) ? (-1.0f) : 1.0f;
        float VS_189 = 1.0f - ((VS_174 * VS_186) * 2.0f);
        float3 VS_195 = mul(normalize(float2(VS_189, VS_186 * (1.0f - abs(VS_189)))), float2x3(VS_181, normalize(cross(VS_173, VS_181))));
        float4 VS_196 = float4(VS_195.x, VS_195.y, VS_195.z, VS_111.w);
        VS_196.w = (float((VS_125 >> 31u) & 1u) * 2.0f) - 1.0f;
        VS_200 = VS_196;
        VS_201 = VS_173;
    }
    else
    {
        VS_200 = 0.0f.xxxx;
        VS_201 = VS_4.xxx;
    }
    bool4 VS_202 = VS_127.xxxx;
    float4 VS_203 = float4(VS_202.x ? VS_200.x : VS_5.x, VS_202.y ? VS_200.y : VS_5.y, VS_202.z ? VS_200.z : VS_5.z, VS_202.w ? VS_200.w : VS_5.w);
    float4 VS_395;
    float3 VS_396;
    float3 VS_397;
    float3 VS_398;
    do
    {
        float4 VS_210 = float4(VS_3, 1.0f);
        uint VS_213 = asuint(EID3336IndependentGetInstanceRecord()._m1.w);
        uint VS_214 = VS_213 & 4294967247u;
        if (((VS_213 & 32u) == 0u) || (VS_214 == 0u))
        {
            VS_395 = VS_203;
            VS_396 = VS_3;
            VS_397 = VS_10.xyz;
            VS_398 = VS_201;
            break;
        }
        uint4 VS_230 = VS_12 * uint4(3u, 3u, 3u, 3u);
        uint4 VS_231 = (asuint(EID3336IndependentGetInstanceRecord()._m2.x) + 3u).xxxx + VS_230;
        uint4 VS_233 = (asuint(EID3336IndependentGetInstanceRecord()._m2.y) + 3u).xxxx + VS_230;
        uint VS_234 = VS_231.x;
        uint VS_237 = VS_234 + 1u;
        uint VS_240 = VS_234 + 2u;
        uint VS_243 = VS_233.x;
        uint VS_246 = VS_243 + 1u;
        uint VS_249 = VS_243 + 2u;
        float4 VS_295;
        float4 VS_296;
        float4 VS_297;
        float4 VS_298;
        float4 VS_299;
        float4 VS_300;
        if (VS_214 >= 2u)
        {
            uint VS_258 = VS_231.y;
            uint VS_278 = VS_233.y;
            VS_295 = (asfloat(VS_32.Load4(VS_249 * 16 + 0)) * VS_11.x) + (asfloat(VS_32.Load4((VS_278 + 2u) * 16 + 0)) * VS_11.y);
            VS_296 = (asfloat(VS_32.Load4(VS_246 * 16 + 0)) * VS_11.x) + (asfloat(VS_32.Load4((VS_278 + 1u) * 16 + 0)) * VS_11.y);
            VS_297 = (asfloat(VS_32.Load4(VS_243 * 16 + 0)) * VS_11.x) + (asfloat(VS_32.Load4(VS_278 * 16 + 0)) * VS_11.y);
            VS_298 = (asfloat(VS_32.Load4(VS_240 * 16 + 0)) * VS_11.x) + (asfloat(VS_32.Load4((VS_258 + 2u) * 16 + 0)) * VS_11.y);
            VS_299 = (asfloat(VS_32.Load4(VS_237 * 16 + 0)) * VS_11.x) + (asfloat(VS_32.Load4((VS_258 + 1u) * 16 + 0)) * VS_11.y);
            VS_300 = (asfloat(VS_32.Load4(VS_234 * 16 + 0)) * VS_11.x) + (asfloat(VS_32.Load4(VS_258 * 16 + 0)) * VS_11.y);
        }
        else
        {
            VS_295 = asfloat(VS_32.Load4(VS_249 * 16 + 0));
            VS_296 = asfloat(VS_32.Load4(VS_246 * 16 + 0));
            VS_297 = asfloat(VS_32.Load4(VS_243 * 16 + 0));
            VS_298 = asfloat(VS_32.Load4(VS_240 * 16 + 0));
            VS_299 = asfloat(VS_32.Load4(VS_237 * 16 + 0));
            VS_300 = asfloat(VS_32.Load4(VS_234 * 16 + 0));
        }
        float4 VS_368;
        float4 VS_369;
        float4 VS_370;
        float4 VS_371;
        float4 VS_372;
        float4 VS_373;
        if (VS_214 >= 4u)
        {
            uint VS_304 = VS_231.z;
            uint VS_310 = VS_231.w;
            uint VS_338 = VS_233.z;
            uint VS_342 = VS_233.w;
            VS_368 = VS_295 + ((asfloat(VS_32.Load4((VS_338 + 2u) * 16 + 0)) * VS_11.z) + (asfloat(VS_32.Load4((VS_342 + 2u) * 16 + 0)) * VS_11.w));
            VS_369 = VS_296 + ((asfloat(VS_32.Load4((VS_338 + 1u) * 16 + 0)) * VS_11.z) + (asfloat(VS_32.Load4((VS_342 + 1u) * 16 + 0)) * VS_11.w));
            VS_370 = VS_297 + ((asfloat(VS_32.Load4(VS_338 * 16 + 0)) * VS_11.z) + (asfloat(VS_32.Load4(VS_342 * 16 + 0)) * VS_11.w));
            VS_371 = VS_298 + ((asfloat(VS_32.Load4((VS_304 + 2u) * 16 + 0)) * VS_11.z) + (asfloat(VS_32.Load4((VS_310 + 2u) * 16 + 0)) * VS_11.w));
            VS_372 = VS_299 + ((asfloat(VS_32.Load4((VS_304 + 1u) * 16 + 0)) * VS_11.z) + (asfloat(VS_32.Load4((VS_310 + 1u) * 16 + 0)) * VS_11.w));
            VS_373 = VS_300 + ((asfloat(VS_32.Load4(VS_304 * 16 + 0)) * VS_11.z) + (asfloat(VS_32.Load4(VS_310 * 16 + 0)) * VS_11.w));
        }
        else
        {
            VS_368 = VS_295;
            VS_369 = VS_296;
            VS_370 = VS_297;
            VS_371 = VS_298;
            VS_372 = VS_299;
            VS_373 = VS_300;
        }
        float3 VS_389 = VS_203.xyz;
        float3 VS_393 = float3(dot(VS_373.xyz, VS_389), dot(VS_372.xyz, VS_389), dot(VS_371.xyz, VS_389));
        VS_395 = float4(VS_393.x, VS_393.y, VS_393.z, VS_203.w);
        VS_396 = float3(dot(VS_373, VS_210), dot(VS_372, VS_210), dot(VS_371, VS_210));
        VS_397 = float3(dot(VS_370, VS_210), dot(VS_369, VS_210), dot(VS_368, VS_210));
        VS_398 = float3(dot(VS_373.xyz, VS_201), dot(VS_372.xyz, VS_201), dot(VS_371.xyz, VS_201));
        break;
    } while(false);
    float3x3 VS_407 = float3x3(EID3336IndependentGetInstanceRecord()._m0[0].xyz, EID3336IndependentGetInstanceRecord()._m0[1].xyz, EID3336IndependentGetInstanceRecord()._m0[2].xyz);
    float3 VS_417 = mul(VS_407, VS_396) + float3(EID3336IndependentGetInstanceRecord()._m0[0].w, EID3336IndependentGetInstanceRecord()._m0[1].w, EID3336IndependentGetInstanceRecord()._m0[2].w);
    float3 VS_426 = mul(VS_407, float3(1.0f / dot(EID3336IndependentGetInstanceRecord()._m0[0].xyz, EID3336IndependentGetInstanceRecord()._m0[0].xyz), 1.0f / dot(EID3336IndependentGetInstanceRecord()._m0[1].xyz, EID3336IndependentGetInstanceRecord()._m0[1].xyz), 1.0f / dot(EID3336IndependentGetInstanceRecord()._m0[2].xyz, EID3336IndependentGetInstanceRecord()._m0[2].xyz)) * VS_398);
    float3 VS_432 = mul(VS_407, VS_395.xyz);
    float4 VS_453 = mul(_EID3336PipelineMVP, float4(VS_417, 1.0f));
    float2 VS_461 = VS_453.xy - ((VS_27_m9.zw * float2(2.0f, -2.0f)) * VS_453.w);
    float4 VS_462 = float4(VS_461.x, VS_461.y, VS_453.z, VS_453.w);
    bool3 VS_467 = (EID3336IndependentGetInstanceRecord()._m4.x < 1.0f).xxx;
    bool4 VS_473 = (EID3336IndependentGetInstanceRecord()._m4.y < 1.0f).xxxx;
    float4 VS_482 = float4(VS_417, 1.0f);
    float4 VS_502 = float4(mul(float3x3(EID3336IndependentGetInstanceRecord()._m3[0].xyz, EID3336IndependentGetInstanceRecord()._m3[1].xyz, EID3336IndependentGetInstanceRecord()._m3[2].xyz), float3(VS_467.x ? VS_396.x : VS_397.xyz.x, VS_467.y ? VS_396.y : VS_397.xyz.y, VS_467.z ? VS_396.z : VS_397.xyz.z)) + float3(EID3336IndependentGetInstanceRecord()._m3[0].w, EID3336IndependentGetInstanceRecord()._m3[1].w, EID3336IndependentGetInstanceRecord()._m3[2].w), 1.0f);
    VS_462.y = VS_461.y;
    EID3336_VS_Position = VS_462;
    VS_15 = VS_7;
    VS_16 = VS_8;
    VS_17 = VS_9;
    VS_18 = VS_426 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(VS_426, VS_426)));
    VS_19 = float4(VS_432 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(VS_432, VS_432))), VS_395.w * ((EID3336IndependentGetInstanceRecord()._m2.w >= 0.0f) ? 1.0f : (-1.0f)));
    VS_21 = VS_453.xyw;
    VS_22 = mul(_EID3336PipelineMVP, float4(VS_473.x ? VS_482.x : VS_502.x, VS_473.y ? VS_482.y : VS_502.y, VS_473.z ? VS_482.z : VS_502.z, VS_473.w ? VS_482.w : VS_502.w)).xyw;
    VS_23 = uint(EID3336_VS_InstanceIndex);
}

EID3336_VS_Output EID3336ExactVSCore(EID3336_VS_Input stage_input)
{
    EID3336_VS_InstanceIndex = 0u;
    VS_3 = stage_input.VS_3;
    VS_4 = stage_input.VS_4;
    VS_5 = stage_input.VS_5;
    VS_6 = stage_input.VS_6;
    VS_7 = stage_input.VS_7;
    VS_8 = stage_input.VS_8;
    VS_9 = stage_input.VS_9;
    VS_10 = stage_input.VS_10;
    VS_11 = stage_input.VS_11;
    VS_12 = stage_input.VS_12;
    EID3336_VS_MainBody();
    EID3336_VS_Output stage_output;
    stage_output.EID3336_VS_Position = EID3336_VS_Position;
    stage_output.VS_15 = VS_15;
    stage_output.VS_16 = VS_16;
    stage_output.VS_17 = VS_17;
    stage_output.VS_18 = VS_18;
    stage_output.VS_19 = VS_19;
    stage_output.VS_21 = VS_21;
    stage_output.VS_22 = VS_22;
    stage_output.VS_23 = VS_23;
    return stage_output;
}



float _EID3336RawStream1StrideBytes = 16.0f;

static uint EID3336LoadU16(ByteAddressBuffer buffer, uint byteAddress)
{
    uint word = buffer.Load(byteAddress & ~3u);
    return (word >> ((byteAddress & 2u) * 8u)) & 65535u;
}

static float4 EID3336DecodeUNorm8(uint packed)
{
    return float4(
        float(packed & 255u),
        float((packed >> 8u) & 255u),
        float((packed >> 16u) & 255u),
        float((packed >> 24u) & 255u)) / 255.0f;
}

EID3336_VS_Output EID3336ExactVSProcedural(uint vertexId : SV_VertexID)
{
    uint index = EID3336LoadU16(EID3336RawIndices, vertexId * 2u);
    uint stream0 = index * 16u;
    uint stream1 = index * (uint)_EID3336RawStream1StrideBytes;

    EID3336_VS_Input input;
    input.VS_3 = asfloat(EID3336RawStream0.Load3(stream0));
    input.VS_4 = asfloat(EID3336RawStream0.Load(stream0 + 12u));
    uint packedTangent = EID3336RawConstants.Load(12u);
    uint packedColor = EID3336RawConstants.Load(4u);
    input.VS_5 = EID3336DecodeUNorm8(packedTangent);
    input.VS_6 = EID3336DecodeUNorm8(packedColor);
    // RenderDoc's EID3315 layout aliases locations 4, 5, 6 and 7 to the
    // same R32G32 attribute at binding 1, whose stride is 8 bytes.  The
    // EID3332/EID3336 layout uses location 4 at offset 0 and locations 5-7
    // at offset 8 in a 16-byte record.  Keep the distinction profile-local:
    // with an 8-byte stream there is no second UV record to read at +8.
    float2 stream1Uv0 = asfloat(EID3336RawStream1.Load2(stream1));
    float2 stream1Uv1 = (_EID3336RawStream1StrideBytes <= 8.5f)
        ? stream1Uv0
        : asfloat(EID3336RawStream1.Load2(stream1 + 8u));
    input.VS_7 = stream1Uv0;
    input.VS_8 = stream1Uv1;
    input.VS_9 = stream1Uv1;
    input.VS_10 = float4(stream1Uv1, 0.0f, 1.0f);
    input.VS_11 = EID3336DecodeUNorm8(EID3336RawConstants.Load(16u));
    input.VS_12 = uint4(
        EID3336RawConstants.Load(0u),
        0u, 0u, 0u);
    return EID3336ExactVSCore(input);
}

EID3336_VS_Output EID3336ExactVS(EID3336_VS_Input stage_input)
{
    return EID3336ExactVSCore(stage_input);
}

#endif



