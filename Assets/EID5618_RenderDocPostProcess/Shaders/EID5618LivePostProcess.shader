Shader "Hidden/EID5618/LivePostProcess"
{
    Properties
    {
        [HideInInspector] _BlitTexture ("实时替换的 res11", 2D) = "black" {}
        [Tooltip("RenderDoc EID5618 res9，独立绑定，不再当作 Opaque/Depth")]
        _EID5618Res9 ("EID5618 res9", 2D) = "black" {}
        [Tooltip("RenderDoc EID5618 res10，独立绑定，不再当作 Depth/Normal")]
        _EID5618Res10 ("EID5618 res10", 2D) = "black" {}
        [Tooltip("RenderDoc EID5618 res11 的捕获备份；启用实时替换时不采样")]
        _EID5618Res11Captured ("EID5618 res11 captured", 2D) = "black" {}
        _EID5618Res9Weight ("res9 输入权重", Range(0,1)) = 1
        _EID5618Res10Weight ("res10 输入权重", Range(0,1)) = 1
        _EID5618InputMode ("输入组合模式", Float) = 1
        _EID5618Exposure ("曝光", Float) = 1
        _EID5618ColorScale ("颜色缩放", Color) = (1,1,1,1)
        _EID5618ColorBias ("颜色偏移", Color) = (0,0,0,0)
        _EID5618Contrast ("对比度", Range(0,4)) = 1
        _EID5618Saturation ("饱和度", Range(0,2)) = 1
        _EID5618Blend ("后处理强度", Range(0,1)) = 1
        _EID5618FlipY ("Y翻转", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "Queue"="Overlay" }
        Pass
        {
            Name "EID5618_LiveRealtimeInput"
            ZTest Always
            ZWrite Off
            Cull Off
            Blend One Zero
            HLSLPROGRAM
            #pragma target 3.5
            #pragma vertex Vert
            #pragma fragment Frag
            #include "Packages/com.unity.render-pipelines.core/Runtime/Utilities/Blit.hlsl"

            TEXTURE2D_X(_BlitTexture);
            SAMPLER(sampler_BlitTexture);
            TEXTURE2D_X(_EID5618Res9);
            SAMPLER(sampler_EID5618Res9);
            TEXTURE2D_X(_EID5618Res10);
            SAMPLER(sampler_EID5618Res10);
            TEXTURE2D_X(_EID5618Res11Captured);
            SAMPLER(sampler_EID5618Res11Captured);

            float _EID5618HasRes9;
            float _EID5618HasRes10;
            float _EID5618HasCapturedRes11;
            float _EID5618ReplaceRes11WithLive;
            float _EID5618Res9Weight;
            float _EID5618Res10Weight;
            float _EID5618InputMode;
            float _EID5618Exposure;
            float4 _EID5618ColorScale;
            float4 _EID5618ColorBias;
            float _EID5618Contrast;
            float _EID5618Saturation;
            float _EID5618Blend;
            float _EID5618FlipY;

            struct Attributes { uint vertexID : SV_VertexID; };
            struct Varyings { float4 positionCS : SV_POSITION; float2 uv : TEXCOORD0; };

            Varyings Vert(Attributes input)
            {
                Varyings output;
                output.positionCS = GetFullScreenTriangleVertexPosition(input.vertexID);
                output.uv = GetFullScreenTriangleTexCoord(input.vertexID);
                if (_EID5618FlipY > 0.5) output.uv.y = 1.0 - output.uv.y;
                return output;
            }

            float3 ApplyColor(float3 source)
            {
                float3 processed = source * _EID5618Exposure;
                processed *= _EID5618ColorScale.rgb;
                processed += _EID5618ColorBias.rgb;
                float luminance = dot(processed, float3(0.2126, 0.7152, 0.0722));
                processed = lerp(luminance.xxx, processed, _EID5618Saturation);
                processed = (processed - 0.5) * _EID5618Contrast + 0.5;
                return max(processed, 0.0);
            }

            half4 Frag(Varyings input) : SV_Target
            {
                // EID5618 PS has exactly three read-only image bindings:
                // res11, res9, res10. The live camera copy replaces res11;
                // res9 and res10 are independent captured texture inputs.
                float4 liveRes11 = SAMPLE_TEXTURE2D_X(_BlitTexture, sampler_BlitTexture, input.uv);
                float4 capturedRes11 = SAMPLE_TEXTURE2D_X(_EID5618Res11Captured, sampler_EID5618Res11Captured, input.uv);
                float4 res9 = SAMPLE_TEXTURE2D_X(_EID5618Res9, sampler_EID5618Res9, input.uv);
                float4 res10 = SAMPLE_TEXTURE2D_X(_EID5618Res10, sampler_EID5618Res10, input.uv);

                float useLive = saturate(_EID5618ReplaceRes11WithLive);
                float3 res11 = lerp(capturedRes11.rgb, liveRes11.rgb, useLive);
                res11 = lerp(res11, liveRes11.rgb, 1.0 - _EID5618HasCapturedRes11 * (1.0 - useLive));

                float w9 = saturate(_EID5618Res9Weight) * saturate(_EID5618HasRes9);
                float w10 = saturate(_EID5618Res10Weight) * saturate(_EID5618HasRes10);
                float3 source;

                // InputMode is intentionally explicit so the three bindings can
                // be validated independently before matching the captured PS math:
                // 0 = live res11 only; 1 = additive res9/res10; 2 = multiplicative;
                // 3 = diagnostic average of all supplied inputs.
                if (_EID5618InputMode < 0.5)
                    source = res11;
                else if (_EID5618InputMode < 1.5)
                    source = res11 + res9.rgb * w9 + res10.rgb * w10;
                else if (_EID5618InputMode < 2.5)
                    source = res11 * lerp(1.0.xxx, res9.rgb, w9) * lerp(1.0.xxx, res10.rgb, w10);
                else
                    source = (res11 + res9.rgb * w9 + res10.rgb * w10) / max(1.0 + w9 + w10, 1e-5);

                float3 processed = ApplyColor(source);
                float3 result = lerp(source, processed, saturate(_EID5618Blend));
                return half4(result, liveRes11.a);
            }
            ENDHLSL
        }
    }
    Fallback Off
}

