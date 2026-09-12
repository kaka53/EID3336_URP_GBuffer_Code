struct _27
{
    column_major float4x4 _m0;
    float4 _m1;
    float4 _m2;
};

static float4 VSX171;
static float4 VSX172;

cbuffer _20_21 : register(b14)
{
    float _21_m0 : packoffset(c0);
    float _21_m1 : packoffset(c0.y);
    float _21_m2 : packoffset(c0.z);
    float _21_m3 : packoffset(c0.w);
    float _21_m4 : packoffset(c1);
    float _21_m5 : packoffset(c1.y);
    float _21_m6 : packoffset(c1.z);
    float _21_m7 : packoffset(c1.w);
};

cbuffer _22_23 : register(b13)
{
    column_major float4x4 _23_m0 : packoffset(c0);
    column_major float4x4 _23_m1 : packoffset(c4);
    column_major float4x4 _23_m2 : packoffset(c8);
    column_major float4x4 _23_m3 : packoffset(c12);
    column_major float4x4 _23_m4 : packoffset(c16);
    column_major float4x4 _23_m5 : packoffset(c20);
    column_major float4x4 _23_m6 : packoffset(c24);
    column_major float4x4 _23_m7 : packoffset(c28);
    column_major float4x4 _23_m8 : packoffset(c32);
    column_major float4x4 _23_m9 : packoffset(c36);
    column_major float4x4 _23_m10 : packoffset(c40);
    float4 _23_m11 : packoffset(c44);
    column_major float4x4 _23_m12 : packoffset(c45);
    column_major float4x4 _23_m13 : packoffset(c49);
    column_major float4x4 _23_m14 : packoffset(c53);
    column_major float4x4 _23_m15 : packoffset(c57);
    column_major float4x4 _23_m16 : packoffset(c61);
    column_major float4x4 _23_m17 : packoffset(c65);
    column_major float4x4 _23_m18 : packoffset(c69);
    column_major float4x4 _23_m19 : packoffset(c73);
    column_major float4x4 _23_m20 : packoffset(c77);
    float4 _23_m21 : packoffset(c81);
};

cbuffer _24_25 : register(b16)
{
    float4 _25_m0 : packoffset(c0);
    float4 _25_m1 : packoffset(c1);
    float4 _25_m2 : packoffset(c2);
    float4 _25_m3 : packoffset(c3);
    float4 _25_m4 : packoffset(c4);
    float4 _25_m5 : packoffset(c5);
    float4 _25_m6[6] : packoffset(c6);
    float4 _25_m7[6] : packoffset(c12);
    float4 _25_m8 : packoffset(c18);
    float4 _25_m9 : packoffset(c19);
    float4 _25_m10 : packoffset(c20);
    float4 _25_m11 : packoffset(c21);
    float4 _25_m12 : packoffset(c22);
    float4 _25_m13 : packoffset(c23);
    float4 _25_m14 : packoffset(c24);
    float4 _25_m15 : packoffset(c25);
    float _25_m16 : packoffset(c26);
    float _25_m17 : packoffset(c26.y);
    float _25_m18 : packoffset(c26.z);
    uint _25_m19 : packoffset(c26.w);
    float4 _25_m20 : packoffset(c27);
    int4 _25_m21 : packoffset(c28);
    float4 _25_m22 : packoffset(c29);
    float4 _25_m23 : packoffset(c30);
    float4 _25_m24 : packoffset(c31);
    float4 _25_m25 : packoffset(c32);
    float4 _25_m26 : packoffset(c33);
    float4 _25_m27 : packoffset(c34);
    float4 _25_m28 : packoffset(c35);
    float4 _25_m29 : packoffset(c36);
    float4 _25_m30 : packoffset(c37);
    float4 _25_m31 : packoffset(c38);
    float4 _25_m32[4] : packoffset(c39);
    float4 _25_m33[4] : packoffset(c43);
    float4 _25_m34[4] : packoffset(c47);
    float4 _25_m35[4] : packoffset(c51);
    float4 _25_m36 : packoffset(c55);
    float4 _25_m37 : packoffset(c56);
    float4 _25_m38[4] : packoffset(c57);
    float4 _25_m39[4] : packoffset(c61);
    float4 _25_m40[4] : packoffset(c65);
    float4 _25_m41 : packoffset(c69);
    float4 _25_m42 : packoffset(c70);
    float4 _25_m43 : packoffset(c71);
    float4 _25_m44 : packoffset(c72);
    float4 _25_m45 : packoffset(c73);
    float4 _25_m46 : packoffset(c74);
    float4 _25_m47 : packoffset(c75);
    float4 _25_m48 : packoffset(c76);
    float4 _25_m49 : packoffset(c77);
    float4 _25_m50 : packoffset(c78);
    float4 _25_m51 : packoffset(c79);
    float4 _25_m52 : packoffset(c80);
    float4 _25_m53 : packoffset(c81);
    float4 _25_m54 : packoffset(c82);
    float4 _25_m55 : packoffset(c83);
    float4 _25_m56 : packoffset(c84);
    float4 _25_m57 : packoffset(c85);
    float4 _25_m58 : packoffset(c86);
    float4 _25_m59 : packoffset(c87);
    float4 _25_m60 : packoffset(c88);
    float4 _25_m61 : packoffset(c89);
    float4 _25_m62 : packoffset(c90);
    float4 _25_m63 : packoffset(c91);
    float4 _25_m64 : packoffset(c92);
    float4 _25_m65 : packoffset(c93);
    float4 _25_m66 : packoffset(c94);
    float4 _25_m67 : packoffset(c95);
    float4 _25_m68 : packoffset(c96);
    float4 _25_m69 : packoffset(c97);
    float4 _25_m70 : packoffset(c98);
    float4 _25_m71 : packoffset(c99);
    float4 _25_m72 : packoffset(c100);
    float4 _25_m73 : packoffset(c101);
    float4 _25_m74 : packoffset(c102);
    float4 _25_m75 : packoffset(c103);
    float4 _25_m76 : packoffset(c104);
    float4 _25_m77 : packoffset(c105);
    float4 _25_m78 : packoffset(c106);
    float4 _25_m79 : packoffset(c107);
    float4 _25_m80 : packoffset(c108);
    float4 _25_m81 : packoffset(c109);
    float4 _25_m82 : packoffset(c110);
    float4 _25_m83 : packoffset(c111);
    float4 _25_m84 : packoffset(c112);
    float4 _25_m85 : packoffset(c113);
    float4 _25_m86 : packoffset(c114);
    float4 _25_m87 : packoffset(c115);
    float4 _25_m88 : packoffset(c116);
    float4 _25_m89 : packoffset(c117);
    float4 _25_m90 : packoffset(c118);
    float4 _25_m91 : packoffset(c119);
    float4 _25_m92 : packoffset(c120);
    float4 _25_m93 : packoffset(c121);
    float4 _25_m94 : packoffset(c122);
    float4 _25_m95 : packoffset(c123);
    float4 _25_m96 : packoffset(c124);
    float4 _25_m97 : packoffset(c125);
    float4 _25_m98 : packoffset(c126);
    float4 _25_m99[2] : packoffset(c127);
    float4 _25_m100[2] : packoffset(c129);
    float _25_m101 : packoffset(c131);
    float _25_m102 : packoffset(c131.y);
    float _25_m103 : packoffset(c131.z);
    float _25_m104 : packoffset(c131.w);
    float4 _25_m105 : packoffset(c132);
    float4 _25_m106 : packoffset(c133);
    float4 _25_m107 : packoffset(c134);
    float4 _25_m108 : packoffset(c135);
    float4 _25_m109 : packoffset(c136);
    float4 _25_m110 : packoffset(c137);
    float4 _25_m111 : packoffset(c138);
    float4 _25_m112 : packoffset(c139);
    float4 _25_m113 : packoffset(c140);
    float4 _25_m114 : packoffset(c141);
    float4 _25_m115 : packoffset(c142);
    float4 _25_m116 : packoffset(c143);
    float4 _25_m117 : packoffset(c144);
    float4 _25_m118 : packoffset(c145);
    float4 _25_m119 : packoffset(c146);
    float4 _25_m120 : packoffset(c147);
    float4 _25_m121 : packoffset(c148);
    float4 _25_m122 : packoffset(c149);
    float4 _25_m123 : packoffset(c150);
    float4 _25_m124 : packoffset(c151);
    float4 _25_m125 : packoffset(c152);
    float4 _25_m126 : packoffset(c153);
    float4 _25_m127 : packoffset(c154);
    float4 _25_m128 : packoffset(c155);
    float4 _25_m129 : packoffset(c156);
    float4 _25_m130 : packoffset(c157);
    float4 _25_m131 : packoffset(c158);
    float4 _25_m132 : packoffset(c159);
    float4 _25_m133 : packoffset(c160);
    float4 _25_m134 : packoffset(c161);
    column_major float4x4 _25_m135 : packoffset(c162);
    float4 _25_m136 : packoffset(c166);
    float4 _25_m137 : packoffset(c167);
    float4 _25_m138[32] : packoffset(c168);
};

