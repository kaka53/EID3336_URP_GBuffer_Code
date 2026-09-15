import json
from pathlib import Path

data = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_12_65_shaders.json').read_text(encoding='utf8'))
item = None
for fam in data['families']:
    if fam.get('n') == 57:
        item = fam
        break
print('PScb names/sz/nvars:')
for cb in item['PScb']:
    print(' ', cb['n'], 'sz', cb['sz'], 'bind', cb['bind'], 'nvars', cb['nvars'])
print('VScb names/sz:')
for cb in item['VScb']:
    print(' ', cb['n'], 'sz', cb['sz'], 'bind', cb['bind'], 'nvars', cb['nvars'])
u30 = [cb for cb in item['PScb'] if cb['n'] == 'uniforms30'][0]
print('\nuniforms30 nvars', u30['nvars'], 'sz', u30['sz'])
for v in u30['vars']:
    print('  %s off=%s rows=%s cols=%s elems=%s' % (v['n'], v['off'], v['rows'], v['cols'], v['elems']))
