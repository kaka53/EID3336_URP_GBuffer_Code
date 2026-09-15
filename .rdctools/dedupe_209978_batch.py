import json,os,hashlib,shutil
ROOT=r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass3_VS209978_PS209979_Batch'
MAN=os.path.join(ROOT,'VS209978_PS209979_BatchManifest.json')
SHARED=os.path.join(ROOT,'Captured','SharedByHash')
os.makedirs(SHARED,exist_ok=True)
m=json.load(open(MAN,encoding='utf8'))
refs=[]
def add(fr,kind,eid):
 if fr and fr.get('file'): refs.append((fr,kind,eid))
for p in m['profiles']:
 eid=p['eid']
 add(p['files']['indices'],'indices',eid); add(p['files']['sourceIndices'],'sourceIndices',eid)
 for s in p['streams']: add(s['file'],'vertexStream%d'%s['slot'],eid)
 for stage in ('VS','PS'):
  for c in p['constantBuffers'][stage]: add(c['file'],stage+'_'+c['name'],eid)
groups={}
for fr,kind,eid in refs:
 src=os.path.join(ROOT,fr['file'])
 data=open(src,'rb').read(); h=hashlib.sha256(data).hexdigest()
 if h!=fr['sha256']: raise RuntimeError('hash mismatch '+src)
 groups.setdefault(h,{'size':len(data),'refs':[],'src':src})['refs'].append((fr,kind,eid,src))
removed=0
for h,g in groups.items():
 dst=os.path.join(SHARED,h+'.bytes')
 if not os.path.exists(dst): shutil.copyfile(g['src'],dst)
 rel=os.path.relpath(dst,ROOT).replace('\\','/')
 for fr,kind,eid,src in g['refs']:
  fr['file']=rel
  if os.path.abspath(src)!=os.path.abspath(dst) and os.path.exists(src): os.remove(src); removed+=1
m['bufferDeduplication']={'uniqueBlobs':len(groups),'references':len(refs),'removedDuplicateFiles':removed,'sharedBlobs':[{'sha256':h,'size':g['size'],'references':len(g['refs']),'eids':sorted(set(x[2] for x in g['refs'])),'kinds':sorted(set(x[1] for x in g['refs']))} for h,g in groups.items()]}
json.dump(m,open(MAN,'w',encoding='utf8'),indent=2)
print(json.dumps({k:m['bufferDeduplication'][k] for k in ('uniqueBlobs','references','removedDuplicateFiles')},indent=2))
