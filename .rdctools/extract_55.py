import json
from pathlib import Path
inv = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/remaining_12_65_inventory.json').read_text(encoding='utf8'))
for item in inv:
    if item.get('n') in (54, 55, 56, 57, 64, 65):
        print(json.dumps({k: item[k] for k in item if k != 'draws'}, indent=2))
        print('draws', json.dumps(item.get('draws'), indent=2))
        print('---')
