// Generated from original EID4730 SPIR-V. See Tools/EID4730/build_assets.py.
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

static const int2 FS_366[6] = { int2(2, 1), int2(2, 1), int2(0, 2), int2(0, 2), int2(0, 1), int2(0, 1) };
static const float2 FS_367[6] = { float2(-1.0f, 1.0f), 1.0f.xx, float2(1.0f, -1.0f), 1.0f.xx, 1.0f.xx, float2(-1.0f, 1.0f) };

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
    float4 FS_49_m35 : packoffset(c14);
    float4 FS_49_m36 : packoffset(c15);
    float4 FS_49_m37 : packoffset(c16);
    float4 FS_49_m38 : packoffset(c17);
    float4 FS_49_m39 : packoffset(c18);
    float FS_49_m40 : packoffset(c19);
    float FS_49_m41 : packoffset(c19.y);
    float FS_49_m42 : packoffset(c19.z);
    float FS_49_m43 : packoffset(c19.w);
    float FS_49_m44 : packoffset(c20);
    float FS_49_m45 : packoffset(c20.y);
    float FS_49_m46 : packoffset(c20.z);
    float FS_49_m47 : packoffset(c20.w);
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
Texture2D<float4> FS_50;
Texture2D<float4> FS_51;
Texture2D<float4> FS_52;
Texture2D<float4> FS_53;
Texture2D<float4> FS_54;
Texture2D<float4> FS_55;
Texture2D<float4> FS_56;
Texture2D<float4> FS_57;
Texture2D<float4> FS_58;
TextureCube<float4> FS_60;
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

