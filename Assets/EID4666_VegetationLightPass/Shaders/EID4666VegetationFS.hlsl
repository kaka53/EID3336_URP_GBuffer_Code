// Wrapped from PS189623.cross.hlsl. Keep SPIR-V arithmetic.
// Nested _25[32] in a cbuffer fails Vulkan glslang (.w out of range); flatten like EID4662.

static uint _256;

cbuffer _6_7 : register(b0)
{
    column_major float4x4 _7_m0_Captured : packoffset(c0);
    column_major float4x4 _7_m1 : packoffset(c4);
    column_major float4x4 _7_m2 : packoffset(c8);
    column_major float4x4 _7_m3 : packoffset(c12);
    column_major float4x4 _7_m4 : packoffset(c16);
    column_major float4x4 _7_m5 : packoffset(c20);
    column_major float4x4 _7_m6_Captured : packoffset(c24);
    column_major float4x4 _7_m7 : packoffset(c28);
    column_major float4x4 _7_m8 : packoffset(c32);
    column_major float4x4 _7_m9 : packoffset(c36);
    column_major float4x4 _7_m10 : packoffset(c40);
    float4 _7_m11_Captured : packoffset(c44);
    column_major float4x4 _7_m12 : packoffset(c45);
    column_major float4x4 _7_m13 : packoffset(c49);
    column_major float4x4 _7_m14 : packoffset(c53);
    column_major float4x4 _7_m15 : packoffset(c57);
    column_major float4x4 _7_m16 : packoffset(c61);
    column_major float4x4 _7_m17 : packoffset(c65);
    column_major float4x4 _7_m18 : packoffset(c69);
    column_major float4x4 _7_m19 : packoffset(c73);
    column_major float4x4 _7_m20 : packoffset(c77);
    float4 _7_m21 : packoffset(c81);
};

cbuffer _8_9 : register(b3)
{
    float4 _9_m0_Captured : packoffset(c0);
    float4 _9_m1 : packoffset(c1);
    float4 _9_m2 : packoffset(c2);
    float4 _9_m3 : packoffset(c3);
    float4 _9_m4 : packoffset(c4);
    float4 _9_m5 : packoffset(c5);
    float4 _9_m6[6] : packoffset(c6);
    float4 _9_m7[6] : packoffset(c12);
    float4 _9_m8 : packoffset(c18);
    float4 _9_m9 : packoffset(c19);
    float4 _9_m10 : packoffset(c20);
    float4 _9_m11 : packoffset(c21);
    float4 _9_m12 : packoffset(c22);
    float4 _9_m13 : packoffset(c23);
    float4 _9_m14 : packoffset(c24);
    float4 _9_m15 : packoffset(c25);
    float _9_m16 : packoffset(c26);
    float _9_m17 : packoffset(c26.y);
    float _9_m18 : packoffset(c26.z);
    uint _9_m19 : packoffset(c26.w);
    float4 _9_m20 : packoffset(c27);
    int4 _9_m21 : packoffset(c28);
    float4 _9_m22 : packoffset(c29);
    float4 _9_m23 : packoffset(c30);
    float4 _9_m24 : packoffset(c31);
    float4 _9_m25 : packoffset(c32);
    float4 _9_m26 : packoffset(c33);
    float4 _9_m27 : packoffset(c34);
    float4 _9_m28 : packoffset(c35);
    float4 _9_m29 : packoffset(c36);
    float4 _9_m30 : packoffset(c37);
    float4 _9_m31 : packoffset(c38);
    float4 _9_m32[4] : packoffset(c39);
    float4 _9_m33[4] : packoffset(c43);
    float4 _9_m34[4] : packoffset(c47);
    float4 _9_m35[4] : packoffset(c51);
    float4 _9_m36 : packoffset(c55);
    float4 _9_m37 : packoffset(c56);
    float4 _9_m38[4] : packoffset(c57);
    float4 _9_m39[4] : packoffset(c61);
    float4 _9_m40[4] : packoffset(c65);
    float4 _9_m41 : packoffset(c69);
    float4 _9_m42 : packoffset(c70);
    float4 _9_m43 : packoffset(c71);
    float4 _9_m44 : packoffset(c72);
    float4 _9_m45 : packoffset(c73);
    float4 _9_m46 : packoffset(c74);
    float4 _9_m47 : packoffset(c75);
    float4 _9_m48 : packoffset(c76);
    float4 _9_m49 : packoffset(c77);
    float4 _9_m50 : packoffset(c78);
    float4 _9_m51 : packoffset(c79);
    float4 _9_m52 : packoffset(c80);
    float4 _9_m53 : packoffset(c81);
    float4 _9_m54 : packoffset(c82);
    float4 _9_m55 : packoffset(c83);
    float4 _9_m56 : packoffset(c84);
    float4 _9_m57 : packoffset(c85);
    float4 _9_m58 : packoffset(c86);
    float4 _9_m59 : packoffset(c87);
    float4 _9_m60 : packoffset(c88);
    float4 _9_m61 : packoffset(c89);
    float4 _9_m62 : packoffset(c90);
    float4 _9_m63 : packoffset(c91);
    float4 _9_m64 : packoffset(c92);
    float4 _9_m65 : packoffset(c93);
    float4 _9_m66 : packoffset(c94);
    float4 _9_m67 : packoffset(c95);
    float4 _9_m68 : packoffset(c96);
    float4 _9_m69 : packoffset(c97);
    float4 _9_m70 : packoffset(c98);
    float4 _9_m71 : packoffset(c99);
    float4 _9_m72 : packoffset(c100);
    float4 _9_m73 : packoffset(c101);
    float4 _9_m74 : packoffset(c102);
    float4 _9_m75 : packoffset(c103);
    float4 _9_m76 : packoffset(c104);
    float4 _9_m77 : packoffset(c105);
    float4 _9_m78 : packoffset(c106);
    float4 _9_m79 : packoffset(c107);
    float4 _9_m80 : packoffset(c108);
    float4 _9_m81 : packoffset(c109);
    float4 _9_m82 : packoffset(c110);
    float4 _9_m83 : packoffset(c111);
    float4 _9_m84 : packoffset(c112);
    float4 _9_m85 : packoffset(c113);
    float4 _9_m86 : packoffset(c114);
    float4 _9_m87 : packoffset(c115);
    float4 _9_m88 : packoffset(c116);
    float4 _9_m89 : packoffset(c117);
    float4 _9_m90 : packoffset(c118);
    float4 _9_m91 : packoffset(c119);
    float4 _9_m92 : packoffset(c120);
    float4 _9_m93 : packoffset(c121);
    float4 _9_m94 : packoffset(c122);
    float4 _9_m95 : packoffset(c123);
    float4 _9_m96 : packoffset(c124);
    float4 _9_m97 : packoffset(c125);
    float4 _9_m98 : packoffset(c126);
    float4 _9_m99[2] : packoffset(c127);
    float4 _9_m100[2] : packoffset(c129);
    float _9_m101 : packoffset(c131);
    float _9_m102 : packoffset(c131.y);
    float _9_m103 : packoffset(c131.z);
    float _9_m104 : packoffset(c131.w);
    float4 _9_m105 : packoffset(c132);
    float4 _9_m106 : packoffset(c133);
    float4 _9_m107 : packoffset(c134);
    float4 _9_m108 : packoffset(c135);
    float4 _9_m109 : packoffset(c136);
    float4 _9_m110 : packoffset(c137);
    float4 _9_m111 : packoffset(c138);
    float4 _9_m112 : packoffset(c139);
    float4 _9_m113 : packoffset(c140);
    float4 _9_m114 : packoffset(c141);
    float4 _9_m115 : packoffset(c142);
    float4 _9_m116 : packoffset(c143);
    float4 _9_m117 : packoffset(c144);
    float4 _9_m118 : packoffset(c145);
    float4 _9_m119 : packoffset(c146);
    float4 _9_m120 : packoffset(c147);
    float4 _9_m121 : packoffset(c148);
    float4 _9_m122 : packoffset(c149);
    float4 _9_m123 : packoffset(c150);
    float4 _9_m124 : packoffset(c151);
    float4 _9_m125 : packoffset(c152);
    float4 _9_m126 : packoffset(c153);
    float4 _9_m127 : packoffset(c154);
    float4 _9_m128 : packoffset(c155);
    float4 _9_m129 : packoffset(c156);
    float4 _9_m130 : packoffset(c157);
    float4 _9_m131 : packoffset(c158);
    float4 _9_m132 : packoffset(c159);
    float4 _9_m133 : packoffset(c160);
    float4 _9_m134 : packoffset(c161);
    column_major float4x4 _9_m135 : packoffset(c162);
    float4 _9_m136 : packoffset(c166);
    float4 _9_m137 : packoffset(c167);
    float4 _9_m138[32] : packoffset(c168);
};