cbuffer EID3863InstanceRecords : register(b17)
{
    _27 _28_m0[682] : packoffset(c0);
};

cbuffer EID3863WindParameters : register(b18)
{
    float _39_m0 : packoffset(c0);
    float _39_m1 : packoffset(c0.y);
    float _39_m2 : packoffset(c0.z);
    float _39_m3 : packoffset(c0.w);
    float _39_m4 : packoffset(c1);
    float _39_m5 : packoffset(c1.y);
    float _39_m6 : packoffset(c1.z);
    float _39_m7 : packoffset(c1.w);
    float _39_m8 : packoffset(c2);
    float _39_m9 : packoffset(c2.y);
    float _39_m10 : packoffset(c2.z);
    float _39_m11 : packoffset(c2.w);
    float _39_m12 : packoffset(c3);
    float _39_m13 : packoffset(c3.y);
    float _39_m14 : packoffset(c3.z);
    float _39_m15 : packoffset(c3.w);
    float _39_m16 : packoffset(c4);
    float _39_m17 : packoffset(c4.y);
    float _39_m18 : packoffset(c4.z);
    float _39_m19 : packoffset(c4.w);
    float _39_m20 : packoffset(c5);
    float _39_m21 : packoffset(c5.y);
    float _39_m22 : packoffset(c5.z);
    float _39_m23 : packoffset(c5.w);
    float _39_m24 : packoffset(c6);
    float _39_m25 : packoffset(c6.y);
    float _39_m26 : packoffset(c6.z);
    float _39_m27 : packoffset(c6.w);
    float _39_m28 : packoffset(c7);
    float _39_m29 : packoffset(c7.y);
    float _39_m30 : packoffset(c7.z);
    float _39_m31 : packoffset(c7.w);
    float4 _39_m32 : packoffset(c8);
    float4 _39_m33 : packoffset(c9);
    float4 _39_m34 : packoffset(c10);
    float4 _39_m35 : packoffset(c11);
    float4 _39_m36 : packoffset(c12);
    float4 _39_m37 : packoffset(c13);
};

SamplerState _30 : register(s8);
SamplerState _31 : register(s10);
SamplerState _32 : register(s9);
Texture2D<float4> _34 : register(t2);
Texture2D<float4> _35 : register(t3);
Texture2D<float4> _36 : register(t1);
Texture2D<float4> _37 : register(t0);

static float4 VSglXPosition;
static int VSglXInstanceIndex;
static float3 VSX3;
static float3 VSX4;
static float4 VSX5;
static float4 VSX6;
static float2 VSX7;
static float2 VSX8;
static float2 VSX9;
static float2 VSX12;
static float3 VSX14;
static float4 VSX15;
static float3 VSX16;
static float3 VSX17;
static float3 VSX18;
static uint VSX19;

struct EID3863VSInputInternal
{
    float3 VSX3 : TEXCOORD0;
    float3 VSX4 : TEXCOORD1;
    float4 VSX5 : TEXCOORD2;
    float4 VSX6 : TEXCOORD3;
    float2 VSX7 : TEXCOORD4;
    float2 VSX8 : TEXCOORD5;
    float2 VSX9 : TEXCOORD6;
    uint VSglXInstanceIndex : SV_InstanceID;
};

struct EID3863Varyings
{
    float2 VSX12 : TEXCOORD0;
    float3 VSX14 : TEXCOORD2;
    float4 VSX15 : TEXCOORD3;
    float3 VSX16 : TEXCOORD4;
    float3 VSX17 : TEXCOORD5;
    float3 VSX18 : TEXCOORD6;
    nointerpolation uint VSX19 : TEXCOORD7;
    precise float4 VSglXPosition : SV_Position;
};

