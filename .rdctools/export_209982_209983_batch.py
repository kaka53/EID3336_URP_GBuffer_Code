import os,json,struct,hashlib,time
EIDS=[2926,2930,2935,2939,2944,2948,2952,2956,2961,2966,2971,2975,2980,2984,2989,2994,2998,3003]
ROOT=r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass8_VS209982_PS209983_Batch'
CAP=os.path.join(ROOT,'Captured');TEX=os.path.join(ROOT,'TextureDatabase');SH=os.path.join(ROOT,'Shaders')
for p in (CAP,TEX,SH):os.makedirs(p,exist_ok=True)
def rid(x):
 try:return int(x)
 except:return 0
def fmt(f):return {'name':f.Name(),'type':str(f.type),'compType':str(f.compType),'compCount':int(f.compCount),'compByteWidth':int(f.compByteWidth)}
def save(path,data):
 data=bytes(data);h=hashlib.sha256(data).hexdigest();reuse=os.path.exists(path) and open(path,'rb').read()==data
 if not reuse:open(path,'wb').write(data)
 return {'file':os.path.relpath(path,ROOT).replace('\\','/'),'bytes':len(data),'sha256':h,'reused':reuse}
def matrix(raw,off=0):
 f=struct.unpack_from('<16f',raw,off)
 return [[f[0],f[4],f[8],f[12]],[f[1],f[5],f[9],f[13]],[f[2],f[6],f[10],f[14]],[f[3],f[7],f[11],f[15]]]
