def obj(o,names):
 r={}
 for n in names:
  try:r[n]=str(getattr(o,n))
  except:pass
 return r
def work(c):
 c.SetFrameEvent(2012,True);s=c.GetPipelineState();rs=s.GetRasterState();ds=s.GetDepthTestState()
 return {'raster':obj(rs,['fillMode','cullMode','frontCCW','depthClampEnable','depthBias','slopeScaledDepthBias','offsetClamp','lineWidth']), 'depth':obj(ds,['depthEnable','depthWrites','depthFunction','nearBound','farBound']), 'stencilEnabled':s.IsStencilTestEnabled(), 'stencil':[obj(x,['failOperation','depthFailOperation','passOperation','function','reference','compareMask','writeMask']) for x in s.GetStencilFaces()]}
ctx.replay(work)
