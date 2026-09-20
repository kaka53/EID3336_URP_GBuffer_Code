#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering.Universal;

public static class EndfieldCP2ExactReplaySetup
{
    const string InputsPath = "Assets/EndfieldCP2_ExactReplay/Materials/EndfieldCP2_ExactReplayInputs.asset";
    const string Imported = "Assets/EID3332_EID3336_Combined/DeferredLighting/EID4662Full/Resources/Imported/";
    const string CombinedRenderer = "Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-Renderer.asset";
    const string Captured = "Assets/EndfieldCP2_ExactReplay/Captured/";
    const string HiZShaderPath = "Assets/EndfieldCP2_ExactReplay/Shaders/EID4486_HiZBuild.compute";
    const string HiZDownShaderPath = "Assets/EndfieldCP2_ExactReplay/Shaders/EID4490_HiZDown.compute";
    const string LinDepthShaderPath = "Assets/EndfieldCP2_ExactReplay/Shaders/EID4514_LinDepth.compute";
    const string GtaoShaderPath = "Assets/EndfieldCP2_ExactReplay/Shaders/EID4518_GTAO.compute";
    const string AoTemporalShaderPath = "Assets/EndfieldCP2_ExactReplay/Shaders/EID4522_AOTemporal.compute";
    const string AoBlurShaderPath = "Assets/EndfieldCP2_ExactReplay/Shaders/EID4526_AOBlur.compute";
    const string AoBlur2ShaderPath = "Assets/EndfieldCP2_ExactReplay/Shaders/EID4530_AOBlur2.compute";
    const string ContactShadowShaderPath = "Assets/EndfieldCP2_ExactReplay/Shaders/EID4594_ContactShadow.compute";
    const string Depth543Path = "Assets/EID4662_ComputePass2/CapturedResources/Native/rid209543_depth_r32f.asset";
    const string OctNormalPath = "Assets/EndfieldCP2_ExactReplay/Captured/UnityNative/rid209566_oct_normal.asset";
    const string Motion210525Path = "Assets/EID4662_ComputePass2/CapturedResources/Native/rid210525.asset";
    const string History209486Path = "Assets/EndfieldCP2_ExactReplay/Captured/UnityNative/rid209486_history.asset";

    [MenuItem("Tools/Endfield CP2/Refresh Baseline Inputs")]
    public static void RefreshInputs()
    {
        EndfieldCP2ExactReplayInputs inputs = LoadOrCreateInputs();
        inputs.aoFull = LoadTex("ssao_b18");
        inputs.ssrColor = LoadTex("screen_specular_color_b7");
        inputs.ssrMask = LoadTex("screen_specular_weight_b8");
        inputs.contact = LoadTex("reflection_visibility_b22");
        inputs.depthFull209535 = AssetDatabase.LoadAssetAtPath<Texture>(
            Captured + "UnityNative/rid209535_depth_r32f.asset");
        inputs.uniforms14 = AssetDatabase.LoadAssetAtPath<TextAsset>(Captured + "eid4486_uniforms14.bytes");
        inputs.uniforms14Down = AssetDatabase.LoadAssetAtPath<TextAsset>(Captured + "eid4490_4510_uniforms14.bytes");
        inputs.hizRef209118 = AssetDatabase.LoadAssetAtPath<Texture>(
            "Assets/EID4662_ComputePass2/CapturedResources/Native/rid209118.asset");
        inputs.depthFull209543 = AssetDatabase.LoadAssetAtPath<Texture>(Depth543Path);
        inputs.uniforms6 = AssetDatabase.LoadAssetAtPath<TextAsset>(Captured + "eid4514_uniforms6.bytes");
        inputs.uniforms11 = AssetDatabase.LoadAssetAtPath<TextAsset>(Captured + "eid4514_uniforms11.bytes");
        inputs.octNormal209566 = AssetDatabase.LoadAssetAtPath<Texture>(OctNormalPath);
        inputs.uniforms5 = AssetDatabase.LoadAssetAtPath<TextAsset>(Captured + "eid4518_uniforms5.bytes");
        inputs.uniforms10 = AssetDatabase.LoadAssetAtPath<TextAsset>(Captured + "eid4518_uniforms10.bytes");
        inputs.motion210525 = AssetDatabase.LoadAssetAtPath<Texture>(Motion210525Path);
        inputs.history209486 = AssetDatabase.LoadAssetAtPath<Texture>(History209486Path);
        inputs.uniforms8 = AssetDatabase.LoadAssetAtPath<TextAsset>(Captured + "eid4522_uniforms8.bytes");
        inputs.uniforms6Contact = AssetDatabase.LoadAssetAtPath<TextAsset>(Captured + "eid4594_uniforms6.bytes");
        inputs.uniforms11Contact = AssetDatabase.LoadAssetAtPath<TextAsset>(Captured + "eid4594_uniforms11.bytes");
        EditorUtility.SetDirty(inputs);
        AssetDatabase.SaveAssets();
        Debug.Log("[Endfield CP2] Inputs refreshed. AO=" + Name(inputs.aoFull)
                  + " SSR=" + Name(inputs.ssrColor)
                  + " Mask=" + Name(inputs.ssrMask)
                  + " Contact=" + Name(inputs.contact)
                  + " Depth535=" + Name(inputs.depthFull209535)
                  + " Depth543=" + Name(inputs.depthFull209543)
                  + " u14=" + (inputs.uniforms14 != null ? inputs.uniforms14.bytes.Length.ToString() : "<null>")
                  + " u14Down=" + (inputs.uniforms14Down != null ? inputs.uniforms14Down.bytes.Length.ToString() : "<null>")
                  + " u6=" + (inputs.uniforms6 != null ? inputs.uniforms6.bytes.Length.ToString() : "<null>")
                  + " u11=" + (inputs.uniforms11 != null ? inputs.uniforms11.bytes.Length.ToString() : "<null>")
                  + " OctN=" + Name(inputs.octNormal209566)
                  + " u5=" + (inputs.uniforms5 != null ? inputs.uniforms5.bytes.Length.ToString() : "<null>")
                  + " u10=" + (inputs.uniforms10 != null ? inputs.uniforms10.bytes.Length.ToString() : "<null>")
                  + " Mot=" + Name(inputs.motion210525)
                  + " Hist=" + Name(inputs.history209486)
                  + " u8=" + (inputs.uniforms8 != null ? inputs.uniforms8.bytes.Length.ToString() : "<null>")
                  + " u6C=" + (inputs.uniforms6Contact != null ? inputs.uniforms6Contact.bytes.Length.ToString() : "<null>")
                  + " u11C=" + (inputs.uniforms11Contact != null ? inputs.uniforms11Contact.bytes.Length.ToString() : "<null>"));
    }

