import os

ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS215481_PS215482_Batch'
IMP = os.path.join(ROOT, 'Editor/ColourPass6VS215481PS215482BatchImporter.cs')
SH = os.path.join(ROOT, 'Shaders/EID215481215482GBuffer.shader')
HL = os.path.join(ROOT, 'Shaders/EID215481215482GBuffer.hlsl')


def patch(path, pairs):
    text = open(path, encoding='utf8').read()
    for old, new in pairs:
        if old not in text:
            raise SystemExit('missing in %s:\n%s' % (path, old[:120]))
        text = text.replace(old, new)
    open(path, 'w', encoding='utf8', newline='\n').write(text)
    print('patched', os.path.basename(path))


patch(IMP, [
    ('static readonly int[] ExpectedEIDs = { 1752, 1757, 1761 };',
     'static readonly int[] ExpectedEIDs = { 1766, 1770 };'),
    ('static readonly int ExpectedInstances = 3;',
     'static readonly int ExpectedInstances = 2;'),
    ('static readonly int ExpectedLayoutVariants = 2;',
     'static readonly int ExpectedLayoutVariants = 1;'),
    ('[MenuItem("Tools/Colour Pass 6/Import EID 28.1-28.3 (VS215481 PS215482)")]',
     '[MenuItem("Tools/Colour Pass 6/Import EID 35.1-35.2 (VS215481 PS215482)")]'),
    ('throw new InvalidDataException("Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 28.1-28.3.");',
     'throw new InvalidDataException("Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 35.1-35.2.");'),
    ('throw new InvalidDataException("Expected EIDs 28.1-28.3, got " + string.Join(",", got));',
     'throw new InvalidDataException("Expected EIDs 35.1-35.2, got " + string.Join(",", got));'),
    ('if (local.Length < 336) throw new InvalidDataException("EID" + p.eid + " PS uniforms11 expected 336 bytes, got " + local.Length);',
     'if (local.Length < 352) throw new InvalidDataException("EID" + p.eid + " PS uniforms11 expected 352 bytes, got " + local.Length);'),
    ('for (int i = 0; i < 21; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));',
     'for (int i = 0; i < 22; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));'),
    ('if (instances != ExpectedInstances) throw new InvalidDataException("28.1-28.3 instance total expected " + ExpectedInstances + ", got " + instances);',
     'if (instances != ExpectedInstances) throw new InvalidDataException("35.1-35.2 instance total expected " + ExpectedInstances + ", got " + instances);'),
    ('audit.Insert(0, "# VS215481 / PS215482 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `28.1-28.3`\\n- Layout variants: `" + layouts + "`\\n- Shader: live Unity VP; unique res12 albedo; PS uniforms11 336B; Cull Front; ZWrite On; stencil Ref 36; Queue AlphaTest clip; packed `_input2` on NORMAL.x; ColorMask RT0 only; skin bake ssbo31 via uniforms26 when bit 32 set\\n\\n");',
     'audit.Insert(0, "# VS215481 / PS215482 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `35.1-35.2`\\n- Layout variants: `" + layouts + "`\\n- Shader: live Unity VP; unique res12 clip; PS uniforms11 352B `_P00`..`_P21`; Cull Front; ZWrite On; stencil Ref 36; Queue AlphaTest clip `sample.x - _P12.x`; packed `_input2` on NORMAL.x; ColorMask RT0 only; skin bake ssbo31 via uniforms26 when bit 32 set\\n\\n");'),
])

patch(SH, [
    ('        [Header(RenderDoc_PS_uniforms11_21xfloat4)]',
     '        [Header(RenderDoc_PS_uniforms11_22xfloat4)]'),
    ('        _P02 ("c02 child9 裁剪阈值在 y", Vector) = (0,0.5,0,0)',
     '        _P02 ("c02 捕获局部参数", Vector) = (0,0,0,0)'),
    ('        _P06 ("c06 child24 透明度在 w", Vector) = (1,1,1,1)',
     '        _P06 ("c06 捕获局部参数", Vector) = (0,0,0,0)'),
    ('        _P12 ("c12 捕获局部参数", Vector) = (0,0,0,0)',
     '        _P12 ("c12 child30 裁剪阈值在 x", Vector) = (0.5,0,0,0)'),
    ('        _P20 ("c20 捕获局部参数", Vector) = (0,0,0,0)\n        _EID215482MipBias ("uniforms6 全局纹理 Mip Bias", Float) = 0',
     '        _P20 ("c20 捕获局部参数", Vector) = (0,0,0,0)\n        _P21 ("c21 捕获局部参数", Vector) = (0,0,0,0)\n        _EID215482MipBias ("uniforms6 全局纹理 Mip Bias", Float) = 0'),
    ('        _Res12 ("res12 基础颜色 Binding1", 2D) = "white" {}',
     '        _Res12 ("res12 裁剪 Binding2", 2D) = "white" {}'),
])

patch(HL, [
    ('	float4 _P16; float4 _P17; float4 _P18; float4 _P19;\n	float4 _P20;\n	float _EID215482MipBias;',
     '	float4 _P16; float4 _P17; float4 _P18; float4 _P19;\n	float4 _P20; float4 _P21;\n	float _EID215482MipBias;'),
    ('    float4 albedoSample = SAMPLE_TEXTURE2D_BIAS(_Res12, sampler_Res12, input.uv, _EID215482MipBias);\n    clip(albedoSample.a * _P06.w - _P02.y);\n    o.rt0 = float4(0.0, 0.0, 0.0, 0.0);',
     '    float clipSample = SAMPLE_TEXTURE2D_BIAS(_Res12, sampler_Res12, input.uv, _EID215482MipBias).x;\n    clip(clipSample - _P12.x);\n    o.rt0 = float4(0.0, 0.0, 0.0, 0.0);'),
])

for path, needles in (
    (IMP, ['1752', '1757', '1761', '28.1', '336', 'i < 21', 'albedoSample']),
    (SH, ['_P00 .. wait', '21xfloat4', 'child9', '透明度']),
    (HL, ['_P06.w', 'albedoSample', 'float4 _P20;']),
):
    text = open(path, encoding='utf8').read()
    leftover = [n for n in needles if n in text]
    print(os.path.basename(path), 'leftover', leftover)
print('ok')
