// PS210085 translated from original SPIR-V; mesh input adapter, no EID3336 material algorithm.
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
static float _197;

cbuffer EID3899Frame
{
    column_major float4x4 _11_m0 : packoffset(c0);
    column_major float4x4 _11_m1 : packoffset(c4);
    column_major float4x4 _11_m2 : packoffset(c8);
    column_major float4x4 _11_m3 : packoffset(c12);
    column_major float4x4 _11_m4 : packoffset(c16);
    column_major float4x4 _11_m5 : packoffset(c20);
    column_major float4x4 _11_m6 : packoffset(c24);
    column_major float4x4 _11_m7 : packoffset(c28);
    column_major float4x4 _11_m8 : packoffset(c32);
    column_major float4x4 _11_m9 : packoffset(c36);
    column_major float4x4 _11_m10 : packoffset(c40);
    float4 _11_m11 : packoffset(c44);
    column_major float4x4 _11_m12 : packoffset(c45);
    column_major float4x4 _11_m13 : packoffset(c49);
    column_major float4x4 _11_m14 : packoffset(c53);
    column_major float4x4 _11_m15 : packoffset(c57);
    column_major float4x4 _11_m16 : packoffset(c61);
    column_major float4x4 _11_m17 : packoffset(c65);
    column_major float4x4 _11_m18 : packoffset(c69);
    column_major float4x4 _11_m19 : packoffset(c73);
    column_major float4x4 _11_m20 : packoffset(c77);
    float4 _11_m21 : packoffset(c81);
};

cbuffer EID3899FrameParameters
{
    float4 _13_m0 : packoffset(c0);
    float4 _13_m1 : packoffset(c1);
    float4 _13_m2 : packoffset(c2);
    float4 _13_m3 : packoffset(c3);
    float4 _13_m4 : packoffset(c4);
    float4 _13_m5 : packoffset(c5);
    float4 _13_m6[6] : packoffset(c6);
    float4 _13_m7[6] : packoffset(c12);
    float4 _13_m8 : packoffset(c18);
    float4 _13_m9 : packoffset(c19);
    float4 _13_m10 : packoffset(c20);
    float4 _13_m11 : packoffset(c21);
    float4 _13_m12 : packoffset(c22);
    float4 _13_m13 : packoffset(c23);
    float4 _13_m14 : packoffset(c24);
    float4 _13_m15 : packoffset(c25);
    float _13_m16 : packoffset(c26);
    float _13_m17 : packoffset(c26.y);
    float _13_m18 : packoffset(c26.z);
    uint _13_m19 : packoffset(c26.w);
    float4 _13_m20 : packoffset(c27);
    int4 _13_m21 : packoffset(c28);
    float4 _13_m22 : packoffset(c29);
    float4 _13_m23 : packoffset(c30);
    float4 _13_m24 : packoffset(c31);
    float4 _13_m25 : packoffset(c32);
    float4 _13_m26 : packoffset(c33);
    float4 _13_m27 : packoffset(c34);
    float4 _13_m28 : packoffset(c35);
    float4 _13_m29 : packoffset(c36);
    float4 _13_m30 : packoffset(c37);
    float4 _13_m31 : packoffset(c38);
    float4 _13_m32[4] : packoffset(c39);
    float4 _13_m33[4] : packoffset(c43);
    float4 _13_m34[4] : packoffset(c47);
    float4 _13_m35[4] : packoffset(c51);
    float4 _13_m36 : packoffset(c55);
    float4 _13_m37 : packoffset(c56);
    float4 _13_m38[4] : packoffset(c57);
    float4 _13_m39[4] : packoffset(c61);
    float4 _13_m40[4] : packoffset(c65);
    float4 _13_m41 : packoffset(c69);
    float4 _13_m42 : packoffset(c70);
    float4 _13_m43 : packoffset(c71);
    float4 _13_m44 : packoffset(c72);
    float4 _13_m45 : packoffset(c73);
    float4 _13_m46 : packoffset(c74);
    float4 _13_m47 : packoffset(c75);
    float4 _13_m48 : packoffset(c76);
    float4 _13_m49 : packoffset(c77);
    float4 _13_m50 : packoffset(c78);
    float4 _13_m51 : packoffset(c79);
    float4 _13_m52 : packoffset(c80);
    float4 _13_m53 : packoffset(c81);
    float4 _13_m54 : packoffset(c82);
    float4 _13_m55 : packoffset(c83);
    float4 _13_m56 : packoffset(c84);
    float4 _13_m57 : packoffset(c85);
    float4 _13_m58 : packoffset(c86);
    float4 _13_m59 : packoffset(c87);
    float4 _13_m60 : packoffset(c88);
    float4 _13_m61 : packoffset(c89);
    float4 _13_m62 : packoffset(c90);
    float4 _13_m63 : packoffset(c91);
    float4 _13_m64 : packoffset(c92);
    float4 _13_m65 : packoffset(c93);
    float4 _13_m66 : packoffset(c94);
    float4 _13_m67 : packoffset(c95);
    float4 _13_m68 : packoffset(c96);
    float4 _13_m69 : packoffset(c97);
    float4 _13_m70 : packoffset(c98);
    float4 _13_m71 : packoffset(c99);
    float4 _13_m72 : packoffset(c100);
    float4 _13_m73 : packoffset(c101);
    float4 _13_m74 : packoffset(c102);
    float4 _13_m75 : packoffset(c103);
    float4 _13_m76 : packoffset(c104);
    float4 _13_m77 : packoffset(c105);
    float4 _13_m78 : packoffset(c106);
    float4 _13_m79 : packoffset(c107);
    float4 _13_m80 : packoffset(c108);
    float4 _13_m81 : packoffset(c109);
    float4 _13_m82 : packoffset(c110);
    float4 _13_m83 : packoffset(c111);
    float4 _13_m84 : packoffset(c112);
    float4 _13_m85 : packoffset(c113);
    float4 _13_m86 : packoffset(c114);
    float4 _13_m87 : packoffset(c115);
    float4 _13_m88 : packoffset(c116);
    float4 _13_m89 : packoffset(c117);
    float4 _13_m90 : packoffset(c118);
    float4 _13_m91 : packoffset(c119);
    float4 _13_m92 : packoffset(c120);
    float4 _13_m93 : packoffset(c121);
    float4 _13_m94 : packoffset(c122);
    float4 _13_m95 : packoffset(c123);
    float4 _13_m96 : packoffset(c124);
    float4 _13_m97 : packoffset(c125);
    float4 _13_m98 : packoffset(c126);
    float4 _13_m99[2] : packoffset(c127);
    float4 _13_m100[2] : packoffset(c129);
    float _13_m101 : packoffset(c131);
    float _13_m102 : packoffset(c131.y);
    float _13_m103 : packoffset(c131.z);
    float _13_m104 : packoffset(c131.w);
    float4 _13_m105 : packoffset(c132);
    float4 _13_m106 : packoffset(c133);
    float4 _13_m107 : packoffset(c134);
    float4 _13_m108 : packoffset(c135);
    float4 _13_m109 : packoffset(c136);
    float4 _13_m110 : packoffset(c137);
    float4 _13_m111 : packoffset(c138);
    float4 _13_m112 : packoffset(c139);
    float4 _13_m113 : packoffset(c140);
    float4 _13_m114 : packoffset(c141);
    float4 _13_m115 : packoffset(c142);
    float4 _13_m116 : packoffset(c143);
    float4 _13_m117 : packoffset(c144);
    float4 _13_m118 : packoffset(c145);
    float4 _13_m119 : packoffset(c146);
    float4 _13_m120 : packoffset(c147);
    float4 _13_m121 : packoffset(c148);
    float4 _13_m122 : packoffset(c149);
    float4 _13_m123 : packoffset(c150);
    float4 _13_m124 : packoffset(c151);
    float4 _13_m125 : packoffset(c152);
    float4 _13_m126 : packoffset(c153);
    float4 _13_m127 : packoffset(c154);
    float4 _13_m128 : packoffset(c155);
    float4 _13_m129 : packoffset(c156);
    float4 _13_m130 : packoffset(c157);
    float4 _13_m131 : packoffset(c158);
    float4 _13_m132 : packoffset(c159);
    float4 _13_m133 : packoffset(c160);
    float4 _13_m134 : packoffset(c161);
    column_major float4x4 _13_m135 : packoffset(c162);
    float4 _13_m136 : packoffset(c166);
    float4 _13_m137 : packoffset(c167);
    float4 _13_m138[32] : packoffset(c168);
};

