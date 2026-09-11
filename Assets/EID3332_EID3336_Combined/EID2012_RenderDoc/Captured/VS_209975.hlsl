struct _25
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

static float4 _97;

cbuffer _20_21 : register(b13)
{
    column_major float4x4 _21_m0 : packoffset(c0);
    column_major float4x4 _21_m1 : packoffset(c4);
    column_major float4x4 _21_m2 : packoffset(c8);
    column_major float4x4 _21_m3 : packoffset(c12);
    column_major float4x4 _21_m4 : packoffset(c16);
    column_major float4x4 _21_m5 : packoffset(c20);
    column_major float4x4 _21_m6 : packoffset(c24);
    column_major float4x4 _21_m7 : packoffset(c28);
    column_major float4x4 _21_m8 : packoffset(c32);
    column_major float4x4 _21_m9 : packoffset(c36);
    column_major float4x4 _21_m10 : packoffset(c40);
    float4 _21_m11 : packoffset(c44);
    column_major float4x4 _21_m12 : packoffset(c45);
    column_major float4x4 _21_m13 : packoffset(c49);
    column_major float4x4 _21_m14 : packoffset(c53);
    column_major float4x4 _21_m15 : packoffset(c57);
    column_major float4x4 _21_m16 : packoffset(c61);
    column_major float4x4 _21_m17 : packoffset(c65);
    column_major float4x4 _21_m18 : packoffset(c69);
    column_major float4x4 _21_m19 : packoffset(c73);
    column_major float4x4 _21_m20 : packoffset(c77);
    float4 _21_m21 : packoffset(c81);
};

