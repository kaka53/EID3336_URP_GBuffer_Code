def work(c):
 c.SetFrameEvent(2012,True);s=c.GetPipelineState();o=s.GetOutputTargets()[0];d=s.GetDepthTarget()
 return {'outDir':[x for x in dir(o) if not x.startswith('_')], 'outStr':str(o), 'depthDir':[x for x in dir(d) if not x.startswith('_')], 'depthStr':str(d)}
ctx.replay(work)
