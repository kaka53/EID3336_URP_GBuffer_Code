import os
OUT=r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/EID4922'
os.makedirs(OUT,exist_ok=True)
def work(c):
 c.SetFrameEvent(4922,True); s=c.GetPipelineState(); o=s.GetOutputTargets()[0]; data=bytes(c.GetTextureData(o.resource,rd.Subresource(0,0,0))); path=os.path.join(OUT,'EID4922_RenderDoc_RT0_R11G11B10.raw');open(path,'wb').write(data);return {'path':path,'bytes':len(data),'rid':int(o.resource)}
ctx.replay(work)
