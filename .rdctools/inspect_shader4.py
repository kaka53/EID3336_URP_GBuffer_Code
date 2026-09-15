def work(c):
 c.SetFrameEvent(2768,False); s=c.GetPipelineState(); p=s.GetGraphicsPipelineObject(); vs=s.GetShader(rd.ShaderStage.Vertex); ps=s.GetShader(rd.ShaderStage.Pixel)
 return {'vsobj':inspect(c.GetShader(vs,rd.ShaderStage.Vertex,p)),'psobj':inspect(c.GetShader(ps,rd.ShaderStage.Pixel,p))}
print(ctx.replay(work))
