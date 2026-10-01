// Generated from EID4817 VS215993/PS215994. See .rdctools/build_eid4817.py.
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

static const int2 FS_312[6] = { int2(2, 1), int2(2, 1), int2(0, 2), int2(0, 2), int2(0, 1), int2(0, 1) };
static const float2 FS_313[6] = { float2(-1.0f, 1.0f), 1.0f.xx, float2(1.0f, -1.0f), 1.0f.xx, 1.0f.xx, float2(-1.0f, 1.0f) };

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

ByteAddressBuffer FS_29;
ByteAddressBuffer FS_31;
cbuffer FS_32_33 : register(b7)
{
    int FS_33_m0 : packoffset(c0);
    int FS_33_m1 : packoffset(c0.y);
    int FS_33_m2 : packoffset(c0.z);
    int FS_33_m3 : packoffset(c0.w);
    float FS_33_m4 : packoffset(c1);
    float FS_33_m5 : packoffset(c1.y);
    float FS_33_m6 : packoffset(c1.z);
    float FS_33_m7 : packoffset(c1.w);
    float FS_33_m8 : packoffset(c2);
    float FS_33_m9 : packoffset(c2.y);
    float FS_33_m10 : packoffset(c2.z);
    float FS_33_m11 : packoffset(c2.w);
};

cbuffer FS_34_35 : register(b8)
{
    float4 FS_35_m0 : packoffset(c0);
    float4 FS_35_m1 : packoffset(c1);
    float4 FS_35_m2 : packoffset(c2);
    float4 FS_35_m3 : packoffset(c3);
    float4 FS_35_m4 : packoffset(c4);
    uint4 FS_35_m5 : packoffset(c5);
    float4 FS_35_m6[2048] : packoffset(c6);
};

cbuffer FS_36_37 : register(b9)
{
    column_major float4x4 FS_37_m0[5] : packoffset(c0);
    float4 FS_37_m1[4] : packoffset(c20);
    float4 FS_37_m2[4] : packoffset(c24);
    float4 FS_37_m3[4] : packoffset(c28);
    float4 FS_37_m4 : packoffset(c32);
    float4 FS_37_m5 : packoffset(c33);
    float4 FS_37_m6 : packoffset(c34);
    float4 FS_37_m7 : packoffset(c35);
    float4 FS_37_m8 : packoffset(c36);
    float4 FS_37_m9[27] : packoffset(c37);
    column_major float4x4 FS_37_m10[56] : packoffset(c64);
    float4 FS_37_m11[56] : packoffset(c288);
    float4 FS_37_m12[56] : packoffset(c344);
    float4 FS_37_m13 : packoffset(c400);
    float4 FS_37_m14[47] : packoffset(c401);
    column_major float4x4 FS_37_m15[15] : packoffset(c448);
    float4 FS_37_m16[15] : packoffset(c508);
    float4 FS_37_m17[15] : packoffset(c523);
    float4 FS_37_m18[15] : packoffset(c538);
    float4 FS_37_m19 : packoffset(c553);
    float4 FS_37_m20 : packoffset(c554);
    float4 FS_37_m21[21] : packoffset(c555);
    column_major float4x4 FS_37_m22 : packoffset(c576);
    column_major float4x4 FS_37_m23 : packoffset(c580);
    float4 FS_37_m24 : packoffset(c584);
    float4 FS_37_m25 : packoffset(c585);
    float4 FS_37_m26 : packoffset(c586);
    float4 FS_37_m27[128] : packoffset(c587);
};

#if !defined(EID_LIVE_PER_MATERIAL)
cbuffer FS_47_48 : register(b10)
{
    float FS_48_m0 : packoffset(c0);
    float FS_48_m1 : packoffset(c0.y);
    float FS_48_m2 : packoffset(c0.z);
    float FS_48_m3 : packoffset(c0.w);
    float FS_48_m4 : packoffset(c1);
    float FS_48_m5 : packoffset(c1.y);
    float FS_48_m6 : packoffset(c1.z);
    float FS_48_m7 : packoffset(c1.w);
    float FS_48_m8 : packoffset(c2);
    float FS_48_m9 : packoffset(c2.y);
    float FS_48_m10 : packoffset(c2.z);
    float FS_48_m11 : packoffset(c2.w);
    float FS_48_m12 : packoffset(c3);
    float FS_48_m13 : packoffset(c3.y);
    float FS_48_m14 : packoffset(c3.z);
    float FS_48_m15 : packoffset(c3.w);
    float FS_48_m16 : packoffset(c4);
    float FS_48_m17 : packoffset(c4.y);
    float FS_48_m18 : packoffset(c4.z);
    float FS_48_m19 : packoffset(c4.w);
    float FS_48_m20 : packoffset(c5);
    float FS_48_m21 : packoffset(c5.y);
    float FS_48_m22 : packoffset(c5.z);
    float FS_48_m23 : packoffset(c5.w);
    float4 FS_48_m24 : packoffset(c6);
    float4 FS_48_m25 : packoffset(c7);
    float4 FS_48_m26 : packoffset(c8);
    float4 FS_48_m27 : packoffset(c9);
    float4 FS_48_m28 : packoffset(c10);
    float4 FS_48_m29 : packoffset(c11);
    float FS_48_m30 : packoffset(c12);
    float FS_48_m31 : packoffset(c12.y);
    float FS_48_m32 : packoffset(c12.z);
    float FS_48_m33 : packoffset(c12.w);
    float4 FS_48_m34 : packoffset(c13);
    float4 FS_48_m35 : packoffset(c14);
    float4 FS_48_m36 : packoffset(c15);
    float4 FS_48_m37 : packoffset(c16);
    float FS_48_m38 : packoffset(c17);
    float FS_48_m39 : packoffset(c17.y);
    float FS_48_m40 : packoffset(c17.z);
    float FS_48_m41 : packoffset(c17.w);
    float4 FS_48_m42 : packoffset(c18);
    float4 FS_48_m43 : packoffset(c19);
    float4 FS_48_m44 : packoffset(c20);
    float4 FS_48_m45 : packoffset(c21);
    float4 FS_48_m46 : packoffset(c22);
    float FS_48_m47 : packoffset(c23);
    float FS_48_m48 : packoffset(c23.y);
    float FS_48_m49 : packoffset(c23.z);
    float FS_48_m50 : packoffset(c23.w);
    float FS_48_m51 : packoffset(c24);
    float FS_48_m52 : packoffset(c24.y);
    float FS_48_m53 : packoffset(c24.z);
    float FS_48_m54 : packoffset(c24.w);
};
#endif

cbuffer FS_54_55 : register(b11)
{
    float4 FS_55_m0[32] : packoffset(c0);
    column_major float4x4 FS_55_m1[32] : packoffset(c32);
};

SamplerState sampler_LinearRepeat;
SamplerState sampler_PointRepeat;

Texture2D<float4> FS_39;
Texture2D<float4> FS_40;
Texture3D<float4> FS_42;
Texture3D<float4> FS_43;
Texture3D<float4> FS_44;
Texture3D<float4> FS_45;
Texture3D<float4> FS_46;
Texture3D<float4> FS_47;
Texture2D<float4> FS4817_49;
Texture2D<float4> FS_54;
Texture2D<float4> FS4817_51;
Texture2D<float4> FS4817_52;
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

