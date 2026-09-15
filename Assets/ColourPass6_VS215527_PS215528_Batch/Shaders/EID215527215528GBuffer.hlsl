#ifndef EID215527_215528_GBUFFER_INCLUDED
#define EID215527_215528_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_Res27); SAMPLER(sampler_Res27);
TEXTURE2D(_Res29); SAMPLER(sampler_Res29);
TEXTURECUBE(_Res32); SAMPLER(sampler_Res32);
TEXTURE2D(_Res33); SAMPLER(sampler_Res33);
TEXTURE2D(_Res34); SAMPLER(sampler_Res34);

CBUFFER_START(UnityPerMaterial)
float4 _P00; float4 _P01; float4 _P02; float4 _P03;
float4 _P04; float4 _P05; float4 _P06; float4 _P07;
float4 _P08; float4 _P09; float4 _P10; float4 _P11;
float4 _P12; float4 _P13; float4 _P14; float4 _P15;
float4 _P16; float4 _P17; float4 _P18; float4 _P19;
float4 _P20; float4 _P21; float4 _P22; float4 _P23;
float4 _P24; float4 _P25; float4 _P26; float4 _P27;
float4 _InstanceMeta;
float4 _InstanceStateYZ;
float _EID215528MipBias;
float _UseBakedSkinning;
CBUFFER_END

struct Attributes215527
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

struct Varyings215527
{
    float4 positionCS : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    float2 uv1 : TEXCOORD1;
    float2 uv2 : TEXCOORD2;
    float3 positionWS : TEXCOORD3;
    float3 normalWS : TEXCOORD4;
    float4 tangentWS : TEXCOORD5;
    float3 currentClipXYW : TEXCOORD6;
    float3 previousClipXYW : TEXCOORD7;
    nointerpolation uint instanceIndex : TEXCOORD8;
};

float3 DecodeOctNormal215527(uint packed)
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

float4 DecodePackedTangent215527(uint packed, float3 n)
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

Varyings215527 EID215527Vertex(Attributes215527 input)
{
    Varyings215527 o;
    uint packed = asuint(input.packedNormal.x);
    bool packedBasis = (packed & 0x40000000u) != 0u;
    float3 decodedNormalOS = packedBasis ? DecodeOctNormal215527(packed) : input.packedNormal.xyz;
    float4 decodedTangentOS = packedBasis ? DecodePackedTangent215527(packed, decodedNormalOS) : input.input2;
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
    o.positionWS = positionWS;
    o.normalWS = normalWS;
    o.tangentWS = float4(tangentWS, tangentOS.w * GetOddNegativeScale());
    o.currentClipXYW = clip.xyw;
    o.previousClipXYW = clip.xyw;
    o.instanceIndex = 0u;
    return o;
}

struct GBufferOutput215528
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

float3 CubeRgbToHsvRgb(float3 cubeRgb, float hueAdd, float satScale, float valScale)
{
    float4 p = lerp(float4(cubeRgb.bg, -1.0, 2.0 / 3.0), float4(cubeRgb.gb, 0.0, -1.0 / 3.0), step(cubeRgb.b, cubeRgb.g));
    float4 q = lerp(float4(p.xyw, cubeRgb.r), float4(cubeRgb.r, p.yzx), step(p.x, cubeRgb.r));
    float d = q.x - min(q.w, q.y);
    float hue = abs(q.z + (q.w - q.y) / (6.0 * d + 0.0001)) + hueAdd;
    float sat = (d / (q.x + 0.0001)) * satScale;
    float val = q.x * valScale;
    float3 rgb = saturate(abs(frac(hue + float3(1.0, 2.0 / 3.0, 1.0 / 3.0)) * 6.0 - 3.0) - 1.0);
    return lerp(1.0.xxx, rgb, sat.xxx) * val;
}

