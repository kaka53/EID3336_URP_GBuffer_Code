// EID4922 direct RenderDoc SPIR-V port. Layout names changed only for Unity binding.
static float4 _56;

cbuffer EID4922FrameCB
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

cbuffer EID4922ViewCB
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

cbuffer EID4922ObjectCB
{
    column_major float4x4 _15_m0 : packoffset(c0);
    float4 _15_m1 : packoffset(c4);
    float4 _15_m2 : packoffset(c5);
    column_major float4x4 _15_m3 : packoffset(c6);
    float4 _15_m4 : packoffset(c10);
    float4 _15_m5 : packoffset(c11);
    float4 _15_m6 : packoffset(c12);
    float4 _15_m7 : packoffset(c13);
    float4 _15_m8 : packoffset(c14);
    float4 _15_m9 : packoffset(c15);
};

// Unity real-time camera state. Captured buffers continue to provide the original
// atmospheric/material parameters; only camera position and MVP become live.
float4x4 _EID4922RealtimeMVP;
float4 _EID4922RealtimeCameraPositionWS;
float _EID4922SkyRadius;
float _EID4922UseRealtimeMVP;
// Canonical URP per-camera depth. The EID4662 light pass and this sky pass both
// read the same _CameraDepthTexture, which is explicitly requested by the pass via
// ConfigureInput(ScriptableRenderPassInput.Depth). The legacy alias remains declared
// for capture compatibility but is no longer the authoritative source.
float _EID4922SceneDepthAvailable;
float _EID4922SceneDepthReversedZ;
float _EID4922SceneDepthEpsilon;
Texture2D<float4> _CameraDepthTexture;
Texture2D<float4> _EID4922SceneDepth;

float3 EID4922GetCameraPositionWS()
{
    return (_EID4922UseRealtimeMVP > 0.5f) ? _EID4922RealtimeCameraPositionWS.xyz : _11_m11.xyz;
}

static float4 gl_Position;
static float3 _2;
static float2 _3;
static float3 _5;
static float3 _7;
static float3 _8;


void vert_main()
{
    float3 _78 = mul(float3x3(_15_m0[0].xyz, _15_m0[1].xyz, _15_m0[2].xyz), _2) + (float3(_15_m0[0].w, _15_m0[1].w, _15_m0[2].w) - EID4922GetCameraPositionWS());
    float4 _86 = mul(_11_m8, float4(_78, 1.0f));
    float2 _94 = _86.xy - ((_13_m9.zw * float2(2.0f, -2.0f)) * _86.w);
    float4 _95 = float4(_94.x, _94.y, _86.z, _86.w);
    _95.z = 0.0f;
    _95.y = -_94.y;
    gl_Position = _95;
    _5 = _78 + EID4922GetCameraPositionWS();
    _7 = _86.xyw;
    _8 = mul(_11_m15, float4(_78 + (EID4922GetCameraPositionWS() - _11_m21.xyz), 1.0f).xyzw).xyw;
}


cbuffer EID4922SkyCB
{
    float _32_m0 : packoffset(c0);
    float _32_m1 : packoffset(c0.y);
    float _32_m2 : packoffset(c0.z);
    float _32_m3 : packoffset(c0.w);
    float _32_m4 : packoffset(c1);
    float _32_m5 : packoffset(c1.y);
    float _32_m6 : packoffset(c1.z);
    float _32_m7 : packoffset(c1.w);
    float _32_m8 : packoffset(c2);
    float _32_m9 : packoffset(c2.y);
    float _32_m10 : packoffset(c2.z);
    float _32_m11 : packoffset(c2.w);
    float4 _32_m12 : packoffset(c3);
    float4 _32_m13 : packoffset(c4);
    float4 _32_m14 : packoffset(c5);
    float4 _32_m15 : packoffset(c6);
    float4 _32_m16 : packoffset(c7);
    float4 _32_m17 : packoffset(c8);
    float4 _32_m18 : packoffset(c9);
    float4 _32_m19 : packoffset(c10);
    float4 _32_m20 : packoffset(c11);
    float4 _32_m21 : packoffset(c12);
    float4 _32_m22 : packoffset(c13);
    float4 _32_m23 : packoffset(c14);
    float4 _32_m24 : packoffset(c15);
    float4 _32_m25 : packoffset(c16);
    float4 _32_m26 : packoffset(c17);
    float4 _32_m27 : packoffset(c18);
    float4 _32_m28 : packoffset(c19);
    float4 _32_m29 : packoffset(c20);
    float4 _32_m30 : packoffset(c21);
    float4 _32_m31 : packoffset(c22);
    float4 _32_m32 : packoffset(c23);
    float4 _32_m33 : packoffset(c24);
    float4 _32_m34 : packoffset(c25);
    float4 _32_m35 : packoffset(c26);
    float4 _32_m36 : packoffset(c27);
    float4 _32_m37 : packoffset(c28);
    float4 _32_m38 : packoffset(c29);
    float4 _32_m39 : packoffset(c30);
    float4 _32_m40 : packoffset(c31);
    float4 _32_m41 : packoffset(c32);
    float4 _32_m42 : packoffset(c33);
    float4 _32_m43 : packoffset(c34);
    float4 _32_m44 : packoffset(c35);
    float4 _32_m45 : packoffset(c36);
    float4 _32_m46 : packoffset(c37);
    float4 _32_m47 : packoffset(c38);
    float4 _32_m48 : packoffset(c39);
    float4 _32_m49 : packoffset(c40);
    float4 _32_m50 : packoffset(c41);
    float4 _32_m51 : packoffset(c42);
    float4 _32_m52 : packoffset(c43);
    float4 _32_m53 : packoffset(c44);
    float4 _32_m54 : packoffset(c45);
    float4 _32_m55 : packoffset(c46);
    float4 _32_m56 : packoffset(c47);
    float4 _32_m57 : packoffset(c48);
    float4 _32_m58 : packoffset(c49);
    float4 _32_m59 : packoffset(c50);
    float4 _32_m60 : packoffset(c51);
};
SamplerState sampler_EID4922Res19;
SamplerState sampler_EID4922Res20;
Texture3D<float4> _EID4922Res18;
Texture2D<float4> _EID4922Res19;
Texture2D<float4> _EID4922Res20;
Texture2D<float4> _EID4922Res21;
SamplerState sampler_EID4922Res21;
Texture2D<float4> _EID4922Res23;
SamplerState sampler_EID4922Res23;
Texture2D<float4> _EID4922Res25;
SamplerState sampler_EID4922Res25;
Texture2D<float4> _EID4922Res27;
SamplerState sampler_EID4922Res27;
Texture2D<float4> _EID4922Res29;
SamplerState sampler_EID4922Res29;


