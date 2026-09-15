def work(c):
 return {'TextureSave':getattr(rd.TextureSave,'__doc__',None),'FileType':getattr(rd.FileType,'__doc__',None),'SaveTexture':getattr(c.SaveTexture,'__doc__',None),'TextureSaveDir':[x for x in dir(rd.TextureSave()) if not x.startswith('_')]}
ctx.replay(work)
