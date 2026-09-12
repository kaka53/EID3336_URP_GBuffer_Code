Shader "EID3899/URP/TerrainGBufferPS210085" {
 Properties {
        _28_m0 ("uniforms28 member 0", Float) = 1
        _28_m1 ("uniforms28 member 1", Float) = 1
        _28_m2 ("uniforms28 member 2", Float) = 0
        _28_m3 ("uniforms28 member 3", Float) = 0
        _28_m4 ("uniforms28 member 4", Float) = 0
        _28_m5 ("uniforms28 member 5", Float) = 0
        _28_m6 ("uniforms28 member 6", Float) = 0
        _28_m7 ("uniforms28 member 7", Float) = 0
        _28_m8 ("uniforms28 member 8", Float) = 50
        _28_m9 ("uniforms28 member 9", Float) = 0
        _28_m10 ("uniforms28 member 10", Float) = 0
        _28_m11 ("uniforms28 member 11", Float) = 0
        _28_m12 ("uniforms28 member 12", Float) = 1
        _28_m13 ("uniforms28 member 13", Float) = 2000
        _28_m14 ("uniforms28 member 14", Float) = 3.3599999
        _28_m15 ("uniforms28 member 15", Float) = 1.20000005
        _28_m16 ("uniforms28 member 16", Float) = 0
        _28_m17 ("uniforms28 member 17", Float) = -0.107999474
        _28_m18 ("uniforms28 member 18", Float) = 0
        _28_m19 ("uniforms28 member 19", Float) = 1
        _28_m20 ("uniforms28 member 20", Vector) = (1,0,0,0)
        _28_m21 ("uniforms28 member 21", Vector) = (0.200000003,-0.200000003,5,0)
        _28_m22 ("uniforms28 member 22", Vector) = (0,1,0,1)
        _28_m23 ("uniforms28 member 23", Vector) = (1.39999998,0.449999988,0,0)
        _28_m24 ("uniforms28 member 24", Vector) = (-0.00400000019,0,0,0)
        _28_m25 ("uniforms28 member 25", Vector) = (1,0.110978186,0.00477695232,1)
        _28_m26 ("uniforms28 member 26", Float) = 0
        _28_m27 ("uniforms28 member 27", Float) = 0
        _28_m28 ("uniforms28 member 28", Float) = 0
        _28_m29 ("uniforms28 member 29", Float) = 0
        _28_m30 ("uniforms28 member 30", Float) = 1
        _28_m31 ("uniforms28 member 31", Float) = 0.5
        _28_m32 ("uniforms28 member 32", Vector) = (0,0,0,0)
        _28_m33 ("uniforms28 member 33", Vector) = (1,1,0,0)
        [NoScaleOffset] _29 ("PS210085 texture 29", 2D) = "" {}
        [NoScaleOffset] _30 ("PS210085 texture 30", 2D) = "" {}
        [NoScaleOffset] _31 ("PS210085 texture 31", 2D) = "" {}
        [NoScaleOffset] _32 ("PS210085 texture 32", 2D) = "" {}
        [NoScaleOffset] _33 ("PS210085 texture 33", 2D) = "" {}
        [NoScaleOffset] _34 ("PS210085 texture 34", 2DArray) = "" {}
        [NoScaleOffset] _35 ("PS210085 texture 35", 2DArray) = "" {}
        [NoScaleOffset] _36 ("PS210085 texture 36", 2D) = "" {}
        [NoScaleOffset] _37 ("PS210085 texture 37", 2D) = "" {}
        [NoScaleOffset] _38 ("PS210085 texture 38", 2D) = "" {}
        [NoScaleOffset] _39 ("PS210085 texture 39", 2D) = "" {}
        [NoScaleOffset] _40 ("PS210085 texture 40", 2D) = "" {}
        [NoScaleOffset] _41 ("PS210085 texture 41", 2D) = "" {}
 [Toggle] _EID3899CapturedCameraParameters ("Capture camera shading parameters (0 = live)",Float) = 0
 }
 SubShader {
 Tags {"RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry"}
 Pass {
 Name "EID3899_Terrain_UniversalGBuffer"
 Tags {"LightMode"="UniversalGBuffer" "UniversalMaterialType"="Lit"}
 Cull Off ZWrite On ZTest LEqual Blend Off
 Stencil { Ref 32 Comp Always Pass Replace ReadMask 96 WriteMask 96 }
 HLSLPROGRAM
 #pragma target 5.0
 #pragma exclude_renderers gles gles3 glcore
 #pragma vertex EID3899Vertex
 #pragma fragment EID3899Fragment
 #include "EID3899TerrainPixel.hlsl"
 ENDHLSL
 }
 }
}
