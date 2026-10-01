float _CP26UseSceneDepthGeometry;
float4x4 _CP26SceneVP;
float _CP26UseCapturedProjection;
float4x4 _CP26ObjectToWorld, _CP26ObjectToClip;
// Captured F:/endfield06.rdc CP26F. Independent resources; live Unity M/VP.
struct CP26FVS_30
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

cbuffer CP26FVS_25_26
{
    column_major float4x4 CP26FVS_26_m0 : packoffset(c0);
    column_major float4x4 CP26FVS_26_m1 : packoffset(c4);
    column_major float4x4 CP26FVS_26_m2 : packoffset(c8);
    column_major float4x4 CP26FVS_26_m3 : packoffset(c12);
    column_major float4x4 CP26FVS_26_m4 : packoffset(c16);
    column_major float4x4 CP26FVS_26_m5 : packoffset(c20);
    column_major float4x4 CP26FVS_26_m6 : packoffset(c24);
    column_major float4x4 CP26FVS_26_m7 : packoffset(c28);
    column_major float4x4 CP26FVS_26_m8 : packoffset(c32);
    column_major float4x4 CP26FVS_26_m9 : packoffset(c36);
    column_major float4x4 CP26FVS_26_m10 : packoffset(c40);
    float4 CP26FVS_26_m11 : packoffset(c44);
    column_major float4x4 CP26FVS_26_m12 : packoffset(c45);
    column_major float4x4 CP26FVS_26_m13 : packoffset(c49);
    column_major float4x4 CP26FVS_26_m14 : packoffset(c53);
    column_major float4x4 CP26FVS_26_m15 : packoffset(c57);
    column_major float4x4 CP26FVS_26_m16 : packoffset(c61);
    column_major float4x4 CP26FVS_26_m17 : packoffset(c65);
    column_major float4x4 CP26FVS_26_m18 : packoffset(c69);
    column_major float4x4 CP26FVS_26_m19 : packoffset(c73);
    column_major float4x4 CP26FVS_26_m20 : packoffset(c77);
    float4 CP26FVS_26_m21 : packoffset(c81);
};

