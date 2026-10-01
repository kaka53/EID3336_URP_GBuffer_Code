// Private per-draw AO; do not expose as a material property.
Texture2D<float4> _EID4705DrawAO;
float _EID4705UseDrawAO;
float _EID4705AOAudit;
// Verified F:/endfield06.rdc EID4705 VS215981/PS215982, independent resources.
struct EID4705PS_22
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

static const int2 EID4705PS_362[6] = { int2(2, 1), int2(2, 1), int2(0, 2), int2(0, 2), int2(0, 1), int2(0, 1) };
static const float2 EID4705PS_363[6] = { float2(-1.0f, 1.0f), 1.0f.xx, float2(1.0f, -1.0f), 1.0f.xx, 1.0f.xx, float2(-1.0f, 1.0f) };

cbuffer EID4705PS_17_18
{
    column_major float4x4 EID4705PS_18_m0 : packoffset(c0);
    column_major float4x4 EID4705PS_18_m1 : packoffset(c4);
    column_major float4x4 EID4705PS_18_m2 : packoffset(c8);
    column_major float4x4 EID4705PS_18_m3 : packoffset(c12);
    column_major float4x4 EID4705PS_18_m4 : packoffset(c16);
    column_major float4x4 EID4705PS_18_m5 : packoffset(c20);
    column_major float4x4 EID4705PS_18_m6 : packoffset(c24);
    column_major float4x4 EID4705PS_18_m7 : packoffset(c28);
    column_major float4x4 EID4705PS_18_m8 : packoffset(c32);
    column_major float4x4 EID4705PS_18_m9 : packoffset(c36);
    column_major float4x4 EID4705PS_18_m10 : packoffset(c40);
    float4 EID4705PS_18_m11 : packoffset(c44);
    column_major float4x4 EID4705PS_18_m12 : packoffset(c45);
    column_major float4x4 EID4705PS_18_m13 : packoffset(c49);
    column_major float4x4 EID4705PS_18_m14 : packoffset(c53);
    column_major float4x4 EID4705PS_18_m15 : packoffset(c57);
    column_major float4x4 EID4705PS_18_m16 : packoffset(c61);
    column_major float4x4 EID4705PS_18_m17 : packoffset(c65);
    column_major float4x4 EID4705PS_18_m18 : packoffset(c69);
    column_major float4x4 EID4705PS_18_m19 : packoffset(c73);
    column_major float4x4 EID4705PS_18_m20 : packoffset(c77);
    float4 EID4705PS_18_m21 : packoffset(c81);
};

cbuffer EID4705PS_19_20
{
    float4 EID4705PS_20_m0 : packoffset(c0);
    float4 EID4705PS_20_m1 : packoffset(c1);
    float4 EID4705PS_20_m2 : packoffset(c2);
    float4 EID4705PS_20_m3 : packoffset(c3);
    float4 EID4705PS_20_m4 : packoffset(c4);
    float4 EID4705PS_20_m5 : packoffset(c5);
    float4 EID4705PS_20_m6[6] : packoffset(c6);
    float4 EID4705PS_20_m7[6] : packoffset(c12);
    float4 EID4705PS_20_m8 : packoffset(c18);
    float4 EID4705PS_20_m9 : packoffset(c19);
    float4 EID4705PS_20_m10 : packoffset(c20);
    float4 EID4705PS_20_m11 : packoffset(c21);
    float4 EID4705PS_20_m12 : packoffset(c22);
    float4 EID4705PS_20_m13 : packoffset(c23);
    float4 EID4705PS_20_m14 : packoffset(c24);
    float4 EID4705PS_20_m15 : packoffset(c25);
    float EID4705PS_20_m16 : packoffset(c26);
    float EID4705PS_20_m17 : packoffset(c26.y);
    float EID4705PS_20_m18 : packoffset(c26.z);
    uint EID4705PS_20_m19 : packoffset(c26.w);
    float4 EID4705PS_20_m20 : packoffset(c27);
    int4 EID4705PS_20_m21 : packoffset(c28);
    float4 EID4705PS_20_m22 : packoffset(c29);
    float4 EID4705PS_20_m23 : packoffset(c30);
    float4 EID4705PS_20_m24 : packoffset(c31);
    float4 EID4705PS_20_m25 : packoffset(c32);
    float4 EID4705PS_20_m26 : packoffset(c33);
    float4 EID4705PS_20_m27 : packoffset(c34);
    float4 EID4705PS_20_m28 : packoffset(c35);
    float4 EID4705PS_20_m29 : packoffset(c36);
    float4 EID4705PS_20_m30 : packoffset(c37);
    float4 EID4705PS_20_m31 : packoffset(c38);
    float4 EID4705PS_20_m32[4] : packoffset(c39);
    float4 EID4705PS_20_m33[4] : packoffset(c43);
    float4 EID4705PS_20_m34[4] : packoffset(c47);
    float4 EID4705PS_20_m35[4] : packoffset(c51);
    float4 EID4705PS_20_m36 : packoffset(c55);
    float4 EID4705PS_20_m37 : packoffset(c56);
    float4 EID4705PS_20_m38[4] : packoffset(c57);
    float4 EID4705PS_20_m39[4] : packoffset(c61);
    float4 EID4705PS_20_m40[4] : packoffset(c65);
    float4 EID4705PS_20_m41 : packoffset(c69);
    float4 EID4705PS_20_m42 : packoffset(c70);
    float4 EID4705PS_20_m43 : packoffset(c71);
    float4 EID4705PS_20_m44 : packoffset(c72);
    float4 EID4705PS_20_m45 : packoffset(c73);
    float4 EID4705PS_20_m46 : packoffset(c74);
    float4 EID4705PS_20_m47 : packoffset(c75);
    float4 EID4705PS_20_m48 : packoffset(c76);
    float4 EID4705PS_20_m49 : packoffset(c77);
    float4 EID4705PS_20_m50 : packoffset(c78);
    float4 EID4705PS_20_m51 : packoffset(c79);
    float4 EID4705PS_20_m52 : packoffset(c80);
    float4 EID4705PS_20_m53 : packoffset(c81);
    float4 EID4705PS_20_m54 : packoffset(c82);
    float4 EID4705PS_20_m55 : packoffset(c83);
    float4 EID4705PS_20_m56 : packoffset(c84);
    float4 EID4705PS_20_m57 : packoffset(c85);
    float4 EID4705PS_20_m58 : packoffset(c86);
    float4 EID4705PS_20_m59 : packoffset(c87);
    float4 EID4705PS_20_m60 : packoffset(c88);
    float4 EID4705PS_20_m61 : packoffset(c89);
    float4 EID4705PS_20_m62 : packoffset(c90);
    float4 EID4705PS_20_m63 : packoffset(c91);
    float4 EID4705PS_20_m64 : packoffset(c92);
    float4 EID4705PS_20_m65 : packoffset(c93);
    float4 EID4705PS_20_m66 : packoffset(c94);
    float4 EID4705PS_20_m67 : packoffset(c95);
    float4 EID4705PS_20_m68 : packoffset(c96);
    float4 EID4705PS_20_m69 : packoffset(c97);
    float4 EID4705PS_20_m70 : packoffset(c98);
    float4 EID4705PS_20_m71 : packoffset(c99);
    float4 EID4705PS_20_m72 : packoffset(c100);
    float4 EID4705PS_20_m73 : packoffset(c101);
    float4 EID4705PS_20_m74 : packoffset(c102);
    float4 EID4705PS_20_m75 : packoffset(c103);
    float4 EID4705PS_20_m76 : packoffset(c104);
    float4 EID4705PS_20_m77 : packoffset(c105);
    float4 EID4705PS_20_m78 : packoffset(c106);
    float4 EID4705PS_20_m79 : packoffset(c107);
    float4 EID4705PS_20_m80 : packoffset(c108);
    float4 EID4705PS_20_m81 : packoffset(c109);
    float4 EID4705PS_20_m82 : packoffset(c110);
    float4 EID4705PS_20_m83 : packoffset(c111);
    float4 EID4705PS_20_m84 : packoffset(c112);
    float4 EID4705PS_20_m85 : packoffset(c113);
    float4 EID4705PS_20_m86 : packoffset(c114);
    float4 EID4705PS_20_m87 : packoffset(c115);
    float4 EID4705PS_20_m88 : packoffset(c116);
    float4 EID4705PS_20_m89 : packoffset(c117);
    float4 EID4705PS_20_m90 : packoffset(c118);
    float4 EID4705PS_20_m91 : packoffset(c119);
    float4 EID4705PS_20_m92 : packoffset(c120);
    float4 EID4705PS_20_m93 : packoffset(c121);
    float4 EID4705PS_20_m94 : packoffset(c122);
    float4 EID4705PS_20_m95 : packoffset(c123);
    float4 EID4705PS_20_m96 : packoffset(c124);
    float4 EID4705PS_20_m97 : packoffset(c125);
    float4 EID4705PS_20_m98 : packoffset(c126);
    float4 EID4705PS_20_m99[2] : packoffset(c127);
    float4 EID4705PS_20_m100[2] : packoffset(c129);
    float EID4705PS_20_m101 : packoffset(c131);
    float EID4705PS_20_m102 : packoffset(c131.y);
    float EID4705PS_20_m103 : packoffset(c131.z);
    float EID4705PS_20_m104 : packoffset(c131.w);
    float4 EID4705PS_20_m105 : packoffset(c132);
    float4 EID4705PS_20_m106 : packoffset(c133);
    float4 EID4705PS_20_m107 : packoffset(c134);
    float4 EID4705PS_20_m108 : packoffset(c135);
    float4 EID4705PS_20_m109 : packoffset(c136);
    float4 EID4705PS_20_m110 : packoffset(c137);
    float4 EID4705PS_20_m111 : packoffset(c138);
    float4 EID4705PS_20_m112 : packoffset(c139);
    float4 EID4705PS_20_m113 : packoffset(c140);
    float4 EID4705PS_20_m114 : packoffset(c141);
    float4 EID4705PS_20_m115 : packoffset(c142);
    float4 EID4705PS_20_m116 : packoffset(c143);
    float4 EID4705PS_20_m117 : packoffset(c144);
    float4 EID4705PS_20_m118 : packoffset(c145);
    float4 EID4705PS_20_m119 : packoffset(c146);
    float4 EID4705PS_20_m120 : packoffset(c147);
    float4 EID4705PS_20_m121 : packoffset(c148);
    float4 EID4705PS_20_m122 : packoffset(c149);
    float4 EID4705PS_20_m123 : packoffset(c150);
    float4 EID4705PS_20_m124 : packoffset(c151);
    float4 EID4705PS_20_m125 : packoffset(c152);
    float4 EID4705PS_20_m126 : packoffset(c153);
    float4 EID4705PS_20_m127 : packoffset(c154);
    float4 EID4705PS_20_m128 : packoffset(c155);
    float4 EID4705PS_20_m129 : packoffset(c156);
    float4 EID4705PS_20_m130 : packoffset(c157);
    float4 EID4705PS_20_m131 : packoffset(c158);
    float4 EID4705PS_20_m132 : packoffset(c159);
    float4 EID4705PS_20_m133 : packoffset(c160);
    float4 EID4705PS_20_m134 : packoffset(c161);
    column_major float4x4 EID4705PS_20_m135 : packoffset(c162);
    float4 EID4705PS_20_m136 : packoffset(c166);
    float4 EID4705PS_20_m137 : packoffset(c167);
    float4 EID4705PS_20_m138[32] : packoffset(c168);
};

cbuffer EID4705PS_21_23
{
    float4 EID4705PS_instanceRaw[4096] : packoffset(c0);
};

ByteAddressBuffer EID4705PS_31;
ByteAddressBuffer EID4705PS_33;
cbuffer EID4705PS_34_35
{
    int EID4705PS_35_m0 : packoffset(c0);
    int EID4705PS_35_m1 : packoffset(c0.y);
    int EID4705PS_35_m2 : packoffset(c0.z);
    int EID4705PS_35_m3 : packoffset(c0.w);
    float EID4705PS_35_m4 : packoffset(c1);
    float EID4705PS_35_m5 : packoffset(c1.y);
    float EID4705PS_35_m6 : packoffset(c1.z);
    float EID4705PS_35_m7 : packoffset(c1.w);
    float EID4705PS_35_m8 : packoffset(c2);
    float EID4705PS_35_m9 : packoffset(c2.y);
    float EID4705PS_35_m10 : packoffset(c2.z);
    float EID4705PS_35_m11 : packoffset(c2.w);
};

cbuffer EID4705PS_36_37
{
    float4 EID4705PS_37_m0 : packoffset(c0);
    float4 EID4705PS_37_m1 : packoffset(c1);
    float4 EID4705PS_37_m2 : packoffset(c2);
    float4 EID4705PS_37_m3 : packoffset(c3);
    float4 EID4705PS_37_m4 : packoffset(c4);
    uint4 EID4705PS_37_m5 : packoffset(c5);
    float4 EID4705PS_37_m6[2048] : packoffset(c6);
};

cbuffer EID4705PS_38_39
{
    column_major float4x4 EID4705PS_39_m0[5] : packoffset(c0);
    float4 EID4705PS_39_m1[4] : packoffset(c20);
    float4 EID4705PS_39_m2[4] : packoffset(c24);
    float4 EID4705PS_39_m3[4] : packoffset(c28);
    float4 EID4705PS_39_m4 : packoffset(c32);
    float4 EID4705PS_39_m5 : packoffset(c33);
    float4 EID4705PS_39_m6 : packoffset(c34);
    float4 EID4705PS_39_m7 : packoffset(c35);
    float4 EID4705PS_39_m8 : packoffset(c36);
    float4 EID4705PS_39_m9[27] : packoffset(c37);
    column_major float4x4 EID4705PS_39_m10[56] : packoffset(c64);
    float4 EID4705PS_39_m11[56] : packoffset(c288);
    float4 EID4705PS_39_m12[56] : packoffset(c344);
    float4 EID4705PS_39_m13 : packoffset(c400);
    float4 EID4705PS_39_m14[47] : packoffset(c401);
    column_major float4x4 EID4705PS_39_m15[15] : packoffset(c448);
    float4 EID4705PS_39_m16[15] : packoffset(c508);
    float4 EID4705PS_39_m17[15] : packoffset(c523);
    float4 EID4705PS_39_m18[15] : packoffset(c538);
    float4 EID4705PS_39_m19 : packoffset(c553);
    float4 EID4705PS_39_m20 : packoffset(c554);
    float4 EID4705PS_39_m21[21] : packoffset(c555);
    column_major float4x4 EID4705PS_39_m22 : packoffset(c576);
    column_major float4x4 EID4705PS_39_m23 : packoffset(c580);
    float4 EID4705PS_39_m24 : packoffset(c584);
    float4 EID4705PS_39_m25 : packoffset(c585);
    float4 EID4705PS_39_m26 : packoffset(c586);
    float4 EID4705PS_39_m27[128] : packoffset(c587);
};

cbuffer EID4705PS_49_50
{
    float EID4705PS_50_m0 : packoffset(c0);
    float EID4705PS_50_m1 : packoffset(c0.y);
    float EID4705PS_50_m2 : packoffset(c0.z);
    float EID4705PS_50_m3 : packoffset(c0.w);
    float EID4705PS_50_m4 : packoffset(c1);
    float EID4705PS_50_m5 : packoffset(c1.y);
    float EID4705PS_50_m6 : packoffset(c1.z);
    float EID4705PS_50_m7 : packoffset(c1.w);
    float EID4705PS_50_m8 : packoffset(c2);
    float EID4705PS_50_m9 : packoffset(c2.y);
    float EID4705PS_50_m10 : packoffset(c2.z);
    float EID4705PS_50_m11 : packoffset(c2.w);
    float EID4705PS_50_m12 : packoffset(c3);
    float EID4705PS_50_m13 : packoffset(c3.y);
    float EID4705PS_50_m14 : packoffset(c3.z);
    float EID4705PS_50_m15 : packoffset(c3.w);
    float EID4705PS_50_m16 : packoffset(c4);
    float EID4705PS_50_m17 : packoffset(c4.y);
    float EID4705PS_50_m18 : packoffset(c4.z);
    float EID4705PS_50_m19 : packoffset(c4.w);
    float EID4705PS_50_m20 : packoffset(c5);
    float EID4705PS_50_m21 : packoffset(c5.y);
    float EID4705PS_50_m22 : packoffset(c5.z);
    float EID4705PS_50_m23 : packoffset(c5.w);
    float4 EID4705PS_50_m24 : packoffset(c6);
    float4 EID4705PS_50_m25 : packoffset(c7);
    float4 EID4705PS_50_m26 : packoffset(c8);
    float4 EID4705PS_50_m27 : packoffset(c9);
    float4 EID4705PS_50_m28 : packoffset(c10);
    float4 EID4705PS_50_m29 : packoffset(c11);
    float EID4705PS_50_m30 : packoffset(c12);
    float EID4705PS_50_m31 : packoffset(c12.y);
    float EID4705PS_50_m32 : packoffset(c12.z);
    float EID4705PS_50_m33 : packoffset(c12.w);
    float4 EID4705PS_50_m34 : packoffset(c13);
    float EID4705PS_50_m35 : packoffset(c14);
    float EID4705PS_50_m36 : packoffset(c14.y);
    float EID4705PS_50_m37 : packoffset(c14.z);
    float EID4705PS_50_m38 : packoffset(c14.w);
    float4 EID4705PS_50_m39 : packoffset(c15);
    float4 EID4705PS_50_m40 : packoffset(c16);
    float4 EID4705PS_50_m41 : packoffset(c17);
    float4 EID4705PS_50_m42 : packoffset(c18);
    float4 EID4705PS_50_m43 : packoffset(c19);
    float4 EID4705PS_50_m44 : packoffset(c20);
    float EID4705PS_50_m45 : packoffset(c21);
    float EID4705PS_50_m46 : packoffset(c21.y);
    float EID4705PS_50_m47 : packoffset(c21.z);
    float EID4705PS_50_m48 : packoffset(c21.w);
    float EID4705PS_50_m49 : packoffset(c22);
    float EID4705PS_50_m50 : packoffset(c22.y);
    float EID4705PS_50_m51 : packoffset(c22.z);
    float EID4705PS_50_m52 : packoffset(c22.w);
};

cbuffer EID4705PS_58_59
{
    float4 EID4705PS_59_m0[32] : packoffset(c0);
    column_major float4x4 EID4705PS_59_m1[32] : packoffset(c32);
};

SamplerState EID4705_point_repeat_sampler;
SamplerState EID4705_linear_clamp_sampler;
SamplerState EID4705_linear_repeat_sampler;

Texture2D<float4> EID4705PS_40;
Texture2D<float4> EID4705PS_41;
Texture3D<float4> EID4705PS_43;
Texture3D<float4> EID4705PS_44;
Texture3D<float4> EID4705PS_45;
Texture3D<float4> EID4705PS_46;
Texture3D<float4> EID4705PS_47;
Texture3D<float4> EID4705PS_48;
Texture2D<float4> EID4705PS_51;
Texture2D<float4> EID4705PS_52;
Texture2D<float4> EID4705PS_53;
Texture2D<float4> EID4705PS_54;
Texture2D<float4> EID4705PS_55;
Texture2D<float4> EID4705PS_56;
Texture2D<float4> EID4705PS_57;
Texture3D<float4> EID4705PS_62;

