from PIL import Image,ImageStat
import struct,math
w,h=1366,768
raw=open(r'Validation/EID4922/EID4922_RenderDoc_RT0_R11G11B10.raw','rb').read()
def uf(v,m):
 e=v>>m; f=v&((1<<m)-1)
 if e==0:return (f/(1<<m))*2**-14 if f else 0.0
 if e==31:return 65504.0 if f==0 else 0.0
 return (1+f/(1<<m))*2**(e-15)
pix=[]
for (p,) in struct.iter_unpack('<I',raw):
 r=uf(p&0x7ff,6);g=uf((p>>11)&0x7ff,6);b=uf((p>>22)&0x3ff,5)
 pix.append((max(0,min(255,round(r*255))),max(0,min(255,round(g*255))),max(0,min(255,round(b*255)))))
im=Image.new('RGB',(w,h)); im.putdata(pix); im.save(r'Validation/EID4922/EID4922_RenderDoc_RT0.png')
im.transpose(Image.Transpose.FLIP_TOP_BOTTOM).save(r'Validation/EID4922/EID4922_RenderDoc_RT0_FlipY.png')
st=ImageStat.Stat(im);print('mean',st.mean,'extrema',st.extrema,'colors',len(im.getcolors(maxcolors=2000000)))
pts=[(0,0),(w-1,0),(0,h-1),(w-1,h-1),(w//2,h//2)]
print([(p,im.getpixel(p)) for p in pts])
u=Image.open(r'Validation/EID4922/05_Exact.png').convert('RGB');st2=ImageStat.Stat(u);print('unity',st2.mean,st2.extrema,[(p,u.getpixel((round(p[0]*(u.width-1)/(w-1)),round(p[1]*(u.height-1)/(h-1))))) for p in pts])
