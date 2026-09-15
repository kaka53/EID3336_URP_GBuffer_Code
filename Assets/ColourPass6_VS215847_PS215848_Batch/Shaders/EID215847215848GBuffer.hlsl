#ifndef EID215847_215848_GBUFFER_INCLUDED
#define EID215847_215848_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

Texture2D _Res25; SamplerState sampler_Res25;
Texture2D _Res27; SamplerState sampler_Res27;
Texture2D _Res32; SamplerState sampler_Res32;
Texture2D _Res33; SamplerState sampler_Res33;
Texture2D _Res34; SamplerState sampler_Res34;

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
float4 _TerrainOrigin32;
float4 _TerrainOrigin33;
float4 _TerrainPad;
float _WindGate;
float _EID215848MipBias;
float _PrevBlend;
CBUFFER_END

struct EID215847Instance
{
    float4 r0;
    float4 r1;
    float4 r2;
    float4 r3;
    float4 m1;
    float4 m2;
};
StructuredBuffer<EID215847Instance> _EID215847Instances;

struct Attributes215847
{
    float3 position : POSITION;
    float4 packedNormal : NORMAL;
    float4 tangent : TANGENT;
    float4 color : COLOR;
    float2 uv0 : TEXCOORD0;
    float2 uv1 : TEXCOORD1;
    float2 uv2 : TEXCOORD2;
    float instanceIndex : TEXCOORD3;
};

struct Varyings215847
{
    float4 positionCS : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    float3 normalWS : TEXCOORD1;
    float4 tangentWS : TEXCOORD2;
    float4 loc3 : TEXCOORD3;
    float3 currentClipXYW : TEXCOORD4;
    float3 previousClipXYW : TEXCOORD5;
    nointerpolation uint instanceId : TEXCOORD6;
};

float4x4 EID215847ObjectToWorldMatrix(uint idx)
{
    EID215847Instance rec = _EID215847Instances[idx];
    return float4x4(
        rec.r0.x, rec.r1.x, rec.r2.x, rec.r3.x,
        rec.r0.y, rec.r1.y, rec.r2.y, rec.r3.y,
        rec.r0.z, rec.r1.z, rec.r2.z, rec.r3.z,
        rec.r0.w, rec.r1.w, rec.r2.w, rec.r3.w);
}

float3 DecodeOctNormal215847(uint packed)
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

float4 DecodePackedTangent215847(uint packed, float3 n)
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

float3 RotateAroundAxis215847(float3 v, float3 axis, float radians)
{
    axis = normalize(axis);
    float s = sin(radians);
    float c = cos(radians);
    float k = 1.0 - c;
    float3x3 m = float3x3(
        k * axis.x * axis.x + c, k * axis.x * axis.y - s * axis.z, k * axis.x * axis.z + s * axis.y,
        k * axis.x * axis.y + s * axis.z, k * axis.y * axis.y + c, k * axis.y * axis.z - s * axis.x,
        k * axis.x * axis.z - s * axis.y, k * axis.y * axis.z + s * axis.x, k * axis.z * axis.z + c);
    return mul(v, m);
}

float3 SampleTerrain215847(Texture2D tex, SamplerState samp, float3 mixPos, float4 origin, float3 worldPos, float3 windVecWS, float loc3y)
{
    float2 delta = mixPos.xz - origin.xz;
    float2 scaled = delta * 0.0313;
    if (any(abs(scaled) > 0.5))
        return 0.0;
    float2 uv = scaled + 0.5;
    float4 s = tex.SampleLevel(samp, uv, 0);
    if (s.x > 0.99)
        return 0.0;
    float height = (s.x - 0.5) * 10.0 + origin.y;
    if (mixPos.y > height + _TerrainPad.x + 0.2 || mixPos.y < height - 0.5)
        return 0.0;
    float sy = tex.SampleLevel(samp, scaled + float2(0.5039, 0.5000), 0).y;
    float sz = tex.SampleLevel(samp, scaled + float2(0.5000, 0.5039), 0).y;
    float4 h4 = (float4(s.y, s.y, sy, sz) - 0.5) * 10.0 + origin.yyyy;
    float3 n = normalize(float3(h4.z - h4.y, 0.0010, h4.w - h4.x));
    float3 h = frac(windVecWS.xzx * 0.1031);
    float nse = frac(dot(h, h.yzx + 33.33));
    float nseB = frac((h.x + nse + h.y) * (h.z + nse));
    float rise = ((s.y - 0.5) * 10.0 + origin.y) - height;
    float t = saturate((rise / max(_P21.x + nseB, 1e-5)) * 2.0);
    float keep = 1.0 - t;
    float cosTerm = cos(t * _P20.z * _P21.x) * keep * keep * keep;
    float drop = max(worldPos.y - height, 0.0) * _P20.w * keep;
    float3 posY = float3(worldPos.x, worldPos.y - drop, worldPos.z);
    float3 lateral = float3(n.x, 0.0, n.z) * cosTerm * max(worldPos.y - height, 0.0) * _P20.y * loc3y;
    float3 displaced = posY + lateral;
    float3 dir = displaced - windVecWS;
    dir *= rsqrt(max(dot(dir, dir), 0.0));
    return windVecWS + dir * length(posY - windVecWS) - worldPos;
}

