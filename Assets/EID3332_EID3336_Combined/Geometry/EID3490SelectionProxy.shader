Shader "Hidden/EID3332Combined/EID3490SelectionProxy"
{
    // Editor-only mesh proxy.  The object remains a normal MeshRenderer so
    // Unity's SceneView can use its standard Picking and Selection passes,
    // while the reconstructed camera path is still produced by the custom
    // EID3490 procedural MRT draw.
    Properties
    {
        [HideInInspector] _CullMode ("Cull", Float) = 0
        [HideInInspector] [MainTexture] _BaseMap ("Albedo", 2D) = "white" {}
        [HideInInspector] [MainColor] _BaseColor ("Color", Color) = (1,1,1,1)
        [HideInInspector] _Cutoff ("Alpha Cutoff", Range(0.0, 1.0)) = 0.5
    }

    SubShader
    {
        Tags
        {
            "RenderType" = "Opaque"
            "RenderPipeline" = "UniversalPipeline"
            "IgnoreProjector" = "True"
            "ShaderModel" = "4.5"
        }
        LOD 300

        Pass
        {
            Name "ScenePickingPass"
            Tags { "LightMode" = "Picking" }
            Cull [_CullMode]
            ZWrite On
            ZTest LEqual

            HLSLPROGRAM
            #pragma target 4.5
            #pragma exclude_renderers gles
            #pragma editor_sync_compilation
            #pragma multi_compile DOTS_INSTANCING_ON
            #pragma vertex EID3490SelectionVertex
            #pragma fragment EID3490SelectionFragment
            #define SCENEPICKINGPASS

            float4 _SelectionID;
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct Attributes
            {
                float4 positionOS : POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };
            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            Varyings EID3490SelectionVertex(Attributes input)
            {
                Varyings output = (Varyings)0;
                UNITY_SETUP_INSTANCE_ID(input);
                UNITY_TRANSFER_INSTANCE_ID(input, output);
                output.positionCS = TransformObjectToHClip(input.positionOS.xyz);
                return output;
            }

            half4 EID3490SelectionFragment(Varyings input) : SV_TARGET
            {
                UNITY_SETUP_INSTANCE_ID(input);
                return unity_SelectionID;
            }
            ENDHLSL
        }

        Pass
        {
            Name "SceneSelectionPass"
            Tags { "LightMode" = "SceneSelectionPass" }
            Cull [_CullMode]
            ZWrite On
            ZTest LEqual

            HLSLPROGRAM
            #pragma target 4.5
            #pragma exclude_renderers gles
            #pragma editor_sync_compilation
            #pragma multi_compile DOTS_INSTANCING_ON
            #pragma vertex EID3490SelectionVertex
            #pragma fragment EID3490OutlineFragment
            #define SCENESELECTIONPASS

            int _ObjectId;
            int _PassValue;
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderVariablesFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitInput.hlsl"

            struct Attributes
            {
                float4 positionOS : POSITION;
                float2 texcoord : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };
            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float2 uv : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            Varyings EID3490SelectionVertex(Attributes input)
            {
                Varyings output = (Varyings)0;
                UNITY_SETUP_INSTANCE_ID(input);
                UNITY_TRANSFER_INSTANCE_ID(input, output);
                output.positionCS = TransformObjectToHClip(input.positionOS.xyz);
                output.uv = TRANSFORM_TEX(input.texcoord, _BaseMap);
                return output;
            }

            half4 EID3490OutlineFragment(Varyings input) : SV_TARGET
            {
                UNITY_SETUP_INSTANCE_ID(input);
                return half4(_ObjectId, _PassValue, 1.0, 1.0);
            }
            ENDHLSL
        }
    }
    FallBack Off
}