cbuffer CP26FVS_27_28
{
    float4 CP26FVS_28_m0 : packoffset(c0);
    float4 CP26FVS_28_m1 : packoffset(c1);
    float4 CP26FVS_28_m2 : packoffset(c2);
    float4 CP26FVS_28_m3 : packoffset(c3);
    float4 CP26FVS_28_m4 : packoffset(c4);
    float4 CP26FVS_28_m5 : packoffset(c5);
    float4 CP26FVS_28_m6[6] : packoffset(c6);
    float4 CP26FVS_28_m7[6] : packoffset(c12);
    float4 CP26FVS_28_m8 : packoffset(c18);
    float4 CP26FVS_28_m9 : packoffset(c19);
    float4 CP26FVS_28_m10 : packoffset(c20);
    float4 CP26FVS_28_m11 : packoffset(c21);
    float4 CP26FVS_28_m12 : packoffset(c22);
    float4 CP26FVS_28_m13 : packoffset(c23);
    float4 CP26FVS_28_m14 : packoffset(c24);
    float4 CP26FVS_28_m15 : packoffset(c25);
    float CP26FVS_28_m16 : packoffset(c26);
    float CP26FVS_28_m17 : packoffset(c26.y);
    float CP26FVS_28_m18 : packoffset(c26.z);
    uint CP26FVS_28_m19 : packoffset(c26.w);
    float4 CP26FVS_28_m20 : packoffset(c27);
    int4 CP26FVS_28_m21 : packoffset(c28);
    float4 CP26FVS_28_m22 : packoffset(c29);
    float4 CP26FVS_28_m23 : packoffset(c30);
    float4 CP26FVS_28_m24 : packoffset(c31);
    float4 CP26FVS_28_m25 : packoffset(c32);
    float4 CP26FVS_28_m26 : packoffset(c33);
    float4 CP26FVS_28_m27 : packoffset(c34);
    float4 CP26FVS_28_m28 : packoffset(c35);
    float4 CP26FVS_28_m29 : packoffset(c36);
    float4 CP26FVS_28_m30 : packoffset(c37);
    float4 CP26FVS_28_m31 : packoffset(c38);
    float4 CP26FVS_28_m32[4] : packoffset(c39);
    float4 CP26FVS_28_m33[4] : packoffset(c43);
    float4 CP26FVS_28_m34[4] : packoffset(c47);
    float4 CP26FVS_28_m35[4] : packoffset(c51);
    float4 CP26FVS_28_m36 : packoffset(c55);
    float4 CP26FVS_28_m37 : packoffset(c56);
    float4 CP26FVS_28_m38[4] : packoffset(c57);
    float4 CP26FVS_28_m39[4] : packoffset(c61);
    float4 CP26FVS_28_m40[4] : packoffset(c65);
    float4 CP26FVS_28_m41 : packoffset(c69);
    float4 CP26FVS_28_m42 : packoffset(c70);
    float4 CP26FVS_28_m43 : packoffset(c71);
    float4 CP26FVS_28_m44 : packoffset(c72);
    float4 CP26FVS_28_m45 : packoffset(c73);
    float4 CP26FVS_28_m46 : packoffset(c74);
    float4 CP26FVS_28_m47 : packoffset(c75);
    float4 CP26FVS_28_m48 : packoffset(c76);
    float4 CP26FVS_28_m49 : packoffset(c77);
    float4 CP26FVS_28_m50 : packoffset(c78);
    float4 CP26FVS_28_m51 : packoffset(c79);
    float4 CP26FVS_28_m52 : packoffset(c80);
    float4 CP26FVS_28_m53 : packoffset(c81);
    float4 CP26FVS_28_m54 : packoffset(c82);
    float4 CP26FVS_28_m55 : packoffset(c83);
    float4 CP26FVS_28_m56 : packoffset(c84);
    float4 CP26FVS_28_m57 : packoffset(c85);
    float4 CP26FVS_28_m58 : packoffset(c86);
    float4 CP26FVS_28_m59 : packoffset(c87);
    float4 CP26FVS_28_m60 : packoffset(c88);
    float4 CP26FVS_28_m61 : packoffset(c89);
    float4 CP26FVS_28_m62 : packoffset(c90);
    float4 CP26FVS_28_m63 : packoffset(c91);
    float4 CP26FVS_28_m64 : packoffset(c92);
    float4 CP26FVS_28_m65 : packoffset(c93);
    float4 CP26FVS_28_m66 : packoffset(c94);
    float4 CP26FVS_28_m67 : packoffset(c95);
    float4 CP26FVS_28_m68 : packoffset(c96);
    float4 CP26FVS_28_m69 : packoffset(c97);
    float4 CP26FVS_28_m70 : packoffset(c98);
    float4 CP26FVS_28_m71 : packoffset(c99);
    float4 CP26FVS_28_m72 : packoffset(c100);
    float4 CP26FVS_28_m73 : packoffset(c101);
    float4 CP26FVS_28_m74 : packoffset(c102);
    float4 CP26FVS_28_m75 : packoffset(c103);
    float4 CP26FVS_28_m76 : packoffset(c104);
    float4 CP26FVS_28_m77 : packoffset(c105);
    float4 CP26FVS_28_m78 : packoffset(c106);
    float4 CP26FVS_28_m79 : packoffset(c107);
    float4 CP26FVS_28_m80 : packoffset(c108);
    float4 CP26FVS_28_m81 : packoffset(c109);
    float4 CP26FVS_28_m82 : packoffset(c110);
    float4 CP26FVS_28_m83 : packoffset(c111);
    float4 CP26FVS_28_m84 : packoffset(c112);
    float4 CP26FVS_28_m85 : packoffset(c113);
    float4 CP26FVS_28_m86 : packoffset(c114);
    float4 CP26FVS_28_m87 : packoffset(c115);
    float4 CP26FVS_28_m88 : packoffset(c116);
    float4 CP26FVS_28_m89 : packoffset(c117);
    float4 CP26FVS_28_m90 : packoffset(c118);
    float4 CP26FVS_28_m91 : packoffset(c119);
    float4 CP26FVS_28_m92 : packoffset(c120);
    float4 CP26FVS_28_m93 : packoffset(c121);
    float4 CP26FVS_28_m94 : packoffset(c122);
    float4 CP26FVS_28_m95 : packoffset(c123);
    float4 CP26FVS_28_m96 : packoffset(c124);
    float4 CP26FVS_28_m97 : packoffset(c125);
    float4 CP26FVS_28_m98 : packoffset(c126);
    float4 CP26FVS_28_m99[2] : packoffset(c127);
    float4 CP26FVS_28_m100[2] : packoffset(c129);
    float CP26FVS_28_m101 : packoffset(c131);
    float CP26FVS_28_m102 : packoffset(c131.y);
    float CP26FVS_28_m103 : packoffset(c131.z);
    float CP26FVS_28_m104 : packoffset(c131.w);
    float4 CP26FVS_28_m105 : packoffset(c132);
    float4 CP26FVS_28_m106 : packoffset(c133);
    float4 CP26FVS_28_m107 : packoffset(c134);
    float4 CP26FVS_28_m108 : packoffset(c135);
    float4 CP26FVS_28_m109 : packoffset(c136);
    float4 CP26FVS_28_m110 : packoffset(c137);
    float4 CP26FVS_28_m111 : packoffset(c138);
    float4 CP26FVS_28_m112 : packoffset(c139);
    float4 CP26FVS_28_m113 : packoffset(c140);
    float4 CP26FVS_28_m114 : packoffset(c141);
    float4 CP26FVS_28_m115 : packoffset(c142);
    float4 CP26FVS_28_m116 : packoffset(c143);
    float4 CP26FVS_28_m117 : packoffset(c144);
    float4 CP26FVS_28_m118 : packoffset(c145);
    float4 CP26FVS_28_m119 : packoffset(c146);
    float4 CP26FVS_28_m120 : packoffset(c147);
    float4 CP26FVS_28_m121 : packoffset(c148);
    float4 CP26FVS_28_m122 : packoffset(c149);
    float4 CP26FVS_28_m123 : packoffset(c150);
    float4 CP26FVS_28_m124 : packoffset(c151);
    float4 CP26FVS_28_m125 : packoffset(c152);
    float4 CP26FVS_28_m126 : packoffset(c153);
    float4 CP26FVS_28_m127 : packoffset(c154);
    float4 CP26FVS_28_m128 : packoffset(c155);
    float4 CP26FVS_28_m129 : packoffset(c156);
    float4 CP26FVS_28_m130 : packoffset(c157);
    float4 CP26FVS_28_m131 : packoffset(c158);
    float4 CP26FVS_28_m132 : packoffset(c159);
    float4 CP26FVS_28_m133 : packoffset(c160);
    float4 CP26FVS_28_m134 : packoffset(c161);
    column_major float4x4 CP26FVS_28_m135 : packoffset(c162);
    float4 CP26FVS_28_m136 : packoffset(c166);
    float4 CP26FVS_28_m137 : packoffset(c167);
    float4 CP26FVS_28_m138[32] : packoffset(c168);
};

