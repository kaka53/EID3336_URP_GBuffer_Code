import struct,os,json
root=r'Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/CapturedResources'
b=open(os.path.join(root,'IndexBuffer.bin'),'rb').read();idx=list(struct.unpack('<%dH'%(len(b)//2),b));print('idx',len(idx),'minmax',min(idx),max(idx), 'unique',len(set(idx)))
v=open(os.path.join(root,'VertexBuffer0.bin'),'rb').read();print('verts',len(v)//32)
for i in range(min(10,len(v)//32)):
 p=struct.unpack_from('<3f',v,i*32); uv=struct.unpack_from('<2f',v,i*32+24); print(i,tuple(round(x,4) for x in p),tuple(round(x,4) for x in uv))
