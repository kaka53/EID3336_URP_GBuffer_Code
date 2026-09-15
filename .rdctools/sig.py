import inspect as _i
out = {}
try:
    out['GetPostVSData_sig'] = str(_i.signature(rd.ReplayController.GetPostVSData))
except Exception as e:
    out['GetPostVSData_sig'] = 'ERR:' + str(e)
out['GetPostVSData_doc'] = rd.ReplayController.GetPostVSData.__doc__
out
