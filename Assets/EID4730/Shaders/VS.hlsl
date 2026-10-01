// Generated from original EID4730 SPIR-V. See Tools/EID4730/build_assets.py.
struct VS_28
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

#if !defined(EID_LIVE_MVP)
cbuffer VS_23_24 : register(b0)
{
    column_major float4x4 VS_24_m0 : packoffset(c0);
    column_major float4x4 VS_24_m1 : packoffset(c4);
    column_major float4x4 VS_24_m2 : packoffset(c8);
    column_major float4x4 VS_24_m3 : packoffset(c12);
    column_major float4x4 VS_24_m4 : packoffset(c16);
    column_major float4x4 VS_24_m5 : packoffset(c20);
    column_major float4x4 VS_24_m6 : packoffset(c24);
    column_major float4x4 VS_24_m7 : packoffset(c28);
    column_major float4x4 VS_24_m8 : packoffset(c32);
    column_major float4x4 VS_24_m9 : packoffset(c36);
    column_major float4x4 VS_24_m10 : packoffset(c40);
    float4 VS_24_m11 : packoffset(c44);
    column_major float4x4 VS_24_m12 : packoffset(c45);
    column_major float4x4 VS_24_m13 : packoffset(c49);
    column_major float4x4 VS_24_m14 : packoffset(c53);
    column_major float4x4 VS_24_m15 : packoffset(c57);
    column_major float4x4 VS_24_m16 : packoffset(c61);
    column_major float4x4 VS_24_m17 : packoffset(c65);
    column_major float4x4 VS_24_m18 : packoffset(c69);
    column_major float4x4 VS_24_m19 : packoffset(c73);
    column_major float4x4 VS_24_m20 : packoffset(c77);
    float4 VS_24_m21 : packoffset(c81);
};
#endif

