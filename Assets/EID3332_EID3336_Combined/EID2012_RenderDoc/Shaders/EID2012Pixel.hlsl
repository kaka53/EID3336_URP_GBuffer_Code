#ifndef EID2012_PIXEL_INCLUDED
#define EID2012_PIXEL_INCLUDED

TEXTURE2D(_EID2012BaseColorMap);
SAMPLER(sampler_EID2012BaseColorMap);
TEXTURE2D(_EID2012NormalMaterialMap);
SAMPLER(sampler_EID2012NormalMaterialMap);

CBUFFER_START(UnityPerMaterial)
float _EID2012MipBias;
float _EID2012BaseColorScale;
float _EID2012LocalParam0;
float4 _EID2012LocalParam2;
float4 _EID2012LocalParam3;
CBUFFER_END

struct EID2012GBufferOutput
{
    float4 rt0 : SV_Target0;
    float4 rt1 : SV_Target1;
    float4 rt2 : SV_Target2;
    float4 rt3 : SV_Target3;
    float4 rt4 : SV_Target4;
};

EID2012GBufferOutput EID2012Fragment(EID2012Varyings input)
{
    EID2012GBufferOutput output;

    // Direct Unity adaptation of RenderDoc PS 209977.
    float tangentHandedness = input.tangentWS.w > 0.0 ? 1.0 : -1.0;
    float3 tangentWS = input.tangentWS.xyz;

    // RenderDoc: _17 at t3/res17 is the base-color texture.
    float4 baseSample = SAMPLE_TEXTURE2D_BIAS(_EID2012BaseColorMap, sampler_EID2012BaseColorMap, input.uv, _EID2012MipBias);
    float baseAlpha = baseSample.a;
    float3 rt0Color = baseSample.rgb * (saturate(baseAlpha * 1.1111111640930176 - 0.111111119389534) * _EID2012BaseColorScale);

    // RenderDoc: _19 at t2/res19 stores tangent-space normal XY and material ZW.
    float4 normalMaterial = SAMPLE_TEXTURE2D_BIAS(_EID2012NormalMaterialMap, sampler_EID2012NormalMaterialMap, input.uv, _EID2012MipBias);
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
        lerp(baseAlpha, 1.0, saturate(sign(_EID2012BaseColorScale))), 0.0, 0.0);
    output.rt3 = float4(encodedNormal, normalMaterial.z, 0.0);
    output.rt4 = float4(baseSample.rgb, 0.0);
    return output;
}

#endif