ByteAddressBuffer _23 : register(t31);
cbuffer _24_26 : register(b4)
{
    float4 _26_m0 : packoffset(c0);
    float4 _26_m1 : packoffset(c1);
    float4 _26_m2 : packoffset(c2);
    float4 _26_m3 : packoffset(c3);
    float4 _26_m4_words[256] : packoffset(c4);
};

cbuffer _27_28 : register(b1)
{
    float4 _28_m0 : packoffset(c0);
    float4 _28_m1 : packoffset(c1);
    float4 _28_m2 : packoffset(c2);
    float4 _28_m3 : packoffset(c3);
    float4 _28_m4 : packoffset(c4);
    uint4 _28_m5 : packoffset(c5);
    float4 _28_m6[2048] : packoffset(c6);
};

cbuffer _35_36 : register(b2)
{
    float4 _36_m0 : packoffset(c0);
    float4 _36_m1 : packoffset(c1);
    float4 _36_m2 : packoffset(c2);
    float4 _36_m3 : packoffset(c3);
    float4 _36_m4 : packoffset(c4);
    uint4 _36_m5 : packoffset(c5);
    float4 _36_m6 : packoffset(c6);
    float4 _36_m7 : packoffset(c7);
};


column_major float4x4 _EID4666WorldToView;
column_major float4x4 _EID4666ClipToWorld;
float4 _EID4666CameraPositionWS;
float4 _EID4666ScreenSize;
float _EID4666UseLiveCamera;

float4x4 EID4666_GetWorldToView()
{
    return (_EID4666UseLiveCamera > 0.5f) ? _EID4666WorldToView : _7_m0_Captured;
}

float4x4 EID4666_GetClipToWorld()
{
    return (_EID4666UseLiveCamera > 0.5f) ? _EID4666ClipToWorld : _7_m6_Captured;
}

float4 EID4666_GetCameraPositionWS()
{
    return (_EID4666UseLiveCamera > 0.5f) ? _EID4666CameraPositionWS : _7_m11_Captured;
}

float4 EID4666_GetScreenSize()
{
    return (_EID4666UseLiveCamera > 0.5f) ? _EID4666ScreenSize : _9_m0_Captured;
}

SamplerState sampler_PointClamp : register(s1);
SamplerState sampler_LinearClamp : register(s3);
SamplerState sampler_LinearRepeat : register(s2);
SamplerState sampler_TrilinearClamp : register(s0);
Texture2D<float4> _17 : register(t23);
Texture2D<float4> _18 : register(t7);
Texture2D<float4> _19 : register(t8);
Texture2D<float4> _20 : register(t18);
Texture2DArray<float4> _21 : register(t9);
Texture2D<float4> _29 : register(t6);
Texture2D<float4> _30 : register(t24);
Texture2D<float4> _32 : register(t10);
Texture2D<float4> _33 : register(t22);
Texture3D<float4> _34 : register(t17);
Texture2D<float4> _37 : register(t25);
Texture2D<float4> _38 : register(t5);
Texture3D<float4> _39 : register(t16);
Texture3D<float4> _40 : register(t13);
Texture3D<float4> _41 : register(t15);
Texture3D<float4> _42 : register(t12);
Texture3D<float4> _43 : register(t14);
Texture3D<float4> _44 : register(t11);
Texture2D<float4> _46 : register(t21);
Texture2D<float4> _47 : register(t20);
Texture2D<float4> _48 : register(t19);

