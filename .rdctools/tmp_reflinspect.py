def work(c):
 c.SetFrameEvent(2768,False);s=c.GetPipelineState();r=s.GetShaderReflection(rd.ShaderStage.Pixel)
 return inspect(r)
print(ctx.replay(work))
