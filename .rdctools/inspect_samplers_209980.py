def work(c):
 c.SetFrameEvent(2768,False);s=c.GetPipelineState();return [inspect(u.sampler) for u in s.GetSamplers(rd.ShaderStage.Pixel)]
print(ctx.replay(work))
