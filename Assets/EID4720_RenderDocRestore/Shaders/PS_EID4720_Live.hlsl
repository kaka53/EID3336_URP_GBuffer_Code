struct EID4720PS_21
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

static const int2 EID4720PS_341[6] = { int2(2, 1), int2(2, 1), int2(0, 2), int2(0, 2), int2(0, 1), int2(0, 1) };
static const float2 EID4720PS_342[6] = { float2(-1.0f, 1.0f), 1.0f.xx, float2(1.0f, -1.0f), 1.0f.xx, 1.0f.xx, float2(-1.0f, 1.0f) };

cbuffer EID4720PS_16_17
{
    column_major float4x4 EID4720PS_17_m0 : packoffset(c0);
    column_major float4x4 EID4720PS_17_m1 : packoffset(c4);
    column_major float4x4 EID4720PS_17_m2 : packoffset(c8);
    column_major float4x4 EID4720PS_17_m3 : packoffset(c12);
    column_major float4x4 EID4720PS_17_m4 : packoffset(c16);
    column_major float4x4 EID4720PS_17_m5 : packoffset(c20);
    column_major float4x4 EID4720PS_17_m6 : packoffset(c24);
    column_major float4x4 EID4720PS_17_m7 : packoffset(c28);
    column_major float4x4 EID4720PS_17_m8 : packoffset(c32);
    column_major float4x4 EID4720PS_17_m9 : packoffset(c36);
    column_major float4x4 EID4720PS_17_m10 : packoffset(c40);
    float4 EID4720PS_17_m11 : packoffset(c44);
    column_major float4x4 EID4720PS_17_m12 : packoffset(c45);
    column_major float4x4 EID4720PS_17_m13 : packoffset(c49);
    column_major float4x4 EID4720PS_17_m14 : packoffset(c53);
    column_major float4x4 EID4720PS_17_m15 : packoffset(c57);
    column_major float4x4 EID4720PS_17_m16 : packoffset(c61);
    column_major float4x4 EID4720PS_17_m17 : packoffset(c65);
    column_major float4x4 EID4720PS_17_m18 : packoffset(c69);
    column_major float4x4 EID4720PS_17_m19 : packoffset(c73);
    column_major float4x4 EID4720PS_17_m20 : packoffset(c77);
    float4 EID4720PS_17_m21 : packoffset(c81);
};

cbuffer EID4720PS_18_19
{
    float4 EID4720PS_19_m0 : packoffset(c0);
    float4 EID4720PS_19_m1 : packoffset(c1);
    float4 EID4720PS_19_m2 : packoffset(c2);
    float4 EID4720PS_19_m3 : packoffset(c3);
    float4 EID4720PS_19_m4 : packoffset(c4);
    float4 EID4720PS_19_m5 : packoffset(c5);
    float4 EID4720PS_19_m6[6] : packoffset(c6);
    float4 EID4720PS_19_m7[6] : packoffset(c12);
    float4 EID4720PS_19_m8 : packoffset(c18);
    float4 EID4720PS_19_m9 : packoffset(c19);
    float4 EID4720PS_19_m10 : packoffset(c20);
    float4 EID4720PS_19_m11 : packoffset(c21);
    float4 EID4720PS_19_m12 : packoffset(c22);
    float4 EID4720PS_19_m13 : packoffset(c23);
    float4 EID4720PS_19_m14 : packoffset(c24);
    float4 EID4720PS_19_m15 : packoffset(c25);
    float EID4720PS_19_m16 : packoffset(c26);
    float EID4720PS_19_m17 : packoffset(c26.y);
    float EID4720PS_19_m18 : packoffset(c26.z);
    uint EID4720PS_19_m19 : packoffset(c26.w);
    float4 EID4720PS_19_m20 : packoffset(c27);
    int4 EID4720PS_19_m21 : packoffset(c28);
    float4 EID4720PS_19_m22 : packoffset(c29);
    float4 EID4720PS_19_m23 : packoffset(c30);
    float4 EID4720PS_19_m24 : packoffset(c31);
    float4 EID4720PS_19_m25 : packoffset(c32);
    float4 EID4720PS_19_m26 : packoffset(c33);
    float4 EID4720PS_19_m27 : packoffset(c34);
    float4 EID4720PS_19_m28 : packoffset(c35);
    float4 EID4720PS_19_m29 : packoffset(c36);
    float4 EID4720PS_19_m30 : packoffset(c37);
    float4 EID4720PS_19_m31 : packoffset(c38);
    float4 EID4720PS_19_m32[4] : packoffset(c39);
    float4 EID4720PS_19_m33[4] : packoffset(c43);
    float4 EID4720PS_19_m34[4] : packoffset(c47);
    float4 EID4720PS_19_m35[4] : packoffset(c51);
    float4 EID4720PS_19_m36 : packoffset(c55);
    float4 EID4720PS_19_m37 : packoffset(c56);
    float4 EID4720PS_19_m38[4] : packoffset(c57);
    float4 EID4720PS_19_m39[4] : packoffset(c61);
    float4 EID4720PS_19_m40[4] : packoffset(c65);
    float4 EID4720PS_19_m41 : packoffset(c69);
    float4 EID4720PS_19_m42 : packoffset(c70);
    float4 EID4720PS_19_m43 : packoffset(c71);
    float4 EID4720PS_19_m44 : packoffset(c72);
    float4 EID4720PS_19_m45 : packoffset(c73);
    float4 EID4720PS_19_m46 : packoffset(c74);
    float4 EID4720PS_19_m47 : packoffset(c75);
    float4 EID4720PS_19_m48 : packoffset(c76);
    float4 EID4720PS_19_m49 : packoffset(c77);
    float4 EID4720PS_19_m50 : packoffset(c78);
    float4 EID4720PS_19_m51 : packoffset(c79);
    float4 EID4720PS_19_m52 : packoffset(c80);
    float4 EID4720PS_19_m53 : packoffset(c81);
    float4 EID4720PS_19_m54 : packoffset(c82);
    float4 EID4720PS_19_m55 : packoffset(c83);
    float4 EID4720PS_19_m56 : packoffset(c84);
    float4 EID4720PS_19_m57 : packoffset(c85);
    float4 EID4720PS_19_m58 : packoffset(c86);
    float4 EID4720PS_19_m59 : packoffset(c87);
    float4 EID4720PS_19_m60 : packoffset(c88);
    float4 EID4720PS_19_m61 : packoffset(c89);
    float4 EID4720PS_19_m62 : packoffset(c90);
    float4 EID4720PS_19_m63 : packoffset(c91);
    float4 EID4720PS_19_m64 : packoffset(c92);
    float4 EID4720PS_19_m65 : packoffset(c93);
    float4 EID4720PS_19_m66 : packoffset(c94);
    float4 EID4720PS_19_m67 : packoffset(c95);
    float4 EID4720PS_19_m68 : packoffset(c96);
    float4 EID4720PS_19_m69 : packoffset(c97);
    float4 EID4720PS_19_m70 : packoffset(c98);
    float4 EID4720PS_19_m71 : packoffset(c99);
    float4 EID4720PS_19_m72 : packoffset(c100);
    float4 EID4720PS_19_m73 : packoffset(c101);
    float4 EID4720PS_19_m74 : packoffset(c102);
    float4 EID4720PS_19_m75 : packoffset(c103);
    float4 EID4720PS_19_m76 : packoffset(c104);
    float4 EID4720PS_19_m77 : packoffset(c105);
    float4 EID4720PS_19_m78 : packoffset(c106);
    float4 EID4720PS_19_m79 : packoffset(c107);
    float4 EID4720PS_19_m80 : packoffset(c108);
    float4 EID4720PS_19_m81 : packoffset(c109);
    float4 EID4720PS_19_m82 : packoffset(c110);
    float4 EID4720PS_19_m83 : packoffset(c111);
    float4 EID4720PS_19_m84 : packoffset(c112);
    float4 EID4720PS_19_m85 : packoffset(c113);
    float4 EID4720PS_19_m86 : packoffset(c114);
    float4 EID4720PS_19_m87 : packoffset(c115);
    float4 EID4720PS_19_m88 : packoffset(c116);
    float4 EID4720PS_19_m89 : packoffset(c117);
    float4 EID4720PS_19_m90 : packoffset(c118);
    float4 EID4720PS_19_m91 : packoffset(c119);
    float4 EID4720PS_19_m92 : packoffset(c120);
    float4 EID4720PS_19_m93 : packoffset(c121);
    float4 EID4720PS_19_m94 : packoffset(c122);
    float4 EID4720PS_19_m95 : packoffset(c123);
    float4 EID4720PS_19_m96 : packoffset(c124);
    float4 EID4720PS_19_m97 : packoffset(c125);
    float4 EID4720PS_19_m98 : packoffset(c126);
    float4 EID4720PS_19_m99[2] : packoffset(c127);
    float4 EID4720PS_19_m100[2] : packoffset(c129);
    float EID4720PS_19_m101 : packoffset(c131);
    float EID4720PS_19_m102 : packoffset(c131.y);
    float EID4720PS_19_m103 : packoffset(c131.z);
    float EID4720PS_19_m104 : packoffset(c131.w);
    float4 EID4720PS_19_m105 : packoffset(c132);
    float4 EID4720PS_19_m106 : packoffset(c133);
    float4 EID4720PS_19_m107 : packoffset(c134);
    float4 EID4720PS_19_m108 : packoffset(c135);
    float4 EID4720PS_19_m109 : packoffset(c136);
    float4 EID4720PS_19_m110 : packoffset(c137);
    float4 EID4720PS_19_m111 : packoffset(c138);
    float4 EID4720PS_19_m112 : packoffset(c139);
    float4 EID4720PS_19_m113 : packoffset(c140);
    float4 EID4720PS_19_m114 : packoffset(c141);
    float4 EID4720PS_19_m115 : packoffset(c142);
    float4 EID4720PS_19_m116 : packoffset(c143);
    float4 EID4720PS_19_m117 : packoffset(c144);
    float4 EID4720PS_19_m118 : packoffset(c145);
    float4 EID4720PS_19_m119 : packoffset(c146);
    float4 EID4720PS_19_m120 : packoffset(c147);
    float4 EID4720PS_19_m121 : packoffset(c148);
    float4 EID4720PS_19_m122 : packoffset(c149);
    float4 EID4720PS_19_m123 : packoffset(c150);
    float4 EID4720PS_19_m124 : packoffset(c151);
    float4 EID4720PS_19_m125 : packoffset(c152);
    float4 EID4720PS_19_m126 : packoffset(c153);
    float4 EID4720PS_19_m127 : packoffset(c154);
    float4 EID4720PS_19_m128 : packoffset(c155);
    float4 EID4720PS_19_m129 : packoffset(c156);
    float4 EID4720PS_19_m130 : packoffset(c157);
    float4 EID4720PS_19_m131 : packoffset(c158);
    float4 EID4720PS_19_m132 : packoffset(c159);
    float4 EID4720PS_19_m133 : packoffset(c160);
    float4 EID4720PS_19_m134 : packoffset(c161);
    column_major float4x4 EID4720PS_19_m135 : packoffset(c162);
    float4 EID4720PS_19_m136 : packoffset(c166);
    float4 EID4720PS_19_m137 : packoffset(c167);
    float4 EID4720PS_19_m138[32] : packoffset(c168);
};

cbuffer EID4720PS_20_22
{
    float4 EID4720PS_instanceRaw[4096] : packoffset(c0);
};

ByteAddressBuffer EID4720PS_30;
ByteAddressBuffer EID4720PS_32;
cbuffer EID4720PS_33_34
{
    int EID4720PS_34_m0 : packoffset(c0);
    int EID4720PS_34_m1 : packoffset(c0.y);
    int EID4720PS_34_m2 : packoffset(c0.z);
    int EID4720PS_34_m3 : packoffset(c0.w);
    float EID4720PS_34_m4 : packoffset(c1);
    float EID4720PS_34_m5 : packoffset(c1.y);
    float EID4720PS_34_m6 : packoffset(c1.z);
    float EID4720PS_34_m7 : packoffset(c1.w);
    float EID4720PS_34_m8 : packoffset(c2);
    float EID4720PS_34_m9 : packoffset(c2.y);
    float EID4720PS_34_m10 : packoffset(c2.z);
    float EID4720PS_34_m11 : packoffset(c2.w);
};

cbuffer EID4720PS_35_36
{
    float4 EID4720PS_36_m0 : packoffset(c0);
    float4 EID4720PS_36_m1 : packoffset(c1);
    float4 EID4720PS_36_m2 : packoffset(c2);
    float4 EID4720PS_36_m3 : packoffset(c3);
    float4 EID4720PS_36_m4 : packoffset(c4);
    uint4 EID4720PS_36_m5 : packoffset(c5);
    float4 EID4720PS_36_m6[2048] : packoffset(c6);
};

cbuffer EID4720PS_37_38
{
    column_major float4x4 EID4720PS_38_m0[5] : packoffset(c0);
    float4 EID4720PS_38_m1[4] : packoffset(c20);
    float4 EID4720PS_38_m2[4] : packoffset(c24);
    float4 EID4720PS_38_m3[4] : packoffset(c28);
    float4 EID4720PS_38_m4 : packoffset(c32);
    float4 EID4720PS_38_m5 : packoffset(c33);
    float4 EID4720PS_38_m6 : packoffset(c34);
    float4 EID4720PS_38_m7 : packoffset(c35);
    float4 EID4720PS_38_m8 : packoffset(c36);
    float4 EID4720PS_38_m9[27] : packoffset(c37);
    column_major float4x4 EID4720PS_38_m10[56] : packoffset(c64);
    float4 EID4720PS_38_m11[56] : packoffset(c288);
    float4 EID4720PS_38_m12[56] : packoffset(c344);
    float4 EID4720PS_38_m13 : packoffset(c400);
    float4 EID4720PS_38_m14[47] : packoffset(c401);
    column_major float4x4 EID4720PS_38_m15[15] : packoffset(c448);
    float4 EID4720PS_38_m16[15] : packoffset(c508);
    float4 EID4720PS_38_m17[15] : packoffset(c523);
    float4 EID4720PS_38_m18[15] : packoffset(c538);
    float4 EID4720PS_38_m19 : packoffset(c553);
    float4 EID4720PS_38_m20 : packoffset(c554);
    float4 EID4720PS_38_m21[21] : packoffset(c555);
    column_major float4x4 EID4720PS_38_m22 : packoffset(c576);
    column_major float4x4 EID4720PS_38_m23 : packoffset(c580);
    float4 EID4720PS_38_m24 : packoffset(c584);
    float4 EID4720PS_38_m25 : packoffset(c585);
    float4 EID4720PS_38_m26 : packoffset(c586);
    float4 EID4720PS_38_m27[128] : packoffset(c587);
};

cbuffer EID4720PS_48_49
{
    float EID4720PS_49_m0 : packoffset(c0);
    float EID4720PS_49_m1 : packoffset(c0.y);
    float EID4720PS_49_m2 : packoffset(c0.z);
    float EID4720PS_49_m3 : packoffset(c0.w);
    float EID4720PS_49_m4 : packoffset(c1);
    float EID4720PS_49_m5 : packoffset(c1.y);
    float EID4720PS_49_m6 : packoffset(c1.z);
    float EID4720PS_49_m7 : packoffset(c1.w);
    float EID4720PS_49_m8 : packoffset(c2);
    float EID4720PS_49_m9 : packoffset(c2.y);
    float EID4720PS_49_m10 : packoffset(c2.z);
    float EID4720PS_49_m11 : packoffset(c2.w);
    float EID4720PS_49_m12 : packoffset(c3);
    float EID4720PS_49_m13 : packoffset(c3.y);
    float EID4720PS_49_m14 : packoffset(c3.z);
    float EID4720PS_49_m15 : packoffset(c3.w);
    float EID4720PS_49_m16 : packoffset(c4);
    float EID4720PS_49_m17 : packoffset(c4.y);
    float EID4720PS_49_m18 : packoffset(c4.z);
    float EID4720PS_49_m19 : packoffset(c4.w);
    float EID4720PS_49_m20 : packoffset(c5);
    float EID4720PS_49_m21 : packoffset(c5.y);
    float EID4720PS_49_m22 : packoffset(c5.z);
    float EID4720PS_49_m23 : packoffset(c5.w);
    float4 EID4720PS_49_m24 : packoffset(c6);
    float4 EID4720PS_49_m25 : packoffset(c7);
    float4 EID4720PS_49_m26 : packoffset(c8);
    float4 EID4720PS_49_m27 : packoffset(c9);
    float4 EID4720PS_49_m28 : packoffset(c10);
    float4 EID4720PS_49_m29 : packoffset(c11);
    float EID4720PS_49_m30 : packoffset(c12);
    float EID4720PS_49_m31 : packoffset(c12.y);
    float EID4720PS_49_m32 : packoffset(c12.z);
    float EID4720PS_49_m33 : packoffset(c12.w);
    float4 EID4720PS_49_m34 : packoffset(c13);
    float EID4720PS_49_m35 : packoffset(c14);
    float EID4720PS_49_m36 : packoffset(c14.y);
    float EID4720PS_49_m37 : packoffset(c14.z);
    float EID4720PS_49_m38 : packoffset(c14.w);
    float4 EID4720PS_49_m39 : packoffset(c15);
    float4 EID4720PS_49_m40 : packoffset(c16);
    float4 EID4720PS_49_m41 : packoffset(c17);
    float4 EID4720PS_49_m42 : packoffset(c18);
    float4 EID4720PS_49_m43 : packoffset(c19);
    float4 EID4720PS_49_m44 : packoffset(c20);
    float EID4720PS_49_m45 : packoffset(c21);
    float EID4720PS_49_m46 : packoffset(c21.y);
    float EID4720PS_49_m47 : packoffset(c21.z);
    float EID4720PS_49_m48 : packoffset(c21.w);
    float EID4720PS_49_m49 : packoffset(c22);
    float EID4720PS_49_m50 : packoffset(c22.y);
    float EID4720PS_49_m51 : packoffset(c22.z);
    float EID4720PS_49_m52 : packoffset(c22.w);
};

