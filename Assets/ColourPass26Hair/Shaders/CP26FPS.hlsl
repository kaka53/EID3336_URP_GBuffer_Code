struct CP26FPS_22
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

static const float2 CP26FPS_476[16] = { float2(-0.94201624393463134765625f, -0.39906215667724609375f), float2(0.94558608531951904296875f, -0.768907248973846435546875f), float2(-0.094184100627899169921875f, -0.929388701915740966796875f), float2(0.34495937824249267578125f, 0.29387760162353515625f), float2(-0.91588580608367919921875f, 0.4577143192291259765625f), float2(-0.8154423236846923828125f, -0.87912464141845703125f), float2(-0.38277542591094970703125f, 0.2767684459686279296875f), float2(0.9748439788818359375f, 0.7564837932586669921875f), float2(0.4432332515716552734375f, -0.9751155376434326171875f), float2(0.5374298095703125f, -0.473734200000762939453125f), float2(-0.2649691104888916015625f, -0.418930232524871826171875f), float2(0.79197514057159423828125f, 0.19090187549591064453125f), float2(-0.24188840389251708984375f, 0.997065067291259765625f), float2(-0.8140995502471923828125f, 0.91437590122222900390625f), float2(0.1998412609100341796875f, 0.786413669586181640625f), float2(0.14383161067962646484375f, -0.141007900238037109375f) };
static const float2 CP26FPS_477[16] = { float2(-0.3996559083461761474609375f, 0.91666519641876220703125f), float2(0.12451229989528656005859375f, -0.992218077182769775390625f), float2(0.8523542881011962890625f, 0.5229647159576416015625f), float2(-0.22931249439716339111328125f, 0.973352909088134765625f), float2(-0.772406101226806640625f, 0.63512897491455078125f), float2(0.7927525043487548828125f, -0.60954368114471435546875f), float2(-0.578049719333648681640625f, 0.816001594066619873046875f), float2(-0.831129610538482666015625f, -0.55607879161834716796875f), float2(0.8077948093414306640625f, 0.589463770389556884765625f), float2(0.47141540050506591796875f, 0.88191127777099609375f), float2(-0.3139738142490386962890625f, -0.949431717395782470703125f), float2(-0.94500672817230224609375f, -0.3270510137081146240234375f), float2(-0.1850374042987823486328125f, -0.982731521129608154296875f), float2(-0.9337558746337890625f, 0.35791051387786865234375f), float2(-0.997614085674285888671875f, 0.069036297500133514404296875f), float2(0.3061277866363525390625f, 0.951990425586700439453125f) };
static const int2 CP26FPS_478[6] = { int2(2, 1), int2(2, 1), int2(0, 2), int2(0, 2), int2(0, 1), int2(0, 1) };
static const float2 CP26FPS_479[6] = { float2(-1.0f, 1.0f), 1.0f.xx, float2(1.0f, -1.0f), 1.0f.xx, 1.0f.xx, float2(-1.0f, 1.0f) };

cbuffer CP26FPS_17_18
{
    column_major float4x4 CP26FPS_18_m0 : packoffset(c0);
    column_major float4x4 CP26FPS_18_m1 : packoffset(c4);
    column_major float4x4 CP26FPS_18_m2 : packoffset(c8);
    column_major float4x4 CP26FPS_18_m3 : packoffset(c12);
    column_major float4x4 CP26FPS_18_m4 : packoffset(c16);
    column_major float4x4 CP26FPS_18_m5 : packoffset(c20);
    column_major float4x4 CP26FPS_18_m6 : packoffset(c24);
    column_major float4x4 CP26FPS_18_m7 : packoffset(c28);
    column_major float4x4 CP26FPS_18_m8 : packoffset(c32);
    column_major float4x4 CP26FPS_18_m9 : packoffset(c36);
    column_major float4x4 CP26FPS_18_m10 : packoffset(c40);
    float4 CP26FPS_18_m11 : packoffset(c44);
    column_major float4x4 CP26FPS_18_m12 : packoffset(c45);
    column_major float4x4 CP26FPS_18_m13 : packoffset(c49);
    column_major float4x4 CP26FPS_18_m14 : packoffset(c53);
    column_major float4x4 CP26FPS_18_m15 : packoffset(c57);
    column_major float4x4 CP26FPS_18_m16 : packoffset(c61);
    column_major float4x4 CP26FPS_18_m17 : packoffset(c65);
    column_major float4x4 CP26FPS_18_m18 : packoffset(c69);
    column_major float4x4 CP26FPS_18_m19 : packoffset(c73);
    column_major float4x4 CP26FPS_18_m20 : packoffset(c77);
    float4 CP26FPS_18_m21 : packoffset(c81);
};

cbuffer CP26FPS_19_20
{
    float4 CP26FPS_20_m0 : packoffset(c0);
    float4 CP26FPS_20_m1 : packoffset(c1);
    float4 CP26FPS_20_m2 : packoffset(c2);
    float4 CP26FPS_20_m3 : packoffset(c3);
    float4 CP26FPS_20_m4 : packoffset(c4);
    float4 CP26FPS_20_m5 : packoffset(c5);
    float4 CP26FPS_20_m6[6] : packoffset(c6);
    float4 CP26FPS_20_m7[6] : packoffset(c12);
    float4 CP26FPS_20_m8 : packoffset(c18);
    float4 CP26FPS_20_m9 : packoffset(c19);
    float4 CP26FPS_20_m10 : packoffset(c20);
    float4 CP26FPS_20_m11 : packoffset(c21);
    float4 CP26FPS_20_m12 : packoffset(c22);
    float4 CP26FPS_20_m13 : packoffset(c23);
    float4 CP26FPS_20_m14 : packoffset(c24);
    float4 CP26FPS_20_m15 : packoffset(c25);
    float CP26FPS_20_m16 : packoffset(c26);
    float CP26FPS_20_m17 : packoffset(c26.y);
    float CP26FPS_20_m18 : packoffset(c26.z);
    uint CP26FPS_20_m19 : packoffset(c26.w);
    float4 CP26FPS_20_m20 : packoffset(c27);
    int4 CP26FPS_20_m21 : packoffset(c28);
    float4 CP26FPS_20_m22 : packoffset(c29);
    float4 CP26FPS_20_m23 : packoffset(c30);
    float4 CP26FPS_20_m24 : packoffset(c31);
    float4 CP26FPS_20_m25 : packoffset(c32);
    float4 CP26FPS_20_m26 : packoffset(c33);
    float4 CP26FPS_20_m27 : packoffset(c34);
    float4 CP26FPS_20_m28 : packoffset(c35);
    float4 CP26FPS_20_m29 : packoffset(c36);
    float4 CP26FPS_20_m30 : packoffset(c37);
    float4 CP26FPS_20_m31 : packoffset(c38);
    float4 CP26FPS_20_m32[4] : packoffset(c39);
    float4 CP26FPS_20_m33[4] : packoffset(c43);
    float4 CP26FPS_20_m34[4] : packoffset(c47);
    float4 CP26FPS_20_m35[4] : packoffset(c51);
    float4 CP26FPS_20_m36 : packoffset(c55);
    float4 CP26FPS_20_m37 : packoffset(c56);
    float4 CP26FPS_20_m38[4] : packoffset(c57);
    float4 CP26FPS_20_m39[4] : packoffset(c61);
    float4 CP26FPS_20_m40[4] : packoffset(c65);
    float4 CP26FPS_20_m41 : packoffset(c69);
    float4 CP26FPS_20_m42 : packoffset(c70);
    float4 CP26FPS_20_m43 : packoffset(c71);
    float4 CP26FPS_20_m44 : packoffset(c72);
    float4 CP26FPS_20_m45 : packoffset(c73);
    float4 CP26FPS_20_m46 : packoffset(c74);
    float4 CP26FPS_20_m47 : packoffset(c75);
    float4 CP26FPS_20_m48 : packoffset(c76);
    float4 CP26FPS_20_m49 : packoffset(c77);
    float4 CP26FPS_20_m50 : packoffset(c78);
    float4 CP26FPS_20_m51 : packoffset(c79);
    float4 CP26FPS_20_m52 : packoffset(c80);
    float4 CP26FPS_20_m53 : packoffset(c81);
    float4 CP26FPS_20_m54 : packoffset(c82);
    float4 CP26FPS_20_m55 : packoffset(c83);
    float4 CP26FPS_20_m56 : packoffset(c84);
    float4 CP26FPS_20_m57 : packoffset(c85);
    float4 CP26FPS_20_m58 : packoffset(c86);
    float4 CP26FPS_20_m59 : packoffset(c87);
    float4 CP26FPS_20_m60 : packoffset(c88);
    float4 CP26FPS_20_m61 : packoffset(c89);
    float4 CP26FPS_20_m62 : packoffset(c90);
    float4 CP26FPS_20_m63 : packoffset(c91);
    float4 CP26FPS_20_m64 : packoffset(c92);
    float4 CP26FPS_20_m65 : packoffset(c93);
    float4 CP26FPS_20_m66 : packoffset(c94);
    float4 CP26FPS_20_m67 : packoffset(c95);
    float4 CP26FPS_20_m68 : packoffset(c96);
    float4 CP26FPS_20_m69 : packoffset(c97);
    float4 CP26FPS_20_m70 : packoffset(c98);
    float4 CP26FPS_20_m71 : packoffset(c99);
    float4 CP26FPS_20_m72 : packoffset(c100);
    float4 CP26FPS_20_m73 : packoffset(c101);
    float4 CP26FPS_20_m74 : packoffset(c102);
    float4 CP26FPS_20_m75 : packoffset(c103);
    float4 CP26FPS_20_m76 : packoffset(c104);
    float4 CP26FPS_20_m77 : packoffset(c105);
    float4 CP26FPS_20_m78 : packoffset(c106);
    float4 CP26FPS_20_m79 : packoffset(c107);
    float4 CP26FPS_20_m80 : packoffset(c108);
    float4 CP26FPS_20_m81 : packoffset(c109);
    float4 CP26FPS_20_m82 : packoffset(c110);
    float4 CP26FPS_20_m83 : packoffset(c111);
    float4 CP26FPS_20_m84 : packoffset(c112);
    float4 CP26FPS_20_m85 : packoffset(c113);
    float4 CP26FPS_20_m86 : packoffset(c114);
    float4 CP26FPS_20_m87 : packoffset(c115);
    float4 CP26FPS_20_m88 : packoffset(c116);
    float4 CP26FPS_20_m89 : packoffset(c117);
    float4 CP26FPS_20_m90 : packoffset(c118);
    float4 CP26FPS_20_m91 : packoffset(c119);
    float4 CP26FPS_20_m92 : packoffset(c120);
    float4 CP26FPS_20_m93 : packoffset(c121);
    float4 CP26FPS_20_m94 : packoffset(c122);
    float4 CP26FPS_20_m95 : packoffset(c123);
    float4 CP26FPS_20_m96 : packoffset(c124);
    float4 CP26FPS_20_m97 : packoffset(c125);
    float4 CP26FPS_20_m98 : packoffset(c126);
    float4 CP26FPS_20_m99[2] : packoffset(c127);
    float4 CP26FPS_20_m100[2] : packoffset(c129);
    float CP26FPS_20_m101 : packoffset(c131);
    float CP26FPS_20_m102 : packoffset(c131.y);
    float CP26FPS_20_m103 : packoffset(c131.z);
    float CP26FPS_20_m104 : packoffset(c131.w);
    float4 CP26FPS_20_m105 : packoffset(c132);
    float4 CP26FPS_20_m106 : packoffset(c133);
    float4 CP26FPS_20_m107 : packoffset(c134);
    float4 CP26FPS_20_m108 : packoffset(c135);
    float4 CP26FPS_20_m109 : packoffset(c136);
    float4 CP26FPS_20_m110 : packoffset(c137);
    float4 CP26FPS_20_m111 : packoffset(c138);
    float4 CP26FPS_20_m112 : packoffset(c139);
    float4 CP26FPS_20_m113 : packoffset(c140);
    float4 CP26FPS_20_m114 : packoffset(c141);
    float4 CP26FPS_20_m115 : packoffset(c142);
    float4 CP26FPS_20_m116 : packoffset(c143);
    float4 CP26FPS_20_m117 : packoffset(c144);
    float4 CP26FPS_20_m118 : packoffset(c145);
    float4 CP26FPS_20_m119 : packoffset(c146);
    float4 CP26FPS_20_m120 : packoffset(c147);
    float4 CP26FPS_20_m121 : packoffset(c148);
    float4 CP26FPS_20_m122 : packoffset(c149);
    float4 CP26FPS_20_m123 : packoffset(c150);
    float4 CP26FPS_20_m124 : packoffset(c151);
    float4 CP26FPS_20_m125 : packoffset(c152);
    float4 CP26FPS_20_m126 : packoffset(c153);
    float4 CP26FPS_20_m127 : packoffset(c154);
    float4 CP26FPS_20_m128 : packoffset(c155);
    float4 CP26FPS_20_m129 : packoffset(c156);
    float4 CP26FPS_20_m130 : packoffset(c157);
    float4 CP26FPS_20_m131 : packoffset(c158);
    float4 CP26FPS_20_m132 : packoffset(c159);
    float4 CP26FPS_20_m133 : packoffset(c160);
    float4 CP26FPS_20_m134 : packoffset(c161);
    column_major float4x4 CP26FPS_20_m135 : packoffset(c162);
    float4 CP26FPS_20_m136 : packoffset(c166);
    float4 CP26FPS_20_m137 : packoffset(c167);
    float4 CP26FPS_20_m138[32] : packoffset(c168);
};

cbuffer CP26FPS_21_23
{
    float4 CP26FPS_instanceRaw[4096] : packoffset(c0);
};

ByteAddressBuffer CP26FPS_30;
ByteAddressBuffer CP26FPS_32;
cbuffer CP26FPS_33_34
{
    int CP26FPS_34_m0 : packoffset(c0);
    int CP26FPS_34_m1 : packoffset(c0.y);
    int CP26FPS_34_m2 : packoffset(c0.z);
    int CP26FPS_34_m3 : packoffset(c0.w);
    float CP26FPS_34_m4 : packoffset(c1);
    float CP26FPS_34_m5 : packoffset(c1.y);
    float CP26FPS_34_m6 : packoffset(c1.z);
    float CP26FPS_34_m7 : packoffset(c1.w);
    float CP26FPS_34_m8 : packoffset(c2);
    float CP26FPS_34_m9 : packoffset(c2.y);
    float CP26FPS_34_m10 : packoffset(c2.z);
    float CP26FPS_34_m11 : packoffset(c2.w);
};

cbuffer CP26FPS_35_36
{
    float4 CP26FPS_36_m0 : packoffset(c0);
    float4 CP26FPS_36_m1 : packoffset(c1);
    float4 CP26FPS_36_m2 : packoffset(c2);
    float4 CP26FPS_36_m3 : packoffset(c3);
    float4 CP26FPS_36_m4 : packoffset(c4);
    uint4 CP26FPS_36_m5 : packoffset(c5);
    float4 CP26FPS_36_m6[2048] : packoffset(c6);
};

cbuffer CP26FPS_39_40
{
    column_major float4x4 CP26FPS_40_m0[5] : packoffset(c0);
    float4 CP26FPS_40_m1[4] : packoffset(c20);
    float4 CP26FPS_40_m2[4] : packoffset(c24);
    float4 CP26FPS_40_m3[4] : packoffset(c28);
    float4 CP26FPS_40_m4 : packoffset(c32);
    float4 CP26FPS_40_m5 : packoffset(c33);
    float4 CP26FPS_40_m6 : packoffset(c34);
    float4 CP26FPS_40_m7 : packoffset(c35);
    float4 CP26FPS_40_m8 : packoffset(c36);
    float4 CP26FPS_40_m9[27] : packoffset(c37);
    column_major float4x4 CP26FPS_40_m10[56] : packoffset(c64);
    float4 CP26FPS_40_m11[56] : packoffset(c288);
    float4 CP26FPS_40_m12[56] : packoffset(c344);
    float4 CP26FPS_40_m13 : packoffset(c400);
    float4 CP26FPS_40_m14[47] : packoffset(c401);
    column_major float4x4 CP26FPS_40_m15[15] : packoffset(c448);
    float4 CP26FPS_40_m16[15] : packoffset(c508);
    float4 CP26FPS_40_m17[15] : packoffset(c523);
    float4 CP26FPS_40_m18[15] : packoffset(c538);
    float4 CP26FPS_40_m19 : packoffset(c553);
    float4 CP26FPS_40_m20 : packoffset(c554);
    float4 CP26FPS_40_m21[21] : packoffset(c555);
    column_major float4x4 CP26FPS_40_m22 : packoffset(c576);
    column_major float4x4 CP26FPS_40_m23 : packoffset(c580);
    float4 CP26FPS_40_m24 : packoffset(c584);
    float4 CP26FPS_40_m25 : packoffset(c585);
    float4 CP26FPS_40_m26 : packoffset(c586);
    float4 CP26FPS_40_m27[128] : packoffset(c587);
};

cbuffer CP26FPS_53_54
{
    float CP26FPS_54_m0 : packoffset(c0);
    float CP26FPS_54_m1 : packoffset(c0.y);
    float CP26FPS_54_m2 : packoffset(c0.z);
    float CP26FPS_54_m3 : packoffset(c0.w);
    float CP26FPS_54_m4 : packoffset(c1);
    float CP26FPS_54_m5 : packoffset(c1.y);
    float CP26FPS_54_m6 : packoffset(c1.z);
    float CP26FPS_54_m7 : packoffset(c1.w);
    float CP26FPS_54_m8 : packoffset(c2);
    float CP26FPS_54_m9 : packoffset(c2.y);
    float CP26FPS_54_m10 : packoffset(c2.z);
    float CP26FPS_54_m11 : packoffset(c2.w);
    float CP26FPS_54_m12 : packoffset(c3);
    float CP26FPS_54_m13 : packoffset(c3.y);
    float CP26FPS_54_m14 : packoffset(c3.z);
    float CP26FPS_54_m15 : packoffset(c3.w);
    float CP26FPS_54_m16 : packoffset(c4);
    float CP26FPS_54_m17 : packoffset(c4.y);
    float CP26FPS_54_m18 : packoffset(c4.z);
    float CP26FPS_54_m19 : packoffset(c4.w);
    float CP26FPS_54_m20 : packoffset(c5);
    float CP26FPS_54_m21 : packoffset(c5.y);
    float CP26FPS_54_m22 : packoffset(c5.z);
    float CP26FPS_54_m23 : packoffset(c5.w);
    float4 CP26FPS_54_m24 : packoffset(c6);
    float4 CP26FPS_54_m25 : packoffset(c7);
    float4 CP26FPS_54_m26 : packoffset(c8);
    float4 CP26FPS_54_m27 : packoffset(c9);
    float4 CP26FPS_54_m28 : packoffset(c10);
    float4 CP26FPS_54_m29 : packoffset(c11);
    float CP26FPS_54_m30 : packoffset(c12);
    float CP26FPS_54_m31 : packoffset(c12.y);
    float CP26FPS_54_m32 : packoffset(c12.z);
    float CP26FPS_54_m33 : packoffset(c12.w);
    float CP26FPS_54_m34 : packoffset(c13);
    float CP26FPS_54_m35 : packoffset(c13.y);
    float CP26FPS_54_m36 : packoffset(c13.z);
    float CP26FPS_54_m37 : packoffset(c13.w);
    float CP26FPS_54_m38 : packoffset(c14);
    float CP26FPS_54_m39 : packoffset(c14.y);
    float CP26FPS_54_m40 : packoffset(c14.z);
    float CP26FPS_54_m41 : packoffset(c14.w);
    float4 CP26FPS_54_m42 : packoffset(c15);
    float CP26FPS_54_m43 : packoffset(c16);
    float CP26FPS_54_m44 : packoffset(c16.y);
    float CP26FPS_54_m45 : packoffset(c16.z);
    float CP26FPS_54_m46 : packoffset(c16.w);
    float CP26FPS_54_m47 : packoffset(c17);
    float CP26FPS_54_m48 : packoffset(c17.y);
    float CP26FPS_54_m49 : packoffset(c17.z);
    float CP26FPS_54_m50 : packoffset(c17.w);
    float4 CP26FPS_54_m51 : packoffset(c18);
    float CP26FPS_54_m52 : packoffset(c19);
    float CP26FPS_54_m53 : packoffset(c19.y);
    float CP26FPS_54_m54 : packoffset(c19.z);
    float CP26FPS_54_m55 : packoffset(c19.w);
    float4 CP26FPS_54_m56 : packoffset(c20);
    float4 CP26FPS_54_m57 : packoffset(c21);
    float4 CP26FPS_54_m58 : packoffset(c22);
    float4 CP26FPS_54_m59 : packoffset(c23);
    float4 CP26FPS_54_m60 : packoffset(c24);
    float4 CP26FPS_54_m61 : packoffset(c25);
    float CP26FPS_54_m62 : packoffset(c26);
    float CP26FPS_54_m63 : packoffset(c26.y);
    float CP26FPS_54_m64 : packoffset(c26.z);
    float CP26FPS_54_m65 : packoffset(c26.w);
    float CP26FPS_54_m66 : packoffset(c27);
    float CP26FPS_54_m67 : packoffset(c27.y);
    float CP26FPS_54_m68 : packoffset(c27.z);
    float CP26FPS_54_m69 : packoffset(c27.w);
};

cbuffer CP26FPS_63_64
{
    float4 CP26FPS_64_m0[32] : packoffset(c0);
    column_major float4x4 CP26FPS_64_m1[32] : packoffset(c32);
};

SamplerState CP26F_linear_clamp_sampler;
SamplerState CP26F_linear_repeat_sampler;

Texture2D<float4> CP26FPS_41;
Texture2D<float4> CP26FPS_42;
Texture2D<float4> CP26FPS_43;
Texture2D<float4> CP26FPS_44;
Texture2D<float4> CP26FPS_45;
Texture3D<float4> CP26FPS_47;
Texture3D<float4> CP26FPS_48;
Texture3D<float4> CP26FPS_49;
Texture3D<float4> CP26FPS_50;
Texture3D<float4> CP26FPS_51;
Texture3D<float4> CP26FPS_52;
Texture2D<float4> CP26FPS_55;
Texture2D<float4> CP26FPS_56;
Texture2D<float4> CP26FPS_57;
Texture2D<float4> CP26FPS_58;
Texture2D<float4> CP26FPS_59;
Texture2D<float4> CP26FPS_60;
Texture2D<float4> CP26FPS_61;
Texture2D<float4> CP26FPS_62;
Texture3D<float4> CP26FPS_67;

static float4 CP26FPS_gl_FragCoord;
static bool CP26FPS_gl_FrontFacing;
static float2 CP26FPS_3;
static float3 CP26FPS_4;
static float3 CP26FPS_5;
static float4 CP26FPS_6;
static float3 CP26FPS_7;
static float3 CP26FPS_8;
static float3 CP26FPS_9;
static float4 CP26FPS_10;
static float3 CP26FPS_11;
static uint CP26FPS_13;
static float4 CP26FPS_15;
static float4 CP26FPS_16;

CP26FPS_22 CP26FPS_LoadInstance(uint index) {uint b=index*16;CP26FPS_22 x;
x._m0=transpose(float4x4(CP26FPS_instanceRaw[b+0],CP26FPS_instanceRaw[b+1],CP26FPS_instanceRaw[b+2],CP26FPS_instanceRaw[b+3]));
x._m3=transpose(float4x4(CP26FPS_instanceRaw[b+6],CP26FPS_instanceRaw[b+7],CP26FPS_instanceRaw[b+8],CP26FPS_instanceRaw[b+9]));
x._m1=CP26FPS_instanceRaw[b+4];
x._m2=CP26FPS_instanceRaw[b+5];
x._m4=CP26FPS_instanceRaw[b+10];
x._m5=CP26FPS_instanceRaw[b+11];
x._m6=CP26FPS_instanceRaw[b+12];
x._m7=CP26FPS_instanceRaw[b+13];
x._m8=CP26FPS_instanceRaw[b+14];
x._m9=CP26FPS_instanceRaw[b+15];
return x;}
struct CP26FPS_SPIRV_Cross_Input
{
    float2 CP26FPS_3 : TEXCOORD0;
    float3 CP26FPS_4 : TEXCOORD1;
    float3 CP26FPS_5 : TEXCOORD2;
    float4 CP26FPS_6 : TEXCOORD3;
    float3 CP26FPS_7 : TEXCOORD4;
    float3 CP26FPS_8 : TEXCOORD5;
    float3 CP26FPS_9 : TEXCOORD6;
    float4 CP26FPS_10 : TEXCOORD7;
    float3 CP26FPS_11 : TEXCOORD8;
    nointerpolation uint CP26FPS_13 : TEXCOORD9;
    float4 CP26FPS_gl_FragCoord : SV_Position;
    bool CP26FPS_gl_FrontFacing : SV_IsFrontFace;
};

struct CP26FPS_SPIRV_Cross_Output
{
    float4 CP26FPS_15 : SV_Target0;
    float4 CP26FPS_16 : SV_Target1;
};

