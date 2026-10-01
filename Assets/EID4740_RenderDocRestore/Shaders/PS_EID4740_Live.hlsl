// Verified F:/endfield06.rdc EID4740 VS215993/PS215994, independent resources.
struct EID4740PS_21
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

static const int2 EID4740PS_312[6] = { int2(2, 1), int2(2, 1), int2(0, 2), int2(0, 2), int2(0, 1), int2(0, 1) };
static const float2 EID4740PS_313[6] = { float2(-1.0f, 1.0f), 1.0f.xx, float2(1.0f, -1.0f), 1.0f.xx, 1.0f.xx, float2(-1.0f, 1.0f) };

cbuffer EID4740PS_16_17
{
    column_major float4x4 EID4740PS_17_m0 : packoffset(c0);
    column_major float4x4 EID4740PS_17_m1 : packoffset(c4);
    column_major float4x4 EID4740PS_17_m2 : packoffset(c8);
    column_major float4x4 EID4740PS_17_m3 : packoffset(c12);
    column_major float4x4 EID4740PS_17_m4 : packoffset(c16);
    column_major float4x4 EID4740PS_17_m5 : packoffset(c20);
    column_major float4x4 EID4740PS_17_m6 : packoffset(c24);
    column_major float4x4 EID4740PS_17_m7 : packoffset(c28);
    column_major float4x4 EID4740PS_17_m8 : packoffset(c32);
    column_major float4x4 EID4740PS_17_m9 : packoffset(c36);
    column_major float4x4 EID4740PS_17_m10 : packoffset(c40);
    float4 EID4740PS_17_m11 : packoffset(c44);
    column_major float4x4 EID4740PS_17_m12 : packoffset(c45);
    column_major float4x4 EID4740PS_17_m13 : packoffset(c49);
    column_major float4x4 EID4740PS_17_m14 : packoffset(c53);
    column_major float4x4 EID4740PS_17_m15 : packoffset(c57);
    column_major float4x4 EID4740PS_17_m16 : packoffset(c61);
    column_major float4x4 EID4740PS_17_m17 : packoffset(c65);
    column_major float4x4 EID4740PS_17_m18 : packoffset(c69);
    column_major float4x4 EID4740PS_17_m19 : packoffset(c73);
    column_major float4x4 EID4740PS_17_m20 : packoffset(c77);
    float4 EID4740PS_17_m21 : packoffset(c81);
};

cbuffer EID4740PS_18_19
{
    float4 EID4740PS_19_m0 : packoffset(c0);
    float4 EID4740PS_19_m1 : packoffset(c1);
    float4 EID4740PS_19_m2 : packoffset(c2);
    float4 EID4740PS_19_m3 : packoffset(c3);
    float4 EID4740PS_19_m4 : packoffset(c4);
    float4 EID4740PS_19_m5 : packoffset(c5);
    float4 EID4740PS_19_m6[6] : packoffset(c6);
    float4 EID4740PS_19_m7[6] : packoffset(c12);
    float4 EID4740PS_19_m8 : packoffset(c18);
    float4 EID4740PS_19_m9 : packoffset(c19);
    float4 EID4740PS_19_m10 : packoffset(c20);
    float4 EID4740PS_19_m11 : packoffset(c21);
    float4 EID4740PS_19_m12 : packoffset(c22);
    float4 EID4740PS_19_m13 : packoffset(c23);
    float4 EID4740PS_19_m14 : packoffset(c24);
    float4 EID4740PS_19_m15 : packoffset(c25);
    float EID4740PS_19_m16 : packoffset(c26);
    float EID4740PS_19_m17 : packoffset(c26.y);
    float EID4740PS_19_m18 : packoffset(c26.z);
    uint EID4740PS_19_m19 : packoffset(c26.w);
    float4 EID4740PS_19_m20 : packoffset(c27);
    int4 EID4740PS_19_m21 : packoffset(c28);
    float4 EID4740PS_19_m22 : packoffset(c29);
    float4 EID4740PS_19_m23 : packoffset(c30);
    float4 EID4740PS_19_m24 : packoffset(c31);
    float4 EID4740PS_19_m25 : packoffset(c32);
    float4 EID4740PS_19_m26 : packoffset(c33);
    float4 EID4740PS_19_m27 : packoffset(c34);
    float4 EID4740PS_19_m28 : packoffset(c35);
    float4 EID4740PS_19_m29 : packoffset(c36);
    float4 EID4740PS_19_m30 : packoffset(c37);
    float4 EID4740PS_19_m31 : packoffset(c38);
    float4 EID4740PS_19_m32[4] : packoffset(c39);
    float4 EID4740PS_19_m33[4] : packoffset(c43);
    float4 EID4740PS_19_m34[4] : packoffset(c47);
    float4 EID4740PS_19_m35[4] : packoffset(c51);
    float4 EID4740PS_19_m36 : packoffset(c55);
    float4 EID4740PS_19_m37 : packoffset(c56);
    float4 EID4740PS_19_m38[4] : packoffset(c57);
    float4 EID4740PS_19_m39[4] : packoffset(c61);
    float4 EID4740PS_19_m40[4] : packoffset(c65);
    float4 EID4740PS_19_m41 : packoffset(c69);
    float4 EID4740PS_19_m42 : packoffset(c70);
    float4 EID4740PS_19_m43 : packoffset(c71);
    float4 EID4740PS_19_m44 : packoffset(c72);
    float4 EID4740PS_19_m45 : packoffset(c73);
    float4 EID4740PS_19_m46 : packoffset(c74);
    float4 EID4740PS_19_m47 : packoffset(c75);
    float4 EID4740PS_19_m48 : packoffset(c76);
    float4 EID4740PS_19_m49 : packoffset(c77);
    float4 EID4740PS_19_m50 : packoffset(c78);
    float4 EID4740PS_19_m51 : packoffset(c79);
    float4 EID4740PS_19_m52 : packoffset(c80);
    float4 EID4740PS_19_m53 : packoffset(c81);
    float4 EID4740PS_19_m54 : packoffset(c82);
    float4 EID4740PS_19_m55 : packoffset(c83);
    float4 EID4740PS_19_m56 : packoffset(c84);
    float4 EID4740PS_19_m57 : packoffset(c85);
    float4 EID4740PS_19_m58 : packoffset(c86);
    float4 EID4740PS_19_m59 : packoffset(c87);
    float4 EID4740PS_19_m60 : packoffset(c88);
    float4 EID4740PS_19_m61 : packoffset(c89);
    float4 EID4740PS_19_m62 : packoffset(c90);
    float4 EID4740PS_19_m63 : packoffset(c91);
    float4 EID4740PS_19_m64 : packoffset(c92);
    float4 EID4740PS_19_m65 : packoffset(c93);
    float4 EID4740PS_19_m66 : packoffset(c94);
    float4 EID4740PS_19_m67 : packoffset(c95);
    float4 EID4740PS_19_m68 : packoffset(c96);
    float4 EID4740PS_19_m69 : packoffset(c97);
    float4 EID4740PS_19_m70 : packoffset(c98);
    float4 EID4740PS_19_m71 : packoffset(c99);
    float4 EID4740PS_19_m72 : packoffset(c100);
    float4 EID4740PS_19_m73 : packoffset(c101);
    float4 EID4740PS_19_m74 : packoffset(c102);
    float4 EID4740PS_19_m75 : packoffset(c103);
    float4 EID4740PS_19_m76 : packoffset(c104);
    float4 EID4740PS_19_m77 : packoffset(c105);
    float4 EID4740PS_19_m78 : packoffset(c106);
    float4 EID4740PS_19_m79 : packoffset(c107);
    float4 EID4740PS_19_m80 : packoffset(c108);
    float4 EID4740PS_19_m81 : packoffset(c109);
    float4 EID4740PS_19_m82 : packoffset(c110);
    float4 EID4740PS_19_m83 : packoffset(c111);
    float4 EID4740PS_19_m84 : packoffset(c112);
    float4 EID4740PS_19_m85 : packoffset(c113);
    float4 EID4740PS_19_m86 : packoffset(c114);
    float4 EID4740PS_19_m87 : packoffset(c115);
    float4 EID4740PS_19_m88 : packoffset(c116);
    float4 EID4740PS_19_m89 : packoffset(c117);
    float4 EID4740PS_19_m90 : packoffset(c118);
    float4 EID4740PS_19_m91 : packoffset(c119);
    float4 EID4740PS_19_m92 : packoffset(c120);
    float4 EID4740PS_19_m93 : packoffset(c121);
    float4 EID4740PS_19_m94 : packoffset(c122);
    float4 EID4740PS_19_m95 : packoffset(c123);
    float4 EID4740PS_19_m96 : packoffset(c124);
    float4 EID4740PS_19_m97 : packoffset(c125);
    float4 EID4740PS_19_m98 : packoffset(c126);
    float4 EID4740PS_19_m99[2] : packoffset(c127);
    float4 EID4740PS_19_m100[2] : packoffset(c129);
    float EID4740PS_19_m101 : packoffset(c131);
    float EID4740PS_19_m102 : packoffset(c131.y);
    float EID4740PS_19_m103 : packoffset(c131.z);
    float EID4740PS_19_m104 : packoffset(c131.w);
    float4 EID4740PS_19_m105 : packoffset(c132);
    float4 EID4740PS_19_m106 : packoffset(c133);
    float4 EID4740PS_19_m107 : packoffset(c134);
    float4 EID4740PS_19_m108 : packoffset(c135);
    float4 EID4740PS_19_m109 : packoffset(c136);
    float4 EID4740PS_19_m110 : packoffset(c137);
    float4 EID4740PS_19_m111 : packoffset(c138);
    float4 EID4740PS_19_m112 : packoffset(c139);
    float4 EID4740PS_19_m113 : packoffset(c140);
    float4 EID4740PS_19_m114 : packoffset(c141);
    float4 EID4740PS_19_m115 : packoffset(c142);
    float4 EID4740PS_19_m116 : packoffset(c143);
    float4 EID4740PS_19_m117 : packoffset(c144);
    float4 EID4740PS_19_m118 : packoffset(c145);
    float4 EID4740PS_19_m119 : packoffset(c146);
    float4 EID4740PS_19_m120 : packoffset(c147);
    float4 EID4740PS_19_m121 : packoffset(c148);
    float4 EID4740PS_19_m122 : packoffset(c149);
    float4 EID4740PS_19_m123 : packoffset(c150);
    float4 EID4740PS_19_m124 : packoffset(c151);
    float4 EID4740PS_19_m125 : packoffset(c152);
    float4 EID4740PS_19_m126 : packoffset(c153);
    float4 EID4740PS_19_m127 : packoffset(c154);
    float4 EID4740PS_19_m128 : packoffset(c155);
    float4 EID4740PS_19_m129 : packoffset(c156);
    float4 EID4740PS_19_m130 : packoffset(c157);
    float4 EID4740PS_19_m131 : packoffset(c158);
    float4 EID4740PS_19_m132 : packoffset(c159);
    float4 EID4740PS_19_m133 : packoffset(c160);
    float4 EID4740PS_19_m134 : packoffset(c161);
    column_major float4x4 EID4740PS_19_m135 : packoffset(c162);
    float4 EID4740PS_19_m136 : packoffset(c166);
    float4 EID4740PS_19_m137 : packoffset(c167);
    float4 EID4740PS_19_m138[32] : packoffset(c168);
};

cbuffer EID4740PS_20_22
{
    float4 EID4740PS_instanceRaw[4096] : packoffset(c0);
};

ByteAddressBuffer EID4740PS_29;
ByteAddressBuffer EID4740PS_31;
cbuffer EID4740PS_32_33
{
    int EID4740PS_33_m0 : packoffset(c0);
    int EID4740PS_33_m1 : packoffset(c0.y);
    int EID4740PS_33_m2 : packoffset(c0.z);
    int EID4740PS_33_m3 : packoffset(c0.w);
    float EID4740PS_33_m4 : packoffset(c1);
    float EID4740PS_33_m5 : packoffset(c1.y);
    float EID4740PS_33_m6 : packoffset(c1.z);
    float EID4740PS_33_m7 : packoffset(c1.w);
    float EID4740PS_33_m8 : packoffset(c2);
    float EID4740PS_33_m9 : packoffset(c2.y);
    float EID4740PS_33_m10 : packoffset(c2.z);
    float EID4740PS_33_m11 : packoffset(c2.w);
};

cbuffer EID4740PS_34_35
{
    float4 EID4740PS_35_m0 : packoffset(c0);
    float4 EID4740PS_35_m1 : packoffset(c1);
    float4 EID4740PS_35_m2 : packoffset(c2);
    float4 EID4740PS_35_m3 : packoffset(c3);
    float4 EID4740PS_35_m4 : packoffset(c4);
    uint4 EID4740PS_35_m5 : packoffset(c5);
    float4 EID4740PS_35_m6[2048] : packoffset(c6);
};

cbuffer EID4740PS_36_37
{
    column_major float4x4 EID4740PS_37_m0[5] : packoffset(c0);
    float4 EID4740PS_37_m1[4] : packoffset(c20);
    float4 EID4740PS_37_m2[4] : packoffset(c24);
    float4 EID4740PS_37_m3[4] : packoffset(c28);
    float4 EID4740PS_37_m4 : packoffset(c32);
    float4 EID4740PS_37_m5 : packoffset(c33);
    float4 EID4740PS_37_m6 : packoffset(c34);
    float4 EID4740PS_37_m7 : packoffset(c35);
    float4 EID4740PS_37_m8 : packoffset(c36);
    float4 EID4740PS_37_m9[27] : packoffset(c37);
    column_major float4x4 EID4740PS_37_m10[56] : packoffset(c64);
    float4 EID4740PS_37_m11[56] : packoffset(c288);
    float4 EID4740PS_37_m12[56] : packoffset(c344);
    float4 EID4740PS_37_m13 : packoffset(c400);
    float4 EID4740PS_37_m14[47] : packoffset(c401);
    column_major float4x4 EID4740PS_37_m15[15] : packoffset(c448);
    float4 EID4740PS_37_m16[15] : packoffset(c508);
    float4 EID4740PS_37_m17[15] : packoffset(c523);
    float4 EID4740PS_37_m18[15] : packoffset(c538);
    float4 EID4740PS_37_m19 : packoffset(c553);
    float4 EID4740PS_37_m20 : packoffset(c554);
    float4 EID4740PS_37_m21[21] : packoffset(c555);
    column_major float4x4 EID4740PS_37_m22 : packoffset(c576);
    column_major float4x4 EID4740PS_37_m23 : packoffset(c580);
    float4 EID4740PS_37_m24 : packoffset(c584);
    float4 EID4740PS_37_m25 : packoffset(c585);
    float4 EID4740PS_37_m26 : packoffset(c586);
    float4 EID4740PS_37_m27[128] : packoffset(c587);
};

