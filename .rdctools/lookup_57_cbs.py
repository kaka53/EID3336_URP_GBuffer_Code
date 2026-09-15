import json
from pathlib import Path

data = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_12_65_shaders.json').read_text(encoding='utf8'))
item = None
for fam in data['families']:
    if fam.get('n') == 57 or fam.get('family') == 'VS215549_PS215550':
        item = fam
        break
print('PScb')
print(json.dumps(item['PScb'], indent=2, default=str)[:8000])
print('\nPSro')
print(json.dumps(item['PSro'], indent=2, default=str)[:8000])
print('\nVScb')
print(json.dumps(item['VScb'], indent=2, default=str)[:4000])
print('\nVSrw')
print(json.dumps(item['VSrw'], indent=2, default=str)[:2000])
print('\nPSinputs')
print(json.dumps(item['PSinputs'], indent=2, default=str)[:3000])
print('\nVSinputs')
print(json.dumps(item['VSinputs'], indent=2, default=str)[:3000])
