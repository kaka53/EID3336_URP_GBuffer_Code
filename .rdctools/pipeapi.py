def work(c):
 c.SetFrameEvent(2012,True);s=c.GetPipelineState()
 return [x for x in dir(s) if 'Pipeline' in x or 'Object' in x]
ctx.replay(work)
