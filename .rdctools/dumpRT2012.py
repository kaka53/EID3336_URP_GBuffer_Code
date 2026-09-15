import os,json
OUT=r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/EID3332_EID3336_Combined/EID2012_RenderDoc/Validation'
os.makedirs(OUT,exist_ok=True)
def work(c):
 c.SetFrameEvent(2012,True);s=c.GetPipelineState();tex={int(t.resourceId):t for t in c.GetTextures()};out=[]
 for i,rt in enumerate(s.GetOutputTargets()):
  rid=int(rt.resource);
  if rid==0: continue
  td=tex[rid];data=bytes(c.GetTextureData(rt.resource,rd.Subresource(0,0,0)));fn='RT'+str(i)+'_rid'+str(rid)+'.bytes';open(os.path.join(OUT,fn),'wb').write(data);out.append({'slot':i,'rid':rid,'desc':serialize.texture_description(td),'len':len(data),'file':fn})
 d=s.GetDepthTarget();rid=int(d.resource);td=tex[rid];data=bytes(c.GetTextureData(d.resource,rd.Subresource(0,0,0)));open(os.path.join(OUT,'Depth_rid'+str(rid)+'.bytes'),'wb').write(data);out.append({'slot':'Depth','rid':rid,'desc':serialize.texture_description(td),'len':len(data)})
 return out
ctx.replay(work)

