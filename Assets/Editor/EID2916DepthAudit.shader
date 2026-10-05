Shader "Hidden/EID2916/DepthAudit" {
 SubShader {
 Pass { ZWrite Off ZTest Always Cull Off
 HLSLPROGRAM
 #pragma target 4.5
 #pragma vertex V
 #pragma fragment F
 Texture2D<float> _AuditDepth;
 float4 V(uint i:SV_VertexID):SV_POSITION {float2 p=float2((i<<1)&2,i&2);return float4(p*2-1,0,1);}
 float4 F(float4 p:SV_POSITION):SV_Target{return _AuditDepth.Load(int3((int2)p.xy,0)).xxxx;}
 ENDHLSL }
 Pass { ZWrite On ZTest LEqual Cull Off
 HLSLPROGRAM
 #pragma target 4.5
 #pragma vertex V
 #pragma fragment F
 #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
 float4 V(float3 p:POSITION):SV_POSITION {return TransformObjectToHClip(p);}
 float4 F(float4 p:SV_POSITION):SV_Target{return float4(p.z,p.z,p.z,1);}
 ENDHLSL }
 }
}
