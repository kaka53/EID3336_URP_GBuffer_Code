def simp(a,depth=0):
 return {'eid':a.eventId,'name':a.GetName(ctx.GetStructuredFile()) if False else '', 'flags':str(a.flags),'children':[simp(x,depth+1) for x in a.children]}
def work(c):
 def rec(a,d=0):
  return {'eid':a.eventId,'name':a.GetName(c.GetStructuredFile()),'flags':str(a.flags),'numChildren':len(a.children),'children':[rec(x,d+1) for x in a.children]}
 return [rec(a) for a in c.GetRootActions()]
ctx.replay(work)
