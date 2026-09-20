Shader "Hidden/EID4649/ExactRenderDoc"
{
    Properties
    {
        [HideInInspector] _15 ("EID4649 _15 rid209560", 2D) = "black" {}
        [HideInInspector] _22 ("EID4649 _22 rid209068", 2D) = "black" {}
        [HideInInspector] _23 ("EID4649 _23 rid198185", 2D) = "white" {}
        [HideInInspector] _24 ("EID4649 _24 rid209590", 2D) = "black" {}
        [HideInInspector] _25 ("EID4649 _25 rid209071", 2D) = "black" {}
        [HideInInspector] _27 ("EID4649 _27 rid209587", 2D) = "white" {}
        [HideInInspector] _EID4649UseLiveCamera ("EID4649 Use Live Camera", Float) = 0
        [HideInInspector] _EID4649ScreenSize ("EID4649 Screen Size", Vector) = (1366, 768, 0.0007320644, 0.0013020834)
        [HideInInspector] _EID4649CameraPositionWS ("EID4649 Camera Position", Vector) = (0, 0, 0, 1)
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "Queue"="Overlay" }
        Pass
        {
            Name "EID4649_Exact_RenderDoc_FS"
            ZTest Always
            ZWrite Off
            Cull Off
            Blend One Zero
            ColorMask RG
            HLSLPROGRAM
            #pragma target 5.0
            #pragma vertex EID4649Vertex
            #pragma fragment EID4649Fragment

            #include "EID4649ExactFS.hlsl"

            struct EID4649Attributes
            {
                uint vertexID : SV_VertexID;
            };

            struct EID4649Varyings
            {
                float4 positionCS : SV_POSITION;
            };

            EID4649Varyings EID4649Vertex(EID4649Attributes input)
            {
                EID4649Varyings output;
                float2 uv = float2(float((input.vertexID << 1u) & 2u), float(input.vertexID & 2u));
                float2 ndc = (uv * 2.0f) - 1.0f;
                float4 pos = float4(ndc, 1.0f, 1.0f);
                pos.z = 0.0f;
                pos.y = -ndc.y;
                output.positionCS = pos;
                return output;
            }

            float4 EID4649Fragment(EID4649Varyings input) : SV_Target0
            {
                SPIRV_Cross_Input capturedInput;
                capturedInput.gl_FragCoord = input.positionCS;
                SPIRV_Cross_Output capturedOutput = main(capturedInput);
                return float4(capturedOutput._4, 0.0f);
            }
            ENDHLSL
        }
    }
    Fallback Off
}
