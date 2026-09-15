from pathlib import Path

src = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215493_PS215494_Batch/Editor/ColourPass6VS215493PS215494BatchImporter.cs')
text = src.read_text(encoding='utf8')

# Longest / unique first. Do NOT globally replace uniforms28 (VS instance name stays).
subs = [
    ('ColourPass6VS215493PS215494BatchImporter', 'ColourPass6VS215491PS215492BatchImporter'),
    ('EID215493DrawProfile', 'EID215491DrawProfile'),
    ('VS215493_PS215494', 'VS215491_PS215492'),
    ('VS215493/PS215494', 'VS215491/PS215492'),
    ('EID215493215494', 'EID215491215492'),
    ('ColourPass6_VS215493', 'ColourPass6_VS215491'),
    ('EID/URP/VS215493_PS215494_GBuffer', 'EID/URP/VS215491_PS215492_GBuffer'),
    ('Import EID 36.1-36.2 (VS215493 PS215494)', 'Import EID 51.1 (VS215491 PS215492)'),
    ('exactly " + ExpectedEIDs.Length + " profiles for 36.1-36.2.', 'exactly " + ExpectedEIDs.Length + " profiles for 51.1.'),
    ('Expected EIDs 36.1-36.2, got ', 'Expected EID 51.1, got '),
    ('static readonly int[] ExpectedEIDs = { 2528, 2533 };', 'static readonly int[] ExpectedEIDs = { 3231 };'),
    ('static readonly int ExpectedInstances = 3;', 'static readonly int ExpectedInstances = 6;'),
    ('static readonly int ExpectedLayoutVariants = 2;', 'static readonly int ExpectedLayoutVariants = 1;\n    static readonly int ExpectedUniqueMeshes = 1;'),
    ('if (p.vs != 215493 || p.ps != 215494)', 'if (p.vs != 215491 || p.ps != 215494)'),
    ('if (p.vs != 215491 || p.ps != 215494)', 'if (p.vs != 215491 || p.ps != 215492)'),
    ('VS215493 Complete VSInput', 'VS215491 Complete VSInput'),
    ('if (Rid(p, "res23") == 0 || Rid(p, "res25") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res23/res25.");',
     'if (Rid(p, "res27") == 0 || Rid(p, "res29") == 0 || Rid(p, "res31") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res27/res29/res31.");'),
    ('byte[] local = ReadCB(p, "PS", "uniforms28");\n        if (local.Length < 416) throw new InvalidDataException("EID" + p.eid + " PS uniforms28 expected 416 bytes, got " + local.Length);',
     'byte[] local = ReadCB(p, "PS", "uniforms33");\n        if (local.Length < 416) throw new InvalidDataException("EID" + p.eid + " PS uniforms33 expected 416 bytes, got " + local.Length);'),
    ('byte[] overlay = ReadCB(p, "PS", "uniforms20");\n        if (overlay.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " PS uniforms20 too small: " + overlay.Length);',
     'byte[] overlay = ReadCB(p, "PS", "uniforms23");\n        if (overlay.Length < p.draw.instanceCount * 256) throw new InvalidDataException("EID" + p.eid + " PS uniforms23 too small: " + overlay.Length);'),
    ('byte[] local = ReadCB(p, "PS", "uniforms28");\n        for (int i = 0; i < 26; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms30");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));\n        ApplyInstanceOverlay(m, p, 0);\n        byte[] globals = ReadCB(p, "PS", "uniforms17");\n        m.SetFloat("_EID215494MipBias", ReadFloat(globals, 416));\n        m.SetFloat("_LightMixY", ReadFloat(globals, 436));',
     'byte[] local = ReadCB(p, "PS", "uniforms33");\n        for (int i = 0; i < 26; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms35");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));\n        ApplyInstanceState(m, p, 0);\n        byte[] globals = ReadCB(p, "PS", "uniforms20");\n        m.SetFloat("_EID215492MipBias", ReadFloat(globals, 416));'),
    ('Texture albedo = LoadTexture(p, "res23");\n        Texture normalTex = LoadTexture(p, "res25");\n        if (albedo == null || normalTex == null)\n            throw new FileNotFoundException("EID" + p.eid + " res23/res25 texture binding is incomplete.");\n        m.SetTexture("_Res23", albedo);\n        m.SetTexture("_Res25", normalTex);',
     'Texture albedo = LoadTexture(p, "res27");\n        Texture normalTex = LoadTexture(p, "res29");\n        Texture extra = LoadTexture(p, "res31");\n        if (albedo == null || normalTex == null || extra == null)\n            throw new FileNotFoundException("EID" + p.eid + " res27/res29/res31 texture binding is incomplete.");\n        m.SetTexture("_Res27", albedo);\n        m.SetTexture("_Res29", normalTex);\n        m.SetTexture("_Res31", extra);'),
    ('report.AppendLine("EID" + p.eid + ": material res23=RID" + Rid(p, "res23") + " res25=RID" + Rid(p, "res25") + " PS uniforms28=" + local.Length + "B");',
     'report.AppendLine("EID" + p.eid + ": material res27=RID" + Rid(p, "res27") + " res29=RID" + Rid(p, "res29") + " res31=RID" + Rid(p, "res31") + " PS uniforms33=" + local.Length + "B");'),
    ('ApplyInstanceOverlay(mat, p, i);', 'ApplyInstanceState(mat, p, i);'),
    ('if (instances != ExpectedInstances) throw new InvalidDataException("36.1-36.2 instance total expected " + ExpectedInstances + ", got " + instances);',
     'if (instances != ExpectedInstances) throw new InvalidDataException("51.1 instance total expected " + ExpectedInstances + ", got " + instances);'),
    ('int layouts = manifest.profiles.Select(LayoutKey).Distinct().Count();\n        if (layouts != ExpectedLayoutVariants) throw new InvalidDataException("Expected " + ExpectedLayoutVariants + " captured vertex layout variants, got " + layouts);',
     'int layouts = manifest.profiles.Select(LayoutKey).Distinct().Count();\n        if (layouts != ExpectedLayoutVariants) throw new InvalidDataException("Expected " + ExpectedLayoutVariants + " captured vertex layout variants, got " + layouts);\n        int uniqueMeshes = manifest.profiles.Select(x => x.geometrySha256).Distinct().Count();\n        if (uniqueMeshes != ExpectedUniqueMeshes) throw new InvalidDataException("Expected " + ExpectedUniqueMeshes + " unique meshes, got " + uniqueMeshes);'),
    ('report.AppendLine("layoutVariants=" + layouts);\n        report.AppendLine("vertexAttributes=COMPLETE_9_OF_9");',
     'report.AppendLine("layoutVariants=" + layouts);\n        report.AppendLine("uniqueMeshes=" + uniqueMeshes);\n        report.AppendLine("vertexAttributes=COMPLETE_9_OF_9");'),
    ('audit.Insert(0, "# VS215493 / PS215494 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `36.1-36.2`\\n- Layout variants: `" + layouts + "` (`3572236fc9e4b455`, `a554ffdeec97df50`)\\n- Shader: live Unity VP; unique res23/res25; PS uniforms28 416B; Cull Off; ZWrite On; stencil 0; skip skin (flags 0); overlay from albedo/normal + uniforms20\\n\\n");',
     'audit.Insert(0, "# VS215491 / PS215492 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `51.1`\\n- Layout variants: `" + layouts + "` (`d6a844f320196881`)\\n- Shader: live Unity VP; unique res27/res29/res31; PS uniforms33 416B; Cull Back; ZWrite On; ZTest GEqual; stencil 0; skip skin (flags 0); extra map + distance fade; RT0 black\\n\\n");'),
    ('static void ApplyInstanceOverlay(Material m, Profile p, int instance)\n    {\n        byte[] overlay = ReadCB(p, "PS", "uniforms20");\n        int o = instance * 256;\n        m.SetVector("_InstanceStateYZ", new Vector4(ReadFloat(overlay, o + 68), ReadFloat(overlay, o + 72), 0, 0));\n        m.SetVector("_OverlayChild5", ReadVector4(overlay, o + 176));\n        m.SetVector("_OverlayChild7", ReadVector4(overlay, o + 208));\n        m.SetVector("_OverlayChild9", ReadVector4(overlay, o + 240));\n        EditorUtility.SetDirty(m);\n    }',
     'static void ApplyInstanceState(Material m, Profile p, int instance)\n    {\n        byte[] overlay = ReadCB(p, "PS", "uniforms23");\n        int o = instance * 256;\n        m.SetVector("_InstanceStateYZ", new Vector4(ReadFloat(overlay, o + 68), ReadFloat(overlay, o + 72), 0, 0));\n        EditorUtility.SetDirty(m);\n    }'),
    ('            new VertexAttributeDescriptor(VertexAttribute.Position, VertexAttributeFormat.Float32, 3, 0),\n            new VertexAttributeDescriptor(VertexAttribute.Normal, VertexAttributeFormat.Float32, 3, 0),\n            new VertexAttributeDescriptor(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4, 2),\n            new VertexAttributeDescriptor(VertexAttribute.Tangent, VertexAttributeFormat.UNorm8, 4, 2),\n            new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 2, 1),\n            new VertexAttributeDescriptor(VertexAttribute.TexCoord1, VertexAttributeFormat.Float32, 2, 1),\n            new VertexAttributeDescriptor(VertexAttribute.TexCoord2, VertexAttributeFormat.Float32, 2, 1),\n            new VertexAttributeDescriptor(VertexAttribute.TexCoord3, VertexAttributeFormat.UNorm8, 4, 2),\n            new VertexAttributeDescriptor(VertexAttribute.BlendIndices, VertexAttributeFormat.UInt8, 4, 2),\n            new VertexAttributeDescriptor(VertexAttribute.TexCoord4, VertexAttributeFormat.Float32, 3, 3),\n            new VertexAttributeDescriptor(VertexAttribute.TexCoord5, VertexAttributeFormat.Float32, 4, 3),',
     '            new VertexAttributeDescriptor(VertexAttribute.Position, VertexAttributeFormat.Float32, 3, 0),\n            new VertexAttributeDescriptor(VertexAttribute.Normal, VertexAttributeFormat.Float32, 3, 0),\n            new VertexAttributeDescriptor(VertexAttribute.TexCoord0, VertexAttributeFormat.Float32, 2, 1),\n            new VertexAttributeDescriptor(VertexAttribute.TexCoord1, VertexAttributeFormat.Float32, 2, 1),\n            new VertexAttributeDescriptor(VertexAttribute.TexCoord2, VertexAttributeFormat.Float32, 2, 1),\n            new VertexAttributeDescriptor(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4, 2),\n            new VertexAttributeDescriptor(VertexAttribute.Tangent, VertexAttributeFormat.UNorm8, 4, 2),\n            new VertexAttributeDescriptor(VertexAttribute.TexCoord3, VertexAttributeFormat.UNorm8, 4, 2),\n            new VertexAttributeDescriptor(VertexAttribute.BlendIndices, VertexAttributeFormat.UInt8, 4, 2),\n            new VertexAttributeDescriptor(VertexAttribute.TexCoord4, VertexAttributeFormat.Float32, 3, 3),\n            new VertexAttributeDescriptor(VertexAttribute.TexCoord5, VertexAttributeFormat.Float32, 4, 3),'),
    ('Validation/ColourPass6_VS215493', 'Validation/ColourPass6_VS215491'),
    ('_EID215494MipBias', '_EID215492MipBias'),
]

for a,b in subs:
    if a not in text:
        print('MISSING', repr(a[:80]))
    else:
        text = text.replace(a,b)
        print('OK', repr(a[:60]))

# leftover checks
for s in ['215493','215494','36.1','2528','2533','res23','res25','ApplyInstanceOverlay','_LightMixY','uniforms17','uniforms30']:
    if s in text:
        # show context lines
        for i,line in enumerate(text.splitlines(),1):
            if s in line:
                print('LEFTOVER', s, i, line.strip()[:140])

dst = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215491_PS215492_Batch/Editor/ColourPass6VS215491PS215492BatchImporter.cs')
dst.parent.mkdir(parents=True, exist_ok=True)
dst.write_text(text, encoding='utf8')
print('wrote', dst, 'len', len(text))
