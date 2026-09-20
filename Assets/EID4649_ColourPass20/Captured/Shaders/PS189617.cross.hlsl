static float _255;

static const float2 _251[16] = { float2(-0.94201624393463134765625f, -0.39906215667724609375f), float2(0.94558608531951904296875f, -0.768907248973846435546875f), float2(-0.094184100627899169921875f, -0.929388701915740966796875f), float2(0.34495937824249267578125f, 0.29387760162353515625f), float2(-0.91588580608367919921875f, 0.4577143192291259765625f), float2(-0.8154423236846923828125f, -0.87912464141845703125f), float2(-0.38277542591094970703125f, 0.2767684459686279296875f), float2(0.9748439788818359375f, 0.7564837932586669921875f), float2(0.4432332515716552734375f, -0.9751155376434326171875f), float2(0.5374298095703125f, -0.473734200000762939453125f), float2(-0.2649691104888916015625f, -0.418930232524871826171875f), float2(0.79197514057159423828125f, 0.19090187549591064453125f), float2(-0.24188840389251708984375f, 0.997065067291259765625f), float2(-0.8140995502471923828125f, 0.91437590122222900390625f), float2(0.1998412609100341796875f, 0.786413669586181640625f), float2(0.14383161067962646484375f, -0.141007900238037109375f) };
static const float2 _252[16] = { float2(-0.3996559083461761474609375f, 0.91666519641876220703125f), float2(0.12451229989528656005859375f, -0.992218077182769775390625f), float2(0.8523542881011962890625f, 0.5229647159576416015625f), float2(-0.22931249439716339111328125f, 0.973352909088134765625f), float2(-0.772406101226806640625f, 0.63512897491455078125f), float2(0.7927525043487548828125f, -0.60954368114471435546875f), float2(-0.578049719333648681640625f, 0.816001594066619873046875f), float2(-0.831129610538482666015625f, -0.55607879161834716796875f), float2(0.8077948093414306640625f, 0.589463770389556884765625f), float2(0.47141540050506591796875f, 0.88191127777099609375f), float2(-0.3139738142490386962890625f, -0.949431717395782470703125f), float2(-0.94500672817230224609375f, -0.3270510137081146240234375f), float2(-0.1850374042987823486328125f, -0.982731521129608154296875f), float2(-0.9337558746337890625f, 0.35791051387786865234375f), float2(-0.997614085674285888671875f, 0.069036297500133514404296875f), float2(0.3061277866363525390625f, 0.951990425586700439453125f) };
static const float4 _253[4] = { float4(1.0f, 0.0f, 0.0f, 0.0f), float4(0.0f, 1.0f, 0.0f, 0.0f), float4(0.0f, 0.0f, 1.0f, 0.0f), float4(0.0f, 0.0f, 0.0f, 1.0f) };

cbuffer _5_6 : register(b10)
{
    column_major float4x4 _6_m0 : packoffset(c0);
    column_major float4x4 _6_m1 : packoffset(c4);
    column_major float4x4 _6_m2 : packoffset(c8);
    column_major float4x4 _6_m3 : packoffset(c12);
    column_major float4x4 _6_m4 : packoffset(c16);
    column_major float4x4 _6_m5 : packoffset(c20);
    column_major float4x4 _6_m6 : packoffset(c24);
    column_major float4x4 _6_m7 : packoffset(c28);
    column_major float4x4 _6_m8 : packoffset(c32);
    column_major float4x4 _6_m9 : packoffset(c36);
    column_major float4x4 _6_m10 : packoffset(c40);
    float4 _6_m11 : packoffset(c44);
    column_major float4x4 _6_m12 : packoffset(c45);
    column_major float4x4 _6_m13 : packoffset(c49);
    column_major float4x4 _6_m14 : packoffset(c53);
    column_major float4x4 _6_m15 : packoffset(c57);
    column_major float4x4 _6_m16 : packoffset(c61);
    column_major float4x4 _6_m17 : packoffset(c65);
    column_major float4x4 _6_m18 : packoffset(c69);
    column_major float4x4 _6_m19 : packoffset(c73);
    column_major float4x4 _6_m20 : packoffset(c77);
    float4 _6_m21 : packoffset(c81);
};

