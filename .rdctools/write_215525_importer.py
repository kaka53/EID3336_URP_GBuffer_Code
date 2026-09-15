from pathlib import Path

src = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215511_PS215514_Batch/Editor/ColourPass6VS215511PS215514BatchImporter.cs')
text = src.read_text(encoding='utf8')

subs = [
    ('ColourPass6VS215511PS215514BatchImporter', 'ColourPass6VS215525PS215526BatchImporter'),
    ('EID215511DrawProfile', 'EID215525DrawProfile'),
    ('VS215511_PS215514', 'VS215525_PS215526'),
    ('VS215511/PS215514', 'VS215525/PS215526'),
    ('VS215511 PS215514', 'VS215525 PS215526'),
    ('EID215511215514', 'EID215525215526'),
    ('ColourPass6_VS215511', 'ColourPass6_VS215525'),
    ('Import EID 38.1-38.2 (VS215525 PS215526)', 'Import EID 54.1 (VS215525 PS215526)'),
    ('exactly " + ExpectedEIDs.Length + " profiles for 38.1-38.2.', 'exactly " + ExpectedEIDs.Length + " profiles for 54.1.'),
    ('Expected EIDs 38.1-38.2, got ', 'Expected EID 54.1, got '),
    ('static readonly int[] ExpectedEIDs = { 3379, 3383 };', 'static readonly int[] ExpectedEIDs = { 3550 };'),
    ('static readonly int ExpectedInstances = 3;', 'static readonly int ExpectedInstances = 1;'),
    ('if (p.vs != 215511 || p.ps != 215514)', 'if (p.vs != 215525 || p.ps != 215526)'),
    ('VS215511 Complete VSInput', 'VS215525 Complete VSInput'),
    (
        'if (Rid(p, "res33") == 0 || Rid(p, "res35") == 0 || Rid(p, "res37") == 0 || Rid(p, "res38") == 0 || Rid(p, "res40") == 0 || Rid(p, "res41") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res33/res35/res37/res38/res40/res41.");\n        if (Rid(p, "res39") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing extra blend slot res39.");\n        byte[] local = ReadCB(p, "PS", "uniforms43");\n        if (local.Length < 656) throw new InvalidDataException("EID" + p.eid + " PS uniforms43 expected 656 bytes, got " + local.Length);',
        'if (Rid(p, "res28") == 0 || Rid(p, "res30") == 0 || Rid(p, "res32") == 0 || Rid(p, "res33") == 0 || Rid(p, "res35") == 0 || Rid(p, "res36") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing material slots res28/res30/res32/res33/res35/res36.");\n        if (Rid(p, "res34") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing extra blend slot res34.");\n        byte[] local = ReadCB(p, "PS", "uniforms38");\n        if (local.Length < 608) throw new InvalidDataException("EID" + p.eid + " PS uniforms38 expected 608 bytes, got " + local.Length);',
    ),
    (
        'byte[] local = ReadCB(p, "PS", "uniforms43");\n        for (int i = 0; i < 41; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms45");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));\n        byte[] instanceCB = ReadCB(p, "VS", "uniforms30");\n        m.SetVector("_InstanceStateYZ", new Vector4(ReadFloat(instanceCB, 68), ReadFloat(instanceCB, 72), 0, 0));\n        byte[] globals = ReadCB(p, "PS", "uniforms21");\n        m.SetFloat("_EID215514MipBias", ReadFloat(globals, 416));\n        Texture albedo = LoadTexture(p, "res33");\n        Texture normalTex = LoadTexture(p, "res35");\n        Texture overlayTex = LoadTexture(p, "res37");\n        Texture maskTex = LoadTexture(p, "res38");\n        Texture extraBlend = LoadTexture(p, "res39");\n        Texture extraColor = LoadTexture(p, "res40");\n        Texture extraN = LoadTexture(p, "res41");\n        if (albedo == null || normalTex == null || overlayTex == null || maskTex == null || extraBlend == null || extraColor == null || extraN == null)\n            throw new FileNotFoundException("EID" + p.eid + " res33/res35/res37/res38/res39/res40/res41 texture binding is incomplete.");\n        m.SetTexture("_Res33", albedo);\n        m.SetTexture("_Res35", normalTex);\n        m.SetTexture("_Res37", overlayTex);\n        m.SetTexture("_Res38", maskTex);\n        m.SetTexture("_Res39", extraBlend);\n        m.SetTexture("_Res40", extraColor);\n        m.SetTexture("_Res41", extraN);\n        EditorUtility.SetDirty(m);\n        report.AppendLine("EID" + p.eid + ": material res33=RID" + Rid(p, "res33") + " res35=RID" + Rid(p, "res35") + " res37=RID" + Rid(p, "res37") + " res38=RID" + Rid(p, "res38") + " res39=RID" + Rid(p, "res39") + " res40=RID" + Rid(p, "res40") + " res41=RID" + Rid(p, "res41") + " PS uniforms43=" + local.Length + "B");',
        'byte[] local = ReadCB(p, "PS", "uniforms38");\n        for (int i = 0; i < 38; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        byte[] meta = ReadCB(p, "PS", "uniforms40");\n        m.SetVector("_InstanceMeta", ReadVector4(meta, 0));\n        byte[] instanceCB = ReadCB(p, "VS", "uniforms30");\n        m.SetVector("_InstanceStateYZ", new Vector4(ReadFloat(instanceCB, 68), ReadFloat(instanceCB, 72), 0, 0));\n        byte[] globals = ReadCB(p, "PS", "uniforms21");\n        m.SetFloat("_EID215526MipBias", ReadFloat(globals, 416));\n        Texture albedo = LoadTexture(p, "res28");\n        Texture normalTex = LoadTexture(p, "res30");\n        Texture overlayTex = LoadTexture(p, "res32");\n        Texture maskTex = LoadTexture(p, "res33");\n        Texture extraBlend = LoadTexture(p, "res34");\n        Texture extraColor = LoadTexture(p, "res35");\n        Texture extraN = LoadTexture(p, "res36");\n        if (albedo == null || normalTex == null || overlayTex == null || maskTex == null || extraBlend == null || extraColor == null || extraN == null)\n            throw new FileNotFoundException("EID" + p.eid + " res28/res30/res32/res33/res34/res35/res36 texture binding is incomplete.");\n        m.SetTexture("_Res28", albedo);\n        m.SetTexture("_Res30", normalTex);\n        m.SetTexture("_Res32", overlayTex);\n        m.SetTexture("_Res33", maskTex);\n        m.SetTexture("_Res34", extraBlend);\n        m.SetTexture("_Res35", extraColor);\n        m.SetTexture("_Res36", extraN);\n        EditorUtility.SetDirty(m);\n        report.AppendLine("EID" + p.eid + ": material res28=RID" + Rid(p, "res28") + " res30=RID" + Rid(p, "res30") + " res32=RID" + Rid(p, "res32") + " res33=RID" + Rid(p, "res33") + " res34=RID" + Rid(p, "res34") + " res35=RID" + Rid(p, "res35") + " res36=RID" + Rid(p, "res36") + " PS uniforms38=" + local.Length + "B");',
    ),
    ('if (instances != ExpectedInstances) throw new InvalidDataException("38.1-38.2 instance total expected " + ExpectedInstances + ", got " + instances);',
     'if (instances != ExpectedInstances) throw new InvalidDataException("54.1 instance total expected " + ExpectedInstances + ", got " + instances);'),
    ('audit.Insert(0, "# VS215525 / PS215526 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `38.1-38.2`\\n- Layout variants: `" + layouts + "` (`68a569b2f8bd2ed2`)\\n- Shader: live Unity VP; unique res33/res35/res37/res38/res40/res41 plus reused res39; PS uniforms43 41 float4; VT off; packed oct 0.0020\\n\\n");',
     'audit.Insert(0, "# VS215525 / PS215526 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `54.1`\\n- Layout variants: `" + layouts + "` (`68a569b2f8bd2ed2`)\\n- Shader: live Unity VP; unique res28/res30/res32/res33/res34/res35/res36; PS uniforms38 38 float4; extra normal DXT5nm .wy; ZTest GEqual; packed oct 0.0020\\n\\n");'),
    ('_EID215514MipBias', '_EID215526MipBias'),
    ('Validation/ColourPass6_VS215511', 'Validation/ColourPass6_VS215525'),
]

for a, b in subs:
    if a not in text:
        print('MISSING', repr(a[:160]))
    else:
        n = text.count(a)
        text = text.replace(a, b)
        print('OK', n, repr(a[:80]))

for s in ['215511', '215514', '3379', '3383', '38.1', 'uniforms43', 'uniforms45', '_EID215514', 'res37', 'res39', 'res40', 'res41', 'for (int i = 0; i < 41', '656']:
    if s in text:
        for i, line in enumerate(text.splitlines(), 1):
            if s in line:
                print('LEFTOVER', s, i, line.strip()[:180])

dst = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215525_PS215526_Batch/Editor/ColourPass6VS215525PS215526BatchImporter.cs')
dst.parent.mkdir(parents=True, exist_ok=True)
dst.write_text(text, encoding='utf8')
print('wrote', dst, 'len', len(text))