static float FS_409;
static float3 FS_410;
static float FS_412;
static uint FS_413;

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
 FS_21 v = (FS_21)0;
   v._m0 = unity_ObjectToWorld;
   v._m3 = unity_ObjectToWorld;
   v._m1 = asfloat(uint4(0x447a0000u,0x00000000u,0x00000000u,0x00000034u));
   v._m2 = asfloat(uint4(0x00005fd2u,0x00003e9fu,0x00000402u,0x3f800000u));
   v._m4 = asfloat(uint4(0x3f800000u,0x3f800000u,0x00000000u,0x00000000u));
   v._m5 = asfloat(uint4(0x0000002au,0x00000000u,0x00000000u,0x00000000u));
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
void FSfrag_main()
{
    float FS_428 = 1.0f / FSgl_FragCoord.w;
    float3 FS_443 = lerp(-FS_4, float3(FS_17_m0[2u].x, FS_17_m0[2u].y, FS_17_m0[2u].z), FS_19_m4.w.xxx);
    float FS_444 = dot(FS_443, FS_443);
    float FS_446 = rsqrt(isnan(9.9999999392252902907785028219223e-09f) ? FS_444 : (isnan(FS_444) ? 9.9999999392252902907785028219223e-09f : max(FS_444, 9.9999999392252902907785028219223e-09f)));
    float3 FS_447 = FS_443 * FS_446;
    float FS_448 = FS_444 * FS_446;
    uint FS_451 = 24530u; // Captured EID4730 bone base, kept as integer (no denormal flushing).
    bool FS_456 = true; // Captured instance flag 16.
    float4 FS_469;
    float4 FS_470;
    if (FS_456)
    {
        FS_469 = asfloat(FS_32.Load4((FS_451 + 2u) * 16 + 0));
        FS_470 = asfloat(FS_32.Load4(FS_451 * 16 + 0));
    }
    else
    {
        FS_469 = FSGetInstance(FS_12)._m0[2];
        FS_470 = FSGetInstance(FS_12)._m0[0];
    }
    float4 FS_476 = FS_56.SampleBias(sampler_LinearRepeat, FS_3, FS_19_m16);
    float3 FS_481 = FS_476.xyz * FS_49_m24.xyz;
    float4 FS_485 = FS_57.SampleBias(sampler_LinearRepeat, FS_3, FS_19_m16);
    float FS_486 = FS_485.x;
    float FS_488 = FS_485.z;
    float FS_490 = 1.0f - FS_485.w;
    float FS_494 = FS_476.w * FS_49_m24.w;
    float3 FS_499 = FS_481 * FS_49_m18;
    float3 FS_503 = lerp(dot(FS_499, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, FS_499, FS_49_m19.xxx);
    float4 FS_507 = FS_58.SampleBias(sampler_LinearRepeat, FS_3, FS_19_m16);
    float4 FS_513 = FS_507;
    FS_513.w = FS_507.w * FS_507.x;
    float2 FS_516 = (FS_513.wy * 2.0f) - 1.0f.xx;
    float2 FS_518 = FS_516.xy;
    float FS_522 = sqrt(1.0f - clamp(dot(FS_518, FS_518), 0.0f, 1.0f));
    float3 FS_524 = float3(FS_516.x, FS_516.y, FS_410.z);
    FS_524.z = isnan(FS_522) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? FS_522 : max(1.000000016862383526387164645044e-16f, FS_522));
    float2 FS_526 = FS_524.xy * FS_49_m3;
    float3 FS_531 = FS_4 + FS_17_m11.xyz;
    float3 FS_536 = FS_531 - float3(FS_470.w, FS_412, FS_469.w);
    FS_536.y = 6.103515625e-05f;
    float3 FS_538 = normalize(FS_536);
    float3 FS_548 = mul(float3(FS_526.x, FS_526.y, FS_524.z), float3x3(FS_6.xyz * 1.0f, (cross(FS_5, FS_6.xyz) * FS_6.w) * 1.0f, FS_5 * 1.0f));
    float FS_549 = dot(FS_548, FS_548);
    float FS_557 = FSgl_FrontFacing ? 1.0f : ((-1.0f) + (2.0f * FS_49_m5));
    float3 FS_558 = (FS_548 * rsqrt(isnan(FS_549) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? FS_549 : max(1.1754943508222875079687365372222e-38f, FS_549)))) * FS_557;
    float3 FS_559 = normalize(FS_5) * FS_557;
    uint2 FS_561 = uint2(FSgl_FragCoord.xy);
    float3 FS_571 = mul(float3x3(FS_17_m1[0].xyz, FS_17_m1[1].xyz, FS_17_m1[2].xyz), float3(0.0f, 0.0f, 1.0f));
    uint FS_580 = asuint((FS_19_m89.x > 0.5f) ? FS_19_m89.y : FSGetInstance(FS_12)._m7.x);
    float4 FS_593 = float4(float(FS_580 & 255u), float((FS_580 >> 8u) & 255u), float((FS_580 >> 16u) & 255u), float((FS_580 >> 24u) & 255u)) * 0.0039215688593685626983642578125f.xxxx;
    float FS_594 = FS_593.x;
    float FS_596 = FS_593.z;
    float FS_597 = FS_593.w;
    float FS_603 = FS_531.y;
    float FS_606 = smoothstep(-0.20000000298023223876953125f, 0.1500000059604644775390625f, lerp(FSGetInstance(FS_12)._m7.y, FS_19_m89.w, FS_19_m89.x) - FS_603) * FS_593.y;
    float FS_607 = isnan(FS_606) ? FS_596 : (isnan(FS_596) ? FS_606 : max(FS_596, FS_606));
    float FS_616 = lerp(FS_19_m22.x, 1.0f, FS_19_m91.w) * FS_19_m20.x;
    float4 FS_1110;
    float3 FS_1111;
    float3 FS_1112;
    float FS_1113;
    if (FS_19_m80.y < 0.5f)
    {
        float3 FS_631 = FS_531 - (FS_19_m105.xyz + (FS_571 * (-FS_19_m107.w)));
        float FS_633 = abs(FS_631.x);
        float FS_635 = abs(FS_631.z);
        float FS_641 = clamp(((isnan(FS_635) ? FS_633 : (isnan(FS_633) ? FS_635 : max(FS_633, FS_635))) - 464.0f) * 0.03125f, 0.0f, 1.0f);
        float FS_644 = clamp((abs(FS_631.y) - 208.0f) * 0.03125f, 0.0f, 1.0f);
        float FS_645 = isnan(FS_644) ? FS_641 : (isnan(FS_641) ? FS_644 : max(FS_641, FS_644));
        float4 FS_947;
        float4 FS_948;
        float4 FS_949;
        float FS_950;
        float FS_951;
        if ((FS_19_m105.w != 0.0f) && (FS_645 < 1.0f))
        {
            float3 FS_658 = FS_531 - (FS_19_m105.xyz + (FS_571 * (-FS_19_m107.y)));
            float FS_660 = abs(FS_658.x);
            float FS_662 = abs(FS_658.z);
            float FS_668 = clamp(((isnan(FS_662) ? FS_660 : (isnan(FS_660) ? FS_662 : max(FS_660, FS_662))) - 29.0f) * 0.5f, 0.0f, 1.0f);
            float FS_671 = clamp((abs(FS_658.y) - 13.0f) * 0.5f, 0.0f, 1.0f);
            float FS_672 = isnan(FS_671) ? FS_668 : (isnan(FS_668) ? FS_671 : max(FS_668, FS_671));
            float FS_748;
            float4 FS_749;
            float4 FS_750;
            float4 FS_751;
            if (FS_672 < 1.0f)
            {
                float3 FS_681 = ((FS_531 * 2.0f) + 0.5f.xxx) * FS_19_m106.xyz;
                float3 FS_683 = FS_681 - floor(FS_681);
                float4 FS_687 = FS_42.SampleLevel(sampler_LinearRepeat, FS_683, 0.0f);
                float FS_688 = 1.0f - FS_672;
                float FS_692 = FS_19_m106.y * 0.5f;
                float FS_697 = FS_683.x;
                float FS_698 = clamp(FS_683.y, FS_692, 1.0f - FS_692) * 0.3333333432674407958984375f;
                float FS_699 = FS_683.z;
                float4 FS_702 = FS_43.SampleLevel(sampler_LinearClamp, float3(FS_697, FS_698, FS_699), 0.0f);
                float FS_718 = FS_687.x;
                float FS_728 = FS_687.y;
                float FS_738 = FS_687.z;
                FS_748 = FS_645 + (FS_702.w * FS_688);
                FS_749 = float4(((FS_43.SampleLevel(sampler_LinearClamp, float3(FS_697, FS_698 + 0.666666686534881591796875f, FS_699), 0.0f).xyz * 4.0f) - 2.0f.xxx) * FS_738, FS_738) * FS_688;
                FS_750 = float4(((FS_43.SampleLevel(sampler_LinearClamp, float3(FS_697, FS_698 + 0.3333333432674407958984375f, FS_699), 0.0f).xyz * 4.0f) - 2.0f.xxx) * FS_728, FS_728) * FS_688;
                FS_751 = float4(((FS_702.xyz * 4.0f) - 2.0f.xxx) * FS_718, FS_718) * FS_688;
            }
            else
            {
                FS_748 = FS_645;
                FS_749 = 0.0f.xxxx;
                FS_750 = 0.0f.xxxx;
                FS_751 = 0.0f.xxxx;
            }
            float3 FS_757 = FS_531 - (FS_19_m105.xyz + (FS_571 * (-FS_19_m107.z)));
            float FS_759 = abs(FS_757.x);
            float FS_761 = abs(FS_757.z);
            float FS_767 = clamp(((isnan(FS_761) ? FS_759 : (isnan(FS_759) ? FS_761 : max(FS_759, FS_761))) - 116.0f) * 0.125f, 0.0f, 1.0f);
            float FS_770 = clamp((abs(FS_757.y) - 52.0f) * 0.125f, 0.0f, 1.0f);
            float FS_771 = isnan(FS_770) ? FS_767 : (isnan(FS_767) ? FS_770 : max(FS_767, FS_770));
            float FS_851;
            float4 FS_852;
            float4 FS_853;
            float4 FS_854;
            if (FS_771 < 1.0f)
            {
                float3 FS_780 = ((FS_531 * 0.5f) + 0.5f.xxx) * FS_19_m106.xyz;
                float3 FS_782 = FS_780 - floor(FS_780);
                float4 FS_786 = FS_44.SampleLevel(sampler_LinearRepeat, FS_782, 0.0f);
                float FS_788 = FS_672 * (1.0f - FS_771);
                float FS_792 = FS_19_m106.y * 0.5f;
                float FS_797 = FS_782.x;
                float FS_798 = clamp(FS_782.y, FS_792, 1.0f - FS_792) * 0.3333333432674407958984375f;
                float FS_799 = FS_782.z;
                float4 FS_802 = FS_45.SampleLevel(sampler_LinearClamp, float3(FS_797, FS_798, FS_799), 0.0f);
                float FS_818 = FS_786.x;
                float FS_829 = FS_786.y;
                float FS_840 = FS_786.z;
                FS_851 = FS_748 + (FS_802.w * FS_788);
                FS_852 = FS_749 + (float4(((FS_45.SampleLevel(sampler_LinearClamp, float3(FS_797, FS_798 + 0.666666686534881591796875f, FS_799), 0.0f).xyz * 4.0f) - 2.0f.xxx) * FS_840, FS_840) * FS_788);
                FS_853 = FS_750 + (float4(((FS_45.SampleLevel(sampler_LinearClamp, float3(FS_797, FS_798 + 0.3333333432674407958984375f, FS_799), 0.0f).xyz * 4.0f) - 2.0f.xxx) * FS_829, FS_829) * FS_788);
                FS_854 = FS_751 + (float4(((FS_802.xyz * 4.0f) - 2.0f.xxx) * FS_818, FS_818) * FS_788);
            }
            else
            {
                FS_851 = FS_748;
                FS_852 = FS_749;
                FS_853 = FS_750;
                FS_854 = FS_751;
            }
            float4 FS_937;
            float4 FS_938;
            float4 FS_939;
            float FS_940;
            if (FS_771 > 0.0f)
            {
                float3 FS_863 = ((FS_531 * 0.125f) + 0.5f.xxx) * FS_19_m106.xyz;
                float3 FS_866 = FS_19_m106.xyz * 0.5f;
                float3 FS_868 = clamp(FS_863 - floor(FS_863), FS_866, 1.0f.xxx - FS_866);
                float4 FS_872 = FS_46.SampleLevel(sampler_LinearRepeat, FS_868, 0.0f);
                float FS_874 = FS_771 * (1.0f - FS_645);
                float FS_878 = FS_19_m106.y * 0.5f;
                float FS_883 = FS_868.x;
                float FS_884 = clamp(FS_868.y, FS_878, 1.0f - FS_878) * 0.3333333432674407958984375f;
                float FS_885 = FS_868.z;
                float4 FS_888 = FS_47.SampleLevel(sampler_LinearClamp, float3(FS_883, FS_884, FS_885), 0.0f);
                float FS_904 = FS_872.x;
                float FS_915 = FS_872.y;
                float FS_926 = FS_872.z;
                FS_937 = FS_852 + (float4(((FS_47.SampleLevel(sampler_LinearClamp, float3(FS_883, FS_884 + 0.666666686534881591796875f, FS_885), 0.0f).xyz * 4.0f) - 2.0f.xxx) * FS_926, FS_926) * FS_874);
                FS_938 = FS_853 + (float4(((FS_47.SampleLevel(sampler_LinearClamp, float3(FS_883, FS_884 + 0.3333333432674407958984375f, FS_885), 0.0f).xyz * 4.0f) - 2.0f.xxx) * FS_915, FS_915) * FS_874);
                FS_939 = FS_854 + (float4(((FS_888.xyz * 4.0f) - 2.0f.xxx) * FS_904, FS_904) * FS_874);
                FS_940 = FS_851 + (FS_888.w * FS_874);
            }
            else
            {
                FS_937 = FS_852;
                FS_938 = FS_853;
                FS_939 = FS_854;
                FS_940 = FS_851;
            }
            float FS_943 = clamp((FS_940 * 2.0f) - 1.0f, 0.0f, 1.0f);
            FS_947 = FS_937;
            FS_948 = FS_938;
            FS_949 = FS_939;
            FS_950 = FS_943 - FS_645;
            FS_951 = (FS_943 + FS_645) * 0.5f;
        }
        else
        {
            FS_947 = 0.0f.xxxx;
            FS_948 = 0.0f.xxxx;
            FS_949 = 0.0f.xxxx;
            FS_950 = 0.0f;
            FS_951 = 1.0f;
        }
        float4 FS_971 = FS_949 + float4(FS_19_m108.x * FS_951, (FS_19_m108.y * FS_951) + ((FS_19_m108.w * FS_950) * 0.5f), FS_19_m108.z * FS_951, (FS_19_m108.w * FS_951) + ((FS_19_m108.y * FS_950) * 0.375f));
        float4 FS_991 = FS_948 + float4(FS_19_m109.x * FS_951, (FS_19_m109.y * FS_951) + ((FS_19_m109.w * FS_950) * 0.5f), FS_19_m109.z * FS_951, (FS_19_m109.w * FS_951) + ((FS_19_m109.y * FS_950) * 0.375f));
        float4 FS_1011 = FS_947 + float4(FS_19_m110.x * FS_951, (FS_19_m110.y * FS_951) + ((FS_19_m110.w * FS_950) * 0.5f), FS_19_m110.z * FS_951, (FS_19_m110.w * FS_951) + ((FS_19_m110.y * FS_950) * 0.375f));
        float4 FS_1015 = float4(FS_558, 1.0f);
        float3 FS_1019 = float3(dot(FS_971, FS_1015), dot(FS_991, FS_1015), dot(FS_1011, FS_1015));
        bool3 FS_3805 = isnan(FS_1019);
        bool3 FS_3806 = isnan(0.0f.xxx);
        float3 FS_3807 = max(FS_1019, 0.0f.xxx);
        float3 FS_3808 = float3(FS_3805.x ? 0.0f.xxx.x : FS_3807.x, FS_3805.y ? 0.0f.xxx.y : FS_3807.y, FS_3805.z ? 0.0f.xxx.z : FS_3807.z);
        float3 FS_1021 = float3(FS_3806.x ? FS_1019.x : FS_3808.x, FS_3806.y ? FS_1019.y : FS_3808.y, FS_3806.z ? FS_1019.z : FS_3808.z) * FS_616;
        float3 FS_1029 = ((FS_971.xyz * 0.2125999927520751953125f) + (FS_991.xyz * 0.715200006961822509765625f)) + (FS_1011.xyz * 0.072200000286102294921875f);
        float FS_1030 = dot(FS_1029, FS_1029);
        float3 FS_1033 = FS_1029 * rsqrt(isnan(FS_1030) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? FS_1030 : max(1.1754943508222875079687365372222e-38f, FS_1030)));
        float FS_1035 = abs(FS_1033.y);
        float3 FS_1036 = FS_1033;
        FS_1036.y = FS_1035;
        float4 FS_1038 = float4(FS_1036.x, FS_1036.y, FS_1036.z, 0.0f.xxxx.w);
        FS_1038.w = 1.0f;
        float4 FS_1041 = float4(FS_1033.x, FS_1035, FS_1033.z, 1.0f);
        float3 FS_1045 = float3(dot(FS_971, FS_1041), dot(FS_991, FS_1041), dot(FS_1011, FS_1041));
        bool3 FS_3815 = isnan(FS_1045);
        bool3 FS_3816 = isnan(0.0f.xxx);
        float3 FS_3817 = max(FS_1045, 0.0f.xxx);
        float3 FS_3818 = float3(FS_3815.x ? 0.0f.xxx.x : FS_3817.x, FS_3815.y ? 0.0f.xxx.y : FS_3817.y, FS_3815.z ? 0.0f.xxx.z : FS_3817.z);
        float3 FS_1046 = float3(FS_3816.x ? FS_1045.x : FS_3818.x, FS_3816.y ? FS_1045.y : FS_3818.y, FS_3816.z ? FS_1045.z : FS_3818.z);
        float FS_1047 = FS_1046.x;
        float FS_1048 = FS_1046.y;
        float FS_1049 = FS_1046.z;
        float FS_1050 = isnan(FS_1048) ? FS_1047 : (isnan(FS_1047) ? FS_1048 : max(FS_1047, FS_1048));
        float FS_1051 = isnan(FS_1049) ? FS_1050 : (isnan(FS_1050) ? FS_1049 : max(FS_1050, FS_1049));
        float FS_1054 = FS_1021.z;
        float FS_1055 = FS_1021.y;
        float4 FS_1060 = lerp(float4(FS_1054, FS_1055, -1.0f, 0.666666686534881591796875f), float4(FS_1055, FS_1054, 0.0f, -0.3333333432674407958984375f), step(FS_1054, FS_1055).xxxx);
        float FS_1061 = FS_1021.x;
        float FS_1062 = FS_1060.x;
        float4 FS_1070 = lerp(float4(FS_1062, FS_1060.yw, FS_1061), float4(FS_1061, FS_1060.yz, FS_1062), step(FS_1062, FS_1061).xxxx);
        float FS_1071 = FS_1070.x;
        float FS_1072 = FS_1070.w;
        float FS_1073 = FS_1070.y;
        float FS_1075 = FS_1071 - (isnan(FS_1073) ? FS_1072 : (isnan(FS_1072) ? FS_1073 : min(FS_1072, FS_1073)));
        float FS_1084 = FS_1075 / (FS_1071 + 9.9999997473787516355514526367188e-05f);
        float FS_1085 = frac(abs(FS_1070.z + ((FS_1072 - FS_1073) / ((6.0f * FS_1075) + 9.9999997473787516355514526367188e-05f))));
        float FS_1091 = lerp(0.699999988079071044921875f, 0.3499999940395355224609375f, smoothstep(0.449999988079071044921875f, 0.3499999940395355224609375f, abs(FS_1085 - 0.5f))) * clamp(FS_1071, 0.0f, 1.0f);
        float FS_1092 = isnan(FS_1091) ? FS_1084 : (isnan(FS_1084) ? FS_1091 : min(FS_1084, FS_1091));
        float FS_1094 = 2.0f / (2.0f - FS_1092);
        FS_1110 = FS_1038;
        FS_1111 = FS_1021;
        FS_1112 = lerp(1.0f.xxx, clamp(abs((frac(float3(FS_1085, FS_1092, FS_1094).xxx + float3(1.0f, 0.666666686534881591796875f, 0.3333333432674407958984375f)) * 6.0f) - 3.0f.xxx) - 1.0f.xxx, 0.0f.xxx, 1.0f.xxx), FS_1092.xxx) * FS_1094;
        FS_1113 = (isnan(0.0f) ? FS_1051 : (isnan(FS_1051) ? 0.0f : max(FS_1051, 0.0f))) * FS_616;
    }
    else
    {
        FS_1110 = 0.0f.xxxx;
        FS_1111 = 1.0f.xxx;
        FS_1112 = FS_19_m81.xyz;
        FS_1113 = FS_616;
    }
    float3 FS_1833;
    float FS_1834;
    float FS_1835;
    float FS_1836;
    float FS_1837;
    float3 FS_1838;
    float3 FS_1839;
    [branch]
    if ((clamp(FS_594 + FS_607, 0.0f, 1.0f) - FS_49_m20) > 0.00999999977648258209228515625f)
    {
        float FS_1141 = 1.0f - FS_486;
        float FS_1144 = smoothstep(0.3499999940395355224609375f, 0.100000001490116119384765625f, dot(FS_481 * FS_1141, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)));
        bool3 FS_1147 = FS_456.xxx;
        float3 FS_1149 = FS_10.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 FS_1153 = float3(FS_1147.x ? FS_1149.x : FS_10.x, FS_1147.y ? FS_1149.y : FS_10.y, FS_1147.z ? FS_1149.z : FS_10.z) * FS_19_m89.z;
        float3 FS_1155 = float3(FS_1147.x ? FS_9.xzy.x : FS_9.x, FS_1147.y ? FS_9.xzy.y : FS_9.y, FS_1147.z ? FS_9.xzy.z : FS_9.z);
        float3 FS_1157 = abs(FS_1155) - 0.20000000298023223876953125f.xxx;
        float3 FS_1159 = (FS_1157 * FS_1157) * FS_1157;
        bool3 FS_3845 = isnan(FS_1159);
        bool3 FS_3846 = isnan(6.103515625e-05f.xxx);
        float3 FS_3847 = max(FS_1159, 6.103515625e-05f.xxx);
        float3 FS_3848 = float3(FS_3845.x ? 6.103515625e-05f.xxx.x : FS_3847.x, FS_3845.y ? 6.103515625e-05f.xxx.y : FS_3847.y, FS_3845.z ? 6.103515625e-05f.xxx.z : FS_3847.z);
        float3 FS_1160 = float3(FS_3846.x ? FS_1159.x : FS_3848.x, FS_3846.y ? FS_1159.y : FS_3848.y, FS_3846.z ? FS_1159.z : FS_3848.z);
        float3 FS_1163 = FS_1160 / dot(FS_1160, 1.0f.xxx).xxx;
        float2 FS_1171 = FS_1153.xy;
        float2 FS_1176 = FS_1153.zy;
        float4 FS_1186 = ((FS_52.SampleBias(sampler_LinearRepeat, FS_1153.xz, FS_19_m16) * FS_1163.y) + (FS_52.SampleBias(sampler_LinearRepeat, FS_1171, FS_19_m16) * FS_1163.z)) + (FS_52.SampleBias(sampler_LinearRepeat, FS_1176, FS_19_m16) * FS_1163.x);
        float FS_1187 = FS_1186.w;
        float FS_1189 = 1.10000002384185791015625f - FS_1187;
        float FS_1193 = smoothstep(0.800000011920928955078125f - FS_1187, FS_1189, clamp((FS_594 * FS_1141) + (FS_558.y * 0.20000000298023223876953125f), 0.0f, 1.0f));
        float FS_1197 = smoothstep(0.449999988079071044921875f - FS_1187, FS_1189, clamp(FS_606 * FS_1141, 0.0f, 1.0f));
        float FS_1198 = isnan(FS_1197) ? FS_1193 : (isnan(FS_1193) ? FS_1197 : max(FS_1193, FS_1197));
        float FS_1205 = smoothstep(0.5f, 0.75f, FS_486);
        float FS_1207 = smoothstep(0.800000011920928955078125f, 0.60000002384185791015625f, FS_490) * FS_1144;
        float FS_1210 = clamp(FS_1207 + FS_1205, 0.0f, 1.0f) * (isnan(FS_607) ? FS_594 : (isnan(FS_594) ? FS_607 : max(FS_594, FS_607)));
        float FS_1213 = step(1.0099999904632568359375f - FS_1210, FS_1186.z);
        bool FS_1214 = !((step(FS_594, 0.00999999977648258209228515625f) * step(0.00999999977648258209228515625f, FS_607)) != 0.0f);
        bool2 FS_1215 = FS_1214.xx;
        float2 FS_1217 = (1.0f - FS_607).xx;
        float2 FS_1218 = float2(FS_1215.x ? float2(3.0f, 4.345600128173828125f).x : FS_1217.x, FS_1215.y ? float2(3.0f, 4.345600128173828125f).y : FS_1217.y);
        float FS_1219 = 1.0f - FS_1210;
        float FS_1222 = FS_1214 ? FS_19_m10.x : 1.0f;
        float FS_1224 = FS_1222 * FS_1218.x;
        float FS_1226 = FS_1222 * FS_1218.y;
        float3 FS_1227 = FS_1153 * 20.0f;
        float3 FS_1228 = FS_1153 * 34.345600128173828125f;
        bool3 FS_3855 = isnan(FS_1157);
        bool3 FS_3856 = isnan(0.0f.xxx);
        float3 FS_3857 = max(FS_1157, 0.0f.xxx);
        float3 FS_3858 = float3(FS_3855.x ? 0.0f.xxx.x : FS_3857.x, FS_3855.y ? 0.0f.xxx.y : FS_3857.y, FS_3855.z ? 0.0f.xxx.z : FS_3857.z);
        float3 FS_1230 = pow(float3(FS_3856.x ? FS_1157.x : FS_3858.x, FS_3856.y ? FS_1157.y : FS_3858.y, FS_3856.z ? FS_1157.z : FS_3858.z), 10.0f.xxx);
        float FS_1231 = dot(FS_1230, 1.0f.xxx);
        float3 FS_1234 = FS_1230 / (isnan(6.103515625e-05f) ? FS_1231 : (isnan(FS_1231) ? 6.103515625e-05f : max(FS_1231, 6.103515625e-05f))).xxx;
        float FS_1236 = FS_1234.y;
        float2 FS_1237 = FS_1227.xz * 1.0f;
        float2 FS_1238 = floor(FS_1237);
        float2 FS_1241 = frac(FS_1238 * float2(123.339996337890625f, 456.209991455078125f));
        float2 FS_1245 = FS_1241 + dot(FS_1241, FS_1241 + 34.345001220703125f.xx).xx;
        float FS_1246 = FS_1245.x;
        float FS_1247 = FS_1245.y;
        float2 FS_1251 = frac(float2(FS_1246 * FS_1247, FS_1246 + FS_1247));
        float2 FS_1254 = frac((FS_1238 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 FS_1258 = FS_1254 + dot(FS_1254, FS_1254 + 34.345001220703125f.xx).xx;
        float FS_1259 = FS_1258.x;
        float FS_1260 = FS_1258.y;
        float2 FS_1264 = frac(float2(FS_1259 * FS_1260, FS_1259 + FS_1260));
        float FS_1270 = FS_1251.x;
        float FS_1272 = 0.25f * lerp(0.60000002384185791015625f, 1.0f, FS_1270);
        float2 FS_1273 = ((FS_1237 - FS_1238) + ((((FS_1264 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float FS_1276 = FS_1273.y;
        float2 FS_1280 = float2(FS_1273.x * 1.25f, FS_1276 * ((FS_1276 < 0.0f) ? 1.25f : 0.75f));
        float FS_1283 = FS_1224 + FS_1270;
        float FS_1287 = FS_1214 ? frac(FS_1283) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(FS_1283, 0.0f, 1.0f));
        float FS_1299 = FS_1251.y;
        float FS_1302 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, FS_1287) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, FS_1287)) * step(0.001000000047497451305389404296875f, smoothstep(FS_1272, 0.0f, length(FS_1280)))) * step(FS_1219, FS_1299 - 0.100000001490116119384765625f);
        float FS_1305 = FS_1302 * FS_1236;
        float2 FS_1311 = float2(FS_1272 * FS_1302, FS_412) * FS_1236;
        float FS_1313 = FS_1234.z;
        float2 FS_1314 = FS_1227.xy * 1.0f;
        float2 FS_1315 = floor(FS_1314);
        float2 FS_1318 = frac(FS_1315 * float2(123.339996337890625f, 456.209991455078125f));
        float2 FS_1322 = FS_1318 + dot(FS_1318, FS_1318 + 34.345001220703125f.xx).xx;
        float FS_1323 = FS_1322.x;
        float FS_1324 = FS_1322.y;
        float2 FS_1328 = frac(float2(FS_1323 * FS_1324, FS_1323 + FS_1324));
        float2 FS_1331 = frac((FS_1315 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 FS_1335 = FS_1331 + dot(FS_1331, FS_1331 + 34.345001220703125f.xx).xx;
        float FS_1336 = FS_1335.x;
        float FS_1337 = FS_1335.y;
        float2 FS_1341 = frac(float2(FS_1336 * FS_1337, FS_1336 + FS_1337));
        float FS_1347 = FS_1328.x;
        float FS_1349 = 0.25f * lerp(0.60000002384185791015625f, 1.0f, FS_1347);
        float2 FS_1350 = ((FS_1314 - FS_1315) + ((((FS_1341 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float FS_1353 = FS_1350.y;
        float2 FS_1357 = float2(FS_1350.x * 1.25f, FS_1353 * ((FS_1353 < 0.0f) ? 1.25f : 0.75f));
        float FS_1360 = FS_1224 + FS_1347;
        float FS_1364 = FS_1214 ? frac(FS_1360) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(FS_1360, 0.0f, 1.0f));
        float FS_1376 = FS_1328.y;
        float FS_1379 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, FS_1364) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, FS_1364)) * step(0.001000000047497451305389404296875f, smoothstep(FS_1349, 0.0f, length(FS_1357)))) * step(FS_1219, FS_1376 - 0.100000001490116119384765625f);
        float FS_1382 = FS_1379 * FS_1313;
        float2 FS_1388 = float2(FS_1349 * FS_1379, FS_412) * FS_1313;
        float FS_1390 = FS_1234.x;
        float2 FS_1391 = FS_1227.zy * 1.0f;
        float2 FS_1392 = floor(FS_1391);
        float2 FS_1395 = frac(FS_1392 * float2(123.339996337890625f, 456.209991455078125f));
        float2 FS_1399 = FS_1395 + dot(FS_1395, FS_1395 + 34.345001220703125f.xx).xx;
        float FS_1400 = FS_1399.x;
        float FS_1401 = FS_1399.y;
        float2 FS_1405 = frac(float2(FS_1400 * FS_1401, FS_1400 + FS_1401));
        float2 FS_1408 = frac((FS_1392 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 FS_1412 = FS_1408 + dot(FS_1408, FS_1408 + 34.345001220703125f.xx).xx;
        float FS_1413 = FS_1412.x;
        float FS_1414 = FS_1412.y;
        float2 FS_1418 = frac(float2(FS_1413 * FS_1414, FS_1413 + FS_1414));
        float FS_1424 = FS_1405.x;
        float FS_1426 = 0.25f * lerp(0.60000002384185791015625f, 1.0f, FS_1424);
        float2 FS_1427 = ((FS_1391 - FS_1392) + ((((FS_1418 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float FS_1430 = FS_1427.y;
        float2 FS_1434 = float2(FS_1427.x * 1.25f, FS_1430 * ((FS_1430 < 0.0f) ? 1.25f : 0.75f));
        float FS_1437 = FS_1224 + FS_1424;
        float FS_1441 = FS_1214 ? frac(FS_1437) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(FS_1437, 0.0f, 1.0f));
        float FS_1453 = FS_1405.y;
        float FS_1456 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, FS_1441) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, FS_1441)) * step(0.001000000047497451305389404296875f, smoothstep(FS_1426, 0.0f, length(FS_1434)))) * step(FS_1219, FS_1453 - 0.100000001490116119384765625f);
        float FS_1459 = FS_1456 * FS_1390;
        float2 FS_1465 = float2(FS_1426 * FS_1456, FS_412) * FS_1390;
        bool2 FS_3865 = isnan(FS_1388);
        bool2 FS_3866 = isnan(FS_1465);
        float2 FS_3867 = max(FS_1388, FS_1465);
        float2 FS_3868 = float2(FS_3865.x ? FS_1465.x : FS_3867.x, FS_3865.y ? FS_1465.y : FS_3867.y);
        float2 FS_1466 = float2(FS_3866.x ? FS_1388.x : FS_3868.x, FS_3866.y ? FS_1388.y : FS_3868.y);
        bool2 FS_3870 = isnan(FS_1311);
        bool2 FS_3871 = isnan(FS_1466);
        float2 FS_3872 = max(FS_1311, FS_1466);
        float2 FS_3873 = float2(FS_3870.x ? FS_1466.x : FS_3872.x, FS_3870.y ? FS_1466.y : FS_3872.y);
        float FS_1473 = isnan(FS_1382) ? FS_1305 : (isnan(FS_1305) ? FS_1382 : max(FS_1305, FS_1382));
        float FS_1474 = isnan(FS_1473) ? FS_1459 : (isnan(FS_1459) ? FS_1473 : max(FS_1459, FS_1473));
        float4 FS_1477 = float4((float4(((clamp(FS_1280 / FS_1272.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, FS_1264.x)) * FS_1302) * FS_1236, FS_1305, FS_1299).xy + float4(((clamp(FS_1357 / FS_1349.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, FS_1341.x)) * FS_1379) * FS_1313, FS_1382, FS_1376).xy) + float4(((clamp(FS_1434 / FS_1426.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, FS_1418.x)) * FS_1456) * FS_1390, FS_1459, FS_1453).xy, FS_1474, 0.0f);
        float2 FS_1479 = FS_1228.xz * 1.0f;
        float2 FS_1480 = floor(FS_1479);
        float2 FS_1483 = frac(FS_1480 * float2(123.339996337890625f, 456.209991455078125f));
        float2 FS_1487 = FS_1483 + dot(FS_1483, FS_1483 + 34.345001220703125f.xx).xx;
        float FS_1488 = FS_1487.x;
        float FS_1489 = FS_1487.y;
        float2 FS_1493 = frac(float2(FS_1488 * FS_1489, FS_1488 + FS_1489));
        float2 FS_1496 = frac((FS_1480 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 FS_1500 = FS_1496 + dot(FS_1496, FS_1496 + 34.345001220703125f.xx).xx;
        float FS_1501 = FS_1500.x;
        float FS_1502 = FS_1500.y;
        float2 FS_1506 = frac(float2(FS_1501 * FS_1502, FS_1501 + FS_1502));
        float FS_1512 = FS_1493.x;
        float FS_1514 = 0.25f * lerp(0.60000002384185791015625f, 1.0f, FS_1512);
        float2 FS_1515 = ((FS_1479 - FS_1480) + ((((FS_1506 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float FS_1518 = FS_1515.y;
        float2 FS_1522 = float2(FS_1515.x * 1.25f, FS_1518 * ((FS_1518 < 0.0f) ? 1.25f : 0.75f));
        float FS_1525 = FS_1226 + FS_1512;
        float FS_1529 = FS_1214 ? frac(FS_1525) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(FS_1525, 0.0f, 1.0f));
        float FS_1541 = FS_1493.y;
        float FS_1544 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, FS_1529) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, FS_1529)) * step(0.001000000047497451305389404296875f, smoothstep(FS_1514, 0.0f, length(FS_1522)))) * step(FS_1219, FS_1541 - 0.100000001490116119384765625f);
        float FS_1547 = FS_1544 * FS_1236;
        float2 FS_1552 = FS_1228.xy * 1.0f;
        float2 FS_1553 = floor(FS_1552);
        float2 FS_1556 = frac(FS_1553 * float2(123.339996337890625f, 456.209991455078125f));
        float2 FS_1560 = FS_1556 + dot(FS_1556, FS_1556 + 34.345001220703125f.xx).xx;
        float FS_1561 = FS_1560.x;
        float FS_1562 = FS_1560.y;
        float2 FS_1566 = frac(float2(FS_1561 * FS_1562, FS_1561 + FS_1562));
        float2 FS_1569 = frac((FS_1553 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 FS_1573 = FS_1569 + dot(FS_1569, FS_1569 + 34.345001220703125f.xx).xx;
        float FS_1574 = FS_1573.x;
        float FS_1575 = FS_1573.y;
        float2 FS_1579 = frac(float2(FS_1574 * FS_1575, FS_1574 + FS_1575));
        float FS_1585 = FS_1566.x;
        float FS_1587 = 0.25f * lerp(0.60000002384185791015625f, 1.0f, FS_1585);
        float2 FS_1588 = ((FS_1552 - FS_1553) + ((((FS_1579 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float FS_1591 = FS_1588.y;
        float2 FS_1595 = float2(FS_1588.x * 1.25f, FS_1591 * ((FS_1591 < 0.0f) ? 1.25f : 0.75f));
        float FS_1598 = FS_1226 + FS_1585;
        float FS_1602 = FS_1214 ? frac(FS_1598) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(FS_1598, 0.0f, 1.0f));
        float FS_1614 = FS_1566.y;
        float FS_1617 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, FS_1602) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, FS_1602)) * step(0.001000000047497451305389404296875f, smoothstep(FS_1587, 0.0f, length(FS_1595)))) * step(FS_1219, FS_1614 - 0.100000001490116119384765625f);
        float FS_1620 = FS_1617 * FS_1313;
        float2 FS_1625 = FS_1228.zy * 1.0f;
        float2 FS_1626 = floor(FS_1625);
        float2 FS_1629 = frac(FS_1626 * float2(123.339996337890625f, 456.209991455078125f));
        float2 FS_1633 = FS_1629 + dot(FS_1629, FS_1629 + 34.345001220703125f.xx).xx;
        float FS_1634 = FS_1633.x;
        float FS_1635 = FS_1633.y;
        float2 FS_1639 = frac(float2(FS_1634 * FS_1635, FS_1634 + FS_1635));
        float2 FS_1642 = frac((FS_1626 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 FS_1646 = FS_1642 + dot(FS_1642, FS_1642 + 34.345001220703125f.xx).xx;
        float FS_1647 = FS_1646.x;
        float FS_1648 = FS_1646.y;
        float2 FS_1652 = frac(float2(FS_1647 * FS_1648, FS_1647 + FS_1648));
        float FS_1658 = FS_1639.x;
        float FS_1660 = 0.25f * lerp(0.60000002384185791015625f, 1.0f, FS_1658);
        float2 FS_1661 = ((FS_1625 - FS_1626) + ((((FS_1652 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float FS_1664 = FS_1661.y;
        float2 FS_1668 = float2(FS_1661.x * 1.25f, FS_1664 * ((FS_1664 < 0.0f) ? 1.25f : 0.75f));
        float FS_1671 = FS_1226 + FS_1658;
        float FS_1675 = FS_1214 ? frac(FS_1671) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(FS_1671, 0.0f, 1.0f));
        float FS_1687 = FS_1639.y;
        float FS_1690 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, FS_1675) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, FS_1675)) * step(0.001000000047497451305389404296875f, smoothstep(FS_1660, 0.0f, length(FS_1668)))) * step(FS_1219, FS_1687 - 0.100000001490116119384765625f);
        float FS_1693 = FS_1690 * FS_1390;
        float FS_1702 = isnan(FS_1620) ? FS_1547 : (isnan(FS_1547) ? FS_1620 : max(FS_1547, FS_1620));
        float4 FS_1706 = float4((float4(((clamp(FS_1522 / FS_1514.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, FS_1506.x)) * FS_1544) * FS_1236, FS_1547, FS_1541).xy + float4(((clamp(FS_1595 / FS_1587.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, FS_1579.x)) * FS_1617) * FS_1313, FS_1620, FS_1614).xy) + float4(((clamp(FS_1668 / FS_1660.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, FS_1652.x)) * FS_1690) * FS_1390, FS_1693, FS_1687).xy, isnan(FS_1702) ? FS_1693 : (isnan(FS_1693) ? FS_1702 : max(FS_1693, FS_1702)), 0.0f);
        float FS_1708 = step(float2(FS_3871.x ? FS_1311.x : FS_3873.x, FS_3871.y ? FS_1311.y : FS_3873.y).x, 0.00999999977648258209228515625f);
        float2 FS_1712 = FS_1477.xy + (FS_1706.xy * FS_1708);
        float2 FS_1715 = FS_1477.zw * step(0.00999999977648258209228515625f, FS_1474);
        float2 FS_1717 = FS_1706.zw * FS_1708;
        bool2 FS_3895 = isnan(FS_1715);
        bool2 FS_3896 = isnan(FS_1717);
        float2 FS_3897 = max(FS_1715, FS_1717);
        float2 FS_3898 = float2(FS_3895.x ? FS_1717.x : FS_3897.x, FS_3895.y ? FS_1717.y : FS_3897.y);
        float2 FS_1718 = float2(FS_3896.x ? FS_1715.x : FS_3898.x, FS_3896.y ? FS_1715.y : FS_3898.y);
        float FS_1720 = FS_1718.x;
        float3 FS_1721 = float3((FS_1186.xy * 2.0f) - 1.0f.xx, 0.0f) + float3(FS_1712.x, FS_1712.y, 0.0f.xxx.z);
        float FS_1722 = isnan(FS_1213) ? FS_1720 : (isnan(FS_1720) ? FS_1213 : max(FS_1720, FS_1213));
        float2 FS_1725 = float2(0.0f, (FS_19_m10.x * FS_19_m89.z) * 0.75f);
        float3 FS_1728 = float3(FS_1155.x, 0.0f, FS_1155.z);
        float FS_1729 = dot(FS_1728, FS_1728);
        float3 FS_1734 = abs(FS_1728 * rsqrt(isnan(FS_1729) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? FS_1729 : max(1.1754943508222875079687365372222e-38f, FS_1729)))) - 0.20000000298023223876953125f.xxx;
        float3 FS_1736 = (FS_1734 * FS_1734) * FS_1734;
        bool3 FS_3910 = isnan(FS_1736);
        bool3 FS_3911 = isnan(6.103515625e-05f.xxx);
        float3 FS_3912 = max(FS_1736, 6.103515625e-05f.xxx);
        float3 FS_3913 = float3(FS_3910.x ? 6.103515625e-05f.xxx.x : FS_3912.x, FS_3910.y ? 6.103515625e-05f.xxx.y : FS_3912.y, FS_3910.z ? 6.103515625e-05f.xxx.z : FS_3912.z);
        float3 FS_1737 = float3(FS_3911.x ? FS_1736.x : FS_3913.x, FS_3911.y ? FS_1736.y : FS_3913.y, FS_3911.z ? FS_1736.z : FS_3913.z);
        float3 FS_1740 = FS_1737 / dot(FS_1737, 1.0f.xxx).xxx;
        float FS_1759 = FS_1740.z;
        float FS_1761 = FS_1740.x;
        float4 FS_1763 = (FS_53.SampleBias(sampler_LinearRepeat, FS_1171, FS_19_m16) * FS_1759) + (FS_53.SampleBias(sampler_LinearRepeat, FS_1176, FS_19_m16) * FS_1761);
        float2 FS_1775 = FS_1721.xy + ((((FS_1763.xy * 2.0f) - 1.0f.xx) * ((FS_53.SampleBias(sampler_LinearRepeat, FS_1171 + FS_1725, FS_19_m16).w * FS_1759) + (FS_53.SampleBias(sampler_LinearRepeat, FS_1176 + FS_1725, FS_19_m16).w * FS_1761))) * FS_1210);
        float FS_1777 = FS_1763.z;
        float FS_1781 = smoothstep(1.0f - FS_1777, 1.10000002384185791015625f - FS_1777, FS_1210) * FS_1210;
        float FS_1782 = isnan(FS_1781) ? FS_1722 : (isnan(FS_1722) ? FS_1781 : max(FS_1722, FS_1781));
        float2 FS_1783 = FS_1775.xy;
        float FS_1787 = sqrt(1.0f - clamp(dot(FS_1783, FS_1783), 0.0f, 1.0f));
        float3 FS_1789 = float3(FS_1775.x, FS_1775.y, FS_1721.z);
        FS_1789.z = isnan(FS_1787) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? FS_1787 : max(1.000000016862383526387164645044e-16f, FS_1787));
        float3 FS_1790 = normalize(FS_1789);
        float3 FS_1791 = cross(FS_558, float3(0.0f, 1.0f, 0.0f));
        bool3 FS_1794 = (dot(FS_1791, FS_1791) > 6.103515625e-05f).xxx;
        float3 FS_1795 = normalize(FS_1791);
        float3 FS_1796 = float3(FS_1794.x ? FS_1795.x : float3(1.0f, 0.0f, 0.0f).x, FS_1794.y ? FS_1795.y : float3(1.0f, 0.0f, 0.0f).y, FS_1794.z ? FS_1795.z : float3(1.0f, 0.0f, 0.0f).z);
        float FS_1807 = isnan(0.0500000007450580596923828125f) ? FS_490 : (isnan(FS_490) ? 0.0500000007450580596923828125f : min(FS_490, 0.0500000007450580596923828125f));
        float FS_1808 = lerp(FS_490, FS_1807, FS_1782);
        float FS_1825 = lerp(1.0f, 0.5f, (FS_1198 * (1.0f - FS_1144)) * (1.0f - FS_1207));
        float FS_1830 = FS_1808 - ((0.20000000298023223876953125f * FS_1144) * FS_1198);
        float FS_1831 = isnan(FS_1808) ? 0.20000000298023223876953125f : (isnan(0.20000000298023223876953125f) ? FS_1808 : min(0.20000000298023223876953125f, FS_1808));
        FS_1833 = normalize(lerp(FS_558, normalize(((FS_1796 * FS_1790.x) + (cross(FS_1796, FS_558) * FS_1790.y)) + (FS_558 * FS_1790.z)), FS_1782.xxx));
        FS_1834 = FS_1782;
        FS_1835 = FS_1807;
        FS_1836 = FS_1782;
        FS_1837 = isnan(FS_1831) ? FS_1830 : (isnan(FS_1830) ? FS_1831 : max(FS_1830, FS_1831));
        FS_1838 = FS_503 * FS_1825;
        FS_1839 = lerp(FS_481, FS_481 * ((smoothstep(0.699999988079071044921875f, 0.300000011920928955078125f, dot(FS_481, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f))) * 0.5f) + 1.0f).xxx, (FS_1782 * FS_1205).xxx) * FS_1825;
    }
    else
    {
        FS_1833 = FS_558;
        FS_1834 = 0.0f;
        FS_1835 = 0.00999999977648258209228515625f;
        FS_1836 = 0.0f;
        FS_1837 = FS_490;
        FS_1838 = FS_503;
        FS_1839 = FS_481;
    }
    float3 FS_2011;
    float FS_2012;
    float FS_2013;
    float3 FS_2014;
    float3 FS_2015;
    float FS_2016;
    [branch]
    if (FS_597 > 0.00999999977648258209228515625f)
    {
        bool3 FS_1843 = FS_456.xxx;
        float3 FS_1845 = FS_10.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 FS_1846 = float3(FS_1843.x ? FS_1845.x : FS_10.x, FS_1843.y ? FS_1845.y : FS_10.y, FS_1843.z ? FS_1845.z : FS_10.z);
        float3 FS_1849 = FS_1846 * FS_19_m89.z;
        float3 FS_1851 = float3(FS_1843.x ? FS_9.xzy.x : FS_9.x, FS_1843.y ? FS_9.xzy.y : FS_9.y, FS_1843.z ? FS_9.xzy.z : FS_9.z);
        float3 FS_1853 = abs(FS_1851) - 0.20000000298023223876953125f.xxx;
        float3 FS_1855 = (FS_1853 * FS_1853) * FS_1853;
        bool3 FS_3940 = isnan(FS_1855);
        bool3 FS_3941 = isnan(6.103515625e-05f.xxx);
        float3 FS_3942 = max(FS_1855, 6.103515625e-05f.xxx);
        float3 FS_3943 = float3(FS_3940.x ? 6.103515625e-05f.xxx.x : FS_3942.x, FS_3940.y ? 6.103515625e-05f.xxx.y : FS_3942.y, FS_3940.z ? 6.103515625e-05f.xxx.z : FS_3942.z);
        float3 FS_1856 = float3(FS_3941.x ? FS_1855.x : FS_3943.x, FS_3941.y ? FS_1855.y : FS_3943.y, FS_3941.z ? FS_1855.z : FS_3943.z);
        float3 FS_1859 = FS_1856 / dot(FS_1856, 1.0f.xxx).xxx;
        float FS_1875 = FS_1859.y;
        float FS_1877 = FS_1859.z;
        float FS_1880 = FS_1859.x;
        float4 FS_1882 = ((FS_54.SampleBias(sampler_LinearRepeat, FS_1849.xz, FS_19_m16) * FS_1875) + (FS_54.SampleBias(sampler_LinearRepeat, FS_1849.xy, FS_19_m16) * FS_1877)) + (FS_54.SampleBias(sampler_LinearRepeat, FS_1849.zy, FS_19_m16) * FS_1880);
        float FS_1883 = FS_1851.y;
        float FS_1890 = clamp(FS_597 + (smoothstep(0.3499999940395355224609375f, 0.20000000298023223876953125f, FS_1846.y) * clamp(FS_597 * 3.0f, 0.0f, 1.0f)), 0.0f, 1.0f);
        float FS_1901 = smoothstep(2.0f - FS_1890, 2.349999904632568359375f - FS_1890, ((FS_1883 * 0.64999997615814208984375f) + 0.3499999940395355224609375f) + FS_1882.z) * ((FS_488 * FS_488) * float(FSgl_FrontFacing));
        float FS_1913 = lerp(1.0f, 0.5f, ((FS_1890 * (1.0f - smoothstep(0.3499999940395355224609375f, 0.100000001490116119384765625f, dot(FS_1839 * (1.0f - FS_486), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f))))) * FS_1882.w) * ((FS_1883 * 0.25f) + 0.75f));
        float3 FS_1915 = FS_1901.xxx;
        float2 FS_1921 = (FS_1882.xy * 2.0f) - 1.0f.xx;
        float2 FS_1923 = FS_1921.xy;
        float FS_1927 = sqrt(1.0f - clamp(dot(FS_1923, FS_1923), 0.0f, 1.0f));
        float3 FS_1929 = float3(FS_1921.x, FS_1921.y, FS_410.z);
        FS_1929.z = isnan(FS_1927) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? FS_1927 : max(1.000000016862383526387164645044e-16f, FS_1927));
        float2 FS_1931 = FS_1929.xy * 2.0f;
        float3 FS_1933 = lerp(float3(0.0f, 0.0f, 1.0f), float3(FS_1931.x, FS_1931.y, FS_1929.z), FS_1915);
        float FS_1934 = dot(FS_1933, FS_1933);
        float3 FS_1937 = FS_1933 * rsqrt(isnan(FS_1934) ? 6.103515625e-05f : (isnan(6.103515625e-05f) ? FS_1934 : max(6.103515625e-05f, FS_1934)));
        float FS_1938 = FS_558.y;
        float FS_1941 = step(0.00999999977648258209228515625f, 1.0f - (FS_1938 * FS_1938));
        float FS_1945 = lerp(FS_558.z, FS_1938, FS_1941);
        float FS_1947 = 1.0f - (FS_1945 * FS_1945);
        float3 FS_1952 = (float3(0.0f, FS_1941, 1.0f - FS_1941) - (FS_558 * FS_1945)) * rsqrt(isnan(FS_1947) ? 9.9999997473787516355514526367188e-05f : (isnan(9.9999997473787516355514526367188e-05f) ? FS_1947 : max(9.9999997473787516355514526367188e-05f, FS_1947)));
        float3 FS_1966 = FS_1849 * 4.0f;
        float4 FS_1986 = ((FS_55.SampleLevel(sampler_PointRepeat, FS_1966.xz, 0.0f) * FS_1875) + (FS_55.SampleLevel(sampler_PointRepeat, FS_1966.xy, 0.0f) * FS_1877)) + (FS_55.SampleLevel(sampler_PointRepeat, FS_1966.zy, 0.0f) * FS_1880);
        float2 FS_1989 = (FS_1986.xz * 2.0f) - 1.0f.xx;
        float FS_2000 = smoothstep(0.949999988079071044921875f, 1.0f, frac(((dot(float3(FS_1989.x, FS_1986.y, FS_1989.y), (floor(FS_447 * 50.0f) * 0.0199999995529651641845703125f) * 0.100000001490116119384765625f) * 0.5f) + 0.5f) * 2.0f));
        float FS_2001 = FS_2000 * FS_2000;
        float FS_2004 = FS_2001 * ((FS_2001 * 2.0f) * FS_1901);
        float3 FS_2005 = 1.0f.xxx * FS_2004;
        FS_2011 = ((cross(FS_1952, FS_558) * FS_1937.x) + (FS_1952 * FS_1937.y)) + (FS_558 * FS_1937.z);
        FS_2012 = FS_1836 + FS_2004;
        FS_2013 = lerp(lerp(FS_1837, 0.89999997615814208984375f, clamp(FS_1901 * 4.0f, 0.0f, 1.0f)), 0.00999999977648258209228515625f, FS_2004);
        FS_2014 = lerp(FS_1838 * FS_1913, 0.3079999983310699462890625f.xxx, FS_1915) + (FS_2005 * 0.5f);
        FS_2015 = lerp(FS_1839 * FS_1913, 0.87999999523162841796875f.xxx, FS_1915) + FS_2005;
        FS_2016 = lerp(FS_486, 0.0f, FS_1901);
    }
    else
    {
        FS_2011 = FS_558;
        FS_2012 = FS_1836;
        FS_2013 = FS_1837;
        FS_2014 = FS_1838;
        FS_2015 = FS_1839;
        FS_2016 = FS_486;
    }
    float FS_2018 = 0.959999978542327880859375f - (FS_2016 * 0.959999978542327880859375f);
    float3 FS_2019 = FS_2015 * FS_2018;
    float3 FS_2022 = lerp(0.039999999105930328369140625f.xxx * FS_485.y, FS_2015, FS_2016.xxx);
    float3 FS_2023 = FS_2014 * FS_2018;
    float FS_2024 = FS_2013 * FS_2013;
    float FS_2025 = isnan(0.0078125f) ? FS_2024 : (isnan(FS_2024) ? 0.0078125f : max(FS_2024, 0.0078125f));
    float FS_2026 = FS_2025 * FS_2025;
    float2 FS_2039 = (FS_7.xy / (isnan(9.9999999392252902907785028219223e-09f) ? FS_7.z : (isnan(FS_7.z) ? 9.9999999392252902907785028219223e-09f : max(FS_7.z, 9.9999999392252902907785028219223e-09f))).xx) - (FS_8.xy / (isnan(9.9999999392252902907785028219223e-09f) ? FS_8.z : (isnan(FS_8.z) ? 9.9999999392252902907785028219223e-09f : max(FS_8.z, 9.9999999392252902907785028219223e-09f))).xx);
    float2 FS_2042 = FS_2039;
    FS_2042.y = -FS_2039.y;
    float2 FS_2052 = ((sqrt(sqrt(abs(FS_2042 * 0.5f))) * float2(int2(sign(FS_2042)))) * 0.5f) + 0.5f.xx;
    float4 FS_2056 = float4(FS_2052.x, FS_2052.y, 0.0f.xxxx.z, 0.0f.xxxx.w);
    FS_2056.z = 1.0f;
    float4 FS_2057 = FS_2056;
    FS_2057.w = (FS_2012 > 0.100000001490116119384765625f) ? 0.699999988079071044921875f : 0.4000000059604644775390625f;
    float3 FS_2068 = lerp(-FS_36_m0.xyz, FS_19_m90.xyz, FS_19_m80.w.xxx);
    float3 FS_2072 = normalize(float3(FS_2068.x, 6.103515625e-05f, FS_2068.z));
    float3 FS_2082 = lerp(FS_36_m3.xyz, FS_19_m84.xyz, FS_19_m91.y.xxx);
    float3 FS_2086 = FS_2082 * lerp(FS_36_m3.w, 1.0f, FS_19_m91.w);
    int FS_2090 = int(FS_561.x);
    int FS_2091 = int(FS_561.y);
    float4 FS_2095 = FS_40.Load(int3(int3(FS_2090, FS_2091, 0).xy, 0));
    float FS_2100 = FS_2095.y;
    float FS_2103 = lerp(lerp(1.0f, FS_2095.x, FS_38_m6.x), 1.0f, FS_19_m80.z);
    float FS_2104 = dot(FS_2011, FS_2068);
    float3 FS_2111 = FS_2023 * FS_19_m79.z;
    float3 FS_2112 = FS_2111 * 0.64999997615814208984375f;
    float FS_2116 = dot(FS_2019, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float FS_2129 = clamp(-dot(FS_2072.xz, normalize(FS_571.xz)), 0.0f, 1.0f);
    float FS_2133 = 1.0f - FS_19_m91.x;
    float4 FS_2147 = FS_50.SampleLevel(sampler_LinearClamp, float2((clamp(lerp(FS_2104, ((-FS_2104) * ((FS_2104 * 0.5f) - 1.0f)) + 0.5f, (FS_2129 * smoothstep(0.25f, 0.75f, 1.0f - abs(FS_571.y))) * FS_2133) + (FS_19_m90.w * FS_19_m91.x), -1.0f, 1.0f) * 0.5f) + 0.5f, 0.5f), 0.0f);
    float FS_2148 = FS_2147.w;
    float FS_2150 = FS_2147.x;
    float FS_2151 = FS_2147.y;
    float FS_2152 = FS_2147.z;
    float FS_2153 = isnan(FS_2151) ? FS_2150 : (isnan(FS_2150) ? FS_2151 : max(FS_2150, FS_2151));
    float FS_2155 = isnan(FS_2151) ? FS_2150 : (isnan(FS_2150) ? FS_2151 : min(FS_2150, FS_2151));
    float FS_2157 = (isnan(FS_2152) ? FS_2153 : (isnan(FS_2153) ? FS_2152 : max(FS_2153, FS_2152))) - (isnan(FS_2152) ? FS_2155 : (isnan(FS_2155) ? FS_2152 : min(FS_2155, FS_2152)));
    float4 FS_2165 = FS_50.SampleLevel(sampler_LinearClamp, float2((dot(FS_2011, FS_571) * 0.5f) + 0.5f, 0.5f), 0.0f);
    float FS_2166 = FS_2165.w;
    float FS_2167 = FS_488 * FS_2100;
    float FS_2173 = isnan(FS_488) ? FS_2100 : (isnan(FS_2100) ? FS_488 : min(FS_2100, FS_488));
    float FS_2174 = isnan(FS_2148) ? FS_2173 : (isnan(FS_2173) ? FS_2148 : min(FS_2173, FS_2148));
    float FS_2175 = FS_2166 * FS_2167;
    float3 FS_2179 = ((clamp(dot(FS_558, FS_19_m85.xyz) + FS_19_m86.x, 0.0f, 1.0f) * FS_19_m86.y) + FS_19_m86.z).xxx * lerp(FS_1112, 1.0f.xxx, (FS_19_m80.y * FS_2174).xxx);
    float3 FS_2181 = FS_2174.xxx;
    float FS_2194 = lerp(0.64999997615814208984375f, 1.0f, FS_1113);
    float3 FS_2204 = FS_2103.xxx;
    float3 FS_2205 = lerp((FS_2179 * lerp(isnan(1.5f) ? FS_2194 : (isnan(FS_2194) ? 1.5f : min(FS_2194, 1.5f)), clamp(FS_1113, 1.25f, 1.75f), FS_19_m80.x)) * FS_19_m79.w, (lerp(dot(FS_2086, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, FS_2086, FS_2181) + ((FS_2179 * clamp(FS_1113, 0.0f, 1.5f)) * ((1.0f - FS_19_m91.y).xxx + (FS_2082 * FS_19_m91.y)))) * FS_19_m79.y, FS_2204);
    float3 FS_2206 = lerp(lerp(lerp(dot(FS_2112, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, FS_2112, 1.2000000476837158203125f.xxx), FS_2111, clamp((FS_2167 * FS_2166) + FS_2148, 0.0f, 1.0f).xxx), FS_2019, FS_2181);
    float3 FS_2212 = FS_2206 * ((1.0f - FS_2157).xxx + (FS_2147.xyz * FS_2157));
    float FS_2213 = dot(FS_2212, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float3 FS_2221 = lerp(lerp(FS_2111, lerp(FS_2116.xxx, FS_2019, 1.2000000476837158203125f.xxx), FS_2175.xxx), FS_2212 * clamp(dot(FS_2206, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)) * (1.0f / (isnan(0.001000000047497451305389404296875f) ? FS_2213 : (isnan(FS_2213) ? 0.001000000047497451305389404296875f : max(FS_2213, 0.001000000047497451305389404296875f)))), 0.0f, 1.5f), FS_2204);
    float4 FS_2225 = float4(FS_2221, FS_2103);
    float FS_2227 = lerp(FS_2175, FS_2174, FS_2103);
    float FS_2230 = lerp(FS_19_m79.z, 1.0f, FS_2227);
    float3 FS_2238 = float3(FS_571.x, lerp(0.5f, FS_2068.y, FS_2103), FS_571.z);
    float FS_2239 = dot(FS_2238, FS_2238);
    float FS_2251 = clamp(dot(FS_1833, FS_447), 0.0f, 1.0f);
    float FS_2252 = dot(FS_1833, normalize(((FS_2068 * FS_2103) + ((FS_2238 * rsqrt(isnan(FS_2239) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? FS_2239 : max(1.1754943508222875079687365372222e-38f, FS_2239)))) * 2.0f)) + (FS_447 * (2.0f + FS_2103))));
    float FS_2256 = (((FS_2252 * FS_2026) - FS_2252) * FS_2252) + 1.0f;
    float FS_2257 = FS_2256 * FS_2256;
    float FS_2260 = (FS_2026 != FS_2257) ? (FS_2026 / FS_2257) : 1.0f;
    float FS_2261 = 2.0f * FS_2251;
    float FS_2263 = (1.0f + FS_2251) - FS_2251;
    float FS_2269 = 1.0f / (FS_2026 + 9.9999997473787516355514526367188e-05f);
    float FS_2272 = FS_2251 * FS_2251;
    float3 FS_2284 = FS_2022 * FS_51.SampleLevel(sampler_LinearClamp, float2(lerp(FS_2260 / (isnan(65504.0f) ? FS_2269 : (isnan(FS_2269) ? 65504.0f : min(FS_2269, 65504.0f))), FS_2272, FS_49_m4), FS_2013 * (1.0f - FS_2016)), 0.0f).xyz;
    float3 FS_2286 = lerp(FS_2022, FS_2284, FS_49_m4.xxx);
    float FS_2299 = (1.0f - FS_49_m6) + (FS_494 * FS_49_m6);
    float3 FS_2301 = ((FS_2205 * FS_2221) * FS_2299) + (((FS_2284 * clamp((FS_2260 * (0.5f / ((FS_2261 + (FS_2025 * FS_2263)) + 9.9999997473787516355514526367188e-05f))) - 6.103515625e-05f, 0.0f, 20.0f)) * ((FS_2205 * (((FS_2227 * 0.5f) + 0.5f) * FS_2230)) * 1.0f)) * FS_19_m92.w);
    float FS_2302 = dot(FS_2301, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float FS_2305 = clamp(FS_2302 - 0.5f, 0.0f, 0.5f);
    float3 FS_2341 = normalize(cross(FS_571, lerp(float3(FS_19_m88.xy, 0.0f), (float3(FS_17_m0[0].x, FS_17_m0[0].y, FS_17_m0[0].z) * FS_19_m88.x) + (float3(FS_17_m0[1].x, FS_17_m0[1].y, FS_17_m0[1].z) * FS_19_m88.y), FS_19_m94.w.xxx)));
    float FS_2347 = dot(FS_447, FS_2011);
    float FS_2349 = 1.0f - abs(FS_2347);
    float FS_2359 = clamp(dot(FS_538, FS_2341) + 1.0f, 0.0f, 1.0f);
    float FS_2360 = isnan(FS_488) ? FS_2359 : (isnan(FS_2359) ? FS_488 : min(FS_2359, FS_488));
    float FS_2371 = dot(FS_2072, FS_2011);
    float FS_2383 = 1.0f - FS_2103;
    float FS_2394 = isnan(FS_1111.y) ? FS_1111.x : (isnan(FS_1111.x) ? FS_1111.y : max(FS_1111.x, FS_1111.y));
    float FS_2396 = (isnan(FS_1111.z) ? FS_2394 : (isnan(FS_2394) ? FS_1111.z : max(FS_2394, FS_1111.z))) * 0.5f;
    bool3 FS_4055 = isnan(0.1500000059604644775390625f.xxx);
    bool3 FS_4056 = isnan(FS_2019);
    float3 FS_4057 = max(0.1500000059604644775390625f.xxx, FS_2019);
    float3 FS_4058 = float3(FS_4055.x ? FS_2019.x : FS_4057.x, FS_4055.y ? FS_2019.y : FS_4057.y, FS_4055.z ? FS_2019.z : FS_4057.z);
    float FS_2410 = lerp(FS_2013, FS_1835, FS_1834);
    float FS_2411 = FS_2410 * FS_2410;
    float FS_2412 = FS_2272 * FS_2251;
    float2 FS_2413 = float2(1.0f, FS_2251);
    float2 FS_2416 = float2(1.0f, FS_2411);
    float3 FS_2419 = float3(1.0f, FS_2411, (FS_2411 * FS_2411) * FS_2411);
    float FS_2424 = dot(mul(FS_2413, float2x2(float2(0.0365463010966777801513671875f, 9.0631999969482421875f), float2(3.3270699977874755859375f, -9.0475597381591796875f))), FS_2416) / dot(mul(float3(1.0f, FS_2272, FS_2412), float3x3(float3(1.0f, 9.044010162353515625f, 5.565889835357666015625f), float3(3.596849918365478515625f, -16.3173999786376953125f, 19.788600921630859375f), float3(-1.36772000789642333984375f, 9.2294902801513671875f, -20.212299346923828125f))), FS_2419);
    float FS_2429 = dot(mul(FS_2413, float2x2(float2(0.99044001102447509765625f, 1.29677999019622802734375f), float2(-1.28514003753662109375f, -0.755906999111175537109375f))), FS_2416) / dot(mul(float3(1.0f, FS_2251, FS_2412), float3x3(float3(1.0f, 20.3225002288818359375f, 121.5630035400390625f), float3(2.9233798980712890625f, -27.0301990509033203125f, 626.1300048828125f), float3(59.41880035400390625f, 222.5919952392578125f, 316.62701416015625f))), FS_2419);
    float3 FS_2432 = (FS_2286 * FS_2424) + FS_2429.xxx;
    float FS_2433 = FS_2424 + FS_2429;
    float3 FS_2439 = -FS_447;
    float2 FS_2459 = float2(FS_561);
    float2 FS_2461 = floor(FS_2459 * 0.03125f);
    int FS_2469 = int((FS_2461.x + (FS_2461.y * FS_34_m5)) * 8.0f);
    float FS_2476 = floor(FS_428 - (FS_19_m3.y * FS_34_m11));
    float FS_2480 = clamp(FS_2476, 0.0f, FS_34_m7 - 1.0f);
    int FS_2482 = int(FS_2480 * 8.0f);
    float3 FS_2484;
    FS_2484 = (lerp(FS_2302.xxx, FS_2301, ((FS_2305 * FS_2305) + 1.0f).xxx) + (((((FS_19_m87.xyz * smoothstep(lerp(0.800000011920928955078125f, 0.20000000298023223876953125f, FS_19_m88.w), lerp(0.89999997615814208984375f, 0.5f, FS_19_m88.w), FS_2349)) * FS_19_m87.w) * (isnan(FS_2100) ? FS_2360 : (isnan(FS_2360) ? FS_2100 : min(FS_2360, FS_2100)))) * (lerp(0.25f.xxx, FS_2019, FS_19_m88.z.xxx) * clamp(dot(FS_2341, FS_2011), 0.0f, 1.0f))) + ((((((lerp(FS_1111 * (1.0f / (isnan(1.0f) ? FS_2396 : (isnan(FS_2396) ? 1.0f : max(FS_2396, 1.0f)))), FS_2086, FS_2204) * clamp(lerp(dot(FS_1110.xyz, FS_2011) * FS_1110.w, ((-FS_2371) * ((FS_2371 * 0.5f) - 1.0f)) + 0.5f, FS_2103), 0.0f, 1.0f)) * ((FS_2383 + (FS_2129 * FS_2103)) * FS_2133)) * smoothstep(0.60000002384185791015625f, 0.800000011920928955078125f, FS_2349)) * (isnan(FS_2100) ? FS_488 : (isnan(FS_488) ? FS_2100 : min(FS_488, FS_2100)))) * (FS_2383 + (smoothstep(0.100000001490116119384765625f, 0.039999999105930328369140625f, FS_2116) * FS_2103))) * float3(FS_4056.x ? 0.1500000059604644775390625f.xxx.x : FS_4058.x, FS_4056.y ? 0.1500000059604644775390625f.xxx.y : FS_4058.y, FS_4056.z ? 0.1500000059604644775390625f.xxx.z : FS_4058.z)))) + (((FS_60.SampleLevel(sampler_LinearClamp, reflect(FS_2439, FS_1833), (1.2000000476837158203125f * log2(isnan(0.001000000047497451305389404296875f) ? FS_2410 : (isnan(FS_2410) ? 0.001000000047497451305389404296875f : max(FS_2410, 0.001000000047497451305389404296875f)))) + 5.0f).xyz * ((FS_2432 + ((FS_2286 * ((1.0f - FS_2433) / FS_2433)) * FS_2432)) * 1.0f)) * ((clamp(FS_1113, 0.5f, 1.5f) * FS_19_m79.w) * FS_2230)) * FS_1112);
    float3 FS_2485;
    [loop]
    for (int FS_2487 = 0; FS_2487 <= 7; FS_2484 = FS_2485, FS_2487++)
    {
        uint FS_2505 = (FS_2476 <= FS_2480) ? (FS_30.Load(uint(FS_2469 + FS_2487) * 4 + 0) & FS_30.Load(uint((FS_19_m21.y + FS_2482) + FS_2487) * 4 + 0)) : 0u;
        uint FS_2506 = uint(FS_2487);
        FS_2485 = FS_2484;
        uint FS_2511;
        float3 FS_2508;
        [loop]
        for (uint FS_2510 = FS_2505; FS_2510 != 0u; FS_2485 = FS_2508, FS_2510 = FS_2511)
        {
            uint FS_2515 = firstbitlow(FS_2510);
            FS_2511 = FS_2510 ^ (1u << (FS_2515 & 31u));
            int FS_2521 = int((32u * FS_2506) + FS_2515) * 8;
            int FS_2524 = FS_2521 + 1;
            int FS_2527 = FS_2521 + 2;
            int FS_2530 = FS_2521 + 3;
            int FS_2533 = FS_2521 + 4;
            int FS_2536 = FS_2521 + 5;
            int FS_2539 = FS_2521 + 6;
            int FS_2542 = FS_2521 + 7;
            uint FS_2546 = uint(FS_36_m6[FS_2536].w);
            float FS_2621;
            if ((FS_2546 & 1u) == 1u)
            {
                uint FS_2552 = asuint(FS_36_m6[FS_2536].x);
                uint FS_2559 = asuint(FS_36_m6[FS_2536].y);
                uint FS_2566 = asuint(FS_36_m6[FS_2536].z);
                uint FS_2573 = asuint(FS_36_m6[FS_2539].x);
                uint FS_2580 = asuint(FS_36_m6[FS_2539].y);
                uint FS_2587 = asuint(FS_36_m6[FS_2539].z);
                float3 FS_2606 = abs(mul(float4(FS_531 - FS_36_m6[FS_2524].xyz, 1.0f), float4x4(float4(spvUnpackHalf2x16(FS_2552).x, spvUnpackHalf2x16(FS_2566).x, spvUnpackHalf2x16(FS_2580).x, 0.0f), float4(spvUnpackHalf2x16(FS_2552 >> 16u).x, spvUnpackHalf2x16(FS_2566 >> 16u).x, spvUnpackHalf2x16(FS_2580 >> 16u).x, 0.0f), float4(spvUnpackHalf2x16(FS_2559).x, spvUnpackHalf2x16(FS_2573).x, spvUnpackHalf2x16(FS_2587).x, 0.0f), float4(spvUnpackHalf2x16(FS_2559 >> 16u).x, spvUnpackHalf2x16(FS_2573 >> 16u).x, spvUnpackHalf2x16(FS_2587 >> 16u).x, 0.0f))).xyz);
                float FS_2607 = FS_2606.x;
                float FS_2608 = FS_2606.y;
                float FS_2609 = isnan(FS_2608) ? FS_2607 : (isnan(FS_2607) ? FS_2608 : max(FS_2607, FS_2608));
                float FS_2610 = FS_2606.z;
                float FS_2613 = FS_36_m6[FS_2542].x * 0.5f;
                float FS_2619 = 1.0f - clamp(((isnan(FS_2610) ? FS_2609 : (isnan(FS_2609) ? FS_2610 : max(FS_2609, FS_2610))) - (FS_2613 + 0.5f)) / (0.5f - FS_2613), 0.0f, 1.0f);
                FS_2621 = FS_2619 * FS_2619;
            }
            else
            {
                FS_2621 = 1.0f;
            }
            if (false || (FS_2621 < 0.001000000047497451305389404296875f))
            {
                FS_2508 = FS_2485;
                continue;
            }
            float3 FS_3314;
            if (FS_36_m6[FS_2521].w < 1.5f)
            {
                float3 FS_3313;
                do
                {
                    uint FS_2634 = asuint(FS_36_m6[FS_2530].w);
                    if ((FS_2634 == 16u) || ((FS_36_m6[FS_2530].z + FS_19_m91.z) < 0.5f))
                    {
                        FS_3313 = FS_2485;
                        break;
                    }
                    bool FS_2646 = (uint(FS_36_m6[FS_2521].w) & 1u) == 0u;
                    bool FS_2650 = (!FS_2646) && (FS_36_m6[FS_2527].z > 0.0f);
                    bool FS_2651 = FS_2634 == 4u;
                    float FS_2652 = float(FS_2646);
                    float FS_2660 = (0.5f + (0.5f * FS_36_m6[FS_2527].y)) - abs(FS_36_m6[FS_2527].x);
                    float FS_2661 = FS_36_m6[FS_2527].y - FS_2660;
                    float FS_2665 = (1.0f - abs(FS_2660)) - abs(FS_2661);
                    float FS_2668 = abs(isnan(0.00048828125f) ? FS_2665 : (isnan(FS_2665) ? 0.00048828125f : max(FS_2665, 0.00048828125f)));
                    float3 FS_2672 = normalize(float3(FS_2660, FS_2661, (FS_36_m6[FS_2527].x >= 0.0f) ? FS_2668 : (-FS_2668)));
                    float FS_2675 = 2.0f * FS_36_m6[FS_2533].y;
                    float FS_2678 = lerp(FS_36_m6[FS_2539].w, isnan(0.100000001490116119384765625f) ? FS_2675 : (isnan(FS_2675) ? 0.100000001490116119384765625f : max(FS_2675, 0.100000001490116119384765625f)), float(FS_2651));
                    float3 FS_2683 = FS_36_m6[FS_2524].xyz - FS_531;
                    float3 FS_2684 = -FS_2672;
                    float3 FS_2689 = lerp(FS_2683, FS_2684 * dot(FS_2683, FS_2684), (float(FS_2651 && (FS_36_m6[FS_2533].z > 0.5f)) * FS_2652).xxx);
                    float FS_2690 = dot(FS_2689, FS_2689);
                    float FS_2691 = rsqrt(FS_2690);
                    float3 FS_2692 = FS_2689 * FS_2691;
                    float3 FS_2725;
                    float FS_2726;
                    if (FS_2650)
                    {
                        float3 FS_2696 = (FS_2672 * FS_36_m6[FS_2527].z) * 0.5f;
                        float3 FS_2697 = FS_2689 - FS_2696;
                        float3 FS_2698 = FS_2689 + FS_2696;
                        float FS_2699 = length(FS_2697);
                        float FS_2700 = length(FS_2698);
                        float3 FS_2709 = normalize(cross(cross(FS_2672, FS_2692), FS_2672));
                        FS_2725 = FS_2709;
                        FS_2726 = ((1.0f / ((((FS_2699 * FS_2700) + dot(FS_2697, FS_2698)) * 0.5f) + 1.0f)) * clamp(0.5f * ((dot(FS_2709, FS_2697) / FS_2699) + (dot(FS_2709, FS_2698) / FS_2700)), 0.0f, 1.0f)) * (1.0f / clamp(1.0f + (0.5f * clamp(FS_36_m6[FS_2527].z * FS_2691, 0.0f, 1.0f)), 0.0f, 1.0f));
                    }
                    else
                    {
                        FS_2725 = FS_2692;
                        FS_2726 = 1.0f;
                    }
                    float FS_2748;
                    if (FS_2678 < 0.0f)
                    {
                        float FS_2736 = FS_2690 * (FS_36_m6[FS_2524].w * FS_36_m6[FS_2524].w);
                        float FS_2739 = clamp(1.0f - (FS_2736 * FS_2736), 0.0f, 1.0f);
                        FS_2748 = lerp(1.0f / (FS_2690 + 1.0f), FS_2726, float(FS_2650)) * (FS_2739 * FS_2739);
                    }
                    else
                    {
                        float3 FS_2742 = FS_2689 * FS_36_m6[FS_2524].w;
                        FS_2748 = FS_2726 * pow(1.0f - clamp(dot(FS_2742, FS_2742), 0.0f, 1.0f), FS_2678);
                    }
                    float FS_2753 = clamp((dot(FS_2725, FS_2684) - FS_36_m6[FS_2527].z) * FS_36_m6[FS_2527].w, 0.0f, 1.0f);
                    float FS_2756 = FS_2748 * lerp(1.0f, FS_2753 * FS_2753, FS_2652);
                    int FS_2758 = int(FS_36_m6[FS_2542].w);
                    float FS_2862;
                    if ((!FS_2650) && (FS_2758 >= 0))
                    {
                        uint FS_2764 = uint(FS_2758);
                        float2 FS_2855;
                        [branch]
                        if (FS_2652 != 0.0f)
                        {
                            float4 FS_2776 = mul(FS_63_m1[FS_2764], float4(FS_531.x, FS_603, FS_531.z, 1.0f));
                            FS_2855 = FS_63_m0[FS_2764].xy + (clamp(FS_2776.xy / FS_2776.w.xx, 0.0f.xx, 1.0f.xx) * FS_63_m0[FS_2764].zw);
                        }
                        else
                        {
                            float3 FS_2796 = mul(float4(-FS_2689, 0.0f), FS_63_m1[FS_2764]).xyz;
                            float3 FS_417 = FS_2796;
                            float3 FS_416 = FS_2796;
                            float3 FS_415 = abs(FS_2796);
                            uint FS_2805 = uint(int(FS_415.y > FS_415.x));
                            uint FS_2811 = (FS_415.z > FS_415[FS_2805]) ? 2u : FS_2805;
                            uint FS_2817 = (FS_2811 * 2u) + uint(FS_416[FS_2811] < 0.0f);
                            float FS_2821 = abs(FS_417[FS_2817 / 2u]);
                            float FS_2841 = 0.5f - (0.000244140625f / FS_63_m0[FS_2764].w);
                            FS_2855 = FS_63_m0[FS_2764].xy + (clamp(float2((float(FS_2817) + ((((FS_417[uint(FS_366[FS_2817].x)] * FS_367[FS_2817].x) / FS_2821) * FS_2841) + 0.5f)) * 0.16666667163372039794921875f, 0.5f - (((FS_417[uint(FS_366[FS_2817].y)] * FS_367[FS_2817].y) / FS_2821) * FS_2841)), 0.0f.xx, 1.0f.xx) * FS_63_m0[FS_2764].zw);
                        }
                        FS_2862 = FS_2756 * FS_61.SampleLevel(sampler_LinearClamp, FS_2855, 0.0f).x;
                    }
                    else
                    {
                        FS_2862 = FS_2756;
                    }
                    float FS_2863 = FS_2862 * FS_2621;
                    float3 FS_3312;
                    do
                    {
                        float3 FS_3311;
                        [branch]
                        if (FS_2863 > 9.9999997473787516355514526367188e-05f)
                        {
                            [branch]
                            if (FS_2651)
                            {
                                FS_3312 = lerp(FS_2485, FS_36_m6[FS_2521].xyz, (FS_2863 * (FS_36_m6[FS_2533].x * ((1.0f - FS_36_m6[FS_2533].w) + (smoothstep(-0.5f, 0.5f, dot(FS_559, FS_2725)) * FS_36_m6[FS_2533].w)))).xxx);
                                break;
                            }
                            float FS_2883 = dot(FS_2011, FS_2725);
                            float FS_2884 = clamp(FS_2883, 0.0f, 1.0f);
                            float FS_3187;
                            if (FS_2634 != 0u)
                            {
                                bool FS_2890 = FS_2646 || ((FS_2546 & 2u) != 0u);
                                int FS_2939;
                                if (FS_2890)
                                {
                                    FS_2939 = int(FS_36_m6[FS_2530].x);
                                }
                                else
                                {
                                    uint FS_2896 = asuint(FS_36_m6[FS_2527].w);
                                    uint FS_2898 = asuint(FS_36_m6[FS_2530].x);
                                    float3 FS_2899 = FS_531 - FS_36_m6[FS_2524].xyz;
                                    float3 FS_2900 = abs(FS_2899);
                                    float FS_2901 = FS_2900.x;
                                    float FS_2902 = FS_2900.y;
                                    float FS_2904 = FS_2900.z;
                                    int FS_2936;
                                    if ((FS_2901 > FS_2902) && (FS_2901 > FS_2904))
                                    {
                                        FS_2936 = int((FS_2899.x > 0.0f) ? (FS_2896 >> 24u) : ((FS_2896 >> 16u) & 255u));
                                    }
                                    else
                                    {
                                        int FS_2935;
                                        if (FS_2902 > FS_2904)
                                        {
                                            FS_2935 = int((FS_2899.y > 0.0f) ? ((FS_2896 >> 8u) & 255u) : (FS_2896 & 255u));
                                        }
                                        else
                                        {
                                            FS_2935 = int((FS_2899.z > 0.0f) ? ((FS_2898 >> 8u) & 255u) : (FS_2898 & 255u));
                                        }
                                        FS_2936 = FS_2935;
                                    }
                                    FS_2939 = (FS_2936 < 80) ? FS_2936 : (-1);
                                }
                                bool FS_2940 = FS_2939 >= 0;
                                float FS_3186;
                                if (FS_2940)
                                {
                                    float4 EIDShadowParams = FS_38_m11[FS_2939];
                                    float3 FS_2944 = FS_531 - FS_36_m6[FS_2524].xyz;
                                    float FS_2945 = dot(FS_2944, FS_2944);
                                    float4 FS_2964 = mul(FS_38_m10[FS_2939], float4((FS_531 - ((FS_2944 * rsqrt(isnan(FS_2945) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? FS_2945 : max(1.1754943508222875079687365372222e-38f, FS_2945)))) * EIDShadowParams.x)) + (FS_559 * (EIDShadowParams.y * 5.0f)), 1.0f));
                                    float FS_2965 = FS_2964.w;
                                    float3 FS_2968 = FS_2964.xyz / FS_2965.xxx;
                                    float2 FS_2969 = FS_2968.xy;
                                    float3 FS_2977 = FS_2968.xyz;
                                    bool3 FS_2978 = bool3(FS_2977.x <= 0.0f.xxx.x, FS_2977.y <= 0.0f.xxx.y, FS_2977.z <= 0.0f.xxx.z);
                                    bool3 FS_2979 = bool3(FS_2977.x >= 1.0f.xxx.x, FS_2977.y >= 1.0f.xxx.y, FS_2977.z >= 1.0f.xxx.z);
                                    float FS_2982 = FS_2968.z;
                                    float2 FS_2993 = ((FS_2969 * (FS_38_m12[FS_2939].zw - FS_38_m12[FS_2939].xy)) + FS_38_m12[FS_2939].xy).xy * FS_38_m13.zw;
                                    float2 FS_2995 = floor(FS_2993 + 0.5f.xx);
                                    float2 FS_2996 = FS_2993 - FS_2995;
                                    float FS_2997 = FS_2996.x;
                                    float FS_2998 = FS_2997 + 0.5f;
                                    float FS_2999 = FS_2998 * FS_2998;
                                    float FS_3002 = 1.0f - FS_2997;
                                    float FS_3003 = isnan(0.0f) ? FS_2997 : (isnan(FS_2997) ? 0.0f : min(FS_2997, 0.0f));
                                    float FS_3006 = FS_2997 + 1.0f;
                                    float FS_3007 = isnan(0.0f) ? FS_2997 : (isnan(FS_2997) ? 0.0f : max(FS_2997, 0.0f));
                                    float FS_3018 = FS_2996.y;
                                    float FS_3019 = FS_3018 + 0.5f;
                                    float FS_3020 = FS_3019 * FS_3019;
                                    float FS_3023 = 1.0f - FS_3018;
                                    float FS_3024 = isnan(0.0f) ? FS_3018 : (isnan(FS_3018) ? 0.0f : min(FS_3018, 0.0f));
                                    float FS_3027 = FS_3018 + 1.0f;
                                    float FS_3028 = isnan(0.0f) ? FS_3018 : (isnan(FS_3018) ? 0.0f : max(FS_3018, 0.0f));
                                    float3 FS_3040 = float3(0.1599999964237213134765625f * FS_3002, 0.1599999964237213134765625f * ((FS_3006 - (FS_3007 * FS_3007)) + 1.0f), FS_2999 * 0.07999999821186065673828125f);
                                    float3 FS_3041 = float3(0.1599999964237213134765625f * ((FS_2999 * 0.5f) - FS_2997), 0.1599999964237213134765625f * ((FS_3002 - (FS_3003 * FS_3003)) + 1.0f), 0.1599999964237213134765625f * FS_3006) + FS_3040;
                                    float3 FS_3043 = float3(0.1599999964237213134765625f * FS_3023, 0.1599999964237213134765625f * ((FS_3027 - (FS_3028 * FS_3028)) + 1.0f), FS_3020 * 0.07999999821186065673828125f);
                                    float3 FS_3044 = float3(0.1599999964237213134765625f * ((FS_3020 * 0.5f) - FS_3018), 0.1599999964237213134765625f * ((FS_3023 - (FS_3024 * FS_3024)) + 1.0f), 0.1599999964237213134765625f * FS_3027) + FS_3043;
                                    float3 FS_3050 = ((FS_3040 / FS_3041) + float3(-2.5f, -0.5f, 1.5f)) * FS_38_m13.xxx;
                                    float3 FS_3052 = ((FS_3043 / FS_3044) + float3(-2.5f, -0.5f, 1.5f)) * FS_38_m13.yyy;
                                    float2 FS_3054 = FS_2995 * FS_38_m13.xy;
                                    float FS_3055 = FS_3050.x;
                                    float FS_3056 = FS_3052.x;
                                    float FS_3059 = FS_3050.y;
                                    float FS_3062 = FS_3050.z;
                                    float FS_3065 = FS_3052.y;
                                    float FS_3072 = FS_3052.z;
                                    float FS_3079 = FS_3041.x;
                                    float FS_3080 = FS_3044.x;
                                    float FS_3082 = FS_3041.y;
                                    float FS_3084 = FS_3041.z;
                                    float FS_3086 = FS_3044.y;
                                    float FS_3090 = FS_3044.z;
                                    float2 FS_3168 = 1.0f.xx - FS_2969;
                                    bool2 FS_4110 = isnan(FS_2969);
                                    bool2 FS_4111 = isnan(FS_3168);
                                    float2 FS_4112 = min(FS_2969, FS_3168);
                                    float2 FS_4113 = float2(FS_4110.x ? FS_3168.x : FS_4112.x, FS_4110.y ? FS_3168.y : FS_4112.y);
                                    float2 FS_3169 = float2(FS_4111.x ? FS_2969.x : FS_4113.x, FS_4111.y ? FS_2969.y : FS_4113.y);
                                    float FS_3170 = FS_3169.x;
                                    float FS_3171 = FS_3169.y;
                                    float FS_3172 = isnan(FS_3171) ? FS_3170 : (isnan(FS_3170) ? FS_3171 : min(FS_3170, FS_3171));
                                    float FS_3176 = (EIDShadowParams.z - FS_2965) * 0.25f;
                                    float FS_3178 = smoothstep(0.0f, 0.0500000007450580596923828125f, isnan(FS_3172) ? FS_3176 : (isnan(FS_3176) ? FS_3172 : min(FS_3176, FS_3172)));
                                    FS_3186 = FS_2940 ? lerp(1.0f, (any(bool3(FS_2978.x || FS_2979.x, FS_2978.y || FS_2979.y, FS_2978.z || FS_2979.z)) || ((asuint(FS_2982) & 2147483647u) > 2139095040u)) ? 1.0f : ((((((((((FS_3079 * FS_3080) * EIDShadowCompare(float3(FS_3054 + float2(FS_3055, FS_3056), FS_409).xy, FS_2982)) + ((FS_3082 * FS_3080) * EIDShadowCompare(float3(FS_3054 + float2(FS_3059, FS_3056), FS_409).xy, FS_2982))) + ((FS_3084 * FS_3080) * EIDShadowCompare(float3(FS_3054 + float2(FS_3062, FS_3056), FS_409).xy, FS_2982))) + ((FS_3079 * FS_3086) * EIDShadowCompare(float3(FS_3054 + float2(FS_3055, FS_3065), FS_409).xy, FS_2982))) + ((FS_3082 * FS_3086) * EIDShadowCompare(float3(FS_3054 + float2(FS_3059, FS_3065), FS_409).xy, FS_2982))) + ((FS_3084 * FS_3086) * EIDShadowCompare(float3(FS_3054 + float2(FS_3062, FS_3065), FS_409).xy, FS_2982))) + ((FS_3079 * FS_3090) * EIDShadowCompare(float3(FS_3054 + float2(FS_3055, FS_3072), FS_409).xy, FS_2982))) + ((FS_3082 * FS_3090) * EIDShadowCompare(float3(FS_3054 + float2(FS_3059, FS_3072), FS_409).xy, FS_2982))) + ((FS_3084 * FS_3090) * EIDShadowCompare(float3(FS_3054 + float2(FS_3062, FS_3072), FS_409).xy, FS_2982))), FS_2890 ? (isnan(FS_3178) ? EIDShadowParams.w : (isnan(EIDShadowParams.w) ? FS_3178 : min(EIDShadowParams.w, FS_3178))) : EIDShadowParams.w) : 1.0f;
                                }
                                else
                                {
                                    FS_3186 = clamp(dot(FS_538, FS_2725) + 1.0f, 0.0f, 1.0f);
                                }
                                FS_3187 = FS_3186;
                            }
                            else
                            {
                                FS_3187 = 1.0f;
                            }
                            float FS_3267;
                            float3 FS_3268;
                            float FS_3269;
                            float3 FS_3270;
                            float3 FS_3271;
                            float FS_3272;
                            float FS_3273;
                            [branch]
                            if (FS_2634 == 0u)
                            {
                                float3 FS_3193 = FS_36_m6[FS_2521].xyz * FS_2863;
                                float FS_3194 = FS_3193.x;
                                float FS_3195 = FS_3193.y;
                                float FS_3196 = FS_3193.z;
                                float FS_3197 = isnan(FS_3195) ? FS_3194 : (isnan(FS_3194) ? FS_3195 : max(FS_3194, FS_3195));
                                float FS_3199 = (isnan(FS_3196) ? FS_3197 : (isnan(FS_3197) ? FS_3196 : max(FS_3197, FS_3196))) * lerp(0.75f, 0.5f, FS_2383);
                                float3 FS_3206 = FS_2225.xyz;
                                FS_3267 = FS_2863;
                                FS_3268 = (FS_36_m6[FS_2521].xyz * ((1.0f - FS_36_m6[FS_2533].y) + ((1.0f / (isnan(FS_3199) ? 1.0f : (isnan(1.0f) ? FS_3199 : max(1.0f, FS_3199)))) * FS_36_m6[FS_2533].y))) * lerp(0.25f * FS_36_m6[FS_2533].x, 1.0f, clamp(FS_2883 + 0.5f, 0.0f, 1.0f));
                                FS_3269 = FS_2884;
                                FS_3270 = FS_3206;
                                FS_3271 = FS_3206;
                                FS_3272 = 1.0f;
                                FS_3273 = 0.0f;
                            }
                            else
                            {
                                float FS_3261;
                                float FS_3262;
                                float3 FS_3263;
                                float3 FS_3264;
                                float FS_3265;
                                float FS_3266;
                                if (FS_2634 == 3u)
                                {
                                    FS_3261 = FS_2863 * (smoothstep(lerp(0.800000011920928955078125f, 0.20000000298023223876953125f, FS_36_m6[FS_2533].x), lerp(0.89999997615814208984375f, 0.5f, FS_36_m6[FS_2533].x), FS_2349) * FS_3187);
                                    FS_3262 = clamp(dot(FS_2011, -normalize(cross(FS_571, cross(FS_571, FS_2725)))), 0.0f, 1.0f);
                                    FS_3263 = lerp(0.5f.xxx, FS_2019, FS_36_m6[FS_2533].y.xxx);
                                    FS_3264 = 0.0f.xxx;
                                    FS_3265 = 1.0f;
                                    FS_3266 = 0.0f;
                                }
                                else
                                {
                                    bool FS_3231 = FS_2634 == 1u;
                                    float FS_3255;
                                    float3 FS_3256;
                                    float FS_3257;
                                    float FS_3258;
                                    if (FS_3231)
                                    {
                                        FS_3255 = clamp(clamp(FS_2883 + FS_36_m6[FS_2533].x, -1.0f, 1.0f), 0.0f, 1.0f) * FS_3187;
                                        FS_3256 = FS_2023 * FS_36_m6[FS_2533].y;
                                        FS_3257 = 1.0f;
                                        FS_3258 = 0.0f;
                                    }
                                    else
                                    {
                                        bool FS_3241 = FS_2634 == 2u;
                                        float FS_3253;
                                        if (FS_3241)
                                        {
                                            FS_3253 = smoothstep(FS_36_m6[FS_2533].x + 0.0500000007450580596923828125f, FS_36_m6[FS_2533].x - 0.0500000007450580596923828125f, FS_2013) * ((1.0f - FS_36_m6[FS_2533].z) + (step(0.5f, FS_2016) * FS_36_m6[FS_2533].z));
                                        }
                                        else
                                        {
                                            FS_3253 = 1.0f;
                                        }
                                        FS_3255 = FS_2884;
                                        FS_3256 = 0.0f.xxx;
                                        FS_3257 = FS_3253;
                                        FS_3258 = FS_3241 ? FS_36_m6[FS_2533].y : 0.0f;
                                    }
                                    bool3 FS_3259 = FS_3231.xxx;
                                    FS_3261 = FS_2863;
                                    FS_3262 = FS_3255;
                                    FS_3263 = float3(FS_3259.x ? FS_2019.x : 0.0f.xxx.x, FS_3259.y ? FS_2019.y : 0.0f.xxx.y, FS_3259.z ? FS_2019.z : 0.0f.xxx.z);
                                    FS_3264 = FS_3256;
                                    FS_3265 = FS_3257;
                                    FS_3266 = FS_3258;
                                }
                                FS_3267 = FS_3261;
                                FS_3268 = FS_36_m6[FS_2521].xyz;
                                FS_3269 = FS_3262;
                                FS_3270 = FS_3263;
                                FS_3271 = FS_3264;
                                FS_3272 = FS_3265;
                                FS_3273 = FS_3266;
                            }
                            float3 FS_3301;
                            [branch]
                            if (FS_2634 != 3u)
                            {
                                float FS_3278 = lerp(FS_2025, 0.00999999977648258209228515625f, FS_3273);
                                float FS_3281 = dot(FS_1833, normalize(FS_2725 + FS_447));
                                float FS_3282 = FS_3278 * FS_3278;
                                float FS_3286 = (((FS_3281 * FS_3282) - FS_3281) * FS_3281) + 1.0f;
                                float FS_3287 = FS_3286 * FS_3286;
                                FS_3301 = ((FS_2284 * clamp((((FS_3282 != FS_3287) ? (FS_3282 / FS_3287) : 1.0f) * (0.5f / ((FS_2261 + (FS_3278 * FS_2263)) + 9.9999997473787516355514526367188e-05f))) - 6.103515625e-05f, 0.0f, 20.0f)) * FS_3272) * FS_36_m6[FS_2542].z;
                            }
                            else
                            {
                                FS_3301 = 0.0f.xxx;
                            }
                            float3 FS_3304 = FS_3268 * FS_3267;
                            FS_3311 = FS_2485 + (((FS_3304 * lerp(FS_3271, FS_3270, FS_3269.xxx)) * FS_2299) + ((FS_3304 * FS_3301) * FS_3269));
                        }
                        else
                        {
                            FS_3311 = FS_2485;
                        }
                        FS_3312 = FS_3311;
                        break;
                    } while(false);
                    FS_3313 = FS_3312;
                    break;
                } while(false);
                FS_3314 = FS_3313;
            }
            else
            {
                FS_3314 = FS_2485;
            }
            FS_2508 = FS_3314;
        }
    }
    float3 FS_3354;
    [branch]
    if (FS_49_m12 > 0.5f)
    {
        FS_3354 = lerp(lerp(0.5f.xxx, lerp(dot(FS_2484, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, FS_2484, FS_49_m14.xxx), FS_49_m15.xxx) * FS_49_m13, FS_49_m26.xyz, FS_49_m26.w.xxx) + ((FS_49_m27.xyz * smoothstep(1.0f - FS_49_m16, 1.0f, 1.0f - clamp(FS_2347, 0.0f, 1.0f))) * FS_49_m17);
    }
    else
    {
        FS_3354 = FS_2484;
    }
    float4 FS_3366 = float4(FS_3354 * FS_19_m20.y, FS_494);
    FS_3366.w = (FS_49_m8 == 1.0f) ? FS_494 : 1.0f;
    float4 FS_3748;
    [branch]
    if (FS_19_m91.w < 0.5f)
    {
        float FS_3380 = (FS_448 * FS_19_m44.w) - FS_19_m43.w;
        float FS_3385 = FS_603 * FS_19_m46.w;
        float FS_3389 = FS_3385 + FS_19_m47.w;
        float FS_3390 = isnan(FS_3389) ? 0.00999999977648258209228515625f : (isnan(0.00999999977648258209228515625f) ? FS_3389 : max(0.00999999977648258209228515625f, FS_3389));
        float3 FS_3404 = exp(FS_19_m45.xyz * ((-(isnan(FS_3380) ? 0.0f : (isnan(0.0f) ? FS_3380 : max(0.0f, FS_3380)))) * (((1.0f - exp(-FS_3390)) / FS_3390) * exp(FS_3385 + FS_19_m48.w))));
        float FS_3407 = dot(FS_2439, FS_19_m44.xyz);
        float FS_3413 = FS_19_m45.w * FS_19_m45.w;
        float FS_3417 = (1.0f + FS_3413) - ((2.0f * FS_19_m45.w) * FS_3407);
        float FS_3421 = (12.56637096405029296875f * FS_3417) * sqrt(FS_3417);
        float3 FS_3740;
        float FS_3741;
        if (FS_19_m55.z > 0.0f)
        {
            uint3 FS_3462 = (uint3(int3(FS_2090, FS_2091, int(FS_19_m19 & 7u))) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint FS_3463 = FS_3462.y;
            uint FS_3464 = FS_3462.z;
            uint FS_3467 = FS_3462.x + (FS_3463 * FS_3464);
            uint FS_3469 = FS_3463 + (FS_3464 * FS_3467);
            uint FS_3471 = FS_3464 + (FS_3467 * FS_3469);
            uint FS_3473 = FS_3467 + (FS_3469 * FS_3471);
            float FS_3498 = dot(FS_2439, -FS_17_m0[2].xyz);
            float3 FS_3505 = FS_531 - FS_17_m11.xyz;
            float FS_3507 = (FS_19_m55.w * ((FS_3498 > 5.9604644775390625e-08f) ? (1.0f / FS_3498) : 0.0f)) * (1.0f / FS_448);
            float FS_3508 = FS_3505.y;
            float FS_3509 = FS_3507 * FS_3508;
            float FS_3511 = FS_17_m11.y + FS_3509;
            float FS_3512 = FS_3508 - FS_3509;
            float FS_3514 = (1.0f - FS_3507) * FS_448;
            float FS_3520 = FS_19_m49.z * (FS_3511 - FS_19_m49.x);
            float FS_3527 = FS_19_m49.z * FS_3512;
            float FS_3528 = isnan(FS_3527) ? (-127.0f) : (isnan(-127.0f) ? FS_3527 : max(-127.0f, FS_3527));
            float FS_3544 = FS_19_m52.x * (FS_3511 - FS_19_m52.z);
            float FS_3551 = FS_19_m52.x * FS_3512;
            float FS_3552 = isnan(FS_3551) ? (-127.0f) : (isnan(-127.0f) ? FS_3551 : max(-127.0f, FS_3551));
            float FS_3563 = ((FS_19_m49.y * exp2(-(isnan(FS_3520) ? (-127.0f) : (isnan(-127.0f) ? FS_3520 : max(-127.0f, FS_3520))))) * ((abs(FS_3528) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-FS_3528)) / FS_3528) : (0.693147182464599609375f - (0.2402265071868896484375f * FS_3528)))) + ((FS_19_m52.y * exp2(-(isnan(FS_3544) ? (-127.0f) : (isnan(-127.0f) ? FS_3544 : max(-127.0f, FS_3544))))) * ((abs(FS_3552) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-FS_3552)) / FS_3552) : (0.693147182464599609375f - (0.2402265071868896484375f * FS_3552))));
            float FS_3567 = clamp(exp2(-(FS_3563 * FS_3514)), 0.0f, 1.0f);
            float FS_3585 = clamp((FS_448 * FS_19_m50.w) + FS_19_m50.z, 0.0f, 1.0f);
            float FS_3588 = clamp(((isnan(FS_19_m51.w) ? FS_3567 : (isnan(FS_3567) ? FS_19_m51.w : max(FS_3567, FS_19_m51.w))) + clamp((FS_448 * FS_19_m50.y) + FS_19_m50.x, 0.0f, 1.0f)) + FS_3585, 0.0f, 1.0f);
            float FS_3607 = FS_3514 - FS_19_m53.w;
            float4 FS_3628 = lerp(float4(0.0f, 0.0f, 0.0f, 1.0f), FS_66.SampleLevel(sampler_LinearClamp, float3((FS_2459 + ((((float3(uint3(FS_3473, FS_3469 + (FS_3471 * FS_3473), FS_413) >> uint3(16u, 16u, 16u)) * 1.525902189314365386962890625e-05f.xxx) * 2.0f) - 1.0f.xxx) * FS_19_m59.w).xy) * FS_19_m57.xy, (log2((FS_428 * FS_19_m56.x) + FS_19_m56.y) * FS_19_m56.z) / FS_19_m55.z), 0.0f), clamp((FS_428 - FS_19_m58.z) * 1000000.0f, 0.0f, 1.0f).xxxx);
            float FS_3630 = FS_3628.w;
            FS_3740 = FS_3628.xyz + (((FS_19_m51.xyz * (1.0f - FS_3588)) + (((FS_19_m54.xyz * pow(clamp(dot(FS_447, FS_19_m53.xyz), 0.0f, 1.0f), FS_19_m54.w)) * (1.0f - clamp(exp2(-(FS_3563 * (isnan(0.0f) ? FS_3607 : (isnan(FS_3607) ? 0.0f : max(FS_3607, 0.0f))))), 0.0f, 1.0f))) * (1.0f - FS_3585))) * FS_3630);
            FS_3741 = FS_3630 * FS_3588;
        }
        else
        {
            float3 FS_3634 = FS_531 - FS_17_m11.xyz;
            float FS_3636 = FS_3634.y;
            float FS_3642 = FS_19_m49.z * (FS_17_m11.y - FS_19_m49.x);
            float FS_3649 = FS_19_m49.z * FS_3636;
            float FS_3650 = isnan(FS_3649) ? (-127.0f) : (isnan(-127.0f) ? FS_3649 : max(-127.0f, FS_3649));
            float FS_3666 = FS_19_m52.x * (FS_17_m11.y - FS_19_m52.z);
            float FS_3673 = FS_19_m52.x * FS_3636;
            float FS_3674 = isnan(FS_3673) ? (-127.0f) : (isnan(-127.0f) ? FS_3673 : max(-127.0f, FS_3673));
            float FS_3685 = ((FS_19_m49.y * exp2(-(isnan(FS_3642) ? (-127.0f) : (isnan(-127.0f) ? FS_3642 : max(-127.0f, FS_3642))))) * ((abs(FS_3650) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-FS_3650)) / FS_3650) : (0.693147182464599609375f - (0.2402265071868896484375f * FS_3650)))) + ((FS_19_m52.y * exp2(-(isnan(FS_3666) ? (-127.0f) : (isnan(-127.0f) ? FS_3666 : max(-127.0f, FS_3666))))) * ((abs(FS_3674) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-FS_3674)) / FS_3674) : (0.693147182464599609375f - (0.2402265071868896484375f * FS_3674))));
            float FS_3689 = clamp(exp2(-(FS_3685 * FS_448)), 0.0f, 1.0f);
            float FS_3707 = clamp((FS_448 * FS_19_m50.w) + FS_19_m50.z, 0.0f, 1.0f);
            float FS_3710 = clamp(((isnan(FS_19_m51.w) ? FS_3689 : (isnan(FS_3689) ? FS_19_m51.w : max(FS_3689, FS_19_m51.w))) + clamp((FS_448 * FS_19_m50.y) + FS_19_m50.x, 0.0f, 1.0f)) + FS_3707, 0.0f, 1.0f);
            float FS_3729 = FS_448 - FS_19_m53.w;
            FS_3740 = (FS_19_m51.xyz * (1.0f - FS_3710)) + (((FS_19_m54.xyz * pow(clamp(dot(FS_447, FS_19_m53.xyz), 0.0f, 1.0f), FS_19_m54.w)) * (1.0f - clamp(exp2(-(FS_3685 * (isnan(0.0f) ? FS_3729 : (isnan(FS_3729) ? 0.0f : max(FS_3729, 0.0f))))), 0.0f, 1.0f))) * (1.0f - FS_3707));
            FS_3741 = FS_3710;
        }
        float3 FS_3746 = (FS_3366.xyz * (FS_3404 * FS_3741)) + ((((clamp(((FS_19_m46.xyz * (0.0596831031143665313720703125f * (1.0f + (FS_3407 * FS_3407)))) + FS_19_m48.xyz) + (FS_19_m47.xyz * ((1.0f - FS_3413) / (isnan(0.001000000047497451305389404296875f) ? FS_3421 : (isnan(FS_3421) ? 0.001000000047497451305389404296875f : max(FS_3421, 0.001000000047497451305389404296875f))))), 0.0f.xxx, 1.0f.xxx) * 255.0f) * (1.0f.xxx - FS_3404)) * FS_3741) + FS_3740);
        FS_3748 = float4(FS_3746.x, FS_3746.y, FS_3746.z, FS_3366.w);
    }
    else
    {
        FS_3748 = FS_3366;
    }
    FS_14 = FS_3748;
    FS_15 = FS_2057;
}

FSSPIRV_Cross_Output FSmain(FSSPIRV_Cross_Input stage_input)
{
    FSgl_FragCoord = stage_input.FSgl_FragCoord;
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
