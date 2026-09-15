import json
from pathlib import Path

root = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace')
vs = (root / '.rdctools/shaders_12_65/951f4c6338c81689_VS.spvasm').read_text(encoding='utf8', errors='replace')
ps = (root / '.rdctools/shaders_12_65/d3eb4657e302f3fe_PS.spvasm').read_text(encoding='utf8', errors='replace')
dump = json.loads((root / '.rdctools/dump_215843.json').read_text(encoding='utf8'))
e = dump['3844']

print('=== VS lines', vs.count('\n'), 'PS lines', ps.count('\n'))
print('=== VS decorations / entry / inputs ===')
keys = [
    'EntryPoint', 'InstanceIndex', 'VertexIndex', 'Position',
    'Oct', '0.002', '0.0019', 'packed', 'asuint', 'bitfield',
    'StructuredBuffer', 'RuntimeArray', 'Instance',
    'uniforms26', 'uniforms22', 'uniforms30',
    'ImageSample', 'DXT5', 'Normal', 'Tangent',
]
for k in keys:
    if k.lower() in vs.lower() or k in vs:
        print('VS has', k)

# print first 80 non-empty lines of VS
print('\n=== VS head ===')
for i, line in enumerate(vs.splitlines()[:120]):
    if line.strip():
        print(f'{i:4d}|{line[:160]}')

print('\n=== VS search interesting ===')
for i, line in enumerate(vs.splitlines()):
    l = line.lower()
    if any(x in l for x in ['entrypoint', 'instanceindex', 'runtimearray', '0.002', '0.0019', 'bitcast', 'uint', 'input1', 'location']):
        if i < 400 or '0.00' in l or 'entrypoint' in l or 'runtimearray' in l:
            print(f'{i:4d}|{line[:180]}')
