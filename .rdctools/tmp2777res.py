def work(c):
 c.SetFrameEvent(2777,False);s=c.GetPipelineState();r=s.GetShaderReflection(rd.ShaderStage.Vertex)
 return {'refl':serialize.shader_reflection(r),'ro':[inspect(x) for x in s.GetReadOnlyResources(rd.ShaderStage.Vertex)],'rw':[inspect(x) for x in s.GetReadWriteResources(rd.ShaderStage.Vertex)]}
print(ctx.replay(work))
