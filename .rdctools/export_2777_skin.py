import json,os,hashlib
ROOT=r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass2_VS209980_PS209981_Batch'
def work(c):
 c.SetFrameEvent(2777,False);s=c.GetPipelineState();arr=[]
 for i,u in enumerate(s.GetReadWriteResources(rd.ShaderStage.Vertex)):
  d=u.descriptor;raw=bytes(c.GetBufferData(d.resource,d.byteOffset,d.byteSize));path=os.path.join(ROOT,'Captured','EID2777','VS_ssbo30.bytes');open(path,'wb').write(raw);arr.append({'index':i,'name':'ssbo30','binding':int(u.access.byteOffset),'rid':int(d.resource),'offset':int(d.byteOffset),'size':int(d.byteSize),'sha256':hashlib.sha256(raw).hexdigest(),'file':{'file':'Captured/EID2777/VS_ssbo30.bytes','bytes':len(raw),'sha256':hashlib.sha256(raw).hexdigest()}})
 return arr
arr=ctx.replay(work);mp=os.path.join(ROOT,'VS209980_PS209981_BatchManifest.json');m=json.load(open(mp,encoding='utf8'))
for p in m['profiles']:
 if p['eid']==2777:p['readWriteResources']={'VS':arr}
json.dump(m,open(mp,'w',encoding='utf8'),indent=2)
print({'count':len(arr),'size':sum(x['size'] for x in arr)})
