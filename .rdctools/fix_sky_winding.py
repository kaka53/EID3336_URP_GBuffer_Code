from pathlib import Path
p=Path('.rdctools/make_eid4922_obj.py')
s=p.read_text().replace("f.write('f %d/%d %d/%d %d/%d\\n'%(a,a,b,b,c,c))", "f.write('f %d/%d %d/%d %d/%d\\n'%(a,a,c,c,b,b))")
p.write_text(s)
