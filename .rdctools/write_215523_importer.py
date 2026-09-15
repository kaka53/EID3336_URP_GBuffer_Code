from pathlib import Path

src = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215491_PS215492_Batch/Editor/ColourPass6VS215491PS215492BatchImporter.cs')
text = src.read_text(encoding='utf8')

subs = [
    ('ColourPass6VS215491PS215492BatchImporter', 'ColourPass6VS215523PS215524BatchImporter'),
    ('EID215491DrawProfile', 'EID215523DrawProfile'),
    ('VS215491_PS215492', 'VS215523_PS215524'),
    ('VS215491/PS215492', 'VS215523/PS215524'),
    ('VS215491 PS215492', 'VS215523 PS215524'),
    ('EID215491215492', 'EID215523215524'),
    ('ColourPass6_VS215491', 'ColourPass6_VS215523'),
    ('EID/URP/VS215523_PS215524_GBuffer', 'EID/URP/VS215523_PS215524_GBuffer'),
    ('Import EID 51.1 (VS215523 PS215524)', 'Import EID 53.1 (VS215523 PS215524)'),
    ('exactly " + ExpectedEIDs.Length + " profiles for 51.1.', 'exactly " + ExpectedEIDs.Length + " profiles for 53.1.'),
    ('Expected EID 51.1, got ', 'Expected EID 53.1, got '),
    ('static readonly int[] ExpectedEIDs = { 3231 };', 'static readonly int[] ExpectedEIDs = { 3545 };'),
    ('static readonly int ExpectedInstances = 6;', 'static readonly int ExpectedInstances = 21;'),
    ('if (p.vs != 215491 || p.ps != 215492)', 'if (p.vs != 215523 || p.ps != 215524)'),
    ('VS215491 Complete VSInput', 'VS215523 Complete VSInput'),
    ('if (Rid(p, "res27") == 0 || Rid(p, "res29") == 0 || Rid(p, "res31") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res27/res29/res31.");',
     'if (Rid(p, "res26") == 0 || Rid(p, "res28") == 0 || Rid(p, "res30") == 0 || Rid(p, "res32") == 0 || Rid(p, "res34") == 0 || Rid(p, "res36") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res26/res28/res30/res32/res34/res36.");'),
    ('byte[] local = ReadCB(p, "PS", "uniforms33");\n        if (local.Length < 416) throw new InvalidDataException("EID" + p.eid + " PS uniforms33 expected 416 bytes, got " + local.Length);',
     'byte[] local = ReadCB(p, "PS", "uniforms39");\n        if (local.Length < 576) throw new InvalidDataException("EID" + p.eid + " PS uniforms39 expected 576 bytes, got " + local.Length);'),
    ('byte[] local = ReadCB(p, "PS", "uniforms33");\n        for (int i = 0; i < 26; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms35");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));\n        ApplyInstanceState(m, p, 0);\n        byte[] globals = ReadCB(p, "PS", "uniforms20");\n        m.SetFloat("_EID215492MipBias", ReadFloat(globals, 416));\n        m.SetFloat("_UseBakedSkinning", HasCapturedSkinning(p) ? 1f : 0f);\n        Texture albedo = LoadTexture(p, "res27");\n        Texture normalTex = LoadTexture(p, "res29");\n        Texture extra = LoadTexture(p, "res31");\n        if (albedo == null || normalTex == null || extra == null)\n            throw new FileNotFoundException("EID" + p.eid + " res27/res29/res31 texture binding is incomplete.");\n        m.SetTexture("_Res27", albedo);\n        m.SetTexture("_Res29", normalTex);\n        m.SetTexture("_Res31", extra);\n        EditorUtility.SetDirty(m);\n        report.AppendLine("EID" + p.eid + ": material res27=RID" + Rid(p, "res27") + " res29=RID" + Rid(p, "res29") + " res31=RID" + Rid(p, "res31") + " PS uniforms33=" + local.Length + "B");',
     'byte[] local = ReadCB(p, "PS", "uniforms39");\n        for (int i = 0; i < 36; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms41");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));\n        ApplyInstanceState(m, p, 0);\n        byte[] globals = ReadCB(p, "PS", "uniforms20");\n        m.SetFloat("_EID215524MipBias", ReadFloat(globals, 416));\n        m.SetFloat("_ScanPomGrad", ReadFloat(globals, 420));\n        m.SetFloat("_ScanGlobalY", ReadFloat(globals, 436));\n        m.SetVector("_ScanPos", ReadVector4(globals, 1648));\n        m.SetVector("_ScanPoint", ReadVector4(globals, 1680));\n        m.SetFloat("_UseBakedSkinning", HasCapturedSkinning(p) ? 1f : 0f);\n        Texture albedo = LoadTexture(p, "res26");\n        Texture normalTex = LoadTexture(p, "res28");\n        Texture extra = LoadTexture(p, "res30");\n        Texture scan = LoadTexture(p, "res32");\n        Texture mix4 = LoadTexture(p, "res34");\n        Texture height = LoadTexture(p, "res36");\n        if (albedo == null || normalTex == null || extra == null || scan == null || mix4 == null || height == null)\n            throw new FileNotFoundException("EID" + p.eid + " res26/res28/res30/res32/res34/res36 texture binding is incomplete.");\n        m.SetTexture("_Res26", albedo);\n        m.SetTexture("_Res28", normalTex);\n        m.SetTexture("_Res30", extra);\n        m.SetTexture("_Res32", scan);\n        m.SetTexture("_Res34", mix4);\n        m.SetTexture("_Res36", height);\n        EditorUtility.SetDirty(m);\n        report.AppendLine("EID" + p.eid + ": material res26=RID" + Rid(p, "res26") + " res28=RID" + Rid(p, "res28") + " res30=RID" + Rid(p, "res30") + " res32=RID" + Rid(p, "res32") + " res34=RID" + Rid(p, "res34") + " res36=RID" + Rid(p, "res36") + " PS uniforms39=" + local.Length + "B");'),
    ('if (instances != ExpectedInstances) throw new InvalidDataException("51.1 instance total expected " + ExpectedInstances + ", got " + instances);',
     'if (instances != ExpectedInstances) throw new InvalidDataException("53.1 instance total expected " + ExpectedInstances + ", got " + instances);'),
    ('audit.Insert(0, "# VS215523 / PS215524 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `51.1`\\n- Layout variants: `" + layouts + "` (`d6a844f320196881`)\\n- Shader: live Unity VP; unique res27/res29/res31; PS uniforms33 416B; Cull Back; ZWrite On; ZTest GEqual; stencil 0; skip skin (flags 0); extra map + distance fade; RT0 black\\n\\n");',
     'audit.Insert(0, "# VS215523 / PS215524 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `53.1`\\n- Layout variants: `" + layouts + "` (`d6a844f320196881`)\\n- Shader: live Unity VP; unique res26/res28/res30/res32/res34/res36; PS uniforms39 576B; Cull Back; ZWrite On; ZTest GEqual; stencil 0; skip skin (flags 0); .wy normal + POM/scan RT0\\n\\n");'),
    ('static void ApplyInstanceState(Material m, Profile p, int instance)\n    {\n        byte[] overlay = ReadCB(p, "PS", "uniforms23");\n        int o = instance * 256;\n        m.SetVector("_InstanceStateYZ", new Vector4(ReadFloat(overlay, o + 68), ReadFloat(overlay, o + 72), 0, 0));\n        EditorUtility.SetDirty(m);\n    }',
     'static void ApplyInstanceState(Material m, Profile p, int instance)\n    {\n        byte[] overlay = ReadCB(p, "PS", "uniforms23");\n        int o = instance * 256;\n        m.SetVector("_InstanceStateYZ", new Vector4(ReadFloat(overlay, o + 68), ReadFloat(overlay, o + 72), 0, 0));\n        Matrix4x4 world = ReadInstanceMatrix(p, instance);\n        m.SetFloat("_InstanceAffineW", world[3, 0] + world[3, 1] + world[3, 2]);\n        EditorUtility.SetDirty(m);\n    }'),
    ('_EID215492MipBias', '_EID215524MipBias'),
    ('Validation/ColourPass6_VS215491', 'Validation/ColourPass6_VS215523'),
]

# First pass identifier replacements that the VS215491_PS215492 global already covers for shader path.
# The shader path line uses VS215491_PS215492 which is already in subs.

for a, b in subs:
    if a not in text:
        print('MISSING', repr(a[:120]))
    else:
        n = text.count(a)
        text = text.replace(a, b)
        print('OK', n, repr(a[:70]))

# The first identifier pass already renamed ColourPass6_VS215491 -> ColourPass6_VS215523
# and VS215491_PS215492, so Import menu / shader name may already be 215523.
# Fix leftover 51.1 / 215491 / 215492 / 3231 / res27 / uniforms33 after identifier pass.

for s in ['215491', '215492', '3231', '51.1', 'res27', 'res29', 'res31', 'uniforms33', 'uniforms35', '_EID215492', '416B', 'for (int i = 0; i < 26']:
    if s in text:
        for i, line in enumerate(text.splitlines(), 1):
            if s in line:
                print('LEFTOVER', s, i, line.strip()[:160])

dst = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215523_PS215524_Batch/Editor/ColourPass6VS215523PS215524BatchImporter.cs')
dst.parent.mkdir(parents=True, exist_ok=True)
dst.write_text(text, encoding='utf8')
print('wrote', dst, 'len', len(text))
