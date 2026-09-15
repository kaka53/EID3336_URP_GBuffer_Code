def work(c):
 c.SetFrameEvent(2012,True);s=c.GetPipelineState()
 return [{'i':i,'resource':str(x.resource),'rid':int(x.resource)} for i,x in enumerate(s.GetOutputTargets())]
ctx.replay(work)
