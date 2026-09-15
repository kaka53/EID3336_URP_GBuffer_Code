import os
import re

SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215851_PS215852_Batch'
DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215847_PS215848_Batch'
SRC58 = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215843_PS215844_Batch'

os.makedirs(DST, exist_ok=True)
for sub in (
    'Editor', 'Runtime', 'Shaders', 'Geometry/Meshes', 'Materials', 'Profiles',
    'TextureDatabase', 'Captured/Geometry', 'Captured/CBuffers', 'Captured/Instances',
):
    os.makedirs(os.path.join(DST, sub), exist_ok=True)


def rewrite_importer(text):
    text = text.replace('ColourPass6VS215851PS215852BatchImporter', 'ColourPass6VS215847PS215848BatchImporter')
    text = text.replace('ColourPass6_VS215851_PS215852_Batch', 'ColourPass6_VS215847_PS215848_Batch')
    text = text.replace('VS215851_PS215852', 'VS215847_PS215848')
    text = text.replace('EID215851215852GBuffer', 'EID215847215848GBuffer')
    text = text.replace('EID215851InstanceBinder', 'EID215847InstanceBinder')
    text = text.replace('EID215851DrawProfile', 'EID215847DrawProfile')
    text = text.replace('_EID215851Instances', '_EID215847Instances')
    text = text.replace('VS215851', 'VS215847')
    text = text.replace('PS215852', 'PS215848')
    text = text.replace('215851', '215847')
    text = text.replace('215852', '215848')
    text = text.replace('static readonly int[] ExpectedEIDs = { 3885, 3889, 3895 };', 'static readonly int[] ExpectedEIDs = { 3858 };')
    text = text.replace('static readonly int ExpectedInstances = 302;', 'static readonly int ExpectedInstances = 5;')
    text = text.replace('static readonly int ExpectedUniqueMeshes = 3;', 'static readonly int ExpectedUniqueMeshes = 1;')
    text = text.replace('static readonly int ExpectedLayoutVariants = 2;', 'static readonly int ExpectedLayoutVariants = 1;')
    text = text.replace('32.1-32.3', '59.1')
    text = text.replace('if (p.vs != 215847 || p.ps != 215848)', 'if (p.vs != 215847 || p.ps != 215848)')
    text = text.replace('Rid(p, "res23") == 0 || Rid(p, "res25") == 0', 'Rid(p, "res25") == 0 || Rid(p, "res27") == 0')
    text = text.replace('missing unique material slots res23/res25.', 'missing unique material slots res25/res27.')
    text = text.replace(
        'if (Rid(p, "res34") == 0 || Rid(p, "res35") == 0 || Rid(p, "res36") == 0 || Rid(p, "res37") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing VS wind/terrain slots res34/res35/res36/res37.");',
        'if (Rid(p, "res32") == 0 || Rid(p, "res33") == 0 || Rid(p, "res34") == 0)\n            throw new InvalidDataException("EID" + p.eid + " missing VS wind slots res32/res33/res34.");',
    )
    text = text.replace('ReadCB(p, "PS", "uniforms28")', 'ReadCB(p, "PS", "uniforms30")')
    text = text.replace('local.Length < 224', 'local.Length < 352')
    text = text.replace('PS uniforms28 expected 224 bytes', 'PS uniforms30 expected 352 bytes')
    text = text.replace('[MenuItem("Tools/Colour Pass 6/Import EID 59.1 (VS215847 PS215848)")]', '[MenuItem("Tools/Colour Pass 6/Import EID 59.1 (VS215847 PS215848)")]')
    text = text.replace('Import EID 32.1-32.3 (VS215847 PS215848)', 'Import EID 59.1 (VS215847 PS215848)')
    return text


