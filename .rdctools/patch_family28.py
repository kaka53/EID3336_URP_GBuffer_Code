# Patch family-27 clones into family 28.
from pathlib import Path

ROOT = Path(r'D:/endcopy/EID3336_URP_GBuffer_Workspace')

def repl(path, pairs):
    text = path.read_text(encoding='utf-8')
    for a, b in pairs:
        if a not in text:
            raise SystemExit('missing %r in %s' % (a, path))
        text = text.replace(a, b)
    path.write_text(text, encoding='utf-8')
    print('patched', path)

cs = ROOT / 'Assets/ColourPass6_VS215479_PS215480_Batch/Editor/ColourPass6VS215479PS215480BatchImporter.cs'
repl(cs, [
    ('ColourPass6VS215477PS215478BatchImporter', 'ColourPass6VS215479PS215480BatchImporter'),
    ('Assets/ColourPass6_VS215477_PS215478_Batch', 'Assets/ColourPass6_VS215479_PS215480_Batch'),
    ('VS215477_PS215478_BatchManifest.json', 'VS215479_PS215480_BatchManifest.json'),
    ('EID215477215478GBuffer.shader', 'EID215479215480GBuffer.shader'),
    ('Validation/ColourPass6_VS215477', 'Validation/ColourPass6_VS215479'),
    ('ColourPass6_VS215477_PS215478', 'ColourPass6_VS215479_PS215480'),
    ('static readonly int[] ExpectedEIDs = { 1738, 1742, 1747 };',
     'static readonly int[] ExpectedEIDs = { 1752, 1757, 1761 };'),
    ('[MenuItem("Tools/Colour Pass 6/Import EID 27.1-27.3 (VS215477 PS215478)")]',
     '[MenuItem("Tools/Colour Pass 6/Import EID 28.1-28.3 (VS215479 PS215480)")]'),
    ('profiles for 27.1-27.3.', 'profiles for 28.1-28.3.'),
    ('Expected EIDs 27.1-27.3, got ', 'Expected EIDs 28.1-28.3, got '),
    ('VS215477/PS215478 shader has compile errors', 'VS215479/PS215480 shader has compile errors'),
    ('EID215477DrawProfile', 'EID215479DrawProfile'),
    ('[ColourPass6] VS215477/PS215478 import completed', '[ColourPass6] VS215479/PS215480 import completed'),
    ('if (p.vs != 215477 || p.ps != 215478)', 'if (p.vs != 215479 || p.ps != 215480)'),
    ('ssbo28 file is missing.', 'ssbo31 file is missing.'),
    ('Materials/EID" + p.eid + "_VS215477_PS215478.mat', 'Materials/EID" + p.eid + "_VS215479_PS215480.mat'),
    ('m.name = "EID" + p.eid + " VS215477 PS215478";', 'm.name = "EID" + p.eid + " VS215479 PS215478";'),
    ('m.SetFloat("_EID215478MipBias", ReadFloat(globals, 416));',
     'm.SetFloat("_EID215480MipBias", ReadFloat(globals, 416));'),
    ('27.1-27.3 instance total expected', '28.1-28.3 instance total expected'),
    ('g.material.shader.name != "EID/URP/VS215477_PS215478_GBuffer"',
     'g.material.shader.name != "EID/URP/VS215479_PS215480_GBuffer"'),
    ('# VS215477 / PS215478 Vertex Attribute Audit', '# VS215479 / PS215480 Vertex Attribute Audit'),
    ('- EIDs: `27.1-27.3`', '- EIDs: `28.1-28.3`'),
    ('skin bake ssbo28 via uniforms26 when bit 32 set',
     'skin bake ssbo31 via uniforms26 when bit 32 set'),
    ('VS215477 Complete VSInput', 'VS215479 Complete VSInput'),
])

# leftover 215478 in material name if the earlier pair missed due to typo
text = cs.read_text(encoding='utf-8')
text = text.replace('VS215479 PS215478', 'VS215479 PS215480')
cs.write_text(text, encoding='utf-8')

leftovers = []
for s in ['215477', '215478', '1738', '1742', '1747', 'ssbo28', '27.1', '27.3']:
    if s in text:
        leftovers.append(s)
print('cs leftovers', leftovers)