static float4 EID4705PS_gl_FragCoord;
static bool EID4705PS_gl_FrontFacing;
static float2 EID4705PS_3;
static float3 EID4705PS_4;
static float3 EID4705PS_5;
static float4 EID4705PS_6;
static float3 EID4705PS_7;
static float3 EID4705PS_8;
static float3 EID4705PS_9;
static float4 EID4705PS_10;
static float3 EID4705PS_11;
static uint EID4705PS_13;
static float4 EID4705PS_15;
static float4 EID4705PS_16;

EID4705PS_22 EID4705PS_LoadInstance(uint index) { uint b=index*16; EID4705PS_22 x;
x._m0=transpose(float4x4(EID4705PS_instanceRaw[b],EID4705PS_instanceRaw[b+1],EID4705PS_instanceRaw[b+2],EID4705PS_instanceRaw[b+3]));
x._m1=EID4705PS_instanceRaw[b+4];x._m2=EID4705PS_instanceRaw[b+5];
x._m3=transpose(float4x4(EID4705PS_instanceRaw[b+6],EID4705PS_instanceRaw[b+7],EID4705PS_instanceRaw[b+8],EID4705PS_instanceRaw[b+9]));
x._m4=EID4705PS_instanceRaw[b+10];
x._m5=EID4705PS_instanceRaw[b+11];
x._m6=EID4705PS_instanceRaw[b+12];
x._m7=EID4705PS_instanceRaw[b+13];
x._m8=EID4705PS_instanceRaw[b+14];
x._m9=EID4705PS_instanceRaw[b+15];
return x;}

struct EID4705PS_SPIRV_Cross_Input
{
    float2 EID4705PS_3 : TEXCOORD0;
    float3 EID4705PS_4 : TEXCOORD1;
    float3 EID4705PS_5 : TEXCOORD2;
    float4 EID4705PS_6 : TEXCOORD3;
    float3 EID4705PS_7 : TEXCOORD4;
    float3 EID4705PS_8 : TEXCOORD5;
    float3 EID4705PS_9 : TEXCOORD6;
    float4 EID4705PS_10 : TEXCOORD7;
    float3 EID4705PS_11 : TEXCOORD8;
    nointerpolation uint EID4705PS_13 : TEXCOORD9;
    float4 EID4705PS_gl_FragCoord : SV_Position;
    bool EID4705PS_gl_FrontFacing : SV_IsFrontFace;
};

struct EID4705PS_SPIRV_Cross_Output
{
    float4 EID4705PS_15 : SV_Target0;
    float4 EID4705PS_16 : SV_Target1;
};

static float EID4705PS_388;
static float3 EID4705PS_389;
static float EID4705PS_394;
static uint EID4705PS_395;

uint EID4705PS_spvPackHalf2x16(float2 value)
{
    uint2 Packed = f32tof16(value);
    return Packed.x | (Packed.y << 16);
}

float2 EID4705PS_spvUnpackHalf2x16(uint value)
{
    return f16tof32(uint2(value & 0xffff, value >> 16));
}

[noinline]
float EID4705ShadowGreater(float2 uv, float reference)
{
 uint w,h; EID4705PS_40.GetDimensions(w,h); float2 p=uv*float2(w,h)-0.5;
 int2 a=(int2)floor(p); float2 f=frac(p); int2 hi=int2(w,h)-1;
 float c00=reference>EID4705PS_40.Load(int3(clamp(a,int2(0,0),hi),0)).r?1:0;
 float c10=reference>EID4705PS_40.Load(int3(clamp(a+int2(1,0),int2(0,0),hi),0)).r?1:0;
 float c01=reference>EID4705PS_40.Load(int3(clamp(a+int2(0,1),int2(0,0),hi),0)).r?1:0;
 float c11=reference>EID4705PS_40.Load(int3(clamp(a+int2(1,1),int2(0,0),hi),0)).r?1:0;
 return lerp(lerp(c00,c10,f.x),lerp(c01,c11,f.x),f.y);
}


[noinline]
void EID4705PS_EarlyExit0(inout float EID4705PS_2864, inout bool EID4705PS_2652, inout float3 EID4705PS_3313, inout float3 EID4705PS_2486, inout int EID4705PS_2522, inout int EID4705PS_2534, inout float3 EID4705PS_561, inout float3 EID4705PS_2726, inout float3 EID4705PS_2084, inout uint EID4705PS_2635, inout bool EID4705PS_2647, inout uint EID4705PS_2547, inout int EID4705PS_2531, inout int EID4705PS_2528, inout float3 EID4705PS_533, inout int EID4705PS_2525, inout float3 EID4705PS_540, inout float EID4705PS_2431, inout float4 EID4705PS_2271, inout float EID4705PS_2395, inout float3 EID4705PS_573, inout float3 EID4705PS_2092, inout float3 EID4705PS_2096, inout float EID4705PS_2086, inout float EID4705PS_2089, inout float EID4705PS_2098, inout float3 EID4705PS_560, inout float3 EID4705PS_430, inout float3 EID4705PS_2095, inout float EID4705PS_2306, inout float EID4705PS_2308, inout int EID4705PS_2543)
{
                        float3 EID4705PS_3312;
                        [branch]
                        if (EID4705PS_2864 > 9.9999997473787516355514526367188e-05f)
                        {
                            [branch]
                            if (EID4705PS_2652)
                            {
                                EID4705PS_3313 = lerp(EID4705PS_2486, EID4705PS_37_m6[EID4705PS_2522].xyz, (EID4705PS_2864 * (EID4705PS_37_m6[EID4705PS_2534].x * ((1.0f - EID4705PS_37_m6[EID4705PS_2534].w) + (smoothstep(-0.5f, 0.5f, dot(EID4705PS_561, EID4705PS_2726)) * EID4705PS_37_m6[EID4705PS_2534].w)))).xxx);
                                return;
                            }
                            float EID4705PS_2884 = dot(EID4705PS_2084, EID4705PS_2726);
                            float EID4705PS_2885 = clamp(EID4705PS_2884, 0.0f, 1.0f);
                            float EID4705PS_3188;
                            if (EID4705PS_2635 != 0u)
                            {
                                bool EID4705PS_2891 = EID4705PS_2647 || ((EID4705PS_2547 & 2u) != 0u);
                                int EID4705PS_2940;
                                if (EID4705PS_2891)
                                {
                                    EID4705PS_2940 = int(EID4705PS_37_m6[EID4705PS_2531].x);
                                }
                                else
                                {
                                    uint EID4705PS_2897 = asuint(EID4705PS_37_m6[EID4705PS_2528].w);
                                    uint EID4705PS_2899 = asuint(EID4705PS_37_m6[EID4705PS_2531].x);
                                    float3 EID4705PS_2900 = EID4705PS_533 - EID4705PS_37_m6[EID4705PS_2525].xyz;
                                    float3 EID4705PS_2901 = abs(EID4705PS_2900);
                                    float EID4705PS_2902 = EID4705PS_2901.x;
                                    float EID4705PS_2903 = EID4705PS_2901.y;
                                    float EID4705PS_2905 = EID4705PS_2901.z;
                                    int EID4705PS_2937;
                                    if ((EID4705PS_2902 > EID4705PS_2903) && (EID4705PS_2902 > EID4705PS_2905))
                                    {
                                        EID4705PS_2937 = int((EID4705PS_2900.x > 0.0f) ? (EID4705PS_2897 >> 24u) : ((EID4705PS_2897 >> 16u) & 255u));
                                    }
                                    else
                                    {
                                        int EID4705PS_2936;
                                        if (EID4705PS_2903 > EID4705PS_2905)
                                        {
                                            EID4705PS_2936 = int((EID4705PS_2900.y > 0.0f) ? ((EID4705PS_2897 >> 8u) & 255u) : (EID4705PS_2897 & 255u));
                                        }
                                        else
                                        {
                                            EID4705PS_2936 = int((EID4705PS_2900.z > 0.0f) ? ((EID4705PS_2899 >> 8u) & 255u) : (EID4705PS_2899 & 255u));
                                        }
                                        EID4705PS_2937 = EID4705PS_2936;
                                    }
                                    EID4705PS_2940 = (EID4705PS_2937 < 80) ? EID4705PS_2937 : (-1);
                                }
                                bool EID4705PS_2941 = EID4705PS_2940 >= 0;
                                float EID4705PS_3187;
                                if (EID4705PS_2941)
                                {
                                    float3 EID4705PS_2945 = EID4705PS_533 - EID4705PS_37_m6[EID4705PS_2525].xyz;
                                    float EID4705PS_2946 = dot(EID4705PS_2945, EID4705PS_2945);
                                    float4 EID4705PS_2965 = mul(EID4705PS_39_m10[EID4705PS_2940], float4((EID4705PS_533 - ((EID4705PS_2945 * rsqrt(max(1.1754943508222875079687365372222e-38f, EID4705PS_2946))) * EID4705PS_39_m11[EID4705PS_2940].x)) + (EID4705PS_561 * (EID4705PS_39_m11[EID4705PS_2940].y * 5.0f)), 1.0f));
                                    float EID4705PS_2966 = EID4705PS_2965.w;
                                    float3 EID4705PS_2969 = EID4705PS_2965.xyz / EID4705PS_2966.xxx;
                                    float2 EID4705PS_2970 = EID4705PS_2969.xy;
                                    float3 EID4705PS_2978 = EID4705PS_2969.xyz;
                                    bool3 EID4705PS_2979 = bool3(EID4705PS_2978.x <= 0.0f.xxx.x, EID4705PS_2978.y <= 0.0f.xxx.y, EID4705PS_2978.z <= 0.0f.xxx.z);
                                    bool3 EID4705PS_2980 = bool3(EID4705PS_2978.x >= 1.0f.xxx.x, EID4705PS_2978.y >= 1.0f.xxx.y, EID4705PS_2978.z >= 1.0f.xxx.z);
                                    float EID4705PS_2983 = EID4705PS_2969.z;
                                    float2 EID4705PS_2994 = ((EID4705PS_2970 * (EID4705PS_39_m12[EID4705PS_2940].zw - EID4705PS_39_m12[EID4705PS_2940].xy)) + EID4705PS_39_m12[EID4705PS_2940].xy).xy * EID4705PS_39_m13.zw;
                                    float2 EID4705PS_2996 = floor(EID4705PS_2994 + 0.5f.xx);
                                    float2 EID4705PS_2997 = EID4705PS_2994 - EID4705PS_2996;
                                    float EID4705PS_2998 = EID4705PS_2997.x;
                                    float EID4705PS_2999 = EID4705PS_2998 + 0.5f;
                                    float EID4705PS_3000 = EID4705PS_2999 * EID4705PS_2999;
                                    float EID4705PS_3003 = 1.0f - EID4705PS_2998;
                                    float EID4705PS_3004 = min(EID4705PS_2998, 0.0f);
                                    float EID4705PS_3007 = EID4705PS_2998 + 1.0f;
                                    float EID4705PS_3008 = max(EID4705PS_2998, 0.0f);
                                    float EID4705PS_3019 = EID4705PS_2997.y;
                                    float EID4705PS_3020 = EID4705PS_3019 + 0.5f;
                                    float EID4705PS_3021 = EID4705PS_3020 * EID4705PS_3020;
                                    float EID4705PS_3024 = 1.0f - EID4705PS_3019;
                                    float EID4705PS_3025 = min(EID4705PS_3019, 0.0f);
                                    float EID4705PS_3028 = EID4705PS_3019 + 1.0f;
                                    float EID4705PS_3029 = max(EID4705PS_3019, 0.0f);
                                    float3 EID4705PS_3041 = float3(0.1599999964237213134765625f * EID4705PS_3003, 0.1599999964237213134765625f * ((EID4705PS_3007 - (EID4705PS_3008 * EID4705PS_3008)) + 1.0f), EID4705PS_3000 * 0.07999999821186065673828125f);
                                    float3 EID4705PS_3042 = float3(0.1599999964237213134765625f * ((EID4705PS_3000 * 0.5f) - EID4705PS_2998), 0.1599999964237213134765625f * ((EID4705PS_3003 - (EID4705PS_3004 * EID4705PS_3004)) + 1.0f), 0.1599999964237213134765625f * EID4705PS_3007) + EID4705PS_3041;
                                    float3 EID4705PS_3044 = float3(0.1599999964237213134765625f * EID4705PS_3024, 0.1599999964237213134765625f * ((EID4705PS_3028 - (EID4705PS_3029 * EID4705PS_3029)) + 1.0f), EID4705PS_3021 * 0.07999999821186065673828125f);
                                    float3 EID4705PS_3045 = float3(0.1599999964237213134765625f * ((EID4705PS_3021 * 0.5f) - EID4705PS_3019), 0.1599999964237213134765625f * ((EID4705PS_3024 - (EID4705PS_3025 * EID4705PS_3025)) + 1.0f), 0.1599999964237213134765625f * EID4705PS_3028) + EID4705PS_3044;
                                    float3 EID4705PS_3051 = ((EID4705PS_3041 / EID4705PS_3042) + float3(-2.5f, -0.5f, 1.5f)) * EID4705PS_39_m13.xxx;
                                    float3 EID4705PS_3053 = ((EID4705PS_3044 / EID4705PS_3045) + float3(-2.5f, -0.5f, 1.5f)) * EID4705PS_39_m13.yyy;
                                    float2 EID4705PS_3055 = EID4705PS_2996 * EID4705PS_39_m13.xy;
                                    float EID4705PS_3056 = EID4705PS_3051.x;
                                    float EID4705PS_3057 = EID4705PS_3053.x;
                                    float EID4705PS_3060 = EID4705PS_3051.y;
                                    float EID4705PS_3063 = EID4705PS_3051.z;
                                    float EID4705PS_3066 = EID4705PS_3053.y;
                                    float EID4705PS_3073 = EID4705PS_3053.z;
                                    float EID4705PS_3080 = EID4705PS_3042.x;
                                    float EID4705PS_3081 = EID4705PS_3045.x;
                                    float EID4705PS_3083 = EID4705PS_3042.y;
                                    float EID4705PS_3085 = EID4705PS_3042.z;
                                    float EID4705PS_3087 = EID4705PS_3045.y;
                                    float EID4705PS_3091 = EID4705PS_3045.z;
                                    float2 EID4705PS_3169 = 1.0f.xx - EID4705PS_2970;
                                    float2 EID4705PS_3170 = min(EID4705PS_2970, EID4705PS_3169);
                                    float EID4705PS_3171 = EID4705PS_3170.x;
                                    float EID4705PS_3172 = EID4705PS_3170.y;
                                    float EID4705PS_3173 = min(EID4705PS_3171, EID4705PS_3172);
                                    float EID4705PS_3177 = (EID4705PS_39_m11[EID4705PS_2940].z - EID4705PS_2966) * 0.25f;
                                    float EID4705PS_3179 = smoothstep(0.0f, 0.0500000007450580596923828125f, min(EID4705PS_3177, EID4705PS_3173));
                                    EID4705PS_3187 = EID4705PS_2941 ? lerp(1.0f, (any(bool3(EID4705PS_2979.x || EID4705PS_2980.x, EID4705PS_2979.y || EID4705PS_2980.y, EID4705PS_2979.z || EID4705PS_2980.z)) || ((asuint(EID4705PS_2983) & 2147483647u) > 2139095040u)) ? 1.0f : ((((((((((EID4705PS_3080 * EID4705PS_3081) * EID4705ShadowGreater( float3(EID4705PS_3055 + float2(EID4705PS_3056, EID4705PS_3057), EID4705PS_388).xy, EID4705PS_2983)) + ((EID4705PS_3083 * EID4705PS_3081) * EID4705ShadowGreater( float3(EID4705PS_3055 + float2(EID4705PS_3060, EID4705PS_3057), EID4705PS_388).xy, EID4705PS_2983))) + ((EID4705PS_3085 * EID4705PS_3081) * EID4705ShadowGreater( float3(EID4705PS_3055 + float2(EID4705PS_3063, EID4705PS_3057), EID4705PS_388).xy, EID4705PS_2983))) + ((EID4705PS_3080 * EID4705PS_3087) * EID4705ShadowGreater( float3(EID4705PS_3055 + float2(EID4705PS_3056, EID4705PS_3066), EID4705PS_388).xy, EID4705PS_2983))) + ((EID4705PS_3083 * EID4705PS_3087) * EID4705ShadowGreater( float3(EID4705PS_3055 + float2(EID4705PS_3060, EID4705PS_3066), EID4705PS_388).xy, EID4705PS_2983))) + ((EID4705PS_3085 * EID4705PS_3087) * EID4705ShadowGreater( float3(EID4705PS_3055 + float2(EID4705PS_3063, EID4705PS_3066), EID4705PS_388).xy, EID4705PS_2983))) + ((EID4705PS_3080 * EID4705PS_3091) * EID4705ShadowGreater( float3(EID4705PS_3055 + float2(EID4705PS_3056, EID4705PS_3073), EID4705PS_388).xy, EID4705PS_2983))) + ((EID4705PS_3083 * EID4705PS_3091) * EID4705ShadowGreater( float3(EID4705PS_3055 + float2(EID4705PS_3060, EID4705PS_3073), EID4705PS_388).xy, EID4705PS_2983))) + ((EID4705PS_3085 * EID4705PS_3091) * EID4705ShadowGreater( float3(EID4705PS_3055 + float2(EID4705PS_3063, EID4705PS_3073), EID4705PS_388).xy, EID4705PS_2983))), EID4705PS_2891 ? (min(EID4705PS_39_m11[EID4705PS_2940].w, EID4705PS_3179)) : EID4705PS_39_m11[EID4705PS_2940].w) : 1.0f;
                                }
                                else
                                {
                                    EID4705PS_3187 = clamp(dot(EID4705PS_540, EID4705PS_2726) + 1.0f, 0.0f, 1.0f);
                                }
                                EID4705PS_3188 = EID4705PS_3187;
                            }
                            else
                            {
                                EID4705PS_3188 = 1.0f;
                            }
                            float EID4705PS_3268;
                            float3 EID4705PS_3269;
                            float EID4705PS_3270;
                            float3 EID4705PS_3271;
                            float3 EID4705PS_3272;
                            float EID4705PS_3273;
                            float EID4705PS_3274;
                            [branch]
                            if (EID4705PS_2635 == 0u)
                            {
                                float3 EID4705PS_3194 = EID4705PS_37_m6[EID4705PS_2522].xyz * EID4705PS_2864;
                                float EID4705PS_3195 = EID4705PS_3194.x;
                                float EID4705PS_3196 = EID4705PS_3194.y;
                                float EID4705PS_3197 = EID4705PS_3194.z;
                                float EID4705PS_3198 = max(EID4705PS_3195, EID4705PS_3196);
                                float EID4705PS_3200 = (max(EID4705PS_3198, EID4705PS_3197)) * lerp(0.75f, 0.5f, EID4705PS_2431);
                                float3 EID4705PS_3207 = EID4705PS_2271.xyz;
                                EID4705PS_3268 = EID4705PS_2864;
                                EID4705PS_3269 = (EID4705PS_37_m6[EID4705PS_2522].xyz * ((1.0f - EID4705PS_37_m6[EID4705PS_2534].y) + ((1.0f / (max(1.0f, EID4705PS_3200))) * EID4705PS_37_m6[EID4705PS_2534].y))) * lerp(0.5f * EID4705PS_37_m6[EID4705PS_2534].x, 1.0f, clamp(EID4705PS_2884 + 0.5f, 0.0f, 1.0f));
                                EID4705PS_3270 = EID4705PS_2885;
                                EID4705PS_3271 = EID4705PS_3207;
                                EID4705PS_3272 = EID4705PS_3207;
                                EID4705PS_3273 = 1.0f;
                                EID4705PS_3274 = 0.0f;
                            }
                            else
                            {
                                float EID4705PS_3262;
                                float EID4705PS_3263;
                                float3 EID4705PS_3264;
                                float3 EID4705PS_3265;
                                float EID4705PS_3266;
                                float EID4705PS_3267;
                                if (EID4705PS_2635 == 3u)
                                {
                                    EID4705PS_3262 = EID4705PS_2864 * (smoothstep(lerp(0.800000011920928955078125f, 0.20000000298023223876953125f, EID4705PS_37_m6[EID4705PS_2534].x), lerp(0.89999997615814208984375f, 0.5f, EID4705PS_37_m6[EID4705PS_2534].x), EID4705PS_2395) * EID4705PS_3188);
                                    EID4705PS_3263 = clamp(dot(EID4705PS_2084, -normalize(cross(EID4705PS_573, cross(EID4705PS_573, EID4705PS_2726)))), 0.0f, 1.0f);
                                    EID4705PS_3264 = lerp(0.5f.xxx, EID4705PS_2092, EID4705PS_37_m6[EID4705PS_2534].y.xxx);
                                    EID4705PS_3265 = 0.0f.xxx;
                                    EID4705PS_3266 = 1.0f;
                                    EID4705PS_3267 = 0.0f;
                                }
                                else
                                {
                                    bool EID4705PS_3232 = EID4705PS_2635 == 1u;
                                    float EID4705PS_3256;
                                    float3 EID4705PS_3257;
                                    float EID4705PS_3258;
                                    float EID4705PS_3259;
                                    if (EID4705PS_3232)
                                    {
                                        EID4705PS_3256 = clamp(clamp(EID4705PS_2884 + EID4705PS_37_m6[EID4705PS_2534].x, -1.0f, 1.0f), 0.0f, 1.0f) * EID4705PS_3188;
                                        EID4705PS_3257 = EID4705PS_2096 * EID4705PS_37_m6[EID4705PS_2534].y;
                                        EID4705PS_3258 = 1.0f;
                                        EID4705PS_3259 = 0.0f;
                                    }
                                    else
                                    {
                                        bool EID4705PS_3242 = EID4705PS_2635 == 2u;
                                        float EID4705PS_3254;
                                        if (EID4705PS_3242)
                                        {
                                            EID4705PS_3254 = smoothstep(EID4705PS_37_m6[EID4705PS_2534].x + 0.0500000007450580596923828125f, EID4705PS_37_m6[EID4705PS_2534].x - 0.0500000007450580596923828125f, EID4705PS_2086) * ((1.0f - EID4705PS_37_m6[EID4705PS_2534].z) + (step(0.5f, EID4705PS_2089) * EID4705PS_37_m6[EID4705PS_2534].z));
                                        }
                                        else
                                        {
                                            EID4705PS_3254 = 1.0f;
                                        }
                                        EID4705PS_3256 = EID4705PS_2885;
                                        EID4705PS_3257 = 0.0f.xxx;
                                        EID4705PS_3258 = EID4705PS_3254;
                                        EID4705PS_3259 = EID4705PS_3242 ? EID4705PS_37_m6[EID4705PS_2534].y : 0.0f;
                                    }
                                    bool3 EID4705PS_3260 = EID4705PS_3232.xxx;
                                    EID4705PS_3262 = EID4705PS_2864;
                                    EID4705PS_3263 = EID4705PS_3256;
                                    EID4705PS_3264 = float3(EID4705PS_3260.x ? EID4705PS_2092.x : 0.0f.xxx.x, EID4705PS_3260.y ? EID4705PS_2092.y : 0.0f.xxx.y, EID4705PS_3260.z ? EID4705PS_2092.z : 0.0f.xxx.z);
                                    EID4705PS_3265 = EID4705PS_3257;
                                    EID4705PS_3266 = EID4705PS_3258;
                                    EID4705PS_3267 = EID4705PS_3259;
                                }
                                EID4705PS_3268 = EID4705PS_3262;
                                EID4705PS_3269 = EID4705PS_37_m6[EID4705PS_2522].xyz;
                                EID4705PS_3270 = EID4705PS_3263;
                                EID4705PS_3271 = EID4705PS_3264;
                                EID4705PS_3272 = EID4705PS_3265;
                                EID4705PS_3273 = EID4705PS_3266;
                                EID4705PS_3274 = EID4705PS_3267;
                            }
                            float3 EID4705PS_3302;
                            [branch]
                            if (EID4705PS_2635 != 3u)
                            {
                                float EID4705PS_3279 = lerp(EID4705PS_2098, 0.00999999977648258209228515625f, EID4705PS_3274);
                                float EID4705PS_3282 = dot(EID4705PS_560, normalize(EID4705PS_2726 + EID4705PS_430));
                                float EID4705PS_3283 = EID4705PS_3279 * EID4705PS_3279;
                                float EID4705PS_3287 = (((EID4705PS_3282 * EID4705PS_3283) - EID4705PS_3282) * EID4705PS_3282) + 1.0f;
                                float EID4705PS_3288 = EID4705PS_3287 * EID4705PS_3287;
                                EID4705PS_3302 = ((EID4705PS_2095 * clamp((((EID4705PS_3283 != EID4705PS_3288) ? (EID4705PS_3283 / EID4705PS_3288) : 1.0f) * (0.5f / ((EID4705PS_2306 + (EID4705PS_3279 * EID4705PS_2308)) + 9.9999997473787516355514526367188e-05f))) - 6.103515625e-05f, 0.0f, 20.0f)) * EID4705PS_3273) * EID4705PS_37_m6[EID4705PS_2543].z;
                            }
                            else
                            {
                                EID4705PS_3302 = 0.0f.xxx;
                            }
                            float3 EID4705PS_3305 = EID4705PS_3269 * EID4705PS_3268;
                            EID4705PS_3312 = EID4705PS_2486 + (((EID4705PS_3305 * lerp(EID4705PS_3272, EID4705PS_3271, EID4705PS_3270.xxx)) * 1.0f) + ((EID4705PS_3305 * EID4705PS_3302) * EID4705PS_3270));
                        }
                        else
                        {
                            EID4705PS_3312 = EID4705PS_2486;
                        }
                        EID4705PS_3313 = EID4705PS_3312;
                        return;
}

