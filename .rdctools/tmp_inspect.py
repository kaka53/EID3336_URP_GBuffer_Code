def work(c):
 return {'doc':getattr(c.GetShader,'__doc__',None),'text':getattr(c.GetShader,'__text_signature__',None),'state':getattr(c.GetPipelineState,'__doc__',None)}
print(ctx.replay(work))
