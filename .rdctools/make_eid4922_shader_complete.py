from pathlib import Path
import re, os
src=Path('.rdctools/eid4922')
out=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Shaders/EID4922Sky.hlsl')
vs=(src/'VS.cross.hlsl').read_text()
ps=(src/'PS.cross.hlsl').read_text()

# Preserve exact reflected layouts. Registers are removed because Unity binds CBs by name.
vs_decl=vs[:vs.index('struct SPIRV_Cross_Input')]
vs_decl=re.sub(r'cbuffer _10_11', 'cbuffer EID4922FrameCB', vs_decl, count=1)
vs_decl=re.sub(r'cbuffer _12_13', 'cbuffer EID4922ViewCB', vs_decl, count=1)
vs_decl=re.sub(r'cbuffer _14_15', 'cbuffer EID4922ObjectCB', vs_decl, count=1)
vs_decl=re.sub(r'\s*:\s*register\(b\d+\)', '', vs_decl)
vs_func=vs[vs.index('void vert_main()'):vs.index('SPIRV_Cross_Output main(')]

ps_local=re.search(r'cbuffer _31_32.*?\n\};', ps, re.S).group(0)
ps_local=ps_local.replace('cbuffer _31_32', 'cbuffer EID4922SkyCB')
ps_local=re.sub(r'\s*:\s*register\(b\d+\)', '', ps_local)
res_start=ps.index('SamplerState _14')
res_end=ps.index('static float4 gl_FragCoord;')
ps_res=re.sub(r'\s*:\s*register\([ts]\d+\)', '', ps[res_start:res_end])
ps_globals=ps[:ps.index('cbuffer _9_10')] + ps[res_end:ps.index('struct SPIRV_Cross_Input')]
ps_func=ps[ps.index('void frag_main()'):ps.index('SPIRV_Cross_Output main(')]

# PS global frame/view blocks are byte-identical to the VS frame/view buffers.
for block in (ps_globals, ps_func):
    pass
ps_globals=ps_globals.replace('_10_m', '_11_m').replace('_12_m', '_13_m')
ps_func=ps_func.replace('_10_m', '_11_m').replace('_12_m', '_13_m')

# Rename sampled resources to stable Unity property names.
for old,new in [('_18','_EID4922Res18'),('_19','_EID4922Res19'),('_20','_EID4922Res20'),('_21','_EID4922Res21'),('_23','_EID4922Res23'),('_25','_EID4922Res25'),('_27','_EID4922Res27'),('_29','_EID4922Res29')]:
    pat=r'(?<![A-Za-z0-9])'+re.escape(old)+r'(?![A-Za-z0-9])'
    ps_res=re.sub(pat,new,ps_res); ps_func=re.sub(pat,new,ps_func)
for old,new in [('_14','sampler_EID4922Res19'),('_15','sampler_EID4922Res20'),('_22','sampler_EID4922Res21'),('_24','sampler_EID4922Res23'),('_26','sampler_EID4922Res25'),('_28','sampler_EID4922Res27'),('_30','sampler_EID4922Res29')]:
    pat=r'(?<![A-Za-z0-9])'+re.escape(old)+r'(?![A-Za-z0-9])'
    ps_res=re.sub(pat,new,ps_res); ps_func=re.sub(pat,new,ps_func)

# VS and PS SPIR-V modules reuse short global identifiers. Separate only those globals;
# all math and temporary ordering inside each original function stays unchanged.
for old,new in [('_4','ps_in0'),('_5','ps_in2'),('_6','ps_in3'),('_7','ps_out0'),('_8','ps_out1')]:
    pat=r'(?<![A-Za-z0-9])'+re.escape(old)+r'(?![A-Za-z0-9])'
    ps_globals=re.sub(pat,new,ps_globals); ps_func=re.sub(pat,new,ps_func)

wrapper=r'''
struct EID4922VertexInput
{
    float3 positionOS : POSITION;
    float2 uv : TEXCOORD0;
};
struct EID4922Varyings
{
    float4 positionCS : SV_Position;
    float3 worldPos : TEXCOORD0;
    float3 screenPos : TEXCOORD2;
    float3 previousScreenPos : TEXCOORD3;
};
EID4922Varyings EID4922VertexMain(EID4922VertexInput input)
{
    _2 = input.positionOS;
    _3 = input.uv;
    vert_main();
    EID4922Varyings o;
    o.positionCS = gl_Position;
    o.worldPos = _5;
    o.screenPos = _7;
    o.previousScreenPos = _8;
    return o;
}
float4 EID4922PixelMain(EID4922Varyings input) : SV_Target0
{
    gl_FragCoord = input.positionCS;
    gl_FragCoord.w = 1.0 / max(input.positionCS.w, 1e-6);
    ps_in0 = input.worldPos;
    ps_in2 = input.screenPos;
    ps_in3 = input.previousScreenPos;
    frag_main();
    return ps_out0;
}
'''
text='// EID4922 direct RenderDoc SPIR-V port. Layout names changed only for Unity binding.\n'+vs_decl+'\n'+vs_func+'\n'+ps_local+'\n'+ps_res+'\n'+ps_globals+'\n'+ps_func+'\n'+wrapper
out.write_text(text)
print(out, len(text), 'vert', text.count('void vert_main()'), 'frag', text.count('void frag_main()'))
