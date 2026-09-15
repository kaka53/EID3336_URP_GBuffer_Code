def work(c):
 c.SetFrameEvent(2012,True)
 s=c.GetPipelineState();r=s.GetShaderReflection(rd.ShaderStage.Vertex)
 return {'controller':[x for x in dir(c) if 'Shader' in x or 'Disassem' in x or 'Buffer' in x or 'Texture' in x], 'reflection':[x for x in dir(r) if not x.startswith('_')], 'state':[x for x in dir(s) if 'Shader' in x or 'Resource' in x or 'Constant' in x or 'Vertex' in x or 'Buffer' in x]}
ctx.replay(work)
