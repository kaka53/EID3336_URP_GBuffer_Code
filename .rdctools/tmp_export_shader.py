import os,json
EID=2768

def work(c):
 c.SetFrameEvent(EID,False);s=c.GetPipelineState();
 out={'pso':str(s.GetGraphicsPipelineObject()),'vsid':str(s.GetShader(rd.ShaderStage.Vertex)),'psid':str(s.GetShader(rd.ShaderStage.Pixel)),'vep':str(s.GetShaderEntryPoint(rd.ShaderStage.Vertex)),'pep':str(s.GetShaderEntryPoint(rd.ShaderStage.Pixel))}
 for st,key in [(rd.ShaderStage.Vertex,'VS'),(rd.ShaderStage.Pixel,'PS')]:
  refl=s.GetShaderReflection(st)
  out[key]={'refl':serialize.shader_reflection(refl),'dis':c.DisassembleShader(s.GetGraphicsPipelineObject(),refl,'SPIR-V (RenderDoc)')}
 return out
r=ctx.replay(work)
open(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/test_2768_shader.json','w',encoding='utf8').write(json.dumps(r,default=str,indent=2))
print({'ok':True,'sizes':{k:len(v.get('dis','')) for k,v in r.items() if isinstance(v,dict)}})
