#ifndef EID229351_229352_GBUFFER_INCLUDED
#define EID229351_229352_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_Res25); SAMPLER(sampler_Res25);
TEXTURE2D(_Res27); SAMPLER(sampler_Res27);
TEXTURE2D(_Res31); SAMPLER(sampler_Res31);

CBUFFER_START(UnityPerMaterial)
float4 _P00; float4 _P01; float4 _P02; float4 _P03;
float4 _P04; float4 _P05; float4 _P06; float4 _P07;
float4 _P08; float4 _P09; float4 _P10; float4 _P11;
float4 _P12; float4 _P13; float4 _P14; float4 _P15;
float4 _P16; float4 _P17; float4 _P18; float4 _P19;
float4 _P20; float4 _P21;
float4 _SunDir;
float4 _WindA;
float4 _WindB;
float _WindGate;
float _PrevBlend;
float _EID229352MipBias;
CBUFFER_END

struct Attributes229351
{
    float3 position : POSITION;
    float4 packedNormal : NORMAL;
    float4 input2 : COLOR0;
    float4 input3 : TANGENT;
    float2 input4 : TEXCOORD0;
    float2 input5 : TEXCOORD1;
    float2 input6 : TEXCOORD2;
};

struct Varyings229351
{
    float4 positionCS : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    float3 normalWS : TEXCOORD1;
    float4 tangentWS : TEXCOORD2;
    float4 loc3 : TEXCOORD3;
    float3 currentClipXYW : TEXCOORD4;
    float3 previousClipXYW : TEXCOORD5;
};

float3 DecodeOctNormal229351(uint packed)
{
    float x = float((packed << 22u) >> 22u);
    float y = float((packed << 12u) >> 22u);
    x = (x >= 512.0) ? x - 1024.0 : x;
    y = (y >= 512.0) ? y - 1024.0 : y;
    float3 n = float3(x, y, 0.0) * 0.0020;
    n.z = 1.0 - abs(n.x) - abs(n.y);
    if (n.z < 0.0)
        n.xy = (1.0 - abs(n.yx)) * (step(0.0, n.xy) * 2.0 - 1.0);
    return normalize(n);
}

float4 DecodePackedTangent229351(uint packed, float3 n)
{
    float signed10 = float((packed << 2u) >> 22u);
    signed10 = ((signed10 >= 512.0) ? signed10 - 1024.0 : signed10) * 0.0020;
    float3 seed = n.yzx - n.zxy;
    float3 t0 = normalize(seed - dot(seed, n).xxx);
    float tangentSign = signed10 < 0.0 ? -1.0 : 1.0;
    float encoded = 1.0 - ((signed10 * tangentSign) * 2.0);
    float2 r = normalize(float2(encoded, tangentSign * (1.0 - abs(encoded))));
    float3 t1 = normalize(cross(n, t0));
    float3 t = mul(r, float2x3(t0, t1));
    return float4(t, float((packed >> 31u) & 1u) * 2.0 - 1.0);
}

float3 RotateAroundAxis229351(float3 v, float3 axis, float radians)
{
    axis = normalize(axis);
    float s = sin(radians);
    float c = cos(radians);
    float t = 1.0 - c;
    float3x3 m = float3x3(
        t * axis.x * axis.x + c, t * axis.x * axis.y - s * axis.z, t * axis.x * axis.z + s * axis.y,
        t * axis.x * axis.y + s * axis.z, t * axis.y * axis.y + c, t * axis.y * axis.z - s * axis.x,
        t * axis.x * axis.z - s * axis.y, t * axis.y * axis.z + s * axis.x, t * axis.z * axis.z + c);
    return mul(v, m);
}

