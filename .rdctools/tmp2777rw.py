def work(c):
 c.SetFrameEvent(2777,False);s=c.GetPipelineState();out=[]
 for u in s.GetReadWriteResources(rd.ShaderStage.Vertex):
  d=u.descriptor;out.append({'resource':int(d.resource),'offset':int(d.byteOffset),'size':int(d.byteSize),'type':str(d.type),'format':serialize.format_description(d.format),'access':{'set':int(u.access.stage) if False else str(u.access),'byteOffset':int(u.access.byteOffset),'byteSize':int(u.access.byteSize)}})
 return out
print(ctx.replay(work))
