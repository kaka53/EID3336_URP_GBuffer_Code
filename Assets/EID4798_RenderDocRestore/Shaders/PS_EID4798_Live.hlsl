// Captured AO uses capture projection; the audit uniform is editor-only in practice.
float _EID4798AOAudit;
// Captured F:/endfield06.rdc EID4798. Independent resources; live Unity M/VP.
struct EID4798PS_22
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

static const int2 EID4798PS_358[6] = { int2(2, 1), int2(2, 1), int2(0, 2), int2(0, 2), int2(0, 1), int2(0, 1) };
static const float2 EID4798PS_359[6] = { float2(-1.0f, 1.0f), 1.0f.xx, float2(1.0f, -1.0f), 1.0f.xx, 1.0f.xx, float2(-1.0f, 1.0f) };

cbuffer EID4798PS_17_18
{
    column_major float4x4 EID4798PS_18_m0 : packoffset(c0);
    column_major float4x4 EID4798PS_18_m1 : packoffset(c4);
    column_major float4x4 EID4798PS_18_m2 : packoffset(c8);
    column_major float4x4 EID4798PS_18_m3 : packoffset(c12);
    column_major float4x4 EID4798PS_18_m4 : packoffset(c16);
    column_major float4x4 EID4798PS_18_m5 : packoffset(c20);
    column_major float4x4 EID4798PS_18_m6 : packoffset(c24);
    column_major float4x4 EID4798PS_18_m7 : packoffset(c28);
    column_major float4x4 EID4798PS_18_m8 : packoffset(c32);
    column_major float4x4 EID4798PS_18_m9 : packoffset(c36);
    column_major float4x4 EID4798PS_18_m10 : packoffset(c40);
    float4 EID4798PS_18_m11 : packoffset(c44);
    column_major float4x4 EID4798PS_18_m12 : packoffset(c45);
    column_major float4x4 EID4798PS_18_m13 : packoffset(c49);
    column_major float4x4 EID4798PS_18_m14 : packoffset(c53);
    column_major float4x4 EID4798PS_18_m15 : packoffset(c57);
    column_major float4x4 EID4798PS_18_m16 : packoffset(c61);
    column_major float4x4 EID4798PS_18_m17 : packoffset(c65);
    column_major float4x4 EID4798PS_18_m18 : packoffset(c69);
    column_major float4x4 EID4798PS_18_m19 : packoffset(c73);
    column_major float4x4 EID4798PS_18_m20 : packoffset(c77);
    float4 EID4798PS_18_m21 : packoffset(c81);
};

cbuffer EID4798PS_19_20
{
    float4 EID4798PS_20_m0 : packoffset(c0);
    float4 EID4798PS_20_m1 : packoffset(c1);
    float4 EID4798PS_20_m2 : packoffset(c2);
    float4 EID4798PS_20_m3 : packoffset(c3);
    float4 EID4798PS_20_m4 : packoffset(c4);
    float4 EID4798PS_20_m5 : packoffset(c5);
    float4 EID4798PS_20_m6[6] : packoffset(c6);
    float4 EID4798PS_20_m7[6] : packoffset(c12);
    float4 EID4798PS_20_m8 : packoffset(c18);
    float4 EID4798PS_20_m9 : packoffset(c19);
    float4 EID4798PS_20_m10 : packoffset(c20);
    float4 EID4798PS_20_m11 : packoffset(c21);
    float4 EID4798PS_20_m12 : packoffset(c22);
    float4 EID4798PS_20_m13 : packoffset(c23);
    float4 EID4798PS_20_m14 : packoffset(c24);
    float4 EID4798PS_20_m15 : packoffset(c25);
    float EID4798PS_20_m16 : packoffset(c26);
    float EID4798PS_20_m17 : packoffset(c26.y);
    float EID4798PS_20_m18 : packoffset(c26.z);
    uint EID4798PS_20_m19 : packoffset(c26.w);
    float4 EID4798PS_20_m20 : packoffset(c27);
    int4 EID4798PS_20_m21 : packoffset(c28);
    float4 EID4798PS_20_m22 : packoffset(c29);
    float4 EID4798PS_20_m23 : packoffset(c30);
    float4 EID4798PS_20_m24 : packoffset(c31);
    float4 EID4798PS_20_m25 : packoffset(c32);
    float4 EID4798PS_20_m26 : packoffset(c33);
    float4 EID4798PS_20_m27 : packoffset(c34);
    float4 EID4798PS_20_m28 : packoffset(c35);
    float4 EID4798PS_20_m29 : packoffset(c36);
    float4 EID4798PS_20_m30 : packoffset(c37);
    float4 EID4798PS_20_m31 : packoffset(c38);
    float4 EID4798PS_20_m32[4] : packoffset(c39);
    float4 EID4798PS_20_m33[4] : packoffset(c43);
    float4 EID4798PS_20_m34[4] : packoffset(c47);
    float4 EID4798PS_20_m35[4] : packoffset(c51);
    float4 EID4798PS_20_m36 : packoffset(c55);
    float4 EID4798PS_20_m37 : packoffset(c56);
    float4 EID4798PS_20_m38[4] : packoffset(c57);
    float4 EID4798PS_20_m39[4] : packoffset(c61);
    float4 EID4798PS_20_m40[4] : packoffset(c65);
    float4 EID4798PS_20_m41 : packoffset(c69);
    float4 EID4798PS_20_m42 : packoffset(c70);
    float4 EID4798PS_20_m43 : packoffset(c71);
    float4 EID4798PS_20_m44 : packoffset(c72);
    float4 EID4798PS_20_m45 : packoffset(c73);
    float4 EID4798PS_20_m46 : packoffset(c74);
    float4 EID4798PS_20_m47 : packoffset(c75);
    float4 EID4798PS_20_m48 : packoffset(c76);
    float4 EID4798PS_20_m49 : packoffset(c77);
    float4 EID4798PS_20_m50 : packoffset(c78);
    float4 EID4798PS_20_m51 : packoffset(c79);
    float4 EID4798PS_20_m52 : packoffset(c80);
    float4 EID4798PS_20_m53 : packoffset(c81);
    float4 EID4798PS_20_m54 : packoffset(c82);
    float4 EID4798PS_20_m55 : packoffset(c83);
    float4 EID4798PS_20_m56 : packoffset(c84);
    float4 EID4798PS_20_m57 : packoffset(c85);
    float4 EID4798PS_20_m58 : packoffset(c86);
    float4 EID4798PS_20_m59 : packoffset(c87);
    float4 EID4798PS_20_m60 : packoffset(c88);
    float4 EID4798PS_20_m61 : packoffset(c89);
    float4 EID4798PS_20_m62 : packoffset(c90);
    float4 EID4798PS_20_m63 : packoffset(c91);
    float4 EID4798PS_20_m64 : packoffset(c92);
    float4 EID4798PS_20_m65 : packoffset(c93);
    float4 EID4798PS_20_m66 : packoffset(c94);
    float4 EID4798PS_20_m67 : packoffset(c95);
    float4 EID4798PS_20_m68 : packoffset(c96);
    float4 EID4798PS_20_m69 : packoffset(c97);
    float4 EID4798PS_20_m70 : packoffset(c98);
    float4 EID4798PS_20_m71 : packoffset(c99);
    float4 EID4798PS_20_m72 : packoffset(c100);
    float4 EID4798PS_20_m73 : packoffset(c101);
    float4 EID4798PS_20_m74 : packoffset(c102);
    float4 EID4798PS_20_m75 : packoffset(c103);
    float4 EID4798PS_20_m76 : packoffset(c104);
    float4 EID4798PS_20_m77 : packoffset(c105);
    float4 EID4798PS_20_m78 : packoffset(c106);
    float4 EID4798PS_20_m79 : packoffset(c107);
    float4 EID4798PS_20_m80 : packoffset(c108);
    float4 EID4798PS_20_m81 : packoffset(c109);
    float4 EID4798PS_20_m82 : packoffset(c110);
    float4 EID4798PS_20_m83 : packoffset(c111);
    float4 EID4798PS_20_m84 : packoffset(c112);
    float4 EID4798PS_20_m85 : packoffset(c113);
    float4 EID4798PS_20_m86 : packoffset(c114);
    float4 EID4798PS_20_m87 : packoffset(c115);
    float4 EID4798PS_20_m88 : packoffset(c116);
    float4 EID4798PS_20_m89 : packoffset(c117);
    float4 EID4798PS_20_m90 : packoffset(c118);
    float4 EID4798PS_20_m91 : packoffset(c119);
    float4 EID4798PS_20_m92 : packoffset(c120);
    float4 EID4798PS_20_m93 : packoffset(c121);
    float4 EID4798PS_20_m94 : packoffset(c122);
    float4 EID4798PS_20_m95 : packoffset(c123);
    float4 EID4798PS_20_m96 : packoffset(c124);
    float4 EID4798PS_20_m97 : packoffset(c125);
    float4 EID4798PS_20_m98 : packoffset(c126);
    float4 EID4798PS_20_m99[2] : packoffset(c127);
    float4 EID4798PS_20_m100[2] : packoffset(c129);
    float EID4798PS_20_m101 : packoffset(c131);
    float EID4798PS_20_m102 : packoffset(c131.y);
    float EID4798PS_20_m103 : packoffset(c131.z);
    float EID4798PS_20_m104 : packoffset(c131.w);
    float4 EID4798PS_20_m105 : packoffset(c132);
    float4 EID4798PS_20_m106 : packoffset(c133);
    float4 EID4798PS_20_m107 : packoffset(c134);
    float4 EID4798PS_20_m108 : packoffset(c135);
    float4 EID4798PS_20_m109 : packoffset(c136);
    float4 EID4798PS_20_m110 : packoffset(c137);
    float4 EID4798PS_20_m111 : packoffset(c138);
    float4 EID4798PS_20_m112 : packoffset(c139);
    float4 EID4798PS_20_m113 : packoffset(c140);
    float4 EID4798PS_20_m114 : packoffset(c141);
    float4 EID4798PS_20_m115 : packoffset(c142);
    float4 EID4798PS_20_m116 : packoffset(c143);
    float4 EID4798PS_20_m117 : packoffset(c144);
    float4 EID4798PS_20_m118 : packoffset(c145);
    float4 EID4798PS_20_m119 : packoffset(c146);
    float4 EID4798PS_20_m120 : packoffset(c147);
    float4 EID4798PS_20_m121 : packoffset(c148);
    float4 EID4798PS_20_m122 : packoffset(c149);
    float4 EID4798PS_20_m123 : packoffset(c150);
    float4 EID4798PS_20_m124 : packoffset(c151);
    float4 EID4798PS_20_m125 : packoffset(c152);
    float4 EID4798PS_20_m126 : packoffset(c153);
    float4 EID4798PS_20_m127 : packoffset(c154);
    float4 EID4798PS_20_m128 : packoffset(c155);
    float4 EID4798PS_20_m129 : packoffset(c156);
    float4 EID4798PS_20_m130 : packoffset(c157);
    float4 EID4798PS_20_m131 : packoffset(c158);
    float4 EID4798PS_20_m132 : packoffset(c159);
    float4 EID4798PS_20_m133 : packoffset(c160);
    float4 EID4798PS_20_m134 : packoffset(c161);
    column_major float4x4 EID4798PS_20_m135 : packoffset(c162);
    float4 EID4798PS_20_m136 : packoffset(c166);
    float4 EID4798PS_20_m137 : packoffset(c167);
    float4 EID4798PS_20_m138[32] : packoffset(c168);
};

cbuffer EID4798PS_21_23
{
    float4 EID4798PS_instanceRaw[4096] : packoffset(c0);
};

ByteAddressBuffer EID4798PS_32;
ByteAddressBuffer EID4798PS_34;
cbuffer EID4798PS_35_36
{
    int EID4798PS_36_m0 : packoffset(c0);
    int EID4798PS_36_m1 : packoffset(c0.y);
    int EID4798PS_36_m2 : packoffset(c0.z);
    int EID4798PS_36_m3 : packoffset(c0.w);
    float EID4798PS_36_m4 : packoffset(c1);
    float EID4798PS_36_m5 : packoffset(c1.y);
    float EID4798PS_36_m6 : packoffset(c1.z);
    float EID4798PS_36_m7 : packoffset(c1.w);
    float EID4798PS_36_m8 : packoffset(c2);
    float EID4798PS_36_m9 : packoffset(c2.y);
    float EID4798PS_36_m10 : packoffset(c2.z);
    float EID4798PS_36_m11 : packoffset(c2.w);
};

cbuffer EID4798PS_37_38
{
    float4 EID4798PS_38_m0 : packoffset(c0);
    float4 EID4798PS_38_m1 : packoffset(c1);
    float4 EID4798PS_38_m2 : packoffset(c2);
    float4 EID4798PS_38_m3 : packoffset(c3);
    float4 EID4798PS_38_m4 : packoffset(c4);
    uint4 EID4798PS_38_m5 : packoffset(c5);
    float4 EID4798PS_38_m6[2048] : packoffset(c6);
};

cbuffer EID4798PS_39_40
{
    column_major float4x4 EID4798PS_40_m0[5] : packoffset(c0);
    float4 EID4798PS_40_m1[4] : packoffset(c20);
    float4 EID4798PS_40_m2[4] : packoffset(c24);
    float4 EID4798PS_40_m3[4] : packoffset(c28);
    float4 EID4798PS_40_m4 : packoffset(c32);
    float4 EID4798PS_40_m5 : packoffset(c33);
    float4 EID4798PS_40_m6 : packoffset(c34);
    float4 EID4798PS_40_m7 : packoffset(c35);
    float4 EID4798PS_40_m8 : packoffset(c36);
    float4 EID4798PS_40_m9[27] : packoffset(c37);
    column_major float4x4 EID4798PS_40_m10[56] : packoffset(c64);
    float4 EID4798PS_40_m11[56] : packoffset(c288);
    float4 EID4798PS_40_m12[56] : packoffset(c344);
    float4 EID4798PS_40_m13 : packoffset(c400);
    float4 EID4798PS_40_m14[47] : packoffset(c401);
    column_major float4x4 EID4798PS_40_m15[15] : packoffset(c448);
    float4 EID4798PS_40_m16[15] : packoffset(c508);
    float4 EID4798PS_40_m17[15] : packoffset(c523);
    float4 EID4798PS_40_m18[15] : packoffset(c538);
    float4 EID4798PS_40_m19 : packoffset(c553);
    float4 EID4798PS_40_m20 : packoffset(c554);
    float4 EID4798PS_40_m21[21] : packoffset(c555);
    column_major float4x4 EID4798PS_40_m22 : packoffset(c576);
    column_major float4x4 EID4798PS_40_m23 : packoffset(c580);
    float4 EID4798PS_40_m24 : packoffset(c584);
    float4 EID4798PS_40_m25 : packoffset(c585);
    float4 EID4798PS_40_m26 : packoffset(c586);
    float4 EID4798PS_40_m27[128] : packoffset(c587);
};

cbuffer EID4798PS_50_51
{
    float EID4798PS_51_m0 : packoffset(c0);
    float EID4798PS_51_m1 : packoffset(c0.y);
    float EID4798PS_51_m2 : packoffset(c0.z);
    float EID4798PS_51_m3 : packoffset(c0.w);
    float EID4798PS_51_m4 : packoffset(c1);
    float EID4798PS_51_m5 : packoffset(c1.y);
    float EID4798PS_51_m6 : packoffset(c1.z);
    float EID4798PS_51_m7 : packoffset(c1.w);
    float EID4798PS_51_m8 : packoffset(c2);
    float EID4798PS_51_m9 : packoffset(c2.y);
    float EID4798PS_51_m10 : packoffset(c2.z);
    float EID4798PS_51_m11 : packoffset(c2.w);
    float EID4798PS_51_m12 : packoffset(c3);
    float EID4798PS_51_m13 : packoffset(c3.y);
    float EID4798PS_51_m14 : packoffset(c3.z);
    float EID4798PS_51_m15 : packoffset(c3.w);
    float EID4798PS_51_m16 : packoffset(c4);
    float EID4798PS_51_m17 : packoffset(c4.y);
    float EID4798PS_51_m18 : packoffset(c4.z);
    float EID4798PS_51_m19 : packoffset(c4.w);
    float EID4798PS_51_m20 : packoffset(c5);
    float EID4798PS_51_m21 : packoffset(c5.y);
    float EID4798PS_51_m22 : packoffset(c5.z);
    float EID4798PS_51_m23 : packoffset(c5.w);
    float4 EID4798PS_51_m24 : packoffset(c6);
    float4 EID4798PS_51_m25 : packoffset(c7);
    float4 EID4798PS_51_m26 : packoffset(c8);
    float4 EID4798PS_51_m27 : packoffset(c9);
    float4 EID4798PS_51_m28 : packoffset(c10);
    float4 EID4798PS_51_m29 : packoffset(c11);
    float EID4798PS_51_m30 : packoffset(c12);
    float EID4798PS_51_m31 : packoffset(c12.y);
    float EID4798PS_51_m32 : packoffset(c12.z);
    float EID4798PS_51_m33 : packoffset(c12.w);
    float EID4798PS_51_m34 : packoffset(c13);
    float EID4798PS_51_m35 : packoffset(c13.y);
    float EID4798PS_51_m36 : packoffset(c13.z);
    float EID4798PS_51_m37 : packoffset(c13.w);
    float EID4798PS_51_m38 : packoffset(c14);
    float EID4798PS_51_m39 : packoffset(c14.y);
    float EID4798PS_51_m40 : packoffset(c14.z);
    float EID4798PS_51_m41 : packoffset(c14.w);
    float4 EID4798PS_51_m42 : packoffset(c15);
    float EID4798PS_51_m43 : packoffset(c16);
    float EID4798PS_51_m44 : packoffset(c16.y);
    float EID4798PS_51_m45 : packoffset(c16.z);
    float EID4798PS_51_m46 : packoffset(c16.w);
    float EID4798PS_51_m47 : packoffset(c17);
    float EID4798PS_51_m48 : packoffset(c17.y);
    float EID4798PS_51_m49 : packoffset(c17.z);
    float EID4798PS_51_m50 : packoffset(c17.w);
    float4 EID4798PS_51_m51 : packoffset(c18);
    float EID4798PS_51_m52 : packoffset(c19);
    float EID4798PS_51_m53 : packoffset(c19.y);
    float EID4798PS_51_m54 : packoffset(c19.z);
    float EID4798PS_51_m55 : packoffset(c19.w);
    float4 EID4798PS_51_m56 : packoffset(c20);
    float4 EID4798PS_51_m57 : packoffset(c21);
    float4 EID4798PS_51_m58 : packoffset(c22);
    float4 EID4798PS_51_m59 : packoffset(c23);
    float4 EID4798PS_51_m60 : packoffset(c24);
    float4 EID4798PS_51_m61 : packoffset(c25);
    float EID4798PS_51_m62 : packoffset(c26);
    float EID4798PS_51_m63 : packoffset(c26.y);
    float EID4798PS_51_m64 : packoffset(c26.z);
    float EID4798PS_51_m65 : packoffset(c26.w);
    float EID4798PS_51_m66 : packoffset(c27);
    float EID4798PS_51_m67 : packoffset(c27.y);
    float EID4798PS_51_m68 : packoffset(c27.z);
    float EID4798PS_51_m69 : packoffset(c27.w);
};

cbuffer EID4798PS_60_61
{
    float4 EID4798PS_61_m0[32] : packoffset(c0);
    column_major float4x4 EID4798PS_61_m1[32] : packoffset(c32);
};

SamplerState EID4798_point_clamp_sampler;
SamplerState EID4798_linear_clamp_sampler;
SamplerState EID4798_linear_repeat_sampler;

Texture2D<float4> EID4798PS_30;
Texture2D<float4> EID4798PS_41;
Texture2D<float4> EID4798PS_42;
Texture3D<float4> EID4798PS_44;
Texture3D<float4> EID4798PS_45;
Texture3D<float4> EID4798PS_46;
Texture3D<float4> EID4798PS_47;
Texture3D<float4> EID4798PS_48;
Texture3D<float4> EID4798PS_49;
Texture2D<float4> EID4798PS_52;
Texture2D<float4> EID4798PS_53;
Texture2D<float4> EID4798PS_54;
Texture2D<float4> EID4798PS_55;
Texture2D<float4> EID4798PS_56;
Texture2D<float4> EID4798PS_57;
Texture2D<float4> EID4798PS_58;
Texture2D<float4> EID4798PS_59;
Texture3D<float4> EID4798PS_64;

static float4 EID4798PS_gl_FragCoord;
static bool EID4798PS_gl_FrontFacing;
static float2 EID4798PS_3;
static float3 EID4798PS_4;
static float3 EID4798PS_5;
static float4 EID4798PS_6;
static float3 EID4798PS_7;
static float3 EID4798PS_8;
static float3 EID4798PS_9;
static float4 EID4798PS_10;
static float3 EID4798PS_11;
static uint EID4798PS_13;
static float4 EID4798PS_15;
static float4 EID4798PS_16;

EID4798PS_22 EID4798PS_LoadInstance(uint index) { uint b=index*16; EID4798PS_22 x;
x._m0=transpose(float4x4(EID4798PS_instanceRaw[b],EID4798PS_instanceRaw[b+1],EID4798PS_instanceRaw[b+2],EID4798PS_instanceRaw[b+3]));
x._m1=EID4798PS_instanceRaw[b+4];x._m2=EID4798PS_instanceRaw[b+5];
x._m3=transpose(float4x4(EID4798PS_instanceRaw[b+6],EID4798PS_instanceRaw[b+7],EID4798PS_instanceRaw[b+8],EID4798PS_instanceRaw[b+9]));
x._m4=EID4798PS_instanceRaw[b+10];
x._m5=EID4798PS_instanceRaw[b+11];
x._m6=EID4798PS_instanceRaw[b+12];
x._m7=EID4798PS_instanceRaw[b+13];
x._m8=EID4798PS_instanceRaw[b+14];
x._m9=EID4798PS_instanceRaw[b+15];
return x;}

