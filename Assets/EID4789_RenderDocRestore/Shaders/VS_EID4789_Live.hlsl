// Verified F:/endfield06.rdc EID4789, original SPIR-V algorithm, independent resources.
struct EID4789VS_28
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

static float4 EID4789VS_111;
static float3 EID4789BakedPosition;
static float3 EID4789BakedNormal;
static float4 EID4789BakedTangent;

cbuffer EID4789VS_23_24
{
    column_major float4x4 EID4789VS_24_m0 : packoffset(c0);
    column_major float4x4 EID4789VS_24_m1 : packoffset(c4);
    column_major float4x4 EID4789VS_24_m2 : packoffset(c8);
    column_major float4x4 EID4789VS_24_m3 : packoffset(c12);
    column_major float4x4 EID4789VS_24_m4 : packoffset(c16);
    column_major float4x4 EID4789VS_24_m5 : packoffset(c20);
    column_major float4x4 EID4789VS_24_m6 : packoffset(c24);
    column_major float4x4 EID4789VS_24_m7 : packoffset(c28);
    column_major float4x4 EID4789VS_24_m8 : packoffset(c32);
    column_major float4x4 EID4789VS_24_m9 : packoffset(c36);
    column_major float4x4 EID4789VS_24_m10 : packoffset(c40);
    float4 EID4789VS_24_m11 : packoffset(c44);
    column_major float4x4 EID4789VS_24_m12 : packoffset(c45);
    column_major float4x4 EID4789VS_24_m13 : packoffset(c49);
    column_major float4x4 EID4789VS_24_m14 : packoffset(c53);
    column_major float4x4 EID4789VS_24_m15 : packoffset(c57);
    column_major float4x4 EID4789VS_24_m16 : packoffset(c61);
    column_major float4x4 EID4789VS_24_m17 : packoffset(c65);
    column_major float4x4 EID4789VS_24_m18 : packoffset(c69);
    column_major float4x4 EID4789VS_24_m19 : packoffset(c73);
    column_major float4x4 EID4789VS_24_m20 : packoffset(c77);
    float4 EID4789VS_24_m21 : packoffset(c81);
};

