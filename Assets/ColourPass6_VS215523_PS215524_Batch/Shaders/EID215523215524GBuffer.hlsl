#ifndef EID215523_215524_GBUFFER_INCLUDED
#define EID215523_215524_GBUFFER_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

TEXTURE2D(_Res26); SAMPLER(sampler_Res26);
TEXTURE2D(_Res28); SAMPLER(sampler_Res28);
TEXTURE2D(_Res30); SAMPLER(sampler_Res30);
TEXTURE2D(_Res32); SAMPLER(sampler_Res32);
TEXTURE2D(_Res34); SAMPLER(sampler_Res34);
TEXTURE2D(_Res36); SAMPLER(sampler_Res36);

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
float4 _InstanceMeta;
float4 _InstanceStateYZ;
float4 _ScanPos;
float4 _ScanPoint;
float _EID215524MipBias;
float _ScanPomGrad;
float _ScanGlobalY;
float _InstanceAffineW;
float _UseBakedSkinning;
CBUFFER_END

struct Attributes215523
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

struct Varyings215523
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

float3 DecodeOctNormal215523(uint packed)
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

float4 DecodePackedTangent215523(uint packed, float3 n)
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

Varyings215523 EID215523Vertex(Attributes215523 input)
{
    Varyings215523 o;
    uint packed = asuint(input.packedNormal.x);
    bool packedBasis = (packed & 0x40000000u) != 0u;
    float3 decodedNormalOS = packedBasis ? DecodeOctNormal215523(packed) : input.packedNormal.xyz;
    float4 decodedTangentOS = packedBasis ? DecodePackedTangent215523(packed, decodedNormalOS) : input.input2;
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

struct GBufferOutput215524
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

GBufferOutput215524 EID215524Fragment(Varyings215523 input, bool isFrontFace : SV_IsFrontFace)
{
    GBufferOutput215524 o;
    float tangentInputSign = input.tangentWS.w > 0.0 ? 1.0 : -1.0;
    float mip = _EID215524MipBias;
    float2 uvAlbedo = lerp(input.uv0, input.uv1, _P02.w) * _P11.xy + _P11.zw;
    float2 uvNormal = lerp(input.uv0, input.uv1, _P03.x) * _P12.xy + _P12.zw;
    float4 albedoSample = SAMPLE_TEXTURE2D_BIAS(_Res26, sampler_Res26, uvAlbedo, mip);
    float4 normalSample = SAMPLE_TEXTURE2D_BIAS(_Res28, sampler_Res28, uvNormal, _P03.y + mip);
    normalSample.a *= normalSample.r;
    float2 nxyRaw = normalSample.wy * 2.0 - 1.0;
    float2 nxy = nxyRaw * _P00.x;
    float nz = sqrt(saturate(1.0 - dot(nxyRaw, nxyRaw)));

    float4 extraSample = SAMPLE_TEXTURE2D_BIAS(_Res30, sampler_Res30, uvNormal, mip);
    float3 baseColor = saturate(albedoSample.rgb * _P08.rgb * _P04.z);
    baseColor = lerp(baseColor, _P08.rgb, _P04.x);
    float roughness = lerp(_P00.z, _P00.w, extraSample.y);
    float ao = lerp(1.0, extraSample.z, _P01.x);
    float materialY = lerp(extraSample.x, _P04.y, saturate(_P03.w - 1.0));

    float faceSign = isFrontFace ? 1.0 : (_P01.w > 0.0 ? -1.0 : 1.0);
    float3 n = normalize(input.normalWS);
    float3 tdir = normalize(input.tangentWS.xyz);
    float3 b = normalize(cross(n, tdir)) * tangentInputSign;
    float3 normalWS = normalize(tdir * nxy.x + b * nxy.y + n * (nz * faceSign));

    float mask = lerp(albedoSample.a, extraSample.w, saturate(_P25.w - 1.0));
    mask = lerp(mask, 0.0, _P26.y);
    if (_P28.y != 0.0)
        mask = lerp(albedoSample.a * _P08.w, SAMPLE_TEXTURE2D_BIAS(_Res34, sampler_Res34, input.uv1, mip).x, _P28.y);

    float3 scan = 0.0.xxx;
    if (mask > 0.01)
    {
        float3 viewWS = GetWorldSpaceNormalizeViewDir(input.positionWS);
        float3 viewTS = normalize(float3(dot(viewWS, tdir), dot(viewWS, b), dot(viewWS, n)));
        float2 mixUV = lerp(input.uv0, input.uv1, _P26.x);
        float2 heightUV = mixUV * _P26.z;
        float2 pomOffset = 0.0.xx;
        float steps = _P24.x;
        if (steps > 0.0)
        {
            float stepCount = min(steps, 20.0);
            float stepSize = 1.0 / stepCount;
            float2 para = viewTS.xy / (viewTS.z + 0.42);
            para /= max(viewTS.z, 0.001);
            float2 delta = para * (-_P22.x) * stepSize;
            float layer = 1.0 - stepSize;
            float2 currOff = delta;
            float2 prevOff = 0.0.xx;
            float prevH = 0.0;
            float prevLayer = 1.0;
            float currH = 0.0;
            float2 gradX = ddx(input.uv0) * _ScanPomGrad;
            float2 gradY = ddy(input.uv0) * _ScanPomGrad;
            [loop]
            for (float i = 0.0; i < stepCount + 1.0; i += 1.0)
            {
                prevOff = currOff;
                prevH = currH;
                prevLayer = layer;
                currH = SAMPLE_TEXTURE2D_GRAD(_Res36, sampler_Res36, heightUV + currOff, gradX, gradY).x;
                currOff += delta;
                layer -= stepSize;
            }
            float denom = (prevH - currH + layer) - prevLayer;
            pomOffset = prevOff + delta * ((prevH - prevLayer) / max(denom, 1e-8));
        }
        float4 scanSample = SAMPLE_TEXTURE2D_BIAS(_Res32, sampler_Res32, (mixUV + pomOffset) * _P24.y, mip);
        float ndotv = pow(max(saturate(dot(viewWS, normalWS)), 0.001), floor(_P25.y));
        float k = _P25.x;
        float pulse = (cos(_ScanPos.w * 0.05 * _P24.z + _P24.w * _InstanceAffineW) + ((1.0 + k) / max(1.0 - k, 1e-8))) * ((1.0 - k) * 0.5);
        float xzFade = smoothstep(_ScanPoint.z, 0.0, distance(input.positionWS.xz, _ScanPoint.xy)) * _ScanPoint.w;
        float distFade = _P26.w != 0.0 ? smoothstep(_P27.x, _P27.y, distance(input.positionWS, _ScanPos.xyz)) * _P27.z : 0.0;
        float3 scanCol = lerp(_P30.rgb, _P29.rgb, scanSample.yyy);
        scan = clamp(scanCol * (mask * ndotv * mask) * (pulse + distFade + xzFade), 0.0.xxx, 1000.0.xxx);
        scan *= (_P25.z != 0.0 ? _ScanGlobalY : 1.0);
    }
    scan *= _P28.w;

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

    o.rt0 = float4(scan, 0.5);
    o.rt1 = float4(encodedMotion, motionWeight > 0.0 ? 1.0 : _P07.x, motionWeight);
    o.rt2 = float4(materialY, ao, materialZ, float(materialId / 4u) * 0.3333333433);
    o.rt3 = float4(oct, roughness, float(materialId % 4u) * 0.3333333433);
    o.rt4 = float4(baseColor, 0.0);
    return o;
}

#endif