struct EID4798PS_SPIRV_Cross_Input
{
    float2 EID4798PS_3 : TEXCOORD0;
    float3 EID4798PS_4 : TEXCOORD1;
    float3 EID4798PS_5 : TEXCOORD2;
    float4 EID4798PS_6 : TEXCOORD3;
    float3 EID4798PS_7 : TEXCOORD4;
    float3 EID4798PS_8 : TEXCOORD5;
    float3 EID4798PS_9 : TEXCOORD6;
    float4 EID4798PS_10 : TEXCOORD7;
    float3 EID4798PS_11 : TEXCOORD8;
    nointerpolation uint EID4798PS_13 : TEXCOORD9;
    float4 EID4798PS_gl_FragCoord : SV_Position;
    bool EID4798PS_gl_FrontFacing : SV_IsFrontFace;
};

struct EID4798PS_SPIRV_Cross_Output
{
    float4 EID4798PS_15 : SV_Target0;
    float4 EID4798PS_16 : SV_Target1;
};

static float3 EID4798PS_381;
static float EID4798PS_382;
static float3 EID4798PS_383;
static float EID4798PS_387;
static uint EID4798PS_388;

uint EID4798PS_spvPackHalf2x16(float2 value)
{
    uint2 Packed = f32tof16(value);
    return Packed.x | (Packed.y << 16);
}

float2 EID4798PS_spvUnpackHalf2x16(uint value)
{
    return f16tof32(uint2(value & 0xffff, value >> 16));
}

float EID4798ShadowGreater(float2 uv, float reference)
{
 uint w,h; EID4798PS_41.GetDimensions(w,h); float2 p=uv*float2(w,h)-0.5;
 int2 a=(int2)floor(p); float2 f=frac(p); int2 hi=int2(w,h)-1;
 float c00=reference>EID4798PS_41.Load(int3(clamp(a,int2(0,0),hi),0)).r?1:0;
 float c10=reference>EID4798PS_41.Load(int3(clamp(a+int2(1,0),int2(0,0),hi),0)).r?1:0;
 float c01=reference>EID4798PS_41.Load(int3(clamp(a+int2(0,1),int2(0,0),hi),0)).r?1:0;
 float c11=reference>EID4798PS_41.Load(int3(clamp(a+int2(1,1),int2(0,0),hi),0)).r?1:0;
 return lerp(lerp(c00,c10,f.x),lerp(c01,c11,f.x),f.y);
}


