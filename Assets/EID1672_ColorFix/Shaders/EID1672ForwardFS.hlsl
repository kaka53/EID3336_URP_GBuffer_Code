// Generated from EID4765 VS215999/PS216000. See .rdctools/build_eid4765.py.
struct FS_21
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

static const int2 FS_344[6] = { int2(2, 1), int2(2, 1), int2(0, 2), int2(0, 2), int2(0, 1), int2(0, 1) };
static const float2 FS_345[6] = { float2(-1.0f, 1.0f), 1.0f.xx, float2(1.0f, -1.0f), 1.0f.xx, 1.0f.xx, float2(-1.0f, 1.0f) };

cbuffer FS_16_17 : register(b4)
{
    column_major float4x4 FS_17_m0 : packoffset(c0);
    column_major float4x4 FS_17_m1 : packoffset(c4);
    column_major float4x4 FS_17_m2 : packoffset(c8);
    column_major float4x4 FS_17_m3 : packoffset(c12);
    column_major float4x4 FS_17_m4 : packoffset(c16);
    column_major float4x4 FS_17_m5 : packoffset(c20);
    column_major float4x4 FS_17_m6 : packoffset(c24);
    column_major float4x4 FS_17_m7 : packoffset(c28);
    column_major float4x4 FS_17_m8 : packoffset(c32);
    column_major float4x4 FS_17_m9 : packoffset(c36);
    column_major float4x4 FS_17_m10 : packoffset(c40);
    float4 FS_17_m11 : packoffset(c44);
    column_major float4x4 FS_17_m12 : packoffset(c45);
    column_major float4x4 FS_17_m13 : packoffset(c49);
    column_major float4x4 FS_17_m14 : packoffset(c53);
    column_major float4x4 FS_17_m15 : packoffset(c57);
    column_major float4x4 FS_17_m16 : packoffset(c61);
    column_major float4x4 FS_17_m17 : packoffset(c65);
    column_major float4x4 FS_17_m18 : packoffset(c69);
    column_major float4x4 FS_17_m19 : packoffset(c73);
    column_major float4x4 FS_17_m20 : packoffset(c77);
    float4 FS_17_m21 : packoffset(c81);
};

cbuffer FS_18_19 : register(b5)
{
    float4 FS_19_m0 : packoffset(c0);
    float4 FS_19_m1 : packoffset(c1);
    float4 FS_19_m2 : packoffset(c2);
    float4 FS_19_m3 : packoffset(c3);
    float4 FS_19_m4 : packoffset(c4);
    float4 FS_19_m5 : packoffset(c5);
    float4 FS_19_m6[6] : packoffset(c6);
    float4 FS_19_m7[6] : packoffset(c12);
    float4 FS_19_m8 : packoffset(c18);
    float4 FS_19_m9 : packoffset(c19);
    float4 FS_19_m10 : packoffset(c20);
    float4 FS_19_m11 : packoffset(c21);
    float4 FS_19_m12 : packoffset(c22);
    float4 FS_19_m13 : packoffset(c23);
    float4 FS_19_m14 : packoffset(c24);
    float4 FS_19_m15 : packoffset(c25);
    float FS_19_m16 : packoffset(c26);
    float FS_19_m17 : packoffset(c26.y);
    float FS_19_m18 : packoffset(c26.z);
    uint FS_19_m19 : packoffset(c26.w);
    float4 FS_19_m20 : packoffset(c27);
    int4 FS_19_m21 : packoffset(c28);
    float4 FS_19_m22 : packoffset(c29);
    float4 FS_19_m23 : packoffset(c30);
    float4 FS_19_m24 : packoffset(c31);
    float4 FS_19_m25 : packoffset(c32);
    float4 FS_19_m26 : packoffset(c33);
    float4 FS_19_m27 : packoffset(c34);
    float4 FS_19_m28 : packoffset(c35);
    float4 FS_19_m29 : packoffset(c36);
    float4 FS_19_m30 : packoffset(c37);
    float4 FS_19_m31 : packoffset(c38);
    float4 FS_19_m32[4] : packoffset(c39);
    float4 FS_19_m33[4] : packoffset(c43);
    float4 FS_19_m34[4] : packoffset(c47);
    float4 FS_19_m35[4] : packoffset(c51);
    float4 FS_19_m36 : packoffset(c55);
    float4 FS_19_m37 : packoffset(c56);
    float4 FS_19_m38[4] : packoffset(c57);
    float4 FS_19_m39[4] : packoffset(c61);
    float4 FS_19_m40[4] : packoffset(c65);
    float4 FS_19_m41 : packoffset(c69);
    float4 FS_19_m42 : packoffset(c70);
    float4 FS_19_m43 : packoffset(c71);
    float4 FS_19_m44 : packoffset(c72);
    float4 FS_19_m45 : packoffset(c73);
    float4 FS_19_m46 : packoffset(c74);
    float4 FS_19_m47 : packoffset(c75);
    float4 FS_19_m48 : packoffset(c76);
    float4 FS_19_m49 : packoffset(c77);
    float4 FS_19_m50 : packoffset(c78);
    float4 FS_19_m51 : packoffset(c79);
    float4 FS_19_m52 : packoffset(c80);
    float4 FS_19_m53 : packoffset(c81);
    float4 FS_19_m54 : packoffset(c82);
    float4 FS_19_m55 : packoffset(c83);
    float4 FS_19_m56 : packoffset(c84);
    float4 FS_19_m57 : packoffset(c85);
    float4 FS_19_m58 : packoffset(c86);
    float4 FS_19_m59 : packoffset(c87);
    float4 FS_19_m60 : packoffset(c88);
    float4 FS_19_m61 : packoffset(c89);
    float4 FS_19_m62 : packoffset(c90);
    float4 FS_19_m63 : packoffset(c91);
    float4 FS_19_m64 : packoffset(c92);
    float4 FS_19_m65 : packoffset(c93);
    float4 FS_19_m66 : packoffset(c94);
    float4 FS_19_m67 : packoffset(c95);
    float4 FS_19_m68 : packoffset(c96);
    float4 FS_19_m69 : packoffset(c97);
    float4 FS_19_m70 : packoffset(c98);
    float4 FS_19_m71 : packoffset(c99);
    float4 FS_19_m72 : packoffset(c100);
    float4 FS_19_m73 : packoffset(c101);
    float4 FS_19_m74 : packoffset(c102);
    float4 FS_19_m75 : packoffset(c103);
    float4 FS_19_m76 : packoffset(c104);
    float4 FS_19_m77 : packoffset(c105);
    float4 FS_19_m78 : packoffset(c106);
    float4 FS_19_m79 : packoffset(c107);
    float4 FS_19_m80 : packoffset(c108);
    float4 FS_19_m81 : packoffset(c109);
    float4 FS_19_m82 : packoffset(c110);
    float4 FS_19_m83 : packoffset(c111);
    float4 FS_19_m84 : packoffset(c112);
    float4 FS_19_m85 : packoffset(c113);
    float4 FS_19_m86 : packoffset(c114);
    float4 FS_19_m87 : packoffset(c115);
    float4 FS_19_m88 : packoffset(c116);
    float4 FS_19_m89 : packoffset(c117);
    float4 FS_19_m90 : packoffset(c118);
    float4 FS_19_m91 : packoffset(c119);
    float4 FS_19_m92 : packoffset(c120);
    float4 FS_19_m93 : packoffset(c121);
    float4 FS_19_m94 : packoffset(c122);
    float4 FS_19_m95 : packoffset(c123);
    float4 FS_19_m96 : packoffset(c124);
    float4 FS_19_m97 : packoffset(c125);
    float4 FS_19_m98 : packoffset(c126);
    float4 FS_19_m99[2] : packoffset(c127);
    float4 FS_19_m100[2] : packoffset(c129);
    float FS_19_m101 : packoffset(c131);
    float FS_19_m102 : packoffset(c131.y);
    float FS_19_m103 : packoffset(c131.z);
    float FS_19_m104 : packoffset(c131.w);
    float4 FS_19_m105 : packoffset(c132);
    float4 FS_19_m106 : packoffset(c133);
    float4 FS_19_m107 : packoffset(c134);
    float4 FS_19_m108 : packoffset(c135);
    float4 FS_19_m109 : packoffset(c136);
    float4 FS_19_m110 : packoffset(c137);
    float4 FS_19_m111 : packoffset(c138);
    float4 FS_19_m112 : packoffset(c139);
    float4 FS_19_m113 : packoffset(c140);
    float4 FS_19_m114 : packoffset(c141);
    float4 FS_19_m115 : packoffset(c142);
    float4 FS_19_m116 : packoffset(c143);
    float4 FS_19_m117 : packoffset(c144);
    float4 FS_19_m118 : packoffset(c145);
    float4 FS_19_m119 : packoffset(c146);
    float4 FS_19_m120 : packoffset(c147);
    float4 FS_19_m121 : packoffset(c148);
    float4 FS_19_m122 : packoffset(c149);
    float4 FS_19_m123 : packoffset(c150);
    float4 FS_19_m124 : packoffset(c151);
    float4 FS_19_m125 : packoffset(c152);
    float4 FS_19_m126 : packoffset(c153);
    float4 FS_19_m127 : packoffset(c154);
    float4 FS_19_m128 : packoffset(c155);
    float4 FS_19_m129 : packoffset(c156);
    float4 FS_19_m130 : packoffset(c157);
    float4 FS_19_m131 : packoffset(c158);
    float4 FS_19_m132 : packoffset(c159);
    float4 FS_19_m133 : packoffset(c160);
    float4 FS_19_m134 : packoffset(c161);
    column_major float4x4 FS_19_m135 : packoffset(c162);
    float4 FS_19_m136 : packoffset(c166);
    float4 FS_19_m137 : packoffset(c167);
    float4 FS_19_m138[32] : packoffset(c168);
};

cbuffer FS_20_22 : register(b6)
{
    float4 FS_22_m0_words[4096] : packoffset(c0);
};

ByteAddressBuffer FS_30;
ByteAddressBuffer FS_32;
cbuffer FS_33_34 : register(b7)
{
    int FS_34_m0 : packoffset(c0);
    int FS_34_m1 : packoffset(c0.y);
    int FS_34_m2 : packoffset(c0.z);
    int FS_34_m3 : packoffset(c0.w);
    float FS_34_m4 : packoffset(c1);
    float FS_34_m5 : packoffset(c1.y);
    float FS_34_m6 : packoffset(c1.z);
    float FS_34_m7 : packoffset(c1.w);
    float FS_34_m8 : packoffset(c2);
    float FS_34_m9 : packoffset(c2.y);
    float FS_34_m10 : packoffset(c2.z);
    float FS_34_m11 : packoffset(c2.w);
};

cbuffer FS_35_36 : register(b8)
{
    float4 FS_36_m0 : packoffset(c0);
    float4 FS_36_m1 : packoffset(c1);
    float4 FS_36_m2 : packoffset(c2);
    float4 FS_36_m3 : packoffset(c3);
    float4 FS_36_m4 : packoffset(c4);
    uint4 FS_36_m5 : packoffset(c5);
    float4 FS_36_m6[2048] : packoffset(c6);
};

cbuffer FS_37_38 : register(b9)
{
    column_major float4x4 FS_38_m0[5] : packoffset(c0);
    float4 FS_38_m1[4] : packoffset(c20);
    float4 FS_38_m2[4] : packoffset(c24);
    float4 FS_38_m3[4] : packoffset(c28);
    float4 FS_38_m4 : packoffset(c32);
    float4 FS_38_m5 : packoffset(c33);
    float4 FS_38_m6 : packoffset(c34);
    float4 FS_38_m7 : packoffset(c35);
    float4 FS_38_m8 : packoffset(c36);
    float4 FS_38_m9[27] : packoffset(c37);
    column_major float4x4 FS_38_m10[56] : packoffset(c64);
    float4 FS_38_m11[56] : packoffset(c288);
    float4 FS_38_m12[56] : packoffset(c344);
    float4 FS_38_m13 : packoffset(c400);
    float4 FS_38_m14[47] : packoffset(c401);
    column_major float4x4 FS_38_m15[15] : packoffset(c448);
    float4 FS_38_m16[15] : packoffset(c508);
    float4 FS_38_m17[15] : packoffset(c523);
    float4 FS_38_m18[15] : packoffset(c538);
    float4 FS_38_m19 : packoffset(c553);
    float4 FS_38_m20 : packoffset(c554);
    float4 FS_38_m21[21] : packoffset(c555);
    column_major float4x4 FS_38_m22 : packoffset(c576);
    column_major float4x4 FS_38_m23 : packoffset(c580);
    float4 FS_38_m24 : packoffset(c584);
    float4 FS_38_m25 : packoffset(c585);
    float4 FS_38_m26 : packoffset(c586);
    float4 FS_38_m27[128] : packoffset(c587);
};

