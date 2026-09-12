Shader "Hidden/EID3332Combined/Deferred/EID4662Full"
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
        [HideInInspector] _45 ("Material Mask", 2D) = "black" {}
        [HideInInspector] _46 ("GBuffer Material", 2D) = "black" {}
        [HideInInspector] _47 ("GBuffer Normal", 2D) = "black" {}
        [HideInInspector] _48 ("GBuffer Base Color", 2D) = "black" {}
        [HideInInspector] _EID4662EnableFullModules ("Enable Full EID4662 Modules", Float) = 1
        [HideInInspector] _EID4662OutputAlpha ("EID4662 Output Alpha", Float) = 1
        [HideInInspector] _EID4662OutputSize ("EID4662 Output Size", Vector) = (1,1,1,1)
        [HideInInspector] _EID4662UseLiveCamera ("EID4662 Use Live Camera", Float) = 1
        [HideInInspector] _EID4662PreserveDestination ("EID4662 Preserve Destination", Float) = 0
        [HideInInspector] _EID4662ReversedZ ("EID4662 Reversed Z", Float) = 0
        [HideInInspector] _EID4662DepthEpsilon ("EID4662 Depth Epsilon", Float) = 0.00001
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "Queue"="Overlay" }
        Pass
        {
            Name "EID4662_Full_Deferred_LightPass_Live"
            Cull Off
            ZWrite Off
            ZTest Always
            Blend One Zero
            ColorMask RGBA
            HLSLPROGRAM
            #pragma target 5.0
            #pragma vertex EID4662FullVertex
            #pragma fragment EID4662FullFragment
            #include "EID4662FullFS.hlsl"

            float4 _EID4662OutputSize;
            float _EID4662ReversedZ;
            float _EID4662DepthEpsilon;

            struct EID4662FullVertexOut
            {
                float2 uv : TEXCOORD0;
                float4 positionCS : SV_POSITION;
            };

            EID4662FullVertexOut EID4662FullVertex(uint vertexID : SV_VertexID)
            {
                EID4662FullVertexOut o;
                float2 p = float2((float)((vertexID << 1u) & 2u), (float)(vertexID & 2u));
                float2 ndc = p * 2.0 - 1.0;
                o.positionCS = float4(ndc.x, -ndc.y, 0.0, 1.0);
                o.uv = float2(p.x, 1.0 - p.y);
                return o;
            }

            float4 EID4662FullFragment(EID4662FullVertexOut input) : SV_Target0
            {
                // The original FS uses Load() with gl_FragCoord. Reject the
                // cleared background before invoking it; otherwise invalid
                // depth is decoded as scene geometry and writes the whole
                // SceneView.
                int2 pixel = int2(input.positionCS.xy);
                float depth = _17.Load(int3(pixel, 0)).x;
                float validDepth = (_EID4662ReversedZ > 0.5)
                    ? step(_EID4662DepthEpsilon, depth)
                    : step(depth, 1.0 - _EID4662DepthEpsilon);
                clip(validDepth - 0.5);

                EID_FS_Input fsInput;
                fsInput._4 = input.uv;
                // SV_Position is the rasterized pixel position here. Do not
                // substitute clip-space vertex coordinates for it.
                fsInput.gl_FragCoord = input.positionCS;
                return EID_OriginalFS(fsInput)._5;
            }
            ENDHLSL
        }
        Pass
        {
            Name "EID4662_Full_Deferred_LightPass_CapturedBlend"
            Cull Off
            ZWrite Off
            ZTest Always
            Blend One SrcAlpha
            ColorMask RGBA
            HLSLPROGRAM
            #pragma target 5.0
            #pragma vertex EID4662FullVertex
            #pragma fragment EID4662FullFragment
            #include "EID4662FullFS.hlsl"

            float4 _EID4662OutputSize;
            float _EID4662ReversedZ;
            float _EID4662DepthEpsilon;

            struct EID4662FullVertexOut
            {
                float2 uv : TEXCOORD0;
                float4 positionCS : SV_POSITION;
            };

            EID4662FullVertexOut EID4662FullVertex(uint vertexID : SV_VertexID)
            {
                EID4662FullVertexOut o;
                float2 p = float2((float)((vertexID << 1u) & 2u), (float)(vertexID & 2u));
                float2 ndc = p * 2.0 - 1.0;
                o.positionCS = float4(ndc.x, -ndc.y, 0.0, 1.0);
                o.uv = float2(p.x, 1.0 - p.y);
                return o;
            }

            float4 EID4662FullFragment(EID4662FullVertexOut input) : SV_Target0
            {
                // The original FS uses Load() with gl_FragCoord. Reject the
                // cleared background before invoking it; otherwise invalid
                // depth is decoded as scene geometry and writes the whole
                // SceneView.
                int2 pixel = int2(input.positionCS.xy);
                float depth = _17.Load(int3(pixel, 0)).x;
                float validDepth = (_EID4662ReversedZ > 0.5)
                    ? step(_EID4662DepthEpsilon, depth)
                    : step(depth, 1.0 - _EID4662DepthEpsilon);
                clip(validDepth - 0.5);

                EID_FS_Input fsInput;
                fsInput._4 = input.uv;
                // SV_Position is the rasterized pixel position here. Do not
                // substitute clip-space vertex coordinates for it.
                fsInput.gl_FragCoord = input.positionCS;
                return EID_OriginalFS(fsInput)._5;
            }
            ENDHLSL
        }
    }
    Fallback Off
}