cbuffer CP26FVS_29_31
{
    float4 CP26FVS_instanceRaw[4096] : packoffset(c0);
};

ByteAddressBuffer CP26FVS_33;
cbuffer CP26FVS_34_35
{
    float CP26FVS_35_m0 : packoffset(c0);
    float CP26FVS_35_m1 : packoffset(c0.y);
    float CP26FVS_35_m2 : packoffset(c0.z);
    float CP26FVS_35_m3 : packoffset(c0.w);
    float CP26FVS_35_m4 : packoffset(c1);
    float CP26FVS_35_m5 : packoffset(c1.y);
    float CP26FVS_35_m6 : packoffset(c1.z);
    float CP26FVS_35_m7 : packoffset(c1.w);
    float CP26FVS_35_m8 : packoffset(c2);
    float CP26FVS_35_m9 : packoffset(c2.y);
    float CP26FVS_35_m10 : packoffset(c2.z);
    float CP26FVS_35_m11 : packoffset(c2.w);
    float CP26FVS_35_m12 : packoffset(c3);
    float CP26FVS_35_m13 : packoffset(c3.y);
    float CP26FVS_35_m14 : packoffset(c3.z);
    float CP26FVS_35_m15 : packoffset(c3.w);
    float CP26FVS_35_m16 : packoffset(c4);
    float CP26FVS_35_m17 : packoffset(c4.y);
    float CP26FVS_35_m18 : packoffset(c4.z);
    float CP26FVS_35_m19 : packoffset(c4.w);
    float CP26FVS_35_m20 : packoffset(c5);
    float CP26FVS_35_m21 : packoffset(c5.y);
    float CP26FVS_35_m22 : packoffset(c5.z);
    float CP26FVS_35_m23 : packoffset(c5.w);
    float4 CP26FVS_35_m24 : packoffset(c6);
    float4 CP26FVS_35_m25 : packoffset(c7);
    float4 CP26FVS_35_m26 : packoffset(c8);
    float4 CP26FVS_35_m27 : packoffset(c9);
    float4 CP26FVS_35_m28 : packoffset(c10);
    float4 CP26FVS_35_m29 : packoffset(c11);
    float CP26FVS_35_m30 : packoffset(c12);
    float CP26FVS_35_m31 : packoffset(c12.y);
    float CP26FVS_35_m32 : packoffset(c12.z);
    float CP26FVS_35_m33 : packoffset(c12.w);
    float CP26FVS_35_m34 : packoffset(c13);
    float CP26FVS_35_m35 : packoffset(c13.y);
    float CP26FVS_35_m36 : packoffset(c13.z);
    float CP26FVS_35_m37 : packoffset(c13.w);
    float CP26FVS_35_m38 : packoffset(c14);
    float CP26FVS_35_m39 : packoffset(c14.y);
    float CP26FVS_35_m40 : packoffset(c14.z);
    float CP26FVS_35_m41 : packoffset(c14.w);
    float4 CP26FVS_35_m42 : packoffset(c15);
    float CP26FVS_35_m43 : packoffset(c16);
    float CP26FVS_35_m44 : packoffset(c16.y);
    float CP26FVS_35_m45 : packoffset(c16.z);
    float CP26FVS_35_m46 : packoffset(c16.w);
    float CP26FVS_35_m47 : packoffset(c17);
    float CP26FVS_35_m48 : packoffset(c17.y);
    float CP26FVS_35_m49 : packoffset(c17.z);
    float CP26FVS_35_m50 : packoffset(c17.w);
    float4 CP26FVS_35_m51 : packoffset(c18);
    float CP26FVS_35_m52 : packoffset(c19);
    float CP26FVS_35_m53 : packoffset(c19.y);
    float CP26FVS_35_m54 : packoffset(c19.z);
    float CP26FVS_35_m55 : packoffset(c19.w);
    float4 CP26FVS_35_m56 : packoffset(c20);
    float4 CP26FVS_35_m57 : packoffset(c21);
    float4 CP26FVS_35_m58 : packoffset(c22);
    float4 CP26FVS_35_m59 : packoffset(c23);
    float4 CP26FVS_35_m60 : packoffset(c24);
    float4 CP26FVS_35_m61 : packoffset(c25);
    float CP26FVS_35_m62 : packoffset(c26);
    float CP26FVS_35_m63 : packoffset(c26.y);
    float CP26FVS_35_m64 : packoffset(c26.z);
    float CP26FVS_35_m65 : packoffset(c26.w);
    float CP26FVS_35_m66 : packoffset(c27);
    float CP26FVS_35_m67 : packoffset(c27.y);
    float CP26FVS_35_m68 : packoffset(c27.z);
    float CP26FVS_35_m69 : packoffset(c27.w);
};


