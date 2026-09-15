def work(c):
 c.SetFrameEvent(2012,True);s=c.GetPipelineState();p=s.GetGraphicsPipelineObject();out={}
 for stage,key in [(rd.ShaderStage.Vertex,'VS'),(rd.ShaderStage.Pixel,'PS')]:
  r=s.GetShaderReflection(stage)
  out[key]=c.DisassembleShader(p,r,'SPIR-V (RenderDoc)')
 return out
ctx.replay(work)
