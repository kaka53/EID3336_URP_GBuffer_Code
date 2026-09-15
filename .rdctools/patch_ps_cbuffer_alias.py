from pathlib import Path
p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Shaders/EID4922Sky.hlsl')
s=p.read_text()
# PS body is after local cbuffer and resource declarations; replace only after EID4922SkyCB block to avoid touching VS declarations.
marker='cbuffer EID4922SkyCB'
pos=s.index(marker)
end=s.index('static float4 gl_FragCoord;',pos)
pre=s[:pos]; mid=s[pos:end]; post=s[end:]
post=post.replace('_10_m','_11_m').replace('_12_m','_13_m')
p.write_text(pre+mid+post)
