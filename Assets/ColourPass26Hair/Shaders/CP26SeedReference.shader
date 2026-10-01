Shader "Hidden/ColourPass26Hair/SeedReference" {
SubShader { Pass { Cull Off ZTest Always ZWrite On Blend Off
HLSLPROGRAM
#pragma target 4.5
#pragma vertex vert
#pragma fragment frag
Texture2D<float4> _ReferenceColor; Texture2D<float> _ReferenceDepth;
float4 vert(uint id:SV_VertexID):SV_POSITION {return float4((id==1?3:-1),(id==2?3:-1),0,1);}
struct Output {float4 color:SV_Target0;float4 aux:SV_Target1;float depth:SV_Depth;};
Output frag(float4 position:SV_POSITION){Output o;o.color=_ReferenceColor.Load(int3(int2(position.xy),0));o.aux=0;o.depth=_ReferenceDepth.Load(int3(int2(position.xy),0));return o;}
ENDHLSL
} }
}
