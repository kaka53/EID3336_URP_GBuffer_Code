Texture2D<float4> _EID4789CapturedScreen40;
float _EID4789UseCapturedScreen40;
// Verified F:/endfield06.rdc EID4789, original SPIR-V algorithm, independent resources.
struct EID4789PS_21
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

static float EID4789PS_424;
static float3 EID4789PS_425;
static float EID4789PS_428;
static uint EID4789PS_429;

static const int2 EID4789PS_378[6] = { int2(2, 1), int2(2, 1), int2(0, 2), int2(0, 2), int2(0, 1), int2(0, 1) };
static const float2 EID4789PS_379[6] = { float2(-1.0f, 1.0f), 1.0f.xx, float2(1.0f, -1.0f), 1.0f.xx, 1.0f.xx, float2(-1.0f, 1.0f) };

cbuffer EID4789PS_16_17
{
    column_major float4x4 EID4789PS_17_m0 : packoffset(c0);
    column_major float4x4 EID4789PS_17_m1 : packoffset(c4);
    column_major float4x4 EID4789PS_17_m2 : packoffset(c8);
    column_major float4x4 EID4789PS_17_m3 : packoffset(c12);
    column_major float4x4 EID4789PS_17_m4 : packoffset(c16);
    column_major float4x4 EID4789PS_17_m5 : packoffset(c20);
    column_major float4x4 EID4789PS_17_m6 : packoffset(c24);
    column_major float4x4 EID4789PS_17_m7 : packoffset(c28);
    column_major float4x4 EID4789PS_17_m8 : packoffset(c32);
    column_major float4x4 EID4789PS_17_m9 : packoffset(c36);
    column_major float4x4 EID4789PS_17_m10 : packoffset(c40);
    float4 EID4789PS_17_m11 : packoffset(c44);
    column_major float4x4 EID4789PS_17_m12 : packoffset(c45);
    column_major float4x4 EID4789PS_17_m13 : packoffset(c49);
    column_major float4x4 EID4789PS_17_m14 : packoffset(c53);
    column_major float4x4 EID4789PS_17_m15 : packoffset(c57);
    column_major float4x4 EID4789PS_17_m16 : packoffset(c61);
    column_major float4x4 EID4789PS_17_m17 : packoffset(c65);
    column_major float4x4 EID4789PS_17_m18 : packoffset(c69);
    column_major float4x4 EID4789PS_17_m19 : packoffset(c73);
    column_major float4x4 EID4789PS_17_m20 : packoffset(c77);
    float4 EID4789PS_17_m21 : packoffset(c81);
};

cbuffer EID4789PS_18_19
{
    float4 EID4789PS_19_m0 : packoffset(c0);
    float4 EID4789PS_19_m1 : packoffset(c1);
    float4 EID4789PS_19_m2 : packoffset(c2);
    float4 EID4789PS_19_m3 : packoffset(c3);
    float4 EID4789PS_19_m4 : packoffset(c4);
    float4 EID4789PS_19_m5 : packoffset(c5);
    float4 EID4789PS_19_m6[6] : packoffset(c6);
    float4 EID4789PS_19_m7[6] : packoffset(c12);
    float4 EID4789PS_19_m8 : packoffset(c18);
    float4 EID4789PS_19_m9 : packoffset(c19);
    float4 EID4789PS_19_m10 : packoffset(c20);
    float4 EID4789PS_19_m11 : packoffset(c21);
    float4 EID4789PS_19_m12 : packoffset(c22);
    float4 EID4789PS_19_m13 : packoffset(c23);
    float4 EID4789PS_19_m14 : packoffset(c24);
    float4 EID4789PS_19_m15 : packoffset(c25);
    float EID4789PS_19_m16 : packoffset(c26);
    float EID4789PS_19_m17 : packoffset(c26.y);
    float EID4789PS_19_m18 : packoffset(c26.z);
    uint EID4789PS_19_m19 : packoffset(c26.w);
    float4 EID4789PS_19_m20 : packoffset(c27);
    int4 EID4789PS_19_m21 : packoffset(c28);
    float4 EID4789PS_19_m22 : packoffset(c29);
    float4 EID4789PS_19_m23 : packoffset(c30);
    float4 EID4789PS_19_m24 : packoffset(c31);
    float4 EID4789PS_19_m25 : packoffset(c32);
    float4 EID4789PS_19_m26 : packoffset(c33);
    float4 EID4789PS_19_m27 : packoffset(c34);
    float4 EID4789PS_19_m28 : packoffset(c35);
    float4 EID4789PS_19_m29 : packoffset(c36);
    float4 EID4789PS_19_m30 : packoffset(c37);
    float4 EID4789PS_19_m31 : packoffset(c38);
    float4 EID4789PS_19_m32[4] : packoffset(c39);
    float4 EID4789PS_19_m33[4] : packoffset(c43);
    float4 EID4789PS_19_m34[4] : packoffset(c47);
    float4 EID4789PS_19_m35[4] : packoffset(c51);
    float4 EID4789PS_19_m36 : packoffset(c55);
    float4 EID4789PS_19_m37 : packoffset(c56);
    float4 EID4789PS_19_m38[4] : packoffset(c57);
    float4 EID4789PS_19_m39[4] : packoffset(c61);
    float4 EID4789PS_19_m40[4] : packoffset(c65);
    float4 EID4789PS_19_m41 : packoffset(c69);
    float4 EID4789PS_19_m42 : packoffset(c70);
    float4 EID4789PS_19_m43 : packoffset(c71);
    float4 EID4789PS_19_m44 : packoffset(c72);
    float4 EID4789PS_19_m45 : packoffset(c73);
    float4 EID4789PS_19_m46 : packoffset(c74);
    float4 EID4789PS_19_m47 : packoffset(c75);
    float4 EID4789PS_19_m48 : packoffset(c76);
    float4 EID4789PS_19_m49 : packoffset(c77);
    float4 EID4789PS_19_m50 : packoffset(c78);
    float4 EID4789PS_19_m51 : packoffset(c79);
    float4 EID4789PS_19_m52 : packoffset(c80);
    float4 EID4789PS_19_m53 : packoffset(c81);
    float4 EID4789PS_19_m54 : packoffset(c82);
    float4 EID4789PS_19_m55 : packoffset(c83);
    float4 EID4789PS_19_m56 : packoffset(c84);
    float4 EID4789PS_19_m57 : packoffset(c85);
    float4 EID4789PS_19_m58 : packoffset(c86);
    float4 EID4789PS_19_m59 : packoffset(c87);
    float4 EID4789PS_19_m60 : packoffset(c88);
    float4 EID4789PS_19_m61 : packoffset(c89);
    float4 EID4789PS_19_m62 : packoffset(c90);
    float4 EID4789PS_19_m63 : packoffset(c91);
    float4 EID4789PS_19_m64 : packoffset(c92);
    float4 EID4789PS_19_m65 : packoffset(c93);
    float4 EID4789PS_19_m66 : packoffset(c94);
    float4 EID4789PS_19_m67 : packoffset(c95);
    float4 EID4789PS_19_m68 : packoffset(c96);
    float4 EID4789PS_19_m69 : packoffset(c97);
    float4 EID4789PS_19_m70 : packoffset(c98);
    float4 EID4789PS_19_m71 : packoffset(c99);
    float4 EID4789PS_19_m72 : packoffset(c100);
    float4 EID4789PS_19_m73 : packoffset(c101);
    float4 EID4789PS_19_m74 : packoffset(c102);
    float4 EID4789PS_19_m75 : packoffset(c103);
    float4 EID4789PS_19_m76 : packoffset(c104);
    float4 EID4789PS_19_m77 : packoffset(c105);
    float4 EID4789PS_19_m78 : packoffset(c106);
    float4 EID4789PS_19_m79 : packoffset(c107);
    float4 EID4789PS_19_m80 : packoffset(c108);
    float4 EID4789PS_19_m81 : packoffset(c109);
    float4 EID4789PS_19_m82 : packoffset(c110);
    float4 EID4789PS_19_m83 : packoffset(c111);
    float4 EID4789PS_19_m84 : packoffset(c112);
    float4 EID4789PS_19_m85 : packoffset(c113);
    float4 EID4789PS_19_m86 : packoffset(c114);
    float4 EID4789PS_19_m87 : packoffset(c115);
    float4 EID4789PS_19_m88 : packoffset(c116);
    float4 EID4789PS_19_m89 : packoffset(c117);
    float4 EID4789PS_19_m90 : packoffset(c118);
    float4 EID4789PS_19_m91 : packoffset(c119);
    float4 EID4789PS_19_m92 : packoffset(c120);
    float4 EID4789PS_19_m93 : packoffset(c121);
    float4 EID4789PS_19_m94 : packoffset(c122);
    float4 EID4789PS_19_m95 : packoffset(c123);
    float4 EID4789PS_19_m96 : packoffset(c124);
    float4 EID4789PS_19_m97 : packoffset(c125);
    float4 EID4789PS_19_m98 : packoffset(c126);
    float4 EID4789PS_19_m99[2] : packoffset(c127);
    float4 EID4789PS_19_m100[2] : packoffset(c129);
    float EID4789PS_19_m101 : packoffset(c131);
    float EID4789PS_19_m102 : packoffset(c131.y);
    float EID4789PS_19_m103 : packoffset(c131.z);
    float EID4789PS_19_m104 : packoffset(c131.w);
    float4 EID4789PS_19_m105 : packoffset(c132);
    float4 EID4789PS_19_m106 : packoffset(c133);
    float4 EID4789PS_19_m107 : packoffset(c134);
    float4 EID4789PS_19_m108 : packoffset(c135);
    float4 EID4789PS_19_m109 : packoffset(c136);
    float4 EID4789PS_19_m110 : packoffset(c137);
    float4 EID4789PS_19_m111 : packoffset(c138);
    float4 EID4789PS_19_m112 : packoffset(c139);
    float4 EID4789PS_19_m113 : packoffset(c140);
    float4 EID4789PS_19_m114 : packoffset(c141);
    float4 EID4789PS_19_m115 : packoffset(c142);
    float4 EID4789PS_19_m116 : packoffset(c143);
    float4 EID4789PS_19_m117 : packoffset(c144);
    float4 EID4789PS_19_m118 : packoffset(c145);
    float4 EID4789PS_19_m119 : packoffset(c146);
    float4 EID4789PS_19_m120 : packoffset(c147);
    float4 EID4789PS_19_m121 : packoffset(c148);
    float4 EID4789PS_19_m122 : packoffset(c149);
    float4 EID4789PS_19_m123 : packoffset(c150);
    float4 EID4789PS_19_m124 : packoffset(c151);
    float4 EID4789PS_19_m125 : packoffset(c152);
    float4 EID4789PS_19_m126 : packoffset(c153);
    float4 EID4789PS_19_m127 : packoffset(c154);
    float4 EID4789PS_19_m128 : packoffset(c155);
    float4 EID4789PS_19_m129 : packoffset(c156);
    float4 EID4789PS_19_m130 : packoffset(c157);
    float4 EID4789PS_19_m131 : packoffset(c158);
    float4 EID4789PS_19_m132 : packoffset(c159);
    float4 EID4789PS_19_m133 : packoffset(c160);
    float4 EID4789PS_19_m134 : packoffset(c161);
    column_major float4x4 EID4789PS_19_m135 : packoffset(c162);
    float4 EID4789PS_19_m136 : packoffset(c166);
    float4 EID4789PS_19_m137 : packoffset(c167);
    float4 EID4789PS_19_m138[32] : packoffset(c168);
};

cbuffer EID4789PS_20_22
{
    float4 EID4789PS_instanceRaw[4096] : packoffset(c0);
};

ByteAddressBuffer EID4789PS_30;
ByteAddressBuffer EID4789PS_32;
cbuffer EID4789PS_33_34
{
    int EID4789PS_34_m0 : packoffset(c0);
    int EID4789PS_34_m1 : packoffset(c0.y);
    int EID4789PS_34_m2 : packoffset(c0.z);
    int EID4789PS_34_m3 : packoffset(c0.w);
    float EID4789PS_34_m4 : packoffset(c1);
    float EID4789PS_34_m5 : packoffset(c1.y);
    float EID4789PS_34_m6 : packoffset(c1.z);
    float EID4789PS_34_m7 : packoffset(c1.w);
    float EID4789PS_34_m8 : packoffset(c2);
    float EID4789PS_34_m9 : packoffset(c2.y);
    float EID4789PS_34_m10 : packoffset(c2.z);
    float EID4789PS_34_m11 : packoffset(c2.w);
};

cbuffer EID4789PS_35_36
{
    float4 EID4789PS_36_m0 : packoffset(c0);
    float4 EID4789PS_36_m1 : packoffset(c1);
    float4 EID4789PS_36_m2 : packoffset(c2);
    float4 EID4789PS_36_m3 : packoffset(c3);
    float4 EID4789PS_36_m4 : packoffset(c4);
    uint4 EID4789PS_36_m5 : packoffset(c5);
    float4 EID4789PS_36_m6[2048] : packoffset(c6);
};

cbuffer EID4789PS_37_38
{
    column_major float4x4 EID4789PS_38_m0[5] : packoffset(c0);
    float4 EID4789PS_38_m1[4] : packoffset(c20);
    float4 EID4789PS_38_m2[4] : packoffset(c24);
    float4 EID4789PS_38_m3[4] : packoffset(c28);
    float4 EID4789PS_38_m4 : packoffset(c32);
    float4 EID4789PS_38_m5 : packoffset(c33);
    float4 EID4789PS_38_m6 : packoffset(c34);
    float4 EID4789PS_38_m7 : packoffset(c35);
    float4 EID4789PS_38_m8 : packoffset(c36);
    float4 EID4789PS_38_m9[27] : packoffset(c37);
    column_major float4x4 EID4789PS_38_m10[56] : packoffset(c64);
    float4 EID4789PS_38_m11[56] : packoffset(c288);
    float4 EID4789PS_38_m12[56] : packoffset(c344);
    float4 EID4789PS_38_m13 : packoffset(c400);
    float4 EID4789PS_38_m14[47] : packoffset(c401);
    column_major float4x4 EID4789PS_38_m15[15] : packoffset(c448);
    float4 EID4789PS_38_m16[15] : packoffset(c508);
    float4 EID4789PS_38_m17[15] : packoffset(c523);
    float4 EID4789PS_38_m18[15] : packoffset(c538);
    float4 EID4789PS_38_m19 : packoffset(c553);
    float4 EID4789PS_38_m20 : packoffset(c554);
    float4 EID4789PS_38_m21[21] : packoffset(c555);
    column_major float4x4 EID4789PS_38_m22 : packoffset(c576);
    column_major float4x4 EID4789PS_38_m23 : packoffset(c580);
    float4 EID4789PS_38_m24 : packoffset(c584);
    float4 EID4789PS_38_m25 : packoffset(c585);
    float4 EID4789PS_38_m26 : packoffset(c586);
    float4 EID4789PS_38_m27[128] : packoffset(c587);
};

cbuffer EID4789PS_48_49
{
    float EID4789PS_49_m0 : packoffset(c0);
    float EID4789PS_49_m1 : packoffset(c0.y);
    float EID4789PS_49_m2 : packoffset(c0.z);
    float EID4789PS_49_m3 : packoffset(c0.w);
    float EID4789PS_49_m4 : packoffset(c1);
    float EID4789PS_49_m5 : packoffset(c1.y);
    float EID4789PS_49_m6 : packoffset(c1.z);
    float EID4789PS_49_m7 : packoffset(c1.w);
    float EID4789PS_49_m8 : packoffset(c2);
    float EID4789PS_49_m9 : packoffset(c2.y);
    float EID4789PS_49_m10 : packoffset(c2.z);
    float EID4789PS_49_m11 : packoffset(c2.w);
    float EID4789PS_49_m12 : packoffset(c3);
    float EID4789PS_49_m13 : packoffset(c3.y);
    float EID4789PS_49_m14 : packoffset(c3.z);
    float EID4789PS_49_m15 : packoffset(c3.w);
    float EID4789PS_49_m16 : packoffset(c4);
    float EID4789PS_49_m17 : packoffset(c4.y);
    float EID4789PS_49_m18 : packoffset(c4.z);
    float EID4789PS_49_m19 : packoffset(c4.w);
    float EID4789PS_49_m20 : packoffset(c5);
    float EID4789PS_49_m21 : packoffset(c5.y);
    float EID4789PS_49_m22 : packoffset(c5.z);
    float EID4789PS_49_m23 : packoffset(c5.w);
    float4 EID4789PS_49_m24 : packoffset(c6);
    float4 EID4789PS_49_m25 : packoffset(c7);
    float4 EID4789PS_49_m26 : packoffset(c8);
    float4 EID4789PS_49_m27 : packoffset(c9);
    float4 EID4789PS_49_m28 : packoffset(c10);
    float4 EID4789PS_49_m29 : packoffset(c11);
    float EID4789PS_49_m30 : packoffset(c12);
    float EID4789PS_49_m31 : packoffset(c12.y);
    float EID4789PS_49_m32 : packoffset(c12.z);
    float EID4789PS_49_m33 : packoffset(c12.w);
    float4 EID4789PS_49_m34 : packoffset(c13);
    float4 EID4789PS_49_m35 : packoffset(c14);
    float4 EID4789PS_49_m36 : packoffset(c15);
    float4 EID4789PS_49_m37 : packoffset(c16);
    float4 EID4789PS_49_m38 : packoffset(c17);
    float4 EID4789PS_49_m39 : packoffset(c18);
    float EID4789PS_49_m40 : packoffset(c19);
    float EID4789PS_49_m41 : packoffset(c19.y);
    float EID4789PS_49_m42 : packoffset(c19.z);
    float EID4789PS_49_m43 : packoffset(c19.w);
    float EID4789PS_49_m44 : packoffset(c20);
    float EID4789PS_49_m45 : packoffset(c20.y);
    float EID4789PS_49_m46 : packoffset(c20.z);
    float EID4789PS_49_m47 : packoffset(c20.w);
};

cbuffer EID4789PS_64_65
{
    float4 EID4789PS_65_m0[32] : packoffset(c0);
    column_major float4x4 EID4789PS_65_m1[32] : packoffset(c32);
};

SamplerState EID4789_point_repeat_sampler;
SamplerState EID4789_linear_clamp_sampler;
SamplerState EID4789_linear_repeat_sampler;


