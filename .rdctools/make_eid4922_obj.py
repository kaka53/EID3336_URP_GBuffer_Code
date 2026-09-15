import struct, os
root=r'Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/CapturedResources'
out=r'Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Meshes/EID4922_SkySphere.obj'
vb=open(os.path.join(root,'VertexBuffer0.bin'),'rb').read(); ib=open(os.path.join(root,'IndexBuffer.bin'),'rb').read()
verts=[]
for i in range(42):
 p=struct.unpack_from('<3f',vb,i*32); uv=struct.unpack_from('<2f',vb,i*32+24); verts.append((p,uv))
idx=struct.unpack('<%dH'%(len(ib)//2),ib)
with open(out,'w',encoding='utf8') as f:
 f.write('# EID4922 EID4922 vertex input: position float3 @0, uv float2 @24, stride 32\n')
 for p,uv in verts:f.write('v %.9g %.9g %.9g\n'%p)
 for p,uv in verts:f.write('vt %.9g %.9g\n'%uv)
 for i in range(0,len(idx),3):
  a,b,c=[x+1 for x in idx[i:i+3]]; f.write('f %d/%d %d/%d %d/%d\n'%(a,a,c,c,b,b))
print(out, len(verts), len(idx)//3)