def work(c):
 t0=time.time();actions={};cache={}
 def walk(xs):
  for a in xs:
   if a.eventId in EIDS:actions[a.eventId]=a
   walk(a.children)
 walk(c.GetRootActions())
 missing=[x for x in EIDS if x not in actions]
 if missing:raise RuntimeError('Missing EIDs: '+str(missing))
 def getbuf(resource,off,size):
  k=(rid(resource),int(off),int(size))
  if k not in cache:cache[k]=bytes(c.GetBufferData(resource,int(off),int(size)))
  return cache[k]
 texdesc={rid(t.resourceId):t for t in c.GetTextures()};profiles=[];texture_refs={};common={};first_state=None
 for eid in EIDS:
  a=actions[eid];c.SetFrameEvent(eid,False);s=c.GetPipelineState();first_state=first_state or s
  vs=rid(s.GetShader(rd.ShaderStage.Vertex));ps=rid(s.GetShader(rd.ShaderStage.Pixel))
  if (vs,ps)!=(209982,209983):raise RuntimeError('EID%d shader mismatch %d/%d'%(eid,vs,ps))
  ib=s.GetIBuffer();istride=int(ib.byteStride);icount=int(a.numIndices);ioff=int(ib.byteOffset)+int(a.indexOffset)*istride;rawidx=getbuf(ib.resourceId,ioff,icount*istride)
  if istride==2:indices=list(struct.unpack('<%dH'%icount,rawidx))
  elif istride==4:indices=list(struct.unpack('<%dI'%icount,rawidx))
  else:raise RuntimeError('EID%d unsupported index stride %d'%(eid,istride))
  imin=min(indices) if indices else 0;imax=max(indices) if indices else -1;first=int(a.baseVertex)+imin;vcount=imax-imin+1
  normalized=[int(x)-imin for x in indices]
  normraw=struct.pack('<%dI'%len(normalized),*normalized)
  edir=os.path.join(CAP,'EID%d'%eid);os.makedirs(edir,exist_ok=True)
  inputs=list(s.GetVertexInputs());vbs=s.GetVBuffers();layouts=[];streams=[]
  for x in inputs:layouts.append({'name':x.name,'slot':int(x.vertexBuffer),'offset':int(x.byteOffset),'format':fmt(x.format),'perInstance':bool(x.perInstance),'instanceRate':int(x.instanceRate)})
  for slot in sorted(set(x.vertexBuffer for x in inputs)):
   vb=vbs[slot];sin=[x for x in inputs if x.vertexBuffer==slot];stride=int(vb.byteStride)
   if stride>0:
    count=int(a.numInstances) if all(x.perInstance for x in sin) else vcount
    start=int(a.instanceOffset) if all(x.perInstance for x in sin) else first
    raw=getbuf(vb.resourceId,int(vb.byteOffset)+start*stride,count*stride)
   else:
    size=max(int(x.byteOffset)+int(x.format.compCount)*int(x.format.compByteWidth) for x in sin);count=1;start=0;raw=getbuf(vb.resourceId,int(vb.byteOffset),size)
   fr=save(os.path.join(edir,'vertex_stream%d.bytes'%slot),raw)
   streams.append({'slot':int(slot),'rid':rid(vb.resourceId),'sourceOffset':int(vb.byteOffset),'sourceStride':stride,'firstElement':start,'elementCount':count,'constant':stride==0,'file':fr})
  files={'indices':save(os.path.join(edir,'indices_u32.bytes'),normraw),'sourceIndices':save(os.path.join(edir,'indices_source_u%d.bytes'%(istride*8)),rawidx)}
  cbs={};instance_mats=[]
  for stage,key in [(rd.ShaderStage.Vertex,'VS'),(rd.ShaderStage.Pixel,'PS')]:
   refl=s.GetShaderReflection(stage);arr=[]
   for i,u in enumerate(s.GetConstantBlocks(stage)):
    d=u.descriptor;name=refl.constantBlocks[i].name if i<len(refl.constantBlocks) else 'cb%d'%i;raw=getbuf(d.resource,d.byteOffset,d.byteSize);h=hashlib.sha256(raw).hexdigest();fn='%s_%02d_%s.bytes'%(key,i,name);fr=save(os.path.join(edir,fn),raw)
    rec={'index':i,'name':name,'binding':int(u.access.byteOffset),'rid':rid(d.resource),'offset':int(d.byteOffset),'size':int(d.byteSize),'sha256':h,'file':fr};arr.append(rec)
    common.setdefault(h,{'sha256':h,'size':len(raw),'stages':set(),'names':set(),'eids':[]});common[h]['stages'].add(key);common[h]['names'].add(name);common[h]['eids'].append(eid)
    if key=='VS' and name=='uniforms28':
     for ii in range(int(a.numInstances)):instance_mats.append(matrix(raw,ii*256))
   cbs[key]=arr
  reflps=s.GetShaderReflection(rd.ShaderStage.Pixel);rr=list(reflps.readOnlyResources);textures=[]
  for i,u in enumerate(s.GetReadOnlyResources(rd.ShaderStage.Pixel)):
   d=u.descriptor;r=rid(d.resource);name=rr[i].name if i<len(rr) else 'tex%d'%i;td=texdesc.get(r);tr={'index':i,'name':name,'binding':int(u.access.byteOffset),'rid':r,'format':td.format.Name() if td else '', 'width':int(td.width) if td else 0,'height':int(td.height) if td else 0,'mips':int(td.mips) if td else 0,'arraySize':int(td.arraysize) if td else 0};textures.append(tr)
   z=texture_refs.setdefault(r,dict(tr,eids=[],bindings=[]));z['eids'].append(eid);z['bindings'].append(name)
  profiles.append({'eid':eid,'shaderFamily':'VS209982_PS209983','vs':vs,'ps':ps,'draw':{'indexCount':icount,'instanceCount':int(a.numInstances),'indexOffset':int(a.indexOffset),'baseVertex':int(a.baseVertex),'vertexOffset':int(a.vertexOffset)},'sourceIndexStride':istride,'sourceIndexMin':imin,'sourceIndexMax':imax,'vertexCount':vcount,'triangleCount':icount//3,'layout':layouts,'streams':streams,'files':files,'constantBuffers':cbs,'textures':textures,'instanceMatricesRowMajor':instance_mats})
 # shader source once
 c.SetFrameEvent(EIDS[0],False);s=c.GetPipelineState();pso=s.GetGraphicsPipelineObject();shader_files={}
 for stage,key in [(rd.ShaderStage.Vertex,'VS209982'),(rd.ShaderStage.Pixel,'PS209983')]:
  refl=s.GetShaderReflection(stage);shader_files[key]={'spv':save(os.path.join(SH,key+'.spv'),bytes(refl.rawBytes)),'disassembly':save(os.path.join(SH,key+'.spvasm'),c.DisassembleShader(pso,refl,'SPIR-V (RenderDoc)').encode('utf8')),'reflection':serialize.shader_reflection(refl)}
 # look for any already-imported RID assets before exporting missing textures
 assets=r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets';existing={}
 for root,dirs,fs in os.walk(assets):
  if os.path.abspath(root).startswith(os.path.abspath(TEX)):continue
  for fn in fs:
   low=fn.lower()
   for r in texture_refs:
    if ('rid%d'%r) in low:existing.setdefault(r,[]).append(os.path.relpath(os.path.join(root,fn),r'D:/endcopy/EID3336_URP_GBuffer_Workspace').replace('\\','/'))
 exported=[]
 for r,v in sorted(texture_refs.items()):
  if existing.get(r):continue
  cfg=rd.TextureSave();cfg.resourceId=next(t.resourceId for t in c.GetTextures() if rid(t.resourceId)==r);cfg.destType=rd.FileType.DDS;cfg.mip=-1;cfg.slice=rd.TextureSliceMapping();path=os.path.join(TEX,'rid%d.dds'%r);res=c.SaveTexture(cfg,path);exported.append({'rid':r,'path':os.path.relpath(path,ROOT).replace('\\','/'),'result':str(res)})
 commons=[]
 for h,v in common.items():commons.append({'sha256':h,'size':v['size'],'stages':sorted(v['stages']),'names':sorted(v['names']),'eids':sorted(set(v['eids'])),'sharedBy':len(set(v['eids']))})
 out={'version':2,'shaderFamily':'VS209982_PS209983','requestedEIDs':EIDS,'profiles':profiles,'shaderFiles':shader_files,'textureDatabase':[],'commonBufferAudit':sorted(commons,key=lambda x:(-x['sharedBy'],x['sha256'])),'statistics':{'eids':len(profiles),'instances':sum(x['draw']['instanceCount'] for x in profiles),'vertices':sum(x['vertexCount'] for x in profiles),'triangles':sum(x['triangleCount'] for x in profiles),'layoutVariants':len(set(json.dumps(x['layout'],sort_keys=True) for x in profiles)),'uniqueTextureRIDs':len(texture_refs),'newTextureExports':len(exported)},'elapsedSeconds':time.time()-t0}
 for r,v in sorted(texture_refs.items()):v['eids']=sorted(set(v['eids']));v['bindings']=sorted(set(v['bindings']));v['existingAssets']=sorted(existing.get(r,[]));v['exportedAsset']=next((x['path'] for x in exported if x['rid']==r),None);out['textureDatabase'].append(v)
 open(os.path.join(ROOT,'VS209982_PS209983_BatchManifest.json'),'w',encoding='utf8').write(json.dumps(out,indent=2,default=str))
 return {'statistics':out['statistics'],'elapsedSeconds':out['elapsedSeconds'],'missingEIDs':missing,'exportedTextures':exported}
print(json.dumps(ctx.replay(work),default=str))


