// Generated from endfield06.rdc EID5519; arithmetic unchanged.
cbuffer _6_7
{
    column_major float4x4 _7_m0 : packoffset(c0);
    column_major float4x4 _7_m1 : packoffset(c4);
    column_major float4x4 _7_m2 : packoffset(c8);
    column_major float4x4 _7_m3 : packoffset(c12);
    column_major float4x4 _7_m4 : packoffset(c16);
    column_major float4x4 _7_m5 : packoffset(c20);
    column_major float4x4 _7_m6 : packoffset(c24);
    column_major float4x4 _7_m7 : packoffset(c28);
    column_major float4x4 _7_m8 : packoffset(c32);
    column_major float4x4 _7_m9 : packoffset(c36);
    column_major float4x4 _7_m10 : packoffset(c40);
    float4 _7_m11 : packoffset(c44);
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

cbuffer _11_12
{
    float4 _12_m0 : packoffset(c0);
    float4 _12_m1 : packoffset(c1);
    float4 _12_m2 : packoffset(c2);
    float4 _12_m3 : packoffset(c3);
    float4 _12_m4 : packoffset(c4);
    float4 _12_m5 : packoffset(c5);
    float4 _12_m6 : packoffset(c6);
    float4 _12_m7 : packoffset(c7);
    float4 _12_m8 : packoffset(c8);
    float4 _12_m9[3] : packoffset(c9);
};

#ifdef EID5519_LIVE
float4 _EID5519Size;
float _EID5519DepthThreshold;
float4x4 _EID5519Reprojection;
#define _12_m6 _EID5519Size
#define _7_m18 _EID5519Reprojection
#endif

SamplerState sampler_PointClamp;
Texture2D<float4> _13;
Texture2D<float4> _14;
Texture2D<float4> _15;
Texture2D<float4> _16;

static float4 gl_FragCoord;
static float _4;
static float4 _5;

struct SPIRV_Cross_Input
{
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float _4 : SV_Target0;
    float4 _5 : SV_Target1;
};

// Original SPIR-V undef resolves to (-1,-1) on the captured replay for all-zero depth.
static const float2 _72 = float2(-1.0, -1.0);

// Lossless byte upload: RGBA8 carries the four bytes of RGB10A2. No
// filtering/sRGB conversion; reconstruct integer bits from the exact Load.
float4 DecodeRGB10A2(float4 bytes) {
 #ifdef EID5519_LIVE
 return bytes; // Native RGB10A2 RT is already decoded by the texture unit.
#else
 uint4 b=(uint4)round(bytes*255.0);
 uint v=b.x | (b.y<<8u) | (b.z<<16u) | (b.w<<24u);
 uint4 u=uint4(v & 1023u, (v >> 10u) & 1023u, (v >> 20u) & 1023u, v >> 30u);
 precise float4 result=float4(u) * float4(1.0/1023.0,1.0/1023.0,1.0/1023.0,1.0/3.0);
 return float4(u.x==1023u?1.0:result.x,u.y==1023u?1.0:result.y,u.z==1023u?1.0:result.z,u.w==3u?1.0:result.w);
#endif
}
float EID5519Threshold() {
#ifdef EID5519_LIVE
 return _EID5519DepthThreshold;
#else
 return _12_m1.y;
#endif
}
void frag_main()
{
    int3 _82 = int3(int(gl_FragCoord.x), int(gl_FragCoord.y), 0);
    float2 _84 = float2(_82.xy);
    float2 _88 = _84 * _12_m6.zw;
    float4 _92 = _13.GatherRed(sampler_PointClamp, _88);
    float4 _101 = _13.GatherRed(sampler_PointClamp, _88 + (float2(_12_m6.z, 0.0f) * 2.0f));
    float4 _110 = _13.GatherRed(sampler_PointClamp, _88 + (float2(0.0f, _12_m6.w) * 2.0f));
    float4 _116 = _13.GatherRed(sampler_PointClamp, _88 + (_12_m6.zw * 2.0f));
    float _117 = _92.w;
    float _118 = _92.z;
    float _119 = _101.w;
    float _120 = _92.x;
    float _121 = _92.y;
    float _122 = _101.x;
    float _123 = _110.w;
    float _124 = _110.z;
    float _125 = _116.w;
    bool _126 = 0.0f < _117;
    float _127 = _126 ? _117 : 0.0f;
    bool2 _128 = _126.xx;
    float2 _129 = float2(_128.x ? (-1.0f).xx.x : _72.x, _128.y ? (-1.0f).xx.y : _72.y);
    bool _130 = _127 < _118;
    float _131 = _130 ? _118 : _127;
    bool2 _132 = _130.xx;
    float2 _133 = float2(_132.x ? float2(0.0f, -1.0f).x : _129.x, _132.y ? float2(0.0f, -1.0f).y : _129.y);
    bool _134 = _131 < _119;
    float _135 = _134 ? _119 : _131;
    bool2 _136 = _134.xx;
    float2 _137 = float2(_136.x ? float2(1.0f, -1.0f).x : _133.x, _136.y ? float2(1.0f, -1.0f).y : _133.y);
    bool _138 = _135 < _120;
    float _139 = _138 ? _120 : _135;
    bool2 _140 = _138.xx;
    float2 _141 = float2(_140.x ? float2(-1.0f, 0.0f).x : _137.x, _140.y ? float2(-1.0f, 0.0f).y : _137.y);
    bool _142 = _139 < _121;
    float _143 = _142 ? _121 : _139;
    bool2 _144 = _142.xx;
    float2 _145 = float2(_144.x ? 0.0f.xx.x : _141.x, _144.y ? 0.0f.xx.y : _141.y);
    bool _146 = _143 < _122;
    float _147 = _146 ? _122 : _143;
    bool2 _148 = _146.xx;
    float2 _149 = float2(_148.x ? float2(1.0f, 0.0f).x : _145.x, _148.y ? float2(1.0f, 0.0f).y : _145.y);
    bool _150 = _147 < _123;
    float _151 = _150 ? _123 : _147;
    bool2 _152 = _150.xx;
    float2 _153 = float2(_152.x ? float2(-1.0f, 1.0f).x : _149.x, _152.y ? float2(-1.0f, 1.0f).y : _149.y);
    bool _154 = _151 < _124;
    float _155 = _154 ? _124 : _151;
    bool2 _156 = _154.xx;
    float2 _157 = float2(_156.x ? float2(0.0f, 1.0f).x : _153.x, _156.y ? float2(0.0f, 1.0f).y : _153.y);
    bool _158 = _155 < _125;
    float _159 = _158 ? _125 : _155;
    bool2 _160 = _158.xx;
    float2 _162 = _84 + float2(_160.x ? 1.0f.xx.x : _157.x, _160.y ? 1.0f.xx.y : _157.y);
    float4 _170 = DecodeRGB10A2(_14.Load(int3(int3(int(_162.x), int(_162.y), 0).xy, 0)));
    float _171 = _170.w;
    float _177 = float(abs(_171 - 0.300000011920928955078125f) < 0.100000001490116119384765625f);
    float2 _178 = _170.xy;
    float2 _185 = (abs(_178) * 2.0f) - 1.0f.xx;
    float2 _186 = _185 * _185;
    float2 _188 = (_186 * _186) * float2(int2(sign(_178 - 0.5f.xx)));
    float2 _192 = _188 * _12_m6.xy;
    int3 _200 = int3((float3(_82) + float3(0.5f, 0.5f, 0.0f)) - float3(int3(int(_192.x), int(_192.y), 0)));
    float2 _202 = (_88 * 2.0f) - 1.0f.xx;
    float4 _207 = float4(_202, _159, 1.0f);
    _207.y = -_202.y;
    float4 _210 = mul(_7_m18, _207);
    int2 _214 = _200.xy;
    int _215 = _200.z;
    float4 _220 = DecodeRGB10A2(_16.Load(int3(_214, _215)));
    float2 _221 = _220.xy;
    float2 _228 = (abs(_221) * 2.0f) - 1.0f.xx;
    float2 _229 = _228 * _228;
    float _232 = _220.w;
    float2 _251 = abs(_188.xy - ((_229 * _229) * float2(int2(sign(_221 - 0.5f.xx)))).xy);
    float _260 = clamp((clamp(float((_15.Load(int3(_214, _215)).x - (_210.z / _210.w)) > EID5519Threshold()) + abs(_177 - float(abs(_232 - 0.300000011920928955078125f) < 0.100000001490116119384765625f)), 0.0f, 1.0f) * smoothstep(9.9999997473787516355514526367188e-05f, 0.0005000000237487256526947021484375f, _251.x + _251.y)) + abs(float(_171 > 0.89999997615814208984375f) - float(_232 > 0.89999997615814208984375f)), 0.0f, 1.0f);
    float _262 = _170.z;
    float4 _286 = _170;
    _286.z = (float(uint(float((uint(_262) | (uint((isnan(_260) ? 1.0f : (isnan(1.0f) ? _260 : min(1.0f, _260))) * (1.0f - _177)) << 1u)) | (uint(float((_262 - float(uint((_220.z * 1023.0f) + 0.5f) & 1u)) < 0.0f)) << 2u)))) + 0.5f) * 0.000977517105638980865478515625f;
    _4 = _159;
    _5 = _286;
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output._4 = _4;
    stage_output._5 = _5;
    return stage_output;
}
