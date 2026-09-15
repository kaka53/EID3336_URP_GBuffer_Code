def work(c):
 c.SetFrameEvent(2768,False);s=c.GetPipelineState();
 out={}
 for st,key in [(rd.ShaderStage.Vertex,'VS209980'),(rd.ShaderStage.Pixel,'PS209981')]:
  r=s.GetShaderReflection(st);out[key]={'encoding':str(r.encoding),'raw':bytes(r.rawBytes)}
 return out
r=ctx.replay(work)
for k,v in r.items():open(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/'+k+'.spv','wb').write(v['raw'])
print({k:{'encoding':v['encoding'],'bytes':len(v['raw'])} for k,v in r.items()})
