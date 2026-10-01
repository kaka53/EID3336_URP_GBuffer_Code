Shader "Hidden/EID4730/Preview"
{
 SubShader { Pass {
 Cull Off ZTest Always ZWrite Off Blend Off
 HLSLPROGRAM
 #pragma target 5.0
 #pragma only_renderers d3d11 vulkan
 #pragma vertex Vert
 #pragma fragment Frag
 Texture2D<float4> _ReplaySource;
 float4 _PreviewViewport;
 float4 Vert(uint id:SV_VertexID):SV_Position
 {
  float2 uv=float2((id<<1)&2,id&2);return float4(uv*2-1,0,1);
 }
 float4 Frag(float4 p:SV_Position):SV_Target
 {
  // Work in D3D pixel coordinates, not Blit UVs: preserve captured top-to-bottom rows.
  uint w,h;_ReplaySource.GetDimensions(w,h);
  float2 uv=(p.xy-_PreviewViewport.xy)/_PreviewViewport.zw;
  int2 xy=clamp(int2(uv*float2(w,h)),int2(0,0),int2(w,h)-1);
  return _ReplaySource.Load(int3(xy,0));
 }
 ENDHLSL
 } }
}
