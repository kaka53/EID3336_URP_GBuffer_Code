#ifndef EID215839_CAPTURED_CONSTANTS_INCLUDED
#define EID215839_CAPTURED_CONSTANTS_INCLUDED

static const float4 EID215839_25_m131 = float4(32.0, 512.0, 1.0, 0.0);
#define _25_m131 EID215839_25_m131
static const float4 EID215839_25_m132 = float4(-556.875, -412.25, -556.875, -412.25);
#define _25_m132 EID215839_25_m132

CBUFFER_START(UnityPerMaterial)
    float _EID3863NormalStrength;
    float _EID3863DoubleSidedNormal;
    float _EID3863MaterialClass;
    float _EID3863PackedNormalWeight;
    float _EID3863NormalMaskWeight;
    float _EID3863RoughnessMaskWeight;
    float _EID3863BaseColorReplaceWeight;
    float _EID3863BaseColorMultiplier;
    float4 _EID3863BaseColorTint;
    float4 _EID3863OpacityDistanceParams;
    float4 _EID3863MaterialDistanceParams;
    float _EID215839Billboard;
    float _StencilRef;
CBUFFER_END

#endif
