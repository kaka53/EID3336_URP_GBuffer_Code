struct _29
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

static float4 _111;

cbuffer _24_25 : register(b13)
{
    column_major float4x4 _25_m0 : packoffset(c0);
    column_major float4x4 _25_m1 : packoffset(c4);
    column_major float4x4 _25_m2 : packoffset(c8);
    column_major float4x4 _25_m3 : packoffset(c12);
    column_major float4x4 _25_m4 : packoffset(c16);
    column_major float4x4 _25_m5 : packoffset(c20);
    column_major float4x4 _25_m6 : packoffset(c24);
    column_major float4x4 _25_m7 : packoffset(c28);
    column_major float4x4 _25_m8 : packoffset(c32);
    column_major float4x4 _25_m9 : packoffset(c36);
    column_major float4x4 _25_m10 : packoffset(c40);
    float4 _25_m11 : packoffset(c44);
    column_major float4x4 _25_m12 : packoffset(c45);
    column_major float4x4 _25_m13 : packoffset(c49);
    column_major float4x4 _25_m14 : packoffset(c53);
    column_major float4x4 _25_m15 : packoffset(c57);
    column_major float4x4 _25_m16 : packoffset(c61);
    column_major float4x4 _25_m17 : packoffset(c65);
    column_major float4x4 _25_m18 : packoffset(c69);
    column_major float4x4 _25_m19 : packoffset(c73);
    column_major float4x4 _25_m20 : packoffset(c77);
    float4 _25_m21 : packoffset(c81);
};

