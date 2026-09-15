from pathlib import Path
p=Path('Assets/EID3332_EID3336_Combined/Scenes/EID3336_RenderDocCamera.unity')
lines=p.read_text().splitlines()
for i,l in enumerate(lines):
 if l.startswith('--- !u!20 '):
  chunk='\n'.join(lines[i:i+45]);
  print('---',i+1); print(chunk[:1800])
