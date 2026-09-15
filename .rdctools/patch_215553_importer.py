import os

src = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215517_PS215518_Batch/Editor/ColourPass6VS215517PS215518BatchImporter.cs'
dst = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215553_PS215554_Batch/Editor/ColourPass6VS215553PS215554BatchImporter.cs'
text = open(src, encoding='utf8').read()

unique_once = [
    (
        'if (Rid(p, "res32") == 0 || Rid(p, "res34") == 0 || Rid(p, "res36") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res32/res34/res36.");\n        byte[] local = ReadCB(p, "PS", "uniforms38");\n        if (local.Length < 544) throw new InvalidDataException("EID" + p.eid + " PS uniforms38 expected 544 bytes, got " + local.Length);\n        byte[] inst = ReadCB(p, "VS", "uniforms28");\n        if (inst.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " VS uniforms28 too small: " + inst.Length);\n        byte[] overlay = ReadCB(p, "PS", "uniforms23");\n        if (overlay.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " PS uniforms23 too small: " + overlay.Length);',
        'if (Rid(p, "res23") == 0 || Rid(p, "res25") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res23/res25.");\n        byte[] local = ReadCB(p, "PS", "uniforms28");\n        if (local.Length < 368) throw new InvalidDataException("EID" + p.eid + " PS uniforms28 expected 368 bytes, got " + local.Length);\n        byte[] inst = ReadCB(p, "VS", "uniforms28");\n        if (inst.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " VS uniforms28 too small: " + inst.Length);\n        byte[] overlay = ReadCB(p, "PS", "uniforms20");\n        if (overlay.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " PS uniforms20 too small: " + overlay.Length);',
    ),
    (
        'byte[] local = ReadCB(p, "PS", "uniforms38");\n        for (int i = 0; i < 34; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms40");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));\n        ApplyInstanceOverlay(m, p, 0);\n        byte[] globals = ReadCB(p, "PS", "uniforms20");\n        m.SetFloat("_EID215518MipBias", ReadFloat(globals, 416));\n        Texture albedo = LoadTexture(p, "res32");\n        Texture normalTex = LoadTexture(p, "res34");\n        Texture overlayTex = LoadTexture(p, "res36");\n        if (albedo == null || normalTex == null || overlayTex == null)\n            throw new FileNotFoundException("EID" + p.eid + " res32/res34/res36 texture binding is incomplete.");\n        m.SetTexture("_Res32", albedo);\n        m.SetTexture("_Res34", normalTex);\n        m.SetTexture("_Res36", overlayTex);\n        EditorUtility.SetDirty(m);\n        report.AppendLine("EID" + p.eid + ": material res32=RID" + Rid(p, "res32") + " res34=RID" + Rid(p, "res34") + " res36=RID" + Rid(p, "res36") + " PS uniforms38=" + local.Length + "B");',
        'byte[] local = ReadCB(p, "PS", "uniforms28");\n        for (int i = 0; i < 23; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms30");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));\n        ApplyInstanceOverlay(m, p, 0);\n        byte[] globals = ReadCB(p, "PS", "uniforms17");\n        m.SetFloat("_EID215554MipBias", ReadFloat(globals, 416));\n        Texture albedo = LoadTexture(p, "res23");\n        Texture normalTex = LoadTexture(p, "res25");\n        if (albedo == null || normalTex == null)\n            throw new FileNotFoundException("EID" + p.eid + " res23/res25 texture binding is incomplete.");\n        m.SetTexture("_Res23", albedo);\n        m.SetTexture("_Res25", normalTex);\n        EditorUtility.SetDirty(m);\n        report.AppendLine("EID" + p.eid + ": material res23=RID" + Rid(p, "res23") + " res25=RID" + Rid(p, "res25") + " PS uniforms28=" + local.Length + "B");',
    ),
    (
        'byte[] overlay = ReadCB(p, "PS", "uniforms23");',
        'byte[] overlay = ReadCB(p, "PS", "uniforms20");',
    ),
    (
        'audit.Insert(0, "# VS215517 / PS215518 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `39.1-39.2`\\n- Layout variants: `" + layouts + "` (`d6a844f320196881`)\\n- Shader: live Unity VP; unique res32/res34/res36; PS uniforms38 34 float4; VT off; packed oct 0.0019569471478462219; 3-layer overlay\\n\\n");',
        'audit.Insert(0, "# VS215553 / PS215554 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `44.1-44.2`\\n- Layout variants: `" + layouts + "` (`d6a844f320196881`)\\n- Shader: live Unity VP; unique res23/res25; PS uniforms28 368B; Cull Back; ZWrite Off; ZTest GEqual; stencil 0; AlphaTest clip; skip skin; oct 0.0019569471478462219; isolate from family 39\\n\\n");',
    ),
]