cbuffer EID4740PS_47_48
{
    float EID4740PS_48_m0 : packoffset(c0);
    float EID4740PS_48_m1 : packoffset(c0.y);
    float EID4740PS_48_m2 : packoffset(c0.z);
    float EID4740PS_48_m3 : packoffset(c0.w);
    float EID4740PS_48_m4 : packoffset(c1);
    float EID4740PS_48_m5 : packoffset(c1.y);
    float EID4740PS_48_m6 : packoffset(c1.z);
    float EID4740PS_48_m7 : packoffset(c1.w);
    float EID4740PS_48_m8 : packoffset(c2);
    float EID4740PS_48_m9 : packoffset(c2.y);
    float EID4740PS_48_m10 : packoffset(c2.z);
    float EID4740PS_48_m11 : packoffset(c2.w);
    float EID4740PS_48_m12 : packoffset(c3);
    float EID4740PS_48_m13 : packoffset(c3.y);
    float EID4740PS_48_m14 : packoffset(c3.z);
    float EID4740PS_48_m15 : packoffset(c3.w);
    float EID4740PS_48_m16 : packoffset(c4);
    float EID4740PS_48_m17 : packoffset(c4.y);
    float EID4740PS_48_m18 : packoffset(c4.z);
    float EID4740PS_48_m19 : packoffset(c4.w);
    float EID4740PS_48_m20 : packoffset(c5);
    float EID4740PS_48_m21 : packoffset(c5.y);
    float EID4740PS_48_m22 : packoffset(c5.z);
    float EID4740PS_48_m23 : packoffset(c5.w);
    float4 EID4740PS_48_m24 : packoffset(c6);
    float4 EID4740PS_48_m25 : packoffset(c7);
    float4 EID4740PS_48_m26 : packoffset(c8);
    float4 EID4740PS_48_m27 : packoffset(c9);
    float4 EID4740PS_48_m28 : packoffset(c10);
    float4 EID4740PS_48_m29 : packoffset(c11);
    float EID4740PS_48_m30 : packoffset(c12);
    float EID4740PS_48_m31 : packoffset(c12.y);
    float EID4740PS_48_m32 : packoffset(c12.z);
    float EID4740PS_48_m33 : packoffset(c12.w);
    float4 EID4740PS_48_m34 : packoffset(c13);
    float4 EID4740PS_48_m35 : packoffset(c14);
    float4 EID4740PS_48_m36 : packoffset(c15);
    float4 EID4740PS_48_m37 : packoffset(c16);
    float EID4740PS_48_m38 : packoffset(c17);
    float EID4740PS_48_m39 : packoffset(c17.y);
    float EID4740PS_48_m40 : packoffset(c17.z);
    float EID4740PS_48_m41 : packoffset(c17.w);
    float4 EID4740PS_48_m42 : packoffset(c18);
    float4 EID4740PS_48_m43 : packoffset(c19);
    float4 EID4740PS_48_m44 : packoffset(c20);
    float4 EID4740PS_48_m45 : packoffset(c21);
    float4 EID4740PS_48_m46 : packoffset(c22);
    float EID4740PS_48_m47 : packoffset(c23);
    float EID4740PS_48_m48 : packoffset(c23.y);
    float EID4740PS_48_m49 : packoffset(c23.z);
    float EID4740PS_48_m50 : packoffset(c23.w);
    float EID4740PS_48_m51 : packoffset(c24);
    float EID4740PS_48_m52 : packoffset(c24.y);
    float EID4740PS_48_m53 : packoffset(c24.z);
    float EID4740PS_48_m54 : packoffset(c24.w);
};

cbuffer EID4740PS_54_55
{
    float4 EID4740PS_55_m0[32] : packoffset(c0);
    column_major float4x4 EID4740PS_55_m1[32] : packoffset(c32);
};

SamplerState EID4740_linear_clamp_sampler;
SamplerState EID4740_linear_repeat_sampler;

Texture2D<float4> EID4740PS_38;
Texture2D<float4> EID4740PS_39;
Texture3D<float4> EID4740PS_41;
Texture3D<float4> EID4740PS_42;
Texture3D<float4> EID4740PS_43;
Texture3D<float4> EID4740PS_44;
Texture3D<float4> EID4740PS_45;
Texture3D<float4> EID4740PS_46;
Texture2D<float4> EID4740PS_49;
Texture2D<float4> EID4740PS_50;
Texture2D<float4> EID4740PS_51;
Texture2D<float4> EID4740PS_52;
Texture2D<float4> EID4740PS_53;
Texture3D<float4> EID4740PS_58;

static float4 EID4740PS_gl_FragCoord;
static bool EID4740PS_gl_FrontFacing;
static float2 EID4740PS_3;
static float3 EID4740PS_4;
static float3 EID4740PS_5;
static float4 EID4740PS_6;
static float3 EID4740PS_7;
static float3 EID4740PS_8;
static float3 EID4740PS_9;
static float3 EID4740PS_10;
static uint EID4740PS_12;
static float4 EID4740PS_14;
static float4 EID4740PS_15;

EID4740PS_21 EID4740PS_LoadInstance(uint index) { uint b=index*16; EID4740PS_21 x;
x._m0=transpose(float4x4(EID4740PS_instanceRaw[b],EID4740PS_instanceRaw[b+1],EID4740PS_instanceRaw[b+2],EID4740PS_instanceRaw[b+3]));
x._m1=EID4740PS_instanceRaw[b+4];x._m2=EID4740PS_instanceRaw[b+5];
x._m3=transpose(float4x4(EID4740PS_instanceRaw[b+6],EID4740PS_instanceRaw[b+7],EID4740PS_instanceRaw[b+8],EID4740PS_instanceRaw[b+9]));
x._m4=EID4740PS_instanceRaw[b+10];
x._m5=EID4740PS_instanceRaw[b+11];
x._m6=EID4740PS_instanceRaw[b+12];
x._m7=EID4740PS_instanceRaw[b+13];
x._m8=EID4740PS_instanceRaw[b+14];
x._m9=EID4740PS_instanceRaw[b+15];
return x;}

struct EID4740PS_SPIRV_Cross_Input
{
    float2 EID4740PS_3 : TEXCOORD0;
    float3 EID4740PS_4 : TEXCOORD1;
    float3 EID4740PS_5 : TEXCOORD2;
    float4 EID4740PS_6 : TEXCOORD3;
    float3 EID4740PS_7 : TEXCOORD4;
    float3 EID4740PS_8 : TEXCOORD5;
    float3 EID4740PS_9 : TEXCOORD6;
    float3 EID4740PS_10 : TEXCOORD7;
    nointerpolation uint EID4740PS_12 : TEXCOORD8;
    float4 EID4740PS_gl_FragCoord : SV_Position;
    bool EID4740PS_gl_FrontFacing : SV_IsFrontFace;
};

struct EID4740PS_SPIRV_Cross_Output
{
    float4 EID4740PS_14 : SV_Target0;
    float4 EID4740PS_15 : SV_Target1;
};

static float EID4740PS_332;
static float3 EID4740PS_333;
static float EID4740PS_335;
static uint EID4740PS_336;

uint EID4740PS_spvPackHalf2x16(float2 value)
{
    uint2 Packed = f32tof16(value);
    return Packed.x | (Packed.y << 16);
}

float2 EID4740PS_spvUnpackHalf2x16(uint value)
{
    return f16tof32(uint2(value & 0xffff, value >> 16));
}

[noinline]
float EID4740ShadowGreater(float2 uv, float reference)
{
 uint w,h; EID4740PS_38.GetDimensions(w,h); float2 p=uv*float2(w,h)-0.5;
 int2 a=(int2)floor(p); float2 f=frac(p); int2 hi=int2(w,h)-1;
 float c00=reference>EID4740PS_38.Load(int3(clamp(a,int2(0,0),hi),0)).r?1:0;
 float c10=reference>EID4740PS_38.Load(int3(clamp(a+int2(1,0),int2(0,0),hi),0)).r?1:0;
 float c01=reference>EID4740PS_38.Load(int3(clamp(a+int2(0,1),int2(0,0),hi),0)).r?1:0;
 float c11=reference>EID4740PS_38.Load(int3(clamp(a+int2(1,1),int2(0,0),hi),0)).r?1:0;
 return lerp(lerp(c00,c10,f.x),lerp(c01,c11,f.x),f.y);
}