cbuffer _7_8 : register(b13)
{
    float4 _8_m0 : packoffset(c0);
    float4 _8_m1 : packoffset(c1);
    float4 _8_m2 : packoffset(c2);
    float4 _8_m3 : packoffset(c3);
    float4 _8_m4 : packoffset(c4);
    float4 _8_m5 : packoffset(c5);
    float4 _8_m6[6] : packoffset(c6);
    float4 _8_m7[6] : packoffset(c12);
    float4 _8_m8 : packoffset(c18);
    float4 _8_m9 : packoffset(c19);
    float4 _8_m10 : packoffset(c20);
    float4 _8_m11 : packoffset(c21);
    float4 _8_m12 : packoffset(c22);
    float4 _8_m13 : packoffset(c23);
    float4 _8_m14 : packoffset(c24);
    float4 _8_m15 : packoffset(c25);
    float _8_m16 : packoffset(c26);
    float _8_m17 : packoffset(c26.y);
    float _8_m18 : packoffset(c26.z);
    uint _8_m19 : packoffset(c26.w);
    float4 _8_m20 : packoffset(c27);
    int4 _8_m21 : packoffset(c28);
    float4 _8_m22 : packoffset(c29);
    float4 _8_m23 : packoffset(c30);
    float4 _8_m24 : packoffset(c31);
    float4 _8_m25 : packoffset(c32);
    float4 _8_m26 : packoffset(c33);
    float4 _8_m27 : packoffset(c34);
    float4 _8_m28 : packoffset(c35);
    float4 _8_m29 : packoffset(c36);
    float4 _8_m30 : packoffset(c37);
    float4 _8_m31 : packoffset(c38);
    float4 _8_m32[4] : packoffset(c39);
    float4 _8_m33[4] : packoffset(c43);
    float4 _8_m34[4] : packoffset(c47);
    float4 _8_m35[4] : packoffset(c51);
    float4 _8_m36 : packoffset(c55);
    float4 _8_m37 : packoffset(c56);
    float4 _8_m38[4] : packoffset(c57);
    float4 _8_m39[4] : packoffset(c61);
    float4 _8_m40[4] : packoffset(c65);
    float4 _8_m41 : packoffset(c69);
    float4 _8_m42 : packoffset(c70);
    float4 _8_m43 : packoffset(c71);
    float4 _8_m44 : packoffset(c72);
    float4 _8_m45 : packoffset(c73);
    float4 _8_m46 : packoffset(c74);
    float4 _8_m47 : packoffset(c75);
    float4 _8_m48 : packoffset(c76);
    float4 _8_m49 : packoffset(c77);
    float4 _8_m50 : packoffset(c78);
    float4 _8_m51 : packoffset(c79);
    float4 _8_m52 : packoffset(c80);
    float4 _8_m53 : packoffset(c81);
    float4 _8_m54 : packoffset(c82);
    float4 _8_m55 : packoffset(c83);
    float4 _8_m56 : packoffset(c84);
    float4 _8_m57 : packoffset(c85);
    float4 _8_m58 : packoffset(c86);
    float4 _8_m59 : packoffset(c87);
    float4 _8_m60 : packoffset(c88);
    float4 _8_m61 : packoffset(c89);
    float4 _8_m62 : packoffset(c90);
    float4 _8_m63 : packoffset(c91);
    float4 _8_m64 : packoffset(c92);
    float4 _8_m65 : packoffset(c93);
    float4 _8_m66 : packoffset(c94);
    float4 _8_m67 : packoffset(c95);
    float4 _8_m68 : packoffset(c96);
    float4 _8_m69 : packoffset(c97);
    float4 _8_m70 : packoffset(c98);
    float4 _8_m71 : packoffset(c99);
    float4 _8_m72 : packoffset(c100);
    float4 _8_m73 : packoffset(c101);
    float4 _8_m74 : packoffset(c102);
    float4 _8_m75 : packoffset(c103);
    float4 _8_m76 : packoffset(c104);
    float4 _8_m77 : packoffset(c105);
    float4 _8_m78 : packoffset(c106);
    float4 _8_m79 : packoffset(c107);
    float4 _8_m80 : packoffset(c108);
    float4 _8_m81 : packoffset(c109);
    float4 _8_m82 : packoffset(c110);
    float4 _8_m83 : packoffset(c111);
    float4 _8_m84 : packoffset(c112);
    float4 _8_m85 : packoffset(c113);
    float4 _8_m86 : packoffset(c114);
    float4 _8_m87 : packoffset(c115);
    float4 _8_m88 : packoffset(c116);
    float4 _8_m89 : packoffset(c117);
    float4 _8_m90 : packoffset(c118);
    float4 _8_m91 : packoffset(c119);
    float4 _8_m92 : packoffset(c120);
    float4 _8_m93 : packoffset(c121);
    float4 _8_m94 : packoffset(c122);
    float4 _8_m95 : packoffset(c123);
    float4 _8_m96 : packoffset(c124);
    float4 _8_m97 : packoffset(c125);
    float4 _8_m98 : packoffset(c126);
    float4 _8_m99[2] : packoffset(c127);
    float4 _8_m100[2] : packoffset(c129);
    float _8_m101 : packoffset(c131);
    float _8_m102 : packoffset(c131.y);
    float _8_m103 : packoffset(c131.z);
    float _8_m104 : packoffset(c131.w);
    float4 _8_m105 : packoffset(c132);
    float4 _8_m106 : packoffset(c133);
    float4 _8_m107 : packoffset(c134);
    float4 _8_m108 : packoffset(c135);
    float4 _8_m109 : packoffset(c136);
    float4 _8_m110 : packoffset(c137);
    float4 _8_m111 : packoffset(c138);
    float4 _8_m112 : packoffset(c139);
    float4 _8_m113 : packoffset(c140);
    float4 _8_m114 : packoffset(c141);
    float4 _8_m115 : packoffset(c142);
    float4 _8_m116 : packoffset(c143);
    float4 _8_m117 : packoffset(c144);
    float4 _8_m118 : packoffset(c145);
    float4 _8_m119 : packoffset(c146);
    float4 _8_m120 : packoffset(c147);
    float4 _8_m121 : packoffset(c148);
    float4 _8_m122 : packoffset(c149);
    float4 _8_m123 : packoffset(c150);
    float4 _8_m124 : packoffset(c151);
    float4 _8_m125 : packoffset(c152);
    float4 _8_m126 : packoffset(c153);
    float4 _8_m127 : packoffset(c154);
    float4 _8_m128 : packoffset(c155);
    float4 _8_m129 : packoffset(c156);
    float4 _8_m130 : packoffset(c157);
    float4 _8_m131 : packoffset(c158);
    float4 _8_m132 : packoffset(c159);
    float4 _8_m133 : packoffset(c160);
    float4 _8_m134 : packoffset(c161);
    column_major float4x4 _8_m135 : packoffset(c162);
    float4 _8_m136 : packoffset(c166);
    float4 _8_m137 : packoffset(c167);
    float4 _8_m138[32] : packoffset(c168);
};