static float3 _204;
static uint _205;
static float4 gl_FragCoord;
static float3 ps_in0;
static float3 ps_in2;
static float3 ps_in3;
static float4 ps_out0;
static float4 ps_out1;


void frag_main()
{
    float _209 = 1.0f / gl_FragCoord.w;
    uint2 _214 = uint2(gl_FragCoord.xy);
    float3 _218 = ps_in0 - EID4922GetCameraPositionWS();
    float _219 = dot(_218, _218);
    float _221 = rsqrt(max(_219, 9.9999999392252902907785028219223e-09f));
    float3 _222 = _218 * _221;
    float _223 = _219 * _221;
    float3 _227 = _222 * (1.0f / dot(abs(_222), 1.0f.xxx));
    float _228 = _227.x;
    float _229 = _227.z;
    float _240 = _222.y;
    float4 _244 = _EID4922Res19.SampleLevel(sampler_EID4922Res19, float2((_228 + _229) + 1.0f, (_228 - _229) + 1.0f) * 0.5f, 0.0f) * clamp(1.0f + (_240 * 10.0f), 0.0f, 1.0f);
    float3 _252 = -_222;
    float _257 = pow(clamp(dot(-_32_m53.xyz, _252), 0.0f, 1.0f), _32_m52.x);
    float _269 = (0.010016442276537418365478515625f * (1.0f + (_257 * _257))) / max(pow(1.98010003566741943359375f - (_257 * 1.980000019073486328125f), pow(_32_m51.w, 0.64999997615814208984375f) * 8.0f), 9.9999997473787516355514526367188e-05f);
    float _285 = _222.x;
    float _286 = _222.z;
    float _287 = _285 / _286;
    float _288 = abs(_287);
    bool _289 = _288 < 1.0f;
    float _291 = _289 ? _288 : (1.0f / _288);
    float _292 = _291 * _291;
    float _297 = (1.0f + (((-0.3018949925899505615234375f) + (0.087292902171611785888671875f * _292)) * _292)) * _291;
    float _299 = _289 ? _297 : (1.57079637050628662109375f - _297);
    float _309 = abs(_240);
    float _316 = ((((0.04688780009746551513671875f * _309) + (-0.203471004962921142578125f)) * _309) + 1.57079601287841796875f) * sqrt(1.0f - _309);
    float2 _323 = (float2(((_287 < 0.0f) ? (-_299) : _299) + (((_285 >= 0.0f) ? 3.141592502593994140625f : (-3.141592502593994140625f)) * float(_286 < 0.0f)), 1.57079637050628662109375f - ((_240 >= 0.0f) ? _316 : (3.1415927410125732421875f - _316))) * float2(0.159099996089935302734375f, 0.3183000087738037109375f)) + 0.5f.xx;
    float4 _339 = _EID4922Res20.SampleBias(sampler_EID4922Res20, float2(_323.x + (1.0f - (_32_m50.w * 0.00277777784503996372222900390625f)), (_323.y * 2.0f) - 1.0f), _13_m16);
    float3 _345 = ((_339.xyz - 0.5f.xxx) * _32_m49.y) + 0.5f.xxx;
    float4 _349 = float4(_345.x, _345.y, _345.z, _339.w) * _32_m47;
    float4 _362 = (lerp(_349, max(_349.x, _349.y).xxxx, _32_m49.x.xxxx) * _32_m48) * step(0.0f, _240);
    float3 _364 = _362.xyz;
    float3 _367 = clamp(_362.w, 0.0f, 1.0f).xxx;
    float3 _368 = lerp((_244.xyz + clamp(((_32_m51.xyz * lerp(smoothstep(0.5f, 1.0f, _269) * _269, _269, _32_m52.y)) * _32_m52.w) * _32_m53.w, 0.0f.xxx, 3.0f.xxx)).xyz, _364, _367);
    float4 _824;
    [branch]
    if (_32_m0 > 0.75f)
    {
        float3 _604;
        float _607;
        float _424 = 1.0f / _32_m36.x;
        float _426 = _32_m36.w + _32_m36.x;
        float3 _429 = normalize(_218);
        float _430 = dot(_429, _32_m24.xyz);
        float _435 = ((_32_m28.x * _32_m28.x) - 1.0f) + (_430 * _430);
        float3 _448 = (((_429 * (_430 - sqrt(max(0.0f, _435)))) - _32_m24.xyz) / _32_m28.x.xxx).xyz;
        float _450 = float(max(_435 * clamp(dot(_429, normalize(_32_m24.xyz)), 0.0f, 1.0f), 0.0f) > 0.0f);
        float3 _459 = ((_429 * (abs(dot(_32_m30.xyz, _32_m24.xyz)) / abs(dot(_32_m30.xyz, _429)))) - _32_m24.xyz).xyz;
        float _464 = length(_459);
        float3 _466 = _459 / _464.xxx;
        float _471 = ((_464 * float(abs(dot(_32_m30.xyz, _459)) < 0.001000000047497451305389404296875f)) * _32_m28.z) + _32_m28.w;
        float _479 = dot(_448, _32_m30.xyz);
        float _480 = -_479;
        float3 _488 = normalize(_448 - (_32_m30.xyz * _479));
        float _497 = float(int(sign(dot(_488, _32_m34.xyz))));
        float2 _502 = float2(clamp(-_497, 0.0f, 1.0f) + (_497 * (acos(dot(_488, _32_m32.xyz)) * 0.15915493667125701904296875f)), ((((-0.22222222387790679931640625f) * (_480 * _480)) + (-0.27777779102325439453125f)) * _480) + 0.500000059604644775390625f);
        float4 _504 = _EID4922Res21.SampleBias(sampler_EID4922Res21, _502, _13_m16);
        float _511 = clamp((clamp(dot(_32_m26.xyz, _448), 0.0f, 1.0f) * _32_m4) + _32_m6, 0.0f, 1.0f);
        float _519 = _504.w;
        float4 _524 = float4((_504.xyz * _511) + (_EID4922Res25.SampleBias(sampler_EID4922Res25, _502, _13_m16).xyz * _32_m18.xyz), _519) * _450;
        float _534 = clamp(float(int(sign(clamp(1.0f - _471, 0.0f, 1.0f) * _471))), 0.0f, 1.0f) * lerp(1.0f, clamp(float(int(sign(-dot(_429, _466)))), 0.0f, 1.0f), _450);
        float _541 = float(int(sign(dot(_466, _32_m34.xyz))));
        float _556 = clamp(-dot(_32_m26.xyz, _466), 0.0f, 1.0f);
        float4 _570 = (_EID4922Res29.SampleBias(sampler_EID4922Res29, float2(clamp(-_541, 0.0f, 1.0f) + (_541 * (acos(dot(_466, _32_m32.xyz)) * 0.15915493667125701904296875f)), _471), _13_m16) * _32_m16) * ((1.0f - clamp(max((((_32_m28.x - (_464 * sqrt(1.0f - (_556 * _556)))) * _32_m28.y) / _32_m2) + 1.0f, 0.0f), 0.0f, 1.0f)) * clamp(abs(dot(_32_m26.xyz, _32_m30.xyz)) + 0.4000000059604644775390625f, 0.0f, 1.0f));
        float3 _576 = (_524.xyz * _519).xyz + ((_570.xyz * _570.w) * _534);
        float4 _577 = float4(_576.x, _576.y, _576.z, _524.w);
        _577.w = _524.w + ((_570.w * _534) * (1.0f - _450));
        float _586 = lerp(1.0f, clamp(_429.y, 0.0f, 1.0f), _32_m38.w);
        float4 _588 = (_577 * _32_m14) * _586;
        float3 _597 = _429 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(_429, _429)));
        float3 _601 = _32_m26.xyz * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(_32_m26.xyz, _32_m26.xyz)));
        float _621;
        float _622;
        bool _623;
        do
        {
            _604 = float4(_32_m22.xyz, _426).xyz;
            float3 _605 = EID4922GetCameraPositionWS() - _604;
            _607 = _426 * _426;
            float _609 = dot(_597, _605);
            float _611 = (_609 * _609) - (dot(_605, _605) - _607);
            if (_611 <= 0.0f)
            {
                _621 = 0.0f;
                _622 = 0.0f;
                _623 = false;
                break;
            }
            float _615 = sqrt(_611);
            float _616 = -_609;
            float _618 = max(0.0f, _616 - _615);
            _621 = _618;
            _622 = (_616 + _615) - _618;
            _623 = true;
            break;
        } while(false);
        float3 _744;
        if (_623)
        {
            float _643;
            bool _644;
            do
            {
                float3 _629 = EID4922GetCameraPositionWS() - float4(_32_m22.xyz, _32_m36.w).xyz;
                float _633 = dot(_597, _629);
                float _635 = (_633 * _633) - (dot(_629, _629) - (_32_m36.w * _32_m36.w));
                if (_635 <= 0.0f)
                {
                    _643 = 0.0f;
                    _644 = false;
                    break;
                }
                _643 = max(0.0f, (-_633) - sqrt(_635));
                _644 = true;
                break;
            } while(false);
            float _653;
            if (_644)
            {
                float _652;
                if (_643 > 0.0f)
                {
                    _652 = min(_622, _643 - _621);
                }
                else
                {
                    _652 = _622;
                }
                _653 = _652;
            }
            else
            {
                _653 = _622;
            }
            float3 _743;
            if (_653 > 0.0f)
            {
                float _659 = _653 / _32_m36.y;
                float _664 = dot(-_597, _601);
                float3 _669 = _32_m36.z.xxx * float3(0.000244140625f, 0.001267349696718156337738037109375f, 0.00266802101396024227142333984375f);
                float3 _674;
                float3 _676;
                _674 = (EID4922GetCameraPositionWS() + (_597 * _621)) + ((_597 * 0.5f) * _659);
                _676 = 0.0f.xxx;
                float _672;
                float3 _675;
                float3 _677;
                float _671 = 0.0f;
                int _678 = 0;
                for (; float(_678) < _32_m36.y; _671 = _672, _674 = _675, _676 = _677, _678++)
                {
                    float3 _684 = _674 - _604;
                    float _692 = min(exp((-((length(_684) - _32_m36.w) * _424)) * _32_m37.y) * _659, 3.4028234663852885981170418348452e+38f);
                    _672 = _671 + _692;
                    float _709;
                    do
                    {
                        float _697 = dot(_601, _684);
                        float _699 = (_697 * _697) - (dot(_684, _684) - _607);
                        if (_699 <= 0.0f)
                        {
                            _709 = 0.0f;
                            break;
                        }
                        float _703 = sqrt(_699);
                        float _704 = -_697;
                        _709 = (_704 + _703) - max(0.0f, _704 - _703);
                        break;
                    } while(false);
                    float _710 = _709 / _32_m37.x;
                    float3 _715;
                    float _718;
                    _715 = _674 + ((_601 * 0.5f) * _710);
                    _718 = 0.0f;
                    for (int _720 = 0; float(_720) < _32_m37.x; )
                    {
                        float3 _725 = _715 - _604;
                        _715 += (_601 * _710);
                        _718 += exp((-(max(length(_725) - _32_m36.w, 0.0f) * _424)) * _32_m37.y);
                        _720++;
                        continue;
                    }
                    _677 = _676 + (exp(-(_669 * ((_718 * _710) + _672))) * _692);
                    _675 = _674 + (_597 * _659);
                }
                _743 = (_676 * (0.0596831031143665313720703125f * (1.0f + (_664 * _664)))) * _669;
            }
            else
            {
                _743 = 0.0f.xxx;
            }
            _744 = _743;
        }
        else
        {
            _744 = 0.0f.xxx;
        }
        float3 _745 = _744 * _32_m37.z;
        float _746 = _745.z;
        float _747 = _745.y;
        float4 _752 = lerp(float4(_746, _747, -1.0f, 0.666666686534881591796875f), float4(_747, _746, 0.0f, -0.3333333432674407958984375f), step(_746, _747).xxxx);
        float _753 = _745.x;
        float _754 = _752.x;
        float4 _762 = lerp(float4(_754, _752.yw, _753), float4(_753, _752.yz, _754), step(_754, _753).xxxx);
        float _763 = _762.x;
        float _764 = _762.w;
        float _765 = _762.y;
        float _767 = _763 - min(_764, _765);
        float3 _778;
        _778.x = abs(_762.z + ((_764 - _765) / ((6.0f * _767) + 9.9999997473787516355514526367188e-05f))) + _32_m37.w;
        float3 _789 = lerp(1.0f.xxx, clamp(abs((frac(_778.xxx + float3(1.0f, 0.666666686534881591796875f, 0.3333333432674407958984375f)) * 6.0f) - 3.0f.xxx) - 1.0f.xxx, 0.0f.xxx, 1.0f.xxx), (_767 / (_763 + 9.9999997473787516355514526367188e-05f)).xxx) * _763;
        float3 _794 = _588.xyz;
        float _806 = _588.w;
        float3 _822 = ((_368.xyz * (1.0f - (_806 * (1.0f - (step(0.5f, _32_m8) * step(_32_m8, 1.5f)))))) + ((lerp(dot(_794, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, _794, _13_m76.w.xxx) * _13_m76.xyz).xyz * (1.0f - ((1.0f - _806) * step(_32_m8, 0.5f))))).xyz + (lerp(_789 * _511, _789, _32_m38.y.xxx) * _586);
        _824 = float4(_822.x, _822.y, _822.z, _244.w);
    }
    else
    {
        _824 = float4(_368.x, _368.y, _368.z, _244.w);
    }
    float4 _1179;
    [branch]
    if (_32_m1 > 0.75f)
    {
        float3 _970;
        float _973;
        float _873 = 1.0f / _32_m39.x;
        float _875 = _32_m39.w + _32_m39.x;
        float3 _878 = normalize(_218);
        float _879 = dot(_878, _32_m25.xyz);
        float _884 = ((_32_m29.x * _32_m29.x) - 1.0f) + (_879 * _879);
        float3 _897 = (((_878 * (_879 - sqrt(max(0.0f, _884)))) - _32_m25.xyz) / _32_m29.x.xxx).xyz;
        float _901 = dot(_897, _32_m31.xyz);
        float _902 = -_901;
        float3 _910 = normalize(_897 - (_32_m31.xyz * _901));
        float _919 = float(int(sign(dot(_910, _32_m35.xyz))));
        float2 _924 = float2(clamp(-_919, 0.0f, 1.0f) + (_919 * (acos(dot(_910, _32_m33.xyz)) * 0.15915493667125701904296875f)), ((((-0.22222222387790679931640625f) * (_902 * _902)) + (-0.27777779102325439453125f)) * _902) + 0.500000059604644775390625f);
        float4 _926 = _EID4922Res23.SampleBias(sampler_EID4922Res23, _924, _13_m16);
        float _933 = clamp((clamp(dot(_32_m27.xyz, _897), 0.0f, 1.0f) * _32_m5) + _32_m7, 0.0f, 1.0f);
        float4 _936 = _EID4922Res27.SampleBias(sampler_EID4922Res27, _924, _13_m16);
        float _941 = _926.w;
        float4 _946 = float4((_926.xyz * _933) + (_936.xyz * _32_m19.xyz), _941) * float(max(_884 * clamp(dot(_878, normalize(_32_m25.xyz)), 0.0f, 1.0f), 0.0f) > 0.0f);
        float3 _948 = _946.xyz * _941;
        float _952 = lerp(1.0f, clamp(_878.y, 0.0f, 1.0f), _32_m41.w);
        float4 _954 = (float4(_948.x, _948.y, _948.z, _946.w) * _32_m15) * _952;
        float3 _963 = _878 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(_878, _878)));
        float3 _967 = _32_m27.xyz * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(_32_m27.xyz, _32_m27.xyz)));
        float _987;
        float _988;
        bool _989;
        do
        {
            _970 = float4(_32_m23.xyz, _875).xyz;
            float3 _971 = EID4922GetCameraPositionWS() - _970;
            _973 = _875 * _875;
            float _975 = dot(_963, _971);
            float _977 = (_975 * _975) - (dot(_971, _971) - _973);
            if (_977 <= 0.0f)
            {
                _987 = 0.0f;
                _988 = 0.0f;
                _989 = false;
                break;
            }
            float _981 = sqrt(_977);
            float _982 = -_975;
            float _984 = max(0.0f, _982 - _981);
            _987 = _984;
            _988 = (_982 + _981) - _984;
            _989 = true;
            break;
        } while(false);
        float3 _1110;
        if (_989)
        {
            float _1009;
            bool _1010;
            do
            {
                float3 _995 = EID4922GetCameraPositionWS() - float4(_32_m23.xyz, _32_m39.w).xyz;
                float _999 = dot(_963, _995);
                float _1001 = (_999 * _999) - (dot(_995, _995) - (_32_m39.w * _32_m39.w));
                if (_1001 <= 0.0f)
                {
                    _1009 = 0.0f;
                    _1010 = false;
                    break;
                }
                _1009 = max(0.0f, (-_999) - sqrt(_1001));
                _1010 = true;
                break;
            } while(false);
            float _1019;
            if (_1010)
            {
                float _1018;
                if (_1009 > 0.0f)
                {
                    _1018 = min(_988, _1009 - _987);
                }
                else
                {
                    _1018 = _988;
                }
                _1019 = _1018;
            }
            else
            {
                _1019 = _988;
            }
            float3 _1109;
            if (_1019 > 0.0f)
            {
                float _1025 = _1019 / _32_m39.y;
                float _1030 = dot(-_963, _967);
                float3 _1035 = _32_m39.z.xxx * float3(0.000244140625f, 0.001267349696718156337738037109375f, 0.00266802101396024227142333984375f);
                float3 _1040;
                float3 _1042;
                _1040 = (EID4922GetCameraPositionWS() + (_963 * _987)) + ((_963 * 0.5f) * _1025);
                _1042 = 0.0f.xxx;
                float _1038;
                float3 _1041;
                float3 _1043;
                float _1037 = 0.0f;
                int _1044 = 0;
                for (; float(_1044) < _32_m39.y; _1037 = _1038, _1040 = _1041, _1042 = _1043, _1044++)
                {
                    float3 _1050 = _1040 - _970;
                    float _1058 = min(exp((-((length(_1050) - _32_m39.w) * _873)) * _32_m40.y) * _1025, 3.4028234663852885981170418348452e+38f);
                    _1038 = _1037 + _1058;
                    float _1075;
                    do
                    {
                        float _1063 = dot(_967, _1050);
                        float _1065 = (_1063 * _1063) - (dot(_1050, _1050) - _973);
                        if (_1065 <= 0.0f)
                        {
                            _1075 = 0.0f;
                            break;
                        }
                        float _1069 = sqrt(_1065);
                        float _1070 = -_1063;
                        _1075 = (_1070 + _1069) - max(0.0f, _1070 - _1069);
                        break;
                    } while(false);
                    float _1076 = _1075 / _32_m40.x;
                    float3 _1081;
                    float _1084;
                    _1081 = _1040 + ((_967 * 0.5f) * _1076);
                    _1084 = 0.0f;
                    for (int _1086 = 0; float(_1086) < _32_m40.x; )
                    {
                        float3 _1091 = _1081 - _970;
                        _1081 += (_967 * _1076);
                        _1084 += exp((-(max(length(_1091) - _32_m39.w, 0.0f) * _873)) * _32_m40.y);
                        _1086++;
                        continue;
                    }
                    _1043 = _1042 + (exp(-(_1035 * ((_1084 * _1076) + _1038))) * _1058);
                    _1041 = _1040 + (_963 * _1025);
                }
                _1109 = (_1042 * (0.0596831031143665313720703125f * (1.0f + (_1030 * _1030)))) * _1035;
            }
            else
            {
                _1109 = 0.0f.xxx;
            }
            _1110 = _1109;
        }
        else
        {
            _1110 = 0.0f.xxx;
        }
        float3 _1111 = _1110 * _32_m40.z;
        float _1112 = _1111.z;
        float _1113 = _1111.y;
        float4 _1118 = lerp(float4(_1112, _1113, -1.0f, 0.666666686534881591796875f), float4(_1113, _1112, 0.0f, -0.3333333432674407958984375f), step(_1112, _1113).xxxx);
        float _1119 = _1111.x;
        float _1120 = _1118.x;
        float4 _1128 = lerp(float4(_1120, _1118.yw, _1119), float4(_1119, _1118.yz, _1120), step(_1120, _1119).xxxx);
        float _1129 = _1128.x;
        float _1130 = _1128.w;
        float _1131 = _1128.y;
        float _1133 = _1129 - min(_1130, _1131);
        float3 _1144;
        _1144.x = abs(_1128.z + ((_1130 - _1131) / ((6.0f * _1133) + 9.9999997473787516355514526367188e-05f))) + _32_m40.w;
        float3 _1155 = lerp(1.0f.xxx, clamp(abs((frac(_1144.xxx + float3(1.0f, 0.666666686534881591796875f, 0.3333333432674407958984375f)) * 6.0f) - 3.0f.xxx) - 1.0f.xxx, 0.0f.xxx, 1.0f.xxx), (_1133 / (_1129 + 9.9999997473787516355514526367188e-05f)).xxx) * _1129;
        float _1161 = _954.w;
        float3 _1177 = ((_824.xyz * (1.0f - (_1161 * (1.0f - (step(0.5f, _32_m9) * step(_32_m9, 1.5f)))))) + (_954.xyz * (1.0f - ((1.0f - _1161) * step(_32_m9, 0.5f))))).xyz + (lerp(_1155 * _933, _1155, _32_m41.y.xxx) * _952);
        _1179 = float4(_1177.x, _1177.y, _1177.z, _824.w);
    }
    else
    {
        _1179 = _824;
    }
    float3 _1182 = lerp(_1179.xyz, _364, _367).xyz;
    float _1210 = ps_in0.y * _13_m46.w;
    float _1215 = max(0.00999999977648258209228515625f, _1210 + _13_m47.w);
    float3 _1229 = exp(_13_m45.xyz * ((-max(0.0f, (_223 * _13_m44.w) - _13_m43.w)) * (((1.0f - exp(-_1215)) / _1215) * exp(_1210 + _13_m48.w))));
    float _1232 = dot(_222, _13_m44.xyz);
    float _1238 = _13_m45.w * _13_m45.w;
    float _1242 = (1.0f + _1238) - ((2.0f * _13_m45.w) * _1232);
    float3 _1569;
    float _1570;
    if (_13_m55.z > 0.0f)
    {
        uint3 _1396 = (uint3(int3(int(_214.x), int(_214.y), int(_13_m19 & 7u))) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
        uint _1397 = _1396.y;
        uint _1398 = _1396.z;
        uint _1401 = _1396.x + (_1397 * _1398);
        uint _1403 = _1397 + (_1398 * _1401);
        uint _1405 = _1398 + (_1401 * _1403);
        uint _1407 = _1401 + (_1403 * _1405);
        float _1434 = dot(_222, -_11_m0[2].xyz);
        float _1442 = (_13_m55.w * ((_1434 > 5.9604644775390625e-08f) ? (1.0f / _1434) : 0.0f)) * (1.0f / _223);
        float _1443 = _218.y;
        float _1444 = _1442 * _1443;
        float _1446 = EID4922GetCameraPositionWS().y + _1444;
        float _1447 = _1443 - _1444;
        float _1449 = (1.0f - _1442) * _223;
        float _1463 = max(-127.0f, _13_m49.z * _1447);
        float _1487 = max(-127.0f, _13_m52.x * _1447);
        float _1498 = ((_13_m49.y * exp2(-max(-127.0f, _13_m49.z * (_1446 - _13_m49.x)))) * ((abs(_1463) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-_1463)) / _1463) : (0.693147182464599609375f - (0.2402265071868896484375f * _1463)))) + ((_13_m52.y * exp2(-max(-127.0f, _13_m52.x * (_1446 - _13_m52.z)))) * ((abs(_1487) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-_1487)) / _1487) : (0.693147182464599609375f - (0.2402265071868896484375f * _1487))));
        float _1520 = clamp((_223 * _13_m50.w) + _13_m50.z, 0.0f, 1.0f);
        float _1523 = clamp((max(clamp(exp2(-(_1498 * _1449)), 0.0f, 1.0f), _13_m51.w) + clamp((_223 * _13_m50.y) + _13_m50.x, 0.0f, 1.0f)) + _1520, 0.0f, 1.0f);
        float4 _1563 = lerp(float4(0.0f, 0.0f, 0.0f, 1.0f), _EID4922Res18.SampleLevel(sampler_EID4922Res19, float3((float2(_214) + ((((float3(uint3(_1407, _1403 + (_1405 * _1407), _205) >> uint3(16u, 16u, 16u)) * 1.525902189314365386962890625e-05f.xxx) * 2.0f) - 1.0f.xxx) * _13_m59.w).xy) * _13_m57.xy, (log2((_209 * _13_m56.x) + _13_m56.y) * _13_m56.z) / _13_m55.z), 0.0f), clamp((_209 - _13_m58.z) * 1000000.0f, 0.0f, 1.0f).xxxx);
        _1569 = _1563.xyz + (((_13_m51.xyz * (1.0f - _1523)) + (((_13_m54.xyz * pow(clamp(dot(_252, _13_m53.xyz), 0.0f, 1.0f), _13_m54.w)) * (1.0f - clamp(exp2(-(_1498 * max(_1449 - _13_m53.w, 0.0f))), 0.0f, 1.0f))) * (1.0f - _1520))) * _1563.w);
        _1570 = _1563.w * _1523;
    }
    else
    {
        float _1270 = _218.y;
        float _1284 = max(-127.0f, _13_m49.z * _1270);
        float _1308 = max(-127.0f, _13_m52.x * _1270);
        float _1319 = ((_13_m49.y * exp2(-max(-127.0f, _13_m49.z * (EID4922GetCameraPositionWS().y - _13_m49.x)))) * ((abs(_1284) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-_1284)) / _1284) : (0.693147182464599609375f - (0.2402265071868896484375f * _1284)))) + ((_13_m52.y * exp2(-max(-127.0f, _13_m52.x * (EID4922GetCameraPositionWS().y - _13_m52.z)))) * ((abs(_1308) > 5.9604644775390625e-08f) ? ((1.0f - exp2(-_1308)) / _1308) : (0.693147182464599609375f - (0.2402265071868896484375f * _1308))));
        float _1341 = clamp((_223 * _13_m50.w) + _13_m50.z, 0.0f, 1.0f);
        float _1344 = clamp((max(clamp(exp2(-(_1319 * _223)), 0.0f, 1.0f), _13_m51.w) + clamp((_223 * _13_m50.y) + _13_m50.x, 0.0f, 1.0f)) + _1341, 0.0f, 1.0f);
        _1569 = (_13_m51.xyz * (1.0f - _1344)) + (((_13_m54.xyz * pow(clamp(dot(_252, _13_m53.xyz), 0.0f, 1.0f), _13_m54.w)) * (1.0f - clamp(exp2(-(_1319 * max(_223 - _13_m53.w, 0.0f))), 0.0f, 1.0f))) * (1.0f - _1341));
        _1570 = _1344;
    }
    float3 _1575 = ((lerp(dot(_1182, float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f)).xxx, _1182, _13_m76.w.xxx) * _13_m76.xyz).xyz * (_1229 * _1570)) + ((((clamp(((_13_m46.xyz * (0.0596831031143665313720703125f * (1.0f + (_1232 * _1232)))) + _13_m48.xyz) + (_13_m47.xyz * ((1.0f - _1238) / max((12.56637096405029296875f * _1242) * sqrt(_1242), 0.001000000047497451305389404296875f))), 0.0f.xxx, 1.0f.xxx) * 255.0f) * (1.0f.xxx - _1229)) * _1570) + _1569);
    float4 _1576 = float4(_1575.x, _1575.y, _1575.z, _1179.w);
    _1576.w = 1.0f;
    float2 _1590 = (ps_in2.xy / max(ps_in2.z, 9.9999999392252902907785028219223e-09f).xx) - (ps_in3.xy / max(ps_in3.z, 9.9999999392252902907785028219223e-09f).xx);
    _1590.y = -_1590.y;
    ps_out0 = _1576;
    ps_out1 = float4(((sqrt(sqrt(abs(_1590 * 0.5f))) * float2(int2(sign(_1590)))) * 0.5f) + 0.5f.xx, 0.0f, 0.0f);
}



