#ifndef EID209975_209977_GBUFFER_INCLUDED
#define EID209975_209977_GBUFFER_INCLUDED

TEXTURE2D(_Res17);
SAMPLER(sampler_Res17);
TEXTURE2D(_Res19);
SAMPLER(sampler_Res19);

CBUFFER_START(UnityPerMaterial)
float _EID209977MipBias;
float _EID209977BaseColorScale;
float _EID209977LocalParam0;
float4 _EID209977LocalParam2;
float4 _EID209977LocalParam3;
CBUFFER_END

struct EID209975VertexInput
{
    float3 positionOS : POSITION;
    float packedNormal : TEXCOORD1;
    float4 tangentOS : TANGENT;
    float4 color : COLOR;
    float2 uv0 : TEXCOORD0;
};

struct EID209975Varyings
{
    float2 uv : TEXCOORD0;
    float3 normalWS : TEXCOORD2;
    float4 tangentWS : TEXCOORD3;
    float3 currentClipXYW : TEXCOORD5;
    float3 previousClipXYW : TEXCOORD6;
    float4 positionCS : SV_POSITION;
};

struct EID209977GBufferOutput
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

void EID209975DecodePackedNormalTangent(float packedValue, float4 fallbackTangent, out float3 normalOS, out float4 tangentOS)
{
    uint packed = asuint(packedValue);
    bool packedEncoding = (packed & 1073741824u) > 0u;
    if (!packedEncoding)
    {
        normalOS = float3(packedValue, 0.0, 0.0);
        tangentOS = fallbackTangent;
        return;
    }

    float px = float((packed << 22u) >> 22u);
    float py = float((packed << 12u) >> 22u);
    float pt = float((packed << 2u) >> 22u);
    float2 oct = float2(px >= 512.0 ? px - 1024.0 : px,
                        py >= 512.0 ? py - 1024.0 : py) * 0.001956947147846221923828125;
    float z = 1.0 - abs(oct.x) - abs(oct.y);
    float2 folded = (1.0.xx - abs(oct.yx)) * (step(0.0.xx, oct.xy) * 2.0 - 1.0.xx);
    if (z < 0.0) oct = folded;
    normalOS = normalize(float3(oct, z));

    float tangentPacked = (pt >= 512.0 ? pt - 1024.0 : pt) * 0.001956947147846221923828125;
    float3 seed = normalOS.yzx - normalOS.zxy;
    float3 basisX = normalize(seed - dot(seed, normalOS) * normalOS);
    float signValue = tangentPacked < 0.0 ? -1.0 : 1.0;
    float reconstructed = 1.0 - (tangentPacked * signValue * 2.0);
    float2 tangent2 = normalize(float2(reconstructed, signValue * (1.0 - abs(reconstructed))));
    float3 tangent3 = mul(tangent2, float2x3(basisX, normalize(cross(normalOS, basisX))));
    tangentOS = float4(tangent3, (float((packed >> 31u) & 1u) * 2.0) - 1.0);
}

EID209975Varyings EID209975Vertex(EID209975VertexInput input)
{
    EID209975Varyings output;
    float3 normalOS;
    float4 tangentOS;
    EID209975DecodePackedNormalTangent(input.packedNormal, input.tangentOS, normalOS, tangentOS);

    float3 positionWS = TransformObjectToWorld(input.positionOS);
    float3 normalWS = normalize(TransformObjectToWorldNormal(normalOS));
    float3 tangentWS = normalize(TransformObjectToWorldDir(tangentOS.xyz));
    float tangentSign = tangentOS.w * GetOddNegativeScale();
    float4 positionCS = TransformWorldToHClip(positionWS);

    output.positionCS = positionCS;
    output.uv = input.uv0;
    output.normalWS = normalWS;
    output.tangentWS = float4(tangentWS, tangentSign);
    output.currentClipXYW = positionCS.xyw;
    output.previousClipXYW = positionCS.xyw;
    return output;
}

EID209977GBufferOutput EID209977Fragment(EID209975Varyings input)
{
    EID209977GBufferOutput output;

    float tangentHandedness = input.tangentWS.w > 0.0 ? 1.0 : -1.0;
    float3 tangentWS = input.tangentWS.xyz;

    float4 baseSample = SAMPLE_TEXTURE2D_BIAS(_Res17, sampler_Res17, input.uv, _EID209977MipBias);
    float baseAlpha = baseSample.a;
    float3 rt0Color = baseSample.rgb * (saturate(baseAlpha * 1.1111111640930176 - 0.111111119389534) * _EID209977BaseColorScale);

    float4 normalMaterial = SAMPLE_TEXTURE2D_BIAS(_Res19, sampler_Res19, input.uv, _EID209977MipBias);
    float2 tangentNormalXY = normalMaterial.xy * 2.0 - 1.0;
    tangentNormalXY = float2(abs(tangentNormalXY.x) < 0.0120000001043081 ? 0.0 : tangentNormalXY.x,
                             abs(tangentNormalXY.y) < 0.0120000001043081 ? 0.0 : tangentNormalXY.y);
    float tangentNormalZ = sqrt(saturate(1.0 - dot(tangentNormalXY, tangentNormalXY)));
    float3x3 tangentToWorld = float3x3(tangentWS,
        cross(input.normalWS, tangentWS) * tangentHandedness,
        input.normalWS);
    float3 normalWS = normalize(mul(float3(tangentNormalXY, tangentNormalZ), tangentToWorld));

    float2 motion = input.currentClipXYW.xy / max(input.currentClipXYW.z, 1.0e-8) -
                    input.previousClipXYW.xy / max(input.previousClipXYW.z, 1.0e-8);
    motion.y = -motion.y;
    float2 encodedMotion = sqrt(sqrt(abs(motion * 0.5))) * sign(motion) * 0.5 + 0.5;

    float2 oct = normalWS.xz / dot(1.0.xxx, abs(normalWS));
    float3 foldedNormal;
    if (normalWS.y <= 0.0)
    {
        float2 folded = (1.0.xx - abs(oct.yx)) * float2(oct.x >= 0.0 ? 1.0 : -1.0, oct.y >= 0.0 ? 1.0 : -1.0);
        foldedNormal = float3(folded.x, normalWS.y, folded.y);
    }
    else
    {
        foldedNormal = float3(oct.x, normalWS.y, oct.y);
    }
    float2 encodedNormal = foldedNormal.xz * 0.5 + 0.5;

    output.rt0 = float4(rt0Color, 0.5);
    output.rt1 = float4(encodedMotion, 0.0, 0.0);
    output.rt2 = float4(normalMaterial.w,
        lerp(baseAlpha, 1.0, saturate(sign(_EID209977BaseColorScale))), 0.0, 0.0);
    output.rt3 = float4(encodedNormal, normalMaterial.z, 0.0);
    output.rt4 = float4(baseSample.rgb, 0.0);
    return output;
}

#endif
