#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;

public sealed class EID4662LightingStageWindow : EditorWindow
{
    EID3332CombinedDeferredController controller;
    Vector2 scroll;
    static readonly string[] Notes = {
        "关闭阶段预览，恢复原始光照与混合方式。",
        "材质遮罩处理后的基础色，不含光照。",
        "世界空间法线映射到 0～1 RGB。",
        "4662：R=金属度；4666：R=解码后的透射强度。G=粗糙度，B=材质 AO。",
        "视空间线性深度 / 深度白色距离。",
        "主光 BRDF 结果，未乘 _29 阴影/LUT 和 _33 可见度；完全阴影处也单独计算供预览。",
        "_29 有效采样值：主光阴影可见度。不是反射探针有效性。",
        "_33 有效采样值：主光接触/可见度调制。",
        "主光经过 _29 和 _33 处理后的实际贡献。",
        "实际间接漫反射遮蔽，包含材质颜色相关补偿。",
        "实际间接高光遮蔽，取决于 AO、粗糙度和 N·V。",
        "三级体积 GI 与环境 SH 合成后，屏幕方向遮挡调制之前；尚未乘基础色/AO。",
        "屏幕 SH 调制后的正面辐照度；尚未乘基础色/AO。",
        "实际间接漫反射贡献；4666 为正面 + 背面透光间接漫反射之和。",
        "局部/全局反射探针混合与强度处理后，尚未乘环境 BRDF。",
        "屏幕高光分支启用时的颜色；分支关闭显示黑色。",
        "屏幕高光实际混合权重；分支关闭为 0。",
        "屏幕高光与探针反射混合后，尚未乘 BRDF/高光遮蔽。",
        "混合反射 × 环境 BRDF/能量补偿 × 高光遮蔽。",
        "间接漫反射 + 间接高光。",
        "主光 + 间接漫反射，暂不叠加间接高光。",
        "主光 + 间接漫反射 + 间接高光；没有本 Pass 的雾。",
        "总 RGB 透射率，白色为无衰减，黑色为完全遮蔽。",
        "最终 RGB 减去被雾衰减的表面光；只看雾/大气散射贡献。",
        "所选 Pass 最终 RGB，但不混入已有目标颜色；区别于 0 的完整正常画面。",
        "各自的环境 BRDF 响应；4662 为能量补偿前，4666 使用植被专用 F0/拟合。",
        "4666 薄叶背光透射分项，包含太阳颜色与植被权重，未乘阴影。4662 不适用，保持正常画面。",
        "4666 包裹光照分项，包含太阳颜色与植被权重，未乘阴影。4662 不适用，保持正常画面。",
        "4666 正面 SH × 基础色 × 间接光强度 × 漫反射遮蔽。4662 不适用。",
        "4666 背面 SH × 透射参数/归一化基础色 × AO，是间接漫反射的背面贡献。4662 不适用。"
    };

    [MenuItem("Window/RenderDoc/延迟光照阶段查看器（4662 + 4666）")]
    [MenuItem("Window/RenderDoc/EID4662 光照阶段查看器")]
    public static void Open() { GetWindow<EID4662LightingStageWindow>("延迟光照阶段"); }
    void OnEnable() { minSize = new Vector2(400, 370); FindController(); }
    void FindController()
    {
        var selected = Selection.activeGameObject;
        if (selected != null) controller = selected.GetComponent<EID3332CombinedDeferredController>();
        if (controller == null) controller = Object.FindObjectOfType<EID3332CombinedDeferredController>();
    }
    void OnGUI()
    {
        scroll = EditorGUILayout.BeginScrollView(scroll);
        EditorGUILayout.LabelField("延迟光照阶段查看 · 4662 / 4666", EditorStyles.boldLabel);
        controller = (EID3332CombinedDeferredController)EditorGUILayout.ObjectField("场景控制器", controller, typeof(EID3332CombinedDeferredController), true);
        if (controller == null)
        {
            EditorGUILayout.HelpBox("请打开还原场景，或指定 EID3332CombinedDeferredController。", MessageType.Info);
            if (GUILayout.Button("查找场景控制器")) FindController();
            EditorGUILayout.EndScrollView(); return;
        }
        var serialized = new SerializedObject(controller);
        serialized.Update();
        var stage = serialized.FindProperty("eid4662LightingStage");
        EditorGUI.BeginChangeCheck();
        EditorGUILayout.PropertyField(serialized.FindProperty("deferredStageTarget"), new GUIContent("作用对象"));
        EditorGUILayout.PropertyField(stage, new GUIContent("查看阶段"));
        EditorGUILayout.PropertyField(serialized.FindProperty("eid4662StageCameraScope"), new GUIContent("显示范围"));
        EditorGUILayout.PropertyField(serialized.FindProperty("eid4662StageExposureEV"), new GUIContent("光照预览曝光 EV"));
        EditorGUILayout.PropertyField(serialized.FindProperty("eid4662StageDepthRange"), new GUIContent("深度白色距离"));
        bool changed = EditorGUI.EndChangeCheck();
        EditorGUILayout.BeginHorizontal();
        if (GUILayout.Button("上一阶段")) { stage.intValue = Mathf.Max(0, stage.intValue - 1); changed = true; }
        if (GUILayout.Button("下一阶段")) { stage.intValue = Mathf.Min(Notes.Length - 1, stage.intValue + 1); changed = true; }
        EditorGUILayout.EndHorizontal();
        if (GUILayout.Button("恢复最终画面（关闭调试）")) { stage.intValue = 0; changed = true; }
        int index = Mathf.Clamp(stage.intValue, 0, Notes.Length - 1);
        EditorGUILayout.HelpBox(Notes[index], MessageType.Info);
        if (stage.intValue >= 26)
            EditorGUILayout.HelpBox("植被专属项目：仅 4666 有对应计算；4662 保持正常画面。若作用对象为仅普通表面，将不显示阶段预览。", MessageType.Info);
        if (controller.lightPassMode != EID3332CombinedDeferredController.LightPassMode.EID4662Full)
        {
            EditorGUILayout.HelpBox("当前不是 EID4662Full 路径，普通表面阶段预览不生效；4666 还需启用独立植被 Feature。", MessageType.Warning);
            if (GUILayout.Button("切换到 EID4662Full")) { serialized.FindProperty("lightPassMode").intValue = 1; changed = true; }
        }
        if (!controller.enableB6Lighting || !controller.enabled || !controller.gameObject.activeInHierarchy)
            EditorGUILayout.HelpBox("控制器或光照已禁用，需要启用后才能查看。", MessageType.Warning);
        EditorGUILayout.HelpBox("按作用对象替换 4662 / 4666 各自覆盖区域。4666 需要植被 Feature 启用。角色前向和后处理仍正常执行，因此不是未经后处理的原始缓冲。\n不会强制打开缺失的 GI/屏幕反射，也不会清除现有诊断参数。曝光仅作用于光照颜色预览。", MessageType.None);
        if (serialized.ApplyModifiedProperties() || changed) RefreshViews();
        if (GUILayout.Button("定位控制器")) { Selection.activeGameObject = controller.gameObject; EditorGUIUtility.PingObject(controller); }
        EditorGUILayout.EndScrollView();
    }
    static void RefreshViews()
    {
        EditorApplication.QueuePlayerLoopUpdate(); SceneView.RepaintAll();
        foreach (var window in Resources.FindObjectsOfTypeAll<EditorWindow>()) if (window.GetType().Name == "GameView") window.Repaint();
    }
}
#endif
