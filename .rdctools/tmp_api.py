def work(c):
 names=[x for x in dir(c) if 'Shader' in x or 'Disass' in x or 'Debug' in x]
 return {n:getattr(getattr(c,n),'__doc__',None) for n in names}
print(ctx.replay(work))
