#ifndef EID3336_DEFERRED_STAGE6_INCLUDED
#define EID3336_DEFERRED_STAGE6_INCLUDED
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"

TEXTURE2D(_EID3336B6RT0); SAMPLER(sampler_EID3336B6RT0);
TEXTURE2D(_EID3336B6RT1); SAMPLER(sampler_EID3336B6RT1);
TEXTURE2D(_EID3336B6RT2); SAMPLER(sampler_EID3336B6RT2);
TEXTURE2D(_EID3336B6RT3); SAMPLER(sampler_EID3336B6RT3);
TEXTURE2D(_EID3336B6RT4); SAMPLER(sampler_EID3336B6RT4);
TEXTURE2D(_EID3336B6Depth); SAMPLER(sampler_EID3336B6Depth);
TEXTURE2D(_EID3336B6ScreenSH); SAMPLER(sampler_EID3336B6ScreenSH);
TEXTURE2D(_EID3336B6ScreenSpecularColor); SAMPLER(sampler_EID3336B6ScreenSpecularColor);
TEXTURE2D(_EID3336B6ScreenSpecularWeight); SAMPLER(sampler_EID3336B6ScreenSpecularWeight);
TEXTURE2D(_EID3336B6ReflectionValidity); SAMPLER(sampler_EID3336B6ReflectionValidity);
TEXTURE2D(_EID3336B6ReflectionVisibility); SAMPLER(sampler_EID3336B6ReflectionVisibility);
TEXTURE2D(_EID3336B6SSAO); SAMPLER(sampler_EID3336B6SSAO);
TEXTURE2D_ARRAY(_EID3336B6ReflectionAtlas); SAMPLER(sampler_EID3336B6ReflectionAtlas);

StructuredBuffer<float4> _EID3336B6ReflectionProbes;
ByteAddressBuffer _EID3336B6ClusterProbeMasks;

float _EID3336B6MaterialTarget, _EID3336B6NormalTarget, _EID3336B6BaseColorTarget;
float _EID3336B6UseURPGBuffer;
float _EID3336B6ViewMode, _EID3336B6RawAttachment, _EID3336B6WorldDisplayRange, _EID3336B6DepthDisplayFar;
float _EID3336B6TextureMipBias, _EID3336B6ReconstructionFlipY, _EID3336B6FlipY;
float4x4 _EID3336B6ClipToWorld, _EID3336B6WorldToView;
float4 _EID3336B6CameraPositionWS, _EID3336B6ScreenSize, _EID3336B6OutputSize, _EID3336B6LightDirectionWS, _EID3336B6LightColor;
float _EID3336B6LightIntensity, _EID3336B6AmbientStrength, _EID3336B6DiffuseStrength, _EID3336B6SpecularStrength;
float _EID3336B6IndirectDiffuseStrength, _EID3336B6IndirectSpecularStrength;
float _EID3336B6ScreenSHWeight, _EID3336B6ScreenSpecularContributionWeight, _EID3336B6ProbeReflectionWeight, _EID3336B6CapturedVisibilityWeight;
float4 _EID3336B6IndirectScale, _EID3336B6IndirectOptions, _EID3336B6FallbackSHRed, _EID3336B6FallbackSHGreen, _EID3336B6FallbackSHBlue;
float4 _EID3336B6ProbeClusterGrid, _EID3336B6ProbeAtlasLayout, _EID3336B6ProbeDepthAndAtlasOffset, _EID3336B6FallbackProbeNormalPlane;
float4 _EID3336B6ReflectionMipParameters;
int4 _EID3336B6ClusterOffsets;

