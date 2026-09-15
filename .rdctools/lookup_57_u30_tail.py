import json
from pathlib import Path
item = None
data = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_12_65_shaders.json').read_text(encoding='utf8'))
for fam in data['families']:
    if fam.get('n') == 57:
        item = fam
        break
u30 = [cb for cb in item['PScb'] if cb['n'] == 'uniforms30'][0]
print('remaining children after 39:')
for v in u30['vars'][40:]:
    print('  %s off=%s rows=%s cols=%s elems=%s' % (v['n'], v['off'], v['rows'], v['cols'], v['elems']))
print('last off', u30['vars'][-1]['off'], 'nvars', u30['nvars'])
