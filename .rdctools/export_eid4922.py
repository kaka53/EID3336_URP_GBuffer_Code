import os,json,hashlib,struct
EID=4922
ROOT=r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky'
CAP=os.path.join(ROOT,'CapturedResources'); os.makedirs(CAP,exist_ok=True)

def rid(x):
 try:return int(x)
 except:return 0

def desc_plain(td):
 out={}
 for n in ['width','height','depth','mips','arraysize','format','dimension','resType','creationFlags','msSamp','byteSize']:
  try:
   v=getattr(td,n); out[n]=v.Name() if hasattr(v,'Name') else str(v)
  except: pass
 return out

def work(c):
 actions={}
 def walk(xs):
  for a in xs: actions[a.eventId]=a; walk(a.children)
 walk(c.GetRootActions()); a=actions[EID]; c.SetFrameEvent(EID,False); s=c.GetPipelineState(); pso=s.GetGraphicsPipelineObject()
 tex={rid(t.resourceId):t for t in c.GetTextures()}
 result={'eid':EID,'draw':{n: str(getattr(a,n)) for n in ['numIndices','numInstances','indexOffset','baseVertex','vertexOffset','instanceOffset']},'vertexInputs':[],'buffers':[],'index':{},'constantBuffers':{},'textures':[],'samplers':[],'outputs':[],'depth':{},'files':{}}
 for x in s.GetVertexInputs(): result['vertexInputs'].append({'name':x.name,'slot':x.vertexBuffer,'offset':x.byteOffset,'format':x.format.Name(),'perInstance':x.perInstance,'instanceRate':x.instanceRate})
 for i,v in enumerate(s.GetVBuffers()):
  if int(v.resourceId)==0:continue
  result['buffers'].append({'slot':i,'rid':rid(v.resourceId),'offset':v.byteOffset,'stride':v.byteStride,'name':get_resource_name(v.resourceId)})
  if i==0 and v.byteStride:
   n=max(1,int(a.numIndices)); raw=bytes(c.GetBufferData(v.resourceId,v.byteOffset,n*v.byteStride)); fn='VertexBuffer0.bin';open(os.path.join(CAP,fn),'wb').write(raw);result['files']['vertexBuffer0']=fn
 ib=s.GetIBuffer(); raw=bytes(c.GetBufferData(ib.resourceId,ib.byteOffset,int(a.numIndices)*ib.byteStride)); fn='IndexBuffer.bin';open(os.path.join(CAP,fn),'wb').write(raw);result['index']={'rid':rid(ib.resourceId),'offset':ib.byteOffset,'stride':ib.byteStride,'name':get_resource_name(ib.resourceId),'bytes':len(raw),'file':fn}
 result['files']['VS.cross.hlsl']='VS.cross.hlsl'; result['files']['PS.cross.hlsl']='PS.cross.hlsl'
 for stage,key in [(rd.ShaderStage.Vertex,'VS'),(rd.ShaderStage.Pixel,'PS')]:
  sh=s.GetShader(stage); refl=s.GetShaderReflection(stage); ep=s.GetShaderEntryPoint(stage)
  for i,u in enumerate(s.GetConstantBlocks(stage)):
   d=u.descriptor; data=bytes(c.GetBufferData(d.resource,d.byteOffset,d.byteSize)); name=refl.constantBlocks[i].name if refl and i<len(refl.constantBlocks) else 'cb%d'%i; fn=key+'_'+name+'.bin';open(os.path.join(CAP,fn),'wb').write(data)
   ent={'stage':key,'slot':i,'name':name,'binding':u.access.byteOffset,'rid':rid(d.resource),'offset':d.byteOffset,'size':d.byteSize,'file':fn,'f32':list(struct.unpack('<%df'%(len(data)//4),data))}
   result['constantBuffers'].setdefault(key,[]).append(ent)
  rr=list(refl.readOnlyResources) if refl else []
  for i,u in enumerate(s.GetReadOnlyResources(stage)):
   d=u.descriptor; r=rid(d.resource);td=tex.get(r); name=rr[i].name if i<len(rr) else 'res%d'%i
   ent={'stage':key,'slot':i,'name':name,'binding':u.access.byteOffset,'rid':r,'resourceName':get_resource_name(d.resource),'desc':desc_plain(td) if td else {},'firstMip':d.firstMip,'numMips':d.numMips,'firstSlice':d.firstSlice,'numSlices':d.numSlices}
   result['textures'].append(ent)
  for i,u in enumerate(s.GetSamplers(stage)):
   sp=u.sampler; result['samplers'].append({'stage':key,'slot':i,'binding':u.access.byteOffset,'addressU':str(sp.addressU),'addressV':str(sp.addressV),'addressW':str(sp.addressW),'filter':str(sp.filter),'mipBias':sp.mipBias})
 # capture texture resources once
 for ent in result['textures']:
  r=ent['rid'];
  if not r or not tex.get(r):continue
  fn='Texture_RID%d.dds'%r; path=os.path.join(CAP,fn); cfg=rd.TextureSave(); cfg.resourceId=tex[r].resourceId; cfg.destType=rd.FileType.DDS; cfg.mip=-1; cfg.slice=rd.TextureSliceMapping();
  try: save=c.SaveTexture(cfg,path); ent['saveResult']=str(save); ent['file']=fn
  except Exception as ex: ent['saveError']=str(ex)
 # RTs after draw and before/after snapshots
 for i,o in enumerate(s.GetOutputTargets()):
  r=rid(o.resource); td=tex.get(r); ent={'slot':i,'rid':r,'desc':desc_plain(td) if td else {}}
  if r and td:
   fn='RT%d_after.png'%i; cfg=rd.TextureSave();cfg.resourceId=o.resource;cfg.destType=rd.FileType.PNG;cfg.mip=0;cfg.slice=rd.TextureSliceMapping();
   try: ent['saveResult']=str(c.SaveTexture(cfg,os.path.join(CAP,fn)));ent['file']=fn
   except Exception as ex:ent['saveError']=str(ex)
  result['outputs'].append(ent)
 o=s.GetDepthTarget();r=rid(o.resource);td=tex.get(r);result['depth']={'rid':r,'desc':desc_plain(td) if td else {}}
 path=os.path.join(ROOT,'eid4922_capture_manifest.json');open(path,'w',encoding='utf8').write(json.dumps(result,indent=2));
 return {'manifest':path,'draw':result['draw'],'inputs':result['vertexInputs'],'textures':result['textures'],'outputs':result['outputs'],'cb':{k:[{'name':x['name'],'size':x['size'],'file':x['file']} for x in v] for k,v in result['constantBuffers'].items()}}
ctx.replay(work)