void vert_main()
{
    float4 _188 = mul(_28_m0[uint(VSglXInstanceIndex)]._m0, float4(VSX3, 1.0f));
    float3 _189 = _188.xyz;
    float3 _193 = float3(_28_m0[uint(VSglXInstanceIndex)]._m0[0].w, _28_m0[uint(VSglXInstanceIndex)]._m0[1].w, _28_m0[uint(VSglXInstanceIndex)]._m0[2].w);
    float3 _201 = _189 - _193;
    _201.y = 0.0f;
    float3 _212 = ((_193 + (_201 * _39_m24)) * (1.0f - _39_m25)) + (mul(_28_m0[uint(VSglXInstanceIndex)]._m0, float4(VSX8, VSX9.x, 1.0f)).xyz * _39_m25);
    float _218 = clamp(VSX6.y - _39_m19, 0.0f, 1.0f);
    float2 _264 = float2(_25_m34[0].y, -_25_m34[0].x);
    float2 _278 = float2(_25_m34[1].y, -_25_m34[1].x);
    float2 _292 = float2(_25_m34[2].y, -_25_m34[2].x);
    float2 _306 = float2(_25_m34[3].y, -_25_m34[3].x);
    float2 _317 = _212.xz;
    float2 _318 = _317 * 0.0500000007450580596923828125f;
    float _319 = _25_m25.x * 0.20000000298023223876953125f;
    float _320 = 1.0f - _319;
    float4 _331 = _37.SampleLevel(_32, _318 + (_25_m26.xy * _39_m31), 0.0f);
    float _333 = _331.y;
    float _345 = _218 * _218;
    bool _349 = _25_m36.x > 0.0f;
    float3 _460;
    float _461;
    float _462;
    [branch]
    if (_349)
    {
        float3 _457;
        float _458;
        float _459;
        [branch]
        if (_25_m35[0].x != 0.0f)
        {
            float3 _454;
            float _455;
            float _456;
            do
            {
                float2 _397 = _193.xz - _25_m32[0].xz;
                float _398 = dot(_397, _25_m34[0].xy);
                float _399 = dot(_397, _264);
                float _405 = abs(_28_m0[uint(VSglXInstanceIndex)]._m0[1].w - _25_m32[0].y);
                if (_25_m34[0].w != 0.0f)
                {
                    if (((abs(_398) > _25_m33[0].x) || (abs(_399) > _25_m33[0].y)) || (_405 > _25_m32[0].w))
                    {
                        _454 = 0.0f.xxx;
                        _455 = 0.0f;
                        _456 = 0.0f;
                        break;
                    }
                }
                else
                {
                    if ((((_398 > _25_m33[0].x) || (_398 < 0.0f)) || (abs(_399) > _25_m33[0].y)) || (_405 > _25_m32[0].w))
                    {
                        _454 = 0.0f.xxx;
                        _455 = 0.0f;
                        _456 = 0.0f;
                        break;
                    }
                }
                float _431 = clamp(abs(_398) / _25_m33[0].x, 0.0f, 1.0f);
                float _441 = _431 / _25_m33[0].w;
                float2 _450 = (_25_m34[0].xy * float((_398 > 0.0f) ? 1 : (-1))) * (((-2.0f) * _25_m34[0].z) + 1.0f);
                _454 = float3(_450.x, 0.0f, _450.y);
                _455 = _25_m35[0].y;
                _456 = (_25_m33[0].z * clamp(_441 * _441, 0.0f, 1.0f)) * min(clamp(2.0f - (2.0f * _431), 0.0f, 1.0f), clamp(2.0f - (2.0f * clamp(abs(_399) / _25_m33[0].y, 0.0f, 1.0f)), 0.0f, 1.0f));
                break;
            } while(false);
            _457 = _454;
            _458 = _455;
            _459 = _456;
        }
        else
        {
            float3 _390;
            float _391;
            float _392;
            do
            {
                if (length(_193 - _25_m32[0].xyz) > _25_m33[0].x)
                {
                    _390 = 0.0f.xxx;
                    _391 = 0.0f;
                    _392 = 0.0f;
                    break;
                }
                float2 _367 = _193.xz - _25_m32[0].xz;
                float _368 = length(_367);
                float _371 = _368 / _25_m33[0].w;
                float _376 = clamp(_368 / _25_m33[0].x, 0.0f, 1.0f);
                float2 _386 = (_367 / _368.xx) * (((-2.0f) * _25_m34[0].z) + 1.0f);
                _390 = float3(_386.x, 0.0f, _386.y);
                _391 = _25_m35[0].y;
                _392 = ((_25_m33[0].z * clamp(_371 * _371, 0.0f, 1.0f)) * (1.0f - (_376 * _376))) * step(_25_m33[0].y, dot(_367, _25_m34[0].xy) / _368);
                break;
            } while(false);
            _457 = _390;
            _458 = _391;
            _459 = _392;
        }
        _460 = _457;
        _461 = _458;
        _462 = _459;
    }
    else
    {
        _460 = 0.0f.xxx;
        _461 = 0.0f;
        _462 = 0.0f;
    }
    bool _463 = _25_m36.x > 1.0f;
    float3 _580;
    float _581;
    float _582;
    [branch]
    if (_463)
    {
        float3 _577;
        float _578;
        float _579;
        [branch]
        if (_25_m35[1].x != 0.0f)
        {
            float3 _574;
            float _575;
            float _576;
            do
            {
                float2 _514 = _193.xz - _25_m32[1].xz;
                float _515 = dot(_514, _25_m34[1].xy);
                float _516 = dot(_514, _278);
                float _522 = abs(_28_m0[uint(VSglXInstanceIndex)]._m0[1].w - _25_m32[1].y);
                if (_25_m34[1].w != 0.0f)
                {
                    if (((abs(_515) > _25_m33[1].x) || (abs(_516) > _25_m33[1].y)) || (_522 > _25_m32[1].w))
                    {
                        _574 = _460;
                        _575 = _461;
                        _576 = _462;
                        break;
                    }
                }
                else
                {
                    if ((((_515 > _25_m33[1].x) || (_515 < 0.0f)) || (abs(_516) > _25_m33[1].y)) || (_522 > _25_m32[1].w))
                    {
                        _574 = _460;
                        _575 = _461;
                        _576 = _462;
                        break;
                    }
                }
                float _548 = clamp(abs(_515) / _25_m33[1].x, 0.0f, 1.0f);
                float _558 = _548 / _25_m33[1].w;
                float2 _567 = (_25_m34[1].xy * float((_515 > 0.0f) ? 1 : (-1))) * (((-2.0f) * _25_m34[1].z) + 1.0f);
                _574 = _460 + float3(_567.x, 0.0f, _567.y);
                _575 = _461 + _25_m35[1].y;
                _576 = _462 + ((_25_m33[1].z * clamp(_558 * _558, 0.0f, 1.0f)) * min(clamp(2.0f - (2.0f * _548), 0.0f, 1.0f), clamp(2.0f - (2.0f * clamp(abs(_516) / _25_m33[1].y, 0.0f, 1.0f)), 0.0f, 1.0f)));
                break;
            } while(false);
            _577 = _574;
            _578 = _575;
            _579 = _576;
        }
        else
        {
            float3 _507;
            float _508;
            float _509;
            do
            {
                if (length(_193 - _25_m32[1].xyz) > _25_m33[1].x)
                {
                    _507 = _460;
                    _508 = _461;
                    _509 = _462;
                    break;
                }
                float2 _481 = _193.xz - _25_m32[1].xz;
                float _482 = length(_481);
                float _485 = _482 / _25_m33[1].w;
                float _490 = clamp(_482 / _25_m33[1].x, 0.0f, 1.0f);
                float2 _500 = (_481 / _482.xx) * (((-2.0f) * _25_m34[1].z) + 1.0f);
                _507 = _460 + float3(_500.x, 0.0f, _500.y);
                _508 = _461 + _25_m35[1].y;
                _509 = _462 + (((_25_m33[1].z * clamp(_485 * _485, 0.0f, 1.0f)) * (1.0f - (_490 * _490))) * step(_25_m33[1].y, dot(_481, _25_m34[1].xy) / _482));
                break;
            } while(false);
            _577 = _507;
            _578 = _508;
            _579 = _509;
        }
        _580 = _577;
        _581 = _578;
        _582 = _579;
    }
    else
    {
        _580 = _460;
        _581 = _461;
        _582 = _462;
    }
    bool _583 = _25_m36.x > 2.0f;
    float3 _700;
    float _701;
    float _702;
    [branch]
    if (_583)
    {
        float3 _697;
        float _698;
        float _699;
        [branch]
        if (_25_m35[2].x != 0.0f)
        {
            float3 _694;
            float _695;
            float _696;
            do
            {
                float2 _634 = _193.xz - _25_m32[2].xz;
                float _635 = dot(_634, _25_m34[2].xy);
                float _636 = dot(_634, _292);
                float _642 = abs(_28_m0[uint(VSglXInstanceIndex)]._m0[1].w - _25_m32[2].y);
                if (_25_m34[2].w != 0.0f)
                {
                    if (((abs(_635) > _25_m33[2].x) || (abs(_636) > _25_m33[2].y)) || (_642 > _25_m32[2].w))
                    {
                        _694 = _580;
                        _695 = _581;
                        _696 = _582;
                        break;
                    }
                }
                else
                {
                    if ((((_635 > _25_m33[2].x) || (_635 < 0.0f)) || (abs(_636) > _25_m33[2].y)) || (_642 > _25_m32[2].w))
                    {
                        _694 = _580;
                        _695 = _581;
                        _696 = _582;
                        break;
                    }
                }
                float _668 = clamp(abs(_635) / _25_m33[2].x, 0.0f, 1.0f);
                float _678 = _668 / _25_m33[2].w;
                float2 _687 = (_25_m34[2].xy * float((_635 > 0.0f) ? 1 : (-1))) * (((-2.0f) * _25_m34[2].z) + 1.0f);
                _694 = _580 + float3(_687.x, 0.0f, _687.y);
                _695 = _581 + _25_m35[2].y;
                _696 = _582 + ((_25_m33[2].z * clamp(_678 * _678, 0.0f, 1.0f)) * min(clamp(2.0f - (2.0f * _668), 0.0f, 1.0f), clamp(2.0f - (2.0f * clamp(abs(_636) / _25_m33[2].y, 0.0f, 1.0f)), 0.0f, 1.0f)));
                break;
            } while(false);
            _697 = _694;
            _698 = _695;
            _699 = _696;
        }
        else
        {
            float3 _627;
            float _628;
            float _629;
            do
            {
                if (length(_193 - _25_m32[2].xyz) > _25_m33[2].x)
                {
                    _627 = _580;
                    _628 = _581;
                    _629 = _582;
                    break;
                }
                float2 _601 = _193.xz - _25_m32[2].xz;
                float _602 = length(_601);
                float _605 = _602 / _25_m33[2].w;
                float _610 = clamp(_602 / _25_m33[2].x, 0.0f, 1.0f);
                float2 _620 = (_601 / _602.xx) * (((-2.0f) * _25_m34[2].z) + 1.0f);
                _627 = _580 + float3(_620.x, 0.0f, _620.y);
                _628 = _581 + _25_m35[2].y;
                _629 = _582 + (((_25_m33[2].z * clamp(_605 * _605, 0.0f, 1.0f)) * (1.0f - (_610 * _610))) * step(_25_m33[2].y, dot(_601, _25_m34[2].xy) / _602));
                break;
            } while(false);
            _697 = _627;
            _698 = _628;
            _699 = _629;
        }
        _700 = _697;
        _701 = _698;
        _702 = _699;
    }
    else
    {
        _700 = _580;
        _701 = _581;
        _702 = _582;
    }
    bool _703 = _25_m36.x > 3.0f;
    float3 _820;
    float _821;
    float _822;
    [branch]
    if (_703)
    {
        float3 _817;
        float _818;
        float _819;
        [branch]
        if (_25_m35[3].x != 0.0f)
        {
            float3 _814;
            float _815;
            float _816;
            do
            {
                float2 _754 = _193.xz - _25_m32[3].xz;
                float _755 = dot(_754, _25_m34[3].xy);
                float _756 = dot(_754, _306);
                float _762 = abs(_28_m0[uint(VSglXInstanceIndex)]._m0[1].w - _25_m32[3].y);
                if (_25_m34[3].w != 0.0f)
                {
                    if (((abs(_755) > _25_m33[3].x) || (abs(_756) > _25_m33[3].y)) || (_762 > _25_m32[3].w))
                    {
                        _814 = _700;
                        _815 = _701;
                        _816 = _702;
                        break;
                    }
                }
                else
                {
                    if ((((_755 > _25_m33[3].x) || (_755 < 0.0f)) || (abs(_756) > _25_m33[3].y)) || (_762 > _25_m32[3].w))
                    {
                        _814 = _700;
                        _815 = _701;
                        _816 = _702;
                        break;
                    }
                }
                float _788 = clamp(abs(_755) / _25_m33[3].x, 0.0f, 1.0f);
                float _798 = _788 / _25_m33[3].w;
                float2 _807 = (_25_m34[3].xy * float((_755 > 0.0f) ? 1 : (-1))) * (((-2.0f) * _25_m34[3].z) + 1.0f);
                _814 = _700 + float3(_807.x, 0.0f, _807.y);
                _815 = _701 + _25_m35[3].y;
                _816 = _702 + ((_25_m33[3].z * clamp(_798 * _798, 0.0f, 1.0f)) * min(clamp(2.0f - (2.0f * _788), 0.0f, 1.0f), clamp(2.0f - (2.0f * clamp(abs(_756) / _25_m33[3].y, 0.0f, 1.0f)), 0.0f, 1.0f)));
                break;
            } while(false);
            _817 = _814;
            _818 = _815;
            _819 = _816;
        }
        else
        {
            float3 _747;
            float _748;
            float _749;
            do
            {
                if (length(_193 - _25_m32[3].xyz) > _25_m33[3].x)
                {
                    _747 = _700;
                    _748 = _701;
                    _749 = _702;
                    break;
                }
                float2 _721 = _193.xz - _25_m32[3].xz;
                float _722 = length(_721);
                float _725 = _722 / _25_m33[3].w;
                float _730 = clamp(_722 / _25_m33[3].x, 0.0f, 1.0f);
                float2 _740 = (_721 / _722.xx) * (((-2.0f) * _25_m34[3].z) + 1.0f);
                _747 = _700 + float3(_740.x, 0.0f, _740.y);
                _748 = _701 + _25_m35[3].y;
                _749 = _702 + (((_25_m33[3].z * clamp(_725 * _725, 0.0f, 1.0f)) * (1.0f - (_730 * _730))) * step(_25_m33[3].y, dot(_721, _25_m34[3].xy) / _722));
                break;
            } while(false);
            _817 = _747;
            _818 = _748;
            _819 = _749;
        }
        _820 = _817;
        _821 = _818;
        _822 = _819;
    }
    else
    {
        _820 = _700;
        _821 = _701;
        _822 = _702;
    }
    float _831 = _822 * 0.100000001490116119384765625f;
    float _840 = 1.0f - _831;
    float3 _852 = _189 + (((float3(_25_m25.z, 0.0f, _25_m25.w) * (_25_m25.x * ((((lerp(_331.x, _333, clamp((_25_m25.x * 0.5f) - 0.5f, 0.0f, 1.0f)) - 0.5f) * (_39_m16 * (1.0f - ((_320 * _320) * _320)))) * 0.699999988079071044921875f) + ((_39_m17 * (_319 * _319)) * 0.070000000298023223876953125f)))) * _345) + (_820 * ((((0.20000000298023223876953125f * (_39_m17 * clamp(_831, 0.0f, 1.0f))) + (((sin(((_39_m31 * _821) * 12.0f) + (((0.20000000298023223876953125f * _333) + dot(float2(-_820.x, -_820.z), _318)) * 25.1327419281005859375f)) * _39_m16) * (1.0f - ((_840 * _840) * _840))) * 0.100000001490116119384765625f)) * _822) * _218)));
    float3 _853 = _852 - _212;
    float _859 = length(_189 - _212);
    float3 _980;
    do
    {
        float2 _876 = (_317 - _25_m41.xz) * 0.03125f.xx;
        float2 _878 = abs(_876);
        if (any(bool2(_878.x > 0.5f.xx.x, _878.y > 0.5f.xx.y)))
        {
            _980 = 0.0f.xxx;
            break;
        }
        float4 _885 = _35.SampleLevel(_30, _876 + 0.5f.xx, 0.0f);
        float _886 = _885.x;
        if (_886 > 0.9900000095367431640625f)
        {
            _980 = 0.0f.xxx;
            break;
        }
        float4 _895 = ((float4(_886, _885.y, 0.0f, 1.0f) - 0.5f.xxxx) * 10.0f.xxxx) + _25_m41.yyyy;
        float _896 = _212.y;
        float _897 = _895.x;
        if ((_896 > ((_897 + _25_m31.x) + 0.20000000298023223876953125f)) || (_896 < (_897 - 0.5f)))
        {
            _980 = 0.0f.xxx;
            break;
        }
        float4 _921 = ((float4(_885.yy, _35.SampleLevel(_30, _876 + float2(0.50390625f, 0.5f), 0.0f).y, _35.SampleLevel(_30, _876 + float2(0.5f, 0.50390625f), 0.0f).y) - 0.5f.xxxx) * 10.0f.xxxx) + _25_m41.yyyy;
        float3 _929 = normalize(float3(_921.z - _921.y, 0.001000000047497451305389404296875f, _921.w - _921.x));
        float3 _932 = frac(_212.xzx * 0.103100001811981201171875f);
        float3 _937 = _932 + dot(_932, _932.yzx + 33.3300018310546875f.xxx).xxx;
        float _949 = clamp(((_895.y - _897) / (_39_m29 + frac((_937.x + _937.y) * _937.z))) * 2.0f, 0.0f, 1.0f);
        float _950 = 1.0f - _949;
        float _956 = _188.y;
        float _958 = max(_956 - _897, 0.0f);
        float3 _962 = _189;
        _962.y = _956 - ((_958 * _39_m30) * _950);
        float3 _970 = (_962 + (((float3(_929.x, 0.0f, _929.z) * ((cos((_949 * _39_m28) * _39_m29) * _950) * _950)) * _958) * _39_m27)) - _212;
        _980 = (_212 + ((_970 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(_970, _970)))) * length(_962 - _212))) - _189;
        break;
    } while(false);
    float _1024 = _25_m37.x * 0.20000000298023223876953125f;
    float _1025 = 1.0f - _1024;
    float4 _1036 = _37.SampleLevel(_32, _318 + (_25_m26.zw * _39_m31), 0.0f);
    float _1038 = _1036.y;
    float3 _1161;
    float _1162;
    float _1163;
    [branch]
    if (_349)
    {
        float3 _1158;
        float _1159;
        float _1160;
        [branch]
        if (_25_m35[0].x != 0.0f)
        {
            float3 _1155;
            float _1156;
            float _1157;
            do
            {
                float2 _1098 = _193.xz - _25_m32[0].xz;
                float _1099 = dot(_1098, _25_m34[0].xy);
                float _1100 = dot(_1098, _264);
                float _1106 = abs(_28_m0[uint(VSglXInstanceIndex)]._m0[1].w - _25_m32[0].y);
                if (_25_m34[0].w != 0.0f)
                {
                    if (((abs(_1099) > _25_m39[0].x) || (abs(_1100) > _25_m39[0].y)) || (_1106 > _25_m32[0].w))
                    {
                        _1155 = 0.0f.xxx;
                        _1156 = 0.0f;
                        _1157 = 0.0f;
                        break;
                    }
                }
                else
                {
                    if ((((_1099 > _25_m39[0].x) || (_1099 < 0.0f)) || (abs(_1100) > _25_m39[0].y)) || (_1106 > _25_m32[0].w))
                    {
                        _1155 = 0.0f.xxx;
                        _1156 = 0.0f;
                        _1157 = 0.0f;
                        break;
                    }
                }
                float _1132 = clamp(abs(_1099) / _25_m39[0].x, 0.0f, 1.0f);
                float _1142 = _1132 / _25_m39[0].w;
                float2 _1151 = (_25_m34[0].xy * float((_1099 > 0.0f) ? 1 : (-1))) * (((-2.0f) * _25_m34[0].z) + 1.0f);
                _1155 = float3(_1151.x, 0.0f, _1151.y);
                _1156 = _25_m40[0].y;
                _1157 = (_25_m39[0].z * clamp(_1142 * _1142, 0.0f, 1.0f)) * min(clamp(2.0f - (2.0f * _1132), 0.0f, 1.0f), clamp(2.0f - (2.0f * clamp(abs(_1100) / _25_m39[0].y, 0.0f, 1.0f)), 0.0f, 1.0f));
                break;
            } while(false);
            _1158 = _1155;
            _1159 = _1156;
            _1160 = _1157;
        }
        else
        {
            float3 _1091;
            float _1092;
            float _1093;
            do
            {
                if (length(_193 - _25_m32[0].xyz) > _25_m39[0].x)
                {
                    _1091 = 0.0f.xxx;
                    _1092 = 0.0f;
                    _1093 = 0.0f;
                    break;
                }
                float2 _1068 = _193.xz - _25_m32[0].xz;
                float _1069 = length(_1068);
                float _1072 = _1069 / _25_m39[0].w;
                float _1077 = clamp(_1069 / _25_m39[0].x, 0.0f, 1.0f);
                float2 _1087 = (_1068 / _1069.xx) * (((-2.0f) * _25_m34[0].z) + 1.0f);
                _1091 = float3(_1087.x, 0.0f, _1087.y);
                _1092 = _25_m40[0].y;
                _1093 = ((_25_m39[0].z * clamp(_1072 * _1072, 0.0f, 1.0f)) * (1.0f - (_1077 * _1077))) * step(_25_m39[0].y, dot(_1068, _25_m34[0].xy) / _1069);
                break;
            } while(false);
            _1158 = _1091;
            _1159 = _1092;
            _1160 = _1093;
        }
        _1161 = _1158;
        _1162 = _1159;
        _1163 = _1160;
    }
    else
    {
        _1161 = 0.0f.xxx;
        _1162 = 0.0f;
        _1163 = 0.0f;
    }
    float3 _1280;
    float _1281;
    float _1282;
    [branch]
    if (_463)
    {
        float3 _1277;
        float _1278;
        float _1279;
        [branch]
        if (_25_m35[1].x != 0.0f)
        {
            float3 _1274;
            float _1275;
            float _1276;
            do
            {
                float2 _1214 = _193.xz - _25_m32[1].xz;
                float _1215 = dot(_1214, _25_m34[1].xy);
                float _1216 = dot(_1214, _278);
                float _1222 = abs(_28_m0[uint(VSglXInstanceIndex)]._m0[1].w - _25_m32[1].y);
                if (_25_m34[1].w != 0.0f)
                {
                    if (((abs(_1215) > _25_m39[1].x) || (abs(_1216) > _25_m39[1].y)) || (_1222 > _25_m32[1].w))
                    {
                        _1274 = _1161;
                        _1275 = _1162;
                        _1276 = _1163;
                        break;
                    }
                }
                else
                {
                    if ((((_1215 > _25_m39[1].x) || (_1215 < 0.0f)) || (abs(_1216) > _25_m39[1].y)) || (_1222 > _25_m32[1].w))
                    {
                        _1274 = _1161;
                        _1275 = _1162;
                        _1276 = _1163;
                        break;
                    }
                }
                float _1248 = clamp(abs(_1215) / _25_m39[1].x, 0.0f, 1.0f);
                float _1258 = _1248 / _25_m39[1].w;
                float2 _1267 = (_25_m34[1].xy * float((_1215 > 0.0f) ? 1 : (-1))) * (((-2.0f) * _25_m34[1].z) + 1.0f);
                _1274 = _1161 + float3(_1267.x, 0.0f, _1267.y);
                _1275 = _1162 + _25_m40[1].y;
                _1276 = _1163 + ((_25_m39[1].z * clamp(_1258 * _1258, 0.0f, 1.0f)) * min(clamp(2.0f - (2.0f * _1248), 0.0f, 1.0f), clamp(2.0f - (2.0f * clamp(abs(_1216) / _25_m39[1].y, 0.0f, 1.0f)), 0.0f, 1.0f)));
                break;
            } while(false);
            _1277 = _1274;
            _1278 = _1275;
            _1279 = _1276;
        }
        else
        {
            float3 _1207;
            float _1208;
            float _1209;
            do
            {
                if (length(_193 - _25_m32[1].xyz) > _25_m39[1].x)
                {
                    _1207 = _1161;
                    _1208 = _1162;
                    _1209 = _1163;
                    break;
                }
                float2 _1181 = _193.xz - _25_m32[1].xz;
                float _1182 = length(_1181);
                float _1185 = _1182 / _25_m39[1].w;
                float _1190 = clamp(_1182 / _25_m39[1].x, 0.0f, 1.0f);
                float2 _1200 = (_1181 / _1182.xx) * (((-2.0f) * _25_m34[1].z) + 1.0f);
                _1207 = _1161 + float3(_1200.x, 0.0f, _1200.y);
                _1208 = _1162 + _25_m40[1].y;
                _1209 = _1163 + (((_25_m39[1].z * clamp(_1185 * _1185, 0.0f, 1.0f)) * (1.0f - (_1190 * _1190))) * step(_25_m39[1].y, dot(_1181, _25_m34[1].xy) / _1182));
                break;
            } while(false);
            _1277 = _1207;
            _1278 = _1208;
            _1279 = _1209;
        }
        _1280 = _1277;
        _1281 = _1278;
        _1282 = _1279;
    }
    else
    {
        _1280 = _1161;
        _1281 = _1162;
        _1282 = _1163;
    }
    float3 _1399;
    float _1400;
    float _1401;
    [branch]
    if (_583)
    {
        float3 _1396;
        float _1397;
        float _1398;
        [branch]
        if (_25_m35[2].x != 0.0f)
        {
            float3 _1393;
            float _1394;
            float _1395;
            do
            {
                float2 _1333 = _193.xz - _25_m32[2].xz;
                float _1334 = dot(_1333, _25_m34[2].xy);
                float _1335 = dot(_1333, _292);
                float _1341 = abs(_28_m0[uint(VSglXInstanceIndex)]._m0[1].w - _25_m32[2].y);
                if (_25_m34[2].w != 0.0f)
                {
                    if (((abs(_1334) > _25_m39[2].x) || (abs(_1335) > _25_m39[2].y)) || (_1341 > _25_m32[2].w))
                    {
                        _1393 = _1280;
                        _1394 = _1281;
                        _1395 = _1282;
                        break;
                    }
                }
                else
                {
                    if ((((_1334 > _25_m39[2].x) || (_1334 < 0.0f)) || (abs(_1335) > _25_m39[2].y)) || (_1341 > _25_m32[2].w))
                    {
                        _1393 = _1280;
                        _1394 = _1281;
                        _1395 = _1282;
                        break;
                    }
                }
                float _1367 = clamp(abs(_1334) / _25_m39[2].x, 0.0f, 1.0f);
                float _1377 = _1367 / _25_m39[2].w;
                float2 _1386 = (_25_m34[2].xy * float((_1334 > 0.0f) ? 1 : (-1))) * (((-2.0f) * _25_m34[2].z) + 1.0f);
                _1393 = _1280 + float3(_1386.x, 0.0f, _1386.y);
                _1394 = _1281 + _25_m40[2].y;
                _1395 = _1282 + ((_25_m39[2].z * clamp(_1377 * _1377, 0.0f, 1.0f)) * min(clamp(2.0f - (2.0f * _1367), 0.0f, 1.0f), clamp(2.0f - (2.0f * clamp(abs(_1335) / _25_m39[2].y, 0.0f, 1.0f)), 0.0f, 1.0f)));
                break;
            } while(false);
            _1396 = _1393;
            _1397 = _1394;
            _1398 = _1395;
        }
        else
        {
            float3 _1326;
            float _1327;
            float _1328;
            do
            {
                if (length(_193 - _25_m32[2].xyz) > _25_m39[2].x)
                {
                    _1326 = _1280;
                    _1327 = _1281;
                    _1328 = _1282;
                    break;
                }
                float2 _1300 = _193.xz - _25_m32[2].xz;
                float _1301 = length(_1300);
                float _1304 = _1301 / _25_m39[2].w;
                float _1309 = clamp(_1301 / _25_m39[2].x, 0.0f, 1.0f);
                float2 _1319 = (_1300 / _1301.xx) * (((-2.0f) * _25_m34[2].z) + 1.0f);
                _1326 = _1280 + float3(_1319.x, 0.0f, _1319.y);
                _1327 = _1281 + _25_m40[2].y;
                _1328 = _1282 + (((_25_m39[2].z * clamp(_1304 * _1304, 0.0f, 1.0f)) * (1.0f - (_1309 * _1309))) * step(_25_m39[2].y, dot(_1300, _25_m34[2].xy) / _1301));
                break;
            } while(false);
            _1396 = _1326;
            _1397 = _1327;
            _1398 = _1328;
        }
        _1399 = _1396;
        _1400 = _1397;
        _1401 = _1398;
    }
    else
    {
        _1399 = _1280;
        _1400 = _1281;
        _1401 = _1282;
    }
    float3 _1518;
    float _1519;
    float _1520;
    [branch]
    if (_703)
    {
        float3 _1515;
        float _1516;
        float _1517;
        [branch]
        if (_25_m35[3].x != 0.0f)
        {
            float3 _1512;
            float _1513;
            float _1514;
            do
            {
                float2 _1452 = _193.xz - _25_m32[3].xz;
                float _1453 = dot(_1452, _25_m34[3].xy);
                float _1454 = dot(_1452, _306);
                float _1460 = abs(_28_m0[uint(VSglXInstanceIndex)]._m0[1].w - _25_m32[3].y);
                if (_25_m34[3].w != 0.0f)
                {
                    if (((abs(_1453) > _25_m39[3].x) || (abs(_1454) > _25_m39[3].y)) || (_1460 > _25_m32[3].w))
                    {
                        _1512 = _1399;
                        _1513 = _1400;
                        _1514 = _1401;
                        break;
                    }
                }
                else
                {
                    if ((((_1453 > _25_m39[3].x) || (_1453 < 0.0f)) || (abs(_1454) > _25_m39[3].y)) || (_1460 > _25_m32[3].w))
                    {
                        _1512 = _1399;
                        _1513 = _1400;
                        _1514 = _1401;
                        break;
                    }
                }
                float _1486 = clamp(abs(_1453) / _25_m39[3].x, 0.0f, 1.0f);
                float _1496 = _1486 / _25_m39[3].w;
                float2 _1505 = (_25_m34[3].xy * float((_1453 > 0.0f) ? 1 : (-1))) * (((-2.0f) * _25_m34[3].z) + 1.0f);
                _1512 = _1399 + float3(_1505.x, 0.0f, _1505.y);
                _1513 = _1400 + _25_m40[3].y;
                _1514 = _1401 + ((_25_m39[3].z * clamp(_1496 * _1496, 0.0f, 1.0f)) * min(clamp(2.0f - (2.0f * _1486), 0.0f, 1.0f), clamp(2.0f - (2.0f * clamp(abs(_1454) / _25_m39[3].y, 0.0f, 1.0f)), 0.0f, 1.0f)));
                break;
            } while(false);
            _1515 = _1512;
            _1516 = _1513;
            _1517 = _1514;
        }
        else
        {
            float3 _1445;
            float _1446;
            float _1447;
            do
            {
                if (length(_193 - _25_m32[3].xyz) > _25_m39[3].x)
                {
                    _1445 = _1399;
                    _1446 = _1400;
                    _1447 = _1401;
                    break;
                }
                float2 _1419 = _193.xz - _25_m32[3].xz;
                float _1420 = length(_1419);
                float _1423 = _1420 / _25_m39[3].w;
                float _1428 = clamp(_1420 / _25_m39[3].x, 0.0f, 1.0f);
                float2 _1438 = (_1419 / _1420.xx) * (((-2.0f) * _25_m34[3].z) + 1.0f);
                _1445 = _1399 + float3(_1438.x, 0.0f, _1438.y);
                _1446 = _1400 + _25_m40[3].y;
                _1447 = _1401 + (((_25_m39[3].z * clamp(_1423 * _1423, 0.0f, 1.0f)) * (1.0f - (_1428 * _1428))) * step(_25_m39[3].y, dot(_1419, _25_m34[3].xy) / _1420));
                break;
            } while(false);
            _1515 = _1445;
            _1516 = _1446;
            _1517 = _1447;
        }
        _1518 = _1515;
        _1519 = _1516;
        _1520 = _1517;
    }
    else
    {
        _1518 = _1399;
        _1519 = _1400;
        _1520 = _1401;
    }
    float _1529 = _1520 * 0.100000001490116119384765625f;
    float _1538 = 1.0f - _1529;
    float3 _1550 = _189 + (((float3(_25_m37.z, 0.0f, _25_m37.w) * (_25_m37.x * ((((lerp(_1036.x, _1038, clamp((_25_m37.x * 0.5f) - 0.5f, 0.0f, 1.0f)) - 0.5f) * (_39_m16 * (1.0f - ((_1025 * _1025) * _1025)))) * 0.699999988079071044921875f) + ((_39_m17 * (_1024 * _1024)) * 0.070000000298023223876953125f)))) * _345) + (_1518 * ((((0.20000000298023223876953125f * (_39_m17 * clamp(_1529, 0.0f, 1.0f))) + (((sin(((_39_m31 * _1519) * 12.0f) + (((0.20000000298023223876953125f * _1038) + dot(float2(-_1518.x, -_1518.z), _318)) * 25.1327419281005859375f)) * _39_m16) * (1.0f - ((_1538 * _1538) * _1538))) * 0.100000001490116119384765625f)) * _1520) * _218)));
    float3 _1551 = _1550 - _212;
    float3 _1668;
    do
    {
        float2 _1564 = (_317 - _25_m42.xz) * 0.03125f.xx;
        float2 _1566 = abs(_1564);
        if (any(bool2(_1566.x > 0.5f.xx.x, _1566.y > 0.5f.xx.y)))
        {
            _1668 = 0.0f.xxx;
            break;
        }
        float4 _1573 = _36.SampleLevel(_30, _1564 + 0.5f.xx, 0.0f);
        float _1574 = _1573.x;
        if (_1574 > 0.9900000095367431640625f)
        {
            _1668 = 0.0f.xxx;
            break;
        }
        float4 _1583 = ((float4(_1574, _1573.y, 0.0f, 1.0f) - 0.5f.xxxx) * 10.0f.xxxx) + _25_m42.yyyy;
        float _1584 = _212.y;
        float _1585 = _1583.x;
        if ((_1584 > ((_1585 + _25_m31.x) + 0.20000000298023223876953125f)) || (_1584 < (_1585 - 0.5f)))
        {
            _1668 = 0.0f.xxx;
            break;
        }
        float4 _1609 = ((float4(_1573.yy, _36.SampleLevel(_30, _1564 + float2(0.50390625f, 0.5f), 0.0f).y, _36.SampleLevel(_30, _1564 + float2(0.5f, 0.50390625f), 0.0f).y) - 0.5f.xxxx) * 10.0f.xxxx) + _25_m42.yyyy;
        float3 _1617 = normalize(float3(_1609.z - _1609.y, 0.001000000047497451305389404296875f, _1609.w - _1609.x));
        float3 _1620 = frac(_212.xzx * 0.103100001811981201171875f);
        float3 _1625 = _1620 + dot(_1620, _1620.yzx + 33.3300018310546875f.xxx).xxx;
        float _1637 = clamp(((_1583.y - _1585) / (_39_m29 + frac((_1625.x + _1625.y) * _1625.z))) * 2.0f, 0.0f, 1.0f);
        float _1638 = 1.0f - _1637;
        float _1644 = _188.y;
        float _1646 = max(_1644 - _1585, 0.0f);
        float3 _1650 = _189;
        _1650.y = _1644 - ((_1646 * _39_m30) * _1638);
        float3 _1658 = (_1650 + (((float3(_1617.x, 0.0f, _1617.z) * ((cos((_1637 * _39_m28) * _39_m29) * _1638) * _1638)) * _1646) * _39_m27)) - _212;
        _1668 = (_212 + ((_1658 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(_1658, _1658)))) * length(_1650 - _212))) - _189;
        break;
    } while(false);
    float3 _1678 = float3(_23_m1[0].y, 0.0f, _23_m1[2].y) * (VSX3.y * _39_m6);
    float2 _1686 = abs(_188.xz - _25_m132.zw);
    float2 _1689 = _25_m131.x.xx;
    float3 _1736;
    float2 _1737;
    if (any(bool2(_1686.x > _1689.x, _1686.y > _1689.y)))
    {
        _1736 = VSX3;
        _1737 = 0.0f.xx;
    }
    else
    {
        float _1699 = _25_m131.x * 2.0f;
        float4 _1712 = _34.SampleLevel(_31, float2(((_188.x - _25_m132.z) / _1699) + 0.5f, ((_188.z - _25_m132.w) / _1699) + 0.5f), 0.0f);
        float _1713 = _1712.x;
        bool _1714 = _1713 > 0.0f;
        float _1718 = _1714 ? _25_m131.z : (1.0f - _25_m131.z);
        float2 _1719 = float2(1.0f, 0.0f);
        _1719.y = _1718;
        float _1720 = _1712.y;
        bool _1722 = _1714 && (_1720 > 0.0f);
        float2 _1733;
        if (_1722)
        {
            _1733 = _1719;
        }
        else
        {
            float2 _1732;
            if ((_1713 == 0.0f) && (_1720 == 0.0f))
            {
                _1732 = float2(0.0f, _1718);
            }
            else
            {
                _1732 = _1719;
            }
            _1733 = _1732;
        }
        bool3 _1734 = _1722.xxx;
        _1736 = float3(_1734.x ? asfloat(0x7fc00000u /* nan */).xxx.x : VSX3.x, _1734.y ? asfloat(0x7fc00000u /* nan */).xxx.y : VSX3.y, _1734.z ? asfloat(0x7fc00000u /* nan */).xxx.z : VSX3.z);
        _1737 = _1733;
    }
    float _1740 = 1.0f - _21_m4;
    uint _1745 = asuint(VSX4.x);
    bool _1747 = (_1745 & 1073741824u) > 0u;
    float4 _1820;
    float3 _1821;
    if (_1747)
    {
        float _1753 = float((_1745 << 22u) >> 22u);
        float _1756 = float((_1745 << 12u) >> 22u);
        float _1759 = float((_1745 << 2u) >> 22u);
        float3 _1773 = float3((_1753 >= 512.0f) ? (_1753 - 1024.0f) : _1753, (_1756 >= 512.0f) ? (_1756 - 1024.0f) : _1756, 0.0f) * 0.001956947147846221923828125f;
        float _1779 = (1.0f - abs(_1773.x)) - abs(_1773.y);
        float3 _1780 = _1773;
        _1780.z = _1779;
        bool2 _1782 = (_1779 < 0.0f).xx;
        float2 _1790 = (1.0f.xx - abs(_1780.yx)) * ((step(0.0f.xx, _1780.xy) * 2.0f) - 1.0f.xx);
        float2 _1791 = float2(_1782.x ? _1790.x : _1780.xy.x, _1782.y ? _1790.y : _1780.xy.y);
        float3 _1793 = normalize(float3(_1791.x, _1791.y, _1780.z));
        float _1794 = ((_1759 >= 512.0f) ? (_1759 - 1024.0f) : _1759) * 0.001956947147846221923828125f;
        float3 _1797 = _1793.yzx - _1793.zxy;
        float3 _1801 = normalize(_1797 - dot(_1797, _1793).xxx);
        float _1806 = (_1794 < 0.0f) ? (-1.0f) : 1.0f;
        float _1809 = 1.0f - ((_1794 * _1806) * 2.0f);
        float3 _1815 = mul(normalize(float2(_1809, _1806 * (1.0f - abs(_1809)))), float2x3(_1801, normalize(cross(_1793, _1801))));
        float4 _1816 = float4(_1815.x, _1815.y, _1815.z, 1.0f);
        _1816.w = (float((_1745 >> 31u) & 1u) * 2.0f) - 1.0f;
        _1820 = _1816;
        _1821 = _1793;
    }
    else
    {
        _1820 = 0.0f.xxxx;
        _1821 = VSX4;
    }
    bool4 _1822 = _1747.xxxx;
    float4 _1823 = float4(_1822.x ? _1820.x : VSX5.x, _1822.y ? _1820.y : VSX5.y, _1822.z ? _1820.z : VSX5.z, _1822.w ? _1820.w : VSX5.w);
    float3x3 _1830 = float3x3(_28_m0[uint(VSglXInstanceIndex)]._m0[0].xyz, _28_m0[uint(VSglXInstanceIndex)]._m0[1].xyz, _28_m0[uint(VSglXInstanceIndex)]._m0[2].xyz);
    float3 _1838 = mul(_1830, _1821);
    float3 _1844 = mul(_1830, _1823.xyz);
    float4 _1860 = mul(_23_m8, float4((mul(_1830, _1736) + (_193 - _23_m11.xyz)) + (((((_212 + ((_853 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(_853, _853)))) * _859)) - _189) + _980) + _1678) * _1740), 1.0f));
    float2 _1868 = _1860.xy - ((_25_m9.zw * float2(2.0f, -2.0f)) * _1860.w);
    float4 _1869 = float4(_1868.x, _1868.y, _1860.z, _1860.w);
    float4 _1882 = float4((mul(_1830, _1736.xyz) + (_193 - _23_m21.xyz)) + (((((_212 + ((_1551 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(_1551, _1551)))) * _859)) - _189) + _1668) + _1678) * _1740), 1.0f);
    float _1890 = _23_m11.y - _28_m0[uint(VSglXInstanceIndex)]._m0[1].w;
    float2 _1900 = abs(float2(_28_m0[uint(VSglXInstanceIndex)]._m0[0].w - _23_m11.x, _28_m0[uint(VSglXInstanceIndex)]._m0[2].w - _23_m11.z));
    float2 _1901 = (_1890 * 0.19885681569576263427734375f).xx;
    bool4 _1905 = ((_1890 > 80.0f) && all(bool2(_1900.x < _1901.x, _1900.y < _1901.y))).xxxx;
    float4 _1906 = float4(_1905.x ? asfloat(0x7fc00000u /* nan */).xxxx.x : _1869.x, _1905.y ? asfloat(0x7fc00000u /* nan */).xxxx.y : _1869.y, _1905.z ? asfloat(0x7fc00000u /* nan */).xxxx.z : _1869.z, _1905.w ? asfloat(0x7fc00000u /* nan */).xxxx.w : _1869.w);
    _1906.y = -_1906.y;
    VSglXPosition = _1906;
    VSX12 = VSX7;
    VSX14 = _1838 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(_1838, _1838)));
    VSX15 = float4(_1844 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(_1844, _1844))), _1823.w);
    VSX16 = _1860.xyw;
    VSX17 = mul(_23_m15, float4(_1882.x, _1882.y, _1882.z, _1882.w)).xyw;
    VSX18 = _1736;
    VSX19 = uint(VSglXInstanceIndex);
}

