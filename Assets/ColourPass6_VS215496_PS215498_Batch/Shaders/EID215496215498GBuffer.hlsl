#ifndef EID215496_215498_GBUFFER_INCLUDED
#define EID215496_215498_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_Res24); SAMPLER(sampler_Res24);
TEXTURE2D(_Res26); SAMPLER(sampler_Res26);
TEXTURE2D(_Res32); SAMPLER(sampler_Res32);

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
float4 _WindA;
float4 _WindB;
float _WindGate;
float _EID215498MipBias;
CBUFFER_END

struct Attributes215496
{
    float3 position : POSITION;
    float4 packedNormal : NORMAL;
    float4 input2 : COLOR0;
    float4 input3 : TANGENT;
    float2 input4 : TEXCOORD0;
    float2 input5 : TEXCOORD1;
    float2 input6 : TEXCOORD2;
};

struct Varyings215496
{
    float4 positionCS : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    float2 uv1 : TEXCOORD1;
    float3 positionWS : TEXCOORD2;
    float3 normalWS : TEXCOORD3;
    float4 tangentWS : TEXCOORD4;
    float4 input3 : TEXCOORD5;
    float3 currentClipXYW : TEXCOORD6;
    float3 previousClipXYW : TEXCOORD7;
};

float3 DecodeOctNormal215496(uint packed)
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

float4 DecodePackedTangent215496(uint packed, float3 n)
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

float3 RotateAroundAxis215496(float3 v, float3 axis, float radians)
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

float3 EvaluateWind215496(float3 posOS, float3 posWS, float3 instanceT, float instanceScale, float4 loc3, float extraPhase, float3 windVecOS, float4 pack)
{
    if (_WindGate <= 0.0 || pack.x <= 0.0)
        return 0.0;
    float intensity = pack.x;
    float t = pack.y;
    float3 dir = float3(pack.z, 0.0, pack.w);
    float amp = intensity;

    float k = saturate(amp * 0.2);
    float k2 = k * k;
    float ease = 1.0 - (1.0 - k) * (1.0 - k) * (1.0 - k);
    float phase = t * _P23.y + (dot(instanceT, float3(0.08, -0.03, 0.08)) - extraPhase) * 6.28318548;
    float wobble = 0.5 * sin(phase) + 0.25 * cos(phase * 0.5);
    float rotMask = saturate(loc3.w - _P23.z);
    rotMask *= rotMask;
    float angleDeg = (wobble * ease + _P23.w * k2) * amp * _P23.x * rotMask;
    float3 rel = posWS - instanceT;
    float3 axis = float3(dir.z, 0.0, -dir.x);
    float3 rotOff = RotateAroundAxis215496(rel, axis, radians(angleDeg)) - rel;

    float3 extra = 0.0;
    if (any(windVecOS != 0.0))
    {
        float3 flutterSrc = lerp(posOS, windVecOS, _P24.z.xxx);
        float3 flutterPos = instanceT * 0.01 + flutterSrc;
        float2 fuv = flutterPos.xz * (_P25.x * _P25.x) + flutterPos.yy * (_P22.y * 0.02);
        float4 fn = SAMPLE_TEXTURE2D_LOD(_Res32, sampler_Res32, fuv, 0);
        float4 s = sin(float4(1.0, 0.5, 0.25, 0.125) * (fn.y * 25.132741 + t * _P24.y));
        float4 w = lerp(float4(0.5, 0.25, 0.125, 0.0625), 0.25.xxxx, _P22.y.xxxx);
        float flutter = dot(s, w) * ease;
        float len = length(windVecOS - posOS);
        float height = loc3.z * lerp(loc3.z, 0.5 * len, _P26.z);
        extra = dir * ((0.5 * instanceScale) * height * _P24.x * (flutter + k2 * _P24.w));
        float3 windVecWS = TransformObjectToWorld(windVecOS);
        float3 displaced = posWS + extra;
        extra = instanceT + normalize(displaced - windVecWS) * length(posWS - windVecWS) - posWS;
    }

    float3 total = rotOff + extra;
    return amp > 0.01 ? total : 0.0;
}

float2 DeadzoneNormalXY(float2 encoded)
{
    float2 nxy = encoded * 2.0 - 1.0;
    return abs(nxy) < 0.012.xx ? 0.0.xx : nxy;
}