cbuffer EID4789VS_25_26
{
    float4 EID4789VS_26_m0 : packoffset(c0);
    float4 EID4789VS_26_m1 : packoffset(c1);
    float4 EID4789VS_26_m2 : packoffset(c2);
    float4 EID4789VS_26_m3 : packoffset(c3);
    float4 EID4789VS_26_m4 : packoffset(c4);
    float4 EID4789VS_26_m5 : packoffset(c5);
    float4 EID4789VS_26_m6[6] : packoffset(c6);
    float4 EID4789VS_26_m7[6] : packoffset(c12);
    float4 EID4789VS_26_m8 : packoffset(c18);
    float4 EID4789VS_26_m9 : packoffset(c19);
    float4 EID4789VS_26_m10 : packoffset(c20);
    float4 EID4789VS_26_m11 : packoffset(c21);
    float4 EID4789VS_26_m12 : packoffset(c22);
    float4 EID4789VS_26_m13 : packoffset(c23);
    float4 EID4789VS_26_m14 : packoffset(c24);
    float4 EID4789VS_26_m15 : packoffset(c25);
    float EID4789VS_26_m16 : packoffset(c26);
    float EID4789VS_26_m17 : packoffset(c26.y);
    float EID4789VS_26_m18 : packoffset(c26.z);
    uint EID4789VS_26_m19 : packoffset(c26.w);
    float4 EID4789VS_26_m20 : packoffset(c27);
    int4 EID4789VS_26_m21 : packoffset(c28);
    float4 EID4789VS_26_m22 : packoffset(c29);
    float4 EID4789VS_26_m23 : packoffset(c30);
    float4 EID4789VS_26_m24 : packoffset(c31);
    float4 EID4789VS_26_m25 : packoffset(c32);
    float4 EID4789VS_26_m26 : packoffset(c33);
    float4 EID4789VS_26_m27 : packoffset(c34);
    float4 EID4789VS_26_m28 : packoffset(c35);
    float4 EID4789VS_26_m29 : packoffset(c36);
    float4 EID4789VS_26_m30 : packoffset(c37);
    float4 EID4789VS_26_m31 : packoffset(c38);
    float4 EID4789VS_26_m32[4] : packoffset(c39);
    float4 EID4789VS_26_m33[4] : packoffset(c43);
    float4 EID4789VS_26_m34[4] : packoffset(c47);
    float4 EID4789VS_26_m35[4] : packoffset(c51);
    float4 EID4789VS_26_m36 : packoffset(c55);
    float4 EID4789VS_26_m37 : packoffset(c56);
    float4 EID4789VS_26_m38[4] : packoffset(c57);
    float4 EID4789VS_26_m39[4] : packoffset(c61);
    float4 EID4789VS_26_m40[4] : packoffset(c65);
    float4 EID4789VS_26_m41 : packoffset(c69);
    float4 EID4789VS_26_m42 : packoffset(c70);
    float4 EID4789VS_26_m43 : packoffset(c71);
    float4 EID4789VS_26_m44 : packoffset(c72);
    float4 EID4789VS_26_m45 : packoffset(c73);
    float4 EID4789VS_26_m46 : packoffset(c74);
    float4 EID4789VS_26_m47 : packoffset(c75);
    float4 EID4789VS_26_m48 : packoffset(c76);
    float4 EID4789VS_26_m49 : packoffset(c77);
    float4 EID4789VS_26_m50 : packoffset(c78);
    float4 EID4789VS_26_m51 : packoffset(c79);
    float4 EID4789VS_26_m52 : packoffset(c80);
    float4 EID4789VS_26_m53 : packoffset(c81);
    float4 EID4789VS_26_m54 : packoffset(c82);
    float4 EID4789VS_26_m55 : packoffset(c83);
    float4 EID4789VS_26_m56 : packoffset(c84);
    float4 EID4789VS_26_m57 : packoffset(c85);
    float4 EID4789VS_26_m58 : packoffset(c86);
    float4 EID4789VS_26_m59 : packoffset(c87);
    float4 EID4789VS_26_m60 : packoffset(c88);
    float4 EID4789VS_26_m61 : packoffset(c89);
    float4 EID4789VS_26_m62 : packoffset(c90);
    float4 EID4789VS_26_m63 : packoffset(c91);
    float4 EID4789VS_26_m64 : packoffset(c92);
    float4 EID4789VS_26_m65 : packoffset(c93);
    float4 EID4789VS_26_m66 : packoffset(c94);
    float4 EID4789VS_26_m67 : packoffset(c95);
    float4 EID4789VS_26_m68 : packoffset(c96);
    float4 EID4789VS_26_m69 : packoffset(c97);
    float4 EID4789VS_26_m70 : packoffset(c98);
    float4 EID4789VS_26_m71 : packoffset(c99);
    float4 EID4789VS_26_m72 : packoffset(c100);
    float4 EID4789VS_26_m73 : packoffset(c101);
    float4 EID4789VS_26_m74 : packoffset(c102);
    float4 EID4789VS_26_m75 : packoffset(c103);
    float4 EID4789VS_26_m76 : packoffset(c104);
    float4 EID4789VS_26_m77 : packoffset(c105);
    float4 EID4789VS_26_m78 : packoffset(c106);
    float4 EID4789VS_26_m79 : packoffset(c107);
    float4 EID4789VS_26_m80 : packoffset(c108);
    float4 EID4789VS_26_m81 : packoffset(c109);
    float4 EID4789VS_26_m82 : packoffset(c110);
    float4 EID4789VS_26_m83 : packoffset(c111);
    float4 EID4789VS_26_m84 : packoffset(c112);
    float4 EID4789VS_26_m85 : packoffset(c113);
    float4 EID4789VS_26_m86 : packoffset(c114);
    float4 EID4789VS_26_m87 : packoffset(c115);
    float4 EID4789VS_26_m88 : packoffset(c116);
    float4 EID4789VS_26_m89 : packoffset(c117);
    float4 EID4789VS_26_m90 : packoffset(c118);
    float4 EID4789VS_26_m91 : packoffset(c119);
    float4 EID4789VS_26_m92 : packoffset(c120);
    float4 EID4789VS_26_m93 : packoffset(c121);
    float4 EID4789VS_26_m94 : packoffset(c122);
    float4 EID4789VS_26_m95 : packoffset(c123);
    float4 EID4789VS_26_m96 : packoffset(c124);
    float4 EID4789VS_26_m97 : packoffset(c125);
    float4 EID4789VS_26_m98 : packoffset(c126);
    float4 EID4789VS_26_m99[2] : packoffset(c127);
    float4 EID4789VS_26_m100[2] : packoffset(c129);
    float EID4789VS_26_m101 : packoffset(c131);
    float EID4789VS_26_m102 : packoffset(c131.y);
    float EID4789VS_26_m103 : packoffset(c131.z);
    float EID4789VS_26_m104 : packoffset(c131.w);
    float4 EID4789VS_26_m105 : packoffset(c132);
    float4 EID4789VS_26_m106 : packoffset(c133);
    float4 EID4789VS_26_m107 : packoffset(c134);
    float4 EID4789VS_26_m108 : packoffset(c135);
    float4 EID4789VS_26_m109 : packoffset(c136);
    float4 EID4789VS_26_m110 : packoffset(c137);
    float4 EID4789VS_26_m111 : packoffset(c138);
    float4 EID4789VS_26_m112 : packoffset(c139);
    float4 EID4789VS_26_m113 : packoffset(c140);
    float4 EID4789VS_26_m114 : packoffset(c141);
    float4 EID4789VS_26_m115 : packoffset(c142);
    float4 EID4789VS_26_m116 : packoffset(c143);
    float4 EID4789VS_26_m117 : packoffset(c144);
    float4 EID4789VS_26_m118 : packoffset(c145);
    float4 EID4789VS_26_m119 : packoffset(c146);
    float4 EID4789VS_26_m120 : packoffset(c147);
    float4 EID4789VS_26_m121 : packoffset(c148);
    float4 EID4789VS_26_m122 : packoffset(c149);
    float4 EID4789VS_26_m123 : packoffset(c150);
    float4 EID4789VS_26_m124 : packoffset(c151);
    float4 EID4789VS_26_m125 : packoffset(c152);
    float4 EID4789VS_26_m126 : packoffset(c153);
    float4 EID4789VS_26_m127 : packoffset(c154);
    float4 EID4789VS_26_m128 : packoffset(c155);
    float4 EID4789VS_26_m129 : packoffset(c156);
    float4 EID4789VS_26_m130 : packoffset(c157);
    float4 EID4789VS_26_m131 : packoffset(c158);
    float4 EID4789VS_26_m132 : packoffset(c159);
    float4 EID4789VS_26_m133 : packoffset(c160);
    float4 EID4789VS_26_m134 : packoffset(c161);
    column_major float4x4 EID4789VS_26_m135 : packoffset(c162);
    float4 EID4789VS_26_m136 : packoffset(c166);
    float4 EID4789VS_26_m137 : packoffset(c167);
    float4 EID4789VS_26_m138[32] : packoffset(c168);
};