CREATE_MATERIAL = r'''    static Material CreateMaterial(Profile p, Shader shader, StringBuilder report)
    {
        string path = Root + "/Materials/EID" + p.eid + "_VS215847_PS215848.mat";
        Material m = AssetDatabase.LoadAssetAtPath<Material>(path);
        if (m == null) { m = new Material(shader); AssetDatabase.CreateAsset(m, path); }
        m.shader = shader; m.name = "EID" + p.eid + " VS215847 PS215848";
        byte[] local = ReadCB(p, "PS", "uniforms30");
        if (local.Length < 352) throw new InvalidDataException("EID" + p.eid + " PS uniforms30 expected 352 bytes, got " + local.Length);
        for (int i = 0; i < 22; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));
        byte[] globals = ReadCB(p, "PS", "uniforms19");
        m.SetFloat("_EID215848MipBias", ReadFloat(globals, 416));
        byte[] wind = ReadCB(p, "VS", "uniforms24");
        m.SetVector("_WindA", ReadVector4(wind, 512));
        m.SetVector("_WindB", ReadVector4(wind, 896));
        m.SetFloat("_WindGate", ReadFloat(wind, 880));
        m.SetVector("_TerrainOrigin32", ReadVector4(wind, 1104));
        m.SetVector("_TerrainOrigin33", ReadVector4(wind, 1120));
        m.SetVector("_TerrainPad", ReadVector4(wind, 608));
        m.SetVector("_SunDir", ReadVector4(wind, 1296));
        byte[] u20 = ReadCB(p, "VS", "uniforms20");
        m.SetFloat("_PrevBlend", u20.Length >= 20 ? ReadFloat(u20, 16) : 0f);
        m.SetFloat("_StencilRef", 33f);
        Texture albedo = LoadTexture(p, "res25");
        Texture extra = LoadTexture(p, "res27");
        Texture fieldA = LoadTexture(p, "res32");
        Texture fieldB = LoadTexture(p, "res33");
        Texture windTex = LoadTexture(p, "res34");
        if (albedo == null || extra == null || fieldA == null || fieldB == null || windTex == null)
            throw new FileNotFoundException("EID" + p.eid + " res25/res27/res32/res33/res34 texture binding is incomplete.");
        m.SetTexture("_Res25", albedo);
        m.SetTexture("_Res27", extra);
        m.SetTexture("_Res32", fieldA);
        m.SetTexture("_Res33", fieldB);
        m.SetTexture("_Res34", windTex);
        EditorUtility.SetDirty(m);
        report.AppendLine("EID" + p.eid + ": material res25=RID" + Rid(p, "res25") + " res27=RID" + Rid(p, "res27") + " res32=RID" + Rid(p, "res32") + " res33=RID" + Rid(p, "res33") + " res34=RID" + Rid(p, "res34") + " instances=" + p.draw.instanceCount + " PS uniforms30=" + local.Length + "B");
        return m;
    }
'''

AUDIT = (
    'audit.Insert(0, "# VS215847 / PS215848 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n'
    '- EIDs: `59.1` (`3858`)\\n- Layout variants: `1` (`ec8a53eaa4a26539`)\\n- Unique source meshes: `1`\\n'
    '- Instances: `5` via uniforms27 stride 96, one MeshRenderer\\n'
    '- Packed `_input1` on `NORMAL.x` oct 0.0020; live Unity VP; Combined wind RID14988/209141/210507; unique res25/res27; DXT5nm `.wy`; no clip; stencil 33; ZTest Equal; Queue Geometry\\n\\n");'
)

src_imp = os.path.join(SRC, 'Editor/ColourPass6VS215851PS215852BatchImporter.cs')
dst_imp = os.path.join(DST, 'Editor/ColourPass6VS215847PS215848BatchImporter.cs')
text = rewrite_importer(open(src_imp, encoding='utf8').read())
text = re.sub(
    r'    static Material CreateMaterial\(Profile p, Shader shader, StringBuilder report\)\n    \{.*?\n    \}\n\n    static TextAsset LoadInstanceBytes',
    CREATE_MATERIAL + '\n    static TextAsset LoadInstanceBytes',
    text,
    count=1,
    flags=re.S,
)
text = re.sub(
    r'audit\.Insert\(0, "# VS215847 / PS215848 Vertex Attribute Audit\\n\\n.*?"\);',
    AUDIT,
    text,
    count=1,
    flags=re.S,
)
open(dst_imp, 'w', encoding='utf8', newline='\n').write(text)
print('importer', os.path.getsize(dst_imp), 'CreateMaterial', text.count('uniforms30'), 'res23', text.count('res23'), 'AlphaCutoff', text.count('AlphaCutoff'), 'uniforms28', text.count('uniforms28'))

