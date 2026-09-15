import os,json,struct,hashlib,time
EIDS=[3274,3278,3282,3286,3290,3294,3298,3302,3306,3310,3315,3320,3324,3328,3332,3336,3340,3344,3348,3353,3358,3362,3366,3370,3374]
SKIP=[3315,3320,3332,3336]
ROOT=r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS209986_PS209987_Batch'
CAP=os.path.join(ROOT,'Captured');TEX=os.path.join(ROOT,'TextureDatabase')
os.makedirs(CAP,exist_ok=True);os.makedirs(TEX,exist_ok=True)
def rid(x):
 try:return int(x)
 except:return 0
def write(path,data):
 if os.path.exists(path):
  old=open(path,'rb').read()
  if old==data:return {'file':os.path.relpath(path,ROOT).replace('\\','/'),'bytes':len(data),'sha256':hashlib.sha256(data).hexdigest(),'reused':True}
 open(path,'wb').write(data);return {'file':os.path.relpath(path,ROOT).replace('\\','/'),'bytes':len(data),'sha256':hashlib.sha256(data).hexdigest(),'reused':False}
def work(c):
 t0=time.time();actions={}
 def walk(xs):
  for a in xs:
   if a.eventId in EIDS:actions[a.eventId]=a
   walk(a.children)
 walk(c.GetRootActions());texdesc={rid(t.resourceId):t for t in c.GetTextures()};profiles=[];texture_refs={};buffer_cache={}
 def getbuf(resource,off,size):
  k=(rid(resource),int(off),int(size))
  if k not in buffer_cache:buffer_cache[k]=bytes(c.GetBufferData(resource,off,size))
  return buffer_cache[k]
 for eid in EIDS:
  a=actions[eid];c.SetFrameEvent(eid,False);s=c.GetPipelineState();reflps=s.GetShaderReflection(rd.ShaderStage.Pixel);rec={'eid':eid,'skipExisting':eid in SKIP,'draw':{'indexCount':a.numIndices,'instanceCount':a.numInstances,'indexOffset':a.indexOffset,'baseVertex':a.baseVertex,'vertexOffset':a.vertexOffset},'vs':rid(s.GetShader(rd.ShaderStage.Vertex)),'ps':rid(s.GetShader(rd.ShaderStage.Pixel)),'files':{},'textures':[],'constantBuffers':{}}
  # all per-EID geometry is exported once; skipExisting draws keep metadata only.
  ib=s.GetIBuffer();idxsize=a.numIndices*ib.byteStride;idx=getbuf(ib.resourceId,ib.byteOffset+a.indexOffset*ib.byteStride,idxsize)
  if ib.byteStride==2:inds=struct.unpack('<%dH'%a.numIndices,idx)
  else:inds=struct.unpack('<%dI'%a.numIndices,idx)
  vc=max(inds)+1;rec['vertexCount']=vc;rec['triangleCount']=a.numIndices//3;rec['indexStride']=ib.byteStride
  inputs=list(s.GetVertexInputs());vbs=s.GetVBuffers();used=sorted(set(x.vertexBuffer for x in inputs))
  rec['layout']=[]
  for x in inputs:rec['layout'].append({'name':x.name,'slot':x.vertexBuffer,'offset':x.byteOffset,'format':x.format.Name(),'perInstance':x.perInstance})
  if eid not in SKIP:
   edir=os.path.join(CAP,'EID%d'%eid);os.makedirs(edir,exist_ok=True)
   rec['files']['indices']=write(os.path.join(edir,'indices_u%d.bytes'%(ib.byteStride*8)),idx)
   for slot in used:
    vb=vbs[slot]
    if vb.byteStride>0:
     # Current family has only per-vertex input streams.
     raw=getbuf(vb.resourceId,vb.byteOffset,vc*vb.byteStride)
    else:
     maxend=max(x.byteOffset+x.format.compCount*x.format.compByteWidth for x in inputs if x.vertexBuffer==slot)
     raw=getbuf(vb.resourceId,vb.byteOffset,maxend)
    rec['files']['vertexStream%d'%slot]=write(os.path.join(edir,'vertex_stream%d.bytes'%slot),raw)
  # constants
  for stage,key in [(rd.ShaderStage.Vertex,'VS'),(rd.ShaderStage.Pixel,'PS')]:
   refl=s.GetShaderReflection(stage);rec['constantBuffers'][key]=[]
   for i,u in enumerate(s.GetConstantBlocks(stage)):
    d=u.descriptor;name=refl.constantBlocks[i].name if i<len(refl.constantBlocks) else 'cb%d'%i;data=getbuf(d.resource,d.byteOffset,d.byteSize);h=hashlib.sha256(data).hexdigest();entry={'name':name,'binding':u.access.byteOffset,'rid':rid(d.resource),'offset':d.byteOffset,'size':d.byteSize,'sha256':h}
    # Save only per-draw instance table and PS material constants. Globals are referenced by hash.
    if eid not in SKIP and name in ('uniforms30','uniforms24','uniforms44'):
     edir=os.path.join(CAP,'EID%d'%eid);fn='%s_%s.bytes'%(key,name);entry['file']=write(os.path.join(edir,fn),data)
    rec['constantBuffers'][key].append(entry)
  # textures and dedupe by RID. Export only resources that material properties actually consume.
  rr=list(reflps.readOnlyResources)
  for i,u in enumerate(s.GetReadOnlyResources(rd.ShaderStage.Pixel)):
   d=u.descriptor;r=rid(d.resource);name=rr[i].name if i<len(rr) else 'tex%d'%i;td=texdesc.get(r);tr={'name':name,'binding':u.access.byteOffset,'rid':r,'format':td.format.Name() if td else '', 'width':td.width if td else 0,'height':td.height if td else 0,'mips':td.mips if td else 0,'arraySize':td.arraysize if td else 0}
   rec['textures'].append(tr);texture_refs.setdefault(r,{'rid':r,'name':name,'format':tr['format'],'width':tr['width'],'height':tr['height'],'mips':tr['mips'],'arraySize':tr['arraySize'],'eids':[],'bindings':[]})['eids'].append(eid);texture_refs[r]['bindings'].append(name)
  profiles.append(rec)
 # Existing asset index by RID, to avoid duplicate RenderDoc export.
 assets=r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets'
 existing={}
 for root,dirs,files in os.walk(assets):
  for fn in files:
   low=fn.lower()
   if low.endswith('.meta') or low.endswith('.bak_srgb_fix'):continue
   for r in texture_refs:
    if ('rid%d'%r) in low: existing.setdefault(r,[]).append(os.path.join(root,fn).replace('\\','/'))
 # Export only missing material-local textures res33/35/37/38/39; res40/41/42 and virtual/global set already exist.
 needed=set()
 for p in profiles:
  if p['skipExisting']:continue
  for t in p['textures']:
   if t['name'] in ('res33','res35','res37','res38','res39') and not existing.get(t['rid']):needed.add(t['rid'])
 exported=[]
 for r in sorted(needed):
  td=texdesc[r];cfg=rd.TextureSave();cfg.resourceId=td.resourceId;cfg.destType=rd.FileType.DDS;cfg.mip=-1;cfg.slice=rd.TextureSliceMapping();path=os.path.join(TEX,'rid%d.dds'%r);res=c.SaveTexture(cfg,path);exported.append({'rid':r,'path':os.path.relpath(path,ROOT).replace('\\','/'),'result':str(res)})
 # Matrix + transform extraction for every instance, first 256-byte record per captured instance.
 for p in profiles:
  if p['skipExisting']:continue
  cb=next(x for x in p['constantBuffers']['VS'] if x['name']=='uniforms30');data=getbuf(next(b.resourceId for b in c.GetBuffers() if rid(b.resourceId)==cb['rid']),cb['offset'],cb['size']);mats=[]
  for ii in range(p['draw']['instanceCount']):
   f=struct.unpack_from('<16f',data,ii*256);m=[[f[0],f[4],f[8],f[12]],[f[1],f[5],f[9],f[13]],[f[2],f[6],f[10],f[14]],[f[3],f[7],f[11],f[15]]];mats.append(m)
  p['instanceMatricesRowMajor']=mats
 out={'shaderFamily':'VS209986_PS209987','requestedEIDs':EIDS,'skippedExistingEIDs':SKIP,'toImportEIDs':[x for x in EIDS if x not in SKIP],'profiles':profiles,'textureDatabase':[],'exportedMissingTextures':exported,'statistics':{'requested':len(EIDS),'skipped':len(SKIP),'newDrawProfiles':len(EIDS)-len(SKIP),'uniqueTextureRIDs':len(texture_refs),'missingTextureExports':len(exported)}}
 for r,v in sorted(texture_refs.items()):
  v['eids']=sorted(set(v['eids']));v['bindings']=sorted(set(v['bindings']));v['existingAssets']=existing.get(r,[]);v['exportedAsset']=next((x['path'] for x in exported if x['rid']==r),None);out['textureDatabase'].append(v)
 open(os.path.join(ROOT,'VS209986_PS209987_BatchManifest.json'),'w',encoding='utf-8').write(json.dumps(out,indent=2))
 return {'stats':out['statistics'],'exportedMissingTextures':exported,'elapsedSeconds':time.time()-t0}
ctx.replay(work)
