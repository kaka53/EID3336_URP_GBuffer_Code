Shader "Hidden/EID3332Combined/Deferred/SceneGBuffer"
{
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" }

        HLSLINCLUDE
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        float4x4 _EID3336BViewProjection;
        float4x4 _EID3336BCorrection;
        float4 _EID3336BRendererColor;
        float4 _EID3336BBaseColor;
        float4 _EID3336BEmission;
        float _EID3336BRendererIndex;
        float _EID3336BMetallic;
        float _EID3336BRoughness;
        float _EID3336BAO;
        float _EID3336BMaterialId;
        float _EID3336BUseVisibilityMask;
        float4 _EID3336BScreenSize;
        TEXTURE2D(_EID3336BVisibilityMask);
        SAMPLER(sampler_EID3336BVisibilityMask);

        struct Attributes
        {
            float3 positionOS : POSITION;
            float3 normalOS : NORMAL;
            float4 tangentOS : TANGENT;
            float2 uv0 : TEXCOORD0;
        };
        struct Varyings
        {
            float4 positionCS : SV_POSITION;
            float3 positionWS : TEXCOORD0;
            float3 normalWS : TEXCOORD1;
            float2 uv0 : TEXCOORD2;
        };
        Varyings Vert(Attributes input)
        {
            Varyings output;
            float4 correctedOS = mul(_EID3336BCorrection, float4(input.positionOS, 1.0));
            float4 positionWS = mul(UNITY_MATRIX_M, correctedOS);
            float3 correctedNormal = mul((float3x3)_EID3336BCorrection, input.normalOS);
            output.positionWS = positionWS.xyz;
            output.normalWS = normalize(mul((float3x3)UNITY_MATRIX_M, correctedNormal));
            output.uv0 = input.uv0;
            output.positionCS = mul(_EID3336BViewProjection, positionWS);
            return output;
        }
        void ApplyVisibility(float4 positionCS)
        {
            if (_EID3336BUseVisibilityMask > .5)
            {
                float2 uv = float2((positionCS.x + .5) * _EID3336BScreenSize.z,
                                   1.0 - (positionCS.y - .5) * _EID3336BScreenSize.w);
                clip(SAMPLE_TEXTURE2D_LOD(_EID3336BVisibilityMask, sampler_EID3336BVisibilityMask, uv, 0).r - .5);
            }
        }
        float2 EncodeOctaYUp(float3 n)
        {
            n = normalize(n);
            n /= max(abs(n.x) + abs(n.y) + abs(n.z), 1e-6);
            float2 encoded = n.xz;
            if (n.y < 0.0)
            {
                float2 signValue = float2(encoded.x >= 0.0 ? 1.0 : -1.0, encoded.y >= 0.0 ? 1.0 : -1.0);
                encoded = (1.0 - abs(encoded.yx)) * signValue;
            }
            return encoded * .5 + .5;
        }
        float3 EncodeSRGBForMRT(float3 linearColor)
        {
            linearColor = saturate(linearColor);
            float3 low = linearColor * 12.92;
            float3 high = 1.055 * pow(linearColor, 1.0 / 2.4) - 0.055;
            return lerp(high, low, step(linearColor, 0.0031308));
        }
        ENDHLSL

        Pass
        {
            Name "EID3336_B4_Stage6CompatibleGBuffer"
            Cull Off
            ZTest LEqual
            ZWrite On
            Blend Off
            HLSLPROGRAM
            #pragma target 4.5
            #pragma vertex Vert
            #pragma fragment FragGBuffer
            struct MRTOutput
            {
                float4 target0 : SV_Target0;
                float4 target1 : SV_Target1;
                float4 target2 : SV_Target2;
                float4 target3 : SV_Target3;
                float4 target4 : SV_Target4;
            };
            MRTOutput FragGBuffer(Varyings input)
            {
                ApplyVisibility(input.positionCS);
                MRTOutput output;
                float3 normalWS = normalize(input.normalWS);
                float2 octa = EncodeOctaYUp(normalWS);
                output.target0 = float4(_EID3336BRendererColor.rgb + _EID3336BEmission.rgb, 1.0);
                output.target1 = float4(normalWS * .5 + .5, 1.0);
                output.target2 = float4(saturate(_EID3336BMetallic), saturate(_EID3336BAO), saturate(_EID3336BMaterialId), saturate(_EID3336BEmission.a));
                output.target3 = float4(octa, saturate(_EID3336BRoughness), 1.0);
                output.target4 = float4(EncodeSRGBForMRT(_EID3336BBaseColor.rgb), 1.0);
                return output;
            }
            ENDHLSL
        }

        Pass
        {
            Name "EID3336_B1_Coverage"
            Cull Off
            ZTest LEqual
            ZWrite Off
            Blend Off
            HLSLPROGRAM
            #pragma target 4.5
            #pragma vertex Vert
            #pragma fragment FragCoverage
            float4 FragCoverage(Varyings input) : SV_Target
            {
                ApplyVisibility(input.positionCS);
                return 1.0.xxxx;
            }
            ENDHLSL
        }

        Pass
        {
            Name "EID3336_B3_RawDepthDebug"
            Cull Off
            ZTest LEqual
            ZWrite Off
            Blend Off
            HLSLPROGRAM
            #pragma target 4.5
            #pragma vertex Vert
            #pragma fragment FragDepth
            float4 FragDepth(Varyings input) : SV_Target
            {
                ApplyVisibility(input.positionCS);
                float depth = input.positionCS.z;
                return float4(depth, depth, depth, 1.0);
            }
            ENDHLSL
        }

        Pass
        {
            Name "EID3336_B3B4_ActualReferences"
            Cull Off
            ZTest LEqual
            ZWrite Off
            Blend Off
            HLSLPROGRAM
            #pragma target 4.5
            #pragma vertex Vert
            #pragma fragment FragReferences
            struct ReferenceOutput
            {
                float4 worldPosition : SV_Target0;
                float4 normalWS : SV_Target1;
            };
            ReferenceOutput FragReferences(Varyings input)
            {
                ApplyVisibility(input.positionCS);
                ReferenceOutput output;
                output.worldPosition = float4(input.positionWS, 1.0);
                output.normalWS = float4(normalize(input.normalWS), 1.0);
                return output;
            }
            ENDHLSL
        }
    }
    Fallback Off
}