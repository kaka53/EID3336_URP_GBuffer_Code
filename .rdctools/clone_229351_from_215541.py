import os
import re

SRC = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215541_PS215542_Batch'
DST = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS229351_PS229352_Batch'

os.makedirs(DST, exist_ok=True)
for sub in (
    'Editor', 'Runtime', 'Shaders', 'Geometry/Meshes', 'Materials', 'Profiles',
    'TextureDatabase', 'Captured/Geometry', 'Captured/CBuffers', 'Captured/Instances',
):
    os.makedirs(os.path.join(DST, sub), exist_ok=True)


def rewrite_importer(text):
    text = text.replace('ColourPass6VS215541PS215542BatchImporter', 'ColourPass6VS229351PS229352BatchImporter')
    text = text.replace('ColourPass6_VS215541_PS215542_Batch', 'ColourPass6_VS229351_PS229352_Batch')
    text = text.replace('VS215541_PS215542', 'VS229351_PS229352')
    text = text.replace('EID215541215542GBuffer', 'EID229351229352GBuffer')
    text = text.replace('EID215541DrawProfile', 'EID229351DrawProfile')
    text = text.replace('VS215541', 'VS229351')
    text = text.replace('PS215542', 'PS229352')
    text = text.replace('215541', '229351')
    text = text.replace('215542', '229352')
    text = text.replace('static readonly int[] ExpectedEIDs = { 3680, 3684, 3689 };', 'static readonly int[] ExpectedEIDs = { 3755 };')
    text = text.replace('static readonly int ExpectedInstances = 38;', 'static readonly int ExpectedInstances = 1;')
    text = text.replace('static readonly int ExpectedLayoutVariants = 2;', 'static readonly int ExpectedLayoutVariants = 1;')
    text = text.replace('31.1-31.3', '60.1')
    text = text.replace('local.Length < 320', 'local.Length < 352')
    text = text.replace('PS uniforms30 expected 320 bytes', 'PS uniforms30 expected 352 bytes')
    text = text.replace('[MenuItem("Tools/Colour Pass 6/Import EID 60.1 (VS229351 PS229352)")]', '[MenuItem("Tools/Colour Pass 6/Import EID 60.1 (VS229351 PS229352)")]')
    text = text.replace('Import EID 60.1 (VS229351 PS229352)', 'Import EID 60.1 (VS229351 PS229352)')
    return text


CREATE_MATERIAL = r'''    static Material CreateMaterial(Profile p, Shader shader, StringBuilder report)
    {
        string path = Root + "/Materials/EID" + p.eid + "_VS229351_PS229352.mat";
        Material m = AssetDatabase.LoadAssetAtPath<Material>(path);
        if (m == null) { m = new Material(shader); AssetDatabase.CreateAsset(m, path); }
        m.shader = shader; m.name = "EID" + p.eid + " VS229351 PS229352";
        byte[] local = ReadCB(p, "PS", "uniforms30");
        if (local.Length < 352) throw new InvalidDataException("EID" + p.eid + " PS uniforms30 expected 352 bytes, got " + local.Length);
        for (int i = 0; i < 22; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));
        byte[] globals = ReadCB(p, "PS", "uniforms19");
        m.SetFloat("_EID229352MipBias", ReadFloat(globals, 416));
        byte[] wind = ReadCB(p, "VS", "uniforms24");
        m.SetVector("_WindA", ReadVector4(wind, 512));
        m.SetVector("_WindB", ReadVector4(wind, 896));
        m.SetFloat("_WindGate", ReadFloat(wind, 880));
        m.SetVector("_SunDir", ReadVector4(wind, 1296));
        byte[] u20 = ReadCB(p, "VS", "uniforms20");
        m.SetFloat("_PrevBlend", u20.Length >= 20 ? ReadFloat(u20, 16) : 0f);
        Texture albedo = LoadTexture(p, "res25");
        Texture extra = LoadTexture(p, "res27");
        Texture windTex = LoadTexture(p, "res31");
        if (albedo == null || extra == null || windTex == null)
            throw new FileNotFoundException("EID" + p.eid + " res25/res27/res31 texture binding is incomplete.");
        m.SetTexture("_Res25", albedo);
        m.SetTexture("_Res27", extra);
        m.SetTexture("_Res31", windTex);
        EditorUtility.SetDirty(m);
        report.AppendLine("EID" + p.eid + ": material res25=RID" + Rid(p, "res25") + " res27=RID" + Rid(p, "res27") + " res31=RID" + Rid(p, "res31") + " PS uniforms30=" + local.Length + "B");
        return m;
    }
'''