static float FS_332;
static float3 FS_333;
static float FS_335;
static uint FS_336;

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
 float3 t = unity_ObjectToWorld._m03_m13_m23;
 v._m0[0] = float4(0.0f, 0.0f, 0.0f, t.x);
 v._m0[1] = float4(0.0f, 0.0f, 0.0f, t.y);
 v._m0[2] = float4(0.0f, 0.0f, 0.0f, t.z);
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
void EIDEarlyExit0(inout float3 FS_1150, inout float3 FS_1156, inout float3 FS_1157, inout float4 FS_1365, inout float FS_1406, inout float FS_1434, inout float3 FS_1501, inout int FS_1537, inout int FS_1540, inout int FS_1543, inout int FS_1546, inout int FS_1549, inout uint FS_1562, inout uint FS_1650, inout bool FS_1662, inout bool FS_1667, inout float3 FS_1741, inout float FS_1880, inout float3 FS_2272, inout float3 FS_455, inout float3 FS_462, inout float3 FS_473, inout float3 FS_507)
{
                        float3 FS_2271;
                        [branch]
                        if (FS_1880 > 9.9999997473787516355514526367188e-05f)
                        {
                            [branch]
                            if (FS_1667)
                            {
                                FS_2272 = lerp(FS_1501, FS_35_m6[FS_1537].xyz, (FS_1880 * (FS_35_m6[FS_1549].x * ((1.0f - FS_35_m6[FS_1549].w) + (smoothstep(-0.5f, 0.5f, dot(FS_473, FS_1741)) * FS_35_m6[FS_1549].w)))).xxx);
                                return;
                            }
                            float FS_1900 = dot(FS_1150, FS_1741);
                            float FS_1901 = clamp(FS_1900, 0.0f, 1.0f);
                            float FS_2204;
                            if (FS_1650 != 0u)
                            {
                                bool FS_1907 = FS_1662 || ((FS_1562 & 2u) != 0u);
                                int FS_1956;
                                if (FS_1907)
                                {
                                    FS_1956 = int(FS_35_m6[FS_1546].x);
                                }
                                else
                                {
                                    uint FS_1911 = asuint(FS_35_m6[FS_1543].w);
                                    uint FS_1913 = asuint(FS_35_m6[FS_1546].x);
                                    float3 FS_1914 = FS_455 - FS_35_m6[FS_1540].xyz;
                                    float3 FS_1915 = abs(FS_1914);
                                    float FS_1916 = FS_1915.x;
                                    float FS_1917 = FS_1915.y;
                                    float FS_1919 = FS_1915.z;
                                    int FS_1951;
                                    if ((FS_1916 > FS_1917) && (FS_1916 > FS_1919))
                                    {
                                        FS_1951 = int((FS_1914.x > 0.0f) ? (FS_1911 >> 24u) : ((FS_1911 >> 16u) & 255u));
                                    }
                                    else
                                    {
                                        int FS_1943;
                                        if (FS_1917 > FS_1919)
                                        {
                                            FS_1943 = int((FS_1914.y > 0.0f) ? ((FS_1911 >> 8u) & 255u) : (FS_1911 & 255u));
                                        }
                                        else
                                        {
                                            FS_1943 = int((FS_1914.z > 0.0f) ? ((FS_1913 >> 8u) & 255u) : (FS_1913 & 255u));
                                        }
                                        FS_1951 = FS_1943;
                                    }
                                    FS_1956 = (FS_1951 < 80) ? FS_1951 : (-1);
                                }
                                bool FS_1957 = FS_1956 >= 0;
                                float FS_2203;
                                if (FS_1957)
                                {
                                    float3 FS_1964 = FS_455 - FS_35_m6[FS_1540].xyz;
                                    float FS_1965 = dot(FS_1964, FS_1964);
                                    float4 EIDShadowParams = FS_37_m11[FS_1956];
                                    float4 FS_1984 = mul(FS_37_m10[FS_1956], float4((FS_455 - ((FS_1964 * rsqrt(isnan(FS_1965) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? FS_1965 : max(1.1754943508222875079687365372222e-38f, FS_1965)))) * EIDShadowParams.x)) + (FS_473 * (EIDShadowParams.y * 5.0f)), 1.0f));
                                    float FS_1985 = FS_1984.w;
                                    float3 FS_1988 = FS_1984.xyz / FS_1985.xxx;
                                    float2 FS_1989 = FS_1988.xy;
                                    float3 FS_1997 = FS_1988.xyz;
                                    bool3 FS_1998 = bool3(FS_1997.x <= 0.0f.xxx.x, FS_1997.y <= 0.0f.xxx.y, FS_1997.z <= 0.0f.xxx.z);
                                    bool3 FS_1999 = bool3(FS_1997.x >= 1.0f.xxx.x, FS_1997.y >= 1.0f.xxx.y, FS_1997.z >= 1.0f.xxx.z);
                                    float FS_2002 = FS_1988.z;
                                    float2 FS_2013 = ((FS_1989 * (FS_37_m12[FS_1956].zw - FS_37_m12[FS_1956].xy)) + FS_37_m12[FS_1956].xy).xy * FS_37_m13.zw;
                                    float2 FS_2015 = floor(FS_2013 + 0.5f.xx);
                                    float2 FS_2016 = FS_2013 - FS_2015;
                                    float FS_2017 = FS_2016.x;
                                    float FS_2018 = FS_2017 + 0.5f;
                                    float FS_2019 = FS_2018 * FS_2018;
                                    float FS_2022 = 1.0f - FS_2017;
                                    float FS_2023 = isnan(0.0f) ? FS_2017 : (isnan(FS_2017) ? 0.0f : min(FS_2017, 0.0f));
                                    float FS_2026 = FS_2017 + 1.0f;
                                    float FS_2027 = isnan(0.0f) ? FS_2017 : (isnan(FS_2017) ? 0.0f : max(FS_2017, 0.0f));
                                    float FS_2038 = FS_2016.y;
                                    float FS_2039 = FS_2038 + 0.5f;
                                    float FS_2040 = FS_2039 * FS_2039;
                                    float FS_2043 = 1.0f - FS_2038;
                                    float FS_2044 = isnan(0.0f) ? FS_2038 : (isnan(FS_2038) ? 0.0f : min(FS_2038, 0.0f));
                                    float FS_2047 = FS_2038 + 1.0f;
                                    float FS_2048 = isnan(0.0f) ? FS_2038 : (isnan(FS_2038) ? 0.0f : max(FS_2038, 0.0f));
                                    float3 FS_2060 = float3(0.1599999964237213134765625f * FS_2022, 0.1599999964237213134765625f * ((FS_2026 - (FS_2027 * FS_2027)) + 1.0f), FS_2019 * 0.07999999821186065673828125f);
                                    float3 FS_2061 = float3(0.1599999964237213134765625f * ((FS_2019 * 0.5f) - FS_2017), 0.1599999964237213134765625f * ((FS_2022 - (FS_2023 * FS_2023)) + 1.0f), 0.1599999964237213134765625f * FS_2026) + FS_2060;
                                    float3 FS_2063 = float3(0.1599999964237213134765625f * FS_2043, 0.1599999964237213134765625f * ((FS_2047 - (FS_2048 * FS_2048)) + 1.0f), FS_2040 * 0.07999999821186065673828125f);
                                    float3 FS_2064 = float3(0.1599999964237213134765625f * ((FS_2040 * 0.5f) - FS_2038), 0.1599999964237213134765625f * ((FS_2043 - (FS_2044 * FS_2044)) + 1.0f), 0.1599999964237213134765625f * FS_2047) + FS_2063;
                                    float3 FS_2070 = ((FS_2060 / FS_2061) + float3(-2.5f, -0.5f, 1.5f)) * FS_37_m13.xxx;
                                    float3 FS_2072 = ((FS_2063 / FS_2064) + float3(-2.5f, -0.5f, 1.5f)) * FS_37_m13.yyy;
                                    float2 FS_2074 = FS_2015 * FS_37_m13.xy;
                                    float FS_2075 = FS_2070.x;
                                    float FS_2076 = FS_2072.x;
                                    float FS_2079 = FS_2070.y;
                                    float FS_2082 = FS_2070.z;
                                    float FS_2085 = FS_2072.y;
                                    float FS_2092 = FS_2072.z;
                                    float FS_2099 = FS_2061.x;
                                    float FS_2100 = FS_2064.x;
                                    float FS_2102 = FS_2061.y;
                                    float FS_2104 = FS_2061.z;
                                    float FS_2106 = FS_2064.y;
                                    float FS_2110 = FS_2064.z;
                                    float2 FS_2188 = 1.0f.xx - FS_1989;
                                    bool2 FS_2934 = isnan(FS_1989);
                                    bool2 FS_2935 = isnan(FS_2188);
                                    float2 FS_2936 = min(FS_1989, FS_2188);
                                    float2 FS_2937 = float2(FS_2934.x ? FS_2188.x : FS_2936.x, FS_2934.y ? FS_2188.y : FS_2936.y);
                                    float2 FS_2189 = float2(FS_2935.x ? FS_1989.x : FS_2937.x, FS_2935.y ? FS_1989.y : FS_2937.y);
                                    float FS_2190 = FS_2189.x;
                                    float FS_2191 = FS_2189.y;
                                    float FS_2192 = isnan(FS_2191) ? FS_2190 : (isnan(FS_2190) ? FS_2191 : min(FS_2190, FS_2191));
                                    float FS_2196 = (EIDShadowParams.z - FS_1985) * 0.25f;
                                    float FS_2198 = smoothstep(0.0f, 0.0500000007450580596923828125f, isnan(FS_2192) ? FS_2196 : (isnan(FS_2196) ? FS_2192 : min(FS_2196, FS_2192)));
                                    FS_2203 = FS_1957 ? lerp(1.0f, (any(bool3(FS_1998.x || FS_1999.x, FS_1998.y || FS_1999.y, FS_1998.z || FS_1999.z)) || ((asuint(FS_2002) & 2147483647u) > 2139095040u)) ? 1.0f : ((((((((((FS_2099 * FS_2100) * EIDShadowCompare(float3(FS_2074 + float2(FS_2075, FS_2076), FS_332).xy, FS_2002)) + ((FS_2102 * FS_2100) * EIDShadowCompare(float3(FS_2074 + float2(FS_2079, FS_2076), FS_332).xy, FS_2002))) + ((FS_2104 * FS_2100) * EIDShadowCompare(float3(FS_2074 + float2(FS_2082, FS_2076), FS_332).xy, FS_2002))) + ((FS_2099 * FS_2106) * EIDShadowCompare(float3(FS_2074 + float2(FS_2075, FS_2085), FS_332).xy, FS_2002))) + ((FS_2102 * FS_2106) * EIDShadowCompare(float3(FS_2074 + float2(FS_2079, FS_2085), FS_332).xy, FS_2002))) + ((FS_2104 * FS_2106) * EIDShadowCompare(float3(FS_2074 + float2(FS_2082, FS_2085), FS_332).xy, FS_2002))) + ((FS_2099 * FS_2110) * EIDShadowCompare(float3(FS_2074 + float2(FS_2075, FS_2092), FS_332).xy, FS_2002))) + ((FS_2102 * FS_2110) * EIDShadowCompare(float3(FS_2074 + float2(FS_2079, FS_2092), FS_332).xy, FS_2002))) + ((FS_2104 * FS_2110) * EIDShadowCompare(float3(FS_2074 + float2(FS_2082, FS_2092), FS_332).xy, FS_2002))), FS_1907 ? (isnan(FS_2198) ? EIDShadowParams.w : (isnan(EIDShadowParams.w) ? FS_2198 : min(EIDShadowParams.w, FS_2198))) : EIDShadowParams.w) : 1.0f;
                                }
                                else
                                {
                                    FS_2203 = clamp(dot(FS_462, FS_1741) + 1.0f, 0.0f, 1.0f);
                                }
                                FS_2204 = FS_2203;
                            }
                            else
                            {
                                FS_2204 = 1.0f;
                            }
                            float FS_2260;
                            float3 FS_2261;
                            float FS_2262;
                            float3 FS_2263;
                            float3 FS_2264;
                            [branch]
                            if (FS_1650 == 0u)
                            {
                                float3 FS_2240 = FS_35_m6[FS_1537].xyz * FS_1880;
                                float FS_2241 = FS_2240.x;
                                float FS_2242 = FS_2240.y;
                                float FS_2243 = FS_2240.z;
                                float FS_2244 = isnan(FS_2242) ? FS_2241 : (isnan(FS_2241) ? FS_2242 : max(FS_2241, FS_2242));
                                float FS_2246 = (isnan(FS_2243) ? FS_2244 : (isnan(FS_2244) ? FS_2243 : max(FS_2244, FS_2243))) * lerp(0.75f, 0.5f, FS_1434);
                                float3 FS_2253 = FS_1365.xyz;
                                FS_2260 = FS_1880;
                                FS_2261 = (FS_35_m6[FS_1537].xyz * ((1.0f - FS_35_m6[FS_1549].y) + ((1.0f / (isnan(FS_2246) ? 1.0f : (isnan(1.0f) ? FS_2246 : max(1.0f, FS_2246)))) * FS_35_m6[FS_1549].y))) * lerp(0.25f * FS_35_m6[FS_1549].x, 1.0f, clamp(FS_1900 + 0.5f, 0.0f, 1.0f));
                                FS_2262 = FS_1901;
                                FS_2263 = FS_2253;
                                FS_2264 = FS_2253;
                            }
                            else
                            {
                                bool FS_2209 = FS_1650 == 3u;
                                float FS_2235;
                                float3 FS_2236;
                                float3 FS_2237;
                                if (FS_2209)
                                {
                                    FS_2235 = clamp(dot(FS_1150, -normalize(cross(FS_507, cross(FS_507, FS_1741)))), 0.0f, 1.0f);
                                    FS_2236 = lerp(0.5f.xxx, FS_1156, FS_35_m6[FS_1549].y.xxx);
                                    FS_2237 = 0.0f.xxx;
                                }
                                else
                                {
                                    bool FS_2213 = FS_1650 == 1u;
                                    float FS_2223;
                                    float3 FS_2224;
                                    if (FS_2213)
                                    {
                                        FS_2223 = clamp(clamp(FS_1900 + FS_35_m6[FS_1549].x, -1.0f, 1.0f), 0.0f, 1.0f) * FS_2204;
                                        FS_2224 = FS_1157 * FS_35_m6[FS_1549].y;
                                    }
                                    else
                                    {
                                        FS_2223 = FS_1901;
                                        FS_2224 = 0.0f.xxx;
                                    }
                                    bool3 FS_2225 = FS_2213.xxx;
                                    FS_2235 = FS_2223;
                                    FS_2236 = float3(FS_2225.x ? FS_1156.x : 0.0f.xxx.x, FS_2225.y ? FS_1156.y : 0.0f.xxx.y, FS_2225.z ? FS_1156.z : 0.0f.xxx.z);
                                    FS_2237 = FS_2224;
                                }
                                FS_2260 = FS_2209 ? 0.0f : FS_1880;
                                FS_2261 = FS_35_m6[FS_1537].xyz;
                                FS_2262 = FS_2235;
                                FS_2263 = FS_2236;
                                FS_2264 = FS_2237;
                            }
                            FS_2271 = FS_1501 + (((FS_2261 * FS_2260) * lerp(FS_2264, FS_2263, FS_2262.xxx)) * FS_1406);
                        }
                        else
                        {
                            FS_2271 = FS_1501;
                        }
                        FS_2272 = FS_2271;
                        return;
                    }

