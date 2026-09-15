def work(c):
 c.SetFrameEvent(2012,True);s=c.GetPipelineState();p=s.GetGraphicsPipelineObject();u=s.GetConstantBlocks(rd.ShaderStage.Pixel)[1];d=u.descriptor;v=c.GetCBufferVariableContents(p,s.GetShader(rd.ShaderStage.Pixel),rd.ShaderStage.Pixel,s.GetShaderEntryPoint(rd.ShaderStage.Pixel),1,d.resource,d.byteOffset,d.byteSize)[1]
 return {'vdir':[x for x in dir(v) if not x.startswith('_')],'valueDir':[x for x in dir(v.value) if not x.startswith('_')], 'value':str(v.value)}
ctx.replay(work)
