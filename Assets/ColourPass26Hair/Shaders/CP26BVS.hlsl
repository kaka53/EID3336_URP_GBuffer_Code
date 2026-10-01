float _CP26UseSceneDepthGeometry;
float4x4 _CP26SceneVP;
float _CP26UseCapturedProjection;
float4x4 _CP26ObjectToWorld, _CP26ObjectToClip;
struct CP26BVS_25
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

cbuffer CP26BVS_20_21
{
    column_major float4x4 CP26BVS_21_m0 : packoffset(c0);
    column_major float4x4 CP26BVS_21_m1 : packoffset(c4);
    column_major float4x4 CP26BVS_21_m2 : packoffset(c8);
    column_major float4x4 CP26BVS_21_m3 : packoffset(c12);
    column_major float4x4 CP26BVS_21_m4 : packoffset(c16);
    column_major float4x4 CP26BVS_21_m5 : packoffset(c20);
    column_major float4x4 CP26BVS_21_m6 : packoffset(c24);
    column_major float4x4 CP26BVS_21_m7 : packoffset(c28);
    column_major float4x4 CP26BVS_21_m8 : packoffset(c32);
    column_major float4x4 CP26BVS_21_m9 : packoffset(c36);
    column_major float4x4 CP26BVS_21_m10 : packoffset(c40);
    float4 CP26BVS_21_m11 : packoffset(c44);
    column_major float4x4 CP26BVS_21_m12 : packoffset(c45);
    column_major float4x4 CP26BVS_21_m13 : packoffset(c49);
    column_major float4x4 CP26BVS_21_m14 : packoffset(c53);
    column_major float4x4 CP26BVS_21_m15 : packoffset(c57);
    column_major float4x4 CP26BVS_21_m16 : packoffset(c61);
    column_major float4x4 CP26BVS_21_m17 : packoffset(c65);
    column_major float4x4 CP26BVS_21_m18 : packoffset(c69);
    column_major float4x4 CP26BVS_21_m19 : packoffset(c73);
    column_major float4x4 CP26BVS_21_m20 : packoffset(c77);
    float4 CP26BVS_21_m21 : packoffset(c81);
};