float3 EvaluateWind229351(float3 posOS, float3 posWS, float3 instanceT, float instanceScale, float4 loc3, float extraPhaseSrc, float3 windVecOS, float4 pack)
{
    if (_WindGate <= 0.0 || pack.x <= 0.0)
        return 0.0;
    float intensity = pack.x;
    float t = pack.y;
    float3 dir = float3(pack.z, 0.0, pack.w);
    float fieldW = 0.0;
    float3 fieldDir = 0.0;
    float amp = max(fieldW, intensity);
    dir = lerp(dir, fieldDir, fieldW / (fieldW + 0.01));

    float3 mixPos = lerp(posWS, TransformObjectToWorld(windVecOS), _P21.x);
    float2 uv = mixPos.xz * _P21.z + mixPos.yy * 0.02;
    uv += (0.1 * (t + fieldW) * _P20.w).xx;
    float4 noise = SAMPLE_TEXTURE2D_LOD(_Res31, sampler_Res31, uv, 0);
    float2 nxy = noise.xy - 0.5;
    float blend = saturate(amp * 0.25 - 0.25);
    float nMix = lerp(nxy.x, nxy.y, blend);
    float3 dispDir = float3(dir.x, 0.2 * nxy.y, dir.z);
    float stiff = loc3.y * loc3.y;
    float linearScale = (amp * 0.25 + 0.25) * (nMix + _P21.z) * stiff * _P20.z * instanceScale;
    float3 linearDisp = dispDir * linearScale;

    float k = saturate(amp * 0.2);
    float k2 = k * k;
    float ease = 1.0 - (1.0 - k) * (1.0 - k) * (1.0 - k);
    float extraPhase = _P19.x > 0.0 ? extraPhaseSrc : 0.0;
    float phase = (t + fieldW) * _P18.y + (dot(instanceT, float3(0.08, -0.03, 0.08)) - extraPhase) * 6.28318548;
    float wobble = 0.5 * sin(phase) + 0.25 * cos(phase * 0.5);
    float rotMask = saturate(loc3.w - _P18.z);
    rotMask *= rotMask;
    float angleDeg = (wobble * ease + _P18.w * k2) * amp * _P18.x * rotMask;
    float3 rel = posWS - instanceT;
    float3 axis = float3(dir.z, 0.0, -dir.x);
    float3 rotOff = RotateAroundAxis229351(rel, axis, radians(angleDeg)) - rel;

    float3 extra = 0.0;
    if (_P19.x > 0.0 && any(windVecOS != 0.0))
    {
        float3 flutterSrc = lerp(posOS, windVecOS, _P19.w.xxx);
        float3 flutterPos = instanceT * 0.01 + flutterSrc;
        float2 fuv = flutterPos.xz * (_P20.y * _P20.y) + flutterPos.yy * (_P19.x * 0.02);
        float4 fn = SAMPLE_TEXTURE2D_LOD(_Res31, sampler_Res31, fuv, 0);
        float4 s = sin(float4(1.0, 0.5, 0.25, 0.125) * (fn.y * 25.132741 + t * _P19.z));
        float4 w = lerp(float4(0.5, 0.25, 0.125, 0.0625), 0.25.xxxx, _P19.x.xxxx);
        float flutter = dot(s, w) * ease;
        float len = length(windVecOS - posOS);
        float height = loc3.z * lerp(loc3.z, 0.5 * len, _P21.w);
        extra = dir * ((0.5 * instanceScale) * height * _P19.y * (flutter + k2 * _P20.x));
        float3 displaced = posWS + extra;
        extra = instanceT + normalize(displaced - TransformObjectToWorld(windVecOS)) * length(posWS - TransformObjectToWorld(windVecOS)) - posWS;
    }

    float3 total = linearDisp + rotOff + extra;
    return amp > 0.01 ? total : 0.0;
}

Varyings229351 EID229351Vertex(Attributes229351 input)
{
    Varyings229351 o;
    uint packed = asuint(input.packedNormal.x);
    bool packedBasis = (packed & 0x40000000u) != 0u;
    float3 normalOS = packedBasis ? DecodeOctNormal229351(packed) : input.packedNormal.xyz;
    float4 tangentOS = packedBasis ? DecodePackedTangent229351(packed, normalOS) : input.input2;

    float3 windVecOS = float3(input.input5.x, input.input5.y, input.input6.x) * _P06.z;
    float3 instanceT = TransformObjectToWorld(float3(0.0, 0.0, 0.0));
    float instanceScale = length(TransformObjectToWorldDir(float3(1.0, 0.0, 0.0)));
    float3 positionWS = TransformObjectToWorld(input.position);
    positionWS += EvaluateWind229351(input.position, positionWS, instanceT, instanceScale, input.input3, input.input6.y, windVecOS, _WindA) * (1.0 - _PrevBlend);

    float3 normalWS = normalize(TransformObjectToWorldNormal(normalOS));
    float3 tangentWS = normalize(TransformObjectToWorldDir(tangentOS.xyz));
    float4 clip = TransformWorldToHClip(positionWS);

    o.positionCS = clip;
    o.uv0 = input.input4;
    o.normalWS = normalWS;
    o.tangentWS = float4(tangentWS, tangentOS.w * GetOddNegativeScale());
    o.loc3 = input.input3;
    o.currentClipXYW = clip.xyw;
    o.previousClipXYW = clip.xyw;
    return o;
}

