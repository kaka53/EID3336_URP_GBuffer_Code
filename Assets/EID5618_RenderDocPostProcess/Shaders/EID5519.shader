Shader "Hidden/EID5618/EID5519"
{
 Properties {
  _13 ("Current depth", 2D) = "black" {}
  _14 ("Current motion", 2D) = "black" {}
  _15 ("Previous depth", 2D) = "black" {}
  _16 ("Previous motion", 2D) = "black" {}
  _EID5519MotionSource ("Current camera motion source", 2D) = "black" {}
 }
 SubShader { Tags { "RenderPipeline"="UniversalPipeline" }
 Pass { Name "EID5519_DepthMotionRejection" ZTest Always ZWrite Off Cull Off Blend One Zero
 HLSLPROGRAM
 #pragma target 4.5
 #pragma vertex Vert
 #pragma fragment main
 #include "EID5519ExactFS.generated.hlsl"
 SPIRV_Cross_Input Vert(uint id : SV_VertexID) {
  SPIRV_Cross_Input o; float2 p=float2((id<<1)&2,id&2);
  o.gl_FragCoord=float4(p*2-1,0,1); return o;
 }
 ENDHLSL
 }
 Pass { Name "EID5519_Live_DepthMotionRejection" ZTest Always ZWrite Off Cull Off Blend One Zero
 HLSLPROGRAM
 #pragma target 4.5
 #pragma vertex Vert
 #pragma fragment main
 #define EID5519_LIVE 1
 #include "EID5519ExactFS.generated.hlsl"
 SPIRV_Cross_Input Vert(uint id : SV_VertexID) {
  SPIRV_Cross_Input o; float2 p=float2((id<<1)&2,id&2);
  o.gl_FragCoord=float4(p*2-1,0,1); return o;
 }
 ENDHLSL
 }
 Pass { Name "EID5519_NormalizeLiveInputs" ZTest Always ZWrite Off Cull Off Blend One Zero
 HLSLPROGRAM
 #pragma target 4.5
 #pragma vertex Vert
 #pragma fragment Frag
 Texture2D<float> _EID5519DepthSource;
 Texture2D<float4> _EID5519MotionSource;
 float4 _EID5519SourceSize;
 float _EID5519FlipY;
 struct V { float4 pos:SV_POSITION; };
 struct O { float depth:SV_Target0; float4 motion:SV_Target1; };
 V Vert(uint id:SV_VertexID) { V o; float2 p=float2((id<<1)&2,id&2);o.pos=float4(p*2-1,0,1);return o; }
 O Frag(V i) {
  int2 p=min(int2(i.pos.xy*_EID5519SourceSize.xy/_EID5519SourceSize.zw),int2(_EID5519SourceSize.xy)-1);
  if(_EID5519FlipY>0.5) p.y=(int)_EID5519SourceSize.y-1-p.y;
  O o;o.depth=_EID5519DepthSource.Load(int3(p,0));o.motion=_EID5519MotionSource.Load(int3(p,0));return o;
 }
 ENDHLSL
 } }
}
