import os,json,struct,hashlib
OUT=r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/EID3332_EID3336_Combined/EID2012_RenderDoc/Captured'
os.makedirs(OUT,exist_ok=True)
def ridnum(r):
 s=str(r)
 try:return int(s.split('::')[-1])
 except:return 0
def fmtobj(o):
 try:return serialize.resource_format(o)
 except:return str(o)
def work(c):
 eid=2012;c.SetFrameEvent(eid,True);s=c.GetPipelineState();p=s.GetGraphicsPipelineObject()
 # action
 act=None
 def walk(xs):
  nonlocal act
  for a in xs:
   if a.eventId==eid:act=a
   walk(a.children)
 walk(c.GetRootActions())
 meta={'eventId':eid,'draw':{'numIndices':act.numIndices,'numInstances':act.numInstances,'indexOffset':act.indexOffset,'baseVertex':act.baseVertex,'vertexOffset':act.vertexOffset,'instanceOffset':act.instanceOffset},'pipeline':serialize.pipeline_state(s),'vertexInputs':[],'vertexBuffers':[],'indexBuffer':{},'shaders':{},'constantBuffers':{},'textures':{},'samplers':{}}
 # shaders
 for stage,key in [(rd.ShaderStage.Vertex,'VS'),(rd.ShaderStage.Pixel,'PS')]:
  r=s.GetShaderReflection(stage);raw=bytes(r.rawBytes)
  open(os.path.join(OUT,key+'_'+str(ridnum(r.resourceId))+'.spv'),'wb').write(raw)
  open(os.path.join(OUT,key+'_'+str(ridnum(r.resourceId))+'.spvasm'),'w',encoding='utf-8').write(c.DisassembleShader(p,r,'SPIR-V (RenderDoc)'))
  meta['shaders'][key]={'resource':ridnum(r.resourceId),'entry':s.GetShaderEntryPoint(stage),'rawSize':len(raw),'reflection':serialize.shader_reflection(r)}
  meta['constantBuffers'][key]=[]
  for i,u in enumerate(s.GetConstantBlocks(stage)):
   d=u.descriptor;data=bytes(c.GetBufferData(d.resource,d.byteOffset,d.byteSize));fn=key+'_uniforms'+str(u.access.byteOffset)+'_'+str(d.byteSize)+'.bytes';open(os.path.join(OUT,fn),'wb').write(data)
   meta['constantBuffers'][key].append({'slot':i,'binding':u.access.byteOffset,'resource':ridnum(d.resource),'offset':d.byteOffset,'size':d.byteSize,'file':fn})
  meta['textures'][key]=[]
  texBy={ridnum(t.resourceId):t for t in c.GetTextures()}
  reflres=list(r.readOnlyResources)
  for i,u in enumerate(s.GetReadOnlyResources(stage)):
   d=u.descriptor;rr=ridnum(d.resource);td=texBy.get(rr);name=(reflres[i].name if i<len(reflres) else 'res'+str(u.access.byteOffset));rec={'slot':i,'binding':u.access.byteOffset,'name':name,'resource':rr,'firstMip':d.firstMip,'numMips':d.numMips,'firstSlice':d.firstSlice,'numSlices':d.numSlices,'description':serialize.texture_description(td) if td else None,'subresources':[]}
   if td:
    for sl in range(d.firstSlice,d.firstSlice+d.numSlices):
     for mip in range(d.firstMip,d.firstMip+d.numMips):
      sub=rd.Subresource(mip,sl,0);data=bytes(c.GetTextureData(d.resource,sub));fn=key+'_'+name+'_rid'+str(rr)+'_s'+str(sl)+'_m'+str(mip)+'.bytes';open(os.path.join(OUT,fn),'wb').write(data);rec['subresources'].append({'slice':sl,'mip':mip,'length':len(data),'file':fn})
   meta['textures'][key].append(rec)
  meta['samplers'][key]=[]
  refls=list(r.samplers)
  for i,u in enumerate(s.GetSamplers(stage)):
   sp=u.sampler;name=(refls[i].name if i<len(refls) else 'samp'+str(i));meta['samplers'][key].append({'slot':i,'binding':u.access.byteOffset,'name':name,'addressU':str(sp.addressU),'addressV':str(sp.addressV),'addressW':str(sp.addressW),'filter':str(sp.filter),'maxAnisotropy':sp.maxAnisotropy,'minLOD':sp.minLOD,'maxLOD':sp.maxLOD,'mipBias':sp.mipBias})
 # index
 ib=s.GetIBuffer();idxbytes=bytes(c.GetBufferData(ib.resourceId,ib.byteOffset+act.indexOffset*ib.byteStride,act.numIndices*ib.byteStride));open(os.path.join(OUT,'indices_u'+str(ib.byteStride*8)+'.bytes'),'wb').write(idxbytes)
 inds=list(struct.unpack('<'+('H' if ib.byteStride==2 else 'I')*act.numIndices,idxbytes));maxidx=max(inds);minidx=min(inds)
 meta['indexBuffer']={'resource':ridnum(ib.resourceId),'offset':ib.byteOffset,'stride':ib.byteStride,'minIndex':minidx,'maxIndex':maxidx,'file':'indices_u'+str(ib.byteStride*8)+'.bytes'}
 # vinputs/vbuffers
 for a in s.GetVertexInputs():meta['vertexInputs'].append({'name':a.name,'vertexBuffer':a.vertexBuffer,'byteOffset':a.byteOffset,'perInstance':a.perInstance,'instanceRate':a.instanceRate,'format':{'name':a.format.Name(),'compType':str(a.format.compType),'compCount':a.format.compCount,'compByteWidth':a.format.compByteWidth,'type':str(a.format.type)}})
 vbs=s.GetVBuffers();used=sorted(set(a.vertexBuffer for a in s.GetVertexInputs()))
 for slot in used:
  vb=vbs[slot];count=(act.numInstances if any(a.vertexBuffer==slot and a.perInstance for a in s.GetVertexInputs()) else maxidx+1);size=count*vb.byteStride if vb.byteStride else vb.byteSize;data=bytes(c.GetBufferData(vb.resourceId,vb.byteOffset,size));fn='vertex_stream'+str(slot)+'.bytes';open(os.path.join(OUT,fn),'wb').write(data);meta['vertexBuffers'].append({'slot':slot,'resource':ridnum(vb.resourceId),'offset':vb.byteOffset,'stride':vb.byteStride,'byteSize':vb.byteSize,'exported':len(data),'file':fn})
 open(os.path.join(OUT,'EID2012_capture_profile.json'),'w',encoding='utf-8').write(json.dumps(meta,indent=2,default=str))
 return {'draw':meta['draw'],'shaders':{k:v['resource'] for k,v in meta['shaders'].items()},'index':meta['indexBuffer'],'vbs':meta['vertexBuffers'],'cbs':meta['constantBuffers'],'textures':meta['textures'],'samplers':meta['samplers']}
ctx.replay(work)

