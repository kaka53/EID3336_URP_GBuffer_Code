Shader "Hidden/EID3332Combined/Deferred/LiveLighting"
{
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "Queue"="Overlay" }
        Pass
        {
            Name "EID3336_B5_Stage6BaseDecode"
            Cull Off
            ZTest Always
            ZWrite Off
            Blend SrcAlpha OneMinusSrcAlpha
            HLSLPROGRAM
            #pragma target 4.5
            #pragma vertex Vert
            #pragma fragment Frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            TEXTURE2D(_EID3336BMRT0); SAMPLER(sampler_EID3336BMRT0);
            TEXTURE2D(_EID3336BMRT1); SAMPLER(sampler_EID3336BMRT1);
            TEXTURE2D(_EID3336BMRT2); SAMPLER(sampler_EID3336BMRT2);
            TEXTURE2D(_EID3336BMRT3); SAMPLER(sampler_EID3336BMRT3);
            TEXTURE2D(_EID3336BMRT4); SAMPLER(sampler_EID3336BMRT4);
            TEXTURE2D(_EID3336BDepth); SAMPLER(sampler_EID3336BDepth);
            TEXTURE2D(_EID3336BCoverage); SAMPLER(sampler_EID3336BCoverage);
            TEXTURE2D(_EID3336BDepthDebug); SAMPLER(sampler_EID3336BDepthDebug);
            TEXTURE2D(_EID3336BActualWorldPosition); SAMPLER(sampler_EID3336BActualWorldPosition);
            TEXTURE2D(_EID3336BActualNormal); SAMPLER(sampler_EID3336BActualNormal);

            float4x4 _EID3336BClipToWorld;
            float4x4 _EID3336BWorldToView;
            float4 _EID3336BCameraPositionWS, _EID3336BLightDirectionWS, _EID3336BLightColor, _EID3336BScreenSize;
            float _EID3336BDisplayMode, _EID3336BWorldDisplayRange, _EID3336BDepthDisplayFar, _EID3336BLightIntensity;
            float _EID3336BAmbientStrength, _EID3336BSpecularStrength, _EID3336BSpecularPower;
            float _EID3336BPreviewOpacity, _EID3336BFlipY, _EID3336BReconstructionFlipY;

            struct Varyings { float4 positionCS : SV_POSITION; float2 uv : TEXCOORD0; };
            Varyings Vert(uint id : SV_VertexID)
            {
                Varyings output;
                uint vertex = id % 3u;
                output.positionCS = vertex == 0u ? float4(-1,-1,0,1) : vertex == 1u ? float4(3,-1,0,1) : float4(-1,3,0,1);
                output.uv = vertex == 0u ? float2(0,0) : vertex == 1u ? float2(2,0) : float2(0,2);
                return output;
            }

            float4 SampleRaw(int target, float2 uv)
            {
                if (target == 0) return SAMPLE_TEXTURE2D(_EID3336BMRT0, sampler_EID3336BMRT0, uv);
                if (target == 1) return SAMPLE_TEXTURE2D(_EID3336BMRT1, sampler_EID3336BMRT1, uv);
                if (target == 2) return SAMPLE_TEXTURE2D(_EID3336BMRT2, sampler_EID3336BMRT2, uv);
                if (target == 3) return SAMPLE_TEXTURE2D(_EID3336BMRT3, sampler_EID3336BMRT3, uv);
                return SAMPLE_TEXTURE2D(_EID3336BMRT4, sampler_EID3336BMRT4, uv);
            }

            float3 DecodeOctaYUp(float4 packedNormal)
            {
                float2 encoded = packedNormal.xy * 2.0 - 1.0;
                float fold = 1.0 - abs(encoded.x) - abs(encoded.y);
                float3 normal = float3(encoded.x, fold, encoded.y);
                if (fold < 0.0)
                {
                    float2 signXZ = float2(normal.x >= 0.0 ? 1.0 : -1.0, normal.z >= 0.0 ? 1.0 : -1.0);
                    float2 folded = (1.0 - abs(normal.zx)) * signXZ;
                    normal = float3(folded.x, normal.y, folded.y);
                }
                return normalize(normal);
            }

            float3 ReconstructWorld(float2 uv, float depth)
            {
                float2 ndc = uv * 2.0 - 1.0;
                if (_EID3336BReconstructionFlipY > .5) ndc.y = -ndc.y;
                float4 worldH = mul(_EID3336BClipToWorld, float4(ndc, depth, 1.0));
                return worldH.xyz / max(abs(worldH.w), 1e-6);
            }

            float3 ErrorHeat(float errorValue)
            {
                float value = saturate(errorValue * 100.0);
                return saturate(float3(value * 2.0, 1.0 - abs(value * 2.0 - 1.0), 1.0 - value * 2.0));
            }

            half4 Frag(Varyings input) : SV_Target
            {
                float2 uv = saturate(input.uv);
                if (_EID3336BFlipY > .5) uv.y = 1.0 - uv.y;
                float coverage = SAMPLE_TEXTURE2D(_EID3336BCoverage, sampler_EID3336BCoverage, uv).r;
                if (coverage < .001) return 0;

                float4 material = SAMPLE_TEXTURE2D(_EID3336BMRT2, sampler_EID3336BMRT2, uv);
                float4 packedNormal = SAMPLE_TEXTURE2D(_EID3336BMRT3, sampler_EID3336BMRT3, uv);
                float4 baseColorSample = SAMPLE_TEXTURE2D(_EID3336BMRT4, sampler_EID3336BMRT4, uv);
                float depth = SAMPLE_TEXTURE2D(_EID3336BDepth, sampler_EID3336BDepth, uv).r;
                float3 normalWS = DecodeOctaYUp(packedNormal);
                float3 worldPosition = ReconstructWorld(uv, depth);
                float3 actualWorld = SAMPLE_TEXTURE2D(_EID3336BActualWorldPosition, sampler_EID3336BActualWorldPosition, uv).xyz;
                float3 baseColor = saturate(baseColorSample.rgb);
                float metallic = saturate(material.x);
                float ao = saturate(material.y);
                float roughness = saturate(packedNormal.z);
                float linearDepth = abs(mul(_EID3336BWorldToView, float4(worldPosition, 1.0)).z);

                float3 lightDirection = normalize(_EID3336BLightDirectionWS.xyz);
                float3 viewDirection = normalize(_EID3336BCameraPositionWS.xyz - worldPosition);
                float3 halfDirection = normalize(lightDirection + viewDirection);
                float ndl = saturate(dot(normalWS, lightDirection));
                float specular = pow(saturate(dot(normalWS, halfDirection)), max(_EID3336BSpecularPower, 1.0));
                specular *= _EID3336BSpecularStrength * (1.0 - roughness * .75);
                float3 diffuseColor = baseColor * (1.0 - metallic);
                float3 lit = diffuseColor * (_EID3336BAmbientStrength * ao + ndl * _EID3336BLightIntensity * _EID3336BLightColor.rgb)
                           + specular * lerp(.04.xxx, baseColor, metallic) * _EID3336BLightColor.rgb;

                int mode = (int)round(_EID3336BDisplayMode);
                float3 output = lit;
                if (mode >= 1 && mode <= 5) output = SampleRaw(mode - 1, uv).rgb;
                else if (mode == 6) output = depth.xxx;
                else if (mode == 7) output = coverage.xxx;
                else if (mode == 8) output = baseColor;
                else if (mode == 9) output = normalWS * .5 + .5;
                else if (mode == 10) output = float3(metallic, roughness, ao);
                else if (mode == 11) output = saturate(linearDepth / max(_EID3336BDepthDisplayFar, 1.0)).xxx;
                else if (mode == 12) output = saturate((worldPosition - _EID3336BCameraPositionWS.xyz) / max(_EID3336BWorldDisplayRange, 1.0) * .5 + .5);
                else if (mode == 13) output = ErrorHeat(length(worldPosition - actualWorld));
                else if (mode == 14) output = roughness.xxx;
                else if (mode == 15) output = metallic.xxx;
                else if (mode == 16) output = ao.xxx;
                return float4(saturate(output), saturate(coverage * _EID3336BPreviewOpacity));
            }
            ENDHLSL
        }
    }
    Fallback Off
}