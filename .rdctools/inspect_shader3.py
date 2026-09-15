def work(c):
 c.SetFrameEvent(2768,False); s=c.GetPipelineState(); vs=s.GetShader(rd.ShaderStage.Vertex); ps=s.GetShader(rd.ShaderStage.Pixel); ve=s.GetShaderEntryPoint(rd.ShaderStage.Vertex); pe=s.GetShaderEntryPoint(rd.ShaderStage.Pixel)
 return {'vs':str(vs),'ps':str(ps),'vep':ve,'pep':pe,'vsobj':inspect(c.GetShader(vs,rd.ShaderStage.Vertex,ve)),'psobj':inspect(c.GetShader(ps,rd.ShaderStage.Pixel,pe))}
print(ctx.replay(work))