#if !defined(EID_LIVE_MVP)
cbuffer VS_25_26 : register(b1)
{
    float4 VS_26_m0 : packoffset(c0);
    float4 VS_26_m1 : packoffset(c1);
    float4 VS_26_m2 : packoffset(c2);
    float4 VS_26_m3 : packoffset(c3);
    float4 VS_26_m4 : packoffset(c4);
    float4 VS_26_m5 : packoffset(c5);
    float4 VS_26_m6[6] : packoffset(c6);
    float4 VS_26_m7[6] : packoffset(c12);
    float4 VS_26_m8 : packoffset(c18);
    float4 VS_26_m9 : packoffset(c19);
    float4 VS_26_m10 : packoffset(c20);
    float4 VS_26_m11 : packoffset(c21);
    float4 VS_26_m12 : packoffset(c22);
    float4 VS_26_m13 : packoffset(c23);
    float4 VS_26_m14 : packoffset(c24);
    float4 VS_26_m15 : packoffset(c25);
    float VS_26_m16 : packoffset(c26);
    float VS_26_m17 : packoffset(c26.y);
    float VS_26_m18 : packoffset(c26.z);
    uint VS_26_m19 : packoffset(c26.w);
    float4 VS_26_m20 : packoffset(c27);
    int4 VS_26_m21 : packoffset(c28);
    float4 VS_26_m22 : packoffset(c29);
    float4 VS_26_m23 : packoffset(c30);
    float4 VS_26_m24 : packoffset(c31);
    float4 VS_26_m25 : packoffset(c32);
    float4 VS_26_m26 : packoffset(c33);
    float4 VS_26_m27 : packoffset(c34);
    float4 VS_26_m28 : packoffset(c35);
    float4 VS_26_m29 : packoffset(c36);
    float4 VS_26_m30 : packoffset(c37);
    float4 VS_26_m31 : packoffset(c38);
    float4 VS_26_m32[4] : packoffset(c39);
    float4 VS_26_m33[4] : packoffset(c43);
    float4 VS_26_m34[4] : packoffset(c47);
    float4 VS_26_m35[4] : packoffset(c51);
    float4 VS_26_m36 : packoffset(c55);
    float4 VS_26_m37 : packoffset(c56);
    float4 VS_26_m38[4] : packoffset(c57);
    float4 VS_26_m39[4] : packoffset(c61);
    float4 VS_26_m40[4] : packoffset(c65);
    float4 VS_26_m41 : packoffset(c69);
    float4 VS_26_m42 : packoffset(c70);
    float4 VS_26_m43 : packoffset(c71);
    float4 VS_26_m44 : packoffset(c72);
    float4 VS_26_m45 : packoffset(c73);
    float4 VS_26_m46 : packoffset(c74);
    float4 VS_26_m47 : packoffset(c75);
    float4 VS_26_m48 : packoffset(c76);
    float4 VS_26_m49 : packoffset(c77);
    float4 VS_26_m50 : packoffset(c78);
    float4 VS_26_m51 : packoffset(c79);
    float4 VS_26_m52 : packoffset(c80);
    float4 VS_26_m53 : packoffset(c81);
    float4 VS_26_m54 : packoffset(c82);
    float4 VS_26_m55 : packoffset(c83);
    float4 VS_26_m56 : packoffset(c84);
    float4 VS_26_m57 : packoffset(c85);
    float4 VS_26_m58 : packoffset(c86);
    float4 VS_26_m59 : packoffset(c87);
    float4 VS_26_m60 : packoffset(c88);
    float4 VS_26_m61 : packoffset(c89);
    float4 VS_26_m62 : packoffset(c90);
    float4 VS_26_m63 : packoffset(c91);
    float4 VS_26_m64 : packoffset(c92);
    float4 VS_26_m65 : packoffset(c93);
    float4 VS_26_m66 : packoffset(c94);
    float4 VS_26_m67 : packoffset(c95);
    float4 VS_26_m68 : packoffset(c96);
    float4 VS_26_m69 : packoffset(c97);
    float4 VS_26_m70 : packoffset(c98);
    float4 VS_26_m71 : packoffset(c99);
    float4 VS_26_m72 : packoffset(c100);
    float4 VS_26_m73 : packoffset(c101);
    float4 VS_26_m74 : packoffset(c102);
    float4 VS_26_m75 : packoffset(c103);
    float4 VS_26_m76 : packoffset(c104);
    float4 VS_26_m77 : packoffset(c105);
    float4 VS_26_m78 : packoffset(c106);
    float4 VS_26_m79 : packoffset(c107);
    float4 VS_26_m80 : packoffset(c108);
    float4 VS_26_m81 : packoffset(c109);
    float4 VS_26_m82 : packoffset(c110);
    float4 VS_26_m83 : packoffset(c111);
    float4 VS_26_m84 : packoffset(c112);
    float4 VS_26_m85 : packoffset(c113);
    float4 VS_26_m86 : packoffset(c114);
    float4 VS_26_m87 : packoffset(c115);
    float4 VS_26_m88 : packoffset(c116);
    float4 VS_26_m89 : packoffset(c117);
    float4 VS_26_m90 : packoffset(c118);
    float4 VS_26_m91 : packoffset(c119);
    float4 VS_26_m92 : packoffset(c120);
    float4 VS_26_m93 : packoffset(c121);
    float4 VS_26_m94 : packoffset(c122);
    float4 VS_26_m95 : packoffset(c123);
    float4 VS_26_m96 : packoffset(c124);
    float4 VS_26_m97 : packoffset(c125);
    float4 VS_26_m98 : packoffset(c126);
    float4 VS_26_m99[2] : packoffset(c127);
    float4 VS_26_m100[2] : packoffset(c129);
    float VS_26_m101 : packoffset(c131);
    float VS_26_m102 : packoffset(c131.y);
    float VS_26_m103 : packoffset(c131.z);
    float VS_26_m104 : packoffset(c131.w);
    float4 VS_26_m105 : packoffset(c132);
    float4 VS_26_m106 : packoffset(c133);
    float4 VS_26_m107 : packoffset(c134);
    float4 VS_26_m108 : packoffset(c135);
    float4 VS_26_m109 : packoffset(c136);
    float4 VS_26_m110 : packoffset(c137);
    float4 VS_26_m111 : packoffset(c138);
    float4 VS_26_m112 : packoffset(c139);
    float4 VS_26_m113 : packoffset(c140);
    float4 VS_26_m114 : packoffset(c141);
    float4 VS_26_m115 : packoffset(c142);
    float4 VS_26_m116 : packoffset(c143);
    float4 VS_26_m117 : packoffset(c144);
    float4 VS_26_m118 : packoffset(c145);
    float4 VS_26_m119 : packoffset(c146);
    float4 VS_26_m120 : packoffset(c147);
    float4 VS_26_m121 : packoffset(c148);
    float4 VS_26_m122 : packoffset(c149);
    float4 VS_26_m123 : packoffset(c150);
    float4 VS_26_m124 : packoffset(c151);
    float4 VS_26_m125 : packoffset(c152);
    float4 VS_26_m126 : packoffset(c153);
    float4 VS_26_m127 : packoffset(c154);
    float4 VS_26_m128 : packoffset(c155);
    float4 VS_26_m129 : packoffset(c156);
    float4 VS_26_m130 : packoffset(c157);
    float4 VS_26_m131 : packoffset(c158);
    float4 VS_26_m132 : packoffset(c159);
    float4 VS_26_m133 : packoffset(c160);
    float4 VS_26_m134 : packoffset(c161);
    column_major float4x4 VS_26_m135 : packoffset(c162);
    float4 VS_26_m136 : packoffset(c166);
    float4 VS_26_m137 : packoffset(c167);
    float4 VS_26_m138[32] : packoffset(c168);
};

