// RenderDoc endfield06 EID4613 PS215963. Original FS arithmetic; per-camera input/transform adapters.
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

cbuffer _13_14
{
    float4 _14_m0 : packoffset(c0);
    float4 _14_m1 : packoffset(c1);
    float4 _14_m2 : packoffset(c2);
    float4 _14_m3 : packoffset(c3);
    float4 _14_m4 : packoffset(c4);
    uint4 _14_m5 : packoffset(c5);
    float4 _14_m6 : packoffset(c6);
    float4 _14_m7 : packoffset(c7);
};

cbuffer _15_17
{
    float4 _17_m0 : packoffset(c0);
    float4 _Capsules[384] : packoffset(c1);
};

SamplerState sampler_PointClamp;
SamplerState sampler_LinearClamp;
Texture2D<float4> _12;
Texture2D<float4> _18;
Texture2D<float4> _19;

float4 _CP16OutputSize;
float _CP16CapturedProjection;
float4x4 _CP16WorldToClip;
float4x4 _CP16ClipToWorld;
StructuredBuffer<float3> _CP16Vertices;
StructuredBuffer<uint> _CP16Indices;

static float4 gl_FragCoord;
static uint _4;
static float4 _5;

struct CP16FragmentInput
{
    nointerpolation uint _4 : TEXCOORD2;
    float4 gl_FragCoord : SV_Position;
};

struct CP16FragmentOutput
{
    float4 _5 : SV_Target0;
};

