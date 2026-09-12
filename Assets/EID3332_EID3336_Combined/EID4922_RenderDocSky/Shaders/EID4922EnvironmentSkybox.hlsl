// Native Unity Skybox wrapper around the captured EID4922 fragment algorithm.
// The URP DrawSkyboxPass supplies the skybox geometry and camera matrices. The
// binder supplies only the captured resources, camera-to-world rotation, and the
// RenderDoc atmospheric radius.
#include "EID4922Sky.hlsl"

float4x4 _EID4922EnvironmentMVP;
float4x4 _EID4922EnvironmentCameraToWorld;
float _EID4922EnvironmentMeshRadius;

struct EID4922EnvironmentVertexInput
{
    float3 positionOS : POSITION;
};

struct EID4922EnvironmentVaryings
{
    float4 positionCS : SV_Position;
    float3 worldPos : TEXCOORD0;
    float3 screenPos : TEXCOORD2;
    float3 previousScreenPos : TEXCOORD3;
};

EID4922EnvironmentVaryings EID4922EnvironmentVertexMain(EID4922EnvironmentVertexInput input)
{
    EID4922EnvironmentVaryings o;
    float3 directionVS = normalize(input.positionOS);
    float3 directionWS = normalize(mul((float3x3)_EID4922EnvironmentCameraToWorld, directionVS));

    // The binder supplies a camera-relative MVP every frame. Do not use
    // UNITY_MATRIX_VP here: this pass is intentionally independent of the
    // renderer feature/global matrix state.
    float4 positionCS = mul(_EID4922EnvironmentMVP, float4(input.positionOS, 1.0f));
    positionCS.z = (_EID4922SceneDepthReversedZ > 0.5f) ? 0.0f : positionCS.w;

    o.positionCS = positionCS;
    o.worldPos = _EID4922RealtimeCameraPositionWS.xyz + directionWS * _EID4922SkyRadius;
    o.screenPos = positionCS.xyw;
    o.previousScreenPos = positionCS.xyw;
    return o;
}

float4 EID4922EnvironmentPixelMain(EID4922EnvironmentVaryings input) : SV_Target0
{
    // The native DrawSkyboxPass can be backed by a depth attachment that is not
    // the custom five-MRT depth resource. Use the exact depth resource published
    // by DeferredLights, so scene geometry always wins over the sky.
    if (_EID4922SceneDepthAvailable > 0.5f)
    {
        uint depthWidth, depthHeight;
        _EID4922SceneDepth.GetDimensions(depthWidth, depthHeight);
        int2 pixel = int2(input.positionCS.xy);
        int2 maxPixel = max(int2(0, 0), int2((int)depthWidth - 1, (int)depthHeight - 1));
        pixel = clamp(pixel, int2(0, 0), maxPixel);
        float sceneDepth = _EID4922SceneDepth.Load(int3(pixel, 0)).r;
        float validSceneDepth = (_EID4922SceneDepthReversedZ > 0.5f)
            ? step(_EID4922SceneDepthEpsilon, sceneDepth)
            : step(sceneDepth, 1.0f - _EID4922SceneDepthEpsilon);
        clip(validSceneDepth - 0.5f);
    }

    gl_FragCoord = input.positionCS;
    gl_FragCoord.w = 1.0 / max(input.positionCS.w, 1e-6);
    ps_in0 = input.worldPos;
    ps_in2 = input.screenPos;
    ps_in3 = input.previousScreenPos;
    frag_main();
    return ps_out0;
}

