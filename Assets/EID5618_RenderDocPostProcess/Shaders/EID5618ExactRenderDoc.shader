Shader "Hidden/EID5618/ExactRenderDoc"
{
    Properties
    {
        [HideInInspector] _EID5618Res9 ("EID5618 res9", 2D) = "black" {}
        [HideInInspector] _EID5618Res10 ("EID5618 res10", 2D) = "black" {}
        [HideInInspector] _EID5618Res11 ("EID5618 res11", 2D) = "black" {}
        [HideInInspector] _EID5618ExactRT ("EID5618 encoded intermediate", 2D) = "black" {}
        [HideInInspector] _EID5618LinearDisplay ("Decode encoded sRGB into linear camera", Float) = 1
        [HideInInspector] _EID5618DebugMode ("EID5618 debug output mode", Float) = 0
        [HideInInspector] _EID5618DebugScale ("EID5618 debug HDR display scale", Float) = 1
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "Queue"="Overlay" }
        Pass
        {
            Name "EID5618_Exact_RenderDoc_FS"
            ZTest Always
            ZWrite Off
            Cull Off
            Blend One Zero
            ColorMask RGBA
            HLSLPROGRAM
            #pragma target 4.5
            #pragma vertex EID5618Vertex
            #pragma fragment EID5618ExactFragment
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            cbuffer _7_uniforms7 : register(b4)
            {
                float4 _7_raw[2];
            };
            #define _7_m1 _7_raw[0].y
            #define _7_m2 _7_raw[0].z

            #include "EID5618ExactFS.hlsl"

            float _EID5618DebugMode;
            float _EID5618DebugScale;

            struct EID5618Attributes { uint vertexID : SV_VertexID; };
            struct EID5618Varyings { float4 positionCS : SV_POSITION; float2 uv : TEXCOORD0; };

            EID5618Varyings EID5618Vertex(EID5618Attributes input)
            {
                EID5618Varyings output;
                float2 uv = float2((input.vertexID << 1) & 2, input.vertexID & 2);
                output.positionCS = float4(uv * 2.0 - 1.0, 0.0, 1.0);
            #if UNITY_UV_STARTS_AT_TOP
                uv.y = 1.0 - uv.y;
            #endif
                output.uv = uv;
                return output;
            }

            float4 EID5618ExactFragment(EID5618Varyings input) : SV_Target0
            {
                SPIRV_Cross_Input capturedInput;
                capturedInput._3 = input.uv;
                SPIRV_Cross_Output capturedOutput = main(capturedInput);
                float4 res9Sample = EID5618_SAMPLE_RES9(input.uv, 0.0f);
                float4 res10Sample = EID5618_SAMPLE_RES10(input.uv, 0.0f);
                float4 res11Sample = EID5618_SAMPLE_RES11(input.uv, 0.0f);
                float3 outputRgb = capturedOutput._4.rgb;
                float outputAlpha = capturedOutput._4.a;
                int debugMode = (int)round(_EID5618DebugMode);
                float debugScale = max(_EID5618DebugScale, 1e-5f);
                if (debugMode == 1)
                {
                    outputRgb = abs(res9Sample.rgb) / (debugScale + abs(res9Sample.rgb));
                    outputAlpha = saturate(res9Sample.a);
                }
                else if (debugMode == 2)
                {
                    outputRgb = abs(res10Sample.rgb) / (debugScale + abs(res10Sample.rgb));
                    outputAlpha = saturate(res10Sample.a);
                }
                else if (debugMode == 3)
                {
                    outputRgb = saturate(res11Sample.rgb / debugScale);
                    outputAlpha = saturate(res11Sample.a);
                }
                else if (debugMode == 10)
                {
                    outputRgb = float3(input.uv, 0.0f);
                    outputAlpha = 1.0f;
                }
                else if (debugMode == 9)
                {
                    outputRgb = float3(1.0f, 0.0f, 0.0f);
                    outputAlpha = 1.0f;
                }
                return float4(outputRgb, outputAlpha);
            }
            ENDHLSL
        }
        Pass
        {
            Name "EID5618_Display"
            ZTest Always
            ZWrite Off
            Cull Off
            Blend One Zero
            ColorMask RGBA
            HLSLPROGRAM
            #pragma target 4.5
            #pragma vertex DisplayVertex
            #pragma fragment DisplayFrag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            Texture2D<float4> _EID5618ExactRT;
            SamplerState sampler_PointClamp;
            float _EID5618LinearDisplay;

            struct Attributes { uint vertexID : SV_VertexID; };
            struct Varyings { float4 positionCS : SV_POSITION; float2 uv : TEXCOORD0; };

            Varyings DisplayVertex(Attributes input)
            {
                Varyings output;
                float2 uv = float2((input.vertexID << 1) & 2, input.vertexID & 2);
                output.positionCS = float4(uv * 2.0 - 1.0, 0.0, 1.0);
            #if UNITY_UV_STARTS_AT_TOP
                uv.y = 1.0 - uv.y;
            #endif
                output.uv = uv;
                return output;
            }

            float3 EID5618SrgbEotf(float3 c)
            {
                float3 low = c / 12.92f;
                float3 high = pow(max((c + 0.055f) / 1.055f, 0.0f), 2.4f);
                return float3(c.x <= 0.04045f ? low.x : high.x,
                              c.y <= 0.04045f ? low.y : high.y,
                              c.z <= 0.04045f ? low.z : high.z);
            }

            float4 DisplayFrag(Varyings input) : SV_Target0
            {
                float4 encoded = _EID5618ExactRT.SampleLevel(sampler_PointClamp, input.uv, 0.0);
                float3 rgb = encoded.rgb;
                if (_EID5618LinearDisplay > 0.5f)
                    rgb = EID5618SrgbEotf(rgb);
                return float4(rgb, encoded.a);
            }
            ENDHLSL
        }
    }
    Fallback Off
}
