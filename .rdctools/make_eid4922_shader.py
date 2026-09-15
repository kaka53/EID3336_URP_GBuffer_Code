import re,os
src=r'.rdctools/eid4922'; out=r'Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Shaders/EID4922Sky.hlsl'
vs=open(os.path.join(src,'VS.cross.hlsl'),encoding='utf8').read(); ps=open(os.path.join(src,'PS.cross.hlsl'),encoding='utf8').read()
vs_full=vs[:vs.index('struct SPIRV_Cross_Input')]
# drop VS's original static declaration? keep
m=re.search(r'cbuffer _31_32.*?\n\};',ps,re.S); ps_local=m.group(0)
res_start=ps.index('SamplerState _14');res_end=ps.index('static float4 gl_FragCoord;');ps_res=ps[res_start:res_end]
ps_body=ps[res_end:ps.index('struct SPIRV_Cross_Input')]
vs_full=re.sub(r'cbuffer _10_11', 'cbuffer EID4922FrameCB', vs_full, count=1)
vs_full=re.sub(r'cbuffer _12_13', 'cbuffer EID4922ViewCB', vs_full, count=1)
vs_full=re.sub(r'cbuffer _14_15', 'cbuffer EID4922ObjectCB', vs_full, count=1)
vs_full=re.sub(r'\s*:\s*register\(b\d+\)','',vs_full)
ps_local=ps_local.replace('cbuffer _31_32','cbuffer EID4922SkyCB');ps_local=re.sub(r'\s*:\s*register\(b\d+\)','',ps_local)
ps_res=re.sub(r'\s*:\s*register\([ts]\d+\)','',ps_res)
for old,new in [('_18','_EID4922Res18'),('_19','_EID4922Res19'),('_20','_EID4922Res20'),('_21','_EID4922Res21'),('_23','_EID4922Res23'),('_25','_EID4922Res25'),('_27','_EID4922Res27'),('_29','_EID4922Res29')]:
 pat=r'(?<![A-Za-z0-9])'+re.escape(old)+r'(?![A-Za-z0-9])'; ps_res=re.sub(pat,new,ps_res); ps_body=re.sub(pat,new,ps_body)
for old,new in [('_14','sampler_EID4922Res19'),('_15','sampler_EID4922Res20'),('_22','sampler_EID4922Res21'),('_24','sampler_EID4922Res23'),('_26','sampler_EID4922Res25'),('_28','sampler_EID4922Res27'),('_30','sampler_EID4922Res29')]:
 pat=r'(?<![A-Za-z0-9])'+re.escape(old)+r'(?![A-Za-z0-9])'; ps_res=re.sub(pat,new,ps_res); ps_body=re.sub(pat,new,ps_body)
wrapper=r'''
struct EID4922VertexInput { float3 positionOS : TEXCOORD0; float2 uv : TEXCOORD1; };
struct EID4922Varyings { float4 positionCS : SV_Position; float3 worldPos : TEXCOORD0; float3 screenPos : TEXCOORD2; float3 prevPos : TEXCOORD3; };
EID4922Varyings EID4922VertexMain(EID4922VertexInput input)
{
    _2 = input.positionOS; _3 = input.uv; vert_main();
    EID4922Varyings o; o.positionCS=gl_Position; o.worldPos=_5; o.screenPos=_7; o.prevPos=_8; return o;
}
struct EID4922FragInput { float4 positionCS : SV_Position; float3 worldPos : TEXCOORD0; float3 screenPos : TEXCOORD2; float3 prevPos : TEXCOORD3; };
struct EID4922FragOutput { float4 rt0 : SV_Target0; float4 rt1 : SV_Target1; };
EID4922FragOutput EID4922PixelMain(EID4922FragInput input)
{
    gl_FragCoord=input.positionCS; gl_FragCoord.w=1.0/max(input.positionCS.w,1e-6); _4=input.worldPos; _5=input.screenPos; _6=input.prevPos; frag_main();
    EID4922FragOutput o; o.rt0=_7; o.rt1=_8; return o;
}
'''
open(out,'w',encoding='utf8').write('// RenderDoc EID4922 direct shader port. Generated from RenderDoc SPIR-V cross-compilation.\n'+vs_full+'\n'+ps_local+'\n'+ps_res+'\n'+ps_body+'\n'+wrapper)
print(out,os.path.getsize(out))