[noinline]
void EID4740PS_EarlyExit0(inout float3 EID4740PS_1150, inout float3 EID4740PS_1156, inout float3 EID4740PS_1157, inout float4 EID4740PS_1365, inout float EID4740PS_1406, inout float EID4740PS_1434, inout float3 EID4740PS_1501, inout int EID4740PS_1537, inout int EID4740PS_1540, inout int EID4740PS_1543, inout int EID4740PS_1546, inout int EID4740PS_1549, inout uint EID4740PS_1562, inout uint EID4740PS_1650, inout bool EID4740PS_1662, inout bool EID4740PS_1667, inout float3 EID4740PS_1741, inout float EID4740PS_1880, inout float3 EID4740PS_2272, inout float3 EID4740PS_455, inout float3 EID4740PS_462, inout float3 EID4740PS_473, inout float3 EID4740PS_507)
{
                        float3 EID4740PS_2271;
                        [branch]
                        if (EID4740PS_1880 > 9.9999997473787516355514526367188e-05f)
                        {
                            [branch]
                            if (EID4740PS_1667)
                            {
                                EID4740PS_2272 = lerp(EID4740PS_1501, EID4740PS_35_m6[EID4740PS_1537].xyz, (EID4740PS_1880 * (EID4740PS_35_m6[EID4740PS_1549].x * ((1.0f - EID4740PS_35_m6[EID4740PS_1549].w) + (smoothstep(-0.5f, 0.5f, dot(EID4740PS_473, EID4740PS_1741)) * EID4740PS_35_m6[EID4740PS_1549].w)))).xxx);
                                return;
                            }
                            float EID4740PS_1900 = dot(EID4740PS_1150, EID4740PS_1741);
                            float EID4740PS_1901 = clamp(EID4740PS_1900, 0.0f, 1.0f);
                            float EID4740PS_2204;
                            if (EID4740PS_1650 != 0u)
                            {
                                bool EID4740PS_1907 = EID4740PS_1662 || ((EID4740PS_1562 & 2u) != 0u);
                                int EID4740PS_1956;
                                if (EID4740PS_1907)
                                {
                                    EID4740PS_1956 = int(EID4740PS_35_m6[EID4740PS_1546].x);
                                }
                                else
                                {
                                    uint EID4740PS_1911 = asuint(EID4740PS_35_m6[EID4740PS_1543].w);
                                    uint EID4740PS_1913 = asuint(EID4740PS_35_m6[EID4740PS_1546].x);
                                    float3 EID4740PS_1914 = EID4740PS_455 - EID4740PS_35_m6[EID4740PS_1540].xyz;
                                    float3 EID4740PS_1915 = abs(EID4740PS_1914);
                                    float EID4740PS_1916 = EID4740PS_1915.x;
                                    float EID4740PS_1917 = EID4740PS_1915.y;
                                    float EID4740PS_1919 = EID4740PS_1915.z;
                                    int EID4740PS_1951;
                                    if ((EID4740PS_1916 > EID4740PS_1917) && (EID4740PS_1916 > EID4740PS_1919))
                                    {
                                        EID4740PS_1951 = int((EID4740PS_1914.x > 0.0f) ? (EID4740PS_1911 >> 24u) : ((EID4740PS_1911 >> 16u) & 255u));
                                    }
                                    else
                                    {
                                        int EID4740PS_1943;
                                        if (EID4740PS_1917 > EID4740PS_1919)
                                        {
                                            EID4740PS_1943 = int((EID4740PS_1914.y > 0.0f) ? ((EID4740PS_1911 >> 8u) & 255u) : (EID4740PS_1911 & 255u));
                                        }
                                        else
                                        {
                                            EID4740PS_1943 = int((EID4740PS_1914.z > 0.0f) ? ((EID4740PS_1913 >> 8u) & 255u) : (EID4740PS_1913 & 255u));
                                        }
                                        EID4740PS_1951 = EID4740PS_1943;
                                    }
                                    EID4740PS_1956 = (EID4740PS_1951 < 80) ? EID4740PS_1951 : (-1);
                                }
                                bool EID4740PS_1957 = EID4740PS_1956 >= 0;
                                float EID4740PS_2203;
                                if (EID4740PS_1957)
                                {
                                    float3 EID4740PS_1964 = EID4740PS_455 - EID4740PS_35_m6[EID4740PS_1540].xyz;
                                    float EID4740PS_1965 = dot(EID4740PS_1964, EID4740PS_1964);
                                    float4 EID4740PS_1984 = mul(EID4740PS_37_m10[EID4740PS_1956], float4((EID4740PS_455 - ((EID4740PS_1964 * rsqrt(max(1.1754943508222875079687365372222e-38f, EID4740PS_1965))) * EID4740PS_37_m11[EID4740PS_1956].x)) + (EID4740PS_473 * (EID4740PS_37_m11[EID4740PS_1956].y * 5.0f)), 1.0f));
                                    float EID4740PS_1985 = EID4740PS_1984.w;
                                    float3 EID4740PS_1988 = EID4740PS_1984.xyz / EID4740PS_1985.xxx;
                                    float2 EID4740PS_1989 = EID4740PS_1988.xy;
                                    float3 EID4740PS_1997 = EID4740PS_1988.xyz;
                                    bool3 EID4740PS_1998 = bool3(EID4740PS_1997.x <= 0.0f.xxx.x, EID4740PS_1997.y <= 0.0f.xxx.y, EID4740PS_1997.z <= 0.0f.xxx.z);
                                    bool3 EID4740PS_1999 = bool3(EID4740PS_1997.x >= 1.0f.xxx.x, EID4740PS_1997.y >= 1.0f.xxx.y, EID4740PS_1997.z >= 1.0f.xxx.z);
                                    float EID4740PS_2002 = EID4740PS_1988.z;
                                    float2 EID4740PS_2013 = ((EID4740PS_1989 * (EID4740PS_37_m12[EID4740PS_1956].zw - EID4740PS_37_m12[EID4740PS_1956].xy)) + EID4740PS_37_m12[EID4740PS_1956].xy).xy * EID4740PS_37_m13.zw;
                                    float2 EID4740PS_2015 = floor(EID4740PS_2013 + 0.5f.xx);
                                    float2 EID4740PS_2016 = EID4740PS_2013 - EID4740PS_2015;
                                    float EID4740PS_2017 = EID4740PS_2016.x;
                                    float EID4740PS_2018 = EID4740PS_2017 + 0.5f;
                                    float EID4740PS_2019 = EID4740PS_2018 * EID4740PS_2018;
                                    float EID4740PS_2022 = 1.0f - EID4740PS_2017;
                                    float EID4740PS_2023 = min(EID4740PS_2017, 0.0f);
                                    float EID4740PS_2026 = EID4740PS_2017 + 1.0f;
                                    float EID4740PS_2027 = max(EID4740PS_2017, 0.0f);
                                    float EID4740PS_2038 = EID4740PS_2016.y;
                                    float EID4740PS_2039 = EID4740PS_2038 + 0.5f;
                                    float EID4740PS_2040 = EID4740PS_2039 * EID4740PS_2039;
                                    float EID4740PS_2043 = 1.0f - EID4740PS_2038;
                                    float EID4740PS_2044 = min(EID4740PS_2038, 0.0f);
                                    float EID4740PS_2047 = EID4740PS_2038 + 1.0f;
                                    float EID4740PS_2048 = max(EID4740PS_2038, 0.0f);
                                    float3 EID4740PS_2060 = float3(0.1599999964237213134765625f * EID4740PS_2022, 0.1599999964237213134765625f * ((EID4740PS_2026 - (EID4740PS_2027 * EID4740PS_2027)) + 1.0f), EID4740PS_2019 * 0.07999999821186065673828125f);
                                    float3 EID4740PS_2061 = float3(0.1599999964237213134765625f * ((EID4740PS_2019 * 0.5f) - EID4740PS_2017), 0.1599999964237213134765625f * ((EID4740PS_2022 - (EID4740PS_2023 * EID4740PS_2023)) + 1.0f), 0.1599999964237213134765625f * EID4740PS_2026) + EID4740PS_2060;
                                    float3 EID4740PS_2063 = float3(0.1599999964237213134765625f * EID4740PS_2043, 0.1599999964237213134765625f * ((EID4740PS_2047 - (EID4740PS_2048 * EID4740PS_2048)) + 1.0f), EID4740PS_2040 * 0.07999999821186065673828125f);
                                    float3 EID4740PS_2064 = float3(0.1599999964237213134765625f * ((EID4740PS_2040 * 0.5f) - EID4740PS_2038), 0.1599999964237213134765625f * ((EID4740PS_2043 - (EID4740PS_2044 * EID4740PS_2044)) + 1.0f), 0.1599999964237213134765625f * EID4740PS_2047) + EID4740PS_2063;
                                    float3 EID4740PS_2070 = ((EID4740PS_2060 / EID4740PS_2061) + float3(-2.5f, -0.5f, 1.5f)) * EID4740PS_37_m13.xxx;
                                    float3 EID4740PS_2072 = ((EID4740PS_2063 / EID4740PS_2064) + float3(-2.5f, -0.5f, 1.5f)) * EID4740PS_37_m13.yyy;
                                    float2 EID4740PS_2074 = EID4740PS_2015 * EID4740PS_37_m13.xy;
                                    float EID4740PS_2075 = EID4740PS_2070.x;
                                    float EID4740PS_2076 = EID4740PS_2072.x;
                                    float EID4740PS_2079 = EID4740PS_2070.y;
                                    float EID4740PS_2082 = EID4740PS_2070.z;
                                    float EID4740PS_2085 = EID4740PS_2072.y;
                                    float EID4740PS_2092 = EID4740PS_2072.z;
                                    float EID4740PS_2099 = EID4740PS_2061.x;
                                    float EID4740PS_2100 = EID4740PS_2064.x;
                                    float EID4740PS_2102 = EID4740PS_2061.y;
                                    float EID4740PS_2104 = EID4740PS_2061.z;
                                    float EID4740PS_2106 = EID4740PS_2064.y;
                                    float EID4740PS_2110 = EID4740PS_2064.z;
                                    float2 EID4740PS_2188 = 1.0f.xx - EID4740PS_1989;
                                    float2 EID4740PS_2189 = min(EID4740PS_1989, EID4740PS_2188);
                                    float EID4740PS_2190 = EID4740PS_2189.x;
                                    float EID4740PS_2191 = EID4740PS_2189.y;
                                    float EID4740PS_2192 = min(EID4740PS_2190, EID4740PS_2191);
                                    float EID4740PS_2196 = (EID4740PS_37_m11[EID4740PS_1956].z - EID4740PS_1985) * 0.25f;
                                    float EID4740PS_2198 = smoothstep(0.0f, 0.0500000007450580596923828125f, min(EID4740PS_2196, EID4740PS_2192));
                                    EID4740PS_2203 = EID4740PS_1957 ? lerp(1.0f, (any(bool3(EID4740PS_1998.x || EID4740PS_1999.x, EID4740PS_1998.y || EID4740PS_1999.y, EID4740PS_1998.z || EID4740PS_1999.z)) || ((asuint(EID4740PS_2002) & 2147483647u) > 2139095040u)) ? 1.0f : ((((((((((EID4740PS_2099 * EID4740PS_2100) * EID4740ShadowGreater( float3(EID4740PS_2074 + float2(EID4740PS_2075, EID4740PS_2076), EID4740PS_332).xy, EID4740PS_2002)) + ((EID4740PS_2102 * EID4740PS_2100) * EID4740ShadowGreater( float3(EID4740PS_2074 + float2(EID4740PS_2079, EID4740PS_2076), EID4740PS_332).xy, EID4740PS_2002))) + ((EID4740PS_2104 * EID4740PS_2100) * EID4740ShadowGreater( float3(EID4740PS_2074 + float2(EID4740PS_2082, EID4740PS_2076), EID4740PS_332).xy, EID4740PS_2002))) + ((EID4740PS_2099 * EID4740PS_2106) * EID4740ShadowGreater( float3(EID4740PS_2074 + float2(EID4740PS_2075, EID4740PS_2085), EID4740PS_332).xy, EID4740PS_2002))) + ((EID4740PS_2102 * EID4740PS_2106) * EID4740ShadowGreater( float3(EID4740PS_2074 + float2(EID4740PS_2079, EID4740PS_2085), EID4740PS_332).xy, EID4740PS_2002))) + ((EID4740PS_2104 * EID4740PS_2106) * EID4740ShadowGreater( float3(EID4740PS_2074 + float2(EID4740PS_2082, EID4740PS_2085), EID4740PS_332).xy, EID4740PS_2002))) + ((EID4740PS_2099 * EID4740PS_2110) * EID4740ShadowGreater( float3(EID4740PS_2074 + float2(EID4740PS_2075, EID4740PS_2092), EID4740PS_332).xy, EID4740PS_2002))) + ((EID4740PS_2102 * EID4740PS_2110) * EID4740ShadowGreater( float3(EID4740PS_2074 + float2(EID4740PS_2079, EID4740PS_2092), EID4740PS_332).xy, EID4740PS_2002))) + ((EID4740PS_2104 * EID4740PS_2110) * EID4740ShadowGreater( float3(EID4740PS_2074 + float2(EID4740PS_2082, EID4740PS_2092), EID4740PS_332).xy, EID4740PS_2002))), EID4740PS_1907 ? (min(EID4740PS_37_m11[EID4740PS_1956].w, EID4740PS_2198)) : EID4740PS_37_m11[EID4740PS_1956].w) : 1.0f;
                                }
                                else
                                {
                                    EID4740PS_2203 = clamp(dot(EID4740PS_462, EID4740PS_1741) + 1.0f, 0.0f, 1.0f);
                                }
                                EID4740PS_2204 = EID4740PS_2203;
                            }
                            else
                            {
                                EID4740PS_2204 = 1.0f;
                            }
                            float EID4740PS_2260;
                            float3 EID4740PS_2261;
                            float EID4740PS_2262;
                            float3 EID4740PS_2263;
                            float3 EID4740PS_2264;
                            [branch]
                            if (EID4740PS_1650 == 0u)
                            {
                                float3 EID4740PS_2240 = EID4740PS_35_m6[EID4740PS_1537].xyz * EID4740PS_1880;
                                float EID4740PS_2241 = EID4740PS_2240.x;
                                float EID4740PS_2242 = EID4740PS_2240.y;
                                float EID4740PS_2243 = EID4740PS_2240.z;
                                float EID4740PS_2244 = max(EID4740PS_2241, EID4740PS_2242);
                                float EID4740PS_2246 = (max(EID4740PS_2244, EID4740PS_2243)) * lerp(0.75f, 0.5f, EID4740PS_1434);
                                float3 EID4740PS_2253 = EID4740PS_1365.xyz;
                                EID4740PS_2260 = EID4740PS_1880;
                                EID4740PS_2261 = (EID4740PS_35_m6[EID4740PS_1537].xyz * ((1.0f - EID4740PS_35_m6[EID4740PS_1549].y) + ((1.0f / (max(1.0f, EID4740PS_2246))) * EID4740PS_35_m6[EID4740PS_1549].y))) * lerp(0.25f * EID4740PS_35_m6[EID4740PS_1549].x, 1.0f, clamp(EID4740PS_1900 + 0.5f, 0.0f, 1.0f));
                                EID4740PS_2262 = EID4740PS_1901;
                                EID4740PS_2263 = EID4740PS_2253;
                                EID4740PS_2264 = EID4740PS_2253;
                            }
                            else
                            {
                                bool EID4740PS_2209 = EID4740PS_1650 == 3u;
                                float EID4740PS_2235;
                                float3 EID4740PS_2236;
                                float3 EID4740PS_2237;
                                if (EID4740PS_2209)
                                {
                                    EID4740PS_2235 = clamp(dot(EID4740PS_1150, -normalize(cross(EID4740PS_507, cross(EID4740PS_507, EID4740PS_1741)))), 0.0f, 1.0f);
                                    EID4740PS_2236 = lerp(0.5f.xxx, EID4740PS_1156, EID4740PS_35_m6[EID4740PS_1549].y.xxx);
                                    EID4740PS_2237 = 0.0f.xxx;
                                }
                                else
                                {
                                    bool EID4740PS_2213 = EID4740PS_1650 == 1u;
                                    float EID4740PS_2223;
                                    float3 EID4740PS_2224;
                                    if (EID4740PS_2213)
                                    {
                                        EID4740PS_2223 = clamp(clamp(EID4740PS_1900 + EID4740PS_35_m6[EID4740PS_1549].x, -1.0f, 1.0f), 0.0f, 1.0f) * EID4740PS_2204;
                                        EID4740PS_2224 = EID4740PS_1157 * EID4740PS_35_m6[EID4740PS_1549].y;
                                    }
                                    else
                                    {
                                        EID4740PS_2223 = EID4740PS_1901;
                                        EID4740PS_2224 = 0.0f.xxx;
                                    }
                                    bool3 EID4740PS_2225 = EID4740PS_2213.xxx;
                                    EID4740PS_2235 = EID4740PS_2223;
                                    EID4740PS_2236 = float3(EID4740PS_2225.x ? EID4740PS_1156.x : 0.0f.xxx.x, EID4740PS_2225.y ? EID4740PS_1156.y : 0.0f.xxx.y, EID4740PS_2225.z ? EID4740PS_1156.z : 0.0f.xxx.z);
                                    EID4740PS_2237 = EID4740PS_2224;
                                }
                                EID4740PS_2260 = EID4740PS_2209 ? 0.0f : EID4740PS_1880;
                                EID4740PS_2261 = EID4740PS_35_m6[EID4740PS_1537].xyz;
                                EID4740PS_2262 = EID4740PS_2235;
                                EID4740PS_2263 = EID4740PS_2236;
                                EID4740PS_2264 = EID4740PS_2237;
                            }
                            EID4740PS_2271 = EID4740PS_1501 + (((EID4740PS_2261 * EID4740PS_2260) * lerp(EID4740PS_2264, EID4740PS_2263, EID4740PS_2262.xxx)) * EID4740PS_1406);
                        }
                        else
                        {
                            EID4740PS_2271 = EID4740PS_1501;
                        }
                        EID4740PS_2272 = EID4740PS_2271;
                        return;
}