#if !defined(EID_LIVE_PER_MATERIAL)
cbuffer FS_48_49 : register(b10)
{
    float FS_49_m0 : packoffset(c0);
    float FS_49_m1 : packoffset(c0.y);
    float FS_49_m2 : packoffset(c0.z);
    float FS_49_m3 : packoffset(c0.w);
    float FS_49_m4 : packoffset(c1);
    float FS_49_m5 : packoffset(c1.y);
    float FS_49_m6 : packoffset(c1.z);
    float FS_49_m7 : packoffset(c1.w);
    float FS_49_m8 : packoffset(c2);
    float FS_49_m9 : packoffset(c2.y);
    float FS_49_m10 : packoffset(c2.z);
    float FS_49_m11 : packoffset(c2.w);
    float FS_49_m12 : packoffset(c3);
    float FS_49_m13 : packoffset(c3.y);
    float FS_49_m14 : packoffset(c3.z);
    float FS_49_m15 : packoffset(c3.w);
    float FS_49_m16 : packoffset(c4);
    float FS_49_m17 : packoffset(c4.y);
    float FS_49_m18 : packoffset(c4.z);
    float FS_49_m19 : packoffset(c4.w);
    float FS_49_m20 : packoffset(c5);
    float FS_49_m21 : packoffset(c5.y);
    float FS_49_m22 : packoffset(c5.z);
    float FS_49_m23 : packoffset(c5.w);
    float4 FS_49_m24 : packoffset(c6);
    float4 FS_49_m25 : packoffset(c7);
    float4 FS_49_m26 : packoffset(c8);
    float4 FS_49_m27 : packoffset(c9);
    float4 FS_49_m28 : packoffset(c10);
    float4 FS_49_m29 : packoffset(c11);
    float FS_49_m30 : packoffset(c12);
    float FS_49_m31 : packoffset(c12.y);
    float FS_49_m32 : packoffset(c12.z);
    float FS_49_m33 : packoffset(c12.w);
    float4 FS_49_m34 : packoffset(c13);
    float FS_49_m35 : packoffset(c14);
    float FS_49_m36 : packoffset(c14.y);
    float FS_49_m37 : packoffset(c14.z);
    float FS_49_m38 : packoffset(c14.w);
    float4 FS_49_m39 : packoffset(c15);
    float4 FS_49_m40 : packoffset(c16);
    float4 FS_49_m41 : packoffset(c17);
    float4 FS_49_m42 : packoffset(c18);
    float4 FS_49_m43 : packoffset(c19);
    float4 FS_49_m44 : packoffset(c20);
    float4 FS_49_m45 : packoffset(c21);
    float FS_49_m46 : packoffset(c22);
    float FS_49_m47 : packoffset(c22.y);
    float FS_49_m48 : packoffset(c22.z);
    float FS_49_m49 : packoffset(c22.w);
    float FS_49_m50 : packoffset(c23);
    float FS_49_m51 : packoffset(c23.y);
    float FS_49_m52 : packoffset(c23.z);
    float FS_49_m53 : packoffset(c23.w);
};
#endif

cbuffer FS_62_63 : register(b11)
{
    float4 FS_63_m0[32] : packoffset(c0);
    column_major float4x4 FS_63_m1[32] : packoffset(c32);
};

SamplerState sampler_PointRepeat;
SamplerState sampler_LinearClamp;
SamplerState sampler_LinearRepeat;

Texture2D<float4> FS_39;
Texture2D<float4> FS_40;
Texture3D<float4> FS_42;
Texture3D<float4> FS_43;
Texture3D<float4> FS_44;
Texture3D<float4> FS_45;
Texture3D<float4> FS_46;
Texture3D<float4> FS_47;
Texture2D<float4> FS4765_50;
Texture2D<float4> FS4765_51;
Texture2D<float4> FS4765_52;
Texture2D<float4> FS4765_53;
Texture2D<float4> FS4765_54;
Texture2D<float4> FS4765_55;
Texture2D<float4> FS_54;
Texture2D<float4> FS_55;
Texture2D<float4> FS_58;
Texture2D<float4> FS_59;
Texture2D<float4> FS4765_60;
Texture2D<float4> FS4765_61;
Texture2D<float4> FS_61;
Texture3D<float4> FS_66;

static float4 FSgl_FragCoord;
static bool FSgl_FrontFacing;
static float2 FS_3;
static float3 FS_4;
static float3 FS_5;
static float4 FS_6;
static float3 FS_7;
static float3 FS_8;
static float3 FS_9;
static float3 FS_10;
static uint FS_12;
static float4 FS_14;
static float4 FS_15;

struct FSSPIRV_Cross_Input
{
    float2 FS_3 : TEXCOORD0;
    float3 FS_4 : TEXCOORD1;
    float3 FS_5 : TEXCOORD2;
    float4 FS_6 : TEXCOORD3;
    float3 FS_7 : TEXCOORD4;
    float3 FS_8 : TEXCOORD5;
    float3 FS_9 : TEXCOORD6;
    float3 FS_10 : TEXCOORD7;
    nointerpolation uint FS_12 : TEXCOORD8;
    float4 FSgl_FragCoord : SV_Position;
    bool FSgl_FrontFacing : SV_IsFrontFace;
};

struct FSSPIRV_Cross_Output
{
    float4 FS_14 : SV_Target0;
    float4 FS_15 : SV_Target1;
};

static float3 FS_369;
static float FS_370;
static float3 FS_371;
static float FS_374;
static uint FS_375;

uint spvPackHalf2x16(float2 value)
{
    uint2 Packed = f32tof16(value);
    return Packed.x | (Packed.y << 16);
}

float2 spvUnpackHalf2x16(uint value)
{
    return f16tof32(uint2(value & 0xffff, value >> 16));
}

