from pathlib import Path
import json,hashlib,collections,os,shutil
root=Path(r'D:\endcopy\EID3336_URP_GBuffer_Workspace\Assets\ColourPass2_VS209980_PS209981_Batch')
mp=root/'VS209980_PS209981_BatchManifest.json'
m=json.loads(mp.read_text(encoding='utf8'))
refs=[]
def add(owner,key,obj):
 if isinstance(obj,dict) and obj.get('file'):
  p=root/obj['file'];
  if p.exists():refs.append((owner,key,obj,p))
for p in m['profiles']:
 for s in p.get('streams',[]):add(p['eid'],'stream'+str(s['slot']),s.get('file'),)
 for k,v in p.get('files',{}).items():add(p['eid'],k,v)
 for stage in ('VS','PS'):
  for cb in p.get('constantBuffers',{}).get(stage,[]):add(p['eid'],stage+'_'+cb['name'],cb.get('file'))
 for stage,arr in p.get('readWriteResources',{}).items():
  for r in arr:add(p['eid'],stage+'_'+r['name'],r.get('file'))
groups=collections.defaultdict(list)
for x in refs:
 h=hashlib.sha256(x[3].read_bytes()).hexdigest();groups[h].append(x)
shared=root/'Captured'/'SharedByHash';shared.mkdir(parents=True,exist_ok=True)
changed=0;saved=0;deleted=[];shared_entries=[]
for h,items in groups.items():
 if len(items)<2:continue
 data=items[0][3].read_bytes();dest=shared/(h[:16]+'.bytes')
 if not dest.exists():dest.write_bytes(data)
 for owner,key,obj,path in items:
  rel=dest.relative_to(root).as_posix();obj['file']=rel;obj['sha256']=h;obj['bytes']=len(data);changed+=1
  if path!=dest:saved+=len(data)
 shared_entries.append({'sha256':h,'bytes':len(data),'references':len(items),'owners':[f'EID{o}/{k}' for o,k,_,_ in items],'file':dest.relative_to(root).as_posix()})
# Find old files no longer referenced
live=set()
def collect(obj):
 if isinstance(obj,dict):
  if isinstance(obj.get('file'),str):live.add((root/obj['file']).resolve())
  for v in obj.values():collect(v)
 elif isinstance(obj,list):
  for v in obj:collect(v)
collect(m)
for _,_,_,p in refs:
 if p.resolve() not in live and p.exists():
  saved_actual=p.stat().st_size;p.unlink();deleted.append(str(p.relative_to(root)));saved_actual=0
m['sharedFileDatabase']=sorted(shared_entries,key=lambda x:(-x['references'],x['sha256']))
m.setdefault('statistics',{})['sharedBinaryPayloads']=len(shared_entries)
m['statistics']['deduplicatedReferences']=changed
mp.write_text(json.dumps(m,indent=2),encoding='utf8')
report={'sharedPayloads':len(shared_entries),'rewrittenReferences':changed,'deletedDuplicateFiles':len(deleted),'estimatedBytesAvoided':saved,'entries':shared_entries,'deleted':deleted}
(root/'BinaryDeduplicationReport.json').write_text(json.dumps(report,indent=2),encoding='utf8')
print(json.dumps({k:report[k] for k in ['sharedPayloads','rewrittenReferences','deletedDuplicateFiles','estimatedBytesAvoided']},indent=2))
