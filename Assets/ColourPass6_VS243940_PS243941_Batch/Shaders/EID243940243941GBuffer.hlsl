#ifndef EID243940_243941_GBUFFER_INCLUDED
#define EID243940_243941_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_Res27); SAMPLER(sampler_Res27);
TEXTURE2D(_Res29); SAMPLER(sampler_Res29);
TEXTURE2D(_Res31); SAMPLER(sampler_Res31);
TEXTURE2D(_Res33); SAMPLER(sampler_Res33);
TEXTURE2D(_Res35); SAMPLER(sampler_Res35);

CBUFFER_START(UnityPerMaterial)
float4 _P00; float4 _P01; float4 _P02; float4 _P03;
float4 _P04; float4 _P05; float4 _P06; float4 _P07;
float4 _P08; float4 _P09; float4 _P10; float4 _P11;
float4 _P12; float4 _P13; float4 _P14; float4 _P15;
float4 _P16; float4 _P17; float4 _P18; float4 _P19;
float4 _P20; float4 _P21; float4 _P22; float4 _P23;
float4 _P24; float4 _P25; float4 _P26; float4 _P27;
float4 _P28; float4 _P29; float4 _P30; float4 _P31;
float4 _P32; float4 _P33; float4 _P34; float4 _P35;
float4 _P36;
float4 _InstanceMeta;
float4 _InstanceStateYZ;
float _EID243941MipBias;
float _LightMixY;
float _UseBakedSkinning;
CBUFFER_END

struct Attributes243940
{
    float3 position : POSITION;
    float4 packedNormal : NORMAL;
    float4 input2 : COLOR0;
    float4 input3 : TANGENT;
    float2 input4 : TEXCOORD0;
    float2 input5 : TEXCOORD1;
    float2 input6 : TEXCOORD2;
    float4 input7 : TEXCOORD3;
    uint4 input8 : BLENDINDICES0;
    float3 bakedNormalOS : TEXCOORD4;
    float4 bakedTangentOS : TEXCOORD5;
};

struct Varyings243940
{
    float4 positionCS : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    float2 uv1 : TEXCOORD1;
    float2 uv2 : TEXCOORD2;
    float3 normalWS : TEXCOORD3;
    float4 tangentWS : TEXCOORD4;
    float3 currentClipXYW : TEXCOORD5;
    float3 previousClipXYW : TEXCOORD6;
    nointerpolation uint instanceIndex : TEXCOORD7;
    float3 positionWS : TEXCOORD8;
};

float3 DecodeOctNormal243940(uint packed)
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

float4 DecodePackedTangent243940(uint packed, float3 n)
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

Varyings243940 EID243940Vertex(Attributes243940 input)
{
    Varyings243940 o;
    uint packed = asuint(input.packedNormal.x);
    bool packedBasis = (packed & 0x40000000u) != 0u;
    float3 decodedNormalOS = packedBasis ? DecodeOctNormal243940(packed) : input.packedNormal.xyz;
    float4 decodedTangentOS = packedBasis ? DecodePackedTangent243940(packed, decodedNormalOS) : input.input2;
    float3 normalOS = _UseBakedSkinning > 0.5 ? input.bakedNormalOS : decodedNormalOS;
    float4 tangentOS = _UseBakedSkinning > 0.5 ? input.bakedTangentOS : decodedTangentOS;

    float3 positionWS = TransformObjectToWorld(input.position);
    float3 normalWS = normalize(TransformObjectToWorldNormal(normalOS));
    float3 tangentWS = normalize(TransformObjectToWorldDir(tangentOS.xyz));
    float4 clip = TransformWorldToHClip(positionWS);

    o.positionCS = clip;
    o.uv0 = input.input4;
    o.uv1 = input.input5;
    o.uv2 = input.input6;
    o.normalWS = normalWS;
    o.tangentWS = float4(tangentWS, tangentOS.w * GetOddNegativeScale());
    o.currentClipXYW = clip.xyw;
    o.previousClipXYW = clip.xyw;
    o.instanceIndex = 0u;
    o.positionWS = positionWS;
    return o;
}

