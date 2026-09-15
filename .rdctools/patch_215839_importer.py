from pathlib import Path

p = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215839_PS215840_Batch/Editor/ColourPass6VS215839PS215840BatchImporter.cs')
t = p.read_text(encoding='utf8')

repls = [
    (
        'static readonly int[] ExpectedEIDs = { 3885, 3889, 3895 };\n    static readonly int ExpectedInstances = 302;\n    static readonly int ExpectedLayoutVariants = 2;\n    static readonly int ExpectedUniqueMeshes = 3;',
        'static readonly int[] ExpectedEIDs = { 3771, 3776 };\n    static readonly int ExpectedInstances = 229;\n    static readonly int ExpectedLayoutVariants = 1;\n    static readonly int ExpectedUniqueMeshes = 2;',
    ),
    (
        '[MenuItem("Tools/Colour Pass 6/Import EID 32.1-32.3 (VS215839 PS215840)")]',
        '[MenuItem("Tools/Colour Pass 6/Import EID 45.1-45.2 (VS215839 PS215840)")]',
    ),
    (
        'throw new InvalidDataException("Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 32.1-32.3.");',
        'throw new InvalidDataException("Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 45.1-45.2.");',
    ),
    (
        'throw new InvalidDataException("Expected EIDs 32.1-32.3, got " + string.Join(",", got));',
        'throw new InvalidDataException("Expected EIDs 45.1-45.2, got " + string.Join(",", got));',
    ),
    (
        'if (p.layout == null || p.layout.Length != 7) throw new InvalidDataException("EID" + p.eid + " must expose the 7 RenderDoc VS inputs.");\n        string[] required = { "_input0", "_input1", "_input2", "_input3", "_input4", "_input5", "_input6" };',
        'if (p.layout == null || p.layout.Length != 4) throw new InvalidDataException("EID" + p.eid + " must expose the 4 RenderDoc VS inputs.");\n        string[] required = { "_input0", "_input1", "_input2", "_input4" };',
    ),
    (
        'if (Rid(p, "res23") == 0 || Rid(p, "res25") == 0) throw new InvalidDataException("EID" + p.eid + " missing unique material slots res23/res25.");\n        if (Rid(p, "res34") == 0 || Rid(p, "res35") == 0 || Rid(p, "res36") == 0 || Rid(p, "res37") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing VS wind/terrain slots res34/res35/res36/res37.");',
        'if (Rid(p, "res23") == 0 || Rid(p, "res25") == 0) throw new InvalidDataException("EID" + p.eid + " missing unique material slots res23/res25.");\n        if (Rid(p, "res29") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing VS terrain slot res29.");',
    ),
]

for old, new in repls:
    if old not in t:
        raise SystemExit('missing fragment:\n' + old[:180])
    t = t.replace(old, new, 1)

src_mesh = '''        int count = p.vertexCount;
        var positions = new Vector3[count];
        var packed = new Vector3[count];
        var tangents = new Vector4[count];
        var colors = new Color32[count];
        var uv0 = new Vector2[count];
        var uv1 = new Vector2[count];
        var uv2 = new Vector2[count];
        var uv3 = new Vector2[count];
        for (int v = 0; v < count; ++v)
        {
            byte[] pos = ReadInput(p, "_input0", v, 12);
            positions[v] = new Vector3(BitConverter.ToSingle(pos, 0), BitConverter.ToSingle(pos, 4), BitConverter.ToSingle(pos, 8));
            uint bits = BitConverter.ToUInt32(ReadInput(p, "_input1", v, 4), 0);
            packed[v] = new Vector3(BitConverter.Int32BitsToSingle(unchecked((int)bits)), 0f, 0f);
            byte[] t = ReadInput(p, "_input2", v, 4);
            tangents[v] = new Vector4(t[0] / 255f, t[1] / 255f, t[2] / 255f, t[3] / 255f);
            byte[] c = ReadInput(p, "_input3", v, 4);
            colors[v] = new Color32(c[0], c[1], c[2], c[3]);
            byte[] u0 = ReadInput(p, "_input4", v, 8);
            uv0[v] = new Vector2(BitConverter.ToSingle(u0, 0), BitConverter.ToSingle(u0, 4));
            byte[] u1 = ReadInput(p, "_input5", v, 8);
            uv1[v] = new Vector2(BitConverter.ToSingle(u1, 0), BitConverter.ToSingle(u1, 4));
            uv2[v] = ReadInput6(p, v);
            uv3[v] = Vector2.zero;
        }'''