FS_21 FSGetInstance(uint index)
{
#if defined(EID_LIVE_PER_MATERIAL)
 // EID1672 / EID4765: restore the complete captured instance, not a zero basis.
 // M remains driven by the Unity object. Flags and packed indices retain their exact bits.
 FS_21 v = (FS_21)0;
 v._m0 = unity_ObjectToWorld;
 v._m3 = unity_ObjectToWorld;
 v._m1 = asfloat(uint4(0x447a0000u,0x00000000u,0x00000000u,0x00000034u));
 v._m2 = asfloat(uint4(0x00005654u,0x00003b6cu,0x00000202u,0x3f800000u));
 v._m4 = asfloat(uint4(0x3f800000u,0x3f800000u,0x00000000u,0x00000000u));
 v._m5 = asfloat(uint4(0x00000039u,0x00000000u,0x00000000u,0x00000000u));
 v._m6 = asfloat(uint4(0x00000000u,0x00000000u,0x00000000u,0x00000000u));
 v._m7 = asfloat(uint4(0x00000000u,0x00000000u,0x00000000u,0x00000000u));
 v._m8 = asfloat(uint4(0x00000000u,0x00000000u,0x00000000u,0x00000000u));
 v._m9 = asfloat(uint4(0x00000000u,0x00000000u,0x00000000u,0x00000000u));
 return v;
#else
 FS_21 v; uint b=index*16u;
 v._m0 = transpose(float4x4(FS_22_m0_words[b+0], FS_22_m0_words[b+1], FS_22_m0_words[b+2], FS_22_m0_words[b+3]));
 v._m1 = FS_22_m0_words[b+4];
 v._m2 = FS_22_m0_words[b+5];
 v._m3 = transpose(float4x4(FS_22_m0_words[b+6], FS_22_m0_words[b+7], FS_22_m0_words[b+8], FS_22_m0_words[b+9]));
 v._m4 = FS_22_m0_words[b+10];
 v._m5 = FS_22_m0_words[b+11];
 v._m6 = FS_22_m0_words[b+12];
 v._m7 = FS_22_m0_words[b+13];
 v._m8 = FS_22_m0_words[b+14];
 v._m9 = FS_22_m0_words[b+15];
 return v;
#endif
}
// Exact four-tap linear PCF for captured VK_COMPARE_OP_GREATER + CLAMP_TO_EDGE.
float EIDShadowCompare(float2 uv, float reference)
{
 uint w,h; FS_39.GetDimensions(w,h); float2 p=uv*float2(w,h)-0.5;
 int2 q=int2(floor(p)); float2 a=frac(p); int2 hi=int2(w,h)-1;
 float d00=FS_39.Load(int3(clamp(q,int2(0,0),hi),0)).x;
 float d10=FS_39.Load(int3(clamp(q+int2(1,0),int2(0,0),hi),0)).x;
 float d01=FS_39.Load(int3(clamp(q+int2(0,1),int2(0,0),hi),0)).x;
 float d11=FS_39.Load(int3(clamp(q+int2(1,1),int2(0,0),hi),0)).x;
 return lerp(lerp(reference>d00?1.0:0.0,reference>d10?1.0:0.0,a.x),lerp(reference>d01?1.0:0.0,reference>d11?1.0:0.0,a.x),a.y);
}
void EIDEarlyExit0(inout float3 FS_1272, inout float FS_1436, inout float FS_1439, inout float3 FS_1442, inout float3 FS_1445, inout float3 FS_1446, inout float FS_1448, inout float FS_1525, inout float3 FS_1579, inout float FS_1580, inout float FS_1656, inout float4 FS_1716, inout float FS_1753, inout float FS_1755, inout float FS_1861, inout float FS_1866, inout float3 FS_1932, inout int FS_1968, inout int FS_1971, inout int FS_1974, inout int FS_1977, inout int FS_1980, inout int FS_1989, inout uint FS_1993, inout uint FS_2081, inout bool FS_2093, inout bool FS_2098, inout float3 FS_2172, inout float FS_2310, inout float3 FS_2783, inout float3 FS_409, inout float FS_516, inout float FS_518, inout float3 FS_546, inout float3 FS_553, inout float3 FS_574, inout float3 FS_586, inout float3 FS_648)
{
                        float3 FS_2782;
                        [branch]
                        if (FS_2310 > 9.9999997473787516355514526367188e-05f)
                        {
                            [branch]
                            if (FS_2098)
                            {
                                FS_2783 = lerp(FS_1932, FS_36_m6[FS_1968].xyz, (FS_2310 * (FS_36_m6[FS_1980].x * ((1.0f - FS_36_m6[FS_1980].w) + (smoothstep(-0.5f, 0.5f, dot(FS_574, FS_2172)) * FS_36_m6[FS_1980].w)))).xxx);
                                return;
                            }
                            float FS_2330 = dot(FS_1579, FS_2172);
                            float FS_2331 = clamp(FS_2330, 0.0f, 1.0f);
                            float FS_2634;
                            if (FS_2081 != 0u)
                            {
                                bool FS_2337 = FS_2093 || ((FS_1993 & 2u) != 0u);
                                int FS_2386;
                                if (FS_2337)
                                {
                                    FS_2386 = int(FS_36_m6[FS_1977].x);
                                }
                                else
                                {
                                    uint FS_2341 = asuint(FS_36_m6[FS_1974].w);
                                    uint FS_2343 = asuint(FS_36_m6[FS_1977].x);
                                    float3 FS_2344 = FS_546 - FS_36_m6[FS_1971].xyz;
                                    float3 FS_2345 = abs(FS_2344);
                                    float FS_2346 = FS_2345.x;
                                    float FS_2347 = FS_2345.y;
                                    float FS_2349 = FS_2345.z;
                                    int FS_2381;
                                    if ((FS_2346 > FS_2347) && (FS_2346 > FS_2349))
                                    {
                                        FS_2381 = int((FS_2344.x > 0.0f) ? (FS_2341 >> 24u) : ((FS_2341 >> 16u) & 255u));
                                    }
                                    else
                                    {
                                        int FS_2373;
                                        if (FS_2347 > FS_2349)
                                        {
                                            FS_2373 = int((FS_2344.y > 0.0f) ? ((FS_2341 >> 8u) & 255u) : (FS_2341 & 255u));
                                        }
                                        else
                                        {
                                            FS_2373 = int((FS_2344.z > 0.0f) ? ((FS_2343 >> 8u) & 255u) : (FS_2343 & 255u));
                                        }
                                        FS_2381 = FS_2373;
                                    }
                                    FS_2386 = (FS_2381 < 80) ? FS_2381 : (-1);
                                }
                                bool FS_2387 = FS_2386 >= 0;
                                float FS_2633;
                                if (FS_2387)
                                {
                                    float3 FS_2394 = FS_546 - FS_36_m6[FS_1971].xyz;
                                    float FS_2395 = dot(FS_2394, FS_2394);
                                    float4 EIDShadowParams = FS_38_m11[FS_2386];
                                    float4 FS_2414 = mul(FS_38_m10[FS_2386], float4((FS_546 - ((FS_2394 * rsqrt(isnan(FS_2395) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? FS_2395 : max(1.1754943508222875079687365372222e-38f, FS_2395)))) * EIDShadowParams.x)) + (FS_574 * (EIDShadowParams.y * 5.0f)), 1.0f));
                                    float FS_2415 = FS_2414.w;
                                    float3 FS_2418 = FS_2414.xyz / FS_2415.xxx;
                                    float2 FS_2419 = FS_2418.xy;
                                    float3 FS_2427 = FS_2418.xyz;
                                    bool3 FS_2428 = bool3(FS_2427.x <= 0.0f.xxx.x, FS_2427.y <= 0.0f.xxx.y, FS_2427.z <= 0.0f.xxx.z);
                                    bool3 FS_2429 = bool3(FS_2427.x >= 1.0f.xxx.x, FS_2427.y >= 1.0f.xxx.y, FS_2427.z >= 1.0f.xxx.z);
                                    float FS_2432 = FS_2418.z;
                                    float2 FS_2443 = ((FS_2419 * (FS_38_m12[FS_2386].zw - FS_38_m12[FS_2386].xy)) + FS_38_m12[FS_2386].xy).xy * FS_38_m13.zw;
                                    float2 FS_2445 = floor(FS_2443 + 0.5f.xx);
                                    float2 FS_2446 = FS_2443 - FS_2445;
                                    float FS_2447 = FS_2446.x;
                                    float FS_2448 = FS_2447 + 0.5f;
                                    float FS_2449 = FS_2448 * FS_2448;
                                    float FS_2452 = 1.0f - FS_2447;
                                    float FS_2453 = isnan(0.0f) ? FS_2447 : (isnan(FS_2447) ? 0.0f : min(FS_2447, 0.0f));
                                    float FS_2456 = FS_2447 + 1.0f;
                                    float FS_2457 = isnan(0.0f) ? FS_2447 : (isnan(FS_2447) ? 0.0f : max(FS_2447, 0.0f));
                                    float FS_2468 = FS_2446.y;
                                    float FS_2469 = FS_2468 + 0.5f;
                                    float FS_2470 = FS_2469 * FS_2469;
                                    float FS_2473 = 1.0f - FS_2468;
                                    float FS_2474 = isnan(0.0f) ? FS_2468 : (isnan(FS_2468) ? 0.0f : min(FS_2468, 0.0f));
                                    float FS_2477 = FS_2468 + 1.0f;
                                    float FS_2478 = isnan(0.0f) ? FS_2468 : (isnan(FS_2468) ? 0.0f : max(FS_2468, 0.0f));
                                    float3 FS_2490 = float3(0.1599999964237213134765625f * FS_2452, 0.1599999964237213134765625f * ((FS_2456 - (FS_2457 * FS_2457)) + 1.0f), FS_2449 * 0.07999999821186065673828125f);
                                    float3 FS_2491 = float3(0.1599999964237213134765625f * ((FS_2449 * 0.5f) - FS_2447), 0.1599999964237213134765625f * ((FS_2452 - (FS_2453 * FS_2453)) + 1.0f), 0.1599999964237213134765625f * FS_2456) + FS_2490;
                                    float3 FS_2493 = float3(0.1599999964237213134765625f * FS_2473, 0.1599999964237213134765625f * ((FS_2477 - (FS_2478 * FS_2478)) + 1.0f), FS_2470 * 0.07999999821186065673828125f);
                                    float3 FS_2494 = float3(0.1599999964237213134765625f * ((FS_2470 * 0.5f) - FS_2468), 0.1599999964237213134765625f * ((FS_2473 - (FS_2474 * FS_2474)) + 1.0f), 0.1599999964237213134765625f * FS_2477) + FS_2493;
                                    float3 FS_2500 = ((FS_2490 / FS_2491) + float3(-2.5f, -0.5f, 1.5f)) * FS_38_m13.xxx;
                                    float3 FS_2502 = ((FS_2493 / FS_2494) + float3(-2.5f, -0.5f, 1.5f)) * FS_38_m13.yyy;
                                    float2 FS_2504 = FS_2445 * FS_38_m13.xy;
                                    float FS_2505 = FS_2500.x;
                                    float FS_2506 = FS_2502.x;
                                    float FS_2509 = FS_2500.y;
                                    float FS_2512 = FS_2500.z;
                                    float FS_2515 = FS_2502.y;
                                    float FS_2522 = FS_2502.z;
                                    float FS_2529 = FS_2491.x;
                                    float FS_2530 = FS_2494.x;
                                    float FS_2532 = FS_2491.y;
                                    float FS_2534 = FS_2491.z;
                                    float FS_2536 = FS_2494.y;
                                    float FS_2540 = FS_2494.z;
                                    float2 FS_2618 = 1.0f.xx - FS_2419;
                                    bool2 FS_3494 = isnan(FS_2419);
                                    bool2 FS_3495 = isnan(FS_2618);
                                    float2 FS_3496 = min(FS_2419, FS_2618);
                                    float2 FS_3497 = float2(FS_3494.x ? FS_2618.x : FS_3496.x, FS_3494.y ? FS_2618.y : FS_3496.y);
                                    float2 FS_2619 = float2(FS_3495.x ? FS_2419.x : FS_3497.x, FS_3495.y ? FS_2419.y : FS_3497.y);
                                    float FS_2620 = FS_2619.x;
                                    float FS_2621 = FS_2619.y;
                                    float FS_2622 = isnan(FS_2621) ? FS_2620 : (isnan(FS_2620) ? FS_2621 : min(FS_2620, FS_2621));
                                    float FS_2626 = (EIDShadowParams.z - FS_2415) * 0.25f;
                                    float FS_2628 = smoothstep(0.0f, 0.0500000007450580596923828125f, isnan(FS_2622) ? FS_2626 : (isnan(FS_2626) ? FS_2622 : min(FS_2626, FS_2622)));
                                    FS_2633 = FS_2387 ? lerp(1.0f, (any(bool3(FS_2428.x || FS_2429.x, FS_2428.y || FS_2429.y, FS_2428.z || FS_2429.z)) || ((asuint(FS_2432) & 2147483647u) > 2139095040u)) ? 1.0f : ((((((((((FS_2529 * FS_2530) * EIDShadowCompare(float3(FS_2504 + float2(FS_2505, FS_2506), FS_370).xy, FS_2432)) + ((FS_2532 * FS_2530) * EIDShadowCompare(float3(FS_2504 + float2(FS_2509, FS_2506), FS_370).xy, FS_2432))) + ((FS_2534 * FS_2530) * EIDShadowCompare(float3(FS_2504 + float2(FS_2512, FS_2506), FS_370).xy, FS_2432))) + ((FS_2529 * FS_2536) * EIDShadowCompare(float3(FS_2504 + float2(FS_2505, FS_2515), FS_370).xy, FS_2432))) + ((FS_2532 * FS_2536) * EIDShadowCompare(float3(FS_2504 + float2(FS_2509, FS_2515), FS_370).xy, FS_2432))) + ((FS_2534 * FS_2536) * EIDShadowCompare(float3(FS_2504 + float2(FS_2512, FS_2515), FS_370).xy, FS_2432))) + ((FS_2529 * FS_2540) * EIDShadowCompare(float3(FS_2504 + float2(FS_2505, FS_2522), FS_370).xy, FS_2432))) + ((FS_2532 * FS_2540) * EIDShadowCompare(float3(FS_2504 + float2(FS_2509, FS_2522), FS_370).xy, FS_2432))) + ((FS_2534 * FS_2540) * EIDShadowCompare(float3(FS_2504 + float2(FS_2512, FS_2522), FS_370).xy, FS_2432))), FS_2337 ? (isnan(FS_2628) ? EIDShadowParams.w : (isnan(EIDShadowParams.w) ? FS_2628 : min(EIDShadowParams.w, FS_2628))) : EIDShadowParams.w) : 1.0f;
                                }
                                else
                                {
                                    FS_2633 = clamp(dot(FS_553, FS_2172) + 1.0f, 0.0f, 1.0f);
                                }
                                FS_2634 = FS_2633;
                            }
                            else
                            {
                                FS_2634 = 1.0f;
                            }
                            float FS_2738;
                            float3 FS_2739;
                            float FS_2740;
                            float3 FS_2741;
                            float3 FS_2742;
                            float FS_2743;
                            float FS_2744;
                            [branch]
                            if (FS_2081 == 0u)
                            {
                                float3 FS_2712 = FS_36_m6[FS_1968].xyz * FS_2310;
                                float FS_2713 = FS_2712.x;
                                float FS_2714 = FS_2712.y;
                                float FS_2715 = FS_2712.z;
                                float FS_2716 = isnan(FS_2714) ? FS_2713 : (isnan(FS_2713) ? FS_2714 : max(FS_2713, FS_2714));
                                float FS_2718 = (isnan(FS_2715) ? FS_2716 : (isnan(FS_2716) ? FS_2715 : max(FS_2716, FS_2715))) * lerp(0.75f, 0.5f, 1.0f - FS_1525);
                                float3 FS_2725 = FS_1716.xyz;
                                FS_2738 = FS_2310;
                                FS_2739 = (FS_36_m6[FS_1968].xyz * ((1.0f - FS_36_m6[FS_1980].y) + ((1.0f / (isnan(FS_2718) ? 1.0f : (isnan(1.0f) ? FS_2718 : max(1.0f, FS_2718)))) * FS_36_m6[FS_1980].y))) * lerp(0.5f * FS_36_m6[FS_1980].x, 1.0f, clamp(dot(normalize(lerp(float3(FS_553.x, 6.103515625e-05f, FS_553.z), FS_1579, FS_648)), FS_2172) + 0.5f, 0.0f, 1.0f));
                                FS_2740 = FS_2331;
                                FS_2741 = FS_2725;
                                FS_2742 = FS_2725;
                                FS_2743 = 1.0f;
                                FS_2744 = 0.0f;
                            }
                            else
                            {
                                float FS_2704;
                                float FS_2705;
                                float3 FS_2706;
                                float3 FS_2707;
                                float FS_2708;
                                float FS_2709;
                                if (FS_2081 == 3u)
                                {
                                    float3 FS_2684 = -normalize(cross(FS_586, cross(FS_586, FS_2172)));
                                    float FS_2692 = float(dot(FS_586, FS_2684) < (-0.00999999977648258209228515625f));
                                    FS_2704 = FS_2310 * (lerp(smoothstep(lerp(0.800000011920928955078125f, 0.20000000298023223876953125f, FS_36_m6[FS_1980].x), lerp(0.89999997615814208984375f, 0.5f, FS_36_m6[FS_1980].x), FS_1861) * FS_1866, (isnan(FS_2692) ? FS_1866 : (isnan(FS_1866) ? FS_2692 : max(FS_1866, FS_2692))) * FS_518, clamp((FS_36_m6[FS_1980].x * 10.0f) - 3.0f, 0.0f, 1.0f)) * FS_2634);
                                    FS_2705 = clamp(dot(FS_1579, FS_2684), 0.0f, 1.0f);
                                    FS_2706 = lerp(0.5f.xxx, FS_1442, FS_36_m6[FS_1980].y.xxx);
                                    FS_2707 = 0.0f.xxx;
                                    FS_2708 = 1.0f;
                                    FS_2709 = 0.0f;
                                }
                                else
                                {
                                    bool FS_2643 = FS_2081 == 1u;
                                    float FS_2674;
                                    float3 FS_2675;
                                    float FS_2676;
                                    float FS_2677;
                                    if (FS_2643)
                                    {
                                        float FS_2668 = smoothstep(0.0f, lerp(0.100000001490116119384765625f, 1.0f, FS_516), clamp(FS_2330 + FS_36_m6[FS_1980].x, -1.0f, 1.0f) + (FS_36_m6[FS_1980].z * FS_1656)) * FS_2634;
                                        float FS_2671 = smoothstep(0.0f, -0.20000000298023223876953125f, FS_1580 - FS_36_m6[FS_1980].w);
                                        FS_2674 = isnan(FS_2668) ? FS_2671 : (isnan(FS_2671) ? FS_2668 : max(FS_2671, FS_2668));
                                        FS_2675 = FS_1446 * FS_36_m6[FS_1980].y;
                                        FS_2676 = 1.0f;
                                        FS_2677 = 0.0f;
                                    }
                                    else
                                    {
                                        bool FS_2647 = FS_2081 == 2u;
                                        float FS_2659;
                                        if (FS_2647)
                                        {
                                            FS_2659 = smoothstep(FS_36_m6[FS_1980].x + 0.0500000007450580596923828125f, FS_36_m6[FS_1980].x - 0.0500000007450580596923828125f, FS_1436) * ((1.0f - FS_36_m6[FS_1980].z) + (step(0.5f, FS_1439) * FS_36_m6[FS_1980].z));
                                        }
                                        else
                                        {
                                            FS_2659 = 1.0f;
                                        }
                                        FS_2674 = FS_2331;
                                        FS_2675 = 0.0f.xxx;
                                        FS_2676 = FS_2659;
                                        FS_2677 = FS_2647 ? FS_36_m6[FS_1980].y : 0.0f;
                                    }
                                    bool3 FS_2678 = FS_2643.xxx;
                                    FS_2704 = FS_2310;
                                    FS_2705 = FS_2674;
                                    FS_2706 = float3(FS_2678.x ? FS_1442.x : 0.0f.xxx.x, FS_2678.y ? FS_1442.y : 0.0f.xxx.y, FS_2678.z ? FS_1442.z : 0.0f.xxx.z);
                                    FS_2707 = FS_2675;
                                    FS_2708 = FS_2676;
                                    FS_2709 = FS_2677;
                                }
                                FS_2738 = FS_2704;
                                FS_2739 = FS_36_m6[FS_1968].xyz;
                                FS_2740 = FS_2705;
                                FS_2741 = FS_2706;
                                FS_2742 = FS_2707;
                                FS_2743 = FS_2708;
                                FS_2744 = FS_2709;
                            }
                            float3 FS_2772;
                            [branch]
                            if (FS_2081 != 3u)
                            {
                                float FS_2749 = lerp(FS_1448, 0.00999999977648258209228515625f, FS_2744);
                                float FS_2752 = dot(FS_1272, normalize(FS_2172 + FS_409));
                                float FS_2753 = FS_2749 * FS_2749;
                                float FS_2757 = (((FS_2752 * FS_2753) - FS_2752) * FS_2752) + 1.0f;
                                float FS_2758 = FS_2757 * FS_2757;
                                FS_2772 = ((FS_1445 * clamp((((FS_2753 != FS_2758) ? (FS_2753 / FS_2758) : 1.0f) * (0.5f / ((FS_1753 + (FS_2749 * FS_1755)) + 9.9999997473787516355514526367188e-05f))) - 6.103515625e-05f, 0.0f, 20.0f)) * FS_2743) * FS_36_m6[FS_1989].z;
                            }
                            else
                            {
                                FS_2772 = 0.0f.xxx;
                            }
                            float3 FS_2775 = FS_2739 * FS_2738;
                            FS_2782 = FS_1932 + (((FS_2775 * lerp(FS_2742, FS_2741, FS_2740.xxx)) * 1.0f) + ((FS_2775 * FS_2772) * FS_2740));
                        }
                        else
                        {
                            FS_2782 = FS_1932;
                        }
                        FS_2783 = FS_2782;
                        return;
                    }