struct GBufferOutput243941
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput243941 EID243941Fragment(Varyings243940 input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput243941 o;
    float tangentInputSign = input.tangentWS.w > 0.0 ? 1.0 : -1.0;
    float mip = _EID243941MipBias;
    float2 uvAlbedo = lerp(input.uv0, input.uv1, _P02.w) * _P11.xy + _P11.zw;
    float2 uvNormal = lerp(input.uv0, input.uv1, _P03.x) * _P12.xy + _P12.zw;
    float4 albedoSample = SAMPLE_TEXTURE2D_BIAS(_Res27, sampler_Res27, uvAlbedo, mip);
    float4 normalSample = SAMPLE_TEXTURE2D_BIAS(_Res29, sampler_Res29, uvNormal, _P03.y + mip);
    float4 extraSample = SAMPLE_TEXTURE2D_BIAS(_Res31, sampler_Res31, uvNormal, mip);

    float4 dxt5 = normalSample;
    dxt5.w = normalSample.w * normalSample.x;
    float2 nxyRaw = dxt5.wy * 2.0 - 1.0;
    float2 nxy = nxyRaw * _P00.x;
    float nz = max(0.0, sqrt(saturate(1.0 - dot(nxyRaw, nxyRaw))));

    float3 baseColor = saturate(albedoSample.rgb * _P08.rgb * _P04.z);
    baseColor = lerp(baseColor, _P08.rgb, _P04.x);
    float roughness = lerp(_P00.z, _P00.w, extraSample.y);
    float ao = lerp(1.0, extraSample.z, _P01.x);
    float materialY = lerp(extraSample.x, _P04.y, saturate(_P03.w - 1.0));

    float faceSign = isFrontFace ? 1.0 : (_P01.w > 0.0 ? -1.0 : 1.0);
    float3 n = normalize(input.normalWS);
    float3 t = normalize(input.tangentWS.xyz);
    float3 b = normalize(cross(n, t)) * tangentInputSign;
    float3 normalWS = normalize(t * nxy.x + b * nxy.y + n * (nz * faceSign));
    float3 viewDirWS = GetWorldSpaceNormalizeViewDir(input.positionWS);

    float alphaMix = lerp(albedoSample.w, extraSample.w, saturate(_P25.w - 1.0));
    float overlayMask = lerp(alphaMix, 0.0, _P26.y);
    float3 overlayLit = 0.0.xxx;
    if (overlayMask > 0.01)
    {
        float2 uvOverlay = lerp(input.uv0, input.uv1, _P26.x) * _P26.z * _P24.y;
        float4 overlaySample = SAMPLE_TEXTURE2D_BIAS(_Res33, sampler_Res33, uvOverlay, mip);
        float3 overlayTint = lerp(_P30.xyz, _P29.xyz, overlaySample.yyy);
        float ndv = max(dot(viewDirWS, normalWS), 0.001);
        float wrap = pow(ndv, floor(_P25.y));
        overlayLit = overlayTint * (overlayMask * wrap * overlayMask);
        overlayLit *= _P25.z != 0.0 ? _LightMixY : 1.0;
    }
    overlayLit *= _P28.w;

    float3 viewN = mul((float3x3)UNITY_MATRIX_V, normalWS);
    float2 uvMatcap = viewN.xy * 0.5 + 0.5;
    float3 matcap = SAMPLE_TEXTURE2D_BIAS(_Res35, sampler_Res35, uvMatcap, mip).xyz;
    matcap *= _P36.x;
    matcap *= (1.0 - _P36.y) + _LightMixY * _P36.y;
    float3 rt0rgb = overlayLit + matcap;

    uint materialId = (uint)_InstanceMeta.w;
    float materialZ = (saturate(_P04.w * roughness + _P05.y * materialY + _P05.x) * 0.95 + 0.05) * (1.0 - _P07.y);
    float active = saturate(float((int)sign(max(_InstanceStateYZ.x, _InstanceStateYZ.y) - 0.1)));

    float2 motion = input.currentClipXYW.xy / max(input.currentClipXYW.z, 1e-8) - input.previousClipXYW.xy / max(input.previousClipXYW.z, 1e-8);
    motion.y = -motion.y;
    float2 encodedMotion = lerp(sqrt(sqrt(abs(motion * 0.5))) * (float2)(int2)sign(motion) * 0.5 + 0.5, 0.5.xx, active.xx);
    float motionWeight = lerp(0.0, 0.7, active);

    float3 octN = normalize(normalWS);
    float2 oct = octN.xz / dot(1.0.xxx, abs(octN));
    if (octN.y <= 0.0)
        oct = (1.0 - abs(oct.yx)) * (step(0.0, oct) * 2.0 - 1.0);
    oct = oct * 0.5 + 0.5;

    o.rt0 = float4(rt0rgb, 0.5);
    o.rt1 = float4(encodedMotion, motionWeight > 0.0 ? 1.0 : _P07.x, motionWeight);
    o.rt2 = float4(materialY, ao, materialZ, float(materialId / 4u) * 0.3333333433);
    o.rt3 = float4(oct, roughness, float(materialId % 4u) * 0.3333333433);
    o.rt4 = float4(baseColor, 0.0);
    return o;
}

#endif