cbuffer _26_27 : register(b16)
{
    float4 _27_m0 : packoffset(c0);
    float4 _27_m1 : packoffset(c1);
    float4 _27_m2 : packoffset(c2);
    float4 _27_m3 : packoffset(c3);
    float4 _27_m4 : packoffset(c4);
    float4 _27_m5 : packoffset(c5);
    float4 _27_m6[6] : packoffset(c6);
    float4 _27_m7[6] : packoffset(c12);
    float4 _27_m8 : packoffset(c18);
    float4 _27_m9 : packoffset(c19);
    float4 _27_m10 : packoffset(c20);
    float4 _27_m11 : packoffset(c21);
    float4 _27_m12 : packoffset(c22);
    float4 _27_m13 : packoffset(c23);
    float4 _27_m14 : packoffset(c24);
    float4 _27_m15 : packoffset(c25);
    float _27_m16 : packoffset(c26);
    float _27_m17 : packoffset(c26.y);
    float _27_m18 : packoffset(c26.z);
    uint _27_m19 : packoffset(c26.w);
    float4 _27_m20 : packoffset(c27);
    int4 _27_m21 : packoffset(c28);
    float4 _27_m22 : packoffset(c29);
    float4 _27_m23 : packoffset(c30);
    float4 _27_m24 : packoffset(c31);
    float4 _27_m25 : packoffset(c32);
    float4 _27_m26 : packoffset(c33);
    float4 _27_m27 : packoffset(c34);
    float4 _27_m28 : packoffset(c35);
    float4 _27_m29 : packoffset(c36);
    float4 _27_m30 : packoffset(c37);
    float4 _27_m31 : packoffset(c38);
    float4 _27_m32[4] : packoffset(c39);
    float4 _27_m33[4] : packoffset(c43);
    float4 _27_m34[4] : packoffset(c47);
    float4 _27_m35[4] : packoffset(c51);
    float4 _27_m36 : packoffset(c55);
    float4 _27_m37 : packoffset(c56);
    float4 _27_m38[4] : packoffset(c57);
    float4 _27_m39[4] : packoffset(c61);
    float4 _27_m40[4] : packoffset(c65);
    float4 _27_m41 : packoffset(c69);
    float4 _27_m42 : packoffset(c70);
    float4 _27_m43 : packoffset(c71);
    float4 _27_m44 : packoffset(c72);
    float4 _27_m45 : packoffset(c73);
    float4 _27_m46 : packoffset(c74);
    float4 _27_m47 : packoffset(c75);
    float4 _27_m48 : packoffset(c76);
    float4 _27_m49 : packoffset(c77);
    float4 _27_m50 : packoffset(c78);
    float4 _27_m51 : packoffset(c79);
    float4 _27_m52 : packoffset(c80);
    float4 _27_m53 : packoffset(c81);
    float4 _27_m54 : packoffset(c82);
    float4 _27_m55 : packoffset(c83);
    float4 _27_m56 : packoffset(c84);
    float4 _27_m57 : packoffset(c85);
    float4 _27_m58 : packoffset(c86);
    float4 _27_m59 : packoffset(c87);
    float4 _27_m60 : packoffset(c88);
    float4 _27_m61 : packoffset(c89);
    float4 _27_m62 : packoffset(c90);
    float4 _27_m63 : packoffset(c91);
    float4 _27_m64 : packoffset(c92);
    float4 _27_m65 : packoffset(c93);
    float4 _27_m66 : packoffset(c94);
    float4 _27_m67 : packoffset(c95);
    float4 _27_m68 : packoffset(c96);
    float4 _27_m69 : packoffset(c97);
    float4 _27_m70 : packoffset(c98);
    float4 _27_m71 : packoffset(c99);
    float4 _27_m72 : packoffset(c100);
    float4 _27_m73 : packoffset(c101);
    float4 _27_m74 : packoffset(c102);
    float4 _27_m75 : packoffset(c103);
    float4 _27_m76 : packoffset(c104);
    float4 _27_m77 : packoffset(c105);
    float4 _27_m78 : packoffset(c106);
    float4 _27_m79 : packoffset(c107);
    float4 _27_m80 : packoffset(c108);
    float4 _27_m81 : packoffset(c109);
    float4 _27_m82 : packoffset(c110);
    float4 _27_m83 : packoffset(c111);
    float4 _27_m84 : packoffset(c112);
    float4 _27_m85 : packoffset(c113);
    float4 _27_m86 : packoffset(c114);
    float4 _27_m87 : packoffset(c115);
    float4 _27_m88 : packoffset(c116);
    float4 _27_m89 : packoffset(c117);
    float4 _27_m90 : packoffset(c118);
    float4 _27_m91 : packoffset(c119);
    float4 _27_m92 : packoffset(c120);
    float4 _27_m93 : packoffset(c121);
    float4 _27_m94 : packoffset(c122);
    float4 _27_m95 : packoffset(c123);
    float4 _27_m96 : packoffset(c124);
    float4 _27_m97 : packoffset(c125);
    float4 _27_m98 : packoffset(c126);
    float4 _27_m99[2] : packoffset(c127);
    float4 _27_m100[2] : packoffset(c129);
    float _27_m101 : packoffset(c131);
    float _27_m102 : packoffset(c131.y);
    float _27_m103 : packoffset(c131.z);
    float _27_m104 : packoffset(c131.w);
    float4 _27_m105 : packoffset(c132);
    float4 _27_m106 : packoffset(c133);
    float4 _27_m107 : packoffset(c134);
    float4 _27_m108 : packoffset(c135);
    float4 _27_m109 : packoffset(c136);
    float4 _27_m110 : packoffset(c137);
    float4 _27_m111 : packoffset(c138);
    float4 _27_m112 : packoffset(c139);
    float4 _27_m113 : packoffset(c140);
    float4 _27_m114 : packoffset(c141);
    float4 _27_m115 : packoffset(c142);
    float4 _27_m116 : packoffset(c143);
    float4 _27_m117 : packoffset(c144);
    float4 _27_m118 : packoffset(c145);
    float4 _27_m119 : packoffset(c146);
    float4 _27_m120 : packoffset(c147);
    float4 _27_m121 : packoffset(c148);
    float4 _27_m122 : packoffset(c149);
    float4 _27_m123 : packoffset(c150);
    float4 _27_m124 : packoffset(c151);
    float4 _27_m125 : packoffset(c152);
    float4 _27_m126 : packoffset(c153);
    float4 _27_m127 : packoffset(c154);
    float4 _27_m128 : packoffset(c155);
    float4 _27_m129 : packoffset(c156);
    float4 _27_m130 : packoffset(c157);
    float4 _27_m131 : packoffset(c158);
    float4 _27_m132 : packoffset(c159);
    float4 _27_m133 : packoffset(c160);
    float4 _27_m134 : packoffset(c161);
    column_major float4x4 _27_m135 : packoffset(c162);
    float4 _27_m136 : packoffset(c166);
    float4 _27_m137 : packoffset(c167);
    float4 _27_m138[32] : packoffset(c168);
};

