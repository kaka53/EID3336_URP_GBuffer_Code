from pathlib import Path
p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Runtime/EID4922SkyRendererFeature.cs')
s=p.read_text()
s=s.replace('public RenderPassEvent injectionPoint = RenderPassEvent.BeforeRenderingSkybox;', 'public RenderPassEvent injectionPoint = RenderPassEvent.AfterRenderingOpaques;')
s=s.replace('pass.SetTarget(renderer.cameraColorTargetHandle);', 'pass.SetTargets(renderer.cameraColorTargetHandle, renderer.cameraDepthTargetHandle);')
s=s.replace('RTHandle colorTarget;', 'RTHandle colorTarget;\n    RTHandle depthTarget;')
s=s.replace('public void SetTarget(RTHandle target) { colorTarget = target; }', 'public void SetTargets(RTHandle color, RTHandle depth) { colorTarget = color; depthTarget = depth; }')
s=s.replace('if (colorTarget != null) ConfigureTarget(colorTarget);', 'if (colorTarget != null && depthTarget != null) ConfigureTarget(colorTarget, depthTarget);')
s=s.replace('CoreUtils.SetRenderTarget(cmd, colorTarget, ClearFlag.None);', 'CoreUtils.SetRenderTarget(cmd, colorTarget, depthTarget, ClearFlag.None, Color.clear);')
s=s.replace('    static float[] BytesToFloats(byte[] bytes)\n    {\n        if (bytes == null || bytes.Length == 0 || (bytes.Length & 15) != 0) return null;\n        float[] result = new float[bytes.Length / 4];\n        Buffer.BlockCopy(bytes, 0, result, 0, bytes.Length);\n        return result;\n    }', '''    static Vector4[] BytesToVectors(byte[] bytes)
    {
        if (bytes == null || bytes.Length == 0 || (bytes.Length & 15) != 0) return null;
        float[] values = new float[bytes.Length / 4];
        Buffer.BlockCopy(bytes, 0, values, 0, bytes.Length);
        Vector4[] result = new Vector4[bytes.Length / 16];
        for (int i = 0; i < result.Length; i++) result[i] = new Vector4(values[i * 4], values[i * 4 + 1], values[i * 4 + 2], values[i * 4 + 3]);
        return result;
    }''')
s=s.replace('old.SetData(BytesToFloats(asset.bytes));', 'old.SetData(BytesToVectors(asset.bytes));')
p.write_text(s)

p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Shaders/EID4922Sky.hlsl')
s=p.read_text().replace('float3 positionOS : TEXCOORD0;', 'float3 positionOS : POSITION;').replace('float2 uv : TEXCOORD1;', 'float2 uv : TEXCOORD0;')
p.write_text(s)

p=Path('Assets/EID3332_EID3336_Combined/EID4922_RenderDocSky/Editor/EID4922SkyAssetBuilder.cs')
s=p.read_text()
# Validate generated direct port instead of accepting lazy shader import.
s=s.replace('if (shader == null || mesh == null) throw new System.Exception("EID4922 shader or mesh import failed");', '''if (shader == null || mesh == null) throw new System.Exception("EID4922 shader or mesh import failed");
        ShaderMessage[] shaderMessages = ShaderUtil.GetShaderMessages(shader);
        if (ShaderUtil.ShaderHasError(shader))
        {
            var errors = new System.Text.StringBuilder();
            foreach (ShaderMessage message in shaderMessages) errors.AppendLine(message.severity + " " + message.file + ":" + message.line + " " + message.message);
            throw new System.Exception("EID4922 direct-port shader compile failed:\n" + errors);
        }''')
# Keep renderer feature local-id map in sync with the feature list.
old='''        feature.settings.injectionPoint = RenderPassEvent.AfterRenderingOpaques;
        EditorUtility.SetDirty(feature); EditorUtility.SetDirty(data);'''
new='''        feature.settings.injectionPoint = RenderPassEvent.AfterRenderingOpaques;
        SerializedObject serialized = new SerializedObject(data);
        SerializedProperty map = serialized.FindProperty("m_RendererFeatureMap");
        if (map != null)
        {
            map.arraySize = data.rendererFeatures.Count;
            for (int i = 0; i < data.rendererFeatures.Count; i++)
            {
                AssetDatabase.TryGetGUIDAndLocalFileIdentifier(data.rendererFeatures[i], out string _, out long localId);
                map.GetArrayElementAtIndex(i).longValue = localId;
            }
        }
        serialized.ApplyModifiedPropertiesWithoutUndo();
        EditorUtility.SetDirty(feature); EditorUtility.SetDirty(data);'''
assert old in s
s=s.replace(old,new)
p.write_text(s)