cbuffer EID4789VS_27_29
{
    float4 EID4789VS_instanceRaw[4096] : packoffset(c0);
};

ByteAddressBuffer EID4789VS_31;
cbuffer EID4789VS_32_33
{
    float EID4789VS_33_m0 : packoffset(c0);
    float EID4789VS_33_m1 : packoffset(c0.y);
    float EID4789VS_33_m2 : packoffset(c0.z);
    float EID4789VS_33_m3 : packoffset(c0.w);
    float EID4789VS_33_m4 : packoffset(c1);
    float EID4789VS_33_m5 : packoffset(c1.y);
    float EID4789VS_33_m6 : packoffset(c1.z);
    float EID4789VS_33_m7 : packoffset(c1.w);
    float EID4789VS_33_m8 : packoffset(c2);
    float EID4789VS_33_m9 : packoffset(c2.y);
    float EID4789VS_33_m10 : packoffset(c2.z);
    float EID4789VS_33_m11 : packoffset(c2.w);
    float EID4789VS_33_m12 : packoffset(c3);
    float EID4789VS_33_m13 : packoffset(c3.y);
    float EID4789VS_33_m14 : packoffset(c3.z);
    float EID4789VS_33_m15 : packoffset(c3.w);
    float EID4789VS_33_m16 : packoffset(c4);
    float EID4789VS_33_m17 : packoffset(c4.y);
    float EID4789VS_33_m18 : packoffset(c4.z);
    float EID4789VS_33_m19 : packoffset(c4.w);
    float EID4789VS_33_m20 : packoffset(c5);
    float EID4789VS_33_m21 : packoffset(c5.y);
    float EID4789VS_33_m22 : packoffset(c5.z);
    float EID4789VS_33_m23 : packoffset(c5.w);
    float4 EID4789VS_33_m24 : packoffset(c6);
    float4 EID4789VS_33_m25 : packoffset(c7);
    float4 EID4789VS_33_m26 : packoffset(c8);
    float4 EID4789VS_33_m27 : packoffset(c9);
    float4 EID4789VS_33_m28 : packoffset(c10);
    float4 EID4789VS_33_m29 : packoffset(c11);
    float EID4789VS_33_m30 : packoffset(c12);
    float EID4789VS_33_m31 : packoffset(c12.y);
    float EID4789VS_33_m32 : packoffset(c12.z);
    float EID4789VS_33_m33 : packoffset(c12.w);
    float4 EID4789VS_33_m34 : packoffset(c13);
    float4 EID4789VS_33_m35 : packoffset(c14);
    float4 EID4789VS_33_m36 : packoffset(c15);
    float4 EID4789VS_33_m37 : packoffset(c16);
    float4 EID4789VS_33_m38 : packoffset(c17);
    float4 EID4789VS_33_m39 : packoffset(c18);
    float EID4789VS_33_m40 : packoffset(c19);
    float EID4789VS_33_m41 : packoffset(c19.y);
    float EID4789VS_33_m42 : packoffset(c19.z);
    float EID4789VS_33_m43 : packoffset(c19.w);
    float EID4789VS_33_m44 : packoffset(c20);
    float EID4789VS_33_m45 : packoffset(c20.y);
    float EID4789VS_33_m46 : packoffset(c20.z);
    float EID4789VS_33_m47 : packoffset(c20.w);
};