cbuffer EID3899TerrainParameters
{
    float4 _22_m0 : packoffset(c0);
    float4 _22_m1 : packoffset(c1);
    float4 _22_m2 : packoffset(c2);
    float4 _22_m3 : packoffset(c3);
    float4 _22_m4 : packoffset(c4);
    int4 _22_m5 : packoffset(c5);
    float4 _22_m6 : packoffset(c6);
    float4 _22_m7 : packoffset(c7);
    float4 _22_m8 : packoffset(c8);
    float4 _22_m9 : packoffset(c9);
    float4 _22_m10 : packoffset(c10);
    uint _22_m11 : packoffset(c11);
    uint _22_m12 : packoffset(c11.y);
    float _22_m13 : packoffset(c11.z);
    float _22_m14 : packoffset(c11.w);
    float _22_m15 : packoffset(c12);
    float _22_m16 : packoffset(c12.y);
    float _22_m17 : packoffset(c12.z);
    float _22_m18 : packoffset(c12.w);
};

cbuffer EID3899PageTable
{
    uint4 _24_m0[64] : packoffset(c0);
    uint4 _24_m1[1024] : packoffset(c64);
    int4 _24_m2 : packoffset(c1088);
    int4 _24_m3 : packoffset(c1089);
    uint4 _24_m4 : packoffset(c1090);
};

cbuffer EID3899Layers
{
    float4 _26_m0[64] : packoffset(c0);
    float4 _26_m1[64] : packoffset(c64);
    float4 _26_m2[64] : packoffset(c128);
    float4 _26_m3[64] : packoffset(c192);
    float4 _26_m4[64] : packoffset(c256);
    float4 _26_m5[64] : packoffset(c320);
    float4 _26_m6[64] : packoffset(c384);
};

cbuffer UnityPerMaterial
{
    float _28_m0 : packoffset(c0);
    float _28_m1 : packoffset(c0.y);
    float _28_m2 : packoffset(c0.z);
    float _28_m3 : packoffset(c0.w);
    float _28_m4 : packoffset(c1);
    float _28_m5 : packoffset(c1.y);
    float _28_m6 : packoffset(c1.z);
    float _28_m7 : packoffset(c1.w);
    float _28_m8 : packoffset(c2);
    float _28_m9 : packoffset(c2.y);
    float _28_m10 : packoffset(c2.z);
    float _28_m11 : packoffset(c2.w);
    float _28_m12 : packoffset(c3);
    float _28_m13 : packoffset(c3.y);
    float _28_m14 : packoffset(c3.z);
    float _28_m15 : packoffset(c3.w);
    float _28_m16 : packoffset(c4);
    float _28_m17 : packoffset(c4.y);
    float _28_m18 : packoffset(c4.z);
    float _28_m19 : packoffset(c4.w);
    float4 _28_m20 : packoffset(c5);
    float4 _28_m21 : packoffset(c6);
    float4 _28_m22 : packoffset(c7);
    float4 _28_m23 : packoffset(c8);
    float4 _28_m24 : packoffset(c9);
    float4 _28_m25 : packoffset(c10);
    float _28_m26 : packoffset(c11);
    float _28_m27 : packoffset(c11.y);
    float _28_m28 : packoffset(c11.z);
    float _28_m29 : packoffset(c11.w);
    float _28_m30 : packoffset(c12);
    float _28_m31 : packoffset(c12.y);
    float4 _28_m32 : packoffset(c13);
    float4 _28_m33 : packoffset(c14);
    float _EID3899CapturedCameraParameters : packoffset(c15);
};


SamplerState sampler_EID3899_point_clamp;
SamplerState sampler_EID3899_linear_clamp;
SamplerState sampler_EID3899_trilinear_repeat;
Texture2D<float4> _29;
Texture2D<float4> _30;
Texture2D<float4> _31;
Texture2D<float4> _32;
Texture2D<float4> _33;
Texture2DArray<float4> _34;
Texture2DArray<float4> _35;
Texture2D<float4> _36;
Texture2D<float4> _37;
Texture2D<float4> _38;
Texture2D<float4> _39;
Texture2D<float4> _40;
Texture2D<float4> _41;