    [MenuItem("Tools/Endfield CP2/Install Baseline On Combined Renderer")]
    public static void InstallOnCombined()
    {
        RefreshInputs();
        UniversalRendererData renderer = AssetDatabase.LoadAssetAtPath<UniversalRendererData>(CombinedRenderer);
        if (renderer == null)
        {
            Debug.LogError("[Endfield CP2] Missing renderer: " + CombinedRenderer);
            return;
        }

        EndfieldCP2ExactReplayInputs inputs = AssetDatabase.LoadAssetAtPath<EndfieldCP2ExactReplayInputs>(InputsPath);
        SerializedObject so = new SerializedObject(renderer);
        SerializedProperty features = so.FindProperty("m_RendererFeatures");
        EndfieldCP2ExactReplayFeature existing = FindFeature(features);
        if (existing == null)
        {
            existing = ScriptableObject.CreateInstance<EndfieldCP2ExactReplayFeature>();
            existing.name = "EndfieldCP2ExactReplayFeature";
            AssetDatabase.AddObjectToAsset(existing, renderer);
            features.arraySize++;
            features.GetArrayElementAtIndex(features.arraySize - 1).objectReferenceValue = existing;
        }

        existing.settings.inputs = inputs;
        existing.settings.hizBuild = AssetDatabase.LoadAssetAtPath<ComputeShader>(HiZShaderPath);
        existing.settings.hizDown = AssetDatabase.LoadAssetAtPath<ComputeShader>(HiZDownShaderPath);
        existing.settings.linDepth = AssetDatabase.LoadAssetAtPath<ComputeShader>(LinDepthShaderPath);
        existing.settings.gtao = AssetDatabase.LoadAssetAtPath<ComputeShader>(GtaoShaderPath);
        existing.settings.aoTemporal = AssetDatabase.LoadAssetAtPath<ComputeShader>(AoTemporalShaderPath);
        existing.settings.aoBlur = AssetDatabase.LoadAssetAtPath<ComputeShader>(AoBlurShaderPath);
        existing.settings.aoBlur2 = AssetDatabase.LoadAssetAtPath<ComputeShader>(AoBlur2ShaderPath);
        existing.settings.contactShadow = AssetDatabase.LoadAssetAtPath<ComputeShader>(ContactShadowShaderPath);
        existing.settings.injectionPoint = RenderPassEvent.AfterRenderingGbuffer;
        existing.settings.renderInGameView = true;
        existing.settings.renderInSceneView = true;
        existing.settings.enabledForCamera = true;
        existing.settings.debugPreview = EndfieldCP2ExactReplayFeature.DebugPreview.AO;
        existing.settings.cameraNameContains = "";
        existing.settings.hizDepthSource = EndfieldCP2ExactReplayFeature.HiZDepthSource.Captured209535;
        EditorUtility.SetDirty(existing);
        so.ApplyModifiedPropertiesWithoutUndo();
        EditorUtility.SetDirty(renderer);
        AssetDatabase.SaveAssets();
        Debug.Log("[Endfield CP2] Feature on EID3332Combined-Renderer. Frame Debugger: Baseline + EID4486 mip0 + EID4490-4510 mip1-6 + EID4514 LinDepth + EID4518 GTAO + EID4522 Temporal + EID4526 Blur + EID4530 Blur2 + EID4594 Contact.");
    }

    static EndfieldCP2ExactReplayFeature FindFeature(SerializedProperty features)
    {
        for (int i = 0; i < features.arraySize; ++i)
        {
            EndfieldCP2ExactReplayFeature feature =
                features.GetArrayElementAtIndex(i).objectReferenceValue as EndfieldCP2ExactReplayFeature;
            if (feature != null)
                return feature;
        }
        return null;
    }

    static EndfieldCP2ExactReplayInputs LoadOrCreateInputs()
    {
        EndfieldCP2ExactReplayInputs inputs = AssetDatabase.LoadAssetAtPath<EndfieldCP2ExactReplayInputs>(InputsPath);
        if (inputs != null)
            return inputs;
        inputs = ScriptableObject.CreateInstance<EndfieldCP2ExactReplayInputs>();
        AssetDatabase.CreateAsset(inputs, InputsPath);
        return inputs;
    }

    static Texture LoadTex(string stem)
    {
        return AssetDatabase.LoadAssetAtPath<Texture>(Imported + stem + ".asset");
    }

    static string Name(Object obj) => obj != null ? obj.name : "<null>";
}
#endif