void EIDEarlyExit1(inout float3 FS_1272, inout float FS_1436, inout float FS_1439, inout float3 FS_1442, inout float3 FS_1445, inout float3 FS_1446, inout float FS_1448, inout float FS_1525, inout float3 FS_1579, inout float FS_1580, inout float FS_1656, inout float4 FS_1716, inout float FS_1753, inout float FS_1755, inout float FS_1861, inout float FS_1866, inout float3 FS_1932, inout int FS_1968, inout int FS_1971, inout int FS_1974, inout int FS_1977, inout int FS_1980, inout int FS_1986, inout int FS_1989, inout uint FS_1993, inout float FS_2068, inout float3 FS_2784, inout float3 FS_409, inout float FS_516, inout float FS_518, inout float3 FS_546, inout float3 FS_553, inout float3 FS_574, inout float3 FS_586, inout float FS_630, inout float3 FS_648)
{
                    uint FS_2081 = asuint(FS_36_m6[FS_1977].w);
                    if ((FS_2081 == 16u) || ((FS_36_m6[FS_1977].z + FS_19_m91.z) < 0.5f))
                    {
                        FS_2784 = FS_1932;
                        return;
                    }
                    bool FS_2093 = (uint(FS_36_m6[FS_1968].w) & 1u) == 0u;
                    bool FS_2097 = (!FS_2093) && (FS_36_m6[FS_1974].z > 0.0f);
                    bool FS_2098 = FS_2081 == 4u;
                    float FS_2099 = float(FS_2093);
                    float FS_2107 = (0.5f + (0.5f * FS_36_m6[FS_1974].y)) - abs(FS_36_m6[FS_1974].x);
                    float FS_2108 = FS_36_m6[FS_1974].y - FS_2107;
                    float FS_2112 = (1.0f - abs(FS_2107)) - abs(FS_2108);
                    float FS_2115 = abs(isnan(0.00048828125f) ? FS_2112 : (isnan(FS_2112) ? 0.00048828125f : max(FS_2112, 0.00048828125f)));
                    float3 FS_2119 = normalize(float3(FS_2107, FS_2108, (FS_36_m6[FS_1974].x >= 0.0f) ? FS_2115 : (-FS_2115)));
                    float FS_2122 = 2.0f * FS_36_m6[FS_1980].y;
                    float FS_2125 = lerp(FS_36_m6[FS_1986].w, isnan(0.100000001490116119384765625f) ? FS_2122 : (isnan(FS_2122) ? 0.100000001490116119384765625f : max(FS_2122, 0.100000001490116119384765625f)), float(FS_2098));
                    float3 FS_2130 = FS_36_m6[FS_1971].xyz - FS_546;
                    float3 FS_2131 = -FS_2119;
                    float3 FS_2136 = lerp(FS_2130, FS_2131 * dot(FS_2130, FS_2131), (float(FS_2098 && (FS_36_m6[FS_1980].z > 0.5f)) * FS_2099).xxx);
                    float FS_2137 = dot(FS_2136, FS_2136);
                    float FS_2138 = rsqrt(FS_2137);
                    float3 FS_2139 = FS_2136 * FS_2138;
                    float3 FS_2172;
                    float FS_2173;
                    if (FS_2097)
                    {
                        float3 FS_2143 = (FS_2119 * FS_36_m6[FS_1974].z) * 0.5f;
                        float3 FS_2144 = FS_2136 - FS_2143;
                        float3 FS_2145 = FS_2136 + FS_2143;
                        float FS_2146 = length(FS_2144);
                        float FS_2147 = length(FS_2145);
                        float3 FS_2156 = normalize(cross(cross(FS_2119, FS_2139), FS_2119));
                        FS_2172 = FS_2156;
                        FS_2173 = ((1.0f / ((((FS_2146 * FS_2147) + dot(FS_2144, FS_2145)) * 0.5f) + 1.0f)) * clamp(0.5f * ((dot(FS_2156, FS_2144) / FS_2146) + (dot(FS_2156, FS_2145) / FS_2147)), 0.0f, 1.0f)) * (1.0f / clamp(1.0f + (0.5f * clamp(FS_36_m6[FS_1974].z * FS_2138, 0.0f, 1.0f)), 0.0f, 1.0f));
                    }
                    else
                    {
                        FS_2172 = FS_2139;
                        FS_2173 = 1.0f;
                    }
                    float FS_2195;
                    if (FS_2125 < 0.0f)
                    {
                        float FS_2189 = FS_2137 * (FS_36_m6[FS_1971].w * FS_36_m6[FS_1971].w);
                        float FS_2192 = clamp(1.0f - (FS_2189 * FS_2189), 0.0f, 1.0f);
                        FS_2195 = lerp(1.0f / (FS_2137 + 1.0f), FS_2173, float(FS_2097)) * (FS_2192 * FS_2192);
                    }
                    else
                    {
                        float3 FS_2178 = FS_2136 * FS_36_m6[FS_1971].w;
                        FS_2195 = FS_2173 * pow(1.0f - clamp(dot(FS_2178, FS_2178), 0.0f, 1.0f), FS_2125);
                    }
                    float FS_2200 = clamp((dot(FS_2172, FS_2131) - FS_36_m6[FS_1974].z) * FS_36_m6[FS_1974].w, 0.0f, 1.0f);
                    float FS_2203 = FS_2195 * lerp(1.0f, FS_2200 * FS_2200, FS_2099);
                    int FS_2205 = int(FS_36_m6[FS_1989].w);
                    float FS_2309;
                    if ((!FS_2097) && (FS_2205 >= 0))
                    {
                        uint FS_2211 = uint(FS_2205);
                        float2 FS_2302;
                        [branch]
                        if (FS_2099 != 0.0f)
                        {
                            float4 FS_2292 = mul(FS_63_m1[FS_2211], float4(FS_546.x, FS_630, FS_546.z, 1.0f));
                            FS_2302 = FS_63_m0[FS_2211].xy + (clamp(FS_2292.xy / FS_2292.w.xx, 0.0f.xx, 1.0f.xx) * FS_63_m0[FS_2211].zw);
                        }
                        else
                        {
                            float3 FS_2226 = mul(float4(-FS_2136, 0.0f), FS_63_m1[FS_2211]).xyz;
                            float3 FS_379 = FS_2226;
                            float3 FS_378 = FS_2226;
                            float3 FS_377 = abs(FS_2226);
                            uint FS_2235 = uint(int(FS_377.y > FS_377.x));
                            uint FS_2241 = (FS_377.z > FS_377[FS_2235]) ? 2u : FS_2235;
                            uint FS_2247 = (FS_2241 * 2u) + uint(FS_378[FS_2241] < 0.0f);
                            float FS_2251 = abs(FS_379[FS_2247 / 2u]);
                            float FS_2271 = 0.5f - (0.000244140625f / FS_63_m0[FS_2211].w);
                            FS_2302 = FS_63_m0[FS_2211].xy + (clamp(float2((float(FS_2247) + ((((FS_379[uint(FS_344[FS_2247].x)] * FS_345[FS_2247].x) / FS_2251) * FS_2271) + 0.5f)) * 0.16666667163372039794921875f, 0.5f - (((FS_379[uint(FS_344[FS_2247].y)] * FS_345[FS_2247].y) / FS_2251) * FS_2271)), 0.0f.xx, 1.0f.xx) * FS_63_m0[FS_2211].zw);
                        }
                        FS_2309 = FS_2203 * FS_61.SampleLevel(sampler_LinearClamp, FS_2302, 0.0f).x;
                    }
                    else
                    {
                        FS_2309 = FS_2203;
                    }
                    float FS_2310 = FS_2309 * FS_2068;
                    float3 FS_2783;
                    EIDEarlyExit0(FS_1272, FS_1436, FS_1439, FS_1442, FS_1445, FS_1446, FS_1448, FS_1525, FS_1579, FS_1580, FS_1656, FS_1716, FS_1753, FS_1755, FS_1861, FS_1866, FS_1932, FS_1968, FS_1971, FS_1974, FS_1977, FS_1980, FS_1989, FS_1993, FS_2081, FS_2093, FS_2098, FS_2172, FS_2310, FS_2783, FS_409, FS_516, FS_518, FS_546, FS_553, FS_574, FS_586, FS_648);
                    FS_2784 = FS_2783;
                    return;
                }
