Shader "Hidden/EID5618/Copy"
{
    Properties
    {
        [HideInInspector] _EID5618Source ("EID5618 source camera color", 2D) = "black" {}
        [HideInInspector] _EID5618LiveCameraFlipY ("Live camera vertical correction", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "Queue"="Overlay" }
        Pass
        {
            Name "EID5618_Input_Copy_Direct"
            ZTest Always
            ZWrite Off
            Cull Off
            Blend One Zero
            HLSLPROGRAM
            #pragma target 4.5
            #pragma vertex EID5618CopyVertex
            #pragma fragment EID5618CopyFragment

            // This is intentionally a standalone copy pass. Do not use
            // Blitter/ CoreBlit or URP _BlitTexture here: those paths can
            // apply a different viewport/color-space path than the captured
            // R16G16B16A16_FLOAT res9 input.
            Texture2D _EID5618Source;
            SamplerState sampler_PointClamp;
            float _EID5618LiveCameraFlipY;

            struct Attributes { uint vertexID : SV_VertexID; };
            struct Varyings { float4 positionCS : SV_POSITION; float2 uv : TEXCOORD0; };

            Varyings EID5618CopyVertex(Attributes input)
            {
                Varyings output;
                float2 uv = float2((input.vertexID << 1) & 2, input.vertexID & 2);
                output.positionCS = float4(uv * 2.0 - 1.0, 0.0, 1.0);
            #if UNITY_UV_STARTS_AT_TOP
                uv.y = 1.0 - uv.y;
            #endif
                // Live camera RT and RenderDoc screen inputs use opposite Y origins
                // in the current Windows URP path. Apply exactly one additional
                // correction here; captured/generated res9 never use this pass.
                if (_EID5618LiveCameraFlipY > 0.5f)
                    uv.y = 1.0f - uv.y;
                output.uv = uv;
                return output;
            }

            float4 EID5618CopyFragment(Varyings input) : SV_Target0
            {
                // No exposure, gamma, premultiply, blend, or CoreBlit path.
                // The source is copied once into a linear HDR intermediate.
                return _EID5618Source.SampleLevel(sampler_PointClamp, input.uv, 0.0);
            }
            ENDHLSL
        }
    }
    Fallback Off
}
