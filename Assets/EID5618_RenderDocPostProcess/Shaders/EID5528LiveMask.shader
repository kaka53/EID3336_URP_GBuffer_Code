Shader "Hidden/EID5618/EID5528LiveMask"
{
 Properties { _EID5528Motion ("EID5519 current motion/rejection", 2D) = "black" {} }
 SubShader {
  Tags { "RenderPipeline"="UniversalPipeline" }
  Pass {
   Name "EID5528_FiveTap_BChannel_Mask"
   ZTest Always ZWrite Off Cull Off Blend One Zero
   HLSLPROGRAM
   #pragma target 4.5
   #pragma vertex Vert
   #pragma fragment Frag
   Texture2D<float4> _EID5528Motion;
   SamplerState sampler_LinearClamp;
   float4 _EID5528SourceSize; // xy dimensions, zw reciprocals (original uniforms9.m6)
   float4 _EID5528TargetSize;
   struct V { float4 positionCS:SV_POSITION; };
   V Vert(uint id:SV_VertexID) {
    V o; float2 p=float2((id<<1)&2,id&2);
    o.positionCS=float4(p*2-1,0,1); return o;
   }
   float Frag(V i):SV_Target0 {
    // Same pixel-row convention as EID5519/5537; no blit or extra Y inversion.
    float2 uv=i.positionCS.xy*_EID5528TargetSize.zw;
    float2 d=_EID5528SourceSize.zw;
    float c=_EID5528Motion.SampleLevel(sampler_LinearClamp,uv,0).b;
    float a=_EID5528Motion.SampleLevel(sampler_LinearClamp,uv-d,0).b;
    float b=_EID5528Motion.SampleLevel(sampler_LinearClamp,uv+float2(d.x,-d.y),0).b;
    float e=_EID5528Motion.SampleLevel(sampler_LinearClamp,uv+float2(-d.x,d.y),0).b;
    float f=_EID5528Motion.SampleLevel(sampler_LinearClamp,uv+d,0).b;
    // Original EID5528 tests the whole B channel, not only rejection bit 1.
    return max(c,max(a,max(b,max(e,f))))>0.0 ? 1.0 : 0.0;
   }
   ENDHLSL
  }
 }
}