cbuffer _28_30 : register(b0)
{
    _29 _30_m0[256] : packoffset(c0);
};

ByteAddressBuffer _32 : register(t19);

static float4 gl_Position;
static int gl_InstanceIndex;
static float3 _3;
static float3 _4;
static float4 _5;
static float4 _6;
static float2 _7;
static float2 _8;
static float2 _9;
static float4 _10;
static float4 _11;
static uint4 _12;
static float2 _15;
static float2 _16;
static float2 _17;
static float3 _18;
static float4 _19;
static float3 _21;
static float3 _22;
static uint _23;

struct SPIRV_Cross_Input
{
    float3 _3 : TEXCOORD0;
    float3 _4 : TEXCOORD1;
    float4 _5 : TEXCOORD2;
    float4 _6 : TEXCOORD3;
    float2 _7 : TEXCOORD4;
    float2 _8 : TEXCOORD5;
    float2 _9 : TEXCOORD6;
    float4 _10 : TEXCOORD7;
    float4 _11 : TEXCOORD8;
    uint4 _12 : TEXCOORD9;
    uint gl_InstanceIndex : SV_InstanceID;
};

struct SPIRV_Cross_Output
{
    float2 _15 : TEXCOORD0;
    float2 _16 : TEXCOORD1;
    float2 _17 : TEXCOORD2;
    float3 _18 : TEXCOORD3;
    float4 _19 : TEXCOORD4;
    float3 _21 : TEXCOORD6;
    float3 _22 : TEXCOORD7;
    nointerpolation uint _23 : TEXCOORD8;
    precise float4 gl_Position : SV_Position;
};