void EIDEarlyExit1(inout float3 FS_1150, inout float3 FS_1156, inout float3 FS_1157, inout float4 FS_1365, inout float FS_1406, inout float FS_1434, inout float3 FS_1501, inout int FS_1537, inout int FS_1540, inout int FS_1543, inout int FS_1546, inout int FS_1549, inout int FS_1555, inout int FS_1558, inout uint FS_1562, inout float FS_1637, inout float3 FS_2273, inout float3 FS_455, inout float3 FS_462, inout float3 FS_473, inout float3 FS_507)
{
                    uint FS_1650 = asuint(FS_35_m6[FS_1546].w);
                    if ((FS_1650 == 16u) || ((FS_35_m6[FS_1546].z + FS_19_m91.z) < 0.5f))
                    {
                        FS_2273 = FS_1501;
                        return;
                    }
                    bool FS_1662 = (uint(FS_35_m6[FS_1537].w) & 1u) == 0u;
                    bool FS_1666 = (!FS_1662) && (FS_35_m6[FS_1543].z > 0.0f);
                    bool FS_1667 = FS_1650 == 4u;
                    float FS_1668 = float(FS_1662);
                    float FS_1676 = (0.5f + (0.5f * FS_35_m6[FS_1543].y)) - abs(FS_35_m6[FS_1543].x);
                    float FS_1677 = FS_35_m6[FS_1543].y - FS_1676;
                    float FS_1681 = (1.0f - abs(FS_1676)) - abs(FS_1677);
                    float FS_1684 = abs(isnan(0.00048828125f) ? FS_1681 : (isnan(FS_1681) ? 0.00048828125f : max(FS_1681, 0.00048828125f)));
                    float3 FS_1688 = normalize(float3(FS_1676, FS_1677, (FS_35_m6[FS_1543].x >= 0.0f) ? FS_1684 : (-FS_1684)));
                    float FS_1691 = 2.0f * FS_35_m6[FS_1549].y;
                    float FS_1694 = lerp(FS_35_m6[FS_1555].w, isnan(0.100000001490116119384765625f) ? FS_1691 : (isnan(FS_1691) ? 0.100000001490116119384765625f : max(FS_1691, 0.100000001490116119384765625f)), float(FS_1667));
                    float3 FS_1699 = FS_35_m6[FS_1540].xyz - FS_455;
                    float3 FS_1700 = -FS_1688;
                    float3 FS_1705 = lerp(FS_1699, FS_1700 * dot(FS_1699, FS_1700), (float(FS_1667 && (FS_35_m6[FS_1549].z > 0.5f)) * FS_1668).xxx);
                    float FS_1706 = dot(FS_1705, FS_1705);
                    float FS_1707 = rsqrt(FS_1706);
                    float3 FS_1708 = FS_1705 * FS_1707;
                    float3 FS_1741;
                    float FS_1742;
                    if (FS_1666)
                    {
                        float3 FS_1712 = (FS_1688 * FS_35_m6[FS_1543].z) * 0.5f;
                        float3 FS_1713 = FS_1705 - FS_1712;
                        float3 FS_1714 = FS_1705 + FS_1712;
                        float FS_1715 = length(FS_1713);
                        float FS_1716 = length(FS_1714);
                        float3 FS_1725 = normalize(cross(cross(FS_1688, FS_1708), FS_1688));
                        FS_1741 = FS_1725;
                        FS_1742 = ((1.0f / ((((FS_1715 * FS_1716) + dot(FS_1713, FS_1714)) * 0.5f) + 1.0f)) * clamp(0.5f * ((dot(FS_1725, FS_1713) / FS_1715) + (dot(FS_1725, FS_1714) / FS_1716)), 0.0f, 1.0f)) * (1.0f / clamp(1.0f + (0.5f * clamp(FS_35_m6[FS_1543].z * FS_1707, 0.0f, 1.0f)), 0.0f, 1.0f));
                    }
                    else
                    {
                        FS_1741 = FS_1708;
                        FS_1742 = 1.0f;
                    }
                    float FS_1764;
                    if (FS_1694 < 0.0f)
                    {
                        float FS_1758 = FS_1706 * (FS_35_m6[FS_1540].w * FS_35_m6[FS_1540].w);
                        float FS_1761 = clamp(1.0f - (FS_1758 * FS_1758), 0.0f, 1.0f);
                        FS_1764 = lerp(1.0f / (FS_1706 + 1.0f), FS_1742, float(FS_1666)) * (FS_1761 * FS_1761);
                    }
                    else
                    {
                        float3 FS_1747 = FS_1705 * FS_35_m6[FS_1540].w;
                        FS_1764 = FS_1742 * pow(1.0f - clamp(dot(FS_1747, FS_1747), 0.0f, 1.0f), FS_1694);
                    }
                    float FS_1769 = clamp((dot(FS_1741, FS_1700) - FS_35_m6[FS_1543].z) * FS_35_m6[FS_1543].w, 0.0f, 1.0f);
                    float FS_1772 = FS_1764 * lerp(1.0f, FS_1769 * FS_1769, FS_1668);
                    int FS_1774 = int(FS_35_m6[FS_1558].w);
                    float FS_1879;
                    if ((!FS_1666) && (FS_1774 >= 0))
                    {
                        uint FS_1780 = uint(FS_1774);
                        float2 FS_1872;
                        [branch]
                        if (FS_1668 != 0.0f)
                        {
                            float4 FS_1862 = mul(FS_55_m1[FS_1780], float4(FS_455, 1.0f));
                            FS_1872 = FS_55_m0[FS_1780].xy + (clamp(FS_1862.xy / FS_1862.w.xx, 0.0f.xx, 1.0f.xx) * FS_55_m0[FS_1780].zw);
                        }
                        else
                        {
                            float3 FS_1795 = mul(float4(-FS_1705, 0.0f), FS_55_m1[FS_1780]).xyz;
                            float3 FS_340 = FS_1795;
                            float3 FS_339 = FS_1795;
                            float3 FS_338 = abs(FS_1795);
                            uint FS_1804 = uint(int(FS_338.y > FS_338.x));
                            uint FS_1810 = (FS_338.z > FS_338[FS_1804]) ? 2u : FS_1804;
                            uint FS_1816 = (FS_1810 * 2u) + uint(FS_339[FS_1810] < 0.0f);
                            float FS_1820 = abs(FS_340[FS_1816 / 2u]);
                            float FS_1840 = 0.5f - (0.000244140625f / FS_55_m0[FS_1780].w);
                            FS_1872 = FS_55_m0[FS_1780].xy + (clamp(float2((float(FS_1816) + ((((FS_340[uint(FS_312[FS_1816].x)] * FS_313[FS_1816].x) / FS_1820) * FS_1840) + 0.5f)) * 0.16666667163372039794921875f, 0.5f - (((FS_340[uint(FS_312[FS_1816].y)] * FS_313[FS_1816].y) / FS_1820) * FS_1840)), 0.0f.xx, 1.0f.xx) * FS_55_m0[FS_1780].zw);
                        }
                        FS_1879 = FS_1772 * FS_61.SampleLevel(sampler_LinearRepeat, FS_1872, 0.0f).x;
                    }
                    else
                    {
                        FS_1879 = FS_1772;
                    }
                    float FS_1880 = FS_1879 * FS_1637;
                    float3 FS_2272;
                    EIDEarlyExit0(FS_1150, FS_1156, FS_1157, FS_1365, FS_1406, FS_1434, FS_1501, FS_1537, FS_1540, FS_1543, FS_1546, FS_1549, FS_1562, FS_1650, FS_1662, FS_1667, FS_1741, FS_1880, FS_2272, FS_455, FS_462, FS_473, FS_507);
                    FS_2273 = FS_2272;
                    return;
                }
