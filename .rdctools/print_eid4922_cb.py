import struct,os
root=r'Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/CapturedResources'
for f in ['VS_uniforms15.bin','VS_uniforms11.bin','VS_uniforms13.bin','PS_uniforms32.bin','PS_uniforms10.bin','PS_uniforms12.bin']:
 b=open(os.path.join(root,f),'rb').read(); print('\n',f,len(b))
 for off in range(0,len(b),16):
  v=struct.unpack_from('<4f',b,off)
  if max(abs(x) for x in v)>1e-5:
   print(off//16,tuple(round(x,6) for x in v))
