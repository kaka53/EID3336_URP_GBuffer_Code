def sval(v):
 d={'name':v.name,'type':str(v.type),'rows':v.rows,'columns':v.columns}
 for n in ['value','fv','iv','uv','dv']:
  try:d[n]=list(getattr(v,n))
  except:pass
 try:d['members']=[sval(x) for x in v.members]
 except:pass
 return d
def work(c):
 c.SetFrameEvent(2012,True);s=c.GetPipelineState();p=s.GetGraphicsPipelineObject();out={}
 for stage,key in [(rd.ShaderStage.Vertex,'VS'),(rd.ShaderStage.Pixel,'PS')]:
  refl=s.GetShaderReflection(stage);arr=[]
  for i,u in enumerate(s.GetConstantBlocks(stage)):
   d=u.descriptor
   vs=c.GetCBufferVariableContents(p,s.GetShader(stage),stage,s.GetShaderEntryPoint(stage),i,d.resource,d.byteOffset,d.byteSize)
   arr.append([sval(x) for x in vs])
  out[key]=arr
 return out
ctx.replay(work)