void FSfrag_main()
{
    float FS_351 = 1.0f / FSgl_FragCoord.w;
    float3 FS_366 = lerp(-FS_4, float3(FS_17_m0[2u].x, FS_17_m0[2u].y, FS_17_m0[2u].z), FS_19_m4.w.xxx);
    float FS_367 = dot(FS_366, FS_366);
    float FS_369 = rsqrt(isnan(9.9999999392252902907785028219223e-09f) ? FS_367 : (isnan(FS_367) ? 9.9999999392252902907785028219223e-09f : max(FS_367, 9.9999999392252902907785028219223e-09f)));
    float3 FS_370 = FS_366 * FS_369;
    float FS_371 = FS_367 * FS_369;
    uint FS_374 = asuint(FSGetInstance(FS_12)._m2.x);
    bool FS_379 = (asuint(FSGetInstance(FS_12)._m1.w) & 16u) != 0u;
    float4 FS_396;
    float4 FS_397;
    float4 FS_398;
    if (FS_379)
    {
        FS_396 = asfloat(FS_31.Load4((FS_374 + 2u) * 16 + 0));
        FS_397 = asfloat(FS_31.Load4((FS_374 + 1u) * 16 + 0));
        FS_398 = asfloat(FS_31.Load4(FS_374 * 16 + 0));
    }
    else
    {
        FS_396 = FSGetInstance(FS_12)._m0[2];
        FS_397 = FSGetInstance(FS_12)._m0[1];
        FS_398 = FSGetInstance(FS_12)._m0[0];
    }
    float2 FS_399 = frac(FS_3);
    float2 FS_400 = FS_399 - 0.5f.xx;
    float FS_401 = dot(FS_400, FS_400);
    float FS_402 = step(0.25f, FS_401);
    float FS_404 = 1.0f / length(FS_5);
    float3 FS_410 = cross(FS_5, FS_6.xyz);
    float4 FS_431 = FS4817_51.SampleBias(sampler_PointRepeat, FS_3 - (((normalize(mul(float3x3(FS_6.xyz * FS_404, (FS_410 * ((FS_6.w > 0.0f) ? 1.0f : (-1.0f))) * FS_404, FS_5 * FS_404), FS_370)).xy * FS_48_m31) * float2(1.0f, 0.25f)) * smoothstep(0.25f, 0.0500000007450580596923828125f, FS_401)), FS_19_m16);
    float4 test=FS_431;
    float3 FS_436 = FS_431.xyz * FS_48_m24.xyz;
    float FS_442 = FS_431.w * FS_48_m24.w;
    float3 FS_447 = FS_436 * FS_48_m18;
    float3 FS_451 = lerp(dot(FS_447, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, FS_447, FS_48_m19.xxx);
    float3 FS_455 = FS_4 + FS_17_m11.xyz;
    float3 FS_460 = FS_455 - float3(FS_398.w, FS_335, FS_396.w);
    FS_460.y = 6.103515625e-05f;
    float3 FS_462 = normalize(FS_460);
    float3x3 FS_467 = float3x3(FS_6.xyz * 1.0f, (FS_410 * FS_6.w) * 1.0f, FS_5 * 1.0f);
    float3 FS_473 = normalize(FS_5) * (FSgl_FrontFacing ? 1.0f : ((-1.0f) + (2.0f * FS_48_m5)));
    float2 FS_478 = (FS_399 * 2.0f) - 1.0f.xx;
    float2 FS_480 = FS_478.xy;
    float FS_484 = sqrt(1.0f - clamp(dot(FS_480, FS_480), 0.0f, 1.0f));
    float3 FS_486 = float3(FS_478.x, FS_478.y, FS_333.z);
    FS_486.z = isnan(FS_484) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? FS_484 : max(1.000000016862383526387164645044e-16f, FS_484));
    float2 FS_488 = FS_486.xy * (-FS_48_m39);
    float3 FS_489 = float3(FS_488.x, FS_488.y, FS_486.z);
    float3 FS_494 = normalize(mul(lerp(FS_489 * float3(-0.125f, -0.125f, 1.0f), float3(0.0f, 0.0f, 1.0f), FS_402.xxx), FS_467));
    uint2 FS_497 = uint2(FSgl_FragCoord.xy);
    float3 FS_507 = mul(float3x3(FS_17_m1[0].xyz, FS_17_m1[1].xyz, FS_17_m1[2].xyz), float3(0.0f, 0.0f, 1.0f));
    float4 FS_521 = float4(FS_335, FS_335, FS_335, float((asuint((FS_19_m89.x > 0.5f) ? FS_19_m89.y : FSGetInstance(FS_12)._m7.x) >> 24u) & 255u)) * 0.0039215688593685626983642578125f.xxxx;
    float FS_522 = FS_521.w;
    float FS_530 = lerp(FS_19_m22.x, 1.0f, FS_19_m91.w) * FS_19_m20.x;
    float FS_532 = FS_494.z;
    float3 FS_534 = normalize(float3(FS_494.x, 6.103515625e-05f, FS_532));
    float4 FS_1028;
    float3 FS_1029;
    float3 FS_1030;
    float FS_1031;
    if (FS_19_m80.y < 0.5f)
    {
        float3 FS_552 = FS_455 - (FS_19_m105.xyz + (FS_507 * (-FS_19_m107.w)));
        float FS_554 = abs(FS_552.x);
        float FS_556 = abs(FS_552.z);
        float FS_562 = clamp(((isnan(FS_556) ? FS_554 : (isnan(FS_554) ? FS_556 : max(FS_554, FS_556))) - 464.0f) * 0.03125f, 0.0f, 1.0f);
        float FS_565 = clamp((abs(FS_552.y) - 208.0f) * 0.03125f, 0.0f, 1.0f);
        float FS_566 = isnan(FS_565) ? FS_562 : (isnan(FS_562) ? FS_565 : max(FS_562, FS_565));
        float4 FS_868;
        float4 FS_869;
        float4 FS_870;
        float FS_871;
        float FS_872;
        if ((FS_19_m105.w != 0.0f) && (FS_566 < 1.0f))
        {
            float3 FS_579 = FS_455 - (FS_19_m105.xyz + (FS_507 * (-FS_19_m107.y)));
            float FS_581 = abs(FS_579.x);
            float FS_583 = abs(FS_579.z);
            float FS_589 = clamp(((isnan(FS_583) ? FS_581 : (isnan(FS_581) ? FS_583 : max(FS_581, FS_583))) - 29.0f) * 0.5f, 0.0f, 1.0f);
            float FS_592 = clamp((abs(FS_579.y) - 13.0f) * 0.5f, 0.0f, 1.0f);
            float FS_593 = isnan(FS_592) ? FS_589 : (isnan(FS_589) ? FS_592 : max(FS_589, FS_592));
            float FS_669;
            float4 FS_670;
            float4 FS_671;
            float4 FS_672;
            if (FS_593 < 1.0f)
            {
                float3 FS_602 = ((FS_455 * 2.0f) + 0.5f.xxx) * FS_19_m106.xyz;
                float3 FS_604 = FS_602 - floor(FS_602);
                float4 FS_608 = FS_42.SampleLevel(sampler_PointRepeat, FS_604, 0.0f);
                float FS_609 = 1.0f - FS_593;
                float FS_613 = FS_19_m106.y * 0.5f;
                float FS_618 = FS_604.x;
                float FS_619 = clamp(FS_604.y, FS_613, 1.0f - FS_613) * 0.3333333432674407958984375f;
                float FS_620 = FS_604.z;
                float4 FS_623 = FS_43.SampleLevel(sampler_LinearRepeat, float3(FS_618, FS_619, FS_620), 0.0f);
                float FS_639 = FS_608.x;
                float FS_649 = FS_608.y;
                float FS_659 = FS_608.z;
                FS_669 = FS_566 + (FS_623.w * FS_609);
                FS_670 = float4(((FS_43.SampleLevel(sampler_LinearRepeat, float3(FS_618, FS_619 + 0.666666686534881591796875f, FS_620), 0.0f).xyz * 4.0f) - 2.0f.xxx) * FS_659, FS_659) * FS_609;
                FS_671 = float4(((FS_43.SampleLevel(sampler_LinearRepeat, float3(FS_618, FS_619 + 0.3333333432674407958984375f, FS_620), 0.0f).xyz * 4.0f) - 2.0f.xxx) * FS_649, FS_649) * FS_609;
                FS_672 = float4(((FS_623.xyz * 4.0f) - 2.0f.xxx) * FS_639, FS_639) * FS_609;
            }
            else
            {
                FS_669 = FS_566;
                FS_670 = 0.0f.xxxx;
                FS_671 = 0.0f.xxxx;
                FS_672 = 0.0f.xxxx;
            }
            float3 FS_678 = FS_455 - (FS_19_m105.xyz + (FS_507 * (-FS_19_m107.z)));
            float FS_680 = abs(FS_678.x);
            float FS_682 = abs(FS_678.z);
            float FS_688 = clamp(((isnan(FS_682) ? FS_680 : (isnan(FS_680) ? FS_682 : max(FS_680, FS_682))) - 116.0f) * 0.125f, 0.0f, 1.0f);
            float FS_691 = clamp((abs(FS_678.y) - 52.0f) * 0.125f, 0.0f, 1.0f);
            float FS_692 = isnan(FS_691) ? FS_688 : (isnan(FS_688) ? FS_691 : max(FS_688, FS_691));
            float FS_772;
            float4 FS_773;
            float4 FS_774;
            float4 FS_775;
            if (FS_692 < 1.0f)
            {
                float3 FS_701 = ((FS_455 * 0.5f) + 0.5f.xxx) * FS_19_m106.xyz;
                float3 FS_703 = FS_701 - floor(FS_701);
                float4 FS_707 = FS_44.SampleLevel(sampler_PointRepeat, FS_703, 0.0f);
                float FS_709 = FS_593 * (1.0f - FS_692);
                float FS_713 = FS_19_m106.y * 0.5f;
                float FS_718 = FS_703.x;
                float FS_719 = clamp(FS_703.y, FS_713, 1.0f - FS_713) * 0.3333333432674407958984375f;
                float FS_720 = FS_703.z;
                float4 FS_723 = FS_45.SampleLevel(sampler_LinearRepeat, float3(FS_718, FS_719, FS_720), 0.0f);
                float FS_739 = FS_707.x;
                float FS_750 = FS_707.y;
                float FS_761 = FS_707.z;
                FS_772 = FS_669 + (FS_723.w * FS_709);
                FS_773 = FS_670 + (float4(((FS_45.SampleLevel(sampler_LinearRepeat, float3(FS_718, FS_719 + 0.666666686534881591796875f, FS_720), 0.0f).xyz * 4.0f) - 2.0f.xxx) * FS_761, FS_761) * FS_709);
                FS_774 = FS_671 + (float4(((FS_45.SampleLevel(sampler_LinearRepeat, float3(FS_718, FS_719 + 0.3333333432674407958984375f, FS_720), 0.0f).xyz * 4.0f) - 2.0f.xxx) * FS_750, FS_750) * FS_709);
                FS_775 = FS_672 + (float4(((FS_723.xyz * 4.0f) - 2.0f.xxx) * FS_739, FS_739) * FS_709);
            }
            else
            {
                FS_772 = FS_669;
                FS_773 = FS_670;
                FS_774 = FS_671;
                FS_775 = FS_672;
            }
            float4 FS_858;
            float4 FS_859;
            float4 FS_860;
            float FS_861;
            if (FS_692 > 0.0f)
            {
                float3 FS_784 = ((FS_455 * 0.125f) + 0.5f.xxx) * FS_19_m106.xyz;
                float3 FS_787 = FS_19_m106.xyz * 0.5f;
                float3 FS_789 = clamp(FS_784 - floor(FS_784), FS_787, 1.0f.xxx - FS_787);
                float4 FS_793 = FS_46.SampleLevel(sampler_PointRepeat, FS_789, 0.0f);
                float FS_795 = FS_692 * (1.0f - FS_566);
                float FS_799 = FS_19_m106.y * 0.5f;
                float FS_804 = FS_789.x;
                float FS_805 = clamp(FS_789.y, FS_799, 1.0f - FS_799) * 0.3333333432674407958984375f;
                float FS_806 = FS_789.z;
                float4 FS_809 = FS_47.SampleLevel(sampler_LinearRepeat, float3(FS_804, FS_805, FS_806), 0.0f);
                float FS_825 = FS_793.x;
                float FS_836 = FS_793.y;
                float FS_847 = FS_793.z;
                FS_858 = FS_773 + (float4(((FS_47.SampleLevel(sampler_LinearRepeat, float3(FS_804, FS_805 + 0.666666686534881591796875f, FS_806), 0.0f).xyz * 4.0f) - 2.0f.xxx) * FS_847, FS_847) * FS_795);
                FS_859 = FS_774 + (float4(((FS_47.SampleLevel(sampler_LinearRepeat, float3(FS_804, FS_805 + 0.3333333432674407958984375f, FS_806), 0.0f).xyz * 4.0f) - 2.0f.xxx) * FS_836, FS_836) * FS_795);
                FS_860 = FS_775 + (float4(((FS_809.xyz * 4.0f) - 2.0f.xxx) * FS_825, FS_825) * FS_795);
                FS_861 = FS_772 + (FS_809.w * FS_795);
            }
            else
            {
                FS_858 = FS_773;
                FS_859 = FS_774;
                FS_860 = FS_775;
                FS_861 = FS_772;
            }
            float FS_864 = clamp((FS_861 * 2.0f) - 1.0f, 0.0f, 1.0f);
            FS_868 = FS_858;
            FS_869 = FS_859;
            FS_870 = FS_860;
            FS_871 = FS_864 - FS_566;
            FS_872 = (FS_864 + FS_566) * 0.5f;
        }
        else
        {
            FS_868 = 0.0f.xxxx;
            FS_869 = 0.0f.xxxx;
            FS_870 = 0.0f.xxxx;
            FS_871 = 0.0f;
            FS_872 = 1.0f;
        }
        float4 FS_892 = FS_870 + float4(FS_19_m108.x * FS_872, (FS_19_m108.y * FS_872) + ((FS_19_m108.w * FS_871) * 0.5f), FS_19_m108.z * FS_872, (FS_19_m108.w * FS_872) + ((FS_19_m108.y * FS_871) * 0.375f));
        float4 FS_912 = FS_869 + float4(FS_19_m109.x * FS_872, (FS_19_m109.y * FS_872) + ((FS_19_m109.w * FS_871) * 0.5f), FS_19_m109.z * FS_872, (FS_19_m109.w * FS_872) + ((FS_19_m109.y * FS_871) * 0.375f));
        float4 FS_932 = FS_868 + float4(FS_19_m110.x * FS_872, (FS_19_m110.y * FS_872) + ((FS_19_m110.w * FS_871) * 0.5f), FS_19_m110.z * FS_872, (FS_19_m110.w * FS_872) + ((FS_19_m110.y * FS_871) * 0.375f));
        float4 FS_936 = float4(FS_534, 1.0f);
        float3 FS_940 = float3(dot(FS_892, FS_936), dot(FS_912, FS_936), dot(FS_932, FS_936));
        bool3 FS_2749 = isnan(FS_940);
        bool3 FS_2750 = isnan(0.0f.xxx);
        float3 FS_2751 = max(FS_940, 0.0f.xxx);
        float3 FS_2752 = float3(FS_2749.x ? 0.0f.xxx.x : FS_2751.x, FS_2749.y ? 0.0f.xxx.y : FS_2751.y, FS_2749.z ? 0.0f.xxx.z : FS_2751.z);
        float3 FS_942 = float3(FS_2750.x ? FS_940.x : FS_2752.x, FS_2750.y ? FS_940.y : FS_2752.y, FS_2750.z ? FS_940.z : FS_2752.z) * FS_530;
        float3 FS_950 = ((FS_892.xyz * 0.2125999927520751953125f) + (FS_912.xyz * 0.715200006961822509765625f)) + (FS_932.xyz * 0.072200000286102294921875f);
        float FS_951 = dot(FS_950, FS_950);
        float3 FS_954 = FS_950 * rsqrt(isnan(FS_951) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? FS_951 : max(1.1754943508222875079687365372222e-38f, FS_951)));
        float FS_956 = abs(FS_954.y);
        float3 FS_957 = FS_954;
        FS_957.y = FS_956;
        float4 FS_959 = float4(FS_957.x, FS_957.y, FS_957.z, 0.0f.xxxx.w);
        FS_959.w = 1.0f;
        float4 FS_962 = float4(FS_954.x, FS_956, FS_954.z, 1.0f);
        float3 FS_966 = float3(dot(FS_892, FS_962), dot(FS_912, FS_962), dot(FS_932, FS_962));
        bool3 FS_2759 = isnan(FS_966);
        bool3 FS_2760 = isnan(0.0f.xxx);
        float3 FS_2761 = max(FS_966, 0.0f.xxx);
        float3 FS_2762 = float3(FS_2759.x ? 0.0f.xxx.x : FS_2761.x, FS_2759.y ? 0.0f.xxx.y : FS_2761.y, FS_2759.z ? 0.0f.xxx.z : FS_2761.z);
        float3 FS_967 = float3(FS_2760.x ? FS_966.x : FS_2762.x, FS_2760.y ? FS_966.y : FS_2762.y, FS_2760.z ? FS_966.z : FS_2762.z);
        float FS_968 = FS_967.x;
        float FS_969 = FS_967.y;
        float FS_970 = FS_967.z;
        float FS_971 = isnan(FS_969) ? FS_968 : (isnan(FS_968) ? FS_969 : max(FS_968, FS_969));
        float FS_972 = isnan(FS_970) ? FS_971 : (isnan(FS_971) ? FS_970 : max(FS_971, FS_970));
        float FS_975 = FS_942.z;
        float FS_976 = FS_942.y;
        float4 FS_981 = lerp(float4(FS_975, FS_976, -1.0f, 0.666666686534881591796875f), float4(FS_976, FS_975, 0.0f, -0.3333333432674407958984375f), step(FS_975, FS_976).xxxx);
        float FS_982 = FS_942.x;
        float FS_983 = FS_981.x;
        float4 FS_991 = lerp(float4(FS_983, FS_981.yw, FS_982), float4(FS_982, FS_981.yz, FS_983), step(FS_983, FS_982).xxxx);
        float FS_992 = FS_991.x;
        float FS_993 = FS_991.w;
        float FS_994 = FS_991.y;
        float FS_996 = FS_992 - (isnan(FS_994) ? FS_993 : (isnan(FS_993) ? FS_994 : min(FS_993, FS_994)));
        float FS_1005 = FS_996 / (FS_992 + 9.9999997473787516355514526367188e-05f);
        float FS_1006 = frac(abs(FS_991.z + ((FS_993 - FS_994) / ((6.0f * FS_996) + 9.9999997473787516355514526367188e-05f))));
        float FS_1012 = lerp(0.699999988079071044921875f, 0.3499999940395355224609375f, smoothstep(0.449999988079071044921875f, 0.3499999940395355224609375f, abs(FS_1006 - 0.5f))) * clamp(FS_992, 0.0f, 1.0f);
        float FS_1013 = isnan(FS_1012) ? FS_1005 : (isnan(FS_1005) ? FS_1012 : min(FS_1005, FS_1012));
        float FS_1015 = 2.0f / (2.0f - FS_1013);
        FS_1028 = FS_959;
        FS_1029 = FS_942;
        FS_1030 = lerp(1.0f.xxx, clamp(abs((frac(float3(FS_1006, FS_1013, FS_1015).xxx + float3(1.0f, 0.666666686534881591796875f, 0.3333333432674407958984375f)) * 6.0f) - 3.0f.xxx) - 1.0f.xxx, 0.0f.xxx, 1.0f.xxx), FS_1013.xxx) * FS_1015;
        FS_1031 = (isnan(0.0f) ? FS_972 : (isnan(FS_972) ? 0.0f : max(FS_972, 0.0f))) * FS_530;
    }
    else
    {
        FS_1028 = 0.0f.xxxx;
        FS_1029 = 1.0f.xxx;
        FS_1030 = FS_19_m81.xyz;
        FS_1031 = FS_530;
    }
    float3 FS_1150;
    float3 FS_1151;
    float3 FS_1152;
    float FS_1153;
    [branch]
    if (FS_522 > 0.00999999977648258209228515625f)
    {
        bool3 FS_1050 = FS_379.xxx;
        float3 FS_1052 = FS_10.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 FS_1053 = float3(FS_1050.x ? FS_1052.x : FS_10.x, FS_1050.y ? FS_1052.y : FS_10.y, FS_1050.z ? FS_1052.z : FS_10.z);
        float3 FS_1056 = FS_1053 * FS_19_m89.z;
        float3 FS_1060 = abs(float3(FS_1050.x ? FS_9.xzy.x : FS_9.x, FS_1050.y ? FS_9.xzy.y : FS_9.y, FS_1050.z ? FS_9.xzy.z : FS_9.z)) - 0.20000000298023223876953125f.xxx;
        float3 FS_1062 = (FS_1060 * FS_1060) * FS_1060;
        bool3 FS_2789 = isnan(FS_1062);
        bool3 FS_2790 = isnan(6.103515625e-05f.xxx);
        float3 FS_2791 = max(FS_1062, 6.103515625e-05f.xxx);
        float3 FS_2792 = float3(FS_2789.x ? 6.103515625e-05f.xxx.x : FS_2791.x, FS_2789.y ? 6.103515625e-05f.xxx.y : FS_2791.y, FS_2789.z ? 6.103515625e-05f.xxx.z : FS_2791.z);
        float3 FS_1063 = float3(FS_2790.x ? FS_1062.x : FS_2792.x, FS_2790.y ? FS_1062.y : FS_2792.y, FS_2790.z ? FS_1062.z : FS_2792.z);
        float3 FS_1066 = FS_1063 / dot(FS_1063, 1.0f.xxx).xxx;
        float FS_1096 = clamp(FS_522 + (smoothstep(0.3499999940395355224609375f, 0.20000000298023223876953125f, FS_1053.y) * clamp(FS_522 * 3.0f, 0.0f, 1.0f)), 0.0f, 1.0f);
        float FS_1101 = smoothstep(2.0f - FS_1096, 2.349999904632568359375f - FS_1096, 0.0f) * float(FSgl_FrontFacing);
        float3 FS_1103 = FS_1101.xxx;
        float2 FS_1109 = ((((FS_54.SampleBias(sampler_PointRepeat, FS_1056.xz, FS_19_m16) * FS_1066.y) + (FS_54.SampleBias(sampler_PointRepeat, FS_1056.xy, FS_19_m16) * FS_1066.z)) + (FS_54.SampleBias(sampler_PointRepeat, FS_1056.zy, FS_19_m16) * FS_1066.x)).xy * 2.0f) - 1.0f.xx;
        float2 FS_1111 = FS_1109.xy;
        float FS_1115 = sqrt(1.0f - clamp(dot(FS_1111, FS_1111), 0.0f, 1.0f));
        float3 FS_1117 = float3(FS_1109.x, FS_1109.y, FS_333.z);
        FS_1117.z = isnan(FS_1115) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? FS_1115 : max(1.000000016862383526387164645044e-16f, FS_1115));
        float2 FS_1119 = FS_1117.xy * 2.0f;
        float3 FS_1121 = lerp(float3(0.0f, 0.0f, 1.0f), float3(FS_1119.x, FS_1119.y, FS_1117.z), FS_1103);
        float FS_1122 = dot(FS_1121, FS_1121);
        float3 FS_1125 = FS_1121 * rsqrt(isnan(FS_1122) ? 6.103515625e-05f : (isnan(6.103515625e-05f) ? FS_1122 : max(6.103515625e-05f, FS_1122)));
        float FS_1126 = FS_494.y;
        float FS_1129 = step(0.00999999977648258209228515625f, 1.0f - (FS_1126 * FS_1126));
        float FS_1132 = lerp(FS_532, FS_1126, FS_1129);
        float FS_1134 = 1.0f - (FS_1132 * FS_1132);
        float3 FS_1139 = (float3(0.0f, FS_1129, 1.0f - FS_1129) - (FS_494 * FS_1132)) * rsqrt(isnan(FS_1134) ? 9.9999997473787516355514526367188e-05f : (isnan(9.9999997473787516355514526367188e-05f) ? FS_1134 : max(9.9999997473787516355514526367188e-05f, FS_1134)));
        FS_1150 = ((cross(FS_1139, FS_494) * FS_1125.x) + (FS_1139 * FS_1125.y)) + (FS_494 * FS_1125.z);
        FS_1151 = lerp(FS_451 * 1.0f, 0.3079999983310699462890625f.xxx, FS_1103);
        FS_1152 = lerp(FS_436 * 1.0f, 0.87999999523162841796875f.xxx, FS_1103);
        FS_1153 = lerp(FS_48_m2, 0.0f, FS_1101);
    }
    else
    {
        FS_1150 = FS_494;
        FS_1151 = FS_451;
        FS_1152 = FS_436;
        FS_1153 = FS_48_m2;
    }
    float FS_1155 = 0.959999978542327880859375f - (FS_1153 * 0.959999978542327880859375f);
    float3 FS_1156 = FS_1152 * FS_1155;
    float3 FS_1157 = FS_1151 * FS_1155;
    float2 FS_1170 = (FS_7.xy / (isnan(9.9999999392252902907785028219223e-09f) ? FS_7.z : (isnan(FS_7.z) ? 9.9999999392252902907785028219223e-09f : max(FS_7.z, 9.9999999392252902907785028219223e-09f))).xx) - (FS_8.xy / (isnan(9.9999999392252902907785028219223e-09f) ? FS_8.z : (isnan(FS_8.z) ? 9.9999999392252902907785028219223e-09f : max(FS_8.z, 9.9999999392252902907785028219223e-09f))).xx);
    float2 FS_1173 = FS_1170;
    FS_1173.y = -FS_1170.y;
    float2 FS_1183 = ((sqrt(sqrt(abs(FS_1173 * 0.5f))) * float2(int2(sign(FS_1173)))) * 0.5f) + 0.5f.xx;
    float4 FS_1185 = float4(FS_1183.x, FS_1183.y, 0.0f.xxxx.z, 0.0f.xxxx.w);
    FS_1185.z = 1.0f;
    float4 FS_1186 = FS_1185;
    FS_1186.w = 0.4000000059604644775390625f;
    float3 FS_1197 = lerp(-FS_35_m0.xyz, FS_19_m90.xyz, FS_19_m80.w.xxx);
    float3 FS_1201 = normalize(float3(FS_1197.x, 6.103515625e-05f, FS_1197.z));
    float3 FS_1211 = lerp(FS_35_m3.xyz, FS_19_m84.xyz, FS_19_m91.y.xxx);
    float3 FS_1215 = FS_1211 * lerp(FS_35_m3.w, 1.0f, FS_19_m91.w);
    float3x3 FS_1220 = float3x3(FS_398.xyz, FS_397.xyz, FS_396.xyz);
    float3 FS_1221 = mul(FS_1197, FS_1220);
    float FS_1222 = dot(FS_1221, FS_1221);
    float3 FS_1227 = (FS_1221 * rsqrt(isnan(FS_1222) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? FS_1222 : max(1.1754943508222875079687365372222e-38f, FS_1222)))).xyz;
    FS_1227.y = 0.0f;
    float3 FS_1228 = mul(FS_1220, FS_1227);
    float FS_1229 = dot(FS_1228, FS_1228);
    int FS_1236 = int(FS_497.x);
    int FS_1237 = int(FS_497.y);
    float FS_1248 = lerp(lerp(1.0f, FS_40.Load(int3(int3(FS_1236, FS_1237, 0).xy, 0)).x, FS_37_m6.x), 1.0f, FS_19_m80.z);
    float3 FS_1256 = FS_1157 * FS_19_m79.z;
    float3 FS_1257 = FS_1256 * 0.64999997615814208984375f;
    float3 FS_1266 = FS_48_m37.xyz * FS_402;
    float3 FS_1273 = FS_48_m36.xyz * FS_442;
    float3 FS_1276 = FS_1156 * (((1.0f - FS_402).xxx + FS_1266) * ((1.0f - FS_442).xxx + FS_1273));
    float4 FS_1290 = FS4817_49.SampleLevel(sampler_LinearRepeat, float2((clamp(dot(FS_1150, (FS_1228 * rsqrt(isnan(FS_1229) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? FS_1229 : max(1.1754943508222875079687365372222e-38f, FS_1229)))).xyz) + (FS_19_m90.w * FS_19_m91.x), -1.0f, 1.0f) * 0.5f) + 0.5f, 0.5f), 0.0f);
    float FS_1291 = FS_1290.w;
    float FS_1293 = FS_1290.x;
    float FS_1294 = FS_1290.y;
    float FS_1295 = FS_1290.z;
    float FS_1296 = isnan(FS_1294) ? FS_1293 : (isnan(FS_1293) ? FS_1294 : max(FS_1293, FS_1294));
    float FS_1298 = isnan(FS_1294) ? FS_1293 : (isnan(FS_1293) ? FS_1294 : min(FS_1293, FS_1294));
    float FS_1300 = (isnan(FS_1295) ? FS_1296 : (isnan(FS_1296) ? FS_1295 : max(FS_1296, FS_1295))) - (isnan(FS_1295) ? FS_1298 : (isnan(FS_1298) ? FS_1295 : min(FS_1298, FS_1295)));
    float4 FS_1308 = FS4817_49.SampleLevel(sampler_LinearRepeat, float2((dot(FS_1150, FS_507) * 0.5f) + 0.5f, 0.5f), 0.0f);
    float FS_1309 = FS_1308.w;
    float FS_1314 = isnan(1.0f) ? 1.0f : (isnan(1.0f) ? 1.0f : min(1.0f, 1.0f));
    float FS_1315 = isnan(FS_1291) ? FS_1314 : (isnan(FS_1314) ? FS_1291 : min(FS_1314, FS_1291));
    float3 FS_1319 = ((clamp(dot(FS_534, FS_19_m85.xyz) + FS_19_m86.x, 0.0f, 1.0f) * FS_19_m86.y) + FS_19_m86.z).xxx * lerp(FS_1030, 1.0f.xxx, (FS_19_m80.y * FS_1315).xxx);
    float3 FS_1321 = FS_1315.xxx;
    float FS_1334 = lerp(0.64999997615814208984375f, 1.0f, FS_1031);
    float3 FS_1344 = FS_1248.xxx;
    float3 FS_1345 = lerp((FS_1319 * lerp(isnan(1.5f) ? FS_1334 : (isnan(FS_1334) ? 1.5f : min(FS_1334, 1.5f)), clamp(FS_1031, 1.25f, 1.75f), FS_19_m80.x)) * FS_19_m79.w, (lerp(dot(FS_1215, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, FS_1215, FS_1321) + ((FS_1319 * clamp(FS_1031, 0.0f, 1.5f)) * ((1.0f - FS_19_m91.y).xxx + (FS_1211 * FS_19_m91.y)))) * FS_19_m79.y, FS_1344);
    float3 FS_1346 = lerp(lerp(lerp(dot(FS_1257, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, FS_1257, 1.2000000476837158203125f.xxx), FS_1256, clamp(FS_1309 + FS_1291, 0.0f, 1.0f).xxx), FS_1276, FS_1321);
    float3 FS_1352 = FS_1346 * ((1.0f - FS_1300).xxx + (FS_1290.xyz * FS_1300));
    float FS_1353 = dot(FS_1352, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float3 FS_1361 = lerp(lerp(FS_1256, FS_1276, FS_1309.xxx), FS_1352 * clamp(dot(FS_1346, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)) * (1.0f / (isnan(0.001000000047497451305389404296875f) ? FS_1353 : (isnan(FS_1353) ? 0.001000000047497451305389404296875f : max(FS_1353, 0.001000000047497451305389404296875f)))), 0.0f, 1.5f), FS_1344);
    float4 FS_1365 = float4(FS_1361, FS_1248);
    float FS_1367 = lerp(FS_1309, FS_1315, FS_1248);
    float4 FS_1390 = FS4817_52.SampleBias(sampler_LinearRepeat, (normalize(mul(float3x3(FS_17_m0[0].xyz, FS_17_m0[1].xyz, FS_17_m0[2].xyz), mul(FS_489, FS_467))).xy * 0.5f) + 0.5f.xx, FS_19_m16);
    float FS_1406 = (1.0f - FS_48_m6) + (FS_442 * FS_48_m6);
    float3 FS_1408 = ((FS_1345 * FS_1361) * FS_1406) + (((FS_1390.xyz * FS_48_m42.w) + (FS_48_m42.xyz * FS_1390.w)) * ((FS_1345 * (((FS_1367 * 0.5f) + 0.5f) * lerp(FS_19_m79.z, 1.0f, FS_1367))) * 1.0f));
    float FS_1409 = dot(FS_1408, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float FS_1412 = clamp(FS_1409 - 0.5f, 0.0f, 0.5f);
    float FS_1417 = dot(FS_1201, FS_1150);
    float FS_1428 = dot(FS_370, FS_1150);
    float FS_1434 = 1.0f - FS_1248;
    float FS_1446 = isnan(FS_1029.y) ? FS_1029.x : (isnan(FS_1029.x) ? FS_1029.y : max(FS_1029.x, FS_1029.y));
    float FS_1448 = (isnan(FS_1029.z) ? FS_1446 : (isnan(FS_1446) ? FS_1029.z : max(FS_1446, FS_1029.z))) * 0.5f;
    bool3 FS_2884 = isnan(0.1500000059604644775390625f.xxx);
    bool3 FS_2885 = isnan(FS_1156);
    float3 FS_2886 = max(0.1500000059604644775390625f.xxx, FS_1156);
    float3 FS_2887 = float3(FS_2884.x ? FS_1156.x : FS_2886.x, FS_2884.y ? FS_1156.y : FS_2886.y, FS_2884.z ? FS_1156.z : FS_2886.z);
    float2 FS_1475 = float2(FS_497);
    float2 FS_1477 = floor(FS_1475 * 0.03125f);
    int FS_1485 = int((FS_1477.x + (FS_1477.y * FS_33_m5)) * 8.0f);
    float FS_1492 = floor(FS_351 - (FS_19_m3.y * FS_33_m11));
    float FS_1496 = clamp(FS_1492, 0.0f, FS_33_m7 - 1.0f);
    int FS_1498 = int(FS_1496 * 8.0f);
    float3 FS_1500;
    FS_1500 = (lerp(FS_1409.xxx, FS_1408, ((FS_1412 * FS_1412) + 1.0f).xxx) + ((((((lerp(FS_1029 * (1.0f / (isnan(1.0f) ? FS_1448 : (isnan(FS_1448) ? 1.0f : max(FS_1448, 1.0f)))), FS_1215, FS_1344) * clamp(lerp(dot(FS_1028.xyz, FS_1150) * FS_1028.w, ((-FS_1417) * ((FS_1417 * 0.5f) - 1.0f)) + 0.5f, FS_1248), 0.0f, 1.0f)) * ((FS_1434 + (clamp(-dot(FS_1201.xz, normalize(FS_507.xz)), 0.0f, 1.0f) * FS_1248)) * (1.0f - FS_19_m91.x))) * smoothstep(0.60000002384185791015625f, 0.800000011920928955078125f, 1.0f - abs(FS_1428))) * FS_1314) * (FS_1434 + (smoothstep(0.100000001490116119384765625f, 0.039999999105930328369140625f, dot(FS_1156, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f))) * FS_1248))) * float3(FS_2885.x ? 0.1500000059604644775390625f.xxx.x : FS_2887.x, FS_2885.y ? 0.1500000059604644775390625f.xxx.y : FS_2887.y, FS_2885.z ? 0.1500000059604644775390625f.xxx.z : FS_2887.z))) + ((((FS_1266 * FS_19_m92.y) + (FS_1273 * FS_19_m92.z)) + (FS_1152 * FS_19_m92.x)) * FS_1406);
    float3 FS_1501;
    [loop]
    for (int FS_1503 = 0; FS_1503 <= 7; FS_1500 = FS_1501, FS_1503++)
    {
        uint FS_1521 = (FS_1492 <= FS_1496) ? (FS_29.Load(uint(FS_1485 + FS_1503) * 4 + 0) & FS_29.Load(uint((FS_19_m21.y + FS_1498) + FS_1503) * 4 + 0)) : 0u;
        uint FS_1522 = uint(FS_1503);
        FS_1501 = FS_1500;
        uint FS_1527;
        float3 FS_1524;
        [loop]
        for (uint FS_1526 = FS_1521; FS_1526 != 0u; FS_1501 = FS_1524, FS_1526 = FS_1527)
        {
            uint FS_1531 = firstbitlow(FS_1526);
            FS_1527 = FS_1526 ^ (1u << (FS_1531 & 31u));
            int FS_1537 = int((32u * FS_1522) + FS_1531) * 8;
            int FS_1540 = FS_1537 + 1;
            int FS_1543 = FS_1537 + 2;
            int FS_1546 = FS_1537 + 3;
            int FS_1549 = FS_1537 + 4;
            int FS_1552 = FS_1537 + 5;
            int FS_1555 = FS_1537 + 6;
            int FS_1558 = FS_1537 + 7;
            uint FS_1562 = uint(FS_35_m6[FS_1552].w);
            float FS_1637;
            if ((FS_1562 & 1u) == 1u)
            {
                uint FS_1568 = asuint(FS_35_m6[FS_1552].x);
                uint FS_1575 = asuint(FS_35_m6[FS_1552].y);
                uint FS_1582 = asuint(FS_35_m6[FS_1552].z);
                uint FS_1589 = asuint(FS_35_m6[FS_1555].x);
                uint FS_1596 = asuint(FS_35_m6[FS_1555].y);
                uint FS_1603 = asuint(FS_35_m6[FS_1555].z);
                float3 FS_1622 = abs(mul(float4(FS_455 - FS_35_m6[FS_1540].xyz, 1.0f), float4x4(float4(spvUnpackHalf2x16(FS_1568).x, spvUnpackHalf2x16(FS_1582).x, spvUnpackHalf2x16(FS_1596).x, 0.0f), float4(spvUnpackHalf2x16(FS_1568 >> 16u).x, spvUnpackHalf2x16(FS_1582 >> 16u).x, spvUnpackHalf2x16(FS_1596 >> 16u).x, 0.0f), float4(spvUnpackHalf2x16(FS_1575).x, spvUnpackHalf2x16(FS_1589).x, spvUnpackHalf2x16(FS_1603).x, 0.0f), float4(spvUnpackHalf2x16(FS_1575 >> 16u).x, spvUnpackHalf2x16(FS_1589 >> 16u).x, spvUnpackHalf2x16(FS_1603 >> 16u).x, 0.0f))).xyz);
                float FS_1623 = FS_1622.x;
                float FS_1624 = FS_1622.y;
                float FS_1625 = isnan(FS_1624) ? FS_1623 : (isnan(FS_1623) ? FS_1624 : max(FS_1623, FS_1624));
                float FS_1626 = FS_1622.z;
                float FS_1629 = FS_35_m6[FS_1558].x * 0.5f;
                float FS_1635 = 1.0f - clamp(((isnan(FS_1626) ? FS_1625 : (isnan(FS_1625) ? FS_1626 : max(FS_1625, FS_1626))) - (FS_1629 + 0.5f)) / (0.5f - FS_1629), 0.0f, 1.0f);
                FS_1637 = FS_1635 * FS_1635;
            }
            else
            {
                FS_1637 = 1.0f;
            }
            if (false || (FS_1637 < 0.001000000047497451305389404296875f))
            {
                FS_1524 = FS_1501;
                continue;
            }
            float3 FS_2274;
            if (FS_35_m6[FS_1537].w < 1.5f)
            {
                float3 FS_2273;
                EIDEarlyExit1(FS_1150, FS_1156, FS_1157, FS_1365, FS_1406, FS_1434, FS_1501, FS_1537, FS_1540, FS_1543, FS_1546, FS_1549, FS_1555, FS_1558, FS_1562, FS_1637, FS_2273, FS_455, FS_462, FS_473, FS_507);
                FS_2274 = FS_2273;
            }
            else
            {
                FS_2274 = FS_1501;
            }
            FS_1524 = FS_2274;
        }
    }
    float3 FS_2314;
    [branch]
    if (FS_48_m12 > 0.5f)
    {
        FS_2314 = lerp(lerp(0.5f.xxx, lerp(dot(FS_1500, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, FS_1500, FS_48_m14.xxx), FS_48_m15.xxx) * FS_48_m13, FS_48_m26.xyz, FS_48_m26.w.xxx) + ((FS_48_m27.xyz * smoothstep(1.0f - FS_48_m16, 1.0f, 1.0f - clamp(FS_1428, 0.0f, 1.0f))) * FS_48_m17);
    }
    else
    {
        FS_2314 = FS_1500;
    }
    float4 FS_2326 = float4(FS_2314 * FS_19_m20.y, FS_442);
    FS_2326.w = (FS_48_m8 == 1.0f) ? FS_442 : 1.0f;
    float4 FS_2707;
    [branch]
    if (FS_19_m91.w < 0.5f)
    {
        float3 FS_2330 = -FS_370;
        float FS_2341 = (FS_371 * FS_19_m44.w) - FS_19_m43.w;
        float FS_2347 = FS_455.y * FS_19_m46.w;
        float FS_2351 = FS_2347 + FS_19_m47.w;
        float FS_2352 = isnan(FS_2351) ? 0.00999999977648258209228515625f : (isnan(0.00999999977648258209228515625f) ? FS_2351 : max(0.00999999977648258209228515625f, FS_2351));
        float3 FS_2366 = exp(FS_19_m45.xyz * ((-(isnan(FS_2341) ? 0.0f : (isnan(0.0f) ? FS_2341 : max(0.0f, FS_2341)))) * (((1.0f - exp(-FS_2352)) / FS_2352) * exp(FS_2347 + FS_19_m48.w))));
        float FS_2369 = dot(FS_2330, FS_19_m44.xyz);
        float FS_2375 = FS_19_m45.w * FS_19_m45.w;
        float FS_2379 = (1.0f + FS_2375) - ((2.0f * FS_19_m45.w) * FS_2369);
        float FS_2383 = (12.56637096405029296875f * FS_2379) * sqrt(FS_2379);
        float3 FS_2699;
        float FS_2700;
        if (FS_19_m55.z > 0.0f)
        {
            uint3 FS_2530 = (uint3(int3(FS_1236, FS_1237, int(FS_19_m19 & 7u))) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint FS_2531 = FS_2530.y;
            uint FS_2532 = FS_2530.z;
            uint FS_2535 = FS_2530.x + (FS_2531 * FS_2532);
            uint FS_2537 = FS_2531 + (FS_2532 * FS_2535);
            uint FS_2539 = FS_2532 + (FS_2535 * FS_2537);
            uint FS_2541 = FS_2535 + (FS_2537 * FS_2539);
            float FS_2563 = dot(FS_2330, -FS_17_m0[2].xyz);
            float3 FS_2570 = FS_455 - FS_17_m11.xyz;
            float FS_2572 = (FS_19_m55.w * ((FS_2563 > 5.9604644775390625e-08f) ? (1.0f / FS_2563) : 0.0f)) * (1.0f / FS_371);
            float FS_2573 = FS_2570.y;
            float FS_2574 = FS_2572 * FS_2573;
            float FS_2576 = FS_17_m11.y + FS_2574;
            float FS_2577 = FS_2573 - FS_2574;
            float FS_2579 = (1.0f - FS_2572) * FS_371;
            float FS_2585 = FS_19_m49.z * (FS_2576 - FS_19_m49.x);
            float FS_2592 = FS_19_m49.z * FS_2577;
            float FS_2593 = isnan(FS_2592) ? (-127.0f) : (isnan(-127.0f) ? FS_2592 : max(-127.0f, FS_2592));
            float FS_2609 = FS_19_m52.x * (FS_2576 - FS_19_m52.z);
            float FS_2616 = FS_19_m52.x * FS_2577;
            float FS_2617 = isnan(FS_2616) ? (-127.0f) : (isnan(-127.0f) ? FS_2616 : max(-127.0f, FS_2616));
            float FS_2628 = ((FS_19_m49.y * exp2(-(isnan(FS_2585) ? (-127.0f) : (isnan(-127.0f) ? FS_2585 : max(-127.0f, FS_2585))))) * ((abs(FS_2593) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-FS_2593)) / FS_2593) : (0.693147182464599609375f - (0.2402265071868896484375f * FS_2593)))) + ((FS_19_m52.y * exp2(-(isnan(FS_2609) ? (-127.0f) : (isnan(-127.0f) ? FS_2609 : max(-127.0f, FS_2609))))) * ((abs(FS_2617) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-FS_2617)) / FS_2617) : (0.693147182464599609375f - (0.2402265071868896484375f * FS_2617))));
            float FS_2632 = clamp(exp2(-(FS_2628 * FS_2579)), 0.0f, 1.0f);
            float FS_2650 = clamp((FS_371 * FS_19_m50.w) + FS_19_m50.z, 0.0f, 1.0f);
            float FS_2653 = clamp(((isnan(FS_19_m51.w) ? FS_2632 : (isnan(FS_2632) ? FS_19_m51.w : max(FS_2632, FS_19_m51.w))) + clamp((FS_371 * FS_19_m50.y) + FS_19_m50.x, 0.0f, 1.0f)) + FS_2650, 0.0f, 1.0f);
            float FS_2672 = FS_2579 - FS_19_m53.w;
            float4 FS_2693 = lerp(float4(0.0f, 0.0f, 0.0f, 1.0f), FS_66.SampleLevel(sampler_LinearRepeat, float3((FS_1475 + ((((float3(uint3(FS_2541, FS_2537 + (FS_2539 * FS_2541), FS_336) >> uint3(16u, 16u, 16u)) * 1.525902189314365386962890625e-05f.xxx) * 2.0f) - 1.0f.xxx) * FS_19_m59.w).xy) * FS_19_m57.xy, (log2((FS_351 * FS_19_m56.x) + FS_19_m56.y) * FS_19_m56.z) / FS_19_m55.z), 0.0f), clamp((FS_351 - FS_19_m58.z) * 1000000.0f, 0.0f, 1.0f).xxxx);
            float FS_2695 = FS_2693.w;
            FS_2699 = FS_2693.xyz + (((FS_19_m51.xyz * (1.0f - FS_2653)) + (((FS_19_m54.xyz * pow(clamp(dot(FS_370, FS_19_m53.xyz), 0.0f, 1.0f), FS_19_m54.w)) * (1.0f - clamp(exp2(-(FS_2628 * (isnan(0.0f) ? FS_2672 : (isnan(FS_2672) ? 0.0f : max(FS_2672, 0.0f))))), 0.0f, 1.0f))) * (1.0f - FS_2650))) * FS_2695);
            FS_2700 = FS_2695 * FS_2653;
        }
        else
        {
            float3 FS_2406 = FS_455 - FS_17_m11.xyz;
            float FS_2408 = FS_2406.y;
            float FS_2414 = FS_19_m49.z * (FS_17_m11.y - FS_19_m49.x);
            float FS_2421 = FS_19_m49.z * FS_2408;
            float FS_2422 = isnan(FS_2421) ? (-127.0f) : (isnan(-127.0f) ? FS_2421 : max(-127.0f, FS_2421));
            float FS_2438 = FS_19_m52.x * (FS_17_m11.y - FS_19_m52.z);
            float FS_2445 = FS_19_m52.x * FS_2408;
            float FS_2446 = isnan(FS_2445) ? (-127.0f) : (isnan(-127.0f) ? FS_2445 : max(-127.0f, FS_2445));
            float FS_2457 = ((FS_19_m49.y * exp2(-(isnan(FS_2414) ? (-127.0f) : (isnan(-127.0f) ? FS_2414 : max(-127.0f, FS_2414))))) * ((abs(FS_2422) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-FS_2422)) / FS_2422) : (0.693147182464599609375f - (0.2402265071868896484375f * FS_2422)))) + ((FS_19_m52.y * exp2(-(isnan(FS_2438) ? (-127.0f) : (isnan(-127.0f) ? FS_2438 : max(-127.0f, FS_2438))))) * ((abs(FS_2446) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-FS_2446)) / FS_2446) : (0.693147182464599609375f - (0.2402265071868896484375f * FS_2446))));
            float FS_2461 = clamp(exp2(-(FS_2457 * FS_371)), 0.0f, 1.0f);
            float FS_2479 = clamp((FS_371 * FS_19_m50.w) + FS_19_m50.z, 0.0f, 1.0f);
            float FS_2482 = clamp(((isnan(FS_19_m51.w) ? FS_2461 : (isnan(FS_2461) ? FS_19_m51.w : max(FS_2461, FS_19_m51.w))) + clamp((FS_371 * FS_19_m50.y) + FS_19_m50.x, 0.0f, 1.0f)) + FS_2479, 0.0f, 1.0f);
            float FS_2501 = FS_371 - FS_19_m53.w;
            FS_2699 = (FS_19_m51.xyz * (1.0f - FS_2482)) + (((FS_19_m54.xyz * pow(clamp(dot(FS_370, FS_19_m53.xyz), 0.0f, 1.0f), FS_19_m54.w)) * (1.0f - clamp(exp2(-(FS_2457 * (isnan(0.0f) ? FS_2501 : (isnan(FS_2501) ? 0.0f : max(FS_2501, 0.0f))))), 0.0f, 1.0f))) * (1.0f - FS_2479));
            FS_2700 = FS_2482;
        }
        float3 FS_2705 = (FS_2326.xyz * (FS_2366 * FS_2700)) + ((((clamp(((FS_19_m46.xyz * (0.0596831031143665313720703125f * (1.0f + (FS_2369 * FS_2369)))) + FS_19_m48.xyz) + (FS_19_m47.xyz * ((1.0f - FS_2375) / (isnan(0.001000000047497451305389404296875f) ? FS_2383 : (isnan(FS_2383) ? 0.001000000047497451305389404296875f : max(FS_2383, 0.001000000047497451305389404296875f))))), 0.0f.xxx, 1.0f.xxx) * 255.0f) * (1.0f.xxx - FS_2366)) * FS_2700) + FS_2699);
        FS_2707 = float4(FS_2705.x, FS_2705.y, FS_2705.z, FS_2326.w);
    }
    else
    {
        FS_2707 = FS_2326;
    }
    FS_14 = FS_2707;
    //FS_14=test;
    FS_15 = FS_1186;
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