cbuffer CP26BVS_22_23
{
    float4 CP26BVS_23_m0 : packoffset(c0);
    float4 CP26BVS_23_m1 : packoffset(c1);
    float4 CP26BVS_23_m2 : packoffset(c2);
    float4 CP26BVS_23_m3 : packoffset(c3);
    float4 CP26BVS_23_m4 : packoffset(c4);
    float4 CP26BVS_23_m5 : packoffset(c5);
    float4 CP26BVS_23_m6[6] : packoffset(c6);
    float4 CP26BVS_23_m7[6] : packoffset(c12);
    float4 CP26BVS_23_m8 : packoffset(c18);
    float4 CP26BVS_23_m9 : packoffset(c19);
    float4 CP26BVS_23_m10 : packoffset(c20);
    float4 CP26BVS_23_m11 : packoffset(c21);
    float4 CP26BVS_23_m12 : packoffset(c22);
    float4 CP26BVS_23_m13 : packoffset(c23);
    float4 CP26BVS_23_m14 : packoffset(c24);
    float4 CP26BVS_23_m15 : packoffset(c25);
    float CP26BVS_23_m16 : packoffset(c26);
    float CP26BVS_23_m17 : packoffset(c26.y);
    float CP26BVS_23_m18 : packoffset(c26.z);
    uint CP26BVS_23_m19 : packoffset(c26.w);
    float4 CP26BVS_23_m20 : packoffset(c27);
    int4 CP26BVS_23_m21 : packoffset(c28);
    float4 CP26BVS_23_m22 : packoffset(c29);
    float4 CP26BVS_23_m23 : packoffset(c30);
    float4 CP26BVS_23_m24 : packoffset(c31);
    float4 CP26BVS_23_m25 : packoffset(c32);
    float4 CP26BVS_23_m26 : packoffset(c33);
    float4 CP26BVS_23_m27 : packoffset(c34);
    float4 CP26BVS_23_m28 : packoffset(c35);
    float4 CP26BVS_23_m29 : packoffset(c36);
    float4 CP26BVS_23_m30 : packoffset(c37);
    float4 CP26BVS_23_m31 : packoffset(c38);
    float4 CP26BVS_23_m32[4] : packoffset(c39);
    float4 CP26BVS_23_m33[4] : packoffset(c43);
    float4 CP26BVS_23_m34[4] : packoffset(c47);
    float4 CP26BVS_23_m35[4] : packoffset(c51);
    float4 CP26BVS_23_m36 : packoffset(c55);
    float4 CP26BVS_23_m37 : packoffset(c56);
    float4 CP26BVS_23_m38[4] : packoffset(c57);
    float4 CP26BVS_23_m39[4] : packoffset(c61);
    float4 CP26BVS_23_m40[4] : packoffset(c65);
    float4 CP26BVS_23_m41 : packoffset(c69);
    float4 CP26BVS_23_m42 : packoffset(c70);
    float4 CP26BVS_23_m43 : packoffset(c71);
    float4 CP26BVS_23_m44 : packoffset(c72);
    float4 CP26BVS_23_m45 : packoffset(c73);
    float4 CP26BVS_23_m46 : packoffset(c74);
    float4 CP26BVS_23_m47 : packoffset(c75);
    float4 CP26BVS_23_m48 : packoffset(c76);
    float4 CP26BVS_23_m49 : packoffset(c77);
    float4 CP26BVS_23_m50 : packoffset(c78);
    float4 CP26BVS_23_m51 : packoffset(c79);
    float4 CP26BVS_23_m52 : packoffset(c80);
    float4 CP26BVS_23_m53 : packoffset(c81);
    float4 CP26BVS_23_m54 : packoffset(c82);
    float4 CP26BVS_23_m55 : packoffset(c83);
    float4 CP26BVS_23_m56 : packoffset(c84);
    float4 CP26BVS_23_m57 : packoffset(c85);
    float4 CP26BVS_23_m58 : packoffset(c86);
    float4 CP26BVS_23_m59 : packoffset(c87);
    float4 CP26BVS_23_m60 : packoffset(c88);
    float4 CP26BVS_23_m61 : packoffset(c89);
    float4 CP26BVS_23_m62 : packoffset(c90);
    float4 CP26BVS_23_m63 : packoffset(c91);
    float4 CP26BVS_23_m64 : packoffset(c92);
    float4 CP26BVS_23_m65 : packoffset(c93);
    float4 CP26BVS_23_m66 : packoffset(c94);
    float4 CP26BVS_23_m67 : packoffset(c95);
    float4 CP26BVS_23_m68 : packoffset(c96);
    float4 CP26BVS_23_m69 : packoffset(c97);
    float4 CP26BVS_23_m70 : packoffset(c98);
    float4 CP26BVS_23_m71 : packoffset(c99);
    float4 CP26BVS_23_m72 : packoffset(c100);
    float4 CP26BVS_23_m73 : packoffset(c101);
    float4 CP26BVS_23_m74 : packoffset(c102);
    float4 CP26BVS_23_m75 : packoffset(c103);
    float4 CP26BVS_23_m76 : packoffset(c104);
    float4 CP26BVS_23_m77 : packoffset(c105);
    float4 CP26BVS_23_m78 : packoffset(c106);
    float4 CP26BVS_23_m79 : packoffset(c107);
    float4 CP26BVS_23_m80 : packoffset(c108);
    float4 CP26BVS_23_m81 : packoffset(c109);
    float4 CP26BVS_23_m82 : packoffset(c110);
    float4 CP26BVS_23_m83 : packoffset(c111);
    float4 CP26BVS_23_m84 : packoffset(c112);
    float4 CP26BVS_23_m85 : packoffset(c113);
    float4 CP26BVS_23_m86 : packoffset(c114);
    float4 CP26BVS_23_m87 : packoffset(c115);
    float4 CP26BVS_23_m88 : packoffset(c116);
    float4 CP26BVS_23_m89 : packoffset(c117);
    float4 CP26BVS_23_m90 : packoffset(c118);
    float4 CP26BVS_23_m91 : packoffset(c119);
    float4 CP26BVS_23_m92 : packoffset(c120);
    float4 CP26BVS_23_m93 : packoffset(c121);
    float4 CP26BVS_23_m94 : packoffset(c122);
    float4 CP26BVS_23_m95 : packoffset(c123);
    float4 CP26BVS_23_m96 : packoffset(c124);
    float4 CP26BVS_23_m97 : packoffset(c125);
    float4 CP26BVS_23_m98 : packoffset(c126);
    float4 CP26BVS_23_m99[2] : packoffset(c127);
    float4 CP26BVS_23_m100[2] : packoffset(c129);
    float CP26BVS_23_m101 : packoffset(c131);
    float CP26BVS_23_m102 : packoffset(c131.y);
    float CP26BVS_23_m103 : packoffset(c131.z);
    float CP26BVS_23_m104 : packoffset(c131.w);
    float4 CP26BVS_23_m105 : packoffset(c132);
    float4 CP26BVS_23_m106 : packoffset(c133);
    float4 CP26BVS_23_m107 : packoffset(c134);
    float4 CP26BVS_23_m108 : packoffset(c135);
    float4 CP26BVS_23_m109 : packoffset(c136);
    float4 CP26BVS_23_m110 : packoffset(c137);
    float4 CP26BVS_23_m111 : packoffset(c138);
    float4 CP26BVS_23_m112 : packoffset(c139);
    float4 CP26BVS_23_m113 : packoffset(c140);
    float4 CP26BVS_23_m114 : packoffset(c141);
    float4 CP26BVS_23_m115 : packoffset(c142);
    float4 CP26BVS_23_m116 : packoffset(c143);
    float4 CP26BVS_23_m117 : packoffset(c144);
    float4 CP26BVS_23_m118 : packoffset(c145);
    float4 CP26BVS_23_m119 : packoffset(c146);
    float4 CP26BVS_23_m120 : packoffset(c147);
    float4 CP26BVS_23_m121 : packoffset(c148);
    float4 CP26BVS_23_m122 : packoffset(c149);
    float4 CP26BVS_23_m123 : packoffset(c150);
    float4 CP26BVS_23_m124 : packoffset(c151);
    float4 CP26BVS_23_m125 : packoffset(c152);
    float4 CP26BVS_23_m126 : packoffset(c153);
    float4 CP26BVS_23_m127 : packoffset(c154);
    float4 CP26BVS_23_m128 : packoffset(c155);
    float4 CP26BVS_23_m129 : packoffset(c156);
    float4 CP26BVS_23_m130 : packoffset(c157);
    float4 CP26BVS_23_m131 : packoffset(c158);
    float4 CP26BVS_23_m132 : packoffset(c159);
    float4 CP26BVS_23_m133 : packoffset(c160);
    float4 CP26BVS_23_m134 : packoffset(c161);
    column_major float4x4 CP26BVS_23_m135 : packoffset(c162);
    float4 CP26BVS_23_m136 : packoffset(c166);
    float4 CP26BVS_23_m137 : packoffset(c167);
    float4 CP26BVS_23_m138[32] : packoffset(c168);
};

