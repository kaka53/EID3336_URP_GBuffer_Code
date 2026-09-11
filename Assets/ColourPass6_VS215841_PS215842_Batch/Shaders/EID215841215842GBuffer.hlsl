#ifndef EID215841_215842_GBUFFER_INCLUDED
#define EID215841_215842_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_Res23); SAMPLER(sampler_Res23);
TEXTURE2D(_Res25); SAMPLER(sampler_Res25);
TEXTURE2D(_Res31);
SamplerState sampler_point_clamp;

CBUFFER_START(UnityPerMaterial)
float _DoubleSided;
float _MaterialClass;
float _PackedNormalWeight;
float _NormalMaskWeight;
float _RoughnessMaskWeight;
float _BaseColorReplaceWeight;
float _BaseColorMultiplier;
float _AlphaCutoff;
float4 _BaseColorTint;
float4 _OpacityDistanceParams;
float4 _MaterialDistanceParams;
float _WindHeightScale;
float _HeightFadeStart;
float _HeightFadeScale;
float _WindScale;
float4 _MaskExtent;
float4 _MaskCenter;
float4 _ViewDir;
float _EID215842MipBias;
float _CardVertexCount;
float4 _CapturedVP0;
float4 _CapturedVP1;
float4 _CapturedVP2;
float4 _CapturedVP3;
float4 _CapturedPrevVP0;
float4 _CapturedPrevVP1;
float4 _CapturedPrevVP2;
float4 _CapturedPrevVP3;
float4 _CapturedCamPos;
float4 _CapturedPrevCamPos;
float4 _CapturedCamUp;
float4 _JitterZW;
CBUFFER_END

struct EID215841Instance
{
    float4 r0;
    float4 r1;
    float4 r2;
    float4 r3;
    float4 m1;
    float4 m2;
};

StructuredBuffer<EID215841Instance> _EID215841Instances;

struct Attributes215841
{
    float4 positionPacked : POSITION;
    float4 input2 : COLOR0;
    float2 uv0 : TEXCOORD0;
    float instanceIndex : TEXCOORD1;
};

struct Varyings215841
{
    float4 positionCS : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    float3 normalWS : TEXCOORD2;
    float4 tangentWS : TEXCOORD3;
    float3 currentClipXYW : TEXCOORD5;
    float3 previousClipXYW : TEXCOORD6;
    float3 posOS : TEXCOORD7;
    nointerpolation uint instanceIndex : TEXCOORD8;
};

float3 DecodeOctNormal215841(uint packed)
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

float4 DecodePackedTangent215841(uint packed, float3 n)
{
    float signed10 = float((packed << 2u) >> 22u);
    signed10 = (signed10 >= 512.0) ? signed10 - 1024.0 : signed10;
    float3 seed = n.yzx - n.zxy;
    float d = dot(seed, n);
    float3 t0 = normalize(seed - d);
    float tangentSign = signed10 < 0.0 ? -1.0 : 1.0;
    float encoded = 1.0 - abs(signed10) * 0.0039138942956924438;
    float2 r = normalize(float2(encoded, tangentSign * (1.0 - abs(encoded))));
    float3 t1 = normalize(cross(n, t0));
    float3 t = t0 * r.x + t1 * r.y;
    return float4(t, float((packed >> 31u) & 1u) * 2.0 - 1.0);
}

float3 ReconstructLambertNormal(float2 nxy, float ds)
{
    float4 q = float4(nxy, 0.0, 0.0) * float4(2.0, 2.0, 0.0, 0.0) + float4(-1.0, -1.0, 1.0, -1.0);
    q.z = dot(q.xyz, -q.xyw);
    q.xy *= sqrt(q.z);
    float3 nTS = q.xyz * 2.0 + float3(0.0, 0.0, -1.0);
    nTS.xy *= ds;
    return nTS;
}

