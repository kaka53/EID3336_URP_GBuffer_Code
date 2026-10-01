Shader "Hidden/EID4725/DiagnosticDepth" {
SubShader { Pass {
Cull Off ZWrite Off ZTest Always
HLSLPROGRAM
#pragma target 4.5
#pragma vertex vert
#pragma fragment frag
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
Texture2D<float> _EID4725DiagnosticDepth;
struct V { float4 positionCS : SV_POSITION; };
V vert(uint id : SV_VertexID) { V o; o.positionCS=GetFullScreenTriangleVertexPosition(id); return o; }
float4 frag(V i) : SV_Target { return _EID4725DiagnosticDepth.Load(int3((int2)i.positionCS.xy,0)).xxxx; }
ENDHLSL
} }
}