src_mesh_new = '''        int count = p.vertexCount;
        var positions = new Vector3[count];
        var packed = new Vector3[count];
        var tangents = new Vector4[count];
        var uv0 = new Vector2[count];
        var uv3 = new Vector2[count];
        for (int v = 0; v < count; ++v)
        {
            byte[] pos = ReadInput(p, "_input0", v, 12);
            positions[v] = new Vector3(BitConverter.ToSingle(pos, 0), BitConverter.ToSingle(pos, 4), BitConverter.ToSingle(pos, 8));
            uint bits = BitConverter.ToUInt32(ReadInput(p, "_input1", v, 4), 0);
            packed[v] = new Vector3(BitConverter.Int32BitsToSingle(unchecked((int)bits)), 0f, 0f);
            byte[] t = ReadInput(p, "_input2", v, 4);
            tangents[v] = new Vector4(t[0] / 255f, t[1] / 255f, t[2] / 255f, t[3] / 255f);
            byte[] u0 = ReadInput(p, "_input4", v, 8);
            uv0[v] = new Vector2(BitConverter.ToSingle(u0, 0), BitConverter.ToSingle(u0, 4));
            uv3[v] = Vector2.zero;
        }'''

if src_mesh not in t:
    raise SystemExit('CreateSourceMesh loop missing')
t = t.replace(src_mesh, src_mesh_new, 1)

t = t.replace(
    '''        mesh.vertices = positions;
        mesh.normals = packed;
        mesh.tangents = tangents;
        mesh.colors32 = colors;
        mesh.SetUVs(0, uv0);
        mesh.SetUVs(1, uv1);
        mesh.SetUVs(2, uv2);
        mesh.SetUVs(3, uv3);
        mesh.SetIndices(indices, MeshTopology.Triangles, 0, true);''',
    '''        mesh.vertices = positions;
        mesh.normals = packed;
        mesh.tangents = tangents;
        mesh.SetUVs(0, uv0);
        mesh.SetUVs(3, uv3);
        mesh.SetIndices(indices, MeshTopology.Triangles, 0, true);''',
    1,
)

t = t.replace(
    'audit.AppendLine("- Unity streams: `Position xyz`, `Normal.x packed input1 bits`, `Tangent input2 UNorm8`, `Color input3`, `UV0 input4`, `UV1 input5`, `UV2 input6`, `UV3 instanceIndex`");',
    'audit.AppendLine("- Unity streams: `Position xyz`, `Normal.x packed input1 bits`, `Tangent input2 UNorm8`, `UV0 input4`, `UV3 instanceIndex`");',
    1,
)

exp_old = '''        var srcPos = source.vertices;
        var srcNrm = source.normals;
        var srcTan = source.tangents;
        var srcCol = source.colors32;
        var srcUv0 = new List<Vector2>(); source.GetUVs(0, srcUv0);
        var srcUv1 = new List<Vector2>(); source.GetUVs(1, srcUv1);
        var srcUv2 = new List<Vector2>(); source.GetUVs(2, srcUv2);
        int[] srcIdx = source.GetIndices(0);

        var dstPos = new Vector3[count];
        var dstNrm = new Vector3[count];
        var dstTan = new Vector4[count];
        var dstCol = new Color32[count];
        var dstUv0 = new Vector2[count];
        var dstUv1 = new Vector2[count];
        var dstUv2 = new Vector2[count];
        var dstUv3 = new Vector2[count];
        var dstIdx = new int[indexCount];
        for (int i = 0; i < inst; ++i)
        {
            int vo = i * baseV;
            for (int v = 0; v < baseV; ++v)
            {
                dstPos[vo + v] = srcPos[v];
                dstNrm[vo + v] = srcNrm[v];
                dstTan[vo + v] = srcTan[v];
                dstCol[vo + v] = srcCol[v];
                dstUv0[vo + v] = srcUv0[v];
                dstUv1[vo + v] = srcUv1[v];
                dstUv2[vo + v] = srcUv2[v];
                dstUv3[vo + v] = new Vector2(i, 0f);
            }'''
