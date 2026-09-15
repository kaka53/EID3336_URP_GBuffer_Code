import struct,json,pathlib,math
p=pathlib.Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/EID3332_EID3336_Combined/EID2012_RenderDoc/Captured')
vs0=(p/'VS_uniforms0_65536.bytes').read_bytes();f=struct.unpack_from('<64f',vs0,0)
# rows as used in decomp: m0[0..3], translation in w of rows 0..2
M=[[f[r*4+c] for c in range(4)] for r in range(4)]
ps4=(p/'PS_uniforms4_48.bytes').read_bytes(); g=struct.unpack('<12f',ps4)
glob=(p/'PS_uniforms16_3200.bytes').read_bytes(); gm16=struct.unpack_from('<f',glob,26*16)[0]
s3=(p/'vertex_stream3.bytes').read_bytes()
print(json.dumps({'matrix_rows':M,'struct64':list(f),'ps4_12f':list(g),'ps_mip_bias_m16':gm16,'stream3_hex':s3.hex(),'stream3_floats':list(struct.unpack('<5f',s3))},indent=2))