[noinline]
void EID4740PS_EarlyExit1(inout float3 EID4740PS_1150, inout float3 EID4740PS_1156, inout float3 EID4740PS_1157, inout float4 EID4740PS_1365, inout float EID4740PS_1406, inout float EID4740PS_1434, inout float3 EID4740PS_1501, inout int EID4740PS_1537, inout int EID4740PS_1540, inout int EID4740PS_1543, inout int EID4740PS_1546, inout int EID4740PS_1549, inout int EID4740PS_1555, inout int EID4740PS_1558, inout uint EID4740PS_1562, inout float EID4740PS_1637, inout float3 EID4740PS_2273, inout float3 EID4740PS_455, inout float3 EID4740PS_462, inout float3 EID4740PS_473, inout float3 EID4740PS_507)
{
                    uint EID4740PS_1650 = asuint(EID4740PS_35_m6[EID4740PS_1546].w);
                    if ((EID4740PS_1650 == 16u) || ((EID4740PS_35_m6[EID4740PS_1546].z + EID4740PS_19_m91.z) < 0.5f))
                    {
                        EID4740PS_2273 = EID4740PS_1501;
                        return;
                    }
                    bool EID4740PS_1662 = (uint(EID4740PS_35_m6[EID4740PS_1537].w) & 1u) == 0u;
                    bool EID4740PS_1666 = (!EID4740PS_1662) && (EID4740PS_35_m6[EID4740PS_1543].z > 0.0f);
                    bool EID4740PS_1667 = EID4740PS_1650 == 4u;
                    float EID4740PS_1668 = float(EID4740PS_1662);
                    float EID4740PS_1676 = (0.5f + (0.5f * EID4740PS_35_m6[EID4740PS_1543].y)) - abs(EID4740PS_35_m6[EID4740PS_1543].x);
                    float EID4740PS_1677 = EID4740PS_35_m6[EID4740PS_1543].y - EID4740PS_1676;
                    float EID4740PS_1681 = (1.0f - abs(EID4740PS_1676)) - abs(EID4740PS_1677);
                    float EID4740PS_1684 = abs(max(EID4740PS_1681, 0.00048828125f));
                    float3 EID4740PS_1688 = normalize(float3(EID4740PS_1676, EID4740PS_1677, (EID4740PS_35_m6[EID4740PS_1543].x >= 0.0f) ? EID4740PS_1684 : (-EID4740PS_1684)));
                    float EID4740PS_1691 = 2.0f * EID4740PS_35_m6[EID4740PS_1549].y;
                    float EID4740PS_1694 = lerp(EID4740PS_35_m6[EID4740PS_1555].w, max(EID4740PS_1691, 0.100000001490116119384765625f), float(EID4740PS_1667));
                    float3 EID4740PS_1699 = EID4740PS_35_m6[EID4740PS_1540].xyz - EID4740PS_455;
                    float3 EID4740PS_1700 = -EID4740PS_1688;
                    float3 EID4740PS_1705 = lerp(EID4740PS_1699, EID4740PS_1700 * dot(EID4740PS_1699, EID4740PS_1700), (float(EID4740PS_1667 && (EID4740PS_35_m6[EID4740PS_1549].z > 0.5f)) * EID4740PS_1668).xxx);
                    float EID4740PS_1706 = dot(EID4740PS_1705, EID4740PS_1705);
                    float EID4740PS_1707 = rsqrt(EID4740PS_1706);
                    float3 EID4740PS_1708 = EID4740PS_1705 * EID4740PS_1707;
                    float3 EID4740PS_1741;
                    float EID4740PS_1742;
                    if (EID4740PS_1666)
                    {
                        float3 EID4740PS_1712 = (EID4740PS_1688 * EID4740PS_35_m6[EID4740PS_1543].z) * 0.5f;
                        float3 EID4740PS_1713 = EID4740PS_1705 - EID4740PS_1712;
                        float3 EID4740PS_1714 = EID4740PS_1705 + EID4740PS_1712;
                        float EID4740PS_1715 = length(EID4740PS_1713);
                        float EID4740PS_1716 = length(EID4740PS_1714);
                        float3 EID4740PS_1725 = normalize(cross(cross(EID4740PS_1688, EID4740PS_1708), EID4740PS_1688));
                        EID4740PS_1741 = EID4740PS_1725;
                        EID4740PS_1742 = ((1.0f / ((((EID4740PS_1715 * EID4740PS_1716) + dot(EID4740PS_1713, EID4740PS_1714)) * 0.5f) + 1.0f)) * clamp(0.5f * ((dot(EID4740PS_1725, EID4740PS_1713) / EID4740PS_1715) + (dot(EID4740PS_1725, EID4740PS_1714) / EID4740PS_1716)), 0.0f, 1.0f)) * (1.0f / clamp(1.0f + (0.5f * clamp(EID4740PS_35_m6[EID4740PS_1543].z * EID4740PS_1707, 0.0f, 1.0f)), 0.0f, 1.0f));
                    }
                    else
                    {
                        EID4740PS_1741 = EID4740PS_1708;
                        EID4740PS_1742 = 1.0f;
                    }
                    float EID4740PS_1764;
                    if (EID4740PS_1694 < 0.0f)
                    {
                        float EID4740PS_1758 = EID4740PS_1706 * (EID4740PS_35_m6[EID4740PS_1540].w * EID4740PS_35_m6[EID4740PS_1540].w);
                        float EID4740PS_1761 = clamp(1.0f - (EID4740PS_1758 * EID4740PS_1758), 0.0f, 1.0f);
                        EID4740PS_1764 = lerp(1.0f / (EID4740PS_1706 + 1.0f), EID4740PS_1742, float(EID4740PS_1666)) * (EID4740PS_1761 * EID4740PS_1761);
                    }
                    else
                    {
                        float3 EID4740PS_1747 = EID4740PS_1705 * EID4740PS_35_m6[EID4740PS_1540].w;
                        EID4740PS_1764 = EID4740PS_1742 * pow(1.0f - clamp(dot(EID4740PS_1747, EID4740PS_1747), 0.0f, 1.0f), EID4740PS_1694);
                    }
                    float EID4740PS_1769 = clamp((dot(EID4740PS_1741, EID4740PS_1700) - EID4740PS_35_m6[EID4740PS_1543].z) * EID4740PS_35_m6[EID4740PS_1543].w, 0.0f, 1.0f);
                    float EID4740PS_1772 = EID4740PS_1764 * lerp(1.0f, EID4740PS_1769 * EID4740PS_1769, EID4740PS_1668);
                    int EID4740PS_1774 = int(EID4740PS_35_m6[EID4740PS_1558].w);
                    float EID4740PS_1879;
                    if ((!EID4740PS_1666) && (EID4740PS_1774 >= 0))
                    {
                        uint EID4740PS_1780 = uint(EID4740PS_1774);
                        float2 EID4740PS_1872;
                        [branch]
                        if (EID4740PS_1668 != 0.0f)
                        {
                            float4 EID4740PS_1862 = mul(EID4740PS_55_m1[EID4740PS_1780], float4(EID4740PS_455, 1.0f));
                            EID4740PS_1872 = EID4740PS_55_m0[EID4740PS_1780].xy + (clamp(EID4740PS_1862.xy / EID4740PS_1862.w.xx, 0.0f.xx, 1.0f.xx) * EID4740PS_55_m0[EID4740PS_1780].zw);
                        }
                        else
                        {
                            float3 EID4740PS_1795 = mul(float4(-EID4740PS_1705, 0.0f), EID4740PS_55_m1[EID4740PS_1780]).xyz;
                            float3 EID4740PS_340 = EID4740PS_1795;
                            float3 EID4740PS_339 = EID4740PS_1795;
                            float3 EID4740PS_338 = abs(EID4740PS_1795);
                            uint EID4740PS_1804 = uint(int(EID4740PS_338.y > EID4740PS_338.x));
                            uint EID4740PS_1810 = (EID4740PS_338.z > EID4740PS_338[EID4740PS_1804]) ? 2u : EID4740PS_1804;
                            uint EID4740PS_1816 = (EID4740PS_1810 * 2u) + uint(EID4740PS_339[EID4740PS_1810] < 0.0f);
                            float EID4740PS_1820 = abs(EID4740PS_340[EID4740PS_1816 / 2u]);
                            float EID4740PS_1840 = 0.5f - (0.000244140625f / EID4740PS_55_m0[EID4740PS_1780].w);
                            EID4740PS_1872 = EID4740PS_55_m0[EID4740PS_1780].xy + (clamp(float2((float(EID4740PS_1816) + ((((EID4740PS_340[uint(EID4740PS_312[EID4740PS_1816].x)] * EID4740PS_313[EID4740PS_1816].x) / EID4740PS_1820) * EID4740PS_1840) + 0.5f)) * 0.16666667163372039794921875f, 0.5f - (((EID4740PS_340[uint(EID4740PS_312[EID4740PS_1816].y)] * EID4740PS_313[EID4740PS_1816].y) / EID4740PS_1820) * EID4740PS_1840)), 0.0f.xx, 1.0f.xx) * EID4740PS_55_m0[EID4740PS_1780].zw);
                        }
                        EID4740PS_1879 = EID4740PS_1772 * EID4740PS_53.SampleLevel(EID4740_linear_clamp_sampler, EID4740PS_1872, 0.0f).x;
                    }
                    else
                    {
                        EID4740PS_1879 = EID4740PS_1772;
                    }
                    float EID4740PS_1880 = EID4740PS_1879 * EID4740PS_1637;
                    float3 EID4740PS_2272;
                    EID4740PS_EarlyExit0(EID4740PS_1150, EID4740PS_1156, EID4740PS_1157, EID4740PS_1365, EID4740PS_1406, EID4740PS_1434, EID4740PS_1501, EID4740PS_1537, EID4740PS_1540, EID4740PS_1543, EID4740PS_1546, EID4740PS_1549, EID4740PS_1562, EID4740PS_1650, EID4740PS_1662, EID4740PS_1667, EID4740PS_1741, EID4740PS_1880, EID4740PS_2272, EID4740PS_455, EID4740PS_462, EID4740PS_473, EID4740PS_507);
                    EID4740PS_2273 = EID4740PS_2272;
                    return;
}

