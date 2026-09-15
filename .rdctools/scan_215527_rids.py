from pathlib import Path
import json

dump = json.loads(Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/dump_215527.json').read_text(encoding='utf8'))
e = dump['3561']
print('localKidsN', len(e['localKids']))
print('pstex', e['pstex'])
print('mip', {k: v for k, v in e['slices'].items() if 'mip' in k or 'y436' in k or 'uniforms38' in k or 'uniforms36' in k})
print('sref', e['sref'], 'sfn', e['sfn'], 'scm', e.get('scm'), 'swm', e.get('swm'))
print('flags', e['flags'], 'mats', e['mats'])

# print remaining kids if truncated in summary (full dump has all)
for k in e['localKids']:
    print('%s off=%s rows=%s cols=%s val=%s' % (k['name'], k['off'], k['rows'], k['cols'], k.get('val')))

# search RID existence
rids = [166, 279845, 269135, 257548, 175]
root = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets')
found = {r: [] for r in rids}
# only scan TextureDatabase folders to stay fast
for p in root.rglob('rid*.dds'):
    name = p.name.lower()
    for r in rids:
        if name == ('rid%d.dds' % r) or name.startswith('rid%d.' % r):
            found[r].append(str(p.relative_to(root)))
print('\nRID hits:')
for r, xs in found.items():
    print(r, xs[:8], 'n=', len(xs))
