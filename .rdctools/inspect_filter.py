def work(c):
 c.SetFrameEvent(2768,False);q=c.GetPipelineState().GetSamplers(rd.ShaderStage.Pixel)[0].sampler.filter;return inspect(q)
print(ctx.replay(work))
