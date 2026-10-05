#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering.Universal;
public static class EID4613ColourPass16Setup
{
    public const string RendererPath = "Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-Renderer.asset";
    [MenuItem("Window/RenderDoc/安装 Colour Pass 16 到当前还原 Renderer")]
    public static void Install()
    {
        var data = AssetDatabase.LoadAssetAtPath<UniversalRendererData>(RendererPath);
        if (!data) throw new System.Exception("Missing reconstruction Renderer");
        EID4613ColourPass16Feature feature = null;
        foreach (var item in data.rendererFeatures) if (item is EID4613ColourPass16Feature cp16) feature = cp16;
        if (!feature)
        {
            feature = ScriptableObject.CreateInstance<EID4613ColourPass16Feature>();
            feature.name = "EID4613 Colour Pass 16 Capsule SH";
            AssetDatabase.AddObjectToAsset(feature, data); data.rendererFeatures.Add(feature);
        }
        // Preserve all other feature settings. Give dependent passes explicit order, not list-order ties.
        foreach (var item in data.rendererFeatures)
            if (item is EID4649ColourPass20Feature cp20) { cp20.settings.injectionPoint = (RenderPassEvent)222; EditorUtility.SetDirty(cp20); }
        var serialized = new SerializedObject(data);
        var map = serialized.FindProperty("m_RendererFeatureMap");
        map.arraySize = data.rendererFeatures.Count;
        for (int i = 0; i < data.rendererFeatures.Count; ++i)
        {
            AssetDatabase.TryGetGUIDAndLocalFileIdentifier(data.rendererFeatures[i], out string guid, out long id);
            map.GetArrayElementAtIndex(i).longValue = id;
        }
        serialized.ApplyModifiedPropertiesWithoutUndo();
        data.SetDirty(); EditorUtility.SetDirty(data); AssetDatabase.SaveAssets();
    }
}
public sealed class EID4613ColourPass16Window : EditorWindow
{
    Camera camera;
    bool flipPreviewY = true;
    double nextPreviewRepaint;
    [MenuItem("Window/RenderDoc/Colour Pass 16 输出 RT")]
    public static void Open()
    {
        var window = GetWindow<EID4613ColourPass16Window>("Colour Pass 16 RT");
        var ctl = Object.FindObjectOfType<EID3332CombinedDeferredController>();
        if (ctl) window.camera = ctl.targetCamera;
    }
    void OnEnable()
    {
        minSize = new Vector2(430, 500);
        EditorApplication.update -= RepaintPreview;
        EditorApplication.update += RepaintPreview;
    }
    void OnDisable() { EditorApplication.update -= RepaintPreview; }
    void RepaintPreview()
    {
        // Inspect an existing output only; never drive rendering at the editor update rate.
        if (EditorApplication.isCompiling || EditorApplication.isUpdating
            || EditorApplication.timeSinceStartup < nextPreviewRepaint) return;
        nextPreviewRepaint = EditorApplication.timeSinceStartup + 0.2;
        if (EID4613ColourPass16Feature.TryGetOutput(camera, out _)) Repaint();
    }
    void OnGUI()
    {
        EditorGUILayout.LabelField("EID4613 · 胶囊方向性 SH 遮蔽", EditorStyles.boldLabel);
        camera = (Camera)EditorGUILayout.ObjectField("相机", camera, typeof(Camera), true);
        using (new EditorGUILayout.HorizontalScope())
        {
            if (GUILayout.Button("Game 相机")) { var ctl=Object.FindObjectOfType<EID3332CombinedDeferredController>(); if(ctl) camera=ctl.targetCamera; }
            if (GUILayout.Button("Scene 相机") && SceneView.lastActiveSceneView) camera=SceneView.lastActiveSceneView.camera;
        }
        if (!EID4613ColourPass16Feature.TryGetOutput(camera, out var rt))
        { EditorGUILayout.HelpBox("请选择相机并让该视口渲染。需要 FiveMRT 与 Colour Pass 16 Feature 启用；不会显示其它视口的旧 RT。", MessageType.Info); return; }
        EditorGUILayout.ObjectField("输出 RGBA16F", rt, typeof(RenderTexture), false);
        EID4613ColourPass16Feature.TryGetInputs(camera, out var depth, out var rt3);
        EditorGUILayout.ObjectField("输入 Depth", depth, typeof(Texture), false);
        EditorGUILayout.ObjectField("输入 RenderGBuffer RT3", rt3, typeof(Texture), false);
        EditorGUILayout.LabelField(rt.width + " × " + rt.height + " · 每相机独立输出");
        EditorGUILayout.HelpBox("RGBA 是含负数的 SH 系数，不是最终光照颜色。此处原始 RGB 预览会截断负值；导出 EXR 保留 RGBA 浮点数据。捕获的 30 个胶囊参数暂为静态，不会自动跟随角色骨骼动画。", MessageType.None);
        if (GUILayout.Button("导出当前 RT（EXR，保存到 D 盘）"))
        {
            string path=EditorUtility.SaveFilePanel("导出 Colour Pass 16", "D:/endcopy", "ColourPass16", "exr");
            if (!string.IsNullOrEmpty(path)) Export(rt,path);
        }
        flipPreviewY = EditorGUILayout.Toggle("翻转预览 Y（不改变 RT）", flipPreviewY);
        var rect=GUILayoutUtility.GetAspectRect((float)rt.width/rt.height);
        GUI.DrawTextureWithTexCoords(rect, rt, flipPreviewY ? new Rect(0,1,1,-1) : new Rect(0,0,1,1), false);
    }
    static void Export(RenderTexture rt,string path)
    {
        var old=RenderTexture.active; var cpu=new Texture2D(rt.width,rt.height,TextureFormat.RGBAFloat,false,true);
        try { RenderTexture.active=rt;cpu.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0);cpu.Apply();System.IO.File.WriteAllBytes(path,cpu.EncodeToEXR(Texture2D.EXRFlags.OutputAsFloat)); }
        finally { RenderTexture.active=old;Object.DestroyImmediate(cpu); }
    }
}
#endif