static float3 EID3899PositionWS;
static float4 gl_FragCoord;
static float2 _4;
static float4 _5, _6, _7, _8, _9;
struct EID3899Attributes { float3 positionOS : POSITION; };
struct EID3899Varyings { float4 positionCS : SV_POSITION; float3 positionWS : TEXCOORD0; };
struct EID3899Output {float4 rt0:SV_Target0;float4 rt1:SV_Target1;float4 rt2:SV_Target2;float4 rt3:SV_Target3;float4 rt4:SV_Target4;};
EID3899Varyings EID3899Vertex(EID3899Attributes input) {
 EID3899Varyings o; o.positionWS=TransformObjectToWorld(input.positionOS);o.positionCS=TransformWorldToHClip(o.positionWS);return o;
}
void frag_main()
{
    // Original fullscreen pass reconstructed this from terrain depth.
    // Mesh path supplies the same world position, now rasterized by the live Unity camera.
    float3 _224 = EID3899PositionWS;
    float3 _225 = _224.xyz;
    float4 _244 = _EID3899CapturedCameraParameters > 0.5
        ? mul(_11_m15, float4((_225 - _11_m11.xyz) + (_11_m11.xyz - _11_m21.xyz), 1.0f))
        : TransformWorldToHClip(_225);
    float2 _245 = float4(gl_FragCoord.xy, _197, _197).xy;
    uint2 _250 = uint2(_245);
    float3 _264;
    do
    {
        if (_13_m4.w == 0.0f)
        {
            _264 = (_EID3899CapturedCameraParameters > 0.5 ? _11_m11.xyz : GetCameraPositionWS()) - _225;
            break;
        }
        else
        {
            _264 = (_EID3899CapturedCameraParameters > 0.5 ? _11_m0[2].xyz : UNITY_MATRIX_V[2].xyz);
            break;
        }
        break; // unreachable workaround
    } while(false);
    float _274;
    float2 _278;
    int2 _283;
    int _288;
    int2 _289;
    int _295;
    float3 _268 = _264 * rsqrt(max(dot(_264, _264), 9.9999999392252902907785028219223e-09f));
    float2 _876;
    do
    {
        float2 _271 = _224.xz;
        _274 = _22_m4.z;
        float2 _275 = _274.xx;
        _278 = _22_m4.xy;
        float2 _279 = (_271 / _275) - _278;
        int2 _280 = int2(_279);
        _283 = _24_m3.xy;
        int2 _284 = _280 - _283;
        bool2 _285 = bool2(_280.x >= int2(0, 0).x, _280.y >= int2(0, 0).y);
        _288 = _22_m5.x;
        _289 = _288.xx;
        bool2 _290 = bool2(_280.x < _289.x, _280.y < _289.y);
        bool2 _291 = bool2(_285.x && _290.x, _285.y && _290.y);
        bool2 _292 = bool2(_284.x >= int2(1, 1).x, _284.y >= int2(1, 1).y);
        bool2 _293 = bool2(_291.x && _292.x, _291.y && _292.y);
        _295 = _24_m3.z;
        int2 _297 = (_295 - 1).xx;
        bool2 _298 = bool2(_284.x < _297.x, _284.y < _297.y);
        bool _300 = all(bool2(_293.x && _298.x, _293.y && _298.y));
        float _428;
        float _429;
        bool _430;
        if (_300)
        {
            int _306 = (_284.y * _295) + _284.x;
            uint4 _317 = (_24_m0[clamp(_306 >> 2, 0, 63)] >> (uint((_306 & 3) << 3).xxxx & uint4(31u, 31u, 31u, 31u))) & uint4(255u, 255u, 255u, 255u);
            uint _327 = (((_317.w << 24u) | (_317.z << 16u)) | (_317.y << 8u)) | _317.x;
            uint _329 = (_327 >> 20u) & 1023u;
            float _330 = float(_329);
            float2 _340 = (_279 * float(1u << (uint(_22_m6.x) & 31u))) * _22_m6.y;
            float2 _341 = ddx(_340);
            float2 _342 = ddy(_340);
            float _343 = dot(_341, _341);
            float _344 = dot(_342, _342);
            float _345 = _22_m6.x - _330;
            float _349 = (0.5f * log2(max(_343, _344))) - _345;
            float _353 = (0.5f * log2(min(_343, _344))) - _345;
            float2 _354 = frac(_279);
            bool2 _355 = bool2(_284.x >= int2(0, 0).x, _284.y >= int2(0, 0).y);
            bool2 _356 = bool2(_291.x && _355.x, _291.y && _355.y);
            int2 _357 = _295.xx;
            bool2 _358 = bool2(_284.x < _357.x, _284.y < _357.y);
            bool _360 = all(bool2(_356.x && _358.x, _356.y && _358.y));
            float4 _393;
            bool _394;
            if (_360)
            {
                float _365 = float(1u << (_329 & 31u));
                float4 _388 = round(_37.SampleLevel(sampler_EID3899_point_clamp, (clamp(_354 * _365, 0.5f.xx, (_365 - 0.5f).xx) + float2(float(_327 & 1023u), float((_327 >> 10u) & 1023u))) * _22_m6.w, floor(clamp(lerp(_349, _353, 0.449999988079071044921875f), 0.0f, _330))) * 255.0f);
                float3 _389 = _388.xyz;
                _393 = _388;
                _394 = !all(bool3(_389.x > 254.0f.xxx.x, _389.y > 254.0f.xxx.y, _389.z > 254.0f.xxx.z));
            }
            else
            {
                _393 = 0.0f.xxxx;
                _394 = false;
            }
            bool _395 = _360 && _394;
            float _424;
            if (_395)
            {
                _424 = _41.SampleLevel(sampler_EID3899_point_clamp, ((clamp(frac(_354 * exp2(_22_m6.x - _393.z)) * _22_m6.y, 0.5f.xx, (_22_m6.y - 0.5f).xx) + _22_m16.xx) + (_393.xy * _22_m15)) * _22_m6.z, 0.0f).z;
            }
            else
            {
                _424 = 1.0f;
            }
            _428 = _353;
            _429 = _349;
            _430 = _300 && (_395 && (_424 > 0.0f));
        }
        else
        {
            _428 = 0.0f;
            _429 = 0.0f;
            _430 = _300;
        }
        if (!_430)
        {
            _876 = _271;
            break;
        }
        float2 _437 = clamp(_279, 0.0f.xx, (float(_288) - 9.9999997473787516355514526367188e-05f).xx);
        int2 _438 = int2(_437);
        int _439 = _438.x;
        int _440 = _438.y;
        int _443 = (_439 | (_439 << 4)) & 3855;
        int _446 = (_443 | (_443 << 2)) & 13107;
        int _452 = (_440 | (_440 << 4)) & 3855;
        int _455 = (_452 | (_452 << 2)) & 13107;
        int _460 = ((_446 | (_446 << 1)) & 21845) | (((_455 | (_455 << 1)) & 21845) << 1);
        uint4 _471 = (_24_m1[clamp(_460 >> 2, 0, 1023)] >> (uint((_460 & 3) << 3).xxxx & uint4(31u, 31u, 31u, 31u))) & uint4(255u, 255u, 255u, 255u);
        uint _481 = (((_471.w << 24u) | (_471.z << 16u)) | (_471.y << 8u)) | _471.x;
        int _484 = int((_481 >> 16u) & 255u);
        int2 _486 = _484.xx & int2(31, 31);
        int _501 = int(_481 & 65535u) - 1;
        float2 _536 = (_29.SampleLevel(sampler_EID3899_linear_clamp, ((((((_437 - float2((_438 >> _486) << _486)) / float(1 << (_484 & 31)).xx).xyxy * _22_m0.xxyy) + (float2(float(_501 & (_22_m5.y - 1)), float(_501 >> (_22_m5.z & 31))) * _22_m4.w).xyxy) + _22_m1.xxyy) * float2(1.0f, _22_m14).xyxy).xy, 0.0f).xy * 2.0f) - 1.0f.xx;
        float _540 = 1.0f - dot(1.0f.xx, abs(_536));
        float3 _542 = float3(_536.x, _540, _536.y);
        float3 _554;
        if (_540 < 0.0f)
        {
            float2 _549 = _542.xz;
            bool2 _550 = bool2(_549.x >= 0.0f.xx.x, _549.y >= 0.0f.xx.y);
            float2 _552 = (1.0f.xx - abs(_542.zx)) * float2(_550.x ? 1.0f.xx.x : (-1.0f).xx.x, _550.y ? 1.0f.xx.y : (-1.0f).xx.y);
            _554 = float3(_552.x, _542.y, _552.y);
        }
        else
        {
            _554 = _542;
        }
        float3 _555 = normalize(_554);
        float3 _557 = normalize(cross(_555, float3(0.0f, 0.0f, 1.0f)));
        float3 _558 = cross(_557, _555);
        float3 _563 = normalize(float3(dot(_268, _557), dot(_268, _558), dot(_268, _555)));
        float _566 = _563.z;
        float2 _569 = ((-_563.xy) / _566.xx) * 0.300000011920928955078125f;
        float _570 = _569.x;
        float3 _575 = (_557 * _570) + (_558 * _569.y);
        float3 _576 = float3(_575.x, _575.z, float3(_570, _569.y, -1.0f).z);
        float2 _577 = _575.xz;
        float _583 = length(_577);
        float3 _585;
        float _592;
        _585 = float3(_271 - (_577 * 0.5f), 1.0f);
        _592 = 0.0f;
        float3 _586;
        bool _589;
        float _593;
        bool _723;
        bool _588 = true;
        uint _590 = 0u;
        for (;;)
        {
            if ((_590 < 8u) && _588)
            {
                float2 _600 = (_585.xy / _275) - _278;
                int2 _601 = int2(_600);
                float2 _602 = frac(_600);
                int2 _603 = _601 - _283;
                bool2 _604 = bool2(_601.x >= int2(0, 0).x, _601.y >= int2(0, 0).y);
                bool2 _605 = bool2(_601.x < _289.x, _601.y < _289.y);
                bool2 _606 = bool2(_604.x && _605.x, _604.y && _605.y);
                bool2 _607 = bool2(_603.x >= int2(0, 0).x, _603.y >= int2(0, 0).y);
                bool2 _608 = bool2(_606.x && _607.x, _606.y && _607.y);
                int2 _609 = _295.xx;
                bool2 _610 = bool2(_603.x < _609.x, _603.y < _609.y);
                bool _612 = all(bool2(_608.x && _610.x, _608.y && _610.y));
                float4 _673;
                bool _674;
                if (_612)
                {
                    int _618 = (_603.y * _295) + _603.x;
                    uint4 _629 = (_24_m0[clamp(_618 >> 2, 0, 63)] >> (uint((_618 & 3) << 3).xxxx & uint4(31u, 31u, 31u, 31u))) & uint4(255u, 255u, 255u, 255u);
                    uint _639 = (((_629.w << 24u) | (_629.z << 16u)) | (_629.y << 8u)) | _629.x;
                    uint _641 = (_639 >> 20u) & 1023u;
                    float _645 = float(1u << (_641 & 31u));
                    float4 _668 = round(_37.SampleLevel(sampler_EID3899_point_clamp, (clamp(_602 * _645, 0.5f.xx, (_645 - 0.5f).xx) + float2(float(_639 & 1023u), float((_639 >> 10u) & 1023u))) * _22_m6.w, floor(clamp(lerp(_429, _428, 0.449999988079071044921875f), 0.0f, float(_641)))) * 255.0f);
                    float3 _669 = _668.xyz;
                    _673 = _668;
                    _674 = !all(bool3(_669.x > 254.0f.xxx.x, _669.y > 254.0f.xxx.y, _669.z > 254.0f.xxx.z));
                }
                else
                {
                    _673 = 0.0f.xxxx;
                    _674 = false;
                }
                bool _675 = _612 && _674;
                float _709;
                float _710;
                if (_675)
                {
                    float4 _706 = _41.SampleLevel(sampler_EID3899_point_clamp, ((clamp(frac(_602 * exp2(_22_m6.x - _673.z)) * _22_m6.y, 0.5f.xx, (_22_m6.y - 0.5f).xx) + _22_m16.xx) + (_673.xy * _22_m15)) * _22_m6.z, 0.0f);
                    _709 = _706.x;
                    _710 = _706.z;
                }
                else
                {
                    _709 = 0.5f;
                    _710 = 1.0f;
                }
                _589 = _588 && (_675 && (_710 > 0.0f));
                if ((_709 >= _585.z) || (!_589))
                {
                    _723 = _589;
                    break;
                }
                _593 = ((_585.z - _709) * _710) / (_710 + _583);
                _586 = _585 + (_576 * _593);
                _585 = _586;
                _588 = _589;
                _590++;
                _592 = _593;
                continue;
            }
            else
            {
                _723 = _588;
                break;
            }
        }
        float3 _725 = _585 - (_576 * _592);
        float3 _730 = _576 * (0.5f * (_725.z - _585.z));
        float3 _733;
        float3 _736;
        bool _738;
        _733 = _725 + _730;
        _736 = _730;
        _738 = _723;
        float3 _737;
        bool _739;
        float3 _734;
        for (uint _740 = 0u; (_740 < 3u) && _738; _733 = _734, _736 = _737, _738 = _739, _740++)
        {
            float2 _748 = (_733.xy / _275) - _278;
            int2 _749 = int2(_748);
            float2 _750 = frac(_748);
            int2 _751 = _749 - _283;
            bool2 _752 = bool2(_749.x >= int2(0, 0).x, _749.y >= int2(0, 0).y);
            bool2 _753 = bool2(_749.x < _289.x, _749.y < _289.y);
            bool2 _754 = bool2(_752.x && _753.x, _752.y && _753.y);
            bool2 _755 = bool2(_751.x >= int2(0, 0).x, _751.y >= int2(0, 0).y);
            bool2 _756 = bool2(_754.x && _755.x, _754.y && _755.y);
            int2 _757 = _295.xx;
            bool2 _758 = bool2(_751.x < _757.x, _751.y < _757.y);
            bool _760 = all(bool2(_756.x && _758.x, _756.y && _758.y));
            float4 _821;
            bool _822;
            if (_760)
            {
                int _766 = (_751.y * _295) + _751.x;
                uint4 _777 = (_24_m0[clamp(_766 >> 2, 0, 63)] >> (uint((_766 & 3) << 3).xxxx & uint4(31u, 31u, 31u, 31u))) & uint4(255u, 255u, 255u, 255u);
                uint _787 = (((_777.w << 24u) | (_777.z << 16u)) | (_777.y << 8u)) | _777.x;
                uint _789 = (_787 >> 20u) & 1023u;
                float _793 = float(1u << (_789 & 31u));
                float4 _816 = round(_37.SampleLevel(sampler_EID3899_point_clamp, (clamp(_750 * _793, 0.5f.xx, (_793 - 0.5f).xx) + float2(float(_787 & 1023u), float((_787 >> 10u) & 1023u))) * _22_m6.w, floor(clamp(lerp(_429, _428, 0.449999988079071044921875f), 0.0f, float(_789)))) * 255.0f);
                float3 _817 = _816.xyz;
                _821 = _816;
                _822 = !all(bool3(_817.x > 254.0f.xxx.x, _817.y > 254.0f.xxx.y, _817.z > 254.0f.xxx.z));
            }
            else
            {
                _821 = 0.0f.xxxx;
                _822 = false;
            }
            bool _823 = _760 && _822;
            float _857;
            float _858;
            if (_823)
            {
                float4 _854 = _41.SampleLevel(sampler_EID3899_point_clamp, ((clamp(frac(_750 * exp2(_22_m6.x - _821.z)) * _22_m6.y, 0.5f.xx, (_22_m6.y - 0.5f).xx) + _22_m16.xx) + (_821.xy * _22_m15)) * _22_m6.z, 0.0f);
                _857 = _854.x;
                _858 = _854.z;
            }
            else
            {
                _857 = 0.5f;
                _858 = 1.0f;
            }
            _739 = _738 && (_823 && (_858 > 0.0f));
            _737 = _736 * 0.5f;
            if (_857 < _733.z)
            {
                _734 = _733 + _737;
            }
            else
            {
                _734 = _733 - _737;
            }
        }
        if (_738)
        {
            _876 = lerp(_271, _733.xy, smoothstep(0.07999999821186065673828125f, 0.119999997317790985107421875f, abs(_566)).xx).xy;
            break;
        }
        _876 = _271;
        break;
    } while(false);
    float3 _880 = float3(_876.x, _224.y, _876.y);
    float3 _881 = ddx(_880);
    float3 _882 = ddy(_880);
    float _883 = 1.0f / _274;
    float2 _884 = _880.xz;
    float2 _892 = max(0.0f.xx, min((_884 * _883) - _278, float2(_22_m5.xx) - 9.9999999747524270787835121154785e-07f.xx));
    int2 _893 = int2(_892);
    float2 _894 = frac(_892);
    int2 _895 = _893 - _283;
    bool2 _896 = bool2(_893.x >= int2(0, 0).x, _893.y >= int2(0, 0).y);
    bool2 _897 = bool2(_893.x < _289.x, _893.y < _289.y);
    bool2 _898 = bool2(_896.x && _897.x, _896.y && _897.y);
    bool2 _899 = bool2(_895.x >= int2(0, 0).x, _895.y >= int2(0, 0).y);
    bool2 _900 = bool2(_898.x && _899.x, _898.y && _899.y);
    int2 _901 = _295.xx;
    bool2 _902 = bool2(_895.x < _901.x, _895.y < _901.y);
    bool _904 = all(bool2(_900.x && _902.x, _900.y && _902.y));
    float4 _1051;
    float2 _1052;
    float2 _1053;
    bool _1054;
    if (_904)
    {
        int _910 = (_895.y * _295) + _895.x;
        uint4 _921 = (_24_m0[clamp(_910 >> 2, 0, 63)] >> (uint((_910 & 3) << 3).xxxx & uint4(31u, 31u, 31u, 31u))) & uint4(255u, 255u, 255u, 255u);
        uint _931 = (((_921.w << 24u) | (_921.z << 16u)) | (_921.y << 8u)) | _921.x;
        uint _933 = (_931 >> 20u) & 1023u;
        float _934 = float(_933);
        float _937 = float(1u << (_933 & 31u));
        float2 _946 = _881.xz * _883;
        float2 _948 = _882.xz * _883;
        float _957 = float(1u << (uint(_22_m6.x) & 31u)) * _22_m6.y;
        float2 _958 = _946 * _957;
        float2 _959 = _948 * _957;
        float _960 = dot(_958, _958);
        float _961 = dot(_959, _959);
        float _962 = _22_m6.x - _934;
        float _973 = floor(clamp(lerp((0.5f * log2(max(_960, _961))) - _962, (0.5f * log2(min(_960, _961))) - _962, 0.449999988079071044921875f), 0.0f, _934));
        float4 _988 = round(_37.SampleLevel(sampler_EID3899_point_clamp, (floor(clamp(_894 * _937, 0.5f.xx, (_937 - 0.5f).xx) + float2(float(_931 & 1023u), float((_931 >> 10u) & 1023u))) + 0.5f.xx) * _22_m6.w, _973) * 255.0f);
        float3 _989 = _988.xyz;
        int _994 = int(_250.x);
        int _996 = int(_250.y);
        int _999 = _24_m2.x - 1;
        int _1004 = _24_m2.y & 31;
        if (((_994 & _999) + ((_996 & _999) << _1004)) == _24_m3.w)
        {
            float _1012 = _988.z;
            int _1019 = int(clamp(clamp(clamp(_962 + _973, 0.0f, _22_m6.x) - _1012, -1.0f, 1.0f) + _1012, _962, _22_m6.x));
            uint2 _1026 = uint2(_894 * exp2(_22_m6.x)) >> (uint(_1019).xx & uint2(31u, 31u));

        // Captured VT pages are resident: streaming request only, no GBuffer dependency.
        }
        _1051 = _988;
        _1052 = _948;
        _1053 = _946;
        _1054 = !all(bool3(_989.x > 254.0f.xxx.x, _989.y > 254.0f.xxx.y, _989.z > 254.0f.xxx.z));
    }
    else
    {
        _1051 = 0.0f.xxxx;
        _1052 = 0.0f.xx;
        _1053 = 0.0f.xx;
        _1054 = false;
    }
    float2 _1059 = clamp(_892, 0.0f.xx, (float(_288) - 9.9999997473787516355514526367188e-05f).xx);
    int2 _1060 = int2(_1059);
    int _1061 = _1060.x;
    int _1062 = _1060.y;
    int _1065 = (_1061 | (_1061 << 4)) & 3855;
    int _1068 = (_1065 | (_1065 << 2)) & 13107;
    int _1074 = (_1062 | (_1062 << 4)) & 3855;
    int _1077 = (_1074 | (_1074 << 2)) & 13107;
    int _1082 = ((_1068 | (_1068 << 1)) & 21845) | (((_1077 | (_1077 << 1)) & 21845) << 1);
    uint4 _1093 = (_24_m1[clamp(_1082 >> 2, 0, 1023)] >> (uint((_1082 & 3) << 3).xxxx & uint4(31u, 31u, 31u, 31u))) & uint4(255u, 255u, 255u, 255u);
    uint _1103 = (((_1093.w << 24u) | (_1093.z << 16u)) | (_1093.y << 8u)) | _1093.x;
    int _1106 = int((_1103 >> 16u) & 255u);
    int2 _1108 = _1106.xx & int2(31, 31);
    float2 _1117 = (_1059 - float2((_1060 >> _1108) << _1108)) / float(1 << (_1106 & 31)).xx;
    float2 _1120 = float2(1.0f, _22_m14);
    int _1123 = int(_1103 & 65535u) - 1;
    float2 _1137 = float2(float(_1123 & (_22_m5.y - 1)), float(_1123 >> (_22_m5.z & 31))) * _22_m4.w;
    uint _1141 = uint(_1106) & 31u;
    float _1143 = float(_22_m11 >> _1141);
    float _1148 = float(_22_m12 << _1141);
    float2 _1149 = _1117 * _1148;
    float4 _1191 = (((_1117.xyxy * _22_m0.xxyy) + _1137.xyxy) + _22_m1.xxyy) * _1120.xyxy;
    float4 _1196 = _29.SampleLevel(sampler_EID3899_linear_clamp, _1191.xy, 0.0f);
    float2 _1199 = (_1196.xy * 2.0f) - 1.0f.xx;
    float _1200 = _1199.x;
    float _1204 = sqrt(max(1.0f - dot(_1199, _1199), 0.0f));
    float _1205 = _1199.y;
    float3 _1206 = float3(_1200, _1204, _1205);
    float _1314;
    float _1315;
    float _1316;
    float _1317;
    float _1318;
    float3 _1319;
    float3 _1320;
    float _1321;
    if (_904 && _1054)
    {
        float _1231 = float(uint(exp2(_22_m6.x - _1051.z)));
        float2 _1251 = ((clamp(frac(_894 * _1231) * _22_m6.y, 0.5f.xx, (_22_m6.y - 0.5f).xx) + _22_m16.xx) + (_1051.xy * _22_m15)) * _22_m6.z;
        _1251.y = _1251.y * _22_m13;
        float _1258 = (_1231 * _22_m6.y) * _22_m6.z;
        float2 _1265 = (_1053 * _1258) * _13_m17;
        float2 _1266 = (_1052 * _1258) * _13_m17;
        float4 _1268 = _38.SampleGrad(sampler_EID3899_linear_clamp, _1251, _1265, _1266);
        float4 _1288;
        if (_22_m17 > 0.0f)
        {
            float4 _1282 = _39.SampleGrad(sampler_EID3899_linear_clamp, _1251, _1265, _1266);
            float4 _1286 = _40.SampleGrad(sampler_EID3899_linear_clamp, _1251, _1265, _1266);
            _1288 = float4(_1282.x, _1282.y, _1286.x, _1286.y);
        }
        else
        {
            _1288 = _39.SampleGrad(sampler_EID3899_linear_clamp, _1251, _1265, _1266);
        }
        float4 _1292 = _41.SampleGrad(sampler_EID3899_linear_clamp, _1251, _1265, _1266);
        float2 _1295 = (_1288.xy * 2.0f) - 1.0f.xx;
        float _1308 = _1292.x;
        _1314 = _1308;
        _1315 = (_1288.w * 2.0f) - 1.0f;
        _1316 = _1292.w;
        _1317 = _1292.y;
        _1318 = _1288.z;
        _1319 = _1268.xyz;
        _1320 = float3(_1295.x, sqrt(max(1.0f - dot(_1295, _1295), 0.0f)), _1295.y);
        _1321 = clamp(_1268.w - _1308, 0.0f, 1.0f);
    }
    else
    {
        _1314 = 0.5f;
        _1315 = 0.0f;
        _1316 = 0.0f;
        _1317 = _1196.z;
        _1318 = _1196.w;
        _1319 = _30.SampleLevel(sampler_EID3899_linear_clamp, _1191.zw, 0.0f).xyz;
        _1320 = _1206;
        _1321 = clamp(_31.SampleLevel(sampler_EID3899_linear_clamp, ((_1137 + (((floor(_1149) + clamp(frac(_1149), (0.5f / _1143).xx, ((_1143 - 0.5f) * (1.0f / _1143)).xx)) / _1148.xx) * _22_m0.w)) + _22_m1.w.xx) * _1120, 0.0f).w - 0.5f, 0.0f, 1.0f);
    }
    float3 _1388;
    float _1323 = clamp(_1321 * 2.17391300201416015625f, 0.0f, 1.0f);
    float3 _1326 = lerp(_1319, _1319 * 0.64999997615814208984375f, _1323.xxx);
    float _1327 = lerp(_1318, 0.0f, _1323);
    float _1329 = lerp(_1317, _1317 * 0.89999997615814208984375f, _1323);
    float3 _1333 = lerp(_1320, float3(0.0f, 1.0f, 0.0f), (min(_1323, 1.0f) * 0.980000019073486328125f).xxx);
    float _1338 = -dot(_1206, _880);
    uint _1340 = _250.x;
    uint _1342 = _250.y;
    float4 _1349 = float4((float2(uint2(_1340 + 1u, _1342)) + 0.5f.xx) * _13_m0.zw, 0.0f, 1.0f);
    float2 _1352 = (_1349.xy * 2.0f) - 1.0f.xx;
    float4 _1353 = float4(_1352.x, _1352.y, _1349.z, _1349.w);
    _1353.y = -_1352.y;
    float4 _1357 = mul(_11_m6, _1353);
    float3 _1363 = (_1357.xyz / _1357.w.xxx).xyz - _11_m11.xyz;
    float4 _1371 = float4((float2(uint2(_1340, _1342 + 1u)) + 0.5f.xx) * _13_m0.zw, 0.0f, 1.0f);
    float2 _1374 = (_1371.xy * 2.0f) - 1.0f.xx;
    float4 _1375 = float4(_1374.x, _1374.y, _1371.z, _1371.w);
    _1375.y = -_1374.y;
    float4 _1379 = mul(_11_m6, _1375);
    float3 _1385 = (_1379.xyz / _1379.w.xxx).xyz - _11_m11.xyz;
    float3 _1400;
    bool _1401;
    do
    {
        _1388 = float4(_1200, _1204, _1205, _1338).xyz;
        float _1389 = dot(_1363, _1388);
        if (_1389 == 0.0f)
        {
            _1400 = 0.0f.xxx;
            _1401 = false;
            break;
        }
        float _1396 = (-(dot(_11_m11.xyz, _1388) + _1338)) / _1389;
        _1400 = _11_m11.xyz + (_1363 * _1396);
        _1401 = _1396 >= 0.0f;
        break;
    } while(false);
    float3 _1405;
    if (_1401)
    {
        _1405 = _1400 - _880;
    }
    else
    {
        _1405 = 0.0f.xxx;
    }
    float3 _1419;
    bool _1420;
    do
    {
        float _1408 = dot(_1385, _1388);
        if (_1408 == 0.0f)
        {
            _1419 = 0.0f.xxx;
            _1420 = false;
            break;
        }
        float _1415 = (-(dot(_11_m11.xyz, _1388) + _1338)) / _1408;
        _1419 = _11_m11.xyz + (_1385 * _1415);
        _1420 = _1415 >= 0.0f;
        break;
    } while(false);
    float3 _1424;
    if (_1420)
    {
        _1424 = _1419 - _880;
    }
    else
    {
        _1424 = 0.0f.xxx;
    }
    float _1431 = log2(1.0f / ((0.300000011920928955078125f * max(length(_1405), length(_1424))) + 6.103515625e-05f));
    float2 _1435 = exp2(float2(floor(_1431), ceil(_1431)));
    float3 _1438 = floor(_880 * _1435.x);
    uint2 _1440 = asuint(_1438.xy);
    uint _1445 = (_1440.x * 374761393u) + (_1440.y * 668265263u);
    uint _1448 = (_1445 ^ (_1445 >> 13u)) * 1274126177u;
    uint2 _1455 = asuint(float2(float(_1448 ^ (_1448 >> 16u)) * 2.3283064365386962890625e-10f, _1438.z));
    uint _1460 = (_1455.x * 374761393u) + (_1455.y * 668265263u);
    uint _1463 = (_1460 ^ (_1460 >> 13u)) * 1274126177u;
    float3 _1470 = floor(_880 * _1435.y);
    uint2 _1472 = asuint(_1470.xy);
    uint _1477 = (_1472.x * 374761393u) + (_1472.y * 668265263u);
    uint _1480 = (_1477 ^ (_1477 >> 13u)) * 1274126177u;
    uint2 _1487 = asuint(float2(float(_1480 ^ (_1480 >> 16u)) * 2.3283064365386962890625e-10f, _1470.z));
    uint _1492 = (_1487.x * 374761393u) + (_1487.y * 668265263u);
    uint _1495 = (_1492 ^ (_1492 >> 13u)) * 1274126177u;
    float _1500 = frac(_1431);
    float _1501 = lerp(float(_1463 ^ (_1463 >> 16u)) * 2.3283064365386962890625e-10f, float(_1495 ^ (_1495 >> 16u)) * 2.3283064365386962890625e-10f, _1500);
    float _1503 = min(_1500, 1.0f - _1500);
    float _1504 = 1.0f - _1503;
    float _1508 = (2.0f * _1503) * _1504;
    float _1513 = 1.0f - _1501;
    float3 _1519 = step(_1501.xxx, float3(_1503, _1504, 1.0f));
    float _1526 = clamp(dot(_1519 * (1.0f.xxx - float3(0.0f, _1519.xy)), float3((_1501 * _1501) / _1508, (_1501 - (0.5f * _1503)) / _1504, 1.0f - ((_1513 * _1513) / _1508))), 0.0f, 1.0f);
    float3 _1527 = abs(_1206);
    float3 _1528 = _1527 * _1527;
    float3 _1529 = _1528 * _1528;
    float3 _1530 = _1529 * _1529;
    float3 _1538 = _1530 / (((_1530.x + _1530.y) + _1530.z) + 6.103515625e-05f).xxx;
    float _1539 = _1538.x;
    float3 _1544 = step(_1526.xxx, float3(_1539, _1539 + _1538.y, 1.0f));
    float3 _1549 = _1544 * (1.0f.xxx - float3(0.0f, _1544.xy));
    float _1551 = _1549.x;
    float _1553 = _1549.y;
    float _1557 = _1549.z;
    float3 _1576 = cross(_1206, float3(0.0f, 0.0f, 1.0f));
    float2 _1579 = ((((_1117 * _22_m9.x) + _1137) + _22_m9.y.xx) * _1120) * _22_m8.xy;
    float2 _1582 = floor(_1579 - 0.5f.xx) + 0.5f.xx;
    float2 _1584 = _1579 - _1582;
    float2 _1585 = 1.0f.xx - _1584;
    float _1586 = _1585.x;
    float _1587 = _1585.y;
    float _1588 = _1586 * _1587;
    float _1593 = _1588 + (_1584.x * _1587);
    float4 _1597 = step(_1526.xxxx, float4(_1588, _1593, _1593 + (_1586 * _1584.y), 1.0f));
    uint _1605 = uint(dot(_1597 * (1.0f.xxxx - float4(0.0f, _1597.xyz)), float4(0.0f, 1.0f, 2.0f, 3.0f)));
    uint2 _1621 = uint2(floor((_33.SampleLevel(sampler_EID3899_point_clamp, _22_m8.zw * (_1582 + float2(float(_1605 & 1u), float(_1605 >> 1u))), 0.0f).xy * 255.5f) * 0.25f.xx));
    uint _1622 = _1621.y;
    float4 _1631 = _32.SampleLevel(sampler_EID3899_linear_clamp, _1191.zw, 0.0f);
    float _1632 = _1631.w;
    float _1633 = _1632 * _1632;
    float _1639 = _26_m1[_1622].x * _22_m3.y;
    float2 _1644 = ((((_880.zy * _1551) + (_884 * _1553)) + (_880.xy * _1557)) * _1639) + _26_m1[_1622].z.xx;
    float4 _1645 = float4(((_1405.zy * _1551) + (_1405.xz * _1553)) + (_1405.xy * _1557), ((_1424.zy * _1551) + (_1424.xz * _1553)) + (_1424.xy * _1557)) * _1639;
    uint _1647 = uint(asint(_26_m1[_1622].y));
    float4 _1677;
    float2 _1678;
    [branch]
    if (((_1647 >> 13u) & 1u) == 0u)
    {
        uint _1663 = (_1647 >> 11u) & 3u;
        _1677 = min(_1645 * 0.5f, _22_m10.z.xxxx);
        _1678 = clamp(frac(_1644) * 0.5f, _22_m10.xx, _22_m10.yy) + (float2(float(_1663 & 1u), float(_1663 >> 1u)) * 0.5f);
    }
    else
    {
        _1677 = _1645;
        _1678 = _1644;
    }
    float3 _1683 = float3(_1678, float((_1647 >> 6u) & 31u));
    float4 _1687 = _34.SampleGrad(sampler_EID3899_trilinear_repeat, _1683, _1677.xy, _1677.zw);
    float4 _1691 = _35.SampleGrad(sampler_EID3899_trilinear_repeat, _1683, _1677.xy, _1677.zw);
    float4 _1717 = (float4(0.0f, _1691.w, _1687.w, _1691.z) * _26_m4[_1622]) + _26_m3[_1622];
    float2 _1723 = ((_1691.xy * 2.0f) - 1.0f.xx).xy;
    float2 _1729 = _1723 * _26_m0[_1622].w;
    float _1740 = round(_26_m3[_1622].x * 255.0f);
    float _1749 = 1.0f - clamp(_1204, 0.0f, 1.0f);
    float _1752 = clamp(lerp(-3.0f, 4.0f, 5.0f * _1749), 0.0f, 1.0f);
    float _1755 = clamp(lerp(-0.20000000298023223876953125f, 1.2000000476837158203125f, 0.89999997615814208984375f * _1749), 0.0f, 1.0f);
    float3 _1756 = _1755.xxx;
    float2 _1764 = float2(_1314, lerp(_1314, _1717.z, _1755));
    float2 _1766 = (_1764 * _1764) * _1764;
    float2 _1772 = float2(_1766.x * (1.0f - _1752), _1766.y * _1752);
    float2 _1776 = _1772 / max(dot(_1772, 1.0f.xx), 6.103515625e-05f).xx;
    float _1777 = _1776.y;
    float3 _1778 = _1777.xxx;
    float3 _1779 = lerp(_1326, lerp(_1326, (_1687.xyz * _26_m2[_1622].xyz) + ((lerp(_1631.xyz, _26_m0[_1622].xyz, (1.0f - _1633).xxx) * _1633) - (_26_m0[_1622].xyz * _1633)), _1756), _1778);
    uint _1787 = uint(_28_m6);
    float2 _1807 = (((_245 * _13_m0.zw) * 2.0f) - 1.0f.xx) + (_13_m9.zw * 2.0f);
    float2 _1817 = float2(_1807.x, -_1807.y) - (_244.xy / max(_244.w, 9.9999999392252902907785028219223e-09f).xx);
    _1817.y = -_1817.y;
    float2 _1830 = ((sqrt(sqrt(abs(_1817 * 0.5f))) * float2(int2(sign(_1817)))) * 0.5f) + 0.5f.xx;
    float4 _1831 = 0.0f.xxxx;
    _1831.y = lerp(_1329, lerp(_1329, _1717.y, _1755), _1777);
    _1831.z = 0.0f;
    float3 _1833 = normalize(normalize(lerp(_1333, normalize(lerp(_1333, normalize(((_1576 * _1729.x) + (cross(_1576, _1206) * _1729.y)) + (_1206 * max(6.103515625e-05f, sqrt(1.0f - clamp(dot(_1723, _1723), 0.0f, 1.0f))))), _1756)), _1778)));
    float2 _1838 = _1833.xz / dot(1.0f.xxx, abs(_1833)).xx;
    float3 _1852;
    if (_1833.y <= 0.0f)
    {
        float2 _1847 = _1838.xy;
        bool2 _1848 = bool2(_1847.x >= 0.0f.xx.x, _1847.y >= 0.0f.xx.y);
        float2 _1850 = (1.0f.xx - abs(_1838.yx)) * float2(_1848.x ? 1.0f.xx.x : (-1.0f).xx.x, _1848.y ? 1.0f.xx.y : (-1.0f).xx.y);
        _1852 = float3(_1850.x, _1833.y, _1850.y);
    }
    else
    {
        _1852 = float3(_1838.x, _1833.y, _1838.y);
    }
    float2 _1855 = (_1852.xz * 0.5f) + 0.5f.xx;
    float4 _1856 = float4(_1855.x, _1855.y, 0.0f.xxxx.z, 0.0f.xxxx.w);
    _1856.z = lerp(_1327, lerp(_1327, _1717.w, _1755), _1777);
    _1831.w = float(_1787 / 4u) * 0.3333333432674407958984375f;
    _1856.w = float(_1787 % 4u) * 0.3333333432674407958984375f;
    float4 _1866 = float4(_1779.x, _1779.y, _1779.z, 0.0f.xxxx.w);
    _1866.w = ((clamp(_1315, 0.0f, 1.0f) * _28_m5) + _28_m4) * (1.0f - clamp(abs((lerp(_1316, lerp(_1316, (_1740 == 19.0f) ? 1.0f : ((_1740 == 15.0f) ? 0.5f : 0.0f), _1755), _1777) * 2.0f) - 1.0f), 0.0f, 1.0f));
    float4 _1868 = float4(_1830.x, _1830.y, 0.0f.xxxx.z, 0.0f.xxxx.w);
    _1868.z = 0.0f;
    _1868.w = 0.0f;
    _5 = float4(0.0f, 0.0f, 0.0f, 0.5f);
    _6 = _1831;
    _7 = _1856;
    _8 = _1866;
    _9 = _1868;
}


EID3899Output EID3899Fragment(EID3899Varyings input) {
 EID3899PositionWS=input.positionWS; gl_FragCoord=input.positionCS;
 _4=GetNormalizedScreenSpaceUV(input.positionCS.xy);
 frag_main(); EID3899Output o;o.rt0=_5;o.rt1=_9;o.rt2=_6;o.rt3=_7;o.rt4=_8;return o;
}