cbuffer VS_27_29 : register(b2)
{
    float4 VS_29_m0_words[4096] : packoffset(c0);
};

ByteAddressBuffer VS_31;
#endif
#if !defined(EID_LIVE_PER_MATERIAL)
cbuffer VS_32_33 : register(b3)
{
    float VS_33_m0 : packoffset(c0);
    float VS_33_m1 : packoffset(c0.y);
    float VS_33_m2 : packoffset(c0.z);
    float VS_33_m3 : packoffset(c0.w);
    float VS_33_m4 : packoffset(c1);
    float VS_33_m5 : packoffset(c1.y);
    float VS_33_m6 : packoffset(c1.z);
    float VS_33_m7 : packoffset(c1.w);
    float VS_33_m8 : packoffset(c2);
    float VS_33_m9 : packoffset(c2.y);
    float VS_33_m10 : packoffset(c2.z);
    float VS_33_m11 : packoffset(c2.w);
    float VS_33_m12 : packoffset(c3);
    float VS_33_m13 : packoffset(c3.y);
    float VS_33_m14 : packoffset(c3.z);
    float VS_33_m15 : packoffset(c3.w);
    float VS_33_m16 : packoffset(c4);
    float VS_33_m17 : packoffset(c4.y);
    float VS_33_m18 : packoffset(c4.z);
    float VS_33_m19 : packoffset(c4.w);
    float VS_33_m20 : packoffset(c5);
    float VS_33_m21 : packoffset(c5.y);
    float VS_33_m22 : packoffset(c5.z);
    float VS_33_m23 : packoffset(c5.w);
    float4 VS_33_m24 : packoffset(c6);
    float4 VS_33_m25 : packoffset(c7);
    float4 VS_33_m26 : packoffset(c8);
    float4 VS_33_m27 : packoffset(c9);
    float4 VS_33_m28 : packoffset(c10);
    float4 VS_33_m29 : packoffset(c11);
    float VS_33_m30 : packoffset(c12);
    float VS_33_m31 : packoffset(c12.y);
    float VS_33_m32 : packoffset(c12.z);
    float VS_33_m33 : packoffset(c12.w);
    float4 VS_33_m34 : packoffset(c13);
    float4 VS_33_m35 : packoffset(c14);
    float4 VS_33_m36 : packoffset(c15);
    float4 VS_33_m37 : packoffset(c16);
    float4 VS_33_m38 : packoffset(c17);
    float4 VS_33_m39 : packoffset(c18);
    float VS_33_m40 : packoffset(c19);
    float VS_33_m41 : packoffset(c19.y);
    float VS_33_m42 : packoffset(c19.z);
    float VS_33_m43 : packoffset(c19.w);
    float VS_33_m44 : packoffset(c20);
    float VS_33_m45 : packoffset(c20.y);
    float VS_33_m46 : packoffset(c20.z);
    float VS_33_m47 : packoffset(c20.w);
};
#endif