missing = []
for a, b in unique_once:
    n = text.count(a)
    if n != 1:
        missing.append((n, a[:220]))
    else:
        text = text.replace(a, b, 1)

global_pairs = [
    ('ColourPass6VS215517PS215518BatchImporter', 'ColourPass6VS215553PS215554BatchImporter'),
    ('Assets/ColourPass6_VS215517_PS215518_Batch', 'Assets/ColourPass6_VS215553_PS215554_Batch'),
    ('VS215517_PS215518_BatchManifest.json', 'VS215553_PS215554_BatchManifest.json'),
    ('Shaders/EID215517215518GBuffer.shader', 'Shaders/EID215553215554GBuffer.shader'),
    ('Validation/ColourPass6_VS215517', 'Validation/ColourPass6_VS215553'),
    ('ColourPass6_VS215517_PS215518', 'ColourPass6_VS215553_PS215554'),
    ('static readonly int[] ExpectedEIDs = { 3439, 3443 };', 'static readonly int[] ExpectedEIDs = { 3761, 3765 };'),
    ('static readonly int ExpectedInstances = 4;', 'static readonly int ExpectedInstances = 3;'),
    ('[MenuItem("Tools/Colour Pass 6/Import EID 39.1-39.2 (VS215517 PS215518)")]', '[MenuItem("Tools/Colour Pass 6/Import EID 44.1-44.2 (VS215553 PS215554)")]'),
    ('Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 39.1-39.2.', 'Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 44.1-44.2.'),
    ('Expected EIDs 39.1-39.2, got ', 'Expected EIDs 44.1-44.2, got '),
    ('VS215517/PS215518 shader has compile errors', 'VS215553/PS215554 shader has compile errors'),
    ('EID215517DrawProfile', 'EID215553DrawProfile'),
    ('"EID" + p.eid + " VS215517 Complete VSInput"', '"EID" + (p.sharedGeometryFromEID != 0 ? p.sharedGeometryFromEID : p.eid) + " VS215553 Complete VSInput"'),
    ('path = Root + "/Materials/EID" + p.eid + "_VS215517_PS215518.mat";', 'path = Root + "/Materials/EID" + p.eid + "_VS215553_PS215554.mat";'),
    ('m.name = "EID" + p.eid + " VS215517 PS215518";', 'm.name = "EID" + p.eid + " VS215553 PS215554";'),
    ('g.material.shader.name != "EID/URP/VS215517_PS215518_GBuffer"', 'g.material.shader.name != "EID/URP/VS215553_PS215554_GBuffer"'),
    ('"39.1-39.2 instance total expected "', '"44.1-44.2 instance total expected "'),
    ('[ColourPass6] VS215517/PS215518 import completed', '[ColourPass6] VS215553/PS215554 import completed'),
    ('EID215517', 'EID215553'),
    ('215517', '215553'),
    ('215518', '215554'),
]

global_missing = []
for a, b in global_pairs:
    n = text.count(a)
    if n == 0:
        global_missing.append(a[:160])
    else:
        text = text.replace(a, b)

open(dst, 'w', encoding='utf8', newline='\n').write(text)
print('wrote', dst, os.path.getsize(dst))
print('unique_missing', missing)
print('global_missing', global_missing)
leftover = []
for needle in ['215517', '215518', 'res32', 'res34', 'res36', 'uniforms38', 'uniforms40', 'uniforms23', '3439', '3443', '39.1', 'EID215517']:
    if needle in text:
        leftover.append((needle, text.count(needle)))
print('leftover', leftover)
print('uniforms28', text.count('uniforms28'))
print('uniforms20', text.count('uniforms20'))
print('uniforms17', text.count('uniforms17'))
print('uniforms30', text.count('uniforms30'))
print('res23', text.count('res23'))
print('res25', text.count('res25'))