float3 EvaluateWind215847(float3 posOS, float3 posWS, float3 instanceT, float instanceScale, float4 loc3, float3 windVecOS, float3 windVecWS, float4 pack)
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

    float3 mixPos = lerp(posWS, windVecWS, _P19.x);
    float2 uv = mixPos.xz * _P19.z + mixPos.yy * 0.02;
    uv += (0.1 * (t + fieldW) * _P18.w).xx;
    float4 noise = _Res34.SampleLevel(sampler_Res34, uv, 0);
    float2 nxy = noise.xy - 0.5;
    float blend = saturate(amp * 0.25 - 0.25);
    float nMix = lerp(nxy.x, nxy.y, blend);
    float3 dispDir = float3(dir.x, 0.2 * nxy.y, dir.z);
    float stiff = loc3.y * loc3.y;
    float linearScale = (amp * 0.25 + 0.25) * (nMix + _P19.z) * stiff * _P18.z * instanceScale;
    float3 linearDisp = dispDir * linearScale;

    float k = saturate(amp * 0.2);
    float k2 = k * k;
    float ease = 1.0 - (1.0 - k) * (1.0 - k) * (1.0 - k);
    float extraPhase = _P17.x > 0.0 ? loc3.w : 0.0;
    float phase = (t + fieldW) * _P16.y + (dot(instanceT, float3(0.08, -0.03, 0.08)) - extraPhase) * 6.28318548;
    float wobble = 0.5 * sin(phase) + 0.25 * cos(phase * 0.5);
    float rotMask = saturate(loc3.w - _P16.z);
    rotMask *= rotMask;
    float angleDeg = (wobble * ease + _P16.w * k2) * amp * _P16.x * rotMask;
    float3 rel = posWS - instanceT;
    float3 axis = float3(dir.z, 0.0, -dir.x);
    float3 rotOff = RotateAroundAxis215847(rel, axis, radians(angleDeg)) - rel;

    float3 extra = 0.0;
    if (_P17.x > 0.0 && any(windVecOS != 0.0))
    {
        float3 flutterSrc = lerp(posOS, windVecOS, _P17.w.xxx);
        float3 flutterPos = instanceT * 0.01 + flutterSrc;
        float2 fuv = flutterPos.xz * (_P18.y * _P18.y) + flutterPos.yy * (_P17.x * 0.02);
        float4 fn = _Res34.SampleLevel(sampler_Res34, fuv, 0);
        float4 s = sin(float4(1.0, 0.5, 0.25, 0.125) * (fn.y * 25.132741 + t * _P17.z));
        float4 w = lerp(float4(0.5, 0.25, 0.125, 0.0625), 0.25.xxxx, _P17.x.xxxx);
        float flutter = dot(s, w) * ease;
        float len = length(windVecOS - posOS);
        float height = loc3.z * lerp(loc3.z, 0.5 * len, _P19.w);
        extra = dir * ((0.5 * instanceScale) * height * _P17.y * (flutter + k2 * _P18.x));
        float3 displaced = posWS + extra;
        extra = instanceT + normalize(displaced - windVecWS) * length(posWS - windVecWS) - posWS;
    }

    float3 total = linearDisp + rotOff + extra;
    return amp > 0.01 ? total : 0.0;
}

Varyings215847 EID215847Vertex(Attributes215847 input)
{
    Varyings215847 o;
    uint idx = (uint)max(input.instanceIndex, 0.0);
    float4x4 objectToWorld = EID215847ObjectToWorldMatrix(idx);
    float3 translation = float3(objectToWorld[0].w, objectToWorld[1].w, objectToWorld[2].w);
    float3x3 basis = float3x3(objectToWorld[0].xyz, objectToWorld[1].xyz, objectToWorld[2].xyz);
    float instanceScale = length(float3(objectToWorld[0].x, objectToWorld[1].x, objectToWorld[2].x));

    uint packed = asuint(input.packedNormal.x);
    bool packedBasis = (packed & 0x40000000u) != 0u;
    float3 normalOS = packedBasis ? DecodeOctNormal215847(packed) : input.packedNormal.xyz;
    float4 tangentOS = packedBasis ? DecodePackedTangent215847(packed, normalOS) : input.tangent;

    float3 windVecOS = float3(input.uv1.x, input.uv1.y, input.uv2.x) * _P06.z;
    float3 positionWS = mul(basis, input.position) + translation;
    float3 windVecWS = mul(basis, windVecOS) + translation;
    float fade = 1.0 - _PrevBlend;
    float3 mixTerrain = lerp(windVecWS, positionWS, _P20.x);
    float3 windNow = EvaluateWind215847(input.position, positionWS, translation, instanceScale, input.color, windVecOS, windVecWS, _WindA);
    float3 windPrev = EvaluateWind215847(input.position, positionWS, translation, instanceScale, input.color, windVecOS, windVecWS, _WindB);
    float3 t32 = SampleTerrain215847(_Res32, sampler_Res32, mixTerrain, _TerrainOrigin32, positionWS, windVecWS, input.color.y);
    float3 t33 = SampleTerrain215847(_Res33, sampler_Res33, mixTerrain, _TerrainOrigin33, positionWS, windVecWS, input.color.y);
    float3 worldNow = positionWS + (windNow + t32) * fade;
    float3 worldPrev = positionWS + (windPrev + t33) * fade;

    float3 normalWS = normalize(mul(basis, normalOS));
    float3 tangentWS = normalize(mul(basis, tangentOS.xyz));
    float4 clip = mul(UNITY_MATRIX_VP, float4(worldNow, 1.0));
    float4 prevClip = mul(UNITY_MATRIX_VP, float4(worldPrev, 1.0));

    o.positionCS = clip;
    o.uv0 = input.uv0;
    o.normalWS = normalWS;
    o.tangentWS = float4(tangentWS, tangentOS.w);
    o.loc3 = input.color;
    o.currentClipXYW = clip.xyw;
    o.previousClipXYW = prevClip.xyw;
    o.instanceId = idx;
    return o;
}

