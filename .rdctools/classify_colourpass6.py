import os,json,hashlib,struct,csv,time
OUT=r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/ColourPass6Classification'
os.makedirs(OUT,exist_ok=True)

def rid(r):
 try:return int(r)
 except:return 0

def action_is_draw(a):
 return bool(a.flags & rd.ActionFlags.Drawcall)

def fmt_desc(f):
 return {'name':f.Name(),'type':str(f.type),'compType':str(f.compType),'compCount':f.compCount,'compByteWidth':f.compByteWidth}

def work(c):
 t0=time.time(); marker=None
 def find(xs):
  nonlocal marker
  for a in xs:
   if a.eventId==5821: marker=a; return
   find(a.children)
   if marker:return
 find(c.GetRootActions())
 if marker is None: raise RuntimeError('Colour Pass #6 marker EID5821 not found')
 draws=[a for a in marker.children if action_is_draw(a)]
 rows=[]; data_cache={}
 def getbuf(resource,offset,length):
  k=(rid(resource),int(offset),int(length))
  if k not in data_cache:data_cache[k]=bytes(c.GetBufferData(resource,offset,length))
  return data_cache[k]
 for di,a in enumerate(draws):
  c.SetFrameEvent(a.eventId,False);s=c.GetPipelineState()
  vs=rid(s.GetShader(rd.ShaderStage.Vertex));ps=rid(s.GetShader(rd.ShaderStage.Pixel))
  inputs=[]
  for x in s.GetVertexInputs():
   inputs.append({'name':x.name,'slot':x.vertexBuffer,'offset':x.byteOffset,'perInstance':bool(x.perInstance),'rate':x.instanceRate,'format':fmt_desc(x.format)})
  inputs.sort(key=lambda x:(x['slot'],x['offset'],x['name']))
  layout_json=json.dumps(inputs,sort_keys=True,separators=(',',':'))
  layout_hash=hashlib.sha256(layout_json.encode()).hexdigest()[:16]
  topo=str(s.GetPrimitiveTopology())
  h=hashlib.sha256();h.update(layout_json.encode());h.update(topo.encode())
  index_count=int(a.numIndices);instance_count=int(a.numInstances)
  index_min=0;index_max=-1;index_stride=0;indices=[]
  if bool(a.flags & rd.ActionFlags.Indexed):
   ib=s.GetIBuffer();index_stride=int(ib.byteStride)
   iboff=int(ib.byteOffset)+int(a.indexOffset)*index_stride
   rawidx=getbuf(ib.resourceId,iboff,index_count*index_stride)
   if index_stride==2:indices=struct.unpack('<%dH'%index_count,rawidx)
   elif index_stride==4:indices=struct.unpack('<%dI'%index_count,rawidx)
   else:raise RuntimeError('Unsupported index stride %d at EID%d'%(index_stride,a.eventId))
   index_min=min(indices) if indices else 0;index_max=max(indices) if indices else -1
   # Normalize index origin so identical meshes at different base vertex offsets group together.
   norm_min=index_min
   for idx in indices:h.update(struct.pack('<I',int(idx)-norm_min))
  else:
   first=int(a.vertexOffset);indices=range(first,first+index_count);index_min=first;index_max=first+index_count-1
   for idx in range(index_count):h.update(struct.pack('<I',idx))
  vbs=s.GetVBuffers();used_slots=sorted(set(x['slot'] for x in inputs))
  stream_meta=[]
  for slot in used_slots:
   vb=vbs[slot];slot_inputs=[x for x in inputs if x['slot']==slot]
   per_vertex=any(not x['perInstance'] for x in slot_inputs)
   stride=int(vb.byteStride)
   if stride>0 and per_vertex and index_max>=index_min:
    first_vertex=index_min+int(a.baseVertex)
    last_vertex=index_max+int(a.baseVertex)
    raw=getbuf(vb.resourceId,int(vb.byteOffset)+first_vertex*stride,(last_vertex-first_vertex+1)*stride)
    h.update(('slot%d-stride%d'% (slot,stride)).encode())
    for idx in indices:
     local=int(idx)-index_min
     h.update(raw[local*stride:(local+1)*stride])
    stream_meta.append({'slot':slot,'rid':rid(vb.resourceId),'offset':int(vb.byteOffset),'stride':stride,'firstVertex':first_vertex,'lastVertex':last_vertex})
   elif stride==0:
    # Constant vertex attributes: hash only the actually referenced bytes.
    maxend=max(x['offset']+x['format']['compCount']*x['format']['compByteWidth'] for x in slot_inputs)
    raw=getbuf(vb.resourceId,int(vb.byteOffset),maxend)
    h.update(('slot%d-constant'%slot).encode());h.update(raw)
    stream_meta.append({'slot':slot,'rid':rid(vb.resourceId),'offset':int(vb.byteOffset),'stride':0,'constantBytes':maxend})
   else:
    stream_meta.append({'slot':slot,'rid':rid(vb.resourceId),'offset':int(vb.byteOffset),'stride':stride,'perInstanceOnly':True})
  mesh_hash=h.hexdigest()[:24]
  rows.append({'eid':int(a.eventId),'vs':vs,'ps':ps,'shaderFamily':'VS%d_PS%d'%(vs,ps),'meshHash':mesh_hash,'layoutHash':layout_hash,'indexCount':index_count,'instanceCount':instance_count,'indexOffset':int(a.indexOffset),'baseVertex':int(a.baseVertex),'vertexOffset':int(a.vertexOffset),'indexed':bool(a.flags & rd.ActionFlags.Indexed),'indexStride':index_stride,'minIndex':index_min,'maxIndex':index_max,'topology':topo,'vertexInputs':inputs,'streams':stream_meta})
 # hierarchy
 families={}
 for r in rows:
  fam=families.setdefault(r['shaderFamily'],{'vs':r['vs'],'ps':r['ps'],'drawCount':0,'eidCount':0,'instanceTotal':0,'meshes':{}})
  fam['drawCount']+=1;fam['eidCount']+=1;fam['instanceTotal']+=r['instanceCount']
  mg=fam['meshes'].setdefault(r['meshHash'],{'meshHash':r['meshHash'],'layoutHash':r['layoutHash'],'indexCount':r['indexCount'],'vertexCount':r['maxIndex']-r['minIndex']+1 if r['maxIndex']>=r['minIndex'] else 0,'triangleCount':r['indexCount']//3 if 'TriangleList' in r['topology'] else None,'topology':r['topology'],'indexed':r['indexed'],'drawCount':0,'instanceTotal':0,'eids':[],'drawVariants':[]})
  mg['drawCount']+=1;mg['instanceTotal']+=r['instanceCount'];mg['eids'].append(r['eid'])
  variant={'eid':r['eid'],'instances':r['instanceCount'],'indexCount':r['indexCount'],'indexOffset':r['indexOffset'],'baseVertex':r['baseVertex'],'vertexOffset':r['vertexOffset']}
  mg['drawVariants'].append(variant)
 # deterministic ordering
 famlist=[]
 for key,f in families.items():
  f['shaderFamily']=key;f['meshCount']=len(f['meshes']);f['meshes']=sorted(f['meshes'].values(),key=lambda m:(-m['drawCount'],m['eids'][0]));famlist.append(f)
 famlist.sort(key=lambda f:(-f['drawCount'],f['vs'],f['ps']))
 result={'capture':'F:/endfield06.rdc','pass':'Colour Pass #6 (5 Targets + Depth)','passMarkerEvent':5821,'eventRange':[min(r['eid'] for r in rows),max(r['eid'] for r in rows)],'drawCount':len(rows),'shaderFamilyCount':len(famlist),'uniqueMeshCount':sum(f['meshCount'] for f in famlist),'families':famlist,'rows':rows,'classificationRule':{'level1':'VS module + PS module','level2':'exact consumed VSInput geometry hash (layout + topology + normalized indices + referenced vertex records + constant vertex attributes)','excludedFromMeshHash':['material textures','pixel constant buffers','instance transform buffers']},'elapsedSeconds':time.time()-t0}
 open(os.path.join(OUT,'ColourPass6_ShaderMesh_EID_Classification.json'),'w',encoding='utf-8').write(json.dumps(result,indent=2))
 with open(os.path.join(OUT,'ColourPass6_EID_Flat.csv'),'w',newline='',encoding='utf-8-sig') as f:
  w=csv.writer(f);w.writerow(['EID','ShaderFamily','VS','PS','MeshHash','LayoutHash','IndexCount','VertexCount','InstanceCount','Topology'])
  for r in rows:w.writerow([r['eid'],r['shaderFamily'],r['vs'],r['ps'],r['meshHash'],r['layoutHash'],r['indexCount'],r['maxIndex']-r['minIndex']+1,r['instanceCount'],r['topology']])
 md=[];md.append('# Colour Pass #6：Shader Module → 同 Mesh → EID 清单\n')
 md.append('- Capture: `F:/endfield06.rdc`')
 md.append('- Pass marker: `EID 5821`')
 md.append('- Draw EID 范围: `%d–%d`'%tuple(result['eventRange']))
 md.append('- Draw 数量: `%d`'%result['drawCount'])
 md.append('- Shader Family 数量: `%d`'%result['shaderFamilyCount'])
 md.append('- Shader Family 内唯一 Mesh 总数: `%d`\n'%result['uniqueMeshCount'])
 md.append('> 一级按 `VS Module + PS Module`；二级按精确 VSInput Mesh Hash。Mesh Hash 包含顶点布局、拓扑、归一化索引顺序、被索引引用的顶点记录和常量顶点属性；不包含材质纹理、PS 参数和 Transform。\n')
 for fi,f in enumerate(famlist,1):
  md.append('## %d. `%s`'% (fi,f['shaderFamily']))
  md.append('- Draws: `%d`；Meshes: `%d`；Instances: `%d`\n'%(f['drawCount'],f['meshCount'],f['instanceTotal']))
  for mi,m in enumerate(f['meshes'],1):
   md.append('### %d.%d Mesh `%s`'%(fi,mi,m['meshHash']))
   md.append('- Layout: `%s`；Vertices: `%d`；Indices: `%d`；Triangles: `%s`；Draws: `%d`；Instances: `%d`'%(m['layoutHash'],m['vertexCount'],m['indexCount'],str(m['triangleCount']),m['drawCount'],m['instanceTotal']))
   md.append('- EIDs: '+', '.join('`%d`'%x for x in m['eids'])+'\n')
 open(os.path.join(OUT,'ColourPass6_ShaderMesh_EID_List.md'),'w',encoding='utf-8').write('\n'.join(md))
 return {'drawCount':result['drawCount'],'shaderFamilyCount':result['shaderFamilyCount'],'uniqueMeshCount':result['uniqueMeshCount'],'eventRange':result['eventRange'],'elapsedSeconds':result['elapsedSeconds'],'families':[{'shaderFamily':f['shaderFamily'],'drawCount':f['drawCount'],'meshCount':f['meshCount'],'instanceTotal':f['instanceTotal']} for f in famlist],'outputs':[os.path.join(OUT,x) for x in ['ColourPass6_ShaderMesh_EID_List.md','ColourPass6_EID_Flat.csv','ColourPass6_ShaderMesh_EID_Classification.json']]}
ctx.replay(work)