static float4 CP26FVS_gl_Position;
static int CP26FVS_gl_InstanceIndex;
static float3 CP26FVS_3;
static float2 CP26FVS_4;
static float3 CP26FVS_5;
static float4 CP26FVS_6;
static float4 CP26FVS_7;
static float3 CP26FVS_8;
static float3 CP26FVS_9;
static float4 CP26FVS_10;
static float4 CP26FVS_12;
static uint4 CP26FVS_13;
static float2 CP26FVS_14;
static float3 CP26FVS_15;
static float3 CP26FVS_16;
static float4 CP26FVS_17;
static float3 CP26FVS_18;
static float3 CP26FVS_19;
static float3 CP26FVS_20;
static float4 CP26FVS_21;
static float3 CP26FVS_22;
static uint CP26FVS_24;

CP26FVS_30 CP26FVS_LoadInstance(uint index) { uint b=index*16; CP26FVS_30 x;
x._m0=transpose(float4x4(CP26FVS_instanceRaw[b],CP26FVS_instanceRaw[b+1],CP26FVS_instanceRaw[b+2],CP26FVS_instanceRaw[b+3]));
x._m1=CP26FVS_instanceRaw[b+4];x._m2=CP26FVS_instanceRaw[b+5];
x._m3=transpose(float4x4(CP26FVS_instanceRaw[b+6],CP26FVS_instanceRaw[b+7],CP26FVS_instanceRaw[b+8],CP26FVS_instanceRaw[b+9]));
x._m4=CP26FVS_instanceRaw[b+10];
x._m5=CP26FVS_instanceRaw[b+11];
x._m6=CP26FVS_instanceRaw[b+12];
x._m7=CP26FVS_instanceRaw[b+13];
x._m8=CP26FVS_instanceRaw[b+14];
x._m9=CP26FVS_instanceRaw[b+15];
return x;}

struct CP26FVS_SPIRV_Cross_Input
{
    float3 CP26FVS_3 : TEXCOORD0;
    float2 CP26FVS_4 : TEXCOORD1;
    float3 CP26FVS_5 : TEXCOORD2;
    float4 CP26FVS_6 : TEXCOORD3;
    float4 CP26FVS_7 : TEXCOORD4;
    float3 CP26FVS_8 : TEXCOORD5;
    float3 CP26FVS_9 : TEXCOORD6;
    float4 CP26FVS_10 : TEXCOORD7;
    float4 CP26FVS_12 : TEXCOORD8;
    uint4 CP26FVS_13 : TEXCOORD9;
    uint CP26FVS_gl_InstanceIndex : SV_InstanceID;
};

struct CP26FVS_SPIRV_Cross_Output
{
    float2 CP26FVS_14 : TEXCOORD0;
    float3 CP26FVS_15 : TEXCOORD1;
    float3 CP26FVS_16 : TEXCOORD2;
    float4 CP26FVS_17 : TEXCOORD3;
    float3 CP26FVS_18 : TEXCOORD4;
    float3 CP26FVS_19 : TEXCOORD5;
    float3 CP26FVS_20 : TEXCOORD6;
    float4 CP26FVS_21 : TEXCOORD7;
    float3 CP26FVS_22 : TEXCOORD8;
    nointerpolation uint CP26FVS_24 : TEXCOORD9;
    float4 CP26FVS_gl_Position : SV_Position;
};

static float4 CP26FVS_113;
static float3 CP26FBakedPosition;
static float3 CP26FBakedNormal;
static float4 CP26FBakedTangent;

