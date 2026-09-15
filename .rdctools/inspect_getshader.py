def work(c):
 return {'getshader':inspect(c.GetShader),'getpipeline':inspect(c.GetPipelineState)}
print(ctx.replay(work))