static float4 EID4789VS_gl_Position;
static int EID4789VS_gl_InstanceIndex;
static float3 EID4789VS_3;
static float2 EID4789VS_4;
static float3 EID4789VS_5;
static float4 EID4789VS_6;
static float4 EID4789VS_7;
static float3 EID4789VS_8;
static float3 EID4789VS_9;
static float4 EID4789VS_11;
static uint4 EID4789VS_12;
static float2 EID4789VS_13;
static float3 EID4789VS_14;
static float3 EID4789VS_15;
static float4 EID4789VS_16;
static float3 EID4789VS_17;
static float3 EID4789VS_18;
static float3 EID4789VS_19;
static float3 EID4789VS_20;
static uint EID4789VS_22;

EID4789VS_28 EID4789VS_LoadInstance(uint index) { uint b=index*16; EID4789VS_28 x;
x._m0=transpose(float4x4(EID4789VS_instanceRaw[b],EID4789VS_instanceRaw[b+1],EID4789VS_instanceRaw[b+2],EID4789VS_instanceRaw[b+3]));
x._m1=EID4789VS_instanceRaw[b+4];x._m2=EID4789VS_instanceRaw[b+5];
x._m3=transpose(float4x4(EID4789VS_instanceRaw[b+6],EID4789VS_instanceRaw[b+7],EID4789VS_instanceRaw[b+8],EID4789VS_instanceRaw[b+9]));
x._m4=EID4789VS_instanceRaw[b+10];
x._m5=EID4789VS_instanceRaw[b+11];
x._m6=EID4789VS_instanceRaw[b+12];
x._m7=EID4789VS_instanceRaw[b+13];
x._m8=EID4789VS_instanceRaw[b+14];
x._m9=EID4789VS_instanceRaw[b+15];
return x;}

struct EID4789VS_SPIRV_Cross_Input
{
    float3 EID4789VS_3 : TEXCOORD0;
    float2 EID4789VS_4 : TEXCOORD1;
    float3 EID4789VS_5 : TEXCOORD2;
    float4 EID4789VS_6 : TEXCOORD3;
    float4 EID4789VS_7 : TEXCOORD4;
    float3 EID4789VS_8 : TEXCOORD5;
    float3 EID4789VS_9 : TEXCOORD6;
    float4 EID4789VS_11 : TEXCOORD8;
    uint4 EID4789VS_12 : TEXCOORD9;
    uint EID4789VS_gl_InstanceIndex : SV_InstanceID;
};

struct EID4789VS_SPIRV_Cross_Output
{
    float2 EID4789VS_13 : TEXCOORD0;
    float3 EID4789VS_14 : TEXCOORD1;
    float3 EID4789VS_15 : TEXCOORD2;
    float4 EID4789VS_16 : TEXCOORD3;
    float3 EID4789VS_17 : TEXCOORD4;
    float3 EID4789VS_18 : TEXCOORD5;
    float3 EID4789VS_19 : TEXCOORD6;
    float3 EID4789VS_20 : TEXCOORD7;
    nointerpolation uint EID4789VS_22 : TEXCOORD8;
    float4 EID4789VS_gl_Position : SV_Position;
};