static float4 gl_FragCoord;
static float2 _4;
static float4 _5;

struct EID_FS_Input
{
    float2 _4 : TEXCOORD0;
    float4 gl_FragCoord : SV_Position;
};

struct EID_FS_Output
{
    float4 _5 : SV_Target0;
};

void frag_main()
{
    uint2 _262 = uint2(gl_FragCoord.xy);
    int _265 = int(_262.x);
    int _266 = int(_262.y);
    int2 _268 = int3(_265, _266, 0).xy;
    float4 _270 = _46.Load(int3(_268, 0));
    float4 _272 = _47.Load(int3(_268, 0));
    float4 _274 = _48.Load(int3(_268, 0));
    uint _278 = uint(_270.x * 1023.0f);
    float _282 = float((_278 >> 3u) & 127u) * 0.0078740157186985015869140625f;
    float _290 = float(((_278 & 7u) << 2u) | (uint(_270.w * 3.0f) & 3u)) * 0.0322580635547637939453125f;
    uint _294 = uint(round(_270.y * 1023.0f));
    float _299 = float((_294 >> 3u) & 127u) * 0.0078740157186985015869140625f;
    uint _304 = uint(_270.z * 1023.0f);
    float2 _319 = (_272.xy * 2.0f) - 1.0f.xx;
    float _323 = 1.0f - dot(1.0f.xx, abs(_319));
    float3 _325 = float3(_319.x, _323, _319.y);
    float3 _337;
    if (_323 < 0.0f)
    {
        float2 _332 = _325.xz;
        bool2 _333 = bool2(_332.x >= 0.0f.xx.x, _332.y >= 0.0f.xx.y);
        float2 _335 = (1.0f.xx - abs(_325.zx)) * float2(_333.x ? 1.0f.xx.x : (-1.0f).xx.x, _333.y ? 1.0f.xx.y : (-1.0f).xx.y);
        _337 = float3(_335.x, _325.y, _335.y);
    }
    else
    {
        _337 = _325;
    }
    float3 _338 = normalize(_337);
    float _339 = _272.z;
    float3 _340 = _274.xyz;
    float _341 = _274.w;
    float _343 = (float(_294 & 7u) * 0.107142865657806396484375f) + 0.5f;
    float2 _346 = float2(_262);
    float2 _359 = gl_FragCoord.xy * EID4666_GetScreenSize().zw;
    float2 _361 = (_359 * 2.0f) - 1.0f.xx;
    float4 _364 = float4(_361.x, _361.y, _17.SampleLevel(sampler_PointClamp, (_346 + 0.5f.xx) * EID4666_GetScreenSize().zw, 0.0f).x, 1.0f);
    _364.y = -_361.y;
    float4 _367 = mul(EID4666_GetClipToWorld(), _364);
    float3 _371 = _367.xyz / _367.w.xxx;
    float4 _375 = float4(_371.x, _371.y, _371.z, 1.0f);
    float _378 = abs(mul(EID4666_GetWorldToView(), _375).z);
    float3 _393;
    do
    {
        if (_9_m4.w == 0.0f)
        {
            _393 = EID4666_GetCameraPositionWS().xyz - _371;
            break;
        }
        else
        {
            _393 = EID4666_GetWorldToView()[2].xyz;
            break;
        }
        break; // unreachable workaround
    } while(false);
    float _394 = dot(_393, _393);
    float _396 = rsqrt(max(_394, 9.9999999392252902907785028219223e-09f));
    float3 _397 = _393 * _396;
    float _398 = _394 * _396;
    float3 _399 = -_397;
    float3 _401 = (0.07999999821186065673828125f * _343).xxx;
    float _402 = dot(_338, _397);
    float _403 = max(0.0f, _402);
    float4 _405 = (float4(-1.0f, -0.0274999998509883880615234375f, -0.572000026702880859375f, 0.02199999988079071044921875f) * _339) + float4(1.0f, 0.0425000004470348358154296875f, 1.03999996185302734375f, -0.039999999105930328369140625f);
    float _406 = _405.x;
    float2 _416 = (float2(-1.03999996185302734375f, 1.03999996185302734375f) * ((min(_406 * _406, exp2((-9.27999973297119140625f) * _403)) * _406) + _405.y)) + _405.zw;
    float4 _428 = _33.SampleLevel(sampler_LinearClamp, _359, 0.0f);
    float _429 = _428.x;
    float4 _433 = _29.Load(int3(_268, 0));
    float _434 = _433.x;
    float4 _617;
    if (_434 > 0.001000000047497451305389404296875f)
    {
        float3 _444 = reflect(_399, _338);
        float3 _445 = -_28_m0.xyz;
        float _450 = dot(_445, _444);
        float3 _452 = _444 - (_445 * _450);
        bool3 _454 = (_450 < _28_m4.z).xxx;
        float3 _462 = normalize((_445 * _28_m4.z) + ((_452 * rsqrt(max(6.103515625e-05f, dot(_452, _452)))) * _28_m4.y));
        float3 _463 = float3(_454.x ? _462.x : _444.x, _454.y ? _462.y : _444.y, _454.z ? _462.z : _444.z);
        float3 _467 = _463 + _397;
        float3 _471 = _467 * rsqrt(max(6.103515625e-05f, dot(_467, _467)));
        float _472 = dot(_338, _463);
        float _473 = clamp(dot(_463, _338), 0.0f, 1.0f);
        float _475 = clamp(dot(_338, _471), 0.0f, 1.0f);
        float _478 = dot(_397, _463);
        float _480 = clamp(_402, 0.0f, 1.0f);
        float _481 = _339 * _339;
        float _482 = _481 * _481;
        float _503 = (((_475 * _482) - _475) * _475) + 1.0f;
        float _506 = 1.0f - clamp(dot(_397, _471), 0.0f, 1.0f);
        float _507 = _506 * _506;
        float _509 = (_506 * _507) * _507;
        float _533 = 1.0f - _339;
        float _540 = min(0.999000012874603271484375f, 0.4092549979686737060546875f + (_533 * (1.04997003078460693359375f + (_533 * ((-0.076194703578948974609375f) - (0.38302600383758544921875f * _533))))));
        float _541 = 1.0f - _540;
        float3 _544 = _401 + ((1.0f.xxx - _401) * 0.0476190485060214996337890625f);
        float _575 = clamp(-_478, 0.0f, 1.0f);
        float _579 = (((_575 * 0.36000001430511474609375f) - _575) * _575) + 1.0f;
        float _580 = _579 * _579;
        float3 _592 = ((min(((_401 * (1.0f - _509)) + _509.xxx) * ((_482 / (_503 * _503)) * (0.5f / (((_473 * sqrt(((((-_480) * _482) + _480) * _480) + _482)) + (_480 * sqrt(((((-_473) * _482) + _473) * _473) + _482))) + 9.9999997473787516355514526367188e-05f))), 2048.0f.xxx) + (((_544 * (((_32.SampleLevel(sampler_LinearClamp, (float2(_480, _339) * 0.96875f) + 0.015625f.xx, 0.0f).x * _32.SampleLevel(sampler_LinearClamp, (float2(_473, _339) * 0.96875f) + 0.015625f.xx, 0.0f).x) * _540) / _541)) * _544) / (1.0f.xxx - (_544 * _541)))) * lerp(clamp(_402 + 0.20000000298023223876953125f, 0.0f, 1.0f) * clamp(clamp(_478, 0.0f, 1.0f) + 0.5f, 0.0f, 1.0f), 1.0f, clamp(_478 + 1.0f, 0.0f, 1.0f))) * _299;
        float3 _602 = _28_m1.xyz * (((((_340 * _299) * 1.0f) * (float((_304 >> 3u) & 127u) * 0.0078740157186985015869140625f)) + (clamp(_592 * _28_m4.x, 0.0f.xxx, 1000.0f.xxx) * _473)) + (((((_340 / max(0.00999999977648258209228515625f, max(max(_274.x, _274.y), _274.z)).xxx) * _282) * (clamp(0.5f - _472, 0.0f, 1.0f) * ((0.36000001430511474609375f != _580) ? (0.36000001430511474609375f / _580) : 1.0f))) + (_340 * (clamp(_472 + _290, 0.0f, 1.0f) - clamp(_473, 0.0f, 1.0f)))) * _299));
        float3 _615 = lerp(_602, _602 * _30.SampleBias(sampler_LinearClamp, float2(_434, 0.5f), _9_m16).xyz, (1.0f - _434).xxx) * lerp(_429, max(_429, _299), _290);
        _617 = float4(_615.x, _615.y, _615.z, 0.0f.xxxx.w);
    }
    else
    {
        _617 = 0.0f.xxxx;
    }
    float3 _619 = _341.xxx;
    float3 _656;
    float3 _657;
    [branch]
    if (_9_m23.x != 0.0f)
    {
        float _632 = min(_20.SampleBias(sampler_PointClamp, _4, _9_m16).x, _341);
        _656 = clamp((pow(abs(_403 + _632), exp2(((-16.0f) * _339) - 1.0f)) - 1.0f) + _632, 0.0f, 1.0f).xxx;
        _657 = max(_632.xxx, ((((((_340 * 2.040400028228759765625f) - 0.3323999941349029541015625f.xxx) * _632) + ((_340 * (-4.79510021209716796875f)) + 0.6417000293731689453125f.xxx)) * _632) + ((_340 * 2.755199909210205078125f) + 0.69029998779296875f.xxx)) * _632);
    }
    else
    {
        _656 = _619;
        _657 = _619;
    }
    float3 _667 = mul(float3x3(_7_m1[0].xyz, _7_m1[1].xyz, _7_m1[2].xyz), float3(0.0f, 0.0f, 1.0f));
    float3 _676 = _371 - (_9_m105.xyz + (_667 * (-_9_m107.w)));
    float _690 = max(clamp((max(abs(_676.x), abs(_676.z)) - 464.0f) * 0.03125f, 0.0f, 1.0f), clamp((abs(_676.y) - 208.0f) * 0.03125f, 0.0f, 1.0f));
    float4 _992;
    float4 _993;
    float4 _994;
    float _995;
    float _996;
    if ((_9_m105.w != 0.0f) && (_690 < 1.0f))
    {
        float3 _703 = _371 - (_9_m105.xyz + (_667 * (-_9_m107.y)));
        float _717 = max(clamp((max(abs(_703.x), abs(_703.z)) - 29.0f) * 0.5f, 0.0f, 1.0f), clamp((abs(_703.y) - 13.0f) * 0.5f, 0.0f, 1.0f));
        float _793;
        float4 _794;
        float4 _795;
        float4 _796;
        if (_717 < 1.0f)
        {
            float3 _726 = ((_371 * 2.0f) + 0.5f.xxx) * _9_m106.xyz;
            float3 _728 = _726 - floor(_726);
            float4 _732 = _39.SampleLevel(sampler_LinearRepeat, _728, 0.0f);
            float _733 = 1.0f - _717;
            float _737 = _9_m106.y * 0.5f;
            float _742 = _728.x;
            float _743 = clamp(_728.y, _737, 1.0f - _737) * 0.3333333432674407958984375f;
            float _744 = _728.z;
            float4 _747 = _40.SampleLevel(sampler_LinearClamp, float3(_742, _743, _744), 0.0f);
            float _763 = _732.x;
            float _773 = _732.y;
            float _783 = _732.z;
            _793 = _690 + (_747.w * _733);
            _794 = float4(((_40.SampleLevel(sampler_LinearClamp, float3(_742, _743 + 0.666666686534881591796875f, _744), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _783, _783) * _733;
            _795 = float4(((_40.SampleLevel(sampler_LinearClamp, float3(_742, _743 + 0.3333333432674407958984375f, _744), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _773, _773) * _733;
            _796 = float4(((_747.xyz * 4.0f) - 2.0f.xxx) * _763, _763) * _733;
        }
        else
        {
            _793 = _690;
            _794 = 0.0f.xxxx;
            _795 = 0.0f.xxxx;
            _796 = 0.0f.xxxx;
        }
        float3 _802 = _371 - (_9_m105.xyz + (_667 * (-_9_m107.z)));
        float _816 = max(clamp((max(abs(_802.x), abs(_802.z)) - 116.0f) * 0.125f, 0.0f, 1.0f), clamp((abs(_802.y) - 52.0f) * 0.125f, 0.0f, 1.0f));
        float _896;
        float4 _897;
        float4 _898;
        float4 _899;
        if (_816 < 1.0f)
        {
            float3 _825 = ((_371 * 0.5f) + 0.5f.xxx) * _9_m106.xyz;
            float3 _827 = _825 - floor(_825);
            float4 _831 = _41.SampleLevel(sampler_LinearRepeat, _827, 0.0f);
            float _833 = _717 * (1.0f - _816);
            float _837 = _9_m106.y * 0.5f;
            float _842 = _827.x;
            float _843 = clamp(_827.y, _837, 1.0f - _837) * 0.3333333432674407958984375f;
            float _844 = _827.z;
            float4 _847 = _42.SampleLevel(sampler_LinearClamp, float3(_842, _843, _844), 0.0f);
            float _863 = _831.x;
            float _874 = _831.y;
            float _885 = _831.z;
            _896 = _793 + (_847.w * _833);
            _897 = _794 + (float4(((_42.SampleLevel(sampler_LinearClamp, float3(_842, _843 + 0.666666686534881591796875f, _844), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _885, _885) * _833);
            _898 = _795 + (float4(((_42.SampleLevel(sampler_LinearClamp, float3(_842, _843 + 0.3333333432674407958984375f, _844), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _874, _874) * _833);
            _899 = _796 + (float4(((_847.xyz * 4.0f) - 2.0f.xxx) * _863, _863) * _833);
        }
        else
        {
            _896 = _793;
            _897 = _794;
            _898 = _795;
            _899 = _796;
        }
        float4 _982;
        float4 _983;
        float4 _984;
        float _985;
        if (_816 > 0.0f)
        {
            float3 _908 = ((_371 * 0.125f) + 0.5f.xxx) * _9_m106.xyz;
            float3 _911 = _9_m106.xyz * 0.5f;
            float3 _913 = clamp(_908 - floor(_908), _911, 1.0f.xxx - _911);
            float4 _917 = _43.SampleLevel(sampler_LinearRepeat, _913, 0.0f);
            float _919 = _816 * (1.0f - _690);
            float _923 = _9_m106.y * 0.5f;
            float _928 = _913.x;
            float _929 = clamp(_913.y, _923, 1.0f - _923) * 0.3333333432674407958984375f;
            float _930 = _913.z;
            float4 _933 = _44.SampleLevel(sampler_LinearClamp, float3(_928, _929, _930), 0.0f);
            float _949 = _917.x;
            float _960 = _917.y;
            float _971 = _917.z;
            _982 = _897 + (float4(((_44.SampleLevel(sampler_LinearClamp, float3(_928, _929 + 0.666666686534881591796875f, _930), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _971, _971) * _919);
            _983 = _898 + (float4(((_44.SampleLevel(sampler_LinearClamp, float3(_928, _929 + 0.3333333432674407958984375f, _930), 0.0f).xyz * 4.0f) - 2.0f.xxx) * _960, _960) * _919);
            _984 = _899 + (float4(((_933.xyz * 4.0f) - 2.0f.xxx) * _949, _949) * _919);
            _985 = _896 + (_933.w * _919);
        }
        else
        {
            _982 = _897;
            _983 = _898;
            _984 = _899;
            _985 = _896;
        }
        float _988 = clamp((_985 * 2.0f) - 1.0f, 0.0f, 1.0f);
        _992 = _982;
        _993 = _983;
        _994 = _984;
        _995 = _988 - _690;
        _996 = (_988 + _690) * 0.5f;
    }
    else
    {
        _992 = 0.0f.xxxx;
        _993 = 0.0f.xxxx;
        _994 = 0.0f.xxxx;
        _995 = 0.0f;
        _996 = 1.0f;
    }
    float4 _1016 = _994 + float4(_9_m108.x * _996, (_9_m108.y * _996) + ((_9_m108.w * _995) * 0.5f), _9_m108.z * _996, (_9_m108.w * _996) + ((_9_m108.y * _995) * 0.375f));
    float4 _1036 = _993 + float4(_9_m109.x * _996, (_9_m109.y * _996) + ((_9_m109.w * _995) * 0.5f), _9_m109.z * _996, (_9_m109.w * _996) + ((_9_m109.y * _995) * 0.375f));
    float4 _1056 = _992 + float4(_9_m110.x * _996, (_9_m110.y * _996) + ((_9_m110.w * _995) * 0.5f), _9_m110.z * _996, (_9_m110.w * _996) + ((_9_m110.y * _995) * 0.375f));
    float4 _1214;
    float4 _1215;
    float4 _1216;
    [branch]
    if (all(bool2(_359.x >= 0.0f.xx.x, _359.y >= 0.0f.xx.y)))
    {
        float4 _1064 = _38.SampleLevel(sampler_LinearClamp, _359, 0.0f);
        float4 _1065 = abs(_1064);
        float4 _1211;
        float4 _1212;
        float4 _1213;
        [branch]
        if (any(bool4(_1065.x > 9.9999997473787516355514526367188e-05f.xxxx.x, _1065.y > 9.9999997473787516355514526367188e-05f.xxxx.y, _1065.z > 9.9999997473787516355514526367188e-05f.xxxx.z, _1065.w > 9.9999997473787516355514526367188e-05f.xxxx.w)))
        {
            float _1071 = length(_1064.yzw);
            uint _1073;
            float _1076;
            _1073 = 0u;
            _1076 = 1.0f;
            for (float _1078 = _1071; _1078 > 4.599999904632568359375f; )
            {
                _1073++;
                _1076 *= 0.5f;
                _1078 *= 0.5f;
                continue;
            }
            float4 _1082 = _1064 * _1076;
            float4 _1087 = float4(0.0f, _1082.yzw);
            float2 _1109 = (_37.SampleLevel(sampler_LinearClamp, float2(((((length(_1087) * _36_m3.x) + _36_m3.y) * 255.0f) + 0.5f) * 0.00390625f, 0.5f), 0.0f).xy * _36_m2.xy) + _36_m2.zw;
            float4 _1123;
            _1123 = float4(_1109.x * 3.5449078083038330078125f, _1087.yzw * _1109.y) * exp(_1082.x * 0.282094776630401611328125f);
            for (uint _1126 = 0u; _1126 < _1073; )
            {
                _1123 = mul(float4x4(_1123, float4(_1123.yx, 0.0f, 0.0f), float4(_1123.z, 0.0f, _1123.x, 0.0f), float4(_1123.w, 0.0f, 0.0f, _1123.x)) * 0.282094776630401611328125f, _1123);
                _1126++;
                continue;
            }
            float4x4 _1147 = float4x4(_1123, float4(_1123.yx, 0.0f, 0.0f), float4(_1123.z, 0.0f, _1123.x, 0.0f), float4(_1123.w, 0.0f, 0.0f, _1123.x)) * 0.282094776630401611328125f;
            float4 _1157 = mul(_1147, float4(_1016.w * 1.1283791065216064453125f, _1016.y * (-0.977204978466033935546875f), _1016.z * 0.977204978466033935546875f, _1016.x * (-0.977204978466033935546875f)));
            float4 _1177 = mul(_1147, float4(_1036.w * 1.1283791065216064453125f, _1036.y * (-0.977204978466033935546875f), _1036.z * 0.977204978466033935546875f, _1036.x * (-0.977204978466033935546875f)));
            float4 _1197 = mul(_1147, float4(_1056.w * 1.1283791065216064453125f, _1056.y * (-0.977204978466033935546875f), _1056.z * 0.977204978466033935546875f, _1056.x * (-0.977204978466033935546875f)));
            _1211 = float4(_1157.x * 0.886226952075958251953125f, _1157.w * (-1.02332675457000732421875f), _1157.y * (-1.02332675457000732421875f), _1157.z * 1.02332675457000732421875f).yzwx * 1.0f;
            _1212 = float4(_1177.x * 0.886226952075958251953125f, _1177.w * (-1.02332675457000732421875f), _1177.y * (-1.02332675457000732421875f), _1177.z * 1.02332675457000732421875f).yzwx * 1.0f;
            _1213 = float4(_1197.x * 0.886226952075958251953125f, _1197.w * (-1.02332675457000732421875f), _1197.y * (-1.02332675457000732421875f), _1197.z * 1.02332675457000732421875f).yzwx * 1.0f;
        }
        else
        {
            _1211 = _1016;
            _1212 = _1036;
            _1213 = _1056;
        }
        _1214 = _1211;
        _1215 = _1212;
        _1216 = _1213;
    }
    else
    {
        _1214 = _1016;
        _1215 = _1036;
        _1216 = _1056;
    }
    float _1227 = max(0.0f, dot(_1214.xyz, _338) + _1214.w);
    float _1232 = max(0.0f, dot(_1215.xyz, _338) + _1215.w);
    float _1237 = max(0.0f, dot(_1216.xyz, _338) + _1216.w);
    float3 _1225 = float3(_1227, _1232, _1237);
    float3 _nneg = -_338;
    float3 _1230rgb = max(float3(dot(_1214.xyz, _nneg) + _1214.w, dot(_1215.xyz, _nneg) + _1215.w, dot(_1216.xyz, _nneg) + _1216.w), 0.0f.xxx);
    float3 _1247 = reflect(_399, _338);
    float _1255 = (_9_m24.x - 1.0f) - (1.0f - (1.2000000476837158203125f * log2(max(_339, 0.001000000047497451305389404296875f))));
    float2 _1259 = floor(_346 * _26_m0.w);
    float _1276 = floor(_378 - _26_m2.y);
    float _1280 = clamp(_1276, 0.0f, _26_m1.x - 1.0f);
    uint _1290 = (_1276 <= _1280) ? (_23.Load(uint(_9_m21.z + int(_1259.x + (_1259.y * _26_m0.x))) * 4 + 0) & _23.Load(uint(_9_m21.w + int(_1280)) * 4 + 0)) : 0u;
    float _1293 = dot(_1225 * _9_m22.x, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
    float3 _1295;
    float _1298;
    uint _1300;
    _1295 = 0.0f.xxx;
    _1298 = 1.0f;
    _1300 = _1290;
    uint _1301;
    float3 _1296;
    float _1299;
    bool _1303;
    [loop]
    for (;;)
    {
        _1303 = _1298 > 0.00999999977648258209228515625f;
        if ((_1300 != 0u) && _1303)
        {
            uint _1307 = firstbitlow(_1300);
            _1301 = _1300 ^ (1u << (_1307 & 31u));
            float3 _1327 = float3(dot(_26_m4_words[(_1307) * 8 + 2], _375), dot(_26_m4_words[(_1307) * 8 + 3], _375), dot(_26_m4_words[(_1307) * 8 + 4], _375));
            float3 _1328 = abs(_1327);
            if (all(bool3(_1328.x <= _26_m4_words[(_1307) * 8 + 1].xyz.x, _1328.y <= _26_m4_words[(_1307) * 8 + 1].xyz.y, _1328.z <= _26_m4_words[(_1307) * 8 + 1].xyz.z)))
            {
                float3 _1337 = _26_m4_words[(_1307) * 8 + 1].xyz * 0.100000001490116119384765625f;
                float3 _1339 = _1328 * 0.100000001490116119384765625f;
                float3 _1340 = _1339 * _1339;
                float3 _1343 = (_26_m4_words[(_1307) * 8 + 1].xyz - _1328) * _26_m4_words[(_1307) * 8 + 5].xyz;
                float3 _1391;
                [branch]
                if (_26_m4_words[(_1307) * 8 + 6].x == 1.0f)
                {
                    float3 _1376 = float3(dot(_26_m4_words[(_1307) * 8 + 2].xyz, _1247), dot(_26_m4_words[(_1307) * 8 + 3].xyz, _1247), dot(_26_m4_words[(_1307) * 8 + 4].xyz, _1247));
                    float3 _1378 = (_26_m4_words[(_1307) * 8 + 1].xyz - _1327) / _1376;
                    float3 _1381 = ((-_26_m4_words[(_1307) * 8 + 1].xyz) - _1327) / _1376;
                    bool3 _1382 = bool3(_1376.x > 0.0f.xxx.x, _1376.y > 0.0f.xxx.y, _1376.z > 0.0f.xxx.z);
                    float3 _1383 = float3(_1382.x ? _1378.x : _1381.x, _1382.y ? _1378.y : _1381.y, _1382.z ? _1378.z : _1381.z);
                    _1391 = _1327 + (_1376 * min(min(_1383.x, _1383.y), _1383.z));
                }
                else
                {
                    _1391 = _1247;
                }
                float3 _1392 = normalize(_1391);
                float3 _1395 = float3(int3(sign(_1392)));
                float3 _1398 = _1392 / dot(_1392, _1395).xxx;
                float3 _1412;
                if (_1398.z < 0.0f)
                {
                    float3 _1403 = abs(_1398);
                    float2 _1410 = _1395.xy * float2(1.0f - _1403.y, 1.0f - _1403.x);
                    _1412 = float3(_1410.x, _1410.y, _1398.z);
                }
                else
                {
                    _1412 = _1398;
                }
                float _1433 = max(9.9999997473787516355514526367188e-05f, max(0.0f, dot(_26_m4_words[(_1307) * 8 + 0].xyz, _338) + _26_m4_words[(_1307) * 8 + 0].w));
                float _1446 = clamp((min(_1343.x, min(_1343.y, _1343.z)) * _26_m4_words[(_1307) * 8 + 6].y) + ((((((_1337 * _1337).x - ((_1340.x + _1340.y) + _1340.z)) * _26_m4_words[(_1307) * 8 + 5].x) * _26_m4_words[(_1307) * 8 + 5].x) * (1.0f - _26_m4_words[(_1307) * 8 + 6].y)) * 100.0f), 0.0f, 1.0f) * _26_m4_words[(_1307) * 8 + 6].w;
                _1296 = _1295 + ((((_21.SampleLevel(sampler_TrilinearClamp, float3((((_1412.xy * 0.5f) + 0.5f.xx) * _26_m1.w) + _26_m2.w.xx, _26_m4_words[(_1307) * 8 + 1].w), _1255).xyz * _26_m4_words[(_1307) * 8 + 5].w) * ((((((clamp(abs(_1293 / _1433), 0.0f, 1.0f) * 2.0f) + _1293) / (2.0f + _1433)) - 1.0f) * _9_m23.w) + 1.0f)) * _1446) * _1298);
                _1299 = _1298 * (1.0f - _1446);
            }
            else
            {
                _1296 = _1295;
                _1299 = _1298;
            }
            _1295 = _1296;
            _1298 = _1299;
            _1300 = _1301;
            continue;
        }
        else
        {
            break;
        }
    }
    float3 _1511;
    if (_1303)
    {
        float3 _1454 = normalize(_1247);
        float3 _1457 = float3(int3(sign(_1454)));
        float3 _1460 = _1454 / dot(_1454, _1457).xxx;
        float3 _1474;
        if (_1460.z < 0.0f)
        {
            float3 _1465 = abs(_1460);
            float2 _1472 = _1457.xy * float2(1.0f - _1465.y, 1.0f - _1465.x);
            _1474 = float3(_1472.x, _1472.y, _1460.z);
        }
        else
        {
            _1474 = _1460;
        }
        float _1497 = max(9.9999997473787516355514526367188e-05f, max(0.0f, dot(_26_m3.xyz, _338) + _26_m3.w));
        _1511 = _1295 + ((_21.SampleLevel(sampler_TrilinearClamp, float3((((_1474.xy * 0.5f) + 0.5f.xx) * _26_m1.w) + _26_m2.w.xx, 0.0f), _1255).xyz * ((((((clamp(abs(_1293 / _1497), 0.0f, 1.0f) * 2.0f) + _1293) / (2.0f + _1497)) - 1.0f) * _9_m23.w) + 1.0f)) * _1298);
    }
    else
    {
        _1511 = _1295;
    }
    float3 _1517 = (_1511 * _9_m23.z) * _9_m22.y;
    float3 _1540;
    [branch]
    if (_9_m23.y != 0.0f)
    {
        float4 _1534 = _19.SampleBias(sampler_LinearClamp, _4, _9_m16);
        float _1535 = _1534.x;
        _1540 = (_18.SampleBias(sampler_LinearClamp, _4, _9_m16).xyz * _1535) + (_1517 * (1.0f - _1535));
    }
    else
    {
        _1540 = _1517;
    }
    float3 _1561 = ((((_1225 * _340) * _9_m22.x) * _657) + ((_1540 * ((_401 * _416.x) + (clamp(_343 * 4.0f, 0.0f, 1.0f) * _416.y).xxx)) * _656)) + (((((_1230rgb * _9_m22.x) * _657) * (_340 / max(0.00999999977648258209228515625f, max(max(_274.x, _274.y), _274.z)).xxx)) * ((_282 * clamp(dot(_397, _338), 0.0f, 1.0f)) + (float(((_304 & 7u) << 2u) | (uint(_272.w * 3.0f) & 3u)) * 0.0322580635547637939453125f))) * 0.3183098733425140380859375f);
    float4 _1563 = float4(_617.x, _617.y, _617.z, _617.w) + float4(_1561.x, _1561.y, _1561.z, 0.0f.xxxx.w);
    float _1581 = _371.y * _9_m46.w;
    float _1586 = max(0.00999999977648258209228515625f, _1581 + _9_m47.w);
    float3 _1600 = exp(_9_m45.xyz * ((-max(0.0f, (_398 * _9_m44.w) - _9_m43.w)) * (((1.0f - exp(-_1586)) / _1586) * exp(_1581 + _9_m48.w))));
    float _1603 = dot(_399, _9_m44.xyz);
    float _1609 = _9_m45.w * _9_m45.w;
    float _1613 = (1.0f + _1609) - ((2.0f * _9_m45.w) * _1603);
    float3 _1941;
    float _1942;
    if (_9_m55.z > 0.0f)
    {
        uint3 _1767 = (uint3(int3(_265, _266, int(_9_m19 & 7u))) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
        uint _1768 = _1767.y;
        uint _1769 = _1767.z;
        uint _1772 = _1767.x + (_1768 * _1769);
        uint _1774 = _1768 + (_1769 * _1772);
        uint _1776 = _1769 + (_1772 * _1774);
        uint _1778 = _1772 + (_1774 * _1776);
        float _1802 = dot(_399, -EID4666_GetWorldToView()[2].xyz);
        float3 _1812 = _371 - EID4666_GetCameraPositionWS().xyz;
        float _1814 = (_9_m55.w * ((_1802 > 5.9604644775390625e-08f) ? (1.0f / _1802) : 0.0f)) * (1.0f / _398);
        float _1815 = _1812.y;
        float _1816 = _1814 * _1815;
        float _1818 = EID4666_GetCameraPositionWS().y + _1816;
        float _1819 = _1815 - _1816;
        float _1821 = (1.0f - _1814) * _398;
        float _1835 = max(-127.0f, _9_m49.z * _1819);
        float _1859 = max(-127.0f, _9_m52.x * _1819);
        float _1870 = ((_9_m49.y * exp2(-max(-127.0f, _9_m49.z * (_1818 - _9_m49.x)))) * ((abs(_1835) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-_1835)) / _1835) : (0.693147182464599609375f - (0.2402265071868896484375f * _1835)))) + ((_9_m52.y * exp2(-max(-127.0f, _9_m52.x * (_1818 - _9_m52.z)))) * ((abs(_1859) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-_1859)) / _1859) : (0.693147182464599609375f - (0.2402265071868896484375f * _1859))));
        float _1892 = clamp((_398 * _9_m50.w) + _9_m50.z, 0.0f, 1.0f);
        float _1895 = clamp((max(clamp(exp2(-(_1870 * _1821)), 0.0f, 1.0f), _9_m51.w) + clamp((_398 * _9_m50.y) + _9_m50.x, 0.0f, 1.0f)) + _1892, 0.0f, 1.0f);
        float4 _1935 = lerp(float4(0.0f, 0.0f, 0.0f, 1.0f), _34.SampleLevel(sampler_LinearClamp, float3((_346 + ((((float3(uint3(_1778, _1774 + (_1776 * _1778), _256) >> uint3(16u, 16u, 16u)) * 1.525902189314365386962890625e-05f.xxx) * 2.0f) - 1.0f.xxx) * _9_m59.w).xy) * _9_m57.xy, (log2((_378 * _9_m56.x) + _9_m56.y) * _9_m56.z) / _9_m55.z), 0.0f), clamp((_378 - _9_m58.z) * 1000000.0f, 0.0f, 1.0f).xxxx);
        float _1937 = _1935.w;
        _1941 = _1935.xyz + (((_9_m51.xyz * (1.0f - _1895)) + (((_9_m54.xyz * pow(clamp(dot(_397, _9_m53.xyz), 0.0f, 1.0f), _9_m54.w)) * (1.0f - clamp(exp2(-(_1870 * max(_1821 - _9_m53.w, 0.0f))), 0.0f, 1.0f))) * (1.0f - _1892))) * _1937);
        _1942 = _1937 * _1895;
    }
    else
    {
        float3 _1643 = _371 - EID4666_GetCameraPositionWS().xyz;
        float _1645 = _1643.y;
        float _1659 = max(-127.0f, _9_m49.z * _1645);
        float _1683 = max(-127.0f, _9_m52.x * _1645);
        float _1694 = ((_9_m49.y * exp2(-max(-127.0f, _9_m49.z * (EID4666_GetCameraPositionWS().y - _9_m49.x)))) * ((abs(_1659) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-_1659)) / _1659) : (0.693147182464599609375f - (0.2402265071868896484375f * _1659)))) + ((_9_m52.y * exp2(-max(-127.0f, _9_m52.x * (EID4666_GetCameraPositionWS().y - _9_m52.z)))) * ((abs(_1683) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-_1683)) / _1683) : (0.693147182464599609375f - (0.2402265071868896484375f * _1683))));
        float _1716 = clamp((_398 * _9_m50.w) + _9_m50.z, 0.0f, 1.0f);
        float _1719 = clamp((max(clamp(exp2(-(_1694 * _398)), 0.0f, 1.0f), _9_m51.w) + clamp((_398 * _9_m50.y) + _9_m50.x, 0.0f, 1.0f)) + _1716, 0.0f, 1.0f);
        _1941 = (_9_m51.xyz * (1.0f - _1719)) + (((_9_m54.xyz * pow(clamp(dot(_397, _9_m53.xyz), 0.0f, 1.0f), _9_m54.w)) * (1.0f - clamp(exp2(-(_1694 * max(_398 - _9_m53.w, 0.0f))), 0.0f, 1.0f))) * (1.0f - _1716));
        _1942 = _1719;
    }
    float3 _1945 = _1600 * _1942;
    float3 _1947 = (clamp(_1563.xyz, 0.0f.xxx, 255.0f.xxx).xyz * _1945) + ((((clamp(((_9_m46.xyz * (0.0596831031143665313720703125f * (1.0f + (_1603 * _1603)))) + _9_m48.xyz) + (_9_m47.xyz * ((1.0f - _1609) / max((12.56637096405029296875f * _1613) * sqrt(_1613), 0.001000000047497451305389404296875f))), 0.0f.xxx, 1.0f.xxx) * 255.0f) * (1.0f.xxx - _1600)) * _1942) + _1941);
    float4 _1949 = float4(_1947.x, _1947.y, _1947.z, _1563.w);
    _1949.w = dot(_1945, 0.3333333432674407958984375f.xxx);
    _5 = _1949;
}

EID_FS_Output EID_OriginalFS(EID_FS_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    _4 = stage_input._4;
    frag_main();
    EID_FS_Output stage_output;
    stage_output._5 = _5;
    return stage_output;
}
