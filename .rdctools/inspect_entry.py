def work(c):
 c.SetFrameEvent(2768,False); s=c.GetPipelineState(); return {'shader':repr(s.GetShader(rd.ShaderStage.Vertex)),'entry':repr(s.GetShaderEntryPoint(rd.ShaderStage.Vertex)),'stage':repr(rd.ShaderStage.Vertex),'entrytype':str(type(s.GetShaderEntryPoint(rd.ShaderStage.Vertex)))}
print(ctx.replay(work))
