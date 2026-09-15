import os
def work(c):
 c.SetFrameEvent(3278,True)
 cfg=rd.TextureSave();cfg.resourceId=next(t.resourceId for t in c.GetTextures() if int(t.resourceId)==197837);cfg.destType=rd.FileType.DDS;cfg.mip=-1;cfg.slice=rd.TextureSliceMapping();
 return str(c.SaveTexture(cfg,r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/test_rid197837.dds'))
ctx.replay(work)