static float4 VSgl_Position;
static int VSgl_InstanceIndex;
static float3 VS_3;
static float2 VS_4;
static float3 VS_5;
static float4 VS_6;
static float4 VS_7;
static float3 VS_8;
static float3 VS_9;
static float4 VS_11;
static uint4 VS_12;
static float2 VS_13;
static float3 VS_14;
static float3 VS_15;
static float4 VS_16;
static float3 VS_17;
static float3 VS_18;
static float3 VS_19;
static float3 VS_20;
static uint VS_22;

struct VSSPIRV_Cross_Input
{
    float3 VS_3 : TEXCOORD0;
    float2 VS_4 : TEXCOORD1;
    float3 VS_5 : TEXCOORD2;
    float4 VS_6 : TEXCOORD3;
    float4 VS_7 : TEXCOORD4;
    float3 VS_8 : TEXCOORD5;
    float3 VS_9 : TEXCOORD6;
    float4 VS_11 : TEXCOORD8;
    uint4 VS_12 : TEXCOORD9;
    uint VSgl_InstanceIndex : SV_InstanceID;
};

struct VSSPIRV_Cross_Output
{
    float2 VS_13 : TEXCOORD0;
    float3 VS_14 : TEXCOORD1;
    float3 VS_15 : TEXCOORD2;
    float4 VS_16 : TEXCOORD3;
    float3 VS_17 : TEXCOORD4;
    float3 VS_18 : TEXCOORD5;
    float3 VS_19 : TEXCOORD6;
    float3 VS_20 : TEXCOORD7;
    nointerpolation uint VS_22 : TEXCOORD8;
    float4 VSgl_Position : SV_Position;
};

static float4 VS_111;

