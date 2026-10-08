Shader "Hidden/EID5618/EID5537Res9"
{
    Properties
    {
        _13 ("EID5537 res13 color", 2D) = "black" {}
        _790 ("EID5537 res14 depth", 2D) = "black" {}
        _15 ("EID5537 res15 motion", 2D) = "black" {}
        _795 ("EID5537 res16 mask 输入", 2D) = "black" {}
        _800 ("EID5537 res17 history", 2D) = "black" {}
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
            float _EID5537Probe;
            float _EID5537BootstrapHistory;

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
                int2 pixel = int2(input.positionCS.xy);
                if (_EID5537Probe == 1) return _790.Load(int3(pixel, 0));
                if (_EID5537Probe == 2) return _15.Load(int3(pixel, 0));
                if (_EID5537Probe == 3) return _13.Load(int3(pixel, 0));
                if (_EID5537Probe == 4) return _795.Load(int3(pixel / 4, 0));
                if (_EID5537Probe == 5) return _800.Load(int3(pixel, 0));
                // Only the transitional color-history mode sets this. Do not
                // accumulate black/uninitialized history on its first sample.
                if (_EID5537BootstrapHistory > 0.5f)
                    return float4(_13.Load(int3(pixel, 0)).rgb, 0.0f);
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
        Pass
        {
            Name "EID5537_CopyLive13"
            ZTest Always
            ZWrite Off
            Cull Off
            Blend One Zero
            HLSLPROGRAM
            #pragma target 4.5
            #pragma vertex CopyVertex
            #pragma fragment CopyFragment
            Texture2D<float4> _EID5537CameraSource;
            float4 _EID5537SourceSize; // active source width/height, fixed destination width/height
            float _EID5537CopyFlipY;
            struct CopyAttributes { uint vertexID : SV_VertexID; };
            struct CopyVaryings { float4 positionCS : SV_Position; };
            CopyVaryings CopyVertex(CopyAttributes input)
            {
                CopyVaryings output;
                float2 p = float2((input.vertexID << 1) & 2, input.vertexID & 2);
                output.positionCS = float4(p * 2.0 - 1.0, 0.0, 1.0);
                return output;
            }
            float4 CopyFragment(CopyVaryings input) : SV_Target0
            {
                // Pixel-addressed copy in the same row convention as the exact
                // FS Load path: no implicit blit Y flip, tonemap or gamma pass.
                // Normalize only color to the capture resolution; the remaining
                // captured inputs still use their original 1366x768 coordinates.
                int2 size = int2(_EID5537SourceSize.xy);
                int2 pixel = int2(input.positionCS.xy * _EID5537SourceSize.xy / _EID5537SourceSize.zw);
                pixel = clamp(pixel, int2(0, 0), size - 1);
                if (_EID5537CopyFlipY > 0.5f) pixel.y = size.y - 1 - pixel.y;
                return _EID5537CameraSource.Load(int3(pixel, 0));
            }
            ENDHLSL
        }
        Pass
        {
            Name "EID5537_CopyLive790"
            ZTest Always
            ZWrite Off
            Cull Off
            Blend One Zero
            HLSLPROGRAM
            #pragma target 4.5
            #pragma vertex DepthCopyVertex
            #pragma fragment DepthCopyFragment
            Texture2D<float> _EID5537CameraDepthSource;
            float4 _EID5537SourceSize;
            float _EID5537CopyFlipY;
            struct DepthCopyAttributes { uint vertexID : SV_VertexID; };
            struct DepthCopyVaryings { float4 positionCS : SV_Position; };
            DepthCopyVaryings DepthCopyVertex(DepthCopyAttributes input)
            {
                DepthCopyVaryings output;
                float2 p = float2((input.vertexID << 1) & 2, input.vertexID & 2);
                output.positionCS = float4(p * 2.0 - 1.0, 0.0, 1.0);
                return output;
            }
            float DepthCopyFragment(DepthCopyVaryings input) : SV_Target0
            {
                // Same nearest-pixel mapping/orientation as live _13. Preserve
                // raw device Z in R32F; no linearization or depth/stencil writes.
                int2 size = int2(_EID5537SourceSize.xy);
                int2 pixel = int2(input.positionCS.xy * _EID5537SourceSize.xy / _EID5537SourceSize.zw);
                pixel = clamp(pixel, int2(0, 0), size - 1);
                if (_EID5537CopyFlipY > 0.5f) pixel.y = size.y - 1 - pixel.y;
                return _EID5537CameraDepthSource.Load(int3(pixel, 0));
            }
            ENDHLSL
        }
    }
    Fallback Off
}