cbuffer _22_23 : register(b16)
{
    float4 _23_m0 : packoffset(c0);
    float4 _23_m1 : packoffset(c1);
    float4 _23_m2 : packoffset(c2);
    float4 _23_m3 : packoffset(c3);
    float4 _23_m4 : packoffset(c4);
    float4 _23_m5 : packoffset(c5);
    float4 _23_m6[6] : packoffset(c6);
    float4 _23_m7[6] : packoffset(c12);
    float4 _23_m8 : packoffset(c18);
    float4 _23_m9 : packoffset(c19);
    float4 _23_m10 : packoffset(c20);
    float4 _23_m11 : packoffset(c21);
    float4 _23_m12 : packoffset(c22);
    float4 _23_m13 : packoffset(c23);
    float4 _23_m14 : packoffset(c24);
    float4 _23_m15 : packoffset(c25);
    float _23_m16 : packoffset(c26);
    float _23_m17 : packoffset(c26.y);
    float _23_m18 : packoffset(c26.z);
    uint _23_m19 : packoffset(c26.w);
    float4 _23_m20 : packoffset(c27);
    int4 _23_m21 : packoffset(c28);
    float4 _23_m22 : packoffset(c29);
    float4 _23_m23 : packoffset(c30);
    float4 _23_m24 : packoffset(c31);
    float4 _23_m25 : packoffset(c32);
    float4 _23_m26 : packoffset(c33);
    float4 _23_m27 : packoffset(c34);
    float4 _23_m28 : packoffset(c35);
    float4 _23_m29 : packoffset(c36);
    float4 _23_m30 : packoffset(c37);
    float4 _23_m31 : packoffset(c38);
    float4 _23_m32[4] : packoffset(c39);
    float4 _23_m33[4] : packoffset(c43);
    float4 _23_m34[4] : packoffset(c47);
    float4 _23_m35[4] : packoffset(c51);
    float4 _23_m36 : packoffset(c55);
    float4 _23_m37 : packoffset(c56);
    float4 _23_m38[4] : packoffset(c57);
    float4 _23_m39[4] : packoffset(c61);
    float4 _23_m40[4] : packoffset(c65);
    float4 _23_m41 : packoffset(c69);
    float4 _23_m42 : packoffset(c70);
    float4 _23_m43 : packoffset(c71);
    float4 _23_m44 : packoffset(c72);
    float4 _23_m45 : packoffset(c73);
    float4 _23_m46 : packoffset(c74);
    float4 _23_m47 : packoffset(c75);
    float4 _23_m48 : packoffset(c76);
    float4 _23_m49 : packoffset(c77);
    float4 _23_m50 : packoffset(c78);
    float4 _23_m51 : packoffset(c79);
    float4 _23_m52 : packoffset(c80);
    float4 _23_m53 : packoffset(c81);
    float4 _23_m54 : packoffset(c82);
    float4 _23_m55 : packoffset(c83);
    float4 _23_m56 : packoffset(c84);
    float4 _23_m57 : packoffset(c85);
    float4 _23_m58 : packoffset(c86);
    float4 _23_m59 : packoffset(c87);
    float4 _23_m60 : packoffset(c88);
    float4 _23_m61 : packoffset(c89);
    float4 _23_m62 : packoffset(c90);
    float4 _23_m63 : packoffset(c91);
    float4 _23_m64 : packoffset(c92);
    float4 _23_m65 : packoffset(c93);
    float4 _23_m66 : packoffset(c94);
    float4 _23_m67 : packoffset(c95);
    float4 _23_m68 : packoffset(c96);
    float4 _23_m69 : packoffset(c97);
    float4 _23_m70 : packoffset(c98);
    float4 _23_m71 : packoffset(c99);
    float4 _23_m72 : packoffset(c100);
    float4 _23_m73 : packoffset(c101);
    float4 _23_m74 : packoffset(c102);
    float4 _23_m75 : packoffset(c103);
    float4 _23_m76 : packoffset(c104);
    float4 _23_m77 : packoffset(c105);
    float4 _23_m78 : packoffset(c106);
    float4 _23_m79 : packoffset(c107);
    float4 _23_m80 : packoffset(c108);
    float4 _23_m81 : packoffset(c109);
    float4 _23_m82 : packoffset(c110);
    float4 _23_m83 : packoffset(c111);
    float4 _23_m84 : packoffset(c112);
    float4 _23_m85 : packoffset(c113);
    float4 _23_m86 : packoffset(c114);
    float4 _23_m87 : packoffset(c115);
    float4 _23_m88 : packoffset(c116);
    float4 _23_m89 : packoffset(c117);
    float4 _23_m90 : packoffset(c118);
    float4 _23_m91 : packoffset(c119);
    float4 _23_m92 : packoffset(c120);
    float4 _23_m93 : packoffset(c121);
    float4 _23_m94 : packoffset(c122);
    float4 _23_m95 : packoffset(c123);
    float4 _23_m96 : packoffset(c124);
    float4 _23_m97 : packoffset(c125);
    float4 _23_m98 : packoffset(c126);
    float4 _23_m99[2] : packoffset(c127);
    float4 _23_m100[2] : packoffset(c129);
    float _23_m101 : packoffset(c131);
    float _23_m102 : packoffset(c131.y);
    float _23_m103 : packoffset(c131.z);
    float _23_m104 : packoffset(c131.w);
    float4 _23_m105 : packoffset(c132);
    float4 _23_m106 : packoffset(c133);
    float4 _23_m107 : packoffset(c134);
    float4 _23_m108 : packoffset(c135);
    float4 _23_m109 : packoffset(c136);
    float4 _23_m110 : packoffset(c137);
    float4 _23_m111 : packoffset(c138);
    float4 _23_m112 : packoffset(c139);
    float4 _23_m113 : packoffset(c140);
    float4 _23_m114 : packoffset(c141);
    float4 _23_m115 : packoffset(c142);
    float4 _23_m116 : packoffset(c143);
    float4 _23_m117 : packoffset(c144);
    float4 _23_m118 : packoffset(c145);
    float4 _23_m119 : packoffset(c146);
    float4 _23_m120 : packoffset(c147);
    float4 _23_m121 : packoffset(c148);
    float4 _23_m122 : packoffset(c149);
    float4 _23_m123 : packoffset(c150);
    float4 _23_m124 : packoffset(c151);
    float4 _23_m125 : packoffset(c152);
    float4 _23_m126 : packoffset(c153);
    float4 _23_m127 : packoffset(c154);
    float4 _23_m128 : packoffset(c155);
    float4 _23_m129 : packoffset(c156);
    float4 _23_m130 : packoffset(c157);
    float4 _23_m131 : packoffset(c158);
    float4 _23_m132 : packoffset(c159);
    float4 _23_m133 : packoffset(c160);
    float4 _23_m134 : packoffset(c161);
    column_major float4x4 _23_m135 : packoffset(c162);
    float4 _23_m136 : packoffset(c166);
    float4 _23_m137 : packoffset(c167);
    float4 _23_m138[32] : packoffset(c168);
};