cbuffer CP26BVS_24_26
{
    float4 CP26BVS_instanceRaw[4096] : packoffset(c0);
};

ByteAddressBuffer CP26BVS_31;
cbuffer CP26BVS_32_33
{
    float CP26BVS_33_m0 : packoffset(c0);
    float CP26BVS_33_m1 : packoffset(c0.y);
    float CP26BVS_33_m2 : packoffset(c0.z);
    float CP26BVS_33_m3 : packoffset(c0.w);
    float CP26BVS_33_m4 : packoffset(c1);
    float CP26BVS_33_m5 : packoffset(c1.y);
    float CP26BVS_33_m6 : packoffset(c1.z);
    float CP26BVS_33_m7 : packoffset(c1.w);
    float CP26BVS_33_m8 : packoffset(c2);
    float CP26BVS_33_m9 : packoffset(c2.y);
    float CP26BVS_33_m10 : packoffset(c2.z);
    float CP26BVS_33_m11 : packoffset(c2.w);
    float CP26BVS_33_m12 : packoffset(c3);
    float CP26BVS_33_m13 : packoffset(c3.y);
    float CP26BVS_33_m14 : packoffset(c3.z);
    float CP26BVS_33_m15 : packoffset(c3.w);
    float CP26BVS_33_m16 : packoffset(c4);
    float CP26BVS_33_m17 : packoffset(c4.y);
    float CP26BVS_33_m18 : packoffset(c4.z);
    float CP26BVS_33_m19 : packoffset(c4.w);
    float CP26BVS_33_m20 : packoffset(c5);
    float CP26BVS_33_m21 : packoffset(c5.y);
    float CP26BVS_33_m22 : packoffset(c5.z);
    float CP26BVS_33_m23 : packoffset(c5.w);
    float4 CP26BVS_33_m24 : packoffset(c6);
    float4 CP26BVS_33_m25 : packoffset(c7);
    float4 CP26BVS_33_m26 : packoffset(c8);
    float4 CP26BVS_33_m27 : packoffset(c9);
    float4 CP26BVS_33_m28 : packoffset(c10);
    float4 CP26BVS_33_m29 : packoffset(c11);
    float CP26BVS_33_m30 : packoffset(c12);
    float CP26BVS_33_m31 : packoffset(c12.y);
    float CP26BVS_33_m32 : packoffset(c12.z);
    float CP26BVS_33_m33 : packoffset(c12.w);
    float CP26BVS_33_m34 : packoffset(c13);
    float CP26BVS_33_m35 : packoffset(c13.y);
    float CP26BVS_33_m36 : packoffset(c13.z);
    float CP26BVS_33_m37 : packoffset(c13.w);
    float CP26BVS_33_m38 : packoffset(c14);
    float CP26BVS_33_m39 : packoffset(c14.y);
    float CP26BVS_33_m40 : packoffset(c14.z);
    float CP26BVS_33_m41 : packoffset(c14.w);
    float4 CP26BVS_33_m42 : packoffset(c15);
    float4 CP26BVS_33_m43 : packoffset(c16);
    float4 CP26BVS_33_m44 : packoffset(c17);
    float4 CP26BVS_33_m45 : packoffset(c18);
    float4 CP26BVS_33_m46 : packoffset(c19);
    float CP26BVS_33_m47 : packoffset(c20);
    float CP26BVS_33_m48 : packoffset(c20.y);
    float CP26BVS_33_m49 : packoffset(c20.z);
    float CP26BVS_33_m50 : packoffset(c20.w);
    float CP26BVS_33_m51 : packoffset(c21);
    float CP26BVS_33_m52 : packoffset(c21.y);
    float CP26BVS_33_m53 : packoffset(c21.z);
    float CP26BVS_33_m54 : packoffset(c21.w);
};

SamplerState CP26B_linear_repeat_sampler;
Texture2D<float4> CP26BVS_34;

static float4 CP26BVS_gl_Position;
static int CP26BVS_gl_InstanceIndex;
static float3 CP26BVS_3;
static float2 CP26BVS_4;
static float3 CP26BVS_5;
static float4 CP26BVS_6;
static float2 CP26BVS_7;
static float4 CP26BVS_8;
static float4 CP26BVS_10;
static uint4 CP26BVS_11;
static float2 CP26BVS_12;
static float3 CP26BVS_13;
static float3 CP26BVS_14;
static float3 CP26BVS_16;
static float3 CP26BVS_17;
static uint CP26BVS_19;

