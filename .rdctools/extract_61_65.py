import json
from pathlib import Path

inv = json.loads(Path('.rdctools/remaining_12_65_inventory.json').read_text(encoding='utf8'))
sh = json.loads(Path('.rdctools/dump_12_65_shaders.json').read_text(encoding='utf8'))

items = inv if isinstance(inv, list) else inv.get('families', inv.get('items', []))
if isinstance(inv, dict) and not items:
    items = [inv[k] for k in sorted(inv) if k.isdigit() or str(k).startswith('6')]

print('INV TYPE', type(inv).__name__, 'len', len(inv) if hasattr(inv, '__len__') else '?')
if isinstance(inv, dict):
    print('INV KEYS', list(inv.keys())[:20])

def show(obj, n):
    if isinstance(obj, list):
        for x in obj:
            num = x.get('n') or x.get('family') or x.get('index')
            if num in (n, str(n), '6%d'%n if False else n):
                print('INV', n, json.dumps(x, indent=2)[:2500])
                return
            fam = str(x.get('family','') or x.get('name','') or '')
            if fam.startswith('VS239789') or (n==61 and '239789' in fam):
                print('INV', n, json.dumps(x, indent=2)[:2500]); return
            if n==62 and '241568' in fam:
                print('INV', n, json.dumps(x, indent=2)[:2500]); return
            if n==63 and '243940' in fam:
                print('INV', n, json.dumps(x, indent=2)[:2500]); return
            if n==64 and '244085' in fam:
                print('INV', n, json.dumps(x, indent=2)[:2500]); return
            if n==65 and '264371' in fam:
                print('INV', n, json.dumps(x, indent=2)[:2500]); return
    elif isinstance(obj, dict):
        for k,v in obj.items():
            s = json.dumps(v) if not isinstance(v, str) else v
            if str(n) == str(k) or ('239789' in str(k) and n==61) or (isinstance(v, dict) and v.get('n')==n):
                print('INV', n, k, json.dumps(v, indent=2)[:2500] if not isinstance(v, str) else v[:2500])
                return

for n in range(61,66):
    show(items if items else inv, n)
    print('---')

# shaders
print('SH TYPE', type(sh).__name__)
if isinstance(sh, dict):
    print('SH KEYS', list(sh.keys())[:20])
    for k,v in list(sh.items())[:3]:
        print(' sample', k, type(v).__name__)
data = sh.get('families') or sh.get('items') or sh
if isinstance(data, list):
    for x in data:
        fam = str(x.get('family','') or x.get('name','') or x.get('n',''))
        if any(s in fam or s in json.dumps(x)[:200] for s in ['239789','241568','243940','244085','264371']):
            print('SH', json.dumps({k:v for k,v in x.items() if k!='disasm'}, indent=2)[:2000])
            print('---')
elif isinstance(data, dict):
    for k,v in data.items():
        js = json.dumps(v) if not isinstance(v, str) else v
        if any(s in str(k) or s in js[:400] for s in ['239789','241568','243940','244085','264371']):
            print('SH', k, js[:2000])
            print('---')