static float CP26FPS_501;
static float3 CP26FPS_502;
static float3 CP26FPS_503;
static float CP26FPS_507;
static uint CP26FPS_508;

uint CP26FPS_spvPackHalf2x16(float2 value)
{
    uint2 Packed = f32tof16(value);
    return Packed.x | (Packed.y << 16);
}

float2 CP26FPS_spvUnpackHalf2x16(uint value)
{
    return f16tof32(uint2(value & 0xffff, value >> 16));
}

float CP26F_ShadowCompare(Texture2D<float4> tex,float2 uv,float reference) {
 uint w,h;tex.GetDimensions(w,h);float2 p=uv*float2(w,h)-0.5;int2 b=int2(floor(p));float2 f=frac(p);int2 hi=int2(w,h)-1;
 float a=reference>tex.Load(int3(clamp(b,int2(0,0),hi),0)).r;
 float c=reference>tex.Load(int3(clamp(b+int2(1,0),int2(0,0),hi),0)).r;
 float d=reference>tex.Load(int3(clamp(b+int2(0,1),int2(0,0),hi),0)).r;
 float e=reference>tex.Load(int3(clamp(b+int2(1,1),int2(0,0),hi),0)).r;
 return lerp(lerp(a,c,f.x),lerp(d,e,f.x),f.y);
}
void CP26FPS_frag_main()
{
    float CP26FPS_524 = 1.0f / CP26FPS_gl_FragCoord.w;
    float3 CP26FPS_539 = lerp(-CP26FPS_4, float3(CP26FPS_18_m0[2u].x, CP26FPS_18_m0[2u].y, CP26FPS_18_m0[2u].z), CP26FPS_20_m4.w.xxx);
    float CP26FPS_540 = dot(CP26FPS_539, CP26FPS_539);
    float CP26FPS_542 = rsqrt(isnan(9.9999999392252902907785028219223e-09f) ? CP26FPS_540 : (isnan(CP26FPS_540) ? 9.9999999392252902907785028219223e-09f : max(CP26FPS_540, 9.9999999392252902907785028219223e-09f)));
    float3 CP26FPS_543 = CP26FPS_539 * CP26FPS_542;
    float CP26FPS_544 = CP26FPS_540 * CP26FPS_542;
    uint CP26FPS_547 = asuint(CP26FPS_LoadInstance(CP26FPS_13)._m2.x);
    bool CP26FPS_552 = (asuint(CP26FPS_LoadInstance(CP26FPS_13)._m1.w) & 16u) != 0u;
    float4 CP26FPS_569;
    float4 CP26FPS_570;
    float4 CP26FPS_571;
    if (CP26FPS_552)
    {
        CP26FPS_569 = asfloat(CP26FPS_32.Load4((CP26FPS_547 + 2u) * 16 + 0));
        CP26FPS_570 = asfloat(CP26FPS_32.Load4((CP26FPS_547 + 1u) * 16 + 0));
        CP26FPS_571 = asfloat(CP26FPS_32.Load4(CP26FPS_547 * 16 + 0));
    }
    else
    {
        CP26FPS_569 = CP26FPS_LoadInstance(CP26FPS_13)._m0[2];
        CP26FPS_570 = CP26FPS_LoadInstance(CP26FPS_13)._m0[1];
        CP26FPS_571 = CP26FPS_LoadInstance(CP26FPS_13)._m0[0];
    }
    float4 CP26FPS_577 = CP26FPS_59.SampleBias(CP26F_linear_repeat_sampler, CP26FPS_3, CP26FPS_20_m16);
    float3 CP26FPS_582 = CP26FPS_577.xyz * CP26FPS_54_m24.xyz;
    float4 CP26FPS_586 = CP26FPS_60.SampleBias(CP26F_linear_repeat_sampler, CP26FPS_3, CP26FPS_20_m16);
    float CP26FPS_587 = CP26FPS_586.x;
    float CP26FPS_588 = CP26FPS_586.y;
    float CP26FPS_589 = CP26FPS_586.z;
    float CP26FPS_593 = CP26FPS_577.w * CP26FPS_54_m24.w;
    float3 CP26FPS_611 = CP26FPS_582 * CP26FPS_54_m18;
    float3 CP26FPS_615 = lerp(dot(CP26FPS_611, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, CP26FPS_611, CP26FPS_54_m19.xxx);
    float4 CP26FPS_619 = CP26FPS_61.SampleBias(CP26F_linear_repeat_sampler, CP26FPS_3, CP26FPS_20_m16);
    float2 CP26FPS_624 = (CP26FPS_619.xy * 2.0f) - 1.0f.xx;
    float2 CP26FPS_626 = CP26FPS_624.xy;
    float CP26FPS_630 = sqrt(1.0f - clamp(dot(CP26FPS_626, CP26FPS_626), 0.0f, 1.0f));
    float3 CP26FPS_632 = float3(CP26FPS_624.x, CP26FPS_624.y, CP26FPS_503.z);
    CP26FPS_632.z = isnan(CP26FPS_630) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? CP26FPS_630 : max(1.000000016862383526387164645044e-16f, CP26FPS_630));
    float2 CP26FPS_634 = CP26FPS_632.xy * CP26FPS_54_m3;
    float4 CP26FPS_645 = CP26FPS_55.Sample(CP26F_linear_repeat_sampler, (CP26FPS_3 * CP26FPS_54_m51.xy) + CP26FPS_54_m51.zw);
    float3 CP26FPS_650 = CP26FPS_4 + CP26FPS_18_m11.xyz;
    float3 CP26FPS_655 = CP26FPS_650 - float3(CP26FPS_571.w, CP26FPS_507, CP26FPS_569.w);
    CP26FPS_655.y = 6.103515625e-05f;
    float3 CP26FPS_657 = normalize(CP26FPS_655);
    float3 CP26FPS_663 = CP26FPS_6.xyz * 1.0f;
    float3 CP26FPS_664 = (cross(CP26FPS_5, CP26FPS_6.xyz) * CP26FPS_6.w) * 1.0f;
    float3 CP26FPS_665 = CP26FPS_5 * 1.0f;
    float3x3 CP26FPS_666 = float3x3(CP26FPS_663, CP26FPS_664, CP26FPS_665);
    float3 CP26FPS_667 = mul(float3(CP26FPS_634.x, CP26FPS_634.y, CP26FPS_632.z), CP26FPS_666);
    float CP26FPS_668 = dot(CP26FPS_667, CP26FPS_667);
    float CP26FPS_676 = CP26FPS_gl_FrontFacing ? 1.0f : ((-1.0f) + (2.0f * CP26FPS_54_m5));
    float3 CP26FPS_677 = (CP26FPS_667 * rsqrt(isnan(CP26FPS_668) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? CP26FPS_668 : max(1.1754943508222875079687365372222e-38f, CP26FPS_668)))) * CP26FPS_676;
    float3 CP26FPS_678 = normalize(CP26FPS_5) * CP26FPS_676;
    float2 CP26FPS_683 = (CP26FPS_619.zw * 2.0f) - 1.0f.xx;
    float2 CP26FPS_685 = CP26FPS_683.xy;
    float CP26FPS_689 = sqrt(1.0f - clamp(dot(CP26FPS_685, CP26FPS_685), 0.0f, 1.0f));
    float3 CP26FPS_691 = float3(CP26FPS_683.x, CP26FPS_683.y, CP26FPS_503.z);
    CP26FPS_691.z = isnan(CP26FPS_689) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? CP26FPS_689 : max(1.000000016862383526387164645044e-16f, CP26FPS_689));
    float2 CP26FPS_693 = CP26FPS_691.xy * CP26FPS_54_m31;
    float3 CP26FPS_696 = normalize(mul(float3(CP26FPS_693.x, CP26FPS_693.y, CP26FPS_691.z), CP26FPS_666));
    float3x3 CP26FPS_703 = float3x3(CP26FPS_571.xyz, CP26FPS_570.xyz, CP26FPS_569.xyz);
    float3 CP26FPS_704 = mul(CP26FPS_703, float3(CP26FPS_54_m39, 1.0f, 0.0f));
    float CP26FPS_705 = dot(CP26FPS_704, CP26FPS_704);
    float3 CP26FPS_716 = cross(CP26FPS_696, lerp(cross(CP26FPS_696, (CP26FPS_704 * rsqrt(isnan(CP26FPS_705) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? CP26FPS_705 : max(1.1754943508222875079687365372222e-38f, CP26FPS_705)))).xyz), CP26FPS_6.xyz, CP26FPS_587.xxx).xyz) * lerp(1.0f, CP26FPS_6.w, CP26FPS_587);
    float3 CP26FPS_718 = mul(CP26FPS_543, CP26FPS_703);
    float CP26FPS_727 = pow(clamp(dot(normalize(mul(CP26FPS_696, CP26FPS_703).xz), normalize(CP26FPS_718.xz)), 0.0f, 1.0f), CP26FPS_54_m37);
    uint2 CP26FPS_729 = uint2(CP26FPS_gl_FragCoord.xy);
    float3 CP26FPS_739 = mul(float3x3(CP26FPS_18_m1[0].xyz, CP26FPS_18_m1[1].xyz, CP26FPS_18_m1[2].xyz), float3(0.0f, 0.0f, 1.0f));
    uint CP26FPS_748 = asuint((CP26FPS_20_m89.x > 0.5f) ? CP26FPS_20_m89.y : CP26FPS_LoadInstance(CP26FPS_13)._m7.x);
    float4 CP26FPS_761 = float4(float(CP26FPS_748 & 255u), float((CP26FPS_748 >> 8u) & 255u), float((CP26FPS_748 >> 16u) & 255u), float((CP26FPS_748 >> 24u) & 255u)) * 0.0039215688593685626983642578125f.xxxx;
    float CP26FPS_762 = CP26FPS_761.x;
    float CP26FPS_764 = CP26FPS_761.z;
    float CP26FPS_765 = CP26FPS_761.w;
    float CP26FPS_771 = CP26FPS_650.y;
    float CP26FPS_774 = smoothstep(-0.20000000298023223876953125f, 0.1500000059604644775390625f, lerp(CP26FPS_LoadInstance(CP26FPS_13)._m7.y, CP26FPS_20_m89.w, CP26FPS_20_m89.x) - CP26FPS_771) * CP26FPS_761.y;
    float CP26FPS_775 = isnan(CP26FPS_774) ? CP26FPS_764 : (isnan(CP26FPS_764) ? CP26FPS_774 : max(CP26FPS_764, CP26FPS_774));
    float CP26FPS_776 = isnan(CP26FPS_775) ? CP26FPS_762 : (isnan(CP26FPS_762) ? CP26FPS_775 : max(CP26FPS_762, CP26FPS_775));
    float CP26FPS_784 = lerp(CP26FPS_20_m22.x, 1.0f, CP26FPS_20_m91.w) * CP26FPS_20_m20.x;
    float4 CP26FPS_1278;
    float3 CP26FPS_1279;
    float3 CP26FPS_1280;
    float CP26FPS_1281;
    if (CP26FPS_20_m80.y < 0.5f)
    {
        float3 CP26FPS_799 = CP26FPS_650 - (CP26FPS_20_m105.xyz + (CP26FPS_739 * (-CP26FPS_20_m107.w)));
        float CP26FPS_801 = abs(CP26FPS_799.x);
        float CP26FPS_803 = abs(CP26FPS_799.z);
        float CP26FPS_809 = clamp(((isnan(CP26FPS_803) ? CP26FPS_801 : (isnan(CP26FPS_801) ? CP26FPS_803 : max(CP26FPS_801, CP26FPS_803))) - 464.0f) * 0.03125f, 0.0f, 1.0f);
        float CP26FPS_812 = clamp((abs(CP26FPS_799.y) - 208.0f) * 0.03125f, 0.0f, 1.0f);
        float CP26FPS_813 = isnan(CP26FPS_812) ? CP26FPS_809 : (isnan(CP26FPS_809) ? CP26FPS_812 : max(CP26FPS_809, CP26FPS_812));
        float4 CP26FPS_1115;
        float4 CP26FPS_1116;
        float4 CP26FPS_1117;
        float CP26FPS_1118;
        float CP26FPS_1119;
        if ((CP26FPS_20_m105.w != 0.0f) && (CP26FPS_813 < 1.0f))
        {
            float3 CP26FPS_826 = CP26FPS_650 - (CP26FPS_20_m105.xyz + (CP26FPS_739 * (-CP26FPS_20_m107.y)));
            float CP26FPS_828 = abs(CP26FPS_826.x);
            float CP26FPS_830 = abs(CP26FPS_826.z);
            float CP26FPS_836 = clamp(((isnan(CP26FPS_830) ? CP26FPS_828 : (isnan(CP26FPS_828) ? CP26FPS_830 : max(CP26FPS_828, CP26FPS_830))) - 29.0f) * 0.5f, 0.0f, 1.0f);
            float CP26FPS_839 = clamp((abs(CP26FPS_826.y) - 13.0f) * 0.5f, 0.0f, 1.0f);
            float CP26FPS_840 = isnan(CP26FPS_839) ? CP26FPS_836 : (isnan(CP26FPS_836) ? CP26FPS_839 : max(CP26FPS_836, CP26FPS_839));
            float CP26FPS_916;
            float4 CP26FPS_917;
            float4 CP26FPS_918;
            float4 CP26FPS_919;
            if (CP26FPS_840 < 1.0f)
            {
                float3 CP26FPS_849 = ((CP26FPS_650 * 2.0f) + 0.5f.xxx) * CP26FPS_20_m106.xyz;
                float3 CP26FPS_851 = CP26FPS_849 - floor(CP26FPS_849);
                float4 CP26FPS_855 = CP26FPS_47.SampleLevel(CP26F_linear_repeat_sampler, CP26FPS_851, 0.0f);
                float CP26FPS_856 = 1.0f - CP26FPS_840;
                float CP26FPS_860 = CP26FPS_20_m106.y * 0.5f;
                float CP26FPS_865 = CP26FPS_851.x;
                float CP26FPS_866 = clamp(CP26FPS_851.y, CP26FPS_860, 1.0f - CP26FPS_860) * 0.3333333432674407958984375f;
                float CP26FPS_867 = CP26FPS_851.z;
                float4 CP26FPS_870 = CP26FPS_48.SampleLevel(CP26F_linear_clamp_sampler, float3(CP26FPS_865, CP26FPS_866, CP26FPS_867), 0.0f);
                float CP26FPS_886 = CP26FPS_855.x;
                float CP26FPS_896 = CP26FPS_855.y;
                float CP26FPS_906 = CP26FPS_855.z;
                CP26FPS_916 = CP26FPS_813 + (CP26FPS_870.w * CP26FPS_856);
                CP26FPS_917 = float4(((CP26FPS_48.SampleLevel(CP26F_linear_clamp_sampler, float3(CP26FPS_865, CP26FPS_866 + 0.666666686534881591796875f, CP26FPS_867), 0.0f).xyz * 4.0f) - 2.0f.xxx) * CP26FPS_906, CP26FPS_906) * CP26FPS_856;
                CP26FPS_918 = float4(((CP26FPS_48.SampleLevel(CP26F_linear_clamp_sampler, float3(CP26FPS_865, CP26FPS_866 + 0.3333333432674407958984375f, CP26FPS_867), 0.0f).xyz * 4.0f) - 2.0f.xxx) * CP26FPS_896, CP26FPS_896) * CP26FPS_856;
                CP26FPS_919 = float4(((CP26FPS_870.xyz * 4.0f) - 2.0f.xxx) * CP26FPS_886, CP26FPS_886) * CP26FPS_856;
            }
            else
            {
                CP26FPS_916 = CP26FPS_813;
                CP26FPS_917 = 0.0f.xxxx;
                CP26FPS_918 = 0.0f.xxxx;
                CP26FPS_919 = 0.0f.xxxx;
            }
            float3 CP26FPS_925 = CP26FPS_650 - (CP26FPS_20_m105.xyz + (CP26FPS_739 * (-CP26FPS_20_m107.z)));
            float CP26FPS_927 = abs(CP26FPS_925.x);
            float CP26FPS_929 = abs(CP26FPS_925.z);
            float CP26FPS_935 = clamp(((isnan(CP26FPS_929) ? CP26FPS_927 : (isnan(CP26FPS_927) ? CP26FPS_929 : max(CP26FPS_927, CP26FPS_929))) - 116.0f) * 0.125f, 0.0f, 1.0f);
            float CP26FPS_938 = clamp((abs(CP26FPS_925.y) - 52.0f) * 0.125f, 0.0f, 1.0f);
            float CP26FPS_939 = isnan(CP26FPS_938) ? CP26FPS_935 : (isnan(CP26FPS_935) ? CP26FPS_938 : max(CP26FPS_935, CP26FPS_938));
            float CP26FPS_1019;
            float4 CP26FPS_1020;
            float4 CP26FPS_1021;
            float4 CP26FPS_1022;
            if (CP26FPS_939 < 1.0f)
            {
                float3 CP26FPS_948 = ((CP26FPS_650 * 0.5f) + 0.5f.xxx) * CP26FPS_20_m106.xyz;
                float3 CP26FPS_950 = CP26FPS_948 - floor(CP26FPS_948);
                float4 CP26FPS_954 = CP26FPS_49.SampleLevel(CP26F_linear_repeat_sampler, CP26FPS_950, 0.0f);
                float CP26FPS_956 = CP26FPS_840 * (1.0f - CP26FPS_939);
                float CP26FPS_960 = CP26FPS_20_m106.y * 0.5f;
                float CP26FPS_965 = CP26FPS_950.x;
                float CP26FPS_966 = clamp(CP26FPS_950.y, CP26FPS_960, 1.0f - CP26FPS_960) * 0.3333333432674407958984375f;
                float CP26FPS_967 = CP26FPS_950.z;
                float4 CP26FPS_970 = CP26FPS_50.SampleLevel(CP26F_linear_clamp_sampler, float3(CP26FPS_965, CP26FPS_966, CP26FPS_967), 0.0f);
                float CP26FPS_986 = CP26FPS_954.x;
                float CP26FPS_997 = CP26FPS_954.y;
                float CP26FPS_1008 = CP26FPS_954.z;
                CP26FPS_1019 = CP26FPS_916 + (CP26FPS_970.w * CP26FPS_956);
                CP26FPS_1020 = CP26FPS_917 + (float4(((CP26FPS_50.SampleLevel(CP26F_linear_clamp_sampler, float3(CP26FPS_965, CP26FPS_966 + 0.666666686534881591796875f, CP26FPS_967), 0.0f).xyz * 4.0f) - 2.0f.xxx) * CP26FPS_1008, CP26FPS_1008) * CP26FPS_956);
                CP26FPS_1021 = CP26FPS_918 + (float4(((CP26FPS_50.SampleLevel(CP26F_linear_clamp_sampler, float3(CP26FPS_965, CP26FPS_966 + 0.3333333432674407958984375f, CP26FPS_967), 0.0f).xyz * 4.0f) - 2.0f.xxx) * CP26FPS_997, CP26FPS_997) * CP26FPS_956);
                CP26FPS_1022 = CP26FPS_919 + (float4(((CP26FPS_970.xyz * 4.0f) - 2.0f.xxx) * CP26FPS_986, CP26FPS_986) * CP26FPS_956);
            }
            else
            {
                CP26FPS_1019 = CP26FPS_916;
                CP26FPS_1020 = CP26FPS_917;
                CP26FPS_1021 = CP26FPS_918;
                CP26FPS_1022 = CP26FPS_919;
            }
            float4 CP26FPS_1105;
            float4 CP26FPS_1106;
            float4 CP26FPS_1107;
            float CP26FPS_1108;
            if (CP26FPS_939 > 0.0f)
            {
                float3 CP26FPS_1031 = ((CP26FPS_650 * 0.125f) + 0.5f.xxx) * CP26FPS_20_m106.xyz;
                float3 CP26FPS_1034 = CP26FPS_20_m106.xyz * 0.5f;
                float3 CP26FPS_1036 = clamp(CP26FPS_1031 - floor(CP26FPS_1031), CP26FPS_1034, 1.0f.xxx - CP26FPS_1034);
                float4 CP26FPS_1040 = CP26FPS_51.SampleLevel(CP26F_linear_repeat_sampler, CP26FPS_1036, 0.0f);
                float CP26FPS_1042 = CP26FPS_939 * (1.0f - CP26FPS_813);
                float CP26FPS_1046 = CP26FPS_20_m106.y * 0.5f;
                float CP26FPS_1051 = CP26FPS_1036.x;
                float CP26FPS_1052 = clamp(CP26FPS_1036.y, CP26FPS_1046, 1.0f - CP26FPS_1046) * 0.3333333432674407958984375f;
                float CP26FPS_1053 = CP26FPS_1036.z;
                float4 CP26FPS_1056 = CP26FPS_52.SampleLevel(CP26F_linear_clamp_sampler, float3(CP26FPS_1051, CP26FPS_1052, CP26FPS_1053), 0.0f);
                float CP26FPS_1072 = CP26FPS_1040.x;
                float CP26FPS_1083 = CP26FPS_1040.y;
                float CP26FPS_1094 = CP26FPS_1040.z;
                CP26FPS_1105 = CP26FPS_1020 + (float4(((CP26FPS_52.SampleLevel(CP26F_linear_clamp_sampler, float3(CP26FPS_1051, CP26FPS_1052 + 0.666666686534881591796875f, CP26FPS_1053), 0.0f).xyz * 4.0f) - 2.0f.xxx) * CP26FPS_1094, CP26FPS_1094) * CP26FPS_1042);
                CP26FPS_1106 = CP26FPS_1021 + (float4(((CP26FPS_52.SampleLevel(CP26F_linear_clamp_sampler, float3(CP26FPS_1051, CP26FPS_1052 + 0.3333333432674407958984375f, CP26FPS_1053), 0.0f).xyz * 4.0f) - 2.0f.xxx) * CP26FPS_1083, CP26FPS_1083) * CP26FPS_1042);
                CP26FPS_1107 = CP26FPS_1022 + (float4(((CP26FPS_1056.xyz * 4.0f) - 2.0f.xxx) * CP26FPS_1072, CP26FPS_1072) * CP26FPS_1042);
                CP26FPS_1108 = CP26FPS_1019 + (CP26FPS_1056.w * CP26FPS_1042);
            }
            else
            {
                CP26FPS_1105 = CP26FPS_1020;
                CP26FPS_1106 = CP26FPS_1021;
                CP26FPS_1107 = CP26FPS_1022;
                CP26FPS_1108 = CP26FPS_1019;
            }
            float CP26FPS_1111 = clamp((CP26FPS_1108 * 2.0f) - 1.0f, 0.0f, 1.0f);
            CP26FPS_1115 = CP26FPS_1105;
            CP26FPS_1116 = CP26FPS_1106;
            CP26FPS_1117 = CP26FPS_1107;
            CP26FPS_1118 = CP26FPS_1111 - CP26FPS_813;
            CP26FPS_1119 = (CP26FPS_1111 + CP26FPS_813) * 0.5f;
        }
        else
        {
            CP26FPS_1115 = 0.0f.xxxx;
            CP26FPS_1116 = 0.0f.xxxx;
            CP26FPS_1117 = 0.0f.xxxx;
            CP26FPS_1118 = 0.0f;
            CP26FPS_1119 = 1.0f;
        }
        float4 CP26FPS_1139 = CP26FPS_1117 + float4(CP26FPS_20_m108.x * CP26FPS_1119, (CP26FPS_20_m108.y * CP26FPS_1119) + ((CP26FPS_20_m108.w * CP26FPS_1118) * 0.5f), CP26FPS_20_m108.z * CP26FPS_1119, (CP26FPS_20_m108.w * CP26FPS_1119) + ((CP26FPS_20_m108.y * CP26FPS_1118) * 0.375f));
        float4 CP26FPS_1159 = CP26FPS_1116 + float4(CP26FPS_20_m109.x * CP26FPS_1119, (CP26FPS_20_m109.y * CP26FPS_1119) + ((CP26FPS_20_m109.w * CP26FPS_1118) * 0.5f), CP26FPS_20_m109.z * CP26FPS_1119, (CP26FPS_20_m109.w * CP26FPS_1119) + ((CP26FPS_20_m109.y * CP26FPS_1118) * 0.375f));
        float4 CP26FPS_1179 = CP26FPS_1115 + float4(CP26FPS_20_m110.x * CP26FPS_1119, (CP26FPS_20_m110.y * CP26FPS_1119) + ((CP26FPS_20_m110.w * CP26FPS_1118) * 0.5f), CP26FPS_20_m110.z * CP26FPS_1119, (CP26FPS_20_m110.w * CP26FPS_1119) + ((CP26FPS_20_m110.y * CP26FPS_1118) * 0.375f));
        float4 CP26FPS_1183 = float4(CP26FPS_677, 1.0f);
        float3 CP26FPS_1187 = float3(dot(CP26FPS_1139, CP26FPS_1183), dot(CP26FPS_1159, CP26FPS_1183), dot(CP26FPS_1179, CP26FPS_1183));
        bool3 CP26FPS_4652 = isnan(CP26FPS_1187);
        bool3 CP26FPS_4653 = isnan(0.0f.xxx);
        float3 CP26FPS_4654 = max(CP26FPS_1187, 0.0f.xxx);
        float3 CP26FPS_4655 = float3(CP26FPS_4652.x ? 0.0f.xxx.x : CP26FPS_4654.x, CP26FPS_4652.y ? 0.0f.xxx.y : CP26FPS_4654.y, CP26FPS_4652.z ? 0.0f.xxx.z : CP26FPS_4654.z);
        float3 CP26FPS_1189 = float3(CP26FPS_4653.x ? CP26FPS_1187.x : CP26FPS_4655.x, CP26FPS_4653.y ? CP26FPS_1187.y : CP26FPS_4655.y, CP26FPS_4653.z ? CP26FPS_1187.z : CP26FPS_4655.z) * CP26FPS_784;
        float3 CP26FPS_1197 = ((CP26FPS_1139.xyz * 0.2125999927520751953125f) + (CP26FPS_1159.xyz * 0.715200006961822509765625f)) + (CP26FPS_1179.xyz * 0.072200000286102294921875f);
        float CP26FPS_1198 = dot(CP26FPS_1197, CP26FPS_1197);
        float3 CP26FPS_1201 = CP26FPS_1197 * rsqrt(isnan(CP26FPS_1198) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? CP26FPS_1198 : max(1.1754943508222875079687365372222e-38f, CP26FPS_1198)));
        float CP26FPS_1203 = abs(CP26FPS_1201.y);
        float3 CP26FPS_1204 = CP26FPS_1201;
        CP26FPS_1204.y = CP26FPS_1203;
        float4 CP26FPS_1206 = float4(CP26FPS_1204.x, CP26FPS_1204.y, CP26FPS_1204.z, 0.0f.xxxx.w);
        CP26FPS_1206.w = 1.0f;
        float4 CP26FPS_1209 = float4(CP26FPS_1201.x, CP26FPS_1203, CP26FPS_1201.z, 1.0f);
        float3 CP26FPS_1213 = float3(dot(CP26FPS_1139, CP26FPS_1209), dot(CP26FPS_1159, CP26FPS_1209), dot(CP26FPS_1179, CP26FPS_1209));
        bool3 CP26FPS_4662 = isnan(CP26FPS_1213);
        bool3 CP26FPS_4663 = isnan(0.0f.xxx);
        float3 CP26FPS_4664 = max(CP26FPS_1213, 0.0f.xxx);
        float3 CP26FPS_4665 = float3(CP26FPS_4662.x ? 0.0f.xxx.x : CP26FPS_4664.x, CP26FPS_4662.y ? 0.0f.xxx.y : CP26FPS_4664.y, CP26FPS_4662.z ? 0.0f.xxx.z : CP26FPS_4664.z);
        float3 CP26FPS_1214 = float3(CP26FPS_4663.x ? CP26FPS_1213.x : CP26FPS_4665.x, CP26FPS_4663.y ? CP26FPS_1213.y : CP26FPS_4665.y, CP26FPS_4663.z ? CP26FPS_1213.z : CP26FPS_4665.z);
        float CP26FPS_1215 = CP26FPS_1214.x;
        float CP26FPS_1216 = CP26FPS_1214.y;
        float CP26FPS_1217 = CP26FPS_1214.z;
        float CP26FPS_1218 = isnan(CP26FPS_1216) ? CP26FPS_1215 : (isnan(CP26FPS_1215) ? CP26FPS_1216 : max(CP26FPS_1215, CP26FPS_1216));
        float CP26FPS_1219 = isnan(CP26FPS_1217) ? CP26FPS_1218 : (isnan(CP26FPS_1218) ? CP26FPS_1217 : max(CP26FPS_1218, CP26FPS_1217));
        float CP26FPS_1222 = CP26FPS_1189.z;
        float CP26FPS_1223 = CP26FPS_1189.y;
        float4 CP26FPS_1228 = lerp(float4(CP26FPS_1222, CP26FPS_1223, -1.0f, 0.666666686534881591796875f), float4(CP26FPS_1223, CP26FPS_1222, 0.0f, -0.3333333432674407958984375f), step(CP26FPS_1222, CP26FPS_1223).xxxx);
        float CP26FPS_1229 = CP26FPS_1189.x;
        float CP26FPS_1230 = CP26FPS_1228.x;
        float4 CP26FPS_1238 = lerp(float4(CP26FPS_1230, CP26FPS_1228.yw, CP26FPS_1229), float4(CP26FPS_1229, CP26FPS_1228.yz, CP26FPS_1230), step(CP26FPS_1230, CP26FPS_1229).xxxx);
        float CP26FPS_1239 = CP26FPS_1238.x;
        float CP26FPS_1240 = CP26FPS_1238.w;
        float CP26FPS_1241 = CP26FPS_1238.y;
        float CP26FPS_1243 = CP26FPS_1239 - (isnan(CP26FPS_1241) ? CP26FPS_1240 : (isnan(CP26FPS_1240) ? CP26FPS_1241 : min(CP26FPS_1240, CP26FPS_1241)));
        float CP26FPS_1252 = CP26FPS_1243 / (CP26FPS_1239 + 9.9999997473787516355514526367188e-05f);
        float CP26FPS_1253 = frac(abs(CP26FPS_1238.z + ((CP26FPS_1240 - CP26FPS_1241) / ((6.0f * CP26FPS_1243) + 9.9999997473787516355514526367188e-05f))));
        float CP26FPS_1259 = lerp(0.699999988079071044921875f, 0.3499999940395355224609375f, smoothstep(0.449999988079071044921875f, 0.3499999940395355224609375f, abs(CP26FPS_1253 - 0.5f))) * clamp(CP26FPS_1239, 0.0f, 1.0f);
        float CP26FPS_1260 = isnan(CP26FPS_1259) ? CP26FPS_1252 : (isnan(CP26FPS_1252) ? CP26FPS_1259 : min(CP26FPS_1252, CP26FPS_1259));
        float CP26FPS_1262 = 2.0f / (2.0f - CP26FPS_1260);
        CP26FPS_1278 = CP26FPS_1206;
        CP26FPS_1279 = CP26FPS_1189;
        CP26FPS_1280 = lerp(1.0f.xxx, clamp(abs((frac(float3(CP26FPS_1253, CP26FPS_1260, CP26FPS_1262).xxx + float3(1.0f, 0.666666686534881591796875f, 0.3333333432674407958984375f)) * 6.0f) - 3.0f.xxx) - 1.0f.xxx, 0.0f.xxx, 1.0f.xxx), CP26FPS_1260.xxx) * CP26FPS_1262;
        CP26FPS_1281 = (isnan(0.0f) ? CP26FPS_1219 : (isnan(CP26FPS_1219) ? 0.0f : max(CP26FPS_1219, 0.0f))) * CP26FPS_784;
    }
    else
    {
        CP26FPS_1278 = 0.0f.xxxx;
        CP26FPS_1279 = 1.0f.xxx;
        CP26FPS_1280 = CP26FPS_20_m81.xyz;
        CP26FPS_1281 = CP26FPS_784;
    }
    float3 CP26FPS_2088;
    float CP26FPS_2089;
    float CP26FPS_2090;
    float CP26FPS_2091;
    float CP26FPS_2092;
    float CP26FPS_2093;
    float3 CP26FPS_2094;
    float3 CP26FPS_2095;
    [branch]
    if ((clamp(CP26FPS_762 + CP26FPS_775, 0.0f, 1.0f) - CP26FPS_54_m20) > 0.00999999977648258209228515625f)
    {
        float CP26FPS_1438;
        bool CP26FPS_1439;
        bool CP26FPS_1308 = (step(CP26FPS_762, 0.00999999977648258209228515625f) * step(0.00999999977648258209228515625f, CP26FPS_775)) != 0.0f;
        bool3 CP26FPS_1309 = CP26FPS_552.xxx;
        float3 CP26FPS_1311 = CP26FPS_11.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 CP26FPS_1315 = float3(CP26FPS_1309.x ? CP26FPS_1311.x : CP26FPS_11.x, CP26FPS_1309.y ? CP26FPS_1311.y : CP26FPS_11.y, CP26FPS_1309.z ? CP26FPS_1311.z : CP26FPS_11.z) * CP26FPS_20_m89.z;
        float3 CP26FPS_1325 = float3(0.0f, -1.0f, 0.0f) + (CP26FPS_665 * CP26FPS_665.y);
        float3 CP26FPS_1333 = ((CP26FPS_10.xyz * dot(CP26FPS_1325, CP26FPS_663)) + ((cross(CP26FPS_9, CP26FPS_10.xyz) * CP26FPS_10.w) * dot(CP26FPS_1325, CP26FPS_664))) + (CP26FPS_9 * dot(CP26FPS_1325, CP26FPS_665));
        float3 CP26FPS_1335 = CP26FPS_1333.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 CP26FPS_1336 = float3(CP26FPS_1309.x ? CP26FPS_1335.x : CP26FPS_1333.x, CP26FPS_1309.y ? CP26FPS_1335.y : CP26FPS_1333.y, CP26FPS_1309.z ? CP26FPS_1335.z : CP26FPS_1333.z);
        bool CP26FPS_1337 = !CP26FPS_1308;
        bool2 CP26FPS_1338 = CP26FPS_1337.xx;
        float2 CP26FPS_1340 = (1.0f - CP26FPS_775).xx;
        float2 CP26FPS_1341 = float2(CP26FPS_1338.x ? float2(3.0f, 4.340000152587890625f).x : CP26FPS_1340.x, CP26FPS_1338.y ? float2(3.0f, 4.340000152587890625f).y : CP26FPS_1340.y);
        float CP26FPS_1344 = 1.0f - ((CP26FPS_1308 ? CP26FPS_775 : CP26FPS_762) * 0.64999997615814208984375f);
        float3 CP26FPS_1352 = frac(floor(((CP26FPS_3.xx * CP26FPS_20_m89.z) * 32.0f) * 1.5f).xyx * 0.103100001811981201171875f);
        float3 CP26FPS_1357 = CP26FPS_1352 + dot(CP26FPS_1352, CP26FPS_1352.yzx + 33.3300018310546875f.xxx).xxx;
        float CP26FPS_1374 = lerp(0.60000002384185791015625f, 1.0f, clamp((1.2000000476837158203125f * frac((CP26FPS_1315.y * (-3.0f)) + frac((CP26FPS_1357.x + CP26FPS_1357.y) * CP26FPS_1357.z))) + clamp(CP26FPS_1315.z * 10.0f, 0.0f, 1.0f), 0.0f, 1.0f));
        float CP26FPS_1375 = 1.0f - CP26FPS_776;
        float CP26FPS_1377 = CP26FPS_1375 + (0.800000011920928955078125f * CP26FPS_776);
        float CP26FPS_1380 = CP26FPS_1337 ? CP26FPS_20_m10.x : 1.0f;
        float CP26FPS_1382 = CP26FPS_1380 * CP26FPS_1341.x;
        float CP26FPS_1384 = CP26FPS_1380 * CP26FPS_1341.y;
        float3 CP26FPS_1385 = CP26FPS_1315 * 32.0f;
        float3 CP26FPS_1386 = CP26FPS_1315 * 48.345600128173828125f;
        float3 CP26FPS_1388 = abs(float3(CP26FPS_1309.x ? CP26FPS_9.xzy.x : CP26FPS_9.x, CP26FPS_1309.y ? CP26FPS_9.xzy.y : CP26FPS_9.y, CP26FPS_1309.z ? CP26FPS_9.xzy.z : CP26FPS_9.z)) - 0.20000000298023223876953125f.xxx;
        bool3 CP26FPS_4692 = isnan(CP26FPS_1388);
        bool3 CP26FPS_4693 = isnan(0.0f.xxx);
        float3 CP26FPS_4694 = max(CP26FPS_1388, 0.0f.xxx);
        float3 CP26FPS_4695 = float3(CP26FPS_4692.x ? 0.0f.xxx.x : CP26FPS_4694.x, CP26FPS_4692.y ? 0.0f.xxx.y : CP26FPS_4694.y, CP26FPS_4692.z ? 0.0f.xxx.z : CP26FPS_4694.z);
        float3 CP26FPS_1390 = pow(float3(CP26FPS_4693.x ? CP26FPS_1388.x : CP26FPS_4695.x, CP26FPS_4693.y ? CP26FPS_1388.y : CP26FPS_4695.y, CP26FPS_4693.z ? CP26FPS_1388.z : CP26FPS_4695.z), 10.0f.xxx);
        float CP26FPS_1391 = dot(CP26FPS_1390, 1.0f.xxx);
        float3 CP26FPS_1394 = CP26FPS_1390 / (isnan(6.103515625e-05f) ? CP26FPS_1391 : (isnan(CP26FPS_1391) ? 6.103515625e-05f : max(CP26FPS_1391, 6.103515625e-05f))).xxx;
        float2 CP26FPS_1396 = CP26FPS_1336.xz;
        float CP26FPS_1397 = CP26FPS_1394.y;
        float2 CP26FPS_1398 = CP26FPS_1385.xz * 1.0f;
        float2 CP26FPS_1399 = floor(CP26FPS_1398);
        float2 CP26FPS_1402 = frac(CP26FPS_1399 * float2(123.339996337890625f, 456.209991455078125f));
        float2 CP26FPS_1406 = CP26FPS_1402 + dot(CP26FPS_1402, CP26FPS_1402 + 34.345001220703125f.xx).xx;
        float CP26FPS_1407 = CP26FPS_1406.x;
        float CP26FPS_1408 = CP26FPS_1406.y;
        float2 CP26FPS_1412 = frac(float2(CP26FPS_1407 * CP26FPS_1408, CP26FPS_1407 + CP26FPS_1408));
        float2 CP26FPS_1415 = frac((CP26FPS_1399 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 CP26FPS_1419 = CP26FPS_1415 + dot(CP26FPS_1415, CP26FPS_1415 + 34.345001220703125f.xx).xx;
        float CP26FPS_1420 = CP26FPS_1419.x;
        float CP26FPS_1421 = CP26FPS_1419.y;
        float2 CP26FPS_1425 = frac(float2(CP26FPS_1420 * CP26FPS_1421, CP26FPS_1420 + CP26FPS_1421));
        float CP26FPS_1431 = CP26FPS_1412.x;
        float CP26FPS_1434 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, CP26FPS_1431)) * CP26FPS_1374;
        float2 CP26FPS_1435 = ((CP26FPS_1398 - CP26FPS_1399) + ((((CP26FPS_1425 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 CP26FPS_1452;
        do
        {
            CP26FPS_1438 = dot(CP26FPS_1396, CP26FPS_1396);
            CP26FPS_1439 = CP26FPS_1438 <= 9.9999997473787516355514526367188e-06f;
            if (CP26FPS_1439)
            {
                CP26FPS_1452 = CP26FPS_1435;
                break;
            }
            float2 CP26FPS_1443 = CP26FPS_1396 * rsqrt(CP26FPS_1438);
            CP26FPS_1452 = float2(dot(CP26FPS_1435, float2(-CP26FPS_1443.y, CP26FPS_1443.x)), -dot(CP26FPS_1435, CP26FPS_1443));
            break;
        } while(false);
        float CP26FPS_1535;
        bool CP26FPS_1536;
        float2 CP26FPS_1459 = float2(CP26FPS_1452.x * 1.25f, CP26FPS_1452.y * ((CP26FPS_1452.y < 0.0f) ? 1.25f : 0.75f));
        float CP26FPS_1460 = length(CP26FPS_1459);
        float CP26FPS_1462 = CP26FPS_1382 + CP26FPS_1431;
        float CP26FPS_1466 = CP26FPS_1337 ? frac(CP26FPS_1462) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(CP26FPS_1462, 0.0f, 1.0f));
        float CP26FPS_1478 = CP26FPS_1412.y;
        float CP26FPS_1481 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, CP26FPS_1466) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, CP26FPS_1466)) * step(0.001000000047497451305389404296875f, smoothstep(CP26FPS_1434, 0.0f, CP26FPS_1460))) * step(CP26FPS_1344, CP26FPS_1478 - 0.100000001490116119384765625f);
        float CP26FPS_1484 = CP26FPS_1481 * CP26FPS_1397;
        float2 CP26FPS_1491 = float2(CP26FPS_1434 * CP26FPS_1481, CP26FPS_1434 - CP26FPS_1460) * CP26FPS_1397;
        float2 CP26FPS_1493 = CP26FPS_1336.xy;
        float CP26FPS_1494 = CP26FPS_1394.z;
        float2 CP26FPS_1495 = CP26FPS_1385.xy * 1.0f;
        float2 CP26FPS_1496 = floor(CP26FPS_1495);
        float2 CP26FPS_1499 = frac(CP26FPS_1496 * float2(123.339996337890625f, 456.209991455078125f));
        float2 CP26FPS_1503 = CP26FPS_1499 + dot(CP26FPS_1499, CP26FPS_1499 + 34.345001220703125f.xx).xx;
        float CP26FPS_1504 = CP26FPS_1503.x;
        float CP26FPS_1505 = CP26FPS_1503.y;
        float2 CP26FPS_1509 = frac(float2(CP26FPS_1504 * CP26FPS_1505, CP26FPS_1504 + CP26FPS_1505));
        float2 CP26FPS_1512 = frac((CP26FPS_1496 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 CP26FPS_1516 = CP26FPS_1512 + dot(CP26FPS_1512, CP26FPS_1512 + 34.345001220703125f.xx).xx;
        float CP26FPS_1517 = CP26FPS_1516.x;
        float CP26FPS_1518 = CP26FPS_1516.y;
        float2 CP26FPS_1522 = frac(float2(CP26FPS_1517 * CP26FPS_1518, CP26FPS_1517 + CP26FPS_1518));
        float CP26FPS_1528 = CP26FPS_1509.x;
        float CP26FPS_1531 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, CP26FPS_1528)) * CP26FPS_1374;
        float2 CP26FPS_1532 = ((CP26FPS_1495 - CP26FPS_1496) + ((((CP26FPS_1522 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 CP26FPS_1549;
        do
        {
            CP26FPS_1535 = dot(CP26FPS_1493, CP26FPS_1493);
            CP26FPS_1536 = CP26FPS_1535 <= 9.9999997473787516355514526367188e-06f;
            if (CP26FPS_1536)
            {
                CP26FPS_1549 = CP26FPS_1532;
                break;
            }
            float2 CP26FPS_1540 = CP26FPS_1493 * rsqrt(CP26FPS_1535);
            CP26FPS_1549 = float2(dot(CP26FPS_1532, float2(-CP26FPS_1540.y, CP26FPS_1540.x)), -dot(CP26FPS_1532, CP26FPS_1540));
            break;
        } while(false);
        float CP26FPS_1632;
        bool CP26FPS_1633;
        float2 CP26FPS_1556 = float2(CP26FPS_1549.x * 1.25f, CP26FPS_1549.y * ((CP26FPS_1549.y < 0.0f) ? 1.25f : 0.75f));
        float CP26FPS_1557 = length(CP26FPS_1556);
        float CP26FPS_1559 = CP26FPS_1382 + CP26FPS_1528;
        float CP26FPS_1563 = CP26FPS_1337 ? frac(CP26FPS_1559) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(CP26FPS_1559, 0.0f, 1.0f));
        float CP26FPS_1575 = CP26FPS_1509.y;
        float CP26FPS_1578 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, CP26FPS_1563) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, CP26FPS_1563)) * step(0.001000000047497451305389404296875f, smoothstep(CP26FPS_1531, 0.0f, CP26FPS_1557))) * step(CP26FPS_1344, CP26FPS_1575 - 0.100000001490116119384765625f);
        float CP26FPS_1581 = CP26FPS_1578 * CP26FPS_1494;
        float2 CP26FPS_1588 = float2(CP26FPS_1531 * CP26FPS_1578, CP26FPS_1531 - CP26FPS_1557) * CP26FPS_1494;
        float2 CP26FPS_1590 = CP26FPS_1336.zy;
        float CP26FPS_1591 = CP26FPS_1394.x;
        float2 CP26FPS_1592 = CP26FPS_1385.zy * 1.0f;
        float2 CP26FPS_1593 = floor(CP26FPS_1592);
        float2 CP26FPS_1596 = frac(CP26FPS_1593 * float2(123.339996337890625f, 456.209991455078125f));
        float2 CP26FPS_1600 = CP26FPS_1596 + dot(CP26FPS_1596, CP26FPS_1596 + 34.345001220703125f.xx).xx;
        float CP26FPS_1601 = CP26FPS_1600.x;
        float CP26FPS_1602 = CP26FPS_1600.y;
        float2 CP26FPS_1606 = frac(float2(CP26FPS_1601 * CP26FPS_1602, CP26FPS_1601 + CP26FPS_1602));
        float2 CP26FPS_1609 = frac((CP26FPS_1593 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 CP26FPS_1613 = CP26FPS_1609 + dot(CP26FPS_1609, CP26FPS_1609 + 34.345001220703125f.xx).xx;
        float CP26FPS_1614 = CP26FPS_1613.x;
        float CP26FPS_1615 = CP26FPS_1613.y;
        float2 CP26FPS_1619 = frac(float2(CP26FPS_1614 * CP26FPS_1615, CP26FPS_1614 + CP26FPS_1615));
        float CP26FPS_1625 = CP26FPS_1606.x;
        float CP26FPS_1628 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, CP26FPS_1625)) * CP26FPS_1374;
        float2 CP26FPS_1629 = ((CP26FPS_1592 - CP26FPS_1593) + ((((CP26FPS_1619 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 CP26FPS_1646;
        do
        {
            CP26FPS_1632 = dot(CP26FPS_1590, CP26FPS_1590);
            CP26FPS_1633 = CP26FPS_1632 <= 9.9999997473787516355514526367188e-06f;
            if (CP26FPS_1633)
            {
                CP26FPS_1646 = CP26FPS_1629;
                break;
            }
            float2 CP26FPS_1637 = CP26FPS_1590 * rsqrt(CP26FPS_1632);
            CP26FPS_1646 = float2(dot(CP26FPS_1629, float2(-CP26FPS_1637.y, CP26FPS_1637.x)), -dot(CP26FPS_1629, CP26FPS_1637));
            break;
        } while(false);
        float2 CP26FPS_1653 = float2(CP26FPS_1646.x * 1.25f, CP26FPS_1646.y * ((CP26FPS_1646.y < 0.0f) ? 1.25f : 0.75f));
        float CP26FPS_1654 = length(CP26FPS_1653);
        float CP26FPS_1656 = CP26FPS_1382 + CP26FPS_1625;
        float CP26FPS_1660 = CP26FPS_1337 ? frac(CP26FPS_1656) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(CP26FPS_1656, 0.0f, 1.0f));
        float CP26FPS_1672 = CP26FPS_1606.y;
        float CP26FPS_1675 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, CP26FPS_1660) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, CP26FPS_1660)) * step(0.001000000047497451305389404296875f, smoothstep(CP26FPS_1628, 0.0f, CP26FPS_1654))) * step(CP26FPS_1344, CP26FPS_1672 - 0.100000001490116119384765625f);
        float CP26FPS_1678 = CP26FPS_1675 * CP26FPS_1591;
        float2 CP26FPS_1685 = float2(CP26FPS_1628 * CP26FPS_1675, CP26FPS_1628 - CP26FPS_1654) * CP26FPS_1591;
        bool2 CP26FPS_4702 = isnan(CP26FPS_1588);
        bool2 CP26FPS_4703 = isnan(CP26FPS_1685);
        float2 CP26FPS_4704 = max(CP26FPS_1588, CP26FPS_1685);
        float2 CP26FPS_4705 = float2(CP26FPS_4702.x ? CP26FPS_1685.x : CP26FPS_4704.x, CP26FPS_4702.y ? CP26FPS_1685.y : CP26FPS_4704.y);
        float2 CP26FPS_1686 = float2(CP26FPS_4703.x ? CP26FPS_1588.x : CP26FPS_4705.x, CP26FPS_4703.y ? CP26FPS_1588.y : CP26FPS_4705.y);
        bool2 CP26FPS_4707 = isnan(CP26FPS_1491);
        bool2 CP26FPS_4708 = isnan(CP26FPS_1686);
        float2 CP26FPS_4709 = max(CP26FPS_1491, CP26FPS_1686);
        float2 CP26FPS_4710 = float2(CP26FPS_4707.x ? CP26FPS_1686.x : CP26FPS_4709.x, CP26FPS_4707.y ? CP26FPS_1686.y : CP26FPS_4709.y);
        float2 CP26FPS_1687 = float2(CP26FPS_4708.x ? CP26FPS_1491.x : CP26FPS_4710.x, CP26FPS_4708.y ? CP26FPS_1491.y : CP26FPS_4710.y);
        float CP26FPS_1693 = isnan(CP26FPS_1581) ? CP26FPS_1484 : (isnan(CP26FPS_1484) ? CP26FPS_1581 : max(CP26FPS_1484, CP26FPS_1581));
        float CP26FPS_1694 = isnan(CP26FPS_1693) ? CP26FPS_1678 : (isnan(CP26FPS_1678) ? CP26FPS_1693 : max(CP26FPS_1678, CP26FPS_1693));
        float4 CP26FPS_1697 = float4((float4(((clamp(CP26FPS_1459 / CP26FPS_1434.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, CP26FPS_1425.x)) * CP26FPS_1481) * CP26FPS_1397, CP26FPS_1484, CP26FPS_1478).xy + float4(((clamp(CP26FPS_1556 / CP26FPS_1531.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, CP26FPS_1522.x)) * CP26FPS_1578) * CP26FPS_1494, CP26FPS_1581, CP26FPS_1575).xy) + float4(((clamp(CP26FPS_1653 / CP26FPS_1628.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, CP26FPS_1619.x)) * CP26FPS_1675) * CP26FPS_1591, CP26FPS_1678, CP26FPS_1672).xy, CP26FPS_1694, 0.0f);
        float2 CP26FPS_1699 = CP26FPS_1386.xz * 1.0f;
        float2 CP26FPS_1700 = floor(CP26FPS_1699);
        float2 CP26FPS_1703 = frac(CP26FPS_1700 * float2(123.339996337890625f, 456.209991455078125f));
        float2 CP26FPS_1707 = CP26FPS_1703 + dot(CP26FPS_1703, CP26FPS_1703 + 34.345001220703125f.xx).xx;
        float CP26FPS_1708 = CP26FPS_1707.x;
        float CP26FPS_1709 = CP26FPS_1707.y;
        float2 CP26FPS_1713 = frac(float2(CP26FPS_1708 * CP26FPS_1709, CP26FPS_1708 + CP26FPS_1709));
        float2 CP26FPS_1716 = frac((CP26FPS_1700 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 CP26FPS_1720 = CP26FPS_1716 + dot(CP26FPS_1716, CP26FPS_1716 + 34.345001220703125f.xx).xx;
        float CP26FPS_1721 = CP26FPS_1720.x;
        float CP26FPS_1722 = CP26FPS_1720.y;
        float2 CP26FPS_1726 = frac(float2(CP26FPS_1721 * CP26FPS_1722, CP26FPS_1721 + CP26FPS_1722));
        float CP26FPS_1732 = CP26FPS_1713.x;
        float CP26FPS_1735 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, CP26FPS_1732)) * CP26FPS_1374;
        float2 CP26FPS_1736 = ((CP26FPS_1699 - CP26FPS_1700) + ((((CP26FPS_1726 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 CP26FPS_1751;
        do
        {
            if (CP26FPS_1439)
            {
                CP26FPS_1751 = CP26FPS_1736;
                break;
            }
            float2 CP26FPS_1742 = CP26FPS_1396 * rsqrt(CP26FPS_1438);
            CP26FPS_1751 = float2(dot(CP26FPS_1736, float2(-CP26FPS_1742.y, CP26FPS_1742.x)), -dot(CP26FPS_1736, CP26FPS_1742));
            break;
        } while(false);
        float2 CP26FPS_1758 = float2(CP26FPS_1751.x * 1.25f, CP26FPS_1751.y * ((CP26FPS_1751.y < 0.0f) ? 1.25f : 0.75f));
        float CP26FPS_1759 = length(CP26FPS_1758);
        float CP26FPS_1761 = CP26FPS_1384 + CP26FPS_1732;
        float CP26FPS_1765 = CP26FPS_1337 ? frac(CP26FPS_1761) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(CP26FPS_1761, 0.0f, 1.0f));
        float CP26FPS_1777 = CP26FPS_1713.y;
        float CP26FPS_1780 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, CP26FPS_1765) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, CP26FPS_1765)) * step(0.001000000047497451305389404296875f, smoothstep(CP26FPS_1735, 0.0f, CP26FPS_1759))) * step(CP26FPS_1344, CP26FPS_1777 - 0.100000001490116119384765625f);
        float CP26FPS_1783 = CP26FPS_1780 * CP26FPS_1397;
        float2 CP26FPS_1790 = float2(CP26FPS_1735 * CP26FPS_1780, CP26FPS_1735 - CP26FPS_1759) * CP26FPS_1397;
        float2 CP26FPS_1792 = CP26FPS_1386.xy * 1.0f;
        float2 CP26FPS_1793 = floor(CP26FPS_1792);
        float2 CP26FPS_1796 = frac(CP26FPS_1793 * float2(123.339996337890625f, 456.209991455078125f));
        float2 CP26FPS_1800 = CP26FPS_1796 + dot(CP26FPS_1796, CP26FPS_1796 + 34.345001220703125f.xx).xx;
        float CP26FPS_1801 = CP26FPS_1800.x;
        float CP26FPS_1802 = CP26FPS_1800.y;
        float2 CP26FPS_1806 = frac(float2(CP26FPS_1801 * CP26FPS_1802, CP26FPS_1801 + CP26FPS_1802));
        float2 CP26FPS_1809 = frac((CP26FPS_1793 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 CP26FPS_1813 = CP26FPS_1809 + dot(CP26FPS_1809, CP26FPS_1809 + 34.345001220703125f.xx).xx;
        float CP26FPS_1814 = CP26FPS_1813.x;
        float CP26FPS_1815 = CP26FPS_1813.y;
        float2 CP26FPS_1819 = frac(float2(CP26FPS_1814 * CP26FPS_1815, CP26FPS_1814 + CP26FPS_1815));
        float CP26FPS_1825 = CP26FPS_1806.x;
        float CP26FPS_1828 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, CP26FPS_1825)) * CP26FPS_1374;
        float2 CP26FPS_1829 = ((CP26FPS_1792 - CP26FPS_1793) + ((((CP26FPS_1819 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 CP26FPS_1844;
        do
        {
            if (CP26FPS_1536)
            {
                CP26FPS_1844 = CP26FPS_1829;
                break;
            }
            float2 CP26FPS_1835 = CP26FPS_1493 * rsqrt(CP26FPS_1535);
            CP26FPS_1844 = float2(dot(CP26FPS_1829, float2(-CP26FPS_1835.y, CP26FPS_1835.x)), -dot(CP26FPS_1829, CP26FPS_1835));
            break;
        } while(false);
        float2 CP26FPS_1851 = float2(CP26FPS_1844.x * 1.25f, CP26FPS_1844.y * ((CP26FPS_1844.y < 0.0f) ? 1.25f : 0.75f));
        float CP26FPS_1852 = length(CP26FPS_1851);
        float CP26FPS_1854 = CP26FPS_1384 + CP26FPS_1825;
        float CP26FPS_1858 = CP26FPS_1337 ? frac(CP26FPS_1854) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(CP26FPS_1854, 0.0f, 1.0f));
        float CP26FPS_1870 = CP26FPS_1806.y;
        float CP26FPS_1873 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, CP26FPS_1858) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, CP26FPS_1858)) * step(0.001000000047497451305389404296875f, smoothstep(CP26FPS_1828, 0.0f, CP26FPS_1852))) * step(CP26FPS_1344, CP26FPS_1870 - 0.100000001490116119384765625f);
        float CP26FPS_1876 = CP26FPS_1873 * CP26FPS_1494;
        float2 CP26FPS_1883 = float2(CP26FPS_1828 * CP26FPS_1873, CP26FPS_1828 - CP26FPS_1852) * CP26FPS_1494;
        float2 CP26FPS_1885 = CP26FPS_1386.zy * 1.0f;
        float2 CP26FPS_1886 = floor(CP26FPS_1885);
        float2 CP26FPS_1889 = frac(CP26FPS_1886 * float2(123.339996337890625f, 456.209991455078125f));
        float2 CP26FPS_1893 = CP26FPS_1889 + dot(CP26FPS_1889, CP26FPS_1889 + 34.345001220703125f.xx).xx;
        float CP26FPS_1894 = CP26FPS_1893.x;
        float CP26FPS_1895 = CP26FPS_1893.y;
        float2 CP26FPS_1899 = frac(float2(CP26FPS_1894 * CP26FPS_1895, CP26FPS_1894 + CP26FPS_1895));
        float2 CP26FPS_1902 = frac((CP26FPS_1886 + 114.51399993896484375f.xx) * float2(123.339996337890625f, 456.209991455078125f));
        float2 CP26FPS_1906 = CP26FPS_1902 + dot(CP26FPS_1902, CP26FPS_1902 + 34.345001220703125f.xx).xx;
        float CP26FPS_1907 = CP26FPS_1906.x;
        float CP26FPS_1908 = CP26FPS_1906.y;
        float2 CP26FPS_1912 = frac(float2(CP26FPS_1907 * CP26FPS_1908, CP26FPS_1907 + CP26FPS_1908));
        float CP26FPS_1918 = CP26FPS_1899.x;
        float CP26FPS_1921 = (0.25f * lerp(0.60000002384185791015625f, 1.0f, CP26FPS_1918)) * CP26FPS_1374;
        float2 CP26FPS_1922 = ((CP26FPS_1885 - CP26FPS_1886) + ((((CP26FPS_1912 * 2.0f) - 1.0f.xx) * 0.25f) * 1.0f)) - 0.5f.xx;
        float2 CP26FPS_1937;
        do
        {
            if (CP26FPS_1633)
            {
                CP26FPS_1937 = CP26FPS_1922;
                break;
            }
            float2 CP26FPS_1928 = CP26FPS_1590 * rsqrt(CP26FPS_1632);
            CP26FPS_1937 = float2(dot(CP26FPS_1922, float2(-CP26FPS_1928.y, CP26FPS_1928.x)), -dot(CP26FPS_1922, CP26FPS_1928));
            break;
        } while(false);
        float2 CP26FPS_1944 = float2(CP26FPS_1937.x * 1.25f, CP26FPS_1937.y * ((CP26FPS_1937.y < 0.0f) ? 1.25f : 0.75f));
        float CP26FPS_1945 = length(CP26FPS_1944);
        float CP26FPS_1947 = CP26FPS_1384 + CP26FPS_1918;
        float CP26FPS_1951 = CP26FPS_1337 ? frac(CP26FPS_1947) : lerp(0.2199999988079071044921875f, 0.85000002384185791015625f, clamp(CP26FPS_1947, 0.0f, 1.0f));
        float CP26FPS_1963 = CP26FPS_1899.y;
        float CP26FPS_1966 = ((smoothstep(0.20000000298023223876953125f, 0.2199999988079071044921875f, CP26FPS_1951) * smoothstep(0.85000002384185791015625f, 0.550000011920928955078125f, CP26FPS_1951)) * step(0.001000000047497451305389404296875f, smoothstep(CP26FPS_1921, 0.0f, CP26FPS_1945))) * step(CP26FPS_1344, CP26FPS_1963 - 0.100000001490116119384765625f);
        float CP26FPS_1969 = CP26FPS_1966 * CP26FPS_1591;
        float2 CP26FPS_1976 = float2(CP26FPS_1921 * CP26FPS_1966, CP26FPS_1921 - CP26FPS_1945) * CP26FPS_1591;
        bool2 CP26FPS_4722 = isnan(CP26FPS_1883);
        bool2 CP26FPS_4723 = isnan(CP26FPS_1976);
        float2 CP26FPS_4724 = max(CP26FPS_1883, CP26FPS_1976);
        float2 CP26FPS_4725 = float2(CP26FPS_4722.x ? CP26FPS_1976.x : CP26FPS_4724.x, CP26FPS_4722.y ? CP26FPS_1976.y : CP26FPS_4724.y);
        float2 CP26FPS_1977 = float2(CP26FPS_4723.x ? CP26FPS_1883.x : CP26FPS_4725.x, CP26FPS_4723.y ? CP26FPS_1883.y : CP26FPS_4725.y);
        bool2 CP26FPS_4727 = isnan(CP26FPS_1790);
        bool2 CP26FPS_4728 = isnan(CP26FPS_1977);
        float2 CP26FPS_4729 = max(CP26FPS_1790, CP26FPS_1977);
        float2 CP26FPS_4730 = float2(CP26FPS_4727.x ? CP26FPS_1977.x : CP26FPS_4729.x, CP26FPS_4727.y ? CP26FPS_1977.y : CP26FPS_4729.y);
        float CP26FPS_1984 = isnan(CP26FPS_1876) ? CP26FPS_1783 : (isnan(CP26FPS_1783) ? CP26FPS_1876 : max(CP26FPS_1783, CP26FPS_1876));
        float4 CP26FPS_1988 = float4((float4(((clamp(CP26FPS_1758 / CP26FPS_1735.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, CP26FPS_1726.x)) * CP26FPS_1780) * CP26FPS_1397, CP26FPS_1783, CP26FPS_1777).xy + float4(((clamp(CP26FPS_1851 / CP26FPS_1828.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, CP26FPS_1819.x)) * CP26FPS_1873) * CP26FPS_1494, CP26FPS_1876, CP26FPS_1870).xy) + float4(((clamp(CP26FPS_1944 / CP26FPS_1921.xx, (-1.0f).xx, 1.0f.xx) * lerp(0.25f, 0.5f, CP26FPS_1912.x)) * CP26FPS_1966) * CP26FPS_1591, CP26FPS_1969, CP26FPS_1963).xy, isnan(CP26FPS_1984) ? CP26FPS_1969 : (isnan(CP26FPS_1969) ? CP26FPS_1984 : max(CP26FPS_1969, CP26FPS_1984)), 0.0f);
        float CP26FPS_1990 = step(CP26FPS_1687.x, 0.00999999977648258209228515625f);
        float2 CP26FPS_1997 = CP26FPS_1697.zw * step(0.00999999977648258209228515625f, CP26FPS_1694);
        float2 CP26FPS_1999 = CP26FPS_1988.zw * CP26FPS_1990;
        bool2 CP26FPS_4742 = isnan(CP26FPS_1997);
        bool2 CP26FPS_4743 = isnan(CP26FPS_1999);
        float2 CP26FPS_4744 = max(CP26FPS_1997, CP26FPS_1999);
        float2 CP26FPS_4745 = float2(CP26FPS_4742.x ? CP26FPS_1999.x : CP26FPS_4744.x, CP26FPS_4742.y ? CP26FPS_1999.y : CP26FPS_4744.y);
        float2 CP26FPS_2002 = (float2(CP26FPS_4728.x ? CP26FPS_1790.x : CP26FPS_4730.x, CP26FPS_4728.y ? CP26FPS_1790.y : CP26FPS_4730.y) * float2(0.661900997161865234375f, 1.0f)) * CP26FPS_1990;
        bool2 CP26FPS_4747 = isnan(CP26FPS_1687);
        bool2 CP26FPS_4748 = isnan(CP26FPS_2002);
        float2 CP26FPS_4749 = max(CP26FPS_1687, CP26FPS_2002);
        float2 CP26FPS_4750 = float2(CP26FPS_4747.x ? CP26FPS_2002.x : CP26FPS_4749.x, CP26FPS_4747.y ? CP26FPS_2002.y : CP26FPS_4749.y);
        float2 CP26FPS_2003 = float2(CP26FPS_4748.x ? CP26FPS_1687.x : CP26FPS_4750.x, CP26FPS_4748.y ? CP26FPS_1687.y : CP26FPS_4750.y);
        float CP26FPS_2008 = clamp(dot(CP26FPS_543, CP26FPS_677), 0.0f, 1.0f);
        float CP26FPS_2017 = float2(CP26FPS_4743.x ? CP26FPS_1997.x : CP26FPS_4745.x, CP26FPS_4743.y ? CP26FPS_1997.y : CP26FPS_4745.y).x * (CP26FPS_2008 * lerp(0.4000000059604644775390625f, 1.0f, smoothstep(0.0f, 4.0f, abs(CP26FPS_18_m2[1].y) / CP26FPS_544)));
        float2 CP26FPS_2018 = (CP26FPS_1697.xy + (CP26FPS_1988.xy * CP26FPS_1990)).xy;
        float CP26FPS_2023 = sqrt(1.0f - clamp(dot(CP26FPS_2018, CP26FPS_2018), 0.0f, 1.0f));
        float3 CP26FPS_2029 = normalize(float3(CP26FPS_2018 * (2.5f * CP26FPS_2008), isnan(CP26FPS_2023) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? CP26FPS_2023 : max(1.000000016862383526387164645044e-16f, CP26FPS_2023))));
        float2 CP26FPS_2031 = CP26FPS_2029.xy;
        float CP26FPS_2035 = sqrt(1.0f - clamp(dot(CP26FPS_2031, CP26FPS_2031), 0.0f, 1.0f));
        float3 CP26FPS_2037 = float3(CP26FPS_2029.x, CP26FPS_2029.y, 0.0f.xxx.z);
        CP26FPS_2037.z = isnan(CP26FPS_2035) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? CP26FPS_2035 : max(1.000000016862383526387164645044e-16f, CP26FPS_2035));
        float3 CP26FPS_2038 = normalize(CP26FPS_2037);
        float3 CP26FPS_2039 = cross(CP26FPS_677, float3(0.0f, 1.0f, 0.0f));
        bool3 CP26FPS_2042 = (dot(CP26FPS_2039, CP26FPS_2039) > 6.103515625e-05f).xxx;
        float3 CP26FPS_2043 = normalize(CP26FPS_2039);
        float3 CP26FPS_2044 = float3(CP26FPS_2042.x ? CP26FPS_2043.x : float3(1.0f, 0.0f, 0.0f).x, CP26FPS_2042.y ? CP26FPS_2043.y : float3(1.0f, 0.0f, 0.0f).y, CP26FPS_2042.z ? CP26FPS_2043.z : float3(1.0f, 0.0f, 0.0f).z);
        float CP26FPS_2048 = CP26FPS_2038.y;
        float CP26FPS_2055 = CP26FPS_2003.x * 4.0f;
        float CP26FPS_2065 = clamp(dot(CP26FPS_2038, normalize(float3(0.0f, -1.0f, 0.75f))), 0.0f, 1.0f);
        float CP26FPS_2071 = (0.60000002384185791015625f * CP26FPS_2017) * CP26FPS_2055;
        float CP26FPS_2074 = (1.0f - CP26FPS_2071) + (clamp(clamp(clamp(CP26FPS_2003.y * 17.54000091552734375f, 0.0f, 1.0f), 0.0f, 1.0f) + clamp(1.60000002384185791015625f * CP26FPS_2048, 0.0f, 1.0f), 0.0f, 1.0f) * CP26FPS_2071);
        float CP26FPS_2077 = smoothstep(0.60000002384185791015625f, 1.0f, CP26FPS_2074);
        float CP26FPS_2080 = CP26FPS_2017 * CP26FPS_2055;
        CP26FPS_2088 = normalize(((CP26FPS_2044 * CP26FPS_2038.x) + (cross(CP26FPS_2044, CP26FPS_677) * CP26FPS_2048)) + (CP26FPS_677 * CP26FPS_2038.z));
        CP26FPS_2089 = CP26FPS_1375 + (2.0f * CP26FPS_776);
        CP26FPS_2090 = CP26FPS_2080;
        CP26FPS_2091 = ((lerp(0.0500000007450580596923828125f, 1.7999999523162841796875f, (CP26FPS_2065 * CP26FPS_2065) * CP26FPS_2065) * CP26FPS_2055) * CP26FPS_2077) * CP26FPS_2017;
        CP26FPS_2092 = lerp(1.0f, 0.800000011920928955078125f * lerp(0.5f, 1.0f, CP26FPS_2077), CP26FPS_2017);
        CP26FPS_2093 = CP26FPS_2080;
        CP26FPS_2094 = (CP26FPS_615 * CP26FPS_2074) * CP26FPS_1377;
        CP26FPS_2095 = (CP26FPS_582 * CP26FPS_2074) * CP26FPS_1377;
    }
    else
    {
        CP26FPS_2088 = CP26FPS_677;
        CP26FPS_2089 = 1.0f;
        CP26FPS_2090 = 0.0f;
        CP26FPS_2091 = 0.0f;
        CP26FPS_2092 = 1.0f;
        CP26FPS_2093 = 0.0f;
        CP26FPS_2094 = CP26FPS_615;
        CP26FPS_2095 = CP26FPS_582;
    }
    float3 CP26FPS_2207;
    float3 CP26FPS_2208;
    float3 CP26FPS_2209;
    float CP26FPS_2210;
    [branch]
    if (CP26FPS_765 > 0.00999999977648258209228515625f)
    {
        bool3 CP26FPS_2099 = CP26FPS_552.xxx;
        float3 CP26FPS_2101 = CP26FPS_11.xzy * float3(1.0f, 1.0f, -1.0f);
        float3 CP26FPS_2102 = float3(CP26FPS_2099.x ? CP26FPS_2101.x : CP26FPS_11.x, CP26FPS_2099.y ? CP26FPS_2101.y : CP26FPS_11.y, CP26FPS_2099.z ? CP26FPS_2101.z : CP26FPS_11.z);
        float3 CP26FPS_2105 = CP26FPS_2102 * CP26FPS_20_m89.z;
        float3 CP26FPS_2107 = float3(CP26FPS_2099.x ? CP26FPS_9.xzy.x : CP26FPS_9.x, CP26FPS_2099.y ? CP26FPS_9.xzy.y : CP26FPS_9.y, CP26FPS_2099.z ? CP26FPS_9.xzy.z : CP26FPS_9.z);
        float3 CP26FPS_2109 = abs(CP26FPS_2107) - 0.20000000298023223876953125f.xxx;
        float3 CP26FPS_2111 = (CP26FPS_2109 * CP26FPS_2109) * CP26FPS_2109;
        bool3 CP26FPS_4762 = isnan(CP26FPS_2111);
        bool3 CP26FPS_4763 = isnan(6.103515625e-05f.xxx);
        float3 CP26FPS_4764 = max(CP26FPS_2111, 6.103515625e-05f.xxx);
        float3 CP26FPS_4765 = float3(CP26FPS_4762.x ? 6.103515625e-05f.xxx.x : CP26FPS_4764.x, CP26FPS_4762.y ? 6.103515625e-05f.xxx.y : CP26FPS_4764.y, CP26FPS_4762.z ? 6.103515625e-05f.xxx.z : CP26FPS_4764.z);
        float3 CP26FPS_2112 = float3(CP26FPS_4763.x ? CP26FPS_2111.x : CP26FPS_4765.x, CP26FPS_4763.y ? CP26FPS_2111.y : CP26FPS_4765.y, CP26FPS_4763.z ? CP26FPS_2111.z : CP26FPS_4765.z);
        float3 CP26FPS_2115 = CP26FPS_2112 / dot(CP26FPS_2112, 1.0f.xxx).xxx;
        float4 CP26FPS_2138 = ((CP26FPS_58.SampleBias(CP26F_linear_repeat_sampler, CP26FPS_2105.xz, CP26FPS_20_m16) * CP26FPS_2115.y) + (CP26FPS_58.SampleBias(CP26F_linear_repeat_sampler, CP26FPS_2105.xy, CP26FPS_20_m16) * CP26FPS_2115.z)) + (CP26FPS_58.SampleBias(CP26F_linear_repeat_sampler, CP26FPS_2105.zy, CP26FPS_20_m16) * CP26FPS_2115.x);
        float CP26FPS_2146 = clamp(CP26FPS_765 + (smoothstep(0.3499999940395355224609375f, 0.20000000298023223876953125f, CP26FPS_2102.y) * clamp(CP26FPS_765 * 3.0f, 0.0f, 1.0f)), 0.0f, 1.0f);
        float CP26FPS_2157 = smoothstep(2.0f - CP26FPS_2146, 2.349999904632568359375f - CP26FPS_2146, ((CP26FPS_2107.y * 0.64999997615814208984375f) + 0.3499999940395355224609375f) + CP26FPS_2138.z) * ((CP26FPS_589 * CP26FPS_589) * float(CP26FPS_gl_FrontFacing));
        float3 CP26FPS_2159 = CP26FPS_2157.xxx;
        float2 CP26FPS_2165 = (CP26FPS_2138.xy * 2.0f) - 1.0f.xx;
        float2 CP26FPS_2167 = CP26FPS_2165.xy;
        float CP26FPS_2171 = sqrt(1.0f - clamp(dot(CP26FPS_2167, CP26FPS_2167), 0.0f, 1.0f));
        float3 CP26FPS_2173 = float3(CP26FPS_2165.x, CP26FPS_2165.y, CP26FPS_503.z);
        CP26FPS_2173.z = isnan(CP26FPS_2171) ? 1.000000016862383526387164645044e-16f : (isnan(1.000000016862383526387164645044e-16f) ? CP26FPS_2171 : max(1.000000016862383526387164645044e-16f, CP26FPS_2171));
        float2 CP26FPS_2175 = CP26FPS_2173.xy * 2.0f;
        float3 CP26FPS_2177 = lerp(float3(0.0f, 0.0f, 1.0f), float3(CP26FPS_2175.x, CP26FPS_2175.y, CP26FPS_2173.z), CP26FPS_2159);
        float CP26FPS_2178 = dot(CP26FPS_2177, CP26FPS_2177);
        float3 CP26FPS_2181 = CP26FPS_2177 * rsqrt(isnan(CP26FPS_2178) ? 6.103515625e-05f : (isnan(6.103515625e-05f) ? CP26FPS_2178 : max(6.103515625e-05f, CP26FPS_2178)));
        float CP26FPS_2182 = CP26FPS_677.y;
        float CP26FPS_2185 = step(0.00999999977648258209228515625f, 1.0f - (CP26FPS_2182 * CP26FPS_2182));
        float CP26FPS_2189 = lerp(CP26FPS_677.z, CP26FPS_2182, CP26FPS_2185);
        float CP26FPS_2191 = 1.0f - (CP26FPS_2189 * CP26FPS_2189);
        float3 CP26FPS_2196 = (float3(0.0f, CP26FPS_2185, 1.0f - CP26FPS_2185) - (CP26FPS_677 * CP26FPS_2189)) * rsqrt(isnan(CP26FPS_2191) ? 9.9999997473787516355514526367188e-05f : (isnan(9.9999997473787516355514526367188e-05f) ? CP26FPS_2191 : max(9.9999997473787516355514526367188e-05f, CP26FPS_2191)));
        CP26FPS_2207 = ((cross(CP26FPS_2196, CP26FPS_677) * CP26FPS_2181.x) + (CP26FPS_2196 * CP26FPS_2181.y)) + (CP26FPS_677 * CP26FPS_2181.z);
        CP26FPS_2208 = lerp(CP26FPS_2094 * 1.0f, 0.3079999983310699462890625f.xxx, CP26FPS_2159);
        CP26FPS_2209 = lerp(CP26FPS_2095 * 1.0f, 0.87999999523162841796875f.xxx, CP26FPS_2159);
        CP26FPS_2210 = lerp(0.0f, 0.0f, CP26FPS_2157);
    }
    else
    {
        CP26FPS_2207 = CP26FPS_677;
        CP26FPS_2208 = CP26FPS_2094;
        CP26FPS_2209 = CP26FPS_2095;
        CP26FPS_2210 = 0.0f;
    }
    float CP26FPS_2212 = 0.959999978542327880859375f - (CP26FPS_2210 * 0.959999978542327880859375f);
    float3 CP26FPS_2213 = CP26FPS_2209 * CP26FPS_2212;
    float3 CP26FPS_2216 = lerp(0.039999999105930328369140625f.xxx * CP26FPS_588, CP26FPS_2209, CP26FPS_2210.xxx);
    float3 CP26FPS_2217 = CP26FPS_2208 * CP26FPS_2212;
    float2 CP26FPS_2230 = (CP26FPS_7.xy / (isnan(9.9999999392252902907785028219223e-09f) ? CP26FPS_7.z : (isnan(CP26FPS_7.z) ? 9.9999999392252902907785028219223e-09f : max(CP26FPS_7.z, 9.9999999392252902907785028219223e-09f))).xx) - (CP26FPS_8.xy / (isnan(9.9999999392252902907785028219223e-09f) ? CP26FPS_8.z : (isnan(CP26FPS_8.z) ? 9.9999999392252902907785028219223e-09f : max(CP26FPS_8.z, 9.9999999392252902907785028219223e-09f))).xx);
    float2 CP26FPS_2233 = CP26FPS_2230;
    CP26FPS_2233.y = -CP26FPS_2230.y;
    float2 CP26FPS_2243 = ((sqrt(sqrt(abs(CP26FPS_2233 * 0.5f))) * float2(int2(sign(CP26FPS_2233)))) * 0.5f) + 0.5f.xx;
    float4 CP26FPS_2247 = float4(CP26FPS_2243.x, CP26FPS_2243.y, 0.0f.xxxx.z, 0.0f.xxxx.w);
    CP26FPS_2247.z = 1.0f;
    float4 CP26FPS_2248 = CP26FPS_2247;
    CP26FPS_2248.w = (CP26FPS_2093 > 0.100000001490116119384765625f) ? 0.699999988079071044921875f : 0.4000000059604644775390625f;
    float3 CP26FPS_2259 = lerp(-CP26FPS_36_m0.xyz, CP26FPS_20_m90.xyz, CP26FPS_20_m80.w.xxx);
    float3 CP26FPS_2263 = normalize(float3(CP26FPS_2259.x, 6.103515625e-05f, CP26FPS_2259.z));
    float3 CP26FPS_2273 = lerp(CP26FPS_36_m3.xyz, CP26FPS_20_m84.xyz, CP26FPS_20_m91.y.xxx);
    float3 CP26FPS_2277 = CP26FPS_2273 * lerp(CP26FPS_36_m3.w, 1.0f, CP26FPS_20_m91.w);
    float CP26FPS_2404;
    do
    {
        float CP26FPS_2286 = log2(float(asuint(CP26FPS_LoadInstance(CP26FPS_13)._m2.z))) - 8.0f;
        float CP26FPS_2403;
        if ((CP26FPS_2286 >= 0.0f) && (CP26FPS_2286 < CP26FPS_40_m20.z))
        {
            int CP26FPS_2294 = int(CP26FPS_2286);
            float CP26FPS_2300 = 1.0f - clamp(dot(CP26FPS_678, CP26FPS_40_m17[CP26FPS_2294].xyz), 0.0f, 0.89999997615814208984375f);
            float4 CP26FPS_2317 = mul(CP26FPS_40_m15[CP26FPS_2294], float4((CP26FPS_650 - (CP26FPS_40_m17[CP26FPS_2294].xyz * (CP26FPS_2300 * CP26FPS_40_m16[CP26FPS_2294].x))) + (CP26FPS_678 * (CP26FPS_2300 * CP26FPS_40_m16[CP26FPS_2294].y)), 1.0f));
            float CP26FPS_2318 = CP26FPS_2317.z;
            float CP26FPS_2319 = isnan(0.00999999977648258209228515625f) ? CP26FPS_2318 : (isnan(CP26FPS_2318) ? 0.00999999977648258209228515625f : max(CP26FPS_2318, 0.00999999977648258209228515625f));
            float4 CP26FPS_2320 = CP26FPS_2317;
            CP26FPS_2320.z = CP26FPS_2319;
            bool3 CP26FPS_2322 = bool3(CP26FPS_2320.xyz.x <= 0.0f.xxx.x, CP26FPS_2320.xyz.y <= 0.0f.xxx.y, CP26FPS_2320.xyz.z <= 0.0f.xxx.z);
            bool3 CP26FPS_2323 = bool3(CP26FPS_2320.xyz.x >= 1.0f.xxx.x, CP26FPS_2320.xyz.y >= 1.0f.xxx.y, CP26FPS_2320.xyz.z >= 1.0f.xxx.z);
            if (any(bool3(CP26FPS_2322.x || CP26FPS_2323.x, CP26FPS_2322.y || CP26FPS_2323.y, CP26FPS_2322.z || CP26FPS_2323.z)) || ((asuint(CP26FPS_2319) & 2147483647u) > 2139095040u))
            {
                CP26FPS_2404 = 1.0f;
                break;
            }
            float CP26FPS_2344 = 4.0f * CP26FPS_40_m19.x;
            float2 CP26FPS_2345 = (CP26FPS_40_m18[CP26FPS_2294].xy + (CP26FPS_2320.xy * CP26FPS_40_m18[CP26FPS_2294].zw)).xy;
            int2 CP26FPS_2347 = int2(CP26FPS_729 % uint2(4u, 4u));
            int CP26FPS_2351 = (CP26FPS_2347.x * 4) + CP26FPS_2347.y;
            float2x2 CP26FPS_2358 = float2x2(CP26FPS_477[CP26FPS_2351], float2(-CP26FPS_477[CP26FPS_2351].y, CP26FPS_477[CP26FPS_2351].x));
            float CP26FPS_2360;
            float CP26FPS_2363;
            CP26FPS_2360 = 0.0f;
            CP26FPS_2363 = 0.0f;
            for (uint CP26FPS_2365 = 0u; CP26FPS_2365 < 16u; )
            {
                float4 CP26FPS_2377 = CP26FPS_43.GatherRed(CP26F_linear_clamp_sampler, CP26FPS_2345 + (mul(CP26FPS_476[CP26FPS_2365], CP26FPS_2358) * CP26FPS_2344)) - CP26FPS_2319.xxxx;
                float4 CP26FPS_2378 = step(0.0f.xxxx, CP26FPS_2377);
                CP26FPS_2360 += dot(CP26FPS_2377, CP26FPS_2378);
                CP26FPS_2363 += dot(CP26FPS_2378, 1.0f.xxxx);
                CP26FPS_2365++;
                continue;
            }
            float CP26FPS_2389 = (2.0f * clamp(CP26FPS_2363 * 0.015625f, 0.0f, 1.0f)) - 1.0f;
            float CP26FPS_2392 = float(int(sign(CP26FPS_2389)));
            float CP26FPS_2394 = 1.0f - (CP26FPS_2392 * CP26FPS_2389);
            float CP26FPS_2401 = 0.5f - (0.5f * ((1.0f - lerp((CP26FPS_2394 * CP26FPS_2394) * CP26FPS_2394, CP26FPS_2394, clamp((CP26FPS_2360 * (1.0f / CP26FPS_2363)) * (1.0f / CP26FPS_2319), 0.0f, 1.0f))) * CP26FPS_2392));
            CP26FPS_2403 = isnan(CP26FPS_2401) ? 1.0f : (isnan(1.0f) ? CP26FPS_2401 : min(1.0f, CP26FPS_2401));
        }
        else
        {
            CP26FPS_2403 = 1.0f;
        }
        CP26FPS_2404 = CP26FPS_2403;
        break;
    } while(false);
    float2 CP26FPS_2881;
    do
    {
        if (CP26FPS_40_m7.w >= 0.9900000095367431640625f)
        {
            CP26FPS_2881 = float2(CP26FPS_40_m7.z, 1.0f);
            break;
        }
        int CP26FPS_2417 = int(CP26FPS_40_m7.x);
        bool3 CP26FPS_2419 = (CP26FPS_2417 == 2).xxx;
        float3 CP26FPS_2424 = CP26FPS_650 - float3(CP26FPS_2419.x ? CP26FPS_40_m1[0].xyz.x : CP26FPS_18_m11.xyz.x, CP26FPS_2419.y ? CP26FPS_40_m1[0].xyz.y : CP26FPS_18_m11.xyz.y, CP26FPS_2419.z ? CP26FPS_40_m1[0].xyz.z : CP26FPS_18_m11.xyz.z);
        float CP26FPS_2432 = clamp((CP26FPS_40_m6.w - dot(CP26FPS_2424, CP26FPS_2424)) * CP26FPS_40_m6.z, 0.0f, 1.0f);
        float CP26FPS_2435 = isnan(CP26FPS_40_m8.x) ? CP26FPS_2432 : (isnan(CP26FPS_2432) ? CP26FPS_40_m8.x : max(CP26FPS_2432, CP26FPS_40_m8.x));
        float CP26FPS_2623;
        bool CP26FPS_2624;
        if (CP26FPS_2435 > 0.0f)
        {
            float CP26FPS_2621;
            bool CP26FPS_2622;
            if (CP26FPS_2417 > 0)
            {
                float3 CP26FPS_2442 = CP26FPS_650 - CP26FPS_40_m1[0].xyz;
                float3 CP26FPS_2446 = CP26FPS_650 - CP26FPS_40_m1[1].xyz;
                float3 CP26FPS_2450 = CP26FPS_650 - CP26FPS_40_m1[2].xyz;
                float3 CP26FPS_2454 = CP26FPS_650 - CP26FPS_40_m1[3].xyz;
                float4 CP26FPS_2459 = float4(dot(CP26FPS_2442, CP26FPS_2442), dot(CP26FPS_2446, CP26FPS_2446), dot(CP26FPS_2450, CP26FPS_2450), dot(CP26FPS_2454, CP26FPS_2454));
                float4 CP26FPS_2468 = float4(CP26FPS_40_m1[0].w, CP26FPS_40_m1[1].w, CP26FPS_40_m1[2].w, CP26FPS_40_m1[3].w);
                bool4 CP26FPS_2469 = bool4(CP26FPS_2459.x < CP26FPS_2468.x, CP26FPS_2459.y < CP26FPS_2468.y, CP26FPS_2459.z < CP26FPS_2468.z, CP26FPS_2459.w < CP26FPS_2468.w);
                float4 CP26FPS_2470 = float4(CP26FPS_2469.x ? 1.0f.xxxx.x : 0.0f.xxxx.x, CP26FPS_2469.y ? 1.0f.xxxx.y : 0.0f.xxxx.y, CP26FPS_2469.z ? 1.0f.xxxx.z : 0.0f.xxxx.z, CP26FPS_2469.w ? 1.0f.xxxx.w : 0.0f.xxxx.w);
                float3 CP26FPS_2474 = clamp(CP26FPS_2470.yzw - CP26FPS_2470.xyz, 0.0f.xxx, 1.0f.xxx);
                float CP26FPS_2478 = clamp(4.0f - dot(float4(CP26FPS_2470.x, CP26FPS_2474.x, CP26FPS_2474.y, CP26FPS_2474.z), float4(4.0f, 3.0f, 2.0f, 1.0f)), 0.0f, 3.0f);
                float CP26FPS_2481 = isnan(CP26FPS_40_m6.y) ? CP26FPS_2478 : (isnan(CP26FPS_2478) ? CP26FPS_40_m6.y : max(CP26FPS_2478, CP26FPS_40_m6.y));
                float4 CP26FPS_2488 = mul(CP26FPS_40_m0[uint(CP26FPS_2481)], float4(CP26FPS_650.x, CP26FPS_771, CP26FPS_650.z, 1.0f));
                float CP26FPS_2491 = CP26FPS_2488.z;
                float4 CP26FPS_2492 = float4(CP26FPS_2488.xy, CP26FPS_2491, CP26FPS_2481);
                float3 CP26FPS_2493 = CP26FPS_2492.xyz;
                bool3 CP26FPS_2494 = bool3(CP26FPS_2493.x <= 0.0f.xxx.x, CP26FPS_2493.y <= 0.0f.xxx.y, CP26FPS_2493.z <= 0.0f.xxx.z);
                bool3 CP26FPS_2495 = bool3(CP26FPS_2493.x >= 1.0f.xxx.x, CP26FPS_2493.y >= 1.0f.xxx.y, CP26FPS_2493.z >= 1.0f.xxx.z);
                bool CP26FPS_2501 = any(bool3(CP26FPS_2494.x || CP26FPS_2495.x, CP26FPS_2494.y || CP26FPS_2495.y, CP26FPS_2494.z || CP26FPS_2495.z)) || ((asuint(CP26FPS_2491) & 2147483647u) > 2139095040u);
                int CP26FPS_2502 = int(CP26FPS_2481);
                float2 CP26FPS_2519 = float4(CP26FPS_40_m3[CP26FPS_2502].xy + (CP26FPS_2492.xy * CP26FPS_40_m3[CP26FPS_2502].zw), CP26FPS_2491, CP26FPS_2481).xy * CP26FPS_40_m4.zw;
                float2 CP26FPS_2521 = floor(CP26FPS_2519 + 0.5f.xx);
                float2 CP26FPS_2522 = CP26FPS_2519 - CP26FPS_2521;
                float CP26FPS_2523 = CP26FPS_2522.x;
                float CP26FPS_2524 = CP26FPS_2523 + 0.5f;
                float CP26FPS_2526 = (CP26FPS_2524 * CP26FPS_2524) * 0.5f;
                float CP26FPS_2529 = isnan(0.0f) ? CP26FPS_2523 : (isnan(CP26FPS_2523) ? 0.0f : min(CP26FPS_2523, 0.0f));
                float CP26FPS_2533 = isnan(0.0f) ? CP26FPS_2523 : (isnan(CP26FPS_2523) ? 0.0f : max(CP26FPS_2523, 0.0f));
                float4 CP26FPS_2537 = float4(CP26FPS_2526 - CP26FPS_2523, (1.0f - CP26FPS_2523) - (CP26FPS_2529 * CP26FPS_2529), (CP26FPS_2523 + 1.0f) - (CP26FPS_2533 * CP26FPS_2533), CP26FPS_2526) * 0.44444000720977783203125f;
                float CP26FPS_2538 = CP26FPS_2522.y;
                float CP26FPS_2539 = CP26FPS_2538 + 0.5f;
                float CP26FPS_2541 = (CP26FPS_2539 * CP26FPS_2539) * 0.5f;
                float CP26FPS_2544 = isnan(0.0f) ? CP26FPS_2538 : (isnan(CP26FPS_2538) ? 0.0f : min(CP26FPS_2538, 0.0f));
                float CP26FPS_2548 = isnan(0.0f) ? CP26FPS_2538 : (isnan(CP26FPS_2538) ? 0.0f : max(CP26FPS_2538, 0.0f));
                float4 CP26FPS_2552 = float4(CP26FPS_2541 - CP26FPS_2538, (1.0f - CP26FPS_2538) - (CP26FPS_2544 * CP26FPS_2544), (CP26FPS_2538 + 1.0f) - (CP26FPS_2548 * CP26FPS_2548), CP26FPS_2541) * 0.44444000720977783203125f;
                float2 CP26FPS_2554 = CP26FPS_2537.yw;
                float2 CP26FPS_2555 = CP26FPS_2537.xz + CP26FPS_2554;
                float2 CP26FPS_2557 = CP26FPS_2552.yw;
                float2 CP26FPS_2558 = CP26FPS_2552.xz + CP26FPS_2557;
                float2 CP26FPS_2564 = ((CP26FPS_2554 / CP26FPS_2555) + float2(-1.5f, 0.5f)) * CP26FPS_40_m4.xx;
                float2 CP26FPS_2566 = ((CP26FPS_2557 / CP26FPS_2558) + float2(-1.5f, 0.5f)) * CP26FPS_40_m4.yy;
                float2 CP26FPS_2568 = CP26FPS_2521 * CP26FPS_40_m4.xy;
                float CP26FPS_2569 = CP26FPS_2564.x;
                float CP26FPS_2570 = CP26FPS_2566.x;
                float CP26FPS_2573 = CP26FPS_2564.y;
                float CP26FPS_2576 = CP26FPS_2566.y;
                float CP26FPS_2581 = CP26FPS_2555.x;
                float CP26FPS_2582 = CP26FPS_2558.x;
                float CP26FPS_2584 = CP26FPS_2555.y;
                float CP26FPS_2586 = CP26FPS_2558.y;
                CP26FPS_2621 = CP26FPS_2501 ? 1.0f : (((((CP26FPS_2581 * CP26FPS_2582) * CP26F_ShadowCompare(CP26FPS_41, float3(CP26FPS_2568 + float2(CP26FPS_2569, CP26FPS_2570), CP26FPS_501).xy, CP26FPS_2491)) + ((CP26FPS_2584 * CP26FPS_2582) * CP26F_ShadowCompare(CP26FPS_41, float3(CP26FPS_2568 + float2(CP26FPS_2573, CP26FPS_2570), CP26FPS_501).xy, CP26FPS_2491))) + ((CP26FPS_2581 * CP26FPS_2586) * CP26F_ShadowCompare(CP26FPS_41, float3(CP26FPS_2568 + float2(CP26FPS_2569, CP26FPS_2576), CP26FPS_501).xy, CP26FPS_2491))) + ((CP26FPS_2584 * CP26FPS_2586) * CP26F_ShadowCompare(CP26FPS_41, float3(CP26FPS_2568 + float2(CP26FPS_2573, CP26FPS_2576), CP26FPS_501).xy, CP26FPS_2491)));
                CP26FPS_2622 = CP26FPS_2501;
            }
            else
            {
                CP26FPS_2621 = 1.0f;
                CP26FPS_2622 = false;
            }
            CP26FPS_2623 = CP26FPS_2621;
            CP26FPS_2624 = CP26FPS_2622;
        }
        else
        {
            CP26FPS_2623 = 1.0f;
            CP26FPS_2624 = false;
        }
        float CP26FPS_2821;
        float CP26FPS_2822;
        if ((CP26FPS_2435 < 1.0f) || (CP26FPS_40_m8.x > 0.5f))
        {
            float CP26FPS_2632 = 1.0f - clamp(dot(CP26FPS_678, CP26FPS_36_m0.xyz), 0.0f, 0.89999997615814208984375f);
            float4 CP26FPS_2649 = float4((CP26FPS_650 - (CP26FPS_36_m0.xyz * (CP26FPS_2632 * CP26FPS_40_m24.x))) + (CP26FPS_678 * (CP26FPS_2632 * CP26FPS_40_m24.y)), 1.0f);
            float4 CP26FPS_2650 = mul(CP26FPS_40_m23, CP26FPS_2649);
            float2 CP26FPS_2651 = CP26FPS_2650.xy;
            float CP26FPS_2819;
            if (all(bool2(CP26FPS_2651.x > 0.0f.xx.x, CP26FPS_2651.y > 0.0f.xx.y)) && all(bool2(CP26FPS_2651.x < 1.0f.xx.x, CP26FPS_2651.y < 1.0f.xx.y)))
            {
                uint CP26FPS_2670 = clamp(uint((floor(CP26FPS_2650.y * CP26FPS_40_m25.z) + CP26FPS_2650.x) * CP26FPS_40_m25.y), 0u, 127u);
                uint CP26FPS_2674 = asuint(CP26FPS_40_m27[CP26FPS_2670].x);
                float2 CP26FPS_2675 = CP26FPS_spvUnpackHalf2x16(CP26FPS_2674);
                float CP26FPS_2676 = CP26FPS_2675.x;
                float CP26FPS_2818;
                if (CP26FPS_2676 >= 0.0f)
                {
                    float4x4 CP26FPS_2687 = CP26FPS_40_m22;
                    CP26FPS_2687[0].w = CP26FPS_40_m27[CP26FPS_2670].y;
                    float4x4 CP26FPS_2689 = CP26FPS_2687;
                    CP26FPS_2689[1].w = CP26FPS_40_m27[CP26FPS_2670].z;
                    float4x4 CP26FPS_2691 = CP26FPS_2689;
                    CP26FPS_2691[2].w = CP26FPS_40_m27[CP26FPS_2670].w;
                    float4 CP26FPS_2692 = mul(CP26FPS_2691, CP26FPS_2649);
                    float3 CP26FPS_2693 = CP26FPS_2692.xyz;
                    float CP26FPS_2817;
                    if (all(bool3(CP26FPS_2693.x > 0.0f.xxx.x, CP26FPS_2693.y > 0.0f.xxx.y, CP26FPS_2693.z > 0.0f.xxx.z)) && all(bool3(CP26FPS_2693.x < 1.0f.xxx.x, CP26FPS_2693.y < 1.0f.xxx.y, CP26FPS_2693.z < 1.0f.xxx.z)))
                    {
                        float CP26FPS_2710 = CP26FPS_2692.z;
                        float2 CP26FPS_2716 = float4((CP26FPS_2692.xy * CP26FPS_40_m24.zw) + float2(CP26FPS_2676, CP26FPS_spvUnpackHalf2x16(CP26FPS_2674 >> 16u).x), CP26FPS_2710, 1.0f).xy * CP26FPS_40_m26.zw;
                        float2 CP26FPS_2718 = floor(CP26FPS_2716 + 0.5f.xx);
                        float2 CP26FPS_2719 = CP26FPS_2716 - CP26FPS_2718;
                        float CP26FPS_2720 = CP26FPS_2719.x;
                        float CP26FPS_2721 = CP26FPS_2720 + 0.5f;
                        float CP26FPS_2723 = (CP26FPS_2721 * CP26FPS_2721) * 0.5f;
                        float CP26FPS_2726 = isnan(0.0f) ? CP26FPS_2720 : (isnan(CP26FPS_2720) ? 0.0f : min(CP26FPS_2720, 0.0f));
                        float CP26FPS_2730 = isnan(0.0f) ? CP26FPS_2720 : (isnan(CP26FPS_2720) ? 0.0f : max(CP26FPS_2720, 0.0f));
                        float4 CP26FPS_2734 = float4(CP26FPS_2723 - CP26FPS_2720, (1.0f - CP26FPS_2720) - (CP26FPS_2726 * CP26FPS_2726), (CP26FPS_2720 + 1.0f) - (CP26FPS_2730 * CP26FPS_2730), CP26FPS_2723) * 0.44444000720977783203125f;
                        float CP26FPS_2735 = CP26FPS_2719.y;
                        float CP26FPS_2736 = CP26FPS_2735 + 0.5f;
                        float CP26FPS_2738 = (CP26FPS_2736 * CP26FPS_2736) * 0.5f;
                        float CP26FPS_2741 = isnan(0.0f) ? CP26FPS_2735 : (isnan(CP26FPS_2735) ? 0.0f : min(CP26FPS_2735, 0.0f));
                        float CP26FPS_2745 = isnan(0.0f) ? CP26FPS_2735 : (isnan(CP26FPS_2735) ? 0.0f : max(CP26FPS_2735, 0.0f));
                        float4 CP26FPS_2749 = float4(CP26FPS_2738 - CP26FPS_2735, (1.0f - CP26FPS_2735) - (CP26FPS_2741 * CP26FPS_2741), (CP26FPS_2735 + 1.0f) - (CP26FPS_2745 * CP26FPS_2745), CP26FPS_2738) * 0.44444000720977783203125f;
                        float2 CP26FPS_2751 = CP26FPS_2734.yw;
                        float2 CP26FPS_2752 = CP26FPS_2734.xz + CP26FPS_2751;
                        float2 CP26FPS_2754 = CP26FPS_2749.yw;
                        float2 CP26FPS_2755 = CP26FPS_2749.xz + CP26FPS_2754;
                        float2 CP26FPS_2761 = ((CP26FPS_2751 / CP26FPS_2752) + float2(-1.5f, 0.5f)) * CP26FPS_40_m26.xx;
                        float2 CP26FPS_2763 = ((CP26FPS_2754 / CP26FPS_2755) + float2(-1.5f, 0.5f)) * CP26FPS_40_m26.yy;
                        float2 CP26FPS_2765 = CP26FPS_2718 * CP26FPS_40_m26.xy;
                        float CP26FPS_2766 = CP26FPS_2761.x;
                        float CP26FPS_2767 = CP26FPS_2763.x;
                        float CP26FPS_2770 = CP26FPS_2761.y;
                        float CP26FPS_2773 = CP26FPS_2763.y;
                        float CP26FPS_2778 = CP26FPS_2752.x;
                        float CP26FPS_2779 = CP26FPS_2755.x;
                        float CP26FPS_2781 = CP26FPS_2752.y;
                        float CP26FPS_2783 = CP26FPS_2755.y;
                        CP26FPS_2817 = ((((CP26FPS_2778 * CP26FPS_2779) * CP26F_ShadowCompare(CP26FPS_45, float3(CP26FPS_2765 + float2(CP26FPS_2766, CP26FPS_2767), CP26FPS_501).xy, CP26FPS_2710)) + ((CP26FPS_2781 * CP26FPS_2779) * CP26F_ShadowCompare(CP26FPS_45, float3(CP26FPS_2765 + float2(CP26FPS_2770, CP26FPS_2767), CP26FPS_501).xy, CP26FPS_2710))) + ((CP26FPS_2778 * CP26FPS_2783) * CP26F_ShadowCompare(CP26FPS_45, float3(CP26FPS_2765 + float2(CP26FPS_2766, CP26FPS_2773), CP26FPS_501).xy, CP26FPS_2710))) + ((CP26FPS_2781 * CP26FPS_2783) * CP26F_ShadowCompare(CP26FPS_45, float3(CP26FPS_2765 + float2(CP26FPS_2770, CP26FPS_2773), CP26FPS_501).xy, CP26FPS_2710));
                    }
                    else
                    {
                        CP26FPS_2817 = 1.0f;
                    }
                    CP26FPS_2818 = CP26FPS_2817;
                }
                else
                {
                    CP26FPS_2818 = 1.0f;
                }
                CP26FPS_2819 = CP26FPS_2818;
            }
            else
            {
                CP26FPS_2819 = 1.0f;
            }
            CP26FPS_2821 = CP26FPS_2624 ? CP26FPS_2819 : CP26FPS_2623;
            CP26FPS_2822 = CP26FPS_2819;
        }
        else
        {
            CP26FPS_2821 = CP26FPS_2623;
            CP26FPS_2822 = 1.0f;
        }
        float CP26FPS_2825 = lerp(lerp(CP26FPS_2822, CP26FPS_2821, CP26FPS_2435), isnan(CP26FPS_2821) ? CP26FPS_2822 : (isnan(CP26FPS_2822) ? CP26FPS_2821 : min(CP26FPS_2822, CP26FPS_2821)), CP26FPS_40_m8.x);
        float CP26FPS_2876;
        if (CP26FPS_2825 > 0.001000000047497451305389404296875f)
        {
            float3 CP26FPS_2832 = CP26FPS_650 - CP26FPS_20_m65.xyz;
            float2 CP26FPS_2842 = (CP26FPS_2832 + (CP26FPS_20_m68.xyz * CP26FPS_2832.y)).xz * CP26FPS_20_m66.z;
            float2 CP26FPS_2851 = CP26FPS_20_m67.xy * CP26FPS_20_m75.w;
            CP26FPS_2876 = CP26FPS_2825 * lerp(1.0f, lerp(CP26FPS_44.SampleLevel(CP26F_linear_repeat_sampler, CP26FPS_2842 + CP26FPS_2851, 0.0f), CP26FPS_44.SampleLevel(CP26F_linear_repeat_sampler, (CP26FPS_2842 * CP26FPS_20_m67.w) + CP26FPS_2851, 0.0f), smoothstep(CP26FPS_20_m66.x, CP26FPS_20_m66.y, length(CP26FPS_2832.xz)).xxxx).x, CP26FPS_20_m67.z);
        }
        else
        {
            CP26FPS_2876 = CP26FPS_2825;
        }
        CP26FPS_2881 = float2(lerp(CP26FPS_2876, CP26FPS_40_m7.z, CP26FPS_40_m7.w), CP26FPS_2876);
        break;
    } while(false);
    float CP26FPS_2885 = lerp(1.0f, CP26FPS_2404, CP26FPS_40_m6.x);
    float CP26FPS_2889 = lerp(lerp(1.0f, CP26FPS_2881.x, CP26FPS_40_m6.x), 1.0f, CP26FPS_20_m80.z);
    float CP26FPS_2890 = dot(CP26FPS_2207, CP26FPS_2259);
    float3 CP26FPS_2897 = CP26FPS_2217 * CP26FPS_20_m79.z;
    float3 CP26FPS_2898 = CP26FPS_2897 * 0.64999997615814208984375f;
    float CP26FPS_2902 = dot(CP26FPS_2213, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float CP26FPS_2915 = clamp(-dot(CP26FPS_2263.xz, normalize(CP26FPS_739.xz)), 0.0f, 1.0f);
    float CP26FPS_2919 = 1.0f - CP26FPS_20_m91.x;
    float4 CP26FPS_2933 = CP26FPS_56.SampleLevel(CP26F_linear_clamp_sampler, float2((clamp(lerp(CP26FPS_2890, ((-CP26FPS_2890) * ((CP26FPS_2890 * 0.5f) - 1.0f)) + 0.5f, (CP26FPS_2915 * smoothstep(0.25f, 0.75f, 1.0f - abs(CP26FPS_739.y))) * CP26FPS_2919) + (CP26FPS_20_m90.w * CP26FPS_20_m91.x), -1.0f, 1.0f) * 0.5f) + 0.5f, 0.5f), 0.0f);
    float CP26FPS_2934 = CP26FPS_2933.w;
    float CP26FPS_2936 = CP26FPS_2933.x;
    float CP26FPS_2937 = CP26FPS_2933.y;
    float CP26FPS_2938 = CP26FPS_2933.z;
    float CP26FPS_2939 = isnan(CP26FPS_2937) ? CP26FPS_2936 : (isnan(CP26FPS_2936) ? CP26FPS_2937 : max(CP26FPS_2936, CP26FPS_2937));
    float CP26FPS_2941 = isnan(CP26FPS_2937) ? CP26FPS_2936 : (isnan(CP26FPS_2936) ? CP26FPS_2937 : min(CP26FPS_2936, CP26FPS_2937));
    float CP26FPS_2943 = (isnan(CP26FPS_2938) ? CP26FPS_2939 : (isnan(CP26FPS_2939) ? CP26FPS_2938 : max(CP26FPS_2939, CP26FPS_2938))) - (isnan(CP26FPS_2938) ? CP26FPS_2941 : (isnan(CP26FPS_2941) ? CP26FPS_2938 : min(CP26FPS_2941, CP26FPS_2938)));
    float4 CP26FPS_2951 = CP26FPS_56.SampleLevel(CP26F_linear_clamp_sampler, float2((dot(CP26FPS_2207, CP26FPS_739) * 0.5f) + 0.5f, 0.5f), 0.0f);
    float CP26FPS_2952 = CP26FPS_2951.w;
    float CP26FPS_2953 = CP26FPS_589 * CP26FPS_2885;
    float CP26FPS_2959 = isnan(CP26FPS_589) ? CP26FPS_2885 : (isnan(CP26FPS_2885) ? CP26FPS_589 : min(CP26FPS_2885, CP26FPS_589));
    float CP26FPS_2960 = isnan(CP26FPS_2934) ? CP26FPS_2959 : (isnan(CP26FPS_2959) ? CP26FPS_2934 : min(CP26FPS_2959, CP26FPS_2934));
    float CP26FPS_2961 = CP26FPS_2952 * CP26FPS_2953;
    float3 CP26FPS_2965 = ((clamp(dot(CP26FPS_677, CP26FPS_20_m85.xyz) + CP26FPS_20_m86.x, 0.0f, 1.0f) * CP26FPS_20_m86.y) + CP26FPS_20_m86.z).xxx * lerp(CP26FPS_1280, 1.0f.xxx, (CP26FPS_20_m80.y * CP26FPS_2960).xxx);
    float3 CP26FPS_2967 = CP26FPS_2960.xxx;
    float CP26FPS_2980 = lerp(0.64999997615814208984375f, 1.0f, CP26FPS_1281);
    float3 CP26FPS_2990 = CP26FPS_2889.xxx;
    float3 CP26FPS_2991 = lerp((CP26FPS_2965 * lerp(isnan(1.5f) ? CP26FPS_2980 : (isnan(CP26FPS_2980) ? 1.5f : min(CP26FPS_2980, 1.5f)), clamp(CP26FPS_1281, 1.25f, 1.75f), CP26FPS_20_m80.x)) * CP26FPS_20_m79.w, (lerp(dot(CP26FPS_2277, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, CP26FPS_2277, CP26FPS_2967) + ((CP26FPS_2965 * clamp(CP26FPS_1281, 0.0f, 1.5f)) * ((1.0f - CP26FPS_20_m91.y).xxx + (CP26FPS_2273 * CP26FPS_20_m91.y)))) * CP26FPS_20_m79.y, CP26FPS_2990);
    float3 CP26FPS_2992 = lerp(lerp(lerp(dot(CP26FPS_2898, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, CP26FPS_2898, 1.2000000476837158203125f.xxx), CP26FPS_2897, clamp((CP26FPS_2953 * CP26FPS_2952) + CP26FPS_2934, 0.0f, 1.0f).xxx), CP26FPS_2213, CP26FPS_2967);
    float3 CP26FPS_2998 = CP26FPS_2992 * ((1.0f - CP26FPS_2943).xxx + (CP26FPS_2933.xyz * CP26FPS_2943));
    float CP26FPS_2999 = dot(CP26FPS_2998, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float3 CP26FPS_3007 = lerp(lerp(CP26FPS_2897, lerp(CP26FPS_2902.xxx, CP26FPS_2213, 1.2000000476837158203125f.xxx), CP26FPS_2961.xxx), CP26FPS_2998 * clamp(dot(CP26FPS_2992, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)) * (1.0f / (isnan(0.001000000047497451305389404296875f) ? CP26FPS_2999 : (isnan(CP26FPS_2999) ? 0.001000000047497451305389404296875f : max(CP26FPS_2999, 0.001000000047497451305389404296875f)))), 0.0f, 1.5f), CP26FPS_2990);
    float4 CP26FPS_3011 = float4(CP26FPS_3007, CP26FPS_2889);
    float CP26FPS_3013 = lerp(CP26FPS_2961, CP26FPS_2960, CP26FPS_2889);
    float3 CP26FPS_3019 = (CP26FPS_2991 * (((CP26FPS_3013 * 0.5f) + 0.5f) * lerp(CP26FPS_20_m79.z, 1.0f, CP26FPS_3013))) * 1.0f;
    float CP26FPS_3022 = lerp(0.5f, CP26FPS_2259.y, CP26FPS_2889);
    float3 CP26FPS_3025 = mul(CP26FPS_703, float3(CP26FPS_718.x, CP26FPS_3022, CP26FPS_718.z));
    float3 CP26FPS_3027 = CP26FPS_2259 * CP26FPS_2889;
    float3 CP26FPS_3033 = normalize(CP26FPS_716 + (CP26FPS_696 * ((CP26FPS_54_m34 * 2.0f) - 1.0f)));
    float3 CP26FPS_3034 = normalize(CP26FPS_3027 + (float3(CP26FPS_3025.x, CP26FPS_3025.y, CP26FPS_3025.z) * 2.0f)) + CP26FPS_543;
    float CP26FPS_3035 = dot(CP26FPS_3034, CP26FPS_3034);
    float3 CP26FPS_3038 = CP26FPS_3034 * rsqrt(isnan(CP26FPS_3035) ? 6.103515625e-05f : (isnan(6.103515625e-05f) ? CP26FPS_3035 : max(6.103515625e-05f, CP26FPS_3035)));
    float CP26FPS_3039 = dot(CP26FPS_3033, CP26FPS_3038);
    float CP26FPS_3042 = sqrt(1.0f - (CP26FPS_3039 * CP26FPS_3039));
    float3 CP26FPS_3047 = clamp(pow(isnan(9.9999997473787516355514526367188e-05f) ? CP26FPS_3042 : (isnan(CP26FPS_3042) ? 9.9999997473787516355514526367188e-05f : max(CP26FPS_3042, 9.9999997473787516355514526367188e-05f)), 200.0f).xxx * CP26FPS_588, 0.0f.xxx, 1.0f.xxx);
    float CP26FPS_3050 = CP26FPS_727 * CP26FPS_727;
    float3 CP26FPS_3060 = (CP26FPS_3047 * CP26FPS_57.SampleLevel(CP26F_linear_clamp_sampler, float2(CP26FPS_3047.x, float(CP26FPS_3039 > 0.0f) * CP26FPS_3050), 0.0f).xyz) * CP26FPS_727;
    float CP26FPS_3061 = CP26FPS_3060.x;
    float CP26FPS_3062 = CP26FPS_3060.y;
    float CP26FPS_3063 = CP26FPS_3060.z;
    float CP26FPS_3064 = isnan(CP26FPS_3062) ? CP26FPS_3061 : (isnan(CP26FPS_3061) ? CP26FPS_3062 : max(CP26FPS_3061, CP26FPS_3062));
    float CP26FPS_3065 = isnan(CP26FPS_3063) ? CP26FPS_3064 : (isnan(CP26FPS_3064) ? CP26FPS_3063 : max(CP26FPS_3064, CP26FPS_3063));
    float CP26FPS_3077 = 1.0f - CP26FPS_54_m38;
    float CP26FPS_3081 = dot(normalize(CP26FPS_716 + (CP26FPS_696 * ((CP26FPS_54_m35 * 2.0f) - 1.0f))), CP26FPS_3038);
    float CP26FPS_3084 = sqrt(1.0f - (CP26FPS_3081 * CP26FPS_3081));
    float CP26FPS_3117 = 1.0f - CP26FPS_54_m45;
    float CP26FPS_3121 = dot(normalize(CP26FPS_716 + (CP26FPS_696 * ((2.0f * CP26FPS_54_m44) - 1.0f))), CP26FPS_3038);
    float CP26FPS_3124 = sqrt(1.0f - (CP26FPS_3121 * CP26FPS_3121));
    float CP26FPS_3135 = lerp(1.0f, lerp(1.0f, lerp(lerp(1.0f - CP26FPS_54_m46, 1.0f, lerp(ceil(clamp(frac(CP26FPS_3.x * CP26FPS_54_m43) - 0.5f, 0.0f, 1.0f)), 1.0f - CP26FPS_645.x, CP26FPS_54_m48)), 1.0f, CP26FPS_3065), clamp(pow(isnan(9.9999997473787516355514526367188e-05f) ? CP26FPS_3124 : (isnan(CP26FPS_3124) ? 9.9999997473787516355514526367188e-05f : max(CP26FPS_3124, 9.9999997473787516355514526367188e-05f)), float(int(200.0f * (isnan(0.0f) ? CP26FPS_3117 : (isnan(CP26FPS_3117) ? 0.0f : max(CP26FPS_3117, 0.0f)))))), 0.0f, 1.0f)), CP26FPS_588);
    float3 CP26FPS_3139 = ((((((CP26FPS_3060 * CP26FPS_2216) * CP26FPS_54_m36) * 5.0f) * CP26FPS_2089) + lerp(((pow(isnan(9.9999997473787516355514526367188e-05f) ? CP26FPS_3084 : (isnan(CP26FPS_3084) ? 9.9999997473787516355514526367188e-05f : max(CP26FPS_3084, 9.9999997473787516355514526367188e-05f)), float(int(200.0f * (isnan(0.0f) ? CP26FPS_3077 : (isnan(CP26FPS_3077) ? 0.0f : max(CP26FPS_3077, 0.0f)))))).xxx * CP26FPS_727) * (CP26FPS_54_m42.xyz * CP26FPS_586.w)) * CP26FPS_2089, 0.0f.xxx, CP26FPS_3065.xxx)) * CP26FPS_3019) * CP26FPS_20_m92.w;
    float3 CP26FPS_3143 = (CP26FPS_2991 * CP26FPS_3007) * CP26FPS_3135;
    float3 CP26FPS_3147 = lerp(dot(CP26FPS_3143, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, CP26FPS_3143, lerp(CP26FPS_54_m47, 1.0f, CP26FPS_3135).xxx);
    float3 CP26FPS_3153 = float3(CP26FPS_739.x, CP26FPS_3022, CP26FPS_739.z);
    float CP26FPS_3154 = dot(CP26FPS_3153, CP26FPS_3153);
    float3 CP26FPS_3163 = normalize((CP26FPS_3027 + ((CP26FPS_3153 * rsqrt(isnan(CP26FPS_3154) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? CP26FPS_3154 : max(1.1754943508222875079687365372222e-38f, CP26FPS_3154)))) * 2.0f)) + (CP26FPS_543 * (2.0f + CP26FPS_2889)));
    float3 CP26FPS_3168 = normalize(float3(-CP26FPS_2088.z, 0.001000000047497451305389404296875f, CP26FPS_2088.x));
    float CP26FPS_3177 = dot(CP26FPS_2088, CP26FPS_3163);
    float CP26FPS_3190 = (1.0f - CP26FPS_54_m6) + (CP26FPS_593 * CP26FPS_54_m6);
    float3 CP26FPS_3192 = (CP26FPS_3147 * CP26FPS_3190) + ((CP26FPS_3139 * CP26FPS_2092) + (((CP26FPS_3147 + CP26FPS_3139) * CP26FPS_2091) + (((((smoothstep(0.1500000059604644775390625f, 0.100000001490116119384765625f, abs(dot(CP26FPS_3163, CP26FPS_3168))) * smoothstep(0.070000000298023223876953125f, 0.0199999995529651641845703125f, abs(dot(CP26FPS_3163, cross(CP26FPS_2088, CP26FPS_3168))))) * (isnan(CP26FPS_3177) ? 0.0f : (isnan(0.0f) ? CP26FPS_3177 : max(0.0f, CP26FPS_3177)))) * 2.0f) * CP26FPS_2090).xxx * CP26FPS_3019)));
    float CP26FPS_3193 = dot(CP26FPS_3192, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float CP26FPS_3196 = clamp(CP26FPS_3193 - 0.5f, 0.0f, 0.5f);
    float3 CP26FPS_3232 = normalize(cross(CP26FPS_739, lerp(float3(CP26FPS_20_m88.xy, 0.0f), (float3(CP26FPS_18_m0[0].x, CP26FPS_18_m0[0].y, CP26FPS_18_m0[0].z) * CP26FPS_20_m88.x) + (float3(CP26FPS_18_m0[1].x, CP26FPS_18_m0[1].y, CP26FPS_18_m0[1].z) * CP26FPS_20_m88.y), CP26FPS_20_m94.w.xxx)));
    float CP26FPS_3238 = dot(CP26FPS_543, CP26FPS_2207);
    float CP26FPS_3240 = 1.0f - abs(CP26FPS_3238);
    float CP26FPS_3250 = clamp(dot(CP26FPS_657, CP26FPS_3232) + 1.0f, 0.0f, 1.0f);
    float CP26FPS_3251 = isnan(CP26FPS_589) ? CP26FPS_3250 : (isnan(CP26FPS_3250) ? CP26FPS_589 : min(CP26FPS_3250, CP26FPS_589));
    float CP26FPS_3262 = dot(CP26FPS_2263, CP26FPS_2207);
    float CP26FPS_3274 = 1.0f - CP26FPS_2889;
    float CP26FPS_3285 = isnan(CP26FPS_1279.y) ? CP26FPS_1279.x : (isnan(CP26FPS_1279.x) ? CP26FPS_1279.y : max(CP26FPS_1279.x, CP26FPS_1279.y));
    float CP26FPS_3287 = (isnan(CP26FPS_1279.z) ? CP26FPS_3285 : (isnan(CP26FPS_3285) ? CP26FPS_1279.z : max(CP26FPS_3285, CP26FPS_1279.z))) * 0.5f;
    bool3 CP26FPS_4977 = isnan(0.1500000059604644775390625f.xxx);
    bool3 CP26FPS_4978 = isnan(CP26FPS_2213);
    float3 CP26FPS_4979 = max(0.1500000059604644775390625f.xxx, CP26FPS_2213);
    float3 CP26FPS_4980 = float3(CP26FPS_4977.x ? CP26FPS_2213.x : CP26FPS_4979.x, CP26FPS_4977.y ? CP26FPS_2213.y : CP26FPS_4979.y, CP26FPS_4977.z ? CP26FPS_2213.z : CP26FPS_4979.z);
    float2 CP26FPS_3302 = float2(CP26FPS_729);
    float2 CP26FPS_3304 = floor(CP26FPS_3302 * 0.03125f);
    int CP26FPS_3312 = int((CP26FPS_3304.x + (CP26FPS_3304.y * CP26FPS_34_m5)) * 8.0f);
    float CP26FPS_3319 = floor(CP26FPS_524 - (CP26FPS_20_m3.y * CP26FPS_34_m11));
    float CP26FPS_3323 = clamp(CP26FPS_3319, 0.0f, CP26FPS_34_m7 - 1.0f);
    int CP26FPS_3325 = int(CP26FPS_3323 * 8.0f);
    float3 CP26FPS_3327;
    CP26FPS_3327 = lerp(CP26FPS_3193.xxx, CP26FPS_3192, ((CP26FPS_3196 * CP26FPS_3196) + 1.0f).xxx) + (((((CP26FPS_20_m87.xyz * smoothstep(lerp(0.800000011920928955078125f, 0.20000000298023223876953125f, CP26FPS_20_m88.w), lerp(0.89999997615814208984375f, 0.5f, CP26FPS_20_m88.w), CP26FPS_3240)) * CP26FPS_20_m87.w) * (isnan(CP26FPS_2885) ? CP26FPS_3251 : (isnan(CP26FPS_3251) ? CP26FPS_2885 : min(CP26FPS_3251, CP26FPS_2885)))) * (lerp(0.25f.xxx, CP26FPS_2213, CP26FPS_20_m88.z.xxx) * clamp(dot(CP26FPS_3232, CP26FPS_2207), 0.0f, 1.0f))) + ((((((lerp(CP26FPS_1279 * (1.0f / (isnan(1.0f) ? CP26FPS_3287 : (isnan(CP26FPS_3287) ? 1.0f : max(CP26FPS_3287, 1.0f)))), CP26FPS_2277, CP26FPS_2990) * clamp(lerp(dot(CP26FPS_1278.xyz, CP26FPS_2207) * CP26FPS_1278.w, ((-CP26FPS_3262) * ((CP26FPS_3262 * 0.5f) - 1.0f)) + 0.5f, CP26FPS_2889), 0.0f, 1.0f)) * ((CP26FPS_3274 + (CP26FPS_2915 * CP26FPS_2889)) * CP26FPS_2919)) * smoothstep(0.60000002384185791015625f, 0.800000011920928955078125f, CP26FPS_3240)) * (isnan(CP26FPS_2885) ? CP26FPS_589 : (isnan(CP26FPS_589) ? CP26FPS_2885 : min(CP26FPS_589, CP26FPS_2885)))) * (CP26FPS_3274 + (smoothstep(0.100000001490116119384765625f, 0.039999999105930328369140625f, CP26FPS_2902) * CP26FPS_2889))) * float3(CP26FPS_4978.x ? 0.1500000059604644775390625f.xxx.x : CP26FPS_4980.x, CP26FPS_4978.y ? 0.1500000059604644775390625f.xxx.y : CP26FPS_4980.y, CP26FPS_4978.z ? 0.1500000059604644775390625f.xxx.z : CP26FPS_4980.z)));
    float3 CP26FPS_3328;
    [loop]
    for (int CP26FPS_3330 = 0; CP26FPS_3330 <= 7; CP26FPS_3327 = CP26FPS_3328, CP26FPS_3330++)
    {
        uint CP26FPS_3348 = (CP26FPS_3319 <= CP26FPS_3323) ? (CP26FPS_30.Load(uint(CP26FPS_3312 + CP26FPS_3330) * 4 + 0) & CP26FPS_30.Load(uint((CP26FPS_20_m21.y + CP26FPS_3325) + CP26FPS_3330) * 4 + 0)) : 0u;
        uint CP26FPS_3349 = uint(CP26FPS_3330);
        CP26FPS_3328 = CP26FPS_3327;
        uint CP26FPS_3354;
        float3 CP26FPS_3351;
        [loop]
        for (uint CP26FPS_3353 = CP26FPS_3348; CP26FPS_3353 != 0u; CP26FPS_3328 = CP26FPS_3351, CP26FPS_3353 = CP26FPS_3354)
        {
            uint CP26FPS_3358 = firstbitlow(CP26FPS_3353);
            CP26FPS_3354 = CP26FPS_3353 ^ (1u << (CP26FPS_3358 & 31u));
            int CP26FPS_3364 = int((32u * CP26FPS_3349) + CP26FPS_3358) * 8;
            int CP26FPS_3367 = CP26FPS_3364 + 1;
            int CP26FPS_3370 = CP26FPS_3364 + 2;
            int CP26FPS_3373 = CP26FPS_3364 + 3;
            int CP26FPS_3376 = CP26FPS_3364 + 4;
            int CP26FPS_3379 = CP26FPS_3364 + 5;
            int CP26FPS_3382 = CP26FPS_3364 + 6;
            int CP26FPS_3385 = CP26FPS_3364 + 7;
            uint CP26FPS_3389 = uint(CP26FPS_36_m6[CP26FPS_3379].w);
            float CP26FPS_3464;
            if ((CP26FPS_3389 & 1u) == 1u)
            {
                uint CP26FPS_3395 = asuint(CP26FPS_36_m6[CP26FPS_3379].x);
                uint CP26FPS_3402 = asuint(CP26FPS_36_m6[CP26FPS_3379].y);
                uint CP26FPS_3409 = asuint(CP26FPS_36_m6[CP26FPS_3379].z);
                uint CP26FPS_3416 = asuint(CP26FPS_36_m6[CP26FPS_3382].x);
                uint CP26FPS_3423 = asuint(CP26FPS_36_m6[CP26FPS_3382].y);
                uint CP26FPS_3430 = asuint(CP26FPS_36_m6[CP26FPS_3382].z);
                float3 CP26FPS_3449 = abs(mul(float4(CP26FPS_650 - CP26FPS_36_m6[CP26FPS_3367].xyz, 1.0f), float4x4(float4(CP26FPS_spvUnpackHalf2x16(CP26FPS_3395).x, CP26FPS_spvUnpackHalf2x16(CP26FPS_3409).x, CP26FPS_spvUnpackHalf2x16(CP26FPS_3423).x, 0.0f), float4(CP26FPS_spvUnpackHalf2x16(CP26FPS_3395 >> 16u).x, CP26FPS_spvUnpackHalf2x16(CP26FPS_3409 >> 16u).x, CP26FPS_spvUnpackHalf2x16(CP26FPS_3423 >> 16u).x, 0.0f), float4(CP26FPS_spvUnpackHalf2x16(CP26FPS_3402).x, CP26FPS_spvUnpackHalf2x16(CP26FPS_3416).x, CP26FPS_spvUnpackHalf2x16(CP26FPS_3430).x, 0.0f), float4(CP26FPS_spvUnpackHalf2x16(CP26FPS_3402 >> 16u).x, CP26FPS_spvUnpackHalf2x16(CP26FPS_3416 >> 16u).x, CP26FPS_spvUnpackHalf2x16(CP26FPS_3430 >> 16u).x, 0.0f))).xyz);
                float CP26FPS_3450 = CP26FPS_3449.x;
                float CP26FPS_3451 = CP26FPS_3449.y;
                float CP26FPS_3452 = isnan(CP26FPS_3451) ? CP26FPS_3450 : (isnan(CP26FPS_3450) ? CP26FPS_3451 : max(CP26FPS_3450, CP26FPS_3451));
                float CP26FPS_3453 = CP26FPS_3449.z;
                float CP26FPS_3456 = CP26FPS_36_m6[CP26FPS_3385].x * 0.5f;
                float CP26FPS_3462 = 1.0f - clamp(((isnan(CP26FPS_3453) ? CP26FPS_3452 : (isnan(CP26FPS_3452) ? CP26FPS_3453 : max(CP26FPS_3452, CP26FPS_3453))) - (CP26FPS_3456 + 0.5f)) / (0.5f - CP26FPS_3456), 0.0f, 1.0f);
                CP26FPS_3464 = CP26FPS_3462 * CP26FPS_3462;
            }
            else
            {
                CP26FPS_3464 = 1.0f;
            }
            if (false || (CP26FPS_3464 < 0.001000000047497451305389404296875f))
            {
                CP26FPS_3351 = CP26FPS_3328;
                continue;
            }
            float3 CP26FPS_4146;
            if (CP26FPS_36_m6[CP26FPS_3364].w < 1.5f)
            {
                float3 CP26FPS_4145;
                do
                {
                    uint CP26FPS_3477 = asuint(CP26FPS_36_m6[CP26FPS_3373].w);
                    if ((CP26FPS_3477 == 16u) || ((CP26FPS_36_m6[CP26FPS_3373].z + CP26FPS_20_m91.z) < 0.5f))
                    {
                        CP26FPS_4145 = CP26FPS_3328;
                        break;
                    }
                    bool CP26FPS_3489 = (uint(CP26FPS_36_m6[CP26FPS_3364].w) & 1u) == 0u;
                    bool CP26FPS_3493 = (!CP26FPS_3489) && (CP26FPS_36_m6[CP26FPS_3370].z > 0.0f);
                    bool CP26FPS_3494 = CP26FPS_3477 == 4u;
                    float CP26FPS_3495 = float(CP26FPS_3489);
                    float CP26FPS_3503 = (0.5f + (0.5f * CP26FPS_36_m6[CP26FPS_3370].y)) - abs(CP26FPS_36_m6[CP26FPS_3370].x);
                    float CP26FPS_3504 = CP26FPS_36_m6[CP26FPS_3370].y - CP26FPS_3503;
                    float CP26FPS_3508 = (1.0f - abs(CP26FPS_3503)) - abs(CP26FPS_3504);
                    float CP26FPS_3511 = abs(isnan(0.00048828125f) ? CP26FPS_3508 : (isnan(CP26FPS_3508) ? 0.00048828125f : max(CP26FPS_3508, 0.00048828125f)));
                    float3 CP26FPS_3515 = normalize(float3(CP26FPS_3503, CP26FPS_3504, (CP26FPS_36_m6[CP26FPS_3370].x >= 0.0f) ? CP26FPS_3511 : (-CP26FPS_3511)));
                    float CP26FPS_3518 = 2.0f * CP26FPS_36_m6[CP26FPS_3376].y;
                    float CP26FPS_3521 = lerp(CP26FPS_36_m6[CP26FPS_3382].w, isnan(0.100000001490116119384765625f) ? CP26FPS_3518 : (isnan(CP26FPS_3518) ? 0.100000001490116119384765625f : max(CP26FPS_3518, 0.100000001490116119384765625f)), float(CP26FPS_3494));
                    float3 CP26FPS_3526 = CP26FPS_36_m6[CP26FPS_3367].xyz - CP26FPS_650;
                    float3 CP26FPS_3527 = -CP26FPS_3515;
                    float3 CP26FPS_3532 = lerp(CP26FPS_3526, CP26FPS_3527 * dot(CP26FPS_3526, CP26FPS_3527), (float(CP26FPS_3494 && (CP26FPS_36_m6[CP26FPS_3376].z > 0.5f)) * CP26FPS_3495).xxx);
                    float CP26FPS_3533 = dot(CP26FPS_3532, CP26FPS_3532);
                    float CP26FPS_3534 = rsqrt(CP26FPS_3533);
                    float3 CP26FPS_3535 = CP26FPS_3532 * CP26FPS_3534;
                    float3 CP26FPS_3568;
                    float CP26FPS_3569;
                    if (CP26FPS_3493)
                    {
                        float3 CP26FPS_3539 = (CP26FPS_3515 * CP26FPS_36_m6[CP26FPS_3370].z) * 0.5f;
                        float3 CP26FPS_3540 = CP26FPS_3532 - CP26FPS_3539;
                        float3 CP26FPS_3541 = CP26FPS_3532 + CP26FPS_3539;
                        float CP26FPS_3542 = length(CP26FPS_3540);
                        float CP26FPS_3543 = length(CP26FPS_3541);
                        float3 CP26FPS_3552 = normalize(cross(cross(CP26FPS_3515, CP26FPS_3535), CP26FPS_3515));
                        CP26FPS_3568 = CP26FPS_3552;
                        CP26FPS_3569 = ((1.0f / ((((CP26FPS_3542 * CP26FPS_3543) + dot(CP26FPS_3540, CP26FPS_3541)) * 0.5f) + 1.0f)) * clamp(0.5f * ((dot(CP26FPS_3552, CP26FPS_3540) / CP26FPS_3542) + (dot(CP26FPS_3552, CP26FPS_3541) / CP26FPS_3543)), 0.0f, 1.0f)) * (1.0f / clamp(1.0f + (0.5f * clamp(CP26FPS_36_m6[CP26FPS_3370].z * CP26FPS_3534, 0.0f, 1.0f)), 0.0f, 1.0f));
                    }
                    else
                    {
                        CP26FPS_3568 = CP26FPS_3535;
                        CP26FPS_3569 = 1.0f;
                    }
                    float CP26FPS_3591;
                    if (CP26FPS_3521 < 0.0f)
                    {
                        float CP26FPS_3579 = CP26FPS_3533 * (CP26FPS_36_m6[CP26FPS_3367].w * CP26FPS_36_m6[CP26FPS_3367].w);
                        float CP26FPS_3582 = clamp(1.0f - (CP26FPS_3579 * CP26FPS_3579), 0.0f, 1.0f);
                        CP26FPS_3591 = lerp(1.0f / (CP26FPS_3533 + 1.0f), CP26FPS_3569, float(CP26FPS_3493)) * (CP26FPS_3582 * CP26FPS_3582);
                    }
                    else
                    {
                        float3 CP26FPS_3585 = CP26FPS_3532 * CP26FPS_36_m6[CP26FPS_3367].w;
                        CP26FPS_3591 = CP26FPS_3569 * pow(1.0f - clamp(dot(CP26FPS_3585, CP26FPS_3585), 0.0f, 1.0f), CP26FPS_3521);
                    }
                    float CP26FPS_3596 = clamp((dot(CP26FPS_3568, CP26FPS_3527) - CP26FPS_36_m6[CP26FPS_3370].z) * CP26FPS_36_m6[CP26FPS_3370].w, 0.0f, 1.0f);
                    float CP26FPS_3599 = CP26FPS_3591 * lerp(1.0f, CP26FPS_3596 * CP26FPS_3596, CP26FPS_3495);
                    int CP26FPS_3601 = int(CP26FPS_36_m6[CP26FPS_3385].w);
                    float CP26FPS_3705;
                    if ((!CP26FPS_3493) && (CP26FPS_3601 >= 0))
                    {
                        uint CP26FPS_3607 = uint(CP26FPS_3601);
                        float2 CP26FPS_3698;
                        [branch]
                        if (CP26FPS_3495 != 0.0f)
                        {
                            float4 CP26FPS_3619 = mul(CP26FPS_64_m1[CP26FPS_3607], float4(CP26FPS_650.x, CP26FPS_771, CP26FPS_650.z, 1.0f));
                            CP26FPS_3698 = CP26FPS_64_m0[CP26FPS_3607].xy + (clamp(CP26FPS_3619.xy / CP26FPS_3619.w.xx, 0.0f.xx, 1.0f.xx) * CP26FPS_64_m0[CP26FPS_3607].zw);
                        }
                        else
                        {
                            float3 CP26FPS_3639 = mul(float4(-CP26FPS_3532, 0.0f), CP26FPS_64_m1[CP26FPS_3607]).xyz;
                            float3 CP26FPS_512 = CP26FPS_3639;
                            float3 CP26FPS_511 = CP26FPS_3639;
                            float3 CP26FPS_510 = abs(CP26FPS_3639);
                            uint CP26FPS_3648 = uint(int(CP26FPS_510.y > CP26FPS_510.x));
                            uint CP26FPS_3654 = (CP26FPS_510.z > CP26FPS_510[CP26FPS_3648]) ? 2u : CP26FPS_3648;
                            uint CP26FPS_3660 = (CP26FPS_3654 * 2u) + uint(CP26FPS_511[CP26FPS_3654] < 0.0f);
                            float CP26FPS_3664 = abs(CP26FPS_512[CP26FPS_3660 / 2u]);
                            float CP26FPS_3684 = 0.5f - (0.000244140625f / CP26FPS_64_m0[CP26FPS_3607].w);
                            CP26FPS_3698 = CP26FPS_64_m0[CP26FPS_3607].xy + (clamp(float2((float(CP26FPS_3660) + ((((CP26FPS_512[uint(CP26FPS_478[CP26FPS_3660].x)] * CP26FPS_479[CP26FPS_3660].x) / CP26FPS_3664) * CP26FPS_3684) + 0.5f)) * 0.16666667163372039794921875f, 0.5f - (((CP26FPS_512[uint(CP26FPS_478[CP26FPS_3660].y)] * CP26FPS_479[CP26FPS_3660].y) / CP26FPS_3664) * CP26FPS_3684)), 0.0f.xx, 1.0f.xx) * CP26FPS_64_m0[CP26FPS_3607].zw);
                        }
                        CP26FPS_3705 = CP26FPS_3599 * CP26FPS_62.SampleLevel(CP26F_linear_clamp_sampler, CP26FPS_3698, 0.0f).x;
                    }
                    else
                    {
                        CP26FPS_3705 = CP26FPS_3599;
                    }
                    float CP26FPS_3706 = CP26FPS_3705 * CP26FPS_3464;
                    float3 CP26FPS_4144;
                    do
                    {
                        float3 CP26FPS_4143;
                        [branch]
                        if (CP26FPS_3706 > 9.9999997473787516355514526367188e-05f)
                        {
                            [branch]
                            if (CP26FPS_3494)
                            {
                                CP26FPS_4144 = lerp(CP26FPS_3328, CP26FPS_36_m6[CP26FPS_3364].xyz, (CP26FPS_3706 * (CP26FPS_36_m6[CP26FPS_3376].x * ((1.0f - CP26FPS_36_m6[CP26FPS_3376].w) + (smoothstep(-0.5f, 0.5f, dot(CP26FPS_678, CP26FPS_3568)) * CP26FPS_36_m6[CP26FPS_3376].w)))).xxx);
                                break;
                            }
                            float CP26FPS_3726 = dot(CP26FPS_2207, CP26FPS_3568);
                            float CP26FPS_3727 = clamp(CP26FPS_3726, 0.0f, 1.0f);
                            float CP26FPS_4030;
                            if (CP26FPS_3477 != 0u)
                            {
                                bool CP26FPS_3733 = CP26FPS_3489 || ((CP26FPS_3389 & 2u) != 0u);
                                int CP26FPS_3782;
                                if (CP26FPS_3733)
                                {
                                    CP26FPS_3782 = int(CP26FPS_36_m6[CP26FPS_3373].x);
                                }
                                else
                                {
                                    uint CP26FPS_3739 = asuint(CP26FPS_36_m6[CP26FPS_3370].w);
                                    uint CP26FPS_3741 = asuint(CP26FPS_36_m6[CP26FPS_3373].x);
                                    float3 CP26FPS_3742 = CP26FPS_650 - CP26FPS_36_m6[CP26FPS_3367].xyz;
                                    float3 CP26FPS_3743 = abs(CP26FPS_3742);
                                    float CP26FPS_3744 = CP26FPS_3743.x;
                                    float CP26FPS_3745 = CP26FPS_3743.y;
                                    float CP26FPS_3747 = CP26FPS_3743.z;
                                    int CP26FPS_3779;
                                    if ((CP26FPS_3744 > CP26FPS_3745) && (CP26FPS_3744 > CP26FPS_3747))
                                    {
                                        CP26FPS_3779 = int((CP26FPS_3742.x > 0.0f) ? (CP26FPS_3739 >> 24u) : ((CP26FPS_3739 >> 16u) & 255u));
                                    }
                                    else
                                    {
                                        int CP26FPS_3778;
                                        if (CP26FPS_3745 > CP26FPS_3747)
                                        {
                                            CP26FPS_3778 = int((CP26FPS_3742.y > 0.0f) ? ((CP26FPS_3739 >> 8u) & 255u) : (CP26FPS_3739 & 255u));
                                        }
                                        else
                                        {
                                            CP26FPS_3778 = int((CP26FPS_3742.z > 0.0f) ? ((CP26FPS_3741 >> 8u) & 255u) : (CP26FPS_3741 & 255u));
                                        }
                                        CP26FPS_3779 = CP26FPS_3778;
                                    }
                                    CP26FPS_3782 = (CP26FPS_3779 < 80) ? CP26FPS_3779 : (-1);
                                }
                                bool CP26FPS_3783 = CP26FPS_3782 >= 0;
                                float CP26FPS_4029;
                                if (CP26FPS_3783)
                                {
                                    float3 CP26FPS_3787 = CP26FPS_650 - CP26FPS_36_m6[CP26FPS_3367].xyz;
                                    float CP26FPS_3788 = dot(CP26FPS_3787, CP26FPS_3787);
                                    float4 CP26FPS_3807 = mul(CP26FPS_40_m10[CP26FPS_3782], float4((CP26FPS_650 - ((CP26FPS_3787 * rsqrt(isnan(CP26FPS_3788) ? 1.1754943508222875079687365372222e-38f : (isnan(1.1754943508222875079687365372222e-38f) ? CP26FPS_3788 : max(1.1754943508222875079687365372222e-38f, CP26FPS_3788)))) * CP26FPS_40_m11[CP26FPS_3782].x)) + (CP26FPS_678 * (CP26FPS_40_m11[CP26FPS_3782].y * 5.0f)), 1.0f));
                                    float CP26FPS_3808 = CP26FPS_3807.w;
                                    float3 CP26FPS_3811 = CP26FPS_3807.xyz / CP26FPS_3808.xxx;
                                    float2 CP26FPS_3812 = CP26FPS_3811.xy;
                                    float3 CP26FPS_3820 = CP26FPS_3811.xyz;
                                    bool3 CP26FPS_3821 = bool3(CP26FPS_3820.x <= 0.0f.xxx.x, CP26FPS_3820.y <= 0.0f.xxx.y, CP26FPS_3820.z <= 0.0f.xxx.z);
                                    bool3 CP26FPS_3822 = bool3(CP26FPS_3820.x >= 1.0f.xxx.x, CP26FPS_3820.y >= 1.0f.xxx.y, CP26FPS_3820.z >= 1.0f.xxx.z);
                                    float CP26FPS_3825 = CP26FPS_3811.z;
                                    float2 CP26FPS_3836 = ((CP26FPS_3812 * (CP26FPS_40_m12[CP26FPS_3782].zw - CP26FPS_40_m12[CP26FPS_3782].xy)) + CP26FPS_40_m12[CP26FPS_3782].xy).xy * CP26FPS_40_m13.zw;
                                    float2 CP26FPS_3838 = floor(CP26FPS_3836 + 0.5f.xx);
                                    float2 CP26FPS_3839 = CP26FPS_3836 - CP26FPS_3838;
                                    float CP26FPS_3840 = CP26FPS_3839.x;
                                    float CP26FPS_3841 = CP26FPS_3840 + 0.5f;
                                    float CP26FPS_3842 = CP26FPS_3841 * CP26FPS_3841;
                                    float CP26FPS_3845 = 1.0f - CP26FPS_3840;
                                    float CP26FPS_3846 = isnan(0.0f) ? CP26FPS_3840 : (isnan(CP26FPS_3840) ? 0.0f : min(CP26FPS_3840, 0.0f));
                                    float CP26FPS_3849 = CP26FPS_3840 + 1.0f;
                                    float CP26FPS_3850 = isnan(0.0f) ? CP26FPS_3840 : (isnan(CP26FPS_3840) ? 0.0f : max(CP26FPS_3840, 0.0f));
                                    float CP26FPS_3861 = CP26FPS_3839.y;
                                    float CP26FPS_3862 = CP26FPS_3861 + 0.5f;
                                    float CP26FPS_3863 = CP26FPS_3862 * CP26FPS_3862;
                                    float CP26FPS_3866 = 1.0f - CP26FPS_3861;
                                    float CP26FPS_3867 = isnan(0.0f) ? CP26FPS_3861 : (isnan(CP26FPS_3861) ? 0.0f : min(CP26FPS_3861, 0.0f));
                                    float CP26FPS_3870 = CP26FPS_3861 + 1.0f;
                                    float CP26FPS_3871 = isnan(0.0f) ? CP26FPS_3861 : (isnan(CP26FPS_3861) ? 0.0f : max(CP26FPS_3861, 0.0f));
                                    float3 CP26FPS_3883 = float3(0.1599999964237213134765625f * CP26FPS_3845, 0.1599999964237213134765625f * ((CP26FPS_3849 - (CP26FPS_3850 * CP26FPS_3850)) + 1.0f), CP26FPS_3842 * 0.07999999821186065673828125f);
                                    float3 CP26FPS_3884 = float3(0.1599999964237213134765625f * ((CP26FPS_3842 * 0.5f) - CP26FPS_3840), 0.1599999964237213134765625f * ((CP26FPS_3845 - (CP26FPS_3846 * CP26FPS_3846)) + 1.0f), 0.1599999964237213134765625f * CP26FPS_3849) + CP26FPS_3883;
                                    float3 CP26FPS_3886 = float3(0.1599999964237213134765625f * CP26FPS_3866, 0.1599999964237213134765625f * ((CP26FPS_3870 - (CP26FPS_3871 * CP26FPS_3871)) + 1.0f), CP26FPS_3863 * 0.07999999821186065673828125f);
                                    float3 CP26FPS_3887 = float3(0.1599999964237213134765625f * ((CP26FPS_3863 * 0.5f) - CP26FPS_3861), 0.1599999964237213134765625f * ((CP26FPS_3866 - (CP26FPS_3867 * CP26FPS_3867)) + 1.0f), 0.1599999964237213134765625f * CP26FPS_3870) + CP26FPS_3886;
                                    float3 CP26FPS_3893 = ((CP26FPS_3883 / CP26FPS_3884) + float3(-2.5f, -0.5f, 1.5f)) * CP26FPS_40_m13.xxx;
                                    float3 CP26FPS_3895 = ((CP26FPS_3886 / CP26FPS_3887) + float3(-2.5f, -0.5f, 1.5f)) * CP26FPS_40_m13.yyy;
                                    float2 CP26FPS_3897 = CP26FPS_3838 * CP26FPS_40_m13.xy;
                                    float CP26FPS_3898 = CP26FPS_3893.x;
                                    float CP26FPS_3899 = CP26FPS_3895.x;
                                    float CP26FPS_3902 = CP26FPS_3893.y;
                                    float CP26FPS_3905 = CP26FPS_3893.z;
                                    float CP26FPS_3908 = CP26FPS_3895.y;
                                    float CP26FPS_3915 = CP26FPS_3895.z;
                                    float CP26FPS_3922 = CP26FPS_3884.x;
                                    float CP26FPS_3923 = CP26FPS_3887.x;
                                    float CP26FPS_3925 = CP26FPS_3884.y;
                                    float CP26FPS_3927 = CP26FPS_3884.z;
                                    float CP26FPS_3929 = CP26FPS_3887.y;
                                    float CP26FPS_3933 = CP26FPS_3887.z;
                                    float2 CP26FPS_4011 = 1.0f.xx - CP26FPS_3812;
                                    bool2 CP26FPS_5027 = isnan(CP26FPS_3812);
                                    bool2 CP26FPS_5028 = isnan(CP26FPS_4011);
                                    float2 CP26FPS_5029 = min(CP26FPS_3812, CP26FPS_4011);
                                    float2 CP26FPS_5030 = float2(CP26FPS_5027.x ? CP26FPS_4011.x : CP26FPS_5029.x, CP26FPS_5027.y ? CP26FPS_4011.y : CP26FPS_5029.y);
                                    float2 CP26FPS_4012 = float2(CP26FPS_5028.x ? CP26FPS_3812.x : CP26FPS_5030.x, CP26FPS_5028.y ? CP26FPS_3812.y : CP26FPS_5030.y);
                                    float CP26FPS_4013 = CP26FPS_4012.x;
                                    float CP26FPS_4014 = CP26FPS_4012.y;
                                    float CP26FPS_4015 = isnan(CP26FPS_4014) ? CP26FPS_4013 : (isnan(CP26FPS_4013) ? CP26FPS_4014 : min(CP26FPS_4013, CP26FPS_4014));
                                    float CP26FPS_4019 = (CP26FPS_40_m11[CP26FPS_3782].z - CP26FPS_3808) * 0.25f;
                                    float CP26FPS_4021 = smoothstep(0.0f, 0.0500000007450580596923828125f, isnan(CP26FPS_4015) ? CP26FPS_4019 : (isnan(CP26FPS_4019) ? CP26FPS_4015 : min(CP26FPS_4019, CP26FPS_4015)));
                                    CP26FPS_4029 = CP26FPS_3783 ? lerp(1.0f, (any(bool3(CP26FPS_3821.x || CP26FPS_3822.x, CP26FPS_3821.y || CP26FPS_3822.y, CP26FPS_3821.z || CP26FPS_3822.z)) || ((asuint(CP26FPS_3825) & 2147483647u) > 2139095040u)) ? 1.0f : ((((((((((CP26FPS_3922 * CP26FPS_3923) * CP26F_ShadowCompare(CP26FPS_42, float3(CP26FPS_3897 + float2(CP26FPS_3898, CP26FPS_3899), CP26FPS_501).xy, CP26FPS_3825)) + ((CP26FPS_3925 * CP26FPS_3923) * CP26F_ShadowCompare(CP26FPS_42, float3(CP26FPS_3897 + float2(CP26FPS_3902, CP26FPS_3899), CP26FPS_501).xy, CP26FPS_3825))) + ((CP26FPS_3927 * CP26FPS_3923) * CP26F_ShadowCompare(CP26FPS_42, float3(CP26FPS_3897 + float2(CP26FPS_3905, CP26FPS_3899), CP26FPS_501).xy, CP26FPS_3825))) + ((CP26FPS_3922 * CP26FPS_3929) * CP26F_ShadowCompare(CP26FPS_42, float3(CP26FPS_3897 + float2(CP26FPS_3898, CP26FPS_3908), CP26FPS_501).xy, CP26FPS_3825))) + ((CP26FPS_3925 * CP26FPS_3929) * CP26F_ShadowCompare(CP26FPS_42, float3(CP26FPS_3897 + float2(CP26FPS_3902, CP26FPS_3908), CP26FPS_501).xy, CP26FPS_3825))) + ((CP26FPS_3927 * CP26FPS_3929) * CP26F_ShadowCompare(CP26FPS_42, float3(CP26FPS_3897 + float2(CP26FPS_3905, CP26FPS_3908), CP26FPS_501).xy, CP26FPS_3825))) + ((CP26FPS_3922 * CP26FPS_3933) * CP26F_ShadowCompare(CP26FPS_42, float3(CP26FPS_3897 + float2(CP26FPS_3898, CP26FPS_3915), CP26FPS_501).xy, CP26FPS_3825))) + ((CP26FPS_3925 * CP26FPS_3933) * CP26F_ShadowCompare(CP26FPS_42, float3(CP26FPS_3897 + float2(CP26FPS_3902, CP26FPS_3915), CP26FPS_501).xy, CP26FPS_3825))) + ((CP26FPS_3927 * CP26FPS_3933) * CP26F_ShadowCompare(CP26FPS_42, float3(CP26FPS_3897 + float2(CP26FPS_3905, CP26FPS_3915), CP26FPS_501).xy, CP26FPS_3825))), CP26FPS_3733 ? (isnan(CP26FPS_4021) ? CP26FPS_40_m11[CP26FPS_3782].w : (isnan(CP26FPS_40_m11[CP26FPS_3782].w) ? CP26FPS_4021 : min(CP26FPS_40_m11[CP26FPS_3782].w, CP26FPS_4021))) : CP26FPS_40_m11[CP26FPS_3782].w) : 1.0f;
                                }
                                else
                                {
                                    CP26FPS_4029 = clamp(dot(CP26FPS_657, CP26FPS_3568) + 1.0f, 0.0f, 1.0f);
                                }
                                CP26FPS_4030 = CP26FPS_4029;
                            }
                            else
                            {
                                CP26FPS_4030 = 1.0f;
                            }
                            float CP26FPS_4092;
                            float3 CP26FPS_4093;
                            float CP26FPS_4094;
                            float3 CP26FPS_4095;
                            float3 CP26FPS_4096;
                            [branch]
                            if (CP26FPS_3477 == 0u)
                            {
                                float3 CP26FPS_4036 = CP26FPS_36_m6[CP26FPS_3364].xyz * CP26FPS_3706;
                                float CP26FPS_4037 = CP26FPS_4036.x;
                                float CP26FPS_4038 = CP26FPS_4036.y;
                                float CP26FPS_4039 = CP26FPS_4036.z;
                                float CP26FPS_4040 = isnan(CP26FPS_4038) ? CP26FPS_4037 : (isnan(CP26FPS_4037) ? CP26FPS_4038 : max(CP26FPS_4037, CP26FPS_4038));
                                float CP26FPS_4042 = (isnan(CP26FPS_4039) ? CP26FPS_4040 : (isnan(CP26FPS_4040) ? CP26FPS_4039 : max(CP26FPS_4040, CP26FPS_4039))) * lerp(0.75f, 0.5f, CP26FPS_3274);
                                float3 CP26FPS_4049 = CP26FPS_3011.xyz;
                                CP26FPS_4092 = CP26FPS_3706;
                                CP26FPS_4093 = (CP26FPS_36_m6[CP26FPS_3364].xyz * ((1.0f - CP26FPS_36_m6[CP26FPS_3376].y) + ((1.0f / (isnan(CP26FPS_4042) ? 1.0f : (isnan(1.0f) ? CP26FPS_4042 : max(1.0f, CP26FPS_4042)))) * CP26FPS_36_m6[CP26FPS_3376].y))) * lerp(0.25f * CP26FPS_36_m6[CP26FPS_3376].x, 1.0f, clamp(CP26FPS_3726 + 0.5f, 0.0f, 1.0f));
                                CP26FPS_4094 = CP26FPS_3727;
                                CP26FPS_4095 = CP26FPS_4049;
                                CP26FPS_4096 = CP26FPS_4049;
                            }
                            else
                            {
                                float CP26FPS_4088;
                                float CP26FPS_4089;
                                float3 CP26FPS_4090;
                                float3 CP26FPS_4091;
                                if (CP26FPS_3477 == 3u)
                                {
                                    CP26FPS_4088 = CP26FPS_3706 * (smoothstep(lerp(0.800000011920928955078125f, 0.20000000298023223876953125f, CP26FPS_36_m6[CP26FPS_3376].x), lerp(0.89999997615814208984375f, 0.5f, CP26FPS_36_m6[CP26FPS_3376].x), CP26FPS_3240) * CP26FPS_4030);
                                    CP26FPS_4089 = clamp(dot(CP26FPS_2207, -normalize(cross(CP26FPS_739, cross(CP26FPS_739, CP26FPS_3568)))), 0.0f, 1.0f);
                                    CP26FPS_4090 = lerp(0.5f.xxx, CP26FPS_2213, CP26FPS_36_m6[CP26FPS_3376].y.xxx);
                                    CP26FPS_4091 = 0.0f.xxx;
                                }
                                else
                                {
                                    bool CP26FPS_4074 = CP26FPS_3477 == 1u;
                                    float CP26FPS_4084;
                                    float3 CP26FPS_4085;
                                    if (CP26FPS_4074)
                                    {
                                        CP26FPS_4084 = clamp(clamp(CP26FPS_3726 + CP26FPS_36_m6[CP26FPS_3376].x, -1.0f, 1.0f), 0.0f, 1.0f) * CP26FPS_4030;
                                        CP26FPS_4085 = CP26FPS_2217 * CP26FPS_36_m6[CP26FPS_3376].y;
                                    }
                                    else
                                    {
                                        CP26FPS_4084 = CP26FPS_3727;
                                        CP26FPS_4085 = 0.0f.xxx;
                                    }
                                    bool3 CP26FPS_4086 = CP26FPS_4074.xxx;
                                    CP26FPS_4088 = CP26FPS_3706;
                                    CP26FPS_4089 = CP26FPS_4084;
                                    CP26FPS_4090 = float3(CP26FPS_4086.x ? CP26FPS_2213.x : 0.0f.xxx.x, CP26FPS_4086.y ? CP26FPS_2213.y : 0.0f.xxx.y, CP26FPS_4086.z ? CP26FPS_2213.z : 0.0f.xxx.z);
                                    CP26FPS_4091 = CP26FPS_4085;
                                }
                                CP26FPS_4092 = CP26FPS_4088;
                                CP26FPS_4093 = CP26FPS_36_m6[CP26FPS_3364].xyz;
                                CP26FPS_4094 = CP26FPS_4089;
                                CP26FPS_4095 = CP26FPS_4090;
                                CP26FPS_4096 = CP26FPS_4091;
                            }
                            float3 CP26FPS_4133;
                            [branch]
                            if (CP26FPS_3477 != 3u)
                            {
                                float3 CP26FPS_4101 = CP26FPS_3568 + CP26FPS_543;
                                float CP26FPS_4102 = dot(CP26FPS_4101, CP26FPS_4101);
                                float CP26FPS_4106 = dot(CP26FPS_3033, CP26FPS_4101 * rsqrt(isnan(CP26FPS_4102) ? 6.103515625e-05f : (isnan(6.103515625e-05f) ? CP26FPS_4102 : max(6.103515625e-05f, CP26FPS_4102))));
                                float CP26FPS_4109 = sqrt(1.0f - (CP26FPS_4106 * CP26FPS_4106));
                                float3 CP26FPS_4114 = clamp(pow(isnan(9.9999997473787516355514526367188e-05f) ? CP26FPS_4109 : (isnan(CP26FPS_4109) ? 9.9999997473787516355514526367188e-05f : max(CP26FPS_4109, 9.9999997473787516355514526367188e-05f)), 200.0f).xxx * CP26FPS_588, 0.0f.xxx, 1.0f.xxx);
                                CP26FPS_4133 = (((((((CP26FPS_4114 * CP26FPS_57.SampleLevel(CP26F_linear_clamp_sampler, float2(CP26FPS_4114.x, float(CP26FPS_4106 > 0.0f) * CP26FPS_3050), 0.0f).xyz) * CP26FPS_727) * CP26FPS_2216) * CP26FPS_54_m36) * 5.0f) * CP26FPS_2089) * 1.0f) * CP26FPS_36_m6[CP26FPS_3385].z;
                            }
                            else
                            {
                                CP26FPS_4133 = 0.0f.xxx;
                            }
                            float3 CP26FPS_4136 = CP26FPS_4093 * CP26FPS_4092;
                            CP26FPS_4143 = CP26FPS_3328 + (((CP26FPS_4136 * lerp(CP26FPS_4096, CP26FPS_4095, CP26FPS_4094.xxx)) * CP26FPS_3190) + ((CP26FPS_4136 * CP26FPS_4133) * CP26FPS_4094));
                        }
                        else
                        {
                            CP26FPS_4143 = CP26FPS_3328;
                        }
                        CP26FPS_4144 = CP26FPS_4143;
                        break;
                    } while(false);
                    CP26FPS_4145 = CP26FPS_4144;
                    break;
                } while(false);
                CP26FPS_4146 = CP26FPS_4145;
            }
            else
            {
                CP26FPS_4146 = CP26FPS_3328;
            }
            CP26FPS_3351 = CP26FPS_4146;
        }
    }
    float3 CP26FPS_4186;
    [branch]
    if (CP26FPS_54_m12 > 0.5f)
    {
        CP26FPS_4186 = lerp(lerp(0.5f.xxx, lerp(dot(CP26FPS_3327, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, CP26FPS_3327, CP26FPS_54_m14.xxx), CP26FPS_54_m15.xxx) * CP26FPS_54_m13, CP26FPS_54_m26.xyz, CP26FPS_54_m26.w.xxx) + ((CP26FPS_54_m27.xyz * smoothstep(1.0f - CP26FPS_54_m16, 1.0f, 1.0f - clamp(CP26FPS_3238, 0.0f, 1.0f))) * CP26FPS_54_m17);
    }
    else
    {
        CP26FPS_4186 = CP26FPS_3327;
    }
    float4 CP26FPS_4198 = float4(CP26FPS_4186 * CP26FPS_20_m20.y, CP26FPS_593);
    CP26FPS_4198.w = (CP26FPS_54_m8 == 1.0f) ? CP26FPS_593 : 1.0f;
    float4 CP26FPS_4585;
    [branch]
    if (CP26FPS_20_m91.w < 0.5f)
    {
        float3 CP26FPS_4202 = -CP26FPS_543;
        float CP26FPS_4213 = (CP26FPS_544 * CP26FPS_20_m44.w) - CP26FPS_20_m43.w;
        float CP26FPS_4218 = CP26FPS_771 * CP26FPS_20_m46.w;
        float CP26FPS_4222 = CP26FPS_4218 + CP26FPS_20_m47.w;
        float CP26FPS_4223 = isnan(CP26FPS_4222) ? 0.00999999977648258209228515625f : (isnan(0.00999999977648258209228515625f) ? CP26FPS_4222 : max(0.00999999977648258209228515625f, CP26FPS_4222));
        float3 CP26FPS_4237 = exp(CP26FPS_20_m45.xyz * ((-(isnan(CP26FPS_4213) ? 0.0f : (isnan(0.0f) ? CP26FPS_4213 : max(0.0f, CP26FPS_4213)))) * (((1.0f - exp(-CP26FPS_4223)) / CP26FPS_4223) * exp(CP26FPS_4218 + CP26FPS_20_m48.w))));
        float CP26FPS_4240 = dot(CP26FPS_4202, CP26FPS_20_m44.xyz);
        float CP26FPS_4246 = CP26FPS_20_m45.w * CP26FPS_20_m45.w;
        float CP26FPS_4250 = (1.0f + CP26FPS_4246) - ((2.0f * CP26FPS_20_m45.w) * CP26FPS_4240);
        float CP26FPS_4254 = (12.56637096405029296875f * CP26FPS_4250) * sqrt(CP26FPS_4250);
        float3 CP26FPS_4577;
        float CP26FPS_4578;
        if (CP26FPS_20_m55.z > 0.0f)
        {
            uint3 CP26FPS_4299 = (uint3(int3(int(CP26FPS_729.x), int(CP26FPS_729.y), int(CP26FPS_20_m19 & 7u))) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint CP26FPS_4300 = CP26FPS_4299.y;
            uint CP26FPS_4301 = CP26FPS_4299.z;
            uint CP26FPS_4304 = CP26FPS_4299.x + (CP26FPS_4300 * CP26FPS_4301);
            uint CP26FPS_4306 = CP26FPS_4300 + (CP26FPS_4301 * CP26FPS_4304);
            uint CP26FPS_4308 = CP26FPS_4301 + (CP26FPS_4304 * CP26FPS_4306);
            uint CP26FPS_4310 = CP26FPS_4304 + (CP26FPS_4306 * CP26FPS_4308);
            float CP26FPS_4335 = dot(CP26FPS_4202, -CP26FPS_18_m0[2].xyz);
            float3 CP26FPS_4342 = CP26FPS_650 - CP26FPS_18_m11.xyz;
            float CP26FPS_4344 = (CP26FPS_20_m55.w * ((CP26FPS_4335 > 5.9604644775390625e-08f) ? (1.0f / CP26FPS_4335) : 0.0f)) * (1.0f / CP26FPS_544);
            float CP26FPS_4345 = CP26FPS_4342.y;
            float CP26FPS_4346 = CP26FPS_4344 * CP26FPS_4345;
            float CP26FPS_4348 = CP26FPS_18_m11.y + CP26FPS_4346;
            float CP26FPS_4349 = CP26FPS_4345 - CP26FPS_4346;
            float CP26FPS_4351 = (1.0f - CP26FPS_4344) * CP26FPS_544;
            float CP26FPS_4357 = CP26FPS_20_m49.z * (CP26FPS_4348 - CP26FPS_20_m49.x);
            float CP26FPS_4364 = CP26FPS_20_m49.z * CP26FPS_4349;
            float CP26FPS_4365 = isnan(CP26FPS_4364) ? (-127.0f) : (isnan(-127.0f) ? CP26FPS_4364 : max(-127.0f, CP26FPS_4364));
            float CP26FPS_4381 = CP26FPS_20_m52.x * (CP26FPS_4348 - CP26FPS_20_m52.z);
            float CP26FPS_4388 = CP26FPS_20_m52.x * CP26FPS_4349;
            float CP26FPS_4389 = isnan(CP26FPS_4388) ? (-127.0f) : (isnan(-127.0f) ? CP26FPS_4388 : max(-127.0f, CP26FPS_4388));
            float CP26FPS_4400 = ((CP26FPS_20_m49.y * exp2(-(isnan(CP26FPS_4357) ? (-127.0f) : (isnan(-127.0f) ? CP26FPS_4357 : max(-127.0f, CP26FPS_4357))))) * ((abs(CP26FPS_4365) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-CP26FPS_4365)) / CP26FPS_4365) : (0.693147182464599609375f - (0.2402265071868896484375f * CP26FPS_4365)))) + ((CP26FPS_20_m52.y * exp2(-(isnan(CP26FPS_4381) ? (-127.0f) : (isnan(-127.0f) ? CP26FPS_4381 : max(-127.0f, CP26FPS_4381))))) * ((abs(CP26FPS_4389) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-CP26FPS_4389)) / CP26FPS_4389) : (0.693147182464599609375f - (0.2402265071868896484375f * CP26FPS_4389))));
            float CP26FPS_4404 = clamp(exp2(-(CP26FPS_4400 * CP26FPS_4351)), 0.0f, 1.0f);
            float CP26FPS_4422 = clamp((CP26FPS_544 * CP26FPS_20_m50.w) + CP26FPS_20_m50.z, 0.0f, 1.0f);
            float CP26FPS_4425 = clamp(((isnan(CP26FPS_20_m51.w) ? CP26FPS_4404 : (isnan(CP26FPS_4404) ? CP26FPS_20_m51.w : max(CP26FPS_4404, CP26FPS_20_m51.w))) + clamp((CP26FPS_544 * CP26FPS_20_m50.y) + CP26FPS_20_m50.x, 0.0f, 1.0f)) + CP26FPS_4422, 0.0f, 1.0f);
            float CP26FPS_4444 = CP26FPS_4351 - CP26FPS_20_m53.w;
            float4 CP26FPS_4465 = lerp(float4(0.0f, 0.0f, 0.0f, 1.0f), CP26FPS_67.SampleLevel(CP26F_linear_clamp_sampler, float3((CP26FPS_3302 + ((((float3(uint3(CP26FPS_4310, CP26FPS_4306 + (CP26FPS_4308 * CP26FPS_4310), CP26FPS_508) >> uint3(16u, 16u, 16u)) * 1.525902189314365386962890625e-05f.xxx) * 2.0f) - 1.0f.xxx) * CP26FPS_20_m59.w).xy) * CP26FPS_20_m57.xy, (log2((CP26FPS_524 * CP26FPS_20_m56.x) + CP26FPS_20_m56.y) * CP26FPS_20_m56.z) / CP26FPS_20_m55.z), 0.0f), clamp((CP26FPS_524 - CP26FPS_20_m58.z) * 1000000.0f, 0.0f, 1.0f).xxxx);
            float CP26FPS_4467 = CP26FPS_4465.w;
            CP26FPS_4577 = CP26FPS_4465.xyz + (((CP26FPS_20_m51.xyz * (1.0f - CP26FPS_4425)) + (((CP26FPS_20_m54.xyz * pow(clamp(dot(CP26FPS_543, CP26FPS_20_m53.xyz), 0.0f, 1.0f), CP26FPS_20_m54.w)) * (1.0f - clamp(exp2(-(CP26FPS_4400 * (isnan(0.0f) ? CP26FPS_4444 : (isnan(CP26FPS_4444) ? 0.0f : max(CP26FPS_4444, 0.0f))))), 0.0f, 1.0f))) * (1.0f - CP26FPS_4422))) * CP26FPS_4467);
            CP26FPS_4578 = CP26FPS_4467 * CP26FPS_4425;
        }
        else
        {
            float3 CP26FPS_4471 = CP26FPS_650 - CP26FPS_18_m11.xyz;
            float CP26FPS_4473 = CP26FPS_4471.y;
            float CP26FPS_4479 = CP26FPS_20_m49.z * (CP26FPS_18_m11.y - CP26FPS_20_m49.x);
            float CP26FPS_4486 = CP26FPS_20_m49.z * CP26FPS_4473;
            float CP26FPS_4487 = isnan(CP26FPS_4486) ? (-127.0f) : (isnan(-127.0f) ? CP26FPS_4486 : max(-127.0f, CP26FPS_4486));
            float CP26FPS_4503 = CP26FPS_20_m52.x * (CP26FPS_18_m11.y - CP26FPS_20_m52.z);
            float CP26FPS_4510 = CP26FPS_20_m52.x * CP26FPS_4473;
            float CP26FPS_4511 = isnan(CP26FPS_4510) ? (-127.0f) : (isnan(-127.0f) ? CP26FPS_4510 : max(-127.0f, CP26FPS_4510));
            float CP26FPS_4522 = ((CP26FPS_20_m49.y * exp2(-(isnan(CP26FPS_4479) ? (-127.0f) : (isnan(-127.0f) ? CP26FPS_4479 : max(-127.0f, CP26FPS_4479))))) * ((abs(CP26FPS_4487) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-CP26FPS_4487)) / CP26FPS_4487) : (0.693147182464599609375f - (0.2402265071868896484375f * CP26FPS_4487)))) + ((CP26FPS_20_m52.y * exp2(-(isnan(CP26FPS_4503) ? (-127.0f) : (isnan(-127.0f) ? CP26FPS_4503 : max(-127.0f, CP26FPS_4503))))) * ((abs(CP26FPS_4511) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-CP26FPS_4511)) / CP26FPS_4511) : (0.693147182464599609375f - (0.2402265071868896484375f * CP26FPS_4511))));
            float CP26FPS_4526 = clamp(exp2(-(CP26FPS_4522 * CP26FPS_544)), 0.0f, 1.0f);
            float CP26FPS_4544 = clamp((CP26FPS_544 * CP26FPS_20_m50.w) + CP26FPS_20_m50.z, 0.0f, 1.0f);
            float CP26FPS_4547 = clamp(((isnan(CP26FPS_20_m51.w) ? CP26FPS_4526 : (isnan(CP26FPS_4526) ? CP26FPS_20_m51.w : max(CP26FPS_4526, CP26FPS_20_m51.w))) + clamp((CP26FPS_544 * CP26FPS_20_m50.y) + CP26FPS_20_m50.x, 0.0f, 1.0f)) + CP26FPS_4544, 0.0f, 1.0f);
            float CP26FPS_4566 = CP26FPS_544 - CP26FPS_20_m53.w;
            CP26FPS_4577 = (CP26FPS_20_m51.xyz * (1.0f - CP26FPS_4547)) + (((CP26FPS_20_m54.xyz * pow(clamp(dot(CP26FPS_543, CP26FPS_20_m53.xyz), 0.0f, 1.0f), CP26FPS_20_m54.w)) * (1.0f - clamp(exp2(-(CP26FPS_4522 * (isnan(0.0f) ? CP26FPS_4566 : (isnan(CP26FPS_4566) ? 0.0f : max(CP26FPS_4566, 0.0f))))), 0.0f, 1.0f))) * (1.0f - CP26FPS_4544));
            CP26FPS_4578 = CP26FPS_4547;
        }
        float3 CP26FPS_4583 = (CP26FPS_4198.xyz * (CP26FPS_4237 * CP26FPS_4578)) + ((((clamp(((CP26FPS_20_m46.xyz * (0.0596831031143665313720703125f * (1.0f + (CP26FPS_4240 * CP26FPS_4240)))) + CP26FPS_20_m48.xyz) + (CP26FPS_20_m47.xyz * ((1.0f - CP26FPS_4246) / (isnan(0.001000000047497451305389404296875f) ? CP26FPS_4254 : (isnan(CP26FPS_4254) ? 0.001000000047497451305389404296875f : max(CP26FPS_4254, 0.001000000047497451305389404296875f))))), 0.0f.xxx, 1.0f.xxx) * 255.0f) * (1.0f.xxx - CP26FPS_4237)) * CP26FPS_4578) + CP26FPS_4577);
        CP26FPS_4585 = float4(CP26FPS_4583.x, CP26FPS_4583.y, CP26FPS_4583.z, CP26FPS_4198.w);
    }
    else
    {
        CP26FPS_4585 = CP26FPS_4198;
    }
    CP26FPS_15 = CP26FPS_4585;
    CP26FPS_16 = CP26FPS_2248;
}

