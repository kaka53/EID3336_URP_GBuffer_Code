import sys, json, traceback
import renderdoc as rd

def rid(x):
    try: return str(x)
    except: return repr(x)
def fmt(x):
    try: return str(x)
    except: return repr(x)
def dump_event(c,eid):
    c.SetFrameEvent(eid, True)
    st=c.GetPipelineState()
    d=None
    def find_action(xs):
      nonlocal d
      for a in xs:
        if a.eventId==eid: d=a; return
        find_action(a.children)
        if d: return
    find_action(c.GetRootActions())
    o={'eventId':eid,'action':None,'pipeline':{},'vertexInputs':[],'vbuffers':[],'ibuffer':None,'shaders':{},'constantBlocks':{},'resources':{},'samplers':[]}
    if d:
      o['action']={'name':d.GetName(c.GetStructuredFile()),'flags':int(d.flags),'numIndices':d.numIndices,'numInstances':d.numInstances,'indexOffset':d.indexOffset,'vertexOffset':d.vertexOffset,'baseVertex':d.baseVertex,'instanceOffset':d.instanceOffset}
    try:
      ib=st.GetIBuffer(); o['ibuffer']={'resource':rid(ib.resourceId),'byteOffset':ib.byteOffset,'byteStride':ib.byteStride}
    except Exception as x:o['ibuffer_error']=str(x)
    try:
      for i,v in enumerate(st.GetVBuffers()): o['vbuffers'].append({'slot':i,'resource':rid(v.resourceId),'byteOffset':v.byteOffset,'byteStride':v.byteStride,'byteSize':v.byteSize})
    except Exception as x:o['vbuffers_error']=str(x)
    try:
      for a in st.GetVertexInputs(): o['vertexInputs'].append({'name':a.name,'vertexBuffer':a.vertexBuffer,'byteOffset':a.byteOffset,'format':fmt(a.format),'perInstance':a.perInstance})
    except Exception as x:o['vertexInputs_error']=str(x)
    for stage,key in [(rd.ShaderStage.Vertex,'VS'),(rd.ShaderStage.Pixel,'PS')]:
      try:
        refl=st.GetShaderReflection(stage); o['shaders'][key]={'resourceId':rid(refl.resourceId),'entry':st.GetShaderEntryPoint(stage),'inputs':[str(x) for x in refl.inputSignature],'outputs':[str(x) for x in refl.outputSignature]}
      except Exception as x:o['shaders'][key+'_error']=str(x)
      try:
        blocks=st.GetConstantBlocks(stage);o['constantBlocks'][key]=[]
        for i,b in enumerate(blocks):
          z={'slot':i,'name':b.name,'byteSize':b.byteSize,'descriptor':str(b.descriptor),'variables':[str(v) for v in b.variables]};o['constantBlocks'][key].append(z)
      except Exception as x:o['constantBlocks'][key+'_error']=str(x)
      try:
        o['resources'][key]=[str(x) for x in st.GetReadOnlyResources(stage)]
      except Exception as x:o['resources'][key+'_error']=str(x)
      try:o['samplers'] += [{'stage':key,'items':[str(x) for x in st.GetSamplers(stage)]}]
      except:pass
    return o

def main():
  fn=r'F:\\endfield06.rdc'
  rd.InitialiseReplay(rd.GlobalEnvironment(),[]);cap=rd.OpenCaptureFile();res=cap.OpenFile(fn,'',None)
  if res!=rd.ResultCode.Succeeded: raise RuntimeError('open '+str(res))
  res,c=cap.OpenCapture(rd.ReplayOptions(),None)
  if res!=rd.ResultCode.Succeeded: raise RuntimeError('replay '+str(res))
  o=dump_event(c,3863)
  open(r'D:\endcopy\EID3336_URP_GBuffer_Workspace\EID3863_pipeline_dump.json','w',encoding='utf-8').write(json.dumps(o,indent=2,default=str))
  print(json.dumps(o,indent=2,default=str))
  c.Shutdown();cap.Shutdown();rd.ShutdownReplay()
try: main()
except Exception:
 traceback.print_exc();open(r'D:\endcopy\EID3336_URP_GBuffer_Workspace\EID3863_pipeline_error.txt','w').write(traceback.format_exc())



