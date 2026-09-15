def work(c):
 c.SetFrameEvent(2768,False); s=c.GetPipelineState(); vs=int(s.GetShader(rd.ShaderStage.Vertex)); ps=int(s.GetShader(rd.ShaderStage.Pixel));
 return {'vs':vs,'ps':ps,'vep':s.GetShaderEntryPoint(rd.ShaderStage.Vertex),'pep':s.GetShaderEntryPoint(rd.ShaderStage.Pixel),'vsobj':inspect(c.GetShader(vs,rd.ShaderStage.Vertex,s.GetShaderEntryPoint(rd.ShaderStage.Vertex))),'psobj':inspect(c.GetShader(ps,rd.ShaderStage.Pixel,s.GetShaderEntryPoint(rd.ShaderStage.Pixel)))}
print(ctx.replay(work))
