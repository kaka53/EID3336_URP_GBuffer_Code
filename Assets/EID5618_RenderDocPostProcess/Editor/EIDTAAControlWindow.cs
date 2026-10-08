#if UNITY_EDITOR
using System;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering.Universal;

public sealed class EIDTAAControlWindow : EditorWindow
{
    const string RendererPath="Assets/EID3332_EID3336_Combined/Settings/EID3332Combined-Renderer.asset";
    const string ProfilePath="Assets/EID5618_RenderDocPostProcess/Materials/EID5618_InputProfile.asset";
    const string ToggleMenu="EID3332-EID3336/TAA/Enable TAA (Game Only)";
    UniversalRendererData rendererData;
    EID5537FixedFrameRendererFeature taa;
    EID5618InputProfile profile;
    string error;

    [MenuItem("EID3332-EID3336/TAA/Control Panel")]
    public static void Open() { var window=GetWindow<EIDTAAControlWindow>("TAA 控制");window.minSize=new Vector2(370,180);window.Show(); }
    [MenuItem(ToggleMenu)]
    static void Toggle()
    {
        var w=CreateInstance<EIDTAAControlWindow>();
        try { if(!w.Resolve())throw new InvalidOperationException(w.error);w.Apply(!w.Enabled); }
        finally {DestroyImmediate(w);}
    }
    [MenuItem(ToggleMenu,true)]
    static bool ValidateToggle()
    {
        var renderer=AssetDatabase.LoadAssetAtPath<UniversalRendererData>(RendererPath);
        var p=AssetDatabase.LoadAssetAtPath<EID5618InputProfile>(ProfilePath);
        EID5537FixedFrameRendererFeature f=null;
        if(renderer!=null)foreach(var item in renderer.rendererFeatures)if(item is EID5537FixedFrameRendererFeature t){f=t;break;}
        Menu.SetChecked(ToggleMenu,f!=null && f.isActive && f.settings.enabledForCamera && p!=null && p.res9Source==EID5618InputProfile.Res9SourceMode.EID5537RenderFeature);
        return f!=null && p!=null;
    }
    bool Resolve()
    {
        if(rendererData==null)rendererData=AssetDatabase.LoadAssetAtPath<UniversalRendererData>(RendererPath);
        if(profile==null)profile=AssetDatabase.LoadAssetAtPath<EID5618InputProfile>(ProfilePath);
        if(taa==null && rendererData!=null)foreach(var f in rendererData.rendererFeatures)if(f is EID5537FixedFrameRendererFeature t){taa=t;break;}
        error=taa==null || profile==null ? "未找到 EID3336 Renderer 或 EID5618 输入配置。" : null;
        return error==null;
    }
    bool Enabled => taa!=null && taa.isActive && taa.settings.enabledForCamera && profile!=null && profile.res9Source==EID5618InputProfile.Res9SourceMode.EID5537RenderFeature;
    void OnGUI()
    {
        EditorGUILayout.LabelField("EID3336 · Game TAA",EditorStyles.boldLabel);
        if(!Resolve()){EditorGUILayout.HelpBox(error,MessageType.Error);return;}
        EditorGUI.BeginChangeCheck();
        bool enabled=EditorGUILayout.ToggleLeft("启用 TAA（仅 Game）",Enabled,EditorStyles.boldLabel);
        if(EditorGUI.EndChangeCheck())Apply(enabled);
        EditorGUILayout.HelpBox(Enabled ? "已开启：5519 → 5528 → 5537 → 后处理。Scene 不启用 TAA。" : "已关闭：后处理直接读取相机颜色，TAA 辅助绘制停止。",MessageType.Info);
        EditorGUILayout.LabelField("设置自动保存，重启工程后保留。",EditorStyles.wordWrappedLabel);
        using(new EditorGUI.DisabledScope(!Enabled))if(GUILayout.Button("重置 TAA 历史")){taa.ResetColorHistory();RepaintViews();}
    }
    void Apply(bool enabled)
    {
        // Deliberately avoid changing capture constants, shaders, camera transform or scene.
        // Explicit persistence also applies when using this switch during Play mode.
        taa.SetTAAEnabled(enabled);
        profile.res9Source=enabled ? EID5618InputProfile.Res9SourceMode.EID5537RenderFeature : EID5618InputProfile.Res9SourceMode.LiveCameraColor;
        EditorUtility.SetDirty(taa);EditorUtility.SetDirty(profile);EditorUtility.SetDirty(rendererData);
        AssetDatabase.SaveAssetIfDirty(taa);AssetDatabase.SaveAssetIfDirty(profile);AssetDatabase.SaveAssetIfDirty(rendererData);
        RepaintViews();Repaint();
        Debug.Log("[TAA] "+(enabled?"Enabled for Game; history reset.":"Disabled; temporal RTs released; live camera color selected."));
    }
    static void RepaintViews()
    {
        SceneView.RepaintAll();EditorApplication.QueuePlayerLoopUpdate();
        foreach(var window in Resources.FindObjectsOfTypeAll<EditorWindow>())if(window.GetType().Name=="GameView")window.Repaint();
    }
}
#endif
