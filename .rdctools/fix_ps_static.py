from pathlib import Path
p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Shaders/EID4922Sky.hlsl')
s=p.read_text(); marker='static float4 gl_FragCoord;'; s=s.replace(marker,'static float3 _204;\nstatic uint _205;\n'+marker,1); p.write_text(s)
# Keep extraction generator reproducible.
p=Path('.rdctools/make_eid4922_shader_complete.py'); s=p.read_text();
s=s.replace("ps_globals=ps[res_end:ps.index('struct SPIRV_Cross_Input')]", "ps_globals=ps[:ps.index('cbuffer _9_10')] + ps[res_end:ps.index('struct SPIRV_Cross_Input')]")
s=s.replace('float3 positionOS : TEXCOORD0;', 'float3 positionOS : POSITION;').replace('float2 uv : TEXCOORD1;', 'float2 uv : TEXCOORD0;')
p.write_text(s)