CP26BVS_25 CP26BVS_LoadInstance(uint index) {uint b=index*16;CP26BVS_25 x;
x._m0=transpose(float4x4(CP26BVS_instanceRaw[b],CP26BVS_instanceRaw[b+1],CP26BVS_instanceRaw[b+2],CP26BVS_instanceRaw[b+3]));x._m1=CP26BVS_instanceRaw[b+4];x._m2=CP26BVS_instanceRaw[b+5];x._m3=transpose(float4x4(CP26BVS_instanceRaw[b+6],CP26BVS_instanceRaw[b+7],CP26BVS_instanceRaw[b+8],CP26BVS_instanceRaw[b+9]));
x._m4=CP26BVS_instanceRaw[b+10];
x._m5=CP26BVS_instanceRaw[b+11];
x._m6=CP26BVS_instanceRaw[b+12];
x._m7=CP26BVS_instanceRaw[b+13];
x._m8=CP26BVS_instanceRaw[b+14];
x._m9=CP26BVS_instanceRaw[b+15];
return x;}

struct CP26BVS_SPIRV_Cross_Input
{
    float3 CP26BVS_3 : TEXCOORD0;
    float2 CP26BVS_4 : TEXCOORD1;
    float3 CP26BVS_5 : TEXCOORD2;
    float4 CP26BVS_6 : TEXCOORD3;
    float2 CP26BVS_7 : TEXCOORD4;
    float4 CP26BVS_8 : TEXCOORD5;
    float4 CP26BVS_10 : TEXCOORD6;
    uint4 CP26BVS_11 : TEXCOORD7;
    uint CP26BVS_gl_InstanceIndex : SV_InstanceID;
};

struct CP26BVS_SPIRV_Cross_Output
{
    float2 CP26BVS_12 : TEXCOORD0;
    float3 CP26BVS_13 : TEXCOORD1;
    float3 CP26BVS_14 : TEXCOORD2;
    float3 CP26BVS_16 : TEXCOORD4;
    float3 CP26BVS_17 : TEXCOORD5;
    nointerpolation uint CP26BVS_19 : TEXCOORD6;
    float4 CP26BVS_gl_Position : SV_Position;
};

static float4 CP26BVS_124;
static float3 CP26BBakedPosition;
static float3 CP26BBakedNormal;
static float4 CP26BBakedTangent;
float4x4 _CP26BLiveVP, _CP26BLiveP, _CP26BLiveView;
float4 _CP26BLiveScreen;