cbuffer EID4720PS_61_62
{
    float4 EID4720PS_62_m0[32] : packoffset(c0);
    column_major float4x4 EID4720PS_62_m1[32] : packoffset(c32);
};

SamplerState EID4720_point_repeat_sampler;
SamplerState EID4720_linear_clamp_sampler;
SamplerState EID4720_linear_repeat_sampler;

Texture2D<float4> EID4720PS_39;
Texture2D<float4> EID4720PS_40;
Texture3D<float4> EID4720PS_42;
Texture3D<float4> EID4720PS_43;
Texture3D<float4> EID4720PS_44;
Texture3D<float4> EID4720PS_45;
Texture3D<float4> EID4720PS_46;
Texture3D<float4> EID4720PS_47;
Texture2D<float4> EID4720PS_50;
Texture2D<float4> EID4720PS_51;
Texture2D<float4> EID4720PS_52;
Texture2D<float4> EID4720PS_53;
Texture2D<float4> EID4720PS_54;
Texture2D<float4> EID4720PS_55;
Texture2D<float4> EID4720PS_56;
Texture2D<float4> EID4720PS_57;
Texture2D<float4> EID4720PS_58;
Texture2D<float4> EID4720PS_59;
Texture2D<float4> EID4720PS_60;
Texture3D<float4> EID4720PS_65;

static float4 EID4720PS_gl_FragCoord;
static bool EID4720PS_gl_FrontFacing;
static float2 EID4720PS_3;
static float3 EID4720PS_4;
static float3 EID4720PS_5;
static float4 EID4720PS_6;
static float3 EID4720PS_7;
static float3 EID4720PS_8;
static float3 EID4720PS_9;
static float3 EID4720PS_10;
static uint EID4720PS_12;
static float4 EID4720PS_14;
static float4 EID4720PS_15;

EID4720PS_21 EID4720PS_LoadInstance(uint index) {uint b=index*16; EID4720PS_21 x;
x._m0=transpose(float4x4(EID4720PS_instanceRaw[b],EID4720PS_instanceRaw[b+1],EID4720PS_instanceRaw[b+2],EID4720PS_instanceRaw[b+3]));
x._m1=EID4720PS_instanceRaw[b+4];x._m2=EID4720PS_instanceRaw[b+5];
x._m3=transpose(float4x4(EID4720PS_instanceRaw[b+6],EID4720PS_instanceRaw[b+7],EID4720PS_instanceRaw[b+8],EID4720PS_instanceRaw[b+9]));
x._m4=EID4720PS_instanceRaw[b+10];
x._m5=EID4720PS_instanceRaw[b+11];
x._m6=EID4720PS_instanceRaw[b+12];
x._m7=EID4720PS_instanceRaw[b+13];
x._m8=EID4720PS_instanceRaw[b+14];
x._m9=EID4720PS_instanceRaw[b+15];
return x;}

struct EID4720PS_SPIRV_Cross_Input
{
    float2 EID4720PS_3 : TEXCOORD0;
    float3 EID4720PS_4 : TEXCOORD1;
    float3 EID4720PS_5 : TEXCOORD2;
    float4 EID4720PS_6 : TEXCOORD3;
    float3 EID4720PS_7 : TEXCOORD4;
    float3 EID4720PS_8 : TEXCOORD5;
    float3 EID4720PS_9 : TEXCOORD6;
    float3 EID4720PS_10 : TEXCOORD7;
    nointerpolation uint EID4720PS_12 : TEXCOORD8;
    float4 EID4720PS_gl_FragCoord : SV_Position;
    bool EID4720PS_gl_FrontFacing : SV_IsFrontFace;
};

struct EID4720PS_SPIRV_Cross_Output
{
    float4 EID4720PS_14 : SV_Target0;
    float4 EID4720PS_15 : SV_Target1;
};

static float3 EID4720PS_366;
static float EID4720PS_367;
static float3 EID4720PS_368;
static float EID4720PS_371;
static uint EID4720PS_372;

uint EID4720PS_spvPackHalf2x16(float2 value)
{
    uint2 Packed = f32tof16(value);
    return Packed.x | (Packed.y << 16);
}

float2 EID4720PS_spvUnpackHalf2x16(uint value)
{
    return f16tof32(uint2(value & 0xffff, value >> 16));
}

float EID4720ShadowGreater(float2 uv, float reference)
{
 uint w,h; EID4720PS_39.GetDimensions(w,h); float2 p=uv*float2(w,h)-0.5;
 int2 a=(int2)floor(p); float2 f=frac(p); int2 hi=int2(w,h)-1;
 float c00=reference>EID4720PS_39.Load(int3(clamp(a,int2(0,0),hi),0)).r?1:0;
 float c10=reference>EID4720PS_39.Load(int3(clamp(a+int2(1,0),int2(0,0),hi),0)).r?1:0;
 float c01=reference>EID4720PS_39.Load(int3(clamp(a+int2(0,1),int2(0,0),hi),0)).r?1:0;
 float c11=reference>EID4720PS_39.Load(int3(clamp(a+int2(1,1),int2(0,0),hi),0)).r?1:0;
 return lerp(lerp(c00,c10,f.x),lerp(c01,c11,f.x),f.y);
}