cbuffer _24_26 : register(b0)
{
    _25 _26_m0[256] : packoffset(c0);
};


static float4 gl_Position;
static int gl_InstanceIndex;
static float3 _3;
static float3 _4;
static float4 _5;
static float4 _6;
static float2 _7;
static float2 _8;
static float4 _9;
static float2 _12;
static float3 _14;
static float4 _15;
static float3 _17;
static float3 _18;

struct SPIRV_Cross_Input
{
    float3 _3 : TEXCOORD0;
    float3 _4 : TEXCOORD1;
    float4 _5 : TEXCOORD2;
    float4 _6 : TEXCOORD3;
    float2 _7 : TEXCOORD4;
    float2 _8 : TEXCOORD5;
    float4 _9 : TEXCOORD6;
    uint gl_InstanceIndex : SV_InstanceID;
};

struct SPIRV_Cross_Output
{
    float2 _12 : TEXCOORD0;
    float3 _14 : TEXCOORD2;
    float4 _15 : TEXCOORD3;
    float3 _17 : TEXCOORD5;
    float3 _18 : TEXCOORD6;
    float4 gl_Position : SV_Position;
};

void vert_main()
{
    uint _109 = asuint(_4.x);
    bool _111 = (_109 & 1073741824u) > 0u;
    float4 _184;
    float3 _185;
    if (_111)
    {
        float _117 = float((_109 << 22u) >> 22u);
        float _120 = float((_109 << 12u) >> 22u);
        float _123 = float((_109 << 2u) >> 22u);
        float3 _137 = float3((_117 >= 512.0f) ? (_117 - 1024.0f) : _117, (_120 >= 512.0f) ? (_120 - 1024.0f) : _120, 0.0f) * 0.001956947147846221923828125f;
        float _143 = (1.0f - abs(_137.x)) - abs(_137.y);
        float3 _144 = _137;
        _144.z = _143;
        bool2 _146 = (_143 < 0.0f).xx;
        float2 _154 = (1.0f.xx - abs(_144.yx)) * ((step(0.0f.xx, _144.xy) * 2.0f) - 1.0f.xx);
        float2 _155 = float2(_146.x ? _154.x : _144.xy.x, _146.y ? _154.y : _144.xy.y);
        float3 _157 = normalize(float3(_155.x, _155.y, _144.z));
        float _158 = ((_123 >= 512.0f) ? (_123 - 1024.0f) : _123) * 0.001956947147846221923828125f;
        float3 _161 = _157.yzx - _157.zxy;
        float3 _165 = normalize(_161 - dot(_161, _157).xxx);
        float _170 = (_158 < 0.0f) ? (-1.0f) : 1.0f;
        float _173 = 1.0f - ((_158 * _170) * 2.0f);
        float3 _179 = mul(normalize(float2(_173, _170 * (1.0f - abs(_173)))), float2x3(_165, normalize(cross(_157, _165))));
        float4 _180 = float4(_179.x, _179.y, _179.z, _97.w);
        _180.w = (float((_109 >> 31u) & 1u) * 2.0f) - 1.0f;
        _184 = _180;
        _185 = _157;
    }
    else
    {
        _184 = 0.0f.xxxx;
        _185 = _4;
    }
    bool4 _186 = _111.xxxx;
    float4 _187 = float4(_186.x ? _184.x : _5.x, _186.y ? _184.y : _5.y, _186.z ? _184.z : _5.z, _186.w ? _184.w : _5.w);
    float3x3 _196 = float3x3(_26_m0[uint(gl_InstanceIndex)]._m0[0].xyz, _26_m0[uint(gl_InstanceIndex)]._m0[1].xyz, _26_m0[uint(gl_InstanceIndex)]._m0[2].xyz);
    float3 _206 = mul(_196, _3) + (float3(_26_m0[uint(gl_InstanceIndex)]._m0[0].w, _26_m0[uint(gl_InstanceIndex)]._m0[1].w, _26_m0[uint(gl_InstanceIndex)]._m0[2].w) - _21_m11.xyz);
    float3 _215 = mul(_196, float3(1.0f / dot(_26_m0[uint(gl_InstanceIndex)]._m0[0].xyz, _26_m0[uint(gl_InstanceIndex)]._m0[0].xyz), 1.0f / dot(_26_m0[uint(gl_InstanceIndex)]._m0[1].xyz, _26_m0[uint(gl_InstanceIndex)]._m0[1].xyz), 1.0f / dot(_26_m0[uint(gl_InstanceIndex)]._m0[2].xyz, _26_m0[uint(gl_InstanceIndex)]._m0[2].xyz)) * _185);
    float3 _221 = mul(_196, _187.xyz);
    float4 _242 = mul(_21_m8, float4(_206, 1.0f));
    float2 _250 = _242.xy - ((_23_m9.zw * float2(2.0f, -2.0f)) * _242.w);
    float4 _251 = float4(_250.x, _250.y, _242.z, _242.w);
    bool3 _256 = (_26_m0[uint(gl_InstanceIndex)]._m4.x < 1.0f).xxx;
    bool4 _262 = (_26_m0[uint(gl_InstanceIndex)]._m4.y < 1.0f).xxxx;
    float4 _271 = float4(_206 + (_21_m11.xyz - _21_m21.xyz), 1.0f);
    float4 _291 = float4(mul(float3x3(_26_m0[uint(gl_InstanceIndex)]._m3[0].xyz, _26_m0[uint(gl_InstanceIndex)]._m3[1].xyz, _26_m0[uint(gl_InstanceIndex)]._m3[2].xyz), float3(_256.x ? _3.x : _9.xyz.x, _256.y ? _3.y : _9.xyz.y, _256.z ? _3.z : _9.xyz.z)) + (float3(_26_m0[uint(gl_InstanceIndex)]._m3[0].w, _26_m0[uint(gl_InstanceIndex)]._m3[1].w, _26_m0[uint(gl_InstanceIndex)]._m3[2].w) - _21_m21.xyz), 1.0f);
    _251.y = -_250.y;
    gl_Position = _251;
    _12 = _7;
    _14 = _215 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(_215, _215)));
    _15 = float4(_221 * rsqrt(max(1.1754943508222875079687365372222e-38f, dot(_221, _221))), _187.w * ((_26_m0[uint(gl_InstanceIndex)]._m2.w >= 0.0f) ? 1.0f : (-1.0f)));
    _17 = _242.xyw;
    _18 = mul(_21_m15, float4(_262.x ? _271.x : _291.x, _262.y ? _271.y : _291.y, _262.z ? _271.z : _291.z, _262.w ? _271.w : _291.w)).xyw;
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
    vert_main();
    SPIRV_Cross_Output stage_output;
    stage_output.gl_Position = gl_Position;
    stage_output._12 = _12;
    stage_output._14 = _14;
    stage_output._15 = _15;
    stage_output._17 = _17;
    stage_output._18 = _18;
    return stage_output;
}
