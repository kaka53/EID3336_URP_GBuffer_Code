def work(c):
 c.SetFrameEvent(2768,False); s=c.GetPipelineState(); p=s.GetGraphicsPipelineObject(); return {'p':inspect(p),'vs':repr(s.GetShader(rd.ShaderStage.Vertex)),'ps':repr(s.GetShader(rd.ShaderStage.Pixel))}
print(ctx.replay(work))
