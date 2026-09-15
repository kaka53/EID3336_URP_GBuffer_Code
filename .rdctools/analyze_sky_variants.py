from PIL import Image,ImageStat
from pathlib import Path
for p in sorted(Path('Validation/EID4922').glob('0*.png')):
 im=Image.open(p).convert('RGB'); st=ImageStat.Stat(im); colors=im.getcolors(maxcolors=1000000)
 print(p.name,'mean',tuple(round(x,3) for x in st.mean),'extrema',st.extrema,'colors',len(colors) if colors else '>1m','center',im.getpixel((im.width//2,im.height//2)))