void CP26BVS_vert_main()
{
    uint CP26BVS_144 = asuint(CP26BVS_5.x);
    bool CP26BVS_146 = (CP26BVS_144 & 1073741824u) > 0u;
    float3 CP26BVS_219;
    float4 CP26BVS_220;
    if (CP26BVS_146)
    {
        float CP26BVS_152 = float((CP26BVS_144 << 22u) >> 22u);
        float CP26BVS_155 = float((CP26BVS_144 << 12u) >> 22u);
        float CP26BVS_158 = float((CP26BVS_144 << 2u) >> 22u);
        float3 CP26BVS_172 = float3((CP26BVS_152 >= 512.0f) ? (CP26BVS_152 - 1024.0f) : CP26BVS_152, (CP26BVS_155 >= 512.0f) ? (CP26BVS_155 - 1024.0f) : CP26BVS_155, 0.0f) * 0.001956947147846221923828125f;
        float CP26BVS_178 = (1.0f - abs(CP26BVS_172.x)) - abs(CP26BVS_172.y);
        float3 CP26BVS_179 = CP26BVS_172;
        CP26BVS_179.z = CP26BVS_178;
        bool2 CP26BVS_181 = (CP26BVS_178 < 0.0f).xx;
        float2 CP26BVS_189 = (1.0f.xx - abs(CP26BVS_179.yx)) * ((step(0.0f.xx, CP26BVS_179.xy) * 2.0f) - 1.0f.xx);
        float2 CP26BVS_190 = float2(CP26BVS_181.x ? CP26BVS_189.x : CP26BVS_179.xy.x, CP26BVS_181.y ? CP26BVS_189.y : CP26BVS_179.xy.y);
        float3 CP26BVS_192 = normalize(float3(CP26BVS_190.x, CP26BVS_190.y, CP26BVS_179.z));
        float CP26BVS_193 = ((CP26BVS_158 >= 512.0f) ? (CP26BVS_158 - 1024.0f) : CP26BVS_158) * 0.001956947147846221923828125f;
        float3 CP26BVS_196 = CP26BVS_192.yzx - CP26BVS_192.zxy;
        float3 CP26BVS_200 = normalize(CP26BVS_196 - dot(CP26BVS_196, CP26BVS_192).xxx);
        float CP26BVS_204 = (CP26BVS_193 < 0.0f) ? (-1.0f) : 1.0f;
        float CP26BVS_207 = 1.0f - ((CP26BVS_193 * CP26BVS_204) * 2.0f);
        float3 CP26BVS_214 = mul(normalize(float2(CP26BVS_207, CP26BVS_204 * (1.0f - abs(CP26BVS_207)))), float2x3(CP26BVS_200, normalize(cross(CP26BVS_192, CP26BVS_200))));
        float4 CP26BVS_218 = float4(CP26BVS_214.x, CP26BVS_214.y, CP26BVS_214.z, CP26BVS_124.w);
        CP26BVS_218.w = (float((CP26BVS_144 >> 31u) & 1u) * 2.0f) - 1.0f;
        CP26BVS_219 = CP26BVS_192;
        CP26BVS_220 = CP26BVS_218;
    }
    else
    {
        CP26BVS_219 = CP26BVS_5;
        CP26BVS_220 = 0.0f.xxxx;
    }
    bool4 CP26BVS_221 = CP26BVS_146.xxxx;
    float4 CP26BVS_222 = float4(CP26BVS_221.x ? CP26BVS_220.x : CP26BVS_6.x, CP26BVS_221.y ? CP26BVS_220.y : CP26BVS_6.y, CP26BVS_221.z ? CP26BVS_220.z : CP26BVS_6.z, CP26BVS_221.w ? CP26BVS_220.w : CP26BVS_6.w);
    float4 CP26BVS_410;
    float3 CP26BVS_411;
    float3 CP26BVS_412;
    float3 CP26BVS_413;
    do
    {
        float4 CP26BVS_229 = float4(CP26BVS_3, 1.0f);
        uint CP26BVS_232 = asuint(CP26BVS_LoadInstance(uint(CP26BVS_gl_InstanceIndex))._m1.w);
        uint CP26BVS_233 = CP26BVS_232 & 4294967247u;
        if (((CP26BVS_232 & 32u) == 0u) || (CP26BVS_233 == 0u))
        {
            CP26BVS_410 = CP26BVS_222;
            CP26BVS_411 = CP26BVS_219;
            CP26BVS_412 = CP26BVS_3;
            CP26BVS_413 = CP26BVS_8.xyz;
            break;
        }
        uint4 CP26BVS_249 = CP26BVS_11 * uint4(3u, 3u, 3u, 3u);
        uint4 CP26BVS_250 = (asuint(CP26BVS_LoadInstance(uint(CP26BVS_gl_InstanceIndex))._m2.x) + 3u).xxxx + CP26BVS_249;
        uint4 CP26BVS_252 = (asuint(CP26BVS_LoadInstance(uint(CP26BVS_gl_InstanceIndex))._m2.y) + 3u).xxxx + CP26BVS_249;
        uint CP26BVS_253 = CP26BVS_250.x;
        uint CP26BVS_256 = CP26BVS_253 + 1u;
        uint CP26BVS_259 = CP26BVS_253 + 2u;
        uint CP26BVS_262 = CP26BVS_252.x;
        uint CP26BVS_265 = CP26BVS_262 + 1u;
        uint CP26BVS_268 = CP26BVS_262 + 2u;
        float4 CP26BVS_312;
        float4 CP26BVS_313;
        float4 CP26BVS_314;
        float4 CP26BVS_315;
        float4 CP26BVS_316;
        float4 CP26BVS_317;
        if (CP26BVS_233 >= 2u)
        {
            uint CP26BVS_276 = CP26BVS_250.y;
            uint CP26BVS_295 = CP26BVS_252.y;
            CP26BVS_312 = (asfloat(CP26BVS_31.Load4(CP26BVS_268 * 16 + 0)) * CP26BVS_10.x) + (asfloat(CP26BVS_31.Load4((CP26BVS_295 + 2u) * 16 + 0)) * CP26BVS_10.y);
            CP26BVS_313 = (asfloat(CP26BVS_31.Load4(CP26BVS_265 * 16 + 0)) * CP26BVS_10.x) + (asfloat(CP26BVS_31.Load4((CP26BVS_295 + 1u) * 16 + 0)) * CP26BVS_10.y);
            CP26BVS_314 = (asfloat(CP26BVS_31.Load4(CP26BVS_262 * 16 + 0)) * CP26BVS_10.x) + (asfloat(CP26BVS_31.Load4(CP26BVS_295 * 16 + 0)) * CP26BVS_10.y);
            CP26BVS_315 = (asfloat(CP26BVS_31.Load4(CP26BVS_259 * 16 + 0)) * CP26BVS_10.x) + (asfloat(CP26BVS_31.Load4((CP26BVS_276 + 2u) * 16 + 0)) * CP26BVS_10.y);
            CP26BVS_316 = (asfloat(CP26BVS_31.Load4(CP26BVS_256 * 16 + 0)) * CP26BVS_10.x) + (asfloat(CP26BVS_31.Load4((CP26BVS_276 + 1u) * 16 + 0)) * CP26BVS_10.y);
            CP26BVS_317 = (asfloat(CP26BVS_31.Load4(CP26BVS_253 * 16 + 0)) * CP26BVS_10.x) + (asfloat(CP26BVS_31.Load4(CP26BVS_276 * 16 + 0)) * CP26BVS_10.y);
        }
        else
        {
            CP26BVS_312 = asfloat(CP26BVS_31.Load4(CP26BVS_268 * 16 + 0));
            CP26BVS_313 = asfloat(CP26BVS_31.Load4(CP26BVS_265 * 16 + 0));
            CP26BVS_314 = asfloat(CP26BVS_31.Load4(CP26BVS_262 * 16 + 0));
            CP26BVS_315 = asfloat(CP26BVS_31.Load4(CP26BVS_259 * 16 + 0));
            CP26BVS_316 = asfloat(CP26BVS_31.Load4(CP26BVS_256 * 16 + 0));
            CP26BVS_317 = asfloat(CP26BVS_31.Load4(CP26BVS_253 * 16 + 0));
        }
        float4 CP26BVS_383;
        float4 CP26BVS_384;
        float4 CP26BVS_385;
        float4 CP26BVS_386;
        float4 CP26BVS_387;
        float4 CP26BVS_388;
        if (CP26BVS_233 >= 4u)
        {
            uint CP26BVS_321 = CP26BVS_250.z;
            uint CP26BVS_326 = CP26BVS_250.w;
            uint CP26BVS_353 = CP26BVS_252.z;
            uint CP26BVS_357 = CP26BVS_252.w;
            CP26BVS_383 = CP26BVS_312 + ((asfloat(CP26BVS_31.Load4((CP26BVS_353 + 2u) * 16 + 0)) * CP26BVS_10.z) + (asfloat(CP26BVS_31.Load4((CP26BVS_357 + 2u) * 16 + 0)) * CP26BVS_10.w));
            CP26BVS_384 = CP26BVS_313 + ((asfloat(CP26BVS_31.Load4((CP26BVS_353 + 1u) * 16 + 0)) * CP26BVS_10.z) + (asfloat(CP26BVS_31.Load4((CP26BVS_357 + 1u) * 16 + 0)) * CP26BVS_10.w));
            CP26BVS_385 = CP26BVS_314 + ((asfloat(CP26BVS_31.Load4(CP26BVS_353 * 16 + 0)) * CP26BVS_10.z) + (asfloat(CP26BVS_31.Load4(CP26BVS_357 * 16 + 0)) * CP26BVS_10.w));
            CP26BVS_386 = CP26BVS_315 + ((asfloat(CP26BVS_31.Load4((CP26BVS_321 + 2u) * 16 + 0)) * CP26BVS_10.z) + (asfloat(CP26BVS_31.Load4((CP26BVS_326 + 2u) * 16 + 0)) * CP26BVS_10.w));
            CP26BVS_387 = CP26BVS_316 + ((asfloat(CP26BVS_31.Load4((CP26BVS_321 + 1u) * 16 + 0)) * CP26BVS_10.z) + (asfloat(CP26BVS_31.Load4((CP26BVS_326 + 1u) * 16 + 0)) * CP26BVS_10.w));
            CP26BVS_388 = CP26BVS_317 + ((asfloat(CP26BVS_31.Load4(CP26BVS_321 * 16 + 0)) * CP26BVS_10.z) + (asfloat(CP26BVS_31.Load4(CP26BVS_326 * 16 + 0)) * CP26BVS_10.w));
        }
        else
        {
            CP26BVS_383 = CP26BVS_312;
            CP26BVS_384 = CP26BVS_313;
            CP26BVS_385 = CP26BVS_314;
            CP26BVS_386 = CP26BVS_315;
            CP26BVS_387 = CP26BVS_316;
            CP26BVS_388 = CP26BVS_317;
        }
        float3 CP26BVS_404 = CP26BVS_222.xyz;
        float3 CP26BVS_408 = float3(dot(CP26BVS_388.xyz, CP26BVS_404), dot(CP26BVS_387.xyz, CP26BVS_404), dot(CP26BVS_386.xyz, CP26BVS_404));
        CP26BVS_410 = float4(CP26BVS_408.x, CP26BVS_408.y, CP26BVS_408.z, CP26BVS_222.w);
        CP26BVS_411 = float3(dot(CP26BVS_388.xyz, CP26BVS_219), dot(CP26BVS_387.xyz, CP26BVS_219), dot(CP26BVS_386.xyz, CP26BVS_219));
        CP26BVS_412 = float3(dot(CP26BVS_388, CP26BVS_229), dot(CP26BVS_387, CP26BVS_229), dot(CP26BVS_386, CP26BVS_229));
        CP26BVS_413 = float3(dot(CP26BVS_385, CP26BVS_229), dot(CP26BVS_384, CP26BVS_229), dot(CP26BVS_383, CP26BVS_229));
        break;
    } while(false);
    // Original captured vertex streams and bone buffers preserve current/previous skinning.
    float4x4 captureObject=CP26BVS_LoadInstance(uint(CP26BVS_gl_InstanceIndex))._m0;
    float4x4 objectMatrix=_CP26UseCapturedProjection>0.5?captureObject:_CP26ObjectToWorld;
    float3x3 CP26BVS_422=(float3x3)objectMatrix;
    float3 CP26BVS_432=mul(CP26BVS_422,CP26BVS_412)+(objectMatrix._m03_m13_m23-CP26BVS_21_m11.xyz);
    float4 CP26BVS_439 = mul(CP26BVS_21_m8, float4(CP26BVS_432, 1.0f));
    float CP26BVS_444 = CP26BVS_439.w;
    float2 CP26BVS_453 = (CP26BVS_4 * CP26BVS_33_m28.xy) + CP26BVS_33_m28.zw;
    float3 CP26BVS_454 = mul(CP26BVS_422, CP26BVS_411);
    float CP26BVS_455 = dot(CP26BVS_454, CP26BVS_454);
    float3 CP26BVS_458 = CP26BVS_454 * rsqrt(isnan(CP26BVS_455) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? CP26BVS_455 : max(1.1754943508222875079687365372222e-38f, CP26BVS_455)));
    float3 CP26BVS_460 = mul(CP26BVS_422, CP26BVS_410.xyz);
    float CP26BVS_461 = dot(CP26BVS_460, CP26BVS_460);
    bool3 CP26BVS_473 = (CP26BVS_LoadInstance(uint(CP26BVS_gl_InstanceIndex))._m4.x < 1.0f).xxx;
    float4 CP26BVS_501 = mul(CP26BVS_21_m15, float4(mul(float3x3(CP26BVS_LoadInstance(uint(CP26BVS_gl_InstanceIndex))._m3[0].xyz, CP26BVS_LoadInstance(uint(CP26BVS_gl_InstanceIndex))._m3[1].xyz, CP26BVS_LoadInstance(uint(CP26BVS_gl_InstanceIndex))._m3[2].xyz), float3(CP26BVS_473.x ? CP26BVS_412.x : CP26BVS_413.xyz.x, CP26BVS_473.y ? CP26BVS_412.y : CP26BVS_413.xyz.y, CP26BVS_473.z ? CP26BVS_412.z : CP26BVS_413.xyz.z)) + (float3(CP26BVS_LoadInstance(uint(CP26BVS_gl_InstanceIndex))._m3[0].w, CP26BVS_LoadInstance(uint(CP26BVS_gl_InstanceIndex))._m3[1].w, CP26BVS_LoadInstance(uint(CP26BVS_gl_InstanceIndex))._m3[2].w) - CP26BVS_21_m21.xyz), 1.0f));
    float3 CP26BVS_521;
    if (CP26BVS_33_m38 > 0.5f)
    {
        float3 CP26BVS_509 = float3(CP26BVS_7, 0.0f);
        float2 CP26BVS_510 = CP26BVS_509.xy;
        float3 CP26BVS_515 = CP26BVS_509;
        CP26BVS_515.z = sqrt(1.0f - clamp(dot(CP26BVS_510, CP26BVS_510), 0.0f, 1.0f));
        float3 CP26BVS_516 = float4(CP26BVS_460 * rsqrt(isnan(CP26BVS_461) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? CP26BVS_461 : max(1.1754943508222875079687365372222e-38f, CP26BVS_461))), CP26BVS_410.w).xyz;
        CP26BVS_521 = mul(CP26BVS_515, float3x3(CP26BVS_516, cross(CP26BVS_458, CP26BVS_516) * CP26BVS_410.w, CP26BVS_458));
    }
    else
    {
        CP26BVS_521 = CP26BVS_458;
    }
    float4 CP26BVS_533 = CP26BVS_34.SampleLevel(CP26B_linear_repeat_sampler, CP26BVS_453, 0.0f);
    float CP26BVS_538 = CP26BVS_33_m35 * CP26BVS_533.y;
    float CP26BVS_542 = (-1.0f) / CP26BVS_21_m2[1].y;
    float CP26BVS_543 = abs(CP26BVS_542);
    bool CP26BVS_544 = CP26BVS_543 < 1.0f;
    float CP26BVS_546 = CP26BVS_544 ? CP26BVS_543 : (1.0f / CP26BVS_543);
    float CP26BVS_547 = CP26BVS_546 * CP26BVS_546;
    float CP26BVS_552 = (1.0f + (((-0.3018949925899505615234375f) + (0.087292902171611785888671875f * CP26BVS_547)) * CP26BVS_547)) * CP26BVS_546;
    float CP26BVS_554 = CP26BVS_544 ? CP26BVS_552 : (1.57079637050628662109375f - CP26BVS_552);
    float CP26BVS_557 = (CP26BVS_542 < 0.0f) ? (-CP26BVS_554) : CP26BVS_554;
    float2 CP26BVS_578 = (((normalize(mul(float3x3(CP26BVS_21_m8[0].xyz, CP26BVS_21_m8[1].xyz, CP26BVS_21_m8[2].xyz), CP26BVS_521).xy) * float2(CP26BVS_23_m1.y / CP26BVS_23_m1.x, 1.0f)) * (CP26BVS_33_m34 * (0.3926990330219268798828125f / CP26BVS_557))) * clamp((CP26BVS_444 * (CP26BVS_557 * 114.5915679931640625f)) * 0.039999999105930328369140625f, 0.0f, 1.0f)) * 0.004999999888241291046142578125f;
    float2 CP26BVS_583 = CP26BVS_23_m1.zw * clamp(CP26BVS_444, 0.0f, 1.57079613208770751953125f / CP26BVS_557);
    float2 CP26BVS_584 = abs(CP26BVS_578);
    bool2 CP26BVS_585 = bool2(CP26BVS_584.x < CP26BVS_583.x, CP26BVS_584.y < CP26BVS_583.y);
    float2 CP26BVS_589 = CP26BVS_583 * float2(int2(sign(CP26BVS_578)));
    float2 CP26BVS_591 = float2(CP26BVS_585.x ? CP26BVS_589.x : CP26BVS_578.x, CP26BVS_585.y ? CP26BVS_589.y : CP26BVS_578.y) * CP26BVS_533.x;
    float2 CP26BVS_593 = (CP26BVS_439.xy - ((CP26BVS_23_m9.zw * float2(2.0f, -2.0f)) * CP26BVS_444)).xy + CP26BVS_591;
    float4 CP26BVS_594 = float4(CP26BVS_593.x, CP26BVS_593.y, CP26BVS_439.z, CP26BVS_439.w);
    float4 CP26BVS_620;
    if (CP26BVS_23_m4.w == 0.0f)
    {
        float CP26BVS_611 = (-CP26BVS_444) + (CP26BVS_538 * (-0.100000001490116119384765625f));
        float4 CP26BVS_619 = CP26BVS_594;
        CP26BVS_619.z = (((CP26BVS_611 * CP26BVS_21_m2[2].z) + CP26BVS_21_m2[2].w) * CP26BVS_444) / (-CP26BVS_611);
        CP26BVS_620 = CP26BVS_619;
    }
    else
    {
        float4 CP26BVS_607 = CP26BVS_594;
        CP26BVS_607.z = CP26BVS_439.z + ((CP26BVS_538 * (-0.100000001490116119384765625f)) / CP26BVS_23_m3.z);
        CP26BVS_620 = CP26BVS_607;
    }
    float2 CP26BVS_622 = CP26BVS_439.xy + CP26BVS_591;
    float2 CP26BVS_625 = CP26BVS_501.xy + CP26BVS_591;
    CP26BVS_12 = CP26BVS_453;
    CP26BVS_13 = CP26BVS_432;
    CP26BVS_14 = CP26BVS_458;
    CP26BVS_16 = float3(CP26BVS_622.x, CP26BVS_622.y, CP26BVS_439.w);
    CP26BVS_17 = float3(CP26BVS_625.x, CP26BVS_625.y, CP26BVS_501.w);
    float4 CP26BVS_629 = CP26BVS_620;
    CP26BVS_629.y = -CP26BVS_620.y;
    float3 world=mul(_CP26ObjectToWorld,float4(_CP26UseSceneDepthGeometry>0.5?CP26BBakedPosition:CP26BVS_412,1)).xyz;
    float4 baseClip=mul(_CP26BLiveVP,float4(world,1));
    float3 normalClip=mul((float3x3)_CP26BLiveVP,CP26BVS_521);
    float q=abs(1.0/_CP26BLiveP._m11); bool small=q<1;float x=small?q:1/q;float x2=x*x;
    float f=(1+(-0.30189499258995056+0.08729290217161179*x2)*x2)*x;
    float halfFov=small?f:1.5707963705062866-f;
    float2 xy=normalClip.xy;float len=max(dot(xy,xy),1e-20);xy*=rsqrt(len);
    float2 delta=xy*float2(_CP26BLiveScreen.y/_CP26BLiveScreen.x,1)*(CP26BVS_33_m34*(0.39269903302192688/halfFov))*saturate(baseClip.w*(halfFov*114.59156799316406)*0.03999999910593033)*0.004999999888241291;
    float2 minimum=_CP26BLiveScreen.zw*clamp(baseClip.w,0,1.5707961320877075/halfFov);
    delta=max(abs(delta),minimum)*sign(delta)*CP26BVS_533.x;
    float4 result=baseClip;result.xy+=delta;
    float3 view=mul(_CP26BLiveView,float4(world,1)).xyz;
    view.z-=(CP26BVS_33_m35*CP26BVS_533.y)*0.10000000149011612;
    float4 displaced=mul(_CP26BLiveP,float4(view,1));
    result.z=(displaced.z/displaced.w)*baseClip.w;
    CP26BVS_gl_Position=result;
    // Captured Vulkan clip path; Unity RT convention reverses captured output Y.
    if(_CP26UseCapturedProjection>0.5) {CP26BVS_gl_Position=CP26BVS_629;CP26BVS_gl_Position.y=-CP26BVS_gl_Position.y;}
    CP26BVS_19 = uint(CP26BVS_gl_InstanceIndex);
}

