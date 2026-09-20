using System.Reflection;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering.Universal;

internal static class EID4662ComputePass2Setup
{
    const string Root = "Assets/EID4662_ComputePass2/Shaders/";
    const string RendererPath = "Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-Renderer.asset";
    const string CapturedResourcesPath = "Assets/EID4662_ComputePass2/Settings/EID4662ComputePass2CapturedResources.asset";

    [MenuItem("EID4662/Compute Pass 2/Create Settings Asset")]
    public static void CreateSettingsAsset()
    {
        const string path = "Assets/EID4662_ComputePass2/Settings/EID4662ComputePass2Settings.asset";
        var existing = AssetDatabase.LoadAssetAtPath<EID4662ComputePass2Settings>(path);
        if (existing != null) { Selection.activeObject = existing; return; }
        var asset = ScriptableObject.CreateInstance<EID4662ComputePass2Settings>();
        AssetDatabase.CreateAsset(asset, path);
        AssetDatabase.SaveAssets();
        Selection.activeObject = asset;
    }

    [MenuItem("EID4662/Compute Pass 2/Create RenderDoc Resources Asset")]
    public static void CreateCapturedResourcesAsset()
    {
        var existing = AssetDatabase.LoadAssetAtPath<EID4662ComputePass2CapturedResources>(CapturedResourcesPath);
        if (existing != null) { Selection.activeObject = existing; return; }
        var asset = ScriptableObject.CreateInstance<EID4662ComputePass2CapturedResources>();
        AssetDatabase.CreateAsset(asset, CapturedResourcesPath);
        AssetDatabase.SaveAssets();
        Selection.activeObject = asset;
        Debug.Log("已创建 RenderDoc 资源清单。请把 F:/endfield06.rdc 导出的资源逐项拖入；不完整时 Feature 会停止，不会回退 Camera Color。");
    }

    [MenuItem("EID4662/Compute Pass 2/Add Feature To Selected Renderer")]
    public static void AddFeatureToSelectedRenderer()
    {
        var renderer = Selection.activeObject as UniversalRendererData;
        if (renderer == null)
        {
            Debug.LogError("请选择一个 UniversalRendererData 资源后再执行 EID4662/Compute Pass 2/Add Feature To Selected Renderer。");
            return;
        }
        AddFeatureToRenderer(renderer);
    }

    public static void InstallToDefaultRenderer()
    {
        var renderer = AssetDatabase.LoadAssetAtPath<UniversalRendererData>(RendererPath);
        if (renderer == null)
        {
            Debug.LogError("找不到目标 RendererData: " + RendererPath);
            return;
        }
        CreateSettingsAsset();
        CreateCapturedResourcesAsset();
        AddFeatureToRenderer(renderer);
    }

    static void AddFeatureToRenderer(UniversalRendererData renderer)
    {
        foreach (var existing in renderer.rendererFeatures)
        {
            if (existing is EID4662ComputePass2RenderFeature)
            {
                var existingSO = new SerializedObject(existing);
                Assign(existingSO.FindProperty("settings").FindPropertyRelative("capturedResources"), CapturedResourcesPath);
                existingSO.ApplyModifiedPropertiesWithoutUndo();
                EditorUtility.SetDirty(existing);
                EditorUtility.SetDirty(renderer);
                AssetDatabase.SaveAssets();
                Debug.Log("EID4662 Compute Pass #2 已存在；已绑定独立 RenderDoc 资源清单。");
                return;
            }
        }

        var feature = ScriptableObject.CreateInstance<EID4662ComputePass2RenderFeature>();
        feature.name = "EID4662ComputePass2RenderFeature";
        var featureSO = new SerializedObject(feature);
        var settings = featureSO.FindProperty("settings");
        Assign(settings.FindPropertyRelative("capturedResources"), CapturedResourcesPath);
        AssignCompute(settings.FindPropertyRelative("prepare4542"), "EID4542_Prepare.compute");
        AssignCompute(settings.FindPropertyRelative("prepare4546"), "EID4546_Prepare.compute");
        AssignCompute(settings.FindPropertyRelative("prepare4550"), "EID4550_Prepare.compute");
        AssignCompute(settings.FindPropertyRelative("seed4554"), "EID4554_SeedA.compute");
        AssignCompute(settings.FindPropertyRelative("seed4558"), "EID4558_SeedB.compute");
        AssignCompute(settings.FindPropertyRelative("iterate4562"), "EID4562_Iterate.compute");
        AssignCompute(settings.FindPropertyRelative("build4586"), "EID4586_BuildRes18.compute");
        AssignCompute(settings.FindPropertyRelative("build4590"), "EID4590_BuildRes19.compute");
        AssignCompute(settings.FindPropertyRelative("build4594"), "EID4594_BuildRes33.compute");
        featureSO.ApplyModifiedPropertiesWithoutUndo();

        AssetDatabase.AddObjectToAsset(feature, renderer);
        var rendererSO = new SerializedObject(renderer);
        var features = rendererSO.FindProperty("m_RendererFeatures");
        int index = features.arraySize;
        features.InsertArrayElementAtIndex(index);
        features.GetArrayElementAtIndex(index).objectReferenceValue = feature;
        rendererSO.ApplyModifiedPropertiesWithoutUndo();
        RefreshFeatureMap(renderer);
        EditorUtility.SetDirty(feature);
        EditorUtility.SetDirty(renderer);
        AssetDatabase.SaveAssets();
        AssetDatabase.ImportAsset(AssetDatabase.GetAssetPath(renderer));
        Debug.Log("已添加 EID4662 Compute Pass #2：RenderDoc 资源清单 + 14 次 dispatch + 独立 Debug RT；未修改原有 GBuffer/B6/Controller。");
    }

    static void RefreshFeatureMap(UniversalRendererData renderer)
    {
        var method = typeof(ScriptableRendererData).GetMethod("ValidateRendererFeatures", BindingFlags.Instance | BindingFlags.NonPublic);
        if (method != null) method.Invoke(renderer, null);
    }

    static void Assign(SerializedProperty property, string assetPath)
    {
        if (property == null) return;
        property.objectReferenceValue = AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(assetPath);
    }

    static void AssignCompute(SerializedProperty property, string fileName)
    {
        if (property == null) return;
        property.objectReferenceValue = AssetDatabase.LoadAssetAtPath<ComputeShader>(Root + fileName);
    }
}

