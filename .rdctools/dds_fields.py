import struct,os
root=r'Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/CapturedResources'
for f in ['Texture_RID15375.dds','Texture_RID209575.dds']:
 b=open(os.path.join(root,f),'rb').read(); print('\n',f)
 for off in [76,80,84,88,92,96,100,104,108,112,116,120,124,128,132,136,140,144]: print(off, b[off:off+4], struct.unpack_from('<I',b,off)[0])
