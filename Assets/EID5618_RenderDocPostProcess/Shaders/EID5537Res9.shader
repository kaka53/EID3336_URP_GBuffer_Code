Shader "Hidden/EID5618/EID5537Res9"
{
    Properties
    {
        _13 ("EID5537 res14 深度输入", 2D) = "black" {}
        _790 ("EID5537 res13 R11G11B10 输入", 2D) = "black" {}
        _15 ("EID5537 res17 RGBA16F 输入", 2D) = "black" {}
        _795 ("EID5537 res16 mask 输入", 2D) = "black" {}
        _800 ("EID5537 res15 输入", 2D) = "black" {}
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "Queue"="Overlay" }
        Pass
        {
            Name "EID5537_Exact_RenderDoc_FS"
            ZTest Always
            ZWrite Off
            Cull Off
            Blend One Zero
            HLSLPROGRAM
            #pragma target 4.5
            #pragma vertex EID5537Vertex
            #pragma fragment EID5537Fragment
            #include "EID5537ExactFS.generated.hlsl"

            struct Attributes { uint vertexID : SV_VertexID; };
            struct Varyings { float4 positionCS : SV_POSITION; };

            Varyings EID5537Vertex(Attributes input)
            {
                Varyings o;
                float2 p = float2((input.vertexID << 1) & 2, input.vertexID & 2);
                o.positionCS = float4(p * 2.0 - 1.0, 0.0, 1.0);
                return o;
            }

            float4 EID5537Fragment(Varyings input) : SV_Target0
            {
                SPIRV_Cross_Input i;
                i.gl_FragCoord = input.positionCS;
                // The rasterizer supplies the real pixel coordinate through SV_Position.
                // The wrapper only supplies the required .w value; the exact FS uses xy.
                i.gl_FragCoord.w = 1.0;
                SPIRV_Cross_Output o = main(i);
                return o._4;
            }
            ENDHLSL
        }
    }
    Fallback Off
}

