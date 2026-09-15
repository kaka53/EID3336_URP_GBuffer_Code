import struct,pathlib,math
p=pathlib.Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/EID3332_EID3336_Combined/EID2012_RenderDoc/Captured/vertex_stream0.bytes').read_bytes();n=len(p)//16
vals=[struct.unpack_from('<f',p,i*16+12)[0] for i in range(n)];bits=[struct.unpack_from('<I',p,i*16+12)[0] for i in range(n)]
print('n',n,'nan',sum(math.isnan(x) for x in vals),'inf',sum(math.isinf(x) for x in vals),'packedFlag',sum((b&0x40000000)!=0 for b in bits),'minBits',hex(min(bits)),'maxBits',hex(max(bits)))
print('first',[(vals[i],hex(bits[i])) for i in range(12)])
