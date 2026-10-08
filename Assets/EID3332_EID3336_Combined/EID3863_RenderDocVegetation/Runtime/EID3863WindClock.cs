using UnityEngine;
using UnityEngine.Rendering;
#if UNITY_EDITOR
using UnityEditor;
#endif

// A single shared time source. Never advance time in beginCameraRendering.
public static class EID3863WindClock
{
    static readonly int Times = Shader.PropertyToID("_EID3863WindTimes");
    static double epoch;
    static float previous;
    static int lastFrame = -1;
    static bool runtimeDomain;
#if UNITY_EDITOR
    static double nextRepaint;
    const string PreviewKey = "EID3863.WindPreview.Enabled";
    const string PreviewMenu = "EID3332-EID3336/EID3863/Enable Editor Wind Preview";
    [MenuItem(PreviewMenu)]
    static void ToggleEditorPreview()
    {
        SessionState.SetBool(PreviewKey, !SessionState.GetBool(PreviewKey, false));
        Reset();
    }
    [MenuItem(PreviewMenu, true)]
    static bool ValidateEditorPreview()
    {
        Menu.SetChecked(PreviewMenu, SessionState.GetBool(PreviewKey, false));
        return true;
    }
    static readonly string[] MaterialPaths = new[] {
        "Assets/EID3332_EID3336_Combined/EID3863_RenderDocVegetation/Materials/EID3863_Vegetation_PS215850.mat",
        "Assets/ColourPass6_VS215849_PS215850_Batch/Materials/EID3875_VS215849_PS215850.mat",
        "Assets/ColourPass6_VS215851_PS215852_Batch/Materials/EID3885_VS215851_PS215852.mat",
        "Assets/ColourPass6_VS215851_PS215852_Batch/Materials/EID3895_VS215851_PS215852.mat",
        "Assets/ColourPass6_VS215847_PS215848_Batch/Materials/EID3858_VS215847_PS215848.mat"
    };
    static readonly Material[] editorMaterials = new Material[MaterialPaths.Length];
    [InitializeOnLoadMethod]
    static void InitializeEditor()
    {
        Reset();
        EditorApplication.update -= EditorTick;
        EditorApplication.update += EditorTick;
    }
    static void EditorTick()
    {
        if (Application.isPlaying || EditorApplication.isCompiling || EditorApplication.isUpdating) return;
        // Do not force both viewports to render continuously during startup.
        // Runtime wind is unaffected; editor animation is opt-in per session.
        if (!SessionState.GetBool(PreviewKey, false)) return;
        double now = EditorApplication.timeSinceStartup;
        if (now < nextRepaint) return;
        nextRepaint = now + 1.0 / 15.0;
        Publish(now);
        bool animate = false;
        for (int i=0; i<MaterialPaths.Length; i++) {
            if (!editorMaterials[i]) editorMaterials[i]=AssetDatabase.LoadAssetAtPath<Material>(MaterialPaths[i]);
            if (editorMaterials[i] && editorMaterials[i].GetFloat("_EID3863WindEnabled")>.5f) animate=true;
        }
        if (!animate) return;
        SceneView.RepaintAll();
        EditorApplication.QueuePlayerLoopUpdate();
        foreach (var window in Resources.FindObjectsOfTypeAll<EditorWindow>())
            if (window.GetType().Name == "GameView") window.Repaint();
    }
    [MenuItem("EID3332-EID3336/EID3863/Reset Shared Wind Clock")]
#endif
    public static void Reset()
    {
        epoch = Now(); previous = 0; lastFrame = -1; runtimeDomain = Application.isPlaying;
        Shader.SetGlobalVector(Times, Vector4.zero);
    }
    static double Now()
    {
#if UNITY_EDITOR
        if (!Application.isPlaying) return EditorApplication.timeSinceStartup;
#endif
        return Time.timeAsDouble;
    }
    [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
    static void InitializeRuntime()
    {
        Reset();
        RenderPipelineManager.beginFrameRendering -= BeginFrame;
        RenderPipelineManager.beginFrameRendering += BeginFrame;
    }
    static void BeginFrame(ScriptableRenderContext context, Camera[] cameras)
    {
        if (!Application.isPlaying || lastFrame == Time.frameCount) return;
        lastFrame = Time.frameCount; Publish(Now());
    }
    static void Publish(double now)
    {
        // Returning from Play mode switches clock domains; restart coherently.
        if (runtimeDomain != Application.isPlaying || now < epoch) { epoch = now; previous = 0; runtimeDomain = Application.isPlaying; }
        float current = (float)(now - epoch);
        Shader.SetGlobalVector(Times, new Vector4(current, previous, 0, 0));
        previous = current;
    }
}
