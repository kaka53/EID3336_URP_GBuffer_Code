#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering.Universal;

public static class EID5618ComputePass3Setup
{
    const string RendererPath = "Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-Renderer.asset";
    const string InputsPath = "Assets/EID5618_RenderDocPostProcess/ComputePass3/EID5618_ComputePass3Inputs.asset";
    const string Captured = "Assets/EID5618_RenderDocPostProcess/CapturedInputs/ComputePass3/";
    const string ShaderRoot = "Assets/EID5618_RenderDocPostProcess/ComputePass3/Shaders/";

    [MenuItem("Tools/EID5618 Combined/Assign ComputePass3")]
    public static void Assign()
    {
        EID5618ComputePass3Inputs inputs = AssetDatabase.LoadAssetAtPath<EID5618ComputePass3Inputs>(InputsPath);
        if (inputs == null)
        {
            inputs = ScriptableObject.CreateInstance<EID5618ComputePass3Inputs>();
            AssetDatabase.CreateAsset(inputs, InputsPath);
        }

        inputs.hdr210447 = AssetDatabase.LoadAssetAtPath<Texture>("Assets/EID5618_RenderDocPostProcess/CapturedInputs/UnityNative/res9.asset");
        inputs.uniforms5_3200 = LoadBytes("eid5542_uniforms5_3200.bytes");
        inputs.uniforms13_64 = LoadBytes("eid5542_uniforms13_64.bytes");
        inputs.down5546 = LoadBytes("eid5546_uniforms13_16.bytes");
        inputs.down5550 = LoadBytes("eid5550_uniforms13_16.bytes");
        inputs.down5554 = LoadBytes("eid5554_uniforms13_16.bytes");
        inputs.down5558 = LoadBytes("eid5558_uniforms13_16.bytes");
        inputs.down5562 = LoadBytes("eid5562_uniforms13_16.bytes");
        inputs.down5566 = LoadBytes("eid5566_uniforms13_16.bytes");
        inputs.down5570 = LoadBytes("eid5570_uniforms13_16.bytes");
        inputs.up5574 = LoadBytes("eid5574_uniforms12_48.bytes");
        inputs.up5578 = LoadBytes("eid5578_uniforms12_48.bytes");
        inputs.up5582 = LoadBytes("eid5582_uniforms12_48.bytes");
        inputs.up5586 = LoadBytes("eid5586_uniforms12_48.bytes");
        inputs.up5590 = LoadBytes("eid5590_uniforms12_48.bytes");
        inputs.up5594 = LoadBytes("eid5594_uniforms12_48.bytes");
        inputs.up5598 = LoadBytes("eid5598_uniforms12_48.bytes");
        EditorUtility.SetDirty(inputs);

        UniversalRendererData renderer = AssetDatabase.LoadAssetAtPath<UniversalRendererData>(RendererPath);
        if (renderer == null)
        {
            Debug.LogError("[EID5618 CP3] Renderer not found: " + RendererPath);
            return;
        }

        EID5618ComputePass3Feature feature = null;
        var features = renderer.rendererFeatures;
        for (int i0 = 0; i0 < features.Count; i0++)
        {
            feature = features[i0] as EID5618ComputePass3Feature;
            if (feature != null)
                break;
        }
        if (feature == null)
        {
            Debug.LogError("[EID5618 CP3] Feature missing on EID3332Combined-Renderer. Reimport the renderer YAML.");
            return;
        }

        feature.settings.threshold5542 = AssetDatabase.LoadAssetAtPath<ComputeShader>(ShaderRoot + "EID5542_Threshold.compute");
        feature.settings.downsample5546 = AssetDatabase.LoadAssetAtPath<ComputeShader>(ShaderRoot + "EID5546_Downsample.compute");
        feature.settings.upsample5574 = AssetDatabase.LoadAssetAtPath<ComputeShader>(ShaderRoot + "EID5574_Upsample.compute");
        feature.settings.inputs = inputs;
        feature.settings.injectionPoint = (RenderPassEvent)550;
        feature.settings.publishGlobalRes10 = true;
        EditorUtility.SetDirty(feature);
        EditorUtility.SetDirty(renderer);
        AssetDatabase.SaveAssets();
        Debug.Log("[EID5618 CP3] Assigned shaders/inputs. hdr=" + (inputs.hdr210447 != null ? inputs.hdr210447.name : "<null>")
                  + " u5=" + Size(inputs.uniforms5_3200)
                  + " thresh=" + (feature.settings.threshold5542 != null)
                  + " down=" + (feature.settings.downsample5546 != null)
                  + " up=" + (feature.settings.upsample5574 != null));
    }

    static TextAsset LoadBytes(string fileName)
    {
        return AssetDatabase.LoadAssetAtPath<TextAsset>(Captured + fileName);
    }

    static string Size(TextAsset asset) => asset != null ? asset.bytes.Length.ToString() : "<null>";
}
#endif