void EID4740PS_frag_main()
{
    float EID4740PS_351 = 1.0f / EID4740PS_gl_FragCoord.w;
    float3 EID4740PS_366 = lerp(-EID4740PS_4, float3(EID4740PS_17_m0[2u].x, EID4740PS_17_m0[2u].y, EID4740PS_17_m0[2u].z), EID4740PS_19_m4.w.xxx);
    float EID4740PS_367 = dot(EID4740PS_366, EID4740PS_366);
    float EID4740PS_369 = rsqrt(max(EID4740PS_367, 9.9999999392252902907785028219223e-09f));
    float3 EID4740PS_370 = EID4740PS_366 * EID4740PS_369;
    float EID4740PS_371 = EID4740PS_367 * EID4740PS_369;
    uint EID4740PS_374 = asuint(EID4740PS_LoadInstance(EID4740PS_12)._m2.x);
    bool EID4740PS_379 = (asuint(EID4740PS_LoadInstance(EID4740PS_12)._m1.w) & 16u) != 0u;
    float4 EID4740PS_396;
    float4 EID4740PS_397;
    float4 EID4740PS_398;
    if (EID4740PS_379)
    {
        EID4740PS_396 = asfloat(EID4740PS_31.Load4((EID4740PS_374 + 2u) * 16 + 0));
        EID4740PS_397 = asfloat(EID4740PS_31.Load4((EID4740PS_374 + 1u) * 16 + 0));
        EID4740PS_398 = asfloat(EID4740PS_31.Load4(EID4740PS_374 * 16 + 0));
    }
    else
    {
        EID4740PS_396 = EID4740PS_LoadInstance(EID4740PS_12)._m0[2];
        EID4740PS_397 = EID4740PS_LoadInstance(EID4740PS_12)._m0[1];
        EID4740PS_398 = EID4740PS_LoadInstance(EID4740PS_12)._m0[0];
    }
    float2 EID4740PS_399 = frac(EID4740PS_3);
    float2 EID4740PS_400 = EID4740PS_399 - 0.5f.xx;
    float EID4740PS_401 = dot(EID4740PS_400, EID4740PS_400);
    float EID4740PS_402 = step(0.25f, EID4740PS_401);
    float EID4740PS_404 = 1.0f / length(EID4740PS_5);
    float3 EID4740PS_410 = cross(EID4740PS_5, EID4740PS_6.xyz);
    float4 EID4740PS_431 = EID4740PS_51.SampleBias(EID4740_linear_repeat_sampler, EID4740PS_3 - (((normalize(mul(float3x3(EID4740PS_6.xyz * EID4740PS_404, (EID4740PS_410 * ((EID4740PS_6.w > 0.0f) ? 1.0f : (-1.0f))) * EID4740PS_404, EID4740PS_5 * EID4740PS_404), EID4740PS_370)).xy * EID4740PS_48_m31) * float2(1.0f, 0.25f)) * smoothstep(0.25f, 0.0500000007450580596923828125f, EID4740PS_401)), EID4740PS_19_m16);
    float3 EID4740PS_436 = EID4740PS_431.xyz * EID4740PS_48_m24.xyz;
    float EID4740PS_442 = EID4740PS_431.w * EID4740PS_48_m24.w;
    float3 EID4740PS_447 = EID4740PS_436 * EID4740PS_48_m18;
    float3 EID4740PS_451 = lerp(dot(EID4740PS_447, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, EID4740PS_447, EID4740PS_48_m19.xxx);
    float3 EID4740PS_455 = EID4740PS_4 + EID4740PS_17_m11.xyz;
    float3 EID4740PS_460 = EID4740PS_455 - float3(EID4740PS_398.w, EID4740PS_335, EID4740PS_396.w);
    EID4740PS_460.y = 6.103515625e-05f;
    float3 EID4740PS_462 = normalize(EID4740PS_460);
    float3x3 EID4740PS_467 = float3x3(EID4740PS_6.xyz * 1.0f, (EID4740PS_410 * EID4740PS_6.w) * 1.0f, EID4740PS_5 * 1.0f);
    float3 EID4740PS_473 = normalize(EID4740PS_5) * (EID4740PS_gl_FrontFacing ? 1.0f : ((-1.0f) + (2.0f * EID4740PS_48_m5)));
    float2 EID4740PS_478 = (EID4740PS_399 * 2.0f) - 1.0f.xx;
    float2 EID4740PS_480 = EID4740PS_478.xy;
    float EID4740PS_484 = sqrt(1.0f - clamp(dot(EID4740PS_480, EID4740PS_480), 0.0f, 1.0f));
    float3 EID4740PS_486 = float3(EID4740PS_478.x, EID4740PS_478.y, EID4740PS_333.z);
    EID4740PS_486.z = max(1.000000016862383526387164645044e-16f, EID4740PS_484);
    float2 EID4740PS_488 = EID4740PS_486.xy * (-EID4740PS_48_m39);
    float3 EID4740PS_489 = float3(EID4740PS_488.x, EID4740PS_488.y, EID4740PS_486.z);
    float3 EID4740PS_494 = normalize(mul(lerp(EID4740PS_489 * float3(-0.125f, -0.125f, 1.0f), float3(0.0f, 0.0f, 1.0f), EID4740PS_402.xxx), EID4740PS_467));
    uint2 EID4740PS_497 = uint2(EID4740PS_gl_FragCoord.xy);
    float3 EID4740PS_507 = mul(float3x3(EID4740PS_17_m1[0].xyz, EID4740PS_17_m1[1].xyz, EID4740PS_17_m1[2].xyz), float3(0.0f, 0.0f, 1.0f));
    float4 EID4740PS_521 = float4(EID4740PS_335, EID4740PS_335, EID4740PS_335, float((asuint((EID4740PS_19_m89.x > 0.5f) ? EID4740PS_19_m89.y : EID4740PS_LoadInstance(EID4740PS_12)._m7.x) >> 24u) & 255u)) * 0.0039215688593685626983642578125f.xxxx;
    float EID4740PS_522 = EID4740PS_521.w;
    float EID4740PS_530 = lerp(EID4740PS_19_m22.x, 1.0f, EID4740PS_19_m91.w) * EID4740PS_19_m20.x;
    float EID4740PS_532 = EID4740PS_494.z;
    float3 EID4740PS_534 = normalize(float3(EID4740PS_494.x, 6.103515625e-05f, EID4740PS_532));
    float4 EID4740PS_1028;
    float3 EID4740PS_1029;
    float3 EID4740PS_1030;
    float EID4740PS_1031;
    if (EID4740PS_19_m80.y < 0.5f)
    {
        float3 EID4740PS_552 = EID4740PS_455 - (EID4740PS_19_m105.xyz + (EID4740PS_507 * (-EID4740PS_19_m107.w)));
        float EID4740PS_554 = abs(EID4740PS_552.x);
        float EID4740PS_556 = abs(EID4740PS_552.z);
        float EID4740PS_562 = clamp(((max(EID4740PS_554, EID4740PS_556)) - 464.0f) * 0.03125f, 0.0f, 1.0f);
        float EID4740PS_565 = clamp((abs(EID4740PS_552.y) - 208.0f) * 0.03125f, 0.0f, 1.0f);
        float EID4740PS_566 = max(EID4740PS_562, EID4740PS_565);
        float4 EID4740PS_868;
        float4 EID4740PS_869;
        float4 EID4740PS_870;
        float EID4740PS_871;
        float EID4740PS_872;
        if ((EID4740PS_19_m105.w != 0.0f) && (EID4740PS_566 < 1.0f))
        {
            float3 EID4740PS_579 = EID4740PS_455 - (EID4740PS_19_m105.xyz + (EID4740PS_507 * (-EID4740PS_19_m107.y)));
            float EID4740PS_581 = abs(EID4740PS_579.x);
            float EID4740PS_583 = abs(EID4740PS_579.z);
            float EID4740PS_589 = clamp(((max(EID4740PS_581, EID4740PS_583)) - 29.0f) * 0.5f, 0.0f, 1.0f);
            float EID4740PS_592 = clamp((abs(EID4740PS_579.y) - 13.0f) * 0.5f, 0.0f, 1.0f);
            float EID4740PS_593 = max(EID4740PS_589, EID4740PS_592);
            float EID4740PS_669;
            float4 EID4740PS_670;
            float4 EID4740PS_671;
            float4 EID4740PS_672;
            if (EID4740PS_593 < 1.0f)
            {
                float3 EID4740PS_602 = ((EID4740PS_455 * 2.0f) + 0.5f.xxx) * EID4740PS_19_m106.xyz;
                float3 EID4740PS_604 = EID4740PS_602 - floor(EID4740PS_602);
                float4 EID4740PS_608 = EID4740PS_41.SampleLevel(EID4740_linear_repeat_sampler, EID4740PS_604, 0.0f);
                float EID4740PS_609 = 1.0f - EID4740PS_593;
                float EID4740PS_613 = EID4740PS_19_m106.y * 0.5f;
                float EID4740PS_618 = EID4740PS_604.x;
                float EID4740PS_619 = clamp(EID4740PS_604.y, EID4740PS_613, 1.0f - EID4740PS_613) * 0.3333333432674407958984375f;
                float EID4740PS_620 = EID4740PS_604.z;
                float4 EID4740PS_623 = EID4740PS_42.SampleLevel(EID4740_linear_clamp_sampler, float3(EID4740PS_618, EID4740PS_619, EID4740PS_620), 0.0f);
                float EID4740PS_639 = EID4740PS_608.x;
                float EID4740PS_649 = EID4740PS_608.y;
                float EID4740PS_659 = EID4740PS_608.z;
                EID4740PS_669 = EID4740PS_566 + (EID4740PS_623.w * EID4740PS_609);
                EID4740PS_670 = float4(((EID4740PS_42.SampleLevel(EID4740_linear_clamp_sampler, float3(EID4740PS_618, EID4740PS_619 + 0.666666686534881591796875f, EID4740PS_620), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4740PS_659, EID4740PS_659) * EID4740PS_609;
                EID4740PS_671 = float4(((EID4740PS_42.SampleLevel(EID4740_linear_clamp_sampler, float3(EID4740PS_618, EID4740PS_619 + 0.3333333432674407958984375f, EID4740PS_620), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4740PS_649, EID4740PS_649) * EID4740PS_609;
                EID4740PS_672 = float4(((EID4740PS_623.xyz * 4.0f) - 2.0f.xxx) * EID4740PS_639, EID4740PS_639) * EID4740PS_609;
            }
            else
            {
                EID4740PS_669 = EID4740PS_566;
                EID4740PS_670 = 0.0f.xxxx;
                EID4740PS_671 = 0.0f.xxxx;
                EID4740PS_672 = 0.0f.xxxx;
            }
            float3 EID4740PS_678 = EID4740PS_455 - (EID4740PS_19_m105.xyz + (EID4740PS_507 * (-EID4740PS_19_m107.z)));
            float EID4740PS_680 = abs(EID4740PS_678.x);
            float EID4740PS_682 = abs(EID4740PS_678.z);
            float EID4740PS_688 = clamp(((max(EID4740PS_680, EID4740PS_682)) - 116.0f) * 0.125f, 0.0f, 1.0f);
            float EID4740PS_691 = clamp((abs(EID4740PS_678.y) - 52.0f) * 0.125f, 0.0f, 1.0f);
            float EID4740PS_692 = max(EID4740PS_688, EID4740PS_691);
            float EID4740PS_772;
            float4 EID4740PS_773;
            float4 EID4740PS_774;
            float4 EID4740PS_775;
            if (EID4740PS_692 < 1.0f)
            {
                float3 EID4740PS_701 = ((EID4740PS_455 * 0.5f) + 0.5f.xxx) * EID4740PS_19_m106.xyz;
                float3 EID4740PS_703 = EID4740PS_701 - floor(EID4740PS_701);
                float4 EID4740PS_707 = EID4740PS_43.SampleLevel(EID4740_linear_repeat_sampler, EID4740PS_703, 0.0f);
                float EID4740PS_709 = EID4740PS_593 * (1.0f - EID4740PS_692);
                float EID4740PS_713 = EID4740PS_19_m106.y * 0.5f;
                float EID4740PS_718 = EID4740PS_703.x;
                float EID4740PS_719 = clamp(EID4740PS_703.y, EID4740PS_713, 1.0f - EID4740PS_713) * 0.3333333432674407958984375f;
                float EID4740PS_720 = EID4740PS_703.z;
                float4 EID4740PS_723 = EID4740PS_44.SampleLevel(EID4740_linear_clamp_sampler, float3(EID4740PS_718, EID4740PS_719, EID4740PS_720), 0.0f);
                float EID4740PS_739 = EID4740PS_707.x;
                float EID4740PS_750 = EID4740PS_707.y;
                float EID4740PS_761 = EID4740PS_707.z;
                EID4740PS_772 = EID4740PS_669 + (EID4740PS_723.w * EID4740PS_709);
                EID4740PS_773 = EID4740PS_670 + (float4(((EID4740PS_44.SampleLevel(EID4740_linear_clamp_sampler, float3(EID4740PS_718, EID4740PS_719 + 0.666666686534881591796875f, EID4740PS_720), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4740PS_761, EID4740PS_761) * EID4740PS_709);
                EID4740PS_774 = EID4740PS_671 + (float4(((EID4740PS_44.SampleLevel(EID4740_linear_clamp_sampler, float3(EID4740PS_718, EID4740PS_719 + 0.3333333432674407958984375f, EID4740PS_720), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4740PS_750, EID4740PS_750) * EID4740PS_709);
                EID4740PS_775 = EID4740PS_672 + (float4(((EID4740PS_723.xyz * 4.0f) - 2.0f.xxx) * EID4740PS_739, EID4740PS_739) * EID4740PS_709);
            }
            else
            {
                EID4740PS_772 = EID4740PS_669;
                EID4740PS_773 = EID4740PS_670;
                EID4740PS_774 = EID4740PS_671;
                EID4740PS_775 = EID4740PS_672;
            }
            float4 EID4740PS_858;
            float4 EID4740PS_859;
            float4 EID4740PS_860;
            float EID4740PS_861;
            if (EID4740PS_692 > 0.0f)
            {
                float3 EID4740PS_784 = ((EID4740PS_455 * 0.125f) + 0.5f.xxx) * EID4740PS_19_m106.xyz;
                float3 EID4740PS_787 = EID4740PS_19_m106.xyz * 0.5f;
                float3 EID4740PS_789 = clamp(EID4740PS_784 - floor(EID4740PS_784), EID4740PS_787, 1.0f.xxx - EID4740PS_787);
                float4 EID4740PS_793 = EID4740PS_45.SampleLevel(EID4740_linear_repeat_sampler, EID4740PS_789, 0.0f);
                float EID4740PS_795 = EID4740PS_692 * (1.0f - EID4740PS_566);
                float EID4740PS_799 = EID4740PS_19_m106.y * 0.5f;
                float EID4740PS_804 = EID4740PS_789.x;
                float EID4740PS_805 = clamp(EID4740PS_789.y, EID4740PS_799, 1.0f - EID4740PS_799) * 0.3333333432674407958984375f;
                float EID4740PS_806 = EID4740PS_789.z;
                float4 EID4740PS_809 = EID4740PS_46.SampleLevel(EID4740_linear_clamp_sampler, float3(EID4740PS_804, EID4740PS_805, EID4740PS_806), 0.0f);
                float EID4740PS_825 = EID4740PS_793.x;
                float EID4740PS_836 = EID4740PS_793.y;
                float EID4740PS_847 = EID4740PS_793.z;
                EID4740PS_858 = EID4740PS_773 + (float4(((EID4740PS_46.SampleLevel(EID4740_linear_clamp_sampler, float3(EID4740PS_804, EID4740PS_805 + 0.666666686534881591796875f, EID4740PS_806), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4740PS_847, EID4740PS_847) * EID4740PS_795);
                EID4740PS_859 = EID4740PS_774 + (float4(((EID4740PS_46.SampleLevel(EID4740_linear_clamp_sampler, float3(EID4740PS_804, EID4740PS_805 + 0.3333333432674407958984375f, EID4740PS_806), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4740PS_836, EID4740PS_836) * EID4740PS_795);
                EID4740PS_860 = EID4740PS_775 + (float4(((EID4740PS_809.xyz * 4.0f) - 2.0f.xxx) * EID4740PS_825, EID4740PS_825) * EID4740PS_795);
                EID4740PS_861 = EID4740PS_772 + (EID4740PS_809.w * EID4740PS_795);
            }
            else
            {
                EID4740PS_858 = EID4740PS_773;
                EID4740PS_859 = EID4740PS_774;
                EID4740PS_860 = EID4740PS_775;
                EID4740PS_861 = EID4740PS_772;
            }
            float EID4740PS_864 = clamp((EID4740PS_861 * 2.0f) - 1.0f, 0.0f, 1.0f);
            EID4740PS_868 = EID4740PS_858;
            EID4740PS_869 = EID4740PS_859;
            EID4740PS_870 = EID4740PS_860;
            EID4740PS_871 = EID4740PS_864 - EID4740PS_566;
            EID4740PS_872 = (EID4740PS_864 + EID4740PS_566) * 0.5f;
        }
        else
        {
            EID4740PS_868 = 0.0f.xxxx;
            EID4740PS_869 = 0.0f.xxxx;
            EID4740PS_870 = 0.0f.xxxx;
            EID4740PS_871 = 0.0f;
            EID4740PS_872 = 1.0f;
        }
        float4 EID4740PS_892 = EID4740PS_870 + float4(EID4740PS_19_m108.x * EID4740PS_872, (EID4740PS_19_m108.y * EID4740PS_872) + ((EID4740PS_19_m108.w * EID4740PS_871) * 0.5f), EID4740PS_19_m108.z * EID4740PS_872, (EID4740PS_19_m108.w * EID4740PS_872) + ((EID4740PS_19_m108.y * EID4740PS_871) * 0.375f));
        float4 EID4740PS_912 = EID4740PS_869 + float4(EID4740PS_19_m109.x * EID4740PS_872, (EID4740PS_19_m109.y * EID4740PS_872) + ((EID4740PS_19_m109.w * EID4740PS_871) * 0.5f), EID4740PS_19_m109.z * EID4740PS_872, (EID4740PS_19_m109.w * EID4740PS_872) + ((EID4740PS_19_m109.y * EID4740PS_871) * 0.375f));
        float4 EID4740PS_932 = EID4740PS_868 + float4(EID4740PS_19_m110.x * EID4740PS_872, (EID4740PS_19_m110.y * EID4740PS_872) + ((EID4740PS_19_m110.w * EID4740PS_871) * 0.5f), EID4740PS_19_m110.z * EID4740PS_872, (EID4740PS_19_m110.w * EID4740PS_872) + ((EID4740PS_19_m110.y * EID4740PS_871) * 0.375f));
        float4 EID4740PS_936 = float4(EID4740PS_534, 1.0f);
        float3 EID4740PS_940 = float3(dot(EID4740PS_892, EID4740PS_936), dot(EID4740PS_912, EID4740PS_936), dot(EID4740PS_932, EID4740PS_936));
        float3 EID4740PS_942 = max(EID4740PS_940, 0.0f.xxx) * EID4740PS_530;
        float3 EID4740PS_950 = ((EID4740PS_892.xyz * 0.2125999927520751953125f) + (EID4740PS_912.xyz * 0.715200006961822509765625f)) + (EID4740PS_932.xyz * 0.072200000286102294921875f);
        float EID4740PS_951 = dot(EID4740PS_950, EID4740PS_950);
        float3 EID4740PS_954 = EID4740PS_950 * rsqrt(max(1.1754943508222875079687365372222e-38f, EID4740PS_951));
        float EID4740PS_956 = abs(EID4740PS_954.y);
        float3 EID4740PS_957 = EID4740PS_954;
        EID4740PS_957.y = EID4740PS_956;
        float4 EID4740PS_959 = float4(EID4740PS_957.x, EID4740PS_957.y, EID4740PS_957.z, 0.0f.xxxx.w);
        EID4740PS_959.w = 1.0f;
        float4 EID4740PS_962 = float4(EID4740PS_954.x, EID4740PS_956, EID4740PS_954.z, 1.0f);
        float3 EID4740PS_966 = float3(dot(EID4740PS_892, EID4740PS_962), dot(EID4740PS_912, EID4740PS_962), dot(EID4740PS_932, EID4740PS_962));
        float3 EID4740PS_967 = max(EID4740PS_966, 0.0f.xxx);
        float EID4740PS_968 = EID4740PS_967.x;
        float EID4740PS_969 = EID4740PS_967.y;
        float EID4740PS_970 = EID4740PS_967.z;
        float EID4740PS_971 = max(EID4740PS_968, EID4740PS_969);
        float EID4740PS_972 = max(EID4740PS_971, EID4740PS_970);
        float EID4740PS_975 = EID4740PS_942.z;
        float EID4740PS_976 = EID4740PS_942.y;
        float4 EID4740PS_981 = lerp(float4(EID4740PS_975, EID4740PS_976, -1.0f, 0.666666686534881591796875f), float4(EID4740PS_976, EID4740PS_975, 0.0f, -0.3333333432674407958984375f), step(EID4740PS_975, EID4740PS_976).xxxx);
        float EID4740PS_982 = EID4740PS_942.x;
        float EID4740PS_983 = EID4740PS_981.x;
        float4 EID4740PS_991 = lerp(float4(EID4740PS_983, EID4740PS_981.yw, EID4740PS_982), float4(EID4740PS_982, EID4740PS_981.yz, EID4740PS_983), step(EID4740PS_983, EID4740PS_982).xxxx);
        float EID4740PS_992 = EID4740PS_991.x;
        float EID4740PS_993 = EID4740PS_991.w;
        float EID4740PS_994 = EID4740PS_991.y;
        float EID4740PS_996 = EID4740PS_992 - (min(EID4740PS_993, EID4740PS_994));
        float EID4740PS_1005 = EID4740PS_996 / (EID4740PS_992 + 9.9999997473787516355514526367188e-05f);
        float EID4740PS_1006 = frac(abs(EID4740PS_991.z + ((EID4740PS_993 - EID4740PS_994) / ((6.0f * EID4740PS_996) + 9.9999997473787516355514526367188e-05f))));
        float EID4740PS_1012 = lerp(0.699999988079071044921875f, 0.3499999940395355224609375f, smoothstep(0.449999988079071044921875f, 0.3499999940395355224609375f, abs(EID4740PS_1006 - 0.5f))) * clamp(EID4740PS_992, 0.0f, 1.0f);
        float EID4740PS_1013 = min(EID4740PS_1005, EID4740PS_1012);
        float EID4740PS_1015 = 2.0f / (2.0f - EID4740PS_1013);
        EID4740PS_1028 = EID4740PS_959;
        EID4740PS_1029 = EID4740PS_942;
        EID4740PS_1030 = lerp(1.0f.xxx, clamp(abs((frac(float3(EID4740PS_1006, EID4740PS_1013, EID4740PS_1015).xxx + float3(1.0f, 0.666666686534881591796875f, 0.3333333432674407958984375f)) * 6.0f) - 3.0f.xxx) - 1.0f.xxx, 0.0f.xxx, 1.0f.xxx), EID4740PS_1013.xxx) * EID4740PS_1015;
        EID4740PS_1031 = (max(EID4740PS_972, 0.0f)) * EID4740PS_530;
    }
    else
    {
        EID4740PS_1028 = 0.0f.xxxx;
        EID4740PS_1029 = 1.0f.xxx;
        EID4740PS_1030 = EID4740PS_19_m81.xyz;
        EID4740PS_1031 = EID4740PS_530;
    }
    float3 EID4740PS_1150;
    float3 EID4740PS_1151;
    float3 EID4740PS_1152;
    float EID4740PS_1153;
    [branch]
    if (EID4740PS_522 > 0.00999999977648258209228515625f)
    {
        bool3 EID4740PS_1050 = EID4740PS_379.xxx;
        float3 EID4740PS_1052 = EID4740PS_10.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 EID4740PS_1053 = float3(EID4740PS_1050.x ? EID4740PS_1052.x : EID4740PS_10.x, EID4740PS_1050.y ? EID4740PS_1052.y : EID4740PS_10.y, EID4740PS_1050.z ? EID4740PS_1052.z : EID4740PS_10.z);
        float3 EID4740PS_1056 = EID4740PS_1053 * EID4740PS_19_m89.z;
        float3 EID4740PS_1060 = abs(float3(EID4740PS_1050.x ? EID4740PS_9.xzy.x : EID4740PS_9.x, EID4740PS_1050.y ? EID4740PS_9.xzy.y : EID4740PS_9.y, EID4740PS_1050.z ? EID4740PS_9.xzy.z : EID4740PS_9.z)) - 0.20000000298023223876953125f.xxx;
        float3 EID4740PS_1062 = (EID4740PS_1060 * EID4740PS_1060) * EID4740PS_1060;
        float3 EID4740PS_1063 = max(EID4740PS_1062, 6.103515625e-05f.xxx);
        float3 EID4740PS_1066 = EID4740PS_1063 / dot(EID4740PS_1063, 1.0f.xxx).xxx;
        float EID4740PS_1096 = clamp(EID4740PS_522 + (smoothstep(0.3499999940395355224609375f, 0.20000000298023223876953125f, EID4740PS_1053.y) * clamp(EID4740PS_522 * 3.0f, 0.0f, 1.0f)), 0.0f, 1.0f);
        float EID4740PS_1101 = smoothstep(2.0f - EID4740PS_1096, 2.349999904632568359375f - EID4740PS_1096, 0.0f) * float(EID4740PS_gl_FrontFacing);
        float3 EID4740PS_1103 = EID4740PS_1101.xxx;
        float2 EID4740PS_1109 = ((((EID4740PS_50.SampleBias(EID4740_linear_repeat_sampler, EID4740PS_1056.xz, EID4740PS_19_m16) * EID4740PS_1066.y) + (EID4740PS_50.SampleBias(EID4740_linear_repeat_sampler, EID4740PS_1056.xy, EID4740PS_19_m16) * EID4740PS_1066.z)) + (EID4740PS_50.SampleBias(EID4740_linear_repeat_sampler, EID4740PS_1056.zy, EID4740PS_19_m16) * EID4740PS_1066.x)).xy * 2.0f) - 1.0f.xx;
        float2 EID4740PS_1111 = EID4740PS_1109.xy;
        float EID4740PS_1115 = sqrt(1.0f - clamp(dot(EID4740PS_1111, EID4740PS_1111), 0.0f, 1.0f));
        float3 EID4740PS_1117 = float3(EID4740PS_1109.x, EID4740PS_1109.y, EID4740PS_333.z);
        EID4740PS_1117.z = max(1.000000016862383526387164645044e-16f, EID4740PS_1115);
        float2 EID4740PS_1119 = EID4740PS_1117.xy * 2.0f;
        float3 EID4740PS_1121 = lerp(float3(0.0f, 0.0f, 1.0f), float3(EID4740PS_1119.x, EID4740PS_1119.y, EID4740PS_1117.z), EID4740PS_1103);
        float EID4740PS_1122 = dot(EID4740PS_1121, EID4740PS_1121);
        float3 EID4740PS_1125 = EID4740PS_1121 * rsqrt(max(6.103515625e-05f, EID4740PS_1122));
        float EID4740PS_1126 = EID4740PS_494.y;
        float EID4740PS_1129 = step(0.00999999977648258209228515625f, 1.0f - (EID4740PS_1126 * EID4740PS_1126));
        float EID4740PS_1132 = lerp(EID4740PS_532, EID4740PS_1126, EID4740PS_1129);
        float EID4740PS_1134 = 1.0f - (EID4740PS_1132 * EID4740PS_1132);
        float3 EID4740PS_1139 = (float3(0.0f, EID4740PS_1129, 1.0f - EID4740PS_1129) - (EID4740PS_494 * EID4740PS_1132)) * rsqrt(max(9.9999997473787516355514526367188e-05f, EID4740PS_1134));
        EID4740PS_1150 = ((cross(EID4740PS_1139, EID4740PS_494) * EID4740PS_1125.x) + (EID4740PS_1139 * EID4740PS_1125.y)) + (EID4740PS_494 * EID4740PS_1125.z);
        EID4740PS_1151 = lerp(EID4740PS_451 * 1.0f, 0.3079999983310699462890625f.xxx, EID4740PS_1103);
        EID4740PS_1152 = lerp(EID4740PS_436 * 1.0f, 0.87999999523162841796875f.xxx, EID4740PS_1103);
        EID4740PS_1153 = lerp(EID4740PS_48_m2, 0.0f, EID4740PS_1101);
    }
    else
    {
        EID4740PS_1150 = EID4740PS_494;
        EID4740PS_1151 = EID4740PS_451;
        EID4740PS_1152 = EID4740PS_436;
        EID4740PS_1153 = EID4740PS_48_m2;
    }
    float EID4740PS_1155 = 0.959999978542327880859375f - (EID4740PS_1153 * 0.959999978542327880859375f);
    float3 EID4740PS_1156 = EID4740PS_1152 * EID4740PS_1155;
    float3 EID4740PS_1157 = EID4740PS_1151 * EID4740PS_1155;
    float2 EID4740PS_1170 = (EID4740PS_7.xy / (max(EID4740PS_7.z, 9.9999999392252902907785028219223e-09f)).xx) - (EID4740PS_8.xy / (max(EID4740PS_8.z, 9.9999999392252902907785028219223e-09f)).xx);
    float2 EID4740PS_1173 = EID4740PS_1170;
    EID4740PS_1173.y = -EID4740PS_1170.y;
    float2 EID4740PS_1183 = ((sqrt(sqrt(abs(EID4740PS_1173 * 0.5f))) * float2(int2(sign(EID4740PS_1173)))) * 0.5f) + 0.5f.xx;
    float4 EID4740PS_1185 = float4(EID4740PS_1183.x, EID4740PS_1183.y, 0.0f.xxxx.z, 0.0f.xxxx.w);
    EID4740PS_1185.z = 1.0f;
    float4 EID4740PS_1186 = EID4740PS_1185;
    EID4740PS_1186.w = 0.4000000059604644775390625f;
    float3 EID4740PS_1197 = lerp(-EID4740PS_35_m0.xyz, EID4740PS_19_m90.xyz, EID4740PS_19_m80.w.xxx);
    float3 EID4740PS_1201 = normalize(float3(EID4740PS_1197.x, 6.103515625e-05f, EID4740PS_1197.z));
    float3 EID4740PS_1211 = lerp(EID4740PS_35_m3.xyz, EID4740PS_19_m84.xyz, EID4740PS_19_m91.y.xxx);
    float3 EID4740PS_1215 = EID4740PS_1211 * lerp(EID4740PS_35_m3.w, 1.0f, EID4740PS_19_m91.w);
    float3x3 EID4740PS_1220 = float3x3(EID4740PS_398.xyz, EID4740PS_397.xyz, EID4740PS_396.xyz);
    float3 EID4740PS_1221 = mul(EID4740PS_1197, EID4740PS_1220);
    float EID4740PS_1222 = dot(EID4740PS_1221, EID4740PS_1221);
    float3 EID4740PS_1227 = (EID4740PS_1221 * rsqrt(max(1.1754943508222875079687365372222e-38f, EID4740PS_1222))).xyz;
    EID4740PS_1227.y = 0.0f;
    float3 EID4740PS_1228 = mul(EID4740PS_1220, EID4740PS_1227);
    float EID4740PS_1229 = dot(EID4740PS_1228, EID4740PS_1228);
    int EID4740PS_1236 = int(EID4740PS_497.x);
    int EID4740PS_1237 = int(EID4740PS_497.y);
    float EID4740PS_1248 = lerp(lerp(1.0f, EID4740PS_39.Load(int3(int3(EID4740PS_1236, EID4740PS_1237, 0).xy, 0)).x, EID4740PS_37_m6.x), 1.0f, EID4740PS_19_m80.z);
    float3 EID4740PS_1256 = EID4740PS_1157 * EID4740PS_19_m79.z;
    float3 EID4740PS_1257 = EID4740PS_1256 * 0.64999997615814208984375f;
    float3 EID4740PS_1266 = EID4740PS_48_m37.xyz * EID4740PS_402;
    float3 EID4740PS_1273 = EID4740PS_48_m36.xyz * EID4740PS_442;
    float3 EID4740PS_1276 = EID4740PS_1156 * (((1.0f - EID4740PS_402).xxx + EID4740PS_1266) * ((1.0f - EID4740PS_442).xxx + EID4740PS_1273));
    float4 EID4740PS_1290 = EID4740PS_49.SampleLevel(EID4740_linear_clamp_sampler, float2((clamp(dot(EID4740PS_1150, (EID4740PS_1228 * rsqrt(max(1.1754943508222875079687365372222e-38f, EID4740PS_1229))).xyz) + (EID4740PS_19_m90.w * EID4740PS_19_m91.x), -1.0f, 1.0f) * 0.5f) + 0.5f, 0.5f), 0.0f);
    float EID4740PS_1291 = EID4740PS_1290.w;
    float EID4740PS_1293 = EID4740PS_1290.x;
    float EID4740PS_1294 = EID4740PS_1290.y;
    float EID4740PS_1295 = EID4740PS_1290.z;
    float EID4740PS_1296 = max(EID4740PS_1293, EID4740PS_1294);
    float EID4740PS_1298 = min(EID4740PS_1293, EID4740PS_1294);
    float EID4740PS_1300 = (max(EID4740PS_1296, EID4740PS_1295)) - (min(EID4740PS_1298, EID4740PS_1295));
    float4 EID4740PS_1308 = EID4740PS_49.SampleLevel(EID4740_linear_clamp_sampler, float2((dot(EID4740PS_1150, EID4740PS_507) * 0.5f) + 0.5f, 0.5f), 0.0f);
    float EID4740PS_1309 = EID4740PS_1308.w;
    float EID4740PS_1314 = min(1.0f, 1.0f);
    float EID4740PS_1315 = min(EID4740PS_1314, EID4740PS_1291);
    float3 EID4740PS_1319 = ((clamp(dot(EID4740PS_534, EID4740PS_19_m85.xyz) + EID4740PS_19_m86.x, 0.0f, 1.0f) * EID4740PS_19_m86.y) + EID4740PS_19_m86.z).xxx * lerp(EID4740PS_1030, 1.0f.xxx, (EID4740PS_19_m80.y * EID4740PS_1315).xxx);
    float3 EID4740PS_1321 = EID4740PS_1315.xxx;
    float EID4740PS_1334 = lerp(0.64999997615814208984375f, 1.0f, EID4740PS_1031);
    float3 EID4740PS_1344 = EID4740PS_1248.xxx;
    float3 EID4740PS_1345 = lerp((EID4740PS_1319 * lerp(min(EID4740PS_1334, 1.5f), clamp(EID4740PS_1031, 1.25f, 1.75f), EID4740PS_19_m80.x)) * EID4740PS_19_m79.w, (lerp(dot(EID4740PS_1215, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, EID4740PS_1215, EID4740PS_1321) + ((EID4740PS_1319 * clamp(EID4740PS_1031, 0.0f, 1.5f)) * ((1.0f - EID4740PS_19_m91.y).xxx + (EID4740PS_1211 * EID4740PS_19_m91.y)))) * EID4740PS_19_m79.y, EID4740PS_1344);
    float3 EID4740PS_1346 = lerp(lerp(lerp(dot(EID4740PS_1257, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, EID4740PS_1257, 1.2000000476837158203125f.xxx), EID4740PS_1256, clamp(EID4740PS_1309 + EID4740PS_1291, 0.0f, 1.0f).xxx), EID4740PS_1276, EID4740PS_1321);
    float3 EID4740PS_1352 = EID4740PS_1346 * ((1.0f - EID4740PS_1300).xxx + (EID4740PS_1290.xyz * EID4740PS_1300));
    float EID4740PS_1353 = dot(EID4740PS_1352, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float3 EID4740PS_1361 = lerp(lerp(EID4740PS_1256, EID4740PS_1276, EID4740PS_1309.xxx), EID4740PS_1352 * clamp(dot(EID4740PS_1346, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)) * (1.0f / (max(EID4740PS_1353, 0.001000000047497451305389404296875f))), 0.0f, 1.5f), EID4740PS_1344);
    float4 EID4740PS_1365 = float4(EID4740PS_1361, EID4740PS_1248);
    float EID4740PS_1367 = lerp(EID4740PS_1309, EID4740PS_1315, EID4740PS_1248);
    float4 EID4740PS_1390 = EID4740PS_52.SampleBias(EID4740_linear_clamp_sampler, (normalize(mul(float3x3(EID4740PS_17_m0[0].xyz, EID4740PS_17_m0[1].xyz, EID4740PS_17_m0[2].xyz), mul(EID4740PS_489, EID4740PS_467))).xy * 0.5f) + 0.5f.xx, EID4740PS_19_m16);
    float EID4740PS_1406 = (1.0f - EID4740PS_48_m6) + (EID4740PS_442 * EID4740PS_48_m6);
    float3 EID4740PS_1408 = ((EID4740PS_1345 * EID4740PS_1361) * EID4740PS_1406) + (((EID4740PS_1390.xyz * EID4740PS_48_m42.w) + (EID4740PS_48_m42.xyz * EID4740PS_1390.w)) * ((EID4740PS_1345 * (((EID4740PS_1367 * 0.5f) + 0.5f) * lerp(EID4740PS_19_m79.z, 1.0f, EID4740PS_1367))) * 1.0f));
    float EID4740PS_1409 = dot(EID4740PS_1408, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float EID4740PS_1412 = clamp(EID4740PS_1409 - 0.5f, 0.0f, 0.5f);
    float EID4740PS_1417 = dot(EID4740PS_1201, EID4740PS_1150);
    float EID4740PS_1428 = dot(EID4740PS_370, EID4740PS_1150);
    float EID4740PS_1434 = 1.0f - EID4740PS_1248;
    float EID4740PS_1446 = max(EID4740PS_1029.x, EID4740PS_1029.y);
    float EID4740PS_1448 = (max(EID4740PS_1446, EID4740PS_1029.z)) * 0.5f;
    float2 EID4740PS_1475 = float2(EID4740PS_497);
    float2 EID4740PS_1477 = floor(EID4740PS_1475 * 0.03125f);
    int EID4740PS_1485 = int((EID4740PS_1477.x + (EID4740PS_1477.y * EID4740PS_33_m5)) * 8.0f);
    float EID4740PS_1492 = floor(EID4740PS_351 - (EID4740PS_19_m3.y * EID4740PS_33_m11));
    float EID4740PS_1496 = clamp(EID4740PS_1492, 0.0f, EID4740PS_33_m7 - 1.0f);
    int EID4740PS_1498 = int(EID4740PS_1496 * 8.0f);
    float3 EID4740PS_1500;
    EID4740PS_1500 = (lerp(EID4740PS_1409.xxx, EID4740PS_1408, ((EID4740PS_1412 * EID4740PS_1412) + 1.0f).xxx) + ((((((lerp(EID4740PS_1029 * (1.0f / (max(EID4740PS_1448, 1.0f))), EID4740PS_1215, EID4740PS_1344) * clamp(lerp(dot(EID4740PS_1028.xyz, EID4740PS_1150) * EID4740PS_1028.w, ((-EID4740PS_1417) * ((EID4740PS_1417 * 0.5f) - 1.0f)) + 0.5f, EID4740PS_1248), 0.0f, 1.0f)) * ((EID4740PS_1434 + (clamp(-dot(EID4740PS_1201.xz, normalize(EID4740PS_507.xz)), 0.0f, 1.0f) * EID4740PS_1248)) * (1.0f - EID4740PS_19_m91.x))) * smoothstep(0.60000002384185791015625f, 0.800000011920928955078125f, 1.0f - abs(EID4740PS_1428))) * EID4740PS_1314) * (EID4740PS_1434 + (smoothstep(0.100000001490116119384765625f, 0.039999999105930328369140625f, dot(EID4740PS_1156, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f))) * EID4740PS_1248))) * max(0.1500000059604644775390625f.xxx, EID4740PS_1156))) + ((((EID4740PS_1266 * EID4740PS_19_m92.y) + (EID4740PS_1273 * EID4740PS_19_m92.z)) + (EID4740PS_1152 * EID4740PS_19_m92.x)) * EID4740PS_1406);
    float3 EID4740PS_1501;
    [loop]
    for (int EID4740PS_1503 = 0; EID4740PS_1503 <= 7; EID4740PS_1500 = EID4740PS_1501, EID4740PS_1503++)
    {
        uint EID4740PS_1521 = (EID4740PS_1492 <= EID4740PS_1496) ? (EID4740PS_29.Load(uint(EID4740PS_1485 + EID4740PS_1503) * 4 + 0) & EID4740PS_29.Load(uint((EID4740PS_19_m21.y + EID4740PS_1498) + EID4740PS_1503) * 4 + 0)) : 0u;
        uint EID4740PS_1522 = uint(EID4740PS_1503);
        EID4740PS_1501 = EID4740PS_1500;
        uint EID4740PS_1527;
        float3 EID4740PS_1524;
        [loop]
        for (uint EID4740PS_1526 = EID4740PS_1521; EID4740PS_1526 != 0u; EID4740PS_1501 = EID4740PS_1524, EID4740PS_1526 = EID4740PS_1527)
        {
            uint EID4740PS_1531 = firstbitlow(EID4740PS_1526);
            EID4740PS_1527 = EID4740PS_1526 ^ (1u << (EID4740PS_1531 & 31u));
            int EID4740PS_1537 = int((32u * EID4740PS_1522) + EID4740PS_1531) * 8;
            int EID4740PS_1540 = EID4740PS_1537 + 1;
            int EID4740PS_1543 = EID4740PS_1537 + 2;
            int EID4740PS_1546 = EID4740PS_1537 + 3;
            int EID4740PS_1549 = EID4740PS_1537 + 4;
            int EID4740PS_1552 = EID4740PS_1537 + 5;
            int EID4740PS_1555 = EID4740PS_1537 + 6;
            int EID4740PS_1558 = EID4740PS_1537 + 7;
            uint EID4740PS_1562 = uint(EID4740PS_35_m6[EID4740PS_1552].w);
            float EID4740PS_1637;
            if ((EID4740PS_1562 & 1u) == 1u)
            {
                uint EID4740PS_1568 = asuint(EID4740PS_35_m6[EID4740PS_1552].x);
                uint EID4740PS_1575 = asuint(EID4740PS_35_m6[EID4740PS_1552].y);
                uint EID4740PS_1582 = asuint(EID4740PS_35_m6[EID4740PS_1552].z);
                uint EID4740PS_1589 = asuint(EID4740PS_35_m6[EID4740PS_1555].x);
                uint EID4740PS_1596 = asuint(EID4740PS_35_m6[EID4740PS_1555].y);
                uint EID4740PS_1603 = asuint(EID4740PS_35_m6[EID4740PS_1555].z);
                float3 EID4740PS_1622 = abs(mul(float4(EID4740PS_455 - EID4740PS_35_m6[EID4740PS_1540].xyz, 1.0f), float4x4(float4(EID4740PS_spvUnpackHalf2x16(EID4740PS_1568).x, EID4740PS_spvUnpackHalf2x16(EID4740PS_1582).x, EID4740PS_spvUnpackHalf2x16(EID4740PS_1596).x, 0.0f), float4(EID4740PS_spvUnpackHalf2x16(EID4740PS_1568 >> 16u).x, EID4740PS_spvUnpackHalf2x16(EID4740PS_1582 >> 16u).x, EID4740PS_spvUnpackHalf2x16(EID4740PS_1596 >> 16u).x, 0.0f), float4(EID4740PS_spvUnpackHalf2x16(EID4740PS_1575).x, EID4740PS_spvUnpackHalf2x16(EID4740PS_1589).x, EID4740PS_spvUnpackHalf2x16(EID4740PS_1603).x, 0.0f), float4(EID4740PS_spvUnpackHalf2x16(EID4740PS_1575 >> 16u).x, EID4740PS_spvUnpackHalf2x16(EID4740PS_1589 >> 16u).x, EID4740PS_spvUnpackHalf2x16(EID4740PS_1603 >> 16u).x, 0.0f))).xyz);
                float EID4740PS_1623 = EID4740PS_1622.x;
                float EID4740PS_1624 = EID4740PS_1622.y;
                float EID4740PS_1625 = max(EID4740PS_1623, EID4740PS_1624);
                float EID4740PS_1626 = EID4740PS_1622.z;
                float EID4740PS_1629 = EID4740PS_35_m6[EID4740PS_1558].x * 0.5f;
                float EID4740PS_1635 = 1.0f - clamp(((max(EID4740PS_1625, EID4740PS_1626)) - (EID4740PS_1629 + 0.5f)) / (0.5f - EID4740PS_1629), 0.0f, 1.0f);
                EID4740PS_1637 = EID4740PS_1635 * EID4740PS_1635;
            }
            else
            {
                EID4740PS_1637 = 1.0f;
            }
            if (false || (EID4740PS_1637 < 0.001000000047497451305389404296875f))
            {
                EID4740PS_1524 = EID4740PS_1501;
                continue;
            }
            float3 EID4740PS_2274;
            if (EID4740PS_35_m6[EID4740PS_1537].w < 1.5f)
            {
                float3 EID4740PS_2273;
                EID4740PS_EarlyExit1(EID4740PS_1150, EID4740PS_1156, EID4740PS_1157, EID4740PS_1365, EID4740PS_1406, EID4740PS_1434, EID4740PS_1501, EID4740PS_1537, EID4740PS_1540, EID4740PS_1543, EID4740PS_1546, EID4740PS_1549, EID4740PS_1555, EID4740PS_1558, EID4740PS_1562, EID4740PS_1637, EID4740PS_2273, EID4740PS_455, EID4740PS_462, EID4740PS_473, EID4740PS_507);
                EID4740PS_2274 = EID4740PS_2273;
            }
            else
            {
                EID4740PS_2274 = EID4740PS_1501;
            }
            EID4740PS_1524 = EID4740PS_2274;
        }
    }
    float3 EID4740PS_2314;
    [branch]
    if (EID4740PS_48_m12 > 0.5f)
    {
        EID4740PS_2314 = lerp(lerp(0.5f.xxx, lerp(dot(EID4740PS_1500, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, EID4740PS_1500, EID4740PS_48_m14.xxx), EID4740PS_48_m15.xxx) * EID4740PS_48_m13, EID4740PS_48_m26.xyz, EID4740PS_48_m26.w.xxx) + ((EID4740PS_48_m27.xyz * smoothstep(1.0f - EID4740PS_48_m16, 1.0f, 1.0f - clamp(EID4740PS_1428, 0.0f, 1.0f))) * EID4740PS_48_m17);
    }
    else
    {
        EID4740PS_2314 = EID4740PS_1500;
    }
    float4 EID4740PS_2326 = float4(EID4740PS_2314 * EID4740PS_19_m20.y, EID4740PS_442);
    EID4740PS_2326.w = (EID4740PS_48_m8 == 1.0f) ? EID4740PS_442 : 1.0f;
    float4 EID4740PS_2707;
    [branch]
    if (EID4740PS_19_m91.w < 0.5f)
    {
        float3 EID4740PS_2330 = -EID4740PS_370;
        float EID4740PS_2341 = (EID4740PS_371 * EID4740PS_19_m44.w) - EID4740PS_19_m43.w;
        float EID4740PS_2347 = EID4740PS_455.y * EID4740PS_19_m46.w;
        float EID4740PS_2351 = EID4740PS_2347 + EID4740PS_19_m47.w;
        float EID4740PS_2352 = max(0.00999999977648258209228515625f, EID4740PS_2351);
        float3 EID4740PS_2366 = exp(EID4740PS_19_m45.xyz * ((-(max(0.0f, EID4740PS_2341))) * (((1.0f - exp(-EID4740PS_2352)) / EID4740PS_2352) * exp(EID4740PS_2347 + EID4740PS_19_m48.w))));
        float EID4740PS_2369 = dot(EID4740PS_2330, EID4740PS_19_m44.xyz);
        float EID4740PS_2375 = EID4740PS_19_m45.w * EID4740PS_19_m45.w;
        float EID4740PS_2379 = (1.0f + EID4740PS_2375) - ((2.0f * EID4740PS_19_m45.w) * EID4740PS_2369);
        float EID4740PS_2383 = (12.56637096405029296875f * EID4740PS_2379) * sqrt(EID4740PS_2379);
        float3 EID4740PS_2699;
        float EID4740PS_2700;
        if (EID4740PS_19_m55.z > 0.0f)
        {
            uint3 EID4740PS_2530 = (uint3(int3(EID4740PS_1236, EID4740PS_1237, int(EID4740PS_19_m19 & 7u))) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint EID4740PS_2531 = EID4740PS_2530.y;
            uint EID4740PS_2532 = EID4740PS_2530.z;
            uint EID4740PS_2535 = EID4740PS_2530.x + (EID4740PS_2531 * EID4740PS_2532);
            uint EID4740PS_2537 = EID4740PS_2531 + (EID4740PS_2532 * EID4740PS_2535);
            uint EID4740PS_2539 = EID4740PS_2532 + (EID4740PS_2535 * EID4740PS_2537);
            uint EID4740PS_2541 = EID4740PS_2535 + (EID4740PS_2537 * EID4740PS_2539);
            float EID4740PS_2563 = dot(EID4740PS_2330, -EID4740PS_17_m0[2].xyz);
            float3 EID4740PS_2570 = EID4740PS_455 - EID4740PS_17_m11.xyz;
            float EID4740PS_2572 = (EID4740PS_19_m55.w * ((EID4740PS_2563 > 5.9604644775390625e-08f) ? (1.0f / EID4740PS_2563) : 0.0f)) * (1.0f / EID4740PS_371);
            float EID4740PS_2573 = EID4740PS_2570.y;
            float EID4740PS_2574 = EID4740PS_2572 * EID4740PS_2573;
            float EID4740PS_2576 = EID4740PS_17_m11.y + EID4740PS_2574;
            float EID4740PS_2577 = EID4740PS_2573 - EID4740PS_2574;
            float EID4740PS_2579 = (1.0f - EID4740PS_2572) * EID4740PS_371;
            float EID4740PS_2585 = EID4740PS_19_m49.z * (EID4740PS_2576 - EID4740PS_19_m49.x);
            float EID4740PS_2592 = EID4740PS_19_m49.z * EID4740PS_2577;
            float EID4740PS_2593 = max(-127.0f, EID4740PS_2592);
            float EID4740PS_2609 = EID4740PS_19_m52.x * (EID4740PS_2576 - EID4740PS_19_m52.z);
            float EID4740PS_2616 = EID4740PS_19_m52.x * EID4740PS_2577;
            float EID4740PS_2617 = max(-127.0f, EID4740PS_2616);
            float EID4740PS_2628 = ((EID4740PS_19_m49.y * exp2(-(max(-127.0f, EID4740PS_2585)))) * ((abs(EID4740PS_2593) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-EID4740PS_2593)) / EID4740PS_2593) : (0.693147182464599609375f - (0.2402265071868896484375f * EID4740PS_2593)))) + ((EID4740PS_19_m52.y * exp2(-(max(-127.0f, EID4740PS_2609)))) * ((abs(EID4740PS_2617) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-EID4740PS_2617)) / EID4740PS_2617) : (0.693147182464599609375f - (0.2402265071868896484375f * EID4740PS_2617))));
            float EID4740PS_2632 = clamp(exp2(-(EID4740PS_2628 * EID4740PS_2579)), 0.0f, 1.0f);
            float EID4740PS_2650 = clamp((EID4740PS_371 * EID4740PS_19_m50.w) + EID4740PS_19_m50.z, 0.0f, 1.0f);
            float EID4740PS_2653 = clamp(((max(EID4740PS_2632, EID4740PS_19_m51.w)) + clamp((EID4740PS_371 * EID4740PS_19_m50.y) + EID4740PS_19_m50.x, 0.0f, 1.0f)) + EID4740PS_2650, 0.0f, 1.0f);
            float EID4740PS_2672 = EID4740PS_2579 - EID4740PS_19_m53.w;
            float4 EID4740PS_2693 = lerp(float4(0.0f, 0.0f, 0.0f, 1.0f), EID4740PS_58.SampleLevel(EID4740_linear_clamp_sampler, float3((EID4740PS_1475 + ((((float3(uint3(EID4740PS_2541, EID4740PS_2537 + (EID4740PS_2539 * EID4740PS_2541), EID4740PS_336) >> uint3(16u, 16u, 16u)) * 1.525902189314365386962890625e-05f.xxx) * 2.0f) - 1.0f.xxx) * EID4740PS_19_m59.w).xy) * EID4740PS_19_m57.xy, (log2((EID4740PS_351 * EID4740PS_19_m56.x) + EID4740PS_19_m56.y) * EID4740PS_19_m56.z) / EID4740PS_19_m55.z), 0.0f), clamp((EID4740PS_351 - EID4740PS_19_m58.z) * 1000000.0f, 0.0f, 1.0f).xxxx);
            float EID4740PS_2695 = EID4740PS_2693.w;
            EID4740PS_2699 = EID4740PS_2693.xyz + (((EID4740PS_19_m51.xyz * (1.0f - EID4740PS_2653)) + (((EID4740PS_19_m54.xyz * pow(clamp(dot(EID4740PS_370, EID4740PS_19_m53.xyz), 0.0f, 1.0f), EID4740PS_19_m54.w)) * (1.0f - clamp(exp2(-(EID4740PS_2628 * (max(EID4740PS_2672, 0.0f)))), 0.0f, 1.0f))) * (1.0f - EID4740PS_2650))) * EID4740PS_2695);
            EID4740PS_2700 = EID4740PS_2695 * EID4740PS_2653;
        }
        else
        {
            float3 EID4740PS_2406 = EID4740PS_455 - EID4740PS_17_m11.xyz;
            float EID4740PS_2408 = EID4740PS_2406.y;
            float EID4740PS_2414 = EID4740PS_19_m49.z * (EID4740PS_17_m11.y - EID4740PS_19_m49.x);
            float EID4740PS_2421 = EID4740PS_19_m49.z * EID4740PS_2408;
            float EID4740PS_2422 = max(-127.0f, EID4740PS_2421);
            float EID4740PS_2438 = EID4740PS_19_m52.x * (EID4740PS_17_m11.y - EID4740PS_19_m52.z);
            float EID4740PS_2445 = EID4740PS_19_m52.x * EID4740PS_2408;
            float EID4740PS_2446 = max(-127.0f, EID4740PS_2445);
            float EID4740PS_2457 = ((EID4740PS_19_m49.y * exp2(-(max(-127.0f, EID4740PS_2414)))) * ((abs(EID4740PS_2422) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-EID4740PS_2422)) / EID4740PS_2422) : (0.693147182464599609375f - (0.2402265071868896484375f * EID4740PS_2422)))) + ((EID4740PS_19_m52.y * exp2(-(max(-127.0f, EID4740PS_2438)))) * ((abs(EID4740PS_2446) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-EID4740PS_2446)) / EID4740PS_2446) : (0.693147182464599609375f - (0.2402265071868896484375f * EID4740PS_2446))));
            float EID4740PS_2461 = clamp(exp2(-(EID4740PS_2457 * EID4740PS_371)), 0.0f, 1.0f);
            float EID4740PS_2479 = clamp((EID4740PS_371 * EID4740PS_19_m50.w) + EID4740PS_19_m50.z, 0.0f, 1.0f);
            float EID4740PS_2482 = clamp(((max(EID4740PS_2461, EID4740PS_19_m51.w)) + clamp((EID4740PS_371 * EID4740PS_19_m50.y) + EID4740PS_19_m50.x, 0.0f, 1.0f)) + EID4740PS_2479, 0.0f, 1.0f);
            float EID4740PS_2501 = EID4740PS_371 - EID4740PS_19_m53.w;
            EID4740PS_2699 = (EID4740PS_19_m51.xyz * (1.0f - EID4740PS_2482)) + (((EID4740PS_19_m54.xyz * pow(clamp(dot(EID4740PS_370, EID4740PS_19_m53.xyz), 0.0f, 1.0f), EID4740PS_19_m54.w)) * (1.0f - clamp(exp2(-(EID4740PS_2457 * (max(EID4740PS_2501, 0.0f)))), 0.0f, 1.0f))) * (1.0f - EID4740PS_2479));
            EID4740PS_2700 = EID4740PS_2482;
        }
        float3 EID4740PS_2705 = (EID4740PS_2326.xyz * (EID4740PS_2366 * EID4740PS_2700)) + ((((clamp(((EID4740PS_19_m46.xyz * (0.0596831031143665313720703125f * (1.0f + (EID4740PS_2369 * EID4740PS_2369)))) + EID4740PS_19_m48.xyz) + (EID4740PS_19_m47.xyz * ((1.0f - EID4740PS_2375) / (max(EID4740PS_2383, 0.001000000047497451305389404296875f)))), 0.0f.xxx, 1.0f.xxx) * 255.0f) * (1.0f.xxx - EID4740PS_2366)) * EID4740PS_2700) + EID4740PS_2699);
        EID4740PS_2707 = float4(EID4740PS_2705.x, EID4740PS_2705.y, EID4740PS_2705.z, EID4740PS_2326.w);
    }
    else
    {
        EID4740PS_2707 = EID4740PS_2326;
    }
    EID4740PS_14 = EID4740PS_2707;
    EID4740PS_15 = EID4740PS_1186;
}

EID4740PS_SPIRV_Cross_Output EID4740PS_main(EID4740PS_SPIRV_Cross_Input stage_input)
{
    EID4740PS_gl_FragCoord = stage_input.EID4740PS_gl_FragCoord;
    EID4740PS_gl_FragCoord.w = 1.0 / EID4740PS_gl_FragCoord.w;
    EID4740PS_gl_FrontFacing = stage_input.EID4740PS_gl_FrontFacing;
    EID4740PS_3 = stage_input.EID4740PS_3;
    EID4740PS_4 = stage_input.EID4740PS_4;
    EID4740PS_5 = stage_input.EID4740PS_5;
    EID4740PS_6 = stage_input.EID4740PS_6;
    EID4740PS_7 = stage_input.EID4740PS_7;
    EID4740PS_8 = stage_input.EID4740PS_8;
    EID4740PS_9 = stage_input.EID4740PS_9;
    EID4740PS_10 = stage_input.EID4740PS_10;
    EID4740PS_12 = stage_input.EID4740PS_12;
    EID4740PS_frag_main();
    EID4740PS_SPIRV_Cross_Output stage_output;
    stage_output.EID4740PS_14 = EID4740PS_14;
    stage_output.EID4740PS_15 = EID4740PS_15;
    return stage_output;
}