void EID4798PS_frag_main()
{
    float EID4798PS_404 = 1.0f / EID4798PS_gl_FragCoord.w;
    float3 EID4798PS_419 = lerp(-EID4798PS_4, float3(EID4798PS_18_m0[2u].x, EID4798PS_18_m0[2u].y, EID4798PS_18_m0[2u].z), EID4798PS_20_m4.w.xxx);
    float EID4798PS_420 = dot(EID4798PS_419, EID4798PS_419);
    float EID4798PS_422 = rsqrt(isnan(9.9999999392252902907785028219223e-09f) ? EID4798PS_420 : (isnan(EID4798PS_420) ? 9.9999999392252902907785028219223e-09f : max(EID4798PS_420, 9.9999999392252902907785028219223e-09f)));
    float3 EID4798PS_423 = EID4798PS_419 * EID4798PS_422;
    float EID4798PS_424 = EID4798PS_420 * EID4798PS_422;
    uint EID4798PS_427 = asuint(EID4798PS_LoadInstance(EID4798PS_13)._m2.x);
    bool EID4798PS_432 = (asuint(EID4798PS_LoadInstance(EID4798PS_13)._m1.w) & 16u) != 0u;
    float4 EID4798PS_449;
    float4 EID4798PS_450;
    float4 EID4798PS_451;
    if (EID4798PS_432)
    {
        EID4798PS_449 = asfloat(EID4798PS_34.Load4((EID4798PS_427 + 2u) * 16 + 0));
        EID4798PS_450 = asfloat(EID4798PS_34.Load4((EID4798PS_427 + 1u) * 16 + 0));
        EID4798PS_451 = asfloat(EID4798PS_34.Load4(EID4798PS_427 * 16 + 0));
    }
    else
    {
        EID4798PS_449 = EID4798PS_LoadInstance(EID4798PS_13)._m0[2];
        EID4798PS_450 = EID4798PS_LoadInstance(EID4798PS_13)._m0[1];
        EID4798PS_451 = EID4798PS_LoadInstance(EID4798PS_13)._m0[0];
    }
    float4 EID4798PS_457 = EID4798PS_56.SampleBias(EID4798_linear_repeat_sampler, EID4798PS_3, EID4798PS_20_m16);
    float3 EID4798PS_462 = EID4798PS_457.xyz * EID4798PS_51_m24.xyz;
    float4 EID4798PS_466 = EID4798PS_57.SampleBias(EID4798_linear_repeat_sampler, EID4798PS_3, EID4798PS_20_m16);
    float EID4798PS_467 = EID4798PS_466.x;
    float EID4798PS_468 = EID4798PS_466.y;
    float EID4798PS_469 = EID4798PS_466.z;
    float EID4798PS_473 = EID4798PS_457.w * EID4798PS_51_m24.w;
    float3 EID4798PS_491 = EID4798PS_462 * EID4798PS_51_m18;
    float3 EID4798PS_495 = lerp(dot(EID4798PS_491, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, EID4798PS_491, EID4798PS_51_m19.xxx);
    float4 EID4798PS_499 = EID4798PS_58.SampleBias(EID4798_linear_repeat_sampler, EID4798PS_3, EID4798PS_20_m16);
    float2 EID4798PS_504 = (EID4798PS_499.xy * 2.0f) - 1.0f.xx;
    float2 EID4798PS_506 = EID4798PS_504.xy;
    float EID4798PS_510 = sqrt(1.0f - clamp(dot(EID4798PS_506, EID4798PS_506), 0.0f, 1.0f));
    float3 EID4798PS_512 = float3(EID4798PS_504.x, EID4798PS_504.y, EID4798PS_383.z);
    EID4798PS_512.z = isnan(EID4798PS_510) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? EID4798PS_510 : max(1.000000016862383526387164645044e-16f, EID4798PS_510));
    float2 EID4798PS_514 = EID4798PS_512.xy * EID4798PS_51_m3;
    float4 EID4798PS_525 = EID4798PS_52.Sample(EID4798_linear_repeat_sampler, (EID4798PS_3 * EID4798PS_51_m51.xy) + EID4798PS_51_m51.zw);
    float3 EID4798PS_530 = EID4798PS_4 + EID4798PS_18_m11.xyz;
    float3 EID4798PS_535 = EID4798PS_530 - float3(EID4798PS_451.w, EID4798PS_387, EID4798PS_449.w);
    EID4798PS_535.y = 6.103515625e-05f;
    float3 EID4798PS_537 = normalize(EID4798PS_535);
    float3 EID4798PS_543 = EID4798PS_6.xyz * 1.0f;
    float3 EID4798PS_544 = (cross(EID4798PS_5, EID4798PS_6.xyz) * EID4798PS_6.w) * 1.0f;
    float3 EID4798PS_545 = EID4798PS_5 * 1.0f;
    float3x3 EID4798PS_546 = float3x3(EID4798PS_543, EID4798PS_544, EID4798PS_545);
    float3 EID4798PS_547 = mul(float3(EID4798PS_514.x, EID4798PS_514.y, EID4798PS_512.z), EID4798PS_546);
    float EID4798PS_548 = dot(EID4798PS_547, EID4798PS_547);
    float EID4798PS_556 = EID4798PS_gl_FrontFacing ? 1.0f : ((-1.0f) + (2.0f * EID4798PS_51_m5));
    float3 EID4798PS_557 = (EID4798PS_547 * rsqrt(isnan(EID4798PS_548) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? EID4798PS_548 : max(1.1754943508222875079687365372222e-38f, EID4798PS_548)))) * EID4798PS_556;
    float3 EID4798PS_558 = normalize(EID4798PS_5) * EID4798PS_556;
    float2 EID4798PS_563 = (EID4798PS_499.zw * 2.0f) - 1.0f.xx;
    float2 EID4798PS_565 = EID4798PS_563.xy;
    float EID4798PS_569 = sqrt(1.0f - clamp(dot(EID4798PS_565, EID4798PS_565), 0.0f, 1.0f));
    float3 EID4798PS_571 = float3(EID4798PS_563.x, EID4798PS_563.y, EID4798PS_383.z);
    EID4798PS_571.z = isnan(EID4798PS_569) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? EID4798PS_569 : max(1.000000016862383526387164645044e-16f, EID4798PS_569));
    float2 EID4798PS_573 = EID4798PS_571.xy * EID4798PS_51_m31;
    float3 EID4798PS_576 = normalize(mul(float3(EID4798PS_573.x, EID4798PS_573.y, EID4798PS_571.z), EID4798PS_546));
    float3x3 EID4798PS_583 = float3x3(EID4798PS_451.xyz, EID4798PS_450.xyz, EID4798PS_449.xyz);
    float3 EID4798PS_584 = mul(EID4798PS_583, float3(EID4798PS_51_m39, 1.0f, 0.0f));
    float EID4798PS_585 = dot(EID4798PS_584, EID4798PS_584);
    float3 EID4798PS_596 = cross(EID4798PS_576, lerp(cross(EID4798PS_576, (EID4798PS_584 * rsqrt(isnan(EID4798PS_585) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? EID4798PS_585 : max(1.1754943508222875079687365372222e-38f, EID4798PS_585)))).xyz), EID4798PS_6.xyz, EID4798PS_467.xxx).xyz) * lerp(1.0f, EID4798PS_6.w, EID4798PS_467);
    float3 EID4798PS_598 = mul(EID4798PS_423, EID4798PS_583);
    float EID4798PS_607 = pow(clamp(dot(normalize(mul(EID4798PS_576, EID4798PS_583).xz), normalize(EID4798PS_598.xz)), 0.0f, 1.0f), EID4798PS_51_m37);
    float2 EID4798PS_612 = EID4798PS_gl_FragCoord.xy * EID4798PS_20_m0.zw;
    uint2 EID4798PS_613 = uint2(EID4798PS_gl_FragCoord.xy);
    float3 EID4798PS_623 = mul(float3x3(EID4798PS_18_m1[0].xyz, EID4798PS_18_m1[1].xyz, EID4798PS_18_m1[2].xyz), float3(0.0f, 0.0f, 1.0f));
    uint EID4798PS_632 = asuint((EID4798PS_20_m89.x > 0.5f) ? EID4798PS_20_m89.y : EID4798PS_LoadInstance(EID4798PS_13)._m7.x);
    float4 EID4798PS_645 = float4(float(EID4798PS_632 & 255u), float((EID4798PS_632 >> 8u) & 255u), float((EID4798PS_632 >> 16u) & 255u), float((EID4798PS_632 >> 24u) & 255u)) * 0.0039215688593685626983642578125f.xxxx;
    float EID4798PS_646 = EID4798PS_645.x;
    float EID4798PS_648 = EID4798PS_645.z;
    float EID4798PS_649 = EID4798PS_645.w;
    float EID4798PS_655 = EID4798PS_530.y;
    float EID4798PS_658 = smoothstep(-0.20000000298023223876953125f, 0.1500000059604644775390625f, lerp(EID4798PS_LoadInstance(EID4798PS_13)._m7.y, EID4798PS_20_m89.w, EID4798PS_20_m89.x) - EID4798PS_655) * EID4798PS_645.y;
    float EID4798PS_659 = isnan(EID4798PS_658) ? EID4798PS_648 : (isnan(EID4798PS_648) ? EID4798PS_658 : max(EID4798PS_648, EID4798PS_658));
    float EID4798PS_660 = isnan(EID4798PS_659) ? EID4798PS_646 : (isnan(EID4798PS_646) ? EID4798PS_659 : max(EID4798PS_646, EID4798PS_659));
    float EID4798PS_668 = lerp(EID4798PS_20_m22.x, 1.0f, EID4798PS_20_m91.w) * EID4798PS_20_m20.x;
    float4 EID4798PS_1162;
    float3 EID4798PS_1163;
    float3 EID4798PS_1164;
    float EID4798PS_1165;
    if (EID4798PS_20_m80.y < 0.5f)
    {
        float3 EID4798PS_686 = EID4798PS_530 - (EID4798PS_20_m105.xyz + (EID4798PS_623 * (-EID4798PS_20_m107.w)));
        float EID4798PS_688 = abs(EID4798PS_686.x);
        float EID4798PS_690 = abs(EID4798PS_686.z);
        float EID4798PS_696 = clamp(((isnan(EID4798PS_690) ? EID4798PS_688 : (isnan(EID4798PS_688) ? EID4798PS_690 : max(EID4798PS_688, EID4798PS_690))) - 464.0f) * 0.03125f, 0.0f, 1.0f);
        float EID4798PS_699 = clamp((abs(EID4798PS_686.y) - 208.0f) * 0.03125f, 0.0f, 1.0f);
        float EID4798PS_700 = isnan(EID4798PS_699) ? EID4798PS_696 : (isnan(EID4798PS_696) ? EID4798PS_699 : max(EID4798PS_696, EID4798PS_699));
        float4 EID4798PS_1002;
        float4 EID4798PS_1003;
        float4 EID4798PS_1004;
        float EID4798PS_1005;
        float EID4798PS_1006;
        if ((EID4798PS_20_m105.w != 0.0f) && (EID4798PS_700 < 1.0f))
        {
            float3 EID4798PS_713 = EID4798PS_530 - (EID4798PS_20_m105.xyz + (EID4798PS_623 * (-EID4798PS_20_m107.y)));
            float EID4798PS_715 = abs(EID4798PS_713.x);
            float EID4798PS_717 = abs(EID4798PS_713.z);
            float EID4798PS_723 = clamp(((isnan(EID4798PS_717) ? EID4798PS_715 : (isnan(EID4798PS_715) ? EID4798PS_717 : max(EID4798PS_715, EID4798PS_717))) - 29.0f) * 0.5f, 0.0f, 1.0f);
            float EID4798PS_726 = clamp((abs(EID4798PS_713.y) - 13.0f) * 0.5f, 0.0f, 1.0f);
            float EID4798PS_727 = isnan(EID4798PS_726) ? EID4798PS_723 : (isnan(EID4798PS_723) ? EID4798PS_726 : max(EID4798PS_723, EID4798PS_726));
            float EID4798PS_803;
            float4 EID4798PS_804;
            float4 EID4798PS_805;
            float4 EID4798PS_806;
            if (EID4798PS_727 < 1.0f)
            {
                float3 EID4798PS_736 = ((EID4798PS_530 * 2.0f) + 0.5f.xxx) * EID4798PS_20_m106.xyz;
                float3 EID4798PS_738 = EID4798PS_736 - floor(EID4798PS_736);
                float4 EID4798PS_742 = EID4798PS_44.SampleLevel(EID4798_linear_repeat_sampler, EID4798PS_738, 0.0f);
                float EID4798PS_743 = 1.0f - EID4798PS_727;
                float EID4798PS_747 = EID4798PS_20_m106.y * 0.5f;
                float EID4798PS_752 = EID4798PS_738.x;
                float EID4798PS_753 = clamp(EID4798PS_738.y, EID4798PS_747, 1.0f - EID4798PS_747) * 0.3333333432674407958984375f;
                float EID4798PS_754 = EID4798PS_738.z;
                float4 EID4798PS_757 = EID4798PS_45.SampleLevel(EID4798_linear_clamp_sampler, float3(EID4798PS_752, EID4798PS_753, EID4798PS_754), 0.0f);
                float EID4798PS_773 = EID4798PS_742.x;
                float EID4798PS_783 = EID4798PS_742.y;
                float EID4798PS_793 = EID4798PS_742.z;
                EID4798PS_803 = EID4798PS_700 + (EID4798PS_757.w * EID4798PS_743);
                EID4798PS_804 = float4(((EID4798PS_45.SampleLevel(EID4798_linear_clamp_sampler, float3(EID4798PS_752, EID4798PS_753 + 0.666666686534881591796875f, EID4798PS_754), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4798PS_793, EID4798PS_793) * EID4798PS_743;
                EID4798PS_805 = float4(((EID4798PS_45.SampleLevel(EID4798_linear_clamp_sampler, float3(EID4798PS_752, EID4798PS_753 + 0.3333333432674407958984375f, EID4798PS_754), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4798PS_783, EID4798PS_783) * EID4798PS_743;
                EID4798PS_806 = float4(((EID4798PS_757.xyz * 4.0f) - 2.0f.xxx) * EID4798PS_773, EID4798PS_773) * EID4798PS_743;
            }
            else
            {
                EID4798PS_803 = EID4798PS_700;
                EID4798PS_804 = 0.0f.xxxx;
                EID4798PS_805 = 0.0f.xxxx;
                EID4798PS_806 = 0.0f.xxxx;
            }
            float3 EID4798PS_812 = EID4798PS_530 - (EID4798PS_20_m105.xyz + (EID4798PS_623 * (-EID4798PS_20_m107.z)));
            float EID4798PS_814 = abs(EID4798PS_812.x);
            float EID4798PS_816 = abs(EID4798PS_812.z);
            float EID4798PS_822 = clamp(((isnan(EID4798PS_816) ? EID4798PS_814 : (isnan(EID4798PS_814) ? EID4798PS_816 : max(EID4798PS_814, EID4798PS_816))) - 116.0f) * 0.125f, 0.0f, 1.0f);
            float EID4798PS_825 = clamp((abs(EID4798PS_812.y) - 52.0f) * 0.125f, 0.0f, 1.0f);
            float EID4798PS_826 = isnan(EID4798PS_825) ? EID4798PS_822 : (isnan(EID4798PS_822) ? EID4798PS_825 : max(EID4798PS_822, EID4798PS_825));
            float EID4798PS_906;
            float4 EID4798PS_907;
            float4 EID4798PS_908;
            float4 EID4798PS_909;
            if (EID4798PS_826 < 1.0f)
            {
                float3 EID4798PS_835 = ((EID4798PS_530 * 0.5f) + 0.5f.xxx) * EID4798PS_20_m106.xyz;
                float3 EID4798PS_837 = EID4798PS_835 - floor(EID4798PS_835);
                float4 EID4798PS_841 = EID4798PS_46.SampleLevel(EID4798_linear_repeat_sampler, EID4798PS_837, 0.0f);
                float EID4798PS_843 = EID4798PS_727 * (1.0f - EID4798PS_826);
                float EID4798PS_847 = EID4798PS_20_m106.y * 0.5f;
                float EID4798PS_852 = EID4798PS_837.x;
                float EID4798PS_853 = clamp(EID4798PS_837.y, EID4798PS_847, 1.0f - EID4798PS_847) * 0.3333333432674407958984375f;
                float EID4798PS_854 = EID4798PS_837.z;
                float4 EID4798PS_857 = EID4798PS_47.SampleLevel(EID4798_linear_clamp_sampler, float3(EID4798PS_852, EID4798PS_853, EID4798PS_854), 0.0f);
                float EID4798PS_873 = EID4798PS_841.x;
                float EID4798PS_884 = EID4798PS_841.y;
                float EID4798PS_895 = EID4798PS_841.z;
                EID4798PS_906 = EID4798PS_803 + (EID4798PS_857.w * EID4798PS_843);
                EID4798PS_907 = EID4798PS_804 + (float4(((EID4798PS_47.SampleLevel(EID4798_linear_clamp_sampler, float3(EID4798PS_852, EID4798PS_853 + 0.666666686534881591796875f, EID4798PS_854), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4798PS_895, EID4798PS_895) * EID4798PS_843);
                EID4798PS_908 = EID4798PS_805 + (float4(((EID4798PS_47.SampleLevel(EID4798_linear_clamp_sampler, float3(EID4798PS_852, EID4798PS_853 + 0.3333333432674407958984375f, EID4798PS_854), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4798PS_884, EID4798PS_884) * EID4798PS_843);
                EID4798PS_909 = EID4798PS_806 + (float4(((EID4798PS_857.xyz * 4.0f) - 2.0f.xxx) * EID4798PS_873, EID4798PS_873) * EID4798PS_843);
            }
            else
            {
                EID4798PS_906 = EID4798PS_803;
                EID4798PS_907 = EID4798PS_804;
                EID4798PS_908 = EID4798PS_805;
                EID4798PS_909 = EID4798PS_806;
            }
            float4 EID4798PS_992;
            float4 EID4798PS_993;
            float4 EID4798PS_994;
            float EID4798PS_995;
            if (EID4798PS_826 > 0.0f)
            {
                float3 EID4798PS_918 = ((EID4798PS_530 * 0.125f) + 0.5f.xxx) * EID4798PS_20_m106.xyz;
                float3 EID4798PS_921 = EID4798PS_20_m106.xyz * 0.5f;
                float3 EID4798PS_923 = clamp(EID4798PS_918 - floor(EID4798PS_918), EID4798PS_921, 1.0f.xxx - EID4798PS_921);
                float4 EID4798PS_927 = EID4798PS_48.SampleLevel(EID4798_linear_repeat_sampler, EID4798PS_923, 0.0f);
                float EID4798PS_929 = EID4798PS_826 * (1.0f - EID4798PS_700);
                float EID4798PS_933 = EID4798PS_20_m106.y * 0.5f;
                float EID4798PS_938 = EID4798PS_923.x;
                float EID4798PS_939 = clamp(EID4798PS_923.y, EID4798PS_933, 1.0f - EID4798PS_933) * 0.3333333432674407958984375f;
                float EID4798PS_940 = EID4798PS_923.z;
                float4 EID4798PS_943 = EID4798PS_49.SampleLevel(EID4798_linear_clamp_sampler, float3(EID4798PS_938, EID4798PS_939, EID4798PS_940), 0.0f);
                float EID4798PS_959 = EID4798PS_927.x;
                float EID4798PS_970 = EID4798PS_927.y;
                float EID4798PS_981 = EID4798PS_927.z;
                EID4798PS_992 = EID4798PS_907 + (float4(((EID4798PS_49.SampleLevel(EID4798_linear_clamp_sampler, float3(EID4798PS_938, EID4798PS_939 + 0.666666686534881591796875f, EID4798PS_940), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4798PS_981, EID4798PS_981) * EID4798PS_929);
                EID4798PS_993 = EID4798PS_908 + (float4(((EID4798PS_49.SampleLevel(EID4798_linear_clamp_sampler, float3(EID4798PS_938, EID4798PS_939 + 0.3333333432674407958984375f, EID4798PS_940), 0.0f).xyz * 4.0f) - 2.0f.xxx) * EID4798PS_970, EID4798PS_970) * EID4798PS_929);
                EID4798PS_994 = EID4798PS_909 + (float4(((EID4798PS_943.xyz * 4.0f) - 2.0f.xxx) * EID4798PS_959, EID4798PS_959) * EID4798PS_929);
                EID4798PS_995 = EID4798PS_906 + (EID4798PS_943.w * EID4798PS_929);
            }
            else
            {
                EID4798PS_992 = EID4798PS_907;
                EID4798PS_993 = EID4798PS_908;
                EID4798PS_994 = EID4798PS_909;
                EID4798PS_995 = EID4798PS_906;
            }
            float EID4798PS_998 = clamp((EID4798PS_995 * 2.0f) - 1.0f, 0.0f, 1.0f);
            EID4798PS_1002 = EID4798PS_992;
            EID4798PS_1003 = EID4798PS_993;
            EID4798PS_1004 = EID4798PS_994;
            EID4798PS_1005 = EID4798PS_998 - EID4798PS_700;
            EID4798PS_1006 = (EID4798PS_998 + EID4798PS_700) * 0.5f;
        }
        else
        {
            EID4798PS_1002 = 0.0f.xxxx;
            EID4798PS_1003 = 0.0f.xxxx;
            EID4798PS_1004 = 0.0f.xxxx;
            EID4798PS_1005 = 0.0f;
            EID4798PS_1006 = 1.0f;
        }
        float4 EID4798PS_1026 = EID4798PS_1004 + float4(EID4798PS_20_m108.x * EID4798PS_1006, (EID4798PS_20_m108.y * EID4798PS_1006) + ((EID4798PS_20_m108.w * EID4798PS_1005) * 0.5f), EID4798PS_20_m108.z * EID4798PS_1006, (EID4798PS_20_m108.w * EID4798PS_1006) + ((EID4798PS_20_m108.y * EID4798PS_1005) * 0.375f));
        float4 EID4798PS_1046 = EID4798PS_1003 + float4(EID4798PS_20_m109.x * EID4798PS_1006, (EID4798PS_20_m109.y * EID4798PS_1006) + ((EID4798PS_20_m109.w * EID4798PS_1005) * 0.5f), EID4798PS_20_m109.z * EID4798PS_1006, (EID4798PS_20_m109.w * EID4798PS_1006) + ((EID4798PS_20_m109.y * EID4798PS_1005) * 0.375f));
        float4 EID4798PS_1066 = EID4798PS_1002 + float4(EID4798PS_20_m110.x * EID4798PS_1006, (EID4798PS_20_m110.y * EID4798PS_1006) + ((EID4798PS_20_m110.w * EID4798PS_1005) * 0.5f), EID4798PS_20_m110.z * EID4798PS_1006, (EID4798PS_20_m110.w * EID4798PS_1006) + ((EID4798PS_20_m110.y * EID4798PS_1005) * 0.375f));
        float4 EID4798PS_1070 = float4(EID4798PS_557, 1.0f);
        float3 EID4798PS_1074 = float3(dot(EID4798PS_1026, EID4798PS_1070), dot(EID4798PS_1046, EID4798PS_1070), dot(EID4798PS_1066, EID4798PS_1070));
        bool3 EID4798PS_3983 = isnan(EID4798PS_1074);
        bool3 EID4798PS_3984 = isnan(0.0f.xxx);
        float3 EID4798PS_3985 = max(EID4798PS_1074, 0.0f.xxx);
        float3 EID4798PS_3986 = float3(EID4798PS_3983.x ? 0.0f.xxx.x : EID4798PS_3985.x, EID4798PS_3983.y ? 0.0f.xxx.y : EID4798PS_3985.y, EID4798PS_3983.z ? 0.0f.xxx.z : EID4798PS_3985.z);
        float3 EID4798PS_1076 = float3(EID4798PS_3984.x ? EID4798PS_1074.x : EID4798PS_3986.x, EID4798PS_3984.y ? EID4798PS_1074.y : EID4798PS_3986.y, EID4798PS_3984.z ? EID4798PS_1074.z : EID4798PS_3986.z) * EID4798PS_668;
        float3 EID4798PS_1084 = ((EID4798PS_1026.xyz * 0.2125999927520751953125f) + (EID4798PS_1046.xyz * 0.715200006961822509765625f)) + (EID4798PS_1066.xyz * 0.072200000286102294921875f);
        float EID4798PS_1085 = dot(EID4798PS_1084, EID4798PS_1084);
        float3 EID4798PS_1088 = EID4798PS_1084 * rsqrt(isnan(EID4798PS_1085) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? EID4798PS_1085 : max(1.1754943508222875079687365372222e-38f, EID4798PS_1085)));
        float EID4798PS_1090 = abs(EID4798PS_1088.y);
        float3 EID4798PS_1091 = EID4798PS_1088;
        EID4798PS_1091.y = EID4798PS_1090;
        float4 EID4798PS_1093 = float4(EID4798PS_1091.x, EID4798PS_1091.y, EID4798PS_1091.z, 0.0f.xxxx.w);
        EID4798PS_1093.w = 1.0f;
        float4 EID4798PS_1096 = float4(EID4798PS_1088.x, EID4798PS_1090, EID4798PS_1088.z, 1.0f);
        float3 EID4798PS_1100 = float3(dot(EID4798PS_1026, EID4798PS_1096), dot(EID4798PS_1046, EID4798PS_1096), dot(EID4798PS_1066, EID4798PS_1096));
        bool3 EID4798PS_3993 = isnan(EID4798PS_1100);
        bool3 EID4798PS_3994 = isnan(0.0f.xxx);
        float3 EID4798PS_3995 = max(EID4798PS_1100, 0.0f.xxx);
        float3 EID4798PS_3996 = float3(EID4798PS_3993.x ? 0.0f.xxx.x : EID4798PS_3995.x, EID4798PS_3993.y ? 0.0f.xxx.y : EID4798PS_3995.y, EID4798PS_3993.z ? 0.0f.xxx.z : EID4798PS_3995.z);
        float3 EID4798PS_1101 = float3(EID4798PS_3994.x ? EID4798PS_1100.x : EID4798PS_3996.x, EID4798PS_3994.y ? EID4798PS_1100.y : EID4798PS_3996.y, EID4798PS_3994.z ? EID4798PS_1100.z : EID4798PS_3996.z);
        float EID4798PS_1102 = EID4798PS_1101.x;
        float EID4798PS_1103 = EID4798PS_1101.y;
        float EID4798PS_1104 = EID4798PS_1101.z;
        float EID4798PS_1105 = isnan(EID4798PS_1103) ? EID4798PS_1102 : (isnan(EID4798PS_1102) ? EID4798PS_1103 : max(EID4798PS_1102, EID4798PS_1103));
        float EID4798PS_1106 = isnan(EID4798PS_1104) ? EID4798PS_1105 : (isnan(EID4798PS_1105) ? EID4798PS_1104 : max(EID4798PS_1105, EID4798PS_1104));
        float EID4798PS_1109 = EID4798PS_1076.z;
        float EID4798PS_1110 = EID4798PS_1076.y;
        float4 EID4798PS_1115 = lerp(float4(EID4798PS_1109, EID4798PS_1110, -1.0f, 0.666666686534881591796875f), float4(EID4798PS_1110, EID4798PS_1109, 0.0f, -0.3333333432674407958984375f), step(EID4798PS_1109, EID4798PS_1110).xxxx);
        float EID4798PS_1116 = EID4798PS_1076.x;
        float EID4798PS_1117 = EID4798PS_1115.x;
        float4 EID4798PS_1125 = lerp(float4(EID4798PS_1117, EID4798PS_1115.yw, EID4798PS_1116), float4(EID4798PS_1116, EID4798PS_1115.yz, EID4798PS_1117), step(EID4798PS_1117, EID4798PS_1116).xxxx);
        float EID4798PS_1126 = EID4798PS_1125.x;
        float EID4798PS_1127 = EID4798PS_1125.w;
        float EID4798PS_1128 = EID4798PS_1125.y;
        float EID4798PS_1130 = EID4798PS_1126 - (isnan(EID4798PS_1128) ? EID4798PS_1127 : (isnan(EID4798PS_1127) ? EID4798PS_1128 : min(EID4798PS_1127, EID4798PS_1128)));
        float EID4798PS_1139 = EID4798PS_1130 / (EID4798PS_1126 + 9.9999997473787516355514526367188e-05f);
        float EID4798PS_1140 = frac(abs(EID4798PS_1125.z + ((EID4798PS_1127 - EID4798PS_1128) / ((6.0f * EID4798PS_1130) + 9.9999997473787516355514526367188e-05f))));
        float EID4798PS_1146 = lerp(0.699999988079071044921875f, 0.3499999940395355224609375f, smoothstep(0.449999988079071044921875f, 0.3499999940395355224609375f, abs(EID4798PS_1140 - 0.5f))) * clamp(EID4798PS_1126, 0.0f, 1.0f);
        float EID4798PS_1147 = isnan(EID4798PS_1146) ? EID4798PS_1139 : (isnan(EID4798PS_1139) ? EID4798PS_1146 : min(EID4798PS_1139, EID4798PS_1146));
        float EID4798PS_1149 = 2.0f / (2.0f - EID4798PS_1147);
        EID4798PS_1162 = EID4798PS_1093;
        EID4798PS_1163 = EID4798PS_1076;
        EID4798PS_1164 = lerp(1.0f.xxx, clamp(abs((frac(float3(EID4798PS_1140, EID4798PS_1147, EID4798PS_1149).xxx + float3(1.0f, 0.666666686534881591796875f, 0.3333333432674407958984375f)) * 6.0f) - 3.0f.xxx) - 1.0f.xxx, 0.0f.xxx, 1.0f.xxx), EID4798PS_1147.xxx) * EID4798PS_1149;
        EID4798PS_1165 = (isnan(0.0f) ? EID4798PS_1106 : (isnan(EID4798PS_1106) ? 0.0f : max(EID4798PS_1106, 0.0f))) * EID4798PS_668;
    }
    else
    {
        EID4798PS_1162 = 0.0f.xxxx;
        EID4798PS_1163 = 1.0f.xxx;
        EID4798PS_1164 = EID4798PS_20_m81.xyz;
        EID4798PS_1165 = EID4798PS_668;
    }
    float3 EID4798PS_1972;
    float EID4798PS_1973;
    float EID4798PS_1974;
    float EID4798PS_1975;
    float EID4798PS_1976;
    float EID4798PS_1977;
    float3 EID4798PS_1978;
    float3 EID4798PS_1979;
    [branch]
    if ((clamp(EID4798PS_646 + EID4798PS_659, 0.0f, 1.0f) - EID4798PS_51_m20) > 0.00999999977648258209228515625f)
    {
        float EID4798PS_1322;
        bool EID4798PS_1323;
        bool EID4798PS_1192 = (step(EID4798PS_646, 0.00999999977648258209228515625f) * step(0.00999999977648258209228515625f, EID4798PS_659)) != 0.0f;
        bool3 EID4798PS_1193 = EID4798PS_432.xxx;
        float3 EID4798PS_1195 = EID4798PS_11.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 EID4798PS_1199 = float3(EID4798PS_1193.x ? EID4798PS_1195.x : EID4798PS_11.x, EID4798PS_1193.y ? EID4798PS_1195.y : EID4798PS_11.y, EID4798PS_1193.z ? EID4798PS_1195.z : EID4798PS_11.z) * EID4798PS_20_m89.z;
        float3 EID4798PS_1209 = float3(0.0f, -1.0f, 0.0f) + (EID4798PS_545 * EID4798PS_545.y);
        float3 EID4798PS_1217 = ((EID4798PS_10.xyz * dot(EID4798PS_1209, EID4798PS_543)) + ((cross(EID4798PS_9, EID4798PS_10.xyz) * EID4798PS_10.w) * dot(EID4798PS_1209, EID4798PS_544))) + (EID4798PS_9 * dot(EID4798PS_1209, EID4798PS_545));
        float3 EID4798PS_1219 = EID4798PS_1217.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 EID4798PS_1220 = float3(EID4798PS_1193.x ? EID4798PS_1219.x : EID4798PS_1217.x, EID4798PS_1193.y ? EID4798PS_1219.y : EID4798PS_1217.y, EID4798PS_1193.z ? EID4798PS_1219.z : EID4798PS_1217.z);
        bool EID4798PS_1221 = !EID4798PS_1192;
        bool2 EID4798PS_1222 = EID4798PS_1221.xx;
        float2 EID4798PS_1224 = (1.0f - EID4798PS_659).xx;
        float2 EID4798PS_1225 = float2(EID4798PS_1222.x ? float2(3.0f, 4.340000152587890625f).x : EID4798PS_1224.x, EID4798PS_1222.y ? float2(3.0f, 4.340000152587890625f).y : EID4798PS_1224.y);
        float EID4798PS_1228 = 1.0f - ((EID4798PS_1192 ? EID4798PS_659 : EID4798PS_646) * 0.64999997615814208984375f);
        float3 EID4798PS_1236 = frac(floor(((EID4798PS_3.xx * EID4798PS_20_m89.z) * 32.0f) * 1.5f).xyx * 0.103100001811981201171875f);
        float3 EID4798PS_1241 = EID4798PS_1236 + dot(EID4798PS_1236, EID4798PS_1236.yzx + 33.3300018310546875f.xxx).xxx;
        float EID4798PS_1258 = lerp(0.60000002384185791015625f, 1.0f, clamp((1.2000000476837158203125f * frac((EID4798PS_1199.y * (-3.0f)) + frac((EID4798PS_1241.x + EID4798PS_1241.y) * EID4798PS_1241.z))) + clamp(EID4798PS_1199.z * 10.0f, 0.0f, 1.0f), 0.0f, 1.0f));
        float EID4798PS_1259 = 1.0f - EID4798PS_660;
        float EID4798PS_1261 = EID4798PS_1259 + (0.800000011920928955078125f * EID4798PS_660);
        float EID4798PS_1264 = EID4798PS_1221 ? EID4798PS_20_m10.x : 1.0f;
        float EID4798PS_1266 = EID4798PS_1264 * EID4798PS_1225.x;
        float EID4798PS_1268 = EID4798PS_1264 * EID4798PS_1225.y;
        float3 EID4798PS_1269 = EID4798PS_1199 * 32.0f;
        float3 EID4798PS_1270 = EID4798PS_1199 * 48.345600128173828125f;
        float3 EID4798PS_1272 = abs(float3(EID4798PS_1193.x ? EID4798PS_9.xzy.x : EID4798PS_9.x, EID4798PS_1193.y ? EID4798PS_9.xzy.y : EID4798PS_9.y, EID4798PS_1193.z ? EID4798PS_9.xzy.z : EID4798PS_9.z)) - 0.20000000298023223876953125f.xxx;
        bool3 EID4798PS_4023 = isnan(EID4798PS_1272);
        bool3 EID4798PS_4024 = isnan(0.0f.xxx);
        float3 EID4798PS_4025 = max(EID4798PS_1272, 0.0f.xxx);
        float3 EID4798PS_4026 = float3(EID4798PS_4023.x ? 0.0f.xxx.x : EID4798PS_4025.x, EID4798PS_4023.y ? 0.0f.xxx.y : EID4798PS_4025.y, EID4798PS_4023.z ? 0.0f.xxx.z : EID4798PS_4025.z);
        float3 EID4798PS_1274 = pow(float3(EID4798PS_4024.x ? EID4798PS_1272.x : EID4798PS_4026.x, EID4798PS_4024.y ? EID4798PS_1272.y : EID4798PS_4026.y, EID4798PS_4024.z ? EID4798PS_1272.z : EID4798PS_4026.z), 10.0f.xxx);
        float EID4798PS_1275 = dot(EID4798PS_1274, 1.0f.xxx);
        float3 EID4798PS_1278 = EID4798PS_1274 / (isnan(6.103515625e-05f) ? EID4798PS_1275 : (isnan(EID4798PS_1275) ? 6.103515625e-05f : max(EID4798PS_1275, 6.103515625e-05f))).xxx;
        float2 EID4798PS_1280 = EID4798PS_1220.xz;
        float EID4798PS_1281 = EID4798PS_1278.y;
        float2 EID4798PS_1282 = EID4798PS_1269.xz * 1.0f;
        float2 EID4798PS_1283 = floor(EID4798PS_1282);
        float2 EID4798PS_1286 = frac(EID4798PS_1283 * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4798PS_1290 = EID4798PS_1286 + dot(EID4798PS_1286, EID4798PS_1286 + 34.345001220703125f.xx).xx;
        float EID4798PS_1291 = EID4798PS_1290.x;
        float EID4798PS_1292 = EID4798PS_1290.y;
        float2 EID4798PS_1296 = frac(float2(EID4798PS_1291 * EID4798PS_1292, EID4798PS_1291 + EID4798PS_1292));
        float2 EID4798PS_1299 = frac((EID4798PS_1283 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4798PS_1303 = EID4798PS_1299 + dot(EID4798PS_1299, EID4798PS_1299 + 34.345001220703125f.xx).xx;
        float EID4798PS_1304 = EID4798PS_1303.x;
        float EID4798PS_1305 = EID4798PS_1303.y;
        float2 EID4798PS_1309 = frac(float2(EID4798PS_1304 * EID4798PS_1305, EID4798PS_1304 + EID4798PS_1305));
        float EID4798PS_1315 = EID4798PS_1296.x;
        float EID4798PS_1318 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, EID4798PS_1315)) * EID4798PS_1258;
        float2 EID4798PS_1319 = ((EID4798PS_1282 - EID4798PS_1283) + ((((EID4798PS_1309 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 EID4798PS_1336;
        do
        {
            EID4798PS_1322 = dot(EID4798PS_1280, EID4798PS_1280);
            EID4798PS_1323 = EID4798PS_1322 <= 9.9999997473787516355514526367188e-06f;
            if (EID4798PS_1323)
            {
                EID4798PS_1336 = EID4798PS_1319;
                break;
            }
            float2 EID4798PS_1327 = EID4798PS_1280 * rsqrt(EID4798PS_1322);
            EID4798PS_1336 = float2(dot(EID4798PS_1319, float2(-EID4798PS_1327.y, EID4798PS_1327.x)), -dot(EID4798PS_1319, EID4798PS_1327));
            break;
        } while(false);
        float EID4798PS_1419;
        bool EID4798PS_1420;
        float2 EID4798PS_1343 = float2(EID4798PS_1336.x * 1.25f, EID4798PS_1336.y * ((EID4798PS_1336.y < 0.0f) ? 1.25f : 0.75f));
        float EID4798PS_1344 = length(EID4798PS_1343);
        float EID4798PS_1346 = EID4798PS_1266 + EID4798PS_1315;
        float EID4798PS_1350 = EID4798PS_1221 ? frac(EID4798PS_1346) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(EID4798PS_1346, 0.0f, 1.0f));
        float EID4798PS_1362 = EID4798PS_1296.y;
        float EID4798PS_1365 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, EID4798PS_1350) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, EID4798PS_1350)) * step(0.001000000047497451305389404296875f, smoothstep(EID4798PS_1318, 0.0f, EID4798PS_1344))) * step(EID4798PS_1228, EID4798PS_1362 - 0.100000001490116119384765625f);
        float EID4798PS_1368 = EID4798PS_1365 * EID4798PS_1281;
        float2 EID4798PS_1375 = float2(EID4798PS_1318 * EID4798PS_1365, EID4798PS_1318 - EID4798PS_1344) * EID4798PS_1281;
        float2 EID4798PS_1377 = EID4798PS_1220.xy;
        float EID4798PS_1378 = EID4798PS_1278.z;
        float2 EID4798PS_1379 = EID4798PS_1269.xy * 1.0f;
        float2 EID4798PS_1380 = floor(EID4798PS_1379);
        float2 EID4798PS_1383 = frac(EID4798PS_1380 * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4798PS_1387 = EID4798PS_1383 + dot(EID4798PS_1383, EID4798PS_1383 + 34.345001220703125f.xx).xx;
        float EID4798PS_1388 = EID4798PS_1387.x;
        float EID4798PS_1389 = EID4798PS_1387.y;
        float2 EID4798PS_1393 = frac(float2(EID4798PS_1388 * EID4798PS_1389, EID4798PS_1388 + EID4798PS_1389));
        float2 EID4798PS_1396 = frac((EID4798PS_1380 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4798PS_1400 = EID4798PS_1396 + dot(EID4798PS_1396, EID4798PS_1396 + 34.345001220703125f.xx).xx;
        float EID4798PS_1401 = EID4798PS_1400.x;
        float EID4798PS_1402 = EID4798PS_1400.y;
        float2 EID4798PS_1406 = frac(float2(EID4798PS_1401 * EID4798PS_1402, EID4798PS_1401 + EID4798PS_1402));
        float EID4798PS_1412 = EID4798PS_1393.x;
        float EID4798PS_1415 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, EID4798PS_1412)) * EID4798PS_1258;
        float2 EID4798PS_1416 = ((EID4798PS_1379 - EID4798PS_1380) + ((((EID4798PS_1406 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 EID4798PS_1433;
        do
        {
            EID4798PS_1419 = dot(EID4798PS_1377, EID4798PS_1377);
            EID4798PS_1420 = EID4798PS_1419 <= 9.9999997473787516355514526367188e-06f;
            if (EID4798PS_1420)
            {
                EID4798PS_1433 = EID4798PS_1416;
                break;
            }
            float2 EID4798PS_1424 = EID4798PS_1377 * rsqrt(EID4798PS_1419);
            EID4798PS_1433 = float2(dot(EID4798PS_1416, float2(-EID4798PS_1424.y, EID4798PS_1424.x)), -dot(EID4798PS_1416, EID4798PS_1424));
            break;
        } while(false);
        float EID4798PS_1516;
        bool EID4798PS_1517;
        float2 EID4798PS_1440 = float2(EID4798PS_1433.x * 1.25f, EID4798PS_1433.y * ((EID4798PS_1433.y < 0.0f) ? 1.25f : 0.75f));
        float EID4798PS_1441 = length(EID4798PS_1440);
        float EID4798PS_1443 = EID4798PS_1266 + EID4798PS_1412;
        float EID4798PS_1447 = EID4798PS_1221 ? frac(EID4798PS_1443) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(EID4798PS_1443, 0.0f, 1.0f));
        float EID4798PS_1459 = EID4798PS_1393.y;
        float EID4798PS_1462 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, EID4798PS_1447) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, EID4798PS_1447)) * step(0.001000000047497451305389404296875f, smoothstep(EID4798PS_1415, 0.0f, EID4798PS_1441))) * step(EID4798PS_1228, EID4798PS_1459 - 0.100000001490116119384765625f);
        float EID4798PS_1465 = EID4798PS_1462 * EID4798PS_1378;
        float2 EID4798PS_1472 = float2(EID4798PS_1415 * EID4798PS_1462, EID4798PS_1415 - EID4798PS_1441) * EID4798PS_1378;
        float2 EID4798PS_1474 = EID4798PS_1220.zy;
        float EID4798PS_1475 = EID4798PS_1278.x;
        float2 EID4798PS_1476 = EID4798PS_1269.zy * 1.0f;
        float2 EID4798PS_1477 = floor(EID4798PS_1476);
        float2 EID4798PS_1480 = frac(EID4798PS_1477 * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4798PS_1484 = EID4798PS_1480 + dot(EID4798PS_1480, EID4798PS_1480 + 34.345001220703125f.xx).xx;
        float EID4798PS_1485 = EID4798PS_1484.x;
        float EID4798PS_1486 = EID4798PS_1484.y;
        float2 EID4798PS_1490 = frac(float2(EID4798PS_1485 * EID4798PS_1486, EID4798PS_1485 + EID4798PS_1486));
        float2 EID4798PS_1493 = frac((EID4798PS_1477 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4798PS_1497 = EID4798PS_1493 + dot(EID4798PS_1493, EID4798PS_1493 + 34.345001220703125f.xx).xx;
        float EID4798PS_1498 = EID4798PS_1497.x;
        float EID4798PS_1499 = EID4798PS_1497.y;
        float2 EID4798PS_1503 = frac(float2(EID4798PS_1498 * EID4798PS_1499, EID4798PS_1498 + EID4798PS_1499));
        float EID4798PS_1509 = EID4798PS_1490.x;
        float EID4798PS_1512 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, EID4798PS_1509)) * EID4798PS_1258;
        float2 EID4798PS_1513 = ((EID4798PS_1476 - EID4798PS_1477) + ((((EID4798PS_1503 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 EID4798PS_1530;
        do
        {
            EID4798PS_1516 = dot(EID4798PS_1474, EID4798PS_1474);
            EID4798PS_1517 = EID4798PS_1516 <= 9.9999997473787516355514526367188e-06f;
            if (EID4798PS_1517)
            {
                EID4798PS_1530 = EID4798PS_1513;
                break;
            }
            float2 EID4798PS_1521 = EID4798PS_1474 * rsqrt(EID4798PS_1516);
            EID4798PS_1530 = float2(dot(EID4798PS_1513, float2(-EID4798PS_1521.y, EID4798PS_1521.x)), -dot(EID4798PS_1513, EID4798PS_1521));
            break;
        } while(false);
        float2 EID4798PS_1537 = float2(EID4798PS_1530.x * 1.25f, EID4798PS_1530.y * ((EID4798PS_1530.y < 0.0f) ? 1.25f : 0.75f));
        float EID4798PS_1538 = length(EID4798PS_1537);
        float EID4798PS_1540 = EID4798PS_1266 + EID4798PS_1509;
        float EID4798PS_1544 = EID4798PS_1221 ? frac(EID4798PS_1540) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(EID4798PS_1540, 0.0f, 1.0f));
        float EID4798PS_1556 = EID4798PS_1490.y;
        float EID4798PS_1559 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, EID4798PS_1544) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, EID4798PS_1544)) * step(0.001000000047497451305389404296875f, smoothstep(EID4798PS_1512, 0.0f, EID4798PS_1538))) * step(EID4798PS_1228, EID4798PS_1556 - 0.100000001490116119384765625f);
        float EID4798PS_1562 = EID4798PS_1559 * EID4798PS_1475;
        float2 EID4798PS_1569 = float2(EID4798PS_1512 * EID4798PS_1559, EID4798PS_1512 - EID4798PS_1538) * EID4798PS_1475;
        bool2 EID4798PS_4033 = isnan(EID4798PS_1472);
        bool2 EID4798PS_4034 = isnan(EID4798PS_1569);
        float2 EID4798PS_4035 = max(EID4798PS_1472, EID4798PS_1569);
        float2 EID4798PS_4036 = float2(EID4798PS_4033.x ? EID4798PS_1569.x : EID4798PS_4035.x, EID4798PS_4033.y ? EID4798PS_1569.y : EID4798PS_4035.y);
        float2 EID4798PS_1570 = float2(EID4798PS_4034.x ? EID4798PS_1472.x : EID4798PS_4036.x, EID4798PS_4034.y ? EID4798PS_1472.y : EID4798PS_4036.y);
        bool2 EID4798PS_4038 = isnan(EID4798PS_1375);
        bool2 EID4798PS_4039 = isnan(EID4798PS_1570);
        float2 EID4798PS_4040 = max(EID4798PS_1375, EID4798PS_1570);
        float2 EID4798PS_4041 = float2(EID4798PS_4038.x ? EID4798PS_1570.x : EID4798PS_4040.x, EID4798PS_4038.y ? EID4798PS_1570.y : EID4798PS_4040.y);
        float2 EID4798PS_1571 = float2(EID4798PS_4039.x ? EID4798PS_1375.x : EID4798PS_4041.x, EID4798PS_4039.y ? EID4798PS_1375.y : EID4798PS_4041.y);
        float EID4798PS_1577 = isnan(EID4798PS_1465) ? EID4798PS_1368 : (isnan(EID4798PS_1368) ? EID4798PS_1465 : max(EID4798PS_1368, EID4798PS_1465));
        float EID4798PS_1578 = isnan(EID4798PS_1577) ? EID4798PS_1562 : (isnan(EID4798PS_1562) ? EID4798PS_1577 : max(EID4798PS_1562, EID4798PS_1577));
        float4 EID4798PS_1581 = float4((float4(((clamp(EID4798PS_1343 / EID4798PS_1318.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, EID4798PS_1309.x)) * EID4798PS_1365) * EID4798PS_1281, EID4798PS_1368, EID4798PS_1362).xy + float4(((clamp(EID4798PS_1440 / EID4798PS_1415.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, EID4798PS_1406.x)) * EID4798PS_1462) * EID4798PS_1378, EID4798PS_1465, EID4798PS_1459).xy) + float4(((clamp(EID4798PS_1537 / EID4798PS_1512.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, EID4798PS_1503.x)) * EID4798PS_1559) * EID4798PS_1475, EID4798PS_1562, EID4798PS_1556).xy, EID4798PS_1578, 0.0f);
        float2 EID4798PS_1583 = EID4798PS_1270.xz * 1.0f;
        float2 EID4798PS_1584 = floor(EID4798PS_1583);
        float2 EID4798PS_1587 = frac(EID4798PS_1584 * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4798PS_1591 = EID4798PS_1587 + dot(EID4798PS_1587, EID4798PS_1587 + 34.345001220703125f.xx).xx;
        float EID4798PS_1592 = EID4798PS_1591.x;
        float EID4798PS_1593 = EID4798PS_1591.y;
        float2 EID4798PS_1597 = frac(float2(EID4798PS_1592 * EID4798PS_1593, EID4798PS_1592 + EID4798PS_1593));
        float2 EID4798PS_1600 = frac((EID4798PS_1584 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4798PS_1604 = EID4798PS_1600 + dot(EID4798PS_1600, EID4798PS_1600 + 34.345001220703125f.xx).xx;
        float EID4798PS_1605 = EID4798PS_1604.x;
        float EID4798PS_1606 = EID4798PS_1604.y;
        float2 EID4798PS_1610 = frac(float2(EID4798PS_1605 * EID4798PS_1606, EID4798PS_1605 + EID4798PS_1606));
        float EID4798PS_1616 = EID4798PS_1597.x;
        float EID4798PS_1619 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, EID4798PS_1616)) * EID4798PS_1258;
        float2 EID4798PS_1620 = ((EID4798PS_1583 - EID4798PS_1584) + ((((EID4798PS_1610 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 EID4798PS_1635;
        do
        {
            if (EID4798PS_1323)
            {
                EID4798PS_1635 = EID4798PS_1620;
                break;
            }
            float2 EID4798PS_1626 = EID4798PS_1280 * rsqrt(EID4798PS_1322);
            EID4798PS_1635 = float2(dot(EID4798PS_1620, float2(-EID4798PS_1626.y, EID4798PS_1626.x)), -dot(EID4798PS_1620, EID4798PS_1626));
            break;
        } while(false);
        float2 EID4798PS_1642 = float2(EID4798PS_1635.x * 1.25f, EID4798PS_1635.y * ((EID4798PS_1635.y < 0.0f) ? 1.25f : 0.75f));
        float EID4798PS_1643 = length(EID4798PS_1642);
        float EID4798PS_1645 = EID4798PS_1268 + EID4798PS_1616;
        float EID4798PS_1649 = EID4798PS_1221 ? frac(EID4798PS_1645) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(EID4798PS_1645, 0.0f, 1.0f));
        float EID4798PS_1661 = EID4798PS_1597.y;
        float EID4798PS_1664 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, EID4798PS_1649) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, EID4798PS_1649)) * step(0.001000000047497451305389404296875f, smoothstep(EID4798PS_1619, 0.0f, EID4798PS_1643))) * step(EID4798PS_1228, EID4798PS_1661 - 0.100000001490116119384765625f);
        float EID4798PS_1667 = EID4798PS_1664 * EID4798PS_1281;
        float2 EID4798PS_1674 = float2(EID4798PS_1619 * EID4798PS_1664, EID4798PS_1619 - EID4798PS_1643) * EID4798PS_1281;
        float2 EID4798PS_1676 = EID4798PS_1270.xy * 1.0f;
        float2 EID4798PS_1677 = floor(EID4798PS_1676);
        float2 EID4798PS_1680 = frac(EID4798PS_1677 * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4798PS_1684 = EID4798PS_1680 + dot(EID4798PS_1680, EID4798PS_1680 + 34.345001220703125f.xx).xx;
        float EID4798PS_1685 = EID4798PS_1684.x;
        float EID4798PS_1686 = EID4798PS_1684.y;
        float2 EID4798PS_1690 = frac(float2(EID4798PS_1685 * EID4798PS_1686, EID4798PS_1685 + EID4798PS_1686));
        float2 EID4798PS_1693 = frac((EID4798PS_1677 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4798PS_1697 = EID4798PS_1693 + dot(EID4798PS_1693, EID4798PS_1693 + 34.345001220703125f.xx).xx;
        float EID4798PS_1698 = EID4798PS_1697.x;
        float EID4798PS_1699 = EID4798PS_1697.y;
        float2 EID4798PS_1703 = frac(float2(EID4798PS_1698 * EID4798PS_1699, EID4798PS_1698 + EID4798PS_1699));
        float EID4798PS_1709 = EID4798PS_1690.x;
        float EID4798PS_1712 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, EID4798PS_1709)) * EID4798PS_1258;
        float2 EID4798PS_1713 = ((EID4798PS_1676 - EID4798PS_1677) + ((((EID4798PS_1703 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 EID4798PS_1728;
        do
        {
            if (EID4798PS_1420)
            {
                EID4798PS_1728 = EID4798PS_1713;
                break;
            }
            float2 EID4798PS_1719 = EID4798PS_1377 * rsqrt(EID4798PS_1419);
            EID4798PS_1728 = float2(dot(EID4798PS_1713, float2(-EID4798PS_1719.y, EID4798PS_1719.x)), -dot(EID4798PS_1713, EID4798PS_1719));
            break;
        } while(false);
        float2 EID4798PS_1735 = float2(EID4798PS_1728.x * 1.25f, EID4798PS_1728.y * ((EID4798PS_1728.y < 0.0f) ? 1.25f : 0.75f));
        float EID4798PS_1736 = length(EID4798PS_1735);
        float EID4798PS_1738 = EID4798PS_1268 + EID4798PS_1709;
        float EID4798PS_1742 = EID4798PS_1221 ? frac(EID4798PS_1738) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(EID4798PS_1738, 0.0f, 1.0f));
        float EID4798PS_1754 = EID4798PS_1690.y;
        float EID4798PS_1757 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, EID4798PS_1742) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, EID4798PS_1742)) * step(0.001000000047497451305389404296875f, smoothstep(EID4798PS_1712, 0.0f, EID4798PS_1736))) * step(EID4798PS_1228, EID4798PS_1754 - 0.100000001490116119384765625f);
        float EID4798PS_1760 = EID4798PS_1757 * EID4798PS_1378;
        float2 EID4798PS_1767 = float2(EID4798PS_1712 * EID4798PS_1757, EID4798PS_1712 - EID4798PS_1736) * EID4798PS_1378;
        float2 EID4798PS_1769 = EID4798PS_1270.zy * 1.0f;
        float2 EID4798PS_1770 = floor(EID4798PS_1769);
        float2 EID4798PS_1773 = frac(EID4798PS_1770 * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4798PS_1777 = EID4798PS_1773 + dot(EID4798PS_1773, EID4798PS_1773 + 34.345001220703125f.xx).xx;
        float EID4798PS_1778 = EID4798PS_1777.x;
        float EID4798PS_1779 = EID4798PS_1777.y;
        float2 EID4798PS_1783 = frac(float2(EID4798PS_1778 * EID4798PS_1779, EID4798PS_1778 + EID4798PS_1779));
        float2 EID4798PS_1786 = frac((EID4798PS_1770 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 EID4798PS_1790 = EID4798PS_1786 + dot(EID4798PS_1786, EID4798PS_1786 + 34.345001220703125f.xx).xx;
        float EID4798PS_1791 = EID4798PS_1790.x;
        float EID4798PS_1792 = EID4798PS_1790.y;
        float2 EID4798PS_1796 = frac(float2(EID4798PS_1791 * EID4798PS_1792, EID4798PS_1791 + EID4798PS_1792));
        float EID4798PS_1802 = EID4798PS_1783.x;
        float EID4798PS_1805 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, EID4798PS_1802)) * EID4798PS_1258;
        float2 EID4798PS_1806 = ((EID4798PS_1769 - EID4798PS_1770) + ((((EID4798PS_1796 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 EID4798PS_1821;
        do
        {
            if (EID4798PS_1517)
            {
                EID4798PS_1821 = EID4798PS_1806;
                break;
            }
            float2 EID4798PS_1812 = EID4798PS_1474 * rsqrt(EID4798PS_1516);
            EID4798PS_1821 = float2(dot(EID4798PS_1806, float2(-EID4798PS_1812.y, EID4798PS_1812.x)), -dot(EID4798PS_1806, EID4798PS_1812));
            break;
        } while(false);
        float2 EID4798PS_1828 = float2(EID4798PS_1821.x * 1.25f, EID4798PS_1821.y * ((EID4798PS_1821.y < 0.0f) ? 1.25f : 0.75f));
        float EID4798PS_1829 = length(EID4798PS_1828);
        float EID4798PS_1831 = EID4798PS_1268 + EID4798PS_1802;
        float EID4798PS_1835 = EID4798PS_1221 ? frac(EID4798PS_1831) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(EID4798PS_1831, 0.0f, 1.0f));
        float EID4798PS_1847 = EID4798PS_1783.y;
        float EID4798PS_1850 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, EID4798PS_1835) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, EID4798PS_1835)) * step(0.001000000047497451305389404296875f, smoothstep(EID4798PS_1805, 0.0f, EID4798PS_1829))) * step(EID4798PS_1228, EID4798PS_1847 - 0.100000001490116119384765625f);
        float EID4798PS_1853 = EID4798PS_1850 * EID4798PS_1475;
        float2 EID4798PS_1860 = float2(EID4798PS_1805 * EID4798PS_1850, EID4798PS_1805 - EID4798PS_1829) * EID4798PS_1475;
        bool2 EID4798PS_4053 = isnan(EID4798PS_1767);
        bool2 EID4798PS_4054 = isnan(EID4798PS_1860);
        float2 EID4798PS_4055 = max(EID4798PS_1767, EID4798PS_1860);
        float2 EID4798PS_4056 = float2(EID4798PS_4053.x ? EID4798PS_1860.x : EID4798PS_4055.x, EID4798PS_4053.y ? EID4798PS_1860.y : EID4798PS_4055.y);
        float2 EID4798PS_1861 = float2(EID4798PS_4054.x ? EID4798PS_1767.x : EID4798PS_4056.x, EID4798PS_4054.y ? EID4798PS_1767.y : EID4798PS_4056.y);
        bool2 EID4798PS_4058 = isnan(EID4798PS_1674);
        bool2 EID4798PS_4059 = isnan(EID4798PS_1861);
        float2 EID4798PS_4060 = max(EID4798PS_1674, EID4798PS_1861);
        float2 EID4798PS_4061 = float2(EID4798PS_4058.x ? EID4798PS_1861.x : EID4798PS_4060.x, EID4798PS_4058.y ? EID4798PS_1861.y : EID4798PS_4060.y);
        float EID4798PS_1868 = isnan(EID4798PS_1760) ? EID4798PS_1667 : (isnan(EID4798PS_1667) ? EID4798PS_1760 : max(EID4798PS_1667, EID4798PS_1760));
        float4 EID4798PS_1872 = float4((float4(((clamp(EID4798PS_1642 / EID4798PS_1619.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, EID4798PS_1610.x)) * EID4798PS_1664) * EID4798PS_1281, EID4798PS_1667, EID4798PS_1661).xy + float4(((clamp(EID4798PS_1735 / EID4798PS_1712.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, EID4798PS_1703.x)) * EID4798PS_1757) * EID4798PS_1378, EID4798PS_1760, EID4798PS_1754).xy) + float4(((clamp(EID4798PS_1828 / EID4798PS_1805.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, EID4798PS_1796.x)) * EID4798PS_1850) * EID4798PS_1475, EID4798PS_1853, EID4798PS_1847).xy, isnan(EID4798PS_1868) ? EID4798PS_1853 : (isnan(EID4798PS_1853) ? EID4798PS_1868 : max(EID4798PS_1853, EID4798PS_1868)), 0.0f);
        float EID4798PS_1874 = step(EID4798PS_1571.x, 0.00999999977648258209228515625f);
        float2 EID4798PS_1881 = EID4798PS_1581.zw * step(0.00999999977648258209228515625f, EID4798PS_1578);
        float2 EID4798PS_1883 = EID4798PS_1872.zw * EID4798PS_1874;
        bool2 EID4798PS_4073 = isnan(EID4798PS_1881);
        bool2 EID4798PS_4074 = isnan(EID4798PS_1883);
        float2 EID4798PS_4075 = max(EID4798PS_1881, EID4798PS_1883);
        float2 EID4798PS_4076 = float2(EID4798PS_4073.x ? EID4798PS_1883.x : EID4798PS_4075.x, EID4798PS_4073.y ? EID4798PS_1883.y : EID4798PS_4075.y);
        float2 EID4798PS_1886 = (float2(EID4798PS_4059.x ? EID4798PS_1674.x : EID4798PS_4061.x, EID4798PS_4059.y ? EID4798PS_1674.y : EID4798PS_4061.y) * float2(0.661900997161865234375f, 1.0f)) * EID4798PS_1874;
        bool2 EID4798PS_4078 = isnan(EID4798PS_1571);
        bool2 EID4798PS_4079 = isnan(EID4798PS_1886);
        float2 EID4798PS_4080 = max(EID4798PS_1571, EID4798PS_1886);
        float2 EID4798PS_4081 = float2(EID4798PS_4078.x ? EID4798PS_1886.x : EID4798PS_4080.x, EID4798PS_4078.y ? EID4798PS_1886.y : EID4798PS_4080.y);
        float2 EID4798PS_1887 = float2(EID4798PS_4079.x ? EID4798PS_1571.x : EID4798PS_4081.x, EID4798PS_4079.y ? EID4798PS_1571.y : EID4798PS_4081.y);
        float EID4798PS_1892 = clamp(dot(EID4798PS_423, EID4798PS_557), 0.0f, 1.0f);
        float EID4798PS_1901 = float2(EID4798PS_4074.x ? EID4798PS_1881.x : EID4798PS_4076.x, EID4798PS_4074.y ? EID4798PS_1881.y : EID4798PS_4076.y).x * (EID4798PS_1892 * lerp(0.4000000059604644775390625f, 1.0f, smoothstep(0.0f, 4.0f, abs(EID4798PS_18_m2[1].y) / EID4798PS_424)));
        float2 EID4798PS_1902 = (EID4798PS_1581.xy + (EID4798PS_1872.xy * EID4798PS_1874)).xy;
        float EID4798PS_1907 = sqrt(1.0f - clamp(dot(EID4798PS_1902, EID4798PS_1902), 0.0f, 1.0f));
        float3 EID4798PS_1913 = normalize(float3(EID4798PS_1902 * (2.5f * EID4798PS_1892), isnan(EID4798PS_1907) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? EID4798PS_1907 : max(1.000000016862383526387164645044e-16f, EID4798PS_1907))));
        float2 EID4798PS_1915 = EID4798PS_1913.xy;
        float EID4798PS_1919 = sqrt(1.0f - clamp(dot(EID4798PS_1915, EID4798PS_1915), 0.0f, 1.0f));
        float3 EID4798PS_1921 = float3(EID4798PS_1913.x, EID4798PS_1913.y, 0.0f.xxx.z);
        EID4798PS_1921.z = isnan(EID4798PS_1919) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? EID4798PS_1919 : max(1.000000016862383526387164645044e-16f, EID4798PS_1919));
        float3 EID4798PS_1922 = normalize(EID4798PS_1921);
        float3 EID4798PS_1923 = cross(EID4798PS_557, float3(0.0f, 1.0f, 0.0f));
        bool3 EID4798PS_1926 = (dot(EID4798PS_1923, EID4798PS_1923) > 6.103515625e-05f).xxx;
        float3 EID4798PS_1927 = normalize(EID4798PS_1923);
        float3 EID4798PS_1928 = float3(EID4798PS_1926.x ? EID4798PS_1927.x : float3(1.0f, 0.0f, 0.0f).x, EID4798PS_1926.y ? EID4798PS_1927.y : float3(1.0f, 0.0f, 0.0f).y, EID4798PS_1926.z ? EID4798PS_1927.z : float3(1.0f, 0.0f, 0.0f).z);
        float EID4798PS_1932 = EID4798PS_1922.y;
        float EID4798PS_1939 = EID4798PS_1887.x * 4.0f;
        float EID4798PS_1949 = clamp(dot(EID4798PS_1922, normalize(float3(0.0f, -1.0f, 0.75f))), 0.0f, 1.0f);
        float EID4798PS_1955 = (0.60000002384185791015625f * EID4798PS_1901) * EID4798PS_1939;
        float EID4798PS_1958 = (1.0f - EID4798PS_1955) + (clamp(clamp(clamp(EID4798PS_1887.y * 17.54000091552734375f, 0.0f, 1.0f), 0.0f, 1.0f) + clamp(1.60000002384185791015625f * EID4798PS_1932, 0.0f, 1.0f), 0.0f, 1.0f) * EID4798PS_1955);
        float EID4798PS_1961 = smoothstep(0.60000002384185791015625f, 1.0f, EID4798PS_1958);
        float EID4798PS_1964 = EID4798PS_1901 * EID4798PS_1939;
        EID4798PS_1972 = normalize(((EID4798PS_1928 * EID4798PS_1922.x) + (cross(EID4798PS_1928, EID4798PS_557) * EID4798PS_1932)) + (EID4798PS_557 * EID4798PS_1922.z));
        EID4798PS_1973 = EID4798PS_1259 + (2.0f * EID4798PS_660);
        EID4798PS_1974 = EID4798PS_1964;
        EID4798PS_1975 = ((lerp(0.0500000007450580596923828125f, 1.7999999523162841796875f, (EID4798PS_1949 * EID4798PS_1949) * EID4798PS_1949) * EID4798PS_1939) * EID4798PS_1961) * EID4798PS_1901;
        EID4798PS_1976 = lerp(1.0f, 0.800000011920928955078125f * lerp(0.5f, 1.0f, EID4798PS_1961), EID4798PS_1901);
        EID4798PS_1977 = EID4798PS_1964;
        EID4798PS_1978 = (EID4798PS_495 * EID4798PS_1958) * EID4798PS_1261;
        EID4798PS_1979 = (EID4798PS_462 * EID4798PS_1958) * EID4798PS_1261;
    }
    else
    {
        EID4798PS_1972 = EID4798PS_557;
        EID4798PS_1973 = 1.0f;
        EID4798PS_1974 = 0.0f;
        EID4798PS_1975 = 0.0f;
        EID4798PS_1976 = 1.0f;
        EID4798PS_1977 = 0.0f;
        EID4798PS_1978 = EID4798PS_495;
        EID4798PS_1979 = EID4798PS_462;
    }
    float3 EID4798PS_2091;
    float3 EID4798PS_2092;
    float3 EID4798PS_2093;
    float EID4798PS_2094;
    [branch]
    if (EID4798PS_649 > 0.00999999977648258209228515625f)
    {
        bool3 EID4798PS_1983 = EID4798PS_432.xxx;
        float3 EID4798PS_1985 = EID4798PS_11.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 EID4798PS_1986 = float3(EID4798PS_1983.x ? EID4798PS_1985.x : EID4798PS_11.x, EID4798PS_1983.y ? EID4798PS_1985.y : EID4798PS_11.y, EID4798PS_1983.z ? EID4798PS_1985.z : EID4798PS_11.z);
        float3 EID4798PS_1989 = EID4798PS_1986 * EID4798PS_20_m89.z;
        float3 EID4798PS_1991 = float3(EID4798PS_1983.x ? EID4798PS_9.xzy.x : EID4798PS_9.x, EID4798PS_1983.y ? EID4798PS_9.xzy.y : EID4798PS_9.y, EID4798PS_1983.z ? EID4798PS_9.xzy.z : EID4798PS_9.z);
        float3 EID4798PS_1993 = abs(EID4798PS_1991) - 0.20000000298023223876953125f.xxx;
        float3 EID4798PS_1995 = (EID4798PS_1993 * EID4798PS_1993) * EID4798PS_1993;
        bool3 EID4798PS_4093 = isnan(EID4798PS_1995);
        bool3 EID4798PS_4094 = isnan(6.103515625e-05f.xxx);
        float3 EID4798PS_4095 = max(EID4798PS_1995, 6.103515625e-05f.xxx);
        float3 EID4798PS_4096 = float3(EID4798PS_4093.x ? 6.103515625e-05f.xxx.x : EID4798PS_4095.x, EID4798PS_4093.y ? 6.103515625e-05f.xxx.y : EID4798PS_4095.y, EID4798PS_4093.z ? 6.103515625e-05f.xxx.z : EID4798PS_4095.z);
        float3 EID4798PS_1996 = float3(EID4798PS_4094.x ? EID4798PS_1995.x : EID4798PS_4096.x, EID4798PS_4094.y ? EID4798PS_1995.y : EID4798PS_4096.y, EID4798PS_4094.z ? EID4798PS_1995.z : EID4798PS_4096.z);
        float3 EID4798PS_1999 = EID4798PS_1996 / dot(EID4798PS_1996, 1.0f.xxx).xxx;
        float4 EID4798PS_2022 = ((EID4798PS_55.SampleBias(EID4798_linear_repeat_sampler, EID4798PS_1989.xz, EID4798PS_20_m16) * EID4798PS_1999.y) + (EID4798PS_55.SampleBias(EID4798_linear_repeat_sampler, EID4798PS_1989.xy, EID4798PS_20_m16) * EID4798PS_1999.z)) + (EID4798PS_55.SampleBias(EID4798_linear_repeat_sampler, EID4798PS_1989.zy, EID4798PS_20_m16) * EID4798PS_1999.x);
        float EID4798PS_2030 = clamp(EID4798PS_649 + (smoothstep(0.3499999940395355224609375f, 0.20000000298023223876953125f, EID4798PS_1986.y) * clamp(EID4798PS_649 * 3.0f, 0.0f, 1.0f)), 0.0f, 1.0f);
        float EID4798PS_2041 = smoothstep(2.0f - EID4798PS_2030, 2.349999904632568359375f - EID4798PS_2030, ((EID4798PS_1991.y * 0.64999997615814208984375f) + 0.3499999940395355224609375f) + EID4798PS_2022.z) * ((EID4798PS_469 * EID4798PS_469) * float(EID4798PS_gl_FrontFacing));
        float3 EID4798PS_2043 = EID4798PS_2041.xxx;
        float2 EID4798PS_2049 = (EID4798PS_2022.xy * 2.0f) - 1.0f.xx;
        float2 EID4798PS_2051 = EID4798PS_2049.xy;
        float EID4798PS_2055 = sqrt(1.0f - clamp(dot(EID4798PS_2051, EID4798PS_2051), 0.0f, 1.0f));
        float3 EID4798PS_2057 = float3(EID4798PS_2049.x, EID4798PS_2049.y, EID4798PS_383.z);
        EID4798PS_2057.z = isnan(EID4798PS_2055) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? EID4798PS_2055 : max(1.000000016862383526387164645044e-16f, EID4798PS_2055));
        float2 EID4798PS_2059 = EID4798PS_2057.xy * 2.0f;
        float3 EID4798PS_2061 = lerp(float3(0.0f, 0.0f, 1.0f), float3(EID4798PS_2059.x, EID4798PS_2059.y, EID4798PS_2057.z), EID4798PS_2043);
        float EID4798PS_2062 = dot(EID4798PS_2061, EID4798PS_2061);
        float3 EID4798PS_2065 = EID4798PS_2061 * rsqrt(isnan(EID4798PS_2062) ? 6.103515625e-05f : (isnan(6.103515625e-05f) ? EID4798PS_2062 : max(6.103515625e-05f, EID4798PS_2062)));
        float EID4798PS_2066 = EID4798PS_557.y;
        float EID4798PS_2069 = step(0.00999999977648258209228515625f, 1.0f - (EID4798PS_2066 * EID4798PS_2066));
        float EID4798PS_2073 = lerp(EID4798PS_557.z, EID4798PS_2066, EID4798PS_2069);
        float EID4798PS_2075 = 1.0f - (EID4798PS_2073 * EID4798PS_2073);
        float3 EID4798PS_2080 = (float3(0.0f, EID4798PS_2069, 1.0f - EID4798PS_2069) - (EID4798PS_557 * EID4798PS_2073)) * rsqrt(isnan(EID4798PS_2075) ? 9.9999997473787516355514526367188e-05f : (isnan(9.9999997473787516355514526367188e-05f) ? EID4798PS_2075 : max(9.9999997473787516355514526367188e-05f, EID4798PS_2075)));
        EID4798PS_2091 = ((cross(EID4798PS_2080, EID4798PS_557) * EID4798PS_2065.x) + (EID4798PS_2080 * EID4798PS_2065.y)) + (EID4798PS_557 * EID4798PS_2065.z);
        EID4798PS_2092 = lerp(EID4798PS_1978 * 1.0f, 0.3079999983310699462890625f.xxx, EID4798PS_2043);
        EID4798PS_2093 = lerp(EID4798PS_1979 * 1.0f, 0.87999999523162841796875f.xxx, EID4798PS_2043);
        EID4798PS_2094 = lerp(0.0f, 0.0f, EID4798PS_2041);
    }
    else
    {
        EID4798PS_2091 = EID4798PS_557;
        EID4798PS_2092 = EID4798PS_1978;
        EID4798PS_2093 = EID4798PS_1979;
        EID4798PS_2094 = 0.0f;
    }
    float EID4798PS_2096 = 0.959999978542327880859375f - (EID4798PS_2094 * 0.959999978542327880859375f);
    float3 EID4798PS_2097 = EID4798PS_2093 * EID4798PS_2096;
    float3 EID4798PS_2100 = lerp(0.039999999105930328369140625f.xxx * EID4798PS_468, EID4798PS_2093, EID4798PS_2094.xxx);
    float3 EID4798PS_2101 = EID4798PS_2092 * EID4798PS_2096;
    float2 EID4798PS_2114 = (EID4798PS_7.xy / (isnan(9.9999999392252902907785028219223e-09f) ? EID4798PS_7.z : (isnan(EID4798PS_7.z) ? 9.9999999392252902907785028219223e-09f : max(EID4798PS_7.z, 9.9999999392252902907785028219223e-09f))).xx) - (EID4798PS_8.xy / (isnan(9.9999999392252902907785028219223e-09f) ? EID4798PS_8.z : (isnan(EID4798PS_8.z) ? 9.9999999392252902907785028219223e-09f : max(EID4798PS_8.z, 9.9999999392252902907785028219223e-09f))).xx);
    float2 EID4798PS_2117 = EID4798PS_2114;
    EID4798PS_2117.y = -EID4798PS_2114.y;
    float2 EID4798PS_2127 = ((sqrt(sqrt(abs(EID4798PS_2117 * 0.5f))) * float2(int2(sign(EID4798PS_2117)))) * 0.5f) + 0.5f.xx;
    float4 EID4798PS_2131 = float4(EID4798PS_2127.x, EID4798PS_2127.y, 0.0f.xxxx.z, 0.0f.xxxx.w);
    EID4798PS_2131.z = 1.0f;
    float4 EID4798PS_2132 = EID4798PS_2131;
    EID4798PS_2132.w = (EID4798PS_1977 > 0.100000001490116119384765625f) ? 0.699999988079071044921875f : 0.4000000059604644775390625f;
    float3 EID4798PS_2143 = lerp(-EID4798PS_38_m0.xyz, EID4798PS_20_m90.xyz, EID4798PS_20_m80.w.xxx);
    float3 EID4798PS_2147 = normalize(float3(EID4798PS_2143.x, 6.103515625e-05f, EID4798PS_2143.z));
    float3 EID4798PS_2157 = lerp(EID4798PS_38_m3.xyz, EID4798PS_20_m84.xyz, EID4798PS_20_m91.y.xxx);
    float3 EID4798PS_2161 = EID4798PS_2157 * lerp(EID4798PS_38_m3.w, 1.0f, EID4798PS_20_m91.w);
    int EID4798PS_2165 = int(EID4798PS_613.x);
    int EID4798PS_2166 = int(EID4798PS_613.y);
    // This replay retains captured lighting, so AO must use the same capture's
    // camera projection, not the active editor viewport or its live CP20 output.
    float2 capturedAOPixel = (EID4798PS_7.xy / max(EID4798PS_7.z, 1e-6f)
        * float2(0.5f, -0.5f) + 0.5f) * EID4798PS_20_m0.xy - EID4798PS_20_m9.xy;
    bool capturedAOValid = EID4798PS_7.z > 0 && all(capturedAOPixel >= 0) && all(capturedAOPixel < EID4798PS_20_m0.xy);
    float4 EID4798PS_2170 = capturedAOValid
        ? EID4798PS_42.Load(int3(int2(capturedAOPixel), 0)) : float4(1,1,0,0);
    if (_EID4798AOAudit > 0.5) {
        EID4798PS_15 = float4(EID4798PS_2170.rg,0.75,1);
        EID4798PS_16 = 0; return;
    }
    float EID4798PS_2175 = EID4798PS_2170.y;
    float EID4798PS_2178 = lerp(lerp(1.0f, EID4798PS_2170.x, EID4798PS_40_m6.x), 1.0f, EID4798PS_20_m80.z);
    float EID4798PS_2179 = dot(EID4798PS_2091, EID4798PS_2143);
    float3 EID4798PS_2186 = EID4798PS_2101 * EID4798PS_20_m79.z;
    float3 EID4798PS_2187 = EID4798PS_2186 * 0.64999997615814208984375f;
    float EID4798PS_2191 = dot(EID4798PS_2097, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float EID4798PS_2204 = clamp(-dot(EID4798PS_2147.xz, normalize(EID4798PS_623.xz)), 0.0f, 1.0f);
    float EID4798PS_2208 = 1.0f - EID4798PS_20_m91.x;
    float4 EID4798PS_2222 = EID4798PS_53.SampleLevel(EID4798_linear_clamp_sampler, float2((clamp(lerp(EID4798PS_2179, ((-EID4798PS_2179) * ((EID4798PS_2179 * 0.5f) - 1.0f)) + 0.5f, (EID4798PS_2204 * smoothstep(0.25f, 0.75f, 1.0f - abs(EID4798PS_623.y))) * EID4798PS_2208) + (EID4798PS_20_m90.w * EID4798PS_20_m91.x), -1.0f, 1.0f) * 0.5f) + 0.5f, 0.5f), 0.0f);
    float EID4798PS_2223 = EID4798PS_2222.w;
    float EID4798PS_2225 = EID4798PS_2222.x;
    float EID4798PS_2226 = EID4798PS_2222.y;
    float EID4798PS_2227 = EID4798PS_2222.z;
    float EID4798PS_2228 = isnan(EID4798PS_2226) ? EID4798PS_2225 : (isnan(EID4798PS_2225) ? EID4798PS_2226 : max(EID4798PS_2225, EID4798PS_2226));
    float EID4798PS_2230 = isnan(EID4798PS_2226) ? EID4798PS_2225 : (isnan(EID4798PS_2225) ? EID4798PS_2226 : min(EID4798PS_2225, EID4798PS_2226));
    float EID4798PS_2232 = (isnan(EID4798PS_2227) ? EID4798PS_2228 : (isnan(EID4798PS_2228) ? EID4798PS_2227 : max(EID4798PS_2228, EID4798PS_2227))) - (isnan(EID4798PS_2227) ? EID4798PS_2230 : (isnan(EID4798PS_2230) ? EID4798PS_2227 : min(EID4798PS_2230, EID4798PS_2227)));
    float4 EID4798PS_2240 = EID4798PS_53.SampleLevel(EID4798_linear_clamp_sampler, float2((dot(EID4798PS_2091, EID4798PS_623) * 0.5f) + 0.5f, 0.5f), 0.0f);
    float EID4798PS_2241 = EID4798PS_2240.w;
    float EID4798PS_2242 = EID4798PS_469 * EID4798PS_2175;
    float EID4798PS_2248 = isnan(EID4798PS_469) ? EID4798PS_2175 : (isnan(EID4798PS_2175) ? EID4798PS_469 : min(EID4798PS_2175, EID4798PS_469));
    float EID4798PS_2249 = isnan(EID4798PS_2223) ? EID4798PS_2248 : (isnan(EID4798PS_2248) ? EID4798PS_2223 : min(EID4798PS_2248, EID4798PS_2223));
    float EID4798PS_2250 = EID4798PS_2241 * EID4798PS_2242;
    float3 EID4798PS_2254 = ((clamp(dot(EID4798PS_557, EID4798PS_20_m85.xyz) + EID4798PS_20_m86.x, 0.0f, 1.0f) * EID4798PS_20_m86.y) + EID4798PS_20_m86.z).xxx * lerp(EID4798PS_1164, 1.0f.xxx, (EID4798PS_20_m80.y * EID4798PS_2249).xxx);
    float3 EID4798PS_2256 = EID4798PS_2249.xxx;
    float EID4798PS_2269 = lerp(0.64999997615814208984375f, 1.0f, EID4798PS_1165);
    float3 EID4798PS_2279 = EID4798PS_2178.xxx;
    float3 EID4798PS_2280 = lerp((EID4798PS_2254 * lerp(isnan(1.5f) ? EID4798PS_2269 : (isnan(EID4798PS_2269) ? 1.5f : min(EID4798PS_2269, 1.5f)), clamp(EID4798PS_1165, 1.25f, 1.75f), EID4798PS_20_m80.x)) * EID4798PS_20_m79.w, (lerp(dot(EID4798PS_2161, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, EID4798PS_2161, EID4798PS_2256) + ((EID4798PS_2254 * clamp(EID4798PS_1165, 0.0f, 1.5f)) * ((1.0f - EID4798PS_20_m91.y).xxx + (EID4798PS_2157 * EID4798PS_20_m91.y)))) * EID4798PS_20_m79.y, EID4798PS_2279);
    float3 EID4798PS_2281 = lerp(lerp(lerp(dot(EID4798PS_2187, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, EID4798PS_2187, 1.2000000476837158203125f.xxx), EID4798PS_2186, clamp((EID4798PS_2242 * EID4798PS_2241) + EID4798PS_2223, 0.0f, 1.0f).xxx), EID4798PS_2097, EID4798PS_2256);
    float3 EID4798PS_2287 = EID4798PS_2281 * ((1.0f - EID4798PS_2232).xxx + (EID4798PS_2222.xyz * EID4798PS_2232));
    float EID4798PS_2288 = dot(EID4798PS_2287, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float3 EID4798PS_2296 = lerp(lerp(EID4798PS_2186, lerp(EID4798PS_2191.xxx, EID4798PS_2097, 1.2000000476837158203125f.xxx), EID4798PS_2250.xxx), EID4798PS_2287 * clamp(dot(EID4798PS_2281, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)) * (1.0f / (isnan(0.001000000047497451305389404296875f) ? EID4798PS_2288 : (isnan(EID4798PS_2288) ? 0.001000000047497451305389404296875f : max(EID4798PS_2288, 0.001000000047497451305389404296875f)))), 0.0f, 1.5f), EID4798PS_2279);
    float4 EID4798PS_2300 = float4(EID4798PS_2296, EID4798PS_2178);
    float EID4798PS_2302 = lerp(EID4798PS_2250, EID4798PS_2249, EID4798PS_2178);
    float3 EID4798PS_2308 = (EID4798PS_2280 * (((EID4798PS_2302 * 0.5f) + 0.5f) * lerp(EID4798PS_20_m79.z, 1.0f, EID4798PS_2302))) * 1.0f;
    float EID4798PS_2311 = lerp(0.5f, EID4798PS_2143.y, EID4798PS_2178);
    float3 EID4798PS_2314 = mul(EID4798PS_583, float3(EID4798PS_598.x, EID4798PS_2311, EID4798PS_598.z));
    float3 EID4798PS_2316 = EID4798PS_2143 * EID4798PS_2178;
    float3 EID4798PS_2322 = normalize(EID4798PS_596 + (EID4798PS_576 * ((EID4798PS_51_m34 * 2.0f) - 1.0f)));
    float3 EID4798PS_2323 = normalize(EID4798PS_2316 + (float3(EID4798PS_2314.x, EID4798PS_2314.y, EID4798PS_2314.z) * 2.0f)) + EID4798PS_423;
    float EID4798PS_2324 = dot(EID4798PS_2323, EID4798PS_2323);
    float3 EID4798PS_2327 = EID4798PS_2323 * rsqrt(isnan(EID4798PS_2324) ? 6.103515625e-05f : (isnan(6.103515625e-05f) ? EID4798PS_2324 : max(6.103515625e-05f, EID4798PS_2324)));
    float EID4798PS_2328 = dot(EID4798PS_2322, EID4798PS_2327);
    float EID4798PS_2331 = sqrt(1.0f - (EID4798PS_2328 * EID4798PS_2328));
    float3 EID4798PS_2336 = clamp(pow(isnan(9.9999997473787516355514526367188e-05f) ? EID4798PS_2331 : (isnan(EID4798PS_2331) ? 9.9999997473787516355514526367188e-05f : max(EID4798PS_2331, 9.9999997473787516355514526367188e-05f)), 200.0f).xxx * EID4798PS_468, 0.0f.xxx, 1.0f.xxx);
    float EID4798PS_2339 = EID4798PS_607 * EID4798PS_607;
    float3 EID4798PS_2349 = (EID4798PS_2336 * EID4798PS_54.SampleLevel(EID4798_linear_clamp_sampler, float2(EID4798PS_2336.x, float(EID4798PS_2328 > 0.0f) * EID4798PS_2339), 0.0f).xyz) * EID4798PS_607;
    float EID4798PS_2350 = EID4798PS_2349.x;
    float EID4798PS_2351 = EID4798PS_2349.y;
    float EID4798PS_2352 = EID4798PS_2349.z;
    float EID4798PS_2353 = isnan(EID4798PS_2351) ? EID4798PS_2350 : (isnan(EID4798PS_2350) ? EID4798PS_2351 : max(EID4798PS_2350, EID4798PS_2351));
    float EID4798PS_2354 = isnan(EID4798PS_2352) ? EID4798PS_2353 : (isnan(EID4798PS_2353) ? EID4798PS_2352 : max(EID4798PS_2353, EID4798PS_2352));
    float EID4798PS_2366 = 1.0f - EID4798PS_51_m38;
    float EID4798PS_2370 = dot(normalize(EID4798PS_596 + (EID4798PS_576 * ((EID4798PS_51_m35 * 2.0f) - 1.0f))), EID4798PS_2327);
    float EID4798PS_2373 = sqrt(1.0f - (EID4798PS_2370 * EID4798PS_2370));
    float EID4798PS_2406 = 1.0f - EID4798PS_51_m45;
    float EID4798PS_2410 = dot(normalize(EID4798PS_596 + (EID4798PS_576 * ((2.0f * EID4798PS_51_m44) - 1.0f))), EID4798PS_2327);
    float EID4798PS_2413 = sqrt(1.0f - (EID4798PS_2410 * EID4798PS_2410));
    float EID4798PS_2424 = lerp(1.0f, lerp(1.0f, lerp(lerp(1.0f - EID4798PS_51_m46, 1.0f, lerp(ceil(clamp(frac(EID4798PS_3.x * EID4798PS_51_m43) - 0.5f, 0.0f, 1.0f)), 1.0f - EID4798PS_525.x, EID4798PS_51_m48)), 1.0f, EID4798PS_2354), clamp(pow(isnan(9.9999997473787516355514526367188e-05f) ? EID4798PS_2413 : (isnan(EID4798PS_2413) ? 9.9999997473787516355514526367188e-05f : max(EID4798PS_2413, 9.9999997473787516355514526367188e-05f)), float(int(200.0f * (isnan(0.0f) ? EID4798PS_2406 : (isnan(EID4798PS_2406) ? 0.0f : max(EID4798PS_2406, 0.0f)))))), 0.0f, 1.0f)), EID4798PS_468);
    float3 EID4798PS_2428 = ((((((EID4798PS_2349 * EID4798PS_2100) * EID4798PS_51_m36) * 5.0f) * EID4798PS_1973) + lerp(((pow(isnan(9.9999997473787516355514526367188e-05f) ? EID4798PS_2373 : (isnan(EID4798PS_2373) ? 9.9999997473787516355514526367188e-05f : max(EID4798PS_2373, 9.9999997473787516355514526367188e-05f)), float(int(200.0f * (isnan(0.0f) ? EID4798PS_2366 : (isnan(EID4798PS_2366) ? 0.0f : max(EID4798PS_2366, 0.0f)))))).xxx * EID4798PS_607) * (EID4798PS_51_m42.xyz * EID4798PS_466.w)) * EID4798PS_1973, 0.0f.xxx, EID4798PS_2354.xxx)) * EID4798PS_2308) * EID4798PS_20_m92.w;
    float3 EID4798PS_2432 = (EID4798PS_2280 * EID4798PS_2296) * EID4798PS_2424;
    float3 EID4798PS_2436 = lerp(dot(EID4798PS_2432, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, EID4798PS_2432, lerp(EID4798PS_51_m47, 1.0f, EID4798PS_2424).xxx);
    float3 EID4798PS_2442 = float3(EID4798PS_623.x, EID4798PS_2311, EID4798PS_623.z);
    float EID4798PS_2443 = dot(EID4798PS_2442, EID4798PS_2442);
    float3 EID4798PS_2452 = normalize((EID4798PS_2316 + ((EID4798PS_2442 * rsqrt(isnan(EID4798PS_2443) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? EID4798PS_2443 : max(1.1754943508222875079687365372222e-38f, EID4798PS_2443)))) * 2.0f)) + (EID4798PS_423 * (2.0f + EID4798PS_2178)));
    float3 EID4798PS_2457 = normalize(float3(-EID4798PS_1972.z, 0.001000000047497451305389404296875f, EID4798PS_1972.x));
    float EID4798PS_2466 = dot(EID4798PS_1972, EID4798PS_2452);
    float EID4798PS_2479 = (1.0f - EID4798PS_51_m6) + (EID4798PS_473 * EID4798PS_51_m6);
    float3 EID4798PS_2481 = (EID4798PS_2436 * EID4798PS_2479) + ((EID4798PS_2428 * EID4798PS_1976) + (((EID4798PS_2436 + EID4798PS_2428) * EID4798PS_1975) + (((((smoothstep(0.1500000059604644775390625f, 0.100000001490116119384765625f, abs(dot(EID4798PS_2452, EID4798PS_2457))) * smoothstep(0.070000000298023223876953125f, 0.0199999995529651641845703125f, abs(dot(EID4798PS_2452, cross(EID4798PS_1972, EID4798PS_2457))))) * (isnan(EID4798PS_2466) ? 0.0f : (isnan(0.0f) ? EID4798PS_2466 : max(0.0f, EID4798PS_2466)))) * 2.0f) * EID4798PS_1974).xxx * EID4798PS_2308)));
    float EID4798PS_2482 = dot(EID4798PS_2481, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float EID4798PS_2485 = clamp(EID4798PS_2482 - 0.5f, 0.0f, 0.5f);
    float3 EID4798PS_2521 = normalize(cross(EID4798PS_623, lerp(float3(EID4798PS_20_m88.xy, 0.0f), (float3(EID4798PS_18_m0[0].x, EID4798PS_18_m0[0].y, EID4798PS_18_m0[0].z) * EID4798PS_20_m88.x) + (float3(EID4798PS_18_m0[1].x, EID4798PS_18_m0[1].y, EID4798PS_18_m0[1].z) * EID4798PS_20_m88.y), EID4798PS_20_m94.w.xxx)));
    float2 EID4798PS_2545 = normalize(mul(float3x3(EID4798PS_18_m0[0].xyz, EID4798PS_18_m0[1].xyz, EID4798PS_18_m0[2].xyz), EID4798PS_2091).xy) * float2(EID4798PS_20_m5.y / EID4798PS_20_m5.x, 1.0f);
    float2 EID4798PS_2551 = EID4798PS_20_m5.zw - 1.0f.xx;
    float2 EID4798PS_2552 = 2.0f.xx - EID4798PS_20_m5.zw;
    float EID4798PS_2574 = clamp(dot(EID4798PS_537, EID4798PS_2521) + 1.0f, 0.0f, 1.0f);
    float EID4798PS_2575 = isnan(EID4798PS_469) ? EID4798PS_2574 : (isnan(EID4798PS_2574) ? EID4798PS_469 : min(EID4798PS_2574, EID4798PS_469));
    float EID4798PS_2586 = dot(EID4798PS_2147, EID4798PS_2091);
    float EID4798PS_2597 = dot(EID4798PS_423, EID4798PS_2091);
    float EID4798PS_2601 = 1.0f - EID4798PS_2178;
    float EID4798PS_2612 = isnan(EID4798PS_1163.y) ? EID4798PS_1163.x : (isnan(EID4798PS_1163.x) ? EID4798PS_1163.y : max(EID4798PS_1163.x, EID4798PS_1163.y));
    float EID4798PS_2614 = (isnan(EID4798PS_1163.z) ? EID4798PS_2612 : (isnan(EID4798PS_2612) ? EID4798PS_1163.z : max(EID4798PS_2612, EID4798PS_1163.z))) * 0.5f;
    bool3 EID4798PS_4243 = isnan(0.1500000059604644775390625f.xxx);
    bool3 EID4798PS_4244 = isnan(EID4798PS_2097);
    float3 EID4798PS_4245 = max(0.1500000059604644775390625f.xxx, EID4798PS_2097);
    float3 EID4798PS_4246 = float3(EID4798PS_4243.x ? EID4798PS_2097.x : EID4798PS_4245.x, EID4798PS_4243.y ? EID4798PS_2097.y : EID4798PS_4245.y, EID4798PS_4243.z ? EID4798PS_2097.z : EID4798PS_4245.z);
    float2 EID4798PS_2629 = float2(EID4798PS_613);
    float2 EID4798PS_2631 = floor(EID4798PS_2629 * 0.03125f);
    int EID4798PS_2639 = int((EID4798PS_2631.x + (EID4798PS_2631.y * EID4798PS_36_m5)) * 8.0f);
    float EID4798PS_2646 = floor(EID4798PS_404 - (EID4798PS_20_m3.y * EID4798PS_36_m11));
    float EID4798PS_2650 = clamp(EID4798PS_2646, 0.0f, EID4798PS_36_m7 - 1.0f);
    int EID4798PS_2652 = int(EID4798PS_2650 * 8.0f);
    float3 EID4798PS_2654;
    EID4798PS_2654 = lerp(EID4798PS_2482.xxx, EID4798PS_2481, ((EID4798PS_2485 * EID4798PS_2485) + 1.0f).xxx) + (((((EID4798PS_20_m87.xyz * smoothstep(0.100000001490116119384765625f, 0.20000000298023223876953125f, (1.0f / ((EID4798PS_20_m2.z * EID4798PS_30.SampleLevel(EID4798_point_clamp_sampler, clamp(EID4798PS_612 + ((EID4798PS_2545 * EID4798PS_20_m88.w) * 0.006000000052154064178466796875f), EID4798PS_2551, EID4798PS_2552), 0.0f).x) + EID4798PS_20_m2.w)) - EID4798PS_404)) * EID4798PS_20_m87.w) * (isnan(EID4798PS_2175) ? EID4798PS_2575 : (isnan(EID4798PS_2575) ? EID4798PS_2175 : min(EID4798PS_2575, EID4798PS_2175)))) * (lerp(0.25f.xxx, EID4798PS_2097, EID4798PS_20_m88.z.xxx) * clamp(dot(EID4798PS_2521, EID4798PS_2091), 0.0f, 1.0f))) + ((((((lerp(EID4798PS_1163 * (1.0f / (isnan(1.0f) ? EID4798PS_2614 : (isnan(EID4798PS_2614) ? 1.0f : max(EID4798PS_2614, 1.0f)))), EID4798PS_2161, EID4798PS_2279) * clamp(lerp(dot(EID4798PS_1162.xyz, EID4798PS_2091) * EID4798PS_1162.w, ((-EID4798PS_2586) * ((EID4798PS_2586 * 0.5f) - 1.0f)) + 0.5f, EID4798PS_2178), 0.0f, 1.0f)) * ((EID4798PS_2601 + (EID4798PS_2204 * EID4798PS_2178)) * EID4798PS_2208)) * smoothstep(0.60000002384185791015625f, 0.800000011920928955078125f, 1.0f - abs(EID4798PS_2597))) * (isnan(EID4798PS_2175) ? EID4798PS_469 : (isnan(EID4798PS_469) ? EID4798PS_2175 : min(EID4798PS_469, EID4798PS_2175)))) * (EID4798PS_2601 + (smoothstep(0.100000001490116119384765625f, 0.039999999105930328369140625f, EID4798PS_2191) * EID4798PS_2178))) * float3(EID4798PS_4244.x ? 0.1500000059604644775390625f.xxx.x : EID4798PS_4246.x, EID4798PS_4244.y ? 0.1500000059604644775390625f.xxx.y : EID4798PS_4246.y, EID4798PS_4244.z ? 0.1500000059604644775390625f.xxx.z : EID4798PS_4246.z)));
    float3 EID4798PS_2655;
    [loop]
    for (int EID4798PS_2657 = 0; EID4798PS_2657 <= 7; EID4798PS_2654 = EID4798PS_2655, EID4798PS_2657++)
    {
        uint EID4798PS_2675 = (EID4798PS_2646 <= EID4798PS_2650) ? (EID4798PS_32.Load(uint(EID4798PS_2639 + EID4798PS_2657) * 4 + 0) & EID4798PS_32.Load(uint((EID4798PS_20_m21.y + EID4798PS_2652) + EID4798PS_2657) * 4 + 0)) : 0u;
        uint EID4798PS_2676 = uint(EID4798PS_2657);
        EID4798PS_2655 = EID4798PS_2654;
        uint EID4798PS_2681;
        float3 EID4798PS_2678;
        [loop]
        for (uint EID4798PS_2680 = EID4798PS_2675; EID4798PS_2680 != 0u; EID4798PS_2655 = EID4798PS_2678, EID4798PS_2680 = EID4798PS_2681)
        {
            uint EID4798PS_2685 = firstbitlow(EID4798PS_2680);
            EID4798PS_2681 = EID4798PS_2680 ^ (1u << (EID4798PS_2685 & 31u));
            int EID4798PS_2691 = int((32u * EID4798PS_2676) + EID4798PS_2685) * 8;
            int EID4798PS_2694 = EID4798PS_2691 + 1;
            int EID4798PS_2697 = EID4798PS_2691 + 2;
            int EID4798PS_2700 = EID4798PS_2691 + 3;
            int EID4798PS_2703 = EID4798PS_2691 + 4;
            int EID4798PS_2706 = EID4798PS_2691 + 5;
            int EID4798PS_2709 = EID4798PS_2691 + 6;
            int EID4798PS_2712 = EID4798PS_2691 + 7;
            uint EID4798PS_2716 = uint(EID4798PS_38_m6[EID4798PS_2706].w);
            float EID4798PS_2791;
            if ((EID4798PS_2716 & 1u) == 1u)
            {
                uint EID4798PS_2722 = asuint(EID4798PS_38_m6[EID4798PS_2706].x);
                uint EID4798PS_2729 = asuint(EID4798PS_38_m6[EID4798PS_2706].y);
                uint EID4798PS_2736 = asuint(EID4798PS_38_m6[EID4798PS_2706].z);
                uint EID4798PS_2743 = asuint(EID4798PS_38_m6[EID4798PS_2709].x);
                uint EID4798PS_2750 = asuint(EID4798PS_38_m6[EID4798PS_2709].y);
                uint EID4798PS_2757 = asuint(EID4798PS_38_m6[EID4798PS_2709].z);
                float3 EID4798PS_2776 = abs(mul(float4(EID4798PS_530 - EID4798PS_38_m6[EID4798PS_2694].xyz, 1.0f), float4x4(float4(EID4798PS_spvUnpackHalf2x16(EID4798PS_2722).x, EID4798PS_spvUnpackHalf2x16(EID4798PS_2736).x, EID4798PS_spvUnpackHalf2x16(EID4798PS_2750).x, 0.0f), float4(EID4798PS_spvUnpackHalf2x16(EID4798PS_2722 >> 16u).x, EID4798PS_spvUnpackHalf2x16(EID4798PS_2736 >> 16u).x, EID4798PS_spvUnpackHalf2x16(EID4798PS_2750 >> 16u).x, 0.0f), float4(EID4798PS_spvUnpackHalf2x16(EID4798PS_2729).x, EID4798PS_spvUnpackHalf2x16(EID4798PS_2743).x, EID4798PS_spvUnpackHalf2x16(EID4798PS_2757).x, 0.0f), float4(EID4798PS_spvUnpackHalf2x16(EID4798PS_2729 >> 16u).x, EID4798PS_spvUnpackHalf2x16(EID4798PS_2743 >> 16u).x, EID4798PS_spvUnpackHalf2x16(EID4798PS_2757 >> 16u).x, 0.0f))).xyz);
                float EID4798PS_2777 = EID4798PS_2776.x;
                float EID4798PS_2778 = EID4798PS_2776.y;
                float EID4798PS_2779 = isnan(EID4798PS_2778) ? EID4798PS_2777 : (isnan(EID4798PS_2777) ? EID4798PS_2778 : max(EID4798PS_2777, EID4798PS_2778));
                float EID4798PS_2780 = EID4798PS_2776.z;
                float EID4798PS_2783 = EID4798PS_38_m6[EID4798PS_2712].x * 0.5f;
                float EID4798PS_2789 = 1.0f - clamp(((isnan(EID4798PS_2780) ? EID4798PS_2779 : (isnan(EID4798PS_2779) ? EID4798PS_2780 : max(EID4798PS_2779, EID4798PS_2780))) - (EID4798PS_2783 + 0.5f)) / (0.5f - EID4798PS_2783), 0.0f, 1.0f);
                EID4798PS_2791 = EID4798PS_2789 * EID4798PS_2789;
            }
            else
            {
                EID4798PS_2791 = 1.0f;
            }
            if (false || (EID4798PS_2791 < 0.001000000047497451305389404296875f))
            {
                EID4798PS_2678 = EID4798PS_2655;
                continue;
            }
            float3 EID4798PS_3484;
            if (EID4798PS_38_m6[EID4798PS_2691].w < 1.5f)
            {
                float3 EID4798PS_3483;
                do
                {
                    uint EID4798PS_2804 = asuint(EID4798PS_38_m6[EID4798PS_2700].w);
                    if ((EID4798PS_2804 == 16u) || ((EID4798PS_38_m6[EID4798PS_2700].z + EID4798PS_20_m91.z) < 0.5f))
                    {
                        EID4798PS_3483 = EID4798PS_2655;
                        break;
                    }
                    bool EID4798PS_2816 = (uint(EID4798PS_38_m6[EID4798PS_2691].w) & 1u) == 0u;
                    bool EID4798PS_2820 = (!EID4798PS_2816) && (EID4798PS_38_m6[EID4798PS_2697].z > 0.0f);
                    bool EID4798PS_2821 = EID4798PS_2804 == 4u;
                    float EID4798PS_2822 = float(EID4798PS_2816);
                    float EID4798PS_2830 = (0.5f + (0.5f * EID4798PS_38_m6[EID4798PS_2697].y)) - abs(EID4798PS_38_m6[EID4798PS_2697].x);
                    float EID4798PS_2831 = EID4798PS_38_m6[EID4798PS_2697].y - EID4798PS_2830;
                    float EID4798PS_2835 = (1.0f - abs(EID4798PS_2830)) - abs(EID4798PS_2831);
                    float EID4798PS_2838 = abs(isnan(0.00048828125f) ? EID4798PS_2835 : (isnan(EID4798PS_2835) ? 0.00048828125f : max(EID4798PS_2835, 0.00048828125f)));
                    float3 EID4798PS_2842 = normalize(float3(EID4798PS_2830, EID4798PS_2831, (EID4798PS_38_m6[EID4798PS_2697].x >= 0.0f) ? EID4798PS_2838 : (-EID4798PS_2838)));
                    float EID4798PS_2845 = 2.0f * EID4798PS_38_m6[EID4798PS_2703].y;
                    float EID4798PS_2848 = lerp(EID4798PS_38_m6[EID4798PS_2709].w, isnan(0.100000001490116119384765625f) ? EID4798PS_2845 : (isnan(EID4798PS_2845) ? 0.100000001490116119384765625f : max(EID4798PS_2845, 0.100000001490116119384765625f)), float(EID4798PS_2821));
                    float3 EID4798PS_2853 = EID4798PS_38_m6[EID4798PS_2694].xyz - EID4798PS_530;
                    float3 EID4798PS_2854 = -EID4798PS_2842;
                    float3 EID4798PS_2859 = lerp(EID4798PS_2853, EID4798PS_2854 * dot(EID4798PS_2853, EID4798PS_2854), (float(EID4798PS_2821 && (EID4798PS_38_m6[EID4798PS_2703].z > 0.5f)) * EID4798PS_2822).xxx);
                    float EID4798PS_2860 = dot(EID4798PS_2859, EID4798PS_2859);
                    float EID4798PS_2861 = rsqrt(EID4798PS_2860);
                    float3 EID4798PS_2862 = EID4798PS_2859 * EID4798PS_2861;
                    float3 EID4798PS_2895;
                    float EID4798PS_2896;
                    if (EID4798PS_2820)
                    {
                        float3 EID4798PS_2866 = (EID4798PS_2842 * EID4798PS_38_m6[EID4798PS_2697].z) * 0.5f;
                        float3 EID4798PS_2867 = EID4798PS_2859 - EID4798PS_2866;
                        float3 EID4798PS_2868 = EID4798PS_2859 + EID4798PS_2866;
                        float EID4798PS_2869 = length(EID4798PS_2867);
                        float EID4798PS_2870 = length(EID4798PS_2868);
                        float3 EID4798PS_2879 = normalize(cross(cross(EID4798PS_2842, EID4798PS_2862), EID4798PS_2842));
                        EID4798PS_2895 = EID4798PS_2879;
                        EID4798PS_2896 = ((1.0f / ((((EID4798PS_2869 * EID4798PS_2870) + dot(EID4798PS_2867, EID4798PS_2868)) * 0.5f) + 1.0f)) * clamp(0.5f * ((dot(EID4798PS_2879, EID4798PS_2867) / EID4798PS_2869) + (dot(EID4798PS_2879, EID4798PS_2868) / EID4798PS_2870)), 0.0f, 1.0f)) * (1.0f / clamp(1.0f + (0.5f * clamp(EID4798PS_38_m6[EID4798PS_2697].z * EID4798PS_2861, 0.0f, 1.0f)), 0.0f, 1.0f));
                    }
                    else
                    {
                        EID4798PS_2895 = EID4798PS_2862;
                        EID4798PS_2896 = 1.0f;
                    }
                    float EID4798PS_2918;
                    if (EID4798PS_2848 < 0.0f)
                    {
                        float EID4798PS_2912 = EID4798PS_2860 * (EID4798PS_38_m6[EID4798PS_2694].w * EID4798PS_38_m6[EID4798PS_2694].w);
                        float EID4798PS_2915 = clamp(1.0f - (EID4798PS_2912 * EID4798PS_2912), 0.0f, 1.0f);
                        EID4798PS_2918 = lerp(1.0f / (EID4798PS_2860 + 1.0f), EID4798PS_2896, float(EID4798PS_2820)) * (EID4798PS_2915 * EID4798PS_2915);
                    }
                    else
                    {
                        float3 EID4798PS_2901 = EID4798PS_2859 * EID4798PS_38_m6[EID4798PS_2694].w;
                        EID4798PS_2918 = EID4798PS_2896 * pow(1.0f - clamp(dot(EID4798PS_2901, EID4798PS_2901), 0.0f, 1.0f), EID4798PS_2848);
                    }
                    float EID4798PS_2923 = clamp((dot(EID4798PS_2895, EID4798PS_2854) - EID4798PS_38_m6[EID4798PS_2697].z) * EID4798PS_38_m6[EID4798PS_2697].w, 0.0f, 1.0f);
                    float EID4798PS_2926 = EID4798PS_2918 * lerp(1.0f, EID4798PS_2923 * EID4798PS_2923, EID4798PS_2822);
                    int EID4798PS_2928 = int(EID4798PS_38_m6[EID4798PS_2712].w);
                    float EID4798PS_3032;
                    if ((!EID4798PS_2820) && (EID4798PS_2928 >= 0))
                    {
                        uint EID4798PS_2934 = uint(EID4798PS_2928);
                        float2 EID4798PS_3025;
                        [branch]
                        if (EID4798PS_2822 != 0.0f)
                        {
                            float4 EID4798PS_3015 = mul(EID4798PS_61_m1[EID4798PS_2934], float4(EID4798PS_530.x, EID4798PS_655, EID4798PS_530.z, 1.0f));
                            EID4798PS_3025 = EID4798PS_61_m0[EID4798PS_2934].xy + (clamp(EID4798PS_3015.xy / EID4798PS_3015.w.xx, 0.0f.xx, 1.0f.xx) * EID4798PS_61_m0[EID4798PS_2934].zw);
                        }
                        else
                        {
                            float3 EID4798PS_2949 = mul(float4(-EID4798PS_2859, 0.0f), EID4798PS_61_m1[EID4798PS_2934]).xyz;
                            float3 EID4798PS_392 = EID4798PS_2949;
                            float3 EID4798PS_391 = EID4798PS_2949;
                            float3 EID4798PS_390 = abs(EID4798PS_2949);
                            uint EID4798PS_2958 = uint(int(EID4798PS_390.y > EID4798PS_390.x));
                            uint EID4798PS_2964 = (EID4798PS_390.z > EID4798PS_390[EID4798PS_2958]) ? 2u : EID4798PS_2958;
                            uint EID4798PS_2970 = (EID4798PS_2964 * 2u) + uint(EID4798PS_391[EID4798PS_2964] < 0.0f);
                            float EID4798PS_2974 = abs(EID4798PS_392[EID4798PS_2970 / 2u]);
                            float EID4798PS_2994 = 0.5f - (0.000244140625f / EID4798PS_61_m0[EID4798PS_2934].w);
                            EID4798PS_3025 = EID4798PS_61_m0[EID4798PS_2934].xy + (clamp(float2((float(EID4798PS_2970) + ((((EID4798PS_392[uint(EID4798PS_358[EID4798PS_2970].x)] * EID4798PS_359[EID4798PS_2970].x) / EID4798PS_2974) * EID4798PS_2994) + 0.5f)) * 0.16666667163372039794921875f, 0.5f - (((EID4798PS_392[uint(EID4798PS_358[EID4798PS_2970].y)] * EID4798PS_359[EID4798PS_2970].y) / EID4798PS_2974) * EID4798PS_2994)), 0.0f.xx, 1.0f.xx) * EID4798PS_61_m0[EID4798PS_2934].zw);
                        }
                        EID4798PS_3032 = EID4798PS_2926 * EID4798PS_59.SampleLevel(EID4798_linear_clamp_sampler, EID4798PS_3025, 0.0f).x;
                    }
                    else
                    {
                        EID4798PS_3032 = EID4798PS_2926;
                    }
                    float EID4798PS_3033 = EID4798PS_3032 * EID4798PS_2791;
                    float3 EID4798PS_3482;
                    do
                    {
                        float3 EID4798PS_3481;
                        [branch]
                        if (EID4798PS_3033 > 9.9999997473787516355514526367188e-05f)
                        {
                            [branch]
                            if (EID4798PS_2821)
                            {
                                EID4798PS_3482 = lerp(EID4798PS_2655, EID4798PS_38_m6[EID4798PS_2691].xyz, (EID4798PS_3033 * (EID4798PS_38_m6[EID4798PS_2703].x * ((1.0f - EID4798PS_38_m6[EID4798PS_2703].w) + (smoothstep(-0.5f, 0.5f, dot(EID4798PS_558, EID4798PS_2895)) * EID4798PS_38_m6[EID4798PS_2703].w)))).xxx);
                                break;
                            }
                            float EID4798PS_3053 = dot(EID4798PS_2091, EID4798PS_2895);
                            float EID4798PS_3054 = clamp(EID4798PS_3053, 0.0f, 1.0f);
                            float EID4798PS_3357;
                            if (EID4798PS_2804 != 0u)
                            {
                                bool EID4798PS_3060 = EID4798PS_2816 || ((EID4798PS_2716 & 2u) != 0u);
                                int EID4798PS_3109;
                                if (EID4798PS_3060)
                                {
                                    EID4798PS_3109 = int(EID4798PS_38_m6[EID4798PS_2700].x);
                                }
                                else
                                {
                                    uint EID4798PS_3064 = asuint(EID4798PS_38_m6[EID4798PS_2697].w);
                                    uint EID4798PS_3066 = asuint(EID4798PS_38_m6[EID4798PS_2700].x);
                                    float3 EID4798PS_3067 = EID4798PS_530 - EID4798PS_38_m6[EID4798PS_2694].xyz;
                                    float3 EID4798PS_3068 = abs(EID4798PS_3067);
                                    float EID4798PS_3069 = EID4798PS_3068.x;
                                    float EID4798PS_3070 = EID4798PS_3068.y;
                                    float EID4798PS_3072 = EID4798PS_3068.z;
                                    int EID4798PS_3104;
                                    if ((EID4798PS_3069 > EID4798PS_3070) && (EID4798PS_3069 > EID4798PS_3072))
                                    {
                                        EID4798PS_3104 = int((EID4798PS_3067.x > 0.0f) ? (EID4798PS_3064 >> 24u) : ((EID4798PS_3064 >> 16u) & 255u));
                                    }
                                    else
                                    {
                                        int EID4798PS_3096;
                                        if (EID4798PS_3070 > EID4798PS_3072)
                                        {
                                            EID4798PS_3096 = int((EID4798PS_3067.y > 0.0f) ? ((EID4798PS_3064 >> 8u) & 255u) : (EID4798PS_3064 & 255u));
                                        }
                                        else
                                        {
                                            EID4798PS_3096 = int((EID4798PS_3067.z > 0.0f) ? ((EID4798PS_3066 >> 8u) & 255u) : (EID4798PS_3066 & 255u));
                                        }
                                        EID4798PS_3104 = EID4798PS_3096;
                                    }
                                    EID4798PS_3109 = (EID4798PS_3104 < 80) ? EID4798PS_3104 : (-1);
                                }
                                bool EID4798PS_3110 = EID4798PS_3109 >= 0;
                                float EID4798PS_3356;
                                if (EID4798PS_3110)
                                {
                                    float3 EID4798PS_3117 = EID4798PS_530 - EID4798PS_38_m6[EID4798PS_2694].xyz;
                                    float EID4798PS_3118 = dot(EID4798PS_3117, EID4798PS_3117);
                                    float4 EID4798PS_3137 = mul(EID4798PS_40_m10[EID4798PS_3109], float4((EID4798PS_530 - ((EID4798PS_3117 * rsqrt(isnan(EID4798PS_3118) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? EID4798PS_3118 : max(1.1754943508222875079687365372222e-38f, EID4798PS_3118)))) * EID4798PS_40_m11[EID4798PS_3109].x)) + (EID4798PS_558 * (EID4798PS_40_m11[EID4798PS_3109].y * 5.0f)), 1.0f));
                                    float EID4798PS_3138 = EID4798PS_3137.w;
                                    float3 EID4798PS_3141 = EID4798PS_3137.xyz / EID4798PS_3138.xxx;
                                    float2 EID4798PS_3142 = EID4798PS_3141.xy;
                                    float3 EID4798PS_3150 = EID4798PS_3141.xyz;
                                    bool3 EID4798PS_3151 = bool3(EID4798PS_3150.x <= 0.0f.xxx.x, EID4798PS_3150.y <= 0.0f.xxx.y, EID4798PS_3150.z <= 0.0f.xxx.z);
                                    bool3 EID4798PS_3152 = bool3(EID4798PS_3150.x >= 1.0f.xxx.x, EID4798PS_3150.y >= 1.0f.xxx.y, EID4798PS_3150.z >= 1.0f.xxx.z);
                                    float EID4798PS_3155 = EID4798PS_3141.z;
                                    float2 EID4798PS_3166 = ((EID4798PS_3142 * (EID4798PS_40_m12[EID4798PS_3109].zw - EID4798PS_40_m12[EID4798PS_3109].xy)) + EID4798PS_40_m12[EID4798PS_3109].xy).xy * EID4798PS_40_m13.zw;
                                    float2 EID4798PS_3168 = floor(EID4798PS_3166 + 0.5f.xx);
                                    float2 EID4798PS_3169 = EID4798PS_3166 - EID4798PS_3168;
                                    float EID4798PS_3170 = EID4798PS_3169.x;
                                    float EID4798PS_3171 = EID4798PS_3170 + 0.5f;
                                    float EID4798PS_3172 = EID4798PS_3171 * EID4798PS_3171;
                                    float EID4798PS_3175 = 1.0f - EID4798PS_3170;
                                    float EID4798PS_3176 = isnan(0.0f) ? EID4798PS_3170 : (isnan(EID4798PS_3170) ? 0.0f : min(EID4798PS_3170, 0.0f));
                                    float EID4798PS_3179 = EID4798PS_3170 + 1.0f;
                                    float EID4798PS_3180 = isnan(0.0f) ? EID4798PS_3170 : (isnan(EID4798PS_3170) ? 0.0f : max(EID4798PS_3170, 0.0f));
                                    float EID4798PS_3191 = EID4798PS_3169.y;
                                    float EID4798PS_3192 = EID4798PS_3191 + 0.5f;
                                    float EID4798PS_3193 = EID4798PS_3192 * EID4798PS_3192;
                                    float EID4798PS_3196 = 1.0f - EID4798PS_3191;
                                    float EID4798PS_3197 = isnan(0.0f) ? EID4798PS_3191 : (isnan(EID4798PS_3191) ? 0.0f : min(EID4798PS_3191, 0.0f));
                                    float EID4798PS_3200 = EID4798PS_3191 + 1.0f;
                                    float EID4798PS_3201 = isnan(0.0f) ? EID4798PS_3191 : (isnan(EID4798PS_3191) ? 0.0f : max(EID4798PS_3191, 0.0f));
                                    float3 EID4798PS_3213 = float3(0.1599999964237213134765625f * EID4798PS_3175, 0.1599999964237213134765625f * ((EID4798PS_3179 - (EID4798PS_3180 * EID4798PS_3180)) + 1.0f), EID4798PS_3172 * 0.07999999821186065673828125f);
                                    float3 EID4798PS_3214 = float3(0.1599999964237213134765625f * ((EID4798PS_3172 * 0.5f) - EID4798PS_3170), 0.1599999964237213134765625f * ((EID4798PS_3175 - (EID4798PS_3176 * EID4798PS_3176)) + 1.0f), 0.1599999964237213134765625f * EID4798PS_3179) + EID4798PS_3213;
                                    float3 EID4798PS_3216 = float3(0.1599999964237213134765625f * EID4798PS_3196, 0.1599999964237213134765625f * ((EID4798PS_3200 - (EID4798PS_3201 * EID4798PS_3201)) + 1.0f), EID4798PS_3193 * 0.07999999821186065673828125f);
                                    float3 EID4798PS_3217 = float3(0.1599999964237213134765625f * ((EID4798PS_3193 * 0.5f) - EID4798PS_3191), 0.1599999964237213134765625f * ((EID4798PS_3196 - (EID4798PS_3197 * EID4798PS_3197)) + 1.0f), 0.1599999964237213134765625f * EID4798PS_3200) + EID4798PS_3216;
                                    float3 EID4798PS_3223 = ((EID4798PS_3213 / EID4798PS_3214) + float3(-2.5f, -0.5f, 1.5f)) * EID4798PS_40_m13.xxx;
                                    float3 EID4798PS_3225 = ((EID4798PS_3216 / EID4798PS_3217) + float3(-2.5f, -0.5f, 1.5f)) * EID4798PS_40_m13.yyy;
                                    float2 EID4798PS_3227 = EID4798PS_3168 * EID4798PS_40_m13.xy;
                                    float EID4798PS_3228 = EID4798PS_3223.x;
                                    float EID4798PS_3229 = EID4798PS_3225.x;
                                    float EID4798PS_3232 = EID4798PS_3223.y;
                                    float EID4798PS_3235 = EID4798PS_3223.z;
                                    float EID4798PS_3238 = EID4798PS_3225.y;
                                    float EID4798PS_3245 = EID4798PS_3225.z;
                                    float EID4798PS_3252 = EID4798PS_3214.x;
                                    float EID4798PS_3253 = EID4798PS_3217.x;
                                    float EID4798PS_3255 = EID4798PS_3214.y;
                                    float EID4798PS_3257 = EID4798PS_3214.z;
                                    float EID4798PS_3259 = EID4798PS_3217.y;
                                    float EID4798PS_3263 = EID4798PS_3217.z;
                                    float2 EID4798PS_3341 = 1.0f.xx - EID4798PS_3142;
                                    bool2 EID4798PS_4293 = isnan(EID4798PS_3142);
                                    bool2 EID4798PS_4294 = isnan(EID4798PS_3341);
                                    float2 EID4798PS_4295 = min(EID4798PS_3142, EID4798PS_3341);
                                    float2 EID4798PS_4296 = float2(EID4798PS_4293.x ? EID4798PS_3341.x : EID4798PS_4295.x, EID4798PS_4293.y ? EID4798PS_3341.y : EID4798PS_4295.y);
                                    float2 EID4798PS_3342 = float2(EID4798PS_4294.x ? EID4798PS_3142.x : EID4798PS_4296.x, EID4798PS_4294.y ? EID4798PS_3142.y : EID4798PS_4296.y);
                                    float EID4798PS_3343 = EID4798PS_3342.x;
                                    float EID4798PS_3344 = EID4798PS_3342.y;
                                    float EID4798PS_3345 = isnan(EID4798PS_3344) ? EID4798PS_3343 : (isnan(EID4798PS_3343) ? EID4798PS_3344 : min(EID4798PS_3343, EID4798PS_3344));
                                    float EID4798PS_3349 = (EID4798PS_40_m11[EID4798PS_3109].z - EID4798PS_3138) * 0.25f;
                                    float EID4798PS_3351 = smoothstep(0.0f, 0.0500000007450580596923828125f, isnan(EID4798PS_3345) ? EID4798PS_3349 : (isnan(EID4798PS_3349) ? EID4798PS_3345 : min(EID4798PS_3349, EID4798PS_3345)));
                                    EID4798PS_3356 = EID4798PS_3110 ? lerp(1.0f, (any(bool3(EID4798PS_3151.x || EID4798PS_3152.x, EID4798PS_3151.y || EID4798PS_3152.y, EID4798PS_3151.z || EID4798PS_3152.z)) || ((asuint(EID4798PS_3155) & 2147483647u) > 2139095040u)) ? 1.0f : ((((((((((EID4798PS_3252 * EID4798PS_3253) * EID4798ShadowGreater( float3(EID4798PS_3227 + float2(EID4798PS_3228, EID4798PS_3229), EID4798PS_382).xy, EID4798PS_3155)) + ((EID4798PS_3255 * EID4798PS_3253) * EID4798ShadowGreater( float3(EID4798PS_3227 + float2(EID4798PS_3232, EID4798PS_3229), EID4798PS_382).xy, EID4798PS_3155))) + ((EID4798PS_3257 * EID4798PS_3253) * EID4798ShadowGreater( float3(EID4798PS_3227 + float2(EID4798PS_3235, EID4798PS_3229), EID4798PS_382).xy, EID4798PS_3155))) + ((EID4798PS_3252 * EID4798PS_3259) * EID4798ShadowGreater( float3(EID4798PS_3227 + float2(EID4798PS_3228, EID4798PS_3238), EID4798PS_382).xy, EID4798PS_3155))) + ((EID4798PS_3255 * EID4798PS_3259) * EID4798ShadowGreater( float3(EID4798PS_3227 + float2(EID4798PS_3232, EID4798PS_3238), EID4798PS_382).xy, EID4798PS_3155))) + ((EID4798PS_3257 * EID4798PS_3259) * EID4798ShadowGreater( float3(EID4798PS_3227 + float2(EID4798PS_3235, EID4798PS_3238), EID4798PS_382).xy, EID4798PS_3155))) + ((EID4798PS_3252 * EID4798PS_3263) * EID4798ShadowGreater( float3(EID4798PS_3227 + float2(EID4798PS_3228, EID4798PS_3245), EID4798PS_382).xy, EID4798PS_3155))) + ((EID4798PS_3255 * EID4798PS_3263) * EID4798ShadowGreater( float3(EID4798PS_3227 + float2(EID4798PS_3232, EID4798PS_3245), EID4798PS_382).xy, EID4798PS_3155))) + ((EID4798PS_3257 * EID4798PS_3263) * EID4798ShadowGreater( float3(EID4798PS_3227 + float2(EID4798PS_3235, EID4798PS_3245), EID4798PS_382).xy, EID4798PS_3155))), EID4798PS_3060 ? (isnan(EID4798PS_3351) ? EID4798PS_40_m11[EID4798PS_3109].w : (isnan(EID4798PS_40_m11[EID4798PS_3109].w) ? EID4798PS_3351 : min(EID4798PS_40_m11[EID4798PS_3109].w, EID4798PS_3351))) : EID4798PS_40_m11[EID4798PS_3109].w) : 1.0f;
                                }
                                else
                                {
                                    EID4798PS_3356 = clamp(dot(EID4798PS_537, EID4798PS_2895) + 1.0f, 0.0f, 1.0f);
                                }
                                EID4798PS_3357 = EID4798PS_3356;
                            }
                            else
                            {
                                EID4798PS_3357 = 1.0f;
                            }
                            float EID4798PS_3430;
                            float3 EID4798PS_3431;
                            float EID4798PS_3432;
                            float3 EID4798PS_3433;
                            float3 EID4798PS_3434;
                            [branch]
                            if (EID4798PS_2804 == 0u)
                            {
                                float3 EID4798PS_3410 = EID4798PS_38_m6[EID4798PS_2691].xyz * EID4798PS_3033;
                                float EID4798PS_3411 = EID4798PS_3410.x;
                                float EID4798PS_3412 = EID4798PS_3410.y;
                                float EID4798PS_3413 = EID4798PS_3410.z;
                                float EID4798PS_3414 = isnan(EID4798PS_3412) ? EID4798PS_3411 : (isnan(EID4798PS_3411) ? EID4798PS_3412 : max(EID4798PS_3411, EID4798PS_3412));
                                float EID4798PS_3416 = (isnan(EID4798PS_3413) ? EID4798PS_3414 : (isnan(EID4798PS_3414) ? EID4798PS_3413 : max(EID4798PS_3414, EID4798PS_3413))) * lerp(0.75f, 0.5f, EID4798PS_2601);
                                float3 EID4798PS_3423 = EID4798PS_2300.xyz;
                                EID4798PS_3430 = EID4798PS_3033;
                                EID4798PS_3431 = (EID4798PS_38_m6[EID4798PS_2691].xyz * ((1.0f - EID4798PS_38_m6[EID4798PS_2703].y) + ((1.0f / (isnan(EID4798PS_3416) ? 1.0f : (isnan(1.0f) ? EID4798PS_3416 : max(1.0f, EID4798PS_3416)))) * EID4798PS_38_m6[EID4798PS_2703].y))) * lerp(0.25f * EID4798PS_38_m6[EID4798PS_2703].x, 1.0f, clamp(EID4798PS_3053 + 0.5f, 0.0f, 1.0f));
                                EID4798PS_3432 = EID4798PS_3054;
                                EID4798PS_3433 = EID4798PS_3423;
                                EID4798PS_3434 = EID4798PS_3423;
                            }
                            else
                            {
                                float EID4798PS_3405;
                                float EID4798PS_3406;
                                float3 EID4798PS_3407;
                                float3 EID4798PS_3408;
                                if (EID4798PS_2804 == 3u)
                                {
                                    EID4798PS_3405 = EID4798PS_3033 * (smoothstep(0.100000001490116119384765625f, 0.20000000298023223876953125f, (1.0f / ((EID4798PS_20_m2.z * EID4798PS_30.SampleLevel(EID4798_point_clamp_sampler, clamp(EID4798PS_612 + ((EID4798PS_2545 * EID4798PS_38_m6[EID4798PS_2703].x) * 0.006000000052154064178466796875f), EID4798PS_2551, EID4798PS_2552), 0.0f).x) + EID4798PS_20_m2.w)) - EID4798PS_404) * EID4798PS_3357);
                                    EID4798PS_3406 = clamp(dot(EID4798PS_2091, -normalize(cross(EID4798PS_623, cross(EID4798PS_623, EID4798PS_2895)))), 0.0f, 1.0f);
                                    EID4798PS_3407 = lerp(0.5f.xxx, EID4798PS_2097, EID4798PS_38_m6[EID4798PS_2703].y.xxx);
                                    EID4798PS_3408 = 0.0f.xxx;
                                }
                                else
                                {
                                    bool EID4798PS_3366 = EID4798PS_2804 == 1u;
                                    float EID4798PS_3376;
                                    float3 EID4798PS_3377;
                                    if (EID4798PS_3366)
                                    {
                                        EID4798PS_3376 = clamp(clamp(EID4798PS_3053 + EID4798PS_38_m6[EID4798PS_2703].x, -1.0f, 1.0f), 0.0f, 1.0f) * EID4798PS_3357;
                                        EID4798PS_3377 = EID4798PS_2101 * EID4798PS_38_m6[EID4798PS_2703].y;
                                    }
                                    else
                                    {
                                        EID4798PS_3376 = EID4798PS_3054;
                                        EID4798PS_3377 = 0.0f.xxx;
                                    }
                                    bool3 EID4798PS_3378 = EID4798PS_3366.xxx;
                                    EID4798PS_3405 = EID4798PS_3033;
                                    EID4798PS_3406 = EID4798PS_3376;
                                    EID4798PS_3407 = float3(EID4798PS_3378.x ? EID4798PS_2097.x : 0.0f.xxx.x, EID4798PS_3378.y ? EID4798PS_2097.y : 0.0f.xxx.y, EID4798PS_3378.z ? EID4798PS_2097.z : 0.0f.xxx.z);
                                    EID4798PS_3408 = EID4798PS_3377;
                                }
                                EID4798PS_3430 = EID4798PS_3405;
                                EID4798PS_3431 = EID4798PS_38_m6[EID4798PS_2691].xyz;
                                EID4798PS_3432 = EID4798PS_3406;
                                EID4798PS_3433 = EID4798PS_3407;
                                EID4798PS_3434 = EID4798PS_3408;
                            }
                            float3 EID4798PS_3471;
                            [branch]
                            if (EID4798PS_2804 != 3u)
                            {
                                float3 EID4798PS_3439 = EID4798PS_2895 + EID4798PS_423;
                                float EID4798PS_3440 = dot(EID4798PS_3439, EID4798PS_3439);
                                float EID4798PS_3444 = dot(EID4798PS_2322, EID4798PS_3439 * rsqrt(isnan(EID4798PS_3440) ? 6.103515625e-05f : (isnan(6.103515625e-05f) ? EID4798PS_3440 : max(6.103515625e-05f, EID4798PS_3440))));
                                float EID4798PS_3447 = sqrt(1.0f - (EID4798PS_3444 * EID4798PS_3444));
                                float3 EID4798PS_3452 = clamp(pow(isnan(9.9999997473787516355514526367188e-05f) ? EID4798PS_3447 : (isnan(EID4798PS_3447) ? 9.9999997473787516355514526367188e-05f : max(EID4798PS_3447, 9.9999997473787516355514526367188e-05f)), 200.0f).xxx * EID4798PS_468, 0.0f.xxx, 1.0f.xxx);
                                EID4798PS_3471 = (((((((EID4798PS_3452 * EID4798PS_54.SampleLevel(EID4798_linear_clamp_sampler, float2(EID4798PS_3452.x, float(EID4798PS_3444 > 0.0f) * EID4798PS_2339), 0.0f).xyz) * EID4798PS_607) * EID4798PS_2100) * EID4798PS_51_m36) * 5.0f) * EID4798PS_1973) * 1.0f) * EID4798PS_38_m6[EID4798PS_2712].z;
                            }
                            else
                            {
                                EID4798PS_3471 = 0.0f.xxx;
                            }
                            float3 EID4798PS_3474 = EID4798PS_3431 * EID4798PS_3430;
                            EID4798PS_3481 = EID4798PS_2655 + (((EID4798PS_3474 * lerp(EID4798PS_3434, EID4798PS_3433, EID4798PS_3432.xxx)) * EID4798PS_2479) + ((EID4798PS_3474 * EID4798PS_3471) * EID4798PS_3432));
                        }
                        else
                        {
                            EID4798PS_3481 = EID4798PS_2655;
                        }
                        EID4798PS_3482 = EID4798PS_3481;
                        break;
                    } while(false);
                    EID4798PS_3483 = EID4798PS_3482;
                    break;
                } while(false);
                EID4798PS_3484 = EID4798PS_3483;
            }
            else
            {
                EID4798PS_3484 = EID4798PS_2655;
            }
            EID4798PS_2678 = EID4798PS_3484;
        }
    }
    float3 EID4798PS_3524;
    [branch]
    if (EID4798PS_51_m12 > 0.5f)
    {
        EID4798PS_3524 = lerp(lerp(0.5f.xxx, lerp(dot(EID4798PS_2654, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, EID4798PS_2654, EID4798PS_51_m14.xxx), EID4798PS_51_m15.xxx) * EID4798PS_51_m13, EID4798PS_51_m26.xyz, EID4798PS_51_m26.w.xxx) + ((EID4798PS_51_m27.xyz * smoothstep(1.0f - EID4798PS_51_m16, 1.0f, 1.0f - clamp(EID4798PS_2597, 0.0f, 1.0f))) * EID4798PS_51_m17);
    }
    else
    {
        EID4798PS_3524 = EID4798PS_2654;
    }
    float4 EID4798PS_3536 = float4(EID4798PS_3524 * EID4798PS_20_m20.y, EID4798PS_473);
    EID4798PS_3536.w = (EID4798PS_51_m8 == 1.0f) ? EID4798PS_473 : 1.0f;
    float4 EID4798PS_3916;
    [branch]
    if (EID4798PS_20_m91.w < 0.5f)
    {
        float3 EID4798PS_3540 = -EID4798PS_423;
        float EID4798PS_3551 = (EID4798PS_424 * EID4798PS_20_m44.w) - EID4798PS_20_m43.w;
        float EID4798PS_3556 = EID4798PS_655 * EID4798PS_20_m46.w;
        float EID4798PS_3560 = EID4798PS_3556 + EID4798PS_20_m47.w;
        float EID4798PS_3561 = isnan(EID4798PS_3560) ? 0.00999999977648258209228515625f : (isnan(0.00999999977648258209228515625f) ? EID4798PS_3560 : max(0.00999999977648258209228515625f, EID4798PS_3560));
        float3 EID4798PS_3575 = exp(EID4798PS_20_m45.xyz * ((-(isnan(EID4798PS_3551) ? 0.0f : (isnan(0.0f) ? EID4798PS_3551 : max(0.0f, EID4798PS_3551)))) * (((1.0f - exp(-EID4798PS_3561)) / EID4798PS_3561) * exp(EID4798PS_3556 + EID4798PS_20_m48.w))));
        float EID4798PS_3578 = dot(EID4798PS_3540, EID4798PS_20_m44.xyz);
        float EID4798PS_3584 = EID4798PS_20_m45.w * EID4798PS_20_m45.w;
        float EID4798PS_3588 = (1.0f + EID4798PS_3584) - ((2.0f * EID4798PS_20_m45.w) * EID4798PS_3578);
        float EID4798PS_3592 = (12.56637096405029296875f * EID4798PS_3588) * sqrt(EID4798PS_3588);
        float3 EID4798PS_3908;
        float EID4798PS_3909;
        if (EID4798PS_20_m55.z > 0.0f)
        {
            uint3 EID4798PS_3739 = (uint3(int3(EID4798PS_2165, EID4798PS_2166, int(EID4798PS_20_m19 & 7u))) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint EID4798PS_3740 = EID4798PS_3739.y;
            uint EID4798PS_3741 = EID4798PS_3739.z;
            uint EID4798PS_3744 = EID4798PS_3739.x + (EID4798PS_3740 * EID4798PS_3741);
            uint EID4798PS_3746 = EID4798PS_3740 + (EID4798PS_3741 * EID4798PS_3744);
            uint EID4798PS_3748 = EID4798PS_3741 + (EID4798PS_3744 * EID4798PS_3746);
            uint EID4798PS_3750 = EID4798PS_3744 + (EID4798PS_3746 * EID4798PS_3748);
            float EID4798PS_3772 = dot(EID4798PS_3540, -EID4798PS_18_m0[2].xyz);
            float3 EID4798PS_3779 = EID4798PS_530 - EID4798PS_18_m11.xyz;
            float EID4798PS_3781 = (EID4798PS_20_m55.w * ((EID4798PS_3772 > 5.9604644775390625e-08f) ? (1.0f / EID4798PS_3772) : 0.0f)) * (1.0f / EID4798PS_424);
            float EID4798PS_3782 = EID4798PS_3779.y;
            float EID4798PS_3783 = EID4798PS_3781 * EID4798PS_3782;
            float EID4798PS_3785 = EID4798PS_18_m11.y + EID4798PS_3783;
            float EID4798PS_3786 = EID4798PS_3782 - EID4798PS_3783;
            float EID4798PS_3788 = (1.0f - EID4798PS_3781) * EID4798PS_424;
            float EID4798PS_3794 = EID4798PS_20_m49.z * (EID4798PS_3785 - EID4798PS_20_m49.x);
            float EID4798PS_3801 = EID4798PS_20_m49.z * EID4798PS_3786;
            float EID4798PS_3802 = isnan(EID4798PS_3801) ? (-127.0f) : (isnan(-127.0f) ? EID4798PS_3801 : max(-127.0f, EID4798PS_3801));
            float EID4798PS_3818 = EID4798PS_20_m52.x * (EID4798PS_3785 - EID4798PS_20_m52.z);
            float EID4798PS_3825 = EID4798PS_20_m52.x * EID4798PS_3786;
            float EID4798PS_3826 = isnan(EID4798PS_3825) ? (-127.0f) : (isnan(-127.0f) ? EID4798PS_3825 : max(-127.0f, EID4798PS_3825));
            float EID4798PS_3837 = ((EID4798PS_20_m49.y * exp2(-(isnan(EID4798PS_3794) ? (-127.0f) : (isnan(-127.0f) ? EID4798PS_3794 : max(-127.0f, EID4798PS_3794))))) * ((abs(EID4798PS_3802) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-EID4798PS_3802)) / EID4798PS_3802) : (0.693147182464599609375f - (0.2402265071868896484375f * EID4798PS_3802)))) + ((EID4798PS_20_m52.y * exp2(-(isnan(EID4798PS_3818) ? (-127.0f) : (isnan(-127.0f) ? EID4798PS_3818 : max(-127.0f, EID4798PS_3818))))) * ((abs(EID4798PS_3826) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-EID4798PS_3826)) / EID4798PS_3826) : (0.693147182464599609375f - (0.2402265071868896484375f * EID4798PS_3826))));
            float EID4798PS_3841 = clamp(exp2(-(EID4798PS_3837 * EID4798PS_3788)), 0.0f, 1.0f);
            float EID4798PS_3859 = clamp((EID4798PS_424 * EID4798PS_20_m50.w) + EID4798PS_20_m50.z, 0.0f, 1.0f);
            float EID4798PS_3862 = clamp(((isnan(EID4798PS_20_m51.w) ? EID4798PS_3841 : (isnan(EID4798PS_3841) ? EID4798PS_20_m51.w : max(EID4798PS_3841, EID4798PS_20_m51.w))) + clamp((EID4798PS_424 * EID4798PS_20_m50.y) + EID4798PS_20_m50.x, 0.0f, 1.0f)) + EID4798PS_3859, 0.0f, 1.0f);
            float EID4798PS_3881 = EID4798PS_3788 - EID4798PS_20_m53.w;
            float4 EID4798PS_3902 = lerp(float4(0.0f, 0.0f, 0.0f, 1.0f), EID4798PS_64.SampleLevel(EID4798_linear_clamp_sampler, float3((EID4798PS_2629 + ((((float3(uint3(EID4798PS_3750, EID4798PS_3746 + (EID4798PS_3748 * EID4798PS_3750), EID4798PS_388) >> uint3(16u, 16u, 16u)) * 1.525902189314365386962890625e-05f.xxx) * 2.0f) - 1.0f.xxx) * EID4798PS_20_m59.w).xy) * EID4798PS_20_m57.xy, (log2((EID4798PS_404 * EID4798PS_20_m56.x) + EID4798PS_20_m56.y) * EID4798PS_20_m56.z) / EID4798PS_20_m55.z), 0.0f), clamp((EID4798PS_404 - EID4798PS_20_m58.z) * 1000000.0f, 0.0f, 1.0f).xxxx);
            float EID4798PS_3904 = EID4798PS_3902.w;
            EID4798PS_3908 = EID4798PS_3902.xyz + (((EID4798PS_20_m51.xyz * (1.0f - EID4798PS_3862)) + (((EID4798PS_20_m54.xyz * pow(clamp(dot(EID4798PS_423, EID4798PS_20_m53.xyz), 0.0f, 1.0f), EID4798PS_20_m54.w)) * (1.0f - clamp(exp2(-(EID4798PS_3837 * (isnan(0.0f) ? EID4798PS_3881 : (isnan(EID4798PS_3881) ? 0.0f : max(EID4798PS_3881, 0.0f))))), 0.0f, 1.0f))) * (1.0f - EID4798PS_3859))) * EID4798PS_3904);
            EID4798PS_3909 = EID4798PS_3904 * EID4798PS_3862;
        }
        else
        {
            float3 EID4798PS_3615 = EID4798PS_530 - EID4798PS_18_m11.xyz;
            float EID4798PS_3617 = EID4798PS_3615.y;
            float EID4798PS_3623 = EID4798PS_20_m49.z * (EID4798PS_18_m11.y - EID4798PS_20_m49.x);
            float EID4798PS_3630 = EID4798PS_20_m49.z * EID4798PS_3617;
            float EID4798PS_3631 = isnan(EID4798PS_3630) ? (-127.0f) : (isnan(-127.0f) ? EID4798PS_3630 : max(-127.0f, EID4798PS_3630));
            float EID4798PS_3647 = EID4798PS_20_m52.x * (EID4798PS_18_m11.y - EID4798PS_20_m52.z);
            float EID4798PS_3654 = EID4798PS_20_m52.x * EID4798PS_3617;
            float EID4798PS_3655 = isnan(EID4798PS_3654) ? (-127.0f) : (isnan(-127.0f) ? EID4798PS_3654 : max(-127.0f, EID4798PS_3654));
            float EID4798PS_3666 = ((EID4798PS_20_m49.y * exp2(-(isnan(EID4798PS_3623) ? (-127.0f) : (isnan(-127.0f) ? EID4798PS_3623 : max(-127.0f, EID4798PS_3623))))) * ((abs(EID4798PS_3631) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-EID4798PS_3631)) / EID4798PS_3631) : (0.693147182464599609375f - (0.2402265071868896484375f * EID4798PS_3631)))) + ((EID4798PS_20_m52.y * exp2(-(isnan(EID4798PS_3647) ? (-127.0f) : (isnan(-127.0f) ? EID4798PS_3647 : max(-127.0f, EID4798PS_3647))))) * ((abs(EID4798PS_3655) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-EID4798PS_3655)) / EID4798PS_3655) : (0.693147182464599609375f - (0.2402265071868896484375f * EID4798PS_3655))));
            float EID4798PS_3670 = clamp(exp2(-(EID4798PS_3666 * EID4798PS_424)), 0.0f, 1.0f);
            float EID4798PS_3688 = clamp((EID4798PS_424 * EID4798PS_20_m50.w) + EID4798PS_20_m50.z, 0.0f, 1.0f);
            float EID4798PS_3691 = clamp(((isnan(EID4798PS_20_m51.w) ? EID4798PS_3670 : (isnan(EID4798PS_3670) ? EID4798PS_20_m51.w : max(EID4798PS_3670, EID4798PS_20_m51.w))) + clamp((EID4798PS_424 * EID4798PS_20_m50.y) + EID4798PS_20_m50.x, 0.0f, 1.0f)) + EID4798PS_3688, 0.0f, 1.0f);
            float EID4798PS_3710 = EID4798PS_424 - EID4798PS_20_m53.w;
            EID4798PS_3908 = (EID4798PS_20_m51.xyz * (1.0f - EID4798PS_3691)) + (((EID4798PS_20_m54.xyz * pow(clamp(dot(EID4798PS_423, EID4798PS_20_m53.xyz), 0.0f, 1.0f), EID4798PS_20_m54.w)) * (1.0f - clamp(exp2(-(EID4798PS_3666 * (isnan(0.0f) ? EID4798PS_3710 : (isnan(EID4798PS_3710) ? 0.0f : max(EID4798PS_3710, 0.0f))))), 0.0f, 1.0f))) * (1.0f - EID4798PS_3688));
            EID4798PS_3909 = EID4798PS_3691;
        }
        float3 EID4798PS_3914 = (EID4798PS_3536.xyz * (EID4798PS_3575 * EID4798PS_3909)) + ((((clamp(((EID4798PS_20_m46.xyz * (0.0596831031143665313720703125f * (1.0f + (EID4798PS_3578 * EID4798PS_3578)))) + EID4798PS_20_m48.xyz) + (EID4798PS_20_m47.xyz * ((1.0f - EID4798PS_3584) / (isnan(0.001000000047497451305389404296875f) ? EID4798PS_3592 : (isnan(EID4798PS_3592) ? 0.001000000047497451305389404296875f : max(EID4798PS_3592, 0.001000000047497451305389404296875f))))), 0.0f.xxx, 1.0f.xxx) * 255.0f) * (1.0f.xxx - EID4798PS_3575)) * EID4798PS_3909) + EID4798PS_3908);
        EID4798PS_3916 = float4(EID4798PS_3914.x, EID4798PS_3914.y, EID4798PS_3914.z, EID4798PS_3536.w);
    }
    else
    {
        EID4798PS_3916 = EID4798PS_3536;
    }
    EID4798PS_15 = EID4798PS_3916;
    EID4798PS_16 = EID4798PS_2132;

}

EID4798PS_SPIRV_Cross_Output EID4798PS_main(EID4798PS_SPIRV_Cross_Input stage_input)
{
    EID4798PS_gl_FragCoord = stage_input.EID4798PS_gl_FragCoord;
    EID4798PS_gl_FragCoord.w = 1.0 / EID4798PS_gl_FragCoord.w;
    EID4798PS_gl_FrontFacing = stage_input.EID4798PS_gl_FrontFacing;
    EID4798PS_3 = stage_input.EID4798PS_3;
    EID4798PS_4 = stage_input.EID4798PS_4;
    EID4798PS_5 = stage_input.EID4798PS_5;
    EID4798PS_6 = stage_input.EID4798PS_6;
    EID4798PS_7 = stage_input.EID4798PS_7;
    EID4798PS_8 = stage_input.EID4798PS_8;
    EID4798PS_9 = stage_input.EID4798PS_9;
    EID4798PS_10 = stage_input.EID4798PS_10;
    EID4798PS_11 = stage_input.EID4798PS_11;
    EID4798PS_13 = stage_input.EID4798PS_13;
    EID4798PS_frag_main();
    EID4798PS_SPIRV_Cross_Output stage_output;
    stage_output.EID4798PS_15 = EID4798PS_15;
    stage_output.EID4798PS_16 = EID4798PS_16;
    return stage_output;
}
