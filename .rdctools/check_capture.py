import json
print(json.dumps({'loaded':str(ctx.GetFilename()),'roots':len(ctx.GetRootActions()),'first':[a.eventId for a in ctx.GetRootActions()[:5]]},default=str))