exp_new = '''        var srcPos = source.vertices;
        var srcNrm = source.normals;
        var srcTan = source.tangents;
        var srcUv0 = new List<Vector2>(); source.GetUVs(0, srcUv0);
        int[] srcIdx = source.GetIndices(0);

        var dstPos = new Vector3[count];
        var dstNrm = new Vector3[count];
        var dstTan = new Vector4[count];
        var dstUv0 = new Vector2[count];
        var dstUv3 = new Vector2[count];
        var dstIdx = new int[indexCount];
        for (int i = 0; i < inst; ++i)
        {
            int vo = i * baseV;
            for (int v = 0; v < baseV; ++v)
            {
                dstPos[vo + v] = srcPos[v];
                dstNrm[vo + v] = srcNrm[v];
                dstTan[vo + v] = srcTan[v];
                dstUv0[vo + v] = srcUv0[v];
                dstUv3[vo + v] = new Vector2(i, 0f);
            }'''
if exp_old not in t:
    raise SystemExit('expanded loop missing')
t = t.replace(exp_old, exp_new, 1)

t = t.replace(
    '''        mesh.vertices = dstPos;
        mesh.normals = dstNrm;
        mesh.tangents = dstTan;
        mesh.colors32 = dstCol;
        mesh.SetUVs(0, dstUv0);
        mesh.SetUVs(1, dstUv1);
        mesh.SetUVs(2, dstUv2);
        mesh.SetUVs(3, dstUv3);''',
    '''        mesh.vertices = dstPos;
        mesh.normals = dstNrm;
        mesh.tangents = dstTan;
        mesh.SetUVs(0, dstUv0);
        mesh.SetUVs(3, dstUv3);''',
    1,
)

scratch_old = '''        int count = p.vertexCount;
        var positions = new Vector3[count];
        var packed = new Vector3[count];
        var tangents = new Vector4[count];
        var colors = new Color32[count];
        var uv0 = new Vector2[count];
        var uv1 = new Vector2[count];
        var uv2 = new Vector2[count];
        for (int v = 0; v < count; ++v)
        {
            byte[] pos = ReadInput(p, "_input0", v, 12);
            positions[v] = new Vector3(BitConverter.ToSingle(pos, 0), BitConverter.ToSingle(pos, 4), BitConverter.ToSingle(pos, 8));
            uint bits = BitConverter.ToUInt32(ReadInput(p, "_input1", v, 4), 0);
            packed[v] = new Vector3(BitConverter.Int32BitsToSingle(unchecked((int)bits)), 0f, 0f);
            byte[] t = ReadInput(p, "_input2", v, 4);
            tangents[v] = new Vector4(t[0] / 255f, t[1] / 255f, t[2] / 255f, t[3] / 255f);
            byte[] c = ReadInput(p, "_input3", v, 4);
            colors[v] = new Color32(c[0], c[1], c[2], c[3]);
            byte[] u0 = ReadInput(p, "_input4", v, 8);
            uv0[v] = new Vector2(BitConverter.ToSingle(u0, 0), BitConverter.ToSingle(u0, 4));
            byte[] u1 = ReadInput(p, "_input5", v, 8);
            uv1[v] = new Vector2(BitConverter.ToSingle(u1, 0), BitConverter.ToSingle(u1, 4));
            uv2[v] = ReadInput6(p, v);
        }'''
scratch_new = '''        int count = p.vertexCount;
        var positions = new Vector3[count];
        var packed = new Vector3[count];
        var tangents = new Vector4[count];
        var uv0 = new Vector2[count];
        for (int v = 0; v < count; ++v)
        {
            byte[] pos = ReadInput(p, "_input0", v, 12);
            positions[v] = new Vector3(BitConverter.ToSingle(pos, 0), BitConverter.ToSingle(pos, 4), BitConverter.ToSingle(pos, 8));
            uint bits = BitConverter.ToUInt32(ReadInput(p, "_input1", v, 4), 0);
            packed[v] = new Vector3(BitConverter.Int32BitsToSingle(unchecked((int)bits)), 0f, 0f);
            byte[] t = ReadInput(p, "_input2", v, 4);
            tangents[v] = new Vector4(t[0] / 255f, t[1] / 255f, t[2] / 255f, t[3] / 255f);
            byte[] u0 = ReadInput(p, "_input4", v, 8);
            uv0[v] = new Vector2(BitConverter.ToSingle(u0, 0), BitConverter.ToSingle(u0, 4));
        }'''
if scratch_old not in t:
    raise SystemExit('scratch loop missing')
t = t.replace(scratch_old, scratch_new, 1)

