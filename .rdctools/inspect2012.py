import json

def work(c):
    eid=2012
    c.SetFrameEvent(eid, True)
    s=c.GetPipelineState()
    action=None
    near=[]
    def walk(xs):
        nonlocal action
        for a in xs:
            if abs(a.eventId-eid)<=8:
                near.append(serialize.action_description(a))
            if a.eventId==eid: action=serialize.action_description(a)
            walk(a.children)
    walk(c.GetRootActions())
    return {
      'event':eid,
      'action':action,
      'nearby':near,
      'pipeline':serialize.pipeline_state(s),
      'textures':[serialize.texture_description(t) for t in c.GetTextures()],
      'buffers':[serialize.buffer_description(b) for b in c.GetBuffers()],
    }
ctx.replay(work)
