Shader "Hidden/EID3448/DepthSeed" {
 SubShader { Pass { Cull Off ZWrite On ZTest Always ColorMask 0
 HLSLPROGRAM
 #pragma vertex V
 #pragma fragment F
 #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
 float4 V(float3 p:POSITION):SV_POSITION{return TransformObjectToHClip(p);}
 float4 F():SV_Target{return 0;}
 ENDHLSL
 } }
}