cbuffer _16_17 : register(b11)
{
    float4 _17_m0 : packoffset(c0);
    float4 _17_m1 : packoffset(c1);
    float4 _17_m2 : packoffset(c2);
    float4 _17_m3 : packoffset(c3);
    float4 _17_m4 : packoffset(c4);
    uint4 _17_m5 : packoffset(c5);
    float4 _17_m6[2048] : packoffset(c6);
};

cbuffer _20_21 : register(b12)
{
    column_major float4x4 _21_m0[5] : packoffset(c0);
    float4 _21_m1[4] : packoffset(c20);
    float4 _21_m2[4] : packoffset(c24);
    float4 _21_m3[4] : packoffset(c28);
    float4 _21_m4 : packoffset(c32);
    float4 _21_m5 : packoffset(c33);
    float4 _21_m6 : packoffset(c34);
    float4 _21_m7 : packoffset(c35);
    float4 _21_m8 : packoffset(c36);
    float4 _21_m9[27] : packoffset(c37);
    column_major float4x4 _21_m10[56] : packoffset(c64);
    float4 _21_m11[56] : packoffset(c288);
    float4 _21_m12[56] : packoffset(c344);
    float4 _21_m13 : packoffset(c400);
    float4 _21_m14[47] : packoffset(c401);
    column_major float4x4 _21_m15[15] : packoffset(c448);
    float4 _21_m16[15] : packoffset(c508);
    float4 _21_m17[15] : packoffset(c523);
    float4 _21_m18[15] : packoffset(c538);
    float4 _21_m19 : packoffset(c553);
    float4 _21_m20 : packoffset(c554);
    float4 _21_m21[21] : packoffset(c555);
    column_major float4x4 _21_m22 : packoffset(c576);
    column_major float4x4 _21_m23 : packoffset(c580);
    float4 _21_m24 : packoffset(c584);
    float4 _21_m25 : packoffset(c585);
    float4 _21_m26 : packoffset(c586);
    float4 _21_m27[128] : packoffset(c587);
};