Varyings215841 EID215841Vertex(Attributes215841 input)
{
    Varyings215841 o;
    uint inst = (uint)input.instanceIndex;
    EID215841Instance rec = _EID215841Instances[inst];
    float3 posOS = input.positionPacked.xyz;
    uint packed = asuint(input.positionPacked.w);
    bool packedBasis = (packed & 0x40000000u) != 0u;
    float3 nOS = packedBasis ? DecodeOctNormal215841(packed) : float3(input.positionPacked.w, 0.0, 1.0);
    float4 tOS = packedBasis ? DecodePackedTangent215841(packed, nOS) : input.input2;

    float3 translation = rec.r3.xyz;
    float instY = translation.y;
    float3 camPos = _WorldSpaceCameraPos;
    float fade = saturate(((camPos.y - instY) - _HeightFadeStart) * _HeightFadeScale);
    float3 camUpXZ = float3(UNITY_MATRIX_I_V._m01, 0.0, UNITY_MATRIX_I_V._m21);
    float3 wind = camUpXZ * (posOS.y * _WindHeightScale);
    wind.y += -10.0 * step(0.0, fade - 0.95);
    wind *= _WindScale;

    float3x3 lin = float3x3(rec.r0.xyz, rec.r1.xyz, rec.r2.xyz);
    float3 worldUnmasked = mul(posOS, lin) + translation;
    float2 delta = abs(worldUnmasked.xz - _MaskCenter.zw);
    float3 maskedPos = posOS;
    if (!any(delta > _MaskExtent.xx))
    {
        float extent = _MaskExtent.x * 2.0;
        float2 uv = float2((worldUnmasked.x - _MaskCenter.z) / extent + 0.5, (worldUnmasked.z - _MaskCenter.w) / extent + 0.5);
        float4 s = SAMPLE_TEXTURE2D_LOD(_Res31, sampler_point_clamp, uv, 0.0);
        bool cull = (s.x > 0.0) && (s.y > 0.0);
        maskedPos = cull ? asfloat(uint3(0x7FC00000u, 0x7FC00000u, 0x7FC00000u)) : posOS;
    }

    float3 positionWS = mul(maskedPos, lin) + translation + wind;
    float3 nWS = mul(nOS, lin);
    nWS *= rsqrt(max(dot(nWS, nWS), 1.17549435e-38));
    float3 tWS = mul(tOS.xyz, lin);
    tWS *= rsqrt(max(dot(tWS, tWS), 1.17549435e-38));

    float4 clip = TransformWorldToHClip(positionWS);

    float dy = camPos.y - instY;
    float2 dXZ = float2(translation.x - camPos.x, translation.z - camPos.z);
    bool hide = (dy > 80.0) && all(abs(dXZ) < (0.1989 * dy).xx);
    if (hide)
        clip = asfloat(uint4(0x7FC00000u, 0x7FC00000u, 0x7FC00000u, 0x7FC00000u));

    o.positionCS = clip;
    o.uv0 = input.uv0;
    o.normalWS = nWS;
    o.tangentWS = float4(tWS, tOS.w);
    o.currentClipXYW = clip.xyw;
    o.previousClipXYW = clip.xyw;
    o.posOS = maskedPos;
    o.instanceIndex = inst;
    return o;
}

