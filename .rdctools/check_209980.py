import json
EIDS=[2768,2772,2777,2782,2787,2791,2795,2799,2804,2809,2813,2818,2823,2828,2833,2838,2842,2847,2851,2856,2860,2865,2870,2874,2876,2880,2882,2886,2891,2896,2900,2905,2907,2912,2916]
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
