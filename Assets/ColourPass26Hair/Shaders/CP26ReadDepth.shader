Shader "Hidden/ColourPass26Hair/ReadDepth" { SubShader { Pass {
Cull Off ZTest Always ZWrite Off Blend Off
HLSLPROGRAM
#pragma target 4.5
#pragma vertex vert
#pragma fragment frag
Texture2D<float> _CP26AuditDepth;
float4 vert(uint id:SV_VertexID):SV_POSITION {return float4((id==1?3:-1),(id==2?3:-1),0,1);}
float4 frag(float4 p:SV_POSITION):SV_Target {float d=_CP26AuditDepth.Load(int3(int2(p.xy),0));return float4(d,d,d,1);}
ENDHLSL
} } }
