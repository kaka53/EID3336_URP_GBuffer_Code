Shader "Hidden/ColourPass26Hair/Diagnostic" {
Properties { _Cull("Cull",Float)=0 }
SubShader { Pass {
Cull [_Cull] ZTest Always ZWrite Off Blend Off
HLSLPROGRAM
#pragma vertex vert
#pragma fragment frag
float4x4 _DiagnosticMVP;
float4 vert(float3 p:POSITION):SV_POSITION { return mul(_DiagnosticMVP,float4(p,1)); }
float4 frag():SV_Target { return float4(1,0,0,1); }
ENDHLSL
} }
}