CP26BVS_SPIRV_Cross_Output CP26BVS_main(CP26BVS_SPIRV_Cross_Input stage_input)
{
    CP26BVS_gl_InstanceIndex = int(stage_input.CP26BVS_gl_InstanceIndex);
    CP26BVS_3 = stage_input.CP26BVS_3;
    CP26BVS_4 = stage_input.CP26BVS_4;
    CP26BVS_5 = stage_input.CP26BVS_5;
    CP26BVS_6 = stage_input.CP26BVS_6;
    CP26BVS_7 = stage_input.CP26BVS_7;
    CP26BVS_8 = stage_input.CP26BVS_8;
    CP26BVS_10 = stage_input.CP26BVS_10;
    CP26BVS_11 = stage_input.CP26BVS_11;
    CP26BVS_vert_main();
    CP26BVS_SPIRV_Cross_Output stage_output;
    stage_output.CP26BVS_gl_Position = CP26BVS_gl_Position;
    stage_output.CP26BVS_12 = CP26BVS_12;
    stage_output.CP26BVS_13 = CP26BVS_13;
    stage_output.CP26BVS_14 = CP26BVS_14;
    stage_output.CP26BVS_16 = CP26BVS_16;
    stage_output.CP26BVS_17 = CP26BVS_17;
    stage_output.CP26BVS_19 = CP26BVS_19;
    return stage_output;
}
