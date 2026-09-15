import os, json, hashlib, struct
EID=4922
OUT=r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/eid4922'
os.makedirs(OUT,exist_ok=True)

def rid(x):
    try:return int(x)
    except:return 0

def enum(x):
    try:return str(x)
    except:return ''

def fmt(x):
    try:return x.Name()
    except:return enum(x)

def attr(o,n,default=None):
    try:return getattr(o,n)
    except:return default

def plain(v):
    if v is None:return None
    if isinstance(v,(str,int,float,bool)):return v
    if isinstance(v,(list,tuple)):return [plain(x) for x in v]
    return enum(v)

def svar(v):
    out={'name':v.name,'rows':v.rows,'columns':v.columns,'type':enum(attr(v,'type'))}
    try: out['f32']=list(v.value.f32v)
    except: pass
    try: out['f64']=list(v.value.f64v)
    except: pass
    try: out['u32']=list(v.value.u32v)
    except: pass
    try: out['s32']=list(v.value.s32v)
    except: pass
    try:
        if v.members: out['members']=[svar(x) for x in v.members]
    except: pass
    return out

def work(c):
    actions={}
    flat=[]
    def walk(xs,depth=0):
        for a in xs:
            actions[a.eventId]=a
            flat.append((a.eventId,depth,a))
            walk(a.children,depth+1)
    walk(c.GetRootActions())
    if EID not in actions: return {'error':'event not found','max':max(actions) if actions else 0}
    a=actions[EID]
    c.SetFrameEvent(EID,False)
    s=c.GetPipelineState()
    pso=s.GetGraphicsPipelineObject()
    rec={
      'eid':EID,
      'action':{n:plain(attr(a,n)) for n in ['eventId','actionId','customName','flags','numIndices','numInstances','indexOffset','baseVertex','vertexOffset','instanceOffset','dispatchDimension']},
      'pipelineObject':rid(pso),
      'shaders':{},'vertexInputs':[],'vertexBuffers':[],'indexBuffer':{},'constantBuffers':{},'readOnlyResources':{},'samplers':{},'outputs':{},'state':{},'neighbors':[]
    }
    pos=next((i for i,x in enumerate(flat) if x[0]==EID),0)
    for e,d,x in flat[max(0,pos-10):pos+11]:
        rec['neighbors'].append({'eid':e,'depth':d,'name':str(attr(x,'customName','')),'flags':enum(attr(x,'flags')),'indices':plain(attr(x,'numIndices')),'instances':plain(attr(x,'numInstances'))})
    # vertex data layout
    for x in s.GetVertexInputs():
        rec['vertexInputs'].append({'name':x.name,'slot':x.vertexBuffer,'offset':x.byteOffset,'format':fmt(x.format),'perInstance':x.perInstance,'instanceRate':x.instanceRate})
    for i,v in enumerate(s.GetVBuffers()):
        rec['vertexBuffers'].append({'slot':i,'rid':rid(v.resourceId),'name':get_resource_name(v.resourceId),'offset':v.byteOffset,'stride':v.byteStride,'size':attr(v,'byteSize',0)})
    ib=s.GetIBuffer(); rec['indexBuffer']={'rid':rid(ib.resourceId),'name':get_resource_name(ib.resourceId),'offset':ib.byteOffset,'stride':ib.byteStride,'size':attr(ib,'byteSize',0)}
    texdesc={rid(t.resourceId):t for t in c.GetTextures()}
    resnames={rid(x.resourceId):x.name for x in c.GetResources()}
    def rname(x): return resnames.get(rid(x),'')
    for stage,key in [(rd.ShaderStage.Vertex,'VS'),(rd.ShaderStage.Pixel,'PS')]:
        sh=s.GetShader(stage); ep=s.GetShaderEntryPoint(stage); refl=s.GetShaderReflection(stage)
        sr={'rid':rid(sh),'entry':ep,'debugName':get_resource_name(sh)}
        if refl:
            raw=bytes(refl.rawBytes); h=hashlib.sha256(raw).hexdigest(); sr['sha256']=h; sr['bytes']=len(raw)
            open(os.path.join(OUT,key+'.spv'),'wb').write(raw)
            dis=c.DisassembleShader(pso,refl,'SPIR-V (RenderDoc)')
            open(os.path.join(OUT,key+'.spvasm'),'w',encoding='utf8').write(dis)
            sr['inputSignature']=[{'name':x.varName,'semantic':x.semanticName,'semanticIndex':x.semanticIndex,'location':x.regIndex,'type':enum(x.varType),'compCount':x.compCount} for x in refl.inputSignature]
            sr['outputSignature']=[{'name':x.varName,'semantic':x.semanticName,'semanticIndex':x.semanticIndex,'location':x.regIndex,'type':enum(x.varType),'compCount':x.compCount} for x in refl.outputSignature]
        rec['shaders'][key]=sr
        rec['constantBuffers'][key]=[]
        blocks=list(s.GetConstantBlocks(stage))
        for i,u in enumerate(blocks):
            d=u.descriptor
            data=bytes(c.GetBufferData(d.resource,d.byteOffset,d.byteSize))
            name=refl.constantBlocks[i].name if refl and i<len(refl.constantBlocks) else 'cb%d'%i
            fn='%s_%02d_%s.bytes'%(key,i,name)
            open(os.path.join(OUT,fn),'wb').write(data)
            ent={'slot':i,'name':name,'binding':u.access.byteOffset,'rid':rid(d.resource),'resourceName':get_resource_name(d.resource),'offset':d.byteOffset,'size':d.byteSize,'sha256':hashlib.sha256(data).hexdigest(),'file':fn}
            try:
                vals=c.GetCBufferVariableContents(pso,sh,stage,ep,i,d.resource,d.byteOffset,d.byteSize)
                ent['variables']=[svar(x) for x in vals]
            except Exception as ex: ent['variablesError']=str(ex)
            rec['constantBuffers'][key].append(ent)
        rec['readOnlyResources'][key]=[]
        rr=list(refl.readOnlyResources) if refl else []
        for i,u in enumerate(s.GetReadOnlyResources(stage)):
            d=u.descriptor; r=rid(d.resource); td=texdesc.get(r)
            name=rr[i].name if i<len(rr) else 'res%d'%i
            rec['readOnlyResources'][key].append({'slot':i,'name':name,'binding':u.access.byteOffset,'rid':r,'resourceName':get_resource_name(d.resource),'type':enum(attr(d,'type')),'format':fmt(td.format) if td else fmt(attr(d,'format')),'width':attr(td,'width',0),'height':attr(td,'height',0),'depth':attr(td,'depth',0),'mips':attr(td,'mips',0),'arraySize':attr(td,'arraysize',0),'dimension':enum(attr(td,'dimension')),'firstMip':d.firstMip,'numMips':d.numMips,'firstSlice':d.firstSlice,'numSlices':d.numSlices})
        rec['samplers'][key]=[]
        for i,u in enumerate(s.GetSamplers(stage)):
            sp=u.sampler
            rec['samplers'][key].append({'slot':i,'binding':u.access.byteOffset,'rid':rid(attr(sp,'resource')),'addressU':enum(sp.addressU),'addressV':enum(sp.addressV),'addressW':enum(sp.addressW),'filter':enum(sp.filter),'maxAnisotropy':sp.maxAnisotropy,'minLOD':sp.minLOD,'maxLOD':sp.maxLOD,'mipBias':sp.mipBias,'compareFunction':enum(sp.compareFunction)})
    # outputs/state
    rec['outputs']['colors']=[]
    for i,o in enumerate(s.GetOutputTargets()):
        d=o;r=rid(d.resource);td=texdesc.get(r)
        rec['outputs']['colors'].append({'slot':i,'rid':r,'name':get_resource_name(d.resource),'format':fmt(td.format) if td else fmt(d.format),'width':attr(td,'width',0),'height':attr(td,'height',0),'firstMip':d.firstMip,'firstSlice':d.firstSlice})
    o=s.GetDepthTarget(); d=o; r=rid(d.resource); td=texdesc.get(r)
    rec['outputs']['depth']={'rid':r,'name':get_resource_name(d.resource),'format':fmt(td.format) if td else fmt(d.format),'width':attr(td,'width',0),'height':attr(td,'height',0),'firstMip':d.firstMip,'firstSlice':d.firstSlice}
    rs=s.GetRasterState(); ds=s.GetDepthTestState()
    rec['state']['raster']={n:plain(attr(rs,n)) for n in ['fillMode','cullMode','frontCCW','depthClampEnable','depthBias','slopeScaledDepthBias','offsetClamp','lineWidth']}
    rec['state']['depth']={n:plain(attr(ds,n)) for n in ['depthEnable','depthWrites','depthFunction','nearBound','farBound']}
    rec['state']['stencilEnabled']=s.IsStencilTestEnabled()
    rec['state']['stencil']=[{n:plain(attr(x,n)) for n in ['failOperation','depthFailOperation','passOperation','function','reference','compareMask','writeMask']} for x in s.GetStencilFaces()]
    try:
      x=s.GetViewport(0);rec['state']['viewports']=[{n:plain(attr(x,n)) for n in ['x','y','width','height','minDepth','maxDepth']}]
    except Exception as ex: rec['state']['viewportError']=str(ex)
    try:
      x=s.GetScissor(0);rec['state']['scissors']=[{n:plain(attr(x,n)) for n in ['x','y','width','height','enabled']}]
    except Exception as ex: rec['state']['scissorError']=str(ex)
    try:
      rec['state']['blends']=[]
      bs=s.GetColorBlends()
      for x in bs:
        rec['state']['blends'].append({n:plain(attr(x,n)) for n in ['enabled','logicOperationEnabled','logicOperation','source','destination','operation','alphaSource','alphaDestination','alphaOperation','writeMask']})
    except Exception as ex: rec['state']['blendError']=str(ex)
    path=os.path.join(OUT,'eid4922_pipeline.json')
    open(path,'w',encoding='utf8').write(json.dumps(rec,indent=2))
    return {'path':path,'action':rec['action'],'shaders':rec['shaders'],'outputs':rec['outputs'],'inputs':rec['vertexInputs'],'resourcesPS':rec['readOnlyResources']['PS'],'cbPS':[{'name':x['name'],'binding':x['binding'],'size':x['size']} for x in rec['constantBuffers']['PS']],'state':rec['state']}
ctx.replay(work)