void EID4789VS_vert_main()
{
    uint EID4789VS_127 = asuint(EID4789VS_5.x);
    bool EID4789VS_129 = (EID4789VS_127 & 1073741824u) > 0u;
    float3 EID4789VS_202;
    float4 EID4789VS_203;
    if (EID4789VS_129)
    {
        float EID4789VS_135 = float((EID4789VS_127 << 22u) >> 22u);
        float EID4789VS_138 = float((EID4789VS_127 << 12u) >> 22u);
        float EID4789VS_141 = float((EID4789VS_127 << 2u) >> 22u);
        float3 EID4789VS_155 = float3((EID4789VS_135 >= 512.0f) ? (EID4789VS_135 - 1024.0f) : EID4789VS_135, (EID4789VS_138 >= 512.0f) ? (EID4789VS_138 - 1024.0f) : EID4789VS_138, 0.0f) * 0.001956947147846221923828125f;
        float EID4789VS_161 = (1.0f - abs(EID4789VS_155.x)) - abs(EID4789VS_155.y);
        float3 EID4789VS_162 = EID4789VS_155;
        EID4789VS_162.z = EID4789VS_161;
        bool2 EID4789VS_164 = (EID4789VS_161 < 0.0f).xx;
        float2 EID4789VS_172 = (1.0f.xx - abs(EID4789VS_162.yx)) * ((step(0.0f.xx, EID4789VS_162.xy) * 2.0f) - 1.0f.xx);
        float2 EID4789VS_173 = float2(EID4789VS_164.x ? EID4789VS_172.x : EID4789VS_162.xy.x, EID4789VS_164.y ? EID4789VS_172.y : EID4789VS_162.xy.y);
        float3 EID4789VS_175 = normalize(float3(EID4789VS_173.x, EID4789VS_173.y, EID4789VS_162.z));
        float EID4789VS_176 = ((EID4789VS_141 >= 512.0f) ? (EID4789VS_141 - 1024.0f) : EID4789VS_141) * 0.001956947147846221923828125f;
        float3 EID4789VS_179 = EID4789VS_175.yzx - EID4789VS_175.zxy;
        float3 EID4789VS_183 = normalize(EID4789VS_179 - dot(EID4789VS_179, EID4789VS_175).xxx);
        float EID4789VS_187 = (EID4789VS_176 < 0.0f) ? (-1.0f) : 1.0f;
        float EID4789VS_190 = 1.0f - ((EID4789VS_176 * EID4789VS_187) * 2.0f);
        float3 EID4789VS_197 = mul(normalize(float2(EID4789VS_190, EID4789VS_187 * (1.0f - abs(EID4789VS_190)))), float2x3(EID4789VS_183, normalize(cross(EID4789VS_175, EID4789VS_183))));
        float4 EID4789VS_198 = float4(EID4789VS_197.x, EID4789VS_197.y, EID4789VS_197.z, EID4789VS_111.w);
        EID4789VS_198.w = (float((EID4789VS_127 >> 31u) & 1u) * 2.0f) - 1.0f;
        EID4789VS_202 = EID4789VS_175;
        EID4789VS_203 = EID4789VS_198;
    }
    else
    {
        EID4789VS_202 = EID4789VS_5;
        EID4789VS_203 = 0.0f.xxxx;
    }
    bool4 EID4789VS_204 = EID4789VS_129.xxxx;
    float4 EID4789VS_205 = float4(EID4789VS_204.x ? EID4789VS_203.x : EID4789VS_6.x, EID4789VS_204.y ? EID4789VS_203.y : EID4789VS_6.y, EID4789VS_204.z ? EID4789VS_203.z : EID4789VS_6.z, EID4789VS_204.w ? EID4789VS_203.w : EID4789VS_6.w);
    uint EID4789VS_207 = asuint(EID4789VS_9.x);
    float3 EID4789VS_247;
    if ((EID4789VS_207 & 1073741824u) > 0u)
    {
        float EID4789VS_215 = float((EID4789VS_207 << 22u) >> 22u);
        float EID4789VS_218 = float((EID4789VS_207 << 12u) >> 22u);
        float3 EID4789VS_226 = float3((EID4789VS_215 >= 512.0f) ? (EID4789VS_215 - 1024.0f) : EID4789VS_215, (EID4789VS_218 >= 512.0f) ? (EID4789VS_218 - 1024.0f) : EID4789VS_218, 0.0f) * 0.001956947147846221923828125f;
        float EID4789VS_232 = (1.0f - abs(EID4789VS_226.x)) - abs(EID4789VS_226.y);
        float3 EID4789VS_233 = EID4789VS_226;
        EID4789VS_233.z = EID4789VS_232;
        bool2 EID4789VS_235 = (EID4789VS_232 < 0.0f).xx;
        float2 EID4789VS_243 = (1.0f.xx - abs(EID4789VS_233.yx)) * ((step(0.0f.xx, EID4789VS_233.xy) * 2.0f) - 1.0f.xx);
        float2 EID4789VS_244 = float2(EID4789VS_235.x ? EID4789VS_243.x : EID4789VS_233.xy.x, EID4789VS_235.y ? EID4789VS_243.y : EID4789VS_233.xy.y);
        EID4789VS_247 = normalize(float3(EID4789VS_244.x, EID4789VS_244.y, EID4789VS_233.z));
    }
    else
    {
        EID4789VS_247 = EID4789VS_9;
    }
    uint EID4789VS_250 = asuint(EID4789VS_LoadInstance(uint(EID4789VS_gl_InstanceIndex))._m1.w);
    bool3 EID4789VS_253 = ((EID4789VS_250 & 16u) != 0u).xxx;
    float4 EID4789VS_439;
    float3 EID4789VS_440;
    float3 EID4789VS_441;
    float3 EID4789VS_442;
    do
    {
        float4 EID4789VS_261 = float4(EID4789VS_3, 1.0f);
        uint EID4789VS_262 = EID4789VS_250 & 4294967247u;
        if (((EID4789VS_250 & 32u) == 0u) || (EID4789VS_262 == 0u))
        {
            EID4789VS_439 = EID4789VS_205;
            EID4789VS_440 = EID4789VS_202;
            EID4789VS_441 = EID4789VS_3;
            EID4789VS_442 = EID4789VS_7.xyz;
            break;
        }
        uint4 EID4789VS_278 = EID4789VS_12 * uint4(3u, 3u, 3u, 3u);
        uint4 EID4789VS_279 = (asuint(EID4789VS_LoadInstance(uint(EID4789VS_gl_InstanceIndex))._m2.x) + 3u).xxxx + EID4789VS_278;
        uint4 EID4789VS_281 = (asuint(EID4789VS_LoadInstance(uint(EID4789VS_gl_InstanceIndex))._m2.y) + 3u).xxxx + EID4789VS_278;
        uint EID4789VS_282 = EID4789VS_279.x;
        uint EID4789VS_285 = EID4789VS_282 + 1u;
        uint EID4789VS_288 = EID4789VS_282 + 2u;
        uint EID4789VS_291 = EID4789VS_281.x;
        uint EID4789VS_294 = EID4789VS_291 + 1u;
        uint EID4789VS_297 = EID4789VS_291 + 2u;
        float4 EID4789VS_341;
        float4 EID4789VS_342;
        float4 EID4789VS_343;
        float4 EID4789VS_344;
        float4 EID4789VS_345;
        float4 EID4789VS_346;
        if (EID4789VS_262 >= 2u)
        {
            uint EID4789VS_305 = EID4789VS_279.y;
            uint EID4789VS_324 = EID4789VS_281.y;
            EID4789VS_341 = (asfloat(EID4789VS_31.Load4(EID4789VS_297 * 16 + 0)) * EID4789VS_11.x) + (asfloat(EID4789VS_31.Load4((EID4789VS_324 + 2u) * 16 + 0)) * EID4789VS_11.y);
            EID4789VS_342 = (asfloat(EID4789VS_31.Load4(EID4789VS_294 * 16 + 0)) * EID4789VS_11.x) + (asfloat(EID4789VS_31.Load4((EID4789VS_324 + 1u) * 16 + 0)) * EID4789VS_11.y);
            EID4789VS_343 = (asfloat(EID4789VS_31.Load4(EID4789VS_291 * 16 + 0)) * EID4789VS_11.x) + (asfloat(EID4789VS_31.Load4(EID4789VS_324 * 16 + 0)) * EID4789VS_11.y);
            EID4789VS_344 = (asfloat(EID4789VS_31.Load4(EID4789VS_288 * 16 + 0)) * EID4789VS_11.x) + (asfloat(EID4789VS_31.Load4((EID4789VS_305 + 2u) * 16 + 0)) * EID4789VS_11.y);
            EID4789VS_345 = (asfloat(EID4789VS_31.Load4(EID4789VS_285 * 16 + 0)) * EID4789VS_11.x) + (asfloat(EID4789VS_31.Load4((EID4789VS_305 + 1u) * 16 + 0)) * EID4789VS_11.y);
            EID4789VS_346 = (asfloat(EID4789VS_31.Load4(EID4789VS_282 * 16 + 0)) * EID4789VS_11.x) + (asfloat(EID4789VS_31.Load4(EID4789VS_305 * 16 + 0)) * EID4789VS_11.y);
        }
        else
        {
            EID4789VS_341 = asfloat(EID4789VS_31.Load4(EID4789VS_297 * 16 + 0));
            EID4789VS_342 = asfloat(EID4789VS_31.Load4(EID4789VS_294 * 16 + 0));
            EID4789VS_343 = asfloat(EID4789VS_31.Load4(EID4789VS_291 * 16 + 0));
            EID4789VS_344 = asfloat(EID4789VS_31.Load4(EID4789VS_288 * 16 + 0));
            EID4789VS_345 = asfloat(EID4789VS_31.Load4(EID4789VS_285 * 16 + 0));
            EID4789VS_346 = asfloat(EID4789VS_31.Load4(EID4789VS_282 * 16 + 0));
        }
        float4 EID4789VS_412;
        float4 EID4789VS_413;
        float4 EID4789VS_414;
        float4 EID4789VS_415;
        float4 EID4789VS_416;
        float4 EID4789VS_417;
        if (EID4789VS_262 >= 4u)
        {
            uint EID4789VS_350 = EID4789VS_279.z;
            uint EID4789VS_355 = EID4789VS_279.w;
            uint EID4789VS_382 = EID4789VS_281.z;
            uint EID4789VS_386 = EID4789VS_281.w;
            EID4789VS_412 = EID4789VS_341 + ((asfloat(EID4789VS_31.Load4((EID4789VS_382 + 2u) * 16 + 0)) * EID4789VS_11.z) + (asfloat(EID4789VS_31.Load4((EID4789VS_386 + 2u) * 16 + 0)) * EID4789VS_11.w));
            EID4789VS_413 = EID4789VS_342 + ((asfloat(EID4789VS_31.Load4((EID4789VS_382 + 1u) * 16 + 0)) * EID4789VS_11.z) + (asfloat(EID4789VS_31.Load4((EID4789VS_386 + 1u) * 16 + 0)) * EID4789VS_11.w));
            EID4789VS_414 = EID4789VS_343 + ((asfloat(EID4789VS_31.Load4(EID4789VS_382 * 16 + 0)) * EID4789VS_11.z) + (asfloat(EID4789VS_31.Load4(EID4789VS_386 * 16 + 0)) * EID4789VS_11.w));
            EID4789VS_415 = EID4789VS_344 + ((asfloat(EID4789VS_31.Load4((EID4789VS_350 + 2u) * 16 + 0)) * EID4789VS_11.z) + (asfloat(EID4789VS_31.Load4((EID4789VS_355 + 2u) * 16 + 0)) * EID4789VS_11.w));
            EID4789VS_416 = EID4789VS_345 + ((asfloat(EID4789VS_31.Load4((EID4789VS_350 + 1u) * 16 + 0)) * EID4789VS_11.z) + (asfloat(EID4789VS_31.Load4((EID4789VS_355 + 1u) * 16 + 0)) * EID4789VS_11.w));
            EID4789VS_417 = EID4789VS_346 + ((asfloat(EID4789VS_31.Load4(EID4789VS_350 * 16 + 0)) * EID4789VS_11.z) + (asfloat(EID4789VS_31.Load4(EID4789VS_355 * 16 + 0)) * EID4789VS_11.w));
        }
        else
        {
            EID4789VS_412 = EID4789VS_341;
            EID4789VS_413 = EID4789VS_342;
            EID4789VS_414 = EID4789VS_343;
            EID4789VS_415 = EID4789VS_344;
            EID4789VS_416 = EID4789VS_345;
            EID4789VS_417 = EID4789VS_346;
        }
        float3 EID4789VS_433 = EID4789VS_205.xyz;
        float3 EID4789VS_437 = float3(dot(EID4789VS_417.xyz, EID4789VS_433), dot(EID4789VS_416.xyz, EID4789VS_433), dot(EID4789VS_415.xyz, EID4789VS_433));
        EID4789VS_439 = float4(EID4789VS_437.x, EID4789VS_437.y, EID4789VS_437.z, EID4789VS_205.w);
        EID4789VS_440 = float3(dot(EID4789VS_417.xyz, EID4789VS_202), dot(EID4789VS_416.xyz, EID4789VS_202), dot(EID4789VS_415.xyz, EID4789VS_202));
        EID4789VS_441 = float3(dot(EID4789VS_417, EID4789VS_261), dot(EID4789VS_416, EID4789VS_261), dot(EID4789VS_415, EID4789VS_261));
        EID4789VS_442 = float3(dot(EID4789VS_414, EID4789VS_261), dot(EID4789VS_413, EID4789VS_261), dot(EID4789VS_412, EID4789VS_261));
        break;
    } while(false);
    EID4789VS_441 = EID4789BakedPosition; EID4789VS_440 = EID4789BakedNormal; EID4789VS_439 = EID4789BakedTangent;
    float3x3 EID4789VS_451 = (float3x3)unity_ObjectToWorld;
    float3 EID4789VS_461 = mul(EID4789VS_451,EID4789VS_441) + (unity_ObjectToWorld._m03_m13_m23 - EID4789VS_24_m11.xyz);
    float4 EID4789VS_468 = mul(EID4789VS_24_m8, float4(EID4789VS_461, 1.0f));
    float2 EID4789VS_476 = EID4789VS_468.xy - ((EID4789VS_26_m9.zw * float2(2.0f, -2.0f)) * EID4789VS_468.w);
    float4 EID4789VS_477 = float4(EID4789VS_476.x, EID4789VS_476.y, EID4789VS_468.z, EID4789VS_468.w);
    float3 EID4789VS_484 = mul(EID4789VS_451, EID4789VS_440);
    float3 EID4789VS_490 = mul(EID4789VS_451, EID4789VS_439.xyz);
    bool3 EID4789VS_504 = (EID4789VS_LoadInstance(uint(EID4789VS_gl_InstanceIndex))._m4.x < 1.0f).xxx;
    EID4789VS_13 = (EID4789VS_4 * EID4789VS_33_m28.xy) + EID4789VS_33_m28.zw;
    EID4789VS_14 = EID4789VS_461;
    EID4789VS_15 = EID4789VS_484 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(EID4789VS_484, EID4789VS_484)));
    EID4789VS_16 = float4(EID4789VS_490 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(EID4789VS_490, EID4789VS_490))), EID4789VS_439.w);
    EID4789VS_17 = EID4789VS_468.xyw;
    EID4789VS_18 = mul(EID4789VS_24_m15, float4(mul(float3x3(EID4789VS_LoadInstance(uint(EID4789VS_gl_InstanceIndex))._m3[0].xyz, EID4789VS_LoadInstance(uint(EID4789VS_gl_InstanceIndex))._m3[1].xyz, EID4789VS_LoadInstance(uint(EID4789VS_gl_InstanceIndex))._m3[2].xyz), float3(EID4789VS_504.x ? EID4789VS_441.x : EID4789VS_442.xyz.x, EID4789VS_504.y ? EID4789VS_441.y : EID4789VS_442.xyz.y, EID4789VS_504.z ? EID4789VS_441.z : EID4789VS_442.xyz.z)) + (float3(EID4789VS_LoadInstance(uint(EID4789VS_gl_InstanceIndex))._m3[0].w, EID4789VS_LoadInstance(uint(EID4789VS_gl_InstanceIndex))._m3[1].w, EID4789VS_LoadInstance(uint(EID4789VS_gl_InstanceIndex))._m3[2].w) - EID4789VS_24_m21.xyz), 1.0f)).xyw;
    EID4789VS_19 = float3(EID4789VS_253.x ? EID4789VS_247.x : EID4789VS_202.x, EID4789VS_253.y ? EID4789VS_247.y : EID4789VS_202.y, EID4789VS_253.z ? EID4789VS_247.z : EID4789VS_202.z);
    EID4789VS_20 = EID4789VS_8;
    EID4789VS_477.y = -EID4789VS_476.y;
    EID4789VS_gl_Position = TransformWorldToHClip(TransformObjectToWorld(EID4789VS_441));
    EID4789VS_22 = uint(EID4789VS_gl_InstanceIndex);
}

