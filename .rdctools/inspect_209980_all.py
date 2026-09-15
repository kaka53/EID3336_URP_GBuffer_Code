import json
EIDS=[2768,2772,2777,2782,2787,2791,2795,2799,2804,2809,2813,2818,2823,2828,2833,2838,2842,2847,2851,2856,2860,2865,2870,2874,2876,2880,2882,2886,2891,2896,2900,2905,2907,2912,2916]
def rid(x):
 try:return int(x)
 except:return 0
def desc(o):
 d={}
 for n in ['resourceId','byteOffset','byteStride','byteSize','format','width','height','mips','arraysize','arraySize','resource','type','access']:
  try:
   v=getattr(o,n)
   try:v=serialize.format_description(v)
   except: v=str(v) if n in ('format','type','access') else v
   d[n]=v
  except:pass
 return d
def work(c):
 actions={}
 def walk(xs):
  for a in xs:
   if a.eventId in EIDS:actions[a.eventId]=a
   walk(a.children)
 walk(c.GetRootActions());out={}
 for eid in EIDS:
  c.SetFrameEvent(eid,False);s=c.GetPipelineState();row={'draw':{n:getattr(actions[eid],n) for n in ['numIndices','numInstances','indexOffset','baseVertex','vertexOffset']},'vs':rid(s.GetShader(rd.ShaderStage.Vertex)),'ps':rid(s.GetShader(rd.ShaderStage.Pixel)),'entry':{'vs':str(s.GetShaderEntryPoint(rd.ShaderStage.Vertex)),'ps':str(s.GetShaderEntryPoint(rd.ShaderStage.Pixel))},'vinputs':[],'vbuffers':[],'ibuffer':desc(s.GetIBuffer()),'cbs':{},'resources':{},'samplers':[]}
  for x in s.GetVertexInputs(): row['vinputs'].append({'name':x.name,'slot':x.vertexBuffer,'offset':x.byteOffset,'format':serialize.format_description(x.format),'perInstance':bool(x.perInstance),'rate':x.instanceRate})
  for i,v in enumerate(s.GetVBuffers()): row['vbuffers'].append({'slot':i,**desc(v)})
  for st,key in [(rd.ShaderStage.Vertex,'VS'),(rd.ShaderStage.Pixel,'PS')]:
   refl=s.GetShaderReflection(st); blocks=[]
   for i,u in enumerate(s.GetConstantBlocks(st)):
    d=u.descriptor; blocks.append({'index':i,'name':refl.constantBlocks[i].name if i<len(refl.constantBlocks) else 'cb%d'%i,'descriptor':desc(d),'access':str(u.access)})
   row['cbs'][key]={'blocks':blocks,'reflection':serialize.shader_reflection(refl)}
   try: row['resources'][key]=[{'index':i,'descriptor':desc(u.descriptor),'access':str(u.access)} for i,u in enumerate(s.GetReadOnlyResources(st))]
   except Exception as e: row['resources'][key]={'error':str(e)}
   try: row['samplers'] += [{'stage':key,'index':i,'sampler':inspect(u)} for i,u in enumerate(s.GetSamplers(st))]
   except:pass
  out[str(eid)]=row
 return out
r=ctx.replay(work)
open(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/inspect_209980_all.json','w',encoding='utf8').write(json.dumps(r,default=str,indent=2))
print({'eids':len(r),'first':r.get('2768')})
