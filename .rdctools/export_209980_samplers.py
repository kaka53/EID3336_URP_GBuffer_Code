import json
EIDS=[2768,2772,2777,2782,2787,2791,2795,2799,2804,2809,2813,2818,2823,2828,2833,2838,2842,2847,2851,2856,2860,2865,2870,2874,2876,2880,2882,2886,2891,2896,2900,2905,2907,2912,2916]
def work(c):
 out={}
 for eid in EIDS:
  c.SetFrameEvent(eid,False);s=c.GetPipelineState();a=[]
  for i,u in enumerate(s.GetSamplers(rd.ShaderStage.Pixel)):
   q=u.sampler;f=q.filter;a.append({'index':i,'binding':int(u.access.byteOffset),'minify':str(f.minify),'magnify':str(f.magnify),'mip':str(f.mip),'function':str(f.filter),'addressU':str(q.addressU),'addressV':str(q.addressV),'addressW':str(q.addressW),'mipBias':float(q.mipBias),'minLOD':float(q.minLOD),'maxLOD':float(q.maxLOD),'maxAnisotropy':float(q.maxAnisotropy),'unnormalized':bool(q.unnormalized),'compareFunction':str(q.compareFunction)})
  out[str(eid)]=a
 return out
r=ctx.replay(work);path=r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass2_VS209980_PS209981_Batch/SamplerStates.json';open(path,'w',encoding='utf8').write(json.dumps(r,indent=2));print(json.dumps({'groups':len(set(json.dumps(v,sort_keys=True) for v in r.values())),'first':r['2768']},default=str))
