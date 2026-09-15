import csv
from pathlib import Path
p = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Validation/ColourPass6Classification/ColourPass6_EID_Flat.csv')
with p.open(encoding='utf8') as f:
    r = csv.DictReader(f)
    rows = list(r)
print('cols', rows[0].keys())
for row in rows:
    fam = row.get('family') or row.get('Family') or row.get('familyIndex') or row.get('#')
    vs = row.get('vs') or row.get('VS') or row.get('vsId')
    if str(fam) in ('58','59','60','61','62','63','64','65') or str(vs) in ('215843','215847','229351','239789','241568','243940','244085','264371'):
        print(row)