Varyings215496 EID215496Vertex(Attributes215496 input)
{
    Varyings215496 o;
    uint packed = asuint(input.packedNormal.x);
    bool packedBasis = (packed & 0x40000000u) != 0u;
    float3 normalOS = packedBasis ? DecodeOctNormal215496(packed) : input.packedNormal.xyz;
    float4 tangentOS = packedBasis ? DecodePackedTangent215496(packed, normalOS) : input.input2;

    float3 windVecOS = float3(input.input5.x, input.input5.y, input.input6.x) * _P22.x;
    float extraPhase = _P22.y > 0.0 ? input.input6.y : 0.0;
    float3 instanceT = TransformObjectToWorld(float3(0.0, 0.0, 0.0));
    float3 xaxis = mul((float3x3)GetObjectToWorldMatrix(), float3(1.0, 0.0, 0.0));
    float instanceScale = length(xaxis);
    float3 positionWS = TransformObjectToWorld(input.position);
    positionWS += EvaluateWind215496(input.position, positionWS, instanceT, instanceScale, input.input3, extraPhase, windVecOS, _WindA);

    float3 normalWS = normalize(TransformObjectToWorldNormal(normalOS));
    float3 tangentWS = normalize(TransformObjectToWorldDir(tangentOS.xyz));
    float4 clip = TransformWorldToHClip(positionWS);

    o.positionCS = clip;
    o.uv0 = input.input4;
    o.uv1 = input.input5;
    o.positionWS = positionWS;
    o.normalWS = normalWS;
    o.tangentWS = float4(tangentWS, tangentOS.w * GetOddNegativeScale());
    o.input3 = input.input3;
    o.currentClipXYW = clip.xyw;
    o.previousClipXYW = clip.xyw;
    return o;
}

struct GBufferOutput215498
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput215498 EID215498Fragment(Varyings215496 input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput215498 o;
    float tangentInputSign = input.tangentWS.w > 0.0 ? 1.0 : -1.0;
    float2 uvAlbedo = lerp(input.uv0, input.uv1, _P02.w) * _P11.xy + _P11.zw;
    float2 uvNormal = lerp(input.uv0, input.uv1, _P03.x) * _P12.xy + _P12.zw;
    float mip = _EID215498MipBias;
    float4 albedoSample = SAMPLE_TEXTURE2D_BIAS(_Res24, sampler_Res24, uvAlbedo, mip);
    float4 normalSample = SAMPLE_TEXTURE2D_BIAS(_Res26, sampler_Res26, uvNormal, _P03.y + mip);

    float2 nxyRaw = DeadzoneNormalXY(normalSample.xy);
    float2 nxy = nxyRaw * _P00.x;
    float nz = sqrt(saturate(1.0 - dot(nxyRaw, nxyRaw)));

    float3 baseColor = saturate(albedoSample.rgb * _P08.rgb * _P04.z);
    baseColor = lerp(baseColor, _P08.rgb, _P04.x);
    float roughness = lerp(_P00.z, _P00.w, normalSample.z);
    float ao = lerp(1.0, normalSample.w, _P01.x);
    float materialY = lerp(albedoSample.w, _P04.y, saturate(_P03.w - 1.0));
    ao *= lerp(1.0, input.input3.x, _P25.y);
    if (_P25.z > 0.5)
    {
        float edge = smoothstep(_P26.x + _P26.y, _P26.x, input.input3.w);
        baseColor = lerp(baseColor, _P27.rgb, (_P25.w * edge * albedoSample.a).xxx);
    }

    float faceSign = isFrontFace ? 1.0 : (_P01.w > 0.0 ? -1.0 : 1.0);
    float3 n = normalize(input.normalWS);
    float3 t = normalize(input.tangentWS.xyz);
    float3 b = normalize(cross(n, t)) * tangentInputSign;
    float3 normalWS = normalize(t * nxy.x + b * nxy.y + n * (nz * faceSign));

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

    o.rt0 = float4(0.0, 0.0, 0.0, 0.5);
    o.rt1 = float4(encodedMotion, motionWeight > 0.0 ? 1.0 : _P07.x, motionWeight);
    o.rt2 = float4(materialY, ao, materialZ, float(materialId / 4u) * 0.3333333433);
    o.rt3 = float4(oct, roughness, float(materialId % 4u) * 0.3333333433);
    o.rt4 = float4(baseColor, 0.0);
    return o;
}

#endif
