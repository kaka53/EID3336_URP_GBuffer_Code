#ifndef EID215445_215446_GBUFFER_INCLUDED
#define EID215445_215446_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
// This mesh contains raw VS input, not the family importer's baked skin stream.
// Share exactly the forward skinning path and Unity live M/VP.
#include "VS_EID4725.hlsl"

TEXTURE2D(_EID4725_GBuffer_Res27); SAMPLER(sampler_EID4725_GBuffer_Res27);

CBUFFER_START(UnityPerMaterial)
float4 _EID4725_GBuffer_P00; float4 _EID4725_GBuffer_P01; float4 _EID4725_GBuffer_P02; float4 _EID4725_GBuffer_P03;
float4 _EID4725_GBuffer_P04; float4 _EID4725_GBuffer_P05; float4 _EID4725_GBuffer_P06; float4 _EID4725_GBuffer_P07;
float4 _EID4725_GBuffer_P08; float4 _EID4725_GBuffer_P09; float4 _EID4725_GBuffer_P10; float4 _EID4725_GBuffer_P11;
float4 _EID4725_GBuffer_P12; float4 _EID4725_GBuffer_P13; float4 _EID4725_GBuffer_P14; float4 _EID4725_GBuffer_P15;
float4 _EID4725_GBuffer_P16; float4 _EID4725_GBuffer_P17; float4 _EID4725_GBuffer_P18; float4 _EID4725_GBuffer_P19;
float4 _EID4725_GBuffer_InstancePacked;
float _EID4725_GBuffer_EID215446MipBias;
float _EID4725_GBuffer_UseBakedSkinning;
CBUFFER_END

struct Attributes215445
{
    float3 position : POSITION;
    float3 packedNormal : NORMAL;
    float4 tangent : TANGENT;
    float2 uv : TEXCOORD0;
    float3 previous : TEXCOORD1;
    float3 referencePosition : TEXCOORD2;
    float3 referenceNormal : TEXCOORD3;
    float4 weights : TEXCOORD4;
    uint4 joints : TEXCOORD5;
};

struct Varyings215445
{
    precise float4 positionCS : SV_POSITION;
    float2 uv : TEXCOORD0;
    float3 normalWS : TEXCOORD1;
    float3 currentClipXYW : TEXCOORD2;
    float3 previousClipXYW : TEXCOORD3;
    float3 positionWS : TEXCOORD4;
};

Varyings215445 EID215445Vertex(Attributes215445 input)
{
    EID4725VS_SPIRV_Cross_Input raw = (EID4725VS_SPIRV_Cross_Input)0;
    raw.EID4725VS_3 = input.position;
    raw.EID4725VS_4 = input.uv;
    raw.EID4725VS_5 = input.packedNormal;
    raw.EID4725VS_6 = input.tangent;
    raw.EID4725VS_7 = float4(input.previous, 1);
    raw.EID4725VS_8 = input.referencePosition;
    raw.EID4725VS_9 = input.referenceNormal;
    raw.EID4725VS_11 = input.weights;
    raw.EID4725VS_12 = input.joints;
    raw.EID4725VS_gl_InstanceIndex = 0;
    EID4725VS_SPIRV_Cross_Output skinned = EID4725VS_main(raw);
    Varyings215445 o;
    o.positionCS = skinned.EID4725VS_gl_Position;
    // GBuffer material parameters remain separate from forward material uniforms.
    o.uv = input.uv * _EID4725_GBuffer_P10.xy + _EID4725_GBuffer_P10.zw;
    o.normalWS = skinned.EID4725VS_15;
    o.currentClipXYW = o.positionCS.xyw;
    o.previousClipXYW = o.positionCS.xyw;
    o.positionWS = skinned.EID4725VS_14 + EID4725VS_24_m11.xyz;
    return o;
}

struct GBufferOutput215446
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput215446 EID215446Fragment(Varyings215445 input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput215446 o;
    float4 albedoSample = SAMPLE_TEXTURE2D_BIAS(_EID4725_GBuffer_Res27, sampler_EID4725_GBuffer_Res27, input.uv, _EID4725_GBuffer_EID215446MipBias);
    float3 tinted = albedoSample.rgb * _EID4725_GBuffer_P06.rgb;

    float faceSign = isFrontFace ? 1.0 : (2.0 * _EID4725_GBuffer_P01.y - 1.0);
    float3 n = input.normalWS;
    float3 normalWS = normalize(n * faceSign);

    // PS215446 wraps against the surface-to-camera direction, not -normal.
    float3 wrapDir = GetWorldSpaceNormalizeViewDir(input.positionWS);
    float ndv = saturate(dot(normalWS, wrapDir));
    float wrap = saturate(ndv * 0.85 + 0.15);
    float inv = saturate((1.0 - wrap) * _EID4725_GBuffer_P12.x);
    float3 albedo = tinted * lerp(1.0, _EID4725_GBuffer_P13.rgb, inv);

    float2 motion = input.currentClipXYW.xy / max(input.currentClipXYW.z, 1e-8) - input.previousClipXYW.xy / max(input.previousClipXYW.z, 1e-8);
    motion.y = -motion.y;
    float2 encodedMotion = sqrt(sqrt(abs(motion * 0.5))) * (float2)(int2)sign(motion) * 0.5 + 0.5;

    uint packedMat = asuint(_EID4725_GBuffer_InstancePacked.z);
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







