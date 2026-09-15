import os

src = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215512_PS215513_Batch/Editor/ColourPass6VS215512PS215513BatchImporter.cs'
dst = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215537_PS215538_Batch/Editor/ColourPass6VS215537PS215538BatchImporter.cs'
text = open(src, encoding='utf8').read()

# Unique fragments first so later identifier replaces cannot collide.
unique_once = [
    (
        'byte[] local = ReadCB(p, "PS", "uniforms32");\n        if (local.Length < 448) throw new InvalidDataException("EID" + p.eid + " PS uniforms32 expected 448 bytes, got " + local.Length);',
        'byte[] local = ReadCB(p, "PS", "uniforms38");\n        if (local.Length < 512) throw new InvalidDataException("EID" + p.eid + " PS uniforms38 expected 512 bytes, got " + local.Length);',
    ),
    (
        'byte[] overlay = ReadCB(p, "PS", "uniforms24");\n        if (overlay.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " PS uniforms24 too small: " + overlay.Length);',
        'byte[] overlay = ReadCB(p, "PS", "uniforms25");\n        if (overlay.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " PS uniforms25 too small: " + overlay.Length);',
    ),
    (
        'byte[] local = ReadCB(p, "PS", "uniforms32");\n        for (int i = 0; i < 28; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));',
        'byte[] local = ReadCB(p, "PS", "uniforms38");\n        for (int i = 0; i < 32; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));',
    ),
    ('byte[] meta = ReadCB(p, "PS", "uniforms34");', 'byte[] meta = ReadCB(p, "PS", "uniforms40");'),
    ('byte[] globals = ReadCB(p, "PS", "uniforms21");', 'byte[] globals = ReadCB(p, "PS", "uniforms22");'),
    (
        'Texture albedo = LoadTexture(p, "res27");\n        Texture normalTex = LoadTexture(p, "res29");',
        'Texture albedo = LoadTexture(p, "res33");\n        Texture normalTex = LoadTexture(p, "res35");',
    ),
    (
        'm.SetTexture("_Res27", albedo);\n        m.SetTexture("_Res29", normalTex);',
        'm.SetTexture("_Res33", albedo);\n        m.SetTexture("_Res35", normalTex);',
    ),
    (
        'byte[] overlay = ReadCB(p, "PS", "uniforms24");\n        int o = instance * 256;',
        'byte[] overlay = ReadCB(p, "PS", "uniforms25");\n        int o = instance * 256;',
    ),
    ('Rid(p, "res27") == 0 || Rid(p, "res29") == 0', 'Rid(p, "res33") == 0 || Rid(p, "res35") == 0'),
    ('missing material slots res27/res29.', 'missing material slots res33/res35.'),
    ('EID" + p.eid + " res27/res29 texture binding is incomplete.', 'EID" + p.eid + " res33/res35 texture binding is incomplete.'),
    (
        'EID" + p.eid + ": material res27=RID" + Rid(p, "res27") + " res29=RID" + Rid(p, "res29") + " PS uniforms32=" + local.Length + "B"',
        'EID" + p.eid + ": material res33=RID" + Rid(p, "res33") + " res35=RID" + Rid(p, "res35") + " PS uniforms38=" + local.Length + "B"',
    ),
]

missing = []
for a, b in unique_once:
    n = text.count(a)
    if n != 1:
        missing.append((n, a[:140]))
    else:
        text = text.replace(a, b, 1)