void CP26FVS_vert_main()
{
    uint CP26FVS_130 = asuint(CP26FVS_5.x);
    bool CP26FVS_132 = (CP26FVS_130 & 1073741824u) > 0u;
    float3 CP26FVS_205;
    float4 CP26FVS_206;
    if (CP26FVS_132)
    {
        float CP26FVS_138 = float((CP26FVS_130 << 22u) >> 22u);
        float CP26FVS_141 = float((CP26FVS_130 << 12u) >> 22u);
        float CP26FVS_144 = float((CP26FVS_130 << 2u) >> 22u);
        float3 CP26FVS_158 = float3((CP26FVS_138 >= 512.0f) ? (CP26FVS_138 - 1024.0f) : CP26FVS_138, (CP26FVS_141 >= 512.0f) ? (CP26FVS_141 - 1024.0f) : CP26FVS_141, 0.0f) * 0.001956947147846221923828125f;
        float CP26FVS_164 = (1.0f - abs(CP26FVS_158.x)) - abs(CP26FVS_158.y);
        float3 CP26FVS_165 = CP26FVS_158;
        CP26FVS_165.z = CP26FVS_164;
        bool2 CP26FVS_167 = (CP26FVS_164 < 0.0f).xx;
        float2 CP26FVS_175 = (1.0f.xx - abs(CP26FVS_165.yx)) * ((step(0.0f.xx, CP26FVS_165.xy) * 2.0f) - 1.0f.xx);
        float2 CP26FVS_176 = float2(CP26FVS_167.x ? CP26FVS_175.x : CP26FVS_165.xy.x, CP26FVS_167.y ? CP26FVS_175.y : CP26FVS_165.xy.y);
        float3 CP26FVS_178 = normalize(float3(CP26FVS_176.x, CP26FVS_176.y, CP26FVS_165.z));
        float CP26FVS_179 = ((CP26FVS_144 >= 512.0f) ? (CP26FVS_144 - 1024.0f) : CP26FVS_144) * 0.001956947147846221923828125f;
        float3 CP26FVS_182 = CP26FVS_178.yzx - CP26FVS_178.zxy;
        float3 CP26FVS_186 = normalize(CP26FVS_182 - dot(CP26FVS_182, CP26FVS_178).xxx);
        float CP26FVS_190 = (CP26FVS_179 < 0.0f) ? (-1.0f) : 1.0f;
        float CP26FVS_193 = 1.0f - ((CP26FVS_179 * CP26FVS_190) * 2.0f);
        float3 CP26FVS_200 = mul(normalize(float2(CP26FVS_193, CP26FVS_190 * (1.0f - abs(CP26FVS_193)))), float2x3(CP26FVS_186, normalize(cross(CP26FVS_178, CP26FVS_186))));
        float4 CP26FVS_204 = float4(CP26FVS_200.x, CP26FVS_200.y, CP26FVS_200.z, CP26FVS_113.w);
        CP26FVS_204.w = (float((CP26FVS_130 >> 31u) & 1u) * 2.0f) - 1.0f;
        CP26FVS_205 = CP26FVS_178;
        CP26FVS_206 = CP26FVS_204;
    }
    else
    {
        CP26FVS_205 = CP26FVS_5;
        CP26FVS_206 = 0.0f.xxxx;
    }
    bool4 CP26FVS_207 = CP26FVS_132.xxxx;
    float4 CP26FVS_208 = float4(CP26FVS_207.x ? CP26FVS_206.x : CP26FVS_6.x, CP26FVS_207.y ? CP26FVS_206.y : CP26FVS_6.y, CP26FVS_207.z ? CP26FVS_206.z : CP26FVS_6.z, CP26FVS_207.w ? CP26FVS_206.w : CP26FVS_6.w);
    uint CP26FVS_210 = asuint(CP26FVS_9.x);
    bool CP26FVS_212 = (CP26FVS_210 & 1073741824u) > 0u;
    float3 CP26FVS_285;
    float4 CP26FVS_286;
    if (CP26FVS_212)
    {
        float CP26FVS_218 = float((CP26FVS_210 << 22u) >> 22u);
        float CP26FVS_221 = float((CP26FVS_210 << 12u) >> 22u);
        float CP26FVS_224 = float((CP26FVS_210 << 2u) >> 22u);
        float3 CP26FVS_238 = float3((CP26FVS_218 >= 512.0f) ? (CP26FVS_218 - 1024.0f) : CP26FVS_218, (CP26FVS_221 >= 512.0f) ? (CP26FVS_221 - 1024.0f) : CP26FVS_221, 0.0f) * 0.001956947147846221923828125f;
        float CP26FVS_244 = (1.0f - abs(CP26FVS_238.x)) - abs(CP26FVS_238.y);
        float3 CP26FVS_245 = CP26FVS_238;
        CP26FVS_245.z = CP26FVS_244;
        bool2 CP26FVS_247 = (CP26FVS_244 < 0.0f).xx;
        float2 CP26FVS_255 = (1.0f.xx - abs(CP26FVS_245.yx)) * ((step(0.0f.xx, CP26FVS_245.xy) * 2.0f) - 1.0f.xx);
        float2 CP26FVS_256 = float2(CP26FVS_247.x ? CP26FVS_255.x : CP26FVS_245.xy.x, CP26FVS_247.y ? CP26FVS_255.y : CP26FVS_245.xy.y);
        float3 CP26FVS_258 = normalize(float3(CP26FVS_256.x, CP26FVS_256.y, CP26FVS_245.z));
        float CP26FVS_259 = ((CP26FVS_224 >= 512.0f) ? (CP26FVS_224 - 1024.0f) : CP26FVS_224) * 0.001956947147846221923828125f;
        float3 CP26FVS_262 = CP26FVS_258.yzx - CP26FVS_258.zxy;
        float3 CP26FVS_266 = normalize(CP26FVS_262 - dot(CP26FVS_262, CP26FVS_258).xxx);
        float CP26FVS_270 = (CP26FVS_259 < 0.0f) ? (-1.0f) : 1.0f;
        float CP26FVS_273 = 1.0f - ((CP26FVS_259 * CP26FVS_270) * 2.0f);
        float3 CP26FVS_280 = mul(normalize(float2(CP26FVS_273, CP26FVS_270 * (1.0f - abs(CP26FVS_273)))), float2x3(CP26FVS_266, normalize(cross(CP26FVS_258, CP26FVS_266))));
        float4 CP26FVS_284 = float4(CP26FVS_280.x, CP26FVS_280.y, CP26FVS_280.z, CP26FVS_113.w);
        CP26FVS_284.w = (float((CP26FVS_210 >> 31u) & 1u) * 2.0f) - 1.0f;
        CP26FVS_285 = CP26FVS_258;
        CP26FVS_286 = CP26FVS_284;
    }
    else
    {
        CP26FVS_285 = CP26FVS_9;
        CP26FVS_286 = 0.0f.xxxx;
    }
    bool4 CP26FVS_287 = CP26FVS_212.xxxx;
    float4 CP26FVS_288 = float4(CP26FVS_287.x ? CP26FVS_286.x : CP26FVS_10.x, CP26FVS_287.y ? CP26FVS_286.y : CP26FVS_10.y, CP26FVS_287.z ? CP26FVS_286.z : CP26FVS_10.z, CP26FVS_287.w ? CP26FVS_286.w : CP26FVS_10.w);
    uint CP26FVS_291 = asuint(CP26FVS_LoadInstance(uint(CP26FVS_gl_InstanceIndex))._m1.w);
    bool CP26FVS_293 = (CP26FVS_291 & 16u) != 0u;
    bool3 CP26FVS_294 = CP26FVS_293.xxx;
    bool4 CP26FVS_296 = CP26FVS_293.xxxx;
    float4 CP26FVS_482;
    float3 CP26FVS_483;
    float3 CP26FVS_484;
    float3 CP26FVS_485;
    do
    {
        float4 CP26FVS_304 = float4(CP26FVS_3, 1.0f);
        uint CP26FVS_305 = CP26FVS_291 & 4294967247u;
        if (((CP26FVS_291 & 32u) == 0u) || (CP26FVS_305 == 0u))
        {
            CP26FVS_482 = CP26FVS_208;
            CP26FVS_483 = CP26FVS_205;
            CP26FVS_484 = CP26FVS_3;
            CP26FVS_485 = CP26FVS_7.xyz;
            break;
        }
        uint4 CP26FVS_321 = CP26FVS_13 * uint4(3u, 3u, 3u, 3u);
        uint4 CP26FVS_322 = (asuint(CP26FVS_LoadInstance(uint(CP26FVS_gl_InstanceIndex))._m2.x) + 3u).xxxx + CP26FVS_321;
        uint4 CP26FVS_324 = (asuint(CP26FVS_LoadInstance(uint(CP26FVS_gl_InstanceIndex))._m2.y) + 3u).xxxx + CP26FVS_321;
        uint CP26FVS_325 = CP26FVS_322.x;
        uint CP26FVS_328 = CP26FVS_325 + 1u;
        uint CP26FVS_331 = CP26FVS_325 + 2u;
        uint CP26FVS_334 = CP26FVS_324.x;
        uint CP26FVS_337 = CP26FVS_334 + 1u;
        uint CP26FVS_340 = CP26FVS_334 + 2u;
        float4 CP26FVS_384;
        float4 CP26FVS_385;
        float4 CP26FVS_386;
        float4 CP26FVS_387;
        float4 CP26FVS_388;
        float4 CP26FVS_389;
        if (CP26FVS_305 >= 2u)
        {
            uint CP26FVS_348 = CP26FVS_322.y;
            uint CP26FVS_367 = CP26FVS_324.y;
            CP26FVS_384 = (asfloat(CP26FVS_33.Load4(CP26FVS_340 * 16 + 0)) * CP26FVS_12.x) + (asfloat(CP26FVS_33.Load4((CP26FVS_367 + 2u) * 16 + 0)) * CP26FVS_12.y);
            CP26FVS_385 = (asfloat(CP26FVS_33.Load4(CP26FVS_337 * 16 + 0)) * CP26FVS_12.x) + (asfloat(CP26FVS_33.Load4((CP26FVS_367 + 1u) * 16 + 0)) * CP26FVS_12.y);
            CP26FVS_386 = (asfloat(CP26FVS_33.Load4(CP26FVS_334 * 16 + 0)) * CP26FVS_12.x) + (asfloat(CP26FVS_33.Load4(CP26FVS_367 * 16 + 0)) * CP26FVS_12.y);
            CP26FVS_387 = (asfloat(CP26FVS_33.Load4(CP26FVS_331 * 16 + 0)) * CP26FVS_12.x) + (asfloat(CP26FVS_33.Load4((CP26FVS_348 + 2u) * 16 + 0)) * CP26FVS_12.y);
            CP26FVS_388 = (asfloat(CP26FVS_33.Load4(CP26FVS_328 * 16 + 0)) * CP26FVS_12.x) + (asfloat(CP26FVS_33.Load4((CP26FVS_348 + 1u) * 16 + 0)) * CP26FVS_12.y);
            CP26FVS_389 = (asfloat(CP26FVS_33.Load4(CP26FVS_325 * 16 + 0)) * CP26FVS_12.x) + (asfloat(CP26FVS_33.Load4(CP26FVS_348 * 16 + 0)) * CP26FVS_12.y);
        }
        else
        {
            CP26FVS_384 = asfloat(CP26FVS_33.Load4(CP26FVS_340 * 16 + 0));
            CP26FVS_385 = asfloat(CP26FVS_33.Load4(CP26FVS_337 * 16 + 0));
            CP26FVS_386 = asfloat(CP26FVS_33.Load4(CP26FVS_334 * 16 + 0));
            CP26FVS_387 = asfloat(CP26FVS_33.Load4(CP26FVS_331 * 16 + 0));
            CP26FVS_388 = asfloat(CP26FVS_33.Load4(CP26FVS_328 * 16 + 0));
            CP26FVS_389 = asfloat(CP26FVS_33.Load4(CP26FVS_325 * 16 + 0));
        }
        float4 CP26FVS_455;
        float4 CP26FVS_456;
        float4 CP26FVS_457;
        float4 CP26FVS_458;
        float4 CP26FVS_459;
        float4 CP26FVS_460;
        if (CP26FVS_305 >= 4u)
        {
            uint CP26FVS_393 = CP26FVS_322.z;
            uint CP26FVS_398 = CP26FVS_322.w;
            uint CP26FVS_425 = CP26FVS_324.z;
            uint CP26FVS_429 = CP26FVS_324.w;
            CP26FVS_455 = CP26FVS_384 + ((asfloat(CP26FVS_33.Load4((CP26FVS_425 + 2u) * 16 + 0)) * CP26FVS_12.z) + (asfloat(CP26FVS_33.Load4((CP26FVS_429 + 2u) * 16 + 0)) * CP26FVS_12.w));
            CP26FVS_456 = CP26FVS_385 + ((asfloat(CP26FVS_33.Load4((CP26FVS_425 + 1u) * 16 + 0)) * CP26FVS_12.z) + (asfloat(CP26FVS_33.Load4((CP26FVS_429 + 1u) * 16 + 0)) * CP26FVS_12.w));
            CP26FVS_457 = CP26FVS_386 + ((asfloat(CP26FVS_33.Load4(CP26FVS_425 * 16 + 0)) * CP26FVS_12.z) + (asfloat(CP26FVS_33.Load4(CP26FVS_429 * 16 + 0)) * CP26FVS_12.w));
            CP26FVS_458 = CP26FVS_387 + ((asfloat(CP26FVS_33.Load4((CP26FVS_393 + 2u) * 16 + 0)) * CP26FVS_12.z) + (asfloat(CP26FVS_33.Load4((CP26FVS_398 + 2u) * 16 + 0)) * CP26FVS_12.w));
            CP26FVS_459 = CP26FVS_388 + ((asfloat(CP26FVS_33.Load4((CP26FVS_393 + 1u) * 16 + 0)) * CP26FVS_12.z) + (asfloat(CP26FVS_33.Load4((CP26FVS_398 + 1u) * 16 + 0)) * CP26FVS_12.w));
            CP26FVS_460 = CP26FVS_389 + ((asfloat(CP26FVS_33.Load4(CP26FVS_393 * 16 + 0)) * CP26FVS_12.z) + (asfloat(CP26FVS_33.Load4(CP26FVS_398 * 16 + 0)) * CP26FVS_12.w));
        }
        else
        {
            CP26FVS_455 = CP26FVS_384;
            CP26FVS_456 = CP26FVS_385;
            CP26FVS_457 = CP26FVS_386;
            CP26FVS_458 = CP26FVS_387;
            CP26FVS_459 = CP26FVS_388;
            CP26FVS_460 = CP26FVS_389;
        }
        float3 CP26FVS_476 = CP26FVS_208.xyz;
        float3 CP26FVS_480 = float3(dot(CP26FVS_460.xyz, CP26FVS_476), dot(CP26FVS_459.xyz, CP26FVS_476), dot(CP26FVS_458.xyz, CP26FVS_476));
        CP26FVS_482 = float4(CP26FVS_480.x, CP26FVS_480.y, CP26FVS_480.z, CP26FVS_208.w);
        CP26FVS_483 = float3(dot(CP26FVS_460.xyz, CP26FVS_205), dot(CP26FVS_459.xyz, CP26FVS_205), dot(CP26FVS_458.xyz, CP26FVS_205));
        CP26FVS_484 = float3(dot(CP26FVS_460, CP26FVS_304), dot(CP26FVS_459, CP26FVS_304), dot(CP26FVS_458, CP26FVS_304));
        CP26FVS_485 = float3(dot(CP26FVS_457, CP26FVS_304), dot(CP26FVS_456, CP26FVS_304), dot(CP26FVS_455, CP26FVS_304));
        break;
    } while(false);
    // Original captured vertex streams and bone buffers preserve current/previous skinning.
    float4x4 captureObject=CP26FVS_LoadInstance(uint(CP26FVS_gl_InstanceIndex))._m0;
    float4x4 objectMatrix=_CP26UseCapturedProjection>0.5?captureObject:_CP26ObjectToWorld;
    float3x3 CP26FVS_494=(float3x3)objectMatrix;
    float3 CP26FVS_504=mul(CP26FVS_494,CP26FVS_484)+(objectMatrix._m03_m13_m23-CP26FVS_26_m11.xyz);
    float4 CP26FVS_511 = mul(CP26FVS_26_m8, float4(CP26FVS_504, 1.0f));
    float2 CP26FVS_519 = CP26FVS_511.xy - ((CP26FVS_28_m9.zw * float2(2.0f, -2.0f)) * CP26FVS_511.w);
    float3 CP26FVS_527 = mul(CP26FVS_494, CP26FVS_483);
    float CP26FVS_528 = dot(CP26FVS_527, CP26FVS_527);
    float3 CP26FVS_533 = mul(CP26FVS_494, CP26FVS_482.xyz);
    float CP26FVS_534 = dot(CP26FVS_533, CP26FVS_533);
    bool3 CP26FVS_547 = (CP26FVS_LoadInstance(uint(CP26FVS_gl_InstanceIndex))._m4.x < 1.0f).xxx;
    CP26FVS_14 = (CP26FVS_4 * CP26FVS_35_m28.xy) + CP26FVS_35_m28.zw;
    CP26FVS_15 = CP26FVS_504;
    CP26FVS_16 = CP26FVS_527 * rsqrt(isnan(CP26FVS_528) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? CP26FVS_528 : max(1.1754943508222875079687365372222e-38f, CP26FVS_528)));
    CP26FVS_17 = float4(CP26FVS_533 * rsqrt(isnan(CP26FVS_534) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? CP26FVS_534 : max(1.1754943508222875079687365372222e-38f, CP26FVS_534))), CP26FVS_482.w);
    CP26FVS_18 = CP26FVS_511.xyw;
    CP26FVS_19 = mul(CP26FVS_26_m15, float4(mul(float3x3(CP26FVS_LoadInstance(uint(CP26FVS_gl_InstanceIndex))._m3[0].xyz, CP26FVS_LoadInstance(uint(CP26FVS_gl_InstanceIndex))._m3[1].xyz, CP26FVS_LoadInstance(uint(CP26FVS_gl_InstanceIndex))._m3[2].xyz), float3(CP26FVS_547.x ? CP26FVS_484.x : CP26FVS_485.xyz.x, CP26FVS_547.y ? CP26FVS_484.y : CP26FVS_485.xyz.y, CP26FVS_547.z ? CP26FVS_484.z : CP26FVS_485.xyz.z)) + (float3(CP26FVS_LoadInstance(uint(CP26FVS_gl_InstanceIndex))._m3[0].w, CP26FVS_LoadInstance(uint(CP26FVS_gl_InstanceIndex))._m3[1].w, CP26FVS_LoadInstance(uint(CP26FVS_gl_InstanceIndex))._m3[2].w) - CP26FVS_26_m21.xyz), 1.0f)).xyw;
    CP26FVS_20 = float3(CP26FVS_294.x ? CP26FVS_285.x : CP26FVS_205.x, CP26FVS_294.y ? CP26FVS_285.y : CP26FVS_205.y, CP26FVS_294.z ? CP26FVS_285.z : CP26FVS_205.z);
    CP26FVS_21 = float4(CP26FVS_296.x ? CP26FVS_288.x : CP26FVS_208.x, CP26FVS_296.y ? CP26FVS_288.y : CP26FVS_208.y, CP26FVS_296.z ? CP26FVS_288.z : CP26FVS_208.z, CP26FVS_296.w ? CP26FVS_288.w : CP26FVS_208.w);
    CP26FVS_22 = CP26FVS_8;
    float4 CP26FVS_579 = float4(CP26FVS_519.x, CP26FVS_519.y, CP26FVS_511.z, CP26FVS_511.w);
    CP26FVS_579.y = -CP26FVS_519.y;
    CP26FVS_gl_Position=mul(_CP26ObjectToClip,float4(CP26FVS_484,1));
    if(_CP26UseSceneDepthGeometry>0.5) {float3 worldForDepth=mul(_CP26ObjectToWorld,float4(CP26FBakedPosition,1)).xyz;CP26FVS_gl_Position=mul(_CP26SceneVP,float4(worldForDepth,1));}
    // Captured Vulkan clip path; Unity RT convention reverses captured output Y.
    if(_CP26UseCapturedProjection>0.5) {CP26FVS_gl_Position=CP26FVS_579;CP26FVS_gl_Position.y=-CP26FVS_gl_Position.y;}
    CP26FVS_24 = uint(CP26FVS_gl_InstanceIndex);
}

