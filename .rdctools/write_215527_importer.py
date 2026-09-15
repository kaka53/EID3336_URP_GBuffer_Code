from pathlib import Path

src = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215491_PS215492_Batch/Editor/ColourPass6VS215491PS215492BatchImporter.cs')
text = src.read_text(encoding='utf8')

subs = [
    ('ColourPass6VS215491PS215492BatchImporter', 'ColourPass6VS215527PS215528BatchImporter'),
    ('EID215491DrawProfile', 'EID215527DrawProfile'),
    ('VS215491_PS215492', 'VS215527_PS215528'),
    ('VS215491/PS215492', 'VS215527/PS215528'),
    ('VS215491 PS215492', 'VS215527 PS215528'),
    ('EID215491215492', 'EID215527215528'),
    ('ColourPass6_VS215491', 'ColourPass6_VS215527'),
    ('Import EID 51.1 (VS215527 PS215528)', 'Import EID 55.1 (VS215527 PS215528)'),
    ('exactly " + ExpectedEIDs.Length + " profiles for 51.1.', 'exactly " + ExpectedEIDs.Length + " profiles for 55.1.'),
    ('Expected EID 51.1, got ', 'Expected EID 55.1, got '),
    ('static readonly int[] ExpectedEIDs = { 3231 };', 'static readonly int[] ExpectedEIDs = { 3561 };'),
    ('static readonly int ExpectedInstances = 6;', 'static readonly int ExpectedInstances = 1;'),
    ('if (p.vs != 215491 || p.ps != 215492)', 'if (p.vs != 215527 || p.ps != 215528)'),
    ('VS215491 Complete VSInput', 'VS215527 Complete VSInput'),
    (
        'if (Rid(p, "res27") == 0 || Rid(p, "res29") == 0 || Rid(p, "res31") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res27/res29/res31.");\n        byte[] local = ReadCB(p, "PS", "uniforms33");\n        if (local.Length < 416) throw new InvalidDataException("EID" + p.eid + " PS uniforms33 expected 416 bytes, got " + local.Length);',
        'if (Rid(p, "res27") == 0 || Rid(p, "res29") == 0 || Rid(p, "res32") == 0 || Rid(p, "res33") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res27/res29/res32/res33.");\n        byte[] local = ReadCB(p, "PS", "uniforms36");\n        if (local.Length < 448) throw new InvalidDataException("EID" + p.eid + " PS uniforms36 expected 448 bytes, got " + local.Length);',
    ),
    (
        'byte[] local = ReadCB(p, "PS", "uniforms33");\n        for (int i = 0; i < 26; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms35");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));\n        ApplyInstanceState(m, p, 0);\n        byte[] globals = ReadCB(p, "PS", "uniforms20");\n        m.SetFloat("_EID215492MipBias", ReadFloat(globals, 416));\n        m.SetFloat("_UseBakedSkinning", HasCapturedSkinning(p) ? 1f : 0f);\n        Texture albedo = LoadTexture(p, "res27");\n        Texture normalTex = LoadTexture(p, "res29");\n        Texture extra = LoadTexture(p, "res31");\n        if (albedo == null || normalTex == null || extra == null)\n            throw new FileNotFoundException("EID" + p.eid + " res27/res29/res31 texture binding is incomplete.");\n        m.SetTexture("_Res27", albedo);\n        m.SetTexture("_Res29", normalTex);\n        m.SetTexture("_Res31", extra);\n        EditorUtility.SetDirty(m);\n        report.AppendLine("EID" + p.eid + ": material res27=RID" + Rid(p, "res27") + " res29=RID" + Rid(p, "res29") + " res31=RID" + Rid(p, "res31") + " PS uniforms33=" + local.Length + "B");',
        'byte[] local = ReadCB(p, "PS", "uniforms36");\n        for (int i = 0; i < 28; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms38");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));\n        ApplyInstanceState(m, p, 0);\n        byte[] globals = ReadCB(p, "PS", "uniforms20");\n        m.SetFloat("_EID215528MipBias", ReadFloat(globals, 416));\n        m.SetFloat("_UseBakedSkinning", HasCapturedSkinning(p) ? 1f : 0f);\n        Texture normalTex = LoadTexture(p, "res27");\n        Texture materialTex = LoadTexture(p, "res29");\n        Texture cubeTex = LoadTexture(p, "res32");\n        Texture overlayTex = LoadTexture(p, "res33");\n        Texture extraTex = LoadTexture(p, "res34");\n        if (normalTex == null || materialTex == null || cubeTex == null || overlayTex == null)\n            throw new FileNotFoundException("EID" + p.eid + " res27/res29/res32/res33 texture binding is incomplete.");\n        m.SetTexture("_Res27", normalTex);\n        m.SetTexture("_Res29", materialTex);\n        m.SetTexture("_Res32", cubeTex);\n        m.SetTexture("_Res33", overlayTex);\n        if (extraTex != null) m.SetTexture("_Res34", extraTex);\n        EditorUtility.SetDirty(m);\n        report.AppendLine("EID" + p.eid + ": material res27=RID" + Rid(p, "res27") + " res29=RID" + Rid(p, "res29") + " res32=RID" + Rid(p, "res32") + " res33=RID" + Rid(p, "res33") + " res34=RID" + Rid(p, "res34") + " PS uniforms36=" + local.Length + "B");',
    ),
    ('if (instances != ExpectedInstances) throw new InvalidDataException("51.1 instance total expected " + ExpectedInstances + ", got " + instances);',
     'if (instances != ExpectedInstances) throw new InvalidDataException("55.1 instance total expected " + ExpectedInstances + ", got " + instances);'),
    ('audit.Insert(0, "# VS215527 / PS215528 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `51.1`\\n- Layout variants: `" + layouts + "` (`d6a844f320196881`)\\n- Shader: live Unity VP; unique res27/res29/res31; PS uniforms33 416B; Cull Back; ZWrite On; ZTest GEqual; stencil 0; skip skin (flags 0); extra map + distance fade; RT0 black\\n\\n");',
     'audit.Insert(0, "# VS215527 / PS215528 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `55.1`\\n- Layout variants: `" + layouts + "` (`d6a844f320196881`)\\n- Shader: live Unity VP; unique res27 DXT5nm / res29 material / res32 cubemap / res33 overlay / res34 extra; PS uniforms36 28 float4; stencil 48; skip skin (flags 0); refractive cubemap RT0\\n\\n");'),
    ('_EID215492MipBias', '_EID215528MipBias'),
    ('Validation/ColourPass6_VS215491', 'Validation/ColourPass6_VS215527'),
    (
        '''            TextureImporter ti = AssetImporter.GetAtPath(path) as TextureImporter;
            if (ti != null)
            {
                ti.sRGBTexture = srgb;
                ti.textureType = TextureImporterType.Default;
                ti.mipmapEnabled = e.mips > 1;
                ti.wrapMode = TextureWrapMode.Repeat;
                ti.filterMode = FilterMode.Bilinear;
                ti.SaveAndReimport();
            }
            else
            {
                string absMeta = Absolute(path + ".meta");
                if (File.Exists(absMeta))
                {
                    string text = File.ReadAllText(absMeta);
                    string want = "sRGBTexture: " + (srgb ? "1" : "0");
                    string next = System.Text.RegularExpressions.Regex.Replace(text, @"sRGBTexture: [01]", want);
                    if (next != text) File.WriteAllText(absMeta, next);
                }
                AssetDatabase.ImportAsset(path, ImportAssetOptions.ForceSynchronousImport);
                report.AppendLine("ihvTexture=" + path + " format=" + e.format + " sRGB=" + srgb);
            }''',
        '''            TextureImporter ti = AssetImporter.GetAtPath(path) as TextureImporter;
            bool cube = e.arraySize == 6;
            if (ti != null)
            {
                ti.sRGBTexture = srgb;
                ti.textureType = TextureImporterType.Default;
                ti.textureShape = cube ? TextureImporterShape.TextureCube : TextureImporterShape.Texture2D;
                ti.mipmapEnabled = e.mips > 1;
                ti.wrapMode = cube ? TextureWrapMode.Clamp : TextureWrapMode.Repeat;
                ti.filterMode = FilterMode.Bilinear;
                ti.SaveAndReimport();
            }
            else
            {
                string absMeta = Absolute(path + ".meta");
                if (File.Exists(absMeta))
                {
                    string text = File.ReadAllText(absMeta);
                    string want = "sRGBTexture: " + (srgb ? "1" : "0");
                    string next = System.Text.RegularExpressions.Regex.Replace(text, @"sRGBTexture: [01]", want);
                    if (cube) next = System.Text.RegularExpressions.Regex.Replace(next, @"textureShape: \\d+", "textureShape: 2");
                    if (next != text) File.WriteAllText(absMeta, next);
                }
                AssetDatabase.ImportAsset(path, ImportAssetOptions.ForceSynchronousImport);
                report.AppendLine("ihvTexture=" + path + " format=" + e.format + " sRGB=" + srgb + " cube=" + cube);
            }''',
    ),
]

for a, b in subs:
    if a not in text:
        print('MISSING', repr(a[:200]))
    else:
        n = text.count(a)
        text = text.replace(a, b)
        print('OK', n, repr(a[:80]))

for s in ['215491', '215492', '3231', '51.1', 'uniforms33', 'uniforms35', '_EID215492', 'res31', 'for (int i = 0; i < 26', '416']:
    if s in text:
        for i, line in enumerate(text.splitlines(), 1):
            if s in line:
                print('LEFTOVER', s, i, line.strip()[:180])

dst = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215527_PS215528_Batch/Editor/ColourPass6VS215527PS215528BatchImporter.cs')
dst.parent.mkdir(parents=True, exist_ok=True)
dst.write_text(text, encoding='utf8')
print('wrote', dst, 'len', len(text))