AUDIT = (
    'audit.Insert(0, "# VS229351 / PS229352 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n'
    '- EIDs: `60.1` (`3755`)\\n- Layout variants: `1` (`812bd8531503c10d`)\\n- Unique source meshes: `1`\\n'
    '- Instances: `1` via uniforms27 stride 256, per-GO Transform\\n'
    '- Packed `_input1` on `NORMAL.x` oct 0.0020; live Unity VP; Combined wind RID14988; unique res25/res27; DXT5nm `.wy`; no clip; stencil 33; ZTest Equal; ZWrite Off; Queue Geometry+10; PS uniforms30 352B; encode 0.0010; skip skin\\n\\n");'
)

src_imp = os.path.join(SRC, 'Editor/ColourPass6VS215541PS215542BatchImporter.cs')
dst_imp = os.path.join(DST, 'Editor/ColourPass6VS229351PS229352BatchImporter.cs')
text = rewrite_importer(open(src_imp, encoding='utf8').read())
text = re.sub(
    r'    static Material CreateMaterial\(Profile p, Shader shader, StringBuilder report\)\n    \{.*?\n    \}\n\n    static EID229351DrawProfile CreateProfileAsset',
    CREATE_MATERIAL + '\n    static EID229351DrawProfile CreateProfileAsset',
    text,
    count=1,
    flags=re.S,
)
text = re.sub(
    r'audit\.Insert\(0, "# VS229351 / PS229352 Vertex Attribute Audit\\n\\n.*?"\);',
    AUDIT,
    text,
    count=1,
    flags=re.S,
)
open(dst_imp, 'w', encoding='utf8', newline='\n').write(text)
print(
    'importer', os.path.getsize(dst_imp),
    'uniforms32', text.count('uniforms32'),
    'for22', text.count('i < 22'),
    'for20', text.count('i < 20'),
    '3680', text.count('3680'),
    '3755', text.count('3755'),
    '320B leftover', text.count('320'),
)

src_dp = os.path.join(SRC, 'Runtime/EID215541DrawProfile.cs')
dst_dp = os.path.join(DST, 'Runtime/EID229351DrawProfile.cs')
body = open(src_dp, encoding='utf8').read().replace('215541', '229351').replace('215542', '229352')
open(dst_dp, 'w', encoding='utf8', newline='\n').write(body)
print('wrote DrawProfile', os.path.getsize(dst_dp))

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
    os.path.join(DST, 'Editor/ColourPass6VS229351PS229352BatchImporter.cs.meta'): ('229351d4e5f647890abcde4455667701', CS_META),
    os.path.join(DST, 'Shaders/EID229351229352GBuffer.shader.meta'): ('229351d4e5f647890abcde4455667702', SHADER_META),
    os.path.join(DST, 'Shaders/EID229351229352GBuffer.hlsl.meta'): ('229351d4e5f647890abcde4455667703', HLSL_META),
    os.path.join(DST, 'Runtime/EID229351DrawProfile.cs.meta'): ('229351d4e5f647890abcde4455667704', CS_META),
}
for path, (guid, tmpl) in GUIDS.items():
    assert len(guid) == 32, guid
    open(path, 'w', encoding='utf8', newline='\n').write(tmpl % guid)
    print('guid', os.path.basename(path), guid)

open(DST + '.meta', 'w', encoding='utf8', newline='\n').write(FOLDER_META % '229351d4e5f647890abcde4455667700')

FOLDERS = {
    'Editor': '229351d4e5f647890abcde4455667710',
    'Runtime': '229351d4e5f647890abcde4455667711',
    'Shaders': '229351d4e5f647890abcde4455667712',
    'Geometry': '229351d4e5f647890abcde4455667713',
    'Geometry/Meshes': '229351d4e5f647890abcde4455667714',
    'Captured': '229351d4e5f647890abcde4455667715',
    'Captured/Geometry': '229351d4e5f647890abcde4455667716',
    'Captured/CBuffers': '229351d4e5f647890abcde4455667717',
    'Captured/Instances': '229351d4e5f647890abcde4455667718',
    'Materials': '229351d4e5f647890abcde4455667719',
    'Profiles': '229351d4e5f647890abcde445566771a',
    'TextureDatabase': '229351d4e5f647890abcde445566771b',
}
for rel, guid in FOLDERS.items():
    assert len(guid) == 32, (rel, guid)
    open(os.path.join(DST, rel) + '.meta', 'w', encoding='utf8', newline='\n').write(FOLDER_META % guid)
    print('folder', rel, guid)
print('clone ok')
