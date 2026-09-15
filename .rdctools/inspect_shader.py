def work(c):
 c.SetFrameEvent(2768,False); s=c.GetPipelineState();
 return {'shader_reflection':inspect(s.GetShaderReflection(rd.ShaderStage.Vertex)),'controller_shader':inspect(c.GetShader(int(s.GetShader(rd.ShaderStage.Vertex))))}
print(ctx.replay(work))
