def work(c):
 c.SetFrameEvent(2012,True);s=c.GetPipelineState()
 return [x for x in dir(s) if any(k in x for k in ['Raster','Depth','Stencil','Blend','Viewport','Scissor'])]
ctx.replay(work)