void FSfrag_main()
{
    float FS_390 = 1.0f / FSgl_FragCoord.w;
    float3 FS_405 = lerp(-FS_4, float3(FS_17_m0[2u].x, FS_17_m0[2u].y, FS_17_m0[2u].z), FS_19_m4.w.xxx);
    float FS_406 = dot(FS_405, FS_405);
    float FS_408 = rsqrt(isnan(9.9999999392252902907785028219223e-09f) ? FS_406 : (isnan(FS_406) ? 9.9999999392252902907785028219223e-09f : max(FS_406, 9.9999999392252902907785028219223e-09f)));
    float3 FS_409 = FS_405 * FS_408;
    float FS_410 = FS_406 * FS_408;
#if defined(EID_LIVE_MVP)
    // Captured instance stores integer flags as denormal float bit patterns.
    // Keep the known buffer index/flag in integer form: the Unity compiler
    // flushes these bit patterns across the synthetic instance struct return.
    uint FS_413 = 22100u;
    bool FS_418 = true;
#else
    uint FS_413 = asuint(FSGetInstance(FS_12)._m2.x);
    bool FS_418 = (asuint(FSGetInstance(FS_12)._m1.w) & 16u) != 0u;
#endif
    float4 FS_435;
    float4 FS_436;
    float4 FS_437;
    if (FS_418)
    {
        FS_435 = asfloat(FS_32.Load4((FS_413 + 2u) * 16 + 0));
        FS_436 = asfloat(FS_32.Load4((FS_413 + 1u) * 16 + 0));
        FS_437 = asfloat(FS_32.Load4(FS_413 * 16 + 0));
    }
    else
    {
        FS_435 = FSGetInstance(FS_12)._m0[2];
        FS_436 = FSGetInstance(FS_12)._m0[1];
        FS_437 = FSGetInstance(FS_12)._m0[0];
    }
    float4 FS_443 = FS_58.SampleBias(sampler_LinearRepeat, FS_3, FS_19_m16);
    float FS_455 = 1.0f - FS_49_m0;
    float FS_456 = FS_443.w;
    float4 FS_470 = FS4765_52.SampleBias(sampler_LinearRepeat, float2(fmod(FS_49_m32, 2.0f) * 0.5f, floor(FS_49_m32 * 0.5f) * 0.5f) + (0.5f.xx * FS_3), FS_19_m16);
    float3 FS_477 = lerp(FS_443.xyz * FS_49_m24.xyz, FS_470.xyz, (FS_470.w * FS_49_m33).xxx);
    float3 FS_478 = FS_477 * 12.9200000762939453125f;
    float3 FS_482 = (pow(abs(FS_477), 0.4166666567325592041015625f.xxx) * 1.05499994754791259765625f) - 0.054999999701976776123046875f.xxx;
    bool3 FS_483 = bool3(FS_477.x <= 0.003130800090730190277099609375f.xxx.x, FS_477.y <= 0.003130800090730190277099609375f.xxx.y, FS_477.z <= 0.003130800090730190277099609375f.xxx.z);
    float3 FS_485 = clamp(float3(FS_483.x ? FS_478.x : FS_482.x, FS_483.y ? FS_478.y : FS_482.y, FS_483.z ? FS_478.z : FS_482.z), 0.0f.xxx, 1.0f.xxx);
    float FS_489 = FS_485.z * 31.0f;
    float FS_490 = floor(FS_489);
    float2 FS_494 = ((FS_485.xy * 31.0f) * float2(0.0009765625f, 0.03125f)) + float2(0.00048828125f, 0.015625f);
    float3 FS_499 = float3(FS_494.x, FS_494.y, FS_485.z);
    FS_499.x = FS_494.x + (FS_490 * 0.03125f);
    float3 FS_510 = lerp(FS4765_53.SampleLevel(sampler_LinearClamp, FS_499.xy, 0.0f).xyz, FS4765_53.SampleLevel(sampler_LinearClamp, FS_499.xy + float2(0.03125f, 0.0f), 0.0f).xyz, (FS_489 - FS_490).xxx);
    float4 FS_514 = FS4765_61.SampleBias(sampler_LinearClamp, FS_3, FS_19_m16);
    float FS_516 = FS_514.y;
    float FS_517 = FS_514.z;
    float FS_518 = FS_514.w;
    float4 FS_522 = FS_59.SampleBias(sampler_LinearRepeat, FS_3, FS_19_m16);
    float4 FS_528 = FS_522;
    FS_528.w = FS_522.w * FS_522.x;
    float2 FS_531 = (FS_528.wy * 2.0f) - 1.0f.xx;
    float2 FS_533 = FS_531.xy;
    float FS_537 = sqrt(1.0f - clamp(dot(FS_533, FS_533), 0.0f, 1.0f));
    float3 FS_539 = float3(FS_531.x, FS_531.y, FS_371.z);
    FS_539.z = isnan(FS_537) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? FS_537 : max(1.000000016862383526387164645044e-16f, FS_537));
    float2 FS_541 = FS_539.xy * FS_49_m3;
    float3 FS_546 = FS_4 + FS_17_m11.xyz;
    float3 FS_551 = FS_546 - float3(FS_437.w, FS_374, FS_435.w);
    FS_551.y = 6.103515625e-05f;
    float3 FS_553 = normalize(FS_551);
    float3x3 FS_562 = float3x3(FS_6.xyz * 1.0f, (cross(FS_5, FS_6.xyz) * FS_6.w) * 1.0f, FS_5 * 1.0f);
    float3 FS_563 = mul(float3(FS_541.x, FS_541.y, FS_539.z), FS_562);
    float FS_564 = dot(FS_563, FS_563);
    float FS_572 = FSgl_FrontFacing ? 1.0f : ((-1.0f) + (2.0f * FS_49_m5));
    float3 FS_573 = (FS_563 * rsqrt(isnan(FS_564) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? FS_564 : max(1.1754943508222875079687365372222e-38f, FS_564)))) * FS_572;
    float3 FS_574 = normalize(FS_5) * FS_572;
    uint2 FS_576 = uint2(FSgl_FragCoord.xy);
    float3 FS_586 = mul(float3x3(FS_17_m1[0].xyz, FS_17_m1[1].xyz, FS_17_m1[2].xyz), float3(0.0f, 0.0f, 1.0f));
    float3x3 FS_590 = float3x3(FS_437.xyz, FS_436.xyz, FS_435.xyz);
    float3 FS_591 = mul(FS_586, FS_590);
    float FS_592 = dot(FS_591, FS_591);
    float2 FS_597 = normalize((FS_591 * rsqrt(isnan(FS_592) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? FS_592 : max(1.1754943508222875079687365372222e-38f, FS_592)))).xz);
    float FS_598 = FS_597.y;
    uint FS_607 = asuint((FS_19_m89.x > 0.5f) ? FS_19_m89.y : FSGetInstance(FS_12)._m7.x);
    float4 FS_620 = float4(float(FS_607 & 255u), float((FS_607 >> 8u) & 255u), float((FS_607 >> 16u) & 255u), float((FS_607 >> 24u) & 255u)) * 0.0039215688593685626983642578125f.xxxx;
    float FS_621 = FS_620.x;
    float FS_623 = FS_620.z;
    float FS_624 = FS_620.w;
    float FS_630 = FS_546.y;
    float FS_633 = smoothstep(-0.20000000298023223876953125f, 0.1500000059604644775390625f, lerp(FSGetInstance(FS_12)._m7.y, FS_19_m89.w, FS_19_m89.x) - FS_630) * FS_620.y;
    float FS_634 = isnan(FS_633) ? FS_623 : (isnan(FS_623) ? FS_633 : max(FS_623, FS_633));
    float FS_635 = isnan(FS_634) ? FS_621 : (isnan(FS_621) ? FS_634 : max(FS_621, FS_634));
    float FS_643 = lerp(FS_19_m22.x, 1.0f, FS_19_m91.w) * FS_19_m20.x;
    float FS_645 = FS_573.z;
    float3 FS_648 = FS_516.xxx;
    float3 FS_650 = normalize(lerp(FS_553, normalize(float3(FS_573.x, 6.103515625e-05f, FS_645)), FS_648));
    float3 FS_1141;
    float FS_1142;
    if (FS_19_m80.y < 0.5f)
    {
        float3 FS_668 = FS_546 - (FS_19_m105.xyz + (FS_586 * (-FS_19_m107.w)));
        float FS_670 = abs(FS_668.x);
        float FS_672 = abs(FS_668.z);
        float FS_678 = clamp(((isnan(FS_672) ? FS_670 : (isnan(FS_670) ? FS_672 : max(FS_670, FS_672))) - 464.0f) * 0.03125f, 0.0f, 1.0f);
        float FS_681 = clamp((abs(FS_668.y) - 208.0f) * 0.03125f, 0.0f, 1.0f);
        float FS_682 = isnan(FS_681) ? FS_678 : (isnan(FS_678) ? FS_681 : max(FS_678, FS_681));
        float4 FS_984;
        float4 FS_985;
        float4 FS_986;
        float FS_987;
        float FS_988;
        if ((FS_19_m105.w != 0.0f) && (FS_682 < 1.0f))
        {
            float3 FS_695 = FS_546 - (FS_19_m105.xyz + (FS_586 * (-FS_19_m107.y)));
            float FS_697 = abs(FS_695.x);
            float FS_699 = abs(FS_695.z);
            float FS_705 = clamp(((isnan(FS_699) ? FS_697 : (isnan(FS_697) ? FS_699 : max(FS_697, FS_699))) - 29.0f) * 0.5f, 0.0f, 1.0f);
            float FS_708 = clamp((abs(FS_695.y) - 13.0f) * 0.5f, 0.0f, 1.0f);
            float FS_709 = isnan(FS_708) ? FS_705 : (isnan(FS_705) ? FS_708 : max(FS_705, FS_708));
            float FS_785;
            float4 FS_786;
            float4 FS_787;
            float4 FS_788;
            if (FS_709 < 1.0f)
            {
                float3 FS_718 = ((FS_546 * 2.0f) + 0.5f.xxx) * FS_19_m106.xyz;
                float3 FS_720 = FS_718 - floor(FS_718);
                float4 FS_724 = FS_42.SampleLevel(sampler_LinearRepeat, FS_720, 0.0f);
                float FS_725 = 1.0f - FS_709;
                float FS_729 = FS_19_m106.y * 0.5f;
                float FS_734 = FS_720.x;
                float FS_735 = clamp(FS_720.y, FS_729, 1.0f - FS_729) * 0.3333333432674407958984375f;
                float FS_736 = FS_720.z;
                float4 FS_739 = FS_43.SampleLevel(sampler_LinearClamp, float3(FS_734, FS_735, FS_736), 0.0f);
                float FS_755 = FS_724.x;
                float FS_765 = FS_724.y;
                float FS_775 = FS_724.z;
                FS_785 = FS_682 + (FS_739.w * FS_725);
                FS_786 = float4(((FS_43.SampleLevel(sampler_LinearClamp, float3(FS_734, FS_735 + 0.666666686534881591796875f, FS_736), 0.0f).xyz * 4.0f) - 2.0f.xxx) * FS_775, FS_775) * FS_725;
                FS_787 = float4(((FS_43.SampleLevel(sampler_LinearClamp, float3(FS_734, FS_735 + 0.3333333432674407958984375f, FS_736), 0.0f).xyz * 4.0f) - 2.0f.xxx) * FS_765, FS_765) * FS_725;
                FS_788 = float4(((FS_739.xyz * 4.0f) - 2.0f.xxx) * FS_755, FS_755) * FS_725;
            }
            else
            {
                FS_785 = FS_682;
                FS_786 = 0.0f.xxxx;
                FS_787 = 0.0f.xxxx;
                FS_788 = 0.0f.xxxx;
            }
            float3 FS_794 = FS_546 - (FS_19_m105.xyz + (FS_586 * (-FS_19_m107.z)));
            float FS_796 = abs(FS_794.x);
            float FS_798 = abs(FS_794.z);
            float FS_804 = clamp(((isnan(FS_798) ? FS_796 : (isnan(FS_796) ? FS_798 : max(FS_796, FS_798))) - 116.0f) * 0.125f, 0.0f, 1.0f);
            float FS_807 = clamp((abs(FS_794.y) - 52.0f) * 0.125f, 0.0f, 1.0f);
            float FS_808 = isnan(FS_807) ? FS_804 : (isnan(FS_804) ? FS_807 : max(FS_804, FS_807));
            float FS_888;
            float4 FS_889;
            float4 FS_890;
            float4 FS_891;
            if (FS_808 < 1.0f)
            {
                float3 FS_817 = ((FS_546 * 0.5f) + 0.5f.xxx) * FS_19_m106.xyz;
                float3 FS_819 = FS_817 - floor(FS_817);
                float4 FS_823 = FS_44.SampleLevel(sampler_LinearRepeat, FS_819, 0.0f);
                float FS_825 = FS_709 * (1.0f - FS_808);
                float FS_829 = FS_19_m106.y * 0.5f;
                float FS_834 = FS_819.x;
                float FS_835 = clamp(FS_819.y, FS_829, 1.0f - FS_829) * 0.3333333432674407958984375f;
                float FS_836 = FS_819.z;
                float4 FS_839 = FS_45.SampleLevel(sampler_LinearClamp, float3(FS_834, FS_835, FS_836), 0.0f);
                float FS_855 = FS_823.x;
                float FS_866 = FS_823.y;
                float FS_877 = FS_823.z;
                FS_888 = FS_785 + (FS_839.w * FS_825);
                FS_889 = FS_786 + (float4(((FS_45.SampleLevel(sampler_LinearClamp, float3(FS_834, FS_835 + 0.666666686534881591796875f, FS_836), 0.0f).xyz * 4.0f) - 2.0f.xxx) * FS_877, FS_877) * FS_825);
                FS_890 = FS_787 + (float4(((FS_45.SampleLevel(sampler_LinearClamp, float3(FS_834, FS_835 + 0.3333333432674407958984375f, FS_836), 0.0f).xyz * 4.0f) - 2.0f.xxx) * FS_866, FS_866) * FS_825);
                FS_891 = FS_788 + (float4(((FS_839.xyz * 4.0f) - 2.0f.xxx) * FS_855, FS_855) * FS_825);
            }
            else
            {
                FS_888 = FS_785;
                FS_889 = FS_786;
                FS_890 = FS_787;
                FS_891 = FS_788;
            }
            float4 FS_974;
            float4 FS_975;
            float4 FS_976;
            float FS_977;
            if (FS_808 > 0.0f)
            {
                float3 FS_900 = ((FS_546 * 0.125f) + 0.5f.xxx) * FS_19_m106.xyz;
                float3 FS_903 = FS_19_m106.xyz * 0.5f;
                float3 FS_905 = clamp(FS_900 - floor(FS_900), FS_903, 1.0f.xxx - FS_903);
                float4 FS_909 = FS_46.SampleLevel(sampler_LinearRepeat, FS_905, 0.0f);
                float FS_911 = FS_808 * (1.0f - FS_682);
                float FS_915 = FS_19_m106.y * 0.5f;
                float FS_920 = FS_905.x;
                float FS_921 = clamp(FS_905.y, FS_915, 1.0f - FS_915) * 0.3333333432674407958984375f;
                float FS_922 = FS_905.z;
                float4 FS_925 = FS_47.SampleLevel(sampler_LinearClamp, float3(FS_920, FS_921, FS_922), 0.0f);
                float FS_941 = FS_909.x;
                float FS_952 = FS_909.y;
                float FS_963 = FS_909.z;
                FS_974 = FS_889 + (float4(((FS_47.SampleLevel(sampler_LinearClamp, float3(FS_920, FS_921 + 0.666666686534881591796875f, FS_922), 0.0f).xyz * 4.0f) - 2.0f.xxx) * FS_963, FS_963) * FS_911);
                FS_975 = FS_890 + (float4(((FS_47.SampleLevel(sampler_LinearClamp, float3(FS_920, FS_921 + 0.3333333432674407958984375f, FS_922), 0.0f).xyz * 4.0f) - 2.0f.xxx) * FS_952, FS_952) * FS_911);
                FS_976 = FS_891 + (float4(((FS_925.xyz * 4.0f) - 2.0f.xxx) * FS_941, FS_941) * FS_911);
                FS_977 = FS_888 + (FS_925.w * FS_911);
            }
            else
            {
                FS_974 = FS_889;
                FS_975 = FS_890;
                FS_976 = FS_891;
                FS_977 = FS_888;
            }
            float FS_980 = clamp((FS_977 * 2.0f) - 1.0f, 0.0f, 1.0f);
            FS_984 = FS_974;
            FS_985 = FS_975;
            FS_986 = FS_976;
            FS_987 = FS_980 - FS_682;
            FS_988 = (FS_980 + FS_682) * 0.5f;
        }
        else
        {
            FS_984 = 0.0f.xxxx;
            FS_985 = 0.0f.xxxx;
            FS_986 = 0.0f.xxxx;
            FS_987 = 0.0f;
            FS_988 = 1.0f;
        }
        float4 FS_1008 = FS_986 + float4(FS_19_m108.x * FS_988, (FS_19_m108.y * FS_988) + ((FS_19_m108.w * FS_987) * 0.5f), FS_19_m108.z * FS_988, (FS_19_m108.w * FS_988) + ((FS_19_m108.y * FS_987) * 0.375f));
        float4 FS_1028 = FS_985 + float4(FS_19_m109.x * FS_988, (FS_19_m109.y * FS_988) + ((FS_19_m109.w * FS_987) * 0.5f), FS_19_m109.z * FS_988, (FS_19_m109.w * FS_988) + ((FS_19_m109.y * FS_987) * 0.375f));
        float4 FS_1048 = FS_984 + float4(FS_19_m110.x * FS_988, (FS_19_m110.y * FS_988) + ((FS_19_m110.w * FS_987) * 0.5f), FS_19_m110.z * FS_988, (FS_19_m110.w * FS_988) + ((FS_19_m110.y * FS_987) * 0.375f));
        float4 FS_1052 = float4(FS_650, 1.0f);
        float3 FS_1056 = float3(dot(FS_1008, FS_1052), dot(FS_1028, FS_1052), dot(FS_1048, FS_1052));
        bool3 FS_3279 = isnan(FS_1056);
        bool3 FS_3280 = isnan(0.0f.xxx);
        float3 FS_3281 = max(FS_1056, 0.0f.xxx);
        float3 FS_3282 = float3(FS_3279.x ? 0.0f.xxx.x : FS_3281.x, FS_3279.y ? 0.0f.xxx.y : FS_3281.y, FS_3279.z ? 0.0f.xxx.z : FS_3281.z);
        float3 FS_1058 = float3(FS_3280.x ? FS_1056.x : FS_3282.x, FS_3280.y ? FS_1056.y : FS_3282.y, FS_3280.z ? FS_1056.z : FS_3282.z) * FS_643;
        float3 FS_1066 = ((FS_1008.xyz * 0.2125999927520751953125f) + (FS_1028.xyz * 0.715200006961822509765625f)) + (FS_1048.xyz * 0.072200000286102294921875f);
        float FS_1067 = dot(FS_1066, FS_1066);
        float3 FS_1070 = FS_1066 * rsqrt(isnan(FS_1067) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? FS_1067 : max(1.1754943508222875079687365372222e-38f, FS_1067)));
        float4 FS_1075 = float4(FS_1070.x, abs(FS_1070.y), FS_1070.z, 1.0f);
        float3 FS_1079 = float3(dot(FS_1008, FS_1075), dot(FS_1028, FS_1075), dot(FS_1048, FS_1075));
        bool3 FS_3289 = isnan(FS_1079);
        bool3 FS_3290 = isnan(0.0f.xxx);
        float3 FS_3291 = max(FS_1079, 0.0f.xxx);
        float3 FS_3292 = float3(FS_3289.x ? 0.0f.xxx.x : FS_3291.x, FS_3289.y ? 0.0f.xxx.y : FS_3291.y, FS_3289.z ? 0.0f.xxx.z : FS_3291.z);
        float3 FS_1080 = float3(FS_3290.x ? FS_1079.x : FS_3292.x, FS_3290.y ? FS_1079.y : FS_3292.y, FS_3290.z ? FS_1079.z : FS_3292.z);
        float FS_1081 = FS_1080.x;
        float FS_1082 = FS_1080.y;
        float FS_1083 = FS_1080.z;
        float FS_1084 = isnan(FS_1082) ? FS_1081 : (isnan(FS_1081) ? FS_1082 : max(FS_1081, FS_1082));
        float FS_1085 = isnan(FS_1083) ? FS_1084 : (isnan(FS_1084) ? FS_1083 : max(FS_1084, FS_1083));
        float FS_1088 = FS_1058.z;
        float FS_1089 = FS_1058.y;
        float4 FS_1094 = lerp(float4(FS_1088, FS_1089, -1.0f, 0.666666686534881591796875f), float4(FS_1089, FS_1088, 0.0f, -0.3333333432674407958984375f), step(FS_1088, FS_1089).xxxx);
        float FS_1095 = FS_1058.x;
        float FS_1096 = FS_1094.x;
        float4 FS_1104 = lerp(float4(FS_1096, FS_1094.yw, FS_1095), float4(FS_1095, FS_1094.yz, FS_1096), step(FS_1096, FS_1095).xxxx);
        float FS_1105 = FS_1104.x;
        float FS_1106 = FS_1104.w;
        float FS_1107 = FS_1104.y;
        float FS_1109 = FS_1105 - (isnan(FS_1107) ? FS_1106 : (isnan(FS_1106) ? FS_1107 : min(FS_1106, FS_1107)));
        float FS_1118 = FS_1109 / (FS_1105 + 9.9999997473787516355514526367188e-05f);
        float FS_1119 = frac(abs(FS_1104.z + ((FS_1106 - FS_1107) / ((6.0f * FS_1109) + 9.9999997473787516355514526367188e-05f))));
        float FS_1125 = lerp(0.699999988079071044921875f, 0.3499999940395355224609375f, smoothstep(0.449999988079071044921875f, 0.3499999940395355224609375f, abs(FS_1119 - 0.5f))) * clamp(FS_1105, 0.0f, 1.0f);
        float FS_1126 = isnan(FS_1125) ? FS_1118 : (isnan(FS_1118) ? FS_1125 : min(FS_1118, FS_1125));
        float FS_1128 = 2.0f / (2.0f - FS_1126);
        FS_1141 = lerp(1.0f.xxx, clamp(abs((frac(float3(FS_1119, FS_1126, FS_1128).xxx + float3(1.0f, 0.666666686534881591796875f, 0.3333333432674407958984375f)) * 6.0f) - 3.0f.xxx) - 1.0f.xxx, 0.0f.xxx, 1.0f.xxx), FS_1126.xxx) * FS_1128;
        FS_1142 = (isnan(0.0f) ? FS_1085 : (isnan(FS_1085) ? 0.0f : max(FS_1085, 0.0f))) * FS_643;
    }
    else
    {
        FS_1141 = FS_19_m82.xyz;
        FS_1142 = FS_643;
    }
    float FS_1161 = FS_514.x * lerp(clamp(FS_598 + 0.5f, 0.0f, 1.0f), 1.0f, FS_516);
    float FS_1175 = clamp((1.0f - clamp((clamp(dot(FS_573, FS_409), 0.0f, 1.0f) * 0.85000002384185791015625f) + 0.1500000059604644775390625f, 0.0f, 1.0f)) * (FS_1161 * lerp(FS_49_m31, FS_49_m30, FS_517)), 0.0f, 1.0f);
    float3 FS_1183 = FS_477 * ((1.0f - FS_1175).xxx + (FS_49_m34.xyz * FS_1175));
    float FS_1184 = lerp(0.0f, FS_49_m1, FS_516);
    float FS_1270;
    float FS_1271;
    float3 FS_1272;
    float FS_1273;
    float FS_1274;
    [branch]
    if ((clamp(FS_621 + FS_634, 0.0f, 1.0f) - FS_49_m20) > 0.00999999977648258209228515625f)
    {
        float FS_1197 = FS_19_m10.x * 0.800000011920928955078125f;
        float4 FS_1202 = FS4765_54.SampleBias(sampler_LinearRepeat, FS_3 + float2(0.0f, frac(FS_1197)), FS_19_m16);
        float4 FS_1216 = float4(FS_1202.xy, FS4765_54.SampleBias(sampler_LinearRepeat, FS_3 + float2(0.0f, frac(FS_1197 + 0.004999999888241291046142578125f)), FS_19_m16).w, FS_1202.w);
        float4 FS_1220 = FS4765_55.SampleBias(sampler_LinearRepeat, FS_3, FS_19_m16);
        float FS_1221 = FS_1220.z;
        float2 FS_1223 = FS_1216.zw * FS_1221;
        float FS_1225 = FS_1223.y;
        float2 FS_1228 = (FS_1216.xy * 2.0f) - 1.0f.xx;
        float FS_1229 = FS_1223.x;
        float FS_1232 = clamp(FS_1229 + FS_1225, 0.0f, 1.0f) * FS_635;
        float FS_1233 = (FS_1202.z * FS_1221) * FS_635;
        float3 FS_1236 = float3(FS_1228, 0.0f);
        float2 FS_1237 = FS_1236.xy;
        float FS_1241 = sqrt(1.0f - clamp(dot(FS_1237, FS_1237), 0.0f, 1.0f));
        float3 FS_1243 = FS_1236;
        FS_1243.z = isnan(FS_1241) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? FS_1241 : max(1.000000016862383526387164645044e-16f, FS_1241));
        float FS_1251 = lerp(smoothstep(0.0f, 0.800000011920928955078125f, (FS_1228.y * 0.5f) + 0.5f), 1.0f, clamp(FS_1229 - FS_1225, 0.0f, 1.0f));
        FS_1270 = lerp(FS_1184, 3.0f, clamp((FS_1232 * 2.0f) + FS_1233, 0.0f, 1.0f) * FS_635);
        FS_1271 = FS_456 * ((1.0f - FS_1232) + (lerp((1.0f - FS_1251) + (0.800000011920928955078125f * FS_1251), 0.89999997615814208984375f, FS_516) * FS_1232));
        FS_1272 = normalize(mul(FS_1243, FS_562)) * FS_572;
        FS_1273 = lerp(FS_455, 0.5f, FS_635);
        FS_1274 = clamp(clamp(FS_1232 + FS_1233, 0.0f, 1.0f), 0.0f, 1.0f);
    }
    else
    {
        FS_1270 = FS_1184;
        FS_1271 = FS_456;
        FS_1272 = FS_573;
        FS_1273 = FS_455;
        FS_1274 = 0.0f;
    }
    float3 FS_1434;
    float FS_1435;
    float FS_1436;
    float3 FS_1437;
    float3 FS_1438;
    float FS_1439;
    [branch]
    if (FS_624 > 0.00999999977648258209228515625f)
    {
        bool3 FS_1278 = FS_418.xxx;
        float3 FS_1280 = FS_10.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 FS_1281 = float3(FS_1278.x ? FS_1280.x : FS_10.x, FS_1278.y ? FS_1280.y : FS_10.y, FS_1278.z ? FS_1280.z : FS_10.z);
        float3 FS_1284 = FS_1281 * FS_19_m89.z;
        float3 FS_1286 = float3(FS_1278.x ? FS_9.xzy.x : FS_9.x, FS_1278.y ? FS_9.xzy.y : FS_9.y, FS_1278.z ? FS_9.xzy.z : FS_9.z);
        float3 FS_1288 = abs(FS_1286) - 0.20000000298023223876953125f.xxx;
        float3 FS_1290 = (FS_1288 * FS_1288) * FS_1288;
        bool3 FS_3324 = isnan(FS_1290);
        bool3 FS_3325 = isnan(6.103515625e-05f.xxx);
        float3 FS_3326 = max(FS_1290, 6.103515625e-05f.xxx);
        float3 FS_3327 = float3(FS_3324.x ? 6.103515625e-05f.xxx.x : FS_3326.x, FS_3324.y ? 6.103515625e-05f.xxx.y : FS_3326.y, FS_3324.z ? 6.103515625e-05f.xxx.z : FS_3326.z);
        float3 FS_1291 = float3(FS_3325.x ? FS_1290.x : FS_3327.x, FS_3325.y ? FS_1290.y : FS_3327.y, FS_3325.z ? FS_1290.z : FS_3327.z);
        float3 FS_1294 = FS_1291 / dot(FS_1291, 1.0f.xxx).xxx;
        float FS_1310 = FS_1294.y;
        float FS_1312 = FS_1294.z;
        float FS_1315 = FS_1294.x;
        float4 FS_1317 = ((FS_54.SampleBias(sampler_LinearRepeat, FS_1284.xz, FS_19_m16) * FS_1310) + (FS_54.SampleBias(sampler_LinearRepeat, FS_1284.xy, FS_19_m16) * FS_1312)) + (FS_54.SampleBias(sampler_LinearRepeat, FS_1284.zy, FS_19_m16) * FS_1315);
        float FS_1325 = clamp(FS_624 + (smoothstep(0.3499999940395355224609375f, 0.20000000298023223876953125f, FS_1281.y) * clamp(FS_624 * 3.0f, 0.0f, 1.0f)), 0.0f, 1.0f);
        float FS_1338 = smoothstep(2.0f - FS_1325, 2.349999904632568359375f - FS_1325, lerp(0.0f, (smoothstep(-1.0f, 0.0f, FS_1286.y) + FS_1317.z) * 0.60000002384185791015625f, FS_516 * FS_1161)) * ((FS_1271 * FS_1271) * float(FSgl_FrontFacing));
        float3 FS_1340 = FS_1338.xxx;
        float2 FS_1346 = (FS_1317.xy * 2.0f) - 1.0f.xx;
        float2 FS_1348 = FS_1346.xy;
        float FS_1352 = sqrt(1.0f - clamp(dot(FS_1348, FS_1348), 0.0f, 1.0f));
        float3 FS_1354 = float3(FS_1346.x, FS_1346.y, FS_371.z);
        FS_1354.z = isnan(FS_1352) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? FS_1352 : max(1.000000016862383526387164645044e-16f, FS_1352));
        float2 FS_1356 = FS_1354.xy * 2.0f;
        float3 FS_1358 = lerp(float3(0.0f, 0.0f, 1.0f), float3(FS_1356.x, FS_1356.y, FS_1354.z), FS_1340);
        float FS_1359 = dot(FS_1358, FS_1358);
        float3 FS_1362 = FS_1358 * rsqrt(isnan(FS_1359) ? 6.103515625e-05f : (isnan(6.103515625e-05f) ? FS_1359 : max(6.103515625e-05f, FS_1359)));
        float FS_1363 = FS_573.y;
        float FS_1366 = step(0.00999999977648258209228515625f, 1.0f - (FS_1363 * FS_1363));
        float FS_1369 = lerp(FS_645, FS_1363, FS_1366);
        float FS_1371 = 1.0f - (FS_1369 * FS_1369);
        float3 FS_1376 = (float3(0.0f, FS_1366, 1.0f - FS_1366) - (FS_573 * FS_1369)) * rsqrt(isnan(FS_1371) ? 9.9999997473787516355514526367188e-05f : (isnan(9.9999997473787516355514526367188e-05f) ? FS_1371 : max(9.9999997473787516355514526367188e-05f, FS_1371)));
        float3 FS_1390 = FS_1284 * 4.0f;
        float4 FS_1410 = ((FS_55.SampleLevel(sampler_PointRepeat, FS_1390.xz, 0.0f) * FS_1310) + (FS_55.SampleLevel(sampler_PointRepeat, FS_1390.xy, 0.0f) * FS_1312)) + (FS_55.SampleLevel(sampler_PointRepeat, FS_1390.zy, 0.0f) * FS_1315);
        float2 FS_1413 = (FS_1410.xz * 2.0f) - 1.0f.xx;
        float FS_1424 = smoothstep(0.949999988079071044921875f, 1.0f, frac(((dot(float3(FS_1413.x, FS_1410.y, FS_1413.y), (floor(FS_409 * 50.0f) * 0.0199999995529651641845703125f) * 0.100000001490116119384765625f) * 0.5f) + 0.5f) * 2.0f));
        float FS_1425 = FS_1424 * FS_1424;
        float FS_1428 = FS_1425 * ((FS_1425 * 2.0f) * FS_1338);
        float3 FS_1429 = 1.0f.xxx * FS_1428;
        FS_1434 = ((cross(FS_1376, FS_573) * FS_1362.x) + (FS_1376 * FS_1362.y)) + (FS_573 * FS_1362.z);
        FS_1435 = FS_1428;
        FS_1436 = lerp(lerp(FS_1273, 0.89999997615814208984375f, clamp(FS_1338 * 4.0f, 0.0f, 1.0f)), 0.00999999977648258209228515625f, FS_1428);
        FS_1437 = lerp(FS_510 * 1.0f, 0.3079999983310699462890625f.xxx, FS_1340) + (FS_1429 * 0.5f);
        FS_1438 = lerp(FS_1183 * 1.0f, 0.87999999523162841796875f.xxx, FS_1340) + FS_1429;
        FS_1439 = lerp(FS_49_m2, 0.0f, FS_1338);
    }
    else
    {
        FS_1434 = FS_573;
        FS_1435 = 0.0f;
        FS_1436 = FS_1273;
        FS_1437 = FS_510;
        FS_1438 = FS_1183;
        FS_1439 = FS_49_m2;
    }
    float FS_1441 = 0.959999978542327880859375f - (FS_1439 * 0.959999978542327880859375f);
    float3 FS_1442 = FS_1438 * FS_1441;
    float3 FS_1445 = lerp(0.039999999105930328369140625f.xxx * FS_1270, FS_1438, FS_1439.xxx);
    float3 FS_1446 = FS_1437 * FS_1441;
    float FS_1447 = FS_1436 * FS_1436;
    float FS_1448 = isnan(0.0078125f) ? FS_1447 : (isnan(FS_1447) ? 0.0078125f : max(FS_1447, 0.0078125f));
    float2 FS_1461 = (FS_7.xy / (isnan(9.9999999392252902907785028219223e-09f) ? FS_7.z : (isnan(FS_7.z) ? 9.9999999392252902907785028219223e-09f : max(FS_7.z, 9.9999999392252902907785028219223e-09f))).xx) - (FS_8.xy / (isnan(9.9999999392252902907785028219223e-09f) ? FS_8.z : (isnan(FS_8.z) ? 9.9999999392252902907785028219223e-09f : max(FS_8.z, 9.9999999392252902907785028219223e-09f))).xx);
    float2 FS_1464 = FS_1461;
    FS_1464.y = -FS_1461.y;
    float2 FS_1474 = ((sqrt(sqrt(abs(FS_1464 * 0.5f))) * float2(int2(sign(FS_1464)))) * 0.5f) + 0.5f.xx;
    float4 FS_1478 = float4(FS_1474.x, FS_1474.y, 0.0f.xxxx.z, 0.0f.xxxx.w);
    FS_1478.z = 1.0f;
    float4 FS_1479 = FS_1478;
    FS_1479.w = (FS_1435 > 0.100000001490116119384765625f) ? 0.699999988079071044921875f : 0.4000000059604644775390625f;
    float3 FS_1490 = lerp(-FS_36_m0.xyz, FS_19_m90.xyz, FS_19_m80.w.xxx);
    float3 FS_1504 = lerp(FS_36_m3.xyz, FS_19_m83.xyz, FS_19_m91.y.xxx);
    float3 FS_1508 = FS_1504 * lerp(FS_36_m3.w, 1.0f, FS_19_m91.w);
    int FS_1512 = int(FS_576.x);
    int FS_1513 = int(FS_576.y);
    float4 FS_1517 = FS_40.Load(int3(int3(FS_1512, FS_1513, 0).xy, 0));
    float FS_1522 = FS_1517.y;
    float FS_1525 = lerp(lerp(1.0f, FS_1517.x, FS_38_m6.x), 1.0f, FS_19_m80.z);
    float3 FS_1533 = FS_1446 * FS_19_m79.z;
    float3 FS_1534 = FS_1533 * 0.64999997615814208984375f;
    float3 FS_1548 = mul(FS_1490, FS_590);
    float3 FS_1550 = float3(FS_1548.x, FS_1548.y, FS_1548.z);
    FS_1550.y = 6.103515625e-05f;
    float3 FS_1551 = normalize(FS_1550);
    float FS_1554 = float(FS_1551.x > 0.0f);
    float2 FS_1558 = FS_3;
    FS_1558.x = lerp(1.0f - FS_3.x, FS_3.x, FS_1554);
    float4 FS_1562 = FS4765_60.SampleLevel(sampler_LinearClamp, FS_1558, 0.0f);
    float FS_1564 = FS_1562.z * 2.0f;
    float FS_1567 = lerp(1.0f - FS_1564, FS_1564 - 1.0f, FS_1554);
    float3 FS_1572 = mul(FS_590, normalize(float3(FS_1567, 6.103515625e-05f, 1.0f - abs(FS_1567))));
    float FS_1573 = dot(FS_1572, FS_1572);
    float3 FS_1579 = normalize(lerp((FS_1572 * rsqrt(isnan(FS_1573) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? FS_1573 : max(1.1754943508222875079687365372222e-38f, FS_1573)))).xyz, FS_1434, FS_648));
    float FS_1580 = FS_1562.w;
    float FS_1581 = FS_1551.z;
    float FS_1582 = -FS_1581;
    float FS_1597 = lerp(FS_1581, (FS_1582 * ((FS_1581 * 0.5f) - 1.0f)) + 0.5f, (clamp(-dot(normalize(float3(FS_1490.x, 6.103515625e-05f, FS_1490.z)).xz, normalize(FS_586.xz)), 0.0f, 1.0f) * clamp(FS_1582, 0.0f, 1.0f)) * (1.0f - FS_19_m91.x)) * 0.5f;
    float FS_1599 = clamp(0.5f - FS_1597, 0.001000000047497451305389404296875f, 0.999000012874603271484375f);
    float FS_1601 = FS_1599 - (1.0f - FS_1599);
    float FS_1603 = FS_1599 + FS_1599;
    float FS_1605 = (FS_1562.x + FS_1562.y) * 0.5f;
    float FS_1616 = FS_19_m94.z * 0.5f;
    float FS_1618 = clamp(0.5f - FS_1616, 0.001000000047497451305389404296875f, 0.999000012874603271484375f);
    float FS_1620 = FS_1618 - (1.0f - FS_1618);
    float FS_1622 = FS_1618 + FS_1618;
    float4 FS_1639 = FS4765_50.SampleLevel(sampler_LinearClamp, float2((lerp(lerp(-1.0f, 1.0f, abs((-smoothstep(isnan(0.0f) ? FS_1601 : (isnan(FS_1601) ? 0.0f : max(FS_1601, 0.0f)), isnan(1.0f) ? FS_1603 : (isnan(FS_1603) ? 1.0f : min(FS_1603, 1.0f)), FS_1605)) - (FS_1597 * ceil(FS_1597)))), clamp(dot(FS_1434, FS_1490) + (FS_19_m90.w * FS_19_m91.x), -1.0f, 1.0f), FS_516) * 0.5f) + 0.5f, 0.5f), 0.0f);
    float FS_1640 = FS_1639.w;
    float FS_1642 = FS_1639.x;
    float FS_1643 = FS_1639.y;
    float FS_1644 = FS_1639.z;
    float FS_1645 = isnan(FS_1643) ? FS_1642 : (isnan(FS_1642) ? FS_1643 : max(FS_1642, FS_1643));
    float FS_1647 = isnan(FS_1643) ? FS_1642 : (isnan(FS_1642) ? FS_1643 : min(FS_1642, FS_1643));
    float FS_1649 = (isnan(FS_1644) ? FS_1645 : (isnan(FS_1645) ? FS_1644 : max(FS_1645, FS_1644))) - (isnan(FS_1644) ? FS_1647 : (isnan(FS_1647) ? FS_1644 : min(FS_1647, FS_1644)));
    float FS_1651 = FS_517 * smoothstep(0.75f, 0.25f, FS_598);
    float FS_1652 = isnan(FS_1651) ? FS_516 : (isnan(FS_516) ? FS_1651 : max(FS_516, FS_1651));
    float FS_1655 = (1.0f - FS_1652) + (FS_1522 * FS_1652);
    float FS_1656 = 1.0f - FS_516;
    float FS_1664 = isnan(FS_1271) ? FS_1655 : (isnan(FS_1655) ? FS_1271 : min(FS_1655, FS_1271));
    float FS_1665 = isnan(FS_1640) ? FS_1664 : (isnan(FS_1664) ? FS_1640 : min(FS_1664, FS_1640));
    float FS_1666 = FS_1271 * FS_1655;
    float3 FS_1670 = ((clamp(dot(FS_650, FS_19_m85.xyz) + FS_19_m86.x, 0.0f, 1.0f) * FS_19_m86.y) + FS_19_m86.z).xxx * lerp(FS_1141, 1.0f.xxx, (FS_19_m80.y * FS_1665).xxx);
    float3 FS_1672 = FS_1665.xxx;
    float FS_1685 = lerp(0.64999997615814208984375f, 1.0f, FS_1142);
    float3 FS_1695 = FS_1525.xxx;
    float3 FS_1696 = lerp((FS_1670 * lerp(isnan(1.5f) ? FS_1685 : (isnan(FS_1685) ? 1.5f : min(FS_1685, 1.5f)), clamp(FS_1142, 1.25f, 1.75f), FS_19_m80.x)) * FS_19_m79.w, (lerp(dot(FS_1508, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, FS_1508, FS_1672) + ((FS_1670 * clamp(FS_1142, 0.0f, 1.5f)) * ((1.0f - FS_19_m91.y).xxx + (FS_1504 * FS_19_m91.y)))) * FS_19_m79.y, FS_1695);
    float3 FS_1697 = lerp(lerp(lerp(dot(FS_1534, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, FS_1534, 1.2000000476837158203125f.xxx), FS_1533, clamp((FS_1271 * (FS_1656 + (FS_1655 * FS_516))) + FS_1640, 0.0f, 1.0f).xxx), FS_1442, FS_1672);
    float3 FS_1703 = FS_1697 * ((1.0f - FS_1649).xxx + (FS_1639.xyz * FS_1649));
    float FS_1704 = dot(FS_1703, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float3 FS_1712 = lerp(lerp(FS_1533, lerp(dot(FS_1442, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, FS_1442, 1.2000000476837158203125f.xxx), FS_1666.xxx), FS_1703 * clamp(dot(FS_1697, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)) * (1.0f / (isnan(0.001000000047497451305389404296875f) ? FS_1704 : (isnan(FS_1704) ? 0.001000000047497451305389404296875f : max(FS_1704, 0.001000000047497451305389404296875f)))), 0.0f, 1.5f), FS_1695);
    float4 FS_1716 = float4(FS_1712, FS_1525);
    float FS_1718 = lerp(FS_1666, FS_1665, FS_1525);
    float3 FS_1724 = (FS_1696 * (((FS_1718 * 0.5f) + 0.5f) * lerp(FS_19_m79.z, 1.0f, FS_1718))) * 1.0f;
    float3 FS_1729 = float3(FS_586.x, lerp(0.5f, FS_1490.y, FS_1525), FS_586.z);
    float FS_1730 = dot(FS_1729, FS_1729);
    float FS_1742 = clamp(dot(FS_1272, FS_409), 0.0f, 1.0f);
    float FS_1743 = dot(FS_1272, normalize(((FS_1490 * FS_1525) + ((FS_1729 * rsqrt(isnan(FS_1730) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? FS_1730 : max(1.1754943508222875079687365372222e-38f, FS_1730)))) * 2.0f)) + (FS_409 * (2.0f + FS_1525))));
    float FS_1744 = FS_1448 * FS_1448;
    float FS_1748 = (((FS_1743 * FS_1744) - FS_1743) * FS_1743) + 1.0f;
    float FS_1749 = FS_1748 * FS_1748;
    float FS_1753 = 2.0f * FS_1742;
    float FS_1755 = (1.0f + FS_1742) - FS_1742;
    float4 FS_1778 = FS4765_51.SampleBias(sampler_LinearRepeat, FS_3 + (mul(FS_409, FS_590).xy * FS_49_m41.xy), FS_19_m16);
    float3 FS_1810;
    if (FS_1274 > 0.001000000047497451305389404296875f)
    {
        FS_1810 = ((FS4765_55.SampleBias(sampler_LinearClamp, (normalize(mul(float3x3(FS_17_m0[0].xyz, FS_17_m0[1].xyz, FS_17_m0[2].xyz), FS_1272)).xy * 0.5f) + 0.5f.xx, FS_19_m16).w.xxx * FS_1655) * (clamp(FS_1142, 0.5f, 1.5f) * FS_19_m79.w)) * (FS_1274 * FS_1274);
    }
    else
    {
        FS_1810 = 0.0f.xxx;
    }
    float3 FS_1813 = ((FS_1696 * FS_1712) * 1.0f) + (((((FS_1445 * clamp((((FS_1744 != FS_1749) ? (FS_1744 / FS_1749) : 1.0f) * (0.5f / ((FS_1753 + (FS_1448 * FS_1755)) + 9.9999997473787516355514526367188e-05f))) - 6.103515625e-05f, 0.0f, 20.0f)) * FS_1724) * FS_19_m92.w) + (FS_1778.xyz * FS_1724)) + FS_1810);
    float FS_1814 = dot(FS_1813, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float FS_1817 = clamp(FS_1814 - 0.5f, 0.0f, 0.5f);
    float3 FS_1853 = normalize(cross(FS_586, lerp(float3(FS_19_m88.xy, 0.0f), (float3(FS_17_m0[0].x, FS_17_m0[0].y, FS_17_m0[0].z) * FS_19_m88.x) + (float3(FS_17_m0[1].x, FS_17_m0[1].y, FS_17_m0[1].z) * FS_19_m88.y), FS_19_m94.w.xxx)));
    float FS_1859 = dot(FS_409, FS_1579);
    float FS_1861 = 1.0f - abs(FS_1859);
    float FS_1866 = smoothstep(0.89999997615814208984375f, 1.0f, abs(FS_598));
    float FS_1869 = float(dot(FS_586, FS_1853) < (-0.00999999977648258209228515625f));
    float FS_1883 = clamp(dot(FS_553, FS_1853) + 1.0f, 0.0f, 1.0f);
    float FS_1884 = isnan(FS_1271) ? FS_1883 : (isnan(FS_1883) ? FS_1271 : min(FS_1883, FS_1271));
    float2 FS_1906 = float2(FS_576);
    float2 FS_1908 = floor(FS_1906 * 0.03125f);
    int FS_1916 = int((FS_1908.x + (FS_1908.y * FS_34_m5)) * 8.0f);
    float FS_1923 = floor(FS_390 - (FS_19_m3.y * FS_34_m11));
    float FS_1927 = clamp(FS_1923, 0.0f, FS_34_m7 - 1.0f);
    int FS_1929 = int(FS_1927 * 8.0f);
    float3 FS_1931;
    FS_1931 = lerp(FS_1814.xxx, FS_1813, ((FS_1817 * FS_1817) + 1.0f).xxx) + (((((FS_19_m87.xyz * lerp(smoothstep(lerp(0.800000011920928955078125f, 0.20000000298023223876953125f, FS_19_m88.w), lerp(0.89999997615814208984375f, 0.5f, FS_19_m88.w), FS_1861) * FS_1866, (isnan(FS_1869) ? FS_1866 : (isnan(FS_1866) ? FS_1869 : max(FS_1866, FS_1869))) * FS_518, clamp((FS_19_m88.w * 10.0f) - 3.0f, 0.0f, 1.0f))) * FS_19_m87.w) * (isnan(FS_1522) ? FS_1884 : (isnan(FS_1884) ? FS_1522 : min(FS_1884, FS_1522)))) * (lerp(0.25f.xxx, FS_1442, FS_19_m88.z.xxx) * clamp(dot(FS_1853, FS_1579), 0.0f, 1.0f))) + (((FS_19_m93.xyz * (smoothstep(-0.5f, 0.5f, lerp(-1.0f, 1.0f, abs((-smoothstep(isnan(0.0f) ? FS_1620 : (isnan(FS_1620) ? 0.0f : max(FS_1620, 0.0f)), isnan(1.0f) ? FS_1622 : (isnan(FS_1622) ? 1.0f : min(FS_1622, 1.0f)), FS_1605)) - (FS_1616 * ceil(FS_1616))))) * FS_1656)) * FS_19_m93.w) * FS_1442));
    float3 FS_1932;
    [loop]
    for (int FS_1934 = 0; FS_1934 <= 7; FS_1931 = FS_1932, FS_1934++)
    {
        uint FS_1952 = (FS_1923 <= FS_1927) ? (FS_30.Load(uint(FS_1916 + FS_1934) * 4 + 0) & FS_30.Load(uint((FS_19_m21.y + FS_1929) + FS_1934) * 4 + 0)) : 0u;
        uint FS_1953 = uint(FS_1934);
        FS_1932 = FS_1931;
        uint FS_1958;
        float3 FS_1955;
        [loop]
        for (uint FS_1957 = FS_1952; FS_1957 != 0u; FS_1932 = FS_1955, FS_1957 = FS_1958)
        {
            uint FS_1962 = firstbitlow(FS_1957);
            FS_1958 = FS_1957 ^ (1u << (FS_1962 & 31u));
            int FS_1968 = int((32u * FS_1953) + FS_1962) * 8;
            int FS_1971 = FS_1968 + 1;
            int FS_1974 = FS_1968 + 2;
            int FS_1977 = FS_1968 + 3;
            int FS_1980 = FS_1968 + 4;
            int FS_1983 = FS_1968 + 5;
            int FS_1986 = FS_1968 + 6;
            int FS_1989 = FS_1968 + 7;
            uint FS_1993 = uint(FS_36_m6[FS_1983].w);
            float FS_2068;
            if ((FS_1993 & 1u) == 1u)
            {
                uint FS_1999 = asuint(FS_36_m6[FS_1983].x);
                uint FS_2006 = asuint(FS_36_m6[FS_1983].y);
                uint FS_2013 = asuint(FS_36_m6[FS_1983].z);
                uint FS_2020 = asuint(FS_36_m6[FS_1986].x);
                uint FS_2027 = asuint(FS_36_m6[FS_1986].y);
                uint FS_2034 = asuint(FS_36_m6[FS_1986].z);
                float3 FS_2053 = abs(mul(float4(FS_546 - FS_36_m6[FS_1971].xyz, 1.0f), float4x4(float4(spvUnpackHalf2x16(FS_1999).x, spvUnpackHalf2x16(FS_2013).x, spvUnpackHalf2x16(FS_2027).x, 0.0f), float4(spvUnpackHalf2x16(FS_1999 >> 16u).x, spvUnpackHalf2x16(FS_2013 >> 16u).x, spvUnpackHalf2x16(FS_2027 >> 16u).x, 0.0f), float4(spvUnpackHalf2x16(FS_2006).x, spvUnpackHalf2x16(FS_2020).x, spvUnpackHalf2x16(FS_2034).x, 0.0f), float4(spvUnpackHalf2x16(FS_2006 >> 16u).x, spvUnpackHalf2x16(FS_2020 >> 16u).x, spvUnpackHalf2x16(FS_2034 >> 16u).x, 0.0f))).xyz);
                float FS_2054 = FS_2053.x;
                float FS_2055 = FS_2053.y;
                float FS_2056 = isnan(FS_2055) ? FS_2054 : (isnan(FS_2054) ? FS_2055 : max(FS_2054, FS_2055));
                float FS_2057 = FS_2053.z;
                float FS_2060 = FS_36_m6[FS_1989].x * 0.5f;
                float FS_2066 = 1.0f - clamp(((isnan(FS_2057) ? FS_2056 : (isnan(FS_2056) ? FS_2057 : max(FS_2056, FS_2057))) - (FS_2060 + 0.5f)) / (0.5f - FS_2060), 0.0f, 1.0f);
                FS_2068 = FS_2066 * FS_2066;
            }
            else
            {
                FS_2068 = 1.0f;
            }
            if (false || (FS_2068 < 0.001000000047497451305389404296875f))
            {
                FS_1955 = FS_1932;
                continue;
            }
            float3 FS_2785;
            if (FS_36_m6[FS_1968].w < 1.5f)
            {
                float3 FS_2784;
                EIDEarlyExit1(FS_1272, FS_1436, FS_1439, FS_1442, FS_1445, FS_1446, FS_1448, FS_1525, FS_1579, FS_1580, FS_1656, FS_1716, FS_1753, FS_1755, FS_1861, FS_1866, FS_1932, FS_1968, FS_1971, FS_1974, FS_1977, FS_1980, FS_1986, FS_1989, FS_1993, FS_2068, FS_2784, FS_409, FS_516, FS_518, FS_546, FS_553, FS_574, FS_586, FS_630, FS_648);
                FS_2785 = FS_2784;
            }
            else
            {
                FS_2785 = FS_1932;
            }
            FS_1955 = FS_2785;
        }
    }
    float3 FS_2826;
    [branch]
    if (FS_49_m12 > 0.5f)
    {
        FS_2826 = lerp(lerp(0.5f.xxx, lerp(dot(FS_1931, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, FS_1931, FS_49_m14.xxx), FS_49_m15.xxx) * FS_49_m13, FS_49_m26.xyz, FS_49_m26.w.xxx) + ((FS_49_m27.xyz * (smoothstep(1.0f - FS_49_m16, 1.0f, 1.0f - clamp(FS_1859, 0.0f, 1.0f)) * FS_1161)) * FS_49_m17);
    }
    else
    {
        FS_2826 = FS_1931;
    }
    float4 FS_2834 = float4(FS_2826 * FS_19_m20.y, 1.0f);
    FS_2834.w = 1.0f;
    float4 FS_3217;
    [branch]
    if (FS_19_m91.w < 0.5f)
    {
        float3 FS_2838 = -FS_409;
        float FS_2849 = (FS_410 * FS_19_m44.w) - FS_19_m43.w;
        float FS_2854 = FS_630 * FS_19_m46.w;
        float FS_2858 = FS_2854 + FS_19_m47.w;
        float FS_2859 = isnan(FS_2858) ? 0.00999999977648258209228515625f : (isnan(0.00999999977648258209228515625f) ? FS_2858 : max(0.00999999977648258209228515625f, FS_2858));
        float3 FS_2873 = exp(FS_19_m45.xyz * ((-(isnan(FS_2849) ? 0.0f : (isnan(0.0f) ? FS_2849 : max(0.0f, FS_2849)))) * (((1.0f - exp(-FS_2859)) / FS_2859) * exp(FS_2854 + FS_19_m48.w))));
        float FS_2876 = dot(FS_2838, FS_19_m44.xyz);
        float FS_2882 = FS_19_m45.w * FS_19_m45.w;
        float FS_2886 = (1.0f + FS_2882) - ((2.0f * FS_19_m45.w) * FS_2876);
        float FS_2890 = (12.56637096405029296875f * FS_2886) * sqrt(FS_2886);
        float3 FS_3209;
        float FS_3210;
        if (FS_19_m55.z > 0.0f)
        {
            uint3 FS_3037 = (uint3(int3(FS_1512, FS_1513, int(FS_19_m19 & 7u))) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint FS_3038 = FS_3037.y;
            uint FS_3039 = FS_3037.z;
            uint FS_3042 = FS_3037.x + (FS_3038 * FS_3039);
            uint FS_3044 = FS_3038 + (FS_3039 * FS_3042);
            uint FS_3046 = FS_3039 + (FS_3042 * FS_3044);
            uint FS_3048 = FS_3042 + (FS_3044 * FS_3046);
            float FS_3073 = dot(FS_2838, -FS_17_m0[2].xyz);
            float3 FS_3080 = FS_546 - FS_17_m11.xyz;
            float FS_3082 = (FS_19_m55.w * ((FS_3073 > 5.9604644775390625e-08f) ? (1.0f / FS_3073) : 0.0f)) * (1.0f / FS_410);
            float FS_3083 = FS_3080.y;
            float FS_3084 = FS_3082 * FS_3083;
            float FS_3086 = FS_17_m11.y + FS_3084;
            float FS_3087 = FS_3083 - FS_3084;
            float FS_3089 = (1.0f - FS_3082) * FS_410;
            float FS_3095 = FS_19_m49.z * (FS_3086 - FS_19_m49.x);
            float FS_3102 = FS_19_m49.z * FS_3087;
            float FS_3103 = isnan(FS_3102) ? (-127.0f) : (isnan(-127.0f) ? FS_3102 : max(-127.0f, FS_3102));
            float FS_3119 = FS_19_m52.x * (FS_3086 - FS_19_m52.z);
            float FS_3126 = FS_19_m52.x * FS_3087;
            float FS_3127 = isnan(FS_3126) ? (-127.0f) : (isnan(-127.0f) ? FS_3126 : max(-127.0f, FS_3126));
            float FS_3138 = ((FS_19_m49.y * exp2(-(isnan(FS_3095) ? (-127.0f) : (isnan(-127.0f) ? FS_3095 : max(-127.0f, FS_3095))))) * ((abs(FS_3103) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-FS_3103)) / FS_3103) : (0.693147182464599609375f - (0.2402265071868896484375f * FS_3103)))) + ((FS_19_m52.y * exp2(-(isnan(FS_3119) ? (-127.0f) : (isnan(-127.0f) ? FS_3119 : max(-127.0f, FS_3119))))) * ((abs(FS_3127) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-FS_3127)) / FS_3127) : (0.693147182464599609375f - (0.2402265071868896484375f * FS_3127))));
            float FS_3142 = clamp(exp2(-(FS_3138 * FS_3089)), 0.0f, 1.0f);
            float FS_3160 = clamp((FS_410 * FS_19_m50.w) + FS_19_m50.z, 0.0f, 1.0f);
            float FS_3163 = clamp(((isnan(FS_19_m51.w) ? FS_3142 : (isnan(FS_3142) ? FS_19_m51.w : max(FS_3142, FS_19_m51.w))) + clamp((FS_410 * FS_19_m50.y) + FS_19_m50.x, 0.0f, 1.0f)) + FS_3160, 0.0f, 1.0f);
            float FS_3182 = FS_3089 - FS_19_m53.w;
            float4 FS_3203 = lerp(float4(0.0f, 0.0f, 0.0f, 1.0f), FS_66.SampleLevel(sampler_LinearClamp, float3((FS_1906 + ((((float3(uint3(FS_3048, FS_3044 + (FS_3046 * FS_3048), FS_375) >> uint3(16u, 16u, 16u)) * 1.525902189314365386962890625e-05f.xxx) * 2.0f) - 1.0f.xxx) * FS_19_m59.w).xy) * FS_19_m57.xy, (log2((FS_390 * FS_19_m56.x) + FS_19_m56.y) * FS_19_m56.z) / FS_19_m55.z), 0.0f), clamp((FS_390 - FS_19_m58.z) * 1000000.0f, 0.0f, 1.0f).xxxx);
            float FS_3205 = FS_3203.w;
            FS_3209 = FS_3203.xyz + (((FS_19_m51.xyz * (1.0f - FS_3163)) + (((FS_19_m54.xyz * pow(clamp(dot(FS_409, FS_19_m53.xyz), 0.0f, 1.0f), FS_19_m54.w)) * (1.0f - clamp(exp2(-(FS_3138 * (isnan(0.0f) ? FS_3182 : (isnan(FS_3182) ? 0.0f : max(FS_3182, 0.0f))))), 0.0f, 1.0f))) * (1.0f - FS_3160))) * FS_3205);
            FS_3210 = FS_3205 * FS_3163;
        }
        else
        {
            float3 FS_2913 = FS_546 - FS_17_m11.xyz;
            float FS_2915 = FS_2913.y;
            float FS_2921 = FS_19_m49.z * (FS_17_m11.y - FS_19_m49.x);
            float FS_2928 = FS_19_m49.z * FS_2915;
            float FS_2929 = isnan(FS_2928) ? (-127.0f) : (isnan(-127.0f) ? FS_2928 : max(-127.0f, FS_2928));
            float FS_2945 = FS_19_m52.x * (FS_17_m11.y - FS_19_m52.z);
            float FS_2952 = FS_19_m52.x * FS_2915;
            float FS_2953 = isnan(FS_2952) ? (-127.0f) : (isnan(-127.0f) ? FS_2952 : max(-127.0f, FS_2952));
            float FS_2964 = ((FS_19_m49.y * exp2(-(isnan(FS_2921) ? (-127.0f) : (isnan(-127.0f) ? FS_2921 : max(-127.0f, FS_2921))))) * ((abs(FS_2929) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-FS_2929)) / FS_2929) : (0.693147182464599609375f - (0.2402265071868896484375f * FS_2929)))) + ((FS_19_m52.y * exp2(-(isnan(FS_2945) ? (-127.0f) : (isnan(-127.0f) ? FS_2945 : max(-127.0f, FS_2945))))) * ((abs(FS_2953) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-FS_2953)) / FS_2953) : (0.693147182464599609375f - (0.2402265071868896484375f * FS_2953))));
            float FS_2968 = clamp(exp2(-(FS_2964 * FS_410)), 0.0f, 1.0f);
            float FS_2986 = clamp((FS_410 * FS_19_m50.w) + FS_19_m50.z, 0.0f, 1.0f);
            float FS_2989 = clamp(((isnan(FS_19_m51.w) ? FS_2968 : (isnan(FS_2968) ? FS_19_m51.w : max(FS_2968, FS_19_m51.w))) + clamp((FS_410 * FS_19_m50.y) + FS_19_m50.x, 0.0f, 1.0f)) + FS_2986, 0.0f, 1.0f);
            float FS_3008 = FS_410 - FS_19_m53.w;
            FS_3209 = (FS_19_m51.xyz * (1.0f - FS_2989)) + (((FS_19_m54.xyz * pow(clamp(dot(FS_409, FS_19_m53.xyz), 0.0f, 1.0f), FS_19_m54.w)) * (1.0f - clamp(exp2(-(FS_2964 * (isnan(0.0f) ? FS_3008 : (isnan(FS_3008) ? 0.0f : max(FS_3008, 0.0f))))), 0.0f, 1.0f))) * (1.0f - FS_2986));
            FS_3210 = FS_2989;
        }
        float3 FS_3215 = (FS_2834.xyz * (FS_2873 * FS_3210)) + ((((clamp(((FS_19_m46.xyz * (0.0596831031143665313720703125f * (1.0f + (FS_2876 * FS_2876)))) + FS_19_m48.xyz) + (FS_19_m47.xyz * ((1.0f - FS_2882) / (isnan(0.001000000047497451305389404296875f) ? FS_2890 : (isnan(FS_2890) ? 0.001000000047497451305389404296875f : max(FS_2890, 0.001000000047497451305389404296875f))))), 0.0f.xxx, 1.0f.xxx) * 255.0f) * (1.0f.xxx - FS_2873)) * FS_3210) + FS_3209);
        FS_3217 = float4(FS_3215.x, FS_3215.y, FS_3215.z, FS_2834.w);
    }
    else
    {
        FS_3217 = FS_2834;
    }
    FS_14 = FS_3217;
    FS_15 = FS_1479;
}

FSSPIRV_Cross_Output FSmain(FSSPIRV_Cross_Input stage_input)
{
    FSgl_FragCoord = stage_input.FSgl_FragCoord;
    // Vulkan pixel coordinates match the capture directly (verified with DebugPixel).
    FSgl_FragCoord.w = 1.0 / FSgl_FragCoord.w;
    FSgl_FrontFacing = stage_input.FSgl_FrontFacing;
    FS_3 = stage_input.FS_3;
    FS_4 = stage_input.FS_4;
    FS_5 = stage_input.FS_5;
    FS_6 = stage_input.FS_6;
    FS_7 = stage_input.FS_7;
    FS_8 = stage_input.FS_8;
    FS_9 = stage_input.FS_9;
    FS_10 = stage_input.FS_10;
    FS_12 = stage_input.FS_12;
    FSfrag_main();
    FSSPIRV_Cross_Output stage_output;
    stage_output.FS_14 = FS_14;
    stage_output.FS_15 = FS_15;
    return stage_output;
}
