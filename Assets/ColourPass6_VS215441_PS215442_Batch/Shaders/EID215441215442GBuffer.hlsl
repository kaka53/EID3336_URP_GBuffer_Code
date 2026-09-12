#ifndef EID215441_215442_GBUFFER_INCLUDED
#define EID215441_215442_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_Res28); SAMPLER(sampler_Res28);
TEXTURE2D(_Res29); SAMPLER(sampler_Res29);

CBUFFER_START(UnityPerMaterial)
float4 _P00; float4 _P01; float4 _P02; float4 _P03;
float4 _P04; float4 _P05; float4 _P06; float4 _P07;
float4 _P08; float4 _P09; float4 _P10; float4 _P11;
float4 _P12; float4 _P13; float4 _P14; float4 _P15;
float4 _P16; float4 _P17; float4 _P18; float4 _P19;
float4 _InstancePacked;
float _EID215442MipBias;
float _UseBakedSkinning;
CBUFFER_END

struct Attributes215441
{
    float3 position : POSITION;
    float4 packedNormal : NORMAL;
    float2 uv : TEXCOORD0;
    float4 input3 : COLOR0;
    float4 input5 : TEXCOORD3;
    uint4 input6 : BLENDINDICES0;
    float3 bakedNormalOS : TEXCOORD4;
    float4 bakedTangentOS : TEXCOORD5;
};

struct Varyings215441
{
    float4 positionCS : SV_POSITION;
    float2 uv : TEXCOORD0;
    float3 normalWS : TEXCOORD1;
    float4 tangentWS : TEXCOORD2;
    float3 currentClipXYW : TEXCOORD3;
    float3 previousClipXYW : TEXCOORD4;
};

float3 DecodeOctNormal215441(uint packed)
{
    float x = float((packed << 22u) >> 22u);
    float y = float((packed << 12u) >> 22u);
    x = (x >= 512.0) ? x - 1024.0 : x;
    y = (y >= 512.0) ? y - 1024.0 : y;
    float3 n = float3(x, y, 0.0) * 0.0019569471478462219;
    n.z = 1.0 - abs(n.x) - abs(n.y);
    if (n.z < 0.0)
        n.xy = (1.0 - abs(n.yx)) * (step(0.0, n.xy) * 2.0 - 1.0);
    return normalize(n);
}

float4 DecodePackedTangent215441(uint packed, float3 n)
{
    float signed10 = float((packed << 2u) >> 22u);
    signed10 = ((signed10 >= 512.0) ? signed10 - 1024.0 : signed10) * 0.0019569471478462219;
    float3 seed = n.yzx - n.zxy;
    float3 t0 = normalize(seed - dot(seed, n).xxx);
    float tangentSign = signed10 < 0.0 ? -1.0 : 1.0;
    float encoded = 1.0 - ((signed10 * tangentSign) * 2.0);
    float2 r = normalize(float2(encoded, tangentSign * (1.0 - abs(encoded))));
    float3 t1 = normalize(cross(n, t0));
    float3 t = mul(r, float2x3(t0, t1));
    return float4(t, float((packed >> 31u) & 1u) * 2.0 - 1.0);
}

Varyings215441 EID215441Vertex(Attributes215441 input)
{
    Varyings215441 o;
    uint packed = asuint(input.packedNormal.x);
    bool packedBasis = (packed & 0x40000000u) != 0u;
    float3 decodedNormalOS = packedBasis ? DecodeOctNormal215441(packed) : input.packedNormal.xyz;
    float4 decodedTangentOS = packedBasis ? DecodePackedTangent215441(packed, decodedNormalOS) : input.input3;
    float3 normalOS = _UseBakedSkinning > 0.5 ? input.bakedNormalOS : decodedNormalOS;
    float4 tangentOS = _UseBakedSkinning > 0.5 ? input.bakedTangentOS : decodedTangentOS;

    float3 positionWS = TransformObjectToWorld(input.position);
    float3 normalWS = normalize(TransformObjectToWorldNormal(normalOS));
    float3 tangentWS = normalize(TransformObjectToWorldDir(tangentOS.xyz));
    float4 clip = TransformWorldToHClip(positionWS);

    o.positionCS = clip;
    o.uv = input.uv * _P10.xy + _P10.zw;
    o.normalWS = normalWS;
    o.tangentWS = float4(tangentWS, tangentOS.w * GetOddNegativeScale());
    o.currentClipXYW = clip.xyw;
    o.previousClipXYW = clip.xyw;
    return o;
}

struct GBufferOutput215442
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput215442 EID215442Fragment(Varyings215441 input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput215442 o;
    float4 albedoSample = SAMPLE_TEXTURE2D_BIAS(_Res28, sampler_Res28, input.uv, _EID215442MipBias);
    float3 tinted = albedoSample.rgb * _P06.rgb;

    float4 normalSample = SAMPLE_TEXTURE2D_BIAS(_Res29, sampler_Res29, input.uv, _EID215442MipBias);
    float4 packedN = normalSample;
    packedN.w = packedN.w * packedN.x;
    float2 nxy = packedN.wy * 2.0 - 1.0;
    float nz = max(0.0, sqrt(saturate(1.0 - dot(nxy, nxy))));
    nxy *= _P00.w;

    float3 n = input.normalWS;
    float3 t = input.tangentWS.xyz;
    float3 b = cross(n, t) * input.tangentWS.w;
    float3 mapped = mul(float3(nxy.x, nxy.y, nz), float3x3(t, b, n));
    float faceSign = isFrontFace ? 1.0 : (2.0 * _P01.y - 1.0);
    float3 normalWS = normalize(mapped * faceSign);

    float3 wrapDir = normalize(-n);
    float ndv = saturate(dot(normalWS, wrapDir));
    float wrap = saturate(ndv * 0.85 + 0.15);
    float inv = saturate((1.0 - wrap) * _P12.x);
    float3 albedo = tinted * lerp(1.0, _P13.rgb, inv);

    float2 motion = input.currentClipXYW.xy / max(input.currentClipXYW.z, 1e-8) - input.previousClipXYW.xy / max(input.previousClipXYW.z, 1e-8);
    motion.y = -motion.y;
    float2 encodedMotion = sqrt(sqrt(abs(motion * 0.5))) * (float2)(int2)sign(motion) * 0.5 + 0.5;

    uint packedMat = asuint(_InstancePacked.z);
    float4 unpacked = float4(
        float(packedMat & 1023u) * (1.0 / 1023.0),
        float((packedMat >> 10u) & 1023u) * (1.0 / 1023.0),
        float((packedMat >> 20u) & 1023u) * (1.0 / 1023.0),
        float((packedMat >> 30u) & 3u) * (1.0 / 3.0));

    float3 octN = normalize(normalWS);
    float2 oct = octN.xz / dot(1.0.xxx, abs(octN));
    if (octN.y <= 0.0)
        oct = (1.0 - abs(oct.yx)) * (step(0.0, oct) * 2.0 - 1.0);
    oct = oct * 0.5 + 0.5;

    o.rt0 = float4(0.0, 0.0, 0.0, 0.0);
    o.rt1 = float4(encodedMotion, 1.0, 0.4);
    o.rt2 = unpacked;
    o.rt3 = float4(oct, 0.0, 0.4);
    o.rt4 = float4(albedo, 1.0);
    return o;
}

#endif
