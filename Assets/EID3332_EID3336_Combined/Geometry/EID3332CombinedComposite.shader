Shader "Hidden/EID3332Combined/Deferred/Composite"
{
    Properties
    {
        [NoScaleOffset] _MainTex ("Final Lighting", 2D) = "black" {}
        [NoScaleOffset] _EID3336SceneBackground ("Scene Background", 2D) = "black" {}
        _EID3336UseSceneBackground ("Use Scene Background", Float) = 0
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "Queue"="Overlay" }
        Pass
        {
            Name "EID3332Combined_SceneViewComposite"
            Cull Off
            ZTest Always
            ZWrite Off
            ColorMask RGBA
            Blend One Zero
            HLSLPROGRAM
            #pragma target 3.5
            #pragma vertex Vert
            #pragma fragment Frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);
            TEXTURE2D(_EID3336SceneBackground);
            SAMPLER(sampler_EID3336SceneBackground);
            float _EID3336UseSceneBackground;

            struct Attributes { uint vertexID : SV_VertexID; };
            struct Varyings { float4 positionCS : SV_POSITION; float2 uv : TEXCOORD0; };

            Varyings Vert(Attributes input)
            {
                Varyings output;
                uint vertex = input.vertexID % 3u;
                output.positionCS = vertex == 0u ? float4(-1,-1,0,1) :
                                    vertex == 1u ? float4(3,-1,0,1) : float4(-1,3,0,1);
                output.uv = vertex == 0u ? float2(0,0) :
                           vertex == 1u ? float2(2,0) : float2(0,2);
                return output;
            }

            half4 Frag(Varyings input) : SV_Target
            {
                float2 uv = saturate(input.uv);
                half4 lighting = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, uv);
                half3 outputColor = lighting.rgb;
                if (_EID3336UseSceneBackground > 0.5)
                {
                    half3 background = SAMPLE_TEXTURE2D(_EID3336SceneBackground, sampler_EID3336SceneBackground, uv).rgb;
                    outputColor = lerp(background, lighting.rgb, saturate(lighting.a));
                }
                return half4(outputColor, 1.0h);
            }
            ENDHLSL
        }
    }
    Fallback Off
}