struct GBufferOutput215842
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput215842 EID215842Fragment(Varyings215841 input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput215842 o;
    float tangentInputSign = input.tangentWS.w > 0.0 ? 1.0 : -1.0;
    float3 n = input.normalWS;
    float3 t = input.tangentWS.xyz;
    float3 b = (cross(n, t) * tangentInputSign);
    float3x3 tbn = float3x3(t, b, n);

    float4 baseSample = SAMPLE_TEXTURE2D_BIAS(_Res23, sampler_Res23, input.uv0, _EID215842MipBias);
    clip(baseSample.a - _AlphaCutoff);

    float ds = _DoubleSided > 0.0 ? (isFrontFace ? 1.0 : -1.0) : 1.0;
    float4 nrm = SAMPLE_TEXTURE2D_BIAS(_Res25, sampler_Res25, input.uv0, _EID215842MipBias);
    float3 nTS = ReconstructLambertNormal(nrm.xy, ds);
    float3 nWS = mul(nTS, tbn);
    nWS = (nWS * rsqrt(max(dot(nWS, nWS), 1.17549435e-38))) * ds;

    float distM = clamp(lerp(_MaterialDistanceParams.z, 1.0, saturate((max(length(input.posOS + float3(0.0, _MaterialDistanceParams.w, 0.0)) - _MaterialDistanceParams.w, 0.0) - _MaterialDistanceParams.x) * _MaterialDistanceParams.y)), 0.0, 1.0);
    float a = distM * lerp(1.0, nrm.z, _NormalMaskWeight);
    float c = distM * lerp(1.0, nrm.z, _RoughnessMaskWeight);
    float ndv = saturate(dot(nWS, -GetViewForwardDir()));

    uint classBits = (uint)round(_MaterialClass * 31.0);
    uint zeroBits = (uint)round(0.0);
    const float packScale = 0.000977517105638980865478515625;
    float rt2x = float((uint(round(((0.5 * _PackedNormalWeight) * (1.0 - abs(a - c))) * 127.0)) << 3u) | ((classBits >> 2u) & 7u)) * packScale;
    float rt2y = float((uint(round(max(a, c) * 127.0)) << 3u) | uint(round(3.5))) * packScale;
    float rt2z = float((uint(round(ndv * 127.0)) << 3u) | ((zeroBits >> 2u) & 7u)) * packScale;
    float rt2w = float(classBits & 3u) * 0.3333333432674407958984375;

    float4 nrm2 = SAMPLE_TEXTURE2D_BIAS(_Res25, sampler_Res25, input.uv0, _EID215842MipBias);
    float3 nTS2 = ReconstructLambertNormal(nrm2.xy, ds);
    float3 nWS2 = mul(nTS2, tbn);
    nWS2 = normalize((nWS2 * rsqrt(max(dot(nWS2, nWS2), 1.17549435e-38))) * ds);
    float2 oct = nWS2.xz / dot(1.0.xxx, abs(nWS2));
    if (nWS2.y <= 0.0)
        oct = (1.0 - abs(oct.yx)) * (step(0.0, oct) * 2.0 - 1.0);
    oct = oct * 0.5 + 0.5;

    float3 albedo = saturate(lerp(saturate(baseSample.xyz * _BaseColorTint.xyz * _BaseColorMultiplier), _BaseColorTint.xyz, _BaseColorReplaceWeight.xxx));
    float4 inst2 = _EID215841Instances[input.instanceIndex].m2;
    albedo = saturate(lerp(albedo, inst2.xyz, inst2.www));
    float distO = clamp(lerp(_OpacityDistanceParams.z, 1.0, saturate((max(length(input.posOS + float3(0.0, _OpacityDistanceParams.w, 0.0)) - _OpacityDistanceParams.w, 0.0) - _OpacityDistanceParams.x) * _OpacityDistanceParams.y)), 0.0, 1.0);

    float2 motion = input.currentClipXYW.xy / max(input.currentClipXYW.z, 0.0) - input.previousClipXYW.xy / max(input.previousClipXYW.z, 0.0);
    motion.y = -motion.y;
    float2 encodedMotion = (sqrt(sqrt(abs(motion * 0.5))) * float2(int2(sign(motion)))) * 0.5 + 0.5;

    o.rt0 = float4(0.0, 0.0, 0.0, 1.0);
    o.rt1 = float4(encodedMotion, 0.0, 0.0);
    o.rt2 = float4(rt2x, rt2y, rt2z, rt2w);
    o.rt3 = float4(oct, nrm2.w, float(zeroBits & 3u) * 0.3333333432674407958984375);
    o.rt4 = float4(albedo, distO);
    return o;
}

#endif
