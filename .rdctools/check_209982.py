import json
EIDS=[2926,2930,2935,2939,2944,2948,2952,2956,2961,2966,2971,2975,2980,2984,2989,2994,2998,3003]
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