SamplerState _10 : register(s0);
SamplerState _11 : register(s2);
SamplerState _12 : register(s1);
SamplerComparisonState _13 : register(s3);
Texture2D<float4> _15 : register(t7);
Texture2D<float4> _22 : register(t8);
Texture2D<float4> _23 : register(t6);
Texture2D<float4> _24 : register(t4);
Texture2D<float4> _25 : register(t9);
Texture2D<float4> _27 : register(t5);

static float4 gl_FragCoord;
static float3 _4;

struct SPIRV_Cross_Input
{
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float3 _4 : SV_Target0;
};

uint spvPackHalf2x16(float2 value)
{
    uint2 Packed = f32tof16(value);
    return Packed.x | (Packed.y << 16);
}

float2 spvUnpackHalf2x16(uint value)
{
    return f16tof32(uint2(value & 0xffff, value >> 16));
}

void frag_main()
{
    float2 _262 = float2(uint2(gl_FragCoord.xy));
    float2 _273 = _262 * _8_m0.zw;
    uint2 _274 = uint2(_262);
    float2 _276 = (_273 * 2.0f) - 1.0f.xx;
    float4 _279 = float4(_276, _15.SampleLevel(_10, (_262 + 0.5f.xx) * _8_m0.zw, 0.0f).x, 1.0f);
    _279.y = -_276.y;
    float4 _282 = mul(_6_m6, _279);
    float3 _286 = _282.xyz / _282.w.xxx;
    float3 _287 = ddy(_286);
    float3 _288 = ddx(_286);
    float3 _289 = cross(_287, _288);
    float3 _293 = _289 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(_289, _289)));
    float4 _297 = _27.SampleLevel(_11, _273, 0.0f);
    float2 _797;
    do
    {
        if (_21_m7.w >= 0.9900000095367431640625f)
        {
            _797 = float2(_21_m7.z, 1.0f);
            break;
        }
        int _315 = int(_21_m7.x);
        bool3 _317 = (_315 == 2).xxx;
        float3 _325 = _286 - float3(_317.x ? _21_m1[0].xyz.x : _6_m11.xyz.x, _317.y ? _21_m1[0].xyz.y : _6_m11.xyz.y, _317.z ? _21_m1[0].xyz.z : _6_m11.xyz.z);
        float _336 = max(clamp((_21_m6.w - dot(_325, _325)) * _21_m6.z, 0.0f, 1.0f), _21_m8.x);
        float _536;
        bool _537;
        if (_336 > 0.0f)
        {
            float _534;
            bool _535;
            if (_315 > 0)
            {
                float3 _343 = _286 - _21_m1[0].xyz;
                float3 _347 = _286 - _21_m1[1].xyz;
                float3 _351 = _286 - _21_m1[2].xyz;
                float3 _355 = _286 - _21_m1[3].xyz;
                float4 _360 = float4(dot(_343, _343), dot(_347, _347), dot(_351, _351), dot(_355, _355));
                float4 _369 = float4(_21_m1[0].w, _21_m1[1].w, _21_m1[2].w, _21_m1[3].w);
                float4 _371 = float4(bool4(_360.x < _369.x, _360.y < _369.y, _360.z < _369.z, _360.w < _369.w));
                float3 _375 = clamp(_371.yzw - _371.xyz, 0.0f.xxx, 1.0f.xxx);
                float _379 = clamp(4.0f - dot(float4(_371.x, _375.x, _375.y, _375.z), float4(4.0f, 3.0f, 2.0f, 1.0f)), 0.0f, 3.0f);
                float _381 = clamp(_379 + 1.0f, 0.0f, 3.0f);
                uint _382 = uint(_379);
                uint _390 = uint(_381);
                float _396 = dot(_360, _253[_390]) / _21_m1[_390].w;
                float _414;
                if (((_381 > _379) && (_396 >= 0.0f)) && (_396 <= 1.0f))
                {
                    _414 = _379 + step(frac(52.98291778564453125f * frac(dot(float2(_274) + float2(2.0829999446868896484375f, 4.867000102996826171875f), float2(0.067110560834407806396484375f, 0.005837149918079376220703125f)))), (sqrt(dot(_360, _253[_382]) / _21_m1[_382].w) - 0.89999997615814208984375f) * 12.0f);
                }
                else
                {
                    _414 = _379;
                }
                float _415 = clamp(_414, 0.0f, 4.0f);
                float4 _428 = mul(_21_m0[uint(_415)], float4(_286 - (_17_m0.xyz * (_297.y * (step(0.999989986419677734375f, _297.x) * 4.0f))), 1.0f));
                float _431 = _428.z;
                float4 _432 = float4(_428.xy, _431, _415);
                float3 _433 = _432.xyz;
                bool3 _434 = bool3(_433.x <= 0.0f.xxx.x, _433.y <= 0.0f.xxx.y, _433.z <= 0.0f.xxx.z);
                bool3 _435 = bool3(_433.x >= 1.0f.xxx.x, _433.y >= 1.0f.xxx.y, _433.z >= 1.0f.xxx.z);
                bool _441 = any(bool3(_434.x || _435.x, _434.y || _435.y, _434.z || _435.z)) || ((asuint(_431) & 2147483647u) > 2139095040u);
                float2 _443 = float2(_274) * 0.25f;
                float4 _451 = _24.Load(int3(int3(int(_443.x), int(_443.y), 0).xy, 0));
                float _452 = _451.x;
                float _533;
                if ((_452 < 0.001000000047497451305389404296875f) || (_452 > 0.9900000095367431640625f))
                {
                    _533 = _452;
                }
                else
                {
                    int _459 = int(_415);
                    uint _471 = uint(_459);
                    float2 _475 = float4(_21_m3[_459].xy + (_432.xy * _21_m3[_459].zw), _431, _415).xy;
                    int2 _477 = int2(_274 % uint2(4u, 4u));
                    int _481 = (_477.x * 4) + _477.y;
                    float2x2 _488 = float2x2(_252[_481], float2(-_252[_481].y, _252[_481].x));
                    float _490;
                    float _493;
                    _490 = 0.0f;
                    _493 = 0.0f;
                    for (uint _495 = 0u; _495 < 16u; )
                    {
                        float4 _507 = _22.GatherRed(_11, _475 + (mul(_251[_495], _488) * _21_m5[_471])) - _431.xxxx;
                        float4 _508 = step(0.0f.xxxx, _507);
                        _490 += dot(_507, _508);
                        _493 += dot(_508, 1.0f.xxxx);
                        _495++;
                        continue;
                    }
                    float _519 = (2.0f * clamp(_493 * 0.015625f, 0.0f, 1.0f)) - 1.0f;
                    float _522 = float(int(sign(_519)));
                    float _524 = 1.0f - (_522 * _519);
                    _533 = _441 ? 1.0f : (0.5f - (0.5f * ((1.0f - lerp((_524 * _524) * _524, _524, clamp((_490 * (1.0f / _493)) * (1.0f / _431), 0.0f, 1.0f))) * _522)));
                }
                _534 = _533;
                _535 = _441;
            }
            else
            {
                _534 = 1.0f;
                _535 = false;
            }
            _536 = _534;
            _537 = _535;
        }
        else
        {
            _536 = 1.0f;
            _537 = false;
        }
        float _737;
        float _738;
        if ((_336 < 1.0f) || (_21_m8.x > 0.5f))
        {
            float _548 = 1.0f - clamp(dot(_293, _17_m0.xyz), 0.0f, 0.89999997615814208984375f);
            float4 _565 = float4((_286 - (_17_m0.xyz * (_548 * _21_m24.x))) + (_293 * (_548 * _21_m24.y)), 1.0f);
            float4 _566 = mul(_21_m23, _565);
            float2 _567 = _566.xy;
            float _735;
            if (all(bool2(_567.x > 0.0f.xx.x, _567.y > 0.0f.xx.y)) && all(bool2(_567.x < 1.0f.xx.x, _567.y < 1.0f.xx.y)))
            {
                uint _586 = clamp(uint((floor(_566.y * _21_m25.z) + _566.x) * _21_m25.y), 0u, 127u);
                uint _590 = asuint(_21_m27[_586].x);
                float2 _591 = spvUnpackHalf2x16(_590);
                float _592 = _591.x;
                float _734;
                if (_592 >= 0.0f)
                {
                    float4x4 _601 = _21_m22;
                    _601[0].w = _21_m27[_586].y;
                    _601[1].w = _21_m27[_586].z;
                    _601[2].w = _21_m27[_586].w;
                    float4 _608 = mul(_601, _565);
                    float3 _609 = _608.xyz;
                    float _733;
                    if (all(bool3(_609.x > 0.0f.xxx.x, _609.y > 0.0f.xxx.y, _609.z > 0.0f.xxx.z)) && all(bool3(_609.x < 1.0f.xxx.x, _609.y < 1.0f.xxx.y, _609.z < 1.0f.xxx.z)))
                    {
                        float2 _621 = (_608.xy * _21_m24.zw) + float2(_592, spvUnpackHalf2x16(_590 >> 16u).x);
                        float _626 = _608.z;
                        float2 _632 = float4(_621, _626, 1.0f).xy * _21_m26.zw;
                        float2 _634 = floor(_632 + 0.5f.xx);
                        float2 _635 = _632 - _634;
                        float _636 = _635.x;
                        float _637 = _636 + 0.5f;
                        float _639 = (_637 * _637) * 0.5f;
                        float _642 = min(_636, 0.0f);
                        float _646 = max(_636, 0.0f);
                        float4 _650 = float4(_639 - _636, (1.0f - _636) - (_642 * _642), (_636 + 1.0f) - (_646 * _646), _639) * 0.44444000720977783203125f;
                        float _651 = _635.y;
                        float _652 = _651 + 0.5f;
                        float _654 = (_652 * _652) * 0.5f;
                        float _657 = min(_651, 0.0f);
                        float _661 = max(_651, 0.0f);
                        float4 _665 = float4(_654 - _651, (1.0f - _651) - (_657 * _657), (_651 + 1.0f) - (_661 * _661), _654) * 0.44444000720977783203125f;
                        float2 _667 = _650.yw;
                        float2 _668 = _650.xz + _667;
                        float2 _670 = _665.yw;
                        float2 _671 = _665.xz + _670;
                        float2 _677 = ((_667 / _668) + float2(-1.5f, 0.5f)) * _21_m26.xx;
                        float2 _679 = ((_670 / _671) + float2(-1.5f, 0.5f)) * _21_m26.yy;
                        float2 _681 = _634 * _21_m26.xy;
                        float _682 = _677.x;
                        float _683 = _679.x;
                        float _686 = _677.y;
                        float _689 = _679.y;
                        float _694 = _668.x;
                        float _695 = _671.x;
                        float _697 = _668.y;
                        float _699 = _671.y;
                        _733 = ((((_694 * _695) * _25.SampleCmpLevelZero(_13, float3(_681 + float2(_682, _683), _255).xy, _626)) + ((_697 * _695) * _25.SampleCmpLevelZero(_13, float3(_681 + float2(_686, _683), _255).xy, _626))) + ((_694 * _699) * _25.SampleCmpLevelZero(_13, float3(_681 + float2(_682, _689), _255).xy, _626))) + ((_697 * _699) * _25.SampleCmpLevelZero(_13, float3(_681 + float2(_686, _689), _255).xy, _626));
                    }
                    else
                    {
                        _733 = 1.0f;
                    }
                    _734 = _733;
                }
                else
                {
                    _734 = 1.0f;
                }
                _735 = _734;
            }
            else
            {
                _735 = 1.0f;
            }
            _737 = _537 ? _735 : _536;
            _738 = _735;
        }
        else
        {
            _737 = _536;
            _738 = 1.0f;
        }
        float _741 = lerp(lerp(_738, _737, _336), min(_738, _737), _21_m8.x);
        float _792;
        if (_741 > 0.001000000047497451305389404296875f)
        {
            float3 _748 = _286 - _8_m65.xyz;
            float2 _758 = (_748 + (_8_m68.xyz * _748.y)).xz * _8_m66.z;
            float2 _767 = _8_m67.xy * _8_m75.w;
            _792 = _741 * lerp(1.0f, lerp(_23.SampleLevel(_12, _758 + _767, 0.0f), _23.SampleLevel(_12, (_758 * _8_m67.w) + _767, 0.0f), smoothstep(_8_m66.x, _8_m66.y, length(_748.xz)).xxxx).x, _8_m67.z);
        }
        else
        {
            _792 = _741;
        }
        _797 = float2(lerp(_792, _21_m7.z, _21_m7.w), _792);
        break;
    } while(false);
    _4 = float3(lerp(1.0f, min(1.0f, _797.x), _21_m6.x), 1.0f, 0.0f);
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output._4 = _4;
    return stage_output;
}