struct EID3336B6VSOut { float4 positionCS : SV_POSITION; };
EID3336B6VSOut EID3336B6VS(uint id : SV_VertexID)
{
    EID3336B6VSOut o; uint v = id % 3u;
    o.positionCS = v == 0 ? float4(-1,-1,0,1) : (v == 1 ? float4(3,-1,0,1) : float4(-1,3,0,1));
    return o;
}
float4 EID3336B6SampleRaw(int t, float2 uv)
{
    if (t == 0) return SAMPLE_TEXTURE2D(_EID3336B6RT0, sampler_EID3336B6RT0, uv);
    if (t == 1) return SAMPLE_TEXTURE2D(_EID3336B6RT1, sampler_EID3336B6RT1, uv);
    if (t == 2) return SAMPLE_TEXTURE2D(_EID3336B6RT2, sampler_EID3336B6RT2, uv);
    if (t == 3) return SAMPLE_TEXTURE2D(_EID3336B6RT3, sampler_EID3336B6RT3, uv);
    return SAMPLE_TEXTURE2D(_EID3336B6RT4, sampler_EID3336B6RT4, uv);
}
float3 EID3336B6DecodeOcta(float4 p)
{
    // The shader is shared by two attachment contracts.  The compile-time
    // _GBUFFER_NORMALS_OCT keyword belongs to the stock URP material variant
    // and cannot identify the source contract bound by the modified pipeline.
    if (_EID3336B6UseURPGBuffer > 0.5)
    {
        // Stock URP GBuffer2: PackNormal() writes either octa RGB (when the
        // keyword is enabled) or signed XYZ.  UnpackNormal() is its matching
        // decoder for both variants.
        return normalize((float3)UnpackNormal((half3)p.xyz));
    }

    // RenderDoc EID3336 RT3 (_15): octa normal.xy in [0,1], roughness.z,
    // material/category value.w.  Decode only xy; z/w are not normal data.
    float2 e = p.xy * 2.0 - 1.0;
    float3 n = float3(e.x, 1.0 - abs(e.x) - abs(e.y), e.y);
    if (n.y < 0.0)
    {
        float2 signValue = float2(
            n.x >= 0.0 ? 1.0 : -1.0,
            n.z >= 0.0 ? 1.0 : -1.0);
        n.xz = (1.0 - abs(n.zx)) * signValue;
    }
    return normalize(n);
}
float3 EID3336B6World(float2 uv, float depth)
{
    float2 ndc = uv * 2.0 - 1.0;
    if (_EID3336B6ReconstructionFlipY > 0.5) ndc.y = -ndc.y;
    float4 h = mul(_EID3336B6ClipToWorld, float4(ndc, depth, 1.0));
    return h.xyz / max(abs(h.w), 1e-6);
}
float3 EID3336B6CapturedIrradiance(float2 uv, float3 normalWS)
{
    float3 fallback = max(0.0.xxx, float3(
        dot(_EID3336B6FallbackSHRed.xyz, normalWS) + _EID3336B6FallbackSHRed.w,
        dot(_EID3336B6FallbackSHGreen.xyz, normalWS) + _EID3336B6FallbackSHGreen.w,
        dot(_EID3336B6FallbackSHBlue.xyz, normalWS) + _EID3336B6FallbackSHBlue.w));
    float4 encoded = SAMPLE_TEXTURE2D(_EID3336B6ScreenSH, sampler_EID3336B6ScreenSH, uv);
    float useScreen = step(0.0001, dot(abs(encoded), 1.0.xxxx));
    float screenBlend = useScreen * saturate(_EID3336B6ScreenSHWeight);
    float3 screenIrradiance = max(0.0.xxx, encoded.xxx + encoded.yzx * normalWS * 1.5);
    return lerp(fallback, screenIrradiance, screenBlend);
}
float3 EID3336B6Fresnel(float x, float3 f0)
{
    float y = 1.0 - saturate(x); float y5 = y*y*y*y*y;
    return f0 + (1.0 - f0) * y5;
}
float3 EID3336B6EnvBRDF(float ndv, float rough, float3 f0)
{
    float r2 = rough*rough, r3 = ndv*ndv*ndv;
    float a = dot(mul(float2(1,ndv), float2x2(float2(.0365463,9.0632), float2(3.32707,-9.04756))), float2(1,r2)) /
        max(dot(mul(float3(1,ndv*ndv,r3), float3x3(float3(1,9.04401,5.56589), float3(3.59685,-16.3174,19.7886), float3(-1.36772,9.22949,-20.2123))), float3(1,r2,r2*r2)), 1e-4);
    float b = dot(mul(float2(1,ndv), float2x2(float2(.99044,1.29678), float2(-1.28514,-.755907))), float2(1,r2)) /
        max(dot(mul(float3(1,ndv,r3), float3x3(float3(1,20.3225,121.563), float3(2.92338,-27.0302,626.13), float3(59.4188,222.592,316.627))), float3(1,r2,r2*r2)), 1e-4);
    return f0*a + b.xxx;
}
float3 EID3336B6OctaAtlasDirection(float3 directionWS)
{
    float3 d = normalize(directionWS);
    float3 signs = float3(d.x >= 0.0 ? 1.0 : -1.0, d.y >= 0.0 ? 1.0 : -1.0, d.z >= 0.0 ? 1.0 : -1.0);
    float3 o = d / max(dot(d, signs), 1e-5);
    if (o.z < 0.0)
    {
        float3 a = abs(o);
        float2 uv = signs.xy * float2(1.0 - a.y, 1.0 - a.x);
        return float3(uv.x, uv.y, o.z);
    }
    return o;
}
float3 EID3336B6SampleProbeAtlas(float3 directionWS, float slice, float mip)
{
    float3 atlasDir = EID3336B6OctaAtlasDirection(directionWS);
    float2 uv = ((atlasDir.xy * 0.5) + 0.5) * _EID3336B6ProbeAtlasLayout.w + _EID3336B6ProbeDepthAndAtlasOffset.ww;
    return SAMPLE_TEXTURE2D_ARRAY_LOD(_EID3336B6ReflectionAtlas, sampler_EID3336B6ReflectionAtlas, uv, slice, mip).rgb;
}
float4 EID3336B6ProbeRecord(uint index, uint element)
{
    return _EID3336B6ReflectionProbes[index * 8u + element];
}
float3 EID3336B6EvaluateProbes(float3 worldPositionWS, float3 normalWS, float3 reflectionWS, float linearDepth, float2 pixelFloat, float irradianceLuminance, float roughness, out float probeWeight)
{
    float2 probeTile = floor(pixelFloat * _EID3336B6ProbeClusterGrid.ww);
    probeTile = clamp(probeTile, 0.0.xx, _EID3336B6ProbeClusterGrid.xy - 1.0.xx);
    float rawDepthSlice = floor(linearDepth - _EID3336B6ProbeDepthAndAtlasOffset.y);
    float probeDepthSlice = clamp(rawDepthSlice, 0.0, _EID3336B6ProbeAtlasLayout.x - 1.0);
    uint mask = 0u;
    if (rawDepthSlice <= probeDepthSlice)
    {
        uint tileIndex = (uint)(_EID3336B6ClusterOffsets.z + (int)(probeTile.x + probeTile.y * _EID3336B6ProbeClusterGrid.x));
        uint depthIndex = (uint)(_EID3336B6ClusterOffsets.w + (int)probeDepthSlice);
        mask = _EID3336B6ClusterProbeMasks.Load(tileIndex * 4u) & _EID3336B6ClusterProbeMasks.Load(depthIndex * 4u);
    }
    float3 accumulated = 0.0.xxx;
    float remaining = 1.0;
    for (int pi = 0; pi < 32; ++pi)
    {
        uint bit = 1u << (uint)pi;
        if ((mask & bit) == 0u || remaining <= 0.01) continue;
        uint index = (uint)pi;
        float4 plane = EID3336B6ProbeRecord(index, 0);
        float4 extSlice = EID3336B6ProbeRecord(index, 1);
        float4 row0 = EID3336B6ProbeRecord(index, 2);
        float4 row1 = EID3336B6ProbeRecord(index, 3);
        float4 row2 = EID3336B6ProbeRecord(index, 4);
        float4 fadeIntensity = EID3336B6ProbeRecord(index, 5);
        float4 projectBlendWeight = EID3336B6ProbeRecord(index, 6);
        float4 posH = float4(worldPositionWS, 1.0);
        float3 probePositionH = float3(dot(row0, posH), dot(row1, posH), dot(row2, posH));
        float3 localAbs = abs(probePositionH);
        if (any(localAbs > extSlice.xyz)) continue;
        float3 absLocalPosition = extSlice.xyz * 0.1;
        float3 projectedDirection = localAbs * 0.1;
        float3 projectedDirectionAbs = projectedDirection * projectedDirection;
        float3 blendFactors = (extSlice.xyz - localAbs) * fadeIntensity.xyz;
        float3 sampleDirection = reflectionWS;
        if (projectBlendWeight.x == 1.0)
        {
            float3 blendDistance = float3(dot(row0.xyz, reflectionWS), dot(row1.xyz, reflectionWS), dot(row2.xyz, reflectionWS));
            float3 negT = (-extSlice.xyz - probePositionH) / blendDistance;
            float3 posT = ( extSlice.xyz - probePositionH) / blendDistance;
            bool3 positive = blendDistance > 0.0.xxx;
            float3 boxT = float3(positive.x ? posT.x : negT.x, positive.y ? posT.y : negT.y, positive.z ? posT.z : negT.z);
            sampleDirection = probePositionH + blendDistance * min(boxT.x, min(boxT.y, boxT.z));
        }
        float planeTerm = max(1e-4, max(0.0, dot(plane, float4(normalWS, 1.0))));
        float blendWeight = clamp((min(blendFactors.x, min(blendFactors.y, blendFactors.z)) * projectBlendWeight.y) +
            (((((absLocalPosition * absLocalPosition).x - ((projectedDirectionAbs.x + projectedDirectionAbs.y) + projectedDirectionAbs.z)) * fadeIntensity.x) * fadeIntensity.x) * (1.0 - projectBlendWeight.y) * 100.0), 0.0, 1.0) * projectBlendWeight.w;
        float3 radiance = EID3336B6SampleProbeAtlas(sampleDirection, extSlice.w, _EID3336B6ReflectionMipParameters.x - 1.0 - (1.0 - 1.2 * log2(max(0.001, roughness))));
        radiance *= fadeIntensity.w;
        radiance *= (((clamp(abs(irradianceLuminance / planeTerm), 0.0, 1.0) * 2.0 + irradianceLuminance) / (2.0 + planeTerm) - 1.0) * _EID3336B6IndirectOptions.w + 1.0);
        accumulated += radiance * blendWeight * remaining;
        remaining *= 1.0 - blendWeight;
        mask &= ~bit;
    }
    if (remaining > 0.01)
    {
        float planeTerm = max(1e-4, max(0.0, dot(_EID3336B6FallbackProbeNormalPlane, float4(normalWS, 1.0))));
        float3 fallback = EID3336B6SampleProbeAtlas(reflectionWS, 0.0, _EID3336B6ReflectionMipParameters.x - 1.0 - (1.0 - 1.2 * log2(max(0.001, roughness))));
        fallback *= (((clamp(abs(irradianceLuminance / planeTerm), 0.0, 1.0) * 2.0 + irradianceLuminance) / (2.0 + planeTerm) - 1.0) * _EID3336B6IndirectOptions.w + 1.0);
        accumulated += fallback * remaining;
    }
    probeWeight = saturate(1.0 - remaining);
    return accumulated;
}
float4 EID3336B6PS(EID3336B6VSOut i) : SV_Target0
{
    float2 uv = i.positionCS.xy * _EID3336B6OutputSize.zw;
    if (_EID3336B6FlipY > 0.5) uv.y = 1.0 - uv.y;
    float4 mat = EID3336B6SampleRaw((int)round(_EID3336B6MaterialTarget), uv);
    float4 pn = EID3336B6SampleRaw((int)round(_EID3336B6NormalTarget), uv);
    float4 bc = EID3336B6SampleRaw((int)round(_EID3336B6BaseColorTarget), uv);
    float depth = SAMPLE_TEXTURE2D(_EID3336B6Depth, sampler_EID3336B6Depth, uv).r;
    float3 base = saturate(bc.rgb), n = EID3336B6DecodeOcta(pn), wp = EID3336B6World(uv, depth);
    float3 camRel = wp - _EID3336B6CameraPositionWS.xyz;
    float linearDepth = abs(mul(_EID3336B6WorldToView, float4(wp, 1.0)).z);
    float metallic = (_EID3336B6UseURPGBuffer > 0.5) ? saturate(mat.g) : saturate(mat.x);
    float ao = (_EID3336B6UseURPGBuffer > 0.5) ? saturate(mat.a) : saturate(mat.y);
    float rough = (_EID3336B6UseURPGBuffer > 0.5) ? saturate(1.0 - pn.a) : saturate(pn.z);
    float3 v = normalize(_EID3336B6CameraPositionWS.xyz - wp), l = normalize(_EID3336B6LightDirectionWS.xyz), h = normalize(l + v);
    float ndl = saturate(dot(n,l)), ndv = saturate(dot(n,v)), ndh = saturate(dot(n,h)), vdh = saturate(dot(v,h));
    float3 f0 = lerp(.04.xxx, base, metallic), fres = EID3336B6Fresnel(vdh, f0);
    float a = max(rough*rough, .002), a2 = a*a, d = max(ndh*ndh*(a2-1)+1, 1e-4), D = a2/(PI*d*d);
    float k = (rough+1)*(rough+1)*.125, G = (ndv/max(ndv*(1-k)+k,1e-4))*(ndl/max(ndl*(1-k)+k,1e-4));
    float3 radiance = _EID3336B6LightColor.rgb * _EID3336B6LightIntensity;
    float3 directDiff = base*(1-metallic)/PI*radiance*ndl*_EID3336B6DiffuseStrength;
    float3 directSpec = D*G*fres/max(4*ndv*ndl,1e-4)*radiance*ndl*_EID3336B6SpecularStrength;
    float3 ambient = base*(1-metallic)/PI*_EID3336B6AmbientStrength*ao;
    float3 irr = EID3336B6CapturedIrradiance(uv,n), diffuseColor = base*(1-metallic);
    float aoTerm = ao; if (_EID3336B6IndirectOptions.x != 0) aoTerm = min(ao, SAMPLE_TEXTURE2D(_EID3336B6SSAO, sampler_EID3336B6SSAO, uv).r);
    float3 indirectDiff = irr*diffuseColor*_EID3336B6IndirectScale.x*aoTerm*_EID3336B6IndirectDiffuseStrength;
    float3 reflectionWS = reflect(normalize(wp - _EID3336B6CameraPositionWS.xyz), n);
    float roughMip = (_EID3336B6ReflectionMipParameters.x - 1.0) - (1.0 - 1.2 * log2(max(rough, 0.001)));
    float3 screenSpec = SAMPLE_TEXTURE2D(_EID3336B6ScreenSpecularColor, sampler_EID3336B6ScreenSpecularColor, uv).rgb;
    float screenWeight = SAMPLE_TEXTURE2D(_EID3336B6ScreenSpecularWeight, sampler_EID3336B6ScreenSpecularWeight, uv).r;
    screenWeight = saturate(screenWeight * _EID3336B6ScreenSpecularContributionWeight);
    float validity = SAMPLE_TEXTURE2D(_EID3336B6ReflectionValidity, sampler_EID3336B6ReflectionValidity, uv).r;
    float visibility = min(SAMPLE_TEXTURE2D(_EID3336B6ReflectionVisibility, sampler_EID3336B6ReflectionVisibility, uv).r, 1.0);
    float envEnergy = dot(f0, 0.333333.xxx);
    float irradianceLuminance = dot(irr, float3(0.2126729,0.7151522,0.0721750));
    float probeWeight; float3 probeRadiance = EID3336B6EvaluateProbes(wp, n, reflectionWS, linearDepth, uv * _EID3336B6ScreenSize.xy, irradianceLuminance, rough, probeWeight);
    float3 probeSpec = probeRadiance * _EID3336B6IndirectOptions.z * _EID3336B6IndirectScale.y * saturate(_EID3336B6ProbeReflectionWeight);
    float3 blendedSpec = (_EID3336B6IndirectOptions.y != 0.0) ? (screenSpec * screenWeight + probeSpec * (1.0 - screenWeight)) : probeSpec;
    float3 env = EID3336B6EnvBRDF(ndv, rough, f0);
    float reflOcc = ao; if (_EID3336B6IndirectOptions.x != 0) reflOcc = saturate(pow(abs(ndv+ao), exp2(-16*rough-1))-1+ao);
    float capturedVisibility = lerp(1.0, validity * visibility, saturate(_EID3336B6CapturedVisibilityWeight));
    float3 indirectSpec = blendedSpec * (env + (f0*((1.0-envEnergy)/max(envEnergy,1e-4))*env)) * capturedVisibility * _EID3336B6IndirectSpecularStrength * reflOcc;
    int mode = clamp((int)round(_EID3336B6ViewMode), 0, 19); float3 output;
    if (mode == 0) output = ambient + directDiff + directSpec + indirectDiff + indirectSpec;
    else if (mode == 1) output = ambient + directDiff + directSpec;
    else if (mode == 2) output = indirectDiff;
    else if (mode == 3) output = indirectSpec;
    else if (mode == 4) output = directDiff + directSpec + indirectDiff + indirectSpec;
    else if (mode == 5) output = saturate((base*(1-metallic)/PI + env)*2);
    else if (mode == 6) output = base;
    else if (mode == 7) output = n*.5 + .5;
    else if (mode == 8) output = saturate(camRel/max(_EID3336B6WorldDisplayRange,1e-3)*.5+.5);
    else if (mode == 9) output = float3(metallic,rough,ao);
    else if (mode == 10) output = saturate(linearDepth/max(_EID3336B6DepthDisplayFar,1e-3)).xxx;
    else if (mode == 11) output = probeSpec;
    else if (mode == 12) output = screenSpec * screenWeight;
    else if (mode == 13) output = indirectDiff + indirectSpec;
    else if (mode == 14) output = probeWeight.xxx;
    else if (mode == 15) output = validity.xxx;
    else if (mode == 16) output = EID3336B6SampleRaw(0, uv).rgb;
    else if (mode == 17) output = EID3336B6SampleRaw(1, uv).rgb;
    else if (mode == 18) output = EID3336B6SampleRaw(2, uv).rgb;
    else if (mode == 19) output = EID3336B6SampleRaw(3, uv).rgb;
    else output = validity.xxx;
    if (depth <= 1e-5 || depth >= .99999) output *= .25;
    return float4(saturate(output), 1);
}
#endif










