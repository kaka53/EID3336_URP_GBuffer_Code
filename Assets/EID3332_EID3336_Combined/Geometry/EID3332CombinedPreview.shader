Shader "Hidden/EID3332Combined/Deferred/Preview"
{
    Properties
    {
        [NoScaleOffset] _EID3336BPreviewTexture ("Preview Texture", 2D) = "black" {}
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "Queue"="Overlay" }
        Pass
        {
            Name "EID3332Combined_Preview"
            Cull Off
            ZTest Always
            ZWrite Off
            Blend SrcAlpha OneMinusSrcAlpha
            HLSLPROGRAM
            #pragma target 3.5
            #pragma vertex Vert
            #pragma fragment Frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            TEXTURE2D(_EID3336BPreviewTexture);
            SAMPLER(sampler_EID3336BPreviewTexture);
            float _EID3336BPreviewSingleChannel;
            float _EID3336BPreviewFlipY;
            float _EID3336BPreviewOpacity;

            struct Varyings { float4 positionCS : SV_POSITION; float2 uv : TEXCOORD0; };
            Varyings Vert(uint id : SV_VertexID)
            {
                Varyings output;
                uint vertex = id % 3u;
                output.positionCS = vertex == 0u ? float4(-1,-1,0,1) :
                                    vertex == 1u ? float4(3,-1,0,1) : float4(-1,3,0,1);
                output.uv = vertex == 0u ? float2(0,0) :
                            vertex == 1u ? float2(2,0) : float2(0,2);
                return output;
            }
            half4 Frag(Varyings input) : SV_Target
            {
                float2 uv = input.uv;
                if (_EID3336BPreviewFlipY > .5) uv.y = 1.0 - uv.y;
                float4 value = SAMPLE_TEXTURE2D(_EID3336BPreviewTexture, sampler_EID3336BPreviewTexture, saturate(uv));
                if (_EID3336BPreviewSingleChannel > .5) value.rgb = value.rrr;
                value.a = saturate(_EID3336BPreviewOpacity);
                return value;
            }
            ENDHLSL
        }
    }
    Fallback Off
}