t = t.replace(
    '''        mesh.vertices = positions;
        mesh.normals = packed;
        mesh.tangents = tangents;
        mesh.colors32 = colors;
        mesh.SetUVs(0, uv0);
        mesh.SetUVs(1, uv1);
        mesh.SetUVs(2, uv2);
        mesh.SetIndices(indices, MeshTopology.Triangles, 0, false);''',
    '''        mesh.vertices = positions;
        mesh.normals = packed;
        mesh.tangents = tangents;
        mesh.SetUVs(0, uv0);
        mesh.SetIndices(indices, MeshTopology.Triangles, 0, false);''',
    1,
)

mat_old = '''        m.SetFloat("_EID3863NormalStrength", ReadFloat(local, 16));
        m.SetFloat("_EID3863DoubleSidedNormal", ReadFloat(local, 20));
        m.SetFloat("_EID3863NormalFlatten", ReadFloat(local, 32));
        m.SetFloat("_EID3863MaterialClass", ReadFloat(local, 36));
        m.SetFloat("_EID3863PackedNormalWeight", ReadFloat(local, 40));
        m.SetFloat("_EID3863RoughnessMin", ReadFloat(local, 44));
        m.SetFloat("_EID3863RoughnessMax", ReadFloat(local, 48));
        m.SetFloat("_EID3863NormalMaskWeight", ReadFloat(local, 56));
        m.SetFloat("_EID3863RoughnessMaskWeight", ReadFloat(local, 60));
        m.SetFloat("_EID3863BaseColorReplaceWeight", ReadFloat(local, 80));
        m.SetFloat("_EID3863BaseColorMultiplier", ReadFloat(local, 84));
        m.SetFloat("_EID3863AlphaCutoff", 0.5f);
        m.SetColor("_EID3863BaseColorTint", ReadVector4(local, 128));
        m.SetVector("_EID3863OpacityDistanceParams", ReadVector4(local, 144));
        m.SetVector("_EID3863MaterialDistanceParams", ReadVector4(local, 160));
        byte[] wind = ReadCB(p, "VS", "uniforms39");
        if (wind.Length < 128) throw new InvalidDataException("EID" + p.eid + " VS uniforms39 expected 224 bytes, got " + wind.Length);
        m.SetVector("_EID215839Wind0", new Vector4(ReadFloat(wind, 24), ReadFloat(wind, 64), ReadFloat(wind, 68), ReadFloat(wind, 76)));
        m.SetVector("_EID215839Wind1", new Vector4(ReadFloat(wind, 96), ReadFloat(wind, 100), ReadFloat(wind, 108), ReadFloat(wind, 112)));
        m.SetVector("_EID215839Wind2", new Vector4(ReadFloat(wind, 116), ReadFloat(wind, 120), ReadFloat(wind, 124), 0f));
        m.SetFloat("_StencilRef", p.eid == 3895 ? 1f : 33f);

        Texture baseTex = LoadTexture(p, "res23");
        Texture normalTex = LoadTexture(p, "res25");
        Texture vs34 = LoadTexture(p, "res34");
        Texture vs35 = LoadTexture(p, "res35");
        Texture vs36 = LoadTexture(p, "res36");
        Texture vs37 = LoadTexture(p, "res37");
        if (baseTex == null || normalTex == null || vs34 == null || vs35 == null || vs36 == null || vs37 == null)
            throw new FileNotFoundException("EID" + p.eid + " res23/res25/res34/res35/res36/res37 texture binding is incomplete.");
        m.SetTexture("_Res23", baseTex);
        m.SetTexture("_Res25", normalTex);
        m.SetTexture("_EID3863VSRes34", vs34);
        m.SetTexture("_EID3863VSRes35", vs35);
        m.SetTexture("_EID3863VSRes36", vs36);
        m.SetTexture("_EID3863VSRes37", vs37);'''

