def work(c):
 eid=2044;c.SetFrameEvent(eid,True);s=c.GetPipelineState();a=None;near=[]
 def walk(xs):
  nonlocal a
  for x in xs:
   if abs(x.eventId-eid)<=8: near.append(serialize.action_description(x))
   if x.eventId==eid:a=serialize.action_description(x)
   walk(x.children)
 walk(c.GetRootActions())
 return {'event':eid,'action':a,'nearby':near,'pipeline':serialize.pipeline_state(s),'vertexInputs':[{'name':x.name,'vb':x.vertexBuffer,'offset':x.byteOffset,'perInstance':x.perInstance,'rate':x.instanceRate,'format':x.format.Name()} for x in s.GetVertexInputs()]}
ctx.replay(work)