#if !defined(EID_LIVE_MVP)
VS_28 VSGetInstance(uint index)
{
 VS_28 v; uint b=index*16u;
 v._m0 = transpose(float4x4(VS_29_m0_words[b+0], VS_29_m0_words[b+1], VS_29_m0_words[b+2], VS_29_m0_words[b+3]));
 v._m1 = VS_29_m0_words[b+4];
 v._m2 = VS_29_m0_words[b+5];
 v._m3 = transpose(float4x4(VS_29_m0_words[b+6], VS_29_m0_words[b+7], VS_29_m0_words[b+8], VS_29_m0_words[b+9]));
 v._m4 = VS_29_m0_words[b+10];
 v._m5 = VS_29_m0_words[b+11];
 v._m6 = VS_29_m0_words[b+12];
 v._m7 = VS_29_m0_words[b+13];
 v._m8 = VS_29_m0_words[b+14];
 v._m9 = VS_29_m0_words[b+15];
 return v;
}
#endif
void VSvert_main()
{
#if defined(EID_LIVE_MVP)
    float3 VS_202 = VS_5;
    float4 VS_205 = VS_6;
    float3 VS_247 = VS_9;
#else
    uint VS_127 = asuint(VS_5.x);
    bool VS_129 = (VS_127 & 1073741824u) > 0u;
    float3 VS_202;
    float4 VS_203;
    if (VS_129)
    {
        float VS_135 = float((VS_127 << 22u) >> 22u);
        float VS_138 = float((VS_127 << 12u) >> 22u);
        float VS_141 = float((VS_127 << 2u) >> 22u);
        float3 VS_155 = float3((VS_135 >= 512.0f) ? (VS_135 - 1024.0f) : VS_135, (VS_138 >= 512.0f) ? (VS_138 - 1024.0f) : VS_138, 0.0f) * 0.001956947147846221923828125f;
        float VS_161 = (1.0f - abs(VS_155.x)) - abs(VS_155.y);
        float3 VS_162 = VS_155;
        VS_162.z = VS_161;
        bool2 VS_164 = (VS_161 < 0.0f).xx;
        float2 VS_172 = (1.0f.xx - abs(VS_162.yx)) * ((step(0.0f.xx, VS_162.xy) * 2.0f) - 1.0f.xx);
        float2 VS_173 = float2(VS_164.x ? VS_172.x : VS_162.xy.x, VS_164.y ? VS_172.y : VS_162.xy.y);
        float3 VS_175 = normalize(float3(VS_173.x, VS_173.y, VS_162.z));
        float VS_176 = ((VS_141 >= 512.0f) ? (VS_141 - 1024.0f) : VS_141) * 0.001956947147846221923828125f;
        float3 VS_179 = VS_175.yzx - VS_175.zxy;
        float3 VS_183 = normalize(VS_179 - dot(VS_179, VS_175).xxx);
        float VS_187 = (VS_176 < 0.0f) ? (-1.0f) : 1.0f;
        float VS_190 = 1.0f - ((VS_176 * VS_187) * 2.0f);
        float3 VS_197 = mul(normalize(float2(VS_190, VS_187 * (1.0f - abs(VS_190)))), float2x3(VS_183, normalize(cross(VS_175, VS_183))));
        float4 VS_201 = float4(VS_197.x, VS_197.y, VS_197.z, VS_111.w);
        VS_201.w = (float((VS_127 >> 31u) & 1u) * 2.0f) - 1.0f;
        VS_202 = VS_175;
        VS_203 = VS_201;
    }
    else
    {
        VS_202 = VS_5;
        VS_203 = 0.0f.xxxx;
    }
    bool4 VS_204 = VS_129.xxxx;
    float4 VS_205 = float4(VS_204.x ? VS_203.x : VS_6.x, VS_204.y ? VS_203.y : VS_6.y, VS_204.z ? VS_203.z : VS_6.z, VS_204.w ? VS_203.w : VS_6.w);
    uint VS_207 = asuint(VS_9.x);
    float3 VS_247;
    if ((VS_207 & 1073741824u) > 0u)
    {
        float VS_215 = float((VS_207 << 22u) >> 22u);
        float VS_218 = float((VS_207 << 12u) >> 22u);
        float3 VS_226 = float3((VS_215 >= 512.0f) ? (VS_215 - 1024.0f) : VS_215, (VS_218 >= 512.0f) ? (VS_218 - 1024.0f) : VS_218, 0.0f) * 0.001956947147846221923828125f;
        float VS_232 = (1.0f - abs(VS_226.x)) - abs(VS_226.y);
        float3 VS_233 = VS_226;
        VS_233.z = VS_232;
        bool2 VS_235 = (VS_232 < 0.0f).xx;
        float2 VS_243 = (1.0f.xx - abs(VS_233.yx)) * ((step(0.0f.xx, VS_233.xy) * 2.0f) - 1.0f.xx);
        float2 VS_244 = float2(VS_235.x ? VS_243.x : VS_233.xy.x, VS_235.y ? VS_243.y : VS_233.xy.y);
        VS_247 = normalize(float3(VS_244.x, VS_244.y, VS_233.z));
    }
    else
    {
        VS_247 = VS_9;
    }
#endif
#if defined(EID_LIVE_MVP)
    uint VS_250 = 0u;
#else
    uint VS_250 = asuint(VSGetInstance(uint(VSgl_InstanceIndex))._m1.w);
#endif
    bool3 VS_253 = ((VS_250 & 16u) != 0u).xxx;
    float4 VS_439;
    float3 VS_440;
    float3 VS_441;
    float3 VS_442;
#if defined(EID_LIVE_MVP)
    VS_439 = VS_205;
    VS_440 = VS_202;
    VS_441 = VS_3;
    VS_442 = VS_7.xyz;
#else
    do
    {
        float4 VS_261 = float4(VS_3, 1.0f);
        uint VS_262 = VS_250 & 4294967247u;
        if (((VS_250 & 32u) == 0u) || (VS_262 == 0u))
        {
            VS_439 = VS_205;
            VS_440 = VS_202;
            VS_441 = VS_3;
            VS_442 = VS_7.xyz;
            break;
        }
        uint4 VS_278 = VS_12 * uint4(3u, 3u, 3u, 3u);
        uint4 VS_279 = (asuint(VSGetInstance(uint(VSgl_InstanceIndex))._m2.x) + 3u).xxxx + VS_278;
        uint4 VS_281 = (asuint(VSGetInstance(uint(VSgl_InstanceIndex))._m2.y) + 3u).xxxx + VS_278;
        uint VS_282 = VS_279.x;
        uint VS_285 = VS_282 + 1u;
        uint VS_288 = VS_282 + 2u;
        uint VS_291 = VS_281.x;
        uint VS_294 = VS_291 + 1u;
        uint VS_297 = VS_291 + 2u;
        float4 VS_341;
        float4 VS_342;
        float4 VS_343;
        float4 VS_344;
        float4 VS_345;
        float4 VS_346;
        if (VS_262 >= 2u)
        {
            uint VS_305 = VS_279.y;
            uint VS_324 = VS_281.y;
            VS_341 = (asfloat(VS_31.Load4(VS_297 * 16 + 0)) * VS_11.x) + (asfloat(VS_31.Load4((VS_324 + 2u) * 16 + 0)) * VS_11.y);
            VS_342 = (asfloat(VS_31.Load4(VS_294 * 16 + 0)) * VS_11.x) + (asfloat(VS_31.Load4((VS_324 + 1u) * 16 + 0)) * VS_11.y);
            VS_343 = (asfloat(VS_31.Load4(VS_291 * 16 + 0)) * VS_11.x) + (asfloat(VS_31.Load4(VS_324 * 16 + 0)) * VS_11.y);
            VS_344 = (asfloat(VS_31.Load4(VS_288 * 16 + 0)) * VS_11.x) + (asfloat(VS_31.Load4((VS_305 + 2u) * 16 + 0)) * VS_11.y);
            VS_345 = (asfloat(VS_31.Load4(VS_285 * 16 + 0)) * VS_11.x) + (asfloat(VS_31.Load4((VS_305 + 1u) * 16 + 0)) * VS_11.y);
            VS_346 = (asfloat(VS_31.Load4(VS_282 * 16 + 0)) * VS_11.x) + (asfloat(VS_31.Load4(VS_305 * 16 + 0)) * VS_11.y);
        }
        else
        {
            VS_341 = asfloat(VS_31.Load4(VS_297 * 16 + 0));
            VS_342 = asfloat(VS_31.Load4(VS_294 * 16 + 0));
            VS_343 = asfloat(VS_31.Load4(VS_291 * 16 + 0));
            VS_344 = asfloat(VS_31.Load4(VS_288 * 16 + 0));
            VS_345 = asfloat(VS_31.Load4(VS_285 * 16 + 0));
            VS_346 = asfloat(VS_31.Load4(VS_282 * 16 + 0));
        }
        float4 VS_412;
        float4 VS_413;
        float4 VS_414;
        float4 VS_415;
        float4 VS_416;
        float4 VS_417;
        if (VS_262 >= 4u)
        {
            uint VS_350 = VS_279.z;
            uint VS_355 = VS_279.w;
            uint VS_382 = VS_281.z;
            uint VS_386 = VS_281.w;
            VS_412 = VS_341 + ((asfloat(VS_31.Load4((VS_382 + 2u) * 16 + 0)) * VS_11.z) + (asfloat(VS_31.Load4((VS_386 + 2u) * 16 + 0)) * VS_11.w));
            VS_413 = VS_342 + ((asfloat(VS_31.Load4((VS_382 + 1u) * 16 + 0)) * VS_11.z) + (asfloat(VS_31.Load4((VS_386 + 1u) * 16 + 0)) * VS_11.w));
            VS_414 = VS_343 + ((asfloat(VS_31.Load4(VS_382 * 16 + 0)) * VS_11.z) + (asfloat(VS_31.Load4(VS_386 * 16 + 0)) * VS_11.w));
            VS_415 = VS_344 + ((asfloat(VS_31.Load4((VS_350 + 2u) * 16 + 0)) * VS_11.z) + (asfloat(VS_31.Load4((VS_355 + 2u) * 16 + 0)) * VS_11.w));
            VS_416 = VS_345 + ((asfloat(VS_31.Load4((VS_350 + 1u) * 16 + 0)) * VS_11.z) + (asfloat(VS_31.Load4((VS_355 + 1u) * 16 + 0)) * VS_11.w));
            VS_417 = VS_346 + ((asfloat(VS_31.Load4(VS_350 * 16 + 0)) * VS_11.z) + (asfloat(VS_31.Load4(VS_355 * 16 + 0)) * VS_11.w));
        }
        else
        {
            VS_412 = VS_341;
            VS_413 = VS_342;
            VS_414 = VS_343;
            VS_415 = VS_344;
            VS_416 = VS_345;
            VS_417 = VS_346;
        }
        float3 VS_433 = VS_205.xyz;
        float3 VS_437 = float3(dot(VS_417.xyz, VS_433), dot(VS_416.xyz, VS_433), dot(VS_415.xyz, VS_433));
        VS_439 = float4(VS_437.x, VS_437.y, VS_437.z, VS_205.w);
        VS_440 = float3(dot(VS_417.xyz, VS_202), dot(VS_416.xyz, VS_202), dot(VS_415.xyz, VS_202));
        VS_441 = float3(dot(VS_417, VS_261), dot(VS_416, VS_261), dot(VS_415, VS_261));
        VS_442 = float3(dot(VS_414, VS_261), dot(VS_413, VS_261), dot(VS_412, VS_261));
        break;
    } while(false);
#endif
#if defined(EID_LIVE_MVP)
    float3 worldPos = mul(unity_ObjectToWorld, float4(VS_441, 1.0f)).xyz;
    float4 clip = mul(unity_MatrixVP, float4(worldPos, 1.0f));
    float3 worldN = mul(VS_440, (float3x3)unity_WorldToObject);
    float worldN2 = dot(worldN, worldN);
    float3 worldT = mul(VS_439.xyz, (float3x3)unity_WorldToObject);
    float worldT2 = dot(worldT, worldT);
    VS_13 = (VS_4 * VS_33_m28.xy) + VS_33_m28.zw;
    VS_14 = worldPos - _WorldSpaceCameraPos;
    VS_15 = worldN * rsqrt(isnan(worldN2) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? worldN2 : max(1.1754943508222875079687365372222e-38f, worldN2)));
    VS_16 = float4(worldT * rsqrt(isnan(worldT2) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? worldT2 : max(1.1754943508222875079687365372222e-38f, worldT2))), VS_439.w);
    VS_17 = clip.xyw;
    VS_18 = clip.xyw;
    VS_19 = float3(VS_253.x ? VS_247.x : VS_202.x, VS_253.y ? VS_247.y : VS_202.y, VS_253.z ? VS_247.z : VS_202.z);
    VS_20 = VS_8;
    VSgl_Position = clip;
    VS_22 = uint(VSgl_InstanceIndex);
