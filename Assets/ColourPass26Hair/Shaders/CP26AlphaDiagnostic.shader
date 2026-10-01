Shader "Hidden/ColourPass26Hair/AlphaDiagnostic" {
Properties { _BaseMap("Captured base",2D)="white"{} _Mode("Mode",Float)=0 _Src("Source",Float)=1 _Dst("Destination",Float)=0 }
SubShader { Pass {
Cull Back ZTest Always ZWrite Off
Blend [_Src] [_Dst], One OneMinusSrcAlpha
HLSLPROGRAM
#pragma target 4.5
#pragma vertex vert
#pragma fragment frag
float4x4 _DiagnosticMVP;
float4 _CapturedST;
float _Mode, _Bias, _TintAlpha;
Texture2D _BaseMap;
SamplerState linear_repeat_sampler;
struct V {float4 p:SV_POSITION;float2 uv:TEXCOORD0;};
V vert(float3 p:POSITION,float2 uv:TEXCOORD0){V o;o.p=mul(_DiagnosticMVP,float4(p,1));o.uv=uv*_CapturedST.xy+_CapturedST.zw;return o;}
float4 frag(V i):SV_Target {
float4 t=_BaseMap.SampleBias(linear_repeat_sampler,i.uv,_Bias);float a=t.a*_TintAlpha;
if(_Mode<0.5)return float4(1,0,0,1);
if(_Mode<1.5)return float4(1,0,0,a);
if(_Mode<2.5)return float4(a,a,a,1);
return float4(t.rgb,a);
}
ENDHLSL
} }
}