CP26FVS_SPIRV_Cross_Output CP26FVS_main(CP26FVS_SPIRV_Cross_Input stage_input)
{
    CP26FVS_gl_InstanceIndex = int(stage_input.CP26FVS_gl_InstanceIndex);
    CP26FVS_3 = stage_input.CP26FVS_3;
    CP26FVS_4 = stage_input.CP26FVS_4;
    CP26FVS_5 = stage_input.CP26FVS_5;
    CP26FVS_6 = stage_input.CP26FVS_6;
    CP26FVS_7 = stage_input.CP26FVS_7;
    CP26FVS_8 = stage_input.CP26FVS_8;
    CP26FVS_9 = stage_input.CP26FVS_9;
    CP26FVS_10 = stage_input.CP26FVS_10;
    CP26FVS_12 = stage_input.CP26FVS_12;
    CP26FVS_13 = stage_input.CP26FVS_13;
    CP26FVS_vert_main();
    CP26FVS_SPIRV_Cross_Output stage_output;
    stage_output.CP26FVS_gl_Position = CP26FVS_gl_Position;
    stage_output.CP26FVS_14 = CP26FVS_14;
    stage_output.CP26FVS_15 = CP26FVS_15;
    stage_output.CP26FVS_16 = CP26FVS_16;
    stage_output.CP26FVS_17 = CP26FVS_17;
    stage_output.CP26FVS_18 = CP26FVS_18;
    stage_output.CP26FVS_19 = CP26FVS_19;
    stage_output.CP26FVS_20 = CP26FVS_20;
    stage_output.CP26FVS_21 = CP26FVS_21;
    stage_output.CP26FVS_22 = CP26FVS_22;
    stage_output.CP26FVS_24 = CP26FVS_24;
    return stage_output;
}