mat_new = '''        m.SetFloat("_EID3863NormalStrength", ReadFloat(local, 16));
        m.SetFloat("_EID3863DoubleSidedNormal", ReadFloat(local, 20));
        m.SetFloat("_EID3863MaterialClass", ReadFloat(local, 36));
        m.SetFloat("_EID3863PackedNormalWeight", ReadFloat(local, 40));
        m.SetFloat("_EID3863NormalMaskWeight", ReadFloat(local, 56));
        m.SetFloat("_EID3863RoughnessMaskWeight", ReadFloat(local, 60));
        m.SetFloat("_EID3863BaseColorReplaceWeight", ReadFloat(local, 80));
        m.SetFloat("_EID3863BaseColorMultiplier", ReadFloat(local, 84));
        m.SetColor("_EID3863BaseColorTint", ReadVector4(local, 128));
        m.SetVector("_EID3863OpacityDistanceParams", ReadVector4(local, 144));
        m.SetVector("_EID3863MaterialDistanceParams", ReadVector4(local, 160));
        byte[] vsLocal = ReadCB(p, "VS", "uniforms31");
        if (vsLocal.Length < 28) throw new InvalidDataException("EID" + p.eid + " VS uniforms31 expected 224 bytes, got " + vsLocal.Length);
        m.SetFloat("_EID215839Billboard", ReadFloat(vsLocal, 24));
        m.SetFloat("_StencilRef", p.eid == 3771 ? 1f : 33f);

        Texture baseTex = LoadTexture(p, "res23");
        Texture normalTex = LoadTexture(p, "res25");
        Texture vs29 = LoadTexture(p, "res29");
        if (baseTex == null || normalTex == null || vs29 == null)
            throw new FileNotFoundException("EID" + p.eid + " res23/res25/res29 texture binding is incomplete.");
        m.SetTexture("_Res23", baseTex);
        m.SetTexture("_Res25", normalTex);
        m.SetTexture("_EID215839VSRes29", vs29);'''
if mat_old not in t:
    raise SystemExit('material block missing')
t = t.replace(mat_old, mat_new, 1)

t = t.replace(
    'if (instances != ExpectedInstances) throw new InvalidDataException("32.1-32.3 instance total expected " + ExpectedInstances + ", got " + instances);',
    'if (instances != ExpectedInstances) throw new InvalidDataException("45.1-45.2 instance total expected " + ExpectedInstances + ", got " + instances);',
    1,
)
t = t.replace('report.AppendLine("vertexAttributes=COMPLETE_7_OF_7");', 'report.AppendLine("vertexAttributes=COMPLETE_4_OF_4");', 1)
t = t.replace(
    'report.AppendLine("resourcePolicy=RID_DEDUPLICATED_UNIQUE_MATERIAL_REUSE_VS_WIND");',
    'report.AppendLine("resourcePolicy=RID_DEDUPLICATED_UNIQUE_MATERIAL_REUSE_VS_TERRAIN");',
    1,
)
t = t.replace(
    'audit.Insert(0, "# VS215839 / PS215840 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `32.1-32.3` (`3885,3889,3895`)\\n- Layout variants: `2` (`65bcce980b192dbf` 3885/3889, `ec8a53eaa4a26539` EID3895 SNORM input6)\\n- Unique source meshes: `3`\\n- Instances: `302` via uniforms28 stride 96, one MeshRenderer per EID\\n- Packed `_input1` on `NORMAL.x`; live Unity VP; VS wind/terrain RID reuse; unique PS clip; stencil 33 except EID3895 stencil 1; ZTest Equal\\n\\n");',
    'audit.Insert(0, "# VS215839 / PS215840 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `45.1-45.2` (`3771,3776`)\\n- Layout variants: `1` (`56711b3761a08265`)\\n- Unique source meshes: `2`\\n- Instances: `229` via uniforms25 stride 96, one MeshRenderer per EID\\n- Packed `_input1` on `NORMAL.x`; live Unity VP; VS terrain RID210510 reuse; unique DXT5nm PS no clip; stencil 1 for EID3771 / 33 for EID3776; ZTest Equal\\n\\n");',
    1,
)
t = t.replace(
    'report.AppendLine("localUniqueMaterialRIDs=" + unique + " (VS wind/terrain RIDs reused from Combined EID3863)");',
    'report.AppendLine("localUniqueMaterialRIDs=" + unique + " (VS terrain RID210510 reused from Combined EID3863)");',
    1,
)

leftovers = []
for needle in ('3885', '3889', '3895', 'uniforms39', 'res34', 'res35', 'res36', 'res37', '_input3', '_input5', '_input6', 'AlphaCutoff', '32.1', 'COMPLETE_7', 'ReadInput6'):
    if needle in t:
        leftovers.append(needle)

p.write_text(t, encoding='utf8', newline='\n')
print('ok leftovers', leftovers)
print('len', len(t.splitlines()))
