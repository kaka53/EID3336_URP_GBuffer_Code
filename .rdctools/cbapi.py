def work(c):
 return {'doc':getattr(c.GetCBufferVariableContents,'__doc__',None),'str':str(c.GetCBufferVariableContents)}
ctx.replay(work)