EID3863Varyings EID3863VSGeneratedMain(EID3863VSInputInternal stage_input)
{
    VSglXInstanceIndex = int(stage_input.VSglXInstanceIndex);
    VSX3 = stage_input.VSX3;
    VSX4 = stage_input.VSX4;
    VSX5 = stage_input.VSX5;
    VSX6 = stage_input.VSX6;
    VSX7 = stage_input.VSX7;
    VSX8 = stage_input.VSX8;
    VSX9 = stage_input.VSX9;
    vert_main();
    SPIRV_Cross_Output stage_output;
    stage_output.VSglXPosition = VSglXPosition;
    stage_output.VSX12 = VSX12;
    stage_output.VSX14 = VSX14;
    stage_output.VSX15 = VSX15;
    stage_output.VSX16 = VSX16;
    stage_output.VSX17 = VSX17;
    stage_output.VSX18 = VSX18;
    stage_output.VSX19 = VSX19;
    return stage_output;
}

struct EID3863VertexInput { float3 position : POSITION; float3 normal : NORMAL; float4 tangent : TANGENT; float4 color : COLOR; float2 uv0 : TEXCOORD0; float2 uv1 : TEXCOORD1; float2 uv2 : TEXCOORD2; uint instanceID : SV_InstanceID; };
EID3863Varyings EID3863VertexMain(EID3863VertexInput i) { EID3863VSInputInternal x; x_3=i.position; x_4=i.normal; x_5=i.tangent; x_6=i.color; x_7=i.uv0; x_8=i.uv1; x_9=i.uv2; x.VSglXInstanceIndex=i.instanceID; return EID3863VSGeneratedMain(x); }