dp = ROOT / 'Assets/ColourPass6_VS215479_PS215480_Batch/Runtime/EID215479DrawProfile.cs'
repl(dp, [
    ('[CreateAssetMenu(menuName = "EID/VS215477 PS215478 Draw Profile", fileName = "EID215477DrawProfile")]',
     '[CreateAssetMenu(menuName = "EID/VS215479 PS215480 Draw Profile", fileName = "EID215479DrawProfile")]'),
    ('public sealed class EID215477DrawProfile : ScriptableObject',
     'public sealed class EID215479DrawProfile : ScriptableObject'),
])

sh = ROOT / 'Assets/ColourPass6_VS215479_PS215480_Batch/Shaders/EID215479215480GBuffer.shader'
repl(sh, [
    ('Shader "EID/URP/VS215477_PS215478_GBuffer"', 'Shader "EID/URP/VS215479_PS215480_GBuffer"'),
    ('_EID215478MipBias', '_EID215480MipBias'),
    ('ssbo28', 'ssbo31'),
    ('Name "VS215477_PS215478_UniversalGBuffer"', 'Name "VS215479_PS215480_UniversalGBuffer"'),
    ('#pragma vertex EID215477Vertex', '#pragma vertex EID215479Vertex'),
    ('#pragma fragment EID215478Fragment', '#pragma fragment EID215480Fragment'),
    ('#include "EID215477215478GBuffer.hlsl"', '#include "EID215479215480GBuffer.hlsl"'),
])

hl = ROOT / 'Assets/ColourPass6_VS215479_PS215480_Batch/Shaders/EID215479215480GBuffer.hlsl'
repl(hl, [
    ('EID215477_215478_GBUFFER_INCLUDED', 'EID215479_215480_GBUFFER_INCLUDED'),
    ('_EID215478MipBias', '_EID215480MipBias'),
    ('Attributes215477', 'Attributes215479'),
    ('Varyings215477', 'Varyings215479'),
    ('EID215477Vertex', 'EID215479Vertex'),
    ('GBufferOutput215478', 'GBufferOutput215480'),
    ('EID215478Fragment', 'EID215480Fragment'),
])

py = ROOT / '.rdctools/export_215479_215480_batch.py'
repl(py, [
    ("1738: '27.1',\n    1742: '27.2',\n    1747: '27.3',",
     "1752: '28.1',\n    1757: '28.2',\n    1761: '28.3',"),
    ('EIDS = [1738, 1742, 1747]', 'EIDS = [1752, 1757, 1761]'),
    ("FAMILY = 'VS215477_PS215478'", "FAMILY = 'VS215479_PS215480'"),
    ('EXPECTED = (215477, 215478)', 'EXPECTED = (215479, 215480)'),
    ("ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215477_PS215478_Batch'",
     "ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215479_PS215480_Batch'"),
    ("for stage, key in [(rd.ShaderStage.Vertex, 'VS215477'), (rd.ShaderStage.Pixel, 'PS215478')]:",
     "for stage, key in [(rd.ShaderStage.Vertex, 'VS215479'), (rd.ShaderStage.Pixel, 'PS215480')]:"),
    ("os.path.join(ASSETS, 'ColourPass6_VS215477_PS215478_Batch', 'TextureDatabase'),",
     "os.path.join(ASSETS, 'ColourPass6_VS215479_PS215480_Batch', 'TextureDatabase'),"),
    ("'skinning': 'ssbo28 Binding7; flags uniforms26 child1.w bit32',",
     "'skinning': 'ssbo31 Binding7; flags uniforms26 child1.w bit32',"),
    ("open(os.path.join(ROOT, 'VS215477_PS215478_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))",
     "open(os.path.join(ROOT, 'VS215479_PS215480_BatchManifest.json'), 'w', encoding='utf8').write(json.dumps(out, indent=2, default=str))"),
    ("result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215477_215478_batch_result.json'",
     "result_path = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/.rdctools/export_215479_215480_batch_result.json'"),
])

pytext = py.read_text(encoding='utf-8')
pyleftovers = []
for s in ['215477', '215478', '1738', 'ssbo28', '27.1']:
    if s in pytext:
        pyleftovers.append(s)
print('py leftovers', pyleftovers)
print('done')