#else
    float3x3 VS_451 = float3x3(VSGetInstance(uint(VSgl_InstanceIndex))._m0[0].xyz, VSGetInstance(uint(VSgl_InstanceIndex))._m0[1].xyz, VSGetInstance(uint(VSgl_InstanceIndex))._m0[2].xyz);
    float3 VS_461 = mul(VS_451, VS_441) + (float3(VSGetInstance(uint(VSgl_InstanceIndex))._m0[0].w, VSGetInstance(uint(VSgl_InstanceIndex))._m0[1].w, VSGetInstance(uint(VSgl_InstanceIndex))._m0[2].w) - VS_24_m11.xyz);
    float4 VS_468 = mul(VS_24_m8, float4(VS_461, 1.0f));
    float2 VS_476 = VS_468.xy - ((VS_26_m9.zw * float2(2.0f, -2.0f)) * VS_468.w);
    float3 VS_484 = mul(VS_451, VS_440);
    float VS_485 = dot(VS_484, VS_484);
    float3 VS_490 = mul(VS_451, VS_439.xyz);
    float VS_491 = dot(VS_490, VS_490);
    bool3 VS_504 = (VSGetInstance(uint(VSgl_InstanceIndex))._m4.x < 1.0f).xxx;
    VS_13 = (VS_4 * VS_33_m28.xy) + VS_33_m28.zw;
    VS_14 = VS_461;
    VS_15 = VS_484 * rsqrt(isnan(VS_485) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? VS_485 : max(1.1754943508222875079687365372222e-38f, VS_485)));
    VS_16 = float4(VS_490 * rsqrt(isnan(VS_491) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? VS_491 : max(1.1754943508222875079687365372222e-38f, VS_491))), VS_439.w);
    VS_17 = VS_468.xyw;
    VS_18 = mul(VS_24_m15, float4(mul(float3x3(VSGetInstance(uint(VSgl_InstanceIndex))._m3[0].xyz, VSGetInstance(uint(VSgl_InstanceIndex))._m3[1].xyz, VSGetInstance(uint(VSgl_InstanceIndex))._m3[2].xyz), float3(VS_504.x ? VS_441.x : VS_442.xyz.x, VS_504.y ? VS_441.y : VS_442.xyz.y, VS_504.z ? VS_441.z : VS_442.xyz.z)) + (float3(VSGetInstance(uint(VSgl_InstanceIndex))._m3[0].w, VSGetInstance(uint(VSgl_InstanceIndex))._m3[1].w, VSGetInstance(uint(VSgl_InstanceIndex))._m3[2].w) - VS_24_m21.xyz), 1.0f)).xyw;
    VS_19 = float3(VS_253.x ? VS_247.x : VS_202.x, VS_253.y ? VS_247.y : VS_202.y, VS_253.z ? VS_247.z : VS_202.z);
    VS_20 = VS_8;
    float4 VS_536 = float4(VS_476.x, VS_476.y, VS_468.z, VS_468.w);
    VS_536.y = -VS_476.y;
    VSgl_Position = VS_536;
    VS_22 = uint(VSgl_InstanceIndex);
#endif
}

VSSPIRV_Cross_Output VSmain(VSSPIRV_Cross_Input stage_input)
{
    VSgl_InstanceIndex = int(stage_input.VSgl_InstanceIndex);
    VS_3 = stage_input.VS_3;
    VS_4 = stage_input.VS_4;
    VS_5 = stage_input.VS_5;
    VS_6 = stage_input.VS_6;
    VS_7 = stage_input.VS_7;
    VS_8 = stage_input.VS_8;
    VS_9 = stage_input.VS_9;
    VS_11 = stage_input.VS_11;
    VS_12 = stage_input.VS_12;
    VSvert_main();
    VSSPIRV_Cross_Output stage_output;
    stage_output.VSgl_Position = VSgl_Position;
    stage_output.VS_13 = VS_13;
    stage_output.VS_14 = VS_14;
    stage_output.VS_15 = VS_15;
    stage_output.VS_16 = VS_16;
    stage_output.VS_17 = VS_17;
    stage_output.VS_18 = VS_18;
    stage_output.VS_19 = VS_19;
    stage_output.VS_20 = VS_20;
    stage_output.VS_22 = VS_22;
    return stage_output;
}