void frag_main()
{
    float2 _79 = gl_FragCoord.xy * _CP16OutputSize.zw;
    float2 _88 = (_79 * 2.0f) - 1.0f.xx;
    float4 _93 = float4(_88, _12.SampleLevel(sampler_PointClamp, _79, 0.0f).x, 1.0f);
    _93.y = -_88.y;
    float4 _94 = mul((_CP16CapturedProjection > 0.5f ? _7_m6 : _CP16ClipToWorld), _93);
    float3 _98 = _94.xyz / _94.w.xxx;
    float2 _105 = (_19.SampleLevel(sampler_LinearClamp, _79, 0.0f).xy * 2.0f) - 1.0f.xx;
    float _109 = 1.0f - dot(1.0f.xx, abs(_105));
    float3 _111 = float3(_105.x, _109, _105.y);
    float3 _123;
    if (_109 < 0.0f)
    {
        float2 _118 = _111.xz;
        bool2 _119 = bool2(_118.x >= 0.0f.xx.x, _118.y >= 0.0f.xx.y);
        float2 _121 = (1.0f.xx - abs(_111.zx)) * float2(_119.x ? 1.0f.xx.x : (-1.0f).xx.x, _119.y ? 1.0f.xx.y : (-1.0f).xx.y);
        _123 = float3(_121.x, _111.y, _121.y);
    }
    else
    {
        _123 = _111;
    }
    float3 _124 = normalize(_123);
    float4 _256;
    do
    {
        float _141 = (0.5f * _14_m4.y) * _Capsules[(_4) * 3u + 1u].w;
        float _142 = distance((_Capsules[(_4) * 3u + 0u].xyz + _Capsules[(_4) * 3u + 1u].xyz) * 0.5f, _98);
        if (_142 > _141)
        {
            _256 = 0.0f.xxxx;
            break;
        }
        float _150 = (_14_m4.x * 1.2000000476837158203125f) * _Capsules[(_4) * 3u + 0u].w;
        uint _154 = min(uint(ceil(_Capsules[(_4) * 3u + 1u].w / _150)), 8u);
        float3 _159 = _Capsules[(_4) * 3u + 2u].xyz * _150;
        float3 _161;
        float4 _164;
        _161 = _Capsules[(_4) * 3u + 0u].xyz + (_Capsules[(_4) * 3u + 2u].xyz * ((-_Capsules[(_4) * 3u + 0u].w) + _150));
        _164 = 0.0f.xxxx;
        float3 _162;
        float4 _165;
        for (uint _166 = 1u; _166 < _154; _161 = _162, _164 = _165, _166++)
        {
            float4 _246;
            do
            {
                float3 _173 = _161 - _98;
                float _174 = length(_173);
                float _175 = dot(_173, _124);
                float _176 = _175 + _Capsules[(_4) * 3u + 0u].w;
                bool _180 = _175 <= 0.0f;
                if ((_176 <= 0.0f) || ((_174 < (_Capsules[(_4) * 3u + 0u].w + 9.9999997473787516355514526367188e-06f)) && _180))
                {
                    _246 = 0.0f.xxxx;
                    break;
                }
                float _185 = abs(_175);
                float _211;
                float _212;
                float3 _213;
                if (_185 <= _Capsules[(_4) * 3u + 0u].w)
                {
                    float3 _192 = _161 - (_124 * _175);
                    float3 _195 = (((_161 + (_124 * _Capsules[(_4) * 3u + 0u].w)) + _192) * 0.5f) - _98;
                    float _208;
                    if (_180)
                    {
                        float _202 = sqrt((_Capsules[(_4) * 3u + 0u].w * _Capsules[(_4) * 3u + 0u].w) - (_185 * _185));
                        float _206 = (length(_98 - _192) - _202) / _202;
                        _208 = isnan(_206) ? 1.0f : (isnan(1.0f) ? _206 : min(1.0f, _206));
                    }
                    else
                    {
                        _208 = 1.0f;
                    }
                    _211 = (0.5f * _176) * _208;
                    _212 = length(_195);
                    _213 = _195;
                }
                else
                {
                    _211 = _Capsules[(_4) * 3u + 0u].w;
                    _212 = _174;
                    _213 = _173;
                }
                float3 _214 = normalize(_213);
                _246 = float4(((_18.SampleLevel(sampler_LinearClamp, float2((((sqrt((_212 * _212) - (_211 * _211)) / _212) * 255.0f) + 0.5f) * 0.00390625f, 0.5f), 0.0f).zw * _14_m1.xy) + _14_m1.zw).xyyy) * float4(0.2820948064327239990234375f, (-0.4886024892330169677734375f) * _214.y, 0.4886024892330169677734375f * _214.z, (-0.4886024892330169677734375f) * _214.x);
                break;
            } while(false);
            _165 = _164 + _246;
            _162 = _161 + _159;
        }
        _256 = _164 * ((1.0f - clamp((clamp(_142 / _141, 0.0f, 1.0f) - 0.300000011920928955078125f) * 1.4285714626312255859375f, 0.0f, 1.0f)) * _Capsules[(_4) * 3u + 2u].w);
        break;
    } while(false);
    _5 = _256;
}

[earlydepthstencil]
CP16FragmentOutput CP16Fragment(CP16FragmentInput stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    _4 = stage_input._4;
    frag_main();
    CP16FragmentOutput stage_output;
    stage_output._5 = _5;
    return stage_output;
}

// Original VS sphere expansion. Captured jitter is exactly zero in this draw.
CP16FragmentInput CP16Vertex(uint vertexID : SV_VertexID, uint instanceID : SV_InstanceID)
{
    float4 start = _Capsules[instanceID * 3u];
    float4 end = _Capsules[instanceID * 3u + 1u];
    float3 world = (_CP16Vertices[_CP16Indices[vertexID]] * end.w) * _14_m4.y + (start.xyz + end.xyz) * 0.5f;
    float4 clip;
    if (_CP16CapturedProjection > 0.5f)
    {
        clip = mul(_7_m8, float4(world - _7_m11.xyz, 1.0f));
        // Unity HLSL backend applies the Vulkan clip-Y conversion; do not repeat the captured SPIR-V Y flip.
    }
    else clip = mul(_CP16WorldToClip, float4(world, 1.0f));
    CP16FragmentInput o; o._4 = instanceID; o.gl_FragCoord = clip; return o;
}

