from pathlib import Path

IMP = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215493_PS215494_Batch/Editor/ColourPass6VS215493PS215494BatchImporter.cs')
text = IMP.read_text(encoding='utf8')

repls = [
    ('static readonly int[] ExpectedEIDs = { 3704, 3708, 3712, 3716, 3720, 3724 };',
     'static readonly int[] ExpectedEIDs = { 2528, 2533 };'),
    ('static readonly int ExpectedInstances = 14;',
     'static readonly int ExpectedInstances = 3;'),
    ('static readonly int ExpectedLayoutVariants = 1;',
     'static readonly int ExpectedLayoutVariants = 2;'),
    ('[MenuItem("Tools/Colour Pass 6/Import EID 18.1-18.6 (VS215493 PS215494)")]',
     '[MenuItem("Tools/Colour Pass 6/Import EID 36.1-36.2 (VS215493 PS215494)")]'),
    ('throw new InvalidDataException("Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 18.1-18.6.");',
     'throw new InvalidDataException("Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 36.1-36.2.");'),
    ('throw new InvalidDataException("Expected EIDs 18.1-18.6, got " + string.Join(",", got));',
     'throw new InvalidDataException("Expected EIDs 36.1-36.2, got " + string.Join(",", got));'),
    ('if (Rid(p, "res31") == 0 || Rid(p, "res33") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res31/res33.");',
     'if (Rid(p, "res23") == 0 || Rid(p, "res25") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res23/res25.");'),
    ('byte[] local = ReadCB(p, "PS", "uniforms36");\n        if (local.Length < 416) throw new InvalidDataException("EID" + p.eid + " PS uniforms36 expected 416 bytes, got " + local.Length);',
     'byte[] local = ReadCB(p, "PS", "uniforms28");\n        if (local.Length < 416) throw new InvalidDataException("EID" + p.eid + " PS uniforms28 expected 416 bytes, got " + local.Length);'),
    ('byte[] overlay = ReadCB(p, "PS", "uniforms23");\n        if (overlay.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " PS uniforms23 too small: " + overlay.Length);',
     'byte[] overlay = ReadCB(p, "PS", "uniforms20");\n        if (overlay.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " PS uniforms20 too small: " + overlay.Length);'),
    ('byte[] local = ReadCB(p, "PS", "uniforms36");\n        for (int i = 0; i < 26; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms38");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));\n        ApplyInstanceOverlay(m, p, 0);\n        byte[] globals = ReadCB(p, "PS", "uniforms20");\n        m.SetFloat("_EID215494MipBias", ReadFloat(globals, 416));',
     'byte[] local = ReadCB(p, "PS", "uniforms28");\n        for (int i = 0; i < 26; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms30");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));\n        ApplyInstanceOverlay(m, p, 0);\n        byte[] globals = ReadCB(p, "PS", "uniforms17");\n        m.SetFloat("_EID215494MipBias", ReadFloat(globals, 416));\n        m.SetFloat("_LightMixY", ReadFloat(globals, 436));'),
    ('Texture albedo = LoadTexture(p, "res31");\n        Texture normalTex = LoadTexture(p, "res33");\n        if (albedo == null || normalTex == null)\n            throw new FileNotFoundException("EID" + p.eid + " res31/res33 texture binding is incomplete.");\n        m.SetTexture("_Res31", albedo);\n        m.SetTexture("_Res33", normalTex);\n        EditorUtility.SetDirty(m);\n        report.AppendLine("EID" + p.eid + ": material res31=RID" + Rid(p, "res31") + " res33=RID" + Rid(p, "res33") + " PS uniforms36=" + local.Length + "B");',
     'Texture albedo = LoadTexture(p, "res23");\n        Texture normalTex = LoadTexture(p, "res25");\n        if (albedo == null || normalTex == null)\n            throw new FileNotFoundException("EID" + p.eid + " res23/res25 texture binding is incomplete.");\n        m.SetTexture("_Res23", albedo);\n        m.SetTexture("_Res25", normalTex);\n        EditorUtility.SetDirty(m);\n        report.AppendLine("EID" + p.eid + ": material res23=RID" + Rid(p, "res23") + " res25=RID" + Rid(p, "res25") + " PS uniforms28=" + local.Length + "B");'),
    ('if (instances != ExpectedInstances) throw new InvalidDataException("18.1-18.6 instance total expected " + ExpectedInstances + ", got " + instances);',
     'if (instances != ExpectedInstances) throw new InvalidDataException("36.1-36.2 instance total expected " + ExpectedInstances + ", got " + instances);'),
    ('audit.Insert(0, "# VS215493 / PS215494 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `18.1-18.6`\\n- Layout variants: `" + layouts + "` (`d6a844f320196881`)\\n- Shader: live Unity VP; unique res31/res33; PS uniforms36 416B; Cull Off; ZWrite Off; stencil 0; skip skin (flags 0); VT omitted\\n\\n");',
     'audit.Insert(0, "# VS215493 / PS215494 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `36.1-36.2`\\n- Layout variants: `" + layouts + "` (`3572236fc9e4b455`, `a554ffdeec97df50`)\\n- Shader: live Unity VP; unique res23/res25; PS uniforms28 416B; Cull Off; ZWrite On; stencil 0; skip skin (flags 0); overlay from albedo/normal + uniforms20\\n\\n");'),
    ('static void ApplyInstanceOverlay(Material m, Profile p, int instance)\n    {\n        byte[] overlay = ReadCB(p, "PS", "uniforms23");\n        int o = instance * 256;\n        m.SetVector("_InstanceStateYZ", new Vector4(ReadFloat(overlay, o + 68), ReadFloat(overlay, o + 72), 0, 0));\n        EditorUtility.SetDirty(m);\n    }',
     'static void ApplyInstanceOverlay(Material m, Profile p, int instance)\n    {\n        byte[] overlay = ReadCB(p, "PS", "uniforms20");\n        int o = instance * 256;\n        m.SetVector("_InstanceStateYZ", new Vector4(ReadFloat(overlay, o + 68), ReadFloat(overlay, o + 72), 0, 0));\n        m.SetVector("_OverlayChild5", ReadVector4(overlay, o + 176));\n        m.SetVector("_OverlayChild7", ReadVector4(overlay, o + 208));\n        m.SetVector("_OverlayChild9", ReadVector4(overlay, o + 240));\n        EditorUtility.SetDirty(m);\n    }'),
]

for old, new in repls:
    if old not in text:
        raise SystemExit('missing fragment:\n' + old[:180])
    text = text.replace(old, new, 1)

IMP.write_text(text, encoding='utf8', newline='\n')
print('patched importer', IMP.stat().st_size)
for needle in ('3704', '18.1', 'uniforms36', 'uniforms38', 'uniforms23', 'res31', 'res33', 'ZWrite Off'):
    if needle in text:
        print('LEFTOVER', needle)
    else:
        print('clean', needle)