GBufferOutput215528 EID215528Fragment(Varyings215527 input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput215528 o;
    float tangentInputSign = input.tangentWS.w > 0.0 ? 1.0 : -1.0;
    float mip = _EID215528MipBias;
    float3 nInterp = input.normalWS;
    float3 tInterp = input.tangentWS.xyz;
    float3 bInterp = cross(nInterp, tInterp) * tangentInputSign;
    float3 viewWS = GetWorldSpaceNormalizeViewDir(input.positionWS);

    float2 uvShared = lerp(input.uv0, input.uv1, _P03.x) * _P12.xy + _P12.zw;
    float4 nSample = SAMPLE_TEXTURE2D_BIAS(_Res27, sampler_Res27, uvShared, _P03.y + mip);
    float2 nxyRaw = float2(nSample.w * nSample.x, nSample.y) * 2.0 - 1.0;
    float nz = max(0.0, sqrt(saturate(1.0 - dot(nxyRaw, nxyRaw))));
    float2 nxy = nxyRaw * _P00.x;

    float4 matSample = SAMPLE_TEXTURE2D_BIAS(_Res29, sampler_Res29, uvShared, mip);
    float roughness = lerp(_P00.z, _P00.w, matSample.y);
    float ao = lerp(1.0, matSample.z, _P01.x);
    float materialY = lerp(matSample.x, _P04.y, saturate(_P03.w - 1.0));

    float faceSign = isFrontFace ? 1.0 : (_P01.w > 0.0 ? -1.0 : 1.0);
    float3 normalWS = normalize(tInterp * nxy.x + bInterp * nxy.y + nInterp * (nz * faceSign));

    float2 uvMix2 = lerp(input.uv0, input.uv1, _P22.w);
    float2 uvCube = uvMix2 * _P22.x;
    float3 refractedWS = refract(-viewWS, normalWS, _P23.x);
    float3 dirTS = normalize(mul(float3x3(tInterp, bInterp, nInterp), -refractedWS));
    float3 boxDir = -dirTS;
    float3 scaled = boxDir * _P24.xyx;
    float zParam = (1.0 / (1.0 - _P22.y)) - 1.0;
    scaled.z *= zParam;
    float3 invS = clamp(1.0 / scaled, -16777216.0, 16777216.0);
    float2 boxUV = frac(uvCube * _P24.xy + _P24.zw) * 2.0 - 1.0;
    float3 local = float3(boxUV, 1.0);
    float3 tHit = abs(invS) - invS * local;
    float tMin = min(tHit.x, min(tHit.y, tHit.z));
    float3 hit = -(scaled * tMin + local);
    float swapAmount = fmod(floor(_P26.x), 2.0);
    float3 oriented = lerp(hit, hit.zyx, swapAmount.xxx);
    float mixSign = saturate(floor(_P26.x) - 1.0);
    float3 cubeDir = oriented * lerp(float3(-1.0, -1.0, 1.0), float3(1.0, -1.0, -1.0), mixSign.xxx);
    float4 cubeSample = SAMPLE_TEXTURECUBE_LOD(_Res32, sampler_Res32, cubeDir, _P22.z * 5.0);
    float3 cubeColor = CubeRgbToHsvRgb(cubeSample.rgb, _P25.z, _P25.w, _P25.y);

    float2 overlayUV = uvCube;
    overlayUV.x *= _P27.x;
    overlayUV = frac(overlayUV);
    float overlayY = overlayUV.y - _P25.x;
    overlayUV.y = overlayY;
    float4 overlaySample = SAMPLE_TEXTURE2D_BIAS(_Res33, sampler_Res33, overlayUV, mip);
    float2 paraUV = saturate(uvMix2 - dirTS.xy / (dirTS.z + 0.42) * _P26.y);
    float4 extraSample = SAMPLE_TEXTURE2D_LOD(_Res34, sampler_Res34, paraUV, 10.0 * _P26.w);
    float4 overlayMix = lerp(extraSample * overlaySample, overlaySample, (1.0 - _P26.z).xxxx);
    float mask = overlaySample.a * step(0.0, overlayY) * step(overlayY, 1.0);
    float3 overlayRGB = overlayMix.rgb * mask;
    float3 cubeOut = cubeColor * (1.0 - mask);

    uint materialId = (uint)_InstanceMeta.w;
    float materialZ = saturate(_P04.w * roughness + _P05.y * materialY + _P05.x) * 0.95 + 0.05;
    materialZ *= (1.0 - _P07.y);
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

    o.rt0 = float4(cubeOut, 0.5);
    o.rt1 = float4(encodedMotion, motionWeight > 0.0 ? 1.0 : _P07.x, motionWeight);
    o.rt2 = float4(materialY, ao, materialZ, float(materialId / 4u) * 0.3333333433);
    o.rt3 = float4(oct, roughness, float(materialId % 4u) * 0.3333333433);
    o.rt4 = float4(overlayRGB, 0.0);
    return o;
}

#endif