Texture2D<float4> EID4789PS_39;
Texture2D<float4> EID4789PS_40;
Texture3D<float4> EID4789PS_42;
Texture3D<float4> EID4789PS_43;
Texture3D<float4> EID4789PS_44;
Texture3D<float4> EID4789PS_45;
Texture3D<float4> EID4789PS_46;
Texture3D<float4> EID4789PS_47;
Texture2D<float4> EID4789PS_50;
Texture2D<float4> EID4789PS_51;
Texture2D<float4> EID4789PS_52;
Texture2D<float4> EID4789PS_53;
Texture2D<float4> EID4789PS_54;
Texture2D<float4> EID4789PS_55;
Texture2D<float4> EID4789PS_56;
Texture2D<float4> EID4789PS_57;
Texture2D<float4> EID4789PS_58;
Texture2D<float4> EID4789PS_59;
Texture2D<float4> EID4789PS_60;
TextureCube<float4> EID4789PS_62;
Texture2D<float4> EID4789PS_63;
Texture3D<float4> EID4789PS_68;

static float4 EID4789PS_gl_FragCoord;
static bool EID4789PS_gl_FrontFacing;
static float2 EID4789PS_3;
static float3 EID4789PS_4;
static float3 EID4789PS_5;
static float4 EID4789PS_6;
static float3 EID4789PS_7;
static float3 EID4789PS_8;
static float3 EID4789PS_9;
static float3 EID4789PS_10;
static uint EID4789PS_12;
static float4 EID4789PS_14;
static float4 EID4789PS_15;

EID4789PS_21 EID4789PS_LoadInstance(uint index) { uint b=index*16; EID4789PS_21 x;
x._m0=transpose(float4x4(EID4789PS_instanceRaw[b],EID4789PS_instanceRaw[b+1],EID4789PS_instanceRaw[b+2],EID4789PS_instanceRaw[b+3]));
x._m1=EID4789PS_instanceRaw[b+4];x._m2=EID4789PS_instanceRaw[b+5];
x._m3=transpose(float4x4(EID4789PS_instanceRaw[b+6],EID4789PS_instanceRaw[b+7],EID4789PS_instanceRaw[b+8],EID4789PS_instanceRaw[b+9]));
x._m4=EID4789PS_instanceRaw[b+10];
x._m5=EID4789PS_instanceRaw[b+11];
x._m6=EID4789PS_instanceRaw[b+12];
x._m7=EID4789PS_instanceRaw[b+13];
x._m8=EID4789PS_instanceRaw[b+14];
x._m9=EID4789PS_instanceRaw[b+15];
return x;}

struct EID4789PS_SPIRV_Cross_Input
{
    float2 EID4789PS_3 : TEXCOORD0;
    float3 EID4789PS_4 : TEXCOORD1;
    float3 EID4789PS_5 : TEXCOORD2;
    float4 EID4789PS_6 : TEXCOORD3;
    float3 EID4789PS_7 : TEXCOORD4;
    float3 EID4789PS_8 : TEXCOORD5;
    float3 EID4789PS_9 : TEXCOORD6;
    float3 EID4789PS_10 : TEXCOORD7;
    nointerpolation uint EID4789PS_12 : TEXCOORD8;
    float4 EID4789PS_gl_FragCoord : SV_Position;
    bool EID4789PS_gl_FrontFacing : SV_IsFrontFace;
};

struct EID4789PS_SPIRV_Cross_Output
{
    float4 EID4789PS_14 : SV_Target0;
    float4 EID4789PS_15 : SV_Target1;
};

uint EID4789PS_spvPackHalf2x16(float2 value)
{
    uint2 Packed = f32tof16(value);
    return Packed.x | (Packed.y << 16);
}

float2 EID4789PS_spvUnpackHalf2x16(uint value)
{
    return f16tof32(uint2(value & 0xffff, value >> 16));
}

float EID4789ShadowGreater(float2 uv, float reference)
{
 uint w,h; EID4789PS_39.GetDimensions(w,h); float2 p=uv*float2(w,h)-0.5;
 int2 a=(int2)floor(p); float2 f=frac(p); int2 hi=int2(w,h)-1;
 float c00=reference>EID4789PS_39.Load(int3(clamp(a,int2(0,0),hi),0)).r?1:0;
 float c10=reference>EID4789PS_39.Load(int3(clamp(a+int2(1,0),int2(0,0),hi),0)).r?1:0;
 float c01=reference>EID4789PS_39.Load(int3(clamp(a+int2(0,1),int2(0,0),hi),0)).r?1:0;
 float c11=reference>EID4789PS_39.Load(int3(clamp(a+int2(1,1),int2(0,0),hi),0)).r?1:0;
 return lerp(lerp(c00,c10,f.x),lerp(c01,c11,f.x),f.y);
}


