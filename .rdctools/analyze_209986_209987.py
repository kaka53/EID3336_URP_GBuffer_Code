import json,hashlib,struct,os
EIDS=[3274,3278,3282,3286,3290,3294,3298,3302,3306,3310,3315,3320,3324,3328,3332,3336,3340,3344,3348,3353,3358,3362,3366,3370,3374]
OUT=r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/ColourPass6_VS209986_PS209987'
os.makedirs(OUT,exist_ok=True)
def rid(x):
 try:return int(x)
 except:return 0
def work(c):
 actions={}
 def walk(xs):
  for a in xs:
   if a.eventId in EIDS:actions[a.eventId]=a
   walk(a.children)
 walk(c.GetRootActions())
 texdesc={rid(t.resourceId):t for t in c.GetTextures()}; rows=[]
 for eid in EIDS:
  a=actions[eid];c.SetFrameEvent(eid,False);s=c.GetPipelineState();rec={'eid':eid,'draw':{'indices':a.numIndices,'instances':a.numInstances,'indexOffset':a.indexOffset,'baseVertex':a.baseVertex,'vertexOffset':a.vertexOffset},'vs':rid(s.GetShader(rd.ShaderStage.Vertex)),'ps':rid(s.GetShader(rd.ShaderStage.Pixel)),'inputs':[],'vbs':[],'ib':{},'cb':{},'textures':{},'samplers':{}}
  for x in s.GetVertexInputs():rec['inputs'].append({'name':x.name,'slot':x.vertexBuffer,'offset':x.byteOffset,'format':x.format.Name(),'perInstance':x.perInstance,'rate':x.instanceRate})
  for i,v in enumerate(s.GetVBuffers()):
   if any(x['slot']==i for x in rec['inputs']):rec['vbs'].append({'slot':i,'rid':rid(v.resourceId),'offset':v.byteOffset,'stride':v.byteStride})
  ib=s.GetIBuffer();rec['ib']={'rid':rid(ib.resourceId),'offset':ib.byteOffset,'stride':ib.byteStride}
  for stage,key in [(rd.ShaderStage.Vertex,'VS'),(rd.ShaderStage.Pixel,'PS')]:
   refl=s.GetShaderReflection(stage); rec['cb'][key]=[]
   for i,u in enumerate(s.GetConstantBlocks(stage)):
    d=u.descriptor;data=bytes(c.GetBufferData(d.resource,d.byteOffset,d.byteSize));name=refl.constantBlocks[i].name if i<len(refl.constantBlocks) else 'cb%d'%i
    rec['cb'][key].append({'slot':i,'name':name,'binding':u.access.byteOffset,'rid':rid(d.resource),'offset':d.byteOffset,'size':d.byteSize,'sha256':hashlib.sha256(data).hexdigest()})
   rec['textures'][key]=[];rr=list(refl.readOnlyResources)
   for i,u in enumerate(s.GetReadOnlyResources(stage)):
    d=u.descriptor;r=rid(d.resource);td=texdesc.get(r);name=rr[i].name if i<len(rr) else 'tex%d'%i
    rec['textures'][key].append({'slot':i,'name':name,'binding':u.access.byteOffset,'rid':r,'firstMip':d.firstMip,'numMips':d.numMips,'firstSlice':d.firstSlice,'numSlices':d.numSlices,'format':td.format.Name() if td else '', 'width':td.width if td else 0,'height':td.height if td else 0,'mips':td.mips if td else 0})
   rec['samplers'][key]=[]
   for i,u in enumerate(s.GetSamplers(stage)):
    sp=u.sampler;rec['samplers'][key].append({'slot':i,'binding':u.access.byteOffset,'addressU':str(sp.addressU),'addressV':str(sp.addressV),'addressW':str(sp.addressW),'filter':str(sp.filter),'mipBias':sp.mipBias})
  rows.append(rec)
 # summaries
 texture_usage={};cb_usage={};layout_usage={}
 for r in rows:
  lk=json.dumps(r['inputs'],sort_keys=True,separators=(',',':'));lh=hashlib.sha256(lk.encode()).hexdigest()[:16];r['layoutHash']=lh;layout_usage.setdefault(lh,[]).append(r['eid'])
  for stage in ['VS','PS']:
   for t in r['textures'][stage]: texture_usage.setdefault(str(t['rid']),{'desc':t,'eids':[],'bindings':[]});texture_usage[str(t['rid'])]['eids'].append(r['eid']);texture_usage[str(t['rid'])]['bindings'].append(stage+':'+t['name']+'@'+str(t['binding']))
   for b in r['cb'][stage]: cb_usage.setdefault(b['sha256'],{'name':b['name'],'stage':stage,'size':b['size'],'eids':[],'locations':[]});cb_usage[b['sha256']]['eids'].append(r['eid']);cb_usage[b['sha256']]['locations'].append({'rid':b['rid'],'offset':b['offset'],'binding':b['binding']})
 out={'eids':EIDS,'rows':rows,'layoutUsage':layout_usage,'textureUsage':texture_usage,'constantBufferHashUsage':cb_usage}
 open(os.path.join(OUT,'VS209986_PS209987_commonality.json'),'w',encoding='utf-8').write(json.dumps(out,indent=2))
 return {'layouts':layout_usage,'uniqueTextureRIDs':len(texture_usage),'textureUsage':texture_usage,'uniqueCBHashes':len(cb_usage),'cbReuse':[{'hash':k,'name':v['name'],'stage':v['stage'],'size':v['size'],'eidCount':len(set(v['eids']))} for k,v in cb_usage.items()]}
ctx.replay(work)
