#ifndef EID209990_209991_GBUFFER_INCLUDED
#define EID209990_209991_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_Res28); SAMPLER(sampler_Res28);
TEXTURE2D(_Res26); SAMPLER(sampler_Res26);

CBUFFER_START(UnityPerMaterial)
float4 _P00; float4 _P01; float4 _P02; float4 _P03;
float4 _P04; float4 _P05; float4 _P06; float4 _P07;
float4 _P08; float4 _P09; float4 _P10; float4 _P11;
float4 _P12; float4 _P13; float4 _P14; float4 _P15;
float4 _P16; float4 _P17; float4 _P18; float4 _P19;
float4 _P20; float4 _P21; float4 _P22;
float4 _SunDir;
float _EID209991MipBias;
CBUFFER_END

struct Attributes209990
{
    float3 position : POSITION;
    float4 packedNormal : NORMAL;
    float4 input2 : COLOR0;
    float4 input3 : TANGENT;
    float2 input4 : TEXCOORD0;
};

struct Varyings209990
{
    float4 positionCS : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    float3 normalWS : TEXCOORD1;
    float4 tangentWS : TEXCOORD2;
    float4 loc3 : TEXCOORD3;
    float3 currentClipXYW : TEXCOORD4;
    float3 previousClipXYW : TEXCOORD5;
    float3 objectPos : TEXCOORD6;
};

float3 DecodeOctNormal209990(uint packed)
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

float4 DecodePackedTangent209990(uint packed, float3 n)
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

Varyings209990 EID209990Vertex(Attributes209990 input)
{
    Varyings209990 o;
    uint packed = asuint(input.packedNormal.x);
    bool packedBasis = (packed & 0x40000000u) != 0u;
    float3 normalOS = packedBasis ? DecodeOctNormal209990(packed) : input.packedNormal.xyz;
    float4 tangentOS = packedBasis ? DecodePackedTangent209990(packed, normalOS) : input.input2;

    float3 positionWS = TransformObjectToWorld(input.position);
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
    o.objectPos = input.position;
    return o;
}

struct GBufferOutput209991
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput209991 EID209991Fragment(Varyings209990 input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput209991 o;
    float tangentInputSign = input.tangentWS.w > 0.0 ? 1.0 : -1.0;
    float3 n = normalize(input.normalWS);
    float3 t = normalize(input.tangentWS.xyz);
    float3 b = normalize(cross(n, t)) * tangentInputSign;
    float3x3 tbn = float3x3(t, b, n);

    float loc3x = input.loc3.x;
    float loc3y = input.loc3.y;
    float faceSign = isFrontFace ? 1.0 : -1.0;
    float twoSided = lerp(1.0, faceSign, step(0.5, _P03.x + loc3x + loc3y));

    float4 albedoSample = SAMPLE_TEXTURE2D_BIAS(_Res28, sampler_Res28, input.uv0, _EID209991MipBias);
    float3 albedo = loc3x != 0.0 ? albedoSample.rgb : saturate(albedoSample.rgb * _P09.rgb * _P06.x);

    float4 nmSample = SAMPLE_TEXTURE2D_BIAS(_Res26, sampler_Res26, input.uv0, _EID209991MipBias);
    float4 packed = float4(nmSample.xy, 0.0, 0.0) * float4(2.0, 2.0, 0.0, 0.0) + float4(-1.0, -1.0, 1.0, -1.0);
    packed.z = dot(packed.xyz, -packed.xyw);
    packed.xy *= sqrt(packed.z);
    float3 nts = packed.xyz * 2.0 + float3(0.0, 0.0, -1.0);
    nts.xy *= _P01.x;
    nts = normalize(nts);
    nts.xy *= twoSided;
    nts = normalize(nts);
    float3 normalWS = normalize(mul(nts, tbn));
    normalWS *= twoSided;

    float3 sunDir = _SunDir.xyz;
    float ndl = saturate(dot(normalWS, -sunDir));
    float wrap = pow(dot(normalWS, sunDir) * 0.5 + 0.5, _P05.z) * _P05.y;
    wrap = saturate(1.0 - wrap);
    float wrapMask = lerp(1.0, nmSample.w, _P03.w) * wrap;
    wrapMask = lerp(wrapMask, 1.0, loc3x);

    float distFade = _P06.y != 0.0 ? smoothstep(60.0, 50.0, 0.0) : 1.0;
    float roughnessA;
    float materialY;
    if (_P06.z < 0.5)
    {
        roughnessA = lerp(_P04.y, _P04.z, nmSample.z);
        materialY = _P02.w * distFade;
    }
    else
    {
        roughnessA = lerp(_P04.y, _P04.z, 0.8);
        materialY = _P02.w * nmSample.z * distFade;
    }
    float roughness = lerp(roughnessA, nmSample.z, loc3x);
    materialY = lerp(materialY, 0.0, loc3x);

    float ao = saturate((1.0 - _P03.y) + nmSample.w * _P03.y);
    ao = lerp(ao, nmSample.w, loc3x);
    float materialZ = lerp(_P02.z, 0.0, loc3x);
    float emissive = lerp(_P04.x, 0.0, loc3x);

    float2 aoEdge = float2(_P08.x, _P08.z);
    float2 aoOuter = float2(_P08.x + _P08.y, _P08.z + _P08.w);
    float2 aoMask = smoothstep(aoEdge, aoOuter, ao.xx);
    float packedY = materialY * aoMask.x;
    float packedZ = materialZ * aoMask.y;

    float2 motion = input.currentClipXYW.xy / max(input.currentClipXYW.z, 1e-8) - input.previousClipXYW.xy / max(input.previousClipXYW.z, 1e-8);
    motion.y = -motion.y;
    float2 encodedMotion = sqrt(sqrt(abs(motion * 0.5))) * (float2)(int2)sign(motion) * 0.5 + 0.5;

    uint py = (uint)round(packedY * 127.0);
    uint pz = (uint)round(packedZ * 31.0);
    uint ndlu = (uint)round(ndl * 127.0);
    uint eu = (uint)round(emissive * 31.0);
    uint wrapu = (uint)round(wrapMask * 127.0);
    float rt2x = float((py << 3u) | ((pz >> 2u) & 7u)) * 0.0009765625;
    float rt2w = float(pz & 3u) * 0.3333333433;
    float rt2z = float((ndlu << 3u) | ((eu >> 2u) & 7u)) * 0.0009765625;
    float rt2y = float((wrapu << 3u) | 3u) * 0.0009765625;
    float rt3w = float(eu & 3u) * 0.3333333433;

    float3 octN = normalize(normalWS);
    float2 oct = octN.xz / dot(1.0.xxx, abs(octN));
    if (octN.y <= 0.0)
        oct = (1.0 - abs(oct.yx)) * (oct >= 0.0 ? 1.0 : -1.0);
    oct = oct * 0.5 + 0.5;

    o.rt0 = float4(0.0, 0.0, 0.0, 0.5);
    o.rt1 = float4(encodedMotion, 0.0, 0.0);
    o.rt2 = float4(rt2x, rt2y, rt2z, rt2w);
    o.rt3 = float4(oct, roughness, rt3w);
    o.rt4 = float4(albedo, ao);
    return o;
}

#endif
