def work(c):
 return {'doc':getattr(c.DisassembleShader,'__doc__',None),'targets':c.GetDisassemblyTargets(True)}
print(ctx.replay(work))
