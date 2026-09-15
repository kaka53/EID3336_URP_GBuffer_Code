import struct,os
root=r'Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/CapturedResources'
for f in ['Texture_RID15375.dds','Texture_RID209575.dds']:
 b=open(os.path.join(root,f),'rb').read();print(f,len(b),b[:4],struct.unpack_from('<I',b,4)[0])
 # print header words 0-40
 print(list(struct.unpack_from('<20I',b,4)))