global_pairs = [
    ('ColourPass6VS215512PS215513BatchImporter', 'ColourPass6VS215537PS215538BatchImporter'),
    ('Assets/ColourPass6_VS215512_PS215513_Batch', 'Assets/ColourPass6_VS215537_PS215538_Batch'),
    ('VS215512_PS215513_BatchManifest.json', 'VS215537_PS215538_BatchManifest.json'),
    ('Shaders/EID215512215513GBuffer.shader', 'Shaders/EID215537215538GBuffer.shader'),
    ('Validation/ColourPass6_VS215512', 'Validation/ColourPass6_VS215537'),
    ('ColourPass6_VS215512_PS215513', 'ColourPass6_VS215537_PS215538'),
    ('static readonly int[] ExpectedEIDs = { 3204, 3208, 3212, 3217, 3222, 3226 };', 'static readonly int[] ExpectedEIDs = { 3617, 3621 };'),
    ('static readonly int ExpectedInstances = 7;', 'static readonly int ExpectedInstances = 4;'),
    ('static readonly int ExpectedLayoutVariants = 2;', 'static readonly int ExpectedLayoutVariants = 1;'),
    ('[MenuItem("Tools/Colour Pass 6/Import EID 17.1-17.6 (VS215512 PS215513)")]', '[MenuItem("Tools/Colour Pass 6/Import EID 41.1-41.2 (VS215537 PS215538)")]'),
    ('profiles for 17.1-17.6.', 'profiles for 41.1-41.2.'),
    ('Expected EIDs 17.1-17.6, got "', 'Expected EIDs 41.1-41.2, got "'),
    ('VS215512/PS215513 shader has compile errors', 'VS215537/PS215538 shader has compile errors'),
    ('EID215512DrawProfile', 'EID215537DrawProfile'),
    ('if (p.vs != 215512 || p.ps != 215513)', 'if (p.vs != 215537 || p.ps != 215538)'),
    ('VS215512 Complete VSInput', 'VS215537 Complete VSInput'),
    ('Materials/EID" + p.eid + "_VS215512_PS215513.mat', 'Materials/EID" + p.eid + "_VS215537_PS215538.mat'),
    ('m.name = "EID" + p.eid + " VS215512 PS215513"', 'm.name = "EID" + p.eid + " VS215537 PS215538"'),
    ('"17.1-17.6 instance total expected "', '"41.1-41.2 instance total expected "'),
    ('EID/URP/VS215512_PS215513_GBuffer', 'EID/URP/VS215537_PS215538_GBuffer'),
    ('[ColourPass6] VS215512/PS215513 import completed', '[ColourPass6] VS215537/PS215538 import completed'),
    (
        '# VS215512 / PS215513 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `17.1-17.6`\\n- Layout variants: `" + layouts + "` (`e525fa9f6e4b6e7a` majority, `a554ffdeec97df50` 17.4)\\n- Shader: live Unity VP; unique res27/res29; PS uniforms32 448B; Cull Back; ZWrite On; stencil 0; skip skin (flags 0); scan/rim in RT0\\n\\n"',
        '# VS215537 / PS215538 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `41.1-41.2`\\n- Layout variants: `" + layouts + "` (`a554ffdeec97df50`)\\n- Shader: live Unity VP; unique res33/res35; PS uniforms38 512B; Cull Off; ZWrite Off; ZTest Equal; stencil 0; skip skin (flags 0); scan/rim in RT0; isolate from family 17\\n\\n"',
    ),
]

for a, b in global_pairs:
    n = text.count(a)
    if n == 0:
        missing.append((0, a[:140]))
    else:
        text = text.replace(a, b)

os.makedirs(os.path.dirname(dst), exist_ok=True)
open(dst, 'w', encoding='utf8', newline='\n').write(text)
print('wrote', dst, os.path.getsize(dst))
print('missing', missing)
leftover = []
for needle in ['215512', '215513', 'res27', 'res29', 'uniforms32', 'uniforms24', 'uniforms21', 'uniforms34', '17.1', '17.4', '17.6', '3204', 'PS215513']:
    if needle in text:
        leftover.append((needle, text.count(needle)))
print('leftover', leftover)
print('uniforms29', text.count('uniforms29'))
print('uniforms25', text.count('uniforms25'))
print('uniforms38', text.count('uniforms38'))
print('uniforms22', text.count('uniforms22'))
print('uniforms40', text.count('uniforms40'))
print('res33', text.count('res33'))
print('res35', text.count('res35'))
