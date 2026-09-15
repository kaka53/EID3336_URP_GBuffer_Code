import struct,json,pathlib,math
p=pathlib.Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/EID3332_EID3336_Combined/EID2044_RenderDoc/Captured')
inst=(p/'VS_uniforms0_65536.bytes').read_bytes();f=struct.unpack_from('<64f',inst,0)
ps=struct.unpack('<12f',(p/'PS_uniforms4_48.bytes').read_bytes())
g=struct.unpack_from('<f',(p/'PS_uniforms16_3200.bytes').read_bytes(),26*16)[0]
s0=(p/'vertex_stream0.bytes').read_bytes(); n=len(s0)//16
poss=[struct.unpack_from('<3f',s0,i*16) for i in range(n)]
mins=[min(x[k] for x in poss) for k in range(3)]; maxs=[max(x[k] for x in poss) for k in range(3)]
print(json.dumps({'vertexCount':n,'translation':list(f[12:15]),'firstMatrixRaw':list(f[:16]),'struct64':list(f),'psLocal12':list(ps),'mipBias':g,'boundsMin':mins,'boundsMax':maxs,'boundsCenter':[(mins[i]+maxs[i])/2 for i in range(3)],'boundsSize':[maxs[i]-mins[i] for i in range(3)]},indent=2))