[noinline]
void EID4705PS_EarlyExit1(inout int EID4705PS_2531, inout float3 EID4705PS_3314, inout float3 EID4705PS_2486, inout int EID4705PS_2522, inout int EID4705PS_2528, inout int EID4705PS_2534, inout int EID4705PS_2540, inout int EID4705PS_2525, inout float3 EID4705PS_533, inout int EID4705PS_2543, inout float EID4705PS_605, inout float EID4705PS_2622, inout float3 EID4705PS_561, inout float3 EID4705PS_2084, inout uint EID4705PS_2547, inout float3 EID4705PS_540, inout float EID4705PS_2431, inout float4 EID4705PS_2271, inout float EID4705PS_2395, inout float3 EID4705PS_573, inout float3 EID4705PS_2092, inout float3 EID4705PS_2096, inout float EID4705PS_2086, inout float EID4705PS_2089, inout float EID4705PS_2098, inout float3 EID4705PS_560, inout float3 EID4705PS_430, inout float3 EID4705PS_2095, inout float EID4705PS_2306, inout float EID4705PS_2308)
{
                    uint EID4705PS_2635 = asuint(EID4705PS_37_m6[EID4705PS_2531].w);
                    if ((EID4705PS_2635 == 16u) || ((EID4705PS_37_m6[EID4705PS_2531].z + EID4705PS_20_m91.z) < 0.5f))
                    {
                        EID4705PS_3314 = EID4705PS_2486;
                        return;
                    }
                    bool EID4705PS_2647 = (uint(EID4705PS_37_m6[EID4705PS_2522].w) & 1u) == 0u;
                    bool EID4705PS_2651 = (!EID4705PS_2647) && (EID4705PS_37_m6[EID4705PS_2528].z > 0.0f);
                    bool EID4705PS_2652 = EID4705PS_2635 == 4u;
                    float EID4705PS_2653 = float(EID4705PS_2647);
                    float EID4705PS_2661 = (0.5f + (0.5f * EID4705PS_37_m6[EID4705PS_2528].y)) - abs(EID4705PS_37_m6[EID4705PS_2528].x);
                    float EID4705PS_2662 = EID4705PS_37_m6[EID4705PS_2528].y - EID4705PS_2661;
                    float EID4705PS_2666 = (1.0f - abs(EID4705PS_2661)) - abs(EID4705PS_2662);
                    float EID4705PS_2669 = abs(max(EID4705PS_2666, 0.00048828125f));
                    float3 EID4705PS_2673 = normalize(float3(EID4705PS_2661, EID4705PS_2662, (EID4705PS_37_m6[EID4705PS_2528].x >= 0.0f) ? EID4705PS_2669 : (-EID4705PS_2669)));
                    float EID4705PS_2676 = 2.0f * EID4705PS_37_m6[EID4705PS_2534].y;
                    float EID4705PS_2679 = lerp(EID4705PS_37_m6[EID4705PS_2540].w, max(EID4705PS_2676, 0.100000001490116119384765625f), float(EID4705PS_2652));
                    float3 EID4705PS_2684 = EID4705PS_37_m6[EID4705PS_2525].xyz - EID4705PS_533;
                    float3 EID4705PS_2685 = -EID4705PS_2673;
                    float3 EID4705PS_2690 = lerp(EID4705PS_2684, EID4705PS_2685 * dot(EID4705PS_2684, EID4705PS_2685), (float(EID4705PS_2652 && (EID4705PS_37_m6[EID4705PS_2534].z > 0.5f)) * EID4705PS_2653).xxx);
                    float EID4705PS_2691 = dot(EID4705PS_2690, EID4705PS_2690);
                    float EID4705PS_2692 = rsqrt(EID4705PS_2691);
                    float3 EID4705PS_2693 = EID4705PS_2690 * EID4705PS_2692;
                    float3 EID4705PS_2726;
                    float EID4705PS_2727;
                    if (EID4705PS_2651)
                    {
                        float3 EID4705PS_2697 = (EID4705PS_2673 * EID4705PS_37_m6[EID4705PS_2528].z) * 0.5f;
                        float3 EID4705PS_2698 = EID4705PS_2690 - EID4705PS_2697;
                        float3 EID4705PS_2699 = EID4705PS_2690 + EID4705PS_2697;
                        float EID4705PS_2700 = length(EID4705PS_2698);
                        float EID4705PS_2701 = length(EID4705PS_2699);
                        float3 EID4705PS_2710 = normalize(cross(cross(EID4705PS_2673, EID4705PS_2693), EID4705PS_2673));
                        EID4705PS_2726 = EID4705PS_2710;
                        EID4705PS_2727 = ((1.0f / ((((EID4705PS_2700 * EID4705PS_2701) + dot(EID4705PS_2698, EID4705PS_2699)) * 0.5f) + 1.0f)) * clamp(0.5f * ((dot(EID4705PS_2710, EID4705PS_2698) / EID4705PS_2700) + (dot(EID4705PS_2710, EID4705PS_2699) / EID4705PS_2701)), 0.0f, 1.0f)) * (1.0f / clamp(1.0f + (0.5f * clamp(EID4705PS_37_m6[EID4705PS_2528].z * EID4705PS_2692, 0.0f, 1.0f)), 0.0f, 1.0f));
                    }
                    else
                    {
                        EID4705PS_2726 = EID4705PS_2693;
                        EID4705PS_2727 = 1.0f;
                    }
                    float EID4705PS_2749;
                    if (EID4705PS_2679 < 0.0f)
                    {
                        float EID4705PS_2737 = EID4705PS_2691 * (EID4705PS_37_m6[EID4705PS_2525].w * EID4705PS_37_m6[EID4705PS_2525].w);
                        float EID4705PS_2740 = clamp(1.0f - (EID4705PS_2737 * EID4705PS_2737), 0.0f, 1.0f);
                        EID4705PS_2749 = lerp(1.0f / (EID4705PS_2691 + 1.0f), EID4705PS_2727, float(EID4705PS_2651)) * (EID4705PS_2740 * EID4705PS_2740);
                    }
                    else
                    {
                        float3 EID4705PS_2743 = EID4705PS_2690 * EID4705PS_37_m6[EID4705PS_2525].w;
                        EID4705PS_2749 = EID4705PS_2727 * pow(1.0f - clamp(dot(EID4705PS_2743, EID4705PS_2743), 0.0f, 1.0f), EID4705PS_2679);
                    }
                    float EID4705PS_2754 = clamp((dot(EID4705PS_2726, EID4705PS_2685) - EID4705PS_37_m6[EID4705PS_2528].z) * EID4705PS_37_m6[EID4705PS_2528].w, 0.0f, 1.0f);
                    float EID4705PS_2757 = EID4705PS_2749 * lerp(1.0f, EID4705PS_2754 * EID4705PS_2754, EID4705PS_2653);
                    int EID4705PS_2759 = int(EID4705PS_37_m6[EID4705PS_2543].w);
                    float EID4705PS_2863;
                    if ((!EID4705PS_2651) && (EID4705PS_2759 >= 0))
                    {
                        uint EID4705PS_2765 = uint(EID4705PS_2759);
                        float2 EID4705PS_2856;
                        [branch]
                        if (EID4705PS_2653 != 0.0f)
                        {
                            float4 EID4705PS_2777 = mul(EID4705PS_59_m1[EID4705PS_2765], float4(EID4705PS_533.x, EID4705PS_605, EID4705PS_533.z, 1.0f));
                            EID4705PS_2856 = EID4705PS_59_m0[EID4705PS_2765].xy + (clamp(EID4705PS_2777.xy / EID4705PS_2777.w.xx, 0.0f.xx, 1.0f.xx) * EID4705PS_59_m0[EID4705PS_2765].zw);
                        }
                        else
                        {
                            float3 EID4705PS_2797 = mul(float4(-EID4705PS_2690, 0.0f), EID4705PS_59_m1[EID4705PS_2765]).xyz;
                            float3 EID4705PS_399 = EID4705PS_2797;
                            float3 EID4705PS_398 = EID4705PS_2797;
                            float3 EID4705PS_397 = abs(EID4705PS_2797);
                            uint EID4705PS_2806 = uint(int(EID4705PS_397.y > EID4705PS_397.x));
                            uint EID4705PS_2812 = (EID4705PS_397.z > EID4705PS_397[EID4705PS_2806]) ? 2u : EID4705PS_2806;
                            uint EID4705PS_2818 = (EID4705PS_2812 * 2u) + uint(EID4705PS_398[EID4705PS_2812] < 0.0f);
                            float EID4705PS_2822 = abs(EID4705PS_399[EID4705PS_2818 / 2u]);
                            float EID4705PS_2842 = 0.5f - (0.000244140625f / EID4705PS_59_m0[EID4705PS_2765].w);
                            EID4705PS_2856 = EID4705PS_59_m0[EID4705PS_2765].xy + (clamp(float2((float(EID4705PS_2818) + ((((EID4705PS_399[uint(EID4705PS_362[EID4705PS_2818].x)] * EID4705PS_363[EID4705PS_2818].x) / EID4705PS_2822) * EID4705PS_2842) + 0.5f)) * 0.16666667163372039794921875f, 0.5f - (((EID4705PS_399[uint(EID4705PS_362[EID4705PS_2818].y)] * EID4705PS_363[EID4705PS_2818].y) / EID4705PS_2822) * EID4705PS_2842)), 0.0f.xx, 1.0f.xx) * EID4705PS_59_m0[EID4705PS_2765].zw);
                        }
                        EID4705PS_2863 = EID4705PS_2757 * EID4705PS_57.SampleLevel(EID4705_linear_clamp_sampler, EID4705PS_2856, 0.0f).x;
                    }
                    else
                    {
                        EID4705PS_2863 = EID4705PS_2757;
                    }
                    float EID4705PS_2864 = EID4705PS_2863 * EID4705PS_2622;
                    float3 EID4705PS_3313;
                    EID4705PS_EarlyExit0(EID4705PS_2864, EID4705PS_2652, EID4705PS_3313, EID4705PS_2486, EID4705PS_2522, EID4705PS_2534, EID4705PS_561, EID4705PS_2726, EID4705PS_2084, EID4705PS_2635, EID4705PS_2647, EID4705PS_2547, EID4705PS_2531, EID4705PS_2528, EID4705PS_533, EID4705PS_2525, EID4705PS_540, EID4705PS_2431, EID4705PS_2271, EID4705PS_2395, EID4705PS_573, EID4705PS_2092, EID4705PS_2096, EID4705PS_2086, EID4705PS_2089, EID4705PS_2098, EID4705PS_560, EID4705PS_430, EID4705PS_2095, EID4705PS_2306, EID4705PS_2308, EID4705PS_2543);
                    EID4705PS_3314 = EID4705PS_3313;
                    return;
}