struct GBufferOutput229352
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput229352 EID229352Fragment(Varyings229351 input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput229352 o;
    float tangentInputSign = input.tangentWS.w > 0.0 ? 1.0 : -1.0;
    float3 n = normalize(input.normalWS);
    float3 t = normalize(input.tangentWS.xyz);
    float3 b = normalize(cross(n, t)) * tangentInputSign;
    float3x3 tbn = float3x3(t, b, n);

    float loc3x = input.loc3.x;
    float faceSign = isFrontFace ? 1.0 : -1.0;
    float twoSided = lerp(1.0, faceSign, _P01.z);

    float mip = _EID229352MipBias;
    float4 albedoSample = SAMPLE_TEXTURE2D_BIAS(_Res25, sampler_Res25, input.uv0, mip);
    float3 albedo = lerp(saturate(albedoSample.rgb * _P15.rgb * _P06.x), _P15.rgb, _P05.w);

    float4 extraSample = SAMPLE_TEXTURE2D_BIAS(_Res27, sampler_Res27, input.uv0, mip);
    float4 packed = float4(extraSample.x, extraSample.y, 0.0, extraSample.x);
    float2 nxyRaw = packed.wy * 2.0 - 1.0;
    float nz = sqrt(saturate(1.0 - dot(nxyRaw, nxyRaw)));
    float2 nxy = nxyRaw * _P01.x * twoSided;
    float3 nts = float3(nxy, nz);
    float3 tsNormalWS = normalize(mul(nts, tbn)) * twoSided;
    float3 normalWS = lerp(tsNormalWS, n, _P05.z);
    normalWS = normalize(normalWS);

    float extraW = saturate((1.0 - extraSample.w) * _P17.w * 10.0);
    float h = pow(saturate(lerp(tsNormalWS.y, n.y, _P16.z) + 0.5 + _P16.x), _P16.y);
    float3 extraCol = lerp(_P17.xyz, _P15.xyz, saturate(h + 1.0 - extraW));
    albedo *= extraCol;

    float3 sunDir = _SunDir.xyz;
    float ndl = saturate(dot(normalWS, -sunDir));
    float wrap = pow(dot(tsNormalWS, sunDir) * 0.5 + 0.5, _P05.y) * _P05.x;
    wrap = saturate(1.0 - wrap);
    float wrapMask = lerp(1.0, loc3x, _P02.y) * wrap;

    float3 instanceT = float3(UNITY_MATRIX_M._m03, UNITY_MATRIX_M._m13, UNITY_MATRIX_M._m23);
    float distFade = _P04.z > 0.0 ? smoothstep(60.0, 50.0, length(_WorldSpaceCameraPos - instanceT)) : 1.0;
    float roughness = lerp(_P02.w, _P03.x, extraSample.z);
    float ao = saturate(1.0 - extraSample.w) * _P02.z * distFade;
    float loc3Ao = saturate(lerp(1.0, loc3x, _P02.x));
    float materialY = _P04.x;
    float materialZ = materialY;

    float2 aoEdge = float2(_P07.z, _P08.x);
    float2 aoOuter = float2(_P07.z + _P07.w, _P08.x + _P08.y);
    float2 aoMask = smoothstep(aoEdge, aoOuter, loc3Ao.xx);
    float packedY = ao * aoMask.x;
    float packedZ = materialZ * aoMask.y;

    float2 motion = input.currentClipXYW.xy / max(input.currentClipXYW.z, 1e-8) - input.previousClipXYW.xy / max(input.previousClipXYW.z, 1e-8);
    motion.y = -motion.y;
    float2 encodedMotion = sqrt(sqrt(abs(motion * 0.5))) * (float2)(int2)sign(motion) * 0.5 + 0.5;

    uint py = (uint)round(packedY * 127.0);
    uint pz = (uint)round(packedZ * 31.0);
    uint ndlu = (uint)round(ndl * 127.0);
    uint eu = (uint)round(_P04.w * 31.0);
    uint wrapu = (uint)round(wrapMask * 127.0);
    uint packBits = (uint)round(_P06.y * 7.0);
    float rt2x = float((py << 3u) | ((pz >> 2u) & 7u)) * 0.0010;
    float rt2w = float(pz & 3u) * 0.3333333433;
    float rt2z = float((ndlu << 3u) | ((eu >> 2u) & 7u)) * 0.0010;
    float rt2y = float((wrapu << 3u) | (packBits & 7u)) * 0.0010;
    float rt3w = float(eu & 3u) * 0.3333333433;

    float3 octN = normalize(tsNormalWS);
    float2 oct = octN.xz / dot(1.0.xxx, abs(octN));
    if (octN.y <= 0.0)
        oct = (1.0 - abs(oct.yx)) * (oct >= 0.0 ? 1.0 : -1.0);
    oct = oct * 0.5 + 0.5;

    o.rt0 = float4(0.0, 0.0, 0.0, 0.5);
    o.rt1 = float4(encodedMotion, 1.0, 0.0);
    o.rt2 = float4(rt2x, rt2y, rt2z, rt2w);
    o.rt3 = float4(oct, roughness, rt3w);
    o.rt4 = float4(albedo, loc3Ao);
    return o;
}

#endif