void EID4720PS_frag_main()
{
    float EID4720PS_387 = EID4720PS_7.z;
    float3 EID4720PS_402 = lerp(-EID4720PS_4, float3(EID4720PS_17_m0[2u].x, EID4720PS_17_m0[2u].y, EID4720PS_17_m0[2u].z), EID4720PS_19_m4.w.xxx);
    float EID4720PS_403 = dot(EID4720PS_402, EID4720PS_402);
    float EID4720PS_405 = rsqrt(isnan(9.9999999392252902907785028219223e-09f) ? EID4720PS_403 : (isnan(EID4720PS_403) ? 9.9999999392252902907785028219223e-09f : max(EID4720PS_403, 9.9999999392252902907785028219223e-09f)));
    float3 EID4720PS_406 = EID4720PS_402 * EID4720PS_405;
    float EID4720PS_407 = EID4720PS_403 * EID4720PS_405;
    uint EID4720PS_410 = asuint(EID4720PS_LoadInstance(EID4720PS_12)._m2.x);
    bool EID4720PS_415 = (asuint(EID4720PS_LoadInstance(EID4720PS_12)._m1.w) & 16u) != 0u;
    float4 EID4720PS_432;
    float4 EID4720PS_433;
    float4 EID4720PS_434;
    if (EID4720PS_415)
    {
        EID4720PS_432 = asfloat(EID4720PS_32.Load4((EID4720PS_410 + 2u) * 16 + 0));
        EID4720PS_433 = asfloat(EID4720PS_32.Load4((EID4720PS_410 + 1u) * 16 + 0));
        EID4720PS_434 = asfloat(EID4720PS_32.Load4(EID4720PS_410 * 16 + 0));
    }
    else
    {
        EID4720PS_432 = EID4720PS_LoadInstance(EID4720PS_12)._m0[2];
        EID4720PS_433 = EID4720PS_LoadInstance(EID4720PS_12)._m0[1];
        EID4720PS_434 = EID4720PS_LoadInstance(EID4720PS_12)._m0[0];
    }
    float4 EID4720PS_440 = EID4720PS_57.SampleBias(EID4720_linear_repeat_sampler, EID4720PS_3, EID4720PS_19_m16);
    float EID4720PS_452 = 1.0f - EID4720PS_49_m0;
    float EID4720PS_453 = EID4720PS_440.w;
    float4 EID4720PS_467 = EID4720PS_51.SampleBias(EID4720_linear_repeat_sampler, float2(fmod(EID4720PS_49_m32, 2.0f) * 0.5f, floor(EID4720PS_49_m32 * 0.5f) * 0.5f) + (0.5f.xx * EID4720PS_3), EID4720PS_19_m16);
    float3 EID4720PS_474 = lerp(EID4720PS_440.xyz * EID4720PS_49_m24.xyz, EID4720PS_467.xyz, (EID4720PS_467.w * EID4720PS_49_m33).xxx);
    float3 EID4720PS_475 = EID4720PS_474 * 12.9200000762939453125f;
    float3 EID4720PS_479 = (pow(abs(EID4720PS_474), 0.4166666567325592041015625f.xxx) * 1.05499994754791259765625f) - 0.054999999701976776123046875f.xxx;
    bool3 EID4720PS_480 = bool3(EID4720PS_474.x <= 0.003130800090730190277099609375f.xxx.x, EID4720PS_474.y <= 0.003130800090730190277099609375f.xxx.y, EID4720PS_474.z <= 0.003130800090730190277099609375f.xxx.z);
    float3 EID4720PS_482 = clamp(float3(EID4720PS_480.x ? EID4720PS_475.x : EID4720PS_479.x, EID4720PS_480.y ? EID4720PS_475.y : EID4720PS_479.y, EID4720PS_480.z ? EID4720PS_475.z : EID4720PS_479.z), 0.0f.xxx, 1.0f.xxx);
    float EID4720PS_486 = EID4720PS_482.z * 31.0f;
    float EID4720PS_487 = floor(EID4720PS_486);
    float2 EID4720PS_491 = ((EID4720PS_482.xy * 31.0f) * float2(0.0009765625f, 0.03125f)) + float2(0.00048828125f, 0.015625f);
    float3 EID4720PS_496 = float3(EID4720PS_491.x, EID4720PS_491.y, EID4720PS_482.z);
    EID4720PS_496.x = EID4720PS_491.x + (EID4720PS_487 * 0.03125f);
    float3 EID4720PS_507 = lerp(EID4720PS_52.SampleLevel(EID4720_linear_clamp_sampler, EID4720PS_496.xy, 0.0f).xyz, EID4720PS_52.SampleLevel(EID4720_linear_clamp_sampler, EID4720PS_496.xy + float2(0.03125f, 0.0f), 0.0f).xyz, (EID4720PS_486 - EID4720PS_487).xxx);
    float4 EID4720PS_511 = EID4720PS_59.SampleBias(EID4720_linear_clamp_sampler, EID4720PS_3, EID4720PS_19_m16);
    float EID4720PS_513 = EID4720PS_511.y;
    float EID4720PS_514 = EID4720PS_511.z;
    float EID4720PS_515 = EID4720PS_511.w;
    float3 EID4720PS_519 = EID4720PS_4 + EID4720PS_17_m11.xyz;
    float3 EID4720PS_524 = EID4720PS_519 - float3(EID4720PS_434.w, EID4720PS_371, EID4720PS_432.w);
    EID4720PS_524.y = 6.103515625e-05f;
    float3 EID4720PS_526 = normalize(EID4720PS_524);
    float EID4720PS_540 = EID4720PS_gl_FrontFacing ? 1.0f : ((-1.0f) + (2.0f * EID4720PS_49_m5));
    float3 EID4720PS_541 = normalize(EID4720PS_5) * EID4720PS_540;
    // Fixed capture buffers must use the capture camera, not SceneView pixels.
    float2 capturePixel = (EID4720PS_7.xy / max(EID4720PS_7.z, 1e-6f) * float2(.5f,-.5f) + .5f) * EID4720PS_19_m0.xy - EID4720PS_19_m9.xy;
    bool captureValid = EID4720PS_7.z > 0 && all(capturePixel >= 0) && all(capturePixel < EID4720PS_19_m0.xy);
    uint2 EID4720PS_543 = uint2(clamp(capturePixel,0.0f,EID4720PS_19_m0.xy-1.0f));
    float3 EID4720PS_553 = mul(float3x3(EID4720PS_17_m1[0].xyz, EID4720PS_17_m1[1].xyz, EID4720PS_17_m1[2].xyz), float3(0.0f, 0.0f, 1.0f));
    float3x3 EID4720PS_557 = float3x3(EID4720PS_434.xyz, EID4720PS_433.xyz, EID4720PS_432.xyz);
    float3 EID4720PS_558 = mul(EID4720PS_553, EID4720PS_557);
    float EID4720PS_559 = dot(EID4720PS_558, EID4720PS_558);
    float2 EID4720PS_564 = normalize((EID4720PS_558 * rsqrt(isnan(EID4720PS_559) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? EID4720PS_559 : max(1.1754943508222875079687365372222e-38f, EID4720PS_559)))).xz);
    float EID4720PS_565 = EID4720PS_564.y;
    uint EID4720PS_574 = asuint((EID4720PS_19_m89.x > 0.5f) ? EID4720PS_19_m89.y : EID4720PS_LoadInstance(EID4720PS_12)._m7.x);
    float4 EID4720PS_587 = float4(float(EID4720PS_574 & 255u), float((EID4720PS_574 >> 8u) & 255u), float((EID4720PS_574 >> 16u) & 255u), float((EID4720PS_574 >> 24u) & 255u)) * 0.0039215688593685626983642578125f.xxxx;
    float EID4720PS_588 = EID4720PS_587.x;
    float EID4720PS_590 = EID4720PS_587.z;
    float EID4720PS_591 = EID4720PS_587.w;
    float EID4720PS_597 = EID4720PS_519.y;
    float EID4720PS_600 = smoothstep(-0.20000000298023223876953125f, 0.1500000059604644775390625f, lerp(EID4720PS_LoadInstance(EID4720PS_12)._m7.y, EID4720PS_19_m89.w, EID4720PS_19_m89.x) - EID4720PS_597) * EID4720PS_587.y;
    float EID4720PS_601 = isnan(EID4720PS_600) ? EID4720PS_590 : (isnan(EID4720PS_590) ? EID4720PS_600 : max(EID4720PS_590, EID4720PS_600));
    float EID4720PS_602 = isnan(EID4720PS_601) ? EID4720PS_588 : (isnan(EID4720PS_588) ? EID4720PS_601 : max(EID4720PS_588, EID4720PS_601));
    float EID4720PS_610 = lerp(EID4720PS_19_m22.x, 1.0f, EID4720PS_19_m91.w) * EID4720PS_19_m20.x;
    float EID4720PS_612 = EID4720PS_541.z;
    float3 EID4720PS_615 = EID4720PS_513.xxx;
    float3 EID4720PS_617 = normalize(lerp(EID4720PS_526, normalize(float3(EID4720PS_541.x, 6.103515625e-05f, EID4720PS_612)), EID4720PS_615));
    float3 EID4720PS_1108;
    float EID4720PS_1109;
    if (EID4720PS_19_m80.y < 0.5f)
    {
        float3 EID4720PS_635 = EID4720PS_519 - (EID4720PS_19_m105.xyz + (EID4720PS_553 * (-EID4720PS_19_m107.w)));
        float EID4720PS_637 = abs(EID4720PS_635.x);
        float EID4720PS_639 = abs(EID4720PS_635.z);
        float EID4720PS_645 = clamp(((isnan(EID4720PS_639) ? EID4720PS_637 : (isnan(EID4720PS_637) ? EID4720PS_639 : max(EID4720PS_637, EID4720PS_639))) - 464.0f) * 0.03125f, 0.0f, 1.0f);
        float EID4720PS_648 = clamp((abs(EID4720PS_635.y) - 208.0f) * 0.03125f, 0.0f, 1.0f);
        float EID4720PS_649 = isnan(EID4720PS_648) ? EID4720PS_645 : (isnan(EID4720PS_645) ? EID4720PS_648 : max(EID4720PS_645, EID4720PS_648));
        float4 EID4720PS_951;
        float4 EID4720PS_952;
        float4 EID4720PS_953;
        float EID4720PS_954;
        float EID4720PS_955;
        if ((EID4720PS_19_m105.w != 0.0f) && (EID4720PS_649 < 1.0f))
        {
            float3 EID4720PS_662 = EID4720PS_519 - (EID4720PS_19_m105.xyz + (EID4720PS_553 * (-EID4720PS_19_m107.y)));
            float EID4720PS_664 = abs(EID4720PS_662.x);
            float EID4720PS_666 = abs(EID4720PS_662.z);
            float EID4720PS_672 = clamp(((isnan(EID4720PS_666) ? EID4720PS_664 : (isnan(EID4720PS_664) ? EID4720PS_666 : max(EID4720PS_664, EID4720PS_666))) - 29.0f) * 0.5f, 0.0f, 1.0f);
            float EID4720PS_675 = clamp((abs(EID4720PS_662.y) - 13.0f) * 0.5f, 0.0f, 1.0f);
            float EID4720PS_676 = isnan(EID4720PS_675) ? EID4720PS_672 : (isnan(EID4720PS_672) ? EID4720PS_675 : max(EID4720PS_672, EID4720PS_675));
            float EID4720PS_752;
            float4 EID4720PS_753;
            float4 EID4720PS_754;
            float4 EID4720PS_755;
            if (EID4720PS_676 < 1.0f)
            {
                float3 EID4720PS_685 = ((EID4720PS_519 * 2.0f) + 0.5f.xxx) * EID4720PS_19_m106.xyz;
                float3 EID4720PS_687 = EID4720PS_685 - floor(EID4720PS_685);
                float4 EID4720PS_691 = EID4720PS_42.SampleLevel(EID4720_linear_repeat_sampler, EID4720PS_687, 0.0f);
                float EID4720PS_692 = 1.0f - EID4720PS_676;
                float EID4720PS_696 = EID4720PS_19_m106.y * 0.5f;
                float EID4720PS_701 = EID4720PS_687.x;
                float EID4720PS_702 = clamp(EID4720PS_687.y, EID4720PS_696, 1.0f - EID4720PS_696) * 0.3333333432674407958984375f;
                float EID4720PS_703 = EID4720PS_687.z;
                float4 EID4720PS_706 = EID4720PS_43.SampleLevel(EID4720_linear_clamp_sampler, float3(EID4720PS_701, EID4720PS_702, EID4720PS_703), 0.0f);
                float EID4720PS_722 = EID4720PS_691.x;
                float EID4720PS_732 = EID4720PS_691.y;
                float EID4720PS_742 = EID4720PS_691.z;
                EID4720PS_752 = EID4720PS_649 + (EID4720PS_706.w * EID4720PS_692);
                EID4720PS_753 = float4(((EID4720PS_43.SampleLevel(EID4720_linear_clamp_sampler, float3(EID4720PS_701, EID4720PS_702 + 0.666666686534881591796875f, EID4720PS_703), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4720PS_742, EID4720PS_742) * EID4720PS_692;
                EID4720PS_754 = float4(((EID4720PS_43.SampleLevel(EID4720_linear_clamp_sampler, float3(EID4720PS_701, EID4720PS_702 + 0.3333333432674407958984375f, EID4720PS_703), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4720PS_732, EID4720PS_732) * EID4720PS_692;
                EID4720PS_755 = float4(((EID4720PS_706.xyz * 4.0f) - 2.0f.xxx) * EID4720PS_722, EID4720PS_722) * EID4720PS_692;
            }
            else
            {
                EID4720PS_752 = EID4720PS_649;
                EID4720PS_753 = 0.0f.xxxx;
                EID4720PS_754 = 0.0f.xxxx;
                EID4720PS_755 = 0.0f.xxxx;
            }
            float3 EID4720PS_761 = EID4720PS_519 - (EID4720PS_19_m105.xyz + (EID4720PS_553 * (-EID4720PS_19_m107.z)));
            float EID4720PS_763 = abs(EID4720PS_761.x);
            float EID4720PS_765 = abs(EID4720PS_761.z);
            float EID4720PS_771 = clamp(((isnan(EID4720PS_765) ? EID4720PS_763 : (isnan(EID4720PS_763) ? EID4720PS_765 : max(EID4720PS_763, EID4720PS_765))) - 116.0f) * 0.125f, 0.0f, 1.0f);
            float EID4720PS_774 = clamp((abs(EID4720PS_761.y) - 52.0f) * 0.125f, 0.0f, 1.0f);
            float EID4720PS_775 = isnan(EID4720PS_774) ? EID4720PS_771 : (isnan(EID4720PS_771) ? EID4720PS_774 : max(EID4720PS_771, EID4720PS_774));
            float EID4720PS_855;
            float4 EID4720PS_856;
            float4 EID4720PS_857;
            float4 EID4720PS_858;
            if (EID4720PS_775 < 1.0f)
            {
                float3 EID4720PS_784 = ((EID4720PS_519 * 0.5f) + 0.5f.xxx) * EID4720PS_19_m106.xyz;
                float3 EID4720PS_786 = EID4720PS_784 - floor(EID4720PS_784);
                float4 EID4720PS_790 = EID4720PS_44.SampleLevel(EID4720_linear_repeat_sampler, EID4720PS_786, 0.0f);
                float EID4720PS_792 = EID4720PS_676 * (1.0f - EID4720PS_775);
                float EID4720PS_796 = EID4720PS_19_m106.y * 0.5f;
                float EID4720PS_801 = EID4720PS_786.x;
                float EID4720PS_802 = clamp(EID4720PS_786.y, EID4720PS_796, 1.0f - EID4720PS_796) * 0.3333333432674407958984375f;
                float EID4720PS_803 = EID4720PS_786.z;
                float4 EID4720PS_806 = EID4720PS_45.SampleLevel(EID4720_linear_clamp_sampler, float3(EID4720PS_801, EID4720PS_802, EID4720PS_803), 0.0f);
                float EID4720PS_822 = EID4720PS_790.x;
                float EID4720PS_833 = EID4720PS_790.y;
                float EID4720PS_844 = EID4720PS_790.z;
                EID4720PS_855 = EID4720PS_752 + (EID4720PS_806.w * EID4720PS_792);
                EID4720PS_856 = EID4720PS_753 + (float4(((EID4720PS_45.SampleLevel(EID4720_linear_clamp_sampler, float3(EID4720PS_801, EID4720PS_802 + 0.666666686534881591796875f, EID4720PS_803), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4720PS_844, EID4720PS_844) * EID4720PS_792);
                EID4720PS_857 = EID4720PS_754 + (float4(((EID4720PS_45.SampleLevel(EID4720_linear_clamp_sampler, float3(EID4720PS_801, EID4720PS_802 + 0.3333333432674407958984375f, EID4720PS_803), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4720PS_833, EID4720PS_833) * EID4720PS_792);
                EID4720PS_858 = EID4720PS_755 + (float4(((EID4720PS_806.xyz * 4.0f) - 2.0f.xxx) * EID4720PS_822, EID4720PS_822) * EID4720PS_792);
            }
            else
            {
                EID4720PS_855 = EID4720PS_752;
                EID4720PS_856 = EID4720PS_753;
                EID4720PS_857 = EID4720PS_754;
                EID4720PS_858 = EID4720PS_755;
            }
            float4 EID4720PS_941;
            float4 EID4720PS_942;
            float4 EID4720PS_943;
            float EID4720PS_944;
            if (EID4720PS_775 > 0.0f)
            {
                float3 EID4720PS_867 = ((EID4720PS_519 * 0.125f) + 0.5f.xxx) * EID4720PS_19_m106.xyz;
                float3 EID4720PS_870 = EID4720PS_19_m106.xyz * 0.5f;
                float3 EID4720PS_872 = clamp(EID4720PS_867 - floor(EID4720PS_867), EID4720PS_870, 1.0f.xxx - EID4720PS_870);
                float4 EID4720PS_876 = EID4720PS_46.SampleLevel(EID4720_linear_repeat_sampler, EID4720PS_872, 0.0f);
                float EID4720PS_878 = EID4720PS_775 * (1.0f - EID4720PS_649);
                float EID4720PS_882 = EID4720PS_19_m106.y * 0.5f;
                float EID4720PS_887 = EID4720PS_872.x;
                float EID4720PS_888 = clamp(EID4720PS_872.y, EID4720PS_882, 1.0f - EID4720PS_882) * 0.3333333432674407958984375f;
                float EID4720PS_889 = EID4720PS_872.z;
                float4 EID4720PS_892 = EID4720PS_47.SampleLevel(EID4720_linear_clamp_sampler, float3(EID4720PS_887, EID4720PS_888, EID4720PS_889), 0.0f);
                float EID4720PS_908 = EID4720PS_876.x;
                float EID4720PS_919 = EID4720PS_876.y;
                float EID4720PS_930 = EID4720PS_876.z;
                EID4720PS_941 = EID4720PS_856 + (float4(((EID4720PS_47.SampleLevel(EID4720_linear_clamp_sampler, float3(EID4720PS_887, EID4720PS_888 + 0.666666686534881591796875f, EID4720PS_889), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4720PS_930, EID4720PS_930) * EID4720PS_878);
                EID4720PS_942 = EID4720PS_857 + (float4(((EID4720PS_47.SampleLevel(EID4720_linear_clamp_sampler, float3(EID4720PS_887, EID4720PS_888 + 0.3333333432674407958984375f, EID4720PS_889), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4720PS_919, EID4720PS_919) * EID4720PS_878);
                EID4720PS_943 = EID4720PS_858 + (float4(((EID4720PS_892.xyz * 4.0f) - 2.0f.xxx) * EID4720PS_908, EID4720PS_908) * EID4720PS_878);
                EID4720PS_944 = EID4720PS_855 + (EID4720PS_892.w * EID4720PS_878);
            }
            else
            {
                EID4720PS_941 = EID4720PS_856;
                EID4720PS_942 = EID4720PS_857;
                EID4720PS_943 = EID4720PS_858;
                EID4720PS_944 = EID4720PS_855;
            }
            float EID4720PS_947 = clamp((EID4720PS_944 * 2.0f) - 1.0f, 0.0f, 1.0f);
            EID4720PS_951 = EID4720PS_941;
            EID4720PS_952 = EID4720PS_942;
            EID4720PS_953 = EID4720PS_943;
            EID4720PS_954 = EID4720PS_947 - EID4720PS_649;
            EID4720PS_955 = (EID4720PS_947 + EID4720PS_649) * 0.5f;
        }
        else
        {
            EID4720PS_951 = 0.0f.xxxx;
            EID4720PS_952 = 0.0f.xxxx;
            EID4720PS_953 = 0.0f.xxxx;
            EID4720PS_954 = 0.0f;
            EID4720PS_955 = 1.0f;
        }
        float4 EID4720PS_975 = EID4720PS_953 + float4(EID4720PS_19_m108.x * EID4720PS_955, (EID4720PS_19_m108.y * EID4720PS_955) + ((EID4720PS_19_m108.w * EID4720PS_954) * 0.5f), EID4720PS_19_m108.z * EID4720PS_955, (EID4720PS_19_m108.w * EID4720PS_955) + ((EID4720PS_19_m108.y * EID4720PS_954) * 0.375f));
        float4 EID4720PS_995 = EID4720PS_952 + float4(EID4720PS_19_m109.x * EID4720PS_955, (EID4720PS_19_m109.y * EID4720PS_955) + ((EID4720PS_19_m109.w * EID4720PS_954) * 0.5f), EID4720PS_19_m109.z * EID4720PS_955, (EID4720PS_19_m109.w * EID4720PS_955) + ((EID4720PS_19_m109.y * EID4720PS_954) * 0.375f));
        float4 EID4720PS_1015 = EID4720PS_951 + float4(EID4720PS_19_m110.x * EID4720PS_955, (EID4720PS_19_m110.y * EID4720PS_955) + ((EID4720PS_19_m110.w * EID4720PS_954) * 0.5f), EID4720PS_19_m110.z * EID4720PS_955, (EID4720PS_19_m110.w * EID4720PS_955) + ((EID4720PS_19_m110.y * EID4720PS_954) * 0.375f));
        float4 EID4720PS_1019 = float4(EID4720PS_617, 1.0f);
        float3 EID4720PS_1023 = float3(dot(EID4720PS_975, EID4720PS_1019), dot(EID4720PS_995, EID4720PS_1019), dot(EID4720PS_1015, EID4720PS_1019));
        bool3 EID4720PS_3222 = isnan(EID4720PS_1023);
        bool3 EID4720PS_3223 = isnan(0.0f.xxx);
        float3 EID4720PS_3224 = max(EID4720PS_1023, 0.0f.xxx);
        float3 EID4720PS_3225 = float3(EID4720PS_3222.x ? 0.0f.xxx.x : EID4720PS_3224.x, EID4720PS_3222.y ? 0.0f.xxx.y : EID4720PS_3224.y, EID4720PS_3222.z ? 0.0f.xxx.z : EID4720PS_3224.z);
        float3 EID4720PS_1025 = float3(EID4720PS_3223.x ? EID4720PS_1023.x : EID4720PS_3225.x, EID4720PS_3223.y ? EID4720PS_1023.y : EID4720PS_3225.y, EID4720PS_3223.z ? EID4720PS_1023.z : EID4720PS_3225.z) * EID4720PS_610;
        float3 EID4720PS_1033 = ((EID4720PS_975.xyz * 0.2125999927520751953125f) + (EID4720PS_995.xyz * 0.715200006961822509765625f)) + (EID4720PS_1015.xyz * 0.072200000286102294921875f);
        float EID4720PS_1034 = dot(EID4720PS_1033, EID4720PS_1033);
        float3 EID4720PS_1037 = EID4720PS_1033 * rsqrt(isnan(EID4720PS_1034) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? EID4720PS_1034 : max(1.1754943508222875079687365372222e-38f, EID4720PS_1034)));
        float4 EID4720PS_1042 = float4(EID4720PS_1037.x, abs(EID4720PS_1037.y), EID4720PS_1037.z, 1.0f);
        float3 EID4720PS_1046 = float3(dot(EID4720PS_975, EID4720PS_1042), dot(EID4720PS_995, EID4720PS_1042), dot(EID4720PS_1015, EID4720PS_1042));
        bool3 EID4720PS_3232 = isnan(EID4720PS_1046);
        bool3 EID4720PS_3233 = isnan(0.0f.xxx);
        float3 EID4720PS_3234 = max(EID4720PS_1046, 0.0f.xxx);
        float3 EID4720PS_3235 = float3(EID4720PS_3232.x ? 0.0f.xxx.x : EID4720PS_3234.x, EID4720PS_3232.y ? 0.0f.xxx.y : EID4720PS_3234.y, EID4720PS_3232.z ? 0.0f.xxx.z : EID4720PS_3234.z);
        float3 EID4720PS_1047 = float3(EID4720PS_3233.x ? EID4720PS_1046.x : EID4720PS_3235.x, EID4720PS_3233.y ? EID4720PS_1046.y : EID4720PS_3235.y, EID4720PS_3233.z ? EID4720PS_1046.z : EID4720PS_3235.z);
        float EID4720PS_1048 = EID4720PS_1047.x;
        float EID4720PS_1049 = EID4720PS_1047.y;
        float EID4720PS_1050 = EID4720PS_1047.z;
        float EID4720PS_1051 = isnan(EID4720PS_1049) ? EID4720PS_1048 : (isnan(EID4720PS_1048) ? EID4720PS_1049 : max(EID4720PS_1048, EID4720PS_1049));
        float EID4720PS_1052 = isnan(EID4720PS_1050) ? EID4720PS_1051 : (isnan(EID4720PS_1051) ? EID4720PS_1050 : max(EID4720PS_1051, EID4720PS_1050));
        float EID4720PS_1055 = EID4720PS_1025.z;
        float EID4720PS_1056 = EID4720PS_1025.y;
        float4 EID4720PS_1061 = lerp(float4(EID4720PS_1055, EID4720PS_1056, -1.0f, 0.666666686534881591796875f), float4(EID4720PS_1056, EID4720PS_1055, 0.0f, -0.3333333432674407958984375f), step(EID4720PS_1055, EID4720PS_1056).xxxx);
        float EID4720PS_1062 = EID4720PS_1025.x;
        float EID4720PS_1063 = EID4720PS_1061.x;
        float4 EID4720PS_1071 = lerp(float4(EID4720PS_1063, EID4720PS_1061.yw, EID4720PS_1062), float4(EID4720PS_1062, EID4720PS_1061.yz, EID4720PS_1063), step(EID4720PS_1063, EID4720PS_1062).xxxx);
        float EID4720PS_1072 = EID4720PS_1071.x;
        float EID4720PS_1073 = EID4720PS_1071.w;
        float EID4720PS_1074 = EID4720PS_1071.y;
        float EID4720PS_1076 = EID4720PS_1072 - (isnan(EID4720PS_1074) ? EID4720PS_1073 : (isnan(EID4720PS_1073) ? EID4720PS_1074 : min(EID4720PS_1073, EID4720PS_1074)));
        float EID4720PS_1085 = EID4720PS_1076 / (EID4720PS_1072 + 9.9999997473787516355514526367188e-05f);
        float EID4720PS_1086 = frac(abs(EID4720PS_1071.z + ((EID4720PS_1073 - EID4720PS_1074) / ((6.0f * EID4720PS_1076) + 9.9999997473787516355514526367188e-05f))));
        float EID4720PS_1092 = lerp(0.699999988079071044921875f, 0.3499999940395355224609375f, smoothstep(0.449999988079071044921875f, 0.3499999940395355224609375f, abs(EID4720PS_1086 - 0.5f))) * clamp(EID4720PS_1072, 0.0f, 1.0f);
        float EID4720PS_1093 = isnan(EID4720PS_1092) ? EID4720PS_1085 : (isnan(EID4720PS_1085) ? EID4720PS_1092 : min(EID4720PS_1085, EID4720PS_1092));
        float EID4720PS_1095 = 2.0f / (2.0f - EID4720PS_1093);
        EID4720PS_1108 = lerp(1.0f.xxx, clamp(abs((frac(float3(EID4720PS_1086, EID4720PS_1093, EID4720PS_1095).xxx + float3(1.0f, 0.666666686534881591796875f, 0.3333333432674407958984375f)) * 6.0f) - 3.0f.xxx) - 1.0f.xxx, 0.0f.xxx, 1.0f.xxx), EID4720PS_1093.xxx) * EID4720PS_1095;
        EID4720PS_1109 = (isnan(0.0f) ? EID4720PS_1052 : (isnan(EID4720PS_1052) ? 0.0f : max(EID4720PS_1052, 0.0f))) * EID4720PS_610;
    }
    else
    {
        EID4720PS_1108 = EID4720PS_19_m82.xyz;
        EID4720PS_1109 = EID4720PS_610;
    }
    float EID4720PS_1128 = EID4720PS_511.x * lerp(clamp(EID4720PS_565 + 0.5f, 0.0f, 1.0f), 1.0f, EID4720PS_513);
    float EID4720PS_1142 = clamp((1.0f - clamp((clamp(dot(EID4720PS_541, EID4720PS_406), 0.0f, 1.0f) * 0.85000002384185791015625f) + 0.1500000059604644775390625f, 0.0f, 1.0f)) * (EID4720PS_1128 * lerp(EID4720PS_49_m31, EID4720PS_49_m30, EID4720PS_514)), 0.0f, 1.0f);
    float3 EID4720PS_1150 = EID4720PS_474 * ((1.0f - EID4720PS_1142).xxx + (EID4720PS_49_m34.xyz * EID4720PS_1142));
    float EID4720PS_1151 = lerp(0.0f, EID4720PS_49_m1, EID4720PS_513);
    float EID4720PS_1237;
    float EID4720PS_1238;
    float3 EID4720PS_1239;
    float EID4720PS_1240;
    float EID4720PS_1241;
    [branch]
    if ((clamp(EID4720PS_588 + EID4720PS_601, 0.0f, 1.0f) - EID4720PS_49_m20) > 0.00999999977648258209228515625f)
    {
        float EID4720PS_1164 = EID4720PS_19_m10.x * 0.800000011920928955078125f;
        float4 EID4720PS_1169 = EID4720PS_53.SampleBias(EID4720_linear_repeat_sampler, EID4720PS_3 + float2(0.0f, frac(EID4720PS_1164)), EID4720PS_19_m16);
        float4 EID4720PS_1183 = float4(EID4720PS_1169.xy, EID4720PS_53.SampleBias(EID4720_linear_repeat_sampler, EID4720PS_3 + float2(0.0f, frac(EID4720PS_1164 + 0.004999999888241291046142578125f)), EID4720PS_19_m16).w, EID4720PS_1169.w);
        float4 EID4720PS_1187 = EID4720PS_54.SampleBias(EID4720_linear_repeat_sampler, EID4720PS_3, EID4720PS_19_m16);
        float EID4720PS_1188 = EID4720PS_1187.z;
        float2 EID4720PS_1190 = EID4720PS_1183.zw * EID4720PS_1188;
        float EID4720PS_1192 = EID4720PS_1190.y;
        float2 EID4720PS_1195 = (EID4720PS_1183.xy * 2.0f) - 1.0f.xx;
        float EID4720PS_1196 = EID4720PS_1190.x;
        float EID4720PS_1199 = clamp(EID4720PS_1196 + EID4720PS_1192, 0.0f, 1.0f) * EID4720PS_602;
        float EID4720PS_1200 = (EID4720PS_1169.z * EID4720PS_1188) * EID4720PS_602;
        float3 EID4720PS_1203 = float3(EID4720PS_1195, 0.0f);
        float2 EID4720PS_1204 = EID4720PS_1203.xy;
        float EID4720PS_1208 = sqrt(1.0f - clamp(dot(EID4720PS_1204, EID4720PS_1204), 0.0f, 1.0f));
        float3 EID4720PS_1210 = EID4720PS_1203;
        EID4720PS_1210.z = isnan(EID4720PS_1208) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? EID4720PS_1208 : max(1.000000016862383526387164645044e-16f, EID4720PS_1208));
        float EID4720PS_1218 = lerp(smoothstep(0.0f, 0.800000011920928955078125f, (EID4720PS_1195.y * 0.5f) + 0.5f), 1.0f, clamp(EID4720PS_1196 - EID4720PS_1192, 0.0f, 1.0f));
        EID4720PS_1237 = lerp(EID4720PS_1151, 3.0f, clamp((EID4720PS_1199 * 2.0f) + EID4720PS_1200, 0.0f, 1.0f) * EID4720PS_602);
        EID4720PS_1238 = EID4720PS_453 * ((1.0f - EID4720PS_1199) + (lerp((1.0f - EID4720PS_1218) + (0.800000011920928955078125f * EID4720PS_1218), 0.89999997615814208984375f, EID4720PS_513) * EID4720PS_1199));
        EID4720PS_1239 = normalize(mul(EID4720PS_1210, float3x3(EID4720PS_6.xyz * 1.0f, (cross(EID4720PS_5, EID4720PS_6.xyz) * EID4720PS_6.w) * 1.0f, EID4720PS_5 * 1.0f))) * EID4720PS_540;
        EID4720PS_1240 = lerp(EID4720PS_452, 0.5f, EID4720PS_602);
        EID4720PS_1241 = clamp(clamp(EID4720PS_1199 + EID4720PS_1200, 0.0f, 1.0f), 0.0f, 1.0f);
    }
    else
    {
        EID4720PS_1237 = EID4720PS_1151;
        EID4720PS_1238 = EID4720PS_453;
        EID4720PS_1239 = EID4720PS_541;
        EID4720PS_1240 = EID4720PS_452;
        EID4720PS_1241 = 0.0f;
    }
    float3 EID4720PS_1401;
    float EID4720PS_1402;
    float EID4720PS_1403;
    float3 EID4720PS_1404;
    float3 EID4720PS_1405;
    float EID4720PS_1406;
    [branch]
    if (EID4720PS_591 > 0.00999999977648258209228515625f)
    {
        bool3 EID4720PS_1245 = EID4720PS_415.xxx;
        float3 EID4720PS_1247 = EID4720PS_10.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 EID4720PS_1248 = float3(EID4720PS_1245.x ? EID4720PS_1247.x : EID4720PS_10.x, EID4720PS_1245.y ? EID4720PS_1247.y : EID4720PS_10.y, EID4720PS_1245.z ? EID4720PS_1247.z : EID4720PS_10.z);
        float3 EID4720PS_1251 = EID4720PS_1248 * EID4720PS_19_m89.z;
        float3 EID4720PS_1253 = float3(EID4720PS_1245.x ? EID4720PS_9.xzy.x : EID4720PS_9.x, EID4720PS_1245.y ? EID4720PS_9.xzy.y : EID4720PS_9.y, EID4720PS_1245.z ? EID4720PS_9.xzy.z : EID4720PS_9.z);
        float3 EID4720PS_1255 = abs(EID4720PS_1253) - 0.20000000298023223876953125f.xxx;
        float3 EID4720PS_1257 = (EID4720PS_1255 * EID4720PS_1255) * EID4720PS_1255;
        bool3 EID4720PS_3267 = isnan(EID4720PS_1257);
        bool3 EID4720PS_3268 = isnan(6.103515625e-05f.xxx);
        float3 EID4720PS_3269 = max(EID4720PS_1257, 6.103515625e-05f.xxx);
        float3 EID4720PS_3270 = float3(EID4720PS_3267.x ? 6.103515625e-05f.xxx.x : EID4720PS_3269.x, EID4720PS_3267.y ? 6.103515625e-05f.xxx.y : EID4720PS_3269.y, EID4720PS_3267.z ? 6.103515625e-05f.xxx.z : EID4720PS_3269.z);
        float3 EID4720PS_1258 = float3(EID4720PS_3268.x ? EID4720PS_1257.x : EID4720PS_3270.x, EID4720PS_3268.y ? EID4720PS_1257.y : EID4720PS_3270.y, EID4720PS_3268.z ? EID4720PS_1257.z : EID4720PS_3270.z);
        float3 EID4720PS_1261 = EID4720PS_1258 / dot(EID4720PS_1258, 1.0f.xxx).xxx;
        float EID4720PS_1277 = EID4720PS_1261.y;
        float EID4720PS_1279 = EID4720PS_1261.z;
        float EID4720PS_1282 = EID4720PS_1261.x;
        float4 EID4720PS_1284 = ((EID4720PS_55.SampleBias(EID4720_linear_repeat_sampler, EID4720PS_1251.xz, EID4720PS_19_m16) * EID4720PS_1277) + (EID4720PS_55.SampleBias(EID4720_linear_repeat_sampler, EID4720PS_1251.xy, EID4720PS_19_m16) * EID4720PS_1279)) + (EID4720PS_55.SampleBias(EID4720_linear_repeat_sampler, EID4720PS_1251.zy, EID4720PS_19_m16) * EID4720PS_1282);
        float EID4720PS_1292 = clamp(EID4720PS_591 + (smoothstep(0.3499999940395355224609375f, 0.20000000298023223876953125f, EID4720PS_1248.y) * clamp(EID4720PS_591 * 3.0f, 0.0f, 1.0f)), 0.0f, 1.0f);
        float EID4720PS_1305 = smoothstep(2.0f - EID4720PS_1292, 2.349999904632568359375f - EID4720PS_1292, lerp(0.0f, (smoothstep(-1.0f, 0.0f, EID4720PS_1253.y) + EID4720PS_1284.z) * 0.60000002384185791015625f, EID4720PS_513 * EID4720PS_1128)) * ((EID4720PS_1238 * EID4720PS_1238) * float(EID4720PS_gl_FrontFacing));
        float3 EID4720PS_1307 = EID4720PS_1305.xxx;
        float2 EID4720PS_1313 = (EID4720PS_1284.xy * 2.0f) - 1.0f.xx;
        float2 EID4720PS_1315 = EID4720PS_1313.xy;
        float EID4720PS_1319 = sqrt(1.0f - clamp(dot(EID4720PS_1315, EID4720PS_1315), 0.0f, 1.0f));
        float3 EID4720PS_1321 = float3(EID4720PS_1313.x, EID4720PS_1313.y, EID4720PS_368.z);
        EID4720PS_1321.z = isnan(EID4720PS_1319) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? EID4720PS_1319 : max(1.000000016862383526387164645044e-16f, EID4720PS_1319));
        float2 EID4720PS_1323 = EID4720PS_1321.xy * 2.0f;
        float3 EID4720PS_1325 = lerp(float3(0.0f, 0.0f, 1.0f), float3(EID4720PS_1323.x, EID4720PS_1323.y, EID4720PS_1321.z), EID4720PS_1307);
        float EID4720PS_1326 = dot(EID4720PS_1325, EID4720PS_1325);
        float3 EID4720PS_1329 = EID4720PS_1325 * rsqrt(isnan(EID4720PS_1326) ? 6.103515625e-05f : (isnan(6.103515625e-05f) ? EID4720PS_1326 : max(6.103515625e-05f, EID4720PS_1326)));
        float EID4720PS_1330 = EID4720PS_541.y;
        float EID4720PS_1333 = step(0.00999999977648258209228515625f, 1.0f - (EID4720PS_1330 * EID4720PS_1330));
        float EID4720PS_1336 = lerp(EID4720PS_612, EID4720PS_1330, EID4720PS_1333);
        float EID4720PS_1338 = 1.0f - (EID4720PS_1336 * EID4720PS_1336);
        float3 EID4720PS_1343 = (float3(0.0f, EID4720PS_1333, 1.0f - EID4720PS_1333) - (EID4720PS_541 * EID4720PS_1336)) * rsqrt(isnan(EID4720PS_1338) ? 9.9999997473787516355514526367188e-05f : (isnan(9.9999997473787516355514526367188e-05f) ? EID4720PS_1338 : max(9.9999997473787516355514526367188e-05f, EID4720PS_1338)));
        float3 EID4720PS_1357 = EID4720PS_1251 * 4.0f;
        float4 EID4720PS_1377 = ((EID4720PS_56.SampleLevel(EID4720_point_repeat_sampler, EID4720PS_1357.xz, 0.0f) * EID4720PS_1277) + (EID4720PS_56.SampleLevel(EID4720_point_repeat_sampler, EID4720PS_1357.xy, 0.0f) * EID4720PS_1279)) + (EID4720PS_56.SampleLevel(EID4720_point_repeat_sampler, EID4720PS_1357.zy, 0.0f) * EID4720PS_1282);
        float2 EID4720PS_1380 = (EID4720PS_1377.xz * 2.0f) - 1.0f.xx;
        float EID4720PS_1391 = smoothstep(0.949999988079071044921875f, 1.0f, frac(((dot(float3(EID4720PS_1380.x, EID4720PS_1377.y, EID4720PS_1380.y), (floor(EID4720PS_406 * 50.0f) * 0.0199999995529651641845703125f) * 0.100000001490116119384765625f) * 0.5f) + 0.5f) * 2.0f));
        float EID4720PS_1392 = EID4720PS_1391 * EID4720PS_1391;
        float EID4720PS_1395 = EID4720PS_1392 * ((EID4720PS_1392 * 2.0f) * EID4720PS_1305);
        float3 EID4720PS_1396 = 1.0f.xxx * EID4720PS_1395;
        EID4720PS_1401 = ((cross(EID4720PS_1343, EID4720PS_541) * EID4720PS_1329.x) + (EID4720PS_1343 * EID4720PS_1329.y)) + (EID4720PS_541 * EID4720PS_1329.z);
        EID4720PS_1402 = EID4720PS_1395;
        EID4720PS_1403 = lerp(lerp(EID4720PS_1240, 0.89999997615814208984375f, clamp(EID4720PS_1305 * 4.0f, 0.0f, 1.0f)), 0.00999999977648258209228515625f, EID4720PS_1395);
        EID4720PS_1404 = lerp(EID4720PS_507 * 1.0f, 0.3079999983310699462890625f.xxx, EID4720PS_1307) + (EID4720PS_1396 * 0.5f);
        EID4720PS_1405 = lerp(EID4720PS_1150 * 1.0f, 0.87999999523162841796875f.xxx, EID4720PS_1307) + EID4720PS_1396;
        EID4720PS_1406 = lerp(EID4720PS_49_m2, 0.0f, EID4720PS_1305);
    }
    else
    {
        EID4720PS_1401 = EID4720PS_541;
        EID4720PS_1402 = 0.0f;
        EID4720PS_1403 = EID4720PS_1240;
        EID4720PS_1404 = EID4720PS_507;
        EID4720PS_1405 = EID4720PS_1150;
        EID4720PS_1406 = EID4720PS_49_m2;
    }
    float EID4720PS_1408 = 0.959999978542327880859375f - (EID4720PS_1406 * 0.959999978542327880859375f);
    float3 EID4720PS_1409 = EID4720PS_1405 * EID4720PS_1408;
    float3 EID4720PS_1412 = lerp(0.039999999105930328369140625f.xxx * EID4720PS_1237, EID4720PS_1405, EID4720PS_1406.xxx);
    float3 EID4720PS_1413 = EID4720PS_1404 * EID4720PS_1408;
    float EID4720PS_1414 = EID4720PS_1403 * EID4720PS_1403;
    float EID4720PS_1415 = isnan(0.0078125f) ? EID4720PS_1414 : (isnan(EID4720PS_1414) ? 0.0078125f : max(EID4720PS_1414, 0.0078125f));
    float2 EID4720PS_1428 = (EID4720PS_7.xy / (isnan(9.9999999392252902907785028219223e-09f) ? EID4720PS_7.z : (isnan(EID4720PS_7.z) ? 9.9999999392252902907785028219223e-09f : max(EID4720PS_7.z, 9.9999999392252902907785028219223e-09f))).xx) - (EID4720PS_8.xy / (isnan(9.9999999392252902907785028219223e-09f) ? EID4720PS_8.z : (isnan(EID4720PS_8.z) ? 9.9999999392252902907785028219223e-09f : max(EID4720PS_8.z, 9.9999999392252902907785028219223e-09f))).xx);
    float2 EID4720PS_1431 = EID4720PS_1428;
    EID4720PS_1431.y = -EID4720PS_1428.y;
    float2 EID4720PS_1441 = ((sqrt(sqrt(abs(EID4720PS_1431 * 0.5f))) * float2(int2(sign(EID4720PS_1431)))) * 0.5f) + 0.5f.xx;
    float4 EID4720PS_1445 = float4(EID4720PS_1441.x, EID4720PS_1441.y, 0.0f.xxxx.z, 0.0f.xxxx.w);
    EID4720PS_1445.z = 1.0f;
    float4 EID4720PS_1446 = EID4720PS_1445;
    EID4720PS_1446.w = (EID4720PS_1402 > 0.100000001490116119384765625f) ? 0.699999988079071044921875f : 0.4000000059604644775390625f;
    float3 EID4720PS_1457 = lerp(-EID4720PS_36_m0.xyz, EID4720PS_19_m90.xyz, EID4720PS_19_m80.w.xxx);
    float3 EID4720PS_1471 = lerp(EID4720PS_36_m3.xyz, EID4720PS_19_m83.xyz, EID4720PS_19_m91.y.xxx);
    float3 EID4720PS_1475 = EID4720PS_1471 * lerp(EID4720PS_36_m3.w, 1.0f, EID4720PS_19_m91.w);
    int EID4720PS_1479 = int(EID4720PS_543.x);
    int EID4720PS_1480 = int(EID4720PS_543.y);
    float4 EID4720PS_1484 = captureValid ? EID4720PS_40.Load(int3(EID4720PS_543,0)) : float4(1,1,0,0);
    float EID4720PS_1489 = EID4720PS_1484.y;
    float EID4720PS_1492 = lerp(lerp(1.0f, EID4720PS_1484.x, EID4720PS_38_m6.x), 1.0f, EID4720PS_19_m80.z);
    float3 EID4720PS_1500 = EID4720PS_1413 * EID4720PS_19_m79.z;
    float3 EID4720PS_1501 = EID4720PS_1500 * 0.64999997615814208984375f;
    float3 EID4720PS_1515 = mul(EID4720PS_1457, EID4720PS_557);
    float3 EID4720PS_1517 = float3(EID4720PS_1515.x, EID4720PS_1515.y, EID4720PS_1515.z);
    EID4720PS_1517.y = 6.103515625e-05f;
    float3 EID4720PS_1518 = normalize(EID4720PS_1517);
    float EID4720PS_1521 = float(EID4720PS_1518.x > 0.0f);
    float2 EID4720PS_1525 = EID4720PS_3;
    EID4720PS_1525.x = lerp(1.0f - EID4720PS_3.x, EID4720PS_3.x, EID4720PS_1521);
    float4 EID4720PS_1529 = EID4720PS_58.SampleLevel(EID4720_linear_clamp_sampler, EID4720PS_1525, 0.0f);
    float EID4720PS_1531 = EID4720PS_1529.z * 2.0f;
    float EID4720PS_1534 = lerp(1.0f - EID4720PS_1531, EID4720PS_1531 - 1.0f, EID4720PS_1521);
    float3 EID4720PS_1539 = mul(EID4720PS_557, normalize(float3(EID4720PS_1534, 6.103515625e-05f, 1.0f - abs(EID4720PS_1534))));
    float EID4720PS_1540 = dot(EID4720PS_1539, EID4720PS_1539);
    float3 EID4720PS_1546 = normalize(lerp((EID4720PS_1539 * rsqrt(isnan(EID4720PS_1540) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? EID4720PS_1540 : max(1.1754943508222875079687365372222e-38f, EID4720PS_1540)))).xyz, EID4720PS_1401, EID4720PS_615));
    float EID4720PS_1547 = EID4720PS_1529.w;
    float EID4720PS_1548 = EID4720PS_1518.z;
    float EID4720PS_1549 = -EID4720PS_1548;
    float EID4720PS_1564 = lerp(EID4720PS_1548, (EID4720PS_1549 * ((EID4720PS_1548 * 0.5f) - 1.0f)) + 0.5f, (clamp(-dot(normalize(float3(EID4720PS_1457.x, 6.103515625e-05f, EID4720PS_1457.z)).xz, normalize(EID4720PS_553.xz)), 0.0f, 1.0f) * clamp(EID4720PS_1549, 0.0f, 1.0f)) * (1.0f - EID4720PS_19_m91.x)) * 0.5f;
    float EID4720PS_1566 = clamp(0.5f - EID4720PS_1564, 0.001000000047497451305389404296875f, 0.999000012874603271484375f);
    float EID4720PS_1568 = EID4720PS_1566 - (1.0f - EID4720PS_1566);
    float EID4720PS_1570 = EID4720PS_1566 + EID4720PS_1566;
    float EID4720PS_1572 = (EID4720PS_1529.x + EID4720PS_1529.y) * 0.5f;
    float EID4720PS_1583 = EID4720PS_19_m94.z * 0.5f;
    float EID4720PS_1585 = clamp(0.5f - EID4720PS_1583, 0.001000000047497451305389404296875f, 0.999000012874603271484375f);
    float EID4720PS_1587 = EID4720PS_1585 - (1.0f - EID4720PS_1585);
    float EID4720PS_1589 = EID4720PS_1585 + EID4720PS_1585;
    float4 EID4720PS_1606 = EID4720PS_50.SampleLevel(EID4720_linear_clamp_sampler, float2((lerp(lerp(-1.0f, 1.0f, abs((-smoothstep(isnan(0.0f) ? EID4720PS_1568 : (isnan(EID4720PS_1568) ? 0.0f : max(EID4720PS_1568, 0.0f)), isnan(1.0f) ? EID4720PS_1570 : (isnan(EID4720PS_1570) ? 1.0f : min(EID4720PS_1570, 1.0f)), EID4720PS_1572)) - (EID4720PS_1564 * ceil(EID4720PS_1564)))), clamp(dot(EID4720PS_1401, EID4720PS_1457) + (EID4720PS_19_m90.w * EID4720PS_19_m91.x), -1.0f, 1.0f), EID4720PS_513) * 0.5f) + 0.5f, 0.5f), 0.0f);
    float EID4720PS_1607 = EID4720PS_1606.w;
    float EID4720PS_1609 = EID4720PS_1606.x;
    float EID4720PS_1610 = EID4720PS_1606.y;
    float EID4720PS_1611 = EID4720PS_1606.z;
    float EID4720PS_1612 = isnan(EID4720PS_1610) ? EID4720PS_1609 : (isnan(EID4720PS_1609) ? EID4720PS_1610 : max(EID4720PS_1609, EID4720PS_1610));
    float EID4720PS_1614 = isnan(EID4720PS_1610) ? EID4720PS_1609 : (isnan(EID4720PS_1609) ? EID4720PS_1610 : min(EID4720PS_1609, EID4720PS_1610));
    float EID4720PS_1616 = (isnan(EID4720PS_1611) ? EID4720PS_1612 : (isnan(EID4720PS_1612) ? EID4720PS_1611 : max(EID4720PS_1612, EID4720PS_1611))) - (isnan(EID4720PS_1611) ? EID4720PS_1614 : (isnan(EID4720PS_1614) ? EID4720PS_1611 : min(EID4720PS_1614, EID4720PS_1611)));
    float EID4720PS_1618 = EID4720PS_514 * smoothstep(0.75f, 0.25f, EID4720PS_565);
    float EID4720PS_1619 = isnan(EID4720PS_1618) ? EID4720PS_513 : (isnan(EID4720PS_513) ? EID4720PS_1618 : max(EID4720PS_513, EID4720PS_1618));
    float EID4720PS_1622 = (1.0f - EID4720PS_1619) + (EID4720PS_1489 * EID4720PS_1619);
    float EID4720PS_1623 = 1.0f - EID4720PS_513;
    float EID4720PS_1631 = isnan(EID4720PS_1238) ? EID4720PS_1622 : (isnan(EID4720PS_1622) ? EID4720PS_1238 : min(EID4720PS_1622, EID4720PS_1238));
    float EID4720PS_1632 = isnan(EID4720PS_1607) ? EID4720PS_1631 : (isnan(EID4720PS_1631) ? EID4720PS_1607 : min(EID4720PS_1631, EID4720PS_1607));
    float EID4720PS_1633 = EID4720PS_1238 * EID4720PS_1622;
    float3 EID4720PS_1637 = ((clamp(dot(EID4720PS_617, EID4720PS_19_m85.xyz) + EID4720PS_19_m86.x, 0.0f, 1.0f) * EID4720PS_19_m86.y) + EID4720PS_19_m86.z).xxx * lerp(EID4720PS_1108, 1.0f.xxx, (EID4720PS_19_m80.y * EID4720PS_1632).xxx);
    float3 EID4720PS_1639 = EID4720PS_1632.xxx;
    float EID4720PS_1652 = lerp(0.64999997615814208984375f, 1.0f, EID4720PS_1109);
    float3 EID4720PS_1662 = EID4720PS_1492.xxx;
    float3 EID4720PS_1663 = lerp((EID4720PS_1637 * lerp(isnan(1.5f) ? EID4720PS_1652 : (isnan(EID4720PS_1652) ? 1.5f : min(EID4720PS_1652, 1.5f)), clamp(EID4720PS_1109, 1.25f, 1.75f), EID4720PS_19_m80.x)) * EID4720PS_19_m79.w, (lerp(dot(EID4720PS_1475, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, EID4720PS_1475, EID4720PS_1639) + ((EID4720PS_1637 * clamp(EID4720PS_1109, 0.0f, 1.5f)) * ((1.0f - EID4720PS_19_m91.y).xxx + (EID4720PS_1471 * EID4720PS_19_m91.y)))) * EID4720PS_19_m79.y, EID4720PS_1662);
    float3 EID4720PS_1664 = lerp(lerp(lerp(dot(EID4720PS_1501, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, EID4720PS_1501, 1.2000000476837158203125f.xxx), EID4720PS_1500, clamp((EID4720PS_1238 * (EID4720PS_1623 + (EID4720PS_1622 * EID4720PS_513))) + EID4720PS_1607, 0.0f, 1.0f).xxx), EID4720PS_1409, EID4720PS_1639);
    float3 EID4720PS_1670 = EID4720PS_1664 * ((1.0f - EID4720PS_1616).xxx + (EID4720PS_1606.xyz * EID4720PS_1616));
    float EID4720PS_1671 = dot(EID4720PS_1670, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float3 EID4720PS_1679 = lerp(lerp(EID4720PS_1500, lerp(dot(EID4720PS_1409, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, EID4720PS_1409, 1.2000000476837158203125f.xxx), EID4720PS_1633.xxx), EID4720PS_1670 * clamp(dot(EID4720PS_1664, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)) * (1.0f / (isnan(0.001000000047497451305389404296875f) ? EID4720PS_1671 : (isnan(EID4720PS_1671) ? 0.001000000047497451305389404296875f : max(EID4720PS_1671, 0.001000000047497451305389404296875f)))), 0.0f, 1.5f), EID4720PS_1662);
    float4 EID4720PS_1683 = float4(EID4720PS_1679, EID4720PS_1492);
    float EID4720PS_1685 = lerp(EID4720PS_1633, EID4720PS_1632, EID4720PS_1492);
    float3 EID4720PS_1696 = float3(EID4720PS_553.x, lerp(0.5f, EID4720PS_1457.y, EID4720PS_1492), EID4720PS_553.z);
    float EID4720PS_1697 = dot(EID4720PS_1696, EID4720PS_1696);
    float EID4720PS_1709 = clamp(dot(EID4720PS_1239, EID4720PS_406), 0.0f, 1.0f);
    float EID4720PS_1710 = dot(EID4720PS_1239, normalize(((EID4720PS_1457 * EID4720PS_1492) + ((EID4720PS_1696 * rsqrt(isnan(EID4720PS_1697) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? EID4720PS_1697 : max(1.1754943508222875079687365372222e-38f, EID4720PS_1697)))) * 2.0f)) + (EID4720PS_406 * (2.0f + EID4720PS_1492))));
    float EID4720PS_1711 = EID4720PS_1415 * EID4720PS_1415;
    float EID4720PS_1715 = (((EID4720PS_1710 * EID4720PS_1711) - EID4720PS_1710) * EID4720PS_1710) + 1.0f;
    float EID4720PS_1716 = EID4720PS_1715 * EID4720PS_1715;
    float EID4720PS_1720 = 2.0f * EID4720PS_1709;
    float EID4720PS_1722 = (1.0f + EID4720PS_1709) - EID4720PS_1709;
    float3 EID4720PS_1763;
    if (EID4720PS_1241 > 0.001000000047497451305389404296875f)
    {
        EID4720PS_1763 = ((EID4720PS_54.SampleBias(EID4720_linear_clamp_sampler, (normalize(mul(float3x3(EID4720PS_17_m0[0].xyz, EID4720PS_17_m0[1].xyz, EID4720PS_17_m0[2].xyz), EID4720PS_1239)).xy * 0.5f) + 0.5f.xx, EID4720PS_19_m16).w.xxx * EID4720PS_1622) * (clamp(EID4720PS_1109, 0.5f, 1.5f) * EID4720PS_19_m79.w)) * (EID4720PS_1241 * EID4720PS_1241);
    }
    else
    {
        EID4720PS_1763 = 0.0f.xxx;
    }
    float3 EID4720PS_1766 = ((EID4720PS_1663 * EID4720PS_1679) * 1.0f) + ((((EID4720PS_1412 * clamp((((EID4720PS_1711 != EID4720PS_1716) ? (EID4720PS_1711 / EID4720PS_1716) : 1.0f) * (0.5f / ((EID4720PS_1720 + (EID4720PS_1415 * EID4720PS_1722)) + 9.9999997473787516355514526367188e-05f))) - 6.103515625e-05f, 0.0f, 20.0f)) * ((EID4720PS_1663 * (((EID4720PS_1685 * 0.5f) + 0.5f) * lerp(EID4720PS_19_m79.z, 1.0f, EID4720PS_1685))) * 1.0f)) * EID4720PS_19_m92.w) + EID4720PS_1763);
    float EID4720PS_1767 = dot(EID4720PS_1766, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float EID4720PS_1770 = clamp(EID4720PS_1767 - 0.5f, 0.0f, 0.5f);
    float3 EID4720PS_1806 = normalize(cross(EID4720PS_553, lerp(float3(EID4720PS_19_m88.xy, 0.0f), (float3(EID4720PS_17_m0[0].x, EID4720PS_17_m0[0].y, EID4720PS_17_m0[0].z) * EID4720PS_19_m88.x) + (float3(EID4720PS_17_m0[1].x, EID4720PS_17_m0[1].y, EID4720PS_17_m0[1].z) * EID4720PS_19_m88.y), EID4720PS_19_m94.w.xxx)));
    float EID4720PS_1812 = dot(EID4720PS_406, EID4720PS_1546);
    float EID4720PS_1814 = 1.0f - abs(EID4720PS_1812);
    float EID4720PS_1819 = smoothstep(0.89999997615814208984375f, 1.0f, abs(EID4720PS_565));
    float EID4720PS_1822 = float(dot(EID4720PS_553, EID4720PS_1806) < (-0.00999999977648258209228515625f));
    float EID4720PS_1836 = clamp(dot(EID4720PS_526, EID4720PS_1806) + 1.0f, 0.0f, 1.0f);
    float EID4720PS_1837 = isnan(EID4720PS_1238) ? EID4720PS_1836 : (isnan(EID4720PS_1836) ? EID4720PS_1238 : min(EID4720PS_1836, EID4720PS_1238));
    float2 EID4720PS_1859 = float2(EID4720PS_543);
    float2 EID4720PS_1861 = floor(EID4720PS_1859 * 0.03125f);
    int EID4720PS_1869 = int((EID4720PS_1861.x + (EID4720PS_1861.y * EID4720PS_34_m5)) * 8.0f);
    float EID4720PS_1876 = floor(EID4720PS_387 - (EID4720PS_19_m3.y * EID4720PS_34_m11));
    float EID4720PS_1880 = clamp(EID4720PS_1876, 0.0f, EID4720PS_34_m7 - 1.0f);
    int EID4720PS_1882 = int(EID4720PS_1880 * 8.0f);
    float3 EID4720PS_1884;
    EID4720PS_1884 = lerp(EID4720PS_1767.xxx, EID4720PS_1766, ((EID4720PS_1770 * EID4720PS_1770) + 1.0f).xxx) + (((((EID4720PS_19_m87.xyz * lerp(smoothstep(lerp(0.800000011920928955078125f, 0.20000000298023223876953125f, EID4720PS_19_m88.w), lerp(0.89999997615814208984375f, 0.5f, EID4720PS_19_m88.w), EID4720PS_1814) * EID4720PS_1819, (isnan(EID4720PS_1822) ? EID4720PS_1819 : (isnan(EID4720PS_1819) ? EID4720PS_1822 : max(EID4720PS_1819, EID4720PS_1822))) * EID4720PS_515, clamp((EID4720PS_19_m88.w * 10.0f) - 3.0f, 0.0f, 1.0f))) * EID4720PS_19_m87.w) * (isnan(EID4720PS_1489) ? EID4720PS_1837 : (isnan(EID4720PS_1837) ? EID4720PS_1489 : min(EID4720PS_1837, EID4720PS_1489)))) * (lerp(0.25f.xxx, EID4720PS_1409, EID4720PS_19_m88.z.xxx) * clamp(dot(EID4720PS_1806, EID4720PS_1546), 0.0f, 1.0f))) + (((EID4720PS_19_m93.xyz * (smoothstep(-0.5f, 0.5f, lerp(-1.0f, 1.0f, abs((-smoothstep(isnan(0.0f) ? EID4720PS_1587 : (isnan(EID4720PS_1587) ? 0.0f : max(EID4720PS_1587, 0.0f)), isnan(1.0f) ? EID4720PS_1589 : (isnan(EID4720PS_1589) ? 1.0f : min(EID4720PS_1589, 1.0f)), EID4720PS_1572)) - (EID4720PS_1583 * ceil(EID4720PS_1583))))) * EID4720PS_1623)) * EID4720PS_19_m93.w) * EID4720PS_1409));
    float3 EID4720PS_1885;
    [loop]
    for (int EID4720PS_1887 = 0; EID4720PS_1887 <= 7; EID4720PS_1884 = EID4720PS_1885, EID4720PS_1887++)
    {
        uint EID4720PS_1905 = (captureValid && EID4720PS_1876 <= EID4720PS_1880) ? (EID4720PS_30.Load(uint(EID4720PS_1869 + EID4720PS_1887) * 4 + 0) & EID4720PS_30.Load(uint((EID4720PS_19_m21.y + EID4720PS_1882) + EID4720PS_1887) * 4 + 0)) : 0u;
        uint EID4720PS_1906 = uint(EID4720PS_1887);
        EID4720PS_1885 = EID4720PS_1884;
        uint EID4720PS_1911;
        float3 EID4720PS_1908;
        [loop]
        for (uint EID4720PS_1910 = EID4720PS_1905; EID4720PS_1910 != 0u; EID4720PS_1885 = EID4720PS_1908, EID4720PS_1910 = EID4720PS_1911)
        {
            uint EID4720PS_1915 = firstbitlow(EID4720PS_1910);
            EID4720PS_1911 = EID4720PS_1910 ^ (1u << (EID4720PS_1915 & 31u));
            int EID4720PS_1921 = int((32u * EID4720PS_1906) + EID4720PS_1915) * 8;
            int EID4720PS_1924 = EID4720PS_1921 + 1;
            int EID4720PS_1927 = EID4720PS_1921 + 2;
            int EID4720PS_1930 = EID4720PS_1921 + 3;
            int EID4720PS_1933 = EID4720PS_1921 + 4;
            int EID4720PS_1936 = EID4720PS_1921 + 5;
            int EID4720PS_1939 = EID4720PS_1921 + 6;
            int EID4720PS_1942 = EID4720PS_1921 + 7;
            uint EID4720PS_1946 = uint(EID4720PS_36_m6[EID4720PS_1936].w);
            float EID4720PS_2021;
            if ((EID4720PS_1946 & 1u) == 1u)
            {
                uint EID4720PS_1952 = asuint(EID4720PS_36_m6[EID4720PS_1936].x);
                uint EID4720PS_1959 = asuint(EID4720PS_36_m6[EID4720PS_1936].y);
                uint EID4720PS_1966 = asuint(EID4720PS_36_m6[EID4720PS_1936].z);
                uint EID4720PS_1973 = asuint(EID4720PS_36_m6[EID4720PS_1939].x);
                uint EID4720PS_1980 = asuint(EID4720PS_36_m6[EID4720PS_1939].y);
                uint EID4720PS_1987 = asuint(EID4720PS_36_m6[EID4720PS_1939].z);
                float3 EID4720PS_2006 = abs(mul(float4(EID4720PS_519 - EID4720PS_36_m6[EID4720PS_1924].xyz, 1.0f), float4x4(float4(EID4720PS_spvUnpackHalf2x16(EID4720PS_1952).x, EID4720PS_spvUnpackHalf2x16(EID4720PS_1966).x, EID4720PS_spvUnpackHalf2x16(EID4720PS_1980).x, 0.0f), float4(EID4720PS_spvUnpackHalf2x16(EID4720PS_1952 >> 16u).x, EID4720PS_spvUnpackHalf2x16(EID4720PS_1966 >> 16u).x, EID4720PS_spvUnpackHalf2x16(EID4720PS_1980 >> 16u).x, 0.0f), float4(EID4720PS_spvUnpackHalf2x16(EID4720PS_1959).x, EID4720PS_spvUnpackHalf2x16(EID4720PS_1973).x, EID4720PS_spvUnpackHalf2x16(EID4720PS_1987).x, 0.0f), float4(EID4720PS_spvUnpackHalf2x16(EID4720PS_1959 >> 16u).x, EID4720PS_spvUnpackHalf2x16(EID4720PS_1973 >> 16u).x, EID4720PS_spvUnpackHalf2x16(EID4720PS_1987 >> 16u).x, 0.0f))).xyz);
                float EID4720PS_2007 = EID4720PS_2006.x;
                float EID4720PS_2008 = EID4720PS_2006.y;
                float EID4720PS_2009 = isnan(EID4720PS_2008) ? EID4720PS_2007 : (isnan(EID4720PS_2007) ? EID4720PS_2008 : max(EID4720PS_2007, EID4720PS_2008));
                float EID4720PS_2010 = EID4720PS_2006.z;
                float EID4720PS_2013 = EID4720PS_36_m6[EID4720PS_1942].x * 0.5f;
                float EID4720PS_2019 = 1.0f - clamp(((isnan(EID4720PS_2010) ? EID4720PS_2009 : (isnan(EID4720PS_2009) ? EID4720PS_2010 : max(EID4720PS_2009, EID4720PS_2010))) - (EID4720PS_2013 + 0.5f)) / (0.5f - EID4720PS_2013), 0.0f, 1.0f);
                EID4720PS_2021 = EID4720PS_2019 * EID4720PS_2019;
            }
            else
            {
                EID4720PS_2021 = 1.0f;
            }
            if (false || (EID4720PS_2021 < 0.001000000047497451305389404296875f))
            {
                EID4720PS_1908 = EID4720PS_1885;
                continue;
            }
            float3 EID4720PS_2738;
            if (EID4720PS_36_m6[EID4720PS_1921].w < 1.5f)
            {
                float3 EID4720PS_2737;
                do
                {
                    uint EID4720PS_2034 = asuint(EID4720PS_36_m6[EID4720PS_1930].w);
                    if ((EID4720PS_2034 == 16u) || ((EID4720PS_36_m6[EID4720PS_1930].z + EID4720PS_19_m91.z) < 0.5f))
                    {
                        EID4720PS_2737 = EID4720PS_1885;
                        break;
                    }
                    bool EID4720PS_2046 = (uint(EID4720PS_36_m6[EID4720PS_1921].w) & 1u) == 0u;
                    bool EID4720PS_2050 = (!EID4720PS_2046) && (EID4720PS_36_m6[EID4720PS_1927].z > 0.0f);
                    bool EID4720PS_2051 = EID4720PS_2034 == 4u;
                    float EID4720PS_2052 = float(EID4720PS_2046);
                    float EID4720PS_2060 = (0.5f + (0.5f * EID4720PS_36_m6[EID4720PS_1927].y)) - abs(EID4720PS_36_m6[EID4720PS_1927].x);
                    float EID4720PS_2061 = EID4720PS_36_m6[EID4720PS_1927].y - EID4720PS_2060;
                    float EID4720PS_2065 = (1.0f - abs(EID4720PS_2060)) - abs(EID4720PS_2061);
                    float EID4720PS_2068 = abs(isnan(0.00048828125f) ? EID4720PS_2065 : (isnan(EID4720PS_2065) ? 0.00048828125f : max(EID4720PS_2065, 0.00048828125f)));
                    float3 EID4720PS_2072 = normalize(float3(EID4720PS_2060, EID4720PS_2061, (EID4720PS_36_m6[EID4720PS_1927].x >= 0.0f) ? EID4720PS_2068 : (-EID4720PS_2068)));
                    float EID4720PS_2075 = 2.0f * EID4720PS_36_m6[EID4720PS_1933].y;
                    float EID4720PS_2078 = lerp(EID4720PS_36_m6[EID4720PS_1939].w, isnan(0.100000001490116119384765625f) ? EID4720PS_2075 : (isnan(EID4720PS_2075) ? 0.100000001490116119384765625f : max(EID4720PS_2075, 0.100000001490116119384765625f)), float(EID4720PS_2051));
                    float3 EID4720PS_2083 = EID4720PS_36_m6[EID4720PS_1924].xyz - EID4720PS_519;
                    float3 EID4720PS_2084 = -EID4720PS_2072;
                    float3 EID4720PS_2089 = lerp(EID4720PS_2083, EID4720PS_2084 * dot(EID4720PS_2083, EID4720PS_2084), (float(EID4720PS_2051 && (EID4720PS_36_m6[EID4720PS_1933].z > 0.5f)) * EID4720PS_2052).xxx);
                    float EID4720PS_2090 = dot(EID4720PS_2089, EID4720PS_2089);
                    float EID4720PS_2091 = rsqrt(EID4720PS_2090);
                    float3 EID4720PS_2092 = EID4720PS_2089 * EID4720PS_2091;
                    float3 EID4720PS_2125;
                    float EID4720PS_2126;
                    if (EID4720PS_2050)
                    {
                        float3 EID4720PS_2096 = (EID4720PS_2072 * EID4720PS_36_m6[EID4720PS_1927].z) * 0.5f;
                        float3 EID4720PS_2097 = EID4720PS_2089 - EID4720PS_2096;
                        float3 EID4720PS_2098 = EID4720PS_2089 + EID4720PS_2096;
                        float EID4720PS_2099 = length(EID4720PS_2097);
                        float EID4720PS_2100 = length(EID4720PS_2098);
                        float3 EID4720PS_2109 = normalize(cross(cross(EID4720PS_2072, EID4720PS_2092), EID4720PS_2072));
                        EID4720PS_2125 = EID4720PS_2109;
                        EID4720PS_2126 = ((1.0f / ((((EID4720PS_2099 * EID4720PS_2100) + dot(EID4720PS_2097, EID4720PS_2098)) * 0.5f) + 1.0f)) * clamp(0.5f * ((dot(EID4720PS_2109, EID4720PS_2097) / EID4720PS_2099) + (dot(EID4720PS_2109, EID4720PS_2098) / EID4720PS_2100)), 0.0f, 1.0f)) * (1.0f / clamp(1.0f + (0.5f * clamp(EID4720PS_36_m6[EID4720PS_1927].z * EID4720PS_2091, 0.0f, 1.0f)), 0.0f, 1.0f));
                    }
                    else
                    {
                        EID4720PS_2125 = EID4720PS_2092;
                        EID4720PS_2126 = 1.0f;
                    }
                    float EID4720PS_2148;
                    if (EID4720PS_2078 < 0.0f)
                    {
                        float EID4720PS_2142 = EID4720PS_2090 * (EID4720PS_36_m6[EID4720PS_1924].w * EID4720PS_36_m6[EID4720PS_1924].w);
                        float EID4720PS_2145 = clamp(1.0f - (EID4720PS_2142 * EID4720PS_2142), 0.0f, 1.0f);
                        EID4720PS_2148 = lerp(1.0f / (EID4720PS_2090 + 1.0f), EID4720PS_2126, float(EID4720PS_2050)) * (EID4720PS_2145 * EID4720PS_2145);
                    }
                    else
                    {
                        float3 EID4720PS_2131 = EID4720PS_2089 * EID4720PS_36_m6[EID4720PS_1924].w;
                        EID4720PS_2148 = EID4720PS_2126 * pow(1.0f - clamp(dot(EID4720PS_2131, EID4720PS_2131), 0.0f, 1.0f), EID4720PS_2078);
                    }
                    float EID4720PS_2153 = clamp((dot(EID4720PS_2125, EID4720PS_2084) - EID4720PS_36_m6[EID4720PS_1927].z) * EID4720PS_36_m6[EID4720PS_1927].w, 0.0f, 1.0f);
                    float EID4720PS_2156 = EID4720PS_2148 * lerp(1.0f, EID4720PS_2153 * EID4720PS_2153, EID4720PS_2052);
                    int EID4720PS_2158 = int(EID4720PS_36_m6[EID4720PS_1942].w);
                    float EID4720PS_2262;
                    if ((!EID4720PS_2050) && (EID4720PS_2158 >= 0))
                    {
                        uint EID4720PS_2164 = uint(EID4720PS_2158);
                        float2 EID4720PS_2255;
                        [branch]
                        if (EID4720PS_2052 != 0.0f)
                        {
                            float4 EID4720PS_2245 = mul(EID4720PS_62_m1[EID4720PS_2164], float4(EID4720PS_519.x, EID4720PS_597, EID4720PS_519.z, 1.0f));
                            EID4720PS_2255 = EID4720PS_62_m0[EID4720PS_2164].xy + (clamp(EID4720PS_2245.xy / EID4720PS_2245.w.xx, 0.0f.xx, 1.0f.xx) * EID4720PS_62_m0[EID4720PS_2164].zw);
                        }
                        else
                        {
                            float3 EID4720PS_2179 = mul(float4(-EID4720PS_2089, 0.0f), EID4720PS_62_m1[EID4720PS_2164]).xyz;
                            float3 EID4720PS_376 = EID4720PS_2179;
                            float3 EID4720PS_375 = EID4720PS_2179;
                            float3 EID4720PS_374 = abs(EID4720PS_2179);
                            uint EID4720PS_2188 = uint(int(EID4720PS_374.y > EID4720PS_374.x));
                            uint EID4720PS_2194 = (EID4720PS_374.z > EID4720PS_374[EID4720PS_2188]) ? 2u : EID4720PS_2188;
                            uint EID4720PS_2200 = (EID4720PS_2194 * 2u) + uint(EID4720PS_375[EID4720PS_2194] < 0.0f);
                            float EID4720PS_2204 = abs(EID4720PS_376[EID4720PS_2200 / 2u]);
                            float EID4720PS_2224 = 0.5f - (0.000244140625f / EID4720PS_62_m0[EID4720PS_2164].w);
                            EID4720PS_2255 = EID4720PS_62_m0[EID4720PS_2164].xy + (clamp(float2((float(EID4720PS_2200) + ((((EID4720PS_376[uint(EID4720PS_341[EID4720PS_2200].x)] * EID4720PS_342[EID4720PS_2200].x) / EID4720PS_2204) * EID4720PS_2224) + 0.5f)) * 0.16666667163372039794921875f, 0.5f - (((EID4720PS_376[uint(EID4720PS_341[EID4720PS_2200].y)] * EID4720PS_342[EID4720PS_2200].y) / EID4720PS_2204) * EID4720PS_2224)), 0.0f.xx, 1.0f.xx) * EID4720PS_62_m0[EID4720PS_2164].zw);
                        }
                        EID4720PS_2262 = EID4720PS_2156 * EID4720PS_60.SampleLevel(EID4720_linear_clamp_sampler, EID4720PS_2255, 0.0f).x;
                    }
                    else
                    {
                        EID4720PS_2262 = EID4720PS_2156;
                    }
                    float EID4720PS_2263 = EID4720PS_2262 * EID4720PS_2021;
                    float3 EID4720PS_2736;
                    do
                    {
                        float3 EID4720PS_2735;
                        [branch]
                        if (EID4720PS_2263 > 9.9999997473787516355514526367188e-05f)
                        {
                            [branch]
                            if (EID4720PS_2051)
                            {
                                EID4720PS_2736 = lerp(EID4720PS_1885, EID4720PS_36_m6[EID4720PS_1921].xyz, (EID4720PS_2263 * (EID4720PS_36_m6[EID4720PS_1933].x * ((1.0f - EID4720PS_36_m6[EID4720PS_1933].w) + (smoothstep(-0.5f, 0.5f, dot(EID4720PS_541, EID4720PS_2125)) * EID4720PS_36_m6[EID4720PS_1933].w)))).xxx);
                                break;
                            }
                            float EID4720PS_2283 = dot(EID4720PS_1546, EID4720PS_2125);
                            float EID4720PS_2284 = clamp(EID4720PS_2283, 0.0f, 1.0f);
                            float EID4720PS_2587;
                            if (EID4720PS_2034 != 0u)
                            {
                                bool EID4720PS_2290 = EID4720PS_2046 || ((EID4720PS_1946 & 2u) != 0u);
                                int EID4720PS_2339;
                                if (EID4720PS_2290)
                                {
                                    EID4720PS_2339 = int(EID4720PS_36_m6[EID4720PS_1930].x);
                                }
                                else
                                {
                                    uint EID4720PS_2294 = asuint(EID4720PS_36_m6[EID4720PS_1927].w);
                                    uint EID4720PS_2296 = asuint(EID4720PS_36_m6[EID4720PS_1930].x);
                                    float3 EID4720PS_2297 = EID4720PS_519 - EID4720PS_36_m6[EID4720PS_1924].xyz;
                                    float3 EID4720PS_2298 = abs(EID4720PS_2297);
                                    float EID4720PS_2299 = EID4720PS_2298.x;
                                    float EID4720PS_2300 = EID4720PS_2298.y;
                                    float EID4720PS_2302 = EID4720PS_2298.z;
                                    int EID4720PS_2334;
                                    if ((EID4720PS_2299 > EID4720PS_2300) && (EID4720PS_2299 > EID4720PS_2302))
                                    {
                                        EID4720PS_2334 = int((EID4720PS_2297.x > 0.0f) ? (EID4720PS_2294 >> 24u) : ((EID4720PS_2294 >> 16u) & 255u));
                                    }
                                    else
                                    {
                                        int EID4720PS_2326;
                                        if (EID4720PS_2300 > EID4720PS_2302)
                                        {
                                            EID4720PS_2326 = int((EID4720PS_2297.y > 0.0f) ? ((EID4720PS_2294 >> 8u) & 255u) : (EID4720PS_2294 & 255u));
                                        }
                                        else
                                        {
                                            EID4720PS_2326 = int((EID4720PS_2297.z > 0.0f) ? ((EID4720PS_2296 >> 8u) & 255u) : (EID4720PS_2296 & 255u));
                                        }
                                        EID4720PS_2334 = EID4720PS_2326;
                                    }
                                    EID4720PS_2339 = (EID4720PS_2334 < 80) ? EID4720PS_2334 : (-1);
                                }
                                bool EID4720PS_2340 = EID4720PS_2339 >= 0;
                                float EID4720PS_2586;
                                if (EID4720PS_2340)
                                {
                                    float3 EID4720PS_2347 = EID4720PS_519 - EID4720PS_36_m6[EID4720PS_1924].xyz;
                                    float EID4720PS_2348 = dot(EID4720PS_2347, EID4720PS_2347);
                                    float4 EID4720PS_2367 = mul(EID4720PS_38_m10[EID4720PS_2339], float4((EID4720PS_519 - ((EID4720PS_2347 * rsqrt(isnan(EID4720PS_2348) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? EID4720PS_2348 : max(1.1754943508222875079687365372222e-38f, EID4720PS_2348)))) * EID4720PS_38_m11[EID4720PS_2339].x)) + (EID4720PS_541 * (EID4720PS_38_m11[EID4720PS_2339].y * 5.0f)), 1.0f));
                                    float EID4720PS_2368 = EID4720PS_2367.w;
                                    float3 EID4720PS_2371 = EID4720PS_2367.xyz / EID4720PS_2368.xxx;
                                    float2 EID4720PS_2372 = EID4720PS_2371.xy;
                                    float3 EID4720PS_2380 = EID4720PS_2371.xyz;
                                    bool3 EID4720PS_2381 = bool3(EID4720PS_2380.x <= 0.0f.xxx.x, EID4720PS_2380.y <= 0.0f.xxx.y, EID4720PS_2380.z <= 0.0f.xxx.z);
                                    bool3 EID4720PS_2382 = bool3(EID4720PS_2380.x >= 1.0f.xxx.x, EID4720PS_2380.y >= 1.0f.xxx.y, EID4720PS_2380.z >= 1.0f.xxx.z);
                                    float EID4720PS_2385 = EID4720PS_2371.z;
                                    float2 EID4720PS_2396 = ((EID4720PS_2372 * (EID4720PS_38_m12[EID4720PS_2339].zw - EID4720PS_38_m12[EID4720PS_2339].xy)) + EID4720PS_38_m12[EID4720PS_2339].xy).xy * EID4720PS_38_m13.zw;
                                    float2 EID4720PS_2398 = floor(EID4720PS_2396 + 0.5f.xx);
                                    float2 EID4720PS_2399 = EID4720PS_2396 - EID4720PS_2398;
                                    float EID4720PS_2400 = EID4720PS_2399.x;
                                    float EID4720PS_2401 = EID4720PS_2400 + 0.5f;
                                    float EID4720PS_2402 = EID4720PS_2401 * EID4720PS_2401;
                                    float EID4720PS_2405 = 1.0f - EID4720PS_2400;
                                    float EID4720PS_2406 = isnan(0.0f) ? EID4720PS_2400 : (isnan(EID4720PS_2400) ? 0.0f : min(EID4720PS_2400, 0.0f));
                                    float EID4720PS_2409 = EID4720PS_2400 + 1.0f;
                                    float EID4720PS_2410 = isnan(0.0f) ? EID4720PS_2400 : (isnan(EID4720PS_2400) ? 0.0f : max(EID4720PS_2400, 0.0f));
                                    float EID4720PS_2421 = EID4720PS_2399.y;
                                    float EID4720PS_2422 = EID4720PS_2421 + 0.5f;
                                    float EID4720PS_2423 = EID4720PS_2422 * EID4720PS_2422;
                                    float EID4720PS_2426 = 1.0f - EID4720PS_2421;
                                    float EID4720PS_2427 = isnan(0.0f) ? EID4720PS_2421 : (isnan(EID4720PS_2421) ? 0.0f : min(EID4720PS_2421, 0.0f));
                                    float EID4720PS_2430 = EID4720PS_2421 + 1.0f;
                                    float EID4720PS_2431 = isnan(0.0f) ? EID4720PS_2421 : (isnan(EID4720PS_2421) ? 0.0f : max(EID4720PS_2421, 0.0f));
                                    float3 EID4720PS_2443 = float3(0.1599999964237213134765625f * EID4720PS_2405, 0.1599999964237213134765625f * ((EID4720PS_2409 - (EID4720PS_2410 * EID4720PS_2410)) + 1.0f), EID4720PS_2402 * 0.07999999821186065673828125f);
                                    float3 EID4720PS_2444 = float3(0.1599999964237213134765625f * ((EID4720PS_2402 * 0.5f) - EID4720PS_2400), 0.1599999964237213134765625f * ((EID4720PS_2405 - (EID4720PS_2406 * EID4720PS_2406)) + 1.0f), 0.1599999964237213134765625f * EID4720PS_2409) + EID4720PS_2443;
                                    float3 EID4720PS_2446 = float3(0.1599999964237213134765625f * EID4720PS_2426, 0.1599999964237213134765625f * ((EID4720PS_2430 - (EID4720PS_2431 * EID4720PS_2431)) + 1.0f), EID4720PS_2423 * 0.07999999821186065673828125f);
                                    float3 EID4720PS_2447 = float3(0.1599999964237213134765625f * ((EID4720PS_2423 * 0.5f) - EID4720PS_2421), 0.1599999964237213134765625f * ((EID4720PS_2426 - (EID4720PS_2427 * EID4720PS_2427)) + 1.0f), 0.1599999964237213134765625f * EID4720PS_2430) + EID4720PS_2446;
                                    float3 EID4720PS_2453 = ((EID4720PS_2443 / EID4720PS_2444) + float3(-2.5f, -0.5f, 1.5f)) * EID4720PS_38_m13.xxx;
                                    float3 EID4720PS_2455 = ((EID4720PS_2446 / EID4720PS_2447) + float3(-2.5f, -0.5f, 1.5f)) * EID4720PS_38_m13.yyy;
                                    float2 EID4720PS_2457 = EID4720PS_2398 * EID4720PS_38_m13.xy;
                                    float EID4720PS_2458 = EID4720PS_2453.x;
                                    float EID4720PS_2459 = EID4720PS_2455.x;
                                    float EID4720PS_2462 = EID4720PS_2453.y;
                                    float EID4720PS_2465 = EID4720PS_2453.z;
                                    float EID4720PS_2468 = EID4720PS_2455.y;
                                    float EID4720PS_2475 = EID4720PS_2455.z;
                                    float EID4720PS_2482 = EID4720PS_2444.x;
                                    float EID4720PS_2483 = EID4720PS_2447.x;
                                    float EID4720PS_2485 = EID4720PS_2444.y;
                                    float EID4720PS_2487 = EID4720PS_2444.z;
                                    float EID4720PS_2489 = EID4720PS_2447.y;
                                    float EID4720PS_2493 = EID4720PS_2447.z;
                                    float2 EID4720PS_2571 = 1.0f.xx - EID4720PS_2372;
                                    bool2 EID4720PS_3437 = isnan(EID4720PS_2372);
                                    bool2 EID4720PS_3438 = isnan(EID4720PS_2571);
                                    float2 EID4720PS_3439 = min(EID4720PS_2372, EID4720PS_2571);
                                    float2 EID4720PS_3440 = float2(EID4720PS_3437.x ? EID4720PS_2571.x : EID4720PS_3439.x, EID4720PS_3437.y ? EID4720PS_2571.y : EID4720PS_3439.y);
                                    float2 EID4720PS_2572 = float2(EID4720PS_3438.x ? EID4720PS_2372.x : EID4720PS_3440.x, EID4720PS_3438.y ? EID4720PS_2372.y : EID4720PS_3440.y);
                                    float EID4720PS_2573 = EID4720PS_2572.x;
                                    float EID4720PS_2574 = EID4720PS_2572.y;
                                    float EID4720PS_2575 = isnan(EID4720PS_2574) ? EID4720PS_2573 : (isnan(EID4720PS_2573) ? EID4720PS_2574 : min(EID4720PS_2573, EID4720PS_2574));
                                    float EID4720PS_2579 = (EID4720PS_38_m11[EID4720PS_2339].z - EID4720PS_2368) * 0.25f;
                                    float EID4720PS_2581 = smoothstep(0.0f, 0.0500000007450580596923828125f, isnan(EID4720PS_2575) ? EID4720PS_2579 : (isnan(EID4720PS_2579) ? EID4720PS_2575 : min(EID4720PS_2579, EID4720PS_2575)));
                                    EID4720PS_2586 = EID4720PS_2340 ? lerp(1.0f, (any(bool3(EID4720PS_2381.x || EID4720PS_2382.x, EID4720PS_2381.y || EID4720PS_2382.y, EID4720PS_2381.z || EID4720PS_2382.z)) || ((asuint(EID4720PS_2385) & 2147483647u) > 2139095040u)) ? 1.0f : ((((((((((EID4720PS_2482 * EID4720PS_2483) * EID4720ShadowGreater( float3(EID4720PS_2457 + float2(EID4720PS_2458, EID4720PS_2459), EID4720PS_367).xy, EID4720PS_2385)) + ((EID4720PS_2485 * EID4720PS_2483) * EID4720ShadowGreater( float3(EID4720PS_2457 + float2(EID4720PS_2462, EID4720PS_2459), EID4720PS_367).xy, EID4720PS_2385))) + ((EID4720PS_2487 * EID4720PS_2483) * EID4720ShadowGreater( float3(EID4720PS_2457 + float2(EID4720PS_2465, EID4720PS_2459), EID4720PS_367).xy, EID4720PS_2385))) + ((EID4720PS_2482 * EID4720PS_2489) * EID4720ShadowGreater( float3(EID4720PS_2457 + float2(EID4720PS_2458, EID4720PS_2468), EID4720PS_367).xy, EID4720PS_2385))) + ((EID4720PS_2485 * EID4720PS_2489) * EID4720ShadowGreater( float3(EID4720PS_2457 + float2(EID4720PS_2462, EID4720PS_2468), EID4720PS_367).xy, EID4720PS_2385))) + ((EID4720PS_2487 * EID4720PS_2489) * EID4720ShadowGreater( float3(EID4720PS_2457 + float2(EID4720PS_2465, EID4720PS_2468), EID4720PS_367).xy, EID4720PS_2385))) + ((EID4720PS_2482 * EID4720PS_2493) * EID4720ShadowGreater( float3(EID4720PS_2457 + float2(EID4720PS_2458, EID4720PS_2475), EID4720PS_367).xy, EID4720PS_2385))) + ((EID4720PS_2485 * EID4720PS_2493) * EID4720ShadowGreater( float3(EID4720PS_2457 + float2(EID4720PS_2462, EID4720PS_2475), EID4720PS_367).xy, EID4720PS_2385))) + ((EID4720PS_2487 * EID4720PS_2493) * EID4720ShadowGreater( float3(EID4720PS_2457 + float2(EID4720PS_2465, EID4720PS_2475), EID4720PS_367).xy, EID4720PS_2385))), EID4720PS_2290 ? (isnan(EID4720PS_2581) ? EID4720PS_38_m11[EID4720PS_2339].w : (isnan(EID4720PS_38_m11[EID4720PS_2339].w) ? EID4720PS_2581 : min(EID4720PS_38_m11[EID4720PS_2339].w, EID4720PS_2581))) : EID4720PS_38_m11[EID4720PS_2339].w) : 1.0f;
                                }
                                else
                                {
                                    EID4720PS_2586 = clamp(dot(EID4720PS_526, EID4720PS_2125) + 1.0f, 0.0f, 1.0f);
                                }
                                EID4720PS_2587 = EID4720PS_2586;
                            }
                            else
                            {
                                EID4720PS_2587 = 1.0f;
                            }
                            float EID4720PS_2691;
                            float3 EID4720PS_2692;
                            float EID4720PS_2693;
                            float3 EID4720PS_2694;
                            float3 EID4720PS_2695;
                            float EID4720PS_2696;
                            float EID4720PS_2697;
                            [branch]
                            if (EID4720PS_2034 == 0u)
                            {
                                float3 EID4720PS_2665 = EID4720PS_36_m6[EID4720PS_1921].xyz * EID4720PS_2263;
                                float EID4720PS_2666 = EID4720PS_2665.x;
                                float EID4720PS_2667 = EID4720PS_2665.y;
                                float EID4720PS_2668 = EID4720PS_2665.z;
                                float EID4720PS_2669 = isnan(EID4720PS_2667) ? EID4720PS_2666 : (isnan(EID4720PS_2666) ? EID4720PS_2667 : max(EID4720PS_2666, EID4720PS_2667));
                                float EID4720PS_2671 = (isnan(EID4720PS_2668) ? EID4720PS_2669 : (isnan(EID4720PS_2669) ? EID4720PS_2668 : max(EID4720PS_2669, EID4720PS_2668))) * lerp(0.75f, 0.5f, 1.0f - EID4720PS_1492);
                                float3 EID4720PS_2678 = EID4720PS_1683.xyz;
                                EID4720PS_2691 = EID4720PS_2263;
                                EID4720PS_2692 = (EID4720PS_36_m6[EID4720PS_1921].xyz * ((1.0f - EID4720PS_36_m6[EID4720PS_1933].y) + ((1.0f / (isnan(EID4720PS_2671) ? 1.0f : (isnan(1.0f) ? EID4720PS_2671 : max(1.0f, EID4720PS_2671)))) * EID4720PS_36_m6[EID4720PS_1933].y))) * lerp(0.5f * EID4720PS_36_m6[EID4720PS_1933].x, 1.0f, clamp(dot(normalize(lerp(float3(EID4720PS_526.x, 6.103515625e-05f, EID4720PS_526.z), EID4720PS_1546, EID4720PS_615)), EID4720PS_2125) + 0.5f, 0.0f, 1.0f));
                                EID4720PS_2693 = EID4720PS_2284;
                                EID4720PS_2694 = EID4720PS_2678;
                                EID4720PS_2695 = EID4720PS_2678;
                                EID4720PS_2696 = 1.0f;
                                EID4720PS_2697 = 0.0f;
                            }
                            else
                            {
                                float EID4720PS_2657;
                                float EID4720PS_2658;
                                float3 EID4720PS_2659;
                                float3 EID4720PS_2660;
                                float EID4720PS_2661;
                                float EID4720PS_2662;
                                if (EID4720PS_2034 == 3u)
                                {
                                    float3 EID4720PS_2637 = -normalize(cross(EID4720PS_553, cross(EID4720PS_553, EID4720PS_2125)));
                                    float EID4720PS_2645 = float(dot(EID4720PS_553, EID4720PS_2637) < (-0.00999999977648258209228515625f));
                                    EID4720PS_2657 = EID4720PS_2263 * (lerp(smoothstep(lerp(0.800000011920928955078125f, 0.20000000298023223876953125f, EID4720PS_36_m6[EID4720PS_1933].x), lerp(0.89999997615814208984375f, 0.5f, EID4720PS_36_m6[EID4720PS_1933].x), EID4720PS_1814) * EID4720PS_1819, (isnan(EID4720PS_2645) ? EID4720PS_1819 : (isnan(EID4720PS_1819) ? EID4720PS_2645 : max(EID4720PS_1819, EID4720PS_2645))) * EID4720PS_515, clamp((EID4720PS_36_m6[EID4720PS_1933].x * 10.0f) - 3.0f, 0.0f, 1.0f)) * EID4720PS_2587);
                                    EID4720PS_2658 = clamp(dot(EID4720PS_1546, EID4720PS_2637), 0.0f, 1.0f);
                                    EID4720PS_2659 = lerp(0.5f.xxx, EID4720PS_1409, EID4720PS_36_m6[EID4720PS_1933].y.xxx);
                                    EID4720PS_2660 = 0.0f.xxx;
                                    EID4720PS_2661 = 1.0f;
                                    EID4720PS_2662 = 0.0f;
                                }
                                else
                                {
                                    bool EID4720PS_2596 = EID4720PS_2034 == 1u;
                                    float EID4720PS_2627;
                                    float3 EID4720PS_2628;
                                    float EID4720PS_2629;
                                    float EID4720PS_2630;
                                    if (EID4720PS_2596)
                                    {
                                        float EID4720PS_2621 = smoothstep(0.0f, lerp(0.100000001490116119384765625f, 1.0f, EID4720PS_513), clamp(EID4720PS_2283 + EID4720PS_36_m6[EID4720PS_1933].x, -1.0f, 1.0f) + (EID4720PS_36_m6[EID4720PS_1933].z * EID4720PS_1623)) * EID4720PS_2587;
                                        float EID4720PS_2624 = smoothstep(0.0f, -0.20000000298023223876953125f, EID4720PS_1547 - EID4720PS_36_m6[EID4720PS_1933].w);
                                        EID4720PS_2627 = isnan(EID4720PS_2621) ? EID4720PS_2624 : (isnan(EID4720PS_2624) ? EID4720PS_2621 : max(EID4720PS_2624, EID4720PS_2621));
                                        EID4720PS_2628 = EID4720PS_1413 * EID4720PS_36_m6[EID4720PS_1933].y;
                                        EID4720PS_2629 = 1.0f;
                                        EID4720PS_2630 = 0.0f;
                                    }
                                    else
                                    {
                                        bool EID4720PS_2600 = EID4720PS_2034 == 2u;
                                        float EID4720PS_2612;
                                        if (EID4720PS_2600)
                                        {
                                            EID4720PS_2612 = smoothstep(EID4720PS_36_m6[EID4720PS_1933].x + 0.0500000007450580596923828125f, EID4720PS_36_m6[EID4720PS_1933].x - 0.0500000007450580596923828125f, EID4720PS_1403) * ((1.0f - EID4720PS_36_m6[EID4720PS_1933].z) + (step(0.5f, EID4720PS_1406) * EID4720PS_36_m6[EID4720PS_1933].z));
                                        }
                                        else
                                        {
                                            EID4720PS_2612 = 1.0f;
                                        }
                                        EID4720PS_2627 = EID4720PS_2284;
                                        EID4720PS_2628 = 0.0f.xxx;
                                        EID4720PS_2629 = EID4720PS_2612;
                                        EID4720PS_2630 = EID4720PS_2600 ? EID4720PS_36_m6[EID4720PS_1933].y : 0.0f;
                                    }
                                    bool3 EID4720PS_2631 = EID4720PS_2596.xxx;
                                    EID4720PS_2657 = EID4720PS_2263;
                                    EID4720PS_2658 = EID4720PS_2627;
                                    EID4720PS_2659 = float3(EID4720PS_2631.x ? EID4720PS_1409.x : 0.0f.xxx.x, EID4720PS_2631.y ? EID4720PS_1409.y : 0.0f.xxx.y, EID4720PS_2631.z ? EID4720PS_1409.z : 0.0f.xxx.z);
                                    EID4720PS_2660 = EID4720PS_2628;
                                    EID4720PS_2661 = EID4720PS_2629;
                                    EID4720PS_2662 = EID4720PS_2630;
                                }
                                EID4720PS_2691 = EID4720PS_2657;
                                EID4720PS_2692 = EID4720PS_36_m6[EID4720PS_1921].xyz;
                                EID4720PS_2693 = EID4720PS_2658;
                                EID4720PS_2694 = EID4720PS_2659;
                                EID4720PS_2695 = EID4720PS_2660;
                                EID4720PS_2696 = EID4720PS_2661;
                                EID4720PS_2697 = EID4720PS_2662;
                            }
                            float3 EID4720PS_2725;
                            [branch]
                            if (EID4720PS_2034 != 3u)
                            {
                                float EID4720PS_2702 = lerp(EID4720PS_1415, 0.00999999977648258209228515625f, EID4720PS_2697);
                                float EID4720PS_2705 = dot(EID4720PS_1239, normalize(EID4720PS_2125 + EID4720PS_406));
                                float EID4720PS_2706 = EID4720PS_2702 * EID4720PS_2702;
                                float EID4720PS_2710 = (((EID4720PS_2705 * EID4720PS_2706) - EID4720PS_2705) * EID4720PS_2705) + 1.0f;
                                float EID4720PS_2711 = EID4720PS_2710 * EID4720PS_2710;
                                EID4720PS_2725 = ((EID4720PS_1412 * clamp((((EID4720PS_2706 != EID4720PS_2711) ? (EID4720PS_2706 / EID4720PS_2711) : 1.0f) * (0.5f / ((EID4720PS_1720 + (EID4720PS_2702 * EID4720PS_1722)) + 9.9999997473787516355514526367188e-05f))) - 6.103515625e-05f, 0.0f, 20.0f)) * EID4720PS_2696) * EID4720PS_36_m6[EID4720PS_1942].z;
                            }
                            else
                            {
                                EID4720PS_2725 = 0.0f.xxx;
                            }
                            float3 EID4720PS_2728 = EID4720PS_2692 * EID4720PS_2691;
                            EID4720PS_2735 = EID4720PS_1885 + (((EID4720PS_2728 * lerp(EID4720PS_2695, EID4720PS_2694, EID4720PS_2693.xxx)) * 1.0f) + ((EID4720PS_2728 * EID4720PS_2725) * EID4720PS_2693));
                        }
                        else
                        {
                            EID4720PS_2735 = EID4720PS_1885;
                        }
                        EID4720PS_2736 = EID4720PS_2735;
                        break;
                    } while(false);
                    EID4720PS_2737 = EID4720PS_2736;
                    break;
                } while(false);
                EID4720PS_2738 = EID4720PS_2737;
            }
            else
            {
                EID4720PS_2738 = EID4720PS_1885;
            }
            EID4720PS_1908 = EID4720PS_2738;
        }
    }
    float3 EID4720PS_2779;
    [branch]
    if (EID4720PS_49_m12 > 0.5f)
    {
        EID4720PS_2779 = lerp(lerp(0.5f.xxx, lerp(dot(EID4720PS_1884, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, EID4720PS_1884, EID4720PS_49_m14.xxx), EID4720PS_49_m15.xxx) * EID4720PS_49_m13, EID4720PS_49_m26.xyz, EID4720PS_49_m26.w.xxx) + ((EID4720PS_49_m27.xyz * (smoothstep(1.0f - EID4720PS_49_m16, 1.0f, 1.0f - clamp(EID4720PS_1812, 0.0f, 1.0f)) * EID4720PS_1128)) * EID4720PS_49_m17);
    }
    else
    {
        EID4720PS_2779 = EID4720PS_1884;
    }
    float4 EID4720PS_2787 = float4(EID4720PS_2779 * EID4720PS_19_m20.y, 1.0f);
    EID4720PS_2787.w = 1.0f;
    float4 EID4720PS_3170;
    [branch]
    if (EID4720PS_19_m91.w < 0.5f)
    {
        float3 EID4720PS_2791 = -EID4720PS_406;
        float EID4720PS_2802 = (EID4720PS_407 * EID4720PS_19_m44.w) - EID4720PS_19_m43.w;
        float EID4720PS_2807 = EID4720PS_597 * EID4720PS_19_m46.w;
        float EID4720PS_2811 = EID4720PS_2807 + EID4720PS_19_m47.w;
        float EID4720PS_2812 = isnan(EID4720PS_2811) ? 0.00999999977648258209228515625f : (isnan(0.00999999977648258209228515625f) ? EID4720PS_2811 : max(0.00999999977648258209228515625f, EID4720PS_2811));
        float3 EID4720PS_2826 = exp(EID4720PS_19_m45.xyz * ((-(isnan(EID4720PS_2802) ? 0.0f : (isnan(0.0f) ? EID4720PS_2802 : max(0.0f, EID4720PS_2802)))) * (((1.0f - exp(-EID4720PS_2812)) / EID4720PS_2812) * exp(EID4720PS_2807 + EID4720PS_19_m48.w))));
        float EID4720PS_2829 = dot(EID4720PS_2791, EID4720PS_19_m44.xyz);
        float EID4720PS_2835 = EID4720PS_19_m45.w * EID4720PS_19_m45.w;
        float EID4720PS_2839 = (1.0f + EID4720PS_2835) - ((2.0f * EID4720PS_19_m45.w) * EID4720PS_2829);
        float EID4720PS_2843 = (12.56637096405029296875f * EID4720PS_2839) * sqrt(EID4720PS_2839);
        float3 EID4720PS_3162;
        float EID4720PS_3163;
        if (EID4720PS_19_m55.z > 0.0f)
        {
            uint3 EID4720PS_2990 = (uint3(int3(EID4720PS_1479, EID4720PS_1480, int(EID4720PS_19_m19 & 7u))) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint EID4720PS_2991 = EID4720PS_2990.y;
            uint EID4720PS_2992 = EID4720PS_2990.z;
            uint EID4720PS_2995 = EID4720PS_2990.x + (EID4720PS_2991 * EID4720PS_2992);
            uint EID4720PS_2997 = EID4720PS_2991 + (EID4720PS_2992 * EID4720PS_2995);
            uint EID4720PS_2999 = EID4720PS_2992 + (EID4720PS_2995 * EID4720PS_2997);
            uint EID4720PS_3001 = EID4720PS_2995 + (EID4720PS_2997 * EID4720PS_2999);
            float EID4720PS_3026 = dot(EID4720PS_2791, -EID4720PS_17_m0[2].xyz);
            float3 EID4720PS_3033 = EID4720PS_519 - EID4720PS_17_m11.xyz;
            float EID4720PS_3035 = (EID4720PS_19_m55.w * ((EID4720PS_3026 > 5.9604644775390625e-08f) ? (1.0f / EID4720PS_3026) : 0.0f)) * (1.0f / EID4720PS_407);
            float EID4720PS_3036 = EID4720PS_3033.y;
            float EID4720PS_3037 = EID4720PS_3035 * EID4720PS_3036;
            float EID4720PS_3039 = EID4720PS_17_m11.y + EID4720PS_3037;
            float EID4720PS_3040 = EID4720PS_3036 - EID4720PS_3037;
            float EID4720PS_3042 = (1.0f - EID4720PS_3035) * EID4720PS_407;
            float EID4720PS_3048 = EID4720PS_19_m49.z * (EID4720PS_3039 - EID4720PS_19_m49.x);
            float EID4720PS_3055 = EID4720PS_19_m49.z * EID4720PS_3040;
            float EID4720PS_3056 = isnan(EID4720PS_3055) ? (-127.0f) : (isnan(-127.0f) ? EID4720PS_3055 : max(-127.0f, EID4720PS_3055));
            float EID4720PS_3072 = EID4720PS_19_m52.x * (EID4720PS_3039 - EID4720PS_19_m52.z);
            float EID4720PS_3079 = EID4720PS_19_m52.x * EID4720PS_3040;
            float EID4720PS_3080 = isnan(EID4720PS_3079) ? (-127.0f) : (isnan(-127.0f) ? EID4720PS_3079 : max(-127.0f, EID4720PS_3079));
            float EID4720PS_3091 = ((EID4720PS_19_m49.y * exp2(-(isnan(EID4720PS_3048) ? (-127.0f) : (isnan(-127.0f) ? EID4720PS_3048 : max(-127.0f, EID4720PS_3048))))) * ((abs(EID4720PS_3056) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-EID4720PS_3056)) / EID4720PS_3056) : (0.693147182464599609375f - (0.2402265071868896484375f * EID4720PS_3056)))) + ((EID4720PS_19_m52.y * exp2(-(isnan(EID4720PS_3072) ? (-127.0f) : (isnan(-127.0f) ? EID4720PS_3072 : max(-127.0f, EID4720PS_3072))))) * ((abs(EID4720PS_3080) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-EID4720PS_3080)) / EID4720PS_3080) : (0.693147182464599609375f - (0.2402265071868896484375f * EID4720PS_3080))));
            float EID4720PS_3095 = clamp(exp2(-(EID4720PS_3091 * EID4720PS_3042)), 0.0f, 1.0f);
            float EID4720PS_3113 = clamp((EID4720PS_407 * EID4720PS_19_m50.w) + EID4720PS_19_m50.z, 0.0f, 1.0f);
            float EID4720PS_3116 = clamp(((isnan(EID4720PS_19_m51.w) ? EID4720PS_3095 : (isnan(EID4720PS_3095) ? EID4720PS_19_m51.w : max(EID4720PS_3095, EID4720PS_19_m51.w))) + clamp((EID4720PS_407 * EID4720PS_19_m50.y) + EID4720PS_19_m50.x, 0.0f, 1.0f)) + EID4720PS_3113, 0.0f, 1.0f);
            float EID4720PS_3135 = EID4720PS_3042 - EID4720PS_19_m53.w;
            float4 EID4720PS_3156 = lerp(float4(0.0f, 0.0f, 0.0f, 1.0f), EID4720PS_65.SampleLevel(EID4720_linear_clamp_sampler, float3((EID4720PS_1859 + ((((float3(uint3(EID4720PS_3001, EID4720PS_2997 + (EID4720PS_2999 * EID4720PS_3001), EID4720PS_372) >> uint3(16u, 16u, 16u)) * 1.525902189314365386962890625e-05f.xxx) * 2.0f) - 1.0f.xxx) * EID4720PS_19_m59.w).xy) * EID4720PS_19_m57.xy, (log2((EID4720PS_387 * EID4720PS_19_m56.x) + EID4720PS_19_m56.y) * EID4720PS_19_m56.z) / EID4720PS_19_m55.z), 0.0f), (captureValid ? clamp((EID4720PS_387 - EID4720PS_19_m58.z) * 1000000.0f, 0.0f, 1.0f) : 0.0f).xxxx);
            float EID4720PS_3158 = EID4720PS_3156.w;
            EID4720PS_3162 = EID4720PS_3156.xyz + (((EID4720PS_19_m51.xyz * (1.0f - EID4720PS_3116)) + (((EID4720PS_19_m54.xyz * pow(clamp(dot(EID4720PS_406, EID4720PS_19_m53.xyz), 0.0f, 1.0f), EID4720PS_19_m54.w)) * (1.0f - clamp(exp2(-(EID4720PS_3091 * (isnan(0.0f) ? EID4720PS_3135 : (isnan(EID4720PS_3135) ? 0.0f : max(EID4720PS_3135, 0.0f))))), 0.0f, 1.0f))) * (1.0f - EID4720PS_3113))) * EID4720PS_3158);
            EID4720PS_3163 = EID4720PS_3158 * EID4720PS_3116;
        }
        else
        {
            float3 EID4720PS_2866 = EID4720PS_519 - EID4720PS_17_m11.xyz;
            float EID4720PS_2868 = EID4720PS_2866.y;
            float EID4720PS_2874 = EID4720PS_19_m49.z * (EID4720PS_17_m11.y - EID4720PS_19_m49.x);
            float EID4720PS_2881 = EID4720PS_19_m49.z * EID4720PS_2868;
            float EID4720PS_2882 = isnan(EID4720PS_2881) ? (-127.0f) : (isnan(-127.0f) ? EID4720PS_2881 : max(-127.0f, EID4720PS_2881));
            float EID4720PS_2898 = EID4720PS_19_m52.x * (EID4720PS_17_m11.y - EID4720PS_19_m52.z);
            float EID4720PS_2905 = EID4720PS_19_m52.x * EID4720PS_2868;
            float EID4720PS_2906 = isnan(EID4720PS_2905) ? (-127.0f) : (isnan(-127.0f) ? EID4720PS_2905 : max(-127.0f, EID4720PS_2905));
            float EID4720PS_2917 = ((EID4720PS_19_m49.y * exp2(-(isnan(EID4720PS_2874) ? (-127.0f) : (isnan(-127.0f) ? EID4720PS_2874 : max(-127.0f, EID4720PS_2874))))) * ((abs(EID4720PS_2882) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-EID4720PS_2882)) / EID4720PS_2882) : (0.693147182464599609375f - (0.2402265071868896484375f * EID4720PS_2882)))) + ((EID4720PS_19_m52.y * exp2(-(isnan(EID4720PS_2898) ? (-127.0f) : (isnan(-127.0f) ? EID4720PS_2898 : max(-127.0f, EID4720PS_2898))))) * ((abs(EID4720PS_2906) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-EID4720PS_2906)) / EID4720PS_2906) : (0.693147182464599609375f - (0.2402265071868896484375f * EID4720PS_2906))));
            float EID4720PS_2921 = clamp(exp2(-(EID4720PS_2917 * EID4720PS_407)), 0.0f, 1.0f);
            float EID4720PS_2939 = clamp((EID4720PS_407 * EID4720PS_19_m50.w) + EID4720PS_19_m50.z, 0.0f, 1.0f);
            float EID4720PS_2942 = clamp(((isnan(EID4720PS_19_m51.w) ? EID4720PS_2921 : (isnan(EID4720PS_2921) ? EID4720PS_19_m51.w : max(EID4720PS_2921, EID4720PS_19_m51.w))) + clamp((EID4720PS_407 * EID4720PS_19_m50.y) + EID4720PS_19_m50.x, 0.0f, 1.0f)) + EID4720PS_2939, 0.0f, 1.0f);
            float EID4720PS_2961 = EID4720PS_407 - EID4720PS_19_m53.w;
            EID4720PS_3162 = (EID4720PS_19_m51.xyz * (1.0f - EID4720PS_2942)) + (((EID4720PS_19_m54.xyz * pow(clamp(dot(EID4720PS_406, EID4720PS_19_m53.xyz), 0.0f, 1.0f), EID4720PS_19_m54.w)) * (1.0f - clamp(exp2(-(EID4720PS_2917 * (isnan(0.0f) ? EID4720PS_2961 : (isnan(EID4720PS_2961) ? 0.0f : max(EID4720PS_2961, 0.0f))))), 0.0f, 1.0f))) * (1.0f - EID4720PS_2939));
            EID4720PS_3163 = EID4720PS_2942;
        }
        float3 EID4720PS_3168 = (EID4720PS_2787.xyz * (EID4720PS_2826 * EID4720PS_3163)) + ((((clamp(((EID4720PS_19_m46.xyz * (0.0596831031143665313720703125f * (1.0f + (EID4720PS_2829 * EID4720PS_2829)))) + EID4720PS_19_m48.xyz) + (EID4720PS_19_m47.xyz * ((1.0f - EID4720PS_2835) / (isnan(0.001000000047497451305389404296875f) ? EID4720PS_2843 : (isnan(EID4720PS_2843) ? 0.001000000047497451305389404296875f : max(EID4720PS_2843, 0.001000000047497451305389404296875f))))), 0.0f.xxx, 1.0f.xxx) * 255.0f) * (1.0f.xxx - EID4720PS_2826)) * EID4720PS_3163) + EID4720PS_3162);
        EID4720PS_3170 = float4(EID4720PS_3168.x, EID4720PS_3168.y, EID4720PS_3168.z, EID4720PS_2787.w);
    }
    else
    {
        EID4720PS_3170 = EID4720PS_2787;
    }
    EID4720PS_14 = EID4720PS_3170;
    EID4720PS_15 = EID4720PS_1446;
}

EID4720PS_SPIRV_Cross_Output EID4720PS_main(EID4720PS_SPIRV_Cross_Input stage_input)
{
    EID4720PS_gl_FragCoord = stage_input.EID4720PS_gl_FragCoord;
    EID4720PS_gl_FragCoord.w = 1.0 / EID4720PS_gl_FragCoord.w;
    EID4720PS_gl_FrontFacing = stage_input.EID4720PS_gl_FrontFacing;
    EID4720PS_3 = stage_input.EID4720PS_3;
    EID4720PS_4 = stage_input.EID4720PS_4;
    EID4720PS_5 = stage_input.EID4720PS_5;
    EID4720PS_6 = stage_input.EID4720PS_6;
    EID4720PS_7 = stage_input.EID4720PS_7;
    EID4720PS_8 = stage_input.EID4720PS_8;
    EID4720PS_9 = stage_input.EID4720PS_9;
    EID4720PS_10 = stage_input.EID4720PS_10;
    EID4720PS_12 = stage_input.EID4720PS_12;
    EID4720PS_frag_main();
    EID4720PS_SPIRV_Cross_Output stage_output;
    stage_output.EID4720PS_14 = EID4720PS_14;
    stage_output.EID4720PS_15 = EID4720PS_15;
    return stage_output;
}