void EID4705PS_frag_main()
{
    float EID4705PS_411 = 1.0f / EID4705PS_gl_FragCoord.w;
    float3 EID4705PS_426 = lerp(-EID4705PS_4, float3(EID4705PS_18_m0[2u].x, EID4705PS_18_m0[2u].y, EID4705PS_18_m0[2u].z), EID4705PS_20_m4.w.xxx);
    float EID4705PS_427 = dot(EID4705PS_426, EID4705PS_426);
    float EID4705PS_429 = rsqrt(max(EID4705PS_427, 9.9999999392252902907785028219223e-09f));
    float3 EID4705PS_430 = EID4705PS_426 * EID4705PS_429;
    float EID4705PS_431 = EID4705PS_427 * EID4705PS_429;
    uint EID4705PS_434 = asuint(EID4705PS_LoadInstance(EID4705PS_13)._m2.x);
    bool EID4705PS_439 = (asuint(EID4705PS_LoadInstance(EID4705PS_13)._m1.w) & 16u) != 0u;
    float4 EID4705PS_452;
    float4 EID4705PS_453;
    if (EID4705PS_439)
    {
        EID4705PS_452 = asfloat(EID4705PS_33.Load4((EID4705PS_434 + 2u) * 16 + 0));
        EID4705PS_453 = asfloat(EID4705PS_33.Load4(EID4705PS_434 * 16 + 0));
    }
    else
    {
        EID4705PS_452 = EID4705PS_LoadInstance(EID4705PS_13)._m0[2];
        EID4705PS_453 = EID4705PS_LoadInstance(EID4705PS_13)._m0[0];
    }
    float4 EID4705PS_459 = EID4705PS_55.SampleBias(EID4705_linear_repeat_sampler, EID4705PS_3, EID4705PS_20_m16);
    float3 EID4705PS_464 = EID4705PS_459.xyz * EID4705PS_50_m24.xyz;
    float EID4705PS_471 = 1.0f - EID4705PS_50_m0;
    float EID4705PS_472 = EID4705PS_459.w;
    float3 EID4705PS_473 = EID4705PS_464 * 12.9200000762939453125f;
    float3 EID4705PS_477 = (pow(abs(EID4705PS_464), 0.4166666567325592041015625f.xxx) * 1.05499994754791259765625f) - 0.054999999701976776123046875f.xxx;
    bool3 EID4705PS_478 = bool3(EID4705PS_464.x <= 0.003130800090730190277099609375f.xxx.x, EID4705PS_464.y <= 0.003130800090730190277099609375f.xxx.y, EID4705PS_464.z <= 0.003130800090730190277099609375f.xxx.z);
    float3 EID4705PS_480 = clamp(float3(EID4705PS_478.x ? EID4705PS_473.x : EID4705PS_477.x, EID4705PS_478.y ? EID4705PS_473.y : EID4705PS_477.y, EID4705PS_478.z ? EID4705PS_473.z : EID4705PS_477.z), 0.0f.xxx, 1.0f.xxx);
    float EID4705PS_484 = EID4705PS_480.z * 31.0f;
    float EID4705PS_485 = floor(EID4705PS_484);
    float2 EID4705PS_489 = ((EID4705PS_480.xy * 31.0f) * float2(0.0009765625f, 0.03125f)) + float2(0.00048828125f, 0.015625f);
    float3 EID4705PS_494 = float3(EID4705PS_489.x, EID4705PS_489.y, EID4705PS_480.z);
    EID4705PS_494.x = EID4705PS_489.x + (EID4705PS_485 * 0.03125f);
    float3 EID4705PS_505 = lerp(EID4705PS_52.SampleLevel(EID4705_linear_clamp_sampler, EID4705PS_494.xy, 0.0f).xyz, EID4705PS_52.SampleLevel(EID4705_linear_clamp_sampler, EID4705PS_494.xy + float2(0.03125f, 0.0f), 0.0f).xyz, (EID4705PS_484 - EID4705PS_485).xxx);
    float4 EID4705PS_509 = EID4705PS_56.SampleBias(EID4705_linear_repeat_sampler, EID4705PS_3, EID4705PS_20_m16);
    float4 EID4705PS_515 = EID4705PS_509;
    EID4705PS_515.w = EID4705PS_509.w * EID4705PS_509.x;
    float2 EID4705PS_518 = (EID4705PS_515.wy * 2.0f) - 1.0f.xx;
    float2 EID4705PS_520 = EID4705PS_518.xy;
    float EID4705PS_524 = sqrt(1.0f - clamp(dot(EID4705PS_520, EID4705PS_520), 0.0f, 1.0f));
    float3 EID4705PS_526 = float3(EID4705PS_518.x, EID4705PS_518.y, EID4705PS_389.z);
    EID4705PS_526.z = max(1.000000016862383526387164645044e-16f, EID4705PS_524);
    float2 EID4705PS_528 = EID4705PS_526.xy * EID4705PS_50_m3;
    float3 EID4705PS_533 = EID4705PS_4 + EID4705PS_18_m11.xyz;
    float3 EID4705PS_538 = EID4705PS_533 - float3(EID4705PS_453.w, EID4705PS_394, EID4705PS_452.w);
    EID4705PS_538.y = 6.103515625e-05f;
    float3 EID4705PS_540 = normalize(EID4705PS_538);
    float3 EID4705PS_546 = EID4705PS_6.xyz * 1.0f;
    float3 EID4705PS_547 = (cross(EID4705PS_5, EID4705PS_6.xyz) * EID4705PS_6.w) * 1.0f;
    float3 EID4705PS_548 = EID4705PS_5 * 1.0f;
    float3 EID4705PS_550 = mul(float3(EID4705PS_528.x, EID4705PS_528.y, EID4705PS_526.z), float3x3(EID4705PS_546, EID4705PS_547, EID4705PS_548));
    float EID4705PS_551 = dot(EID4705PS_550, EID4705PS_550);
    float EID4705PS_559 = EID4705PS_gl_FrontFacing ? 1.0f : ((-1.0f) + (2.0f * EID4705PS_50_m5));
    float3 EID4705PS_560 = (EID4705PS_550 * rsqrt(max(1.1754943508222875079687365372222e-38f, EID4705PS_551))) * EID4705PS_559;
    float3 EID4705PS_561 = normalize(EID4705PS_5) * EID4705PS_559;
    uint2 EID4705PS_563 = uint2(EID4705PS_gl_FragCoord.xy);
    float3 EID4705PS_573 = mul(float3x3(EID4705PS_18_m1[0].xyz, EID4705PS_18_m1[1].xyz, EID4705PS_18_m1[2].xyz), float3(0.0f, 0.0f, 1.0f));
    uint EID4705PS_582 = asuint((EID4705PS_20_m89.x > 0.5f) ? EID4705PS_20_m89.y : EID4705PS_LoadInstance(EID4705PS_13)._m7.x);
    float4 EID4705PS_595 = float4(float(EID4705PS_582 & 255u), float((EID4705PS_582 >> 8u) & 255u), float((EID4705PS_582 >> 16u) & 255u), float((EID4705PS_582 >> 24u) & 255u)) * 0.0039215688593685626983642578125f.xxxx;
    float EID4705PS_596 = EID4705PS_595.x;
    float EID4705PS_598 = EID4705PS_595.z;
    float EID4705PS_599 = EID4705PS_595.w;
    float EID4705PS_605 = EID4705PS_533.y;
    float EID4705PS_608 = smoothstep(-0.20000000298023223876953125f, 0.1500000059604644775390625f, lerp(EID4705PS_LoadInstance(EID4705PS_13)._m7.y, EID4705PS_20_m89.w, EID4705PS_20_m89.x) - EID4705PS_605) * EID4705PS_595.y;
    float EID4705PS_609 = max(EID4705PS_598, EID4705PS_608);
    float EID4705PS_617 = lerp(EID4705PS_20_m22.x, 1.0f, EID4705PS_20_m91.w) * EID4705PS_20_m20.x;
    float EID4705PS_619 = EID4705PS_560.z;
    float3 EID4705PS_621 = normalize(float3(EID4705PS_560.x, 6.103515625e-05f, EID4705PS_619));
    float4 EID4705PS_1115;
    float3 EID4705PS_1116;
    float3 EID4705PS_1117;
    float EID4705PS_1118;
    if (EID4705PS_20_m80.y < 0.5f)
    {
        float3 EID4705PS_636 = EID4705PS_533 - (EID4705PS_20_m105.xyz + (EID4705PS_573 * (-EID4705PS_20_m107.w)));
        float EID4705PS_638 = abs(EID4705PS_636.x);
        float EID4705PS_640 = abs(EID4705PS_636.z);
        float EID4705PS_646 = clamp(((max(EID4705PS_638, EID4705PS_640)) - 464.0f) * 0.03125f, 0.0f, 1.0f);
        float EID4705PS_649 = clamp((abs(EID4705PS_636.y) - 208.0f) * 0.03125f, 0.0f, 1.0f);
        float EID4705PS_650 = max(EID4705PS_646, EID4705PS_649);
        float4 EID4705PS_952;
        float4 EID4705PS_953;
        float4 EID4705PS_954;
        float EID4705PS_955;
        float EID4705PS_956;
        if ((EID4705PS_20_m105.w != 0.0f) && (EID4705PS_650 < 1.0f))
        {
            float3 EID4705PS_663 = EID4705PS_533 - (EID4705PS_20_m105.xyz + (EID4705PS_573 * (-EID4705PS_20_m107.y)));
            float EID4705PS_665 = abs(EID4705PS_663.x);
            float EID4705PS_667 = abs(EID4705PS_663.z);
            float EID4705PS_673 = clamp(((max(EID4705PS_665, EID4705PS_667)) - 29.0f) * 0.5f, 0.0f, 1.0f);
            float EID4705PS_676 = clamp((abs(EID4705PS_663.y) - 13.0f) * 0.5f, 0.0f, 1.0f);
            float EID4705PS_677 = max(EID4705PS_673, EID4705PS_676);
            float EID4705PS_753;
            float4 EID4705PS_754;
            float4 EID4705PS_755;
            float4 EID4705PS_756;
            if (EID4705PS_677 < 1.0f)
            {
                float3 EID4705PS_686 = ((EID4705PS_533 * 2.0f) + 0.5f.xxx) * EID4705PS_20_m106.xyz;
                float3 EID4705PS_688 = EID4705PS_686 - floor(EID4705PS_686);
                float4 EID4705PS_692 = EID4705PS_43.SampleLevel(EID4705_linear_repeat_sampler, EID4705PS_688, 0.0f);
                float EID4705PS_693 = 1.0f - EID4705PS_677;
                float EID4705PS_697 = EID4705PS_20_m106.y * 0.5f;
                float EID4705PS_702 = EID4705PS_688.x;
                float EID4705PS_703 = clamp(EID4705PS_688.y, EID4705PS_697, 1.0f - EID4705PS_697) * 0.3333333432674407958984375f;
                float EID4705PS_704 = EID4705PS_688.z;
                float4 EID4705PS_707 = EID4705PS_44.SampleLevel(EID4705_linear_clamp_sampler, float3(EID4705PS_702, EID4705PS_703, EID4705PS_704), 0.0f);
                float EID4705PS_723 = EID4705PS_692.x;
                float EID4705PS_733 = EID4705PS_692.y;
                float EID4705PS_743 = EID4705PS_692.z;
                EID4705PS_753 = EID4705PS_650 + (EID4705PS_707.w * EID4705PS_693);
                EID4705PS_754 = float4(((EID4705PS_44.SampleLevel(EID4705_linear_clamp_sampler, float3(EID4705PS_702, EID4705PS_703 + 0.666666686534881591796875f, EID4705PS_704), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4705PS_743, EID4705PS_743) * EID4705PS_693;
                EID4705PS_755 = float4(((EID4705PS_44.SampleLevel(EID4705_linear_clamp_sampler, float3(EID4705PS_702, EID4705PS_703 + 0.3333333432674407958984375f, EID4705PS_704), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4705PS_733, EID4705PS_733) * EID4705PS_693;
                EID4705PS_756 = float4(((EID4705PS_707.xyz * 4.0f) - 2.0f.xxx) * EID4705PS_723, EID4705PS_723) * EID4705PS_693;
            }
            else
            {
                EID4705PS_753 = EID4705PS_650;
                EID4705PS_754 = 0.0f.xxxx;
                EID4705PS_755 = 0.0f.xxxx;
                EID4705PS_756 = 0.0f.xxxx;
            }
            float3 EID4705PS_762 = EID4705PS_533 - (EID4705PS_20_m105.xyz + (EID4705PS_573 * (-EID4705PS_20_m107.z)));
            float EID4705PS_764 = abs(EID4705PS_762.x);
            float EID4705PS_766 = abs(EID4705PS_762.z);
            float EID4705PS_772 = clamp(((max(EID4705PS_764, EID4705PS_766)) - 116.0f) * 0.125f, 0.0f, 1.0f);
            float EID4705PS_775 = clamp((abs(EID4705PS_762.y) - 52.0f) * 0.125f, 0.0f, 1.0f);
            float EID4705PS_776 = max(EID4705PS_772, EID4705PS_775);
            float EID4705PS_856;
            float4 EID4705PS_857;
            float4 EID4705PS_858;
            float4 EID4705PS_859;
            if (EID4705PS_776 < 1.0f)
            {
                float3 EID4705PS_785 = ((EID4705PS_533 * 0.5f) + 0.5f.xxx) * EID4705PS_20_m106.xyz;
                float3 EID4705PS_787 = EID4705PS_785 - floor(EID4705PS_785);
                float4 EID4705PS_791 = EID4705PS_45.SampleLevel(EID4705_linear_repeat_sampler, EID4705PS_787, 0.0f);
                float EID4705PS_793 = EID4705PS_677 * (1.0f - EID4705PS_776);
                float EID4705PS_797 = EID4705PS_20_m106.y * 0.5f;
                float EID4705PS_802 = EID4705PS_787.x;
                float EID4705PS_803 = clamp(EID4705PS_787.y, EID4705PS_797, 1.0f - EID4705PS_797) * 0.3333333432674407958984375f;
                float EID4705PS_804 = EID4705PS_787.z;
                float4 EID4705PS_807 = EID4705PS_46.SampleLevel(EID4705_linear_clamp_sampler, float3(EID4705PS_802, EID4705PS_803, EID4705PS_804), 0.0f);
                float EID4705PS_823 = EID4705PS_791.x;
                float EID4705PS_834 = EID4705PS_791.y;
                float EID4705PS_845 = EID4705PS_791.z;
                EID4705PS_856 = EID4705PS_753 + (EID4705PS_807.w * EID4705PS_793);
                EID4705PS_857 = EID4705PS_754 + (float4(((EID4705PS_46.SampleLevel(EID4705_linear_clamp_sampler, float3(EID4705PS_802, EID4705PS_803 + 0.666666686534881591796875f, EID4705PS_804), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4705PS_845, EID4705PS_845) * EID4705PS_793);
                EID4705PS_858 = EID4705PS_755 + (float4(((EID4705PS_46.SampleLevel(EID4705_linear_clamp_sampler, float3(EID4705PS_802, EID4705PS_803 + 0.3333333432674407958984375f, EID4705PS_804), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4705PS_834, EID4705PS_834) * EID4705PS_793);
                EID4705PS_859 = EID4705PS_756 + (float4(((EID4705PS_807.xyz * 4.0f) - 2.0f.xxx) * EID4705PS_823, EID4705PS_823) * EID4705PS_793);
            }
            else
            {
                EID4705PS_856 = EID4705PS_753;
                EID4705PS_857 = EID4705PS_754;
                EID4705PS_858 = EID4705PS_755;
                EID4705PS_859 = EID4705PS_756;
            }
            float4 EID4705PS_942;
            float4 EID4705PS_943;
            float4 EID4705PS_944;
            float EID4705PS_945;
            if (EID4705PS_776 > 0.0f)
            {
                float3 EID4705PS_868 = ((EID4705PS_533 * 0.125f) + 0.5f.xxx) * EID4705PS_20_m106.xyz;
                float3 EID4705PS_871 = EID4705PS_20_m106.xyz * 0.5f;
                float3 EID4705PS_873 = clamp(EID4705PS_868 - floor(EID4705PS_868), EID4705PS_871, 1.0f.xxx - EID4705PS_871);
                float4 EID4705PS_877 = EID4705PS_47.SampleLevel(EID4705_linear_repeat_sampler, EID4705PS_873, 0.0f);
                float EID4705PS_879 = EID4705PS_776 * (1.0f - EID4705PS_650);
                float EID4705PS_883 = EID4705PS_20_m106.y * 0.5f;
                float EID4705PS_888 = EID4705PS_873.x;
                float EID4705PS_889 = clamp(EID4705PS_873.y, EID4705PS_883, 1.0f - EID4705PS_883) * 0.3333333432674407958984375f;
                float EID4705PS_890 = EID4705PS_873.z;
                float4 EID4705PS_893 = EID4705PS_48.SampleLevel(EID4705_linear_clamp_sampler, float3(EID4705PS_888, EID4705PS_889, EID4705PS_890), 0.0f);
                float EID4705PS_909 = EID4705PS_877.x;
                float EID4705PS_920 = EID4705PS_877.y;
                float EID4705PS_931 = EID4705PS_877.z;
                EID4705PS_942 = EID4705PS_857 + (float4(((EID4705PS_48.SampleLevel(EID4705_linear_clamp_sampler, float3(EID4705PS_888, EID4705PS_889 + 0.666666686534881591796875f, EID4705PS_890), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4705PS_931, EID4705PS_931) * EID4705PS_879);
                EID4705PS_943 = EID4705PS_858 + (float4(((EID4705PS_48.SampleLevel(EID4705_linear_clamp_sampler, float3(EID4705PS_888, EID4705PS_889 + 0.3333333432674407958984375f, EID4705PS_890), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4705PS_920, EID4705PS_920) * EID4705PS_879);
                EID4705PS_944 = EID4705PS_859 + (float4(((EID4705PS_893.xyz * 4.0f) - 2.0f.xxx) * EID4705PS_909, EID4705PS_909) * EID4705PS_879);
                EID4705PS_945 = EID4705PS_856 + (EID4705PS_893.w * EID4705PS_879);
            }
            else
            {
                EID4705PS_942 = EID4705PS_857;
                EID4705PS_943 = EID4705PS_858;
                EID4705PS_944 = EID4705PS_859;
                EID4705PS_945 = EID4705PS_856;
            }
            float EID4705PS_948 = clamp((EID4705PS_945 * 2.0f) - 1.0f, 0.0f, 1.0f);
            EID4705PS_952 = EID4705PS_942;
            EID4705PS_953 = EID4705PS_943;
            EID4705PS_954 = EID4705PS_944;
            EID4705PS_955 = EID4705PS_948 - EID4705PS_650;
            EID4705PS_956 = (EID4705PS_948 + EID4705PS_650) * 0.5f;
        }
        else
        {
            EID4705PS_952 = 0.0f.xxxx;
            EID4705PS_953 = 0.0f.xxxx;
            EID4705PS_954 = 0.0f.xxxx;
            EID4705PS_955 = 0.0f;
            EID4705PS_956 = 1.0f;
        }
        float4 EID4705PS_976 = EID4705PS_954 + float4(EID4705PS_20_m108.x * EID4705PS_956, (EID4705PS_20_m108.y * EID4705PS_956) + ((EID4705PS_20_m108.w * EID4705PS_955) * 0.5f), EID4705PS_20_m108.z * EID4705PS_956, (EID4705PS_20_m108.w * EID4705PS_956) + ((EID4705PS_20_m108.y * EID4705PS_955) * 0.375f));
        float4 EID4705PS_996 = EID4705PS_953 + float4(EID4705PS_20_m109.x * EID4705PS_956, (EID4705PS_20_m109.y * EID4705PS_956) + ((EID4705PS_20_m109.w * EID4705PS_955) * 0.5f), EID4705PS_20_m109.z * EID4705PS_956, (EID4705PS_20_m109.w * EID4705PS_956) + ((EID4705PS_20_m109.y * EID4705PS_955) * 0.375f));
        float4 EID4705PS_1016 = EID4705PS_952 + float4(EID4705PS_20_m110.x * EID4705PS_956, (EID4705PS_20_m110.y * EID4705PS_956) + ((EID4705PS_20_m110.w * EID4705PS_955) * 0.5f), EID4705PS_20_m110.z * EID4705PS_956, (EID4705PS_20_m110.w * EID4705PS_956) + ((EID4705PS_20_m110.y * EID4705PS_955) * 0.375f));
        float4 EID4705PS_1020 = float4(EID4705PS_621, 1.0f);
        float3 EID4705PS_1024 = float3(dot(EID4705PS_976, EID4705PS_1020), dot(EID4705PS_996, EID4705PS_1020), dot(EID4705PS_1016, EID4705PS_1020));
        float3 EID4705PS_1026 = max(EID4705PS_1024, 0.0f.xxx) * EID4705PS_617;
        float3 EID4705PS_1034 = ((EID4705PS_976.xyz * 0.2125999927520751953125f) + (EID4705PS_996.xyz * 0.715200006961822509765625f)) + (EID4705PS_1016.xyz * 0.072200000286102294921875f);
        float EID4705PS_1035 = dot(EID4705PS_1034, EID4705PS_1034);
        float3 EID4705PS_1038 = EID4705PS_1034 * rsqrt(max(1.1754943508222875079687365372222e-38f, EID4705PS_1035));
        float EID4705PS_1040 = abs(EID4705PS_1038.y);
        float3 EID4705PS_1041 = EID4705PS_1038;
        EID4705PS_1041.y = EID4705PS_1040;
        float4 EID4705PS_1043 = float4(EID4705PS_1041.x, EID4705PS_1041.y, EID4705PS_1041.z, 0.0f.xxxx.w);
        EID4705PS_1043.w = 1.0f;
        float4 EID4705PS_1046 = float4(EID4705PS_1038.x, EID4705PS_1040, EID4705PS_1038.z, 1.0f);
        float3 EID4705PS_1050 = float3(dot(EID4705PS_976, EID4705PS_1046), dot(EID4705PS_996, EID4705PS_1046), dot(EID4705PS_1016, EID4705PS_1046));
        float3 EID4705PS_1051 = max(EID4705PS_1050, 0.0f.xxx);
        float EID4705PS_1052 = EID4705PS_1051.x;
        float EID4705PS_1053 = EID4705PS_1051.y;
        float EID4705PS_1054 = EID4705PS_1051.z;
        float EID4705PS_1055 = max(EID4705PS_1052, EID4705PS_1053);
        float EID4705PS_1056 = max(EID4705PS_1055, EID4705PS_1054);
        float EID4705PS_1059 = EID4705PS_1026.z;
        float EID4705PS_1060 = EID4705PS_1026.y;
        float4 EID4705PS_1065 = lerp(float4(EID4705PS_1059, EID4705PS_1060, -1.0f, 0.666666686534881591796875f), float4(EID4705PS_1060, EID4705PS_1059, 0.0f, -0.3333333432674407958984375f), step(EID4705PS_1059, EID4705PS_1060).xxxx);
        float EID4705PS_1066 = EID4705PS_1026.x;
        float EID4705PS_1067 = EID4705PS_1065.x;
        float4 EID4705PS_1075 = lerp(float4(EID4705PS_1067, EID4705PS_1065.yw, EID4705PS_1066), float4(EID4705PS_1066, EID4705PS_1065.yz, EID4705PS_1067), step(EID4705PS_1067, EID4705PS_1066).xxxx);
        float EID4705PS_1076 = EID4705PS_1075.x;
        float EID4705PS_1077 = EID4705PS_1075.w;
        float EID4705PS_1078 = EID4705PS_1075.y;
        float EID4705PS_1080 = EID4705PS_1076 - (min(EID4705PS_1077, EID4705PS_1078));
        float EID4705PS_1089 = EID4705PS_1080 / (EID4705PS_1076 + 9.9999997473787516355514526367188e-05f);
        float EID4705PS_1090 = frac(abs(EID4705PS_1075.z + ((EID4705PS_1077 - EID4705PS_1078) / ((6.0f * EID4705PS_1080) + 9.9999997473787516355514526367188e-05f))));
        float EID4705PS_1096 = lerp(0.699999988079071044921875f, 0.3499999940395355224609375f, smoothstep(0.449999988079071044921875f, 0.3499999940395355224609375f, abs(EID4705PS_1090 - 0.5f))) * clamp(EID4705PS_1076, 0.0f, 1.0f);
        float EID4705PS_1097 = min(EID4705PS_1089, EID4705PS_1096);
        float EID4705PS_1099 = 2.0f / (2.0f - EID4705PS_1097);
        EID4705PS_1115 = EID4705PS_1043;
        EID4705PS_1116 = EID4705PS_1026;
        EID4705PS_1117 = lerp(1.0f.xxx, clamp(abs((frac(float3(EID4705PS_1090, EID4705PS_1097, EID4705PS_1099).xxx + float3(1.0f, 0.666666686534881591796875f, 0.3333333432674407958984375f)) * 6.0f) - 3.0f.xxx) - 1.0f.xxx, 0.0f.xxx, 1.0f.xxx), EID4705PS_1097.xxx) * EID4705PS_1099;
        EID4705PS_1118 = (max(EID4705PS_1056, 0.0f)) * EID4705PS_617;
    }
    else
    {
        EID4705PS_1115 = 0.0f.xxxx;
        EID4705PS_1116 = 1.0f.xxx;
        EID4705PS_1117 = EID4705PS_20_m82.xyz;
        EID4705PS_1118 = EID4705PS_617;
    }
    float EID4705PS_1137 = clamp(dot(EID4705PS_560, EID4705PS_430), 0.0f, 1.0f);
    float EID4705PS_1143 = clamp((1.0f - clamp((EID4705PS_1137 * 0.85000002384185791015625f) + 0.1500000059604644775390625f, 0.0f, 1.0f)) * EID4705PS_50_m30, 0.0f, 1.0f);
    float3 EID4705PS_1151 = EID4705PS_464 * ((1.0f - EID4705PS_1143).xxx + (EID4705PS_50_m34.xyz * EID4705PS_1143));
    float3 EID4705PS_1919;
    float EID4705PS_1920;
    float EID4705PS_1921;
    float EID4705PS_1922;
    float EID4705PS_1923;
    float3 EID4705PS_1924;
    float3 EID4705PS_1925;
    [branch]
    if ((clamp(EID4705PS_596 + EID4705PS_609, 0.0f, 1.0f) - EID4705PS_50_m20) > 0.00999999977648258209228515625f)
    {
        float EID4705PS_1282;
        bool EID4705PS_1283;
        bool EID4705PS_1163 = (step(EID4705PS_596, 0.00999999977648258209228515625f) * step(0.00999999977648258209228515625f, EID4705PS_609)) != 0.0f;
        bool3 EID4705PS_1164 = EID4705PS_439.xxx;
        float3 EID4705PS_1166 = EID4705PS_11.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 EID4705PS_1170 = float3(EID4705PS_1164.x ? EID4705PS_1166.x : EID4705PS_11.x, EID4705PS_1164.y ? EID4705PS_1166.y : EID4705PS_11.y, EID4705PS_1164.z ? EID4705PS_1166.z : EID4705PS_11.z) * EID4705PS_20_m89.z;
        float3 EID4705PS_1180 = float3(0.0f, -1.0f, 0.0f) + (EID4705PS_548 * EID4705PS_548.y);
        float3 EID4705PS_1188 = ((EID4705PS_10.xyz * dot(EID4705PS_1180, EID4705PS_546)) + ((cross(EID4705PS_9, EID4705PS_10.xyz) * EID4705PS_10.w) * dot(EID4705PS_1180, EID4705PS_547))) + (EID4705PS_9 * dot(EID4705PS_1180, EID4705PS_548));
        float3 EID4705PS_1190 = EID4705PS_1188.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 EID4705PS_1191 = float3(EID4705PS_1164.x ? EID4705PS_1190.x : EID4705PS_1188.x, EID4705PS_1164.y ? EID4705PS_1190.y : EID4705PS_1188.y, EID4705PS_1164.z ? EID4705PS_1190.z : EID4705PS_1188.z);
        float3 EID4705PS_1199 = frac(floor(EID4705PS_1170.xz * 20.0f).xyx * 0.103100001811981201171875f);
        float3 EID4705PS_1204 = EID4705PS_1199 + dot(EID4705PS_1199, EID4705PS_1199.yzx + 33.3300018310546875f.xxx).xxx;
        float EID4705PS_1213 = lerp(0.300000011920928955078125f, 0.64999997615814208984375f, frac((EID4705PS_1170.y * (-3.0f)) + frac((EID4705PS_1204.x + EID4705PS_1204.y) * EID4705PS_1204.z)));
        bool EID4705PS_1214 = !EID4705PS_1163;
        bool2 EID4705PS_1215 = EID4705PS_1214.xx;
        float2 EID4705PS_1217 = (1.0f - EID4705PS_609).xx;
        float2 EID4705PS_1218 = float2(EID4705PS_1215.x ? float2(3.0f, 4.345600128173828125f).x : EID4705PS_1217.x, EID4705PS_1215.y ? float2(3.0f, 4.345600128173828125f).y : EID4705PS_1217.y);
        float EID4705PS_1221 = 1.0f - (0.800000011920928955078125f * (EID4705PS_1163 ? EID4705PS_609 : EID4705PS_596));
        float EID4705PS_1224 = EID4705PS_1214 ? EID4705PS_20_m10.x : 1.0f;
        float EID4705PS_1226 = EID4705PS_1224 * EID4705PS_1218.x;
        float EID4705PS_1228 = EID4705PS_1224 * EID4705PS_1218.y;
        float3 EID4705PS_1229 = EID4705PS_1170 * 24.0f;
        float3 EID4705PS_1230 = EID4705PS_1170 * 36.270000457763671875f;
        float3 EID4705PS_1232 = abs(float3(EID4705PS_1164.x ? EID4705PS_9.xzy.x : EID4705PS_9.x, EID4705PS_1164.y ? EID4705PS_9.xzy.y : EID4705PS_9.y, EID4705PS_1164.z ? EID4705PS_9.xzy.z : EID4705PS_9.z)) - 0.20000000298023223876953125f.xxx;
        float3 EID4705PS_1234 = pow(max(EID4705PS_1232, 0.0f.xxx), 10.0f.xxx);
        float EID4705PS_1235 = dot(EID4705PS_1234, 1.0f.xxx);
        float3 EID4705PS_1238 = EID4705PS_1234 / (max(EID4705PS_1235, 6.103515625e-05f)).xxx;
        float2 EID4705PS_1240 = EID4705PS_1191.xz;
        float EID4705PS_1241 = EID4705PS_1238.y;
        float2 EID4705PS_1242 = EID4705PS_1229.xz * 1.0f;
        float2 EID4705PS_1243 = floor(EID4705PS_1242);
        float2 EID4705PS_1246 = frac(EID4705PS_1243 * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4705PS_1250 = EID4705PS_1246 + dot(EID4705PS_1246, EID4705PS_1246 + 34.345001220703125f.xx).xx;
        float EID4705PS_1251 = EID4705PS_1250.x;
        float EID4705PS_1252 = EID4705PS_1250.y;
        float2 EID4705PS_1256 = frac(float2(EID4705PS_1251 * EID4705PS_1252, EID4705PS_1251 + EID4705PS_1252));
        float2 EID4705PS_1259 = frac((EID4705PS_1243 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4705PS_1263 = EID4705PS_1259 + dot(EID4705PS_1259, EID4705PS_1259 + 34.345001220703125f.xx).xx;
        float EID4705PS_1264 = EID4705PS_1263.x;
        float EID4705PS_1265 = EID4705PS_1263.y;
        float2 EID4705PS_1269 = frac(float2(EID4705PS_1264 * EID4705PS_1265, EID4705PS_1264 + EID4705PS_1265));
        float EID4705PS_1275 = EID4705PS_1256.x;
        float EID4705PS_1278 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, EID4705PS_1275)) * EID4705PS_1213;
        float2 EID4705PS_1279 = ((EID4705PS_1242 - EID4705PS_1243) + ((((EID4705PS_1269 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 EID4705PS_1296;
        EID4705PS_1282 = dot(EID4705PS_1240, EID4705PS_1240);
        EID4705PS_1283 = EID4705PS_1282 <= 9.9999997473787516355514526367188e-06f;
        if (EID4705PS_1283)
        {
            EID4705PS_1296 = EID4705PS_1279;
        }
        else
        {
            float2 EID4705PS_1287 = EID4705PS_1240 * rsqrt(EID4705PS_1282);
            EID4705PS_1296 = float2(dot(EID4705PS_1279, float2(-EID4705PS_1287.y, EID4705PS_1287.x)), -dot(EID4705PS_1279, EID4705PS_1287));
        }
        float EID4705PS_1379;
        bool EID4705PS_1380;
        float2 EID4705PS_1303 = float2(EID4705PS_1296.x * 1.25f, EID4705PS_1296.y * ((EID4705PS_1296.y < 0.0f) ? 1.25f : 0.75f));
        float EID4705PS_1304 = length(EID4705PS_1303);
        float EID4705PS_1306 = EID4705PS_1226 + EID4705PS_1275;
        float EID4705PS_1310 = EID4705PS_1214 ? frac(EID4705PS_1306) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(EID4705PS_1306, 0.0f, 1.0f));
        float EID4705PS_1322 = EID4705PS_1256.y;
        float EID4705PS_1325 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, EID4705PS_1310) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, EID4705PS_1310)) * step(0.001000000047497451305389404296875f, smoothstep(EID4705PS_1278, 0.0f, EID4705PS_1304))) * step(EID4705PS_1221, EID4705PS_1322 - 0.100000001490116119384765625f);
        float EID4705PS_1328 = EID4705PS_1325 * EID4705PS_1241;
        float2 EID4705PS_1335 = float2(EID4705PS_1278 * EID4705PS_1325, EID4705PS_1278 - EID4705PS_1304) * EID4705PS_1241;
        float2 EID4705PS_1337 = EID4705PS_1191.xy;
        float EID4705PS_1338 = EID4705PS_1238.z;
        float2 EID4705PS_1339 = EID4705PS_1229.xy * 1.0f;
        float2 EID4705PS_1340 = floor(EID4705PS_1339);
        float2 EID4705PS_1343 = frac(EID4705PS_1340 * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4705PS_1347 = EID4705PS_1343 + dot(EID4705PS_1343, EID4705PS_1343 + 34.345001220703125f.xx).xx;
        float EID4705PS_1348 = EID4705PS_1347.x;
        float EID4705PS_1349 = EID4705PS_1347.y;
        float2 EID4705PS_1353 = frac(float2(EID4705PS_1348 * EID4705PS_1349, EID4705PS_1348 + EID4705PS_1349));
        float2 EID4705PS_1356 = frac((EID4705PS_1340 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4705PS_1360 = EID4705PS_1356 + dot(EID4705PS_1356, EID4705PS_1356 + 34.345001220703125f.xx).xx;
        float EID4705PS_1361 = EID4705PS_1360.x;
        float EID4705PS_1362 = EID4705PS_1360.y;
        float2 EID4705PS_1366 = frac(float2(EID4705PS_1361 * EID4705PS_1362, EID4705PS_1361 + EID4705PS_1362));
        float EID4705PS_1372 = EID4705PS_1353.x;
        float EID4705PS_1375 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, EID4705PS_1372)) * EID4705PS_1213;
        float2 EID4705PS_1376 = ((EID4705PS_1339 - EID4705PS_1340) + ((((EID4705PS_1366 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 EID4705PS_1393;
        EID4705PS_1379 = dot(EID4705PS_1337, EID4705PS_1337);
        EID4705PS_1380 = EID4705PS_1379 <= 9.9999997473787516355514526367188e-06f;
        if (EID4705PS_1380)
        {
            EID4705PS_1393 = EID4705PS_1376;
        }
        else
        {
            float2 EID4705PS_1384 = EID4705PS_1337 * rsqrt(EID4705PS_1379);
            EID4705PS_1393 = float2(dot(EID4705PS_1376, float2(-EID4705PS_1384.y, EID4705PS_1384.x)), -dot(EID4705PS_1376, EID4705PS_1384));
        }
        float EID4705PS_1476;
        bool EID4705PS_1477;
        float2 EID4705PS_1400 = float2(EID4705PS_1393.x * 1.25f, EID4705PS_1393.y * ((EID4705PS_1393.y < 0.0f) ? 1.25f : 0.75f));
        float EID4705PS_1401 = length(EID4705PS_1400);
        float EID4705PS_1403 = EID4705PS_1226 + EID4705PS_1372;
        float EID4705PS_1407 = EID4705PS_1214 ? frac(EID4705PS_1403) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(EID4705PS_1403, 0.0f, 1.0f));
        float EID4705PS_1419 = EID4705PS_1353.y;
        float EID4705PS_1422 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, EID4705PS_1407) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, EID4705PS_1407)) * step(0.001000000047497451305389404296875f, smoothstep(EID4705PS_1375, 0.0f, EID4705PS_1401))) * step(EID4705PS_1221, EID4705PS_1419 - 0.100000001490116119384765625f);
        float EID4705PS_1425 = EID4705PS_1422 * EID4705PS_1338;
        float2 EID4705PS_1432 = float2(EID4705PS_1375 * EID4705PS_1422, EID4705PS_1375 - EID4705PS_1401) * EID4705PS_1338;
        float2 EID4705PS_1434 = EID4705PS_1191.zy;
        float EID4705PS_1435 = EID4705PS_1238.x;
        float2 EID4705PS_1436 = EID4705PS_1229.zy * 1.0f;
        float2 EID4705PS_1437 = floor(EID4705PS_1436);
        float2 EID4705PS_1440 = frac(EID4705PS_1437 * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4705PS_1444 = EID4705PS_1440 + dot(EID4705PS_1440, EID4705PS_1440 + 34.345001220703125f.xx).xx;
        float EID4705PS_1445 = EID4705PS_1444.x;
        float EID4705PS_1446 = EID4705PS_1444.y;
        float2 EID4705PS_1450 = frac(float2(EID4705PS_1445 * EID4705PS_1446, EID4705PS_1445 + EID4705PS_1446));
        float2 EID4705PS_1453 = frac((EID4705PS_1437 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4705PS_1457 = EID4705PS_1453 + dot(EID4705PS_1453, EID4705PS_1453 + 34.345001220703125f.xx).xx;
        float EID4705PS_1458 = EID4705PS_1457.x;
        float EID4705PS_1459 = EID4705PS_1457.y;
        float2 EID4705PS_1463 = frac(float2(EID4705PS_1458 * EID4705PS_1459, EID4705PS_1458 + EID4705PS_1459));
        float EID4705PS_1469 = EID4705PS_1450.x;
        float EID4705PS_1472 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, EID4705PS_1469)) * EID4705PS_1213;
        float2 EID4705PS_1473 = ((EID4705PS_1436 - EID4705PS_1437) + ((((EID4705PS_1463 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 EID4705PS_1490;
        EID4705PS_1476 = dot(EID4705PS_1434, EID4705PS_1434);
        EID4705PS_1477 = EID4705PS_1476 <= 9.9999997473787516355514526367188e-06f;
        if (EID4705PS_1477)
        {
            EID4705PS_1490 = EID4705PS_1473;
        }
        else
        {
            float2 EID4705PS_1481 = EID4705PS_1434 * rsqrt(EID4705PS_1476);
            EID4705PS_1490 = float2(dot(EID4705PS_1473, float2(-EID4705PS_1481.y, EID4705PS_1481.x)), -dot(EID4705PS_1473, EID4705PS_1481));
        }
        float2 EID4705PS_1497 = float2(EID4705PS_1490.x * 1.25f, EID4705PS_1490.y * ((EID4705PS_1490.y < 0.0f) ? 1.25f : 0.75f));
        float EID4705PS_1498 = length(EID4705PS_1497);
        float EID4705PS_1500 = EID4705PS_1226 + EID4705PS_1469;
        float EID4705PS_1504 = EID4705PS_1214 ? frac(EID4705PS_1500) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(EID4705PS_1500, 0.0f, 1.0f));
        float EID4705PS_1516 = EID4705PS_1450.y;
        float EID4705PS_1519 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, EID4705PS_1504) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, EID4705PS_1504)) * step(0.001000000047497451305389404296875f, smoothstep(EID4705PS_1472, 0.0f, EID4705PS_1498))) * step(EID4705PS_1221, EID4705PS_1516 - 0.100000001490116119384765625f);
        float EID4705PS_1522 = EID4705PS_1519 * EID4705PS_1435;
        float2 EID4705PS_1529 = float2(EID4705PS_1472 * EID4705PS_1519, EID4705PS_1472 - EID4705PS_1498) * EID4705PS_1435;
        float2 EID4705PS_1530 = max(EID4705PS_1432, EID4705PS_1529);
        float2 EID4705PS_1531 = max(EID4705PS_1335, EID4705PS_1530);
        float EID4705PS_1537 = max(EID4705PS_1328, EID4705PS_1425);
        float EID4705PS_1538 = max(EID4705PS_1522, EID4705PS_1537);
        float4 EID4705PS_1541 = float4((float4(((clamp(EID4705PS_1303 / EID4705PS_1278.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, EID4705PS_1269.x)) * EID4705PS_1325) * EID4705PS_1241, EID4705PS_1328, EID4705PS_1322).xy + float4(((clamp(EID4705PS_1400 / EID4705PS_1375.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, EID4705PS_1366.x)) * EID4705PS_1422) * EID4705PS_1338, EID4705PS_1425, EID4705PS_1419).xy) + float4(((clamp(EID4705PS_1497 / EID4705PS_1472.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, EID4705PS_1463.x)) * EID4705PS_1519) * EID4705PS_1435, EID4705PS_1522, EID4705PS_1516).xy, EID4705PS_1538, 0.0f);
        float2 EID4705PS_1543 = EID4705PS_1230.xz * 1.0f;
        float2 EID4705PS_1544 = floor(EID4705PS_1543);
        float2 EID4705PS_1547 = frac(EID4705PS_1544 * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4705PS_1551 = EID4705PS_1547 + dot(EID4705PS_1547, EID4705PS_1547 + 34.345001220703125f.xx).xx;
        float EID4705PS_1552 = EID4705PS_1551.x;
        float EID4705PS_1553 = EID4705PS_1551.y;
        float2 EID4705PS_1557 = frac(float2(EID4705PS_1552 * EID4705PS_1553, EID4705PS_1552 + EID4705PS_1553));
        float2 EID4705PS_1560 = frac((EID4705PS_1544 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4705PS_1564 = EID4705PS_1560 + dot(EID4705PS_1560, EID4705PS_1560 + 34.345001220703125f.xx).xx;
        float EID4705PS_1565 = EID4705PS_1564.x;
        float EID4705PS_1566 = EID4705PS_1564.y;
        float2 EID4705PS_1570 = frac(float2(EID4705PS_1565 * EID4705PS_1566, EID4705PS_1565 + EID4705PS_1566));
        float EID4705PS_1576 = EID4705PS_1557.x;
        float EID4705PS_1579 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, EID4705PS_1576)) * EID4705PS_1213;
        float2 EID4705PS_1580 = ((EID4705PS_1543 - EID4705PS_1544) + ((((EID4705PS_1570 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 EID4705PS_1595;
        if (EID4705PS_1283)
        {
            EID4705PS_1595 = EID4705PS_1580;
        }
        else
        {
            float2 EID4705PS_1586 = EID4705PS_1240 * rsqrt(EID4705PS_1282);
            EID4705PS_1595 = float2(dot(EID4705PS_1580, float2(-EID4705PS_1586.y, EID4705PS_1586.x)), -dot(EID4705PS_1580, EID4705PS_1586));
        }
        float2 EID4705PS_1602 = float2(EID4705PS_1595.x * 1.25f, EID4705PS_1595.y * ((EID4705PS_1595.y < 0.0f) ? 1.25f : 0.75f));
        float EID4705PS_1603 = length(EID4705PS_1602);
        float EID4705PS_1605 = EID4705PS_1228 + EID4705PS_1576;
        float EID4705PS_1609 = EID4705PS_1214 ? frac(EID4705PS_1605) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(EID4705PS_1605, 0.0f, 1.0f));
        float EID4705PS_1621 = EID4705PS_1557.y;
        float EID4705PS_1624 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, EID4705PS_1609) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, EID4705PS_1609)) * step(0.001000000047497451305389404296875f, smoothstep(EID4705PS_1579, 0.0f, EID4705PS_1603))) * step(EID4705PS_1221, EID4705PS_1621 - 0.100000001490116119384765625f);
        float EID4705PS_1627 = EID4705PS_1624 * EID4705PS_1241;
        float2 EID4705PS_1634 = float2(EID4705PS_1579 * EID4705PS_1624, EID4705PS_1579 - EID4705PS_1603) * EID4705PS_1241;
        float2 EID4705PS_1636 = EID4705PS_1230.xy * 1.0f;
        float2 EID4705PS_1637 = floor(EID4705PS_1636);
        float2 EID4705PS_1640 = frac(EID4705PS_1637 * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4705PS_1644 = EID4705PS_1640 + dot(EID4705PS_1640, EID4705PS_1640 + 34.345001220703125f.xx).xx;
        float EID4705PS_1645 = EID4705PS_1644.x;
        float EID4705PS_1646 = EID4705PS_1644.y;
        float2 EID4705PS_1650 = frac(float2(EID4705PS_1645 * EID4705PS_1646, EID4705PS_1645 + EID4705PS_1646));
        float2 EID4705PS_1653 = frac((EID4705PS_1637 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4705PS_1657 = EID4705PS_1653 + dot(EID4705PS_1653, EID4705PS_1653 + 34.345001220703125f.xx).xx;
        float EID4705PS_1658 = EID4705PS_1657.x;
        float EID4705PS_1659 = EID4705PS_1657.y;
        float2 EID4705PS_1663 = frac(float2(EID4705PS_1658 * EID4705PS_1659, EID4705PS_1658 + EID4705PS_1659));
        float EID4705PS_1669 = EID4705PS_1650.x;
        float EID4705PS_1672 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, EID4705PS_1669)) * EID4705PS_1213;
        float2 EID4705PS_1673 = ((EID4705PS_1636 - EID4705PS_1637) + ((((EID4705PS_1663 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 EID4705PS_1688;
        if (EID4705PS_1380)
        {
            EID4705PS_1688 = EID4705PS_1673;
        }
        else
        {
            float2 EID4705PS_1679 = EID4705PS_1337 * rsqrt(EID4705PS_1379);
            EID4705PS_1688 = float2(dot(EID4705PS_1673, float2(-EID4705PS_1679.y, EID4705PS_1679.x)), -dot(EID4705PS_1673, EID4705PS_1679));
        }
        float2 EID4705PS_1695 = float2(EID4705PS_1688.x * 1.25f, EID4705PS_1688.y * ((EID4705PS_1688.y < 0.0f) ? 1.25f : 0.75f));
        float EID4705PS_1696 = length(EID4705PS_1695);
        float EID4705PS_1698 = EID4705PS_1228 + EID4705PS_1669;
        float EID4705PS_1702 = EID4705PS_1214 ? frac(EID4705PS_1698) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(EID4705PS_1698, 0.0f, 1.0f));
        float EID4705PS_1714 = EID4705PS_1650.y;
        float EID4705PS_1717 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, EID4705PS_1702) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, EID4705PS_1702)) * step(0.001000000047497451305389404296875f, smoothstep(EID4705PS_1672, 0.0f, EID4705PS_1696))) * step(EID4705PS_1221, EID4705PS_1714 - 0.100000001490116119384765625f);
        float EID4705PS_1720 = EID4705PS_1717 * EID4705PS_1338;
        float2 EID4705PS_1727 = float2(EID4705PS_1672 * EID4705PS_1717, EID4705PS_1672 - EID4705PS_1696) * EID4705PS_1338;
        float2 EID4705PS_1729 = EID4705PS_1230.zy * 1.0f;
        float2 EID4705PS_1730 = floor(EID4705PS_1729);
        float2 EID4705PS_1733 = frac(EID4705PS_1730 * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4705PS_1737 = EID4705PS_1733 + dot(EID4705PS_1733, EID4705PS_1733 + 34.345001220703125f.xx).xx;
        float EID4705PS_1738 = EID4705PS_1737.x;
        float EID4705PS_1739 = EID4705PS_1737.y;
        float2 EID4705PS_1743 = frac(float2(EID4705PS_1738 * EID4705PS_1739, EID4705PS_1738 + EID4705PS_1739));
        float2 EID4705PS_1746 = frac((EID4705PS_1730 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4705PS_1750 = EID4705PS_1746 + dot(EID4705PS_1746, EID4705PS_1746 + 34.345001220703125f.xx).xx;
        float EID4705PS_1751 = EID4705PS_1750.x;
        float EID4705PS_1752 = EID4705PS_1750.y;
        float2 EID4705PS_1756 = frac(float2(EID4705PS_1751 * EID4705PS_1752, EID4705PS_1751 + EID4705PS_1752));
        float EID4705PS_1762 = EID4705PS_1743.x;
        float EID4705PS_1765 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, EID4705PS_1762)) * EID4705PS_1213;
        float2 EID4705PS_1766 = ((EID4705PS_1729 - EID4705PS_1730) + ((((EID4705PS_1756 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 EID4705PS_1781;
        if (EID4705PS_1477)
        {
            EID4705PS_1781 = EID4705PS_1766;
        }
        else
        {
            float2 EID4705PS_1772 = EID4705PS_1434 * rsqrt(EID4705PS_1476);
            EID4705PS_1781 = float2(dot(EID4705PS_1766, float2(-EID4705PS_1772.y, EID4705PS_1772.x)), -dot(EID4705PS_1766, EID4705PS_1772));
        }
        float2 EID4705PS_1788 = float2(EID4705PS_1781.x * 1.25f, EID4705PS_1781.y * ((EID4705PS_1781.y < 0.0f) ? 1.25f : 0.75f));
        float EID4705PS_1789 = length(EID4705PS_1788);
        float EID4705PS_1791 = EID4705PS_1228 + EID4705PS_1762;
        float EID4705PS_1795 = EID4705PS_1214 ? frac(EID4705PS_1791) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(EID4705PS_1791, 0.0f, 1.0f));
        float EID4705PS_1807 = EID4705PS_1743.y;
        float EID4705PS_1810 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, EID4705PS_1795) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, EID4705PS_1795)) * step(0.001000000047497451305389404296875f, smoothstep(EID4705PS_1765, 0.0f, EID4705PS_1789))) * step(EID4705PS_1221, EID4705PS_1807 - 0.100000001490116119384765625f);
        float EID4705PS_1813 = EID4705PS_1810 * EID4705PS_1435;
        float2 EID4705PS_1820 = float2(EID4705PS_1765 * EID4705PS_1810, EID4705PS_1765 - EID4705PS_1789) * EID4705PS_1435;
        float2 EID4705PS_1821 = max(EID4705PS_1727, EID4705PS_1820);
        float EID4705PS_1828 = max(EID4705PS_1627, EID4705PS_1720);
        float4 EID4705PS_1832 = float4((float4(((clamp(EID4705PS_1602 / EID4705PS_1579.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, EID4705PS_1570.x)) * EID4705PS_1624) * EID4705PS_1241, EID4705PS_1627, EID4705PS_1621).xy + float4(((clamp(EID4705PS_1695 / EID4705PS_1672.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, EID4705PS_1663.x)) * EID4705PS_1717) * EID4705PS_1338, EID4705PS_1720, EID4705PS_1714).xy) + float4(((clamp(EID4705PS_1788 / EID4705PS_1765.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, EID4705PS_1756.x)) * EID4705PS_1810) * EID4705PS_1435, EID4705PS_1813, EID4705PS_1807).xy, max(EID4705PS_1813, EID4705PS_1828), 0.0f);
        float EID4705PS_1834 = step(EID4705PS_1531.x, 0.00999999977648258209228515625f);
        float2 EID4705PS_1841 = EID4705PS_1541.zw * step(0.00999999977648258209228515625f, EID4705PS_1538);
        float2 EID4705PS_1843 = EID4705PS_1832.zw * EID4705PS_1834;
        float2 EID4705PS_1846 = (max(EID4705PS_1634, EID4705PS_1821) * float2(0.661703884601593017578125f, 1.0f)) * EID4705PS_1834;
        float2 EID4705PS_1847 = max(EID4705PS_1531, EID4705PS_1846);
        float EID4705PS_1853 = max(EID4705PS_1841, EID4705PS_1843).x * clamp(dot(EID4705PS_430, EID4705PS_560), 0.0f, 1.0f);
        float2 EID4705PS_1854 = (EID4705PS_1541.xy + (EID4705PS_1832.xy * EID4705PS_1834)).xy;
        float EID4705PS_1858 = sqrt(1.0f - clamp(dot(EID4705PS_1854, EID4705PS_1854), 0.0f, 1.0f));
        float3 EID4705PS_1864 = normalize(float3(EID4705PS_1854 * 2.5f, max(1.000000016862383526387164645044e-16f, EID4705PS_1858)));
        float2 EID4705PS_1866 = EID4705PS_1864.xy;
        float EID4705PS_1870 = sqrt(1.0f - clamp(dot(EID4705PS_1866, EID4705PS_1866), 0.0f, 1.0f));
        float3 EID4705PS_1872 = float3(EID4705PS_1864.x, EID4705PS_1864.y, 0.0f.xxx.z);
        EID4705PS_1872.z = max(1.000000016862383526387164645044e-16f, EID4705PS_1870);
        float3 EID4705PS_1873 = normalize(EID4705PS_1872);
        float3 EID4705PS_1874 = cross(EID4705PS_560, float3(0.0f, 1.0f, 0.0f));
        bool3 EID4705PS_1877 = (dot(EID4705PS_1874, EID4705PS_1874) > 6.103515625e-05f).xxx;
        float3 EID4705PS_1878 = normalize(EID4705PS_1874);
        float3 EID4705PS_1879 = float3(EID4705PS_1877.x ? EID4705PS_1878.x : float3(1.0f, 0.0f, 0.0f).x, EID4705PS_1877.y ? EID4705PS_1878.y : float3(1.0f, 0.0f, 0.0f).y, EID4705PS_1877.z ? EID4705PS_1878.z : float3(1.0f, 0.0f, 0.0f).z);
        float EID4705PS_1883 = EID4705PS_1873.y;
        float EID4705PS_1890 = EID4705PS_1847.x * 4.0f;
        float EID4705PS_1900 = clamp(dot(EID4705PS_1873, normalize(float3(0.0f, -1.0f, 0.75f))), 0.0f, 1.0f);
        float EID4705PS_1906 = (0.60000002384185791015625f * EID4705PS_1853) * EID4705PS_1890;
        float EID4705PS_1909 = (1.0f - EID4705PS_1906) + (clamp(clamp(clamp(EID4705PS_1847.y * 17.54000091552734375f, 0.0f, 1.0f), 0.0f, 1.0f) + clamp(1.60000002384185791015625f * EID4705PS_1883, 0.0f, 1.0f), 0.0f, 1.0f) * EID4705PS_1906);
        float EID4705PS_1912 = smoothstep(0.60000002384185791015625f, 1.0f, EID4705PS_1909);
        float EID4705PS_1915 = EID4705PS_1853 * EID4705PS_1890;
        EID4705PS_1919 = normalize(((EID4705PS_1879 * EID4705PS_1873.x) + (cross(EID4705PS_1879, EID4705PS_560) * EID4705PS_1883)) + (EID4705PS_560 * EID4705PS_1873.z));
        EID4705PS_1920 = EID4705PS_1915;
        EID4705PS_1921 = ((lerp(0.0500000007450580596923828125f, 1.7999999523162841796875f, (EID4705PS_1900 * EID4705PS_1900) * EID4705PS_1900) * EID4705PS_1890) * EID4705PS_1912) * EID4705PS_1853;
        EID4705PS_1922 = lerp(1.0f, 0.800000011920928955078125f * lerp(0.5f, 1.0f, EID4705PS_1912), EID4705PS_1853);
        EID4705PS_1923 = EID4705PS_1915;
        EID4705PS_1924 = EID4705PS_505 * EID4705PS_1909;
        EID4705PS_1925 = EID4705PS_1151 * EID4705PS_1909;
    }
    else
    {
        EID4705PS_1919 = EID4705PS_560;
        EID4705PS_1920 = 0.0f;
        EID4705PS_1921 = 0.0f;
        EID4705PS_1922 = 1.0f;
        EID4705PS_1923 = 0.0f;
        EID4705PS_1924 = EID4705PS_505;
        EID4705PS_1925 = EID4705PS_1151;
    }
    float3 EID4705PS_2084;
    float EID4705PS_2085;
    float EID4705PS_2086;
    float3 EID4705PS_2087;
    float3 EID4705PS_2088;
    float EID4705PS_2089;
    [branch]
    if (EID4705PS_599 > 0.00999999977648258209228515625f)
    {
        bool3 EID4705PS_1929 = EID4705PS_439.xxx;
        float3 EID4705PS_1931 = EID4705PS_11.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 EID4705PS_1932 = float3(EID4705PS_1929.x ? EID4705PS_1931.x : EID4705PS_11.x, EID4705PS_1929.y ? EID4705PS_1931.y : EID4705PS_11.y, EID4705PS_1929.z ? EID4705PS_1931.z : EID4705PS_11.z);
        float3 EID4705PS_1935 = EID4705PS_1932 * EID4705PS_20_m89.z;
        float3 EID4705PS_1937 = float3(EID4705PS_1929.x ? EID4705PS_9.xzy.x : EID4705PS_9.x, EID4705PS_1929.y ? EID4705PS_9.xzy.y : EID4705PS_9.y, EID4705PS_1929.z ? EID4705PS_9.xzy.z : EID4705PS_9.z);
        float3 EID4705PS_1939 = abs(EID4705PS_1937) - 0.20000000298023223876953125f.xxx;
        float3 EID4705PS_1941 = (EID4705PS_1939 * EID4705PS_1939) * EID4705PS_1939;
        float3 EID4705PS_1942 = max(EID4705PS_1941, 6.103515625e-05f.xxx);
        float3 EID4705PS_1945 = EID4705PS_1942 / dot(EID4705PS_1942, 1.0f.xxx).xxx;
        float EID4705PS_1961 = EID4705PS_1945.y;
        float EID4705PS_1963 = EID4705PS_1945.z;
        float EID4705PS_1966 = EID4705PS_1945.x;
        float4 EID4705PS_1968 = ((EID4705PS_53.SampleBias(EID4705_linear_repeat_sampler, EID4705PS_1935.xz, EID4705PS_20_m16) * EID4705PS_1961) + (EID4705PS_53.SampleBias(EID4705_linear_repeat_sampler, EID4705PS_1935.xy, EID4705PS_20_m16) * EID4705PS_1963)) + (EID4705PS_53.SampleBias(EID4705_linear_repeat_sampler, EID4705PS_1935.zy, EID4705PS_20_m16) * EID4705PS_1966);
        float EID4705PS_1976 = clamp(EID4705PS_599 + (smoothstep(0.3499999940395355224609375f, 0.20000000298023223876953125f, EID4705PS_1932.y) * clamp(EID4705PS_599 * 3.0f, 0.0f, 1.0f)), 0.0f, 1.0f);
        float EID4705PS_1987 = smoothstep(2.0f - EID4705PS_1976, 2.349999904632568359375f - EID4705PS_1976, (smoothstep(-1.0f, 0.0f, EID4705PS_1937.y) + EID4705PS_1968.z) * 0.60000002384185791015625f) * ((EID4705PS_472 * EID4705PS_472) * float(EID4705PS_gl_FrontFacing));
        float3 EID4705PS_1989 = EID4705PS_1987.xxx;
        float2 EID4705PS_1995 = (EID4705PS_1968.xy * 2.0f) - 1.0f.xx;
        float2 EID4705PS_1997 = EID4705PS_1995.xy;
        float EID4705PS_2001 = sqrt(1.0f - clamp(dot(EID4705PS_1997, EID4705PS_1997), 0.0f, 1.0f));
        float3 EID4705PS_2003 = float3(EID4705PS_1995.x, EID4705PS_1995.y, EID4705PS_389.z);
        EID4705PS_2003.z = max(1.000000016862383526387164645044e-16f, EID4705PS_2001);
        float2 EID4705PS_2005 = EID4705PS_2003.xy * 2.0f;
        float3 EID4705PS_2007 = lerp(float3(0.0f, 0.0f, 1.0f), float3(EID4705PS_2005.x, EID4705PS_2005.y, EID4705PS_2003.z), EID4705PS_1989);
        float EID4705PS_2008 = dot(EID4705PS_2007, EID4705PS_2007);
        float3 EID4705PS_2011 = EID4705PS_2007 * rsqrt(max(6.103515625e-05f, EID4705PS_2008));
        float EID4705PS_2012 = EID4705PS_560.y;
        float EID4705PS_2015 = step(0.00999999977648258209228515625f, 1.0f - (EID4705PS_2012 * EID4705PS_2012));
        float EID4705PS_2018 = lerp(EID4705PS_619, EID4705PS_2012, EID4705PS_2015);
        float EID4705PS_2020 = 1.0f - (EID4705PS_2018 * EID4705PS_2018);
        float3 EID4705PS_2025 = (float3(0.0f, EID4705PS_2015, 1.0f - EID4705PS_2015) - (EID4705PS_560 * EID4705PS_2018)) * rsqrt(max(9.9999997473787516355514526367188e-05f, EID4705PS_2020));
        float3 EID4705PS_2039 = EID4705PS_1935 * 4.0f;
        float4 EID4705PS_2059 = ((EID4705PS_54.SampleLevel(EID4705_point_repeat_sampler, EID4705PS_2039.xz, 0.0f) * EID4705PS_1961) + (EID4705PS_54.SampleLevel(EID4705_point_repeat_sampler, EID4705PS_2039.xy, 0.0f) * EID4705PS_1963)) + (EID4705PS_54.SampleLevel(EID4705_point_repeat_sampler, EID4705PS_2039.zy, 0.0f) * EID4705PS_1966);
        float2 EID4705PS_2062 = (EID4705PS_2059.xz * 2.0f) - 1.0f.xx;
        float EID4705PS_2073 = smoothstep(0.949999988079071044921875f, 1.0f, frac(((dot(float3(EID4705PS_2062.x, EID4705PS_2059.y, EID4705PS_2062.y), (floor(EID4705PS_430 * 50.0f) * 0.0199999995529651641845703125f) * 0.100000001490116119384765625f) * 0.5f) + 0.5f) * 2.0f));
        float EID4705PS_2074 = EID4705PS_2073 * EID4705PS_2073;
        float EID4705PS_2077 = EID4705PS_2074 * ((EID4705PS_2074 * 2.0f) * EID4705PS_1987);
        float3 EID4705PS_2078 = 1.0f.xxx * EID4705PS_2077;
        EID4705PS_2084 = ((cross(EID4705PS_2025, EID4705PS_560) * EID4705PS_2011.x) + (EID4705PS_2025 * EID4705PS_2011.y)) + (EID4705PS_560 * EID4705PS_2011.z);
        EID4705PS_2085 = EID4705PS_1923 + EID4705PS_2077;
        EID4705PS_2086 = lerp(lerp(EID4705PS_471, 0.89999997615814208984375f, clamp(EID4705PS_1987 * 4.0f, 0.0f, 1.0f)), 0.00999999977648258209228515625f, EID4705PS_2077);
        EID4705PS_2087 = lerp(EID4705PS_1924 * 1.0f, 0.3079999983310699462890625f.xxx, EID4705PS_1989) + (EID4705PS_2078 * 0.5f);
        EID4705PS_2088 = lerp(EID4705PS_1925 * 1.0f, 0.87999999523162841796875f.xxx, EID4705PS_1989) + EID4705PS_2078;
        EID4705PS_2089 = lerp(EID4705PS_50_m2, 0.0f, EID4705PS_1987);
    }
    else
    {
        EID4705PS_2084 = EID4705PS_560;
        EID4705PS_2085 = EID4705PS_1923;
        EID4705PS_2086 = EID4705PS_471;
        EID4705PS_2087 = EID4705PS_1924;
        EID4705PS_2088 = EID4705PS_1925;
        EID4705PS_2089 = EID4705PS_50_m2;
    }
    float EID4705PS_2091 = 0.959999978542327880859375f - (EID4705PS_2089 * 0.959999978542327880859375f);
    float3 EID4705PS_2092 = EID4705PS_2088 * EID4705PS_2091;
    float3 EID4705PS_2095 = lerp(0.039999999105930328369140625f.xxx * EID4705PS_50_m1, EID4705PS_2088, EID4705PS_2089.xxx);
    float3 EID4705PS_2096 = EID4705PS_2087 * EID4705PS_2091;
    float EID4705PS_2097 = EID4705PS_2086 * EID4705PS_2086;
    float EID4705PS_2098 = max(EID4705PS_2097, 0.0078125f);
    float2 EID4705PS_2111 = (EID4705PS_7.xy / (max(EID4705PS_7.z, 9.9999999392252902907785028219223e-09f)).xx) - (EID4705PS_8.xy / (max(EID4705PS_8.z, 9.9999999392252902907785028219223e-09f)).xx);
    float2 EID4705PS_2114 = EID4705PS_2111;
    EID4705PS_2114.y = -EID4705PS_2111.y;
    float2 EID4705PS_2124 = ((sqrt(sqrt(abs(EID4705PS_2114 * 0.5f))) * float2(int2(sign(EID4705PS_2114)))) * 0.5f) + 0.5f.xx;
    float4 EID4705PS_2128 = float4(EID4705PS_2124.x, EID4705PS_2124.y, 0.0f.xxxx.z, 0.0f.xxxx.w);
    EID4705PS_2128.z = 1.0f;
    float4 EID4705PS_2129 = EID4705PS_2128;
    EID4705PS_2129.w = (EID4705PS_2085 > 0.100000001490116119384765625f) ? 0.699999988079071044921875f : 0.4000000059604644775390625f;
    float3 EID4705PS_2140 = lerp(-EID4705PS_37_m0.xyz, EID4705PS_20_m90.xyz, EID4705PS_20_m80.w.xxx);
    float3 EID4705PS_2144 = normalize(float3(EID4705PS_2140.x, 6.103515625e-05f, EID4705PS_2140.z));
    float3 EID4705PS_2154 = lerp(EID4705PS_37_m3.xyz, EID4705PS_20_m83.xyz, EID4705PS_20_m91.y.xxx);
    float3 EID4705PS_2158 = EID4705PS_2154 * lerp(EID4705PS_37_m3.w, 1.0f, EID4705PS_20_m91.w);
    int EID4705PS_2162 = int(EID4705PS_563.x);
    int EID4705PS_2163 = int(EID4705PS_563.y);
    int2 aoPixel=int2(EID4705PS_2162,EID4705PS_2163);
    float4 EID4705PS_2167 = _EID4705UseDrawAO > 0.5
        ? _EID4705DrawAO.Load(int3(aoPixel,0)) : EID4705PS_41.Load(int3(aoPixel,0));
    if (_EID4705AOAudit > 0.5) {
        uint w,h;
        if (_EID4705UseDrawAO>0.5) _EID4705DrawAO.GetDimensions(w,h);
        else EID4705PS_41.GetDimensions(w,h);
        EID4705PS_15=float4(EID4705PS_2167.rg,float(w)/2048.0,float(h)/2048.0);
        EID4705PS_16=0;return;
    }
    float EID4705PS_2172 = EID4705PS_2167.y;
    float EID4705PS_2175 = lerp(lerp(1.0f, EID4705PS_2167.x, EID4705PS_39_m6.x), 1.0f, EID4705PS_20_m80.z);
    float3 EID4705PS_2183 = EID4705PS_2096 * EID4705PS_20_m79.z;
    float3 EID4705PS_2184 = EID4705PS_2183 * 0.64999997615814208984375f;
    float EID4705PS_2188 = dot(EID4705PS_2092, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float4 EID4705PS_2204 = EID4705PS_51.SampleLevel(EID4705_linear_clamp_sampler, float2((clamp(dot(EID4705PS_2084, EID4705PS_2140) + (EID4705PS_20_m90.w * EID4705PS_20_m91.x), -1.0f, 1.0f) * 0.5f) + 0.5f, 0.5f), 0.0f);
    float EID4705PS_2205 = EID4705PS_2204.w;
    float EID4705PS_2207 = EID4705PS_2204.x;
    float EID4705PS_2208 = EID4705PS_2204.y;
    float EID4705PS_2209 = EID4705PS_2204.z;
    float EID4705PS_2210 = max(EID4705PS_2207, EID4705PS_2208);
    float EID4705PS_2212 = min(EID4705PS_2207, EID4705PS_2208);
    float EID4705PS_2214 = (max(EID4705PS_2210, EID4705PS_2209)) - (min(EID4705PS_2212, EID4705PS_2209));
    float EID4705PS_2215 = EID4705PS_472 * EID4705PS_2172;
    float EID4705PS_2220 = min(EID4705PS_2172, EID4705PS_472);
    float EID4705PS_2221 = min(EID4705PS_2220, EID4705PS_2205);
    float3 EID4705PS_2225 = ((clamp(dot(EID4705PS_621, EID4705PS_20_m85.xyz) + EID4705PS_20_m86.x, 0.0f, 1.0f) * EID4705PS_20_m86.y) + EID4705PS_20_m86.z).xxx * lerp(EID4705PS_1117, 1.0f.xxx, (EID4705PS_20_m80.y * EID4705PS_2221).xxx);
    float3 EID4705PS_2227 = EID4705PS_2221.xxx;
    float EID4705PS_2240 = lerp(0.64999997615814208984375f, 1.0f, EID4705PS_1118);
    float3 EID4705PS_2250 = EID4705PS_2175.xxx;
    float3 EID4705PS_2251 = lerp((EID4705PS_2225 * lerp(min(EID4705PS_2240, 1.5f), clamp(EID4705PS_1118, 1.25f, 1.75f), EID4705PS_20_m80.x)) * EID4705PS_20_m79.w, (lerp(dot(EID4705PS_2158, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, EID4705PS_2158, EID4705PS_2227) + ((EID4705PS_2225 * clamp(EID4705PS_1118, 0.0f, 1.5f)) * ((1.0f - EID4705PS_20_m91.y).xxx + (EID4705PS_2154 * EID4705PS_20_m91.y)))) * EID4705PS_20_m79.y, EID4705PS_2250);
    float3 EID4705PS_2252 = lerp(lerp(lerp(dot(EID4705PS_2184, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, EID4705PS_2184, 1.2000000476837158203125f.xxx), EID4705PS_2183, clamp(EID4705PS_2215 + EID4705PS_2205, 0.0f, 1.0f).xxx), EID4705PS_2092, EID4705PS_2227);
    float3 EID4705PS_2258 = EID4705PS_2252 * ((1.0f - EID4705PS_2214).xxx + (EID4705PS_2204.xyz * EID4705PS_2214));
    float EID4705PS_2259 = dot(EID4705PS_2258, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float3 EID4705PS_2267 = lerp(lerp(EID4705PS_2183, lerp(EID4705PS_2188.xxx, EID4705PS_2092, 1.2000000476837158203125f.xxx), EID4705PS_2215.xxx), EID4705PS_2258 * clamp(dot(EID4705PS_2252, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)) * (1.0f / (max(EID4705PS_2259, 0.001000000047497451305389404296875f))), 0.0f, 1.5f), EID4705PS_2250);
    float4 EID4705PS_2271 = float4(EID4705PS_2267, EID4705PS_2175);
    float3 EID4705PS_2272 = EID4705PS_2251 * EID4705PS_2267;
    float EID4705PS_2273 = lerp(EID4705PS_2215, EID4705PS_2221, EID4705PS_2175);
    float3 EID4705PS_2279 = (EID4705PS_2251 * (((EID4705PS_2273 * 0.5f) + 0.5f) * lerp(EID4705PS_20_m79.z, 1.0f, EID4705PS_2273))) * 1.0f;
    float3 EID4705PS_2284 = float3(EID4705PS_573.x, lerp(0.5f, EID4705PS_2140.y, EID4705PS_2175), EID4705PS_573.z);
    float EID4705PS_2285 = dot(EID4705PS_2284, EID4705PS_2284);
    float3 EID4705PS_2295 = normalize(((EID4705PS_2140 * EID4705PS_2175) + ((EID4705PS_2284 * rsqrt(max(1.1754943508222875079687365372222e-38f, EID4705PS_2285))) * 2.0f)) + (EID4705PS_430 * (2.0f + EID4705PS_2175)));
    float EID4705PS_2296 = dot(EID4705PS_560, EID4705PS_2295);
    float EID4705PS_2297 = EID4705PS_2098 * EID4705PS_2098;
    float EID4705PS_2301 = (((EID4705PS_2296 * EID4705PS_2297) - EID4705PS_2296) * EID4705PS_2296) + 1.0f;
    float EID4705PS_2302 = EID4705PS_2301 * EID4705PS_2301;
    float EID4705PS_2306 = 2.0f * EID4705PS_1137;
    float EID4705PS_2308 = (1.0f + EID4705PS_1137) - EID4705PS_1137;
    float3 EID4705PS_2320 = ((EID4705PS_2095 * clamp((((EID4705PS_2297 != EID4705PS_2302) ? (EID4705PS_2297 / EID4705PS_2302) : 1.0f) * (0.5f / ((EID4705PS_2306 + (EID4705PS_2098 * EID4705PS_2308)) + 9.9999997473787516355514526367188e-05f))) - 6.103515625e-05f, 0.0f, 20.0f)) * EID4705PS_2279) * EID4705PS_20_m92.w;
    float3 EID4705PS_2328 = normalize(float3(-EID4705PS_1919.z, 0.001000000047497451305389404296875f, EID4705PS_1919.x));
    float EID4705PS_2337 = dot(EID4705PS_1919, EID4705PS_2295);
    float3 EID4705PS_2347 = (EID4705PS_2272 * 1.0f) + ((EID4705PS_2320 * EID4705PS_1922) + (((EID4705PS_2272 + EID4705PS_2320) * EID4705PS_1921) + (((((smoothstep(0.1500000059604644775390625f, 0.100000001490116119384765625f, abs(dot(EID4705PS_2295, EID4705PS_2328))) * smoothstep(0.070000000298023223876953125f, 0.0199999995529651641845703125f, abs(dot(EID4705PS_2295, cross(EID4705PS_1919, EID4705PS_2328))))) * (max(0.0f, EID4705PS_2337))) * 2.0f) * EID4705PS_1920).xxx * EID4705PS_2279)));
    float EID4705PS_2348 = dot(EID4705PS_2347, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float EID4705PS_2351 = clamp(EID4705PS_2348 - 0.5f, 0.0f, 0.5f);
    float3 EID4705PS_2387 = normalize(cross(EID4705PS_573, lerp(float3(EID4705PS_20_m88.xy, 0.0f), (float3(EID4705PS_18_m0[0].x, EID4705PS_18_m0[0].y, EID4705PS_18_m0[0].z) * EID4705PS_20_m88.x) + (float3(EID4705PS_18_m0[1].x, EID4705PS_18_m0[1].y, EID4705PS_18_m0[1].z) * EID4705PS_20_m88.y), EID4705PS_20_m94.w.xxx)));
    float EID4705PS_2393 = dot(EID4705PS_430, EID4705PS_2084);
    float EID4705PS_2395 = 1.0f - abs(EID4705PS_2393);
    float EID4705PS_2405 = clamp(dot(EID4705PS_540, EID4705PS_2387) + 1.0f, 0.0f, 1.0f);
    float EID4705PS_2406 = min(EID4705PS_2405, EID4705PS_472);
    float EID4705PS_2417 = dot(EID4705PS_2144, EID4705PS_2084);
    float EID4705PS_2431 = 1.0f - EID4705PS_2175;
    float EID4705PS_2443 = max(EID4705PS_1116.x, EID4705PS_1116.y);
    float EID4705PS_2445 = (max(EID4705PS_2443, EID4705PS_1116.z)) * 0.5f;
    float2 EID4705PS_2460 = float2(EID4705PS_563);
    float2 EID4705PS_2462 = floor(EID4705PS_2460 * 0.03125f);
    int EID4705PS_2470 = int((EID4705PS_2462.x + (EID4705PS_2462.y * EID4705PS_35_m5)) * 8.0f);
    float EID4705PS_2477 = floor(EID4705PS_411 - (EID4705PS_20_m3.y * EID4705PS_35_m11));
    float EID4705PS_2481 = clamp(EID4705PS_2477, 0.0f, EID4705PS_35_m7 - 1.0f);
    int EID4705PS_2483 = int(EID4705PS_2481 * 8.0f);
    float3 EID4705PS_2485;
    EID4705PS_2485 = lerp(EID4705PS_2348.xxx, EID4705PS_2347, ((EID4705PS_2351 * EID4705PS_2351) + 1.0f).xxx) + (((((EID4705PS_20_m87.xyz * smoothstep(lerp(0.800000011920928955078125f, 0.20000000298023223876953125f, EID4705PS_20_m88.w), lerp(0.89999997615814208984375f, 0.5f, EID4705PS_20_m88.w), EID4705PS_2395)) * EID4705PS_20_m87.w) * (min(EID4705PS_2406, EID4705PS_2172))) * (lerp(0.25f.xxx, EID4705PS_2092, EID4705PS_20_m88.z.xxx) * clamp(dot(EID4705PS_2387, EID4705PS_2084), 0.0f, 1.0f))) + ((((((lerp(EID4705PS_1116 * (1.0f / (max(EID4705PS_2445, 1.0f))), EID4705PS_2158, EID4705PS_2250) * clamp(lerp(dot(EID4705PS_1115.xyz, EID4705PS_2084) * EID4705PS_1115.w, ((-EID4705PS_2417) * ((EID4705PS_2417 * 0.5f) - 1.0f)) + 0.5f, EID4705PS_2175), 0.0f, 1.0f)) * ((EID4705PS_2431 + (clamp(-dot(EID4705PS_2144.xz, normalize(EID4705PS_573.xz)), 0.0f, 1.0f) * EID4705PS_2175)) * (1.0f - EID4705PS_20_m91.x))) * smoothstep(0.60000002384185791015625f, 0.800000011920928955078125f, EID4705PS_2395)) * (min(EID4705PS_472, EID4705PS_2172))) * (EID4705PS_2431 + (smoothstep(0.100000001490116119384765625f, 0.039999999105930328369140625f, EID4705PS_2188) * EID4705PS_2175))) * max(0.1500000059604644775390625f.xxx, EID4705PS_2092)));
    float3 EID4705PS_2486;
    [loop]
    for (int EID4705PS_2488 = 0; EID4705PS_2488 <= 7; EID4705PS_2485 = EID4705PS_2486, EID4705PS_2488++)
    {
        uint EID4705PS_2506 = (EID4705PS_2477 <= EID4705PS_2481) ? (EID4705PS_31.Load(uint(EID4705PS_2470 + EID4705PS_2488) * 4 + 0) & EID4705PS_31.Load(uint((EID4705PS_20_m21.y + EID4705PS_2483) + EID4705PS_2488) * 4 + 0)) : 0u;
        uint EID4705PS_2507 = uint(EID4705PS_2488);
        EID4705PS_2486 = EID4705PS_2485;
        uint EID4705PS_2512;
        float3 EID4705PS_2509;
        [loop]
        for (uint EID4705PS_2511 = EID4705PS_2506; EID4705PS_2511 != 0u; EID4705PS_2486 = EID4705PS_2509, EID4705PS_2511 = EID4705PS_2512)
        {
            uint EID4705PS_2516 = firstbitlow(EID4705PS_2511);
            EID4705PS_2512 = EID4705PS_2511 ^ (1u << (EID4705PS_2516 & 31u));
            int EID4705PS_2522 = int((32u * EID4705PS_2507) + EID4705PS_2516) * 8;
            int EID4705PS_2525 = EID4705PS_2522 + 1;
            int EID4705PS_2528 = EID4705PS_2522 + 2;
            int EID4705PS_2531 = EID4705PS_2522 + 3;
            int EID4705PS_2534 = EID4705PS_2522 + 4;
            int EID4705PS_2537 = EID4705PS_2522 + 5;
            int EID4705PS_2540 = EID4705PS_2522 + 6;
            int EID4705PS_2543 = EID4705PS_2522 + 7;
            uint EID4705PS_2547 = uint(EID4705PS_37_m6[EID4705PS_2537].w);
            float EID4705PS_2622;
            if ((EID4705PS_2547 & 1u) == 1u)
            {
                uint EID4705PS_2553 = asuint(EID4705PS_37_m6[EID4705PS_2537].x);
                uint EID4705PS_2560 = asuint(EID4705PS_37_m6[EID4705PS_2537].y);
                uint EID4705PS_2567 = asuint(EID4705PS_37_m6[EID4705PS_2537].z);
                uint EID4705PS_2574 = asuint(EID4705PS_37_m6[EID4705PS_2540].x);
                uint EID4705PS_2581 = asuint(EID4705PS_37_m6[EID4705PS_2540].y);
                uint EID4705PS_2588 = asuint(EID4705PS_37_m6[EID4705PS_2540].z);
                float3 EID4705PS_2607 = abs(mul(float4(EID4705PS_533 - EID4705PS_37_m6[EID4705PS_2525].xyz, 1.0f), float4x4(float4(EID4705PS_spvUnpackHalf2x16(EID4705PS_2553).x, EID4705PS_spvUnpackHalf2x16(EID4705PS_2567).x, EID4705PS_spvUnpackHalf2x16(EID4705PS_2581).x, 0.0f), float4(EID4705PS_spvUnpackHalf2x16(EID4705PS_2553 >> 16u).x, EID4705PS_spvUnpackHalf2x16(EID4705PS_2567 >> 16u).x, EID4705PS_spvUnpackHalf2x16(EID4705PS_2581 >> 16u).x, 0.0f), float4(EID4705PS_spvUnpackHalf2x16(EID4705PS_2560).x, EID4705PS_spvUnpackHalf2x16(EID4705PS_2574).x, EID4705PS_spvUnpackHalf2x16(EID4705PS_2588).x, 0.0f), float4(EID4705PS_spvUnpackHalf2x16(EID4705PS_2560 >> 16u).x, EID4705PS_spvUnpackHalf2x16(EID4705PS_2574 >> 16u).x, EID4705PS_spvUnpackHalf2x16(EID4705PS_2588 >> 16u).x, 0.0f))).xyz);
                float EID4705PS_2608 = EID4705PS_2607.x;
                float EID4705PS_2609 = EID4705PS_2607.y;
                float EID4705PS_2610 = max(EID4705PS_2608, EID4705PS_2609);
                float EID4705PS_2611 = EID4705PS_2607.z;
                float EID4705PS_2614 = EID4705PS_37_m6[EID4705PS_2543].x * 0.5f;
                float EID4705PS_2620 = 1.0f - clamp(((max(EID4705PS_2610, EID4705PS_2611)) - (EID4705PS_2614 + 0.5f)) / (0.5f - EID4705PS_2614), 0.0f, 1.0f);
                EID4705PS_2622 = EID4705PS_2620 * EID4705PS_2620;
            }
            else
            {
                EID4705PS_2622 = 1.0f;
            }
            if (false || (EID4705PS_2622 < 0.001000000047497451305389404296875f))
            {
                EID4705PS_2509 = EID4705PS_2486;
                continue;
            }
            float3 EID4705PS_3315;
            if (EID4705PS_37_m6[EID4705PS_2522].w < 1.5f)
            {
                float3 EID4705PS_3314;
                EID4705PS_EarlyExit1(EID4705PS_2531, EID4705PS_3314, EID4705PS_2486, EID4705PS_2522, EID4705PS_2528, EID4705PS_2534, EID4705PS_2540, EID4705PS_2525, EID4705PS_533, EID4705PS_2543, EID4705PS_605, EID4705PS_2622, EID4705PS_561, EID4705PS_2084, EID4705PS_2547, EID4705PS_540, EID4705PS_2431, EID4705PS_2271, EID4705PS_2395, EID4705PS_573, EID4705PS_2092, EID4705PS_2096, EID4705PS_2086, EID4705PS_2089, EID4705PS_2098, EID4705PS_560, EID4705PS_430, EID4705PS_2095, EID4705PS_2306, EID4705PS_2308);
                EID4705PS_3315 = EID4705PS_3314;
            }
            else
            {
                EID4705PS_3315 = EID4705PS_2486;
            }
            EID4705PS_2509 = EID4705PS_3315;
        }
    }
    float3 EID4705PS_3355;
    [branch]
    if (EID4705PS_50_m12 > 0.5f)
    {
        EID4705PS_3355 = lerp(lerp(0.5f.xxx, lerp(dot(EID4705PS_2485, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, EID4705PS_2485, EID4705PS_50_m14.xxx), EID4705PS_50_m15.xxx) * EID4705PS_50_m13, EID4705PS_50_m26.xyz, EID4705PS_50_m26.w.xxx) + ((EID4705PS_50_m27.xyz * smoothstep(1.0f - EID4705PS_50_m16, 1.0f, 1.0f - clamp(EID4705PS_2393, 0.0f, 1.0f))) * EID4705PS_50_m17);
    }
    else
    {
        EID4705PS_3355 = EID4705PS_2485;
    }
    float4 EID4705PS_3363 = float4(EID4705PS_3355 * EID4705PS_20_m20.y, 1.0f);
    EID4705PS_3363.w = 1.0f;
    float4 EID4705PS_3746;
    [branch]
    if (EID4705PS_20_m91.w < 0.5f)
    {
        float3 EID4705PS_3367 = -EID4705PS_430;
        float EID4705PS_3378 = (EID4705PS_431 * EID4705PS_20_m44.w) - EID4705PS_20_m43.w;
        float EID4705PS_3383 = EID4705PS_605 * EID4705PS_20_m46.w;
        float EID4705PS_3387 = EID4705PS_3383 + EID4705PS_20_m47.w;
        float EID4705PS_3388 = max(0.00999999977648258209228515625f, EID4705PS_3387);
        float3 EID4705PS_3402 = exp(EID4705PS_20_m45.xyz * ((-(max(0.0f, EID4705PS_3378))) * (((1.0f - exp(-EID4705PS_3388)) / EID4705PS_3388) * exp(EID4705PS_3383 + EID4705PS_20_m48.w))));
        float EID4705PS_3405 = dot(EID4705PS_3367, EID4705PS_20_m44.xyz);
        float EID4705PS_3411 = EID4705PS_20_m45.w * EID4705PS_20_m45.w;
        float EID4705PS_3415 = (1.0f + EID4705PS_3411) - ((2.0f * EID4705PS_20_m45.w) * EID4705PS_3405);
        float EID4705PS_3419 = (12.56637096405029296875f * EID4705PS_3415) * sqrt(EID4705PS_3415);
        float3 EID4705PS_3738;
        float EID4705PS_3739;
        if (EID4705PS_20_m55.z > 0.0f)
        {
            uint3 EID4705PS_3460 = (uint3(int3(EID4705PS_2162, EID4705PS_2163, int(EID4705PS_20_m19 & 7u))) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint EID4705PS_3461 = EID4705PS_3460.y;
            uint EID4705PS_3462 = EID4705PS_3460.z;
            uint EID4705PS_3465 = EID4705PS_3460.x + (EID4705PS_3461 * EID4705PS_3462);
            uint EID4705PS_3467 = EID4705PS_3461 + (EID4705PS_3462 * EID4705PS_3465);
            uint EID4705PS_3469 = EID4705PS_3462 + (EID4705PS_3465 * EID4705PS_3467);
            uint EID4705PS_3471 = EID4705PS_3465 + (EID4705PS_3467 * EID4705PS_3469);
            float EID4705PS_3496 = dot(EID4705PS_3367, -EID4705PS_18_m0[2].xyz);
            float3 EID4705PS_3503 = EID4705PS_533 - EID4705PS_18_m11.xyz;
            float EID4705PS_3505 = (EID4705PS_20_m55.w * ((EID4705PS_3496 > 5.9604644775390625e-08f) ? (1.0f / EID4705PS_3496) : 0.0f)) * (1.0f / EID4705PS_431);
            float EID4705PS_3506 = EID4705PS_3503.y;
            float EID4705PS_3507 = EID4705PS_3505 * EID4705PS_3506;
            float EID4705PS_3509 = EID4705PS_18_m11.y + EID4705PS_3507;
            float EID4705PS_3510 = EID4705PS_3506 - EID4705PS_3507;
            float EID4705PS_3512 = (1.0f - EID4705PS_3505) * EID4705PS_431;
            float EID4705PS_3518 = EID4705PS_20_m49.z * (EID4705PS_3509 - EID4705PS_20_m49.x);
            float EID4705PS_3525 = EID4705PS_20_m49.z * EID4705PS_3510;
            float EID4705PS_3526 = max(-127.0f, EID4705PS_3525);
            float EID4705PS_3542 = EID4705PS_20_m52.x * (EID4705PS_3509 - EID4705PS_20_m52.z);
            float EID4705PS_3549 = EID4705PS_20_m52.x * EID4705PS_3510;
            float EID4705PS_3550 = max(-127.0f, EID4705PS_3549);
            float EID4705PS_3561 = ((EID4705PS_20_m49.y * exp2(-(max(-127.0f, EID4705PS_3518)))) * ((abs(EID4705PS_3526) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-EID4705PS_3526)) / EID4705PS_3526) : (0.693147182464599609375f - (0.2402265071868896484375f * EID4705PS_3526)))) + ((EID4705PS_20_m52.y * exp2(-(max(-127.0f, EID4705PS_3542)))) * ((abs(EID4705PS_3550) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-EID4705PS_3550)) / EID4705PS_3550) : (0.693147182464599609375f - (0.2402265071868896484375f * EID4705PS_3550))));
            float EID4705PS_3565 = clamp(exp2(-(EID4705PS_3561 * EID4705PS_3512)), 0.0f, 1.0f);
            float EID4705PS_3583 = clamp((EID4705PS_431 * EID4705PS_20_m50.w) + EID4705PS_20_m50.z, 0.0f, 1.0f);
            float EID4705PS_3586 = clamp(((max(EID4705PS_3565, EID4705PS_20_m51.w)) + clamp((EID4705PS_431 * EID4705PS_20_m50.y) + EID4705PS_20_m50.x, 0.0f, 1.0f)) + EID4705PS_3583, 0.0f, 1.0f);
            float EID4705PS_3605 = EID4705PS_3512 - EID4705PS_20_m53.w;
            float4 EID4705PS_3626 = lerp(float4(0.0f, 0.0f, 0.0f, 1.0f), EID4705PS_62.SampleLevel(EID4705_linear_clamp_sampler, float3((EID4705PS_2460 + ((((float3(uint3(EID4705PS_3471, EID4705PS_3467 + (EID4705PS_3469 * EID4705PS_3471), EID4705PS_395) >> uint3(16u, 16u, 16u)) * 1.525902189314365386962890625e-05f.xxx) * 2.0f) - 1.0f.xxx) * EID4705PS_20_m59.w).xy) * EID4705PS_20_m57.xy, (log2((EID4705PS_411 * EID4705PS_20_m56.x) + EID4705PS_20_m56.y) * EID4705PS_20_m56.z) / EID4705PS_20_m55.z), 0.0f), clamp((EID4705PS_411 - EID4705PS_20_m58.z) * 1000000.0f, 0.0f, 1.0f).xxxx);
            float EID4705PS_3628 = EID4705PS_3626.w;
            EID4705PS_3738 = EID4705PS_3626.xyz + (((EID4705PS_20_m51.xyz * (1.0f - EID4705PS_3586)) + (((EID4705PS_20_m54.xyz * pow(clamp(dot(EID4705PS_430, EID4705PS_20_m53.xyz), 0.0f, 1.0f), EID4705PS_20_m54.w)) * (1.0f - clamp(exp2(-(EID4705PS_3561 * (max(EID4705PS_3605, 0.0f)))), 0.0f, 1.0f))) * (1.0f - EID4705PS_3583))) * EID4705PS_3628);
            EID4705PS_3739 = EID4705PS_3628 * EID4705PS_3586;
        }
        else
        {
            float3 EID4705PS_3632 = EID4705PS_533 - EID4705PS_18_m11.xyz;
            float EID4705PS_3634 = EID4705PS_3632.y;
            float EID4705PS_3640 = EID4705PS_20_m49.z * (EID4705PS_18_m11.y - EID4705PS_20_m49.x);
            float EID4705PS_3647 = EID4705PS_20_m49.z * EID4705PS_3634;
            float EID4705PS_3648 = max(-127.0f, EID4705PS_3647);
            float EID4705PS_3664 = EID4705PS_20_m52.x * (EID4705PS_18_m11.y - EID4705PS_20_m52.z);
            float EID4705PS_3671 = EID4705PS_20_m52.x * EID4705PS_3634;
            float EID4705PS_3672 = max(-127.0f, EID4705PS_3671);
            float EID4705PS_3683 = ((EID4705PS_20_m49.y * exp2(-(max(-127.0f, EID4705PS_3640)))) * ((abs(EID4705PS_3648) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-EID4705PS_3648)) / EID4705PS_3648) : (0.693147182464599609375f - (0.2402265071868896484375f * EID4705PS_3648)))) + ((EID4705PS_20_m52.y * exp2(-(max(-127.0f, EID4705PS_3664)))) * ((abs(EID4705PS_3672) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-EID4705PS_3672)) / EID4705PS_3672) : (0.693147182464599609375f - (0.2402265071868896484375f * EID4705PS_3672))));
            float EID4705PS_3687 = clamp(exp2(-(EID4705PS_3683 * EID4705PS_431)), 0.0f, 1.0f);
            float EID4705PS_3705 = clamp((EID4705PS_431 * EID4705PS_20_m50.w) + EID4705PS_20_m50.z, 0.0f, 1.0f);
            float EID4705PS_3708 = clamp(((max(EID4705PS_3687, EID4705PS_20_m51.w)) + clamp((EID4705PS_431 * EID4705PS_20_m50.y) + EID4705PS_20_m50.x, 0.0f, 1.0f)) + EID4705PS_3705, 0.0f, 1.0f);
            float EID4705PS_3727 = EID4705PS_431 - EID4705PS_20_m53.w;
            EID4705PS_3738 = (EID4705PS_20_m51.xyz * (1.0f - EID4705PS_3708)) + (((EID4705PS_20_m54.xyz * pow(clamp(dot(EID4705PS_430, EID4705PS_20_m53.xyz), 0.0f, 1.0f), EID4705PS_20_m54.w)) * (1.0f - clamp(exp2(-(EID4705PS_3683 * (max(EID4705PS_3727, 0.0f)))), 0.0f, 1.0f))) * (1.0f - EID4705PS_3705));
            EID4705PS_3739 = EID4705PS_3708;
        }
        float3 EID4705PS_3744 = (EID4705PS_3363.xyz * (EID4705PS_3402 * EID4705PS_3739)) + ((((clamp(((EID4705PS_20_m46.xyz * (0.0596831031143665313720703125f * (1.0f + (EID4705PS_3405 * EID4705PS_3405)))) + EID4705PS_20_m48.xyz) + (EID4705PS_20_m47.xyz * ((1.0f - EID4705PS_3411) / (max(EID4705PS_3419, 0.001000000047497451305389404296875f)))), 0.0f.xxx, 1.0f.xxx) * 255.0f) * (1.0f.xxx - EID4705PS_3402)) * EID4705PS_3739) + EID4705PS_3738);
        EID4705PS_3746 = float4(EID4705PS_3744.x, EID4705PS_3744.y, EID4705PS_3744.z, EID4705PS_3363.w);
    }
    else
    {
        EID4705PS_3746 = EID4705PS_3363;
    }
    EID4705PS_15 = EID4705PS_3746;
    EID4705PS_16 = EID4705PS_2129;
}

EID4705PS_SPIRV_Cross_Output EID4705PS_main(EID4705PS_SPIRV_Cross_Input stage_input)
{
    EID4705PS_gl_FragCoord = stage_input.EID4705PS_gl_FragCoord;
    EID4705PS_gl_FragCoord.w = 1.0 / EID4705PS_gl_FragCoord.w;
    EID4705PS_gl_FrontFacing = stage_input.EID4705PS_gl_FrontFacing;
    EID4705PS_3 = stage_input.EID4705PS_3;
    EID4705PS_4 = stage_input.EID4705PS_4;
    EID4705PS_5 = stage_input.EID4705PS_5;
    EID4705PS_6 = stage_input.EID4705PS_6;
    EID4705PS_7 = stage_input.EID4705PS_7;
    EID4705PS_8 = stage_input.EID4705PS_8;
    EID4705PS_9 = stage_input.EID4705PS_9;
    EID4705PS_10 = stage_input.EID4705PS_10;
    EID4705PS_11 = stage_input.EID4705PS_11;
    EID4705PS_13 = stage_input.EID4705PS_13;
    EID4705PS_frag_main();
    EID4705PS_SPIRV_Cross_Output stage_output;
    stage_output.EID4705PS_15 = EID4705PS_15;
    stage_output.EID4705PS_16 = EID4705PS_16;
    return stage_output;
}
