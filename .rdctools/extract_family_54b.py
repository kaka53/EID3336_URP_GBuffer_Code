import json
from pathlib import Path

sh = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_12_65_shaders.json').read_text(encoding='utf8'))
for fam in sh['families']:
    if fam.get('n') in (52, 53, 54, 55, 56, 64):
        print('n', fam.get('n'), 'family', fam.get('family'), 'eid', fam.get('eid'))
        print('  VSH', fam.get('VSH'))
        print('  PSH', fam.get('PSH'))
        print('  VSbytes', fam.get('VSbytes'), 'PSbytes', fam.get('PSbytes'))
        print('  VSfile', fam.get('VSfile'))
        print('  PSfile', fam.get('PSfile'))
        print('  VSinputs', json.dumps(fam.get('VSinputs'))[:500])
