# -*- coding: utf-8 -*-
import os

ROOT = r'D:/endcopy/EID3336_URP_GBuffer_Workspace/Assets/ColourPass6_VS229074_PS229075_Batch'
IMP = os.path.join(ROOT, 'Editor/ColourPass6VS229074PS229075BatchImporter.cs')
SH = os.path.join(ROOT, 'Shaders/EID229074229075GBuffer.shader')
HL = os.path.join(ROOT, 'Shaders/EID229074229075GBuffer.hlsl')


def repl(path, old, new, n=1):
    text = open(path, encoding='utf8').read()
    if old not in text:
        raise SystemExit('missing in %s:\n%s' % (path, old[:120]))
    text2 = text.replace(old, new, n)
    if n == 1 and text.count(old) != 1:
        raise SystemExit('expected 1 occurrence in %s, got %d for:\n%s' % (path, text.count(old), old[:120]))
    open(path, 'w', encoding='utf8', newline='\n').write(text2)


repl(IMP, 'static readonly int[] ExpectedEIDs = { 3166, 3170, 3174, 3178, 3182, 3186, 3190, 3194, 3199 };',
     'static readonly int[] ExpectedEIDs = { 3739, 3743, 3749 };')
repl(IMP, 'static readonly int ExpectedInstances = 17;',
     'static readonly int ExpectedInstances = 3;')
repl(IMP, '[MenuItem("Tools/Colour Pass 6/Import EID 12.1-12.9 (VS229074 PS229075)")]',
     '[MenuItem("Tools/Colour Pass 6/Import EID 33.1-33.3 (VS229074 PS229075)")]')
repl(IMP, 'throw new InvalidDataException("Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 12.1-12.9.");',
     'throw new InvalidDataException("Manifest must contain exactly " + ExpectedEIDs.Length + " profiles for 33.1-33.3.");')
repl(IMP, 'throw new InvalidDataException("Expected EIDs 12.1-12.9, got " + string.Join(",", got));',
     'throw new InvalidDataException("Expected EIDs 33.1-33.3, got " + string.Join(",", got));')
repl(IMP, 'if (p.vs != 229074 || p.ps != 229075) throw new InvalidDataException("EID" + p.eid + " shader family mismatch.");',
     'if (p.vs != 229074 || p.ps != 229075) throw new InvalidDataException("EID" + p.eid + " shader family mismatch.");')
repl(IMP, 'if (local.Length < 496) throw new InvalidDataException("EID" + p.eid + " PS uniforms32 expected 496 bytes, got " + local.Length);',
     'if (local.Length < 512) throw new InvalidDataException("EID" + p.eid + " PS uniforms32 expected 512 bytes, got " + local.Length);')
repl(IMP, 'for (int i = 0; i < 31; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));',
     'for (int i = 0; i < 32; ++i) m.SetVector("_P" + i.ToString("00"), ReadVector4(local, i * 16));\n        m.SetFloat("_StencilRef", p.eid == 3749 ? 32f : 0f);')
repl(IMP, 'if (instances != ExpectedInstances) throw new InvalidDataException("12.1-12.9 instance total expected " + ExpectedInstances + ", got " + instances);',
     'if (instances != ExpectedInstances) throw new InvalidDataException("33.1-33.3 instance total expected " + ExpectedInstances + ", got " + instances);')
repl(IMP, 'audit.Insert(0, "# VS229074 / PS229075 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `12.1-12.9`\\n- Layout variants: `" + layouts + "` (`d6a844f320196881` majority, `3eae907666b7ec55` 12.9)\\n- Shader: live Unity VP; unique res23/res25/res27/res29; PS uniforms32 496B; Cull Off; ZWrite On; skin bake EID3199; VT off\\n\\n");',
     'audit.Insert(0, "# VS229074 / PS229075 Vertex Attribute Audit\\n\\n- Date: `" + DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture) + "`\\n- EIDs: `33.1-33.3`\\n- Layout variants: `" + layouts + "` (`92c69fac64531db0` 3739/3743, `29cc8fba15c83e9c` 3749)\\n- Shader: live Unity VP; unique res23/res25/res27/res29; PS uniforms32 512B; Cull Off; ZWrite Off; ZTest Equal; stencil 0/32; skin bake ssbo30; VT off\\n\\n");')

repl(SH, '        [Header(RenderDoc_PS_uniforms32_c00_c30)]',
     '        [Header(RenderDoc_PS_uniforms32_c00_c31)]')
repl(SH, '        _P30 ("c30 叠加UV", Vector) = (1,1,0,0)\n        _InstanceMeta ("uniforms34 实例材质元数据", Vector) = (0,0,0,0)',
     '        _P30 ("c30 叠加UV附加", Vector) = (0,0,0,0)\n        _P31 ("c31 叠加UV", Vector) = (1,1,0,0)\n        _StencilRef ("Captured stencil ref", Float) = 0\n        _InstanceMeta ("uniforms34 实例材质元数据", Vector) = (0,0,0,0)')