struct GBufferOutput215848
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput215848 EID215848Fragment(Varyings215847 input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput215848 o;
    float tangentInputSign = input.tangentWS.w > 0.0 ? 1.0 : -1.0;
    float3 n = input.normalWS;
    float3 t = input.tangentWS.xyz;
    float3 b = cross(n, t) * tangentInputSign;
    float3x3 tbn = float3x3(t, b, n);

    float loc3x = input.loc3.x;
    float faceSign = isFrontFace ? 1.0 : -1.0;
    float twoSided = lerp(1.0, faceSign, _P01.z);

    float mip = _EID215848MipBias;
    float4 albedoSample = _Res25.SampleBias(sampler_Res25, input.uv0, mip);
    float3 albedo = lerp(saturate(albedoSample.rgb * _P15.rgb * _P06.x), _P15.rgb, _P05.w);

    float4 extraSample = _Res27.SampleBias(sampler_Res27, input.uv0, mip);
    float4 packed = float4(extraSample.x, extraSample.y, 0.0, extraSample.x);
    float2 nxyRaw = packed.wy * 2.0 - 1.0;
    float nz = sqrt(saturate(1.0 - dot(nxyRaw, nxyRaw)));
    float2 nxy = nxyRaw * _P01.x * twoSided;
    float3 nts = float3(nxy, nz);
    float3 tsN = mul(nts, tbn);
    tsN *= rsqrt(max(dot(tsN, tsN), 0.0));
    float3 twoSidedN = tsN * twoSided;
    float3 normalWS = lerp(twoSidedN, n, _P05.z);

    float distFade = 1.0;
    if (_P04.z > 0.0)
    {
        EID215847Instance rec = _EID215847Instances[input.instanceId];
        distFade = smoothstep(60.0, 50.0, length(_WorldSpaceCameraPos - rec.r3.xyz));
    }

    float roughness = lerp(_P02.w, _P03.x, extraSample.z);
    float extraMask = _P02.z * saturate(1.0 - extraSample.w) * distFade;
    float loc3Ao = saturate(lerp(1.0, loc3x, _P02.x));
    float wrapMix = lerp(1.0, loc3x, _P02.y);

    float3 sunDir = _SunDir.xyz;
    float ndl = saturate(dot(normalWS, -sunDir));
    float wrap = pow(dot(twoSidedN, sunDir) * 0.5 + 0.5, _P05.y) * _P05.x;
    wrap = saturate(1.0 - wrap);
    float wrapMask = wrapMix * wrap;

    float2 aoEdge = float2(_P07.z, _P08.x);
    float2 aoOuter = float2(_P07.z + _P07.w, _P08.x + _P08.y);
    float2 aoMask = smoothstep(aoEdge, aoOuter, loc3Ao.xx);
    float packedY = extraMask * aoMask.x;
    float packedZ = _P04.x * aoMask.y;

    float2 motion = input.currentClipXYW.xy / max(input.currentClipXYW.z, 0.0) - input.previousClipXYW.xy / max(input.previousClipXYW.z, 0.0);
    motion.y = -motion.y;
    float2 encodedMotion = sqrt(sqrt(abs(motion * 0.5))) * (float2)(int2)sign(motion) * 0.5 + 0.5;

    uint py = (uint)round(packedY * 127.0);
    uint pz = (uint)round(packedZ * 31.0);
    uint ndlu = (uint)round(ndl * 127.0);
    uint eu = (uint)round(_P04.w * 31.0);
    uint wrapu = (uint)round(wrapMask * 127.0);
    uint packBits = (uint)round(_P06.y * 7.0);
    float rt2x = float((py << 3u) | ((pz >> 2u) & 7u)) * 0.0010;
    float rt2w = float(pz & 3u) * 0.3333;
    float rt2z = float((ndlu << 3u) | ((eu >> 2u) & 7u)) * 0.0010;
    float rt2y = float((wrapu << 3u) | (packBits & 7u)) * 0.0010;
    float rt3w = float(eu & 3u) * 0.3333;

    float3 octN = normalize(twoSidedN);
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