CP26FPS_SPIRV_Cross_Output CP26FPS_main(CP26FPS_SPIRV_Cross_Input stage_input)
{
    CP26FPS_gl_FragCoord = stage_input.CP26FPS_gl_FragCoord;
    CP26FPS_gl_FragCoord.w = 1.0 / CP26FPS_gl_FragCoord.w;
    CP26FPS_gl_FrontFacing = stage_input.CP26FPS_gl_FrontFacing;
    CP26FPS_3 = stage_input.CP26FPS_3;
    CP26FPS_4 = stage_input.CP26FPS_4;
    CP26FPS_5 = stage_input.CP26FPS_5;
    CP26FPS_6 = stage_input.CP26FPS_6;
    CP26FPS_7 = stage_input.CP26FPS_7;
    CP26FPS_8 = stage_input.CP26FPS_8;
    CP26FPS_9 = stage_input.CP26FPS_9;
    CP26FPS_10 = stage_input.CP26FPS_10;
    CP26FPS_11 = stage_input.CP26FPS_11;
    CP26FPS_13 = stage_input.CP26FPS_13;
    CP26FPS_frag_main();
    CP26FPS_SPIRV_Cross_Output stage_output;
    stage_output.CP26FPS_15 = CP26FPS_15;
    stage_output.CP26FPS_16 = CP26FPS_16;
    return stage_output;
}
