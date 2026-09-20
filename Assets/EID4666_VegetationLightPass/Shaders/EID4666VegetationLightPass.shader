Shader "Hidden/EID4666/VegetationLightPass"
{
    Properties
    {
        [HideInInspector] _17 ("Scene Depth", 2D) = "black" {}
        [HideInInspector] _18 ("Screen Specular Color", 2D) = "black" {}
        [HideInInspector] _19 ("Screen Specular Weight", 2D) = "black" {}
        [HideInInspector] _20 ("SSAO", 2D) = "white" {}
        [HideInInspector] _21 ("Reflection Atlas", 2DArray) = "black" {}
        [HideInInspector] _29 ("Reflection Validity", 2D) = "black" {}
        [HideInInspector] _30 ("Reflection Tint LUT", 2D) = "white" {}
        [HideInInspector] _32 ("BRDF LUT", 2D) = "white" {}
        [HideInInspector] _33 ("Reflection Visibility", 2D) = "white" {}
        [HideInInspector] _34 ("Volumetric Fog", 3D) = "black" {}
        [HideInInspector] _37 ("SH Decode LUT", 2D) = "white" {}
        [HideInInspector] _38 ("Screen SH", 2D) = "black" {}
        [HideInInspector] _39 ("Irradiance Data 0", 3D) = "black" {}
        [HideInInspector] _40 ("Irradiance Weight 0", 3D) = "black" {}
        [HideInInspector] _41 ("Irradiance Data 1", 3D) = "black" {}
        [HideInInspector] _42 ("Irradiance Weight 1", 3D) = "black" {}
        [HideInInspector] _43 ("Irradiance Data 2", 3D) = "black" {}
        [HideInInspector] _44 ("Irradiance Weight 2", 3D) = "black" {}
        [HideInInspector] _46 ("GBuffer Material", 2D) = "black" {}
        [HideInInspector] _47 ("GBuffer Normal", 2D) = "black" {}
        [HideInInspector] _48 ("GBuffer Base Color", 2D) = "black" {}
        [HideInInspector] _EID4666UseLiveCamera ("EID4666 Use Live Camera", Float) = 1
        [HideInInspector] _EID4666ReversedZ ("EID4666 Reversed Z", Float) = 0
        [HideInInspector] _EID4666DepthEpsilon ("EID4666 Depth Epsilon", Float) = 0.00001
        [HideInInspector] _EID4666ScreenSize ("EID4666 Screen Size", Vector) = (1,1,1,1)
        [HideInInspector] _EID4666CameraPositionWS ("EID4666 Camera Position", Vector) = (0,0,0,1)
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "Queue"="Overlay" }
        Pass
        {
            Name "EID4666_Vegetation_Deferred_LightPass"
            Cull Off
            ZWrite Off
            ZTest Always
            Blend One SrcAlpha
            ColorMask RGBA
            Stencil
            {
                Ref 1
                Comp Equal
                ReadMask 7
                WriteMask 0
                Pass Keep
            }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma vertex EID4666Vertex
            #pragma fragment EID4666Fragment
            #include "EID4666VegetationFS.hlsl"

            float _EID4666ReversedZ;
            float _EID4666DepthEpsilon;

            struct EID4666VertexOut
            {
                float2 uv : TEXCOORD0;
                float4 positionCS : SV_POSITION;
            };

            EID4666VertexOut EID4666Vertex(uint vertexID : SV_VertexID)
            {
                EID4666VertexOut o;
                float2 p = float2((float)((vertexID << 1u) & 2u), (float)(vertexID & 2u));
                float2 ndc = p * 2.0 - 1.0;
                o.positionCS = float4(ndc.x, -ndc.y, 0.0, 1.0);
                o.uv = float2(p.x, 1.0 - p.y);
                return o;
            }

            float4 EID4666Fragment(EID4666VertexOut input) : SV_Target0
            {
                int2 pixel = int2(input.positionCS.xy);
                float depth = _17.Load(int3(pixel, 0)).x;
                float validDepth = (_EID4666ReversedZ > 0.5)
                    ? step(_EID4666DepthEpsilon, depth)
                    : step(depth, 1.0 - _EID4666DepthEpsilon);
                clip(validDepth - 0.5);

                EID_FS_Input fsInput;
                fsInput._4 = input.uv;
                fsInput.gl_FragCoord = input.positionCS;
                return EID_OriginalFS(fsInput)._5;
            }
            ENDHLSL
        }
    }
    Fallback Off
}
