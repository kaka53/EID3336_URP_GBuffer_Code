import struct
def work(c):
 out=[]
 for eid in [2004,2008,2012,2016,2020]:
  c.SetFrameEvent(eid,True);s=c.GetPipelineState();ps=int(s.GetShader(rd.ShaderStage.Pixel));vs=int(s.GetShader(rd.ShaderStage.Vertex));vals=[]
  for u in s.GetConstantBlocks(rd.ShaderStage.Pixel):
   d=u.descriptor;data=bytes(c.GetBufferData(d.resource,d.byteOffset,d.byteSize));vals.append({'binding':u.access.byteOffset,'rid':int(d.resource),'off':d.byteOffset,'size':d.byteSize,'first12':list(struct.unpack_from('<'+str(min(12,len(data)//4))+'f',data,0))})
  out.append({'eid':eid,'vs':vs,'ps':ps,'cbs':vals})
 return out
ctx.replay(work)
