def work(c):
 c.SetFrameEvent(2012,True); s=c.GetPipelineState(); out={}
 for stage,key in [(rd.ShaderStage.Vertex,'VS'),(rd.ShaderStage.Pixel,'PS')]:
  refl=s.GetShaderReflection(stage)
  out[key]={
   'shader':str(s.GetShader(stage)),
   'entry':s.GetShaderEntryPoint(stage),
   'reflection':serialize.shader_reflection(refl),
   'constantBlocks':[inspect(x) for x in s.GetConstantBlocks(stage)],
   'readOnly':[inspect(x) for x in s.GetReadOnlyResources(stage)],
   'samplers':[inspect(x) for x in s.GetSamplers(stage)],
   'disassemblyTargets':c.GetDisassemblyTargets(True),
  }
 return out
ctx.replay(work)
