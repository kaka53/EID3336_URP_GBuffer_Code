def sv(v):
 return {'name':v.name,'rows':v.rows,'columns':v.columns,'f32':list(v.value.f32v),'u32':list(v.value.u32v)}
def work(c):
 c.SetFrameEvent(2012,True);s=c.GetPipelineState();p=s.GetGraphicsPipelineObject();out=[]
 for i,u in enumerate(s.GetConstantBlocks(rd.ShaderStage.Pixel)):
  d=u.descriptor;out.append([sv(x) for x in c.GetCBufferVariableContents(p,s.GetShader(rd.ShaderStage.Pixel),rd.ShaderStage.Pixel,s.GetShaderEntryPoint(rd.ShaderStage.Pixel),i,d.resource,d.byteOffset,d.byteSize)])
 return out
ctx.replay(work)
