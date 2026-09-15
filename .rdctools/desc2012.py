def val(o,n):
 try:return getattr(o,n)
 except:return None
def work(c):
 c.SetFrameEvent(2012,True);s=c.GetPipelineState();out={}
 for stage,key in [(rd.ShaderStage.Vertex,'VS'),(rd.ShaderStage.Pixel,'PS')]:
  arr=[]
  for typ,items in [('cb',s.GetConstantBlocks(stage)),('ro',s.GetReadOnlyResources(stage)),('samp',s.GetSamplers(stage))]:
   for i,u in enumerate(items):
    d=val(u,'descriptor');a=val(u,'access');sp=val(u,'sampler')
    arr.append({'type':typ,'i':i,
      'access':{n:str(val(a,n)) for n in ['stage','type','index','arrayElement','byteOffset','byteSize']},
      'descriptor':{n:str(val(d,n)) for n in ['resource','byteOffset','byteSize','format','type','flags','firstMip','numMips','firstSlice','numSlices']},
      'sampler':{n:str(val(sp,n)) for n in ['resource','addressU','addressV','addressW','filter','maxAnisotropy','minLOD','maxLOD','mipBias','compareFunction']},
    })
  out[key]=arr
 return out
ctx.replay(work)