repl(SH, '            ZWrite On\n            ZTest LEqual\n            Blend Off\n            Stencil { Ref 0 Comp Always Pass Replace ReadMask 255 WriteMask 255 }',
     '            ZWrite Off\n            ZTest Equal\n            Blend Off\n            Stencil { Ref [_StencilRef] Comp Always Pass Replace ReadMask 255 WriteMask 255 }')

repl(HL, '    float4 _P28; float4 _P29; float4 _P30;\n    float4 _InstanceMeta;',
     '    float4 _P28; float4 _P29; float4 _P30; float4 _P31;\n    float _StencilRef;\n    float4 _InstanceMeta;')
repl(HL, '''    float2 uvOverlay = lerp(input.uv0, input.uv1, _P25.x) * _P30.xy + _P30.zw + _P29.xy * _Global75W;
    float4 overlaySample = SAMPLE_TEXTURE2D_BIAS(_Res29, sampler_Res29, uvOverlay, _EID229075MipBias);
    float3 overlayMixColor = lerp(_P24.rgb, _OverlayChild7.rgb, _OverlayChild7.aaa);
    float3 overlayAdd = (_P26.rgb * overlaySample.y + _P27.rgb * overlaySample.z + _P28.rgb * overlaySample.w) * _P25.y;
    float3 overlayColor = overlayMixColor * overlaySample.x + overlayAdd;
    float overlayGate = _OverlayChild9.w * step(0.1, overlaySample.x) * _P22.z;
    float3 overlayMask = lerp(1.0.xxx, _OverlayChild9.rgb, overlayGate.xxx);
    float3 albedoMasked = baseColor * overlayMask;
    float3 overlayLit = overlayColor * lerp(albedoMasked, 1.0.xxx, _P22.yyy);
    overlayLit *= (1.0 - _OverlayChild5.x);
    overlayLit *= lerp(1.0, _LightMixY, _P22.x);''',
     '''    float2 uvOverlay = lerp(input.uv0, input.uv1, _P26.x) * _P31.xy + _P31.zw + _P30.xy * _Global75W;
    float4 overlaySample = SAMPLE_TEXTURE2D_BIAS(_Res29, sampler_Res29, uvOverlay, _EID229075MipBias);
    float3 overlayMixColor = lerp(_P25.rgb, _OverlayChild7.rgb, _OverlayChild7.aaa);
    float3 overlayAdd = (_P27.rgb * overlaySample.y + _P28.rgb * overlaySample.z + _P29.rgb * overlaySample.w) * _P26.y;
    float3 overlayColor = overlayMixColor * overlaySample.x + overlayAdd;
    float overlayGate = _OverlayChild9.w * step(0.1, overlaySample.x) * _P23.z;
    float3 overlayMask = lerp(1.0.xxx, _OverlayChild9.rgb, overlayGate.xxx);
    float3 albedoMasked = baseColor * overlayMask;
    float3 overlayLit = overlayColor * lerp(albedoMasked, 1.0.xxx, _P23.yyy);
    overlayLit *= (1.0 - _OverlayChild5.x);
    overlayLit *= lerp(1.0, _LightMixY, _P23.x);
    overlayLit *= _P26.z;''')

META = '''fileFormatVersion: 2
guid: {guid}
{body}
'''
metas = {
    os.path.join(ROOT, 'Shaders/EID229074229075GBuffer.shader.meta'): (
        '229074d4e5f647890abcde4455667701',
        'ShaderImporter:\n  externalObjects: {}\n  defaultTextures: []\n  nonModifiableTextures: []\n  userData:\n  assetBundleName:\n  assetBundleVariant:\n'),
    os.path.join(ROOT, 'Shaders/EID229074229075GBuffer.hlsl.meta'): (
        '229074d4e5f647890abcde4455667702',
        'ShaderIncludeImporter:\n  externalObjects: {}\n  userData:\n  assetBundleName:\n  assetBundleVariant:\n'),
    os.path.join(ROOT, 'Editor/ColourPass6VS229074PS229075BatchImporter.cs.meta'): (
        '229074d4e5f647890abcde4455667703',
        'MonoImporter:\n  externalObjects: {}\n  serializedVersion: 2\n  defaultReferences: []\n  executionOrder: 0\n  icon: {instanceID: 0}\n  userData:\n  assetBundleName:\n  assetBundleVariant:\n'),
    os.path.join(ROOT, 'Runtime/EID229074DrawProfile.cs.meta'): (
        '229074d4e5f647890abcde4455667704',
        'MonoImporter:\n  externalObjects: {}\n  serializedVersion: 2\n  defaultReferences: []\n  executionOrder: 0\n  icon: {instanceID: 0}\n  userData:\n  assetBundleName:\n  assetBundleVariant:\n'),
}
for path, (guid, body) in metas.items():
    if len(guid) != 32:
        raise SystemExit('bad guid len %s %d' % (guid, len(guid)))
    open(path, 'w', encoding='utf8', newline='\n').write('fileFormatVersion: 2\nguid: %s\n%s' % (guid, body))
    print('meta', os.path.basename(path), guid)

print('patched')
