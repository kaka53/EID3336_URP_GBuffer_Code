Shader "Hidden/EID4613/ColourPass16"
{
    Properties
    {
        [HideInInspector] _CP16DepthTest ("Volume depth test", Float) = 5
        [HideInInspector] _12 ("Depth copy (rid209560)", 2D) = "black" {}
        [HideInInspector] _19 ("RenderGBuffer RT3 (rid209566)", 2D) = "black" {}
        [HideInInspector] _18 ("Capsule SH LUT (rid264196)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" }
        // EID4602: farthest of a 2x2 footprint in the captured reverse-Z depth.
        Pass
        {
            Name "EID4602_HalfDepth"
            Cull Off ZWrite On ZTest Always ColorMask 0
            HLSLPROGRAM
            #pragma target 5.0
            #pragma vertex DepthVertex
            #pragma fragment DepthFragment
            Texture2D<float4> _12;
            SamplerState sampler_PointClamp;
            struct Varyings { float4 position : SV_Position; float2 uv : TEXCOORD0; };
            Varyings DepthVertex(uint id : SV_VertexID)
            {
                float2 p = float2((id << 1u) & 2u, id & 2u);
                Varyings o; o.position = float4(p.x * 2 - 1, 1 - p.y * 2, 1, 1);
                // Compensate Unity backend clip-Y conversion (verified against the captured depth).
                o.uv = p; return o;
            }
            float DepthFragment(Varyings i) : SV_Depth
            {
                float4 d = _12.GatherRed(sampler_PointClamp, i.uv);
                return min(min(d.x, d.y), min(d.z, d.w));
            }
            ENDHLSL
        }
        Pass
        {
            Name "EID4613_CapsuleSH"
            // Unity reverses ShaderLab comparisons on reverse-Z: Greater becomes Vulkan Less.
            Cull Front ZWrite Off ZTest [_CP16DepthTest]
            Blend One One
            ColorMask RGBA
            // EID4602's half-resolution stencil was zero everywhere in capture.
            Stencil { Ref 4 ReadMask 7 WriteMask 0 Comp NotEqual Pass Keep }
            HLSLPROGRAM
            #pragma target 5.0
            #pragma vertex CP16Vertex
            #pragma fragment CP16Fragment
            #include "EID4613FS.hlsl"
            ENDHLSL
        }
    }
    Fallback Off
}
