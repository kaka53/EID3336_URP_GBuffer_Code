#ifndef EID3863_CAPTURED_CONSTANTS_INCLUDED
#define EID3863_CAPTURED_CONSTANTS_INCLUDED

// RenderDoc EID3863 fixed-frame constants actually referenced by VS215851/PS215852.
// Camera matrices and object transforms are deliberately supplied by Unity/URP elsewhere.
#define _21_m4 (0.0)
#define EID3863_RD_CAMERA_RIGHT_Y (0.175364375)
#define EID3863_RD_CAMERA_FORWARD_Y (-0.0616408251)

static const float4 EID3863_25_m25 = float4(1.5, 16.5773296, 5.96046448e-08, 0.99999994);
#define _25_m25 EID3863_25_m25
static const float4 EID3863_25_m26 = float4(-9.88085844e-07, -16.5773296, -9.87966587e-07, -16.5753288);
#define _25_m26 EID3863_25_m26
static const float4 EID3863_25_m31 = float4(1.79999995, 1.65999997, 1.65999997, 0.0);
#define _25_m31 EID3863_25_m31
static const float4 EID3863_25_m36 = float4(1.0, 0.0, 0.0, 0.0);
#define _25_m36 EID3863_25_m36
static const float4 EID3863_25_m37 = float4(1.5, 16.5753288, 5.96046448e-08, 0.99999994);
#define _25_m37 EID3863_25_m37
static const float4 EID3863_25_m41 = float4(-556.875, 105.733459, -412.25, 0.0);
#define _25_m41 EID3863_25_m41
static const float4 EID3863_25_m42 = float4(-556.875, 105.733459, -412.25, 0.0);
#define _25_m42 EID3863_25_m42
static const float4 EID3863_25_m131 = float4(32.0, 512.0, 1.0, 0.0);
#define _25_m131 EID3863_25_m131
static const float4 EID3863_25_m132 = float4(-556.875, -412.25, -556.875, -412.25);
#define _25_m132 EID3863_25_m132
static const float4 EID3863_25_m32[4] = {
    float4(0.0, 0.0, 0.0, 40.0),
    float4(0.0, 0.0, 0.0, 0.0),
    float4(0.0, 0.0, 0.0, 0.0),
    float4(0.0, 0.0, 0.0, 0.0)
};
#define _25_m32 EID3863_25_m32
static const float4 EID3863_25_m33[4] = {
    float4(0.0, 0.0, 0.0, 0.0),
    float4(0.0, 0.0, 0.0, 0.0),
    float4(0.0, 0.0, 0.0, 0.0),
    float4(0.0, 0.0, 0.0, 0.0)
};
#define _25_m33 EID3863_25_m33
static const float4 EID3863_25_m34[4] = {
    float4(0.0, 1.0, 0.0, 0.0),
    float4(0.0, 0.0, 0.0, 0.0),
    float4(0.0, 0.0, 0.0, 0.0),
    float4(0.0, 0.0, 0.0, 0.0)
};
#define _25_m34 EID3863_25_m34
static const float4 EID3863_25_m35[4] = {
    float4(1.0, 0.0266666636, 0.0, 0.0),
    float4(0.0, 0.0, 0.0, 0.0),
    float4(0.0, 0.0, 0.0, 0.0),
    float4(0.0, 0.0, 0.0, 0.0)
};
#define _25_m35 EID3863_25_m35
static const float4 EID3863_25_m39[4] = {
    float4(0.0, 0.0, 0.0, 0.0),
    float4(0.0, 0.0, 0.0, 0.0),
    float4(0.0, 0.0, 0.0, 0.0),
    float4(0.0, 0.0, 0.0, 0.0)
};
#define _25_m39 EID3863_25_m39
static const float4 EID3863_25_m40[4] = {
    float4(1.0, 0.0266666636, 0.0, 0.0),
    float4(0.0, 0.0, 0.0, 0.0),
    float4(0.0, 0.0, 0.0, 0.0),
    float4(0.0, 0.0, 0.0, 0.0)
};
#define _25_m40 EID3863_25_m40

CBUFFER_START(UnityPerMaterial)
    float _EID3863NormalStrength;
    float _EID3863DoubleSidedNormal;
    float _EID3863NormalFlatten;
    float _EID3863MaterialClass;
    float _EID3863PackedNormalWeight;
    float _EID3863RoughnessMin;
    float _EID3863RoughnessMax;
    float _EID3863NormalMaskWeight;
    float _EID3863RoughnessMaskWeight;
    float _EID3863BaseColorReplaceWeight;
    float _EID3863BaseColorMultiplier;
    float _EID3863AlphaCutoff;
    float4 _EID3863BaseColorTint;
    float4 _EID3863OpacityDistanceParams;
    float4 _EID3863MaterialDistanceParams;
    float4 _EID215851Wind0;
    float4 _EID215851Wind1;
    float4 _EID215851Wind2;
    float _StencilRef;
CBUFFER_END

#define _39_m6 _EID215851Wind0.x
#define _39_m16 _EID215851Wind0.y
#define _39_m17 _EID215851Wind0.z
#define _39_m19 _EID215851Wind0.w
#define _39_m24 _EID215851Wind1.x
#define _39_m25 _EID215851Wind1.y
#define _39_m27 _EID215851Wind1.z
#define _39_m28 _EID215851Wind1.w
#define _39_m29 _EID215851Wind2.x
#define _39_m30 _EID215851Wind2.y
#define _39_m31 _EID215851Wind2.z

#endif