float _EID4922DebugMode;
float _EID4922DepthMode;

struct EID4922VertexInput
{
    float3 positionOS : POSITION;
    float2 uv : TEXCOORD0;
};
struct EID4922Varyings
{
    float4 positionCS : SV_Position;
    float3 worldPos : TEXCOORD0;
    float3 screenPos : TEXCOORD2;
    float3 previousScreenPos : TEXCOORD3;
};
EID4922Varyings EID4922VertexMain(EID4922VertexInput input)
{
    EID4922Varyings o;
    if (_EID4922UseRealtimeMVP > 0.5f)
    {
        // The mesh is a unit sphere. The CPU supplies P * rotation-only-V * scale.
        // No manual Vulkan Y inversion is applied here; Unity's GPU projection handles it.
        float3 directionWS = normalize(input.positionOS);
        float4 positionCS = mul(_EID4922RealtimeMVP, float4(input.positionOS, 1.0f));
        positionCS.z = (_EID4922DepthMode < 0.5f) ? 0.0f : positionCS.w;
        o.positionCS = positionCS;
        o.worldPos = _EID4922RealtimeCameraPositionWS.xyz + directionWS * _EID4922SkyRadius;
        o.screenPos = positionCS.xyw;
        o.previousScreenPos = positionCS.xyw;
    }
    else
    {
        _2 = input.positionOS;
        _3 = input.uv;
        vert_main();
        o.positionCS = gl_Position;
        o.worldPos = _5;
        o.screenPos = _7;
        o.previousScreenPos = _8;
    }
    return o;
}
float4 EID4922PixelMain(EID4922Varyings input) : SV_Target0
{
    // Do the same raw-depth validity test as EID4662FullFS. A non-background
    // scene depth always rejects the sky before it can write CameraColor.
    if (_EID4922SceneDepthAvailable > 0.5f)
    {
        // SceneView can render into a different viewport than GameView. Clamp the
        // integer Load coordinates to the actual URP depth texture dimensions so the
        // two views cannot diverge because of an out-of-range or stale pixel address.
        uint depthWidth, depthHeight;
        _CameraDepthTexture.GetDimensions(depthWidth, depthHeight);
        int2 pixel = int2(input.positionCS.xy);
        int2 maxPixel = max(int2(0, 0), int2((int)depthWidth - 1, (int)depthHeight - 1));
        pixel = clamp(pixel, int2(0, 0), maxPixel);
        float sceneDepth = _CameraDepthTexture.Load(int3(pixel, 0)).r;
        float validSceneDepth = (_EID4922SceneDepthReversedZ > 0.5f)
            ? step(_EID4922SceneDepthEpsilon, sceneDepth)
            : step(sceneDepth, 1.0f - _EID4922SceneDepthEpsilon);
        clip(0.5f - validSceneDepth);
    }
    if (_EID4922DebugMode > 0.5) return float4(1.0, 1.0, 1.0, 1.0);
    gl_FragCoord = input.positionCS;
    gl_FragCoord.w = 1.0 / max(input.positionCS.w, 1e-6);
    ps_in0 = input.worldPos;
    ps_in2 = input.screenPos;
    ps_in3 = input.previousScreenPos;
    frag_main();
    return ps_out0;
}