for src_rel, dst_rel, a, b in (
    ('Runtime/EID215843DrawProfile.cs', 'Runtime/EID215847DrawProfile.cs', '215843', '215847'),
    ('Runtime/EID215843InstanceBinder.cs', 'Runtime/EID215847InstanceBinder.cs', '215843', '215847'),
):
    src = os.path.join(SRC58, src_rel)
    dst = os.path.join(DST, dst_rel)
    body = open(src, encoding='utf8').read().replace(a, b).replace('215844', '215848')
    open(dst, 'w', encoding='utf8', newline='\n').write(body)
    print('wrote', dst_rel, os.path.getsize(dst))

CS_META = '''fileFormatVersion: 2
guid: %s
MonoImporter:
  externalObjects: {}
  serializedVersion: 2
  defaultReferences: []
  executionOrder: 0
  icon: {instanceID: 0}
  userData:
  assetBundleName:
  assetBundleVariant:
'''
HLSL_META = '''fileFormatVersion: 2
guid: %s
ShaderIncludeImporter:
  externalObjects: {}
  userData:
  assetBundleName:
  assetBundleVariant:
'''
SHADER_META = '''fileFormatVersion: 2
guid: %s
ShaderImporter:
  externalObjects: {}
  defaultTextures: []
  nonModifiableTextures: []
  userData:
  assetBundleName:
  assetBundleVariant:
'''
FOLDER_META = '''fileFormatVersion: 2
guid: %s
folderAsset: yes
DefaultImporter:
  externalObjects: {}
  userData:
  assetBundleName:
  assetBundleVariant:
'''

GUIDS = {
    os.path.join(DST, 'Editor/ColourPass6VS215847PS215848BatchImporter.cs.meta'): ('215847d4e5f647890abcde4455667701', CS_META),
    os.path.join(DST, 'Shaders/EID215847215848GBuffer.shader.meta'): ('215847d4e5f647890abcde4455667702', SHADER_META),
    os.path.join(DST, 'Shaders/EID215847215848GBuffer.hlsl.meta'): ('215847d4e5f647890abcde4455667703', HLSL_META),
    os.path.join(DST, 'Runtime/EID215847DrawProfile.cs.meta'): ('215847d4e5f647890abcde4455667704', CS_META),
    os.path.join(DST, 'Runtime/EID215847InstanceBinder.cs.meta'): ('215847d4e5f647890abcde4455667705', CS_META),
}
for path, (guid, tmpl) in GUIDS.items():
    assert len(guid) == 32, guid
    open(path, 'w', encoding='utf8', newline='\n').write(tmpl % guid)
    print('guid', os.path.basename(path), guid)

open(DST + '.meta', 'w', encoding='utf8', newline='\n').write(FOLDER_META % '215847d4e5f647890abcde4455667700')

FOLDERS = {
    'Editor': '215847d4e5f647890abcde4455667710',
    'Runtime': '215847d4e5f647890abcde4455667711',
    'Shaders': '215847d4e5f647890abcde4455667712',
    'Geometry': '215847d4e5f647890abcde4455667713',
    'Geometry/Meshes': '215847d4e5f647890abcde4455667714',
    'Captured': '215847d4e5f647890abcde4455667715',
    'Captured/Geometry': '215847d4e5f647890abcde4455667716',
    'Captured/CBuffers': '215847d4e5f647890abcde4455667717',
    'Captured/Instances': '215847d4e5f647890abcde4455667718',
    'Materials': '215847d4e5f647890abcde4455667719',
    'Profiles': '215847d4e5f647890abcde445566771a',
    'TextureDatabase': '215847d4e5f647890abcde445566771b',
}
for rel, guid in FOLDERS.items():
    assert len(guid) == 32, (rel, guid)
    open(os.path.join(DST, rel) + '.meta', 'w', encoding='utf8', newline='\n').write(FOLDER_META % guid)
    print('folder', rel, guid)
print('clone ok')
