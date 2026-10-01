Shader "Hidden/EID4730/RestoreAttachments"
{
 SubShader
 {
  Pass
  {
   Cull Off ZTest Always ZWrite On Blend Off
   HLSLPROGRAM
   #pragma target 5.0
   #pragma only_renderers d3d11 vulkan
   #pragma vertex Vert
   #pragma fragment Frag
   Texture2D<float4> _Before0;
   Texture2D<float4> _Before1;
   Texture2D<float> _BeforeDepth;
   float4 Vert(uint id:SV_VertexID):SV_Position
   {
    float2 uv=float2((id<<1)&2,id&2); return float4(uv*2-1,0,1);
   }
   struct O {float4 a:SV_Target0;float4 b:SV_Target1;float d:SV_Depth;};
   O Frag(float4 p:SV_Position)
   {
    int3 c=int3(int2(p.xy),0);O o;
    o.a=_Before0.Load(c);o.b=_Before1.Load(c);o.d=_BeforeDepth.Load(c);return o;
   }
   ENDHLSL
  }
 }
 Fallback Off
}
