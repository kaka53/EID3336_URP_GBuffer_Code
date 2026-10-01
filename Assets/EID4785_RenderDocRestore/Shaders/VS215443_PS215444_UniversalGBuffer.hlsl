#ifndef EID215443_215444_GBUFFER_INCLUDED
#define EID215443_215444_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_EID4785_GBuffer_Res25); SAMPLER(sampler_EID4785_GBuffer_Res25);
TEXTURE2D(_EID4785_GBuffer_Res26); SAMPLER(sampler_EID4785_GBuffer_Res26);

CBUFFER_START(UnityPerMaterial)
float4 _EID4785_GBuffer_P00; float4 _EID4785_GBuffer_P01; float4 _EID4785_GBuffer_P02; float4 _EID4785_GBuffer_P03;
float4 _EID4785_GBuffer_P04; float4 _EID4785_GBuffer_P05; float4 _EID4785_GBuffer_P06; float4 _EID4785_GBuffer_P07;
float4 _EID4785_GBuffer_P08; float4 _EID4785_GBuffer_P09; float4 _EID4785_GBuffer_P10; float4 _EID4785_GBuffer_P11;
float4 _EID4785_GBuffer_P12; float4 _EID4785_GBuffer_P13; float4 _EID4785_GBuffer_P14; float4 _EID4785_GBuffer_P15;
float4 _EID4785_GBuffer_P16; float4 _EID4785_GBuffer_P17;
float4 _EID4785_GBuffer_InstancePacked;
float _EID4785_GBuffer_EID215444MipBias;
float _EID4785_GBuffer_UseBakedSkinning;
   
   
   
   
   

CBUFFER_END


struct Attributes215443 { float3 position:POSITION; float3 bakedNormalOS:NORMAL; float4 bakedTangentOS:TANGENT; float2 uv:TEXCOORD0; };

struct Varyings215443
{
    float4 positionCS : SV_POSITION;
    float2 uv : TEXCOORD0;
    float3 normalWS : TEXCOORD1;
    float4 tangentWS : TEXCOORD2;
    float3 currentClipXYW : TEXCOORD3;
    float3 previousClipXYW : TEXCOORD4;
    float3 positionWS : TEXCOORD5;
};

float3 DecodeOctNormal215443(uint packed)
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

float4 DecodePackedTangent215443(uint packed, float3 n)
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

Varyings215443 EID215443Vertex(Attributes215443 input)
{
    Varyings215443 o;
    float3 normalOS = input.bakedNormalOS;
    float4 tangentOS = input.bakedTangentOS;
    float3 positionWS = TransformObjectToWorld(input.position);
    float3 normalWS = normalize(TransformObjectToWorldNormal(normalOS));
    float3 tangentWS = normalize(TransformObjectToWorldDir(tangentOS.xyz));
    float4 clip = TransformWorldToHClip(positionWS);

    o.positionCS = clip;
    o.uv = input.uv * _EID4785_GBuffer_P10.xy + _EID4785_GBuffer_P10.zw;
    o.normalWS = normalWS;
    o.tangentWS = float4(tangentWS, tangentOS.w * GetOddNegativeScale());
    o.currentClipXYW = clip.xyw;
    o.previousClipXYW = clip.xyw;
    o.positionWS = positionWS;
    return o;
}

struct GBufferOutput215444
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput215444 EID215444Fragment(Varyings215443 input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput215444 o;
    float4 albedoSample = SAMPLE_TEXTURE2D_BIAS(_EID4785_GBuffer_Res25, sampler_EID4785_GBuffer_Res25, input.uv, _EID4785_GBuffer_EID215444MipBias);
    float3 tinted = albedoSample.rgb * _EID4785_GBuffer_P06.rgb;
    float alpha = albedoSample.a * _EID4785_GBuffer_P06.w;
    clip(alpha - _EID4785_GBuffer_P02.y);

    float4 normalSample = SAMPLE_TEXTURE2D_BIAS(_EID4785_GBuffer_Res26, sampler_EID4785_GBuffer_Res26, input.uv, _EID4785_GBuffer_EID215444MipBias);
    float4 packedN = normalSample;
    packedN.w = packedN.w * packedN.x;
    float2 nxy = packedN.wy * 2.0 - 1.0;
    float nz = max(0.0, sqrt(saturate(1.0 - dot(nxy, nxy))));
    nxy *= _EID4785_GBuffer_P00.w;

    float3 n = input.normalWS;
    float3 t = input.tangentWS.xyz;
    float3 b = cross(n, t) * input.tangentWS.w;
    float3 mapped = mul(float3(nxy.x, nxy.y, nz), float3x3(t, b, n));
    float faceSign = isFrontFace ? 1.0 : (2.0 * _EID4785_GBuffer_P01.y - 1.0);
    float3 normalWS = normalize(mapped * faceSign);

    float2 motion = input.currentClipXYW.xy / max(input.currentClipXYW.z, 1e-8) - input.previousClipXYW.xy / max(input.previousClipXYW.z, 1e-8);
    motion.y = -motion.y;
    float2 encodedMotion = sqrt(sqrt(abs(motion * 0.5))) * (float2)(int2)sign(motion) * 0.5 + 0.5;

    uint packedMat = asuint(_EID4785_GBuffer_InstancePacked.z);
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
    o.rt3 = float4(oct, 0.0, 0.0);
    o.rt4 = float4(tinted, 1.0);
    return o;
}


#endif