EID4789VS_SPIRV_Cross_Output EID4789VS_main(EID4789VS_SPIRV_Cross_Input stage_input)
{
    EID4789VS_gl_InstanceIndex = int(stage_input.EID4789VS_gl_InstanceIndex);
    EID4789VS_3 = stage_input.EID4789VS_3;
    EID4789VS_4 = stage_input.EID4789VS_4;
    EID4789VS_5 = stage_input.EID4789VS_5;
    EID4789VS_6 = stage_input.EID4789VS_6;
    EID4789VS_7 = stage_input.EID4789VS_7;
    EID4789VS_8 = stage_input.EID4789VS_8;
    EID4789VS_9 = stage_input.EID4789VS_9;
    EID4789VS_11 = stage_input.EID4789VS_11;
    EID4789VS_12 = stage_input.EID4789VS_12;
    EID4789VS_vert_main();
    EID4789VS_SPIRV_Cross_Output stage_output;
    stage_output.EID4789VS_gl_Position = EID4789VS_gl_Position;
    stage_output.EID4789VS_13 = EID4789VS_13;
    stage_output.EID4789VS_14 = EID4789VS_14;
    stage_output.EID4789VS_15 = EID4789VS_15;
    stage_output.EID4789VS_16 = EID4789VS_16;
    stage_output.EID4789VS_17 = EID4789VS_17;
    stage_output.EID4789VS_18 = EID4789VS_18;
    stage_output.EID4789VS_19 = EID4789VS_19;
    stage_output.EID4789VS_20 = EID4789VS_20;
    stage_output.EID4789VS_22 = EID4789VS_22;
    return stage_output;
}