void EID4789PS_frag_main()
{
    // This pass replays a captured light grid and froxel volume, not live camera-built data.
    // The captured clip XY/W is perspective-correctly interpolated from the baked world position.
    // Keep SV_Position.xy below for the separately supplied LIVE CP20 AO/contact texture.
    float EID4789PS_444 = EID4789PS_7.z;
    float3 EID4789PS_459 = lerp(-EID4789PS_4, float3(EID4789PS_17_m0[2u].x, EID4789PS_17_m0[2u].y, EID4789PS_17_m0[2u].z), EID4789PS_19_m4.w.xxx);
    float EID4789PS_460 = dot(EID4789PS_459, EID4789PS_459);
    float EID4789PS_462 = rsqrt(max(EID4789PS_460, 9.9999999392252902907785028219223e-09f));
    float3 EID4789PS_463 = EID4789PS_459 * EID4789PS_462;
    float EID4789PS_464 = EID4789PS_460 * EID4789PS_462;
    uint EID4789PS_467 = asuint(EID4789PS_LoadInstance(EID4789PS_12)._m2.x);
    bool EID4789PS_472 = (asuint(EID4789PS_LoadInstance(EID4789PS_12)._m1.w) & 16u) != 0u;
    float4 EID4789PS_485;
    float4 EID4789PS_486;
    if (EID4789PS_472)
    {
        EID4789PS_485 = asfloat(EID4789PS_32.Load4((EID4789PS_467 + 2u) * 16 + 0));
        EID4789PS_486 = asfloat(EID4789PS_32.Load4(EID4789PS_467 * 16 + 0));
    }
    else
    {
        EID4789PS_485 = EID4789PS_LoadInstance(EID4789PS_12)._m0[2];
        EID4789PS_486 = EID4789PS_LoadInstance(EID4789PS_12)._m0[0];
    }
    float4 EID4789PS_492 = EID4789PS_57.SampleBias(EID4789_linear_repeat_sampler, EID4789PS_3, EID4789PS_19_m16);
    float3 EID4789PS_497 = EID4789PS_492.xyz * EID4789PS_49_m24.xyz;
    float4 EID4789PS_501 = EID4789PS_58.SampleBias(EID4789_linear_repeat_sampler, EID4789PS_3, EID4789PS_19_m16);
    float EID4789PS_502 = EID4789PS_501.x;
    float EID4789PS_504 = EID4789PS_501.z;
    float EID4789PS_506 = 1.0f - EID4789PS_501.w;
    float EID4789PS_510 = EID4789PS_492.w * EID4789PS_49_m24.w;
    float3 EID4789PS_511 = EID4789PS_497 * 12.9200000762939453125f;
    float3 EID4789PS_515 = (pow(abs(EID4789PS_497), 0.4166666567325592041015625f.xxx) * 1.05499994754791259765625f) - 0.054999999701976776123046875f.xxx;
    bool3 EID4789PS_516 = bool3(EID4789PS_497.x <= 0.003130800090730190277099609375f.xxx.x, EID4789PS_497.y <= 0.003130800090730190277099609375f.xxx.y, EID4789PS_497.z <= 0.003130800090730190277099609375f.xxx.z);
    float3 EID4789PS_518 = clamp(float3(EID4789PS_516.x ? EID4789PS_511.x : EID4789PS_515.x, EID4789PS_516.y ? EID4789PS_511.y : EID4789PS_515.y, EID4789PS_516.z ? EID4789PS_511.z : EID4789PS_515.z), 0.0f.xxx, 1.0f.xxx);
    float EID4789PS_522 = EID4789PS_518.z * 31.0f;
    float EID4789PS_523 = floor(EID4789PS_522);
    float2 EID4789PS_527 = ((EID4789PS_518.xy * 31.0f) * float2(0.0009765625f, 0.03125f)) + float2(0.00048828125f, 0.015625f);
    float3 EID4789PS_528 = float3(EID4789PS_527.x, EID4789PS_527.y, EID4789PS_518.z);
    EID4789PS_528.x = EID4789PS_527.x + (EID4789PS_523 * 0.03125f);
    float3 EID4789PS_543 = lerp(EID4789PS_52.SampleLevel(EID4789_linear_clamp_sampler, EID4789PS_528.xy, 0.0f).xyz, EID4789PS_52.SampleLevel(EID4789_linear_clamp_sampler, EID4789PS_528.xy + float2(0.03125f, 0.0f), 0.0f).xyz, (EID4789PS_522 - EID4789PS_523).xxx);
    float4 EID4789PS_547 = EID4789PS_59.SampleBias(EID4789_linear_repeat_sampler, EID4789PS_3, EID4789PS_19_m16);
    EID4789PS_547.w = EID4789PS_547.w * EID4789PS_547.x;
    float2 EID4789PS_556 = (EID4789PS_547.wy * 2.0f) - 1.0f.xx;
    float3 EID4789PS_557 = float3(EID4789PS_556.x, EID4789PS_556.y, EID4789PS_425.z);
    float2 EID4789PS_558 = EID4789PS_556.xy;
    EID4789PS_557.z = max(1.000000016862383526387164645044e-16f, sqrt(1.0f - clamp(dot(EID4789PS_558, EID4789PS_558), 0.0f, 1.0f)));
    float2 EID4789PS_566 = EID4789PS_557.xy * EID4789PS_49_m3;
    float4 EID4789PS_571 = EID4789PS_60.SampleBias(EID4789_linear_repeat_sampler, EID4789PS_3, EID4789PS_19_m16);
    float3 EID4789PS_583 = EID4789PS_4 + EID4789PS_17_m11.xyz;
    float3 EID4789PS_587 = EID4789PS_583 - float3(EID4789PS_486.w, EID4789PS_428, EID4789PS_485.w);
    EID4789PS_587.y = 6.103515625e-05f;
    float3 EID4789PS_590 = normalize(EID4789PS_587);
    float3 EID4789PS_600 = mul(float3(EID4789PS_566.x, EID4789PS_566.y, EID4789PS_557.z), float3x3(EID4789PS_6.xyz * 1.0f, (cross(EID4789PS_5, EID4789PS_6.xyz) * EID4789PS_6.w) * 1.0f, EID4789PS_5 * 1.0f));
    float EID4789PS_609 = EID4789PS_gl_FrontFacing ? 1.0f : ((-1.0f) + (2.0f * EID4789PS_49_m5));
    float3 EID4789PS_610 = (EID4789PS_600 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(EID4789PS_600, EID4789PS_600)))) * EID4789PS_609;
    float3 EID4789PS_611 = normalize(EID4789PS_5) * EID4789PS_609;
    uint2 EID4789PS_613 = uint2(EID4789PS_gl_FragCoord.xy);
    float2 capturedNdc = EID4789PS_7.xy / max(EID4789PS_7.z, 1e-6f);
    float2 capturedPixel = (capturedNdc * float2(0.5f, -0.5f) + 0.5f) * EID4789PS_19_m0.xy - EID4789PS_19_m9.xy;
    bool capturedScreenValid = EID4789PS_7.z > 0.0f && all(capturedPixel >= 0.0f) && all(capturedPixel < EID4789PS_19_m0.xy);

    float3 EID4789PS_623 = mul(float3x3(EID4789PS_17_m1[0].xyz, EID4789PS_17_m1[1].xyz, EID4789PS_17_m1[2].xyz), float3(0.0f, 0.0f, 1.0f));
    uint EID4789PS_632 = asuint((EID4789PS_19_m89.x > 0.5f) ? EID4789PS_19_m89.y : EID4789PS_LoadInstance(EID4789PS_12)._m7.x);
    float4 EID4789PS_645 = float4(float(EID4789PS_632 & 255u), float((EID4789PS_632 >> 8u) & 255u), float((EID4789PS_632 >> 16u) & 255u), float((EID4789PS_632 >> 24u) & 255u)) * 0.0039215688593685626983642578125f.xxxx;
    float EID4789PS_646 = EID4789PS_645.x;
    float EID4789PS_649 = EID4789PS_645.w;
    float EID4789PS_655 = EID4789PS_583.y;
    float EID4789PS_658 = smoothstep(-0.20000000298023223876953125f, 0.1500000059604644775390625f, lerp(EID4789PS_LoadInstance(EID4789PS_12)._m7.y, EID4789PS_19_m89.w, EID4789PS_19_m89.x) - EID4789PS_655) * EID4789PS_645.y;
    float EID4789PS_659 = max(EID4789PS_645.z, EID4789PS_658);
    float EID4789PS_668 = lerp(EID4789PS_19_m22.x, 1.0f, EID4789PS_19_m91.w) * EID4789PS_19_m20.x;
    float4 EID4789PS_1162;
    float3 EID4789PS_1163;
    float3 EID4789PS_1164;
    float EID4789PS_1165;
    if (EID4789PS_19_m80.y < 0.5f)
    {
        float3 EID4789PS_683 = EID4789PS_583 - (EID4789PS_19_m105.xyz + (EID4789PS_623 * (-EID4789PS_19_m107.w)));
        float EID4789PS_697 = max(clamp((max(abs(EID4789PS_683.x), abs(EID4789PS_683.z)) - 464.0f) * 0.03125f, 0.0f, 1.0f), clamp((abs(EID4789PS_683.y) - 208.0f) * 0.03125f, 0.0f, 1.0f));
        float4 EID4789PS_999;
        float4 EID4789PS_1000;
        float4 EID4789PS_1001;
        float EID4789PS_1002;
        float EID4789PS_1003;
        if ((EID4789PS_19_m105.w != 0.0f) && (EID4789PS_697 < 1.0f))
        {
            float3 EID4789PS_710 = EID4789PS_583 - (EID4789PS_19_m105.xyz + (EID4789PS_623 * (-EID4789PS_19_m107.y)));
            float EID4789PS_724 = max(clamp((max(abs(EID4789PS_710.x), abs(EID4789PS_710.z)) - 29.0f) * 0.5f, 0.0f, 1.0f), clamp((abs(EID4789PS_710.y) - 13.0f) * 0.5f, 0.0f, 1.0f));
            float EID4789PS_800;
            float4 EID4789PS_801;
            float4 EID4789PS_802;
            float4 EID4789PS_803;
            if (EID4789PS_724 < 1.0f)
            {
                float3 EID4789PS_733 = ((EID4789PS_583 * 2.0f) + 0.5f.xxx) * EID4789PS_19_m106.xyz;
                float3 EID4789PS_735 = EID4789PS_733 - floor(EID4789PS_733);
                float4 EID4789PS_739 = EID4789PS_42.SampleLevel(EID4789_linear_repeat_sampler, EID4789PS_735, 0.0f);
                float EID4789PS_740 = 1.0f - EID4789PS_724;
                float EID4789PS_744 = EID4789PS_19_m106.y * 0.5f;
                float EID4789PS_749 = EID4789PS_735.x;
                float EID4789PS_750 = clamp(EID4789PS_735.y, EID4789PS_744, 1.0f - EID4789PS_744) * 0.3333333432674407958984375f;
                float EID4789PS_751 = EID4789PS_735.z;
                float4 EID4789PS_754 = EID4789PS_43.SampleLevel(EID4789_linear_clamp_sampler, float3(EID4789PS_749, EID4789PS_750, EID4789PS_751), 0.0f);
                float EID4789PS_770 = EID4789PS_739.x;
                float EID4789PS_780 = EID4789PS_739.y;
                float EID4789PS_790 = EID4789PS_739.z;
                EID4789PS_800 = EID4789PS_697 + (EID4789PS_754.w * EID4789PS_740);
                EID4789PS_801 = float4(((EID4789PS_43.SampleLevel(EID4789_linear_clamp_sampler, float3(EID4789PS_749, EID4789PS_750 + 0.666666686534881591796875f, EID4789PS_751), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4789PS_790, EID4789PS_790) * EID4789PS_740;
                EID4789PS_802 = float4(((EID4789PS_43.SampleLevel(EID4789_linear_clamp_sampler, float3(EID4789PS_749, EID4789PS_750 + 0.3333333432674407958984375f, EID4789PS_751), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4789PS_780, EID4789PS_780) * EID4789PS_740;
                EID4789PS_803 = float4(((EID4789PS_754.xyz * 4.0f) - 2.0f.xxx) * EID4789PS_770, EID4789PS_770) * EID4789PS_740;
            }
            else
            {
                EID4789PS_800 = EID4789PS_697;
                EID4789PS_801 = 0.0f.xxxx;
                EID4789PS_802 = 0.0f.xxxx;
                EID4789PS_803 = 0.0f.xxxx;
            }
            float3 EID4789PS_809 = EID4789PS_583 - (EID4789PS_19_m105.xyz + (EID4789PS_623 * (-EID4789PS_19_m107.z)));
            float EID4789PS_823 = max(clamp((max(abs(EID4789PS_809.x), abs(EID4789PS_809.z)) - 116.0f) * 0.125f, 0.0f, 1.0f), clamp((abs(EID4789PS_809.y) - 52.0f) * 0.125f, 0.0f, 1.0f));
            float EID4789PS_903;
            float4 EID4789PS_904;
            float4 EID4789PS_905;
            float4 EID4789PS_906;
            if (EID4789PS_823 < 1.0f)
            {
                float3 EID4789PS_832 = ((EID4789PS_583 * 0.5f) + 0.5f.xxx) * EID4789PS_19_m106.xyz;
                float3 EID4789PS_834 = EID4789PS_832 - floor(EID4789PS_832);
                float4 EID4789PS_838 = EID4789PS_44.SampleLevel(EID4789_linear_repeat_sampler, EID4789PS_834, 0.0f);
                float EID4789PS_840 = EID4789PS_724 * (1.0f - EID4789PS_823);
                float EID4789PS_844 = EID4789PS_19_m106.y * 0.5f;
                float EID4789PS_849 = EID4789PS_834.x;
                float EID4789PS_850 = clamp(EID4789PS_834.y, EID4789PS_844, 1.0f - EID4789PS_844) * 0.3333333432674407958984375f;
                float EID4789PS_851 = EID4789PS_834.z;
                float4 EID4789PS_854 = EID4789PS_45.SampleLevel(EID4789_linear_clamp_sampler, float3(EID4789PS_849, EID4789PS_850, EID4789PS_851), 0.0f);
                float EID4789PS_870 = EID4789PS_838.x;
                float EID4789PS_881 = EID4789PS_838.y;
                float EID4789PS_892 = EID4789PS_838.z;
                EID4789PS_903 = EID4789PS_800 + (EID4789PS_854.w * EID4789PS_840);
                EID4789PS_904 = EID4789PS_801 + (float4(((EID4789PS_45.SampleLevel(EID4789_linear_clamp_sampler, float3(EID4789PS_849, EID4789PS_850 + 0.666666686534881591796875f, EID4789PS_851), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4789PS_892, EID4789PS_892) * EID4789PS_840);
                EID4789PS_905 = EID4789PS_802 + (float4(((EID4789PS_45.SampleLevel(EID4789_linear_clamp_sampler, float3(EID4789PS_849, EID4789PS_850 + 0.3333333432674407958984375f, EID4789PS_851), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4789PS_881, EID4789PS_881) * EID4789PS_840);
                EID4789PS_906 = EID4789PS_803 + (float4(((EID4789PS_854.xyz * 4.0f) - 2.0f.xxx) * EID4789PS_870, EID4789PS_870) * EID4789PS_840);
            }
            else
            {
                EID4789PS_903 = EID4789PS_800;
                EID4789PS_904 = EID4789PS_801;
                EID4789PS_905 = EID4789PS_802;
                EID4789PS_906 = EID4789PS_803;
            }
            float4 EID4789PS_989;
            float4 EID4789PS_990;
            float4 EID4789PS_991;
            float EID4789PS_992;
            if (EID4789PS_823 > 0.0f)
            {
                float3 EID4789PS_915 = ((EID4789PS_583 * 0.125f) + 0.5f.xxx) * EID4789PS_19_m106.xyz;
                float3 EID4789PS_918 = EID4789PS_19_m106.xyz * 0.5f;
                float3 EID4789PS_920 = clamp(EID4789PS_915 - floor(EID4789PS_915), EID4789PS_918, 1.0f.xxx - EID4789PS_918);
                float4 EID4789PS_924 = EID4789PS_46.SampleLevel(EID4789_linear_repeat_sampler, EID4789PS_920, 0.0f);
                float EID4789PS_926 = EID4789PS_823 * (1.0f - EID4789PS_697);
                float EID4789PS_930 = EID4789PS_19_m106.y * 0.5f;
                float EID4789PS_935 = EID4789PS_920.x;
                float EID4789PS_936 = clamp(EID4789PS_920.y, EID4789PS_930, 1.0f - EID4789PS_930) * 0.3333333432674407958984375f;
                float EID4789PS_937 = EID4789PS_920.z;
                float4 EID4789PS_940 = EID4789PS_47.SampleLevel(EID4789_linear_clamp_sampler, float3(EID4789PS_935, EID4789PS_936, EID4789PS_937), 0.0f);
                float EID4789PS_956 = EID4789PS_924.x;
                float EID4789PS_967 = EID4789PS_924.y;
                float EID4789PS_978 = EID4789PS_924.z;
                EID4789PS_989 = EID4789PS_904 + (float4(((EID4789PS_47.SampleLevel(EID4789_linear_clamp_sampler, float3(EID4789PS_935, EID4789PS_936 + 0.666666686534881591796875f, EID4789PS_937), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4789PS_978, EID4789PS_978) * EID4789PS_926);
                EID4789PS_990 = EID4789PS_905 + (float4(((EID4789PS_47.SampleLevel(EID4789_linear_clamp_sampler, float3(EID4789PS_935, EID4789PS_936 + 0.3333333432674407958984375f, EID4789PS_937), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4789PS_967, EID4789PS_967) * EID4789PS_926);
                EID4789PS_991 = EID4789PS_906 + (float4(((EID4789PS_940.xyz * 4.0f) - 2.0f.xxx) * EID4789PS_956, EID4789PS_956) * EID4789PS_926);
                EID4789PS_992 = EID4789PS_903 + (EID4789PS_940.w * EID4789PS_926);
            }
            else
            {
                EID4789PS_989 = EID4789PS_904;
                EID4789PS_990 = EID4789PS_905;
                EID4789PS_991 = EID4789PS_906;
                EID4789PS_992 = EID4789PS_903;
            }
            float EID4789PS_995 = clamp((EID4789PS_992 * 2.0f) - 1.0f, 0.0f, 1.0f);
            EID4789PS_999 = EID4789PS_989;
            EID4789PS_1000 = EID4789PS_990;
            EID4789PS_1001 = EID4789PS_991;
            EID4789PS_1002 = EID4789PS_995 - EID4789PS_697;
            EID4789PS_1003 = (EID4789PS_995 + EID4789PS_697) * 0.5f;
        }
        else
        {
            EID4789PS_999 = 0.0f.xxxx;
            EID4789PS_1000 = 0.0f.xxxx;
            EID4789PS_1001 = 0.0f.xxxx;
            EID4789PS_1002 = 0.0f;
            EID4789PS_1003 = 1.0f;
        }
        float4 EID4789PS_1023 = EID4789PS_1001 + float4(EID4789PS_19_m108.x * EID4789PS_1003, (EID4789PS_19_m108.y * EID4789PS_1003) + ((EID4789PS_19_m108.w * EID4789PS_1002) * 0.5f), EID4789PS_19_m108.z * EID4789PS_1003, (EID4789PS_19_m108.w * EID4789PS_1003) + ((EID4789PS_19_m108.y * EID4789PS_1002) * 0.375f));
        float4 EID4789PS_1043 = EID4789PS_1000 + float4(EID4789PS_19_m109.x * EID4789PS_1003, (EID4789PS_19_m109.y * EID4789PS_1003) + ((EID4789PS_19_m109.w * EID4789PS_1002) * 0.5f), EID4789PS_19_m109.z * EID4789PS_1003, (EID4789PS_19_m109.w * EID4789PS_1003) + ((EID4789PS_19_m109.y * EID4789PS_1002) * 0.375f));
        float4 EID4789PS_1063 = EID4789PS_999 + float4(EID4789PS_19_m110.x * EID4789PS_1003, (EID4789PS_19_m110.y * EID4789PS_1003) + ((EID4789PS_19_m110.w * EID4789PS_1002) * 0.5f), EID4789PS_19_m110.z * EID4789PS_1003, (EID4789PS_19_m110.w * EID4789PS_1003) + ((EID4789PS_19_m110.y * EID4789PS_1002) * 0.375f));
        float4 EID4789PS_1067 = float4(EID4789PS_610, 1.0f);
        float3 EID4789PS_1073 = max(float3(dot(EID4789PS_1023, EID4789PS_1067), dot(EID4789PS_1043, EID4789PS_1067), dot(EID4789PS_1063, EID4789PS_1067)), 0.0f.xxx) * EID4789PS_668;
        float3 EID4789PS_1081 = ((EID4789PS_1023.xyz * 0.2125999927520751953125f) + (EID4789PS_1043.xyz * 0.715200006961822509765625f)) + (EID4789PS_1063.xyz * 0.072200000286102294921875f);
        float3 EID4789PS_1085 = EID4789PS_1081 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(EID4789PS_1081, EID4789PS_1081)));
        float EID4789PS_1087 = abs(EID4789PS_1085.y);
        float3 EID4789PS_1088 = EID4789PS_1085;
        EID4789PS_1088.y = EID4789PS_1087;
        float4 EID4789PS_1089 = float4(EID4789PS_1088.x, EID4789PS_1088.y, EID4789PS_1088.z, 0.0f.xxxx.w);
        EID4789PS_1089.w = 1.0f;
        float4 EID4789PS_1093 = float4(EID4789PS_1085.x, EID4789PS_1087, EID4789PS_1085.z, 1.0f);
        float3 EID4789PS_1098 = max(float3(dot(EID4789PS_1023, EID4789PS_1093), dot(EID4789PS_1043, EID4789PS_1093), dot(EID4789PS_1063, EID4789PS_1093)), 0.0f.xxx);
        float EID4789PS_1106 = EID4789PS_1073.z;
        float EID4789PS_1107 = EID4789PS_1073.y;
        float4 EID4789PS_1112 = lerp(float4(EID4789PS_1106, EID4789PS_1107, -1.0f, 0.666666686534881591796875f), float4(EID4789PS_1107, EID4789PS_1106, 0.0f, -0.3333333432674407958984375f), step(EID4789PS_1106, EID4789PS_1107).xxxx);
        float EID4789PS_1113 = EID4789PS_1073.x;
        float EID4789PS_1114 = EID4789PS_1112.x;
        float4 EID4789PS_1122 = lerp(float4(EID4789PS_1114, EID4789PS_1112.yw, EID4789PS_1113), float4(EID4789PS_1113, EID4789PS_1112.yz, EID4789PS_1114), step(EID4789PS_1114, EID4789PS_1113).xxxx);
        float EID4789PS_1123 = EID4789PS_1122.x;
        float EID4789PS_1124 = EID4789PS_1122.w;
        float EID4789PS_1125 = EID4789PS_1122.y;
        float EID4789PS_1127 = EID4789PS_1123 - min(EID4789PS_1124, EID4789PS_1125);
        float EID4789PS_1137 = frac(abs(EID4789PS_1122.z + ((EID4789PS_1124 - EID4789PS_1125) / ((6.0f * EID4789PS_1127) + 9.9999997473787516355514526367188e-05f))));
        float EID4789PS_1144 = min(EID4789PS_1127 / (EID4789PS_1123 + 9.9999997473787516355514526367188e-05f), lerp(0.699999988079071044921875f, 0.3499999940395355224609375f, smoothstep(0.449999988079071044921875f, 0.3499999940395355224609375f, abs(EID4789PS_1137 - 0.5f))) * clamp(EID4789PS_1123, 0.0f, 1.0f));
        float EID4789PS_1146 = 2.0f / (2.0f - EID4789PS_1144);
        EID4789PS_1162 = EID4789PS_1089;
        EID4789PS_1163 = EID4789PS_1073;
        EID4789PS_1164 = lerp(1.0f.xxx, clamp(abs((frac(float3(EID4789PS_1137, EID4789PS_1144, EID4789PS_1146).xxx + float3(1.0f, 0.666666686534881591796875f, 0.3333333432674407958984375f)) * 6.0f) - 3.0f.xxx) - 1.0f.xxx, 0.0f.xxx, 1.0f.xxx), EID4789PS_1144.xxx) * EID4789PS_1146;
        EID4789PS_1165 = max(max(max(EID4789PS_1098.x, EID4789PS_1098.y), EID4789PS_1098.z), 0.0f) * EID4789PS_668;
    }
    else
    {
        EID4789PS_1162 = 0.0f.xxxx;
        EID4789PS_1163 = 1.0f.xxx;
        EID4789PS_1164 = EID4789PS_19_m81.xyz;
        EID4789PS_1165 = EID4789PS_668;
    }
    float3 EID4789PS_1885;
    float EID4789PS_1886;
    float EID4789PS_1887;
    float EID4789PS_1888;
    float EID4789PS_1889;
    float3 EID4789PS_1890;
    float3 EID4789PS_1891;
    [branch]
    if ((clamp(EID4789PS_646 + EID4789PS_659, 0.0f, 1.0f) - EID4789PS_49_m20) > 0.00999999977648258209228515625f)
    {
        float EID4789PS_1193 = 1.0f - EID4789PS_502;
        float EID4789PS_1196 = smoothstep(0.3499999940395355224609375f, 0.100000001490116119384765625f, dot(EID4789PS_497 * EID4789PS_1193, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)));
        bool3 EID4789PS_1199 = EID4789PS_472.xxx;
        float3 EID4789PS_1201 = EID4789PS_10.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 EID4789PS_1205 = float3(EID4789PS_1199.x ? EID4789PS_1201.x : EID4789PS_10.x, EID4789PS_1199.y ? EID4789PS_1201.y : EID4789PS_10.y, EID4789PS_1199.z ? EID4789PS_1201.z : EID4789PS_10.z) * EID4789PS_19_m89.z;
        float3 EID4789PS_1207 = float3(EID4789PS_1199.x ? EID4789PS_9.xzy.x : EID4789PS_9.x, EID4789PS_1199.y ? EID4789PS_9.xzy.y : EID4789PS_9.y, EID4789PS_1199.z ? EID4789PS_9.xzy.z : EID4789PS_9.z);
        float3 EID4789PS_1209 = abs(EID4789PS_1207) - 0.20000000298023223876953125f.xxx;
        float3 EID4789PS_1212 = max((EID4789PS_1209 * EID4789PS_1209) * EID4789PS_1209, 6.103515625e-05f.xxx);
        float3 EID4789PS_1215 = EID4789PS_1212 / dot(EID4789PS_1212, 1.0f.xxx).xxx;
        float2 EID4789PS_1223 = EID4789PS_1205.xy;
        float2 EID4789PS_1228 = EID4789PS_1205.zy;
        float4 EID4789PS_1238 = ((EID4789PS_53.SampleBias(EID4789_linear_repeat_sampler, EID4789PS_1205.xz, EID4789PS_19_m16) * EID4789PS_1215.y) + (EID4789PS_53.SampleBias(EID4789_linear_repeat_sampler, EID4789PS_1223, EID4789PS_19_m16) * EID4789PS_1215.z)) + (EID4789PS_53.SampleBias(EID4789_linear_repeat_sampler, EID4789PS_1228, EID4789PS_19_m16) * EID4789PS_1215.x);
        float EID4789PS_1239 = EID4789PS_1238.w;
        float EID4789PS_1241 = 1.10000002384185791015625f - EID4789PS_1239;
        float EID4789PS_1250 = max(smoothstep(0.800000011920928955078125f - EID4789PS_1239, EID4789PS_1241, clamp((EID4789PS_646 * EID4789PS_1193) + (EID4789PS_610.y * 0.20000000298023223876953125f), 0.0f, 1.0f)), smoothstep(0.449999988079071044921875f - EID4789PS_1239, EID4789PS_1241, clamp(EID4789PS_658 * EID4789PS_1193, 0.0f, 1.0f)));
        float EID4789PS_1257 = smoothstep(0.5f, 0.75f, EID4789PS_502);
        float EID4789PS_1259 = smoothstep(0.800000011920928955078125f, 0.60000002384185791015625f, EID4789PS_506) * EID4789PS_1196;
        float EID4789PS_1262 = clamp(EID4789PS_1259 + EID4789PS_1257, 0.0f, 1.0f) * max(EID4789PS_646, EID4789PS_659);
        bool EID4789PS_1266 = !((step(EID4789PS_646, 0.00999999977648258209228515625f) * step(0.00999999977648258209228515625f, EID4789PS_659)) != 0.0f);
        bool2 EID4789PS_1267 = EID4789PS_1266.xx;
        float2 EID4789PS_1269 = (1.0f - EID4789PS_659).xx;
        float2 EID4789PS_1270 = float2(EID4789PS_1267.x ? float2(3.0f, 4.345600128173828125f).x : EID4789PS_1269.x, EID4789PS_1267.y ? float2(3.0f, 4.345600128173828125f).y : EID4789PS_1269.y);
        float EID4789PS_1271 = 1.0f - EID4789PS_1262;
        float EID4789PS_1274 = EID4789PS_1266 ? EID4789PS_19_m10.x : 1.0f;
        float EID4789PS_1276 = EID4789PS_1274 * EID4789PS_1270.x;
        float EID4789PS_1278 = EID4789PS_1274 * EID4789PS_1270.y;
        float3 EID4789PS_1279 = EID4789PS_1205 * 20.0f;
        float3 EID4789PS_1280 = EID4789PS_1205 * 34.345600128173828125f;
        float3 EID4789PS_1282 = pow(max(EID4789PS_1209, 0.0f.xxx), 10.0f.xxx);
        float3 EID4789PS_1286 = EID4789PS_1282 / max(dot(EID4789PS_1282, 1.0f.xxx), 6.103515625e-05f).xxx;
        float EID4789PS_1288 = EID4789PS_1286.y;
        float2 EID4789PS_1289 = EID4789PS_1279.xz * 1.0f;
        float2 EID4789PS_1290 = floor(EID4789PS_1289);
        float2 EID4789PS_1293 = frac(EID4789PS_1290 * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4789PS_1297 = EID4789PS_1293 + dot(EID4789PS_1293, EID4789PS_1293 + 34.345001220703125f.xx).xx;
        float EID4789PS_1298 = EID4789PS_1297.x;
        float EID4789PS_1299 = EID4789PS_1297.y;
        float2 EID4789PS_1303 = frac(float2(EID4789PS_1298 * EID4789PS_1299, EID4789PS_1298 + EID4789PS_1299));
        float2 EID4789PS_1306 = frac((EID4789PS_1290 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4789PS_1310 = EID4789PS_1306 + dot(EID4789PS_1306, EID4789PS_1306 + 34.345001220703125f.xx).xx;
        float EID4789PS_1311 = EID4789PS_1310.x;
        float EID4789PS_1312 = EID4789PS_1310.y;
        float2 EID4789PS_1316 = frac(float2(EID4789PS_1311 * EID4789PS_1312, EID4789PS_1311 + EID4789PS_1312));
        float EID4789PS_1322 = EID4789PS_1303.x;
        float EID4789PS_1324 = 0.25f * lerp(0.60000002384185791015625f, 1.0f, EID4789PS_1322);
        float2 EID4789PS_1325 = ((EID4789PS_1289 - EID4789PS_1290) + ((((EID4789PS_1316 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float EID4789PS_1328 = EID4789PS_1325.y;
        float2 EID4789PS_1332 = float2(EID4789PS_1325.x * 1.25f, EID4789PS_1328 * ((EID4789PS_1328 < 0.0f) ? 1.25f : 0.75f));
        float EID4789PS_1335 = EID4789PS_1276 + EID4789PS_1322;
        float EID4789PS_1339 = EID4789PS_1266 ? frac(EID4789PS_1335) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(EID4789PS_1335, 0.0f, 1.0f));
        float EID4789PS_1351 = EID4789PS_1303.y;
        float EID4789PS_1354 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, EID4789PS_1339) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, EID4789PS_1339)) * step(0.001000000047497451305389404296875f, smoothstep(EID4789PS_1324, 0.0f, length(EID4789PS_1332)))) * step(EID4789PS_1271, EID4789PS_1351 - 0.100000001490116119384765625f);
        float EID4789PS_1357 = EID4789PS_1354 * EID4789PS_1288;
        float EID4789PS_1365 = EID4789PS_1286.z;
        float2 EID4789PS_1366 = EID4789PS_1279.xy * 1.0f;
        float2 EID4789PS_1367 = floor(EID4789PS_1366);
        float2 EID4789PS_1370 = frac(EID4789PS_1367 * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4789PS_1374 = EID4789PS_1370 + dot(EID4789PS_1370, EID4789PS_1370 + 34.345001220703125f.xx).xx;
        float EID4789PS_1375 = EID4789PS_1374.x;
        float EID4789PS_1376 = EID4789PS_1374.y;
        float2 EID4789PS_1380 = frac(float2(EID4789PS_1375 * EID4789PS_1376, EID4789PS_1375 + EID4789PS_1376));
        float2 EID4789PS_1383 = frac((EID4789PS_1367 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4789PS_1387 = EID4789PS_1383 + dot(EID4789PS_1383, EID4789PS_1383 + 34.345001220703125f.xx).xx;
        float EID4789PS_1388 = EID4789PS_1387.x;
        float EID4789PS_1389 = EID4789PS_1387.y;
        float2 EID4789PS_1393 = frac(float2(EID4789PS_1388 * EID4789PS_1389, EID4789PS_1388 + EID4789PS_1389));
        float EID4789PS_1399 = EID4789PS_1380.x;
        float EID4789PS_1401 = 0.25f * lerp(0.60000002384185791015625f, 1.0f, EID4789PS_1399);
        float2 EID4789PS_1402 = ((EID4789PS_1366 - EID4789PS_1367) + ((((EID4789PS_1393 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float EID4789PS_1405 = EID4789PS_1402.y;
        float2 EID4789PS_1409 = float2(EID4789PS_1402.x * 1.25f, EID4789PS_1405 * ((EID4789PS_1405 < 0.0f) ? 1.25f : 0.75f));
        float EID4789PS_1412 = EID4789PS_1276 + EID4789PS_1399;
        float EID4789PS_1416 = EID4789PS_1266 ? frac(EID4789PS_1412) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(EID4789PS_1412, 0.0f, 1.0f));
        float EID4789PS_1428 = EID4789PS_1380.y;
        float EID4789PS_1431 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, EID4789PS_1416) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, EID4789PS_1416)) * step(0.001000000047497451305389404296875f, smoothstep(EID4789PS_1401, 0.0f, length(EID4789PS_1409)))) * step(EID4789PS_1271, EID4789PS_1428 - 0.100000001490116119384765625f);
        float EID4789PS_1434 = EID4789PS_1431 * EID4789PS_1365;
        float EID4789PS_1442 = EID4789PS_1286.x;
        float2 EID4789PS_1443 = EID4789PS_1279.zy * 1.0f;
        float2 EID4789PS_1444 = floor(EID4789PS_1443);
        float2 EID4789PS_1447 = frac(EID4789PS_1444 * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4789PS_1451 = EID4789PS_1447 + dot(EID4789PS_1447, EID4789PS_1447 + 34.345001220703125f.xx).xx;
        float EID4789PS_1452 = EID4789PS_1451.x;
        float EID4789PS_1453 = EID4789PS_1451.y;
        float2 EID4789PS_1457 = frac(float2(EID4789PS_1452 * EID4789PS_1453, EID4789PS_1452 + EID4789PS_1453));
        float2 EID4789PS_1460 = frac((EID4789PS_1444 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4789PS_1464 = EID4789PS_1460 + dot(EID4789PS_1460, EID4789PS_1460 + 34.345001220703125f.xx).xx;
        float EID4789PS_1465 = EID4789PS_1464.x;
        float EID4789PS_1466 = EID4789PS_1464.y;
        float2 EID4789PS_1470 = frac(float2(EID4789PS_1465 * EID4789PS_1466, EID4789PS_1465 + EID4789PS_1466));
        float EID4789PS_1476 = EID4789PS_1457.x;
        float EID4789PS_1478 = 0.25f * lerp(0.60000002384185791015625f, 1.0f, EID4789PS_1476);
        float2 EID4789PS_1479 = ((EID4789PS_1443 - EID4789PS_1444) + ((((EID4789PS_1470 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float EID4789PS_1482 = EID4789PS_1479.y;
        float2 EID4789PS_1486 = float2(EID4789PS_1479.x * 1.25f, EID4789PS_1482 * ((EID4789PS_1482 < 0.0f) ? 1.25f : 0.75f));
        float EID4789PS_1489 = EID4789PS_1276 + EID4789PS_1476;
        float EID4789PS_1493 = EID4789PS_1266 ? frac(EID4789PS_1489) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(EID4789PS_1489, 0.0f, 1.0f));
        float EID4789PS_1505 = EID4789PS_1457.y;
        float EID4789PS_1508 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, EID4789PS_1493) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, EID4789PS_1493)) * step(0.001000000047497451305389404296875f, smoothstep(EID4789PS_1478, 0.0f, length(EID4789PS_1486)))) * step(EID4789PS_1271, EID4789PS_1505 - 0.100000001490116119384765625f);
        float EID4789PS_1511 = EID4789PS_1508 * EID4789PS_1442;
        float2 EID4789PS_1524 = (float4(((clamp(EID4789PS_1332 / EID4789PS_1324.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, EID4789PS_1316.x)) * EID4789PS_1354) * EID4789PS_1288, EID4789PS_1357, EID4789PS_1351).xy + float4(((clamp(EID4789PS_1409 / EID4789PS_1401.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, EID4789PS_1393.x)) * EID4789PS_1431) * EID4789PS_1365, EID4789PS_1434, EID4789PS_1428).xy) + float4(((clamp(EID4789PS_1486 / EID4789PS_1478.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, EID4789PS_1470.x)) * EID4789PS_1508) * EID4789PS_1442, EID4789PS_1511, EID4789PS_1505).xy;
        float EID4789PS_1526 = max(EID4789PS_1511, max(EID4789PS_1357, EID4789PS_1434));
        float4 EID4789PS_1529 = float4(EID4789PS_1524, EID4789PS_1526, 0.0f);
        float2 EID4789PS_1531 = EID4789PS_1280.xz * 1.0f;
        float2 EID4789PS_1532 = floor(EID4789PS_1531);
        float2 EID4789PS_1535 = frac(EID4789PS_1532 * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4789PS_1539 = EID4789PS_1535 + dot(EID4789PS_1535, EID4789PS_1535 + 34.345001220703125f.xx).xx;
        float EID4789PS_1540 = EID4789PS_1539.x;
        float EID4789PS_1541 = EID4789PS_1539.y;
        float2 EID4789PS_1545 = frac(float2(EID4789PS_1540 * EID4789PS_1541, EID4789PS_1540 + EID4789PS_1541));
        float2 EID4789PS_1548 = frac((EID4789PS_1532 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4789PS_1552 = EID4789PS_1548 + dot(EID4789PS_1548, EID4789PS_1548 + 34.345001220703125f.xx).xx;
        float EID4789PS_1553 = EID4789PS_1552.x;
        float EID4789PS_1554 = EID4789PS_1552.y;
        float2 EID4789PS_1558 = frac(float2(EID4789PS_1553 * EID4789PS_1554, EID4789PS_1553 + EID4789PS_1554));
        float EID4789PS_1564 = EID4789PS_1545.x;
        float EID4789PS_1566 = 0.25f * lerp(0.60000002384185791015625f, 1.0f, EID4789PS_1564);
        float2 EID4789PS_1567 = ((EID4789PS_1531 - EID4789PS_1532) + ((((EID4789PS_1558 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float EID4789PS_1570 = EID4789PS_1567.y;
        float2 EID4789PS_1574 = float2(EID4789PS_1567.x * 1.25f, EID4789PS_1570 * ((EID4789PS_1570 < 0.0f) ? 1.25f : 0.75f));
        float EID4789PS_1577 = EID4789PS_1278 + EID4789PS_1564;
        float EID4789PS_1581 = EID4789PS_1266 ? frac(EID4789PS_1577) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(EID4789PS_1577, 0.0f, 1.0f));
        float EID4789PS_1593 = EID4789PS_1545.y;
        float EID4789PS_1596 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, EID4789PS_1581) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, EID4789PS_1581)) * step(0.001000000047497451305389404296875f, smoothstep(EID4789PS_1566, 0.0f, length(EID4789PS_1574)))) * step(EID4789PS_1271, EID4789PS_1593 - 0.100000001490116119384765625f);
        float EID4789PS_1599 = EID4789PS_1596 * EID4789PS_1288;
        float2 EID4789PS_1604 = EID4789PS_1280.xy * 1.0f;
        float2 EID4789PS_1605 = floor(EID4789PS_1604);
        float2 EID4789PS_1608 = frac(EID4789PS_1605 * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4789PS_1612 = EID4789PS_1608 + dot(EID4789PS_1608, EID4789PS_1608 + 34.345001220703125f.xx).xx;
        float EID4789PS_1613 = EID4789PS_1612.x;
        float EID4789PS_1614 = EID4789PS_1612.y;
        float2 EID4789PS_1618 = frac(float2(EID4789PS_1613 * EID4789PS_1614, EID4789PS_1613 + EID4789PS_1614));
        float2 EID4789PS_1621 = frac((EID4789PS_1605 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4789PS_1625 = EID4789PS_1621 + dot(EID4789PS_1621, EID4789PS_1621 + 34.345001220703125f.xx).xx;
        float EID4789PS_1626 = EID4789PS_1625.x;
        float EID4789PS_1627 = EID4789PS_1625.y;
        float2 EID4789PS_1631 = frac(float2(EID4789PS_1626 * EID4789PS_1627, EID4789PS_1626 + EID4789PS_1627));
        float EID4789PS_1637 = EID4789PS_1618.x;
        float EID4789PS_1639 = 0.25f * lerp(0.60000002384185791015625f, 1.0f, EID4789PS_1637);
        float2 EID4789PS_1640 = ((EID4789PS_1604 - EID4789PS_1605) + ((((EID4789PS_1631 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float EID4789PS_1643 = EID4789PS_1640.y;
        float2 EID4789PS_1647 = float2(EID4789PS_1640.x * 1.25f, EID4789PS_1643 * ((EID4789PS_1643 < 0.0f) ? 1.25f : 0.75f));
        float EID4789PS_1650 = EID4789PS_1278 + EID4789PS_1637;
        float EID4789PS_1654 = EID4789PS_1266 ? frac(EID4789PS_1650) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(EID4789PS_1650, 0.0f, 1.0f));
        float EID4789PS_1666 = EID4789PS_1618.y;
        float EID4789PS_1669 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, EID4789PS_1654) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, EID4789PS_1654)) * step(0.001000000047497451305389404296875f, smoothstep(EID4789PS_1639, 0.0f, length(EID4789PS_1647)))) * step(EID4789PS_1271, EID4789PS_1666 - 0.100000001490116119384765625f);
        float EID4789PS_1672 = EID4789PS_1669 * EID4789PS_1365;
        float2 EID4789PS_1677 = EID4789PS_1280.zy * 1.0f;
        float2 EID4789PS_1678 = floor(EID4789PS_1677);
        float2 EID4789PS_1681 = frac(EID4789PS_1678 * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4789PS_1685 = EID4789PS_1681 + dot(EID4789PS_1681, EID4789PS_1681 + 34.345001220703125f.xx).xx;
        float EID4789PS_1686 = EID4789PS_1685.x;
        float EID4789PS_1687 = EID4789PS_1685.y;
        float2 EID4789PS_1691 = frac(float2(EID4789PS_1686 * EID4789PS_1687, EID4789PS_1686 + EID4789PS_1687));
        float2 EID4789PS_1694 = frac((EID4789PS_1678 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4789PS_1698 = EID4789PS_1694 + dot(EID4789PS_1694, EID4789PS_1694 + 34.345001220703125f.xx).xx;
        float EID4789PS_1699 = EID4789PS_1698.x;
        float EID4789PS_1700 = EID4789PS_1698.y;
        float2 EID4789PS_1704 = frac(float2(EID4789PS_1699 * EID4789PS_1700, EID4789PS_1699 + EID4789PS_1700));
        float EID4789PS_1710 = EID4789PS_1691.x;
        float EID4789PS_1712 = 0.25f * lerp(0.60000002384185791015625f, 1.0f, EID4789PS_1710);
        float2 EID4789PS_1713 = ((EID4789PS_1677 - EID4789PS_1678) + ((((EID4789PS_1704 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float EID4789PS_1716 = EID4789PS_1713.y;
        float2 EID4789PS_1720 = float2(EID4789PS_1713.x * 1.25f, EID4789PS_1716 * ((EID4789PS_1716 < 0.0f) ? 1.25f : 0.75f));
        float EID4789PS_1723 = EID4789PS_1278 + EID4789PS_1710;
        float EID4789PS_1727 = EID4789PS_1266 ? frac(EID4789PS_1723) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(EID4789PS_1723, 0.0f, 1.0f));
        float EID4789PS_1739 = EID4789PS_1691.y;
        float EID4789PS_1742 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, EID4789PS_1727) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, EID4789PS_1727)) * step(0.001000000047497451305389404296875f, smoothstep(EID4789PS_1712, 0.0f, length(EID4789PS_1720)))) * step(EID4789PS_1271, EID4789PS_1739 - 0.100000001490116119384765625f);
        float EID4789PS_1745 = EID4789PS_1742 * EID4789PS_1442;
        float2 EID4789PS_1753 = (float4(((clamp(EID4789PS_1574 / EID4789PS_1566.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, EID4789PS_1558.x)) * EID4789PS_1596) * EID4789PS_1288, EID4789PS_1599, EID4789PS_1593).xy + float4(((clamp(EID4789PS_1647 / EID4789PS_1639.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, EID4789PS_1631.x)) * EID4789PS_1669) * EID4789PS_1365, EID4789PS_1672, EID4789PS_1666).xy) + float4(((clamp(EID4789PS_1720 / EID4789PS_1712.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, EID4789PS_1704.x)) * EID4789PS_1742) * EID4789PS_1442, EID4789PS_1745, EID4789PS_1739).xy;
        float4 EID4789PS_1758 = float4(EID4789PS_1753, max(EID4789PS_1745, max(EID4789PS_1599, EID4789PS_1672)), 0.0f);
        float EID4789PS_1760 = step(max(float2(EID4789PS_1324 * EID4789PS_1354, EID4789PS_428) * EID4789PS_1288, max(float2(EID4789PS_1401 * EID4789PS_1431, EID4789PS_428) * EID4789PS_1365, float2(EID4789PS_1478 * EID4789PS_1508, EID4789PS_428) * EID4789PS_1442)).x, 0.00999999977648258209228515625f);
        float2 EID4789PS_1764 = EID4789PS_1529.xy + (EID4789PS_1758.xy * EID4789PS_1760);
        float3 EID4789PS_1773 = float3((EID4789PS_1238.xy * 2.0f) - 1.0f.xx, 0.0f) + float3(EID4789PS_1764.x, EID4789PS_1764.y, 0.0f.xxx.z);
        float2 EID4789PS_1777 = float2(0.0f, (EID4789PS_19_m10.x * EID4789PS_19_m89.z) * 0.75f);
        float3 EID4789PS_1780 = float3(EID4789PS_1207.x, 0.0f, EID4789PS_1207.z);
        float3 EID4789PS_1786 = abs(EID4789PS_1780 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(EID4789PS_1780, EID4789PS_1780)))) - 0.20000000298023223876953125f.xxx;
        float3 EID4789PS_1789 = max((EID4789PS_1786 * EID4789PS_1786) * EID4789PS_1786, 6.103515625e-05f.xxx);
        float3 EID4789PS_1792 = EID4789PS_1789 / dot(EID4789PS_1789, 1.0f.xxx).xxx;
        float EID4789PS_1811 = EID4789PS_1792.z;
        float EID4789PS_1813 = EID4789PS_1792.x;
        float4 EID4789PS_1815 = (EID4789PS_54.SampleBias(EID4789_linear_repeat_sampler, EID4789PS_1223, EID4789PS_19_m16) * EID4789PS_1811) + (EID4789PS_54.SampleBias(EID4789_linear_repeat_sampler, EID4789PS_1228, EID4789PS_19_m16) * EID4789PS_1813);
        float2 EID4789PS_1827 = EID4789PS_1773.xy + ((((EID4789PS_1815.xy * 2.0f) - 1.0f.xx) * ((EID4789PS_54.SampleBias(EID4789_linear_repeat_sampler, EID4789PS_1223 + EID4789PS_1777, EID4789PS_19_m16).w * EID4789PS_1811) + (EID4789PS_54.SampleBias(EID4789_linear_repeat_sampler, EID4789PS_1228 + EID4789PS_1777, EID4789PS_19_m16).w * EID4789PS_1813))) * EID4789PS_1262);
        float3 EID4789PS_1828 = float3(EID4789PS_1827.x, EID4789PS_1827.y, EID4789PS_1773.z);
        float EID4789PS_1829 = EID4789PS_1815.z;
        float EID4789PS_1834 = max(max(max(EID4789PS_1529.zw * step(0.00999999977648258209228515625f, EID4789PS_1526), EID4789PS_1758.zw * EID4789PS_1760).x, step(1.0099999904632568359375f - EID4789PS_1262, EID4789PS_1238.z)), smoothstep(1.0f - EID4789PS_1829, 1.10000002384185791015625f - EID4789PS_1829, EID4789PS_1262) * EID4789PS_1262);
        float2 EID4789PS_1835 = EID4789PS_1827.xy;
        EID4789PS_1828.z = max(1.000000016862383526387164645044e-16f, sqrt(1.0f - clamp(dot(EID4789PS_1835, EID4789PS_1835), 0.0f, 1.0f)));
        float3 EID4789PS_1842 = normalize(EID4789PS_1828);
        float3 EID4789PS_1843 = cross(EID4789PS_610, float3(0.0f, 1.0f, 0.0f));
        bool3 EID4789PS_1846 = (dot(EID4789PS_1843, EID4789PS_1843) > 6.103515625e-05f).xxx;
        float3 EID4789PS_1847 = normalize(EID4789PS_1843);
        float3 EID4789PS_1848 = float3(EID4789PS_1846.x ? EID4789PS_1847.x : float3(1.0f, 0.0f, 0.0f).x, EID4789PS_1846.y ? EID4789PS_1847.y : float3(1.0f, 0.0f, 0.0f).y, EID4789PS_1846.z ? EID4789PS_1847.z : float3(1.0f, 0.0f, 0.0f).z);
        float EID4789PS_1859 = min(EID4789PS_506, 0.0500000007450580596923828125f);
        float EID4789PS_1860 = lerp(EID4789PS_506, EID4789PS_1859, EID4789PS_1834);
        float EID4789PS_1877 = lerp(1.0f, 0.5f, (EID4789PS_1250 * (1.0f - EID4789PS_1196)) * (1.0f - EID4789PS_1259));
        EID4789PS_1885 = normalize(lerp(EID4789PS_610, normalize(((EID4789PS_1848 * EID4789PS_1842.x) + (cross(EID4789PS_1848, EID4789PS_610) * EID4789PS_1842.y)) + (EID4789PS_610 * EID4789PS_1842.z)), EID4789PS_1834.xxx));
        EID4789PS_1886 = EID4789PS_1834;
        EID4789PS_1887 = EID4789PS_1859;
        EID4789PS_1888 = EID4789PS_1834;
        EID4789PS_1889 = max(EID4789PS_1860 - ((0.20000000298023223876953125f * EID4789PS_1196) * EID4789PS_1250), min(0.20000000298023223876953125f, EID4789PS_1860));
        EID4789PS_1890 = EID4789PS_543 * EID4789PS_1877;
        EID4789PS_1891 = lerp(EID4789PS_497, EID4789PS_497 * ((smoothstep(0.699999988079071044921875f, 0.300000011920928955078125f, dot(EID4789PS_497, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f))) * 0.5f) + 1.0f).xxx, (EID4789PS_1834 * EID4789PS_1257).xxx) * EID4789PS_1877;
    }
    else
    {
        EID4789PS_1885 = EID4789PS_610;
        EID4789PS_1886 = 0.0f;
        EID4789PS_1887 = 0.00999999977648258209228515625f;
        EID4789PS_1888 = 0.0f;
        EID4789PS_1889 = EID4789PS_506;
        EID4789PS_1890 = EID4789PS_543;
        EID4789PS_1891 = EID4789PS_497;
    }
    float3 EID4789PS_2063;
    float EID4789PS_2064;
    float EID4789PS_2065;
    float3 EID4789PS_2066;
    float3 EID4789PS_2067;
    float EID4789PS_2068;
    [branch]
    if (EID4789PS_649 > 0.00999999977648258209228515625f)
    {
        bool3 EID4789PS_1895 = EID4789PS_472.xxx;
        float3 EID4789PS_1897 = EID4789PS_10.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 EID4789PS_1898 = float3(EID4789PS_1895.x ? EID4789PS_1897.x : EID4789PS_10.x, EID4789PS_1895.y ? EID4789PS_1897.y : EID4789PS_10.y, EID4789PS_1895.z ? EID4789PS_1897.z : EID4789PS_10.z);
        float3 EID4789PS_1901 = EID4789PS_1898 * EID4789PS_19_m89.z;
        float3 EID4789PS_1903 = float3(EID4789PS_1895.x ? EID4789PS_9.xzy.x : EID4789PS_9.x, EID4789PS_1895.y ? EID4789PS_9.xzy.y : EID4789PS_9.y, EID4789PS_1895.z ? EID4789PS_9.xzy.z : EID4789PS_9.z);
        float3 EID4789PS_1905 = abs(EID4789PS_1903) - 0.20000000298023223876953125f.xxx;
        float3 EID4789PS_1908 = max((EID4789PS_1905 * EID4789PS_1905) * EID4789PS_1905, 6.103515625e-05f.xxx);
        float3 EID4789PS_1911 = EID4789PS_1908 / dot(EID4789PS_1908, 1.0f.xxx).xxx;
        float EID4789PS_1927 = EID4789PS_1911.y;
        float EID4789PS_1929 = EID4789PS_1911.z;
        float EID4789PS_1932 = EID4789PS_1911.x;
        float4 EID4789PS_1934 = ((EID4789PS_55.SampleBias(EID4789_linear_repeat_sampler, EID4789PS_1901.xz, EID4789PS_19_m16) * EID4789PS_1927) + (EID4789PS_55.SampleBias(EID4789_linear_repeat_sampler, EID4789PS_1901.xy, EID4789PS_19_m16) * EID4789PS_1929)) + (EID4789PS_55.SampleBias(EID4789_linear_repeat_sampler, EID4789PS_1901.zy, EID4789PS_19_m16) * EID4789PS_1932);
        float EID4789PS_1935 = EID4789PS_1903.y;
        float EID4789PS_1942 = clamp(EID4789PS_649 + (smoothstep(0.3499999940395355224609375f, 0.20000000298023223876953125f, EID4789PS_1898.y) * clamp(EID4789PS_649 * 3.0f, 0.0f, 1.0f)), 0.0f, 1.0f);
        float EID4789PS_1953 = smoothstep(2.0f - EID4789PS_1942, 2.349999904632568359375f - EID4789PS_1942, ((EID4789PS_1935 * 0.64999997615814208984375f) + 0.3499999940395355224609375f) + EID4789PS_1934.z) * ((EID4789PS_504 * EID4789PS_504) * float(EID4789PS_gl_FrontFacing));
        float EID4789PS_1965 = lerp(1.0f, 0.5f, ((EID4789PS_1942 * (1.0f - smoothstep(0.3499999940395355224609375f, 0.100000001490116119384765625f, dot(EID4789PS_1891 * (1.0f - EID4789PS_502), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f))))) * EID4789PS_1934.w) * ((EID4789PS_1935 * 0.25f) + 0.75f));
        float3 EID4789PS_1967 = EID4789PS_1953.xxx;
        float2 EID4789PS_1973 = (EID4789PS_1934.xy * 2.0f) - 1.0f.xx;
        float3 EID4789PS_1974 = float3(EID4789PS_1973.x, EID4789PS_1973.y, EID4789PS_425.z);
        float2 EID4789PS_1975 = EID4789PS_1973.xy;
        EID4789PS_1974.z = max(1.000000016862383526387164645044e-16f, sqrt(1.0f - clamp(dot(EID4789PS_1975, EID4789PS_1975), 0.0f, 1.0f)));
        float2 EID4789PS_1983 = EID4789PS_1974.xy * 2.0f;
        float3 EID4789PS_1985 = lerp(float3(0.0f, 0.0f, 1.0f), float3(EID4789PS_1983.x, EID4789PS_1983.y, EID4789PS_1974.z), EID4789PS_1967);
        float3 EID4789PS_1989 = EID4789PS_1985 * rsqrt(max(6.103515625e-05f, dot(EID4789PS_1985, EID4789PS_1985)));
        float EID4789PS_1990 = EID4789PS_610.y;
        float EID4789PS_1993 = step(0.00999999977648258209228515625f, 1.0f - (EID4789PS_1990 * EID4789PS_1990));
        float EID4789PS_1997 = lerp(EID4789PS_610.z, EID4789PS_1990, EID4789PS_1993);
        float3 EID4789PS_2004 = (float3(0.0f, EID4789PS_1993, 1.0f - EID4789PS_1993) - (EID4789PS_610 * EID4789PS_1997)) * rsqrt(max(9.9999997473787516355514526367188e-05f, 1.0f - (EID4789PS_1997 * EID4789PS_1997)));
        float3 EID4789PS_2018 = EID4789PS_1901 * 4.0f;
        float4 EID4789PS_2038 = ((EID4789PS_56.SampleLevel(EID4789_point_repeat_sampler, EID4789PS_2018.xz, 0.0f) * EID4789PS_1927) + (EID4789PS_56.SampleLevel(EID4789_point_repeat_sampler, EID4789PS_2018.xy, 0.0f) * EID4789PS_1929)) + (EID4789PS_56.SampleLevel(EID4789_point_repeat_sampler, EID4789PS_2018.zy, 0.0f) * EID4789PS_1932);
        float2 EID4789PS_2041 = (EID4789PS_2038.xz * 2.0f) - 1.0f.xx;
        float EID4789PS_2052 = smoothstep(0.949999988079071044921875f, 1.0f, frac(((dot(float3(EID4789PS_2041.x, EID4789PS_2038.y, EID4789PS_2041.y), (floor(EID4789PS_463 * 50.0f) * 0.0199999995529651641845703125f) * 0.100000001490116119384765625f) * 0.5f) + 0.5f) * 2.0f));
        float EID4789PS_2053 = EID4789PS_2052 * EID4789PS_2052;
        float EID4789PS_2056 = EID4789PS_2053 * ((EID4789PS_2053 * 2.0f) * EID4789PS_1953);
        float3 EID4789PS_2057 = 1.0f.xxx * EID4789PS_2056;
        EID4789PS_2063 = ((cross(EID4789PS_2004, EID4789PS_610) * EID4789PS_1989.x) + (EID4789PS_2004 * EID4789PS_1989.y)) + (EID4789PS_610 * EID4789PS_1989.z);
        EID4789PS_2064 = EID4789PS_1888 + EID4789PS_2056;
        EID4789PS_2065 = lerp(lerp(EID4789PS_1889, 0.89999997615814208984375f, clamp(EID4789PS_1953 * 4.0f, 0.0f, 1.0f)), 0.00999999977648258209228515625f, EID4789PS_2056);
        EID4789PS_2066 = lerp(EID4789PS_1890 * EID4789PS_1965, 0.3079999983310699462890625f.xxx, EID4789PS_1967) + (EID4789PS_2057 * 0.5f);
        EID4789PS_2067 = lerp(EID4789PS_1891 * EID4789PS_1965, 0.87999999523162841796875f.xxx, EID4789PS_1967) + EID4789PS_2057;
        EID4789PS_2068 = lerp(EID4789PS_502, 0.0f, EID4789PS_1953);
    }
    else
    {
        EID4789PS_2063 = EID4789PS_610;
        EID4789PS_2064 = EID4789PS_1888;
        EID4789PS_2065 = EID4789PS_1889;
        EID4789PS_2066 = EID4789PS_1890;
        EID4789PS_2067 = EID4789PS_1891;
        EID4789PS_2068 = EID4789PS_502;
    }
    float EID4789PS_2070 = 0.959999978542327880859375f - (EID4789PS_2068 * 0.959999978542327880859375f);
    float3 EID4789PS_2071 = EID4789PS_2067 * EID4789PS_2070;
    float3 EID4789PS_2074 = lerp(0.039999999105930328369140625f.xxx * EID4789PS_501.y, EID4789PS_2067, EID4789PS_2068.xxx);
    float3 EID4789PS_2075 = EID4789PS_2066 * EID4789PS_2070;
    float EID4789PS_2077 = max(EID4789PS_2065 * EID4789PS_2065, 0.0078125f);
    float EID4789PS_2078 = EID4789PS_2077 * EID4789PS_2077;
    float2 EID4789PS_2091 = (EID4789PS_7.xy / max(EID4789PS_7.z, 9.9999999392252902907785028219223e-09f).xx) - (EID4789PS_8.xy / max(EID4789PS_8.z, 9.9999999392252902907785028219223e-09f).xx);
    EID4789PS_2091.y = -EID4789PS_2091.y;
    float2 EID4789PS_2104 = ((sqrt(sqrt(abs(EID4789PS_2091 * 0.5f))) * float2(int2(sign(EID4789PS_2091)))) * 0.5f) + 0.5f.xx;
    float4 EID4789PS_2107 = float4(EID4789PS_2104.x, EID4789PS_2104.y, 0.0f.xxxx.z, 0.0f.xxxx.w);
    EID4789PS_2107.z = 1.0f;
    EID4789PS_2107.w = (EID4789PS_2064 > 0.100000001490116119384765625f) ? 0.699999988079071044921875f : 0.4000000059604644775390625f;
    float3 EID4789PS_2120 = lerp(-EID4789PS_36_m0.xyz, EID4789PS_19_m90.xyz, EID4789PS_19_m80.w.xxx);
    float3 EID4789PS_2124 = normalize(float3(EID4789PS_2120.x, 6.103515625e-05f, EID4789PS_2120.z));
    float3 EID4789PS_2134 = lerp(EID4789PS_36_m3.xyz, EID4789PS_19_m84.xyz, EID4789PS_19_m91.y.xxx);
    float3 EID4789PS_2138 = EID4789PS_2134 * lerp(EID4789PS_36_m3.w, 1.0f, EID4789PS_19_m91.w);
    int EID4789PS_2142 = int(EID4789PS_613.x);
    int EID4789PS_2143 = int(EID4789PS_613.y);
    // Separate the fixed RenderDoc replay texture from CP20's per-camera live override.
    // Never index a captured screen texture with SceneView pixel coordinates.
    float4 EID4789PS_2147;
    if (_EID4789UseCapturedScreen40 > 0.5f)
        EID4789PS_2147 = capturedScreenValid ? _EID4789CapturedScreen40.Load(int3(int2(capturedPixel), 0)) : float4(1,1,0,0);
    else
        EID4789PS_2147 = EID4789PS_40.Load(int3(EID4789PS_2142, EID4789PS_2143, 0));
    float EID4789PS_2152 = EID4789PS_2147.y;
    float EID4789PS_2155 = lerp(lerp(1.0f, EID4789PS_2147.x, EID4789PS_38_m6.x), 1.0f, EID4789PS_19_m80.z);
    float EID4789PS_2156 = dot(EID4789PS_2063, EID4789PS_2120);
    float3 EID4789PS_2163 = EID4789PS_2075 * EID4789PS_19_m79.z;
    float3 EID4789PS_2164 = EID4789PS_2163 * 0.64999997615814208984375f;
    float EID4789PS_2168 = dot(EID4789PS_2071, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float EID4789PS_2181 = clamp(-dot(EID4789PS_2124.xz, normalize(EID4789PS_623.xz)), 0.0f, 1.0f);
    float EID4789PS_2185 = 1.0f - EID4789PS_19_m91.x;
    float4 EID4789PS_2199 = EID4789PS_50.SampleLevel(EID4789_linear_clamp_sampler, float2((clamp(lerp(EID4789PS_2156, ((-EID4789PS_2156) * ((EID4789PS_2156 * 0.5f) - 1.0f)) + 0.5f, (EID4789PS_2181 * smoothstep(0.25f, 0.75f, 1.0f - abs(EID4789PS_623.y))) * EID4789PS_2185) + (EID4789PS_19_m90.w * EID4789PS_19_m91.x), -1.0f, 1.0f) * 0.5f) + 0.5f, 0.5f), 0.0f);
    float EID4789PS_2200 = EID4789PS_2199.w;
    float EID4789PS_2202 = EID4789PS_2199.x;
    float EID4789PS_2203 = EID4789PS_2199.y;
    float EID4789PS_2204 = EID4789PS_2199.z;
    float EID4789PS_2209 = max(max(EID4789PS_2202, EID4789PS_2203), EID4789PS_2204) - min(min(EID4789PS_2202, EID4789PS_2203), EID4789PS_2204);
    float4 EID4789PS_2217 = EID4789PS_50.SampleLevel(EID4789_linear_clamp_sampler, float2((dot(EID4789PS_2063, EID4789PS_623) * 0.5f) + 0.5f, 0.5f), 0.0f);
    float EID4789PS_2218 = EID4789PS_2217.w;
    float EID4789PS_2219 = EID4789PS_504 * EID4789PS_2152;
    float EID4789PS_2226 = min(min(EID4789PS_2152, EID4789PS_504), EID4789PS_2200);
    float EID4789PS_2227 = EID4789PS_2218 * EID4789PS_2219;
    float3 EID4789PS_2231 = ((clamp(dot(EID4789PS_610, EID4789PS_19_m85.xyz) + EID4789PS_19_m86.x, 0.0f, 1.0f) * EID4789PS_19_m86.y) + EID4789PS_19_m86.z).xxx * lerp(EID4789PS_1164, 1.0f.xxx, (EID4789PS_19_m80.y * EID4789PS_2226).xxx);
    float3 EID4789PS_2233 = EID4789PS_2226.xxx;
    float3 EID4789PS_2256 = EID4789PS_2155.xxx;
    float3 EID4789PS_2257 = lerp((EID4789PS_2231 * lerp(min(lerp(0.64999997615814208984375f, 1.0f, EID4789PS_1165), 1.5f), clamp(EID4789PS_1165, 1.25f, 1.75f), EID4789PS_19_m80.x)) * EID4789PS_19_m79.w, (lerp(dot(EID4789PS_2138, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, EID4789PS_2138, EID4789PS_2233) + ((EID4789PS_2231 * clamp(EID4789PS_1165, 0.0f, 1.5f)) * ((1.0f - EID4789PS_19_m91.y).xxx + (EID4789PS_2134 * EID4789PS_19_m91.y)))) * EID4789PS_19_m79.y, EID4789PS_2256);
    float3 EID4789PS_2258 = lerp(lerp(lerp(dot(EID4789PS_2164, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, EID4789PS_2164, 1.2000000476837158203125f.xxx), EID4789PS_2163, clamp((EID4789PS_2219 * EID4789PS_2218) + EID4789PS_2200, 0.0f, 1.0f).xxx), EID4789PS_2071, EID4789PS_2233);
    float3 EID4789PS_2264 = EID4789PS_2258 * ((1.0f - EID4789PS_2209).xxx + (EID4789PS_2199.xyz * EID4789PS_2209));
    float3 EID4789PS_2273 = lerp(lerp(EID4789PS_2163, lerp(EID4789PS_2168.xxx, EID4789PS_2071, 1.2000000476837158203125f.xxx), EID4789PS_2227.xxx), EID4789PS_2264 * clamp(dot(EID4789PS_2258, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)) * (1.0f / max(dot(EID4789PS_2264, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)), 0.001000000047497451305389404296875f)), 0.0f, 1.5f), EID4789PS_2256);
    float4 EID4789PS_2277 = float4(EID4789PS_2273, EID4789PS_2155);
    float EID4789PS_2279 = lerp(EID4789PS_2227, EID4789PS_2226, EID4789PS_2155);
    float EID4789PS_2282 = lerp(EID4789PS_19_m79.z, 1.0f, EID4789PS_2279);
    float3 EID4789PS_2290 = float3(EID4789PS_623.x, lerp(0.5f, EID4789PS_2120.y, EID4789PS_2155), EID4789PS_623.z);
    float EID4789PS_2303 = clamp(dot(EID4789PS_1885, EID4789PS_463), 0.0f, 1.0f);
    float EID4789PS_2304 = dot(EID4789PS_1885, normalize(((EID4789PS_2120 * EID4789PS_2155) + ((EID4789PS_2290 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(EID4789PS_2290, EID4789PS_2290)))) * 2.0f)) + (EID4789PS_463 * (2.0f + EID4789PS_2155))));
    float EID4789PS_2308 = (((EID4789PS_2304 * EID4789PS_2078) - EID4789PS_2304) * EID4789PS_2304) + 1.0f;
    float EID4789PS_2309 = EID4789PS_2308 * EID4789PS_2308;
    float EID4789PS_2312 = (EID4789PS_2078 != EID4789PS_2309) ? (EID4789PS_2078 / EID4789PS_2309) : 1.0f;
    float EID4789PS_2313 = 2.0f * EID4789PS_2303;
    float EID4789PS_2315 = (1.0f + EID4789PS_2303) - EID4789PS_2303;
    float EID4789PS_2324 = EID4789PS_2303 * EID4789PS_2303;
    float3 EID4789PS_2336 = EID4789PS_2074 * EID4789PS_51.SampleLevel(EID4789_linear_clamp_sampler, float2(lerp(EID4789PS_2312 / min(1.0f / (EID4789PS_2078 + 9.9999997473787516355514526367188e-05f), 65504.0f), EID4789PS_2324, EID4789PS_49_m4), EID4789PS_2065 * (1.0f - EID4789PS_2068)), 0.0f).xyz;
    float3 EID4789PS_2338 = lerp(EID4789PS_2074, EID4789PS_2336, EID4789PS_49_m4.xxx);
    float EID4789PS_2351 = (1.0f - EID4789PS_49_m6) + (EID4789PS_510 * EID4789PS_49_m6);
    float3 EID4789PS_2353 = ((EID4789PS_2257 * EID4789PS_2273) * EID4789PS_2351) + (((EID4789PS_2336 * clamp((EID4789PS_2312 * (0.5f / ((EID4789PS_2313 + (EID4789PS_2077 * EID4789PS_2315)) + 9.9999997473787516355514526367188e-05f))) - 6.103515625e-05f, 0.0f, 20.0f)) * ((EID4789PS_2257 * (((EID4789PS_2279 * 0.5f) + 0.5f) * EID4789PS_2282)) * 1.0f)) * EID4789PS_19_m92.w);
    float EID4789PS_2354 = dot(EID4789PS_2353, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float EID4789PS_2357 = clamp(EID4789PS_2354 - 0.5f, 0.0f, 0.5f);
    float3 EID4789PS_2393 = normalize(cross(EID4789PS_623, lerp(float3(EID4789PS_19_m88.xy, 0.0f), (float3(EID4789PS_17_m0[0].x, EID4789PS_17_m0[0].y, EID4789PS_17_m0[0].z) * EID4789PS_19_m88.x) + (float3(EID4789PS_17_m0[1].x, EID4789PS_17_m0[1].y, EID4789PS_17_m0[1].z) * EID4789PS_19_m88.y), EID4789PS_19_m94.w.xxx)));
    float EID4789PS_2399 = dot(EID4789PS_463, EID4789PS_2063);
    float EID4789PS_2401 = 1.0f - abs(EID4789PS_2399);
    float EID4789PS_2423 = dot(EID4789PS_2124, EID4789PS_2063);
    float EID4789PS_2435 = 1.0f - EID4789PS_2155;
    float EID4789PS_2462 = lerp(EID4789PS_2065, EID4789PS_1887, EID4789PS_1886);
    float EID4789PS_2463 = EID4789PS_2462 * EID4789PS_2462;
    float EID4789PS_2464 = EID4789PS_2324 * EID4789PS_2303;
    float2 EID4789PS_2465 = float2(1.0f, EID4789PS_2303);
    float2 EID4789PS_2468 = float2(1.0f, EID4789PS_2463);
    float3 EID4789PS_2471 = float3(1.0f, EID4789PS_2463, (EID4789PS_2463 * EID4789PS_2463) * EID4789PS_2463);
    float EID4789PS_2476 = dot(mul(EID4789PS_2465, float2x2(float2(0.0365463010966777801513671875f, 9.0631999969482421875f), float2(3.3270699977874755859375f, -9.0475597381591796875f))), EID4789PS_2468) / dot(mul(float3(1.0f, EID4789PS_2324, EID4789PS_2464), float3x3(float3(1.0f, 9.044010162353515625f, 5.565889835357666015625f), float3(3.596849918365478515625f, -16.3173999786376953125f, 19.788600921630859375f), float3(-1.36772000789642333984375f, 9.2294902801513671875f, -20.212299346923828125f))), EID4789PS_2471);
    float EID4789PS_2481 = dot(mul(EID4789PS_2465, float2x2(float2(0.99044001102447509765625f, 1.29677999019622802734375f), float2(-1.28514003753662109375f, -0.755906999111175537109375f))), EID4789PS_2468) / dot(mul(float3(1.0f, EID4789PS_2303, EID4789PS_2464), float3x3(float3(1.0f, 20.3225002288818359375f, 121.5630035400390625f), float3(2.9233798980712890625f, -27.0301990509033203125f, 626.1300048828125f), float3(59.41880035400390625f, 222.5919952392578125f, 316.62701416015625f))), EID4789PS_2471);
    float3 EID4789PS_2484 = (EID4789PS_2338 * EID4789PS_2476) + EID4789PS_2481.xxx;
    float EID4789PS_2485 = EID4789PS_2476 + EID4789PS_2481;
    float3 EID4789PS_2491 = -EID4789PS_463;
    float3 EID4789PS_2510 = lerp(EID4789PS_2354.xxx, EID4789PS_2353, ((EID4789PS_2357 * EID4789PS_2357) + 1.0f).xxx) + (((((EID4789PS_19_m87.xyz * smoothstep(lerp(0.800000011920928955078125f, 0.20000000298023223876953125f, EID4789PS_19_m88.w), lerp(0.89999997615814208984375f, 0.5f, EID4789PS_19_m88.w), EID4789PS_2401)) * EID4789PS_19_m87.w) * min(min(clamp(dot(EID4789PS_590, EID4789PS_2393) + 1.0f, 0.0f, 1.0f), EID4789PS_504), EID4789PS_2152)) * (lerp(0.25f.xxx, EID4789PS_2071, EID4789PS_19_m88.z.xxx) * clamp(dot(EID4789PS_2393, EID4789PS_2063), 0.0f, 1.0f))) + ((((((lerp(EID4789PS_1163 * (1.0f / max(max(max(EID4789PS_1163.x, EID4789PS_1163.y), EID4789PS_1163.z) * 0.5f, 1.0f)), EID4789PS_2138, EID4789PS_2256) * clamp(lerp(dot(EID4789PS_1162.xyz, EID4789PS_2063) * EID4789PS_1162.w, ((-EID4789PS_2423) * ((EID4789PS_2423 * 0.5f) - 1.0f)) + 0.5f, EID4789PS_2155), 0.0f, 1.0f)) * ((EID4789PS_2435 + (EID4789PS_2181 * EID4789PS_2155)) * EID4789PS_2185)) * smoothstep(0.60000002384185791015625f, 0.800000011920928955078125f, EID4789PS_2401)) * min(EID4789PS_504, EID4789PS_2152)) * (EID4789PS_2435 + (smoothstep(0.100000001490116119384765625f, 0.039999999105930328369140625f, EID4789PS_2168) * EID4789PS_2155))) * max(0.1500000059604644775390625f.xxx, EID4789PS_2071)));
    float2 EID4789PS_2513 = clamp(capturedPixel, 0.0f, EID4789PS_19_m0.xy - 1.0f);
    float2 EID4789PS_2515 = floor(EID4789PS_2513 * 0.03125f);
    int EID4789PS_2523 = int((EID4789PS_2515.x + (EID4789PS_2515.y * EID4789PS_34_m5)) * 8.0f);
    float EID4789PS_2530 = floor(EID4789PS_444 - (EID4789PS_19_m3.y * EID4789PS_34_m11));
    float EID4789PS_2534 = clamp(EID4789PS_2530, 0.0f, EID4789PS_34_m7 - 1.0f);
    int EID4789PS_2536 = int(EID4789PS_2534 * 8.0f);
    float3 EID4789PS_2538;
    EID4789PS_2538 = (EID4789PS_2510 + (((EID4789PS_571.xyz * EID4789PS_49_m25.xyz) * EID4789PS_49_m7) * EID4789PS_2351)) + (((EID4789PS_62.SampleLevel(EID4789_linear_clamp_sampler, reflect(EID4789PS_2491, EID4789PS_1885), (1.2000000476837158203125f * log2(max(EID4789PS_2462, 0.001000000047497451305389404296875f))) + 5.0f).xyz * ((EID4789PS_2484 + ((EID4789PS_2338 * ((1.0f - EID4789PS_2485) / EID4789PS_2485)) * EID4789PS_2484)) * 1.0f)) * ((clamp(EID4789PS_1165, 0.5f, 1.5f) * EID4789PS_19_m79.w) * EID4789PS_2282)) * EID4789PS_1164);
    float3 EID4789PS_2539;
    [loop]
    for (int EID4789PS_2541 = 0; EID4789PS_2541 <= 7; EID4789PS_2538 = EID4789PS_2539, EID4789PS_2541++)
    {
        uint EID4789PS_2559 = (capturedScreenValid && EID4789PS_2530 <= EID4789PS_2534) ? (EID4789PS_30.Load(uint(EID4789PS_2523 + EID4789PS_2541) * 4 + 0) & EID4789PS_30.Load(uint((EID4789PS_19_m21.y + EID4789PS_2536) + EID4789PS_2541) * 4 + 0)) : 0u;
        uint EID4789PS_2560 = uint(EID4789PS_2541);
        EID4789PS_2539 = EID4789PS_2538;
        uint EID4789PS_2565;
        float3 EID4789PS_2562;
        [loop]
        for (uint EID4789PS_2564 = EID4789PS_2559; EID4789PS_2564 != 0u; EID4789PS_2539 = EID4789PS_2562, EID4789PS_2564 = EID4789PS_2565)
        {
            uint EID4789PS_2569 = firstbitlow(EID4789PS_2564);
            EID4789PS_2565 = EID4789PS_2564 ^ (1u << (EID4789PS_2569 & 31u));
            int EID4789PS_2575 = int((32u * EID4789PS_2560) + EID4789PS_2569) * 8;
            int EID4789PS_2578 = EID4789PS_2575 + 1;
            int EID4789PS_2581 = EID4789PS_2575 + 2;
            int EID4789PS_2584 = EID4789PS_2575 + 3;
            int EID4789PS_2587 = EID4789PS_2575 + 4;
            int EID4789PS_2590 = EID4789PS_2575 + 5;
            int EID4789PS_2593 = EID4789PS_2575 + 6;
            int EID4789PS_2596 = EID4789PS_2575 + 7;
            uint EID4789PS_2600 = uint(EID4789PS_36_m6[EID4789PS_2590].w);
            float EID4789PS_2675;
            if ((EID4789PS_2600 & 1u) == 1u)
            {
                uint EID4789PS_2606 = asuint(EID4789PS_36_m6[EID4789PS_2590].x);
                uint EID4789PS_2613 = asuint(EID4789PS_36_m6[EID4789PS_2590].y);
                uint EID4789PS_2620 = asuint(EID4789PS_36_m6[EID4789PS_2590].z);
                uint EID4789PS_2627 = asuint(EID4789PS_36_m6[EID4789PS_2593].x);
                uint EID4789PS_2634 = asuint(EID4789PS_36_m6[EID4789PS_2593].y);
                uint EID4789PS_2641 = asuint(EID4789PS_36_m6[EID4789PS_2593].z);
                float3 EID4789PS_2660 = abs(mul(float4(EID4789PS_583 - EID4789PS_36_m6[EID4789PS_2578].xyz, 1.0f), float4x4(float4(EID4789PS_spvUnpackHalf2x16(EID4789PS_2606).x, EID4789PS_spvUnpackHalf2x16(EID4789PS_2620).x, EID4789PS_spvUnpackHalf2x16(EID4789PS_2634).x, 0.0f), float4(EID4789PS_spvUnpackHalf2x16(EID4789PS_2606 >> 16u).x, EID4789PS_spvUnpackHalf2x16(EID4789PS_2620 >> 16u).x, EID4789PS_spvUnpackHalf2x16(EID4789PS_2634 >> 16u).x, 0.0f), float4(EID4789PS_spvUnpackHalf2x16(EID4789PS_2613).x, EID4789PS_spvUnpackHalf2x16(EID4789PS_2627).x, EID4789PS_spvUnpackHalf2x16(EID4789PS_2641).x, 0.0f), float4(EID4789PS_spvUnpackHalf2x16(EID4789PS_2613 >> 16u).x, EID4789PS_spvUnpackHalf2x16(EID4789PS_2627 >> 16u).x, EID4789PS_spvUnpackHalf2x16(EID4789PS_2641 >> 16u).x, 0.0f))).xyz);
                float EID4789PS_2667 = EID4789PS_36_m6[EID4789PS_2596].x * 0.5f;
                float EID4789PS_2673 = 1.0f - clamp((max(max(EID4789PS_2660.x, EID4789PS_2660.y), EID4789PS_2660.z) - (EID4789PS_2667 + 0.5f)) / (0.5f - EID4789PS_2667), 0.0f, 1.0f);
                EID4789PS_2675 = EID4789PS_2673 * EID4789PS_2673;
            }
            else
            {
                EID4789PS_2675 = 1.0f;
            }
            if (false || (EID4789PS_2675 < 0.001000000047497451305389404296875f))
            {
                EID4789PS_2562 = EID4789PS_2539;
                continue;
            }
            float3 EID4789PS_3368;
            if (EID4789PS_36_m6[EID4789PS_2575].w < 1.5f)
            {
                float3 EID4789PS_3367;
                do
                {
                    uint EID4789PS_2688 = asuint(EID4789PS_36_m6[EID4789PS_2584].w);
                    if ((EID4789PS_2688 == 16u) || ((EID4789PS_36_m6[EID4789PS_2584].z + EID4789PS_19_m91.z) < 0.5f))
                    {
                        EID4789PS_3367 = EID4789PS_2539;
                        break;
                    }
                    bool EID4789PS_2700 = (uint(EID4789PS_36_m6[EID4789PS_2575].w) & 1u) == 0u;
                    bool EID4789PS_2704 = (!EID4789PS_2700) && (EID4789PS_36_m6[EID4789PS_2581].z > 0.0f);
                    bool EID4789PS_2705 = EID4789PS_2688 == 4u;
                    float EID4789PS_2706 = float(EID4789PS_2700);
                    float EID4789PS_2714 = (0.5f + (0.5f * EID4789PS_36_m6[EID4789PS_2581].y)) - abs(EID4789PS_36_m6[EID4789PS_2581].x);
                    float EID4789PS_2715 = EID4789PS_36_m6[EID4789PS_2581].y - EID4789PS_2714;
                    float EID4789PS_2722 = abs(max((1.0f - abs(EID4789PS_2714)) - abs(EID4789PS_2715), 0.00048828125f));
                    float3 EID4789PS_2726 = normalize(float3(EID4789PS_2714, EID4789PS_2715, (EID4789PS_36_m6[EID4789PS_2581].x >= 0.0f) ? EID4789PS_2722 : (-EID4789PS_2722)));
                    float EID4789PS_2732 = lerp(EID4789PS_36_m6[EID4789PS_2593].w, max(2.0f * EID4789PS_36_m6[EID4789PS_2587].y, 0.100000001490116119384765625f), float(EID4789PS_2705));
                    float3 EID4789PS_2737 = EID4789PS_36_m6[EID4789PS_2578].xyz - EID4789PS_583;
                    float3 EID4789PS_2738 = -EID4789PS_2726;
                    float3 EID4789PS_2743 = lerp(EID4789PS_2737, EID4789PS_2738 * dot(EID4789PS_2737, EID4789PS_2738), (float(EID4789PS_2705 && (EID4789PS_36_m6[EID4789PS_2587].z > 0.5f)) * EID4789PS_2706).xxx);
                    float EID4789PS_2744 = dot(EID4789PS_2743, EID4789PS_2743);
                    float EID4789PS_2745 = rsqrt(EID4789PS_2744);
                    float3 EID4789PS_2746 = EID4789PS_2743 * EID4789PS_2745;
                    float3 EID4789PS_2779;
                    float EID4789PS_2780;
                    if (EID4789PS_2704)
                    {
                        float3 EID4789PS_2750 = (EID4789PS_2726 * EID4789PS_36_m6[EID4789PS_2581].z) * 0.5f;
                        float3 EID4789PS_2751 = EID4789PS_2743 - EID4789PS_2750;
                        float3 EID4789PS_2752 = EID4789PS_2743 + EID4789PS_2750;
                        float EID4789PS_2753 = length(EID4789PS_2751);
                        float EID4789PS_2754 = length(EID4789PS_2752);
                        float3 EID4789PS_2763 = normalize(cross(cross(EID4789PS_2726, EID4789PS_2746), EID4789PS_2726));
                        EID4789PS_2779 = EID4789PS_2763;
                        EID4789PS_2780 = ((1.0f / ((((EID4789PS_2753 * EID4789PS_2754) + dot(EID4789PS_2751, EID4789PS_2752)) * 0.5f) + 1.0f)) * clamp(0.5f * ((dot(EID4789PS_2763, EID4789PS_2751) / EID4789PS_2753) + (dot(EID4789PS_2763, EID4789PS_2752) / EID4789PS_2754)), 0.0f, 1.0f)) * (1.0f / clamp(1.0f + (0.5f * clamp(EID4789PS_36_m6[EID4789PS_2581].z * EID4789PS_2745, 0.0f, 1.0f)), 0.0f, 1.0f));
                    }
                    else
                    {
                        EID4789PS_2779 = EID4789PS_2746;
                        EID4789PS_2780 = 1.0f;
                    }
                    float EID4789PS_2802;
                    if (EID4789PS_2732 < 0.0f)
                    {
                        float EID4789PS_2790 = EID4789PS_2744 * (EID4789PS_36_m6[EID4789PS_2578].w * EID4789PS_36_m6[EID4789PS_2578].w);
                        float EID4789PS_2793 = clamp(1.0f - (EID4789PS_2790 * EID4789PS_2790), 0.0f, 1.0f);
                        EID4789PS_2802 = lerp(1.0f / (EID4789PS_2744 + 1.0f), EID4789PS_2780, float(EID4789PS_2704)) * (EID4789PS_2793 * EID4789PS_2793);
                    }
                    else
                    {
                        float3 EID4789PS_2796 = EID4789PS_2743 * EID4789PS_36_m6[EID4789PS_2578].w;
                        EID4789PS_2802 = EID4789PS_2780 * pow(1.0f - clamp(dot(EID4789PS_2796, EID4789PS_2796), 0.0f, 1.0f), EID4789PS_2732);
                    }
                    float EID4789PS_2807 = clamp((dot(EID4789PS_2779, EID4789PS_2738) - EID4789PS_36_m6[EID4789PS_2581].z) * EID4789PS_36_m6[EID4789PS_2581].w, 0.0f, 1.0f);
                    float EID4789PS_2810 = EID4789PS_2802 * lerp(1.0f, EID4789PS_2807 * EID4789PS_2807, EID4789PS_2706);
                    int EID4789PS_2812 = int(EID4789PS_36_m6[EID4789PS_2596].w);
                    float EID4789PS_2916;
                    if ((!EID4789PS_2704) && (EID4789PS_2812 >= 0))
                    {
                        uint EID4789PS_2818 = uint(EID4789PS_2812);
                        float2 EID4789PS_2909;
                        [branch]
                        if (EID4789PS_2706 != 0.0f)
                        {
                            float4 EID4789PS_2830 = mul(EID4789PS_65_m1[EID4789PS_2818], float4(EID4789PS_583.x, EID4789PS_655, EID4789PS_583.z, 1.0f));
                            EID4789PS_2909 = EID4789PS_65_m0[EID4789PS_2818].xy + (clamp(EID4789PS_2830.xy / EID4789PS_2830.w.xx, 0.0f.xx, 1.0f.xx) * EID4789PS_65_m0[EID4789PS_2818].zw);
                        }
                        else
                        {
                            float3 EID4789PS_2850 = mul(float4(-EID4789PS_2743, 0.0f), EID4789PS_65_m1[EID4789PS_2818]).xyz;
                            float3 EID4789PS_433 = EID4789PS_2850;
                            float3 EID4789PS_432 = EID4789PS_2850;
                            float3 EID4789PS_431 = abs(EID4789PS_2850);
                            uint EID4789PS_2859 = uint(int(EID4789PS_431.y > EID4789PS_431.x));
                            uint EID4789PS_2865 = (EID4789PS_431.z > EID4789PS_431[EID4789PS_2859]) ? 2u : EID4789PS_2859;
                            uint EID4789PS_2871 = (EID4789PS_2865 * 2u) + uint(EID4789PS_432[EID4789PS_2865] < 0.0f);
                            float EID4789PS_2875 = abs(EID4789PS_433[EID4789PS_2871 / 2u]);
                            float EID4789PS_2895 = 0.5f - (0.000244140625f / EID4789PS_65_m0[EID4789PS_2818].w);
                            EID4789PS_2909 = EID4789PS_65_m0[EID4789PS_2818].xy + (clamp(float2((float(EID4789PS_2871) + ((((EID4789PS_433[uint(EID4789PS_378[EID4789PS_2871].x)] * EID4789PS_379[EID4789PS_2871].x) / EID4789PS_2875) * EID4789PS_2895) + 0.5f)) * 0.16666667163372039794921875f, 0.5f - (((EID4789PS_433[uint(EID4789PS_378[EID4789PS_2871].y)] * EID4789PS_379[EID4789PS_2871].y) / EID4789PS_2875) * EID4789PS_2895)), 0.0f.xx, 1.0f.xx) * EID4789PS_65_m0[EID4789PS_2818].zw);
                        }
                        EID4789PS_2916 = EID4789PS_2810 * EID4789PS_63.SampleLevel(EID4789_linear_clamp_sampler, EID4789PS_2909, 0.0f).x;
                    }
                    else
                    {
                        EID4789PS_2916 = EID4789PS_2810;
                    }
                    float EID4789PS_2917 = EID4789PS_2916 * EID4789PS_2675;
                    float3 EID4789PS_3366;
                    do
                    {
                        float3 EID4789PS_3365;
                        [branch]
                        if (EID4789PS_2917 > 9.9999997473787516355514526367188e-05f)
                        {
                            [branch]
                            if (EID4789PS_2705)
                            {
                                EID4789PS_3366 = lerp(EID4789PS_2539, EID4789PS_36_m6[EID4789PS_2575].xyz, (EID4789PS_2917 * (EID4789PS_36_m6[EID4789PS_2587].x * ((1.0f - EID4789PS_36_m6[EID4789PS_2587].w) + (smoothstep(-0.5f, 0.5f, dot(EID4789PS_611, EID4789PS_2779)) * EID4789PS_36_m6[EID4789PS_2587].w)))).xxx);
                                break;
                            }
                            float EID4789PS_2937 = dot(EID4789PS_2063, EID4789PS_2779);
                            float EID4789PS_2938 = clamp(EID4789PS_2937, 0.0f, 1.0f);
                            float EID4789PS_3241;
                            if (EID4789PS_2688 != 0u)
                            {
                                bool EID4789PS_2944 = EID4789PS_2700 || ((EID4789PS_2600 & 2u) != 0u);
                                int EID4789PS_2993;
                                if (EID4789PS_2944)
                                {
                                    EID4789PS_2993 = int(EID4789PS_36_m6[EID4789PS_2584].x);
                                }
                                else
                                {
                                    uint EID4789PS_2950 = asuint(EID4789PS_36_m6[EID4789PS_2581].w);
                                    uint EID4789PS_2952 = asuint(EID4789PS_36_m6[EID4789PS_2584].x);
                                    float3 EID4789PS_2953 = EID4789PS_583 - EID4789PS_36_m6[EID4789PS_2578].xyz;
                                    float3 EID4789PS_2954 = abs(EID4789PS_2953);
                                    float EID4789PS_2955 = EID4789PS_2954.x;
                                    float EID4789PS_2956 = EID4789PS_2954.y;
                                    float EID4789PS_2958 = EID4789PS_2954.z;
                                    int EID4789PS_2990;
                                    if ((EID4789PS_2955 > EID4789PS_2956) && (EID4789PS_2955 > EID4789PS_2958))
                                    {
                                        EID4789PS_2990 = int((EID4789PS_2953.x > 0.0f) ? (EID4789PS_2950 >> 24u) : ((EID4789PS_2950 >> 16u) & 255u));
                                    }
                                    else
                                    {
                                        int EID4789PS_2989;
                                        if (EID4789PS_2956 > EID4789PS_2958)
                                        {
                                            EID4789PS_2989 = int((EID4789PS_2953.y > 0.0f) ? ((EID4789PS_2950 >> 8u) & 255u) : (EID4789PS_2950 & 255u));
                                        }
                                        else
                                        {
                                            EID4789PS_2989 = int((EID4789PS_2953.z > 0.0f) ? ((EID4789PS_2952 >> 8u) & 255u) : (EID4789PS_2952 & 255u));
                                        }
                                        EID4789PS_2990 = EID4789PS_2989;
                                    }
                                    EID4789PS_2993 = (EID4789PS_2990 < 80) ? EID4789PS_2990 : (-1);
                                }
                                bool EID4789PS_2994 = EID4789PS_2993 >= 0;
                                float EID4789PS_3240;
                                if (EID4789PS_2994)
                                {
                                    float3 EID4789PS_2998 = EID4789PS_583 - EID4789PS_36_m6[EID4789PS_2578].xyz;
                                    float4 EID4789PS_3018 = mul(EID4789PS_38_m10[EID4789PS_2993], float4((EID4789PS_583 - ((EID4789PS_2998 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(EID4789PS_2998, EID4789PS_2998)))) * EID4789PS_38_m11[EID4789PS_2993].x)) + (EID4789PS_611 * (EID4789PS_38_m11[EID4789PS_2993].y * 5.0f)), 1.0f));
                                    float EID4789PS_3019 = EID4789PS_3018.w;
                                    float3 EID4789PS_3022 = EID4789PS_3018.xyz / EID4789PS_3019.xxx;
                                    float2 EID4789PS_3023 = EID4789PS_3022.xy;
                                    float3 EID4789PS_3031 = EID4789PS_3022.xyz;
                                    bool3 EID4789PS_3032 = bool3(EID4789PS_3031.x <= 0.0f.xxx.x, EID4789PS_3031.y <= 0.0f.xxx.y, EID4789PS_3031.z <= 0.0f.xxx.z);
                                    bool3 EID4789PS_3033 = bool3(EID4789PS_3031.x >= 1.0f.xxx.x, EID4789PS_3031.y >= 1.0f.xxx.y, EID4789PS_3031.z >= 1.0f.xxx.z);
                                    float EID4789PS_3036 = EID4789PS_3022.z;
                                    float2 EID4789PS_3047 = ((EID4789PS_3023 * (EID4789PS_38_m12[EID4789PS_2993].zw - EID4789PS_38_m12[EID4789PS_2993].xy)) + EID4789PS_38_m12[EID4789PS_2993].xy).xy * EID4789PS_38_m13.zw;
                                    float2 EID4789PS_3049 = floor(EID4789PS_3047 + 0.5f.xx);
                                    float2 EID4789PS_3050 = EID4789PS_3047 - EID4789PS_3049;
                                    float EID4789PS_3052 = EID4789PS_3050.x + 0.5f;
                                    float EID4789PS_3053 = EID4789PS_3052 * EID4789PS_3052;
                                    float EID4789PS_3056 = 1.0f - EID4789PS_3050.x;
                                    float EID4789PS_3057 = min(EID4789PS_3050.x, 0.0f);
                                    float EID4789PS_3060 = EID4789PS_3050.x + 1.0f;
                                    float EID4789PS_3061 = max(EID4789PS_3050.x, 0.0f);
                                    float EID4789PS_3073 = EID4789PS_3050.y + 0.5f;
                                    float EID4789PS_3074 = EID4789PS_3073 * EID4789PS_3073;
                                    float EID4789PS_3077 = 1.0f - EID4789PS_3050.y;
                                    float EID4789PS_3078 = min(EID4789PS_3050.y, 0.0f);
                                    float EID4789PS_3081 = EID4789PS_3050.y + 1.0f;
                                    float EID4789PS_3082 = max(EID4789PS_3050.y, 0.0f);
                                    float3 EID4789PS_3094 = float3(0.1599999964237213134765625f * EID4789PS_3056, 0.1599999964237213134765625f * ((EID4789PS_3060 - (EID4789PS_3061 * EID4789PS_3061)) + 1.0f), EID4789PS_3053 * 0.07999999821186065673828125f);
                                    float3 EID4789PS_3095 = float3(0.1599999964237213134765625f * ((EID4789PS_3053 * 0.5f) - EID4789PS_3050.x), 0.1599999964237213134765625f * ((EID4789PS_3056 - (EID4789PS_3057 * EID4789PS_3057)) + 1.0f), 0.1599999964237213134765625f * EID4789PS_3060) + EID4789PS_3094;
                                    float3 EID4789PS_3097 = float3(0.1599999964237213134765625f * EID4789PS_3077, 0.1599999964237213134765625f * ((EID4789PS_3081 - (EID4789PS_3082 * EID4789PS_3082)) + 1.0f), EID4789PS_3074 * 0.07999999821186065673828125f);
                                    float3 EID4789PS_3098 = float3(0.1599999964237213134765625f * ((EID4789PS_3074 * 0.5f) - EID4789PS_3050.y), 0.1599999964237213134765625f * ((EID4789PS_3077 - (EID4789PS_3078 * EID4789PS_3078)) + 1.0f), 0.1599999964237213134765625f * EID4789PS_3081) + EID4789PS_3097;
                                    float3 EID4789PS_3104 = ((EID4789PS_3094 / EID4789PS_3095) + float3(-2.5f, -0.5f, 1.5f)) * EID4789PS_38_m13.xxx;
                                    float3 EID4789PS_3106 = ((EID4789PS_3097 / EID4789PS_3098) + float3(-2.5f, -0.5f, 1.5f)) * EID4789PS_38_m13.yyy;
                                    float2 EID4789PS_3108 = EID4789PS_3049 * EID4789PS_38_m13.xy;
                                    float EID4789PS_3109 = EID4789PS_3104.x;
                                    float EID4789PS_3110 = EID4789PS_3106.x;
                                    float EID4789PS_3113 = EID4789PS_3104.y;
                                    float EID4789PS_3116 = EID4789PS_3104.z;
                                    float EID4789PS_3119 = EID4789PS_3106.y;
                                    float EID4789PS_3126 = EID4789PS_3106.z;
                                    float EID4789PS_3133 = EID4789PS_3095.x;
                                    float EID4789PS_3134 = EID4789PS_3098.x;
                                    float EID4789PS_3136 = EID4789PS_3095.y;
                                    float EID4789PS_3138 = EID4789PS_3095.z;
                                    float EID4789PS_3140 = EID4789PS_3098.y;
                                    float EID4789PS_3144 = EID4789PS_3098.z;
                                    float EID4789PS_3202 = (((((((EID4789PS_3133 * EID4789PS_3134) * EID4789ShadowGreater( float3(EID4789PS_3108 + float2(EID4789PS_3109, EID4789PS_3110), EID4789PS_424).xy, EID4789PS_3036)) + ((EID4789PS_3136 * EID4789PS_3134) * EID4789ShadowGreater( float3(EID4789PS_3108 + float2(EID4789PS_3113, EID4789PS_3110), EID4789PS_424).xy, EID4789PS_3036))) + ((EID4789PS_3138 * EID4789PS_3134) * EID4789ShadowGreater( float3(EID4789PS_3108 + float2(EID4789PS_3116, EID4789PS_3110), EID4789PS_424).xy, EID4789PS_3036))) + ((EID4789PS_3133 * EID4789PS_3140) * EID4789ShadowGreater( float3(EID4789PS_3108 + float2(EID4789PS_3109, EID4789PS_3119), EID4789PS_424).xy, EID4789PS_3036))) + ((EID4789PS_3136 * EID4789PS_3140) * EID4789ShadowGreater( float3(EID4789PS_3108 + float2(EID4789PS_3113, EID4789PS_3119), EID4789PS_424).xy, EID4789PS_3036))) + ((EID4789PS_3138 * EID4789PS_3140) * EID4789ShadowGreater( float3(EID4789PS_3108 + float2(EID4789PS_3116, EID4789PS_3119), EID4789PS_424).xy, EID4789PS_3036))) + ((EID4789PS_3133 * EID4789PS_3144) * EID4789ShadowGreater( float3(EID4789PS_3108 + float2(EID4789PS_3109, EID4789PS_3126), EID4789PS_424).xy, EID4789PS_3036));
                                    float2 EID4789PS_3223 = min(EID4789PS_3023, 1.0f.xx - EID4789PS_3023);
                                    EID4789PS_3240 = EID4789PS_2994 ? lerp(1.0f, (any(bool3(EID4789PS_3032.x || EID4789PS_3033.x, EID4789PS_3032.y || EID4789PS_3033.y, EID4789PS_3032.z || EID4789PS_3033.z)) || ((asuint(EID4789PS_3036) & 2147483647u) > 2139095040u)) ? 1.0f : ((EID4789PS_3202 + ((EID4789PS_3136 * EID4789PS_3144) * EID4789ShadowGreater( float3(EID4789PS_3108 + float2(EID4789PS_3113, EID4789PS_3126), EID4789PS_424).xy, EID4789PS_3036))) + ((EID4789PS_3138 * EID4789PS_3144) * EID4789ShadowGreater( float3(EID4789PS_3108 + float2(EID4789PS_3116, EID4789PS_3126), EID4789PS_424).xy, EID4789PS_3036))), EID4789PS_2944 ? min(EID4789PS_38_m11[EID4789PS_2993].w, smoothstep(0.0f, 0.0500000007450580596923828125f, min((EID4789PS_38_m11[EID4789PS_2993].z - EID4789PS_3019) * 0.25f, min(EID4789PS_3223.x, EID4789PS_3223.y)))) : EID4789PS_38_m11[EID4789PS_2993].w) : 1.0f;
                                }
                                else
                                {
                                    EID4789PS_3240 = clamp(dot(EID4789PS_590, EID4789PS_2779) + 1.0f, 0.0f, 1.0f);
                                }
                                EID4789PS_3241 = EID4789PS_3240;
                            }
                            else
                            {
                                EID4789PS_3241 = 1.0f;
                            }
                            float EID4789PS_3321;
                            float3 EID4789PS_3322;
                            float EID4789PS_3323;
                            float3 EID4789PS_3324;
                            float3 EID4789PS_3325;
                            float EID4789PS_3326;
                            float EID4789PS_3327;
                            [branch]
                            if (EID4789PS_2688 == 0u)
                            {
                                float3 EID4789PS_3247 = EID4789PS_36_m6[EID4789PS_2575].xyz * EID4789PS_2917;
                                float3 EID4789PS_3260 = EID4789PS_2277.xyz;
                                EID4789PS_3321 = EID4789PS_2917;
                                EID4789PS_3322 = (EID4789PS_36_m6[EID4789PS_2575].xyz * ((1.0f - EID4789PS_36_m6[EID4789PS_2587].y) + ((1.0f / max(1.0f, max(max(EID4789PS_3247.x, EID4789PS_3247.y), EID4789PS_3247.z) * lerp(0.75f, 0.5f, EID4789PS_2435))) * EID4789PS_36_m6[EID4789PS_2587].y))) * lerp(0.25f * EID4789PS_36_m6[EID4789PS_2587].x, 1.0f, clamp(EID4789PS_2937 + 0.5f, 0.0f, 1.0f));
                                EID4789PS_3323 = EID4789PS_2938;
                                EID4789PS_3324 = EID4789PS_3260;
                                EID4789PS_3325 = EID4789PS_3260;
                                EID4789PS_3326 = 1.0f;
                                EID4789PS_3327 = 0.0f;
                            }
                            else
                            {
                                float EID4789PS_3315;
                                float EID4789PS_3316;
                                float3 EID4789PS_3317;
                                float3 EID4789PS_3318;
                                float EID4789PS_3319;
                                float EID4789PS_3320;
                                if (EID4789PS_2688 == 3u)
                                {
                                    EID4789PS_3315 = EID4789PS_2917 * (smoothstep(lerp(0.800000011920928955078125f, 0.20000000298023223876953125f, EID4789PS_36_m6[EID4789PS_2587].x), lerp(0.89999997615814208984375f, 0.5f, EID4789PS_36_m6[EID4789PS_2587].x), EID4789PS_2401) * EID4789PS_3241);
                                    EID4789PS_3316 = clamp(dot(EID4789PS_2063, -normalize(cross(EID4789PS_623, cross(EID4789PS_623, EID4789PS_2779)))), 0.0f, 1.0f);
                                    EID4789PS_3317 = lerp(0.5f.xxx, EID4789PS_2071, EID4789PS_36_m6[EID4789PS_2587].y.xxx);
                                    EID4789PS_3318 = 0.0f.xxx;
                                    EID4789PS_3319 = 1.0f;
                                    EID4789PS_3320 = 0.0f;
                                }
                                else
                                {
                                    bool EID4789PS_3285 = EID4789PS_2688 == 1u;
                                    float EID4789PS_3309;
                                    float3 EID4789PS_3310;
                                    float EID4789PS_3311;
                                    float EID4789PS_3312;
                                    if (EID4789PS_3285)
                                    {
                                        EID4789PS_3309 = clamp(clamp(EID4789PS_2937 + EID4789PS_36_m6[EID4789PS_2587].x, -1.0f, 1.0f), 0.0f, 1.0f) * EID4789PS_3241;
                                        EID4789PS_3310 = EID4789PS_2075 * EID4789PS_36_m6[EID4789PS_2587].y;
                                        EID4789PS_3311 = 1.0f;
                                        EID4789PS_3312 = 0.0f;
                                    }
                                    else
                                    {
                                        bool EID4789PS_3295 = EID4789PS_2688 == 2u;
                                        float EID4789PS_3307;
                                        if (EID4789PS_3295)
                                        {
                                            EID4789PS_3307 = smoothstep(EID4789PS_36_m6[EID4789PS_2587].x + 0.0500000007450580596923828125f, EID4789PS_36_m6[EID4789PS_2587].x - 0.0500000007450580596923828125f, EID4789PS_2065) * ((1.0f - EID4789PS_36_m6[EID4789PS_2587].z) + (step(0.5f, EID4789PS_2068) * EID4789PS_36_m6[EID4789PS_2587].z));
                                        }
                                        else
                                        {
                                            EID4789PS_3307 = 1.0f;
                                        }
                                        EID4789PS_3309 = EID4789PS_2938;
                                        EID4789PS_3310 = 0.0f.xxx;
                                        EID4789PS_3311 = EID4789PS_3307;
                                        EID4789PS_3312 = EID4789PS_3295 ? EID4789PS_36_m6[EID4789PS_2587].y : 0.0f;
                                    }
                                    bool3 EID4789PS_3313 = EID4789PS_3285.xxx;
                                    EID4789PS_3315 = EID4789PS_2917;
                                    EID4789PS_3316 = EID4789PS_3309;
                                    EID4789PS_3317 = float3(EID4789PS_3313.x ? EID4789PS_2071.x : 0.0f.xxx.x, EID4789PS_3313.y ? EID4789PS_2071.y : 0.0f.xxx.y, EID4789PS_3313.z ? EID4789PS_2071.z : 0.0f.xxx.z);
                                    EID4789PS_3318 = EID4789PS_3310;
                                    EID4789PS_3319 = EID4789PS_3311;
                                    EID4789PS_3320 = EID4789PS_3312;
                                }
                                EID4789PS_3321 = EID4789PS_3315;
                                EID4789PS_3322 = EID4789PS_36_m6[EID4789PS_2575].xyz;
                                EID4789PS_3323 = EID4789PS_3316;
                                EID4789PS_3324 = EID4789PS_3317;
                                EID4789PS_3325 = EID4789PS_3318;
                                EID4789PS_3326 = EID4789PS_3319;
                                EID4789PS_3327 = EID4789PS_3320;
                            }
                            float3 EID4789PS_3355;
                            [branch]
                            if (EID4789PS_2688 != 3u)
                            {
                                float EID4789PS_3332 = lerp(EID4789PS_2077, 0.00999999977648258209228515625f, EID4789PS_3327);
                                float EID4789PS_3335 = dot(EID4789PS_1885, normalize(EID4789PS_2779 + EID4789PS_463));
                                float EID4789PS_3336 = EID4789PS_3332 * EID4789PS_3332;
                                float EID4789PS_3340 = (((EID4789PS_3335 * EID4789PS_3336) - EID4789PS_3335) * EID4789PS_3335) + 1.0f;
                                float EID4789PS_3341 = EID4789PS_3340 * EID4789PS_3340;
                                EID4789PS_3355 = ((EID4789PS_2336 * clamp((((EID4789PS_3336 != EID4789PS_3341) ? (EID4789PS_3336 / EID4789PS_3341) : 1.0f) * (0.5f / ((EID4789PS_2313 + (EID4789PS_3332 * EID4789PS_2315)) + 9.9999997473787516355514526367188e-05f))) - 6.103515625e-05f, 0.0f, 20.0f)) * EID4789PS_3326) * EID4789PS_36_m6[EID4789PS_2596].z;
                            }
                            else
                            {
                                EID4789PS_3355 = 0.0f.xxx;
                            }
                            float3 EID4789PS_3358 = EID4789PS_3322 * EID4789PS_3321;
                            EID4789PS_3365 = EID4789PS_2539 + (((EID4789PS_3358 * lerp(EID4789PS_3325, EID4789PS_3324, EID4789PS_3323.xxx)) * EID4789PS_2351) + ((EID4789PS_3358 * EID4789PS_3355) * EID4789PS_3323));
                        }
                        else
                        {
                            EID4789PS_3365 = EID4789PS_2539;
                        }
                        EID4789PS_3366 = EID4789PS_3365;
                        break;
                    } while(false);
                    EID4789PS_3367 = EID4789PS_3366;
                    break;
                } while(false);
                EID4789PS_3368 = EID4789PS_3367;
            }
            else
            {
                EID4789PS_3368 = EID4789PS_2539;
            }
            EID4789PS_2562 = EID4789PS_3368;
        }
    }
    float3 EID4789PS_3408;
    [branch]
    if (EID4789PS_49_m12 > 0.5f)
    {
        EID4789PS_3408 = lerp(lerp(0.5f.xxx, lerp(dot(EID4789PS_2538, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, EID4789PS_2538, EID4789PS_49_m14.xxx), EID4789PS_49_m15.xxx) * EID4789PS_49_m13, EID4789PS_49_m26.xyz, EID4789PS_49_m26.w.xxx) + ((EID4789PS_49_m27.xyz * smoothstep(1.0f - EID4789PS_49_m16, 1.0f, 1.0f - clamp(EID4789PS_2399, 0.0f, 1.0f))) * EID4789PS_49_m17);
    }
    else
    {
        EID4789PS_3408 = EID4789PS_2538;
    }
    float4 EID4789PS_3415 = float4(EID4789PS_3408 * EID4789PS_19_m20.y, EID4789PS_510);
    EID4789PS_3415.w = (EID4789PS_49_m8 == 1.0f) ? EID4789PS_510 : 1.0f;
    float4 EID4789PS_3802;
    [branch]
    if (EID4789PS_19_m91.w < 0.5f)
    {
        float EID4789PS_3439 = EID4789PS_655 * EID4789PS_19_m46.w;
        float EID4789PS_3444 = max(0.00999999977648258209228515625f, EID4789PS_3439 + EID4789PS_19_m47.w);
        float3 EID4789PS_3458 = exp(EID4789PS_19_m45.xyz * ((-max(0.0f, (EID4789PS_464 * EID4789PS_19_m44.w) - EID4789PS_19_m43.w)) * (((1.0f - exp(-EID4789PS_3444)) / EID4789PS_3444) * exp(EID4789PS_3439 + EID4789PS_19_m48.w))));
        float EID4789PS_3461 = dot(EID4789PS_2491, EID4789PS_19_m44.xyz);
        float EID4789PS_3467 = EID4789PS_19_m45.w * EID4789PS_19_m45.w;
        float EID4789PS_3471 = (1.0f + EID4789PS_3467) - ((2.0f * EID4789PS_19_m45.w) * EID4789PS_3461);
        float3 EID4789PS_3794;
        float EID4789PS_3795;
        if (EID4789PS_19_m55.z > 0.0f)
        {
            uint3 EID4789PS_3516 = (uint3(int3(EID4789PS_2142, EID4789PS_2143, int(EID4789PS_19_m19 & 7u))) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint EID4789PS_3517 = EID4789PS_3516.y;
            uint EID4789PS_3518 = EID4789PS_3516.z;
            uint EID4789PS_3521 = EID4789PS_3516.x + (EID4789PS_3517 * EID4789PS_3518);
            uint EID4789PS_3523 = EID4789PS_3517 + (EID4789PS_3518 * EID4789PS_3521);
            uint EID4789PS_3525 = EID4789PS_3518 + (EID4789PS_3521 * EID4789PS_3523);
            uint EID4789PS_3527 = EID4789PS_3521 + (EID4789PS_3523 * EID4789PS_3525);
            float EID4789PS_3552 = dot(EID4789PS_2491, -EID4789PS_17_m0[2].xyz);
            float3 EID4789PS_3559 = EID4789PS_583 - EID4789PS_17_m11.xyz;
            float EID4789PS_3561 = (EID4789PS_19_m55.w * ((EID4789PS_3552 > 5.9604644775390625e-08f) ? (1.0f / EID4789PS_3552) : 0.0f)) * (1.0f / EID4789PS_464);
            float EID4789PS_3562 = EID4789PS_3559.y;
            float EID4789PS_3563 = EID4789PS_3561 * EID4789PS_3562;
            float EID4789PS_3565 = EID4789PS_17_m11.y + EID4789PS_3563;
            float EID4789PS_3566 = EID4789PS_3562 - EID4789PS_3563;
            float EID4789PS_3568 = (1.0f - EID4789PS_3561) * EID4789PS_464;
            float EID4789PS_3582 = max(-127.0f, EID4789PS_19_m49.z * EID4789PS_3566);
            float EID4789PS_3606 = max(-127.0f, EID4789PS_19_m52.x * EID4789PS_3566);
            float EID4789PS_3617 = ((EID4789PS_19_m49.y * exp2(-max(-127.0f, EID4789PS_19_m49.z * (EID4789PS_3565 - EID4789PS_19_m49.x)))) * ((abs(EID4789PS_3582) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-EID4789PS_3582)) / EID4789PS_3582) : (0.693147182464599609375f - (0.2402265071868896484375f * EID4789PS_3582)))) + ((EID4789PS_19_m52.y * exp2(-max(-127.0f, EID4789PS_19_m52.x * (EID4789PS_3565 - EID4789PS_19_m52.z)))) * ((abs(EID4789PS_3606) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-EID4789PS_3606)) / EID4789PS_3606) : (0.693147182464599609375f - (0.2402265071868896484375f * EID4789PS_3606))));
            float EID4789PS_3639 = clamp((EID4789PS_464 * EID4789PS_19_m50.w) + EID4789PS_19_m50.z, 0.0f, 1.0f);
            float EID4789PS_3642 = clamp((max(clamp(exp2(-(EID4789PS_3617 * EID4789PS_3568)), 0.0f, 1.0f), EID4789PS_19_m51.w) + clamp((EID4789PS_464 * EID4789PS_19_m50.y) + EID4789PS_19_m50.x, 0.0f, 1.0f)) + EID4789PS_3639, 0.0f, 1.0f);
            float4 EID4789PS_3682 = lerp(float4(0.0f, 0.0f, 0.0f, 1.0f), EID4789PS_68.SampleLevel(EID4789_linear_clamp_sampler, float3((EID4789PS_2513 + ((((float3(uint3(EID4789PS_3527, EID4789PS_3523 + (EID4789PS_3525 * EID4789PS_3527), EID4789PS_429) >> uint3(16u, 16u, 16u)) * 1.525902189314365386962890625e-05f.xxx) * 2.0f) - 1.0f.xxx) * EID4789PS_19_m59.w).xy) * EID4789PS_19_m57.xy, (log2((EID4789PS_444 * EID4789PS_19_m56.x) + EID4789PS_19_m56.y) * EID4789PS_19_m56.z) / EID4789PS_19_m55.z), 0.0f), (capturedScreenValid ? clamp((EID4789PS_444 - EID4789PS_19_m58.z) * 1000000.0f, 0.0f, 1.0f) : 0.0f).xxxx);
            EID4789PS_3794 = EID4789PS_3682.xyz + (((EID4789PS_19_m51.xyz * (1.0f - EID4789PS_3642)) + (((EID4789PS_19_m54.xyz * pow(clamp(dot(EID4789PS_463, EID4789PS_19_m53.xyz), 0.0f, 1.0f), EID4789PS_19_m54.w)) * (1.0f - clamp(exp2(-(EID4789PS_3617 * max(EID4789PS_3568 - EID4789PS_19_m53.w, 0.0f))), 0.0f, 1.0f))) * (1.0f - EID4789PS_3639))) * EID4789PS_3682.w);
            EID4789PS_3795 = EID4789PS_3682.w * EID4789PS_3642;
        }
        else
        {
            float3 EID4789PS_3688 = EID4789PS_583 - EID4789PS_17_m11.xyz;
            float EID4789PS_3690 = EID4789PS_3688.y;
            float EID4789PS_3704 = max(-127.0f, EID4789PS_19_m49.z * EID4789PS_3690);
            float EID4789PS_3728 = max(-127.0f, EID4789PS_19_m52.x * EID4789PS_3690);
            float EID4789PS_3739 = ((EID4789PS_19_m49.y * exp2(-max(-127.0f, EID4789PS_19_m49.z * (EID4789PS_17_m11.y - EID4789PS_19_m49.x)))) * ((abs(EID4789PS_3704) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-EID4789PS_3704)) / EID4789PS_3704) : (0.693147182464599609375f - (0.2402265071868896484375f * EID4789PS_3704)))) + ((EID4789PS_19_m52.y * exp2(-max(-127.0f, EID4789PS_19_m52.x * (EID4789PS_17_m11.y - EID4789PS_19_m52.z)))) * ((abs(EID4789PS_3728) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-EID4789PS_3728)) / EID4789PS_3728) : (0.693147182464599609375f - (0.2402265071868896484375f * EID4789PS_3728))));
            float EID4789PS_3761 = clamp((EID4789PS_464 * EID4789PS_19_m50.w) + EID4789PS_19_m50.z, 0.0f, 1.0f);
            float EID4789PS_3764 = clamp((max(clamp(exp2(-(EID4789PS_3739 * EID4789PS_464)), 0.0f, 1.0f), EID4789PS_19_m51.w) + clamp((EID4789PS_464 * EID4789PS_19_m50.y) + EID4789PS_19_m50.x, 0.0f, 1.0f)) + EID4789PS_3761, 0.0f, 1.0f);
            EID4789PS_3794 = (EID4789PS_19_m51.xyz * (1.0f - EID4789PS_3764)) + (((EID4789PS_19_m54.xyz * pow(clamp(dot(EID4789PS_463, EID4789PS_19_m53.xyz), 0.0f, 1.0f), EID4789PS_19_m54.w)) * (1.0f - clamp(exp2(-(EID4789PS_3739 * max(EID4789PS_464 - EID4789PS_19_m53.w, 0.0f))), 0.0f, 1.0f))) * (1.0f - EID4789PS_3761));
            EID4789PS_3795 = EID4789PS_3764;
        }
        float3 EID4789PS_3800 = (EID4789PS_3415.xyz * (EID4789PS_3458 * EID4789PS_3795)) + ((((clamp(((EID4789PS_19_m46.xyz * (0.0596831031143665313720703125f * (1.0f + (EID4789PS_3461 * EID4789PS_3461)))) + EID4789PS_19_m48.xyz) + (EID4789PS_19_m47.xyz * ((1.0f - EID4789PS_3467) / max((12.56637096405029296875f * EID4789PS_3471) * sqrt(EID4789PS_3471), 0.001000000047497451305389404296875f))), 0.0f.xxx, 1.0f.xxx) * 255.0f) * (1.0f.xxx - EID4789PS_3458)) * EID4789PS_3795) + EID4789PS_3794);
        EID4789PS_3802 = float4(EID4789PS_3800.x, EID4789PS_3800.y, EID4789PS_3800.z, EID4789PS_3415.w);
    }
    else
    {
        EID4789PS_3802 = EID4789PS_3415;
    }
    EID4789PS_14 = EID4789PS_3802;
    EID4789PS_15 = EID4789PS_2107;
}

EID4789PS_SPIRV_Cross_Output EID4789PS_main(EID4789PS_SPIRV_Cross_Input stage_input)
{
    EID4789PS_gl_FragCoord = stage_input.EID4789PS_gl_FragCoord;
    EID4789PS_gl_FragCoord.w = 1.0 / EID4789PS_gl_FragCoord.w;
    EID4789PS_gl_FrontFacing = stage_input.EID4789PS_gl_FrontFacing;
    EID4789PS_3 = stage_input.EID4789PS_3;
    EID4789PS_4 = stage_input.EID4789PS_4;
    EID4789PS_5 = stage_input.EID4789PS_5;
    EID4789PS_6 = stage_input.EID4789PS_6;
    EID4789PS_7 = stage_input.EID4789PS_7;
    EID4789PS_8 = stage_input.EID4789PS_8;
    EID4789PS_9 = stage_input.EID4789PS_9;
    EID4789PS_10 = stage_input.EID4789PS_10;
    EID4789PS_12 = stage_input.EID4789PS_12;
    EID4789PS_frag_main();
    EID4789PS_SPIRV_Cross_Output stage_output;
    stage_output.EID4789PS_14 = EID4789PS_14;
    stage_output.EID4789PS_15 = EID4789PS_15;
    return stage_output;
}
