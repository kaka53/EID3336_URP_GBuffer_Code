import json
EIDS=[2681,2683,2691,2693,2630,2634,2639,2644,2648,2652,2656,2660,2665,2669,2673,2677,2687,2697,2701,2705,2709,2713,2717,2722,2727,2732,2737,2741,2745,2750,2755,2759,2763]
def work(c):
 actions={}
 def walk(xs):
  for a in xs:
   if a.eventId in EIDS: actions[a.eventId]=a
   walk(a.children)
 walk(c.GetRootActions())
 out={'found':sorted(actions),'missing':[e for e in EIDS if e not in actions], 'details':{}}
 for eid in EIDS:
  if eid not in actions: continue
  c.SetFrameEvent(eid,False);s=c.GetPipelineState();ins=list(s.GetVertexInputs());
  out['details'][str(eid)]={'numIndices':actions[eid].numIndices,'numInstances':actions[eid].numInstances,'vs':int(s.GetShader(rd.ShaderStage.Vertex)),'ps':int(s.GetShader(rd.ShaderStage.Pixel)),'inputs':[{'name':x.name,'slot':x.vertexBuffer,'offset':x.byteOffset,'format':x.format.Name(),'perInstance':x.perInstance,'rate':x.instanceRate} for x in ins]}
 return out
print(json.dumps(ctx.replay(work),default=str))