void vert_main()
{
    uint _125 = asuint(_4.x);
    bool _127 = (_125 & 1073741824u) > 0u;
    float4 _200;
    float3 _201;
    if (_127)
    {
        float _133 = float((_125 << 22u) >> 22u);
        float _136 = float((_125 << 12u) >> 22u);
        float _139 = float((_125 << 2u) >> 22u);
        float3 _153 = float3((_133 >= 512.0f) ? (_133 - 1024.0f) : _133, (_136 >= 512.0f) ? (_136 - 1024.0f) : _136, 0.0f) * 0.001956947147846221923828125f;
        float _159 = (1.0f - abs(_153.x)) - abs(_153.y);
        float3 _160 = _153;
        _160.z = _159;
        bool2 _162 = (_159 < 0.0f).xx;
        float2 _170 = (1.0f.xx - abs(_160.yx)) * ((step(0.0f.xx, _160.xy) * 2.0f) - 1.0f.xx);
        float2 _171 = float2(_162.x ? _170.x : _160.xy.x, _162.y ? _170.y : _160.xy.y);
        float3 _173 = normalize(float3(_171.x, _171.y, _160.z));
        float _174 = ((_139 >= 512.0f) ? (_139 - 1024.0f) : _139) * 0.001956947147846221923828125f;
        float3 _177 = _173.yzx - _173.zxy;
        float3 _181 = normalize(_177 - dot(_177, _173).xxx);
        float _186 = (_174 < 0.0f) ? (-1.0f) : 1.0f;
        float _189 = 1.0f - ((_174 * _186) * 2.0f);
        float3 _195 = mul(normalize(float2(_189, _186 * (1.0f - abs(_189)))), float2x3(_181, normalize(cross(_173, _181))));
        float4 _196 = float4(_195.x, _195.y, _195.z, _111.w);
        _196.w = (float((_125 >> 31u) & 1u) * 2.0f) - 1.0f;
        _200 = _196;
        _201 = _173;
    }
    else
    {
        _200 = 0.0f.xxxx;
        _201 = _4;
    }
    bool4 _202 = _127.xxxx;
    float4 _203 = float4(_202.x ? _200.x : _5.x, _202.y ? _200.y : _5.y, _202.z ? _200.z : _5.z, _202.w ? _200.w : _5.w);
    float4 _395;
    float3 _396;
    float3 _397;
    float3 _398;
    do
    {
        float4 _210 = float4(_3, 1.0f);
        uint _213 = asuint(_30_m0[uint(gl_InstanceIndex)]._m1.w);
        uint _214 = _213 & 4294967247u;
        if (((_213 & 32u) == 0u) || (_214 == 0u))
        {
            _395 = _203;
            _396 = _3;
            _397 = _10.xyz;
            _398 = _201;
            break;
        }
        uint4 _230 = _12 * uint4(3u, 3u, 3u, 3u);
        uint4 _231 = (asuint(_30_m0[uint(gl_InstanceIndex)]._m2.x) + 3u).xxxx + _230;
        uint4 _233 = (asuint(_30_m0[uint(gl_InstanceIndex)]._m2.y) + 3u).xxxx + _230;
        uint _234 = _231.x;
        uint _237 = _234 + 1u;
        uint _240 = _234 + 2u;
        uint _243 = _233.x;
        uint _246 = _243 + 1u;
        uint _249 = _243 + 2u;
        float4 _295;
        float4 _296;
        float4 _297;
        float4 _298;
        float4 _299;
        float4 _300;
        if (_214 >= 2u)
        {
            uint _258 = _231.y;
            uint _278 = _233.y;
            _295 = (asfloat(_32.Load4(_249 * 16 + 0)) * _11.x) + (asfloat(_32.Load4((_278 + 2u) * 16 + 0)) * _11.y);
            _296 = (asfloat(_32.Load4(_246 * 16 + 0)) * _11.x) + (asfloat(_32.Load4((_278 + 1u) * 16 + 0)) * _11.y);
            _297 = (asfloat(_32.Load4(_243 * 16 + 0)) * _11.x) + (asfloat(_32.Load4(_278 * 16 + 0)) * _11.y);
            _298 = (asfloat(_32.Load4(_240 * 16 + 0)) * _11.x) + (asfloat(_32.Load4((_258 + 2u) * 16 + 0)) * _11.y);
            _299 = (asfloat(_32.Load4(_237 * 16 + 0)) * _11.x) + (asfloat(_32.Load4((_258 + 1u) * 16 + 0)) * _11.y);
            _300 = (asfloat(_32.Load4(_234 * 16 + 0)) * _11.x) + (asfloat(_32.Load4(_258 * 16 + 0)) * _11.y);
        }
        else
        {
            _295 = asfloat(_32.Load4(_249 * 16 + 0));
            _296 = asfloat(_32.Load4(_246 * 16 + 0));
            _297 = asfloat(_32.Load4(_243 * 16 + 0));
            _298 = asfloat(_32.Load4(_240 * 16 + 0));
            _299 = asfloat(_32.Load4(_237 * 16 + 0));
            _300 = asfloat(_32.Load4(_234 * 16 + 0));
        }
        float4 _368;
        float4 _369;
        float4 _370;
        float4 _371;
        float4 _372;
        float4 _373;
        if (_214 >= 4u)
        {
            uint _304 = _231.z;
            uint _310 = _231.w;
            uint _338 = _233.z;
            uint _342 = _233.w;
            _368 = _295 + ((asfloat(_32.Load4((_338 + 2u) * 16 + 0)) * _11.z) + (asfloat(_32.Load4((_342 + 2u) * 16 + 0)) * _11.w));
            _369 = _296 + ((asfloat(_32.Load4((_338 + 1u) * 16 + 0)) * _11.z) + (asfloat(_32.Load4((_342 + 1u) * 16 + 0)) * _11.w));
            _370 = _297 + ((asfloat(_32.Load4(_338 * 16 + 0)) * _11.z) + (asfloat(_32.Load4(_342 * 16 + 0)) * _11.w));
            _371 = _298 + ((asfloat(_32.Load4((_304 + 2u) * 16 + 0)) * _11.z) + (asfloat(_32.Load4((_310 + 2u) * 16 + 0)) * _11.w));
            _372 = _299 + ((asfloat(_32.Load4((_304 + 1u) * 16 + 0)) * _11.z) + (asfloat(_32.Load4((_310 + 1u) * 16 + 0)) * _11.w));
            _373 = _300 + ((asfloat(_32.Load4(_304 * 16 + 0)) * _11.z) + (asfloat(_32.Load4(_310 * 16 + 0)) * _11.w));
        }
        else
        {
            _368 = _295;
            _369 = _296;
            _370 = _297;
            _371 = _298;
            _372 = _299;
            _373 = _300;
        }
        float3 _389 = _203.xyz;
        float3 _393 = float3(dot(_373.xyz, _389), dot(_372.xyz, _389), dot(_371.xyz, _389));
        _395 = float4(_393.x, _393.y, _393.z, _203.w);
        _396 = float3(dot(_373, _210), dot(_372, _210), dot(_371, _210));
        _397 = float3(dot(_370, _210), dot(_369, _210), dot(_368, _210));
        _398 = float3(dot(_373.xyz, _201), dot(_372.xyz, _201), dot(_371.xyz, _201));
        break;
    } while(false);
    float3x3 _407 = float3x3(_30_m0[uint(gl_InstanceIndex)]._m0[0].xyz, _30_m0[uint(gl_InstanceIndex)]._m0[1].xyz, _30_m0[uint(gl_InstanceIndex)]._m0[2].xyz);
    float3 _417 = mul(_407, _396) + (float3(_30_m0[uint(gl_InstanceIndex)]._m0[0].w, _30_m0[uint(gl_InstanceIndex)]._m0[1].w, _30_m0[uint(gl_InstanceIndex)]._m0[2].w) - _25_m11.xyz);
    float3 _426 = mul(_407, float3(1.0f / dot(_30_m0[uint(gl_InstanceIndex)]._m0[0].xyz, _30_m0[uint(gl_InstanceIndex)]._m0[0].xyz), 1.0f / dot(_30_m0[uint(gl_InstanceIndex)]._m0[1].xyz, _30_m0[uint(gl_InstanceIndex)]._m0[1].xyz), 1.0f / dot(_30_m0[uint(gl_InstanceIndex)]._m0[2].xyz, _30_m0[uint(gl_InstanceIndex)]._m0[2].xyz)) * _398);
    float3 _432 = mul(_407, _395.xyz);
    float4 _453 = mul(_25_m8, float4(_417, 1.0f));
    float2 _461 = _453.xy - ((_27_m9.zw * float2(2.0f, -2.0f)) * _453.w);
    float4 _462 = float4(_461.x, _461.y, _453.z, _453.w);
    bool3 _467 = (_30_m0[uint(gl_InstanceIndex)]._m4.x < 1.0f).xxx;
    bool4 _473 = (_30_m0[uint(gl_InstanceIndex)]._m4.y < 1.0f).xxxx;
    float4 _482 = float4(_417 + (_25_m11.xyz - _25_m21.xyz), 1.0f);
    float4 _502 = float4(mul(float3x3(_30_m0[uint(gl_InstanceIndex)]._m3[0].xyz, _30_m0[uint(gl_InstanceIndex)]._m3[1].xyz, _30_m0[uint(gl_InstanceIndex)]._m3[2].xyz), float3(_467.x ? _396.x : _397.xyz.x, _467.y ? _396.y : _397.xyz.y, _467.z ? _396.z : _397.xyz.z)) + (float3(_30_m0[uint(gl_InstanceIndex)]._m3[0].w, _30_m0[uint(gl_InstanceIndex)]._m3[1].w, _30_m0[uint(gl_InstanceIndex)]._m3[2].w) - _25_m21.xyz), 1.0f);
    _462.y = -_461.y;
    gl_Position = _462;
    _15 = _7;
    _16 = _8;
    _17 = _9;
    _18 = _426 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(_426, _426)));
    _19 = float4(_432 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(_432, _432))), _395.w * ((_30_m0[uint(gl_InstanceIndex)]._m2.w >= 0.0f) ? 1.0f : (-1.0f)));
    _21 = _453.xyw;
    _22 = mul(_25_m15, float4(_473.x ? _482.x : _502.x, _473.y ? _482.y : _502.y, _473.z ? _482.z : _502.z, _473.w ? _482.w : _502.w)).xyw;
    _23 = uint(gl_InstanceIndex);
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_InstanceIndex = int(stage_input.gl_InstanceIndex);
    _3 = stage_input._3;
    _4 = stage_input._4;
    _5 = stage_input._5;
    _6 = stage_input._6;
    _7 = stage_input._7;
    _8 = stage_input._8;
    _9 = stage_input._9;
    _10 = stage_input._10;
    _11 = stage_input._11;
    _12 = stage_input._12;
    vert_main();
    SPIRV_Cross_Output stage_output;
    stage_output.gl_Position = gl_Position;
    stage_output._15 = _15;
    stage_output._16 = _16;
    stage_output._17 = _17;
    stage_output._18 = _18;
    stage_output._19 = _19;
    stage_output._21 = _21;
    stage_output._22 = _22;
    stage_output._23 = _23;
    return stage_output;
}
